require 'test_helper'

class V1::SymptomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @symptoms = create_list :symptom, 3
  end

  test 'should get index' do
    get symptoms_url

    assert_equal @symptoms.count, json_response.count
    assert_response :success
  end

  test 'should get show' do
    get symptom_url(id: @symptoms.first.id)

    assert_equal @symptoms.first.id, json_response['id']
    assert_response :success
  end
end
