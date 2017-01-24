<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.Id" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="Id asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="AllData.cfc.*" />
<cf_pageWrapper>

<h2>S3 bluebook</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset s3_bluebookArray = application.s3_bluebookService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.s3_bluebookService.count() />
		<cf_s3_bluebookBreadcrumb method="list"/>
		<cf_s3_bluebookSearch q="#url.q#" />
		<cf_s3_bluebookList orderby="#url.orderby#" s3_bluebookArray = "#s3_bluebookArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset s3_bluebookArray = application.s3_bluebookService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.s3_bluebookService.searchCount(url.q) />
		<cf_s3_bluebookBreadcrumb method="list"/>
		<cf_s3_bluebookSearch q="#url.q#" />
		<cf_s3_bluebookList method="searchresult" q="#url.q#" orderby="#url.orderby#" s3_bluebookArray = "#s3_bluebookArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset s3_bluebook = application.s3_bluebookService.get(url.Id) />
		<cf_s3_bluebookBreadcrumb method="read" s3_bluebook = "#s3_bluebook#"/>
		<cf_s3_bluebookSearch q="#url.q#" />
		<cf_s3_bluebookRead s3_bluebook = "#s3_bluebook#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.Id eq 0>
			<cfset s3_bluebook = New s3_bluebook() />
			<cfset new = true />
		<cfelse>
			<cfset s3_bluebook = application.s3_bluebookService.get(url.Id) />
			<cfset new = false />
		</cfif>
		<cf_s3_bluebookBreadcrumb method="edit" s3_bluebook = "#s3_bluebook#"  new="#new#" /> 

		<cf_s3_bluebookEdit s3_bluebook = "#s3_bluebook#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.s3_bluebookService.get(url.Id) />
		<cfset s3_bluebook = entityNew("s3_bluebook") />
		<cfset s3_bluebook.setId(ref.getId())  />
		<cfset s3_bluebook.setPoc(ref.getPoc())  />
		<cfset s3_bluebook.setUnit(ref.getUnit())  />
		<cfset s3_bluebook.setCat(ref.getCat())  />
		<cfset s3_bluebook.setAirframe(ref.getAirframe())  />
		<cfset s3_bluebook.setFl_date(ref.getFl_date())  />
		<cfset s3_bluebook.setFl_type(ref.getFl_type())  />
		<cfset s3_bluebook.setPeriod(ref.getPeriod())  />
		<cfset s3_bluebook.setHours(ref.getHours())  />
		<cfset s3_bluebook.setTakeoff(ref.getTakeoff())  />
		<cfset s3_bluebook.setEquip(ref.getEquip())  />
		<cfset s3_bluebook.setTail(ref.getTail())  />
		<cfset s3_bluebook.setRemarks(ref.getRemarks())  />
		<cfset s3_bluebook.setApproved(ref.getApproved())  />
		<cfset s3_bluebook.setlast_edit(ref.getlast_edit())  />
		<cfset s3_bluebook.setedit_by(ref.getedit_by())  />

		<cf_s3_bluebookBreadcrumb method="new" s3_bluebook = "#s3_bluebook#"  new="true" /> 

		<cf_s3_bluebookEdit s3_bluebook = "#s3_bluebook#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset s3_bluebook = EntityNew("s3_bluebook") />
		<cfset s3_bluebook = s3_bluebook.populate(form) />
		<cfset application.s3_bluebookService.update(s3_bluebook) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&Id=#s3_bluebook.getId()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset s3_bluebook = application.s3_bluebookService.get(url.Id) />
		<cfset application.s3_bluebookService.destroy(s3_bluebook) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>