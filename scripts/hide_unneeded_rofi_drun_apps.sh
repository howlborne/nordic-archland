#!/bin/bash

echo "Hiding unneeded applications from rofi drun..."

unneeded=(
    /usr/share/applications/assistant.desktop
    /usr/share/applications/avahi-discover.desktop
    /usr/share/applications/breezestyleconfig.desktop
    /usr/share/applications/bssh.desktop
    /usr/share/applications/bvnc.desktop
    /usr/share/applications/cmake-gui.desktop
    /usr/share/applications/defaults.list
    /usr/share/applications/designer.desktop
    /usr/share/applications/electron37.desktop
    /usr/share/applications/gcr-prompter.desktop
    /usr/share/applications/gcr-viewer.desktop
    /usr/share/applications/google-maps-geo-handler.desktop
    /usr/share/applications/gtk-lshw.desktop
    /usr/share/applications/java-java-openjdk.desktop
    /usr/share/applications/jconsole-java-openjdk.desktop
    /usr/share/applications/jshell-java-openjdk.desktop
    /usr/share/applications/kcm_animations.desktop
    /usr/share/applications/kcm_autostart.desktop
    /usr/share/applications/kcm_breezedecoration.desktop
    /usr/share/applications/kcm_colors.desktop
    /usr/share/applications/kcm_componentchooser.desktop
    /usr/share/applications/kcm_cursortheme.desktop
    /usr/share/applications/kcm_desktoptheme.desktop
    /usr/share/applications/kcm_feedback.desktop
    /usr/share/applications/kcm_filetypes.desktop
    /usr/share/applications/kcm_fontinst.desktop
    /usr/share/applications/kcm_fonts.desktop
    /usr/share/applications/kcm_icons.desktop
    /usr/share/applications/kcm_kaccounts.desktop
    /usr/share/applications/kcm_kwin_effects.desktop
    /usr/share/applications/kcm_kwin_scripts.desktop
    /usr/share/applications/kcm_kwin_virtualdesktops.desktop
    /usr/share/applications/kcm_kwindecoration.desktop
    /usr/share/applications/kcm_kwinoptions.desktop
    /usr/share/applications/kcm_kwinrules.desktop
    /usr/share/applications/kcm_kwintabbox.desktop
    /usr/share/applications/kcm_kwinxwayland.desktop
    /usr/share/applications/kcm_lookandfeel.desktop
    /usr/share/applications/kcm_netpref.desktop
    /usr/share/applications/kcm_nightlight.desktop
    /usr/share/applications/kcm_nighttime.desktop
    /usr/share/applications/kcm_notifications.desktop
    /usr/share/applications/kcm_proxy.desktop
    /usr/share/applications/kcm_regionandlang.desktop
    /usr/share/applications/kcm_screenlocker.desktop
    /usr/share/applications/kcm_soundtheme.desktop
    /usr/share/applications/kcm_style.desktop
    /usr/share/applications/kcm_trash.desktop
    /usr/share/applications/kcm_users.desktop
    /usr/share/applications/kcm_virtualkeyboard.desktop
    /usr/share/applications/kcm_wallpaper.desktop
    /usr/share/applications/kcm_webshortcuts.desktop
    /usr/share/applications/kdesystemsettings.desktop
    /usr/share/applications/kitty-open.desktop
    /usr/share/applications/ktelnetservice6.desktop
    /usr/share/applications/libreoffice-xsltfilter.desktop
    /usr/share/applications/linguist.desktop
    /usr/share/applications/lstopo.desktop
    /usr/share/applications/mimeinfo.cache
    /usr/share/applications/mpv.desktop
    /usr/share/applications/nvim.desktop
    /usr/share/applications/okularApplication_comicbook.desktop
    /usr/share/applications/okularApplication_djvu.desktop
    /usr/share/applications/okularApplication_dvi.desktop
    /usr/share/applications/okularApplication_epub.desktop
    /usr/share/applications/okularApplication_fax.desktop
    /usr/share/applications/okularApplication_fb.desktop
    /usr/share/applications/okularApplication_ghostview.desktop
    /usr/share/applications/okularApplication_kimgio.desktop
    /usr/share/applications/okularApplication_md.desktop
    /usr/share/applications/okularApplication_mobi.desktop
    /usr/share/applications/okularApplication_pdf.desktop
    /usr/share/applications/okularApplication_tiff.desktop
    /usr/share/applications/okularApplication_txt.desktop
    /usr/share/applications/okularApplication_xps.desktop
    /usr/share/applications/openstreetmap-geo-handler.desktop
    /usr/share/applications/org.freedesktop.impl.portal.desktop.kde.desktop
    /usr/share/applications/org.freedesktop.Xwayland.desktop
    /usr/share/applications/org.gnome.seahorse.Application.desktop
    /usr/share/applications/org.gnupg.pinentry-qt.desktop
    /usr/share/applications/org.gnupg.pinentry-qt5.desktop
    /usr/share/applications/org.kde.kcolorschemeeditor.desktop
    /usr/share/applications/org.kde.kded6.desktop
    /usr/share/applications/org.kde.keditfiletype.desktop
    /usr/share/applications/org.kde.kfontinst.desktop
    /usr/share/applications/org.kde.kfontview.desktop
    /usr/share/applications/org.kde.kiod6.desktop
    /usr/share/applications/org.kde.klipper.desktop
    /usr/share/applications/org.kde.knewstuff-dialog6.desktop
    /usr/share/applications/org.kde.knighttimed.desktop
    /usr/share/applications/org.kde.ksecretd.desktop
    /usr/share/applications/org.kde.kwin.killer.desktop
    /usr/share/applications/org.kde.kwrite.desktop
    /usr/share/applications/org.kde.plasma-fallback-session-save.desktop
    /usr/share/applications/org.kde.plasma-interactiveconsole.desktop
    /usr/share/applications/org.kde.plasmashell.desktop
    /usr/share/applications/org.kde.plasmawindowed.desktop
    /usr/share/applications/phoronix-test-suite.desktop
    /usr/share/applications/phoronix-test-suite-launcher.desktop
    /usr/share/applications/qdbusviewer.desktop
    /usr/share/applications/qemu.desktop
    /usr/share/applications/qv4l2.desktop
    /usr/share/applications/qvidcap.desktop
    /usr/share/applications/rofi.desktop
    /usr/share/applications/rofi-theme-selector.desktop
    /usr/share/applications/satty.desktop
    /usr/share/applications/signon-ui.desktop
    /usr/share/applications/wheelmap-geo-handler.desktop
    /usr/share/applications/xdg-desktop-portal-gtk.desktop
    /usr/share/applications/xgps.desktop
    /usr/share/applications/xgpsspeed.desktop
    /usr/share/applications/org.kde.plasma.settings.open.desktop
)

sudo mkdir -p /usr/share/applications/rofi
sudo mkdir -p /usr/share/applications/unneeded

for app in "${unneeded[@]}"; do
    mv $app /usr/share/applications/unneeded
done

mv /usr/share/applications/*.desktop /usr/share/applications/rofi

mv /usr/share/applications/unneeded/* /usr/share/applications/

for app in "${unneeded[@]}"; do
    grep -q '^NoDisplay=' "$app" || echo 'NoDisplay=true' >> "$app"
done

mv /usr/share/applications/rofi/* /usr/share/applications/

sleep 5

rm -r /usr/share/applications/rofi /usr/share/applications/unneeded

echo "Done!"
