<%@page import="com.ibm.assets.common.AppConstants"%>
<%@ page import="com.ibm.assets.common.SessionConstants.SM_CONST" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!doctype html>
<html>
<head>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>Asset Tool - Logging You In... Please wait...</title>
    <jsp:include page="/WEB-INF/jsp/templates/global_include.jsp" />
    <style>
        .errors {
            background-color:#FFCCCC;
            border:1px solid #CC0000;
            margin-bottom:8px;
            position: relative;
            left: 10px;
            width: 99%;
        }
        .errors li{
            list-style: none;
        }
    </style>
    

</head>
<body style="height: 100% !important;">
<s:if test="%{hasActionErrors()}">
    <div class="errors">
        <s:actionerror/>
    </div>
</s:if>
    <%!
        protected String normalize(String value)
        {
            if(value == null) { return ""; }
            StringBuffer sb = new StringBuffer();
            for (int i = 0; i < value.length(); i++) {
                char c = value.charAt(i);
                sb.append(c);
                if (c == ';')
                    sb.append("<br>");
            }
            return sb.toString();
        }
    %>
    <%

        String sm_user = normalize(request.getHeader("SM_USER"));
        String sm_userdn = normalize(request.getHeader("SM_USERDN"));
        String company = normalize(request.getHeader("company"));
        String country = normalize(request.getHeader("country"));
        String email = normalize(request.getHeader("email"));
        String firstname = normalize(request.getHeader("firstname"));
        String lastname = normalize(request.getHeader("lastname"));

        session.setAttribute(SM_CONST.SM_USER.name(), sm_user);
        session.setAttribute(SM_CONST.SM_USERDN.name(), sm_userdn);
        session.setAttribute(SM_CONST.SM_COMPANY.name(), company);
        session.setAttribute(SM_CONST.SM_COUNTRY.name(), country);
        session.setAttribute(SM_CONST.SM_EMAIL.name(), email);
        session.setAttribute(SM_CONST.SM_FNAME.name(), firstname);
        session.setAttribute(SM_CONST.SM_LNAME.name(), lastname);

    %>
	<%
		if(AppConstants.IS_DEV)
		{
			%>
				<form action="login" name="frmLogin" id="frmLogin" method="post">
				    <s:hidden name="targetURL" id="targetURL"></s:hidden>
				    <table>
				        <tr>
				            <td>Username</td>
				            <td><s:textfield name="username" id="username" value="CT503558"></s:textfield></td>
				        </tr>
				        <tr>
				            <td>Password</td>
				            <td><s:password name="password" id="password" value="password"></s:password></td>
				        </tr>
				        <tr>
				            <td colspan="2">
				                <input type="submit" value="Login">
				            </td>
				        </tr>
				    </table>
				</form>
			<%
		}
		else
		{
			%>
				<div id="dialog-form" title="Checking user.. & Logging In..">
			        <div id="firstMsg">
			            <div style="text-align: center;">
			                <img src="images/ajax_loader_128_128.gif" height="32px" width="32px" />
			            </div>
			            Checking user access to Asset Tool. Please wait.. If you are not authorized to access this tool, an error will
			            be shown saying so.
			        </div>
			        <div id="responseMsg" style="display:none;" class="errors"></div>
			    </div>
			    <form id="frmLogin" action="<%=AppConstants.APP_CTX%>siteminderLogin"></form>
			
			    <script type="text/javascript">
			        $( "#dialog-form" ).dialog({
			            autoOpen: true,
			            height: "auto",
			            width: "400",
			            modal: true,
			            my: "center",
			            at: "center",
			            of: window
			        });
			        
			        $(document).ready(function () {
			        	$("#frmLogin").submit();
			        });
			    </script>	
			<%
		}
	%>
</body>
</html>