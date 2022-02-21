Imports System.Data

Partial Class InternalTag
    Inherits System.Web.UI.Page



    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim heure As Integer
        Dim tmp As String
        'Condition exécutant le code uniquement si la page est ouverte pour la première fois.
        If IsPostBack = False Then
            'Pour chaque information présente dans la source de données "SqlDataSource1", on va assigner une valeur de la source à un élément de l'affichage web
            For Each DBInfo As DataRowView In SqlDataSource1.Select(New Web.UI.DataSourceSelectArguments())
                'Chacune des lignes suivantes est formée de la façon suivante : champ.Text = valeur
                'Le "champ" est associé à un asp:label du fichier du même nom ayant pour extension aspx. (Ici : InternalTag2018_modifs.aspx)
                'Il faut que la valeur de "champ" ait le même nom que l'ID de asp:label afin que l'affichage web récupère la valeur dans l'autre fichier
                FONumber.Text = DBInfo("FO_Number")
                'On ajoute .ToString à la valeur récupérée afin d'avoir les valeurs sous forme de chaînes de caractère et ainsi concaténer les valeurs.
                SizeCode.Text = DBInfo("Nominal_Diameter").ToString + " X " + DBInfo("Nominal_Length").ToString
                Grade.Text = DBInfo("Grade")
                imgBarcode.BarcodeText = DBInfo("FO_Number")

                FurnaceNumber.Text = DBInfo("GPH_Furnace_Number")
                'Le try/catch sert à effectuer un test sur l'existence ou non de la valeur. Si la valeur n'existe pas alors il y aura une erreur
                Try
                    SpecialID.Text = DBInfo("GPH_Special_ID")
                Catch ex As Exception

                End Try

                Process.Text = "GRAPHITIZING"
                'Substring(2,1) permet de récupérer le caractère en troisième position du Forming_Lot (indice commence à 0) et seulement 1 caractère.
                'Exemple : Forming_Lot = J90111 -> J = 0 , 9 = 1, 0 = 2,... Donc substring(2,1) récupère 0.
                lot.Text = DBInfo("Forming_Lot").substring(2, 1)
                CokeGrade.Text = DBInfo("Lot_Coke_Sub_Lot")
                'Ici, on affecte directement les valeurs, on ne passe pas par la base de données car ce sont des textes particuliers.
                essai.Text = "/ ESSAI"
                lblessai.Text = "ESSAI"
                Try
                    'RunNumber.Text = "J" + (90000 + DBInfo("GPH_Run_Number")).ToString

                    ' On recupere le dernier chiffre à droite de l'annee de graphitation, on le multiplie par 10000 pour ajouter la valeur du run
                    ' La fonction format gère le cas où il y a des 0 non significatifs en début de numéro de run  (ex :2010, on récupère 0 et tous les 0 à gauche sont supprimés)
                    RunNumber.Text = "J" + Format(Right(DBInfo("GPH_Year"), 1) * 10000 + DBInfo("GPH_Run_Number"), "00000").ToString
                Catch ex As Exception
                End Try

                Try
                    Position.Text = DBInfo("GPH_Position")
                Catch ex As Exception
                End Try

                ' FORMAT DE LA DATE
                'Now.Hour.ToString récupère la valeur sous forme de chaîne de caractère
                heure = Now.Hour.ToString
                tmp = "AM"
                'On est au format anglais donc si l'heure est supérieure à 12, on prend l'heure - 12 et on change AM par PM
                If (heure > 12) Then
                    heure = heure - 12
                    tmp = "PM"
                End If

                'DatePrinted.Text = Now.ToShortDateString + " " + Now.ToLongTimeString

                ' MISE EN FORME DE LA DATE
                'La date est créée au format MM/JJ/AAAA
                DatePrinted.Text = Now.Month.ToString + "/" + Now.Day.ToString + "/" + Now.Year.ToString + " "
                ' MISE EN FORME DE L'HEURE
                'L'heure est au format : HH:mm:ss
                DatePrinted.Text = DatePrinted.Text + heure.ToString + ":" + Now.Minute.ToString + ":" + Now.Second.ToString + " " + tmp

            Next

        End If

    End Sub

End Class