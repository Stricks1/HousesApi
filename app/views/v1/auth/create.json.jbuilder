json.data do
  json.user do
    json.call(
      @user,
      :id,
      :username,
      :email
    )
  end
  json.token token
end
