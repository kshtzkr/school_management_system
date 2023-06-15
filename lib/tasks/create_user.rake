namespace :user do
  desc 'create roles'
  task create_roles: :environment do
    Role.create(name: 'admin')
    Role.create(name: 'school_admin')
    Role.create(name: 'student')
  end

  desc 'create users'
  task create_users: :environment do
    User.create(email: 'admin@gmail.com',password: '123456')
    User.create(email: 'admin2@gmail.com',password: '123456')
    User.create(email: 'school_admin@gmail.com',password: '123456')
    User.create(email: 'school_admin2@gmail.com',password: '123456')
    User.create(email: 'student@gmail.com',password: '123456')
    User.create(email: 'student1@gmail.com',password: '123456')
  end

  desc 'create users'
  task assign_roles: :environment do
    admin = User.find_by(email: 'admin@gmail.com')
    admin.user_roles.create(role_id: Role.find_by(name: 'admin').id)
    admin2 = User.find_by(email: 'admin2@gmail.com')
    admin2.user_roles.create(role_id: Role.find_by(name: 'admin').id)
    school_admin = User.find_by(email: 'school_admin@gmail.com')
    school_admin.user_roles.create(role_id: Role.find_by(name: 'school_admin').id)
    school_admin2 = User.find_by(email: 'school_admin2@gmail.com')
    school_admin2.user_roles.create(role_id: Role.find_by(name: 'school_admin').id)
    student = User.find_by(email: 'student@gmail.com')
    student.user_roles.create(role_id: Role.find_by(name: 'student').id)
    student1 = User.find_by(email: 'student1@gmail.com')
    student1.user_roles.create(role_id: Role.find_by(name: 'student').id)
  end
end