Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A59BC982DB
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 22:17:20 +0000 (UTC)
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1878.1789683436398462334
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Sep 2026 15:17:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=sODGrGgB;
 spf=pass (domain: smile.fr, ip: 74.125.225.141, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6b885ef8so687525e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 15:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1789683435; x=1790288235; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=owMfiEZBb2u9PicQ1R7dhg89/YW+zu1QH2CrueyT8TY=;
        b=sODGrGgBHAIYvrLql3IDf0FhP1N+yt08IxbT7ZyTrNZIwzfoWLI3G+x6Y4VkX/4yxO
         L+JKcyMMhiZWeLGiw1m3n6TAvhQ99ifmq4BLFr2armulr+vdyFu/cC6czQeySQV6c8qN
         6iuqYabQJprdKU7+1/eEhshV4OsCSJ8WS9c2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789683435; x=1790288235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=owMfiEZBb2u9PicQ1R7dhg89/YW+zu1QH2CrueyT8TY=;
        b=JiQHq7pCkwVlgDAXBF4ho0WQ9ArVoipZ1maNjqCjZl64IX1B4Lwcc5Gjy1RvJQF0n9
         PjmDbTlG8/0t2PDxFWHX2pTfDW65LjVeQzu1Wwn+ErNmhg+j0rZE9uvPxaVfjXt/Xzle
         hXMbburmllDMNFjyecysAwmIh1OpP1vKPcwFwLetKoNpYbkNWsa3XDlYNP6ToW6m4HL7
         ed5noZTSVDbPWrVggC/yaMJSjcXSslPaCyG3n9pO65uVPqK/c2RD6+Fm/eT7IkIExJmI
         YGiSZVzwlLoMwyucmWoUdHneFju39RUWaYLxMyFuntLgRULdZknFpf1jFr8brlVMODiv
         3aOg==
X-Gm-Message-State: AFuF++ktazte9sOoxFEJwafBVTlVTVHiWyXpLhjXHivW68hLIFG7vWeo
	cB/Lmp2zscC5spq0/VQLXPe1Tfx0EiIYevHNFko9J/7dJ/x2DxMab9wMk9GVW8IgWyeo2kNk7rF
	ONWk3Xbw=
X-Gm-Gg: AYBFou1O+p/gS7Ke82G6KXguuR60jKQRWCsPci5w7Mt2R2GnoftxiM349Y15kQ3VbEI
	oFmJGhsDQ7aFaFjDmaXo+e6DIiVn1MQvwizC6GzPcxtu8q6enVia0CD1drG3Um/ApmKGD17P1mW
	ya1r1yrQFekIruvLUCX/BnPc6ypyZSUfa4eIO8Cr9A8u3so2ZdxX9cA74R0PZWybQupzaGsEV3O
	jln7pCbevDHTNBYNYw6N0TXXtprSDIm+Z7EC9L5LO8t5oKoIWYuuxmXRQPWkIziT2fRsfeClD9U
	i5oECU+LoX8JUIOadxCpAyLbnTZwWkLNldfbATIMU9LftGxa6T/mB/4W5p1w8SCyypaxI4p9bql
	65YgR5HaSk4KcE6sxk4s3EWWTdq30b270gmQMUIfOXlJw0JZJhC7iHe+1jbhTd/pLNsFpj9ziub
	3JVGa0jmmNrKu7PV8ta/6dpek2k5OcCKGRog3NDlic/XtbvTU9tfrniST8YuY8Anm07U04jSUes
	qb7AaXZhccqJP5ZooWcGGNj4wlrn2fFhRXGb8MhELonLomaBKURuRO1EPheO+1Lm2yHPGuQu8M=
X-Received: by 2002:a05:600c:1d16:b0:49f:bc8a:b103 with SMTP id 5b1f17b1804b1-49fc55c5361mr4144675e9.0.1789683434657;
        Thu, 17 Sep 2026 15:17:14 -0700 (PDT)
Received: from FRSMI25-LASER.home (2a01cb001331aa00a2e4fb7b0d887544.ipv6.abo.wanadoo.fr. [2a01:cb00:1331:aa00:a2e4:fb7b:d88:7544])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd247809sm185737725e9.11.2026.09.17.15.17.14
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:17:14 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][wrynose][2.18][PATCH 6/7] tests/fetch: Switch to YP mirror repos instead of github
Date: Fri, 18 Sep 2026 00:17:04 +0200
Message-ID: <08922f238e470e8b82f48ea82a0efc6359d65a90.1789683244.git.yoann.congal@smile.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789683244.git.yoann.congal@smile.fr>
References: <cover.1789683244.git.yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Sep 2026 22:17:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20229

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We're having issues with github urls, switch many of the test repos to our own
mirror copies. Some mirror copies are modified to reduce their size and improve test
times. More needs to be done in that area!

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 9dbf27b9fd04c40c87f25eb6cbd884db5c7f2160)
Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/tests/fetch.py | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index c72e4c4e3..f8aa0fd07 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1218,7 +1218,7 @@ class FetcherNetworkTest(FetcherTest):
     def test_git_submodule_dbus_broker(self):
         # The following external repositories have show failures in fetch and unpack operations
         # We want to avoid regressions!
-        url = "gitsm://github.com/bus1/dbus-broker;protocol=https;rev=fc874afa0992d0c75ec25acb43d344679f0ee7d2;branch=main"
+        url = "gitsm://git.yoctoproject.org/bbfetchtests-bus1-dbus-broker;protocol=https;rev=fc874afa0992d0c75ec25acb43d344679f0ee7d2;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -1234,7 +1234,7 @@ class FetcherNetworkTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_git_submodule_CLI11(self):
-        url = "gitsm://github.com/CLIUtils/CLI11;protocol=https;rev=bd4dc911847d0cde7a6b41dfa626a85aab213baf;branch=main"
+        url = "gitsm://git.yoctoproject.org/bbfetchtests-cliutils-cli11;protocol=https;rev=474872a222f61e57b16c2feb774610a4595a729e;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -1244,17 +1244,16 @@ class FetcherNetworkTest(FetcherTest):
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
@@ -1264,11 +1263,10 @@ class FetcherNetworkTest(FetcherTest):
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
@@ -1313,7 +1311,7 @@ class FetcherNetworkTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_git_submodule_reference_to_parent(self):
-        self.recipe_url = "gitsm://github.com/gflags/gflags.git;protocol=https;branch=master"
+        self.recipe_url = "gitsm://git.yoctoproject.org/bbfetchtests-gflags;protocol=https;branch=master"
         self.d.setVar("SRCREV", "14e1138441bbbb584160cb1c0a0426ec1bac35f1")
         with Timeout(60):
             fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
@@ -1478,7 +1476,7 @@ class FetchLatestVersionTest(FetcherTest):
 
     test_git_uris = {
         # version pattern "X.Y.Z"
-        ("mx-1.0", "git://github.com/clutter-project/mx.git;branch=mx-1.4;protocol=https", "9b1db6b8060bd00b121a692f942404a24ae2960f", "", "")
+        ("mx-1.0", "git://git.yoctoproject.org/bbfetchtests-clutter-mx;branch=mx-1.4;protocol=https", "9b1db6b8060bd00b121a692f942404a24ae2960f", "", "")
             : "1.99.4",
         # version pattern "vX.Y"
         # mirror of git.infradead.org since network issues interfered with testing
@@ -1505,11 +1503,11 @@ class FetchLatestVersionTest(FetcherTest):
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
 
@@ -1582,7 +1580,7 @@ class FetchLatestVersionTest(FetcherTest):
     test_git_stable_uris = {
         ("dtc", "git://git.yoctoproject.org/bbfetchtests-dtc.git;branch=master;protocol=https", "65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf", "", r"^1\.4\.\d+$")
             : ("1.4.0", "1.5.0"),
-        ("systemd", "git://github.com/systemd/systemd.git;protocol=https;branch=stable/v259-stable", "b3d8fc43e9cb531d958c17ef2cd93b374bc14e8a", "", r"^259\.\d+$")
+        ("systemd", "git://git.yoctoproject.org/bbfetchtests-systemd;protocol=https;branch=stable/v259-stable", "b3d8fc43e9cb531d958c17ef2cd93b374bc14e8a", "", r"^259\.\d+$")
             : ("259.5", "260")
     }
 
@@ -3267,11 +3265,11 @@ class NPMTest(FetcherTest):
                     'resolved': 'https://registry.npmjs.org/content-type/-/content-type-1.0.4.tgz',
                     'integrity': 'sha512-hIP3EEPs8tB9AT1L+NUqtwOAps4mk2Zob89MWXMHjHWg9milF/j4osnnQLXBCBFBk/tvIG/tUc9mOUJiPBhPXA==',
                     'dependencies': {
-                        'cookie': 'git+https://github.com/jshttp/cookie.git#aec1177c7da67e3b3273df96cf476824dbc9ae09'
+                        'cookie': 'git+https://git.yoctoproject.org/bbfetchtests-jshttp-cookie#aec1177c7da67e3b3273df96cf476824dbc9ae09'
                     }
                 },
                 'node_modules/array-flatten/node_modules/content-type/node_modules/cookie': {
-                    'resolved': 'git+https://github.com/jshttp/cookie.git#aec1177c7da67e3b3273df96cf476824dbc9ae09'
+                    'resolved': 'git+https://git.yoctoproject.org/bbfetchtests-jshttp-cookie#aec1177c7da67e3b3273df96cf476824dbc9ae09'
                 }
             }
         })
@@ -3279,7 +3277,7 @@ class NPMTest(FetcherTest):
         fetcher.download()
         self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'array-flatten-1.1.1.tgz')))
         self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'content-type-1.0.4.tgz')))
-        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'git2', 'github.com.jshttp.cookie.git')))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'git2', 'git.yoctoproject.org.bbfetchtests-jshttp-cookie')))
         fetcher.unpack(self.unpackdir)
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'npm-shrinkwrap.json')))
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'node_modules', 'array-flatten', 'package.json')))
@@ -3292,13 +3290,13 @@ class NPMTest(FetcherTest):
         swfile = self.create_shrinkwrap_file({
             'packages': {
                 'node_modules/cookie': {
-                    'resolved': 'git+https://github.com/jshttp/cookie.git#aec1177c7da67e3b3273df96cf476824dbc9ae09'
+                    'resolved': 'git+https://git.yoctoproject.org/bbfetchtests-jshttp-cookie#aec1177c7da67e3b3273df96cf476824dbc9ae09'
                 }
             }
         })
         fetcher = bb.fetch.Fetch(['npmsw://' + swfile], self.d)
         fetcher.download()
-        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'git2', 'github.com.jshttp.cookie.git')))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'git2', 'git.yoctoproject.org.bbfetchtests-jshttp-cookie')))
 
     @skipIfNoNetwork()
     def test_npmsw_dev(self):
@@ -4005,20 +4003,20 @@ class GoModGitTest(FetcherTest):
     @skipIfNoNetwork()
     def test_gomodgit_url_host_only(self):
         urls = ['gomodgit://go.opencensus.io;version=v0.24.0;'
-                'repo=github.com/census-instrumentation/opencensus-go;'
+                'repo=git.yoctoproject.org/bbfetchtests-census-instrumentation-opencensus-go;'
                 'srcrev=b1a01ee95db0e690d91d7193d037447816fae4c5']
 
         fetcher = bb.fetch2.Fetch(urls, self.d)
         ud = fetcher.ud[urls[0]]
-        self.assertEqual(ud.host, 'github.com')
-        self.assertEqual(ud.path, '/census-instrumentation/opencensus-go')
+        self.assertEqual(ud.host, 'git.yoctoproject.org')
+        self.assertEqual(ud.path, '/bbfetchtests-census-instrumentation-opencensus-go')
         self.assertEqual(ud.name, 'go.opencensus.io@v0.24.0')
         self.assertEqual(self.d.getVar('SRCREV_go.opencensus.io@v0.24.0'), 'b1a01ee95db0e690d91d7193d037447816fae4c5')
 
         fetcher.download()
         fetcher.unpack(self.unpackdir)
         vcsdir = os.path.join(self.unpackdir, 'pkg/mod/cache/vcs')
-        self.assertTrue(os.path.exists(os.path.join(vcsdir, 'aae3ac7b2122ed3345654e6327855e9682f4a5350d63e93dbcfc51c4419df0e1')))
+        self.assertTrue(os.path.exists(os.path.join(vcsdir, '24e4a8be150f9e7343b72e40000115a175fb2f19d015542f54abb6ccdbd52f14')))
         downloaddir = os.path.join(self.unpackdir, 'pkg/mod/cache/download')
         self.assertTrue(os.path.exists(os.path.join(downloaddir, 'go.opencensus.io/@v/v0.24.0.zip')))
         self.assertTrue(os.path.exists(os.path.join(downloaddir, 'go.opencensus.io/@v/v0.24.0.mod')))

