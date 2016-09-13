FactoryGirl.define do
  factory :pack do
    effects { build_list :effect, 3 }
  end
end
