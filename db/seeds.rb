# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Créer 10 villes
10.times do
  City.create!(
    name: Faker::Address.city,
    zip_code: Faker::Address.zip_code
  )
end
# Créer 10 utilisateurs liés à une ville
10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Lorem.paragraph,
    email: Faker::Internet.unique.email,
    age: rand(18..65),
    city: City.all.sample
  )
end

# Créer 20 gossips
20.times do
  Gossip.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    content: Faker::Lorem.paragraph(sentence_count: 2),
    user: User.all.sample
  )
end

# Créer 10 tags
10.times do
    Tag.create!(
        title: Faker::Lorem.unique.word
    )
end

# Associer tags aux gossips
Gossip.all.each do |gossip|
  tags = Tag.order("RANDOM()").limit(rand(1..3))
  gossip.tags << tags
end

# Créer 10 messages privés
10.times do
  sender = User.all.sample
  recipients = User.where.not(id: sender.id).sample(rand(1..3))

  message = Message.create!(
    content: Faker::Lorem.sentence(word_count: rand(5..15)),
    sender: sender
  )

  recipients.each do |recipient|
    MessageRecipient.create!(message: message, user: recipient)
  end
end

puts "✅ Seeds terminés : villes, users, gossips, tags et messages privés créés."
