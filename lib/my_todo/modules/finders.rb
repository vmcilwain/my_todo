module Finders
  def item
    @item ||= Item.find_by_id(@id)
  end

  def item_notes
    @item_notes ||= item.notes
  end

  def all_items
    @items = case @status
            when 'all'
              Item.all
            when 'done'
              Item.where(done: true)
            when 'undone'
              Item.where(done: false)
            else
              say 'Unknown status!'
            end
  end

  def detailed_statuses
    @detailed_statuses ||= Item::DETAILED_STATUSES
  end

  def list_statuses
    detailed_statuses.each_with_index {|status, index| say "#{index}: #{status}"}
  end
end
