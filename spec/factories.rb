FactoryBot.define do
  factory :role do
    name { 'student' }
  end
  
  factory :admin_role, parent: :role do
    name { 'admin' }
  end
  
  factory :school_admin_role, parent: :role do
    name { 'school_admin' }
  end

  factory :user do
    # Define the attributes for the user factory
    # For example:
    email { 'user@example.com' }
    password { 'password' }
  end
end
