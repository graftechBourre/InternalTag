<%@ Page Language="VB" AutoEventWireup="false" CodeFile="InternalTag2018_modifs.aspx.vb" Inherits="InternalTag" %>
<%@ Register TagPrefix="barcode" Namespace="BarcodeNETWorkShop" Assembly="BarcodeNETImage" %>
<!DOCTYPE>
<html>
    <head id="Head1" runat="server">
        <meta http-equiv=X-UA-Compatible content="IE=11"/>
        <title>TAG</title>      
        <link href="Barcode.css" type="text/css" rel="stylesheet"/>
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

        </style>  
    </head>
    <body style="width:415px;height:360px;">
       <%-- 
           Writing-mode est le seul attribut compatible avec le webBrowser afin d'avoir le SizeCode (Longueur X Diametre) dans le sens de la longueur.
           Chaque asp:label récupère la donnée de la base de données qui lui est attribuée dans l'aspx.vb en fonction de son ID.
           ID ="SizeCode" reçoit la valeur récupérée dans SizeCode.Text = DBInfo("Nominal_Diameter").ToString + " X " + DBInfo("Nominal_Length").ToString du fichier InternalTag2018_modifs.aspx.vb
       --%>
            
            <asp:Label ID="SizeCode" runat="server" Text="XXXXXXXX" 
                       style="transform:scale(-1);float:left;writing-mode: tb-rl ;width:60px;font-weight: 700; font-size: 58px;">
            </asp:Label>
            
            <div class="T1" style="float:left;width:285px;">
                <asp:Label ID="lblessai" runat="server" Text="XXX"  style="visibility:hidden;font-weight:600;text-align:center"></asp:Label> 
                 <div id="divCokeGrade">
                      <asp:Label ID="CokeGrade"  runat="server" Text="XXXX" style="font-weight:600"></asp:Label>
                 </div>
                  
                        <table id="tableInfos">
                                <tr style="vertical-align:top">
                                    <td>
                                        <table id="TableFOGR"style="width:280px">
                                            <tr>
                                               <td style="font-weight: 700; text-align: left">FO NUMBER</td>
                                               <td style="text-align: left; font-weight: 700">GRADE</td>
                                            </tr>
                   
                                            <tr> 
                                               <td style="text-align: left; font-weight: 700; font-size: 25px">
                                                   <asp:Label ID="FONumber" runat="server" Text="XXXXXXXXX"></asp:Label>
                                               </td>
                                               <td style="font-weight: 700; text-align: left; font-size: 25px;">
                                                   <asp:Label ID="Grade" runat="server" Text="XXX"></asp:Label>              
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
                                                    <td id="RUN" style ="font-size:large; font-weight:700">RUN:</td>
                                                    <td style="font-size:large;font-weight:700">
                                                        <asp:Label ID="RunNumber" runat="server" Text="___________________"></asp:Label>
                                                    </td>
                                                    <td style="visibility:hidden;font-size:9px;font-weight:700">
                                                           <asp:Label ID="essai" runat="server" Text="_______________" ></asp:Label>
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
               <asp:Label ID="DatePrinted" runat="server" style="font-size:7px; position:absolute;left:340px;top:340px;font-weight:700"  Text="__/__/__ __:__:__"></asp:Label>
            </div>
  
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ElectrodeConnectionString %>" 
                               SelectCommand="SELECT [GPH_Year],[FO_Number], [PROD_VIEW_ALL].[Nominal_Diameter], [PROD_VIEW_ALL].[Nominal_Length], [Grade], [PROD_VIEW_ALL].[Forming_Lot],
                                                     [PROD_VIEW_ALL].[Coke_Type], [GPH_Year], [PROD_VIEW_ALL].[GPH_Run_Number], [GPH_Special_ID], [GPH_Position], [Lot_Coke_Sub_Lot],[GPH_Furnace_Number]
                                              FROM [PROD_VIEW_ALL] 
                                              INNER JOIN [PROD_Forming_Lot] ON PROD_VIEW_ALL.Forming_Lot = PROD_Forming_Lot.Forming_Lot 
                                              INNER JOIN [PROD_RUN_GPH] ON PROD_VIEW_ALL.GPH_Run_Number = PROD_RUN_GPH.GPH_Run_Number
                                              WHERE ([FO_Number] = @FONumber)
                                              AND GPH_Year= GPH_Run_Year">
                               <SelectParameters>
                                   <asp:QueryStringParameter DefaultValue="J70251080" Name="FONumber" QueryStringField="FONumber" Type="String" />
                               </SelectParameters>
            </asp:SqlDataSource> 
        <script>
            /*      
              Dans ce script, on intègre les fonctions "startsWith" et "endsWith".
            
              La fonction "startsWith" renvoie un booléen (vrai ou faux) indiquant si la chaine de caractères récupérée dans le fichier aspx,
              commence par la chaine de caractères fournie renseignée lors de l'appel de la fonction.
              Ex : On récupère la valeur de "divCokeGrade" qui vaut "CB0B" et on appelle la fonction en lui demandant si la valeur commence par "CB", dans ce cas la fonction retourne "vrai".
            
              La fonction "endsWith" renvoie un booléen (vrai ou faux) indiquant si la chaine de caractères récupérée dans le fichier aspx,
              se termine par la chaine de caractères fournie renseignée lors de l'appel de la fonction.
              Ex : On récupère la valeur de "divCokeGrade" qui vaut "CB0G" et on appelle la fonction en lui demandant si la valeur se termine par "0G", dans ce cas la fonction retourne "vrai".
            */

            if (!String.prototype.startsWith) {
                String.prototype.startsWith = function (search, pos) {
                    return this.substr(!pos || pos < 0 ? 0 : +pos, search.length) === search;
                };
            }


            if (!String.prototype.endsWith) {
                String.prototype.endsWith = function (search, this_len) {
                    if (this_len === undefined || this_len > this.length) {
                        this_len = this.length;
                    }
                    return this.substring(this_len - search.length, this_len) === search;
                };
            }


            /*
              Dans cette partie du script, on détermine tous les cas à gérer (CokeGrade) afin de leur affecter des repères visuels différents.
              Il existe 4 types de cokes : SA et CB qui sont des cokes standards et CM et NP qui sont des cokes premiums.
              Pour différencier les deux, on affecte un fond noir (style.backgroundColor) aux premiums et un fond blanc pour les standards.
              Chacun a un repère visuel différents : CB -> Texte de 105 pixels.
                                                     SA -> Cadre Plein de 10 pixels avec un texte de 99 pixels.
                                                           On ajoute une marge de 10 pixels entre le bloc "FO NUMBER/ GRADE/.../FOUR/POS"(Table 3) et le bloc avec le CokeGrade 
                                                           pour que table 3 ne se superpose pas à la bordure du CokeGrade.
                                                     CM -> Bordure noire sur fond noir de 9 pixels  avec un texte en blanc de 94 pixels.
                                                           Une marge de 10 pixels est ajoutée entre le CokeGrade et le bloc d'éléments en-dessous. 
                                                     NP -> Bordure en pointillés blancs (points/dotted) sur fond noir de 13 pixels avec un texte en blanc de 96 pixels.
                                                           Une marge de 10 pixels est ajoutée entre le CokeGrade et le bloc d'éléments en-dessous.
            */
            
            var cokeGrade = document.getElementById("CokeGrade");
            var tableInfos = document.getElementById("tableInfos");
            var sizeCode = document.getElementById("SizeCode");
            var grade = document.getElementById("Grade");
            var lblEssai = document.getElementById("lblessai");
            var runNumber = document.getElementById("RunNumber");

            if (cokeGrade.innerText.startsWith("CB")) {
                cokeGrade.style.fontSize = "105px"
            }

            if (cokeGrade.innerText.startsWith("SA")) {
                cokeGrade.style.border = "10px solid black"
                cokeGrade.style.fontSize = "99px"
                tableInfos.style.marginTop = "10px"
            }

            if (cokeGrade.innerText.startsWith("CM")) {
                cokeGrade.style.border = "9px solid black"
                cokeGrade.style.backgroundColor = "black"
                cokeGrade.style.color = "white"
                cokeGrade.style.fontSize = "94px"
                tableInfos.style.marginTop = "10px"
            }

            if (cokeGrade.innerText.startsWith("NP")) {
                cokeGrade.style.border = "13px dotted white"
                cokeGrade.style.backgroundColor = "black"
                cokeGrade.style.color = "white"
                cokeGrade.style.fontSize = "96px"
                tableInfos.style.marginTop = "10px"
            }


            /* 
              Dans cette partie du script, on utilise la fonction "endsWith" afin de vérifier si c'est une longueur spéciale ou non (finissant par 50 ou égal à 3000).
              Si c'est une longueur spéciale, alors on affiche un texte blanc sur fond noir pour le SizeCode avec une marge  de 2 pixels par rapport au bloc à gauche pour le cokeGrade,
              afin de ne pas confondre les 2 blocs.
            */
            if (sizeCode.innerText.endsWith("50") || sizeCode.innerText.endsWith("3000")) {
                sizeCode.style.backgroundColor = "black"
                sizeCode.style.color = "white"
                cokeGrade.style.marginLeft = "2px"
            }


            /*  
              Ici, on réutilise la fonction "startsWith" pour gérer les grades spéciaux "JOX", "TZGX", "ZGZ", "AGZ", "AGH", "AGU".
              Les || correspondent à "OU" donc si le grade correspond à "JOX" OU "TGZX" OU ...
            */
            if (grade.innerText.startsWith("JOX") || grade.innerText.startsWith("TZGX") || grade.innerText.startsWith("ZGZ")
                || grade.innerText.startsWith("AGZ") || grade.innerText.startsWith("AGH") || grade.innerText.startsWith("AGU"))
            {
                grade.style.backgroundColor = "black"
                grade.style.color = "white"
            }


            /*
              Si le Grade vaut "AGU", le SpecialID vaut 90 ou le cokeGrade commence par "IU" alors la barre est une barre à usage interne (Internal Use).
              Dans ce cas, on masque le code barre pour éviter qu'elle soit usinée puis expediée. Le cokeGrade a une taille de 114 pixels.
            */
            if (grade.innerText.startsWith("AGU") || document.getElementById("SpecialID").innerText.startsWith(90) || cokeGrade.innerText.startsWith("IU")) {
                document.getElementById("imgBarcode").style.visibility = "hidden"
                cokeGrade.style.fontSize = "114px"
            }

            /*
              Chaque cokeGrade à ses spécificités sur l'étiquette, que ce soit sa taille, le style de bordure ou encore la police d'écriture.
            
                CB0G -> Les dimensions sont en italique / gras / taille des caractères = 64 pixels / Police = Lucida sans-serif.
                        Le cokeGrade est en italique / gras / taille des caractères = 103 pixels / Police = Lucida sans-serif.
                        Le cokeGrade à une bordure en pointillés de 9 pixels avec les bords arrondis à partir d'un rayon de 60 pixels.
                        Une marge de 10 pixels est ajoutée entre le cokeGrade et le bloc d'éléments en-dessous.
                        
                CB0J -> Les dimensions sont en italique / gras / taille des caractères = 64 pixels / Police = Lucida sans-serif.
                        Le cokeGrade est en italique / gras / taille des caractères = 113 pixels / Police = Lucida sans-serif.
            */
            if (grade.innerText.startsWith("ZGZ") && cokeGrade.innerText.startsWith("CB0G")) {
                sizeCode.style.font = "italic bold  64px Lucida sans-serif"
                cokeGrade.style.font = "italic bold  103px Lucida sans-serif"
                cokeGrade.style.border = "9px dashed black"
                cokeGrade.style.borderRadius = "60px"
                tableInfos.style.marginTop = "10px"
            }

            if (grade.innerText.startsWith("JOX") && cokeGrade.innerText.startsWith("CB0J")) {
                sizeCode.style.font = "italic bold  64px Lucida sans-serif"
                cokeGrade.style.font = "italic bold  113px Lucida sans-serif"
            }


            /*
                 SA0G -> Les dimensions sont en italique / gras / taille des caractères = 64 pixels / Police = Lucida sans-serif.
                         Le CokeGrade est en italique / gras / taille des caractères = 108 pixels / Police = Lucida sans-serif.
                         Le CokeGrade à un cadre plein de 9 pixels avec les bords arrondis à partir d'un rayon de 60 pixels. 
                        
                 SA0Z -> Les dimensions sont en italique / gras / taille des caractères = 64 pixels / Police = Lucida sans-serif.
                         Le CokeGrade est en italique / gras / taille des caractères = 112 pixels / Police = Lucida sans-serif.
                         Le CokeGrade à une bordure noire de 9 pixels avec les bords arrondis à partir d'un rayon de 60 pixels.
            
                 SA0W -> Les dimensions sont en italique / gras / taille des caractères = 64 pixels / Police = Lucida sans-serif.
                         Le CokeGrade est en italique / gras / taille des caractères = 100 pixels / Police = Lucida sans-serif.
            
                 SA0J -> Les dimensions sont en italique / gras / taille des caractères = 64 pixels / Police = Lucida sans-serif.
                         Le CokeGrade est en italique / gras / taille des caractères = 113 pixels / Police = Lucida sans-serif.
                         Une marge de 10 pixels est ajoutée par rapport à la gauche du CokeGrade pour aligner le CokeGrade au centre.
            */
            if ((grade.innerText.startsWith("ZGZ") && cokeGrade.innerText.startsWith("SA0G"))) {
                sizeCode.style.font = "italic bold  64px Lucida sans-serif"
                cokeGrade.style.font = "italic bold  108px Lucida sans-serif"
                cokeGrade.style.border = "9px solid black"
                cokeGrade.style.borderRadius = "60px"
            }

            if (grade.innerText.startsWith("AGZ") && cokeGrade.innerText.startsWith("SA0Z")) {
                sizeCode.style.font = "italic bold  64px Lucida sans-serif"
                cokeGrade.style.font = "italic bold  112px Lucida sans-serif"
                cokeGrade.style.border = "9px solid black"
                cokeGrade.style.borderRadius = "60px"
            }

            if (grade.innerText.startsWith("AGH") && cokeGrade.innerText.startsWith("SA0W")) {
                sizeCode.style.font = "italic bold  64px Lucida sans-serif"
                cokeGrade.style.font = "italic bold  100px Lucida sans-serif"
            }

            if (grade.innerText.startsWith("JOX") && cokeGrade.innerText.startsWith("SA0J")) {
                sizeCode.style.font = "italic bold  64px Lucida sans-serif"
                cokeGrade.style.font = "italic bold  113px Lucida sans-serif"
                cokeGrade.style.marginLeft = "10px"
            }


            /*
                 
                 CM05 -> Les dimensions sont en italique / gras / taille des caractères = 64 pixels / Police = Lucida sans-serif.
                         Le CokeGrade est en italique / gras / taille des caractères = 103 pixels / Police = Lucida sans-serif.
            
                 CM0X -> Le CokeGrade a une taille de 96 pixels.
            */

            if (grade.innerText.startsWith("TZGX") && cokeGrade.innerText.startsWith("CM05")) {
                sizeCode.style.font = "italic bold  64px Lucida sans-serif"
                cokeGrade.style.font = "italic bold  103px Lucida sans-serif"
            }

            if (grade.innerText.startsWith("AGX") && cokeGrade.innerText.startsWith("CM0X")) {
                cokeGrade.style.fontSize = "96px"
            }


            /*
              Ici, on regarde si le 3ème digit du lot = 9. Si c'est le cas, c'est un lot d'essai.
              L'élément "lot" récupère uniquement le 3ème digit du lot de la base de données.
              Dans le cas où c'est un lot d'essai : - On met un cadre noir de 9 pixels pour les bordures haut/bas et 11 pixels pour gauche/droite afin de le démarquer.
                                                    - On crée le cadre avec une hauteur de 340 pixels.
                                                    - Le run est mis en blanc sur fond noir afin de montrer que c'est un essai.
                                                    - On replace la date à 339 pixels du haut et 345 pixels par rapport au bord gauche.
                                                    - On rend visible l'élément "essai" afin d'afficher "/ESSAI" à droite du run.
                                                    - "Essai" est encadré d'une bordure noire de 4 pixels.
                                                    - On rend visible l'élément "lblessai" afin d'afficher "ESSAI"en grand(48 pixels) au-dessus de la nuance/du cokeGrade, 
                                                      avec un décalage de 70 pixels par rapport au SizeCode pour centrer l'élément.
                                                    - Pour gagner de la place, on met les valeurs de FONumber et Grade à 20 pixels.
                                                    - Encore pour gagner de la place, on met l'intitulé et la valeur de Run, RunNumber,FurnaceNumber et de Four en "medium".
            
              Ensuite, on gère les cas particuliers un par un:
                    
                    CM -> La taille du CokeGrade est mise à 94 pixels et il y a une marge de 5 pixels entre le CokeGrade et le bloc en-dessous.
                        CM05 -> "ESSAI" au-dessus de la nuance est mis à 45 pixels pour faire remonter le bloc afin qu'il ne soit pas en conflit avec le cadre autour de l'étiquette.
                                Une marge de 20 pixels est mise entre le CokeGrade et le SizeCode à gauche afin que le CokeGrade soit centré.
            
                    CB -> 
                        CB0B -> La taille de CB0B est de 99 pixels.
                        CB0G -> La taille de CB0G est de 99 pixels et une marge de 2 pixels est ajoutée entre CB0G et le bloc du dessous.
                        CB0J -> La taille de CB0J est de 105 pixels et celle de "ESSAI" est réduite à 44 pixels.
            
                    SA -> La taille de "ESSAI" est à 43 pixels. Il y a une marge de 1 pixel entre "ESSAI" et le CokeGrade pour éviter que les 2 soient collés.
                          Il y a une marge de 7 pixels entre le CokeGrade et le bloc du dessous.
                        SA0Z -> La taille de SA0Z est de 106 pixels et le texte est centré dans la div. La taille de "ESSAI" est à 41 pixels.
                                Il y a une marge de 10 pixels entre le CokeGrade et le bloc de gauche(SizeCode).
            
                        SA0J -> La taille de SA0Z est de 107 pixels. La taille de "ESSAI" est à 40 pixels.
            
                    NP -> La taille de la nuance est de 93 pixels. La taille de "ESSAI" est à 44 pixels.
                          Il y a une marge de 3 pixels entre le CokeGrade et le bloc du dessous.
            
            
              Par défaut, l'élément "lot" est caché car il n'a pas besoin d'apparaître sur l'étiquette.
            */
            if (document.getElementById("lot").innerText.startsWith("9")) {
                document.body.style.border = "solid black"
                document.body.style.borderWidth = "9px 11px"
                document.body.style.height = "340px"
                runNumber.style.backgroundColor = "black"
                runNumber.style.color = "white"
                document.getElementById("DatePrinted").style.top = "339px"
                document.getElementById("DatePrinted").style.left = "345px"
                document.getElementById("essai").style.visibility = "visible"
                document.getElementById("essai").style.border = "4px solid black"
                lblEssai.style.visibility = "visible"
                lblEssai.style.fontSize = "48px"
                lblEssai.style.marginLeft = "70px"
                document.getElementById("FONumber").style.fontSize = "20px"
                grade.style.fontSize = "20px"
                document.getElementById("RUN").style.fontSize = "medium"
                runNumber.style.fontSize = "medium"
                document.getElementById("FOUR").style.fontSize = "medium"
                document.getElementById("FurnaceNumber").style.fontSize = "medium"

                if (cokeGrade.innerText.startsWith("CM")) {
                    cokeGrade.style.fontSize = "94px"
                    tableInfos.style.marginTop = "5px"

                    if (grade.innerText.startsWith("TZGX")) {
                        lblEssai.style.fontSize = "45px"
                        cokeGrade.style.marginLeft = "20px"
                    }

                }

                if (cokeGrade.innerText.startsWith("CB")) {

                    if (grade.innerText.startsWith("ZGX")) {
                        cokeGrade.style.fontSize = "99px"
                    }

                    if (grade.innerText.startsWith("ZGZ")) {
                        cokeGrade.style.fontSize = "99px"
                        tableInfos.style.marginTop = "2px"
                    }

                    if (grade.innerText.startsWith("JOX")) {
                        cokeGrade.style.fontSize = "105px"
                        lblEssai.style.fontSize = "44px"
                    }

                }

                if (cokeGrade.innerText.startsWith("SA")) {
                    lblEssai.style.fontSize = "43px"
                    tableInfos.style.marginTop = "7px"
                    document.getElementById("divCokeGrade").style.marginTop = "1px"

                    if (grade.innerText.startsWith("AGZ")) {
                        cokeGrade.style.fontSize = "106px"
                        cokeGrade.style.marginLeft = "10px"
                        lblEssai.style.fontSize = "41px"
                    }

                    if (grade.innerText.startsWith("JOX")) {
                        cokeGrade.style.fontSize = "107px"
                        lblEssai.style.fontSize = "40px"
                    }
                }

                if (cokeGrade.innerText.startsWith("NP")) {
                    document.getElementById("divCokeGrade").style.marginTop = "3px"
                    lblEssai.style.fontSize = "44px"
                    cokeGrade.style.fontSize = "93px"
                }
            }
            document.getElementById("lot").style.visibility = "hidden"

            </script>
    </body>
</html>