<%@ Page Language="VB" AutoEventWireup="false" CodeFile="InternalTag2022.aspx.vb" Inherits="InternalTag" %>
<%@ Register TagPrefix="barcode" Namespace="BarcodeNETWorkShop" Assembly="BarcodeNETImage" %>
<!DOCTYPE>
<html>
    <head id="Head1" runat="server">
        <meta http-equiv=X-UA-Compatible content="IE=11"/>
        <title>TAG version 2022</title>      
        <link id="linkCSS_Coke" href="" type="text/css" rel="stylesheet"/>
        <link id="linkCSS_Longueur" href="./css/Longueur/normal.css" type="text/css" rel="stylesheet"/>
        <link id="linkCSS_Grade" href="" type="text/css" rel="stylesheet"/>
        <link id="linkCSS_Essaies" href="" type="text/css" rel="stylesheet"/>
        <asp:Placeholder ID="headPlaceholder" runat="server" />
        <style type="text/css">
            .style1
             {
                font-size:small;
                font-weight:bolder;
             }
             img
             { 
                width:70px;
                max-height:340px;
             }
             
             body{
                margin:0px;
                background-image: none;
                font-family: Arial, Helvetica, sans-serif;
             }
         </style> 
    </head>
    <body style="width:415px;height:360px;">

        <asp:Label class="SizeCode" ID="SizeCode" runat="server" Text="XXXXXXXX"></asp:Label>

        

        <div class="T1" style="float:left;width:285px;">
        <asp:Label class="lblEssai" ID="lblessai" runat="server" Text="XXX"  style="visibility:hidden;font-weight:600;text-align:center"></asp:Label> 
        <div >
            <asp:Label class="divCokeGrade" ID="CokeGrade"  runat="server" Text="XXXX" style="font-weight:600" ></asp:Label>
        </div>
        
                <table id="tableInfos" style="margin-top: 10px;">
                        <tr style="vertical-align:top">
                            <td>
                                <table id="TableFOGR"style="width:280px">
                                    <tr>
                                    <td style="font-weight: 700; text-align: left">FO NUMBER</td>
                                    <td style="text-align: left; font-weight: 700">GRADE</td>
                                    </tr>
        
                                    <tr> 
                                    <td style="text-align: left; font-weight: 700; font-size: 25px">
                                        <asp:Label class="FONumber" ID="FONumber" runat="server" Text="XXXXXXXXX"></asp:Label>
                                    </td>
                                    <td style="font-weight: 700; text-align: left; font-size: 25px;">
                                        <asp:Label class="grade" ID="Grade" runat="server" Text="XXX"></asp:Label>              
                                    </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>

                        <tr style="vertical-align:top">
                        <td>
                                <table>
                                        <tr>
                                            <td class="style1">PROCESS:</td><td class="style1">
                                                <asp:Label ID="Process" runat="server" Text="___________________"></asp:Label>    
                                            </td>
                                            <td>
                                                <asp:Label ID="lot" runat="server" Text="_______________"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="style1" style ="width:80px">SPECIAL ID:</td>
                                            <td class="style1">
                                                <asp:Label ID="SpecialID" runat="server" Text="___________________"></asp:Label>
                                            </td>

                                        </tr>
                                        <tr>
                                            <td class="RUN" style ="font-size:large; font-weight:700">RUN:</td>
                                            <td style="font-size:large;font-weight:700">
                                                <asp:Label class="RunNumber" ID="RunNumber" runat="server" Text="___________________"></asp:Label>
                                            </td>
                                            <td style="visibility:hidden;font-size:9px;font-weight:700">
                                                <asp:Label class="essai" ID="essai" runat="server" Text="_______________" ></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td id="FOUR" style="font-size:large;font-weight:700">FOUR:</td><td style="font-size:large;font-weight:700">
                                                <asp:Label ID="FurnaceNumber" runat="server" Text="___________________"></asp:Label>
                                            </td>
                                            <td style="font-size:medium;font-weight:700">POS:</td><td class="style1" style="font-size:medium;font-weight:700"  >
                                                <asp:Label ID="Position" runat="server" Text="___________________"></asp:Label>
                                            </td>
                                        </tr>
                                        <table>
                                            <tr>
                                                <td style="font-size:medium;font-weight:700;padding-right: 3cm;">FO:</td>  
                                                <td style="font-size:medium;font-weight:700">PL:</td>
                                            </tr>
                                        </table>                                            
                                </table>
                        </td>
                        </tr>
                </table>

            
        </div>      
            <div class="T2" style="float:left;"> 
              <%--
                  Ici, on gère le code barre, son style d'affichage, la taille des barres, ...
                  Ensuite on établit la source de données et la requête que l'on va utiliser pour afficher et récupérer les données des barres.
                  On utilise différentes tables (PROD_VIEW_ALL,PROD_Forming_Lot,PROD_RUN_GPH) pour récupérer les données nécessaires.
              --%>          
               <barcode:barcodenetimage id="imgBarcode" runat="server"   BarcodeType="EAN128B" BarWidth="3" RotateAngle="R270">
               </barcode:barcodenetimage>
               <asp:Label class="DatePrinted" ID="DatePrinted" runat="server" style="font-size:7px; position:absolute;left:340px;top:340px;font-weight:700"  Text="__/__/__ __:__:__"></asp:Label>
            </div>
  
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ElectrodeConnectionString %>" 
                               SelectCommand="SELECT [GPH_Year],[FO_Number], [PROD_VIEW_ALL].[Nominal_Diameter], [PROD_VIEW_ALL].[Nominal_Length], [Grade], [PROD_VIEW_ALL].[Forming_Lot],
                                                     [PROD_VIEW_ALL].[Coke_Type], [GPH_Year], [PROD_VIEW_ALL].[GPH_Run_Number], [GPH_Special_ID], [GPH_Position], [Lot_Coke_Sub_Lot],[GPH_Furnace_Number]
                                              FROM [PROD_VIEW_ALL] 
                                              INNER JOIN [PROD_Forming_Lot] ON PROD_VIEW_ALL.Forming_Lot = PROD_Forming_Lot.Forming_Lot 
                                              INNER JOIN [PROD_RUN_GPH] ON PROD_VIEW_ALL.GPH_Run_Number = PROD_RUN_GPH.GPH_Run_Number
                                              WHERE ([FO_Number] = @FONumber)">
                               <SelectParameters>
                                   <asp:QueryStringParameter DefaultValue="J70251080" Name="FONumber" QueryStringField="FONumber" Type="String" />
                               </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource1_2" runat="server" ConnectionString="<%$ ConnectionStrings:ElectrodeConnectionString %>" 
                               SelectCommand="SELECT pei.Etiquette_id, pei.Zone ,pei.Type, pei.Fichier , pall.Coke_Type , pall.Nominal_Length
                                                FROM PROD_Etiquette_Id as pei 
                                                INNER JOIN PROD_VIEW_ALL AS pall ON pall.FO_Number = @FONumber">
                                <SelectParameters>
                                    <asp:QueryStringParameter DefaultValue="J70251080" Name="FONumber" QueryStringField="FONumber" Type="String" />
                                </SelectParameters>
            </asp:SqlDataSource> 
            <asp:Label ID="test" runat="server" Text="___________________"></asp:Label>
    </body>
</html>