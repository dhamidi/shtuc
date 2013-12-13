#!/bin/sh
describe 'shtuc-local-root'
  describe 'in a project'
    (it 'outputs the project directory'
      project_dir=$(git rev-parse --show-toplevel)
      expect "$(shtuc-local-root)" to = "$project_dir/.shtuc.d"
    end)
  end

  describe 'not in a project'
    (it 'outputs the current directory'
      working_directory=/
      cd $working_directory
      expect "$(shtuc-local-root)" to = "${working_directory}.shtuc.d"
     end)
  end
end
