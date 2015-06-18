# Taken from https://github.com/rspec/rspec-core/issues/470#issuecomment-2332933
module WithAndWithoutJS
  def with_and_without_js(&block)
    [true, false].each do |js|
      context "with js: #{js}", run_with: { js: js } do
        module_eval(&block)
      end
    end
  end

  RSpec.configure { |c| c.extend self }
end
