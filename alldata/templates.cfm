<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.parentmodel" type="any" default="0" />
<cfparam name="url.type" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="type asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="AllData.cfc.*" />
<cf_pageWrapper>

<h2>Templates</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset templatesArray = application.templatesService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.templatesService.count() />
		<cf_templatesBreadcrumb method="list"/>
		<cf_templatesSearch q="#url.q#" />
		<cf_templatesList orderby="#url.orderby#" templatesArray = "#templatesArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset templatesArray = application.templatesService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.templatesService.searchCount(url.q) />
		<cf_templatesBreadcrumb method="list"/>
		<cf_templatesSearch q="#url.q#" />
		<cf_templatesList method="searchresult" q="#url.q#" orderby="#url.orderby#" templatesArray = "#templatesArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset keys = {} />
		<cfset keys["parentmodel"] = url["parentmodel"] />
		<cfset keys["type"] = url["type"] />
		<cfset templates = application.templatesService.get(keys) />
		<cf_templatesBreadcrumb method="read" templates = "#templates#"/>
		<cf_templatesSearch q="#url.q#" />
		<cf_templatesRead templates = "#templates#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.type eq 0>
			<cfset templates = New templates() />
			<cfset new = true />
		<cfelse>
			<cfset keys = {} />
			<cfset keys["parentmodel"] = url["parentmodel"] />
			<cfset keys["type"] = url["type"] />
			<cfset templates = application.templatesService.get(keys) />
			<cfset new = false />
		</cfif>
		<cf_templatesBreadcrumb method="edit" templates = "#templates#"  new="#new#" /> 

		<cf_templatesEdit templates = "#templates#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
			<cfset keys = {} />
			<cfset keys["parentmodel"] = url["parentmodel"] />
			<cfset keys["type"] = url["type"] />
		<cfset ref = application.templatesService.get(keys) />
		<cfset templates = entityNew("templates") />
		<cfset templates.settemplate(ref.gettemplate())  />

		<cf_templatesBreadcrumb method="new" templates = "#templates#"  new="true" /> 

		<cf_templatesEdit templates = "#templates#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset templates = EntityNew("templates") />
		<cfset templates = templates.populate(form) />
		<cfset application.templatesService.update(templates) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&type=#templates.gettype()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset keys = {} />
			<cfset keys["parentmodel"] = url["parentmodel"] />
			<cfset keys["type"] = url["type"] />
			<cfset templates = application.templatesService.get(keys) />
		<cfset application.templatesService.destroy(templates) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>