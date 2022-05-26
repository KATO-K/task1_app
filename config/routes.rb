Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  
  get 'home/top'
  devise_for :users,
  controllers: {
      
      confirmations: 'users/confirmations'
      
    }

  devise_scope :user do
    put 'confirmation', to: 'users/confirmations#show', as: :back_confirmation
  end
end