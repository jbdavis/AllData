<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.member_ID" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="member_ID asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="AllData.cfc.*" />
<cf_pageWrapper>

<h2>Site group member</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset site_group_memberArray = application.site_group_memberService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.site_group_memberService.count() />
		<cf_site_group_memberBreadcrumb method="list"/>
		<cf_site_group_memberSearch q="#url.q#" />
		<cf_site_group_memberList orderby="#url.orderby#" site_group_memberArray = "#site_group_memberArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset site_group_memberArray = application.site_group_memberService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.site_group_memberService.searchCount(url.q) />
		<cf_site_group_memberBreadcrumb method="list"/>
		<cf_site_group_memberSearch q="#url.q#" />
		<cf_site_group_memberList method="searchresult" q="#url.q#" orderby="#url.orderby#" site_group_memberArray = "#site_group_memberArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset site_group_member = application.site_group_memberService.get(url.member_ID) />
		<cf_site_group_memberBreadcrumb method="read" site_group_member = "#site_group_member#"/>
		<cf_site_group_memberSearch q="#url.q#" />
		<cf_site_group_memberRead site_group_member = "#site_group_member#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.member_ID eq 0>
			<cfset site_group_member = New site_group_member() />
			<cfset new = true />
		<cfelse>
			<cfset site_group_member = application.site_group_memberService.get(url.member_ID) />
			<cfset new = false />
		</cfif>
		<cf_site_group_memberBreadcrumb method="edit" site_group_member = "#site_group_member#"  new="#new#" /> 

		<cf_site_group_memberEdit site_group_member = "#site_group_member#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.site_group_memberService.get(url.member_ID) />
		<cfset site_group_member = entityNew("site_group_member") />
		<cfset site_group_member.setlogin(ref.getlogin())  />
		<cfset site_group_member.setsite_group(ref.getsite_group())  />

		<cf_site_group_memberBreadcrumb method="new" site_group_member = "#site_group_member#"  new="true" /> 

		<cf_site_group_memberEdit site_group_member = "#site_group_member#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset site_group_member = EntityNew("site_group_member") />
		<cfset site_group_member = site_group_member.populate(form) />
		<cfset application.site_group_memberService.update(site_group_member) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&member_ID=#site_group_member.getmember_ID()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset site_group_member = application.site_group_memberService.get(url.member_ID) />
		<cfset application.site_group_memberService.destroy(site_group_member) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>