def login
  role = create(:role, name: 'user')
  user = create(:user, name: 'Usuário Comum', email: 'admin@netshow.me', password: 'passwordsecret', role: role)
  sign_in user
  user
end
