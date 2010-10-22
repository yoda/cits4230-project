module ActiveRecord
  module Blakstar
    module Like
      def self.included(base)
        base.extend(ClassMethods)
      end
    
      module ClassMethods
        def blakstar_like(options = {})
          has_many :likes, :as => :likeable, :dependent => :destroy
          
          include ActiveRecord::Blakstar::Like::InstanceMethods
        end
      end
      
      module InstanceMethods
        # Likes the object by a given value. A user object can be passed to the method.
        def like!( user )
          return unless user.is_a?(User)
          ActiveRecord::Base.transaction do
            like = self.liked_by?(user)
            if like.present?
              like.update_attribute :value, 1
            else
              like = likes.create( :value => 1, :user_id => user.id )
              self.increment!( :likes_count ) if self.respond_to?( :likes_count )
            end
            like
          end
        end
        
        def dislike!( user )
          return unless user.is_a?(User)
          ActiveRecord::Base.transaction do
            like = self.liked_by?(user)
            if like.present?
              like.update_attribute :value, -1
            else
              like = likes.create( :value => -1, :user_id => user.id )
              self.increment!( :dislikes_count ) if self.respond_to?( :dislikes_count )
            end
            like
          end
        end
        
        # Calculates the average rating. Calculation based on the already given values.
        def average_like
          return 0 if likes.empty?
          count_likes! + count_dislikes!
        end
        
        def count_likes!
          self.respond_to?( :likes_count) ? self.likes_count : likes.count(:conditions => 'value = 1')
        end
        
        def count_dislikes!
          self.respond_to?( :dislikes_count) ? self.dislikes_count : likes.count(:conditions => 'value = -1')
        end
        
        def update_liked!(user, type)
          case type.to_s.strip
          when "like"
            like! user
          when "dislike"
            dislike! user
          when "forget"
            forget_likes! user
          end
        end
        
        def forget_likes!(user)
          like = liked_by?(user)
          like && like.destroy
        end
        
        # Checks wheter a user liked or disliked the object or not.
        def liked_by?( user )
          return false if user.blank? || !user.is_a?(User)
          likes.detect {|l| l.user_id == user.id }
        end
      end
      
    end
  end
end
