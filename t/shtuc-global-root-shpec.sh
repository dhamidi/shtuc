#!/bin/sh
describe 'shtuc-global-root'
  (it 'respects $XDG_CONFIG_HOME'
      XDG_CONFIG_HOME=/tmp
      expect "$(shtuc-global-root)" to = /tmp/shtuc
  end)

  (it 'falls back to $HOME'
      # just in case
      unset XDG_CONFIG_HOME
      HOME=/tmp
      expect "$(shtuc-global-root)" to = /tmp/.shtuc.d
  end)
end
