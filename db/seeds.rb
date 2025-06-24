# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).


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
  sender = User.all.sample  # On choisit un utilisateur au hasard pour être l'expéditeur du message
  recipients = User.where.not(id: sender.id).sample(rand(1..3))  # On choisit entre 1 et 3 destinataires différents, qui ne sont pas l'expéditeur

# On crée un message avec :
  # - un contenu généré aléatoirement (5 à 15 mots)
  # - l'expéditeur défini juste avant
  message = Message.create!(
    content: Faker::Lorem.sentence(word_count: rand(5..15)),
    sender: sender
  )

  # Pour chaque destinataire choisi :
  recipients.each do |recipient|  # On crée une relation entre le message et ce destinataire, grâce au modèle MessageRecipient (table de liaison)
    MessageRecipient.create!(message: message, user: recipient)
  end
end

# Créer un commentaire
20.times do
  Comment.create!(
    content: Faker::Lorem.paragraph,
    user: User.all.sample,
    gossip: Gossip.all.sample
  )
end

20.times do
  user = User.all.sample   # Sélectionne un utilisateur au hasard parmi tous les utilisateurs en base
  likeable = [Gossip, Comment].sample.all.sample   # Choisit aléatoirement entre la classe Gossip ou Comment, puis prend un enregistrement au hasard parmi tous les gossips ou commentaires
  Like.create!(
    user: user,
    likeable: likeable
  )
  # Crée un nouveau like avec l'utilisateur choisi et le gossip/commentaire choisi
  # Le point d'exclamation (!) signifie qu'une erreur sera levée si la création échoue
end

puts "✅ Seeds terminés : villes, users, gossips, tags, messages privés, commentaires et likes créés."
