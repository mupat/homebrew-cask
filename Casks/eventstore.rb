cask 'eventstore' do
  version '3.9.3'
  sha256 'a4ceca878a833e4f30235b08ce1764d5072935484c126c93fb05ab2188a2a9ee'

  url "http://download.geteventstore.com/binaries/EventStore-OSS-MacOSX-v#{version}.tar.gz"
  name 'Event Store'
  homepage 'http://geteventstore.com'

  binary 'eventstore'
  binary 'eventstore-testclient'

  # shim script (https://github.com/caskroom/homebrew-cask/issues/18809)
  shimscript = "#{staged_path}/eventstore"

  preflight do
    IO.write shimscript, <<-EOS.undent
      #!/bin/sh
      cd "#{staged_path}"
      exec "#{staged_path}/run-node.sh" "$@"
    EOS
    FileUtils.chmod '+x', shimscript
  end

  # shim script (https://github.com/caskroom/homebrew-cask/issues/18809)
  shimscript = "#{staged_path}/eventstore-testclient"

  preflight do
    IO.write shimscript, <<-EOS.undent
      #!/bin/sh
      exec "#{staged_path}/testclient" "$@"
    EOS
    FileUtils.chmod '+x', shimscript
  end
end