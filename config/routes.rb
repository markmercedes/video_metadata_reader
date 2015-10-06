Rails.application.routes.draw do
  post 'video_info' => 'video_info#metadata', defaults: { format: :json }
end
