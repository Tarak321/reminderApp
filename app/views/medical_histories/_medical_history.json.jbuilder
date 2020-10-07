json.extract! medical_history, :id, :illness, :drname, :medicine, :start_date, :end_date, :dosage_amount, :dosage_frequency, :dosage_time, :email_notify, :user_id, :dependent_id, :created_at, :updated_at
json.url medical_history_url(medical_history, format: :json)
