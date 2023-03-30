#INCLUDE 'Totvs.ch'
#INCLUDE 'Fwmvcdef.ch'

/*/{Protheus.doc} User Function Todo
    Função para realizar uma lista TODO em MVC
    @type  Function
    @author Vinícius Silva
    @since 30/03/2023
/*/
User Function Todo()
    Local cAlias := "ZZT"
    Local cTitle := "Cadastro de Tarefas"
    Local oBrowse := FwMBrowse():New()

    oBrowse:SetAlias(cAlias) 
    oBrowse:SetDescription(cTitle)    
    oBrowse:DisableDetails()
    oBrowse:DisableReport() 
    oBrowse:Activate() 
Return 

Static Function MenuDef()
    Local aRotina := {}

    ADD OPTION aRotina TITLE "Incluir"    ACTION "VIEWDEF.Todo" OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE "Alterar"    ACTION "VIEWDEF.Todo" OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE "Excluir"    ACTION "VIEWDEF.Todo" OPERATION 5 ACCESS 0
    
Return aRotina

Static Function ModelDef()
    Local oModel   := MpFormModel():New("TodoM")
    Local oStruZZT := FwFormStruct(1, "ZZT")
    Local oStruZZL := FwFormStruct(1, "ZZL")

    oModel:AddFields("ZZTMASTER", Nil, oStruZZT)
    oModel:SetDescription("Tarefas a Realizar")

    oModel:AddGrid("ZZLDETAIL", "ZZTMASTER", oStruZZL)

    oModel:SetRelation("ZZLDETAIL", {{"ZZL_FILIAL", "xFilial('ZZL')"}, {"ZZL_CODT", "ZZT_CODT"}}, ZZL->(IndexKey(1)))

    oModel:SetPrimaryKey({"ZZT_CODT", "ZZL_CODP"})

Return oModel 

Static Function ViewDef()
    Local oModel   := FwLoadModel("Todo")
    Local oStruZZT := FwFormStruct(2, "ZZT")
    Local oStruZZL := FwFormStruct(2, "ZZL")
    Local oView    := FwFormView():New()

    oView:SetModel(oModel)

    oView:AddField("VIEW_ZZT", oStruZZT, "ZZTMASTER")
    oView:CreateHorizontalBox("TelaProd", 50)
    oView:SetOwnerView("VIEW_ZZT", "TelaProd")
    OView:EnableTitleView("VIEW_ZZT", "Tarefa")

    oView:AddGrid("VIEW_ZZL", oStruZZL, "ZZLDETAIL")
    oView:CreateHorizontalBox("TelaFormProd", 50)
    oView:SetOwnerView("VIEW_ZZL", "TelaFormProd")
    OView:EnableTitleView("VIEW_ZZL", "Passos")

Return oView
