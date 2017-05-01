require 'rails_helper'

RSpec.describe "blogs/new", type: :view do
  before(:each) do
    assign(:blog, Blog.new(
      :name => "MyString",
      :content => "MyText"
    ))
  end

  it "renders new blog form" do
    render

    assert_select "form[action=?][method=?]", blogs_path, "post" do

      assert_select "input#blog_name[name=?]", "blog[name]"

      assert_select "textarea#blog_content[name=?]", "blog[content]"
    end
  end
end
