#!/bin/sh
describe 'shtuc-set'
  describe 'storage location'
    (it 'is the first line from "shtuc-path"'
      expected_location=$(shtuc-path | head -1)/var
      actual_location=$(shtuc-set var value)
      trap "rm $actual_location" EXIT
      expect "$actual_location" to = "$expected_location"
    end)
  end

  (describe 'options'
    test_executable() {
      describe "$1"
        it "is executable"
          location=$(shtuc-set "$1" var 'echo value')
          trap "rm $location" EXIT
          expect "$(shtuc-get var)" to = value
        end
      end
    }

    test_executable '-x'
    test_executable '--executable'
  end)

  (describe 'overwriting a directory with a file'
    trap 'rm "$file_loc"; rmdir "$dir_loc"' EXIT
    file_loc=$(shtuc-set foo/bar value)
    dir_loc=$(shtuc-set foo value) 2>/dev/null
    status=$?

    it 'exits with EX_IOERR'
      expect "$status" to = 74
    end

    it 'outputs the path to the file'
      expect "$dir_loc" to : '.*/foo$'
    end)
  end
end
