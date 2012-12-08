guard :test do
  watch(%r{^lib/(.+)\.rb$})     { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^test/.+_test\.rb$})
  watch('test/test_helper.rb')  { "test" }

  # Rails example
  watch(%r{^app/models/(.+)\.rb$}) { |m| 
    "test/unit/#{m[1]}_test.rb"
  }
  watch(%r{^app/controllers/(.+)\.rb$}) { |m|
    "test/functional/#{m[1]}_test.rb"
  }
  watch(%r{^app/views/(.+)/.+$}) { |m|
    "test/functional/#{m[1]}_controller_test.rb"
  }
  watch(%r{^app/views/.+\.rb$}) {
    "test/integration"
  }
  watch('app/views/layouts/application.html.rb') {
    ["test/functional", "test/integration"]
  }
  watch('app/controllers/application_controller.rb') {
    ["test/functional", "test/integration"]
  }
  watch(%r{^test/fabricators/(.+)_fabricator.rb$}) { |m|
    "test/unit/#{m[1]}_test.rb"
  }
end
