<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.testContrlID" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="testContrlID asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="AllData.cfc.*" />
<cf_pageWrapper>

<h2>Testcontrl</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset testcontrlArray = application.testcontrlService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.testcontrlService.count() />
		<cf_testcontrlBreadcrumb method="list"/>
		<cf_testcontrlSearch q="#url.q#" />
		<cf_testcontrlList orderby="#url.orderby#" testcontrlArray = "#testcontrlArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset testcontrlArray = application.testcontrlService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.testcontrlService.searchCount(url.q) />
		<cf_testcontrlBreadcrumb method="list"/>
		<cf_testcontrlSearch q="#url.q#" />
		<cf_testcontrlList method="searchresult" q="#url.q#" orderby="#url.orderby#" testcontrlArray = "#testcontrlArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset testcontrl = application.testcontrlService.get(url.testContrlID) />
		<cf_testcontrlBreadcrumb method="read" testcontrl = "#testcontrl#"/>
		<cf_testcontrlSearch q="#url.q#" />
		<cf_testcontrlRead testcontrl = "#testcontrl#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.testContrlID eq 0>
			<cfset testcontrl = New testcontrl() />
			<cfset new = true />
		<cfelse>
			<cfset testcontrl = application.testcontrlService.get(url.testContrlID) />
			<cfset new = false />
		</cfif>
		<cf_testcontrlBreadcrumb method="edit" testcontrl = "#testcontrl#"  new="#new#" /> 

		<cf_testcontrlEdit testcontrl = "#testcontrl#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.testcontrlService.get(url.testContrlID) />
		<cfset testcontrl = entityNew("testcontrl") />
		<cfset testcontrl.settestNumber(ref.gettestNumber())  />
		<cfset testcontrl.settitle(ref.gettitle())  />
		<cfset testcontrl.setcopyFrom(ref.getcopyFrom())  />
		<cfset testcontrl.setcopyTo(ref.getcopyTo())  />
		<cfset testcontrl.setonHand(ref.getonHand())  />
		<cfset testcontrl.setinStorage(ref.getinStorage())  />
		<cfset testcontrl.setnotes(ref.getnotes())  />

		<cf_testcontrlBreadcrumb method="new" testcontrl = "#testcontrl#"  new="true" /> 

		<cf_testcontrlEdit testcontrl = "#testcontrl#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset testcontrl = EntityNew("testcontrl") />
		<cfset testcontrl = testcontrl.populate(form) />
		<cfset application.testcontrlService.update(testcontrl) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&testContrlID=#testcontrl.gettestContrlID()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset testcontrl = application.testcontrlService.get(url.testContrlID) />
		<cfset application.testcontrlService.destroy(testcontrl) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>