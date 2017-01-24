<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.personid" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="personid asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="AllData.cfc.*" />
<cf_pageWrapper>

<h2>Isd person</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset isd_personArray = application.isd_personService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.isd_personService.count() />
		<cf_isd_personBreadcrumb method="list"/>
		<cf_isd_personSearch q="#url.q#" />
		<cf_isd_personList orderby="#url.orderby#" isd_personArray = "#isd_personArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset isd_personArray = application.isd_personService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.isd_personService.searchCount(url.q) />
		<cf_isd_personBreadcrumb method="list"/>
		<cf_isd_personSearch q="#url.q#" />
		<cf_isd_personList method="searchresult" q="#url.q#" orderby="#url.orderby#" isd_personArray = "#isd_personArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset isd_person = application.isd_personService.get(url.personid) />
		<cf_isd_personBreadcrumb method="read" isd_person = "#isd_person#"/>
		<cf_isd_personSearch q="#url.q#" />
		<cf_isd_personRead isd_person = "#isd_person#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.personid eq 0>
			<cfset isd_person = New isd_person() />
			<cfset new = true />
		<cfelse>
			<cfset isd_person = application.isd_personService.get(url.personid) />
			<cfset new = false />
		</cfif>
		<cf_isd_personBreadcrumb method="edit" isd_person = "#isd_person#"  new="#new#" /> 

		<cf_isd_personEdit isd_person = "#isd_person#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.isd_personService.get(url.personid) />
		<cfset isd_person = entityNew("isd_person") />
		<cfset isd_person.setlast_name(ref.getlast_name())  />
		<cfset isd_person.setfirst_name(ref.getfirst_name())  />
		<cfset isd_person.setrank(ref.getrank())  />
		<cfset isd_person.setpara_lin(ref.getpara_lin())  />
		<cfset isd_person.setlast_eval(ref.getlast_eval())  />
		<cfset isd_person.seteval_nlt(ref.geteval_nlt())  />
		<cfset isd_person.setsusp(ref.getsusp())  />
		<cfset isd_person.setsusp_reason(ref.getsusp_reason())  />
		<cfset isd_person.setbirth_month(ref.getbirth_month())  />
		<cfset isd_person.setcomments(ref.getcomments())  />
		<cfset isd_person.setapft(ref.getapft())  />
		<cfset isd_person.sethw_tape(ref.gethw_tape())  />
		<cfset isd_person.setpro_type(ref.getpro_type())  />
		<cfset isd_person.setpro_date(ref.getpro_date())  />
		<cfset isd_person.setcm_tng(ref.getcm_tng())  />
		<cfset isd_person.setcoe_tng(ref.getcoe_tng())  />
		<cfset isd_person.setet_tng(ref.getet_tng())  />
		<cfset isd_person.setir_tng(ref.getir_tng())  />
		<cfset isd_person.setta_tng(ref.getta_tng())  />
		<cfset isd_person.settco_tng(ref.gettco_tng())  />
		<cfset isd_person.setopsec_tng(ref.getopsec_tng())  />
		<cfset isd_person.setiaa_tng(ref.getiaa_tng())  />
		<cfset isd_person.setdlx(ref.getdlx())  />
		<cfset isd_person.setbb_qual(ref.getbb_qual())  />

		<cf_isd_personBreadcrumb method="new" isd_person = "#isd_person#"  new="true" /> 

		<cf_isd_personEdit isd_person = "#isd_person#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset isd_person = EntityNew("isd_person") />
		<cfset isd_person = isd_person.populate(form) />
		<cfset application.isd_personService.update(isd_person) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&personid=#isd_person.getpersonid()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset isd_person = application.isd_personService.get(url.personid) />
		<cfset application.isd_personService.destroy(isd_person) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>