require 'spec_helper'

describe TodoPresenter do
  subject { TodoPresenter.new(setup_todo, '1') }

  its(:title) { should eq('Build a Hypermedia API') }
  its(:notes) { should eq('For Codebits 2012') }
  its(:due_date) { should eq('2012-11-15') }
  its(:list_id) { should eq('1') }

  context 'without set due date' do
    subject { TodoPresenter.new(setup_todo(due_date: nil), '1') }

    its(:due_date) { should be_nil }
  end

  def setup_todo(options = {})
    Todo.new(
      title: options.fetch(:title, 'Build a Hypermedia API'),
      notes: options.fetch(:notes, 'For Codebits 2012'),
      due_date: options.fetch(:due_date, Date.new(2012, 11, 15))
    )
  end
end
