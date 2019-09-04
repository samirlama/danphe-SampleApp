class User < ApplicationRecord
    has_many :microposts, dependent: :destroy
    has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
    has_many  :following, through: :active_relationships, source: :followed
    has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
    has_many :followers, through: :passive_relationships, source: :follower
    attr_accessor :remember_token, :activation_token, :reset_token      
    before_save :downcase_email
    before_create :create_activation_digest
    # after_create :send_email
    # at right hand side self is optional
    validates :name , presence: true , length: {maximum: 50}
   
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email , presence: true ,
     length: {maximum: 255} , 
     format: {
        with: VALID_EMAIL_REGEX ,
    },
    uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }

    def follow(other_user)
        active_relationships.create(followed_id: other_user.id)
    end
    
      # Unfollows a user.
      def unfollow(other_user)
        active_relationships.find_by(followed_id: other_user.id).destroy
      end
    
      # Returns true if the current user is following the other user.
      def following?(other_user)
        active_relationships.find_by(followed_id: other_user.id)
      end
    
    def downcase_email
        self.email = email.downcase
    end
    
    def digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
        # Returns a random token.
    def new_token
        SecureRandom.urlsafe_base64
    end

    def remember
        self.remember_token = new_token
        update_attribute(:remember_digest, digest(remember_token))
    end

    def authenticated?(attribute, token)
        digest = self.send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    def forget
        update_attribute(:remember_digest, nil)
    end

    def create_activation_digest
        self.activation_token = new_token
        self.activation_digest = digest(activation_token)    
    end

    # def send_email
    #     UserMailer.account_activation(self).deliver_now
    # end

    def activate
        update_columns(activated: true, activation_at: Time.zone.now)
    end

    def create_reset_digest
       self.reset_token = new_token
       self.reset_digest = digest(reset_token) 
       update_columns(reset_digest:  digest(reset_token), reset_sent_at: Time.zone.now)
    end

    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end

    def feed
        Micropost.where(user_id: self.id)
    end
end
