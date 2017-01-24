component{

	This.name = "EAATSAPPS";
	This.ormenabled = true;
	This.datasource = "EAATSAPPS";
	This.customTagPaths = GetDirectoryFromPath(GetCurrentTemplatePath()) & "customtags";
	This.ormsettings.eventHandler = "AllData.cfc.eventHandler";
	This.ormsettings.dbcreate = "update";
	This.ormsettings.logSQL = true;


	public boolean function onRequestStart() {

		if (structKeyExists(url, "reset_app")){
			ApplicationStop();
			location(cgi.script_name, false);
		}

		return true;
	}

	public boolean function onApplicationStart() {
		application.testrdlogService = new AllData.services.testrdlogService();
		application.rolesService = new AllData.services.rolesService();
		application.active_userService = new AllData.services.active_userService();
		application.site_userService = new AllData.services.site_userService();
		application.isd_course_libService = new AllData.services.isd_course_libService();
		application.isd_coursesService = new AllData.services.isd_coursesService();
		application.site_group_memberService = new AllData.services.site_group_memberService();
		application.templatesService = new AllData.services.templatesService();
		application.s3_bluebook_usersService = new AllData.services.s3_bluebook_usersService();
		application.isd_personService = new AllData.services.isd_personService();
		application.usersService = new AllData.services.usersService();
		application.s3_non_atrrsService = new AllData.services.s3_non_atrrsService();
		application.ratealpharosterService = new AllData.services.ratealpharosterService();
		application.student_dataService = new AllData.services.student_dataService();
		application.testcontrlService = new AllData.services.testcontrlService();
		application.isd_subjectsService = new AllData.services.isd_subjectsService();
		application.site_group_requestService = new AllData.services.site_group_requestService();
		application.sig1059Service = new AllData.services.sig1059Service();
		application.s3_bluebookService = new AllData.services.s3_bluebookService();
		return true;
	}
}