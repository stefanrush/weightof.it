# create model for each JSON object within each fixture file

fixtures = %w( categories libraries )
fixtures_location = "#{Rails.root}/db/fixtures"

fixtures.each do |fixture|
  klass = fixture.singularize.classify.safe_constantize
  file  = File.read("#{fixtures_location}/#{fixture}.json")
  JSON.parse(file)[fixture].each { |item| klass.create!(item) }
end
