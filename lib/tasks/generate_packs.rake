desc "Generate new packs for any users that need them"
task :generate_packs do
  User.needs_new_pack.find_each do |user|
    GeneratePack.call(user: user)
  end
end
