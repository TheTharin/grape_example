# frozen_string_literal: true

Dir[File.expand_path('../lib/common/*.rb', __dir__)].each do |f|
  require f
end

Dir[File.expand_path('../lib/serializers/*.rb', __dir__)].each do |f|
  require f
end

Dir[File.expand_path('../lib/helpers/*.rb', __dir__)].each do |f|
  require f
end

Dir[File.expand_path('../lib/*.rb', __dir__)].each do |f|
  require f
end

Dir[File.expand_path('../lib/validations/*.rb', __dir__)].each do |f|
  require f
end

Dir[File.expand_path('../lib/entities/*.rb', __dir__)].each do |f|
  require f
end

Dir[File.expand_path('../lib/transactions/*.rb', __dir__)].sort.each do |f|
  require f
end

Dir[File.expand_path('../lib/queries/*.rb', __dir__)].each do |f|
  require f
end

Dir[File.expand_path('../api/*.rb', __dir__)].each do |f|
  require f
end
