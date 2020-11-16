json.data do
  json.user do
    json.call(
      @user,
      :username,
      :email,
      :authentication_token
    )
  end
end