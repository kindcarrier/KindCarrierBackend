def json_response
  return @json_response if response.body.object_id == @response_id

  @response_id = response.body.object_id
  @json_response = JSON.parse(response.body)
  @json_response
end
