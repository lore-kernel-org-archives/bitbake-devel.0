Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B176109193F
	for <webhook@archiver.kernel.org>; Fri, 20 Mar 2026 00:26:27 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2598.1773966378244828548
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Mar 2026 17:26:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=z0UGL4ll;
 spf=pass (domain: smile.fr, ip: 209.85.128.47, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48557c8ad47so11958715e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Mar 2026 17:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1773966376; x=1774571176; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GlXaZf/b0fKLh+z3cgTAxV6nCWufGVkdYv8U00H6Vec=;
        b=z0UGL4ll4Diz/LXk4THoQRd6QElVBTZtdObWGN8AyeY2vi9RDAGinB8UlsBA7uLgam
         sAmKunzHFTvKmCgX8klDGhywDyvpKTG2I2pzL7C3qGneDeLazRzT8t5xWOHJz0PPpOKl
         xnLmsOG4gDpn5QKKGulBF6ciL6Zy0gNrr/4ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773966376; x=1774571176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GlXaZf/b0fKLh+z3cgTAxV6nCWufGVkdYv8U00H6Vec=;
        b=KoKkZWIHo60FmTU8xCFlR2m+zPVyph9LMwR2Afksul067eJXQL0ue0FoWdproWKUWr
         LD00bI/ghuRo0m67L0PlmO3Ux7GYkeppXTNa/LjqZd3GaRk3nMGdiwQARd+YEDJ/9Ddq
         wf6u9bHEo26s46uBZkesoM+F86IMtn9zNC7yG7pZC6GVStzIgTsGDEA1mb58BiBawAxG
         JD8m3uQLtjVRSkyzhKtfB7FZ9yZxWg7XMe6EatTAVzsw2yoIjK9Ii/uWG4fYkvCGu7JE
         h0dpfYIeyycEOQPh7lurBAHDehOHfDub48iek0fC8TZjwskply3kycdKZR4XImo73CMV
         QF9g==
X-Gm-Message-State: AOJu0YyZ83syZRP2Us1V88JvEU6FIMZikUUh6xamidN1wuTJJRHqWG4C
	yUW4lpOZuqqv9L0S1yrNnszuqBluOfZ/TTMWy3R56mxP5Ba7TdzXED2q6vgBbALWXW/geUJGL+r
	PN/2+
X-Gm-Gg: ATEYQzxCdJbm2ipH4ba4V1usN4umlTiuNY/l6KpHClQLEYuwZ6w/GjMNtLodTEuZHUq
	c6vt/q9JFiLubbNgO7/Dfu2As074a/Ut8bKCOJjV3PUungwHJdvo7+7ihmbbSM6bZuQAoXRqEVb
	L+hedpU+OxGxKKi+P4TPu914fNZ/vVvx3wzlv3Q9ZVdce/OWDaa6kg4NyGh/xKdTtY0Sf+iwqtL
	dg++zkLqveNGn6JnOGl148AbpfQkk2P6h1UwXLLJkVR3OjicdWsLd9Cd0BXO4IfmxQKLNZQztXM
	ObvYeu0mECnD49klLLxfsJMXkUs7P5+E3uynV1GwQBOU1qXu7qBs70EjCwi5JjtPs2yUQGvf1va
	72AUZhUsjz6NPtyAV2BZsU+nyvl7YWf6z1XtD1RUvUyBp128P63cPArq8pcRJG2YuEK2ncjVYjH
	e3pu5yKLzJ8Px7ObJ3AHdM2xak336G2GadcVYpUn1ODD3mdfwr2nEkBZA2nEB9KWw8HEd/8h+Fp
	+dp9q0HN89XbQGCO8e4EpBFlVhrlcVH3D4nMQ==
X-Received: by 2002:a05:600c:524e:b0:486:f634:ef3 with SMTP id 5b1f17b1804b1-486ff01efcdmr15873345e9.32.1773966376269;
        Thu, 19 Mar 2026 17:26:16 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486fb4309d1sm106036545e9.3.2026.03.19.17.26.15
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 17:26:15 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 4/4] fetch2: Fix LFS object checkout in submodules
Date: Fri, 20 Mar 2026 01:26:11 +0100
Message-ID: <d3b4c352dd33fca90cd31649eda054b884478739.1773966318.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773966318.git.yoann.congal@smile.fr>
References: <cover.1773966318.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Mar 2026 00:26:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19183

From: Philip Lorenz <philip.lorenz@bmw.de>

Skipping smudging prevents the LFS objects from replacing their
placeholder files when `git submodule update` actually checks out the
target revision in the submodule. Smudging cannot happen earlier as the
clone stored in `.git/modules` is bare.

This should be fine as long as all LFS objects are available in the
download cache (which they are after the other fixes are applied).

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit d270e33a07c50bb9c08861cf9a6dc51e1fd2d874)
Suggested-by: Michael Siebold <michael.siebold@gmail.com>
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/fetch2/gitsm.py | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 5c9899148..ef1905333 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -243,12 +243,11 @@ class GitSM(Git):
         ret = self.process_submodules(ud, ud.destdir, unpack_submodules, d)
 
         if not ud.bareclone and ret:
-            # All submodules should already be downloaded and configured in the tree.  This simply
-            # sets up the configuration and checks out the files.  The main project config should
-            # remain unmodified, and no download from the internet should occur. As such, lfs smudge
-            # should also be skipped as these files were already smudged in the fetch stage if lfs
-            # was enabled.
-            runfetchcmd("GIT_LFS_SKIP_SMUDGE=1 %s submodule update --recursive --no-fetch" % (ud.basecmd), d, quiet=True, workdir=ud.destdir)
+            cmdprefix = ""
+            # Avoid LFS smudging (replacing the LFS pointers with the actual content) when LFS shouldn't be used but git-lfs is installed.
+            if not self._need_lfs(ud):
+                cmdprefix = "GIT_LFS_SKIP_SMUDGE=1 "
+            runfetchcmd("%s%s submodule update --recursive --no-fetch" % (cmdprefix, ud.basecmd), d, quiet=True, workdir=ud.destdir)
     def clean(self, ud, d):
         def clean_submodule(ud, url, module, modpath, workdir, d):
             url += ";bareclone=1;nobranch=1"

