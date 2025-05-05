Return-Path: <setairidis@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13FDC3ABBC
	for <webhook@archiver.kernel.org>; Mon,  5 May 2025 18:58:19 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web11.58956.1746471498175999816
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 05 May 2025 11:58:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GL3wvK/g;
 spf=pass (domain: gmail.com, ip: 209.85.208.54, mailfrom: setairidis@gmail.com)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so8377136a12.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 05 May 2025 11:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746471496; x=1747076296; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D2nEV7ikPlCmdecGrfQNtzC6ffDfC9uQtkSsioEJAGY=;
        b=GL3wvK/gFIZ0hFBDX9eJY/4MjxwPyjtKCsRc8VeEywPlp51pqgxWOZ+1PfjZqfapX1
         9HkaO+kN60hVfSdjbslMP68IDICnTcC22YIZN1yKblSq25UQIuANOEyMyzRw2ODns9df
         /Cae1kBcJc/LYsuHh0G6RJUDLYUA1PKeDuabWGpnubVpKxkOi+vQcihXNANrlNiM68zv
         LT3WehFD1XvwLrerSR8BFz8O/K6ZQx6bfK+lVIZWVNMzKMhPoM8riXL+ae6FtQdx6gIw
         5EqBU65ePGr6+EP5Xf5Ia0k1MuWRBoNsGogzU7ksm3WzJlKyLVASRV8OiwT7kRb5uB0G
         eMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746471496; x=1747076296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2nEV7ikPlCmdecGrfQNtzC6ffDfC9uQtkSsioEJAGY=;
        b=FIS9W8f6KG9ERVwjRjd+C8tHRfg5w1QaxhQxXIz60nV2TsdOC+1mPE1n4OQSGGzq7O
         wmY9WIixhkPFOQInBA0iOcnDYehdrLz2qtlc0+gRJk2Yx+NPyOzZhaI2T1e+0PoaI8QX
         QrHqMGPQk0nbl258PqOyci0pplkGDYn6KT9414r+xhhE3eSoDVkMIkSCBE9C/bP4T0l6
         JohRTRaoq8GJQEQ83FqL0mjFQR4OtzjgnLoetXb84FJXa9KA9+Nf6A0LXMR/9SJwL9z+
         xQC8ksdsLa2y9xTiQYF6qfWiSUAbrZhkvLvIUGeIeHiZUyaWlppLmwzX68ipjmBtFvda
         2dkQ==
X-Gm-Message-State: AOJu0YygbQ4LcMOQi+6i0706XDqUGGb/vQG+/8VpcdQoAMgRg27aBHFx
	TTpWKvg/x8pOO8s4v46uHiMk0wxpdN4noflI4s6kkK+nCwpBs6scw6QKABqwlAk=
X-Gm-Gg: ASbGncviQN2UN8YAlD/f30bTC7sBTYaoGJ48GKZWC+yaJ1DzKeooCip46NS7vuzFbyb
	yVdsld8qvqTZQrWwQlVjG4cAoNZ/rM/D2Z0e+AJOGT6i/oz3i4wA8TfKnmfu2ekcRJukLLO3VY3
	oKWA3nwgsNsEhrVfNs021/Nykym5W/rsdQnGIbaHdSwSqDC3Ej3AeO/O5yAT02rF3h3krbXttGw
	w//cypjuwOKAhatOshswjb3K5iJk8uTec6hoscn+tXDQvn8LVB7dhkfioYTZ2ySVY7FpvySi9yS
	amz+JD7qMbNwwQl9QQsfDV5aSPAgcq9nLYLL0aZWEV3ZdkK64YaTeyE7ezNrexVNSLUh06F6EDR
	xHdrSnQvSn2Tn7jXiqBT1VdpZU3ea2xz+Tewnh08=
X-Google-Smtp-Source: AGHT+IHrTEzhw8k6BzhiIgi0z4172VQzV6zie1ljXe4VAdGnUGPcKpVgcblPZoGKuzQ2ggFTp47BTg==
X-Received: by 2002:a05:6402:2801:b0:5fa:a42f:70ee with SMTP id 4fb4d7f45d1cf-5fab04bbe66mr6369629a12.0.1746471496017;
        Mon, 05 May 2025 11:58:16 -0700 (PDT)
Received: from localhost.localdomain (ip-095-223-184-181.um35.pools.vodafone-ip.de. [95.223.184.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa77bf289esm5939862a12.69.2025.05.05.11.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 11:58:15 -0700 (PDT)
From: Savvas Etairidis <setairidis@gmail.com>
X-Google-Original-From: Savvas Etairidis <falital@hotmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	Savvas Etairidis <setairidis@gmail.com>,
	Savvas Etairidis <falital@hotmail.com>
Subject: [PATCH] bitbake: fetch: Add support for remapping URL's
Date: Mon,  5 May 2025 20:57:55 +0200
Message-Id: <20250505185755.1952-1-falital@hotmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 05 May 2025 18:58:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17593

From: Savvas Etairidis <setairidis@gmail.com>

This commit adds support for remapping URL's in the fetcher.
This is useful for cases where the same server is access with
different protocols or different URL's. The remapping is done by
adding a remap entry to the global configuration or the recipe file.

Fixed #10699

Signed-off-by: Savvas Etairidis <falital@hotmail.com>
---
 .../bitbake-user-manual-fetching.rst          |  10 ++
 .../bitbake-user-manual-ref-variables.rst     |   9 ++
 bitbake/lib/bb/fetch2/__init__.py             |  68 +++++++++++-
 bitbake/lib/bb/tests/fetch.py                 | 104 +++++++++++++++++-
 4 files changed, 187 insertions(+), 4 deletions(-)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index fb4f0a23d7..e932fc12e0 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -148,6 +148,16 @@ If :term:`BB_CHECK_SSL_CERTS` is set to ``0`` then SSL certificate checking will
 be disabled. This variable defaults to ``1`` so SSL certificates are normally
 checked.
 
+If :term:`BB_ALLOW_URL_REMAP` is set to ``1`` then URL's will be remapped
+based on the rules defined in :term:`BB_URL_REMAP` the varriable can be set
+in the global configuration or in the recipe.
+
+Here is a examples of how to set the variable::
+
+   BB_URL_REMAP = "\
+       git://example.com/ https://example.com/ \
+       http://example.com/ https://example.com/"
+
 .. _bb-the-unpack:
 
 The Unpack
diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 477443e228..1695a9e980 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -494,6 +494,15 @@ overview of their function and contents.
       running builds when not connected to the Internet, and when operating
       in certain kinds of firewall environments.
 
+   :term:`BB_ALLOW_URL_REMAP`
+      Allows the use of the :term:`BB_URL_REMAP` variable to remap URL's.
+
+   :term:`BB_URL_REMAP`
+      A table of remappings. This variable is used to remap URLs to
+      different locations. The remapping is done by the fetcher module
+      before the fetcher attempts to access the URL. The remapping is
+      performed by replacing the string with the remapped string.
+
    :term:`BB_NUMBER_PARSE_THREADS`
       Sets the number of threads BitBake uses when parsing. By default, the
       number of threads is equal to the number of cores on the system.
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 2de4f4f8c0..24918887fc 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -222,7 +222,7 @@ class URI(object):
 
         # We hijack the URL parameters, since the way bitbake uses
         # them are not quite RFC compliant.
-        uri, param_str = (uri.split(";", 1) + [None])[:2]
+        uri, param_str = self.split_uri_and_parameters(uri)
 
         urlp = urllib.parse.urlparse(uri)
         self.scheme = urlp.scheme
@@ -298,6 +298,13 @@ class URI(object):
     def _param_str_join(self, dict_, elmdelim, kvdelim="="):
         return elmdelim.join([kvdelim.join([k, v]) if v else k for k, v in dict_.items()])
 
+    @staticmethod
+    def split_uri_and_parameters(uri):
+        """
+        Splits the URI into the URI and the parameters.
+        """
+        return (uri.split(";", 1) + [None])[:2]
+
     @property
     def hostport(self):
         if not self.port:
@@ -1319,9 +1326,9 @@ class FetchData(object):
         self.mirrortarballs = []
         self.basename = None
         self.basepath = None
-        (self.type, self.host, self.path, self.user, self.pswd, self.parm) = decodeurl(d.expand(url))
+        self.url = self.remap_url_if_needed(d.expand(url), self.load_url_remap_data(d))
+        (self.type, self.host, self.path, self.user, self.pswd, self.parm) = decodeurl(self.url)
         self.date = self.getSRCDate(d)
-        self.url = url
         if not self.user and "user" in self.parm:
             self.user = self.parm["user"]
         if not self.pswd and "pswd" in self.parm:
@@ -1424,6 +1431,61 @@ class FetchData(object):
 
         return d.getVar("SRCDATE") or d.getVar("DATE")
 
+    def parse_url_remap_entries(self, pkgname, url_remap_entries, entries_as_str):
+        """
+        Parse the URL remap entries from the given dictionary.
+        """
+        if not entries_as_str:
+            return url_remap_entries
+
+        for entry in entries_as_str.split('\n'):
+            try:
+                from_url, to_url = entry.split()
+                url_remap_entries[from_url] = to_url
+            except ValueError:
+                logger.warning("Package %s contains invalid URL remap entry: %s", entry, pkgname)
+                continue
+
+        return url_remap_entries
+
+    def load_url_remap_data(self, d):
+        """
+        Load URL remap data from the package-specific and global variables.
+        """
+        url_remap_entries = {}
+
+        allow_url_remap = d.getVar('BB_ALLOW_URL_REMAP')
+        if not allow_url_remap or not bb.utils.to_boolean(allow_url_remap):
+            logger.debug("URL remapping is disabled")
+            return url_remap_entries
+
+        pkgname = d.getVar('PN')
+        if pkgname:
+            # Check for URL remap entries in the package-specific variable
+            url_remap_entries = self.parse_url_remap_entries(pkgname,
+                                                             url_remap_entries,
+                                                             d.getVarFlag('BB_URL_REMAP', pkgname, False))
+
+        # Check for URL remap entries in the global variable
+        url_remap_entries = self.parse_url_remap_entries(pkgname,
+                                                         url_remap_entries,
+                                                         d.getVar('BB_URL_REMAP'))
+
+        return url_remap_entries
+
+    def remap_url_if_needed(self, base_url, url_remap_entries):
+        """
+        Remap the URL if needed based on the URL remap data.
+        """
+        uri, paramters = URI.split_uri_and_parameters(base_url)
+        for from_url, to_url in url_remap_entries.items():
+            if uri.startswith(from_url):
+                uri = uri.replace(from_url, to_url, 1) + ';' + paramters
+                logger.debug("Remapped URL %s to %s", base_url, uri)
+                print("Remapped URL %s to %s" % (base_url, uri))
+                return uri
+        return base_url
+
 class FetchMethod(object):
     """Base class for 'fetch'ing data"""
 
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index f0c628524c..670781ad93 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -602,13 +602,19 @@ class GitDownloadDirectoryNamingTest(FetcherTest):
 
     @skipIfNoNetwork()
     def test_that_directory_is_named_after_recipe_url_when_no_mirroring_is_used(self):
-        self.setup_mirror_rewrite()
         fetcher = bb.fetch.Fetch([self.recipe_url], self.d)
 
         fetcher.download()
 
         dir = os.listdir(self.dldir + "/git2")
         self.assertIn(self.recipe_dir, dir)
+        self.assertIn(self.recipe_dir + '.done', dir)
+        self.assertNotIn(self.mirror_dir, dir)
+        self.assertNotIn(self.mirror_dir + '.done', dir)
+        self.assertEqual(len(dir), len([
+            self.recipe_dir,
+            self.recipe_dir + '.done'
+        ]))
 
     @skipIfNoNetwork()
     def test_that_directory_exists_for_mirrored_url_and_recipe_url_when_mirroring_is_used(self):
@@ -620,6 +626,12 @@ class GitDownloadDirectoryNamingTest(FetcherTest):
         dir = os.listdir(self.dldir + "/git2")
         self.assertIn(self.mirror_dir, dir)
         self.assertIn(self.recipe_dir, dir)
+        self.assertIn(self.recipe_dir + '.done', dir)
+        self.assertEqual(len(dir), len([
+            self.recipe_dir,
+            self.recipe_dir + '.done',
+            self.mirror_dir
+        ]))
 
     @skipIfNoNetwork()
     def test_that_recipe_directory_and_mirrored_directory_exists_when_mirroring_is_used_and_the_mirrored_directory_already_exists(self):
@@ -632,7 +644,15 @@ class GitDownloadDirectoryNamingTest(FetcherTest):
 
         dir = os.listdir(self.dldir + "/git2")
         self.assertIn(self.mirror_dir, dir)
+        self.assertIn(self.mirror_dir + '.done', dir)
         self.assertIn(self.recipe_dir, dir)
+        self.assertIn(self.recipe_dir + '.done', dir)
+        self.assertEqual(len(dir), len([
+            self.recipe_dir,
+            self.recipe_dir + '.done',
+            self.mirror_dir,
+            self.mirror_dir + '.done'
+        ]))
 
 
 class TarballNamingTest(FetcherTest):
@@ -657,6 +677,15 @@ class TarballNamingTest(FetcherTest):
 
         dir = os.listdir(self.dldir)
         self.assertIn(self.recipe_tarball, dir)
+        self.assertIn(self.recipe_tarball + '.done', dir)
+        self.assertIn('git2', dir)
+        self.assertNotIn(self.mirror_tarball, dir)
+        self.assertNotIn(self.mirror_tarball + '.done', dir)
+        self.assertEqual(len(dir), len([
+            self.recipe_tarball,
+            self.recipe_tarball + '.done',
+            'git2'
+        ]))
 
     @skipIfNoNetwork()
     def test_that_the_mirror_tarball_is_created_when_mirroring_is_used(self):
@@ -666,7 +695,16 @@ class TarballNamingTest(FetcherTest):
         fetcher.download()
 
         dir = os.listdir(self.dldir)
+        self.assertNotIn(self.recipe_tarball, dir)
+        self.assertNotIn(self.recipe_tarball + '.done', dir)
+        self.assertIn('git2', dir)
         self.assertIn(self.mirror_tarball, dir)
+        self.assertIn(self.mirror_tarball + '.done', dir)
+        self.assertEqual(len(dir), len([
+            self.mirror_tarball,
+            self.mirror_tarball + '.done',
+            'git2'
+        ]))
 
 
 class GitShallowTarballNamingTest(FetcherTest):
@@ -692,6 +730,15 @@ class GitShallowTarballNamingTest(FetcherTest):
 
         dir = os.listdir(self.dldir)
         self.assertIn(self.recipe_tarball, dir)
+        self.assertIn(self.recipe_tarball + '.done', dir)
+        self.assertIn('git2', dir)
+        self.assertNotIn(self.mirror_tarball, dir)
+        self.assertNotIn(self.mirror_tarball + '.done', dir)
+        self.assertEqual(len(dir), len([
+            self.recipe_tarball,
+            self.recipe_tarball + '.done',
+            'git2'
+        ]))
 
     @skipIfNoNetwork()
     def test_that_the_mirror_tarball_is_created_when_mirroring_is_used(self):
@@ -701,7 +748,62 @@ class GitShallowTarballNamingTest(FetcherTest):
         fetcher.download()
 
         dir = os.listdir(self.dldir)
+        self.assertNotIn(self.recipe_tarball, dir)
+        self.assertNotIn(self.recipe_tarball + '.done', dir)
         self.assertIn(self.mirror_tarball, dir)
+        self.assertIn(self.mirror_tarball + '.done', dir)
+        self.assertIn('git2', dir)
+        self.assertEqual(len(dir), len([
+            self.mirror_tarball,
+            self.mirror_tarball + '.done',
+            'git2'
+        ]))
+
+
+class GitSameUrl(FetcherTest):
+    def setUp(self):
+        super(GitSameUrl, self).setUp()
+        self.recipe_url = "git://git.openembedded.org/bitbake;branch=master;protocol=https"
+        self.recipe_tarball = "git.openembedded.org.bitbake"
+        self.recipe_url_two = "git://github.com/openembedded/bitbake.git;protocol=https;branch=master"
+        self.recipe_tarball_two = "github.com.openembedded.bitbake.git"
+
+        self.d.setVar('SRCREV', '82ea737a0b42a8b53e11c9cde141e9e9c0bd8c40')
+        self.d.setVar('BB_URL_REMAP', 'git://github.com/openembedded/bitbake.git git://git.openembedded.org/bitbake')
+
+    @skipIfNoNetwork()
+    def test_url_remap_allowed(self):
+        self.d.setVar('BB_ALLOW_URL_REMAP', '1')
+        fetcher = bb.fetch.Fetch([self.recipe_url, self.recipe_url_two], self.d)
+        fetcher.download()
+
+        dir = os.listdir(self.dldir + "/git2")
+        self.assertIn(self.recipe_tarball, dir)
+        self.assertIn(self.recipe_tarball + '.done', dir)
+        self.assertNotIn(self.recipe_tarball_two, dir)
+        self.assertNotIn(self.recipe_tarball_two + '.done', dir)
+        self.assertEqual(len(dir), len([
+            self.recipe_tarball,
+            self.recipe_tarball + '.done'
+        ]))
+
+    @skipIfNoNetwork()
+    def test_url_remap_not_allowed(self):
+        self.d.setVar('BB_ALLOW_URL_REMAP', '0')
+        fetcher = bb.fetch.Fetch([self.recipe_url, self.recipe_url_two], self.d)
+        fetcher.download()
+
+        dir = os.listdir(self.dldir + "/git2")
+        self.assertIn(self.recipe_tarball, dir)
+        self.assertIn(self.recipe_tarball + '.done', dir)
+        self.assertIn(self.recipe_tarball_two, dir)
+        self.assertIn(self.recipe_tarball_two + '.done', dir)
+        self.assertEqual(len(dir), len([
+            self.recipe_tarball,
+            self.recipe_tarball + '.done',
+            self.recipe_tarball_two,
+            self.recipe_tarball_two + '.done'
+        ]))
 
 
 class CleanTarballTest(FetcherTest):
-- 
2.34.1


