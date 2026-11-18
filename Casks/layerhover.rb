cask "layerhover" do
  version "1.6.0"
  sha256 "74590bb6c33fa0f1e6ef1ed0e14fecec44c9db2f6e42e8c2ffb67bfd9a8b7b9e"

  url "https://github.com/kjh13242/layerhover/releases/download/v#{version}/Layerhover.zip"
  name "Layerhover for Figma"
  desc "Unofficial Figma companion: edge-reveal panels, page switcher, activity log"
  homepage "https://github.com/kjh13242/layerhover"

  depends_on macos: :ventura

  app "Layerhover/Layerhover.app"

  # Apple 개발자 인증서로 서명하지 않은 앱이라, 내려받을 때 붙는 격리 표시를 지워야 열린다.
  postflight do
    system_command "/usr/bin/xattr",
                   args:         ["-dr", "com.apple.quarantine", "#{appdir}/Layerhover.app"],
                   must_succeed: false
  end

  uninstall quit: "app.layerhover.Layerhover"

  zap trash: [
    "~/Library/Application Support/Layerhover",
    "~/Library/Logs/Layerhover.log",
    "~/Library/Logs/Layerhover.old.log",
    "~/Library/Preferences/app.layerhover.Layerhover.plist",
  ]

  caveats <<~EOS
    Layerhover를 처음 열면 손쉬운 사용 권한을 허용해야 합니다:
      시스템 설정 > 개인정보 보호 및 보안 > 손쉬운 사용 > Layerhover 켜기

    업데이트한 뒤에는 권한을 다시 허용해야 할 수 있습니다:
      tccutil reset Accessibility app.layerhover.Layerhover
      open #{appdir}/Layerhover.app
  EOS
end
