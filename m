Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web09.13650.1612652932926682633
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Feb 2021 15:08:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=Ue9o13Yp;
 spf=pass (domain: gmail.com, ip: 209.85.216.54, mailfrom: akuster808@gmail.com)
Received: by mail-pj1-f54.google.com with SMTP id q72so5683788pjq.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Feb 2021 15:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=GkNA4hMGuV53132xVumyra8A3rwJjXHn8Enm3WrM7+A=;
        b=Ue9o13YphdxrJh3qciHzOHp4BFgtRqS4bCZeG9xNFx2UhKrtgphK5tdZnWlGkAcDw8
         XG5p/Q27ye9sS3TqUEYPgwwZkR/xTHcoc6m4SyyyrCgsp3PvL1R1HzhbmYG9fH+Ekfi2
         pWp94VxHBPLpiw8XAZXMrQHh02gYg5tJVpCH41mz0oITrPymO5rvFTxLe5YpGpSpz0ca
         TCaLx5YND8ayyQd3UZdvtmjOAtrM+rtZyUSmauQHr+HnULASIlIi367Tguzz3zfJfi+d
         0jYOB5MnSYKaljFp4K1yuB+z0prSWDzn7nXjvQblmuY4vtqSKj3SbhWZbQiIm0IvZmW7
         K6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=GkNA4hMGuV53132xVumyra8A3rwJjXHn8Enm3WrM7+A=;
        b=N5Y8cluJzXH4tYr3+9aYmdGB96XcTM3utZSwPWbMKGJNp4oEb8rxqa0RTsJaBmAm2Z
         2yeospZltNUNhRVcgK/l1XNdf9hGlcwHD7wXd6jO4Ysp7L64SAcVkbZNyVBxkyy43yvL
         qg4HDDceuxXyLmvcZMBiGgAWSUSJxl8mvgwikHgrth+fEZG2wz8Gakt+yiirDu/R0njD
         QFCIChypvHHVnloJHYcptDhYs5mCQzj+s2a1jpSU2Rpd1XNm+C6NPF+WO7nfFaROF9vd
         oD38zUJewNYHRcK07YEaeoZEM1u9/pp3V3Qje3nfCYfsOedZoqPAmyA14pXSdpHkGjJ7
         BIGw==
X-Gm-Message-State: AOAM530eRfBqgjuzDIjNBr9ZEweXJYNmrbeQVx5mPc0SBjfPY+BW7dB9
	JQIcHptubhiZN4OoyBAIVskt+Xh/6wgWnQ==
X-Google-Smtp-Source: ABdhPJzPfu1eg0SA2Z5m3t5+LS7fAgXE6No2xf/S1bBUzyGtL+LnmAiW+S2lwdnQVmT5AEYTAX6ZqA==
X-Received: by 2002:a17:90a:950c:: with SMTP id t12mr10225494pjo.226.1612652932220;
        Sat, 06 Feb 2021 15:08:52 -0800 (PST)
Return-Path: <akuster808@gmail.com>
Received: from akuster-ThinkPad-T460s.mvista.com ([2601:202:4180:a5c0:c5c4:f80e:4f44:b02e])
        by smtp.gmail.com with ESMTPSA id k10sm14492489pfk.0.2021.02.06.15.08.51
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 15:08:51 -0800 (PST)
From: "akuster" <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: [gatesgargh 01/10] xterm: install xterm and uxterm desktop files
Date: Sat,  6 Feb 2021 15:08:38 -0800
Message-Id: <a653238398d483c805c3d026d890162f131ecc01.1612652802.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1612652802.git.akuster808@gmail.com>
References: <cover.1612652802.git.akuster808@gmail.com>

From: Dmitry Baryshkov <dbaryshkov@gmail.com>

Modify recipe to install application desktop files for xterm.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Khem Raj <raj.khem@gmail.com>
(cherry picked from commit 593f21eda5b119f6408975c6b15e94fb168cc9dc)
---
 meta-oe/recipes-graphics/xorg-app/xterm_353.bb | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/meta-oe/recipes-graphics/xorg-app/xterm_353.bb b/meta-oe/recipes-graphics/xorg-app/xterm_353.bb
index 6de704d0b7..6376388c27 100644
--- a/meta-oe/recipes-graphics/xorg-app/xterm_353.bb
+++ b/meta-oe/recipes-graphics/xorg-app/xterm_353.bb
@@ -1,6 +1,6 @@
 require recipes-graphics/xorg-app/xorg-app-common.inc
 SUMMARY = "xterm is the standard terminal emulator for the X Window System"
-DEPENDS = "libxaw xorgproto libxext libxau libxinerama libxpm ncurses"
+DEPENDS = "libxaw xorgproto libxext libxau libxinerama libxpm ncurses desktop-file-utils-native"
 
 LIC_FILES_CHKSUM = "file://xterm.h;beginline=3;endline=31;md5=996b1ce0584c0747b17b57654cc81e8e"
 
@@ -13,6 +13,9 @@ SRC_URI[sha256sum] = "e521d3ee9def61f5d5c911afc74dd5c3a56ce147c7071c74023ea24cac
 PACKAGECONFIG ?= ""
 PACKAGECONFIG[xft] = "--enable-freetype,--disable-freetype,libxft fontconfig freetype-native"
 
+# Let xterm install .desktop files
+inherit mime-xdg
+
 EXTRA_OECONF = " --x-includes=${STAGING_INCDIR} \
                  --x-libraries=${STAGING_LIBDIR} \
                  FREETYPE_CONFIG=${STAGING_BINDIR_CROSS}/freetype-config \
@@ -30,6 +33,10 @@ do_configure() {
     oe_runconf
 }
 
+do_install_append() {
+    oe_runmake install-desktop DESTDIR="${D}" DESKTOP_FLAGS="--dir=${D}${DESKTOPDIR}"
+}
+
 # busybox can supply resize too
 inherit update-alternatives
 
-- 
2.17.1

