TERMUX_PKG_HOMEPAGE=https://github.com/zen-studi/NyxRecon
TERMUX_PKG_DESCRIPTION="NyxRecon Recon Automation Tool"
TERMUX_PKG_LICENSE="MIT"
TERMUX_PKG_VERSION=1.0
TERMUX_PKG_SRCURL=https://github.com/zen-studi/NyxRecon/archive/refs/heads/main.zip
TERMUX_PKG_SHA256=SKIP_CHECKSUM

termux_step_make_install() {
  mkdir -p $TERMUX_PREFIX/bin
  cp nyxrecon.sh $TERMUX_PREFIX/bin/nyxrecon
  chmod +x $TERMUX_PREFIX/bin/nyxrecon
}
