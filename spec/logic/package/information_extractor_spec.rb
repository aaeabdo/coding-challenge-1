require 'spec_helper'
require_relative '../../../logic/package/information_extractor'

# Ideally we should be more concise about the different cases
# For brevity, I added the first 5 packages descriptions and their parsing results as test cases
RSpec.describe Logic::Package::InformationExtractor do
  subject(:call) { described_class.call(package_description) }
  context '.call' do
    [
      {
        package_description:   {
          "Package"          => "A3",
          "Type"             => "Package",
          "Title"            => "Accurate, Adaptable, and Accessible Error Metrics for ...",
          "Version"          => "1.0.0",
          "Date"             => "2015-08-15",
          "Author"           => "Scott Fortmann-Roe",
          "Maintainer"       => "Scott Fortmann-Roe <scottfr@berkeley.edu>",
          "Description"      => "Supplies tools for tabulating and analyzing the results of ...",
          "License"          => "GPL (>= 2)",
          "Depends"          => "R (>= 2.15.0), xtable, pbapply",
          "Suggests"         => "randomForest, e1071",
          "NeedsCompilation" => "no",
          "Packaged"         => "2015-08-16 14:17:33 UTC; scott",
          "Repository"       => "CRAN",
          "Date/Publication" => "2015-08-16 23:05:52"
        },
        parsed_description:   {
          name:             "A3",
          version:          "1.0.0",
          publication_date: "2015-08-16 23:05:52",
          title:            "Accurate, Adaptable, and Accessible Error Metrics for ...",
          description:      "Supplies tools for tabulating and analyzing the results of ...",
          authors: [
            {
              name: "Scott Fortmann-Roe",
              email: nil,
              roles: ["aut"]
            }
          ],
          maintainers:      [
            {
              name: "Scott Fortmann-Roe",
              email: "scottfr@berkeley.edu",
              roles: ["cre"]
            }
          ]
        }
      },
      {
        package_description:   {
          "Package"   => "abbyyR",
          "Title"     => "Access to Abbyy Optical Character Recognition (OCR) API",
          "Version"   => "0.5.4",
          "Authors@R" => "person(\"Gaurav\", \"Sood\", email = \"gsood07@gmail.com\", "\
            "role = c(\"aut\", \"cre\"))",
          "Maintainer"       => "Gaurav Sood <gsood07@gmail.com>",
          "Description"      => "Get text from images of text using Abbyy Cloud Optical Cha ...",
          "URL"              => "http://github.com/soodoku/abbyyR",
          "BugReports"       => "http://github.com/soodoku/abbyyR/issues",
          "Depends"          => "R (>= 3.2.0)",
          "License"          => "MIT + file LICENSE",
          "LazyData"         => "true",
          "VignetteBuilder"  => "knitr",
          "Imports"          => "httr, XML, curl, readr, plyr, progress",
          "Suggests"         => "testthat, rmarkdown, knitr (>= 1.11), lintr",
          "RoxygenNote"      => "6.0.1.9000",
          "NeedsCompilation" => "no",
          "Packaged"         => "2018-05-30 12:47:37 UTC; soodoku",
          "Author"           => "Gaurav Sood [aut, cre]",
          "Repository"       => "CRAN",
          "Date/Publication" => "2018-05-30 13:20:41 UTC"
        },
        parsed_description: {
          name:             "abbyyR",
          version:          "0.5.4",
          publication_date: "2018-05-30 13:20:41 UTC",
          title:            "Access to Abbyy Optical Character Recognition (OCR) API",
          description:      "Get text from images of text using Abbyy Cloud Optical Cha ...",
          authors:          [
            {
              name: "Gaurav Sood",
              roles: ["aut", "cre"],
              email: "gsood07@gmail.com"
            }
          ],
          maintainers: [
            {
              name: "Gaurav Sood",
              roles: ["aut", "cre"],
              email: "gsood07@gmail.com"
            },
            {
              name: "Gaurav Sood",
              email: "gsood07@gmail.com",
              roles: ["cre"]
            }
          ]
        }
      },
      {
        package_description: {
          "Package"   => "abc",
          "Type"      => "Package",
          "Title"     => "Tools for Approximate Bayesian Computation (ABC)",
          "Version"   => "2.1",
          "Date"      => "2015-05-04",
          "Authors@R" =>
            "c(  person(\"Csillery\", \"Katalin\", role = \"aut\", "\
            "email=\"kati.csillery@gmail.com\"), person(\"Lemaire\", \"Louisiane\", "\
            "role = \"aut\"), person(\"Francois\", \"Olivier\", role = \"aut\"), "\
            "person(\"Blum\", \"Michael\", email = \"michael.blum@imag.fr\", "\
            "role = c(\"aut\", \"cre\")))",
          "Depends"          => "R (>= 2.10), abc.data, nnet, quantreg, MASS, locfit",
          "Description"      => "Implements several ABC algorithms for ...",
          "Repository"       => "CRAN",
          "License"          => "GPL (>= 3)",
          "NeedsCompilation" => "no",
          "Packaged"         => "2015-05-05 08:35:25 UTC; mblum",
          "Author"           =>
           "Csillery Katalin [aut], Lemaire Louisiane [aut], Francois Olivier [aut], Blum Michael [aut, cre]",
          "Maintainer"       => "Blum Michael <michael.blum@imag.fr>",
          "Date/Publication" => "2015-05-05 11:34:14"
        },
        parsed_description: {
          name:             "abc",
          version:          "2.1",
          publication_date: "2015-05-05 11:34:14",
          title:            "Tools for Approximate Bayesian Computation (ABC)",
          description:      "Implements several ABC algorithms for ...",
          authors:          [
            {
              name: "Lemaire Louisiane",
              roles: ["aut"],
              email: nil
            },
            {
              name: "Francois Olivier",
              roles: ["aut"],
              email: nil
            },
            {
              name: "Blum Michael",
              roles: ["aut", "cre"],
              email: "michael.blum@imag.fr"
            }
          ],
          maintainers: [
            {
              name: "Blum Michael",
              roles: ["aut", "cre"],
              email: "michael.blum@imag.fr"
            },
            {
              name: "Blum Michael",
              email: "michael.blum@imag.fr",
              roles: ["cre"]
            }
          ]
        }
      },
      {
        package_description:   {
          "Package"          => "abc.data",
          "Type"             => "Package",
          "Title"            => "Data Only: Tools for Approximate Bayesian Computation (ABC)",
          "Version"          => "1.0",
          "Date"             => "2015-05-04",
          "Authors@R"        => "c(  person(\"Csillery\", \"Katalin\", role = \"aut\", "\
            "email=\"kati.csillery@gmail.com\"), person(\"Lemaire\", \"Louisiane\", "\
            "role = \"aut\"), person(\"Francois\", \"Olivier\", role = \"aut\"), "\
            "person(\"Blum\", \"Michael\", email = \"michael.blum@imag.fr\", "\
            "role = c(\"aut\", \"cre\")))",
          "Depends"          => "R (>= 2.10)",
          "Description"      => "Contains data which are used by functions of the 'abc' package.",
          "Repository"       => "CRAN",
          "License"          => "GPL (>= 3)",
          "NeedsCompilation" => "no",
          "Packaged"         => "2015-05-05 09:25:25 UTC; mblum",
          "Author"           => "Csillery Katalin [aut], Lemaire Louisiane [aut], "\
            "Francois Olivier [aut], Blum Michael [aut, cre]",
          "Maintainer"       => "Blum Michael <michael.blum@imag.fr>",
          "Date/Publication" => "2015-05-05 11:34:13"
      },
        parsed_description: {
          name:             "abc.data",
          version:          "1.0",
          publication_date: "2015-05-05 11:34:13",
          title:            "Data Only: Tools for Approximate Bayesian Computation (ABC)",
          description:      "Contains data which are used by functions of the 'abc' package.",
          authors:          [
            {
              name: "Lemaire Louisiane",
              roles: ["aut"],
              email: nil
            },
            {
              name: "Francois Olivier",
              roles: ["aut"],
              email: nil
            },
            {
              name: "Blum Michael",
              roles: ["aut", "cre"],
              email: "michael.blum@imag.fr"
            }
          ],
          maintainers: [
            {
              name: "Blum Michael",
              roles: ["aut", "cre"],
              email: "michael.blum@imag.fr"
            },
            {
              name: "Blum Michael",
              email: "michael.blum@imag.fr",
              roles: ["cre"]
            }
          ]
        }
      },
      {
        package_description: {
          "Package"            => "ABC.RAP",
          "Title"              => "Array Based CpG Region Analysis Pipeline",
          "Version"            => "0.9.0",
          "Author"             => "Abdulmonem Alsaleh [cre, aut], Robert Weeks [aut], "\
            "Ian Morison [aut], RStudio [ctb]",
          "Maintainer"         => "Abdulmonem Alsaleh <a.alsaleh@hotmail.co.nz>",
          "Contact"            => "Ian Morison <ian.morison@otago.ac.nz>",
          "Description"        => "It aims to identify candidate genes that are ...",
          "License"            => "GPL-3",
          "Depends"            => "R (>= 3.1.0)",
          "Imports"            => "graphics, stats, utils",
          "Suggests"           => "knitr, rmarkdown",
          "VignetteBuilder"    => "knitr",
          "Encoding"           => "UTF-8",
          "SystemRequirements" => "GNU make",
          "RoxygenNote"        => "5.0.1.9000",
          "NeedsCompilation"   => "no",
          "Packaged"           => "2016-10-20 01:50:08 UTC; abdul",
          "Repository"         => "CRAN",
          "Date/Publication"   => "2016-10-20 10:52:16"
        },
        parsed_description:   {
          name:             "ABC.RAP",
          version:          "0.9.0",
          publication_date: "2016-10-20 10:52:16",
          title:            "Array Based CpG Region Analysis Pipeline",
          description:      "It aims to identify candidate genes that are ...",
          authors:          [
            { name: "Abdulmonem Alsaleh", email: nil, roles: ["cre", "aut"] },
            { name: "Robert Weeks", email: nil, roles: ["aut"] },
            { name: "Ian Morison", email: nil, roles: ["aut"] }
          ],
          maintainers:     [
            {
              name:  "Abdulmonem Alsaleh",
              email: "a.alsaleh@hotmail.co.nz",
              roles: ["cre"]
            }
          ]
        }
      }
    ].each_with_index do |test_case, index|
      context "Test case: #{index}" do
        let(:package_description) { test_case[:package_description] }
        let(:result)              { test_case[:parsed_description] }

        it 'runs successfully' do
          expect(call).to eq result
        end
      end
    end
  end
end
