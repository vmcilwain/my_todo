module MyTodoActions
  def ask_status
    list_statuses
    @status = ask("Choose a status for item", default: set_default_status)
  end

  def create_item
    @banner = 'ToDo CREATED!'
    @item = Item.new(body: @body)
    assign_detailed_status
    @item.save!
    set_tags
  end

  def update_item
    @banner = 'ToDo UPDATED!'
    @item.assign_attributes(body: @body, done: @done)
    assign_detailed_status
    item.save!
  end

  def assign_detailed_status
    ask_status
    @item.write_attribute(:detailed_status, detailed_statuses[@status.to_i])
  end

  def set_tags
   @tags.each{|tag| @item.tags.create(name: tag) } if @tags
  end

  def set_default_status
    @item.detailed_status.nil? ? 1 : detailed_statuses.index(@item.detailed_status)
  end
end
