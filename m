Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC77C79F8C
	for <webhook@archiver.kernel.org>; Wed,  9 Sep 2026 07:31:14 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6349.1788939067686061460
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Sep 2026 00:31:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=Pm2VCigA;
 spf=pass (domain: smile.fr, ip: 209.85.128.53, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b8687630fso46284035e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Sep 2026 00:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1788939066; x=1789543866; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+enxi87nW/c8WyuswESt2WsoCe3FGwLPq75U9krjQ9Y=;
        b=Pm2VCigA/o+r95ApVE5oCdtNEAi3u2tsAuqzCfnfw0o5emuxpgpljnKIFkvzi/71FM
         QUGVGJ29M0HW7zRjZV54ho5a40Q75MwYP8ZpFn3cjbZWg5ahKZ9OcNZGunaH/LBuOeDR
         ezc8R8CyjEUuXpB9O3k1SAWAB9hP9kINsTLIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788939066; x=1789543866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+enxi87nW/c8WyuswESt2WsoCe3FGwLPq75U9krjQ9Y=;
        b=JDh/7DgK4FWRizIbfBmWzAfcZvpELZYxJqY0BdlyPiJIsQJdPKpHIxrpV7vHBiMdzv
         jyYoDz9CT9IdH/dHfQdjO8R6+5g/GguaeJx+ikGjw1u39nXvOTvtdsQnyw9OZWq65Qzy
         GnvLiltOJaUXY1D6jaQOexZ2vnK71X9JXTfx/yuY4EqT0QE/+dXOAcMNuUeIQArbT3+8
         QMnBkri/SH0ljwn9u+0sdZ2OSRRBIJvJ1HYT+LfKFSIPMwSJ+T3NHgf1dgXjDpFfKRKj
         spuxBT3gKHxoUueJxwJYA5IepPgU/wX2UbU0LCA+hobyIKI8ss6MgUExfz+d0Beyvi9i
         faCg==
X-Gm-Message-State: AFuF++mRVo9XmVyRhoWB9kC2W5iOyQaEghiLmYn9kM/X3Y+Lfx+G96yU
	+QHGs3/sowD6mdcvE3C+b5xpllY2PvVA/iNL5ozKvfKOl9iU/OwehTI4DJYUXktGuhUXxwrWm9b
	RrD1wWSU=
X-Gm-Gg: AYBFou3AyGev+tTSdEQ0c2wxPQQvY4zjjM5M2YwkzDfrHrKfqPEUav/jxxC+kzX3skz
	0V/unJIq4VWs7FJ2iIL35FynLaXu3Cn4mwva3P75C/IYNQ1s2mPayXANOTCwpbeijRG3NN74rNT
	+gbF3MFA5hCEHtvzVHug8XtGaKJoVvR9RQE5nMzmq7Hu7lbdFgIDrMs1KXJtcwighrc+wmuFeFz
	PTjoPNwYBGtalb4MSVqe/oIViGxXCgkjaKBhyj1/Y2DjwldhJYyuKjQJWF2UGptgaFYwi0Lprq/
	Qqg7hAGMJ36kXMrhVTcFLtuY1CrNw9lJO50NKKu1eeJ3tdS3y1Ly0HhjFEczWO3quRCu2rZNEhk
	lrSSLkEr1KV9GvMj7GW+7xXaUbNjPkf8DL6D4FGuIfplAgrlC969+D5m2u1IboCBNVxTFDxhEio
	zZjEITgYlVsrCTOWa+0GquAtv5EpfgBsZ74n8tQEDWfHnhFqPWlHU3mv+SUypHW9Q/WH4NRpyFt
	HtERsZ3OdeAT8MrcMB1sqiXHtgfB7oJeD2JKu2eUCqchivrcXEJ0c1U2d4s5mLdwFo859X1+qw=
X-Received: by 2002:a05:600c:6819:b0:49c:de80:b833 with SMTP id 5b1f17b1804b1-49cf81fb1acmr316990675e9.2.1788939065903;
        Wed, 09 Sep 2026 00:31:05 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f912esm553491385e9.4.2026.09.09.00.31.05
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 00:31:05 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 4/4] tests/fetch: Swap bitbake github mirror for YP one
Date: Wed,  9 Sep 2026 09:31:00 +0200
Message-ID: <f0df79b6b56f6a69067adf974978d9405077f246.1788939009.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788939009.git.yoann.congal@smile.fr>
References: <cover.1788939009.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 09 Sep 2026 07:31:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20176

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We need a reliable mirror of the bitbake repo and github is no longer that. Swap
to use the bitbake-contrib repo which carrys enough bitbake data to work for the
tests we need.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit f311ff38b4bf79675f677f73f1d390723b1c4490)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/tests/fetch.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 845741060..137505343 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -575,8 +575,8 @@ class GitDownloadDirectoryNamingTest(FetcherTest):
         super(GitDownloadDirectoryNamingTest, self).setUp()
         self.recipe_url = "git://git.openembedded.org/bitbake;branch=master;protocol=https"
         self.recipe_dir = "git.openembedded.org.bitbake"
-        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https;branch=master"
-        self.mirror_dir = "github.com.openembedded.bitbake.git"
+        self.mirror_url = "git://git.openembedded.org/bitbake-contrib.git;protocol=https;branch=master"
+        self.mirror_dir = "git.openembedded.org.bitbake-contrib.git"
 
         self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40')
 
@@ -623,8 +623,8 @@ class TarballNamingTest(FetcherTest):
         super(TarballNamingTest, self).setUp()
         self.recipe_url = "git://git.openembedded.org/bitbake;branch=master;protocol=https"
         self.recipe_tarball = "git2_git.openembedded.org.bitbake.tar.gz"
-        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https;branch=master"
-        self.mirror_tarball = "git2_github.com.openembedded.bitbake.git.tar.gz"
+        self.mirror_url = "git://git.openembedded.org/bitbake-contrib.git;protocol=https;branch=master"
+        self.mirror_tarball = "git2_git.openembedded.org.bitbake-contrib.git.tar.gz"
 
         self.d.setVar('BB_GENERATE_MIRROR_TARBALLS', '1')
         self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40')
@@ -657,8 +657,8 @@ class GitShallowTarballNamingTest(FetcherTest):
         super(GitShallowTarballNamingTest, self).setUp()
         self.recipe_url = "git://git.openembedded.org/bitbake;branch=master;protocol=https"
         self.recipe_tarball = "gitshallow_git.openembedded.org.bitbake_82ea737-1_master.tar.gz"
-        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https;branch=master"
-        self.mirror_tarball = "gitshallow_github.com.openembedded.bitbake.git_82ea737-1_master.tar.gz"
+        self.mirror_url = "git://git.openembedded.org/bitbake-contrib.git;protocol=https;branch=master"
+        self.mirror_tarball = "gitshallow_git.openembedded.org.bitbake-contrib.git_82ea737-1_master.tar.gz"
 
         self.d.setVar('BB_GIT_SHALLOW', '1')
         self.d.setVar('BB_GENERATE_SHALLOW_TARBALLS', '1')
@@ -2406,7 +2406,7 @@ class GitShallowTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_bitbake(self):
-        self.git('remote add --mirror=fetch origin https://github.com/openembedded/bitbake', cwd=self.srcdir)
+        self.git('remote add --mirror=fetch origin https://git.openembedded.org/bitbake-contrib', cwd=self.srcdir)
         self.git('config core.bare true', cwd=self.srcdir)
         self.git('fetch', cwd=self.srcdir)
 

