<%@ page language="java" contentType="text/html" %>
<%@ page import="org.example.cayenne.persistent.*" %>
<%@ page import="org.apache.cayenne.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

<% 
    ObjectContext context = BaseContext.getThreadObjectContext();
    String id = request.getParameter("id");

    // find artist for id
    Artist artist = null;
    if(id != null && id.trim().length() > 0) {
        artist = DataObjectUtils.objectForPK(context, Artist.class, Integer.parseInt(id));
    }

    if("POST".equals(request.getMethod())) {
        // if no id is saved in the hidden field, we are dealing with
        // create new artist request
        if(artist == null) {
            artist = context.newObject(Artist.class);
        }

        // note that in a real application we would so dome validation ...
        // here we just hope the input is correct
        artist.setName(request.getParameter("name"));
        artist.setDateOfBirthString(request.getParameter("dateOfBirth"));

        context.commitChanges();

        response.sendRedirect("index.jsp");
    }

    if(artist == null) {
        // create transient artist for the form response rendering
        artist = new Artist();
    }

    String name = artist.getName() == null ? "" : artist.getName();
    String dob = artist.getDateOfBirth() == null
            ? "" : new SimpleDateFormat("yyyyMMdd").format(artist.getDateOfBirth());
%>
<html>
    <head>
        <title>Artist Details</title>
    </head>
    <body>
        <h2>Artists Details</h2>
        <form name="EditArtist" action="detail.jsp" method="POST">
            <input type="hidden" name="id" value="<%= id != null ? id : "" %>" />
            <table border="0">
                <tr>
                    <td>Name:</td>
                    <td><input type="text" name="name" value="<%= name %>"/></td>
                </tr>
                <tr>
                    <td>Date of Birth (yyyyMMdd):</td>
                    <td><input type="text" name="dateOfBirth" value="<%= dob %>"/></td>
                </tr>
                <tr>
                    <td></td>
                    <td align="right"><input type="submit" value="Save" /></td>
                </tr>  
            </table>
        </form>
    </body>	
</html>