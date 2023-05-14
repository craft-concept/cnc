Rails.application.routes.draw do
  mount CNC::Engine => "/cnc"
end
