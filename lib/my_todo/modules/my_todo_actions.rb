module MyTodoActions
  def ask_status
    list_statuses
    @status = ask("Choose a status for item", default: 1)
  end

  def create_item(options)
    @item = Item.new(options.except(:tags))
    assign_detailed_status
    @item.save!
    set_tags
  end

  def update_item(options)
    item.assign_attributes(options)
    @item = item #Find a better way!!!!
    assign_detailed_status
    item.save!
  end

  def assign_detailed_status
    ask_status
    @item.write_attribute(:detailed_status, detailed_statuses[@status.to_i])
  end

  def set_tags
    options[:tags].split(' ').each{|tag| @item.tags.create(name: tag) } if options[:tags]
  end
end
