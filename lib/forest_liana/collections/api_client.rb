class Forest::ApiClient
  include ForestLiana::Collection

  collection :api_clients
  action 'New Secret Key'
end
