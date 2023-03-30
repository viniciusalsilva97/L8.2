#INCLUDE 'Totvs.ch'
#INCLUDE 'Fwmvcdef.ch'


/*/{Protheus.doc} User Function BloAp
    Função para realizar o cadastro de blocos e proprietários em MVC
    @type  Function
    @author Vinícius Silva
    @since 30/03/2023
/*/
User Function BloAp()
    Local cAlias := "ZZQ"
    Local cTitle := "Cadastro dos Blocos"
    Local oBrowse := FwMBrowse():New()

    oBrowse:SetAlias(cAlias) 
    oBrowse:SetDescription(cTitle)    
    oBrowse:DisableDetails()
    oBrowse:DisableReport() 
    oBrowse:Activate() 
Return 

Static Function MenuDef()
    Local aRotina := {}

    ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.BloAp" OPERATION 2 ACCESS 0
    ADD OPTION aRotina TITLE "Incluir"    ACTION "VIEWDEF.BloAp" OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE "Alterar"    ACTION "VIEWDEF.BloAp" OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE "Excluir"    ACTION "VIEWDEF.BloAp" OPERATION 5 ACCESS 0
    
Return aRotina

Static Function ModelDef()
    Local oModel   := MpFormModel():New("BloApM")
    Local oStruZZQ := FwFormStruct(1, "ZZQ")
    Local oStruZZP := FwFormStruct(1, "ZZP")

    oModel:AddFields("ZZQMASTER", Nil, oStruZZQ)
    oModel:SetDescription("Bloco de Apartamentos")

    oModel:AddGrid("ZZPDETAIL", "ZZQMASTER", oStruZZP)

    oModel:SetRelation("ZZPDETAIL", {{"ZZP_FILIAL", "xFilial('ZZP')"}, {"ZZP_CODB", "ZZQ_CODBL"}}, ZZP->(IndexKey(1)))

    oModel:SetPrimaryKey({"ZZP_CODIGO", "ZZQ_CODBL"})

Return oModel 

Static Function ViewDef()
    Local oModel   := FwLoadModel("BloAp")
    Local oStruZZQ := FwFormStruct(2, "ZZQ")
    Local oStruZZP := FwFormStruct(2, "ZZP")
    Local oView    := FwFormView():New()

    oView:SetModel(oModel)

    oView:AddField("VIEW_ZZQ", oStruZZQ, "ZZQMASTER")
    oView:CreateHorizontalBox("TelaProd", 50)
    oView:SetOwnerView("VIEW_ZZQ", "TelaProd")
    OView:EnableTitleView("VIEW_ZZQ", "Bloco")

    oView:AddGrid("VIEW_ZZP", oStruZZP, "ZZPDETAIL")
    oView:CreateHorizontalBox("TelaFormProd", 50)
    oView:SetOwnerView("VIEW_ZZP", "TelaFormProd")
    OView:EnableTitleView("VIEW_ZZP", "Proprietário dos Apartamentos")

Return oView
