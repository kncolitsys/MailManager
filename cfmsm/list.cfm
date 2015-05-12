<html>
<head>
<title>cfMail Spool Manager (cfMSM)</title>
<cfsetting showdebugoutput="no">
<cfinclude template="../inc-scripts.cfm">
</head>

<body style="background:#ececec">

<cfinclude template="../inc-top.cfm">
<!--- insert custom application below comment --->

<cfdirectory action="list" name="mlPending" directory="#application.mailspool.dir_mail_try#" sort="DATELASTMODIFIED DESC">
<cfdirectory action="list" name="mlFailed" directory="#application.mailspool.dir_mail_bad#" sort="DATELASTMODIFIED DESC">
<cfwindow x="10" y="10" width="600" height="480" name="MailPreview" minheight="400" minwidth="400" title="Mail Preview Window" initshow="false" source="preview.cfm?lookat={MailSpool:EmailPreview}&flag={MailSpool:EmailBodyFlag}" />
<cfwindow x="10" y="10" width="600" height="480" name="MailModify" minheight="400" minwidth="400" title="Mail Modify Window" initshow="false" source="edit.cfm?lookat={MailSpool:EmailPreview}" />
<cfscript>
	// set message for failed sentence in grid header
	if (mlFailed.recordcount LTE 25) {
		msgFailed = " and <b>#mlFailed.recordcount#</b> could NOT be delivered.";
	}
	else {
		msgFailed = ". Of the <b>#mlFailed.recordcount#</b> that could NOT be delivered, only the 25 newest files are displayed - these messages should be handled as a top priority.";
	}

	// set message for pending sentence in grid header
	if (mlPending.recordcount NEQ 0) {
		writeoutput("<meta http-equiv='refresh' content='15;url=list.cfm' />");
		msgPending = "(page will refresh in 15 seconds)<br />";
	}
	else {
		msgPending = "";
	}
</cfscript>
<cfform name="MailSpool" action="list.cfm" method="post">
<cfinput type="hidden" name="EmailPreview" value="">
<cfinput type="hidden" name="EmailBodyFlag" value="true">
<br />
<table border="0" cellpadding="5" cellspacing="0" width="100%" class="cell2BlueSidesAndBlueBkgd">
<tr><td width="100%" nowrap="nowrap" style="padding-left:20px;">
Click the button on the right to refresh the page...<br />
</td><td align="right" nowrap="nowrap" style="padding-right:20px;">
<cfinput title="Submit Changes" class="buttn" name="adminsubmit" value="Refresh" type="Submit"><br />
</td></tr>
</table>
	<cfoutput>
	<div style="margin:20px;">
	<h2 class="pageHeader">Mail Spool Manager</h2>
	<br />
	There are currently <b>#mlPending.recordcount#</b> e-mail messages in cue#msgFailed#<br />
	<small><em>#msgPending#</em></small><br />
	<!--
	<cfinput type="checkbox" name="EmailBodyFlagOption" value="1" style="position:relative; top:2px;" />
	Yes, when previewing a message I want to see the entire message?<br />
	<br />
	-->
	<cfif mlFailed.recordcount NEQ 0>
	<cfinclude template="inc-pagination.cfm">
	<table border="0" cellpadding="2" cellspacing="0" width="100%">
	<tr><th class="cellBlueTopAndBottom" scope="col" bgcolor="##f3f7f7">
	Actions<br />
	</th><th class="cellBlueTopAndBottom" scope="col" bgcolor="##f3f7f7">
	Filename<br />
	</th><th class="cellBlueTopAndBottom" scope="col" bgcolor="##f3f7f7">
	Size<br />
	</th><th class="cellBlueTopAndBottom" scope="col" bgcolor="##f3f7f7">
	Attempt Date &amp; Time<br />
	</th></tr>
	
	<cfloop query="mlFailed" startrow="#url.startRow#" endrow="#evaluate(url.startRow + rowsPerPage)#">
	<tr><td class="cell3BlueSides" nowrap="nowrap">
	<a href="javascript: void(0);" onClick="document.getElementById('EmailPreview').value='#NAME#'; ColdFusion.Window.show('MailPreview');"><img src="/CFIDE/administrator/images/view.gif" alt="Preview this E-Mail Message" title="Preview this E-Mail Message" border="0" vspace="2" width="16" height="16" hspace="2"></a>
	<a href="action.cfm?btn_resend=yes&emfile=#name#"><img src="/CFIDE/administrator/images/irefresh.gif" alt="Resend this E-Mail Message" title="Resend this E-Mail Message" border="0" vspace="2" width="16" height="16" hspace="2"></a>
	<a href="javascript: void(0);" onClick="document.getElementById('EmailPreview').value='#NAME#'; ColdFusion.Window.show('MailModify');"><img src="/CFIDE/administrator/images/edit.gif" alt="Modify the E-Mail Header" title="Modify the E-Mail Header" border="0" vspace="2" width="16" height="16" hspace="2"></a>
	<a href="action.cfm?btn_delete=yes&emfile=#name#"><img src="/CFIDE/administrator/images/delete_button.gif" alt="Delete this Message" title="Delete this Message" border="0" vspace="2" width="16" height="16" hspace="2"></a>
	</td><td class="cellRightAndBottomBlueSide" nowrap="nowrap">
	<a href="javascript: void(0);" onClick="document.getElementById('EmailPreview').value='#NAME#'; ColdFusion.Window.show('MailPreview');">#NAME#</a>
	</td><td class="cellRightAndBottomBlueSide" nowrap="nowrap">
	#getFileSize(size)#<br />
	</td><td class="cellRightAndBottomBlueSide" nowrap="nowrap">
	#dateformat(DATELASTMODIFIED,"long")# at #timeformat(DATELASTMODIFIED,"long")#<br />
	</td></tr>
	</cfloop>
	</table>
	<cfinclude template="inc-pagination.cfm">
	</cfif>
	</div>
	</cfoutput>
<table border="0" cellpadding="5" cellspacing="0" width="100%" class="cell2BlueSidesAndBlueBkgd">
<tr><td width="100%" nowrap="nowrap" style="padding:3px 20px; font-size:9px; text-align:right;" colspan="2">
<cfoutput>
You are currently running v#application.mailspool.thisVersion#.
<cfif application.mailspool.thisVersion LT application.mailspool.currentVersion>
A newer version, v#application.mailspool.currentVersion#, is available for download at <a href="http://cfmsm.riaforge.com" title="Mail Spool Manager" target="_blank">http://cfmsm.riaforge.com</a>.<br />
<cfelse>
No updates available at this time.<br />
</cfif>
</cfoutput>
</td></tr>
</table>
</cfform>

<!--- insert custom application above comment --->
<cfinclude template="../inc-bottom.cfm">

</body>
</html>