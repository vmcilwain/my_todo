require 'spec_helper'

describe MyTodo do
  describe 'export' do
    it 'creates a .gz file of the database' do
      MyTodo::Todo.start(%w[export export_file.dump.gz])
      expect(File.exists?("export_file.dump.gz")).to eq be_true
    end
  end
end
