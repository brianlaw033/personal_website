require 'rails_helper'

RSpec.describe "comments/index", type: :view do
  before(:each) do
    assign(:comments, [
      Comment.create!(
        :comment => "Comment",
        :commentable_id => 2,
        :commentable_type => "Commentable Type"
      ),
      Comment.create!(
        :comment => "Comment",
        :commentable_id => 2,
        :commentable_type => "Commentable Type"
      )
    ])
  end

  it "renders a list of comments" do
    render
    assert_select "tr>td", :text => "Comment".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Commentable Type".to_s, :count => 2
  end
end
