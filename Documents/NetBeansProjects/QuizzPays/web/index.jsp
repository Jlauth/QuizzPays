<%! 
// déclarations globales à la page
org.oorsprong.websamples.CountryInfoService service;
org.oorsprong.websamples.CountryInfoServiceSoapType port;
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Quizz des Pays</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <%
        // invocation du Web Service
        try {
            service = new org.oorsprong.websamples.CountryInfoService();
            port = service.getCountryInfoServiceSoap();
        %>
        <div>
            <h1>Quizz des Pays</h1>
            <hr />
            <%  
            String rang = request.getParameter("txtRang");
            if (rang != null) {
                int rangPays = Integer.parseInt(rang);
                String capitaleSaisie = request.getParameter("txtCapitale");
                String monnaieSaisie = request.getParameter("txtMonnaie");
                // récupération des connades réponses
                String codePays = port.listOfCountryNamesByName().getTCountryCodeAndName().get(rangPays).getSISOCode();
                String capitale = port.capitalCity(codePays);
                String monnaie = port.countryCurrency(codePays).getSName();
                if (capitaleSaisie.equals(capitale) && monnaieSaisie.equals(monnaie)) {
                    out.println("Bravo !!!");
                } else {
                    out.println("Presque !");
                    out.println(capitale+" et "+monnaie);
                }
            }
            %>
            <hr />
            <form action="index.jsp" method="POST">
                <table>         
                    <tr>
                        <td>Pays : </td>
                        <td>    
                            <%-- start web service invocation --%>
                            <%
                                    org.oorsprong.websamples.ArrayOftCountryCodeAndName result = port.listOfCountryNamesByName();
                                    // nombre de pays
                                    int nbPays = result.getTCountryCodeAndName().size();
                                    // génération d'un nombre aléatoire pour récupérer un pays
                                    int k = (int)(Math.random()*nbPays);
                                    // affichage aléatoire d'un pays
                                    out.println(result.getTCountryCodeAndName().get(k).getSName());
                                    // rang du pays en champ caché pour le récupérer 
                                    out.println("<input type='hidden' name='txtRang' value='"+k+"' />");

                            %>
                            <%-- end web service invocation --%>
                        </td>
                    </tr>
                    <tr>
                        <td>Capitale : </td>
                        <td><input type="text" name="txtCapitale" value="" size="30"/></td>
                    </tr>
                    <tr>
                        <td>Monnaie : </td>
                        <td><input type="text" name="txtMonnaie" value="" size="30"/></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td><input type="submit" value="Tester" /></td>
                    </tr>
                </table>
            </form>
        </div>
    <% 
    } catch (Exception ex) {
        out.println("Accès au Web Service indisponible");
    }
    %>
    </body>
</html>

