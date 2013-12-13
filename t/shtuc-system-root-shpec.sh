#!/bin/sh
describe 'shtuc-system-root'
  lines=$(shtuc-system-root)
  expect "$lines" to : '.+'

  it 'outputs /usr/local/etc/shtuc.d first'
    expect "$(printf "%s\n" $lines | head -n 1)" \
    to = /usr/local/etc/shtuc.d
  end

  it 'outputs /etc/shtuc.d'
    expect "$(printf "%s\n" $lines | tail -n +2)" \
    to = /etc/shtuc.d
  end
end
