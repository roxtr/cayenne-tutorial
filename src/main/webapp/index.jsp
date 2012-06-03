<%@ page language="java" contentType="text/html" %>
<%@ page import="org.example.cayenne.persistent.*" %>
<%@ page import="org.apache.cayenne.*" %>
<%@ page import="org.apache.cayenne.query.*" %>
<%@ page import="org.apache.cayenne.exp.*" %>
<%@ page import="java.util.*" %>

<% 
    SelectQuery query = new SelectQuery(Artist.class);
    query.addOrdering(Artist.NAME_PROPERTY, SortOrder.ASCENDING);

    ObjectContext context = BaseContext.getThreadObjectContext();
    List<Artist> artists = context.performQuery(query);
%>
<html>
    <head>
        <title>Main</title>
    </head>
    <body>
        <h2>Artists:</h2>
        
        <% if(artists.isEmpty()) {%>
        <p>No artists found</p>
        <% } else { 
            for(Artist a : artists) {
        %>
        <p><a href="detail.jsp?id=<%=DataObjectUtils.intPKForObject(a)%>"> <%=a.getName()%> </a></p>
        <%
            }
            } %>
        <hr>
        <p><a href="detail.jsp">Create new artist...</a></p>
    </body>	
</html>