require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "home shows the landing page and nomination form" do
    get root_path

    assert_response :success
    assert_select "h1", /Friends don’t let friends launch/
    assert_select "form[action=?]", nominations_path
  end
end
