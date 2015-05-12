<html>
<head>
<title>xxxxxx</title>
<cfsetting showdebugoutput="no">
<cfinclude template="inc-scripts.cfm">
</head>

<body style="background:#ececec">

<cfinclude template="inc-top.cfm">
<!--- insert custom application below comment --->

<cfoutput>
	<cfform action="" method="post">
	<br />
	<table border="0" cellpadding="5" cellspacing="0" width="100%" class="cell2BlueSidesAndBlueBkgd">
	<tr><td width="100%" nowrap="nowrap" style="padding-left:20px;">
	Click the button on the right to save your changes...<br />
	</td><td align="right" nowrap="nowrap" style="padding-right:20px;">
	<cfinput title="Submit Changes" class="buttn" name="adminsubmit" value="Submit Changes" type="Submit"><br />
	</td></tr>
	</table>
	</cfform>
<div style="margin:20px;">
<h2 class="pageHeader">Title</h2><br />
</cfoutput>
</div>

<!--- insert custom application above comment --->
<cfinclude template="inc-bottom.cfm">

</body>
</html>
