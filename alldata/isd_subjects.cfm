<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.subjectid" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="subjectid asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="AllData.cfc.*" />
<cf_pageWrapper>

<h2>Isd subjects</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset isd_subjectsArray = application.isd_subjectsService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.isd_subjectsService.count() />
		<cf_isd_subjectsBreadcrumb method="list"/>
		<cf_isd_subjectsSearch q="#url.q#" />
		<cf_isd_subjectsList orderby="#url.orderby#" isd_subjectsArray = "#isd_subjectsArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset isd_subjectsArray = application.isd_subjectsService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.isd_subjectsService.searchCount(url.q) />
		<cf_isd_subjectsBreadcrumb method="list"/>
		<cf_isd_subjectsSearch q="#url.q#" />
		<cf_isd_subjectsList method="searchresult" q="#url.q#" orderby="#url.orderby#" isd_subjectsArray = "#isd_subjectsArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset isd_subjects = application.isd_subjectsService.get(url.subjectid) />
		<cf_isd_subjectsBreadcrumb method="read" isd_subjects = "#isd_subjects#"/>
		<cf_isd_subjectsSearch q="#url.q#" />
		<cf_isd_subjectsRead isd_subjects = "#isd_subjects#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.subjectid eq 0>
			<cfset isd_subjects = New isd_subjects() />
			<cfset new = true />
		<cfelse>
			<cfset isd_subjects = application.isd_subjectsService.get(url.subjectid) />
			<cfset new = false />
		</cfif>
		<cf_isd_subjectsBreadcrumb method="edit" isd_subjects = "#isd_subjects#"  new="#new#" /> 

		<cf_isd_subjectsEdit isd_subjects = "#isd_subjects#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.isd_subjectsService.get(url.subjectid) />
		<cfset isd_subjects = entityNew("isd_subjects") />
		<cfset isd_subjects.setcourse(ref.getcourse())  />
		<cfset isd_subjects.setpfn(ref.getpfn())  />
		<cfset isd_subjects.settitle(ref.gettitle())  />
		<cfset isd_subjects.setsubject_date(ref.getsubject_date())  />
		<cfset isd_subjects.setpersonid(ref.getpersonid())  />

		<cf_isd_subjectsBreadcrumb method="new" isd_subjects = "#isd_subjects#"  new="true" /> 

		<cf_isd_subjectsEdit isd_subjects = "#isd_subjects#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset isd_subjects = EntityNew("isd_subjects") />
		<cfset isd_subjects = isd_subjects.populate(form) />
		<cfset application.isd_subjectsService.update(isd_subjects) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&subjectid=#isd_subjects.getsubjectid()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset isd_subjects = application.isd_subjectsService.get(url.subjectid) />
		<cfset application.isd_subjectsService.destroy(isd_subjects) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>