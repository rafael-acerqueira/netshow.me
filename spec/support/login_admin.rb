def login_admin
  role = create(:role, name: 'admin')
  user = create(:user, name: 'Administrador', email: 'admin@netshow.me', password: 'passwordsecret', role: role)
  sign_in user
  user
end
