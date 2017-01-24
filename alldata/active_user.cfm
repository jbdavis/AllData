<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.userOn_ID" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="userOn_ID asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="AllData.cfc.*" />
<cf_pageWrapper>

<h2>Active user</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset active_userArray = application.active_userService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.active_userService.count() />
		<cf_active_userBreadcrumb method="list"/>
		<cf_active_userSearch q="#url.q#" />
		<cf_active_userList orderby="#url.orderby#" active_userArray = "#active_userArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset active_userArray = application.active_userService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.active_userService.searchCount(url.q) />
		<cf_active_userBreadcrumb method="list"/>
		<cf_active_userSearch q="#url.q#" />
		<cf_active_userList method="searchresult" q="#url.q#" orderby="#url.orderby#" active_userArray = "#active_userArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset active_user = application.active_userService.get(url.userOn_ID) />
		<cf_active_userBreadcrumb method="read" active_user = "#active_user#"/>
		<cf_active_userSearch q="#url.q#" />
		<cf_active_userRead active_user = "#active_user#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.userOn_ID eq 0>
			<cfset active_user = New active_user() />
			<cfset new = true />
		<cfelse>
			<cfset active_user = application.active_userService.get(url.userOn_ID) />
			<cfset new = false />
		</cfif>
		<cf_active_userBreadcrumb method="edit" active_user = "#active_user#"  new="#new#" /> 

		<cf_active_userEdit active_user = "#active_user#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.active_userService.get(url.userOn_ID) />
		<cfset active_user = entityNew("active_user") />
		<cfset active_user.setuserOn_ID(ref.getuserOn_ID())  />
		<cfset active_user.setlogin(ref.getlogin())  />
		<cfset active_user.settimelogged(ref.gettimelogged())  />
		<cfset active_user.setsite_page(ref.getsite_page())  />

		<cf_active_userBreadcrumb method="new" active_user = "#active_user#"  new="true" /> 

		<cf_active_userEdit active_user = "#active_user#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset active_user = EntityNew("active_user") />
		<cfset active_user = active_user.populate(form) />
		<cfset application.active_userService.update(active_user) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&userOn_ID=#active_user.getuserOn_ID()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset active_user = application.active_userService.get(url.userOn_ID) />
		<cfset application.active_userService.destroy(active_user) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>