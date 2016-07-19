Given(/^we can manage battlepets$/) do
  uri = URI.parse(BATTLEPETS_MANAGEMENT_URL)
  expect { Net::HTTP.get(uri) }.not_to raise_error
end

# FIXME: regex match wit and other traits
# FIXME: Need way to delete created objects programmatically (There is no destroy method)
#     Using randomness for now
#     FIXME: use uuids for randomness
Given(/^I create a battlepet "([^"]*)" with wit (\d+) and strength (\d+)$/) do |pet_name, wit, strength|
  instance_variable_set("@#{pet_name.downcase}", pet_name + "_#{rand(1000000)}")
  pet = BattlePet.new(
    name: instance_variable_get("@#{pet_name.downcase}"),
    traits: {wit: wit, strength: strength})
  pet.save
end

When(/^"([^"]*)" and "([^"]*)" participate in a contest of "([^"]*)"$/) do |first_pet_name, second_pet_name, contest_trait|
  first_pet = instance_variable_get("@#{first_pet_name.downcase}")
  second_pet = instance_variable_get("@#{second_pet_name.downcase}")
  response = post 'contests', params: {
    contest: {battlepet_traits: [contest_trait], battlepets: [first_pet, second_pet]}
  }
  expect(response.status).to eq(201)
end

Then(/^the contest will be completed$/) do
  contest = Contest.last
  # FIXME
  sleep(1)
  @result = ContestResult.where(contest: contest).first
  expect(@result).not_to be_nil
end

Then(/^"([^"]*)" will be declared the winner$/) do |pet_name|
  pet_name = instance_variable_get("@#{pet_name.downcase}")
  expect(@result.winner).to eq(pet_name)
end

When(/^"([^"]*)" and "([^"]*)" participate in a contest of strength$/) do |arg1, arg2|
  pending # Write code here that turns the phrase above into concrete actions
end
