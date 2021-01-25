# frozen_string_literal: true

class Adventure < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  acts_as_taggable_on :tags
  belongs_to :content
  belongs_to :template, class_name: 'Adventure', optional: true
  has_many :children, class_name: 'Adventure', foreign_key: :template_id, dependent: :delete_all
  has_many :memberships, dependent: :delete_all
  has_many :users, through: :memberships
  has_many :steps, dependent: :delete_all
  validates :name, :locale, presence: true
  validates :locale, inclusion: { in: I18n.available_locales.map(&:to_s) }
  scope :published, -> { where(published: true, template_id: nil) }
  scope :featured, -> { where(featured: true, template_id: nil) }

  def start(user)
    return self if template_id

    solo_adventure(user) || clone_for_user(user)
  end

  def solo_adventure(user)
    children.joins(:users).where(
      id: children.joins(:users).group('adventures.id').having('count(users) = 1'),
      users: { id: user.id }
    ).first
  end

  protected

  def clone_for_user(user)
    adventure = deep_clone(include: :steps, except: %i[published featured]) do |original, copy|
      copy.template_id = original.id if copy.respond_to?(:template_id)
      copy.tag_list = original.tag_list if copy.respond_to?(:tag_list)
    end
    adventure.users << user
    adventure.save!

    adventure
  end
end
