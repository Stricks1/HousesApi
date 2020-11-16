json.data do
  json.user do
    json.id @user.id
    json.username @user.username
    json.email @user.email
  end
  json.token token
end