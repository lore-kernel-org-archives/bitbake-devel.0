Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3FEC4332F
	for <webhook@archiver.kernel.org>; Sat, 29 Jan 2022 02:29:45 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web09.1520.1643423382741682585
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Jan 2022 18:29:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=Mzln/oVu;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1643423384;
  x=1674959384;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=f6Zr2hWk2Qm3s/eTypHBMWuPbLA15/lmHQkFvdVLdA4=;
  b=Mzln/oVuIvntmWuqlpR4gCjaFbtTgF8ba13CzTGkzfwxp97yVTEfTzfJ
   L9dFfozvkrxTimU+4JwvjZMukSLllJIsSL7EbYxGjWhhPrTwn2G995km4
   RLiJfDgLmn8VScmPopUVIXfato+zZWrBYr/BoiCHqsUQ5zmGvJwiWZNLs
   LlsOYJcwBm4EzbAnMMCzmS9PADD7k98+t4YozPqTVDrNtR5f4gPnRvC3B
   YTBzlZ85y2RCLzrXXA9Gb3E/QdDdaCuxrYXkzx/F0LGpQaMiz5prddcpg
   40fbrirQ3g7NY6cG/P60E1z35biylJ7PVpBpe8q5FPJ4OaRSi6Y448gjB
   Q==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 2/9] tests/fetch: Remove unnecessary \n from mirror variables
Date: Sat, 29 Jan 2022 03:29:32 +0100
Message-ID: <20220129022939.19329-2-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20220129022939.19329-1-pkj@axis.com>
References: <20220129022939.19329-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 29 Jan 2022 02:29:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13296

Since commit 044fb04d (fetch2: Allow whitespace only mirror entries)
there is no need to separate the entries in mirror variables with
"\n".

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/tests/fetch.py | 46 +++++++++++++++++------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index ec7d83c959..e1d79bf964 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -442,10 +442,10 @@ class MirrorUriTest(FetcherTest):
         #("file://sstate-xyz.tgz", "file://.*/.*", "file:///somewhere/1234/sstate-cache") : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
     }
 
-    mirrorvar = "http://.*/.* file:///somepath/downloads/ \n" \
-                "git://someserver.org/bitbake git://git.openembedded.org/bitbake \n" \
-                "https://.*/.* file:///someotherpath/downloads/ \n" \
-                "http://.*/.* file:///someotherpath/downloads/ \n"
+    mirrorvar = "http://.*/.* file:///somepath/downloads/ " \
+                "git://someserver.org/bitbake git://git.openembedded.org/bitbake " \
+                "https://.*/.* file:///someotherpath/downloads/ " \
+                "http://.*/.* file:///someotherpath/downloads/"
 
     def test_urireplace(self):
         for k, v in self.replaceuris.items():
@@ -470,8 +470,8 @@ class MirrorUriTest(FetcherTest):
 
     def test_mirror_of_mirror(self):
         # Test if mirror of a mirror works
-        mirrorvar = self.mirrorvar + " http://.*/.* http://otherdownloads.yoctoproject.org/downloads/ \n"
-        mirrorvar = mirrorvar + " http://otherdownloads.yoctoproject.org/.* http://downloads2.yoctoproject.org/downloads/ \n"
+        mirrorvar = self.mirrorvar + " http://.*/.* http://otherdownloads.yoctoproject.org/downloads/"
+        mirrorvar = mirrorvar + " http://otherdownloads.yoctoproject.org/.* http://downloads2.yoctoproject.org/downloads/"
         fetcher = bb.fetch.FetchData("http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", self.d)
         mirrors = bb.fetch2.mirror_from_string(mirrorvar)
         uris, uds = bb.fetch2.build_mirroruris(fetcher, mirrors, self.d)
@@ -480,8 +480,8 @@ class MirrorUriTest(FetcherTest):
                                 'http://otherdownloads.yoctoproject.org/downloads/bitbake-1.0.tar.gz',
                                 'http://downloads2.yoctoproject.org/downloads/bitbake-1.0.tar.gz'])
 
-    recmirrorvar = "https://.*/[^/]*    http://AAAA/A/A/A/ \n" \
-                   "https://.*/[^/]*    https://BBBB/B/B/B/ \n"
+    recmirrorvar = "https://.*/[^/]*    http://AAAA/A/A/A/ " \
+                   "https://.*/[^/]*    https://BBBB/B/B/B/"
 
     def test_recursive(self):
         fetcher = bb.fetch.FetchData("https://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", self.d)
@@ -503,7 +503,7 @@ class GitDownloadDirectoryNamingTest(FetcherTest):
         self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40')
 
     def setup_mirror_rewrite(self):
-        self.d.setVar("PREMIRRORS", self.recipe_url + " " + self.mirror_url + " \n")
+        self.d.setVar("PREMIRRORS", self.recipe_url + " " + self.mirror_url)
 
     @skipIfNoNetwork()
     def test_that_directory_is_named_after_recipe_url_when_no_mirroring_is_used(self):
@@ -552,7 +552,7 @@ class TarballNamingTest(FetcherTest):
         self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40')
 
     def setup_mirror_rewrite(self):
-        self.d.setVar("PREMIRRORS", self.recipe_url + " " + self.mirror_url + " \n")
+        self.d.setVar("PREMIRRORS", self.recipe_url + " " + self.mirror_url)
 
     @skipIfNoNetwork()
     def test_that_the_recipe_tarball_is_created_when_no_mirroring_is_used(self):
@@ -587,7 +587,7 @@ class GitShallowTarballNamingTest(FetcherTest):
         self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40')
 
     def setup_mirror_rewrite(self):
-        self.d.setVar("PREMIRRORS", self.recipe_url + " " + self.mirror_url + " \n")
+        self.d.setVar("PREMIRRORS", self.recipe_url + " " + self.mirror_url)
 
     @skipIfNoNetwork()
     def test_that_the_tarball_is_named_after_recipe_url_when_no_mirroring_is_used(self):
@@ -867,14 +867,14 @@ class FetcherNetworkTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_fetch_mirror_of_mirror(self):
-        self.d.setVar("MIRRORS", "http://.*/.* http://invalid2.yoctoproject.org/ \n http://invalid2.yoctoproject.org/.* https://downloads.yoctoproject.org/releases/bitbake")
+        self.d.setVar("MIRRORS", "http://.*/.* http://invalid2.yoctoproject.org/ http://invalid2.yoctoproject.org/.* https://downloads.yoctoproject.org/releases/bitbake")
         fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz"], self.d)
         fetcher.download()
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
 
     @skipIfNoNetwork()
     def test_fetch_file_mirror_of_mirror(self):
-        self.d.setVar("MIRRORS", "http://.*/.* file:///some1where/ \n file:///some1where/.* file://some2where/ \n file://some2where/.* https://downloads.yoctoproject.org/releases/bitbake")
+        self.d.setVar("MIRRORS", "http://.*/.* file:///some1where/ file:///some1where/.* file://some2where/ file://some2where/.* https://downloads.yoctoproject.org/releases/bitbake")
         fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz"], self.d)
         os.mkdir(self.dldir + "/some2where")
         fetcher.download()
@@ -981,13 +981,13 @@ class FetcherNetworkTest(FetcherTest):
     def test_gitfetch_finds_local_tarball_for_mirrored_url_when_previous_downloaded_by_the_recipe_url(self):
         recipeurl = "git://git.openembedded.org/bitbake"
         mirrorurl = "git://someserver.org/bitbake"
-        self.d.setVar("PREMIRRORS", "git://someserver.org/bitbake git://git.openembedded.org/bitbake \n")
+        self.d.setVar("PREMIRRORS", "git://someserver.org/bitbake git://git.openembedded.org/bitbake")
         self.gitfetcher(recipeurl, mirrorurl)
 
     @skipIfNoNetwork()
     def test_gitfetch_finds_local_tarball_when_previous_downloaded_from_a_premirror(self):
         recipeurl = "git://someserver.org/bitbake"
-        self.d.setVar("PREMIRRORS", "git://someserver.org/bitbake git://git.openembedded.org/bitbake \n")
+        self.d.setVar("PREMIRRORS", "git://someserver.org/bitbake git://git.openembedded.org/bitbake")
         self.gitfetcher(recipeurl, recipeurl)
 
     @skipIfNoNetwork()
@@ -997,7 +997,7 @@ class FetcherNetworkTest(FetcherTest):
         self.sourcedir = self.unpackdir.replace("unpacked", "sourcemirror.git")
         os.chdir(self.tempdir)
         bb.process.run("git clone %s %s 2> /dev/null" % (realurl, self.sourcedir), shell=True)
-        self.d.setVar("PREMIRRORS", "%s git://%s;protocol=file \n" % (recipeurl, self.sourcedir))
+        self.d.setVar("PREMIRRORS", "%s git://%s;protocol=file" % (recipeurl, self.sourcedir))
         self.gitfetcher(recipeurl, recipeurl)
 
     @skipIfNoNetwork()
@@ -1852,7 +1852,7 @@ class GitShallowTest(FetcherTest):
         # Set up the mirror
         mirrordir = os.path.join(self.tempdir, 'mirror')
         bb.utils.rename(self.dldir, mirrordir)
-        self.d.setVar('PREMIRRORS', 'gitsm://.*/.* file://%s/\n' % mirrordir)
+        self.d.setVar('PREMIRRORS', 'gitsm://.*/.* file://%s/' % mirrordir)
 
         # Fetch from the mirror
         bb.utils.remove(self.dldir, recurse=True)
@@ -1967,7 +1967,7 @@ class GitShallowTest(FetcherTest):
         # Set up the mirror
         mirrordir = os.path.join(self.tempdir, 'mirror')
         bb.utils.mkdirhier(mirrordir)
-        self.d.setVar('PREMIRRORS', 'git://.*/.* file://%s/\n' % mirrordir)
+        self.d.setVar('PREMIRRORS', 'git://.*/.* file://%s/' % mirrordir)
 
         bb.utils.rename(os.path.join(self.dldir, mirrortarball),
                   os.path.join(mirrordir, mirrortarball))
@@ -2349,7 +2349,7 @@ class NPMTest(FetcherTest):
         mirrordir = os.path.join(self.tempdir, 'mirror')
         bb.utils.mkdirhier(mirrordir)
         os.replace(ud.localpath, os.path.join(mirrordir, pkgname))
-        self.d.setVar('PREMIRRORS', 'https?$://.*/.* file://%s/\n' % mirrordir)
+        self.d.setVar('PREMIRRORS', 'https?$://.*/.* file://%s/' % mirrordir)
         self.d.setVar('BB_FETCH_PREMIRRORONLY', '1')
         # Fetch again
         self.assertFalse(os.path.exists(ud.localpath))
@@ -2370,7 +2370,7 @@ class NPMTest(FetcherTest):
         bb.utils.mkdirhier(mirrordir)
         mirrorfilename = os.path.join(mirrordir, os.path.basename(ud.localpath))
         os.replace(ud.localpath, mirrorfilename)
-        self.d.setVar('PREMIRRORS', 'https?$://.*/.* file://%s\n' % mirrorfilename)
+        self.d.setVar('PREMIRRORS', 'https?$://.*/.* file://%s' % mirrorfilename)
         self.d.setVar('BB_FETCH_PREMIRRORONLY', '1')
         # Fetch again
         self.assertFalse(os.path.exists(ud.localpath))
@@ -2390,7 +2390,7 @@ class NPMTest(FetcherTest):
         mirrordir = os.path.join(self.tempdir, 'mirror')
         bb.utils.mkdirhier(mirrordir)
         os.replace(ud.localpath, os.path.join(mirrordir, os.path.basename(ud.localpath)))
-        self.d.setVar('MIRRORS', 'https?$://.*/.* file://%s/\n' % mirrordir)
+        self.d.setVar('MIRRORS', 'https?$://.*/.* file://%s/' % mirrordir)
         # Update the resolved url to an invalid url
         with open(ud.resolvefile, 'r') as f:
             url = f.read()
@@ -2706,7 +2706,7 @@ class NPMTest(FetcherTest):
         mirrordir = os.path.join(self.tempdir, 'mirror')
         bb.utils.mkdirhier(mirrordir)
         os.replace(ud.localpath, os.path.join(mirrordir, os.path.basename(ud.localpath)))
-        self.d.setVar('PREMIRRORS', 'https?$://.*/.* file://%s/\n' % mirrordir)
+        self.d.setVar('PREMIRRORS', 'https?$://.*/.* file://%s/' % mirrordir)
         self.d.setVar('BB_FETCH_PREMIRRORONLY', '1')
         # Fetch again
         self.assertFalse(os.path.exists(ud.localpath))
@@ -2735,7 +2735,7 @@ class NPMTest(FetcherTest):
         mirrordir = os.path.join(self.tempdir, 'mirror')
         bb.utils.mkdirhier(mirrordir)
         os.replace(ud.localpath, os.path.join(mirrordir, os.path.basename(ud.localpath)))
-        self.d.setVar('MIRRORS', 'https?$://.*/.* file://%s/\n' % mirrordir)
+        self.d.setVar('MIRRORS', 'https?$://.*/.* file://%s/' % mirrordir)
         # Fetch again with invalid url
         self.assertFalse(os.path.exists(ud.localpath))
         swfile = self.create_shrinkwrap_file({

