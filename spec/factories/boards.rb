FactoryBot.define do
  factory :board do
    transient do
      file { 'valid' }
    end
    
    trait :valid_csv do
      transient do
        file { 'valid' }
      end
    end
    trait :invalid_csv do
      transient do
        file { 'invalid' }
      end
    end

    after(:build) do |object, evaluator|
      object.csv.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', "#{evaluator.file}.csv")),
        filename: "#{evaluator.file}.csv",
        content_type: 'application/csv'
      )
    end
  end
end
