# frozen_string_literal: true

class Mutations::Adventure::StartMutation < Mutations::AuthenticatedMutation
  graphql_name 'AdventureStartMutation'
  argument :id, ID, required: true, description: 'Can be ID or slug of adventure'
  field :adventure, Types::AdventureType, null: false

  def resolve(id:)
    template_adventure = Adventure.published.friendly.find(id)
    adventure = template_adventure.deep_clone(include: :steps) do |original, copy|
      copy.template_id = original.id if copy.respond_to?(:template_id)
      copy.tag_list = original.tag_list if copy.respond_to?(:tag_list)
    end
    adventure.users << context[:current_user]
    adventure.save!
    { adventure: adventure }
  end
end
