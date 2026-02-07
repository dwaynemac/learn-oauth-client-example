require "test_helper"
require "omniauth"

class HomeFlowTest < ActionDispatch::IntegrationTest
  test "home renders login button" do
    get root_path

    assert_response :success
    assert_select "form[action='/auth/learn'][method='post']"
  end

  test "callback stores session and shows user info" do
    auth = OmniAuth::AuthHash.new(
      provider: "learn",
      uid: "42",
      info: {
        name: "Test User",
        email: "test@example.com",
        first_name: "Test",
        last_name: "User"
      },
      credentials: {
        token: "access-token-123"
      }
    )

    post "/test/auth/learn/callback", env: {"omniauth.auth" => auth}

    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
    assert_includes response.body, "Test User"
    assert_includes response.body, "test@example.com"
    assert_includes response.body, "Signed in with LEARN."
  end

  test "failure redirects to root with alert" do
    get "/auth/failure", params: {message: "invalid_grant"}

    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
    assert_includes response.body, "invalid_grant"
  end

  test "logout clears session" do
    auth = OmniAuth::AuthHash.new(
      provider: "learn",
      uid: "42",
      info: {name: "Test User"},
      credentials: {token: "access-token-123"}
    )
    post "/test/auth/learn/callback", env: {"omniauth.auth" => auth}

    delete logout_path
    assert_redirected_to root_path
    follow_redirect!
    assert_response :success
    assert_includes response.body, "Signed out."
    assert_select "form[action='/auth/learn'][method='post']"
  end
end
