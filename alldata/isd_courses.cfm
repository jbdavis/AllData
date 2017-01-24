<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.courseid" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="courseid asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="AllData.cfc.*" />
<cf_pageWrapper>

<h2>Isd courses</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset isd_coursesArray = application.isd_coursesService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.isd_coursesService.count() />
		<cf_isd_coursesBreadcrumb method="list"/>
		<cf_isd_coursesSearch q="#url.q#" />
		<cf_isd_coursesList orderby="#url.orderby#" isd_coursesArray = "#isd_coursesArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset isd_coursesArray = application.isd_coursesService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.isd_coursesService.searchCount(url.q) />
		<cf_isd_coursesBreadcrumb method="list"/>
		<cf_isd_coursesSearch q="#url.q#" />
		<cf_isd_coursesList method="searchresult" q="#url.q#" orderby="#url.orderby#" isd_coursesArray = "#isd_coursesArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset isd_courses = application.isd_coursesService.get(url.courseid) />
		<cf_isd_coursesBreadcrumb method="read" isd_courses = "#isd_courses#"/>
		<cf_isd_coursesSearch q="#url.q#" />
		<cf_isd_coursesRead isd_courses = "#isd_courses#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.courseid eq 0>
			<cfset isd_courses = New isd_courses() />
			<cfset new = true />
		<cfelse>
			<cfset isd_courses = application.isd_coursesService.get(url.courseid) />
			<cfset new = false />
		</cfif>
		<cf_isd_coursesBreadcrumb method="edit" isd_courses = "#isd_courses#"  new="#new#" /> 

		<cf_isd_coursesEdit isd_courses = "#isd_courses#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.isd_coursesService.get(url.courseid) />
		<cfset isd_courses = entityNew("isd_courses") />
		<cfset isd_courses.settats(ref.gettats())  />
		<cfset isd_courses.settype(ref.gettype())  />
		<cfset isd_courses.setcourse(ref.getcourse())  />
		<cfset isd_courses.setactive(ref.getactive())  />
		<cfset isd_courses.setint_cert(ref.getint_cert())  />
		<cfset isd_courses.setlcert_eval(ref.getlcert_eval())  />
		<cfset isd_courses.setrpt_eval(ref.getrpt_eval())  />
		<cfset isd_courses.setpersonid(ref.getpersonid())  />

		<cf_isd_coursesBreadcrumb method="new" isd_courses = "#isd_courses#"  new="true" /> 

		<cf_isd_coursesEdit isd_courses = "#isd_courses#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset isd_courses = EntityNew("isd_courses") />
		<cfset isd_courses = isd_courses.populate(form) />
		<cfset application.isd_coursesService.update(isd_courses) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&courseid=#isd_courses.getcourseid()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset isd_courses = application.isd_coursesService.get(url.courseid) />
		<cfset application.isd_coursesService.destroy(isd_courses) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>