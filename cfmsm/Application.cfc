<cfcomponent displayname = "Application.cfc">
<cfscript>
	// define application //
	this.name = "mailspoolmanager_v15";
	this.applicationtimeout = "#createtimespan(6,0,0,0)#";
	this.clientmanagement= "yes";
	this.loginstorage = "session" ;

	this.sessionmanagement = true;
	this.sessiontimeout = "#createtimespan(0,0,45,0)#";
	
	this.setClientCookies = "yes";
	this.setDomainCookies = "yes";
	this.scriptProtect = "all"; 
</cfscript>

<!--- onApplicationStart --->
<cffunction name = "onApplicationStart" returntype = "boolean">

	<cflog file="#this.Name#" type="Information" text="Application Started" />
	<cfscript>
		// independant global variables //
		application.availableResources = 0;
		application.counter = 1;
		application.sessions = 0;

		// pagination
		application.mailspool.rowsPerPage = 5;
	
		// current version URL
		application.mailspool.currentVersionURL = "http://www.iribbit.net/i/cfmsm/version.txt";
		application.mailspool.currentVersion = 0;
		application.mailspool.thisVersion = 1.5;
	
		// define directory variables
		thisPath = cgi.path_info;
		thisPath = listlen(thisPath, "/");
		thisPath = thisPath - 2;
		prefixPath = "";
			For (i=1;i LTE thisPath; i=i+1)
				prefixPath = prefixPath & "../";
		application.mailspool.cfide_root = prefixPath;
		application.mailspool.dir_mail = server.coldfusion.rootdir & "\mail\";
		application.mailspool.dir_mail_try = application.mailspool.dir_mail & "spool\";
		application.mailspool.dir_mail_bad = application.mailspool.dir_mail & "Undelivr\";
	
		// define scheduled task to run once per day
		// all variables are required for oversight/accountability
		application.mailspool.msmAdminTO = "xxxxxxxxxxxx@xxxxxx.xxx"; // server administrator assigned to managing e-mail errors
		application.mailspool.msmAdminCC = "xxxxxxxxxxxx@xxxxxx.xxx"; // network administrator responsible for server functionality
		application.mailspool.msmReplyTO = "xxxxxxxxxxxx@xxxxxx.xxx"; // standard reply to e-mail address
		application.mailspool.msmThreshold = 5; // notification threshold, trigger for end of day notification
	</cfscript>

<cfreturn true>
</cffunction>

<!--- 
/////////////////////////////////////
//                                 //
//         onSessionStart          //
//                                 //
/////////////////////////////////////
--->
<cffunction name="onSessionStart" returntype="void" output="false">

	<!--- clearing session when browser closes --->
	<cfif ISDEFINED("cookie.CFID") and ISDEFINED("cookie.CFTOKEN")>
	<cfset localCFID = Cookie.CFID>
	<cfset localCFTOKEN = Cookie.CFTOKEN>
	<cfcookie name = "CFID" value = "#localCFID#">
	<cfcookie name = "CFTOKEN" value = "#localCFTOKEN#">
	</cfif>

	<cfscript>
		Application.sessions = Application.sessions + 1;
	</cfscript>
	<cflog file="#this.Name#" type="Information" text="Session:#Session.sessionid# started" />

</cffunction>

<!--- 
/////////////////////////////////////
//                                 //
//         onRequestStart          //
//                                 //
/////////////////////////////////////
--->
<cffunction name="onRequestStart" returntype="string" output="true">

	<cfinclude template="#application.mailspool.cfide_root#Application.cfm">
	<cfinclude template="inc-udf.cfm">
	<cfscript>
		if (ISDEFINED("url.init")) {
			onApplicationStart();
			StructClear(request);
			StructClear(session);
			StructClear(cookie);
			StructClear(form);
			StructClear(url);
		}
	</cfscript>

<cfreturn true />
</cffunction>


<!--- 
/////////////////////////////////////
//                                 //
//            onRequest            //
//                                 //
/////////////////////////////////////
--->
<cffunction name="onRequest" returntype="string" output="true">
<cfargument name="targetPage" type="String" required="true" />

	<!--- get page contents --->
	<cfsavecontent variable="pagecontent">
	<cfinclude template="#arguments.targetpage#">
	</cfsavecontent>
	
	<!--- output page --->
	<cfoutput>
	#pagecontent#
	</cfoutput>

<cfreturn true />
</cffunction>

<!--- 
/////////////////////////////////////
//                                 //
//          onRequestEnd           //
//                                 //
/////////////////////////////////////
--->
<cffunction name="onRequestEnd" returntype="void" output="false">
<cfargument name="thePage" type="string" required="true" />


		
</cffunction>

<!--- 
/////////////////////////////////////
//                                 //
//          onSessionEnd           //
//                                 //
/////////////////////////////////////
--->
<cffunction name="onSessionEnd" returntype="void" output="false">
<cfargument name="sessionScope" type="struct" required="true" />
<cfargument name="appScope" type="struct" required="false" />

	<cflog file="#this.Name#" type="Information" text="Session:#arguments.SessionScope.sessionid# ended" />

</cffunction>

<!--- 
/////////////////////////////////////
//                                 //
//        onApplicationEnd         //
//                                 //
/////////////////////////////////////
--->
<cffunction name="onApplicationEnd" returntype="void" output="false">
<cfargument name="ApplicationScope" required="true" />

	<cflog file="#this.Name#" type="Information" text="Application #ApplicationScope.applicationname# Ended" />
	<cfmail from = "xxxxxx@xxxxxx.xxx"
			to = "xxxxxx@xxxxxx.xxx"
			replyto = "xxxxxx@xxxxxx.xxx"
			subject = "Mail Spool Manager Application ENDED (#cgi.http_host#)"
			type = "html">
	<cfmailpart type = "html">
	<strong>The Mail Spool Manager Application ENDED.</strong><br />
	At the time of this e-mail the Mail Spool Manager Application has either timed out or has been shut down.<br />
	<br />
	If another message stating that the service has started does not follow this one shortly, then it is likely the web server is down and a support ticket will need to be submitted.<br />
	<br />
	<cfoutput>
	<small><em>#dateformat(now(),"dddd mmmm dd, yyyy")#</em></small>
	<small><em>#cgi.http_host#</em></small>
	</cfoutput>
	</cfmailpart>
	</cfmail>

</cffunction>

<!--- 
/////////////////////////////////////
//                                 //
//            onError              //
//                                 //
/////////////////////////////////////
--->
<cffunction name="onError">
<cfargument name="Exception" required="true" />
<cfargument type="String" name="EventName" required="true" />

	<cflog file="#this.Name#" type="error" text="Event Name: #Eventname#" />
	<cflog file="#this.Name#" type="error" text="Message: #exception.message#" />

	<cfif ISDEFINED("exception.rootcause")>
	<cflog file="#this.Name#" type="error" text="Root Cause Message: #exception.rootcause.message#" />
	</cfif>

	<cfif NOT (Arguments.EventName IS onSessionEnd) OR (Arguments.EventName IS onApplicationEnd)>
	<cfoutput>
	<h2>An unexpected error occurred.</h2>
	Please provide the following information to technical support:<br />
	Error Event: #EventName#<br />
	Error details:<br />
	<cfdump var = "#exception#" /><br />
	<br />
	</cfoutput>
	</cfif>

<cfreturn true />
</cffunction>

<!--- 
/////////////////////////////////////
//                                 //
//        onMissingTemplate        //
//                                 //
/////////////////////////////////////
--->
<cffunction name="onMissingTemplate" returntype="boolean" output="true">
<cfargument name="targetPage" type="string" required=true/>
	<cftry>
	<cflog type="error" text="Missing template: #Arguments.targetPage#">
	<cfoutput>
	<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
	<html>
	<head>
	<title>The page cannot be found</title>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<cfheader name="Author" value="Derek T. Versteegen" />
	<cfheader name="Engine" value="#server.ColdFusion.ProductName# #server.ColdFusion.ProductVersion#" />
	<cfheader name="Robots" value="no-follow" />
	<cfheader name="Expires" value="#GetHttpTimeString()#" />
	<cfheader name="Pragma" value="no-cache" />
	<cfheader name="Cache-Control" value="no-cache" />
	<style type="text/css">
		body { font:8pt/12pt verdana; }
		h1 { font:13pt/15pt verdana; font-weight:bold; }
		h2 { font:11pt/13pt verdana; font-weight:bold; }
		a:link { color:red; }
		a:visited { color:maroon; }
		##error { margin:20px; width:500px; }
		##footer { text-align:center; color:red; }
	</style>
	</head>
	<body>
	<div id="error">
	<h1>#application.applicationname#</h1>
	<h2>The page cannot be found</h2>
	The page you are looking for might have been removed, had its name changed, or is temporarily unavailable.<br />
	<hr />
	Please try the following:
	<ul>
		<li>Make sure that the Web site address displayed in the address bar of your browser is spelled and formatted correctly.</li>
		<li>If you reached this page by clicking a link, contact the Web site administrator to alert them that the link is incorrectly formatted.</li>
		<li>Click the Back button to try another link.</li>
	</ul>
	HTTP Error 404 - File or directory not found.<br />
	Internet Information Services (IIS)<br />
	<hr />
	Technical Information (for support personnel)
	<ul>
		<li>Go to Microsoft Product Support Services and perform a title search for the words HTTP and 404.</li>
		<li>Open IIS Help, which is accessible in IIS Manager (inetmgr), and search for topics titled Web Site Setup, Common Administrative Tasks, and About Custom Error Messages.</li>
		<li>The page <em>#application.urlused##arguments.targetPage#</em> was improperly reference - check the referring URL.</li>
	</ul>
	</div>
	<div id="footer">
	<a href="javascript:void(0);" onclick="history.back();">back</a>
	&nbsp;|&nbsp;
	<a href="javascript:void(0);" onclick="window.close();">close</a>
	</div>
	</body>
	</html>
	</cfoutput>
	<cfreturn true />
		<cfcatch>
		<cfreturn false />
		</cfcatch>
	</cftry>
</cffunction>

</cfcomponent>