group :red_green_refactor, halt_on_fail: true do
  guard :minitest, spring: 'bin/rails test' do
    watch(%r{^app/(.+)\.rb$})                               { |m| "test/#{m[1]}_test.rb" }
    watch(%r{^app/controllers/application_controller\.rb$}) { 'test/controllers' }
    watch(%r{^app/controllers/(.+)_controller\.rb$})        { |m| "test/integration/#{m[1]}_test.rb" }
    watch(%r{^app/views/(.+)_mailer/.+})                    { |m| "test/mailers/#{m[1]}_mailer_test.rb" }
    watch(%r{^test/.+_test\.rb$})
    watch(%r{^test/test_helper\.rb$}) { 'test' }
  end

  guard :rubocop do
    watch(/(.+\.rb)$/) { |m| m[0] }
    watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
  end
end
