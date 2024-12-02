# == Schema Information
#
# Table name: attributes
#
#  id         :bigint           not null, primary key
#  category   :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_attributes_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :attribute do
    name { "Test Attribute" }
    category { "Activity" }
  end
end
