<cfsetting showdebugoutput="no">
<!--- modify (form) --->
<cfif ISDEFINED("form.btn_modify")>
<cffile action="read" file="#application.mailspool.dir_mail_bad##form.emfile#" variable="mailContent">
<cfscript>
	// param form values since some may not exist
	if (NOT ISDEFINED("form.sender")) {form.sender = "";}
	if (NOT ISDEFINED("form.sender_old")) {form.sender_old = "";}
	if (NOT ISDEFINED("form.to")) {form.to = "";}
	if (NOT ISDEFINED("form.to_old")) {form.to_old = "";}
	if (NOT ISDEFINED("form.cc")) {form.cc = "";}
	if (NOT ISDEFINED("form.cc_old")) {form.cc_old = "";}
	if (NOT ISDEFINED("form.bcc")) {form.bcc = "";}
	if (NOT ISDEFINED("form.bcc_old")) {form.bcc_old = "";}
	if (NOT ISDEFINED("form.subject")) {form.subject = "";}
	if (NOT ISDEFINED("form.subject_old")) {form.subject_old = "";}
	if (NOT ISDEFINED("form.server")) {form.server = "";}
	if (NOT ISDEFINED("form.server_old")) {form.server_old = "";}
	
	// replace submitted values - sender,to,cc,bcc,subject,server
	mailContent = replace(mailContent,"from:  #form.sender_old#","from:  #form.sender#","all");
	mailContent = replace(mailContent,"to:  #form.to_old#","to:  #form.to#","all");
	mailContent = replace(mailContent,"cc:  #form.cc_old#","cc:  #form.cc#","all");
	mailContent = replace(mailContent,"bcc:  #form.bcc_old#","bcc:  #form.bcc#","all");
	mailContent = replace(mailContent,"subject:  #form.subject_old#","subject:  #form.subject#","all");
	mailContent = replace(mailContent,"server:  #form.server_old#","server:  #form.server#","all");
</cfscript>
<cffile action="write" file="#application.mailspool.dir_mail_bad##form.emfile#" output="#mailContent#" nameconflict="overwrite">
<cflocation url="action.cfm?btn_resend=yes&emfile=#form.emfile#" addtoken="no" statuscode="301">
<cfabort>

<!--- delete (form) --->
<cfelseif ISDEFINED("form.btn_delete") AND ISDEFINED("form.emfile")>
<cfif fileexists(application.mailspool.dir_mail_bad & form.emfile)>
<cffile action="delete" file="#application.mailspool.dir_mail_bad##form.emfile#">
</cfif>
<cflocation url="list.cfm" addtoken="no" statuscode="301">
<cfabort>

<!--- delete (url) --->
<cfelseif ISDEFINED("url.btn_delete") AND ISDEFINED("url.emfile")>
<cfif fileexists(application.mailspool.dir_mail_bad & url.emfile)>
<cffile action="delete" file="#application.mailspool.dir_mail_bad##url.emfile#">
</cfif>
<cflocation url="list.cfm" addtoken="no" statuscode="301">
<cfabort>

<!--- resend (url) --->
<cfelseif ISDEFINED("url.btn_resend")>
<cfif fileexists(application.mailspool.dir_mail_bad & url.emfile)>
<cffile action="move" source="#application.mailspool.dir_mail_bad##url.emfile#" destination="#application.mailspool.dir_mail_try##url.emfile#">
</cfif>
<cflocation url="list.cfm" addtoken="no" statuscode="301">
<cfabort>

<!--- cancel (url/form) --->
<cfelseif ISDEFINED("url.btn_cancel") OR ISDEFINED("form.btn_cancel")>
<cflocation url="list.cfm" addtoken="no" statuscode="300">
<cfabort>

<!--- other (any) --->
<cfelse>
<cflocation url="list.cfm" addtoken="no" statuscode="300">
<cfabort>
</cfif>