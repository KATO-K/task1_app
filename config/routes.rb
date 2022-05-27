Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_scope :user do
    root "users/sessions#new"
  end
  
  get 'home/top'
  devise_for :users,
  controllers: {
      
      confirmations: 'users/confirmations'
      
    }

  devise_scope :user do
    put 'confirmation', to: 'users/confirmations#show', as: :back_confirmation
  end
end