#!/bin/sh
describe "shtuc-project-root"
  describe 'when in a git repository'
    it 'outputs the top level git dir'
      expect "$(shtuc-project-root)" to = "$(git rev-parse --show-toplevel)"
    end
  end

  describe 'when not in a git repository'
    it 'does not output anything'
      expect "$(cd /tmp; shtuc-project-root)" to = ""
    end
  end
end
