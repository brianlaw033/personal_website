require 'rails_helper'

RSpec.describe "comments/new", type: :view do
  before(:each) do
    assign(:comment, Comment.new(
      :comment => "MyString",
      :commentable_id => 1,
      :commentable_type => "MyString"
    ))
  end

  it "renders new comment form" do
    render

    assert_select "form[action=?][method=?]", comments_path, "post" do

      assert_select "input#comment_comment[name=?]", "comment[comment]"

      assert_select "input#comment_commentable_id[name=?]", "comment[commentable_id]"

      assert_select "input#comment_commentable_type[name=?]", "comment[commentable_type]"
    end
  end
end
