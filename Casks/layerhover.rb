cask "layerhover" do
  version "1.9.0"
  sha256 "2c531ca5dd6c6c72fa884fa434b45714af99b09f373389b722dad6f165a64039"

  url "https://github.com/kjh13242/layerhover/releases/download/v#{version}/Layerhover.zip"
  name "Layerhover for Figma"
  desc "Unofficial Figma companion: edge-reveal panels, page switcher, activity log"
  homepage "https://github.com/kjh13242/layerhover"

  depends_on macos: :ventura
  # 1.6.1부터 앱이 스스로 업데이트한다 (brew upgrade 가 따로 덮어쓰지 않도록)
  auto_updates true

  app "Layerhover/Layerhover.app"

  # Apple 개발자 인증서로 서명하지 않은 앱이라, 내려받을 때 붙는 격리 표시를 지워야 열린다.
  postflight_steps(default_base: :appdir) do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Layerhover.app"],
        writable_paths: ["Layerhover.app"],
        must_succeed:   false
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

    1.6.1부터는 앱이 스스로 업데이트하고, 업데이트해도 권한이 유지됩니다.
    1.6.0 이하에서 올라올 때만 권한을 한 번 다시 허용해야 할 수 있습니다:
      tccutil reset Accessibility app.layerhover.Layerhover
      open #{appdir}/Layerhover.app
  EOS
end
