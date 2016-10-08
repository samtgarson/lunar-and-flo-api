module CheckInHelpers
  def check_in(user, symptom, check_in_options = {})
    options = check_in_options.merge user: user
    create :check_in_symptom, check_in: build(:check_in, options), symptom: symptom
  end

  def generate_check_ins(n, user, _options = {})
    group = build :symptom_group
    symptoms = create_list(:symptom, n + 1, supplement_count: 3, symptom_group: group)

    (1..n).each do |m|
      check_ins = create_list(:check_in, m, user: user)
      m.times { |o| check_ins[o].check_in_symptoms.create! symptom: symptoms[o] }
    end

    symptoms.select { |s| s.check_in_symptoms.any? }
  end
end
