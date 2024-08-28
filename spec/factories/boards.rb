FactoryBot.define do
  factory :board do
    after(:build) do |object|
      object.csv.attach(
        io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'valid.csv')),
        filename: 'valid.csv',
        content_type: 'application/csv'
      )
    end
  end
end
