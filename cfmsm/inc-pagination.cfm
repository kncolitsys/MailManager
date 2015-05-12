<cfscript>
	// set pagination variables
	rowsPerPage = application.mailspool.rowsPerPage;
	if (NOT ISDEFINED("url.startRow")){url.startRow=1;}
	totalRecords = mlFailed.recordcount;
	totalPages = totalRecords / rowsPerPage;
	endRow = (startRow + rowsPerPage) - 1;
	if (NOT ISDEFINED("currentPage")){currentPage=1;}
	
	// if the endrow is greater than the total, set the end row to to total
	if (endRow GT totalRecords) {endRow = totalRecords;}

	// add an extra page if you have leftovers
	if ((totalRecords MOD rowsPerPage) GT 0) {totalPages = totalPages + 1;}
</cfscript>

<!--- Display all of the pages --->
<cfif totalPages gte 2>
<div style="text-align:right;">
Page
<cfloop from="1" to="#totalPages#" index="i">
<cfset startRow = ((i - 1) * rowsPerPage) + 1>
<cfoutput>
/
<cfif currentPage NEQ i>
<a href="list.cfm?startRow=#startRow#&currentPage=#i#">#i#</a>
<cfelse>
<b>#i#</b>
</cfif>
</cfoutput>
</cfloop>
</div>
</cfif>
