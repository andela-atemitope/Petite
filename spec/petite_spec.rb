require "spec_helper"

describe Petite::Application do
  let(:app) { Petite::Application.new }

  it "responds to call method" do
    expect(app.respond_to?(:call)).to be true
  end
end

describe Petite do
  it "has a version number" do
    expect(Petite::VERSION).not_to be nil
  end
end
