#!/bin/sh
describe 'shtuc-path'
  it 'outputs the current directory'
    shtuc-path | grep $HOME >/dev/null
  end

  it 'outputs the project root'
    var PROJECT_ROOT "$(shtuc-project-root)"
    shtuc-path | grep "$(var PROJECT_ROOT)" >/dev/null
  end

  describe 'XDG_CONFIG_HOME is set'
    XDG_CONFIG_HOME="$(date)"

    it 'outputs XDG_CONFIG_HOME'
      shtuc-path | grep "$XDG_CONFIG_HOME" >/dev/null
    end
  end

  it "outputs the user's home directory"
    shtuc-path | grep $HOME >/dev/null
  end

  it 'outputs the default system locations'
    expect "$(shtuc-path | grep -E '(/usr/local)?/etc/shtuc.d' | wc -l)" \
    to = 2
  end
end
