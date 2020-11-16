json.data do
  json.user do
    json.call(
      @user,
      :username,
      :email
    )
  end
  json.token token
end
