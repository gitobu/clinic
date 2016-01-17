<%-- 
    Document   : savedrugform
    Created on : Jan 15, 2016, 7:55:06 PM
    Author     : Gitobu
--%>

<jsp:directive.include file="sqllink.jsp"/>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Kenya Clinic: Drug Form</title>
        <link href="styleOne.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript">
    function validateFormValues(){
	
	
        if (document.drugform.drug_form.value === ""){
		alert('Please enter a drug form');
		return false;}      
			else
		{
			return true;
		}
    }
    </script>
    
    </head>
    <body>
  <div id="header">
       <jsp:directive.include file="header.html"/>
        </div>
        
              <div id="nav">
                 <jsp:directive.include file="menubar.jsp"/>
</div>   
<div id="section">
      <c:set var="edit_mode" value="${not empty param.drug_form_id}"></c:set>   
      <c:set var="new_mode" value="${ empty param.drug_form_id}"></c:set> 
      
    <c:choose>
        <c:when test='${edit_mode}'>

            <c:set var="drug_form_id" value = "<%= request.getParameter("drug_form_id")%>"/>        
            <c:set var="drug_form" value="<%= request.getParameter("drug_form")%>" />

            <sql:update dataSource="${snapshot}" var="result">
            update drug_form set drug_form = '${drug_form}'
            where drug_form_id = ${drug_form_id}
            </sql:update>  

        </c:when>
        <c:when test='${new_mode}'>
            <sql:query dataSource="${snapshot}" var="df">
            select CONCAT('DF', max(substr(drug_form_no,3,5)) + 1) as df_no 
            FROM drug_form
            </sql:query>

            <c:forEach var="row" items="${df.rows}">
                <c:set var="df_no" value = "${row.df_no}" />
            </c:forEach>   


            <c:set var="drug_form" value="<%= request.getParameter("drug_form")%>" />

            <sql:update dataSource="${snapshot}" var="result">
            insert into drug_form (drug_form_no, drug_form)
            values ('${df_no}', '${drug_form}')
            </sql:update>        

        </c:when>
    </c:choose>
    
    
    
    
    <sql:query dataSource="${snapshot}" var="df_list">
        SELECT df.drug_form_id, df.drug_form_no, df.drug_form
        FROM drug_form df 
        ORDER BY drug_form
        </sql:query>
        
   <form name="drugform" action="savedrugform.jsp" method="POST">
         <table border="0" cellpadding="10" align="center">  
             <caption>
                 <h2>New Drug Form</h2>
            </caption>
             
       
                  
          
             <tr><th align="left">Job Title</th><td><input type="text" name="drug_form" ></td> </tr>
           
             <tr><th></th><td><input type="submit" value="Submit" onclick="return validateFormValues()"/></td> </tr>
            </table>
            </form>
         <table border="1" cellpadding="10" align="center" >
         <caption><h2>Drug Form</h2></caption>
         <tr>
            <th>Drug Form Number</th>
            <th>Drug Form</th>
            <th>Edit</th>

         </tr>
         <c:forEach var="row" items="${df_list.rows}">
         <tr>
            <td><c:out value="${row.drug_form_no}"/></td>
            <td><c:out value="${row.drug_form}"/></td>
            <td><a href="<c:url value="drugForm.jsp?drug_form_id=${row.drug_form_id}"/>">Edit</a></td>
         </tr>
         </c:forEach>
         </table>
    </div>
      <div id="footer">
            
        
       <jsp:directive.include file="footer.html"/>
      
        </div>
    </body>
</html>



