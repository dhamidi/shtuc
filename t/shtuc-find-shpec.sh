#!/bin/sh
describe 'shtuc-find'
  it 'returns the first file found'
    shtuc-find shtuc-find-test >/dev/null
  end

  it 'exits with 1 if no file is found'
    shtuc-find SHTUC-NOT-FOUND >/dev/null
    expect "$?" to = 1
  end
end
