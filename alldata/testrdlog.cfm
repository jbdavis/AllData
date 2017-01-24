<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.logID" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="logID asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="AllData.cfc.*" />
<cf_pageWrapper>

<h2>Testrdlog</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset testrdlogArray = application.testrdlogService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.testrdlogService.count() />
		<cf_testrdlogBreadcrumb method="list"/>
		<cf_testrdlogSearch q="#url.q#" />
		<cf_testrdlogList orderby="#url.orderby#" testrdlogArray = "#testrdlogArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset testrdlogArray = application.testrdlogService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.testrdlogService.searchCount(url.q) />
		<cf_testrdlogBreadcrumb method="list"/>
		<cf_testrdlogSearch q="#url.q#" />
		<cf_testrdlogList method="searchresult" q="#url.q#" orderby="#url.orderby#" testrdlogArray = "#testrdlogArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset testrdlog = application.testrdlogService.get(url.logID) />
		<cf_testrdlogBreadcrumb method="read" testrdlog = "#testrdlog#"/>
		<cf_testrdlogSearch q="#url.q#" />
		<cf_testrdlogRead testrdlog = "#testrdlog#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.logID eq 0>
			<cfset testrdlog = New testrdlog() />
			<cfset new = true />
		<cfelse>
			<cfset testrdlog = application.testrdlogService.get(url.logID) />
			<cfset new = false />
		</cfif>
		<cf_testrdlogBreadcrumb method="edit" testrdlog = "#testrdlog#"  new="#new#" /> 

		<cf_testrdlogEdit testrdlog = "#testrdlog#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.testrdlogService.get(url.logID) />
		<cfset testrdlog = entityNew("testrdlog") />
		<cfset testrdlog.setlogDate(ref.getlogDate())  />
		<cfset testrdlog.setreproDestroy(ref.getreproDestroy())  />
		<cfset testrdlog.seteSerialNumber(ref.geteSerialNumber())  />
		<cfset testrdlog.settype(ref.gettype())  />
		<cfset testrdlog.setcopy(ref.getcopy())  />
		<cfset testrdlog.setmethodDestruction(ref.getmethodDestruction())  />
		<cfset testrdlog.setTCOVerification(ref.getTCOVerification())  />

		<cf_testrdlogBreadcrumb method="new" testrdlog = "#testrdlog#"  new="true" /> 

		<cf_testrdlogEdit testrdlog = "#testrdlog#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset testrdlog = EntityNew("testrdlog") />
		<cfset testrdlog = testrdlog.populate(form) />
		<cfset application.testrdlogService.update(testrdlog) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&logID=#testrdlog.getlogID()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset testrdlog = application.testrdlogService.get(url.logID) />
		<cfset application.testrdlogService.destroy(testrdlog) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>