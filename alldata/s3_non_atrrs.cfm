<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.eventID" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="eventID asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="AllData.cfc.*" />
<cf_pageWrapper>

<h2>S3 non atrrs</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset s3_non_atrrsArray = application.s3_non_atrrsService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.s3_non_atrrsService.count() />
		<cf_s3_non_atrrsBreadcrumb method="list"/>
		<cf_s3_non_atrrsSearch q="#url.q#" />
		<cf_s3_non_atrrsList orderby="#url.orderby#" s3_non_atrrsArray = "#s3_non_atrrsArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset s3_non_atrrsArray = application.s3_non_atrrsService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.s3_non_atrrsService.searchCount(url.q) />
		<cf_s3_non_atrrsBreadcrumb method="list"/>
		<cf_s3_non_atrrsSearch q="#url.q#" />
		<cf_s3_non_atrrsList method="searchresult" q="#url.q#" orderby="#url.orderby#" s3_non_atrrsArray = "#s3_non_atrrsArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset s3_non_atrrs = application.s3_non_atrrsService.get(url.eventID) />
		<cf_s3_non_atrrsBreadcrumb method="read" s3_non_atrrs = "#s3_non_atrrs#"/>
		<cf_s3_non_atrrsSearch q="#url.q#" />
		<cf_s3_non_atrrsRead s3_non_atrrs = "#s3_non_atrrs#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.eventID eq 0>
			<cfset s3_non_atrrs = New s3_non_atrrs() />
			<cfset new = true />
		<cfelse>
			<cfset s3_non_atrrs = application.s3_non_atrrsService.get(url.eventID) />
			<cfset new = false />
		</cfif>
		<cf_s3_non_atrrsBreadcrumb method="edit" s3_non_atrrs = "#s3_non_atrrs#"  new="#new#" /> 

		<cf_s3_non_atrrsEdit s3_non_atrrs = "#s3_non_atrrs#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.s3_non_atrrsService.get(url.eventID) />
		<cfset s3_non_atrrs = entityNew("s3_non_atrrs") />
		<cfset s3_non_atrrs.setstartDate(ref.getstartDate())  />
		<cfset s3_non_atrrs.setendDate(ref.getendDate())  />
		<cfset s3_non_atrrs.setevent(ref.getevent())  />
		<cfset s3_non_atrrs.setdescript(ref.getdescript())  />
		<cfset s3_non_atrrs.settrained(ref.gettrained())  />
		<cfset s3_non_atrrs.setuSupport(ref.getuSupport())  />
		<cfset s3_non_atrrs.setfltTime(ref.getfltTime())  />
		<cfset s3_non_atrrs.setsimTime(ref.getsimTime())  />
		<cfset s3_non_atrrs.setactionOfficer(ref.getactionOfficer())  />
		<cfset s3_non_atrrs.setngbApproved(ref.getngbApproved())  />
		<cfset s3_non_atrrs.setcmdApproved(ref.getcmdApproved())  />
		<cfset s3_non_atrrs.settotTime(ref.gettotTime())  />
		<cfset s3_non_atrrs.setmanTime(ref.getmanTime())  />

		<cf_s3_non_atrrsBreadcrumb method="new" s3_non_atrrs = "#s3_non_atrrs#"  new="true" /> 

		<cf_s3_non_atrrsEdit s3_non_atrrs = "#s3_non_atrrs#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset s3_non_atrrs = EntityNew("s3_non_atrrs") />
		<cfset s3_non_atrrs = s3_non_atrrs.populate(form) />
		<cfset application.s3_non_atrrsService.update(s3_non_atrrs) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&eventID=#s3_non_atrrs.geteventID()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset s3_non_atrrs = application.s3_non_atrrsService.get(url.eventID) />
		<cfset application.s3_non_atrrsService.destroy(s3_non_atrrs) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>