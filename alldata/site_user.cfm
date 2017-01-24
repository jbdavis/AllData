<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.user_ID" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="user_ID asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="AllData.cfc.*" />
<cf_pageWrapper>

<h2>Site user</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset site_userArray = application.site_userService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.site_userService.count() />
		<cf_site_userBreadcrumb method="list"/>
		<cf_site_userSearch q="#url.q#" />
		<cf_site_userList orderby="#url.orderby#" site_userArray = "#site_userArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset site_userArray = application.site_userService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.site_userService.searchCount(url.q) />
		<cf_site_userBreadcrumb method="list"/>
		<cf_site_userSearch q="#url.q#" />
		<cf_site_userList method="searchresult" q="#url.q#" orderby="#url.orderby#" site_userArray = "#site_userArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset site_user = application.site_userService.get(url.user_ID) />
		<cf_site_userBreadcrumb method="read" site_user = "#site_user#"/>
		<cf_site_userSearch q="#url.q#" />
		<cf_site_userRead site_user = "#site_user#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.user_ID eq 0>
			<cfset site_user = New site_user() />
			<cfset new = true />
		<cfelse>
			<cfset site_user = application.site_userService.get(url.user_ID) />
			<cfset new = false />
		</cfif>
		<cf_site_userBreadcrumb method="edit" site_user = "#site_user#"  new="#new#" /> 

		<cf_site_userEdit site_user = "#site_user#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.site_userService.get(url.user_ID) />
		<cfset site_user = entityNew("site_user") />
		<cfset site_user.setlogin(ref.getlogin())  />
		<cfset site_user.setl_name(ref.getl_name())  />
		<cfset site_user.setf_name(ref.getf_name())  />
		<cfset site_user.setm_name(ref.getm_name())  />
		<cfset site_user.setalert(ref.getalert())  />
		<cfset site_user.setrank(ref.getrank())  />
		<cfset site_user.setclassification(ref.getclassification())  />
		<cfset site_user.setpara(ref.getpara())  />
		<cfset site_user.setlin(ref.getlin())  />
		<cfset site_user.setgroup_title(ref.getgroup_title())  />
		<cfset site_user.setwork_title(ref.getwork_title())  />
		<cfset site_user.setemail(ref.getemail())  />
		<cfset site_user.setbuilding(ref.getbuilding())  />
		<cfset site_user.setroom(ref.getroom())  />
		<cfset site_user.setduty_phone(ref.getduty_phone())  />
		<cfset site_user.setmil_cell_phone(ref.getmil_cell_phone())  />
		<cfset site_user.setspouse(ref.getspouse())  />
		<cfset site_user.setst_addr(ref.getst_addr())  />
		<cfset site_user.setaddr_city(ref.getaddr_city())  />
		<cfset site_user.setst(ref.getst())  />
		<cfset site_user.setzip(ref.getzip())  />
		<cfset site_user.sethome_phone(ref.gethome_phone())  />
		<cfset site_user.setcell_phone(ref.getcell_phone())  />
		<cfset site_user.setdate_last_edit(ref.getdate_last_edit())  />
		<cfset site_user.setlast_editor_username(ref.getlast_editor_username())  />
		<cfset site_user.setmyinfo_active(ref.getmyinfo_active())  />
		<cfset site_user.seteaats_active(ref.geteaats_active())  />

		<cf_site_userBreadcrumb method="new" site_user = "#site_user#"  new="true" /> 

		<cf_site_userEdit site_user = "#site_user#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset site_user = EntityNew("site_user") />
		<cfset site_user = site_user.populate(form) />
		<cfset application.site_userService.update(site_user) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&user_ID=#site_user.getuser_ID()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset site_user = application.site_userService.get(url.user_ID) />
		<cfset application.site_userService.destroy(site_user) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>