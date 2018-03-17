%w(admin user).each do |role|
  Role.find_or_create_by(name: role)
end


User.find_or_create_by(email: 'user@netshow.me') do |u|
  u.name = 'Usuário Comum'
  u.password = '%*user%*'
  u.role = Role.find_by_name('user')
end

User.find_or_create_by(email: 'admin@netshow.me') do |u|
  u.name = 'Administrador'
  u.password = '%*admin%*'
  u.role = Role.find_by_name('admin')
end
