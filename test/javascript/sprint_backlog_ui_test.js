var product_backlog = [{"title":"Visualizar Perfil do Arquiteto","theme":"Arquiteto","points":2,"id":567492963},{"title":"Buscar Arquiteto","theme":"Arquiteto","points":3,"id":61873896},{"title":"Preencher Dados Gerais do Arquiteto","theme":"Arquiteto","points":3,"id":542149447},{"title":"Preencher Curr\u00edculo do Arquiteto","theme":"Arquiteto","points":3,"id":731456063},{"title":"Construir Show Room de Projetos do Arquiteto","theme":"Arquiteto","points":7,"id":787296314},{"title":"Visualizar Perfil da Empresa","theme":"Empresas de Arquitetura","points":2,"id":510360074},{"title":"Buscar Empresa de Arquitetura","theme":"Empresas de Arquitetura","points":3,"id":470307930},{"title":"Preencher Dados Gerais da Empresa","theme":"Empresas de Arquitetura","points":3,"id":832393412},{"title":"Construir Show Room de Projetos da Empresa","theme":"Empresas de Arquitetura","points":5,"id":947906800},{"title":"Visualizar Perfil do Fornecedor","theme":"Fornecedores","points":2,"id":209392792},{"title":"Preencher Dados Gerais do Fornecedor","theme":"Fornecedores","points":2,"id":699408949},{"title":"Buscar Fornecedor","theme":"Fornecedores","points":2,"id":804945112},{"title":"Cadastrar Produtos do Fornecedor","theme":"Fornecedores","points":5,"id":916701017},{"title":"Visualizar Perfil da Universidade","theme":"Universidades","points":2,"id":929974416},{"title":"Buscar Universidades","theme":"Universidades","points":2,"id":710544066},{"title":"Preencher Dados Gerais da Universidade","theme":"Universidades","points":2,"id":937946479},{"title":"P\u00e1gina Inicial","theme":"Portal","points":5,"id":962005467},{"title":"Institucionais (quem somos, contato, publicidade)","theme":"Portal","points":2,"id":522172059},{"title":"Enviar Mensagem para Usu\u00e1rio","theme":"Mensagens","points":2,"id":365539690},{"title":"Responder Mensagem do Usu\u00e1rio","theme":"Mensagens","points":1,"id":853809577},{"title":"Autenticar","theme":"Seguran\u00e7a","points":1,"id":653382314},{"title":"Recuperar Senha","theme":"Seguran\u00e7a","points":1,"id":337817376},{"title":"Alterar Senha","theme":"Seguran\u00e7a","points":1,"id":722825640},{"title":"Emitir Boleto para Pagamento","theme":"Pagamento de Mensalidades","points":5,"id":396608416},{"title":"Consultar Pagamentos em Aberto","theme":"Pagamento de Mensalidades","points":3,"id":414637248},{"title":"Enviar E-mail Notificando Atraso","theme":"Pagamento de Mensalidades","points":3,"id":865142379},{"title":"Desativar/Reativar Conta por Falta de Pagamento","theme":"Pagamento de Mensalidades","points":1,"id":24387535},{"title":"Informar Pagamento do Boleto","theme":"Pagamento de Mensalidades","points":2,"id":135849485},{"title":"Consultar Dados de Pagamento","theme":"Pagamento de Mensalidades","points":5,"id":177954281},{"title":"Divulgar de Evento","theme":"Divulga\u00e7\u00e3o de Eventos","points":2,"id":883109304},{"title":"Consultar Agenda de Eventos","theme":"Divulga\u00e7\u00e3o de Eventos","points":3,"id":43921208},{"title":"Divulgar Vaga","theme":"Divulga\u00e7\u00e3o de Empregos/Est\u00e1gios","points":2,"id":342617304},{"title":"Consultar Vagas","theme":"Divulga\u00e7\u00e3o de Empregos/Est\u00e1gios","points":2,"id":133030681},{"title":"Veicular Banner","theme":"Propaganda de Empresas","points":2,"id":127933423},{"title":"Divulgar Promo\u00e7\u00f5es","theme":"Propaganda de Empresas","points":3,"id":532125499},{"title":"Cadastrar Banner","theme":"Propaganda de Empresas","points":3,"id":14633730},{"title":"Consultar Estat\u00edsticas do Banner","theme":"Propaganda de Empresas","points":5,"id":226680967},{"title":"Recomendar Livro","theme":"Recomenda\u00e7\u00e3o de Livro","points":2,"id":366918327},{"title":"Comentar Recomenda\u00e7\u00e3o do Livro","theme":"Recomenda\u00e7\u00e3o de Livro","points":1,"id":37401344},{"title":"Consultar Recomenda\u00e7\u00f5es do Livro","theme":"Recomenda\u00e7\u00e3o de Livro","points":2,"id":653614771},{"title":"Linkar Livro com Submarino","theme":"Recomenda\u00e7\u00e3o de Livro","points":3,"id":827000394},{"title":"Visualizar F\u00f3rum","theme":"F\u00f3rum de Discuss\u00e3o","points":2,"id":502549137},{"title":"Criar F\u00f3rum","theme":"F\u00f3rum de Discuss\u00e3o","points":1,"id":967487835},{"title":"Criar T\u00f3pico do F\u00f3rum","theme":"F\u00f3rum de Discuss\u00e3o","points":2,"id":495674528},{"title":"Responder T\u00f3pico do F\u00f3rum","theme":"F\u00f3rum de Discuss\u00e3o","points":2,"id":637340062},{"title":"Moderar F\u00f3rum","theme":"F\u00f3rum de Discuss\u00e3o","points":3,"id":211573974}];
var project_backlog = [{"sprint_id":1,"done":false,"id":5,"backlog_item_id":567492963},{"sprint_id":1,"done":true,"id":6,"backlog_item_id":61873896},{"sprint_id":1,"done":true,"id":7,"backlog_item_id":542149447},{"sprint_id":1,"done":true,"id":8,"backlog_item_id":731456063},{"sprint_id":1,"done":true,"id":9,"backlog_item_id":787296314},{"sprint_id":1,"done":true,"id":10,"backlog_item_id":510360074},{"sprint_id":2,"done":false,"id":11,"backlog_item_id":470307930},{"sprint_id":2,"done":false,"id":12,"backlog_item_id":832393412},{"sprint_id":2,"done":false,"id":13,"backlog_item_id":947906800},{"sprint_id":2,"done":false,"id":14,"backlog_item_id":209392792}]
var sbui

module("SprintBacklogUI", {
	setup: function() {
		var sprint_id = 2
		sbui = new SprintBacklogUI(product_backlog, project_backlog, sprint_id, false)
	}
});

test("instantiate SprintBacklogUI", function() {
	ok(sbui != null)
});

test("render product backlog", function() {
	sbui.render_product_backlog('#product_backlog_div')
	
	// options
	var options = get_options()
	equals(options.length, 37)
	equals(options[0].text, '(2+1) Visualizar Perfil do Arquiteto')
	equals(options[1].text, '(2) Preencher Dados Gerais do Fornecedor')
	equals(options[2].text, '(2) Buscar Fornecedor')
	equals(options[3].text, '(5) Cadastrar Produtos do Fornecedor')
	equals(options[4].text, '(2) Visualizar Perfil da Universidade')
	equals(options[36].text, '(3) Moderar F\u00f3rum')
	
	// optgroups
	var groups = get_groups()
	equals(groups.length, 12)
	equals(groups[0].label, 'Arquiteto')
	equals(groups[1].label, 'Fornecedores')
	equals(groups[2].label, 'Universidades')
	equals(groups[3].label, 'Portal')
	equals(groups[11].label, 'F\u00f3rum de Discuss\u00e3o')
});

test("render sprint backlog", function() {
	sbui.render_sprint_backlog("#sprint_backlog_div")
	
	var items = get_items()
	equals(items.length, 4)
	equals(items[0].innerHTML, 'Buscar Empresa de Arquitetura')
	equals(items[1].innerHTML, 'Preencher Dados Gerais da Empresa')
	equals(items[2].innerHTML, 'Construir Show Room de Projetos da Empresa')
	equals(items[3].innerHTML, 'Visualizar Perfil do Fornecedor')
});

test("add", function() {
	$('#' + sbui.select_tag_id).val(699408949)
	sbui.add("#product_backlog_div", "#sprint_backlog_div")

	var options = get_options()
	equals(options.length, 36)
	equals(options[0].text, '(2+1) Visualizar Perfil do Arquiteto')

	var items = get_items()
	equals(items.length, 5)
	equals(items[4].innerHTML, 'Preencher Dados Gerais do Fornecedor')

});

test("remove", function() {
	sbui.remove(470307930, "#product_backlog_div", "#sprint_backlog_div")		
	
	var options = get_options()
	equals(options.length, 37)
	equals(options[0].text, '(2+1) Visualizar Perfil do Arquiteto')

	var items = get_items()
	equals(items.length, 4)
	equals(items[0].innerHTML, 'Preencher Dados Gerais da Empresa')		
});

test("story_points", function() {
	sbui.render_product_backlog('#product_backlog_div')
	sbui.render_sprint_backlog("#sprint_backlog_div")
	equals(sbui.story_points(), 15)
});

test("backlog_points", function() {
	sbui.render_product_backlog('#product_backlog_div')
	sbui.render_sprint_backlog("#sprint_backlog_div")
	equals(sbui.backlog_points(), 88)
});

// obtains select options	
function get_options() {
	var el = $("#" + sbui.select_tag_id)
	ok(el != null)
	return el[0].options
}

// obtains select optgroups
function get_groups() {
	return $("optgroup")
}

// obtains sprint backlog items
function get_items() {
	return $('#sprint_backlog_div div span.item')
}