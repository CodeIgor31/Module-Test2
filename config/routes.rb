# frozen_string_literal: true

Rails.application.routes.draw do
  root 'arrays#input', as: :home
  get 'arrays/result'
end
