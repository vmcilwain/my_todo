module Finders
  def item
    @item ||= Item.where(id: options[:id]).first
  end

  def item_notes
    @item_notes ||= item.notes
  end

  def all_items
    @items = case options[:status]
            when 'all'
              Item.all
            when 'done'
              Item.where(done: true)
            else
              Item.where(done: false)
            end
  end

  def detailed_statuses
    @detailed_statuses ||= Item::DETAILED_STATUSES
  end

  def list_statuses
    detailed_statuses.each_with_index {|status, index| say "#{index}: #{status}"}
  end
end
