function SprintBacklogUI(product_backlog, project_backlog, sprint_id, executed) {
	this.product_backlog = product_backlog
	this.project_backlog = project_backlog
	this.select_tag_id = "product_backlog_select"
	this.sprint_id = sprint_id
	this.executed = executed
	
	// render the product_backlog list
	this.render_product_backlog = function(toId) {
		// create avaliable product backlog array
		this.create_avaiable_product_backlog()
		
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
			var option = '<option value="' + item.id + '">('+ item.points
			if (item.extra_points != null) {
				option += '+' + item.extra_points
			}
			option += ') ' + item.title + '</option>'
			select.append(option)
		}
	}
	
	// render the sprint_backlog list
	this.render_sprint_backlog = function(toId) {
		var div = $(toId)
		div.empty()
		var theme = null
		var i=0
		for (var id in this.sprint_backlog) {
			var item = this.sprint_backlog[id]
			div.append('<div id="item_'+item.id+'"></div>')
			var content = '<button onclick="remove_item('+item.id+')">×</button>' +
				'<input type="hidden" name="backlog_items[' + i++ +'][backlog_item_id]" value="'+item.id+'" /> ' +
				'('+item.points
			if (item.extra_points != null) {
				content += '+' + item.extra_points
			}
			var project_backlog_items = this.get_project_backlog_item(item.id)
			var done = (project_backlog_items.length > 0 && project_backlog_items[project_backlog_items.length-1].done)
			content += ') ' + item.theme+' &raquo; '
			content += '<span class="item '+ (executed && done ? 'item_done' : 'item_not_done') +'">' +
				item.title+'</span>'
			content += '</div>'
			$("#item_" + item.id).html(content)
		}
	}
	
	// add the product backlog item to sprint backlog 
	this.add = function(fromId, toId) {
		var select = $('#' + this.select_tag_id)
		if (select.val() == null) {
			//alert("Select a value") // TODO i18n this
			return ;
		} 
		var item = this.get_product_backlog_item(select.val())
		
		this.sprint_backlog[this.sprint_backlog.length] = item
		this.project_backlog[this.project_backlog.length] = 
			{"sprint_id":this.sprint_id,"done":false,"id":null,"backlog_item_id":item.id}
		this.render_sprint_backlog(toId)
		this.render_product_backlog(fromId)
	}
	
	this.remove = function(itemId, fromId, toId) {
		var arr_sprint_backlog = this.sprint_backlog
		this.sprint_backlog = []
		var j=0
		for (var i in arr_sprint_backlog) {
			var item = arr_sprint_backlog[i]
			if (item.id != itemId) {
				this.sprint_backlog[j++] = item
			}
		}
		
		var arr_project_backlog = this.project_backlog
		this.project_backlog = []
		var j=0
		for (var i in arr_project_backlog) {
			var item = arr_project_backlog[i]
			if (item.backlog_item_id != itemId) {
				this.project_backlog[j++] = item
			} else if (item.sprint_id != this.sprint_id) {
				this.project_backlog[j++] = item
			}
		}
		
		this.render_sprint_backlog(toId)
		this.render_product_backlog(fromId)
	}
	
	this.story_points = function() {
		var total = 0
		for (var i in this.sprint_backlog) {
			item = this.get_product_backlog_item(this.sprint_backlog[i].id)
			if (item != null) {
				total += item.points
				if (item.extra_points != null) {
					total += item.extra_points
				}
			}
		}
		return total
	}
	
	this.backlog_points = function() {
		var total = 0
		for (var i in this.avaiable_product_backlog) {
			item = this.avaiable_product_backlog[i]
			total += item.points
			if (item.extra_points != null) {
				total += item.extra_points
			}
		}
		return total
	}
	
	// get an item on product_backlog
	this.get_product_backlog_item = function(item_id) {
		for (var i in this.product_backlog) {
			var item = this.product_backlog[i]
			if (item.id == item_id) {
				return item
			}
		}
		return null;
	}

	// get an item on project_backlog
	this.get_project_backlog_item = function(item_id) {
		var items = Array()
		for (var i in this.project_backlog) {
			var item = this.project_backlog[i]
			if (item.backlog_item_id == item_id) {
				items[items.length] = item
			}
		}
		return items;
	}
	
	// get an item on sprint_backlog
	this.get_sprint_backlog_item = function(item_id) {
		for (var i in this.sprint_backlog) {
			var item = this.sprint_backlog[i]
			if (item.id == item_id) {
				return item
			}
		}
		return null;
	}
	
	// create the avaiable product backlog
	this.create_avaiable_product_backlog = function() {
		this.avaiable_product_backlog = Array()
		for (var i in this.product_backlog) {
			var backlog_item = this.product_backlog[i]
			backlog_item.extra_points = null // clean extra points for new calculation
			var project_items = this.get_project_backlog_item(backlog_item.id)
			
			var avaiable = false
			// planned in another sprint
			if (project_items.length > 0) {
				for (var j in project_items) {
					project_item = project_items[j]
					// and not done
					if (!project_item.done && project_item.sprint_id != this.sprint_id) {
						avaiable = true
						// sum 1 extra point
						if (backlog_item.extra_points == null) {
							backlog_item.extra_points = 0
						}
						backlog_item.extra_points++
					} else {
						avaiable = false
					}
				}
			} else {
				avaiable = true
			}
			
			// not planned yet but planned now
			if (avaiable) {
				avaiable = this.get_sprint_backlog_item(backlog_item.id) == null
			}
			
			if (avaiable) {	
				this.avaiable_product_backlog[this.avaiable_product_backlog.length] = backlog_item
			}
		}
	}
	
	// creates sprint backlog
	this.sprint_backlog = []
	var j = 0
	for (var i in this.project_backlog) {
		var item = this.project_backlog[i]
		if (item.sprint_id == this.sprint_id) {
			this.sprint_backlog[j++] = this.get_product_backlog_item(item.backlog_item_id)
		}
	}
		
}