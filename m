Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.web12.2659.1592854716421333588
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Jun 2020 12:38:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=DASy9NKu;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.66, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f66.google.com with SMTP id v3so10434867wrc.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 22 Jun 2020 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c9z+oBkoaDMW4C3Z9z/E9NK++hTsGezfJ4EBlncGA28=;
        b=DASy9NKuhzSP7TR349l3t/Gl6qroxJoxfMsEUv7rulpNuiPFKov+iy3TSfKneuMp0H
         bnbhjhl1jtbY4w0FZ5hRScQU8ML61gxiE4mk3rvRiSnldO99ugMm7mb7QG082sj7BL/n
         krg1opZYKOnUvfONJF+x2DXLf+2G2m96scC8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c9z+oBkoaDMW4C3Z9z/E9NK++hTsGezfJ4EBlncGA28=;
        b=dX1nKFoLeOpwEwASdjajTgvIfuP74d2BemgjgbjG6DM2b8LqAaGI3DQ9SpBuh6BqWN
         qsjMXm41I64XABedMkpmgjEAVEmyCJR0vCGTUl2eZr6+VtgPYDH1QGLJEhDHreRaPMru
         4NxLl0N7kUVN54xFaIh/mpiKUH/SF/kG+BojGocoYeD7od5a3Zez1yxy1ke/wDzA08B8
         dqIb5wOGZGM1w+VTG/bRqfYViGRuaUlhFTMi43umrD0oHBGvy3jE4Pdyv4rAF186OGwg
         gtfB0htI1SdCsQ7vbwRy2gqg75c3pEf1NYtgFdUr1u3YQlypuP65uNiMeX18SzFF1//j
         XDKw==
X-Gm-Message-State: AOAM530Fa8byikMVsLanM8RTsBAFLP92z8HirIWdLdFaQeGZ4u7BmcQF
	EhbGNjIkbbnfHHxrbTdEvmF3+J5iS9jaxg==
X-Google-Smtp-Source: ABdhPJzCQdk8VOdnHzsl8RkaVHPRUyyb88lWJgEdQmEL9bCEagitxB22szc2OpE5YorS8cpRa8yR0w==
X-Received: by 2002:adf:e74e:: with SMTP id c14mr8031764wrn.143.1592854714522;
        Mon, 22 Jun 2020 12:38:34 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
        by smtp.gmail.com with ESMTPSA id 1sm669488wmf.0.2020.06.22.12.38.33
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 12:38:33 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/fetch: Switch from git.infradead.org to a YP mirror
Date: Mon, 22 Jun 2020 20:38:32 +0100
Message-Id: <20200622193832.571813-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Upstream is unavailable, breaking tests. Switch to a YP mirror since
if we can't reach that there are bigger problems. This should remove
a source of intermittent failures on the autobuilder.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index d0c161a7f6..4697ef59b5 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1152,7 +1152,8 @@ class FetchLatestVersionTest(FetcherTest):
         ("mx-1.0", "git://github.com/clutter-project/mx.git;branch=mx-1.4", "9b1db6b8060bd00b121a692f942404a24ae2960f", "")
             : "1.99.4",
         # version pattern "vX.Y"
-        ("mtd-utils", "git://git.infradead.org/mtd-utils.git", "ca39eb1d98e736109c64ff9c1aa2a6ecca222d8f", "")
+        # mirror of git.infradead.org since network issues interfered with testing
+        ("mtd-utils", "git://git.yoctoproject.org/mtd-utils.git", "ca39eb1d98e736109c64ff9c1aa2a6ecca222d8f", "")
             : "1.5.0",
         # version pattern "pkg_name-X.Y"
         ("presentproto", "git://anongit.freedesktop.org/git/xorg/proto/presentproto", "24f3a56e541b0a9e6c6ee76081f441221a120ef9", "")
-- 
2.25.1

