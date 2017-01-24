<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.requestid" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="requestid asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="AllData.cfc.*" />
<cf_pageWrapper>

<h2>Site group request</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset site_group_requestArray = application.site_group_requestService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.site_group_requestService.count() />
		<cf_site_group_requestBreadcrumb method="list"/>
		<cf_site_group_requestSearch q="#url.q#" />
		<cf_site_group_requestList orderby="#url.orderby#" site_group_requestArray = "#site_group_requestArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset site_group_requestArray = application.site_group_requestService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.site_group_requestService.searchCount(url.q) />
		<cf_site_group_requestBreadcrumb method="list"/>
		<cf_site_group_requestSearch q="#url.q#" />
		<cf_site_group_requestList method="searchresult" q="#url.q#" orderby="#url.orderby#" site_group_requestArray = "#site_group_requestArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset site_group_request = application.site_group_requestService.get(url.requestid) />
		<cf_site_group_requestBreadcrumb method="read" site_group_request = "#site_group_request#"/>
		<cf_site_group_requestSearch q="#url.q#" />
		<cf_site_group_requestRead site_group_request = "#site_group_request#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.requestid eq 0>
			<cfset site_group_request = New site_group_request() />
			<cfset new = true />
		<cfelse>
			<cfset site_group_request = application.site_group_requestService.get(url.requestid) />
			<cfset new = false />
		</cfif>
		<cf_site_group_requestBreadcrumb method="edit" site_group_request = "#site_group_request#"  new="#new#" /> 

		<cf_site_group_requestEdit site_group_request = "#site_group_request#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.site_group_requestService.get(url.requestid) />
		<cfset site_group_request = entityNew("site_group_request") />
		<cfset site_group_request.setrequestid(ref.getrequestid())  />
		<cfset site_group_request.setlogin(ref.getlogin())  />
		<cfset site_group_request.setsite_group(ref.getsite_group())  />
		<cfset site_group_request.setdate_request(ref.getdate_request())  />
		<cfset site_group_request.setprocessed(ref.getprocessed())  />

		<cf_site_group_requestBreadcrumb method="new" site_group_request = "#site_group_request#"  new="true" /> 

		<cf_site_group_requestEdit site_group_request = "#site_group_request#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset site_group_request = EntityNew("site_group_request") />
		<cfset site_group_request = site_group_request.populate(form) />
		<cfset application.site_group_requestService.update(site_group_request) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&requestid=#site_group_request.getrequestid()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset site_group_request = application.site_group_requestService.get(url.requestid) />
		<cfset application.site_group_requestService.destroy(site_group_request) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>