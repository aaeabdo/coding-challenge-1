module Logic
  module Package
    class InformationExtractor
      MAINTAINER_ABBREVIATION = 'cre'
      AUTHOR_ABBREVIATION     = 'aut'

      # TODO: better error handling
      def self.call(package_description)
        persons = parse_authors_maintainers(package_description)
        {
          name:             package_description.fetch('Package'),
          version:          package_description.fetch('Version'),
          publication_date: package_description.fetch('Date/Publication'),
          title:            package_description.fetch('Title'),
          description:      package_description.fetch('Description'),
          authors:          get_authors(persons),
          maintainers:      get_maintainers(persons)
        }
      end

      class << self
        private

        def get_authors(persons)
          persons
            .select { |per| per[:roles].include?(AUTHOR_ABBREVIATION) }
            .uniq { |per| per[:name] }
        end

        def get_maintainers(persons)
          persons
            .select { |per| per[:roles].include?(MAINTAINER_ABBREVIATION) && per[:email].present? }
        end

        def parse_authors_maintainers(package_description)
          authors_hashes = if package_description.key? 'Authors@R'
            parse_persons(package_description['Authors@R'])
          else
            authors = package_description['Author']
            authors_hashes = case authors
            when /.*\[.*\]/ # author with roles
              parse_authors_with_role(authors)
            else # author without roles
              parse_authors_without_role(authors)
            end

            authors_hashes
          end
          authors_hashes << parse_maintainer(package_description['Maintainer'])

          authors_hashes
        end

        def parse_maintainer(str)
          {
            name:  parse_name(str),
            email: parse_email(str),
            roles: [MAINTAINER_ABBREVIATION]
          }
        end

        def parse_authors_without_role(authors)
          authors.split(',').map do |auth_str|
            {
              name:  parse_name(auth_str),
              email: parse_email(auth_str),
              roles: [AUTHOR_ABBREVIATION]
            }
          end
        end

        def parse_authors_with_role(authors)
          authors.split(/\]\,\s*/).map do |auth_str|
            /\[(?<roles>.*)/ =~ auth_str
            roles = roles.split(/\,\s*/)
            {
              name:  parse_name(auth_str),
              email: parse_email(auth_str),
              roles: roles
            }
          end
        end

        def parse_persons(persons)
          result = case persons
          when /^c\s*\(\s*(.+)\s*\)\s*$/ # multiple persons
            $1.split(/\,*\s*person/).map do |person_str|
              parse_person(person_str)
            end.compact
          when /^\s*person(.*)/ # one person
            [parse_person($1)]
          end
          result
        end

        def parse_person(person_str)
          return nil if person_str == ""
          # clean leading and ending braces
          /\((?<person_str_sanitized>.+)\)/ =~ person_str
          person_str_sanitized_splitted = person_str_sanitized.split(/\s*\,\s*/)
          name = person_str_sanitized_splitted[0] + " " + person_str_sanitized_splitted[1]
          email_str = person_str_sanitized_splitted.find { |str| str.start_with?('email') }
          {
            name:  remove_quotations(name),
            roles: parse_roles(person_str_sanitized),
            email: parse_email(email_str)
          }
        end

        def parse_roles(roles_str)
          roles = case roles_str
          when /\s*role\s*\=\s*c\s*\(\s*(.+)\s*\)\s*$/ # multiple roles
            $1.split(/\,\s*/)
          when /\s*role\s*\=\s*(.+)\s*$/ # one role
            [$1]
          end
          roles.map { |role| remove_quotations(role) }
        end

        def parse_name(str)
          name = case str
          when /^(.*)\[/
            $1
          when /^(.*)\(/
            $1
          when /^(.*)\</
            $1
          else
            str
          end
          # remove leading 'and'
          /^(\s*and\s*)?(?<name_sanitized>.+)/ =~ name
          name_sanitized.strip
        end

        def parse_email(email_str)
          email = case email_str
          when /\s*email\s*\=\s*(.+)\s*$/
            $1
          when /\<(.*)\>/
            $1
          end

          santized_email = remove_quotations(email) if email
          santized_email
        end

        def remove_quotations(str)
          str.gsub(/\"/, '')
        end
      end
    end
  end
end
