<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.id" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="id asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="AllData.cfc.*" />
<cf_pageWrapper>

<h2>S3 bluebook users</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset s3_bluebook_usersArray = application.s3_bluebook_usersService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.s3_bluebook_usersService.count() />
		<cf_s3_bluebook_usersBreadcrumb method="list"/>
		<cf_s3_bluebook_usersSearch q="#url.q#" />
		<cf_s3_bluebook_usersList orderby="#url.orderby#" s3_bluebook_usersArray = "#s3_bluebook_usersArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset s3_bluebook_usersArray = application.s3_bluebook_usersService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.s3_bluebook_usersService.searchCount(url.q) />
		<cf_s3_bluebook_usersBreadcrumb method="list"/>
		<cf_s3_bluebook_usersSearch q="#url.q#" />
		<cf_s3_bluebook_usersList method="searchresult" q="#url.q#" orderby="#url.orderby#" s3_bluebook_usersArray = "#s3_bluebook_usersArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset s3_bluebook_users = application.s3_bluebook_usersService.get(url.id) />
		<cf_s3_bluebook_usersBreadcrumb method="read" s3_bluebook_users = "#s3_bluebook_users#"/>
		<cf_s3_bluebook_usersSearch q="#url.q#" />
		<cf_s3_bluebook_usersRead s3_bluebook_users = "#s3_bluebook_users#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.id eq 0>
			<cfset s3_bluebook_users = New s3_bluebook_users() />
			<cfset new = true />
		<cfelse>
			<cfset s3_bluebook_users = application.s3_bluebook_usersService.get(url.id) />
			<cfset new = false />
		</cfif>
		<cf_s3_bluebook_usersBreadcrumb method="edit" s3_bluebook_users = "#s3_bluebook_users#"  new="#new#" /> 

		<cf_s3_bluebook_usersEdit s3_bluebook_users = "#s3_bluebook_users#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.s3_bluebook_usersService.get(url.id) />
		<cfset s3_bluebook_users = entityNew("s3_bluebook_users") />
		<cfset s3_bluebook_users.setid(ref.getid())  />
		<cfset s3_bluebook_users.setusers(ref.getusers())  />
		<cfset s3_bluebook_users.setreq_date(ref.getreq_date())  />
		<cfset s3_bluebook_users.setremarks(ref.getremarks())  />
		<cfset s3_bluebook_users.setapproved(ref.getapproved())  />
		<cfset s3_bluebook_users.setlast_edit(ref.getlast_edit())  />
		<cfset s3_bluebook_users.setedit_by(ref.getedit_by())  />

		<cf_s3_bluebook_usersBreadcrumb method="new" s3_bluebook_users = "#s3_bluebook_users#"  new="true" /> 

		<cf_s3_bluebook_usersEdit s3_bluebook_users = "#s3_bluebook_users#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset s3_bluebook_users = EntityNew("s3_bluebook_users") />
		<cfset s3_bluebook_users = s3_bluebook_users.populate(form) />
		<cfset application.s3_bluebook_usersService.update(s3_bluebook_users) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&id=#s3_bluebook_users.getid()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset s3_bluebook_users = application.s3_bluebook_usersService.get(url.id) />
		<cfset application.s3_bluebook_usersService.destroy(s3_bluebook_users) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>