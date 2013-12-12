#!/bin/sh
describe 'shtuc'
  key=set_this_value

  describe 'when called with one argument'
    it 'retrieves the key given as the argument'
      expect "$(shtuc shtuc-find-test)" to = success
    end
  end

  describe 'setting a variable'
    (it 'outputs the storage location'
      trap 'rm $(shtuc-find $key)' EXIT
      expect "$(shtuc $key location)" to : ".*\.shtuc\.d/$key"
    end)
  end

  describe 'when called with two arguments'
    (it 'stores the second argument as the value of the first'
      shtuc $key success >/dev/null
      trap 'rm $(shtuc-find $key)' EXIT
      expect "$(shtuc $key)" to = success
    end)
  end

  describe 'when called with three arguments'
    describe 'and the second is "run"'
      (it 'stores the third argument as the executable value of the first'
        shtuc $key run 'expr 1 + 1' >/dev/null
        trap 'rm $(shtuc-find $key)' EXIT
        expect "$(shtuc $key)" to = 2
      end)
    end

    describe 'and the second argument is not "run"'
      it 'exits with EX_USAGE'
        shtuc $key not-run date
        expect "$?" to = 64 # EX_USAGE
      end
    end
  end
end
