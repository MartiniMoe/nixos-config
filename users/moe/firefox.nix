{ config, pkgs, lib, ... }:

{
  # Firefox
  programs.firefox = {
    enable = true;
    profiles.moe = {
      isDefault = true;
      settings = {
        "app.normandy.first_run" = false;
        "app.shield.optoutstudies.enabled" = false;
        "browser.startup.homepage" = "https://duckduckgo.com";
        "browser.tabs.loadInBackground" = true;
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.uidensity" = 1;
        "browser.search.regior" = "DE";
        "general.useragent.locale" = "de-DE";
        "distribution.searchplugins.defaultLocale" = "de-DE";
        "privacy.donotttrackheader.enabled" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.ffvpx.enabled" = false;
        "media.rdd-vpx.enabled" = false;
        "media.navigator.mediadatadecoder_vpx_enabled" = true;
      };
    };
  };
}
