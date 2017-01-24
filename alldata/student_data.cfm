<cfsetting showdebugoutput="false" />
<cfparam name="url.method" type="string" default="list" />
<cfparam name="url.stu_ID" type="any" default="0" />
<cfparam name="url.orderby" type="string" default="stu_ID asc" />
<cfparam name="url.message" type="string" default="" />
<cfparam name="url.offset" type="numeric" default="0" />
<cfparam name="url.maxresults" type="numeric" default="10" />
<cfparam name="url.q" type="string" default="" />
<cfimport path="AllData.cfc.*" />
<cf_pageWrapper>

<h2>Student data</h2>

<cfswitch expression="#url.method#" >

	<cfcase value="list">
		<cfset student_dataArray = application.student_dataService.listPaged(url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.student_dataService.count() />
		<cf_student_dataBreadcrumb method="list"/>
		<cf_student_dataSearch q="#url.q#" />
		<cf_student_dataList orderby="#url.orderby#" student_dataArray = "#student_dataArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#" totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="searchresult">
		<cfset student_dataArray = application.student_dataService.searchPaged(url.q, url.offset, url.maxresults, url.orderby ) />
		<cfset totalCount = application.student_dataService.searchCount(url.q) />
		<cf_student_dataBreadcrumb method="list"/>
		<cf_student_dataSearch q="#url.q#" />
		<cf_student_dataList method="searchresult" q="#url.q#" orderby="#url.orderby#" student_dataArray = "#student_dataArray#" message="#url.message#" offset="#url.offset#" maxresults="#url.maxresults#"  totalCount="#totalCount#" /> 
	</cfcase>

	<cfcase value="read">
		<cfset student_data = application.student_dataService.get(url.stu_ID) />
		<cf_student_dataBreadcrumb method="read" student_data = "#student_data#"/>
		<cf_student_dataSearch q="#url.q#" />
		<cf_student_dataRead student_data = "#student_data#" /> 
	</cfcase>

	<cfcase value="edit">
		<cfif url.stu_ID eq 0>
			<cfset student_data = New student_data() />
			<cfset new = true />
		<cfelse>
			<cfset student_data = application.student_dataService.get(url.stu_ID) />
			<cfset new = false />
		</cfif>
		<cf_student_dataBreadcrumb method="edit" student_data = "#student_data#"  new="#new#" /> 

		<cf_student_dataEdit student_data = "#student_data#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="clone">
		<cfset ref = application.student_dataService.get(url.stu_ID) />
		<cfset student_data = entityNew("student_data") />
		<cfset student_data.setssn(ref.getssn())  />
		<cfset student_data.setsname(ref.getsname())  />
		<cfset student_data.setpay_grade(ref.getpay_grade())  />
		<cfset student_data.setrank(ref.getrank())  />
		<cfset student_data.setgender(ref.getgender())  />
		<cfset student_data.setpmosen(ref.getpmosen())  />
		<cfset student_data.setbranch(ref.getbranch())  />
		<cfset student_data.setcomponent(ref.getcomponent())  />
		<cfset student_data.setapft_date(ref.getapft_date())  />
		<cfset student_data.settag(ref.gettag())  />
		<cfset student_data.setstreet(ref.getstreet())  />
		<cfset student_data.setcity(ref.getcity())  />
		<cfset student_data.setstate(ref.getstate())  />
		<cfset student_data.setzip(ref.getzip())  />
		<cfset student_data.setemail(ref.getemail())  />
		<cfset student_data.setfiscal_year(ref.getfiscal_year())  />
		<cfset student_data.seteclass(ref.geteclass())  />
		<cfset student_data.setcourse(ref.getcourse())  />
		<cfset student_data.setcourse_title(ref.getcourse_title())  />
		<cfset student_data.setreport_date(ref.getreport_date())  />
		<cfset student_data.setstart_date(ref.getstart_date())  />
		<cfset student_data.setend_date(ref.getend_date())  />
		<cfset student_data.setuser_edit(ref.getuser_edit())  />
		<cfset student_data.setedit_date(ref.getedit_date())  />
		<cfset student_data.setunit_address(ref.getunit_address())  />
		<cfset student_data.setunit_phone(ref.getunit_phone())  />
		<cfset student_data.setem_contact(ref.getem_contact())  />
		<cfset student_data.setem_phone_home(ref.getem_phone_home())  />
		<cfset student_data.setem_phone_work(ref.getem_phone_work())  />
		<cfset student_data.setem_phone_cell(ref.getem_phone_cell())  />
		<cfset student_data.setalt_address(ref.getalt_address())  />
		<cfset student_data.setcourse_oic(ref.getcourse_oic())  />
		<cfset student_data.setrecin_date(ref.getrecin_date())  />
		<cfset student_data.setcomment_TrainSec(ref.getcomment_TrainSec())  />
		<cfset student_data.setblock_9(ref.getblock_9())  />
		<cfset student_data.setblock_11(ref.getblock_11())  />
		<cfset student_data.setblock_12_a(ref.getblock_12_a())  />
		<cfset student_data.setblock_12_b(ref.getblock_12_b())  />
		<cfset student_data.setblock_12_c(ref.getblock_12_c())  />
		<cfset student_data.setblock_12_d(ref.getblock_12_d())  />
		<cfset student_data.setblock_12_e(ref.getblock_12_e())  />
		<cfset student_data.setblock_13(ref.getblock_13())  />
		<cfset student_data.setblock_14_1(ref.getblock_14_1())  />
		<cfset student_data.setblock_14_2(ref.getblock_14_2())  />
		<cfset student_data.setblock_14_3(ref.getblock_14_3())  />
		<cfset student_data.setblock_14_4(ref.getblock_14_4())  />
		<cfset student_data.setblock_14_5(ref.getblock_14_5())  />
		<cfset student_data.setblock_14_6(ref.getblock_14_6())  />
		<cfset student_data.setblock_14_u(ref.getblock_14_u())  />
		<cfset student_data.setprep1059(ref.getprep1059())  />
		<cfset student_data.setreview1059(ref.getreview1059())  />
		<cfset student_data.setbodyfat(ref.getbodyfat())  />
		<cfset student_data.settaped(ref.gettaped())  />
		<cfset student_data.setgrade(ref.getgrade())  />
		<cfset student_data.setpdate(ref.getpdate())  />

		<cf_student_dataBreadcrumb method="new" student_data = "#student_data#"  new="true" /> 

		<cf_student_dataEdit student_data = "#student_data#" message="#url.message#" /> 
	</cfcase>

	<cfcase value="edit_process">
		<cfset student_data = EntityNew("student_data") />
		<cfset student_data = student_data.populate(form) />
		<cfset application.student_dataService.update(student_data) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=edit&stu_ID=#student_data.getstu_ID()#&message=updated" />
	</cfcase>

	<cfcase value="delete_process">
			<cfset student_data = application.student_dataService.get(url.stu_ID) />
		<cfset application.student_dataService.destroy(student_data) />
		<cfset ORMFlush() />
		<cflocation url ="#cgi.script_name#?method=list&message=deleted" />
	</cfcase>

</cfswitch>
</cf_pageWrapper>