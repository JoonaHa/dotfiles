return {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    config = function ()
        require('nvim-web-devicons').set_icon(
          {
            deb = { icon = "", name = "Deb" },
            lock = { icon = "", name = "Lock" },
            mp3 = { icon = "", name = "Mp3" },
            mp4 = { icon = "", name = "Mp4" },
            out = { icon = "", name = "Out" },
            ["robots.txt"] = { icon = "ﮧ", name = "Robots" },
            ttf = { icon = "", name = "TrueTypeFont" },
            rpm = { icon = "", name = "Rpm" },
            woff = { icon = "", name = "WebOpenFontFormat" },
            woff2 = { icon = "", name = "WebOpenFontFormat2" },
  }
)
    end
}
