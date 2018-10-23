FactoryBot.define do
  factory :package do
    name             { 'test' }
    version          { '0.0.1' }
    publication_date { 2.days.ago }
    title            { 'test package' }
    description      { 'package description' }
    authors do
      [
        {
          'name' => 'Abdulmonem Alsaleh',
          'email' => nil,
          'roles' => %w(cre aut)
        },
        {
          'name' => 'Robert Weeks',
          'email' => nil,
          'roles' => ['aut']
        },
        {
          'name' => 'Ian Morison',
          'email' => nil,
          'roles' => ['aut']
        }
      ]
    end
    maintainers do
      [
        {
          'name' => 'Abdulmonem Alsaleh',
          'email' => 'a.alsaleh@hotmail.co.nz',
          'roles' => ['cre']
        }
      ]
    end
  end
end
