module MyTodoActions
  def ask_status
    list_statuses
    @status = ask("Choose a status for item", default: 1)
  end

  def create_item(options)
    ask_status
    @item = Item.create!(options.merge({detailed_status: detailed_statuses[@status.to_i]}).except(:tags))
    options[:tags].split(' ').each{|tag| item.tags.create(name: tag) } if options[:tags]
  end

  def update_item(options)
    ask_status
    new_status = detailed_statuses[@status.to_i]
    item.detailed_status != new_status ? item.update!(options.merge({detailed_status: new_status})) : item.update!(options)
  end
end
