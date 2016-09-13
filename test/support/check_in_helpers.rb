module CheckInHelpers
  def generate_check_ins(n, user)
    symptoms = create_list(:symptom, n + 1, supplement_count: 3)

    (1..n).each do |m|
      check_ins = create_list(:check_in, m, user: user)
      m.times { |o| check_ins[o].check_in_symptoms.create! symptom: symptoms[o] }
    end

    symptoms
  end
end
