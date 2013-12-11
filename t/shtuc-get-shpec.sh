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

  describe 'the requested file does not exist'
    var key shtuc-get-__failure__
    var dir "${SHTUC_TEST_DIR:-$PWD}/.shtuc.d/.shtuc"

    # see /usr/include/sysexits.h for definition of EX_NOINPUT
    it 'exits with EX_NOINPUT'
      expect "$(shtuc-get $(var key); echo $?)" to = 66
    end

    it 'uses .shtuc/unknown if available'
      echo unknown > "$(var dir)/unknown"
      trap "rm $(var dir)/unknown" 0
      expect "$(shtuc-get $(var key))" to = unknown
    end
  end
end
