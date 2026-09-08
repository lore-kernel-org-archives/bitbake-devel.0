Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39402C79FA1
	for <webhook@archiver.kernel.org>; Tue,  8 Sep 2026 21:20:59 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.241.1788902451181815997
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Sep 2026 14:20:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bMb6j5W8;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48589798dbbso4243386f8f.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 08 Sep 2026 14:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1788902449; x=1789507249; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=N7lMwDmbeBrzJmBwf7MnAx1vDnuijnQBAhHFom4Encw=;
        b=bMb6j5W8nnoQut7/9grhcmpW/maUrEebqfJ7kU5lIopAxSo9YG6Z4Q4uyA/m0AugHI
         dEJXG7AWNwh0M0yZcj7JPQ8f/9nZgFLGpW8Mz7fSari88XaMr26l2sVt+PtUVhVjch4E
         E9teOH+Jhwd/ZVte+6QP4fwasTKUTjUKoSKnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788902449; x=1789507249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=N7lMwDmbeBrzJmBwf7MnAx1vDnuijnQBAhHFom4Encw=;
        b=YU6pJZ+l8W9fnTo8KH5imoVGDal/RINZlgzLCUbSx29F5t2L24qT/OT+UZ0KowVqFA
         gcIktEHXNilOIVmdTu3VQLIVKGrOBwyUKh91eK23hyS8pA/AqaUBcWEwYjhJh6uMFZKU
         PBsrZmxVx1l6xKzmPWB0TFsjBh3fKXsEmeSl1lh4vN9Lwjwc2ERo2V91RlwTer7mxGbG
         5bHsCLDAsDEbJasj9r11RNjX+vUzo2559QHJSmQPj3fgsmlq3qB8TaqcNslwe5PxUrPq
         Zn9TAgck4c1LUXgDrvW0obxiIrC8uHN4jw63y91o3YEQdECKJWpVPN+d6cy2RcgooXa1
         W/CA==
X-Gm-Message-State: AFuF++ltzPhZhIbIaVE+KS2vO88XFSHfpMc9sB4uf0Tss6kwrHa2HCHx
	H6dMMTP9ovBegK2S9Yry4F53QuucggtEqLnV8rGjdlJwqPKxpdh1EBxdJ0SRTy2Q+hHzUZ+RVO9
	8fSn1vUI=
X-Gm-Gg: AYBFou0Ft2xAcyAwp8hJwBxQvH1zJci77UsNKVfjWLKkHqtKLnz3QAtEsWthUPvSZv/
	4nIrgJpPUXc5Ocy53PjkF6MVOYRtIwcCuqAjhyjPpLw1N2NTr1kWToeEgaPTGwe376rJmmsEcpP
	QWFf2AHmPzz4F7RRfjeG+aoQ7NENkJZ239wmaArtGhBaFgf0X+wVmDm5M/KvdmeYnL+Bd5qkpq0
	mUDIuKCM71h6hS8cziFFT0sDMzwmlDZ22b+xKeVqRim9tPQ21Mc9QxYIs0TsxkFkJCUWajZaRzu
	1snJ4nXa/XKMeWFUVvdEdMHYlC51kD4ZuWZWN4mfoclDfgDvxBGiEfSaAaXjN45h9uE8niHhkpD
	PUmeF80ENNh6F6jsfeIcL6KNbAcos6g0s9TC5p0NIF5MnVIsuGIGPlfLzNMk62teLYd3+3PMQDW
	mw/EcR3mJ4EJSHfhZH4yYocbz4gY3MHt3RkngVBgIaSFKulxWdlH+uO6jVzmfu+HRHpHVb2blLT
	H9LEW8djTas4yNANg==
X-Received: by 2002:a05:6000:1acf:b0:485:8a46:7062 with SMTP id ffacd0b85a97d-4858a467220mr29513526f8f.52.1788902448838;
        Tue, 08 Sep 2026 14:20:48 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3b52:472d:bd88:cdf3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858d312ca0sm40285771f8f.4.2026.09.08.14.20.47
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 14:20:48 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] tests/fetch: Switch to YP mirror repos instead of github
Date: Tue,  8 Sep 2026 22:20:46 +0100
Message-ID: <20260908212047.1788760-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Sep 2026 21:20:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20170

We're having issues with github urls, switch many of the test repos to our own
mirror copies. Some mirror copies are modified to reduce their size and improve test
times. More needs to be done in that area!

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/fetch.py | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index d69ad6bbd89..40be061af69 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -1258,7 +1258,7 @@ class FetcherNetworkTest(FetcherTest):
     def test_git_submodule_dbus_broker(self):
         # The following external repositories have show failures in fetch and unpack operations
         # We want to avoid regressions!
-        url = "gitsm://github.com/bus1/dbus-broker;protocol=https;rev=fc874afa0992d0c75ec25acb43d344679f0ee7d2;branch=main"
+        url = "gitsm://git.yoctoproject.org/bbfetchtests-bus1-dbus-broker;protocol=https;rev=fc874afa0992d0c75ec25acb43d344679f0ee7d2;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -1274,7 +1274,7 @@ class FetcherNetworkTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_git_submodule_CLI11(self):
-        url = "gitsm://github.com/CLIUtils/CLI11;protocol=https;rev=bd4dc911847d0cde7a6b41dfa626a85aab213baf;branch=main"
+        url = "gitsm://git.yoctoproject.org/bbfetchtests-cliutils-cli11;protocol=https;rev=474872a222f61e57b16c2feb774610a4595a729e;branch=main"
         fetcher = bb.fetch.Fetch([url], self.d)
         fetcher.download()
         # Previous cwd has been deleted
@@ -1284,17 +1284,16 @@ class FetcherNetworkTest(FetcherTest):
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
@@ -1304,11 +1303,10 @@ class FetcherNetworkTest(FetcherTest):
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
@@ -1353,7 +1351,7 @@ class FetcherNetworkTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_git_submodule_reference_to_parent(self):
-        self.recipe_url = "gitsm://github.com/gflags/gflags.git;protocol=https;branch=master"
+        self.recipe_url = "gitsm://git.yoctoproject.org/bbfetchtests-gflags;protocol=https;branch=master"
         self.d.setVar("SRCREV", "14e1138441bbbb584160cb1c0a0426ec1bac35f1")
         with Timeout(60):
             fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
@@ -1518,7 +1516,7 @@ class FetchLatestVersionTest(FetcherTest):
 
     test_git_uris = {
         # version pattern "X.Y.Z"
-        ("mx-1.0", "git://github.com/clutter-project/mx.git;branch=mx-1.4;protocol=https", "9b1db6b8060bd00b121a692f942404a24ae2960f", "", "")
+        ("mx-1.0", "git://git.yoctoproject.org/bbfetchtests-clutter-mx;branch=mx-1.4;protocol=https", "9b1db6b8060bd00b121a692f942404a24ae2960f", "", "")
             : "1.99.4",
         # version pattern "vX.Y"
         # mirror of git.infradead.org since network issues interfered with testing
@@ -1545,11 +1543,11 @@ class FetchLatestVersionTest(FetcherTest):
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
 
@@ -1622,7 +1620,7 @@ class FetchLatestVersionTest(FetcherTest):
     test_git_stable_uris = {
         ("dtc", "git://git.yoctoproject.org/bbfetchtests-dtc.git;branch=master;protocol=https", "65cc4d2748a2c2e6f27f1cf39e07a5dbabd80ebf", "", r"^1\.4\.\d+$")
             : ("1.4.0", "1.5.0"),
-        ("systemd", "git://github.com/systemd/systemd.git;protocol=https;branch=stable/v259-stable", "b3d8fc43e9cb531d958c17ef2cd93b374bc14e8a", "", r"^259\.\d+$")
+        ("systemd", "git://git.yoctoproject.org/bbfetchtests-systemd;protocol=https;branch=stable/v259-stable", "b3d8fc43e9cb531d958c17ef2cd93b374bc14e8a", "", r"^259\.\d+$")
             : ("259.5", "260")
     }
 
@@ -3373,11 +3371,11 @@ class NPMTest(FetcherTest):
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
@@ -3385,7 +3383,7 @@ class NPMTest(FetcherTest):
         fetcher.download()
         self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'array-flatten-1.1.1.tgz')))
         self.assertTrue(os.path.exists(os.path.join(self.dldir, 'npm2', 'content-type-1.0.4.tgz')))
-        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'git2', 'github.com.jshttp.cookie.git')))
+        self.assertTrue(os.path.exists(os.path.join(self.dldir, 'git2', 'git.yoctoproject.org.bbfetchtests-jshttp-cookie')))
         fetcher.unpack(self.unpackdir)
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'npm-shrinkwrap.json')))
         self.assertTrue(os.path.exists(os.path.join(self.unpackdir, 'node_modules', 'array-flatten', 'package.json')))
@@ -3397,13 +3395,13 @@ class NPMTest(FetcherTest):
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
@@ -4104,20 +4102,20 @@ class GoModGitTest(FetcherTest):
     @skipIfNoNetwork()
     def test_gomodgit_url_host_only(self):
         urls = ['gomodgit://go.opencensus.io;version=v0.24.0;'
-                'repo=github.com/census-instrumentation/opencensus-go;'
+                'repo=git.yoctoproject.org/bbfetchtests-census-instrumentation-opencensus-go;'
                 'srcrev=b1a01ee95db0e690d91d7193d037447816fae4c5']
 
         fetcher = bb.fetch.Fetch(urls, self.d)
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

