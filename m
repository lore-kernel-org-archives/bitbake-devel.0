Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6C7C433F5
	for <webhook@archiver.kernel.org>; Thu,  4 Nov 2021 14:11:38 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web09.12162.1636035097478842880
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Nov 2021 07:11:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=BctpHe2n;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.174,
 mailfrom: steve@sakoman.com)
Received: by mail-pf1-f174.google.com with SMTP id h74so6013548pfe.0
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Nov 2021 07:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UBJAIWCuU33PACQactrAvXa7bCWNGPsZUOE6jAcceNQ=;
        b=BctpHe2nrhpT4SVRuUXhC5pA7P/NRoZ514wTY6vBJXAuKy4MlEhA4rljF3CWBEIXFb
         ekzbssssvKQs6aDM6EK6RbhrvC789FPPP7DAZucDhd3alphaYQmqjY9GtV79aODMLS1w
         b6kGTgtEIeG897X05DUI7Ozc1gQeJFnebotVgd001l3OZp5cbu8Uys5QFXDkYK3TFvbD
         eBIN7p9Go95OaIv+r49BHZYF/tSGwy/VaTW1SIcXLHp9sqZJmR1DtD1a/eO+sJjJcywk
         x3gHK3e0WqppOz33kig6k7Z8C/Q3XFDkKzdkNSF1L6Kzf0Paa9wZKRLh1bKtcV/M5pZO
         P96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UBJAIWCuU33PACQactrAvXa7bCWNGPsZUOE6jAcceNQ=;
        b=nmRiWx41OP4fUMVE3FEiHGATDIM++6RyJ4rtbs3bVgu6q0xsgUxbj3TqieuYiQtpKu
         jWFKGu6I4fi+Xn5GT1Y0YZsdx+5oE2nPJrfvoloWcYwIpk4KT72XipfLEc+/J8Z0Ggq7
         n+x31qB3h+PkJnb4UH5mSY9kJjum2LKfbP/OrOgOiLoSdOASKK6h0U9i3Dy0Z64Z/Nhr
         jmjVgWMQ6ybyKlEbgI6nxlBxIyEZ0uch/OAzkP1ZTrTWAlDDDhcPt1GSsu1AaaMBBcV+
         fQ5fZI4LwcZE+mXp60/wXfa3v3RzNkEKidvRsi6HPCRyjo8BuUqc/8EmVYN1ow9jQDJG
         xXUA==
X-Gm-Message-State: AOAM531jj7dG79UigQZ7/j1Lcb2nPbUu/PWFGhN7lmNH0HGXn3RAfR0l
	gosiTKxmVD4C3feSEUu1IK/Q8Jl9frLQYBRIXiU=
X-Google-Smtp-Source: 
 ABdhPJwWerwTmNYAFt4hDI+zV/6pe3/EtazfIB9J8cgk+k7/4GtrgI2VqeVNisNJRzIQwbIvQ7ZXDw==
X-Received: by 2002:a05:6a00:1309:b0:44d:4d1e:c930 with SMTP id
 j9-20020a056a00130900b0044d4d1ec930mr51705683pfu.65.1636035096472;
        Thu, 04 Nov 2021 07:11:36 -0700 (PDT)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 lx12sm1850546pjb.5.2021.11.04.07.11.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 07:11:36 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 2/2] tests/fetch: Update github urls
Date: Thu,  4 Nov 2021 04:11:14 -1000
Message-Id: 
 <bdae4bf287e3583dbc419dd152f63a1b1347fe19.1636034890.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1636034890.git.steve@sakoman.com>
References: <cover.1636034890.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Nov 2021 14:11:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12881

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 07fca7e3ab696ba985b3ef86ab9031d688bf2df2)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/tests/fetch.py | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index afa071bf..9144c9d1 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -472,7 +472,7 @@ class GitDownloadDirectoryNamingTest(FetcherTest):
         super(GitDownloadDirectoryNamingTest, self).setUp()
         self.recipe_url = "git://git.openembedded.org/bitbake"
         self.recipe_dir = "git.openembedded.org.bitbake"
-        self.mirror_url = "git://github.com/openembedded/bitbake.git"
+        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https"
         self.mirror_dir = "github.com.openembedded.bitbake.git"
 
         self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40')
@@ -520,7 +520,7 @@ class TarballNamingTest(FetcherTest):
         super(TarballNamingTest, self).setUp()
         self.recipe_url = "git://git.openembedded.org/bitbake"
         self.recipe_tarball = "git2_git.openembedded.org.bitbake.tar.gz"
-        self.mirror_url = "git://github.com/openembedded/bitbake.git"
+        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https"
         self.mirror_tarball = "git2_github.com.openembedded.bitbake.git.tar.gz"
 
         self.d.setVar('BB_GENERATE_MIRROR_TARBALLS', '1')
@@ -554,7 +554,7 @@ class GitShallowTarballNamingTest(FetcherTest):
         super(GitShallowTarballNamingTest, self).setUp()
         self.recipe_url = "git://git.openembedded.org/bitbake"
         self.recipe_tarball = "gitshallow_git.openembedded.org.bitbake_82ea737-1_master.tar.gz"
-        self.mirror_url = "git://github.com/openembedded/bitbake.git"
+        self.mirror_url = "git://github.com/openembedded/bitbake.git;protocol=https"
         self.mirror_tarball = "gitshallow_github.com.openembedded.bitbake.git_82ea737-1_master.tar.gz"
 
         self.d.setVar('BB_GIT_SHALLOW', '1')
@@ -921,7 +921,7 @@ class FetcherNetworkTest(FetcherTest):
     def test_git_submodule_dbus_broker(self):
         # The following external repositories have show failures in fetch and unpack operations
         # We want to avoid regressions!
-        url = "gitsm://github.com/bus1/dbus-broker;protocol=git;rev=fc874afa0992d0c75ec25acb43d344679f0ee7d2;branch=main"
+        url = "gitsm://github.com/bus1/dbus-broker;protocol=https;rev=fc874afa0992d0c75ec25acb43d344679f0ee7d2;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -937,7 +937,7 @@ class FetcherNetworkTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_git_submodule_CLI11(self):
-        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=bd4dc911847d0cde7a6b41dfa626a85aab213baf;branch=main"
+        url = "gitsm://github.com/CLIUtils/CLI11;protocol=https;rev=bd4dc911847d0cde7a6b41dfa626a85aab213baf;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -952,12 +952,12 @@ class FetcherNetworkTest(FetcherTest):
     @skipIfNoNetwork()
     def test_git_submodule_update_CLI11(self):
         """ Prevent regression on update detection not finding missing submodule, or modules without needed commits """
-        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=cf6a99fa69aaefe477cc52e3ef4a7d2d7fa40714;branch=main"
+        url = "gitsm://github.com/CLIUtils/CLI11;protocol=https;rev=cf6a99fa69aaefe477cc52e3ef4a7d2d7fa40714;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
 
         # CLI11 that pulls in a newer nlohmann-json
-        url = "gitsm://github.com/CLIUtils/CLI11;protocol=git;rev=49ac989a9527ee9bb496de9ded7b4872c2e0e5ca;branch=main"
+        url = "gitsm://github.com/CLIUtils/CLI11;protocol=https;rev=49ac989a9527ee9bb496de9ded7b4872c2e0e5ca;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -971,7 +971,7 @@ class FetcherNetworkTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_git_submodule_aktualizr(self):
-        url = "gitsm://github.com/advancedtelematic/aktualizr;branch=master;protocol=git;rev=d00d1a04cc2366d1a5f143b84b9f507f8bd32c44"
+        url = "gitsm://github.com/advancedtelematic/aktualizr;branch=master;protocol=https;rev=d00d1a04cc2366d1a5f143b84b9f507f8bd32c44"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -991,7 +991,7 @@ class FetcherNetworkTest(FetcherTest):
         """ Prevent regression on deeply nested submodules not being checked out properly, even though they were fetched. """
 
         # This repository also has submodules where the module (name), path and url do not align
-        url = "gitsm://github.com/azure/iotedge.git;protocol=git;rev=d76e0316c6f324345d77c48a83ce836d09392699"
+        url = "gitsm://github.com/azure/iotedge.git;protocol=https;rev=d76e0316c6f324345d77c48a83ce836d09392699"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -1167,7 +1167,7 @@ class FetchLatestVersionTest(FetcherTest):
 
     test_git_uris = {
         # version pattern "X.Y.Z"
-        ("mx-1.0", "git://github.com/clutter-project/mx.git;branch=mx-1.4", "9b1db6b8060bd00b121a692f942404a24ae2960f", "")
+        ("mx-1.0", "git://github.com/clutter-project/mx.git;branch=mx-1.4;protocol=https", "9b1db6b8060bd00b121a692f942404a24ae2960f", "")
             : "1.99.4",
         # version pattern "vX.Y"
         # mirror of git.infradead.org since network issues interfered with testing
@@ -1194,9 +1194,9 @@ class FetchLatestVersionTest(FetcherTest):
             : "0.4.3",
         ("build-appliance-image", "git://git.yoctoproject.org/poky", "b37dd451a52622d5b570183a81583cc34c2ff555", r"(?P<pver>(([0-9][\.|_]?)+[0-9]))")
             : "11.0.0",
-        ("chkconfig-alternatives-native", "git://github.com/kergoth/chkconfig;branch=sysroot", "cd437ecbd8986c894442f8fce1e0061e20f04dee", r"chkconfig\-(?P<pver>((\d+[\.\-_]*)+))")
+        ("chkconfig-alternatives-native", "git://github.com/kergoth/chkconfig;branch=sysroot;protocol=https", "cd437ecbd8986c894442f8fce1e0061e20f04dee", r"chkconfig\-(?P<pver>((\d+[\.\-_]*)+))")
             : "1.3.59",
-        ("remake", "git://github.com/rocky/remake.git", "f05508e521987c8494c92d9c2871aec46307d51d", r"(?P<pver>(\d+\.(\d+\.)*\d*(\+dbg\d+(\.\d+)*)*))")
+        ("remake", "git://github.com/rocky/remake.git;protocol=https", "f05508e521987c8494c92d9c2871aec46307d51d", r"(?P<pver>(\d+\.(\d+\.)*\d*(\+dbg\d+(\.\d+)*)*))")
             : "3.82+dbg0.9",
     }
 
@@ -1983,7 +1983,7 @@ class GitShallowTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_bitbake(self):
-        self.git('remote add --mirror=fetch origin git://github.com/openembedded/bitbake', cwd=self.srcdir)
+        self.git('remote add --mirror=fetch origin https://github.com/openembedded/bitbake', cwd=self.srcdir)
         self.git('config core.bare true', cwd=self.srcdir)
         self.git('fetch', cwd=self.srcdir)
 
-- 
2.25.1


