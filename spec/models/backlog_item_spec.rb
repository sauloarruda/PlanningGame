require 'spec_helper'

describe BacklogItem do
  fixtures :backlogs, :backlog_themes, :backlog_items
  
  it "should belongs to BacklogTheme" do
    item = backlog_items(:visualizar_perfil_do_arquiteto)
    item.backlog_theme.should == backlog_themes(:arquiteto)
  end

  it "should return backlog_items from backlog" do
    pending "refator for consider 46 backlog items"
    items = BacklogItem.all(backlogs(:rede_social_arquitetos))
    items.should have(46).records
    items.to_json.should eql('[{"title":"Visualizar Perfil do Arquiteto","theme":"Arquiteto","points":2,"id":567492963},{"title":"Buscar Arquiteto","theme":"Arquiteto","points":3,"id":61873896},{"title":"Preencher Dados Gerais do Arquiteto","theme":"Arquiteto","points":3,"id":542149447},{"title":"Preencher Curr\u00edculo do Arquiteto","theme":"Arquiteto","points":3,"id":731456063},{"title":"Construir Show Room de Projetos do Arquiteto","theme":"Arquiteto","points":5,"id":787296314},{"title":"Visualizar Perfil da Empresa","theme":"Empresas de Arquitetura","points":2,"id":510360074},{"title":"Buscar Empresa de Arquitetura","theme":"Empresas de Arquitetura","points":3,"id":470307930},{"title":"Preencher Dados Gerais da Empresa","theme":"Empresas de Arquitetura","points":3,"id":832393412},{"title":"Construir Show Room de Projetos da Empresa","theme":"Empresas de Arquitetura","points":1,"id":947906800},{"title":"Visualizar Perfil do Fornecedor","theme":"Fornecedores","points":2,"id":209392792},{"title":"Preencher Dados Gerais do Fornecedor","theme":"Fornecedores","points":2,"id":699408949},{"title":"Buscar Fornecedor","theme":"Fornecedores","points":2,"id":804945112},{"title":"Cadastrar Produtos do Fornecedor","theme":"Fornecedores","points":5,"id":916701017},{"title":"Visualizar Perfil da Universidade","theme":"Universidades","points":2,"id":929974416}]')
  end
  
end
