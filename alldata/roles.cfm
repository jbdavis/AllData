<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.roleID" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="roleID asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="AllData.cfc.*" />
<cf_pageWrapper>

<h2>Roles</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset rolesArray = application.rolesService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.rolesService.count() />
		<cf_rolesBreadcrumb method="list"/>
		<cf_rolesSearch q="#url.q#" />
		<cf_rolesList orderby="#url.orderby#" rolesArray = "#rolesArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset rolesArray = application.rolesService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.rolesService.searchCount(url.q) />
		<cf_rolesBreadcrumb method="list"/>
		<cf_rolesSearch q="#url.q#" />
		<cf_rolesList method="searchresult" q="#url.q#" orderby="#url.orderby#" rolesArray = "#rolesArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset roles = application.rolesService.get(url.roleID) />
		<cf_rolesBreadcrumb method="read" roles = "#roles#"/>
		<cf_rolesSearch q="#url.q#" />
		<cf_rolesRead roles = "#roles#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.roleID eq 0>
			<cfset roles = New roles() />
			<cfset new = true />
		<cfelse>
			<cfset roles = application.rolesService.get(url.roleID) />
			<cfset new = false />
		</cfif>
		<cf_rolesBreadcrumb method="edit" roles = "#roles#"  new="#new#" /> 

		<cf_rolesEdit roles = "#roles#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.rolesService.get(url.roleID) />
		<cfset roles = entityNew("roles") />
		<cfset roles.setrole(ref.getrole())  />

		<cf_rolesBreadcrumb method="new" roles = "#roles#"  new="true" /> 

		<cf_rolesEdit roles = "#roles#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset roles = EntityNew("roles") />
		<cfset roles = roles.populate(form) />
		<cfset application.rolesService.update(roles) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&roleID=#roles.getroleID()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset roles = application.rolesService.get(url.roleID) />
		<cfset application.rolesService.destroy(roles) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>