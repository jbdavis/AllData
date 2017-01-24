<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.pID" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="pID asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="AllData.cfc.*" />
<cf_pageWrapper>

<h2>Ratealpharoster</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset ratealpharosterArray = application.ratealpharosterService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.ratealpharosterService.count() />
		<cf_ratealpharosterBreadcrumb method="list"/>
		<cf_ratealpharosterSearch q="#url.q#" />
		<cf_ratealpharosterList orderby="#url.orderby#" ratealpharosterArray = "#ratealpharosterArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset ratealpharosterArray = application.ratealpharosterService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.ratealpharosterService.searchCount(url.q) />
		<cf_ratealpharosterBreadcrumb method="list"/>
		<cf_ratealpharosterSearch q="#url.q#" />
		<cf_ratealpharosterList method="searchresult" q="#url.q#" orderby="#url.orderby#" ratealpharosterArray = "#ratealpharosterArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset ratealpharoster = application.ratealpharosterService.get(url.pID) />
		<cf_ratealpharosterBreadcrumb method="read" ratealpharoster = "#ratealpharoster#"/>
		<cf_ratealpharosterSearch q="#url.q#" />
		<cf_ratealpharosterRead ratealpharoster = "#ratealpharoster#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.pID eq 0>
			<cfset ratealpharoster = New ratealpharoster() />
			<cfset new = true />
		<cfelse>
			<cfset ratealpharoster = application.ratealpharosterService.get(url.pID) />
			<cfset new = false />
		</cfif>
		<cf_ratealpharosterBreadcrumb method="edit" ratealpharoster = "#ratealpharoster#"  new="#new#" /> 

		<cf_ratealpharosterEdit ratealpharoster = "#ratealpharoster#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.ratealpharosterService.get(url.pID) />
		<cfset ratealpharoster = entityNew("ratealpharoster") />
		<cfset ratealpharoster.setr_type(ref.getr_type())  />
		<cfset ratealpharoster.setactive(ref.getactive())  />
		<cfset ratealpharoster.setlname(ref.getlname())  />
		<cfset ratealpharoster.setfname(ref.getfname())  />
		<cfset ratealpharoster.setmi(ref.getmi())  />
		<cfset ratealpharoster.setduty_title(ref.getduty_title())  />
		<cfset ratealpharoster.setrank(ref.getrank())  />
		<cfset ratealpharoster.setpreperm(ref.getpreperm())  />
		<cfset ratealpharoster.seteff_date(ref.geteff_date())  />
		<cfset ratealpharoster.setthru_date(ref.getthru_date())  />
		<cfset ratealpharoster.sethqs_co(ref.gethqs_co())  />
		<cfset ratealpharoster.setsec_plat(ref.getsec_plat())  />
		<cfset ratealpharoster.setrater(ref.getrater())  />
		<cfset ratealpharoster.setrt_eff_date(ref.getrt_eff_date())  />
		<cfset ratealpharoster.setsr_rater(ref.getsr_rater())  />
		<cfset ratealpharoster.setsr_rt_eff_date(ref.getsr_rt_eff_date())  />
		<cfset ratealpharoster.setreint_rater(ref.getreint_rater())  />
		<cfset ratealpharoster.setreint_rt_eff_date(ref.getreint_rt_eff_date())  />
		<cfset ratealpharoster.sets1_comments(ref.gets1_comments())  />
		<cfset ratealpharoster.setenlisted(ref.getenlisted())  />

		<cf_ratealpharosterBreadcrumb method="new" ratealpharoster = "#ratealpharoster#"  new="true" /> 

		<cf_ratealpharosterEdit ratealpharoster = "#ratealpharoster#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset ratealpharoster = EntityNew("ratealpharoster") />
		<cfset ratealpharoster = ratealpharoster.populate(form) />
		<cfset application.ratealpharosterService.update(ratealpharoster) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&pID=#ratealpharoster.getpID()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset ratealpharoster = application.ratealpharosterService.get(url.pID) />
		<cfset application.ratealpharosterService.destroy(ratealpharoster) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>