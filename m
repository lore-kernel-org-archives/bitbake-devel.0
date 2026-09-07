Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135E0C79F89
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 13:24:52 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34642.1788787486324932978
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Sep 2026 06:24:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Klgw+8Zy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.50, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso30267435e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 07 Sep 2026 06:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788787484; x=1789392284; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CJBG49a9yYMjv8dgR9mC7KWKS7SRhmoQ1mBUU3sUDHU=;
        b=Klgw+8ZyXxSZKi9e2B6B+LaHwNH7cExh9six1MpyJJxyq5YGOUtauOJ0HGWMY6EsGN
         +PNESb8K4bTOzir9/AJ36KtWiv6qcufVqRgoC9GAqNpO5rP6dgzI+0NcxXETYxZ12A0U
         XJGg3ALpThynBcZF+f8UvUtm0z8L3qoZDH6yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788787484; x=1789392284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CJBG49a9yYMjv8dgR9mC7KWKS7SRhmoQ1mBUU3sUDHU=;
        b=Gdu3zruUMx81unobul/Qtkpb++SsZSqzh1TmG3lIDdYMZindQfqpywzPnq9SYrGxEh
         +bBabgeMQC3wn53P5iT9+rg8hY9aW8WsVAvq+9f8kJo4FlPG29kjMioR07Bx0+qRQC8H
         EqzuhvStdcGI4uRJL+F342rJRqgt/dOF8DCQDiznW+H/9cPUDvP7yAh0NNEAA13wVPPV
         EYB/R2dq2euiRKDm4bceUZ5h+ZL8lUegtteTCD+gHO7RJYnrDCfPanEnkvePCilUAUO0
         rx43mEoXgBXY5OcrqEpuqQY+DeL1L6piS24lUW/NNU2d8K04M2xMwzmC44mGtICWRZOr
         oUZw==
X-Gm-Message-State: AFuF++nloml8Sr4rMa/7iVtZ01q8F0Kxp3Nn320s7ZPvQQB9SdFR6XZe
	hlwHqGs6eKX7UC7OWd0s2qln7l/ZhjUmAQh6c+K6SGBNUrW6dappQ/hyIsZU89UhIadq1pYHB2C
	FhIkqn58=
X-Gm-Gg: AYBFou3bLU1MBpDQd8mP91PUt8MXE+n9Sa1hh/sfCI4S0htWFIy2EvFtWK6eJ+8+efz
	F55/N4Naak29pKj9O0l90Df6XCYAA+LloD+Chs78ap134qay90gNUmvjibmr8A3HIMXzTLoL3MB
	smLVaXXOcWY9oY0Z2Bc4hoT2clcIv7itEhHFngUwVfM4rt7ArZYR8AeW8eYd+o3HQ3b/4K2QFQV
	aL3c82e8mCSD+gK2wsE0DaGpp8StDllKHecGLEX5boZQzPL71e+oEBvwCS7yAf1ZzcXVm5NSLBO
	yQi80yPA7NIUUqkTfblvSKC9epF63INOTqvCHN2vbuTWONXCOGmojzAPfZe2dYss8uRpjZt7r3z
	1DzITjTJAhGJHVsnMU4d9py31x7k9APYSNeaVGZdtV+0bafKQayvq1hgdHPmZ5wucLkOsvOiqPo
	3qMptI1vANu+6ttbqrScskVgQJQdNfh64U6kPVjb0ySVsE/+9GnAN6vxmVVnfr3WmXwUcWMESm6
	tpYvgMiMJTLeKCJPw==
X-Received: by 2002:a05:600c:c48f:b0:497:fecd:5b00 with SMTP id 5b1f17b1804b1-49cf825d507mr232442185e9.9.1788787484213;
        Mon, 07 Sep 2026 06:24:44 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e2ae:fec4:d03e:3153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c5bc5sm30165095f8f.24.2026.09.07.06.24.43
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:24:43 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/fetch: Swap bitbake github mirror for YP one
Date: Mon,  7 Sep 2026 14:24:42 +0100
Message-ID: <20260907132442.3997276-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Sep 2026 13:24:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20162

We need a reliable mirror of the bitbake repo and github is no longer that. Swap
to use git.yoctoproject.org which happens to also carry bitbake. We only really need
two different urls.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 4d15a8a235c..7ae7a1c15a8 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -573,8 +573,8 @@ class GitDownloadDirectoryNamingTest(FetcherTest):
         super(GitDownloadDirectoryNamingTest, self).setUp()
         self.recipe_url = "git://git.openembedded.org/bitbake;branch=master;protocol=https"
         self.recipe_dir = "git.openembedded.org.bitbake"
-        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https;branch=master"
-        self.mirror_dir = "github.com.openembedded.bitbake.git"
+        self.mirror_url = "git://git.yoctoproject.org/bitbake.git;protocol=https;branch=master"
+        self.mirror_dir = "git.yoctoproject.org.bitbake.git"
 
         self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40')
 
@@ -621,8 +621,8 @@ class TarballNamingTest(FetcherTest):
         super(TarballNamingTest, self).setUp()
         self.recipe_url = "git://git.openembedded.org/bitbake;branch=master;protocol=https"
         self.recipe_tarball = "git2_git.openembedded.org.bitbake.tar.gz"
-        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https;branch=master"
-        self.mirror_tarball = "git2_github.com.openembedded.bitbake.git.tar.gz"
+        self.mirror_url = "git://git.yoctoproject.org/bitbake.git;protocol=https;branch=master"
+        self.mirror_tarball = "git2_git.yoctoproject.org.bitbake.git.tar.gz"
 
         self.d.setVar('BB_GENERATE_MIRROR_TARBALLS', '1')
         self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40')
@@ -655,8 +655,8 @@ class GitShallowTarballNamingTest(FetcherTest):
         super(GitShallowTarballNamingTest, self).setUp()
         self.recipe_url = "git://git.openembedded.org/bitbake;branch=master;protocol=https"
         self.recipe_tarball = "gitshallow_git.openembedded.org.bitbake_82ea737-1_master.tar.gz"
-        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https;branch=master"
-        self.mirror_tarball = "gitshallow_github.com.openembedded.bitbake.git_82ea737-1_master.tar.gz"
+        self.mirror_url = "git://git.yoctoproject.org/bitbake.git;protocol=https;branch=master"
+        self.mirror_tarball = "gitshallow_git.yoctoproject.org.bitbake.git_82ea737-1_master.tar.gz"
 
         self.d.setVar('BB_GIT_SHALLOW', '1')
         self.d.setVar('BB_GENERATE_SHALLOW_TARBALLS', '1')
@@ -2461,7 +2461,7 @@ class GitShallowTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_bitbake(self):
-        self.git(['remote', 'add', '--mirror=fetch', 'origin', 'https://github.com/openembedded/bitbake'], cwd=self.srcdir)
+        self.git(['remote', 'add', '--mirror=fetch', 'origin', 'https://git.yoctoproject.org/bitbake'], cwd=self.srcdir)
         self.git(['config', 'core.bare', 'true'], cwd=self.srcdir)
         self.git(['fetch'], cwd=self.srcdir)
 

