function SprintBacklogUI(product_backlog, project_backlog, sprint_id) {
	this.product_backlog = product_backlog
	this.project_backlog = project_backlog
	this.select_tag_id = "product_backlog_select"
	this.sprint_id = sprint_id

	// convert product_backlog to hash indexed by backlog_item_id
	var arr_product_backlog = this.product_backlog
	this.product_backlog = Array()
	for (var i=0; i<arr_product_backlog.length; i++) {
		this.product_backlog[arr_product_backlog[i].id] = arr_product_backlog[i]
	}

	// convert product_backlog to hash indexed by backlog_item_id
	var arr_project_backlog = this.project_backlog
	this.project_backlog = Array()
	for (var i=0; i<arr_project_backlog.length; i++) {
		item = arr_project_backlog[i]
		item['item'] = this.product_backlog[item.backlog_item_id]
		this.project_backlog[item.backlog_item_id] = item
	}		

	// creates sprint backlog
	this.sprint_backlog = Array()
	for (var i in this.project_backlog) {
		var item = this.project_backlog[i]
		if (item.sprint_id == this.sprint_id) {
			this.sprint_backlog[item.backlog_item_id] = this.product_backlog[item.backlog_item_id]
		}
	}
	
	// create the product_backlog list
	this.render_product_backlog = function(toId) {
		// create avaliable product backlog array
		this.avaiable_product_backlog = Array()
		for (var i in this.product_backlog) {
			item = this.product_backlog[i]
			if (this.project_backlog[item.id] == null)
				this.avaiable_product_backlog[this.avaiable_product_backlog.length] = item
		}
		
		div = $(toId)
		div.empty()
		div.append('<select id="'+this.select_tag_id+'" size="12" ondblclick="add_item()"></select>')
		var select = $('#' + this.select_tag_id)
		var theme = null
		for (var i=0; i<this.avaiable_product_backlog.length; i++) {
			var item = this.avaiable_product_backlog[i]
			if (theme == null || theme != item.theme) {
				theme = item.theme
				if (i > 0) select.append("</optgroup>")
				select.append('<optgroup label="'+ theme +'">')
			}
			select.append('<option value="' + item.id + '">('+ item.points +') '+ item.title + '</option>')
		}
	}
	
	this.render_sprint_backlog = function(toId) {
		var div = $(toId)
		div.empty()
		var theme = null
		for (var id in this.sprint_backlog) {
			item = this.sprint_backlog[id]
			div.append('<div id="item_'+item.id+'"></div>')
			content = '<button onclick="remove_item('+item.id+')">del</button>' +
				'<input type="hidden" name="backlog_items[][backlog_item_id]" value="'+item.id+'" /> ' +
				'('+item.points+') ' + item.theme+' &raquo; ' +
				'<span class="'+ ((this.project_backlog[id].done) ? 'item_done' : 'item_not_done') +'">' +
				item.title+'</span></div>'
			$("#item_" + item.id).html(content)
		}
	}
	
	// add the product backlog item to sprint backlog 
	this.add = function(fromId, toId) {
		var select = $('#' + this.select_tag_id)
		if (select.val() == null) {
			alert("Select a value")
			return ;
		} 
		var item = this.product_backlog[select.val()]
		
		this.sprint_backlog[item.id] = item
		this.project_backlog[item.id] = item
		this.render_sprint_backlog(toId)
		this.render_product_backlog(fromId)
	}
	
	this.remove = function(itemId, fromId, toId) {
		var item = this.product_backlog[itemId]		
		this.sprint_backlog[item.id] = null
		delete this.sprint_backlog[item.id]
		this.project_backlog[item.id] = null
		delete this.project_backlog[item.id]
		this.render_sprint_backlog(toId)
		this.render_product_backlog(fromId)
	}
	
	this.story_points = function() {
		var total = 0
		for (var id in this.sprint_backlog) {
			item = this.product_backlog[id]
			if (item != null) total += item.points
		}
		return total
	}
	
	this.backlog_points = function() {
		var total = 0
		for (var i in this.avaiable_product_backlog) {
			item = this.avaiable_product_backlog[i]
			total += item.points
		}
		return total
	}
		
}