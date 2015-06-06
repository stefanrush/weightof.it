# create model for each JSON object within each fixture file

fixtures = %w( categories libraries )
fixtures_location = "#{Rails.root}/db/fixtures"

fixtures.each do |fixture|
  klass = fixture.singularize.classify.safe_constantize
  file  = File.read("#{fixtures_location}/#{fixture}.json")
  items = JSON.parse(file)[fixture]
  items.each_with_index do |item, index|
    print "\rSeeding #{fixture.singularize} #{index + 1}/#{items.size}..."
    klass.create!(item)
  end
  print " Done!\n"
end
