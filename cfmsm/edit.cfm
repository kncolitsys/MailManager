<html>
<head>
<title>cfMail Spool Manager (cfMSM)</title>
<cfsetting showdebugoutput="no">
<cfinclude template="../inc-scripts.cfm">
</head>

<body style="background:#ececec">

<cfinclude template="../inc-top.cfm">
<!--- insert custom application below comment --->

<cfoutput>
<div style="margin:20px;">
<h2 class="pageHeader">Mail Spool Editor</h2>
<br />
<cfif fileexists(application.mailspool.dir_mail_bad & url.lookat)>
<cfdirectory action="list" name="mailInfo" directory="#application.mailspool.dir_mail_bad#" filter="#url.lookat#">
<cffile action="read" file="#application.mailspool.dir_mail_bad##url.lookat#" variable="mailContent">
<cfset MailPreview = getMailPreview(mailContent,url.flag)>
<form action="action.cfm" method="post">
<table border="0" cellpadding="2" cellspacing="0" width="100%">
<tr><td class="cellBlueTopAndBottom" scope="col" bgcolor="##f3f7f7">
	<table>
	<tr><th style="text-align:right;">
	Date : <br />
	</th><td>
	#dateformat(mailInfo.DATELASTMODIFIED,"mm/dd/yyyy")# #timeformat(mailInfo.DATELASTMODIFIED,"long")#<br />
	</td></tr>
	<cfloop list="Sender,To,CC,BCC,Subject,Server" index="i">
	<cfset this = evaluate("MailPreview." & i)>
	<cfif len(this) GT 0>
	<tr><th style="text-align:right;">
	#replace(i,"Sender","From","all")# : <br />
	</th><td>
	<input type="hidden" name="#i#_old" value="#this#">
	<input type="text" name="#i#" value="#this#" size="50"><br />
	</td></tr>
	</cfif>
	</cfloop>
	<cfif arraylen(MailPreview.Attachments) GT 0>
	<tr><th style="text-align:right;">
	Attachments : <br />
	</th><td>
	#arraylen(MailPreview.Attachments)#<br />
	</td></tr>
	</cfif>
	</table>
</td></tr>
<tr><td class="cell3BlueSides" nowrap="nowrap">
<pre>#MailPreview.Body#</pre>
</td></tr>
<input type="hidden" name="emfile" value="#url.lookat#">
<tr><td class="cellBlueTopAndBottom" scope="col" bgcolor="##f3f7f7" style="padding:20px; text-align:right;">
<input type="submit" name="btn_modify" value="Save and Resend" class="buttn">
<input type="submit" name="btn_delete" value="Delete" class="buttn">
<input type="submit" name="btn_cancel" value="Cancel" class="buttn">
<br />
</td></tr>
</table>
</form>
<br />
<cfelse>
No message could be found. It has either been removed or respooled.<br />
</cfif>
</div>
</cfoutput>

<!--- insert custom application above comment --->
<cfset showFooter = 0>
<cfinclude template="../inc-bottom.cfm">

</body>
</html>
