require "spec_helper"

describe Todo do
  it "Makes string Camel Case" do
    expect("camel_case".to_camel_case).to eql "CamelCase"
  end

  it "Makes string Snake Case" do
    expect("SnakeCase".to_snake_case).to eql "snake_case"
  end
end
