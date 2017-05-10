require 'rails_helper'

RSpec.describe "comments/show", type: :view do
  before(:each) do
    @comment = assign(:comment, Comment.create!(
      :comment => "Comment",
      :commentable_id => 2,
      :commentable_type => "Commentable Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Comment/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Commentable Type/)
  end
end
