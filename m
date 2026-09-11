Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDFDC88E53
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 22:18:22 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.51009.1789165093178261655
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Sep 2026 15:18:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=l7KbWnWx;
 spf=pass (domain: smile.fr, ip: 74.125.225.140, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e2406so1714255e9.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 11 Sep 2026 15:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1789165091; x=1789769891; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QVmAnHVEa3K/Yzgwg+0mv/jE3a+nDsyFiUXn3as6vrE=;
        b=l7KbWnWxNeIe1E8bT/fW7oCJfNw6JkBirHWVSld29H1ZPE4RzMt9aY7fTbzo5KJEuR
         K0pSVhTaET/b82/LXQLUoglKcEwaAF3cIQCcJyePB+5PXmbCfUXsPyjbkHhntxrrVeXP
         vLzg+rYjMQszgDFxIRkzFDPqS0mRTGdpey4fc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789165091; x=1789769891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QVmAnHVEa3K/Yzgwg+0mv/jE3a+nDsyFiUXn3as6vrE=;
        b=F2UCanq5CbmEH6AVhpUi8cE6L/qll9i6mgSf9MQlL6y8xmOL4w8TatKVxYXCbtrqbN
         2SLvmXM2fB3nUFFBIjLHE29365T0zuJRaJA8lcLcq1dr+OBGQdvQceO7CfkMDyCp0JWv
         PmmuK8kP9fzSS1eNfTPJ7Dw4nJl4Fi2j4Ey0+ZT6GDv2kdmHmDVw1TSbzT9gBxdlBiLV
         1gCGi/0uS0+3o73Cv261kKOvKeIZdnZJ4Fpnr1U9YWAXVSordJk+DGF+mc6RgoVVCkLy
         5tU9zIxTdL8as2pcRvdAqEW6oQrpVHL1dSpGAYfIV7XXc5N/+uNTBpuyUNn2X6z+Btg1
         AwWg==
X-Gm-Message-State: AFuF++m9kkG7v+EWBTcNfY4qneSmKkD4e8vugstsl+mLa1EolghxAEvl
	IsDCFXr6k+1R+gSRPX5BLVg5MI9ulwOuWQWa2phdwYSB3/pUj25rZMPZsXowWTAPTjyo9Kb4NaM
	coUObpk4=
X-Gm-Gg: AYBFou24hw9hIU9QjFCzMpJ4Wks0M3g3JvMaKgqYGsFhDXhGrSFsNhwSY5XG7shOfCy
	FlVnUJIpU/csFO8QgjOaP6wed0J4kzud7xqIEG1o/dX4ze96fy6ClPi22tslGxZb8o8uCJhUlMp
	c507RFvsOzyhjj6PU4/HG9E3Yv36LGNvF3tI7Wn7r7vrNXXPWeOYnmJPo6hECN56flAYwVU4T3Z
	e6l6PgNiWoXJKArEButBZJFj7jOcDP9BtIvLgE333gEw0sERvsMmkSBF6+FxSCHaurjj4cEKYRw
	AuZKwlW0eEYp9PZYnzs/uvBAfdh3g/x+AiYJfzmUb4NvQc1UWsoVFrT0Vkj52whNMmDtKGxJto9
	ouCf+uuW7TVJRnboQuEHY4QdTVL6zmlfmLhOGN0txBXBxnH2UAjTEbjS+yzizSk0LRb36DaCS3r
	GAIbHxNedL5XtbSn/RTdeWYwNDlN6o8DEqYMixsZZy4PFwfgWseOtQFfp7vj+TahNtkKEMEm8Xv
	U1zKmJQozTP8kchS+HBGxcgDn1lm5HNrPA5qhsCiKyHz3K1nH0ibqBoQAOK4vh6tpMp+gela3w=
X-Received: by 2002:a05:600c:3b1f:b0:49c:e37e:4389 with SMTP id 5b1f17b1804b1-49e60f6955cmr80007105e9.4.1789165091410;
        Fri, 11 Sep 2026 15:18:11 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e61a33e34sm78235165e9.0.2026.09.11.15.18.10
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:18:11 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 4/4] tests/fetch: Swap bitbake github mirror for YP one
Date: Sat, 12 Sep 2026 00:18:06 +0200
Message-ID: <cd50c3481e32afff995a143c3459cfa5ae25abd5.1789165002.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789165002.git.yoann.congal@smile.fr>
References: <cover.1789165002.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Sep 2026 22:18:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20187

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
index 3ed98593d..3e2c6f8c1 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -568,8 +568,8 @@ class GitDownloadDirectoryNamingTest(FetcherTest):
         super(GitDownloadDirectoryNamingTest, self).setUp()
         self.recipe_url = "git://git.openembedded.org/bitbake;branch=master;protocol=https"
         self.recipe_dir = "git.openembedded.org.bitbake"
-        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https;branch=master"
-        self.mirror_dir = "github.com.openembedded.bitbake.git"
+        self.mirror_url = "git://git.openembedded.org/bitbake-contrib.git;protocol=https;branch=master"
+        self.mirror_dir = "git.openembedded.org.bitbake-contrib.git"
 
         self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40')
 
@@ -616,8 +616,8 @@ class TarballNamingTest(FetcherTest):
         super(TarballNamingTest, self).setUp()
         self.recipe_url = "git://git.openembedded.org/bitbake;branch=master;protocol=https"
         self.recipe_tarball = "git2_git.openembedded.org.bitbake.tar.gz"
-        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https;branch=master"
-        self.mirror_tarball = "git2_github.com.openembedded.bitbake.git.tar.gz"
+        self.mirror_url = "git://git.openembedded.org/bitbake-contrib.git;protocol=https;branch=master"
+        self.mirror_tarball = "git2_git.openembedded.org.bitbake-contrib.git.tar.gz"
 
         self.d.setVar('BB_GENERATE_MIRROR_TARBALLS', '1')
         self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40')
@@ -650,8 +650,8 @@ class GitShallowTarballNamingTest(FetcherTest):
         super(GitShallowTarballNamingTest, self).setUp()
         self.recipe_url = "git://git.openembedded.org/bitbake;branch=master;protocol=https"
         self.recipe_tarball = "gitshallow_git.openembedded.org.bitbake_82ea737-1_master.tar.gz"
-        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https;branch=master"
-        self.mirror_tarball = "gitshallow_github.com.openembedded.bitbake.git_82ea737-1_master.tar.gz"
+        self.mirror_url = "git://git.openembedded.org/bitbake-contrib.git;protocol=https;branch=master"
+        self.mirror_tarball = "gitshallow_git.openembedded.org.bitbake-contrib.git_82ea737-1_master.tar.gz"
 
         self.d.setVar('BB_GIT_SHALLOW', '1')
         self.d.setVar('BB_GENERATE_SHALLOW_TARBALLS', '1')
@@ -2367,7 +2367,7 @@ class GitShallowTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_bitbake(self):
-        self.git('remote add --mirror=fetch origin https://github.com/openembedded/bitbake', cwd=self.srcdir)
+        self.git('remote add --mirror=fetch origin https://git.openembedded.org/bitbake-contrib', cwd=self.srcdir)
         self.git('config core.bare true', cwd=self.srcdir)
         self.git('fetch', cwd=self.srcdir)
 

