<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.sig_id" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="sig_id asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="AllData.cfc.*" />
<cf_pageWrapper>

<h2>Sig1059</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset sig1059Array = application.sig1059Service.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.sig1059Service.count() />
		<cf_sig1059Breadcrumb method="list"/>
		<cf_sig1059Search q="#url.q#" />
		<cf_sig1059List orderby="#url.orderby#" sig1059Array = "#sig1059Array#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset sig1059Array = application.sig1059Service.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.sig1059Service.searchCount(url.q) />
		<cf_sig1059Breadcrumb method="list"/>
		<cf_sig1059Search q="#url.q#" />
		<cf_sig1059List method="searchresult" q="#url.q#" orderby="#url.orderby#" sig1059Array = "#sig1059Array#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset sig1059 = application.sig1059Service.get(url.sig_id) />
		<cf_sig1059Breadcrumb method="read" sig1059 = "#sig1059#"/>
		<cf_sig1059Search q="#url.q#" />
		<cf_sig1059Read sig1059 = "#sig1059#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.sig_id eq 0>
			<cfset sig1059 = New sig1059() />
			<cfset new = true />
		<cfelse>
			<cfset sig1059 = application.sig1059Service.get(url.sig_id) />
			<cfset new = false />
		</cfif>
		<cf_sig1059Breadcrumb method="edit" sig1059 = "#sig1059#"  new="#new#" /> 

		<cf_sig1059Edit sig1059 = "#sig1059#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.sig1059Service.get(url.sig_id) />
		<cfset sig1059 = entityNew("sig1059") />
		<cfset sig1059.setsignature(ref.getsignature())  />
		<cfset sig1059.settype(ref.gettype())  />

		<cf_sig1059Breadcrumb method="new" sig1059 = "#sig1059#"  new="true" /> 

		<cf_sig1059Edit sig1059 = "#sig1059#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset sig1059 = EntityNew("sig1059") />
		<cfset sig1059 = sig1059.populate(form) />
		<cfset application.sig1059Service.update(sig1059) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&sig_id=#sig1059.getsig_id()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset sig1059 = application.sig1059Service.get(url.sig_id) />
		<cfset application.sig1059Service.destroy(sig1059) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>