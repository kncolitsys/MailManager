<!--- parse e-mail message --->
<cffunction name="getMailPreview" output="false" returntype="struct" hint="Parses a mail file for info.">
	<cfargument name="mailContent" type="string" required="true" />
	<cfargument name="mailHeaderBody" type="boolean" default="true" hint="If True, returns e-mail body" />

	<cfscript>
		// default variables
		var result = structNew();
		var mail = arguments.mailContent;
		var pos = "";
		var line = "";
		var bodyType = "";
		
		// parse SERVER:
		pos = reFindNoCase("(?m)^server: (.*?)\n", mail, 1, 1);
		if (pos.len[1] is not 0) {result.server = trim(mid(mail, pos.pos[2], pos.len[2]));} else {result.server = "";}

		// parse FROM:
		pos = reFindNoCase("(?m)^from: (.*?)\n", mail, 1, 1);
		if (pos.len[1] is not 0){result.sender = trim(mid(mail, pos.pos[2], pos.len[2]));} else {result.sender = "";}

		// parse TO:
		pos = reFindNoCase("(?m)^to: (.*?)\n", mail, 1, 1);
		if (pos.len[1] is not 0){result.to = trim(mid(mail, pos.pos[2], pos.len[2]));} else {result.to = "";}

		// parse CC:
		pos = reFindNoCase("(?m)^cc: (.*?)\n", mail, 1, 1);
		if (pos.len[1] is not 0) {result.cc = trim(mid(mail, pos.pos[2], pos.len[2]));} else {result.cc = "";}
		
		// parse BCC:
		pos = reFindNoCase("(?m)^bcc: (.*?)\n", mail, 1, 1);
		if (pos.len[1] is not 0) {result.bcc = trim(mid(mail, pos.pos[2], pos.len[2]));} else {result.bcc = "";}

		// parse SUBJECT:
		pos = reFindNoCase("(?m)^subject: (.*?)\n", mail, 1, 1);
		if (pos.len[1] is not 0) {result.subject = trim(mid(mail, pos.pos[2], pos.len[2]));} else {result.subject = "";}

		// parse REPLYTO:
		pos = reFindNoCase("(?m)^replyto: (.*?)\n", mail, 1, 1);
		if (pos.len[1] is not 0) {result.replyto = trim(mid(mail, pos.pos[2], pos.len[2]));} else {result.replyto = "";}

		// parse FAILTO:
		pos = reFindNoCase("(?m)^failto: (.*?)\n", mail, 1, 1);
		if (pos.len[1] is not 0) {result.failto = trim(mid(mail, pos.pos[2], pos.len[2]));} else {result.failto = "";}
	</cfscript>

<!--- parse files: --->
<cfset result.attachments = arrayNew(1)>
<cfset pos = reFindNoCase("(?m)^file: (.*?)\n", mail, 1, 1)>
<cfloop condition="pos.len[1] is not 0">
<cfif pos.len[1] is not 0>
<cfset arrayAppend(result.attachments,trim(mid(mail, pos.pos[2], pos.len[2])))>
</cfif>
<cfset pos = reFindNoCase("(?m)^file: (.*?)\n", mail, pos.pos[2]+pos.len[2], 1)>
</cfloop>

<!--- parse BODY: --->
<cfset result.body = "">
<cfif arguments.mailHeaderBody>
<cfif findNoCase("bodypart-start:  text/plain;",mail) and findNoCase("bodypart-start:  text/html;",mail)>
<cfset result.type = "multipart">
<cfelseif findNoCase("type:  text/html", mail)>
<cfset result.type = "html">
<cfelse>
<cfset result.type = "text">
</cfif>

<cfif result.type EQ "multipart">
<cfset result.html = createObject("java", "java.lang.StringBuffer").init()>
<cfset result.plain = createObject("java", "java.lang.StringBuffer").init()>
<cfset bodyType = "plain">
	<cfloop index="line" list="#mail#" delimiters="#chr(10)##chr(13)#">
	<cfif findNoCase("body: ", line) is 1>
	<cfset result[bodyType].append(replaceNoCase(line, "body: ", "") & chr(10) )>

	<cfelseif findNoCase("bodypart-start:  text/plain;",line)>
	<cfset bodyType = "plain">

	<cfelse>
	<cfset bodyType = "html">
	</cfif>
	</cfloop>
<cfelse>
<cfset result.body = createObject("java", "java.lang.StringBuffer").init()>
	<cfloop index="line" list="#mail#" delimiters="#chr(10)##chr(13)#">
	<cfif findNoCase("body: ", line) is 1>
	<cfset result.body.append(replaceNoCase(line, "body: ", "") & chr(10) )>
	</cfif>
	</cfloop>
</cfif>
</cfif>

<cfreturn result>
</cffunction>

<!--- private / helper functions --->
<cffunction name="getFileSize" access="private" returntype="string" output="false">
<cfargument name="size" type="numeric" required="true" />
<cfscript>
	var str = '';
	if (arguments.size GTE 1048576) {
		str = arguments.size \ 1048576;
		str = numberformat(str,"999,999.9") & " Mb";
	}
	else if (arguments.size GTE 1024) {
		str = arguments.size \ 1024;
		str = numberformat(str,"999,999.9") & " Kb";
	}
	else {
		str =  arguments.size;
		str = numberformat(str,"999,999.9") & " b";
	}
	return str;
</cfscript>
</cffunction>

<!--- url params --->
<cfscript>
	// param the url string
	if (NOT ISDEFINED("url.lookat")){url.lookat="";}
	if (NOT ISDEFINED("url.flag")){url.flag=1;}
</cfscript>