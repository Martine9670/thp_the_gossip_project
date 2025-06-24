class User < ApplicationRecord
  # Chaque utilisateur appartient à une ville (relation many-to-one)
  belongs_to :city

  # Un utilisateur peut envoyer plusieurs messages (relation one-to-many)
  # 'sent_messages' est un nom personnalisé pour accéder aux messages envoyés
  # 'class_name: "Message"' indique que le modèle lié est Message
  # 'foreign_key: "sender_id"' précise que la clé étrangère dans messages est sender_id
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"

  # Un utilisateur a plusieurs enregistrements dans la table message_recipients
  # Cette table fait le lien entre messages et utilisateurs destinataires
  has_many :message_recipients

  # Un utilisateur reçoit plusieurs messages via la table de liaison message_recipients
  # 'received_messages' récupère les messages reçus par l'utilisateur
  # 'through: :message_recipients' signifie qu'on passe par la relation message_recipients
  # 'source: :message' indique que c’est la colonne message dans message_recipients qui est utilisée
  has_many :received_messages, through: :message_recipients, source: :message

  # Un utilisateur peut avoir plusieurs commentaires (relation one-to-many)
  # ATTENTION : ici il faut écrire has_many au pluriel pour que ça marche bien
  has_many :comments

  # Un utilisateur peut avoir plusieurs likes (relation one-to-many)
  has_many :likes
end
