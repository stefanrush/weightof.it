require 'csv'

fixtures = ['category']
location = "#{Rails.root}/spec/fixtures"

fixtures.each do |fixture|
  file = "#{location}/#{fixture}.csv"
  klass = fixture.classify.safe_constantize
  CSV.foreach(file, headers: true) { |row| klass.create!(row.to_hash) }
end
