<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.course_lib_id" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="course_lib_id asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="AllData.cfc.*" />
<cf_pageWrapper>

<h2>Isd course lib</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset isd_course_libArray = application.isd_course_libService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.isd_course_libService.count() />
		<cf_isd_course_libBreadcrumb method="list"/>
		<cf_isd_course_libSearch q="#url.q#" />
		<cf_isd_course_libList orderby="#url.orderby#" isd_course_libArray = "#isd_course_libArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset isd_course_libArray = application.isd_course_libService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.isd_course_libService.searchCount(url.q) />
		<cf_isd_course_libBreadcrumb method="list"/>
		<cf_isd_course_libSearch q="#url.q#" />
		<cf_isd_course_libList method="searchresult" q="#url.q#" orderby="#url.orderby#" isd_course_libArray = "#isd_course_libArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset isd_course_lib = application.isd_course_libService.get(url.course_lib_id) />
		<cf_isd_course_libBreadcrumb method="read" isd_course_lib = "#isd_course_lib#"/>
		<cf_isd_course_libSearch q="#url.q#" />
		<cf_isd_course_libRead isd_course_lib = "#isd_course_lib#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.course_lib_id eq 0>
			<cfset isd_course_lib = New isd_course_lib() />
			<cfset new = true />
		<cfelse>
			<cfset isd_course_lib = application.isd_course_libService.get(url.course_lib_id) />
			<cfset new = false />
		</cfif>
		<cf_isd_course_libBreadcrumb method="edit" isd_course_lib = "#isd_course_lib#"  new="#new#" /> 

		<cf_isd_course_libEdit isd_course_lib = "#isd_course_lib#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.isd_course_libService.get(url.course_lib_id) />
		<cfset isd_course_lib = entityNew("isd_course_lib") />
		<cfset isd_course_lib.settats(ref.gettats())  />
		<cfset isd_course_lib.setcourse_name(ref.getcourse_name())  />
		<cfset isd_course_lib.setcourse_type(ref.getcourse_type())  />

		<cf_isd_course_libBreadcrumb method="new" isd_course_lib = "#isd_course_lib#"  new="true" /> 

		<cf_isd_course_libEdit isd_course_lib = "#isd_course_lib#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset isd_course_lib = EntityNew("isd_course_lib") />
		<cfset isd_course_lib = isd_course_lib.populate(form) />
		<cfset application.isd_course_libService.update(isd_course_lib) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&course_lib_id=#isd_course_lib.getcourse_lib_id()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset isd_course_lib = application.isd_course_libService.get(url.course_lib_id) />
		<cfset application.isd_course_libService.destroy(isd_course_lib) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>