<cfsetting showdebugoutput="no">
<cftry>
<!--- check current version --->
<cfhttp method="get" url="#application.mailspool.currentVersionURL#"></cfhttp>
<cfscript>
	// set current version in application scope
	application.mailspool.currentVersion = cfhttp.filecontent;

	// param logical switches
	msg = "none";
	msgType = "information";
	msmLog = 0;
</cfscript>

<!--- check Undelivr folder --->
<cfdirectory action="list" name="mlFailed" directory="#application.mailspool.dir_mail_bad#" sort="DATELASTMODIFIED DESC">

<!--- send notification based on threshold --->
<cfif mlFailed.recordcount GT application.mailspool.msmThreshold>
<cfmail to="#application.mailspool.msmAdminTO#" cc="#application.mailspool.msmAdminCC#" from="#application.mailspool.msmReplyTO#" subject="Mail Spool Mananger Notification (#lcase(cgi.server_name)#)">
<cfmailpart type="text">
UNDELIVERED E-MAIL LIMIT EXCEEDED
#ucase(cgi.server_name)#

This is an automated notification sent to inform you more than #application.mailspool.msmThreshold# e-mail messages not been able to be delivered for any number of reasons.

Please log into the server's ColdFusion Administrator and use the Mail Spool Manager in the Add-Ons section to resend, modify, or remove messages as needed.

Common causes for failed e-mail message delivery include:
1.) unvalidated/invalid e-mail addresses in the TO:, FROM:, CC:, BCC:, REPLYTO:, or FAILTO: components of an e-mail.
2.) improper ColdFusion Administrator mail server settings
3.) improper application programming - related to mail server settings
4.) inability to connect to a mail server - server not available
5.) web server not permitted to relay e-mail

----
Server ID: #cgi.remote_addr#
Notification Date : #dateformat(now(),"long")# #timeformat(now(),"long")#

</cfmailpart>
<cfmailpart type="html">
<b>UNDELIVERED E-MAIL LIMIT EXCEEDED</b><br />
<b>#ucase(cgi.server_name)#</b><br />
<br />
This is an automated notification sent to inform you more than #application.mailspool.msmThreshold# e-mail messages not been able to be delivered for any number of reasons.<br />
<br />
Please log into the server's ColdFusion Administrator and use the Mail Spool Manager in the Add-Ons section to resend, modify, or remove messages as needed.<br />
<br />
Common causes for failed e-mail message delivery include:<br />
<ul>
	<li>unvalidated/invalid e-mail addresses in the TO:, FROM:, CC:, BCC:, REPLYTO:, or FAILTO: components of an e-mail.</li>
	<li>improper ColdFusion Administrator mail server settings</li>
	<li>improper application programming - related to mail server settings</li>
	<li>inability to connect to a mail server - server not available</li>
	<li>web server not permitted to relay e-mail</li>
</ul>
<hr /><br />
<small><em>
IP Address: #cgi.remote_addr#<br />
Notification Date : #dateformat(now(),"long")# #timeformat(now(),"long")#<br />
</em></small>
<br />
</cfmailpart>
</cfmail>
<cfscript>
	msg = "success";
	msgType = "warning";
	msmLog = 1;
</cfscript>
</cfif>
	<cfcatch type="any">
	<cfscript>
		msg = "failed";
		msgType = "error";
		msmLog = 1;
	</cfscript>
	</cfcatch>
</cftry>

<!--- create log entry for threshold events or if an error is thrown during that process --->
<cfif msmLog EQ 1>
<cflog application="no" file="#application.applicationname#_notifications" text="Undelivered E-Mail Limit Exceeded - #mlFailed.recordcount# - notification #msg#" type="#msgType#">
</cfif>

<!--- output what is known - no reason, but just in case the file is run manually --->
<cfoutput>
Notification : #msg#<br />
Label : #msgType#<br />
--<br />
Count : #mlFailed.recordcount#<br />
Limit : #application.mailspool.msmThreshold#<br />
</cfoutput>