#!/bin/sh
describe 'shtuc-root'
  describe 'default behavior'
    it 'outputs shtuc-local-root'
      expect "$(shtuc-root)" to = "$(shtuc-local-root)"
    end
  end

  describe 'invoked with'
    describe  'a valid argument'
    for arg in local global system
    do
      it "outputs shtuc-$arg-root"
        expect "$(shtuc-root $arg)" to = "$(shtuc-$arg-root)"
      end
    done
    end

    describe 'an invalid argument'
      it 'exits with EX_USAGE'
        shtuc-root invalid >/dev/null
        expect $? to = 64
      end
    end
  end
end
