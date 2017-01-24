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

<h2>Users</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset usersArray = application.usersService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.usersService.count() />
		<cf_usersBreadcrumb method="list"/>
		<cf_usersSearch q="#url.q#" />
		<cf_usersList orderby="#url.orderby#" usersArray = "#usersArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset usersArray = application.usersService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.usersService.searchCount(url.q) />
		<cf_usersBreadcrumb method="list"/>
		<cf_usersSearch q="#url.q#" />
		<cf_usersList method="searchresult" q="#url.q#" orderby="#url.orderby#" usersArray = "#usersArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset users = application.usersService.get(url.id) />
		<cf_usersBreadcrumb method="read" users = "#users#"/>
		<cf_usersSearch q="#url.q#" />
		<cf_usersRead users = "#users#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.id eq 0>
			<cfset users = New users() />
			<cfset new = true />
		<cfelse>
			<cfset users = application.usersService.get(url.id) />
			<cfset new = false />
		</cfif>
		<cf_usersBreadcrumb method="edit" users = "#users#"  new="#new#" /> 

		<cf_usersEdit users = "#users#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.usersService.get(url.id) />
		<cfset users = entityNew("users") />
		<cfset users.setemail(ref.getemail())  />
		<cfset users.setfirstname(ref.getfirstname())  />
		<cfset users.setlastname(ref.getlastname())  />
		<cfset users.setrole(ref.getrole())  />
		<cfset users.setpassword(ref.getpassword())  />
		<cfset users.setsalt(ref.getsalt())  />
		<cfset users.setaddress1(ref.getaddress1())  />
		<cfset users.setaddress2(ref.getaddress2())  />
		<cfset users.setpasswordresettoken(ref.getpasswordresettoken())  />
		<cfset users.setstate(ref.getstate())  />
		<cfset users.setcountry(ref.getcountry())  />
		<cfset users.setpostcode(ref.getpostcode())  />
		<cfset users.settel(ref.gettel())  />
		<cfset users.setpasswordresetat(ref.getpasswordresetat())  />
		<cfset users.setcreatedat(ref.getcreatedat())  />
		<cfset users.setupdatedat(ref.getupdatedat())  />
		<cfset users.setdeletedat(ref.getdeletedat())  />
		<cfset users.setapitoken(ref.getapitoken())  />

		<cf_usersBreadcrumb method="new" users = "#users#"  new="true" /> 

		<cf_usersEdit users = "#users#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset users = EntityNew("users") />
		<cfset users = users.populate(form) />
		<cfset application.usersService.update(users) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&id=#users.getid()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset users = application.usersService.get(url.id) />
		<cfset application.usersService.destroy(users) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>