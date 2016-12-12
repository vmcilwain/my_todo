module Templates
  p __dir__
  def print_list
    say ERB.new(File.read("#{__dir__}/../templates/list.erb"), nil, '-').result(binding)
  end

  def print_notes
    say ERB.new(File.read("#{__dir__}/../templates/notes.erb"), nil, '-').result(binding)
  end

  def print_search_results
    say ERB.new(File.read("#{__dir__}/../templates/results.erb"), nil, '-').result(binding)
  end

  def print_item
    say ERB.new(File.read("#{__dir__}/../templates/item.erb"), nil, '-').result(binding)
  end
end
