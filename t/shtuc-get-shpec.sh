#!/bin/sh
describe 'shtuc-get'
  describe 'the requested file exists'
    it 'outputs the contents of a non-executable'
      expect "$(shtuc-get shtuc-find-test)" to = success
    end

    describe 'getting executables'
      it 'executes executables'
        expect "$(shtuc-get shtuc-get-executable)" to = success
      end

      it 'forwards STDIN'
        expect "$(echo hello | shtuc-get shtuc-get-test-fd)" to = hello
      end

      it 'forwards positional parameters'
        expect "$(shtuc-get shtuc-get-test-param 5 5)" to = 25
      end

      it 'preserves the executables exit status'
        expect "$(shtuc-get shtuc-get-test-exit; echo $?)" to = 3
      end
    end
  end

  (describe 'the requested file does not exist'
    key=shtuc-get-__failure__
    dir="${SHTUC_TEST_DIR:-$PWD}/.shtuc.d/.shtuc"

    # see /usr/include/sysexits.h for definition of EX_NOINPUT
    it 'exits with EX_NOINPUT'
      expect "$(shtuc-get $key; echo $?)" to = 66
    end

    describe '.shtuc/unknown'
      (it 'uses .shtuc/unknown if available'
        echo unknown > "$dir/unknown"
        trap "rm $dir/unknown" EXIT
        expect "$(shtuc-get $key)" to = unknown
       end)

      (it 'sets SHTUC_KEY'
        echo 'printf "%s\n" "$SHTUC_KEY"' > "$dir/unknown"
        chmod +x "$dir/unknown"
        trap "rm $dir/unknown" EXIT
        expect "$(shtuc-get $key)" to = "$key"
       end)
    end
  end)
end
