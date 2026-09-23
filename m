Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1938C9830B
	for <webhook@archiver.kernel.org>; Wed, 23 Sep 2026 09:11:13 +0000 (UTC)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2907.1790154670655720424
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Sep 2026 02:11:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=uKPES08h;
 spf=pass (domain: smile.fr, ip: 74.125.225.141, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912e4b11so3739975e9.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 02:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1790154669; x=1790759469; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iIziFfMd8Kqcx7Z9xDAbTF7z8cwbgBkSZnq5AczDgSU=;
        b=uKPES08hDf8jOI1uOeA7HBRtrp2WTAOZXvzqtuVcsFvZ8atinySp5uJ1A9FvxmfY8O
         vh66G5ZV3gYV4yxqifNrcI2HSXEOdCbElRo96sRGKheK7op3DjvUXM27nrOycGGPH+hq
         fB6dk68sZ6NHktBsSyjNub0O/AkYWGC/lM7q0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790154669; x=1790759469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iIziFfMd8Kqcx7Z9xDAbTF7z8cwbgBkSZnq5AczDgSU=;
        b=a/fnn9eUygV5D3VfEMS9qtI6xkQP7rw5fauAL4RJF+pAPt1Gqv3JuHxaDaQcJEVqL7
         GuQ0AZIyJ7IvVxw+K/NuRzQ9fy+INMt6XInTKqW4utQRgAnX9ZN8fCVFSLUR7zlsxA7v
         h5vuUDUPwv0CiU9RmN96DK4niG58BeSROEm+oywJ5MU94gb4H1cVrlZT2efc99Tj3MYa
         3/PimRn3+45EzS3uMUsURSWGB+VTPfd0N4xp3u9GHcyk2JgTRj14SWofkY29FAmdwDcL
         iOQRWsYf9blUsYol5NlQYKyWSWUjrAWXaZAu/dirkHb9QJ870stUSzA+l36s1jC+wmOq
         z31Q==
X-Gm-Message-State: AFuF++nOPrjWt5ohjTJ14lOWYfep1uDetaCXIfXrz6bDSLM98gz1+Oj7
	ZDyDNg7TuoBYD9P5aw9L8BRRb1BM0bG8pC0ICHMNghoN3nWO1VdkslqnF4pstQ/vVBJtAMVNliw
	aYTKqqkw=
X-Gm-Gg: AYBFou3tlGNfkH8mspQ4DUfpOuw+WHzaVaR8kBGnkT+nJeUbkJgVE45NXJDP6+k88YA
	pWxQoaxKpF4QsBZYWh7+wnbn1TqsbyFlQW8z9Xcbjmj78KEkOnHccGvUi9OalQ1wkP5Hka97jdn
	S2W1Y2Na0OcZEGPxZsbthTZcUxyiKmetOfhWBAoM1FyticvD4wD9mOijpNE4+CTNXfIS3c/JZOd
	XLrhghyesMSqjn99NO72uOhjaOszvtEMz8GsrnQY6mQI93eVHa0ET364H9W1P1IB+B+S1lWiwus
	iPOtJN+p7TbJJF0H+Pa+0JTCO7enwliH52N3EkGoYnVfW9n+cBqEnbn5R/Zk3ZnZUm6dj3NbfQc
	PBsQD0Pz5yjXOntyuQKBuEK5/8wuIwgx9vqlr9VLTRlfrnIxFaMLo9bxZAyDWW8cT1+ZxguVlnL
	GWWwa+xsem46bEoJ/N3wltd+7hT/j3jb7hmU4RuOo3zcgkusnw6rKdi3qpezdvgZA7aJ7mW4kN8
	aPRFR9IplVN1Kcth+hB8qAJPuM28+v0h4di/zXHXlIOuQ/OHRlrraeaW1/jc9h0lDTbY1H4xsHJ
	2SqEEww=
X-Received: by 2002:a05:600c:4ec6:b0:49f:dc71:e609 with SMTP id 5b1f17b1804b1-49fdf12f351mr24202105e9.20.1790154668701;
        Wed, 23 Sep 2026 02:11:08 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a02-8440-b519-f416-8bed-8817-19fd-ccf7.rev.sfr.net. [2a02:8440:b519:f416:8bed:8817:19fd:ccf7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe14322c0sm48384135e9.5.2026.09.23.02.11.07
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 02:11:08 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 2/3] tests/fetch: Switch to YP mirror repos instead of github
Date: Wed, 23 Sep 2026 11:10:16 +0200
Message-ID: <931a230a28a0582552f098e97d94299f310fd2eb.1790154568.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790154568.git.yoann.congal@smile.fr>
References: <cover.1790154568.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Sep 2026 09:11:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20239

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We're having issues with github urls, switch many of the test repos to our own
mirror copies. Some mirror copies are modified to reduce their size and improve test
times. More needs to be done in that area!

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 9dbf27b9fd04c40c87f25eb6cbd884db5c7f2160)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/tests/fetch.py | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index d47e3cd29..087ebb7db 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1212,7 +1212,7 @@ class FetcherNetworkTest(FetcherTest):
     def test_git_submodule_dbus_broker(self):
         # The following external repositories have show failures in fetch and unpack operations
         # We want to avoid regressions!
-        url = "gitsm://github.com/bus1/dbus-broker;protocol=https;rev=fc874afa0992d0c75ec25acb43d344679f0ee7d2;branch=main"
+        url = "gitsm://git.yoctoproject.org/bbfetchtests-bus1-dbus-broker;protocol=https;rev=fc874afa0992d0c75ec25acb43d344679f0ee7d2;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -1228,7 +1228,7 @@ class FetcherNetworkTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_git_submodule_CLI11(self):
-        url = "gitsm://github.com/CLIUtils/CLI11;protocol=https;rev=bd4dc911847d0cde7a6b41dfa626a85aab213baf;branch=main"
+        url = "gitsm://git.yoctoproject.org/bbfetchtests-cliutils-cli11;protocol=https;rev=474872a222f61e57b16c2feb774610a4595a729e;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -1238,17 +1238,16 @@ class FetcherNetworkTest(FetcherTest):
         repo_path = os.path.join(self.tempdir, 'unpacked', 'git')
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/googletest/config')), msg='Missing submodule config "extern/googletest"')
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/json/config')), msg='Missing submodule config "extern/json"')
-        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/sanitizers/config')), msg='Missing submodule config "extern/sanitizers"')
 
     @skipIfNoNetwork()
     def test_git_submodule_update_CLI11(self):
         """ Prevent regression on update detection not finding missing submodule, or modules without needed commits """
-        url = "gitsm://github.com/CLIUtils/CLI11;protocol=https;rev=cf6a99fa69aaefe477cc52e3ef4a7d2d7fa40714;branch=main"
+        url = "gitsm://git.yoctoproject.org/bbfetchtests-cliutils-cli11;protocol=https;rev=fe0e149a0624db734de37dc827af3328855f51cf;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
 
         # CLI11 that pulls in a newer nlohmann-json
-        url = "gitsm://github.com/CLIUtils/CLI11;protocol=https;rev=49ac989a9527ee9bb496de9ded7b4872c2e0e5ca;branch=main"
+        url = "gitsm://git.yoctoproject.org/bbfetchtests-cliutils-cli11;protocol=https;rev=141f9dca45bd5ef42e7b1a06637860b7581370c8;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -1258,11 +1257,10 @@ class FetcherNetworkTest(FetcherTest):
         repo_path = os.path.join(self.tempdir, 'unpacked', 'git')
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/googletest/config')), msg='Missing submodule config "extern/googletest"')
         self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/json/config')), msg='Missing submodule config "extern/json"')
-        self.assertTrue(os.path.exists(os.path.join(repo_path, '.git/modules/extern/sanitizers/config')), msg='Missing submodule config "extern/sanitizers"')
 
     @skipIfNoNetwork()
     def test_git_submodule_aktualizr(self):
-        url = "gitsm://github.com/advancedtelematic/aktualizr;branch=master;protocol=https;rev=d00d1a04cc2366d1a5f143b84b9f507f8bd32c44"
+        url = "gitsm://git.yoctoproject.org/bbfetchtests-advancedtelematic-aktualizr;branch=master;protocol=https;rev=d00d1a04cc2366d1a5f143b84b9f507f8bd32c44"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -1307,7 +1305,7 @@ class FetcherNetworkTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_git_submodule_reference_to_parent(self):
-        self.recipe_url = "gitsm://github.com/gflags/gflags.git;protocol=https;branch=master"
+        self.recipe_url = "gitsm://git.yoctoproject.org/bbfetchtests-gflags;protocol=https;branch=master"
         self.d.setVar("SRCREV", "14e1138441bbbb584160cb1c0a0426ec1bac35f1")
         with Timeout(60):
             fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
@@ -1471,7 +1469,7 @@ class FetchLatestVersionTest(FetcherTest):
 
     test_git_uris = {
         # version pattern "X.Y.Z"
-        ("mx-1.0", "git://github.com/clutter-project/mx.git;branch=mx-1.4;protocol=https", "9b1db6b8060bd00b121a692f942404a24ae2960f", "", "")
+        ("mx-1.0", "git://git.yoctoproject.org/bbfetchtests-clutter-mx;branch=mx-1.4;protocol=https", "9b1db6b8060bd00b121a692f942404a24ae2960f", "", "")
             : "1.99.4",
         # version pattern "vX.Y"
         # mirror of git.infradead.org since network issues interfered with testing
@@ -1498,11 +1496,11 @@ class FetchLatestVersionTest(FetcherTest):
             : "0.4.3",
         ("build-appliance-image", "git://git.yoctoproject.org/poky;branch=master;protocol=https", "b37dd451a52622d5b570183a81583cc34c2ff555", r"(?P<pver>(([0-9][\.|_]?)+[0-9]))", "")
             : "11.0.0",
-        ("chkconfig-alternatives-native", "git://github.com/kergoth/chkconfig;branch=sysroot;protocol=https", "cd437ecbd8986c894442f8fce1e0061e20f04dee", r"chkconfig\-(?P<pver>((\d+[\.\-_]*)+))", "")
+        ("chkconfig-alternatives-native", "git://git.yoctoproject.org/bbfetchtests-kergoth-chkconfig;branch=sysroot;protocol=https", "cd437ecbd8986c894442f8fce1e0061e20f04dee", r"chkconfig\-(?P<pver>((\d+[\.\-_]*)+))", "")
             : "1.3.59",
-        ("remake", "git://github.com/rocky/remake.git;protocol=https;branch=master", "f05508e521987c8494c92d9c2871aec46307d51d", r"(?P<pver>(\d+\.(\d+\.)*\d*(\+dbg\d+(\.\d+)*)*))", "")
+        ("remake", "git://git.yoctoproject.org/bbfetchtests-rocky-remake;protocol=https;branch=master", "f05508e521987c8494c92d9c2871aec46307d51d", r"(?P<pver>(\d+\.(\d+\.)*\d*(\+dbg\d+(\.\d+)*)*))", "")
             : "3.82+dbg0.9",
-        ("sysdig", "git://github.com/draios/sysdig.git;branch=dev;protocol=https", "4fb6288275f567f63515df0ff0a6518043ecfa9b", r"^(?P<pver>\d+(\.\d+)+)", "10.0.0")
+        ("sysdig", "git://git.yoctoproject.org/bbfetchtests-draios-sysdig;branch=dev;protocol=https", "4fb6288275f567f63515df0ff0a6518043ecfa9b", r"^(?P<pver>\d+(\.\d+)+)", "10.0.0")
             : "0.28.0",
     }
 
@@ -2988,8 +2986,8 @@ class NPMTest(FetcherTest):
                             'integrity': 'sha512-hIP3EEPs8tB9AT1L+NUqtwOAps4mk2Zob89MWXMHjHWg9milF/j4osnnQLXBCBFBk/tvIG/tUc9mOUJiPBhPXA==',
                             'dependencies': {
                                 'cookie': {
-                                    'version': 'git+https://github.com/jshttp/cookie.git#aec1177c7da67e3b3273df96cf476824dbc9ae09',
-                                    'from': 'git+https://github.com/jshttp/cookie.git'
+                                    'version': 'git+https://git.yoctoproject.org/bbfetchtests-jshttp-cookie#aec1177c7da67e3b3273df96cf476824dbc9ae09',
+                                    'from': 'git+https://git.yoctoproject.org/bbfetchtests-jshttp-cookie'
                                 }
                             }
                         }
@@ -3001,7 +2999,7 @@ class NPMTest(FetcherTest):
         fetcher.download()
         self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'array-flatten-1.1.1.tgz')))
         self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'content-type-1.0.4.tgz')))
-        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'git2', 'github.com.jshttp.cookie.git')))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'git2', 'git.yoctoproject.org.bbfetchtests-jshttp-cookie')))
         fetcher.unpack(self.unpackdir)
         self.assertTrue(os.path.exists(os.path.join(self.sdir, 'npm-shrinkwrap.json')))
         self.assertTrue(os.path.exists(os.path.join(self.sdir, 'node_modules', 'array-flatten', 'package.json')))
@@ -3014,14 +3012,14 @@ class NPMTest(FetcherTest):
         swfile = self.create_shrinkwrap_file({
             'dependencies': {
                 'cookie': {
-                    'version': 'github:jshttp/cookie.git#aec1177c7da67e3b3273df96cf476824dbc9ae09',
-                    'from': 'github:jshttp/cookie.git'
+                    'version': 'git+https://git.yoctoproject.org/bbfetchtests-jshttp-cookie#aec1177c7da67e3b3273df96cf476824dbc9ae09',
+                    'from': 'git+https://git.yoctoproject.org/bbfetchtests-jshttp-cookie'
                 }
             }
         })
         fetcher = bb.fetch.Fetch(['npmsw://' + swfile], self.d)
         fetcher.download()
-        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'git2', 'github.com.jshttp.cookie.git')))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'git2', 'git.yoctoproject.org.bbfetchtests-jshttp-cookie')))
 
         swfile = self.create_shrinkwrap_file({
             'dependencies': {

