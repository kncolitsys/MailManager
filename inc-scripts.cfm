<style type="text/css">
	body, p, td {
		font-family: Arial, Helvetica, sans-serif;
	
		font-size: small;
	
	}
	
	th {
	 font-family: Arial, Helvetica, sans-serif;
	 font-size: small; ! important;
	}
	
	th {
	 text-align:left;
	}
	.adminbody {
		background-color: #c4c4c4;
	}
	
	.resourcelist {
		list-style-type:square;
		margin-top:5px;
		margin-bottom:10px;
	}
	
	.errorText {
		color: #CC0000; 
	}
	
	.successText {
		color: #008800; 
	}
	
	.loginWhiteText {
		color: #FFFFFF; 
		font-weight: bold;
	}
	
	.loginInvalidText {
		color: #CC0000; 
		font-weight: bold;
	}
	
	.loginCopyrightText {
		color: #000000;
		font-size: 9px;
		font-family:Arial, Helvetica, sans-serif;
	}
	
	a {
		color: #003399;
		text-decoration: none;
	}
	
	a:hover {
		color: #008A00; 
	}
	
	.iconLinkText {
		color: #FFFFFF;
		font-weight: bold;
	
		font-size: small;
	
	}
	
	.leftMenuLinkText {
		color: #6C7A83; 
	
		font-size: small;
	
	}
	
	.leftMenuLinkTextHighlighted {
		color: #123f61; 
	
		font-size: small;
	
		font-weight:bold;
	}
	
	.topMenuLinkText {
		color: #000000;
		font-size: x-small; 
	}
	
	.menuCFAdminText {
		color: #000000;
		font-weight: bold;
		
	
		font-size: small;
	
	}
	
	.menuAuxText {
		color: #6C7A83;
		
			font-size: small;
		
	}
	
	.menuHeaderText {
		color: #0072AC;
		font-weight: bold;
	
		font-size: x-small;
	
		text-transform:uppercase;
	}
	
	.menuTD {
		/*border-top-width: 1px;
		border-right-width: 1px;
		border-bottom-width: 1px;
		border-left-width: 1px;
		border-top-style: none;
		border-right-style: none;
		border-bottom-style: solid;
		border-left-style: none;
		border-bottom-color: #CCCCCC;*/
		background: #ececec;
	}
	
	.menuTDHeader {
		/* can delete me thinks */
		/*border-top-width: 1px;
		border-right-width: 1px;
		border-bottom-width: 1px;
		border-left-width: 1px;
		border-top-style: solid;
		border-right-style: none;
		border-bottom-style: solid;
		border-left-style: none;*/
		background: #ececec url('/CFIDE/administrator/images/cap_menuitem_background.png') repeat-x;
	}
	.menuTDHeaderLeft {
		border-left-style:solid;
		border-left-width: 1px;
		border-color: #c4c4c4;
		background: #ececec url('/CFIDE/administrator/images/cap_menuitem_background.png') repeat-x;
	}
	.menuTDHeaderRight {
		border-right-style:solid;
		border-right-width: 1px;
		border-color: #c4c4c4;
		background: #ececec url('/CFIDE/administrator/images/cap_menuitem_background.png') repeat-x;
	}
	
	h1 {
		color: #000000;
		font-weight: bold;
		font-size: x-small;
		margin-top: 5px;
		margin-bottom: 5px;
	}
	
	.pageHeader {
		color: #0072AC;
		font-weight: bold;
		font-size: medium;
		margin-top: 5px;
		margin-bottom: 5px;
	}
	
	.currentuser {
		color: #0072AC;
		font-weight: bold;
		font-size: x-small;
		margin-top: 5px;
		margin-bottom: 5px;
	}
	
	.cellBlueSides {
		border-right-width: 1px;
		border-left-width: 1px;
		border-right-style: solid;
		border-left-style: solid;
		border-right-color: #C1D9DB;
		border-left-color: #C1D9DB;
	}
	
	.cellLeftBlueSide {
		border-left-width: 1px;
		border-left-style: solid;
		border-left-color: #D5E3E6;
	}
	
	.cellRightAndBottomBlueSide {
		border-right-width: 1px;
		border-right-style: solid;
		border-right-color: #D5E3E6;
		border-bottom-width: 1px;
		border-bottom-style: solid;
		border-bottom-color: #D5E3E6;
	}
	
	.cell3BlueSides {
		border-left-width: 1px;
		border-left-style: solid;
		border-left-color: #D5E3E6;
		border-right-width: 1px;
		border-right-style: solid;
		border-right-color: #D5E3E6;
		border-bottom-width: 1px;
		border-bottom-style: solid;
		border-bottom-color: #D5E3E6;
	}
	
	.cell4BlueSides {
		border-top-width: 1px;
		border-top-style: solid;
		border-top-color: #D5E3E6;
		border-left-width: 1px;
		border-left-style: solid;
		border-left-color: #D5E3E6;
		border-right-width: 1px;
		border-right-style: solid;
		border-right-color: #D5E3E6;
		border-bottom-width: 1px;
		border-bottom-style: solid;
		border-bottom-color: #D5E3E6;
	}
	
	.cell2BlueSidesAndBlueBkgd {
		border-top-width: 1px;
		border-top-style: solid;
		border-top-color: #D5E3E6;
		border-bottom-width: 1px;
		border-bottom-style: solid;
		border-bottom-color: #D5E3E6;
		background-color: #E8F0F1;
	}
	
	.cellBlueTop {
		border-top-width: 1px;
		border-top-style: solid;
		border-top-color: #C1D9DB;
	}
	
	.cellBlueBottom {
		border-bottom-width: 1px;
		border-bottom-style: solid;
		border-bottom-color: #C1D9DB;
	}
	
	.cellBlueTopAndBottom {
		border-top-width: 1px;
		border-top-style: solid;
		border-top-color: #C1D9DB;
		border-bottom-width: 1px;
		border-bottom-style: solid;
		border-bottom-color: #C1D9DB;
	}
	
	.cellBordersBlue {
		border: 1px solid #C1D9DB;
	}
	
	.cellGrayBottom {
		border-bottom-width: 1px;
		border-bottom-style: solid;
		border-bottom-color: #E2E6E7;
	}
	
	.copyright {
		color: #000000;
		
			font-size: x-small;
		
	}
	
	.copyrightLink {
		color:#003399; 
		
			font-size: x-small;
		
	}
	
	.disabled {
		color: #999999;
	}
	.color-title		{background-color:888885;color:white;background-color:7A8FA4;}
	.color-header		{background-color:ddddd5;}
	.color-buttons		{background-color:ccccc5;}
	.color-border		{background-color:666666;}
	.color-row			{background-color:fffff5;}
	.color-rowalert		{background-color:ffddaa;}
	.buttn,.buttnText	{font-size:1em;font-family: tahoma,arial,Geneva,Helvetica,sans-serif;background-color:e0e0d5;}

	.switchcontent{display:none;}
</style>
<script type="text/javascript" src="/CFIDE/scripts/cfform.js"></script>
<script type="text/javascript" src="/CFIDE/scripts/masks.js"></script>

<script type="text/javascript" language="javascript">
/***********************************************
* Switch Content script- © Dynamic Drive (www.dynamicdrive.com)
* This notice must stay intact for use
* Visit http://www.dynamicdrive.com/ for full source code
***********************************************/

var enablepersist="on" //Enable saving state of content structure? (on/off)
if (document.getElementById){
document.write('<style type="text/css">')
document.write('.switchcontent{display:none;}')
document.write('</style>')
}
function getElementbyClass(classname){
ccollect=new Array()
var inc=0
var alltags=document.all? document.all : document.getElementsByTagName("*")
for (i=0; i<alltags.length; i++){
if (alltags[i].className==classname)
ccollect[inc++]=alltags[i]
}
}
function contractcontent(omit){
var inc=0
while (ccollect[inc]){
if (ccollect[inc].id!=omit)
ccollect[inc].style.display="none"
inc++
}
}
function expandcontent(cid){
if (typeof ccollect!="undefined"){
contractcontent(cid)
document.getElementById(cid).style.display=(document.getElementById(cid).style.display!="block")? "block" : "none"
selectedItem=cid+"|"+document.getElementById(cid).style.display
}
}
function revivecontent(){
selectedItem=getselectedItem()
selectedComponents=selectedItem.split("|")
contractcontent(selectedComponents[0])
document.getElementById(selectedComponents[0]).style.display=selectedComponents[1]
}
function get_cookie(Name) { 
var search = Name + "="
var returnvalue = "";
if (document.cookie.length > 0) {
offset = document.cookie.indexOf(search)
if (offset != -1) { 
offset += search.length
end = document.cookie.indexOf(";", offset);
if (end == -1) end = document.cookie.length;
returnvalue=unescape(document.cookie.substring(offset, end))
}
}
return returnvalue;
}
function getselectedItem(){
if (get_cookie(window.location.pathname) != ""){
selectedItem=get_cookie(window.location.pathname)
return selectedItem
}
else
return ""
}
function saveswitchstate(){
if (typeof selectedItem!="undefined")
document.cookie=window.location.pathname+"="+selectedItem
}
function do_onload(){
getElementbyClass("switchcontent")
if (enablepersist=="on" && getselectedItem()!="")
revivecontent()
}
if (window.addEventListener)
window.addEventListener("load", do_onload, false)
else if (window.attachEvent)
window.attachEvent("onload", do_onload)
else if (document.getElementById)
window.onload=do_onload
if (enablepersist=="on" && document.getElementById)
window.onunload=saveswitchstate
</script>
<script language="javascript" type="text/javascript">
<!--//
// author: skemcin
// description: create a popup window at a certain size and location with desired functionality
// necessary mods: each yes/no value can be changed to accommodate desired functionality while the height and width integers can be change to determine the size of the window.  The "top" and "eft" integers allow the popup window to be positioned relative to the top-left corner of the client's monitor. Change the "HelpWindow" name ot assign a desired name to the window.
var features="status=no,scrollbars=yes,resizable=yes,menubar=yes,width=385,height=500,top=75,left=75";
    function Info(x){
        //window.name = "HelpWindow";
    var openit = window.open(x, "HelpWindow", features);
    }
//-->
</script>
<link rel="shortcut icon" href="/CFIDE/administrator/favicon.ico" />
