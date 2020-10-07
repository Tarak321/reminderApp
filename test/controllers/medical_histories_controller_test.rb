require 'test_helper'

class MedicalHistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @medical_history = medical_histories(:one)
  end

  test "should get index" do
    get medical_histories_url
    assert_response :success
  end

  test "should get new" do
    get new_medical_history_url
    assert_response :success
  end

  test "should create medical_history" do
    assert_difference('MedicalHistory.count') do
      post medical_histories_url, params: { medical_history: { dependent_id: @medical_history.dependent_id, dosage_amount: @medical_history.dosage_amount, dosage_frequency: @medical_history.dosage_frequency, dosage_time: @medical_history.dosage_time, drname: @medical_history.drname, email_notify: @medical_history.email_notify, end_date: @medical_history.end_date, illness: @medical_history.illness, medicine: @medical_history.medicine, start_date: @medical_history.start_date, user_id: @medical_history.user_id } }
    end

    assert_redirected_to medical_history_url(MedicalHistory.last)
  end

  test "should show medical_history" do
    get medical_history_url(@medical_history)
    assert_response :success
  end

  test "should get edit" do
    get edit_medical_history_url(@medical_history)
    assert_response :success
  end

  test "should update medical_history" do
    patch medical_history_url(@medical_history), params: { medical_history: { dependent_id: @medical_history.dependent_id, dosage_amount: @medical_history.dosage_amount, dosage_frequency: @medical_history.dosage_frequency, dosage_time: @medical_history.dosage_time, drname: @medical_history.drname, email_notify: @medical_history.email_notify, end_date: @medical_history.end_date, illness: @medical_history.illness, medicine: @medical_history.medicine, start_date: @medical_history.start_date, user_id: @medical_history.user_id } }
    assert_redirected_to medical_history_url(@medical_history)
  end

  test "should destroy medical_history" do
    assert_difference('MedicalHistory.count', -1) do
      delete medical_history_url(@medical_history)
    end

    assert_redirected_to medical_histories_url
  end
end
