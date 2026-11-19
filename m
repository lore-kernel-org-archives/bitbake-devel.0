Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4740.1795121343177071651
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 19 Nov 2026 12:49:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=HUDwhvza;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: stondo@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4a34ffd3e39so94001f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 19 Nov 2026 12:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795121341; x=1795726141; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=px32SnLEIu5XcFTuQwUFsjPjpZpIjGqFg+ySxq62B5o=;
        b=HUDwhvza2bL71TFDWNHC09d3vlOcx8CNINS+NiQqp4dJcf+9HjpWcpLam1GLZXyJln
         ZfpsozaKam42ttQA3enDuaz7l4NYMimKFS3Tet3nWH6Zt0WHUHviT6et99j8xsvFkP/K
         xmh8PeI5ZgBexS5E+nMotUgJKbo6PYae1Clat2sQNssHKDRNa/JIbXedYLlbk0bqiYWN
         1V8l2r4dFYeBU8J7k/fJWZjuyTS7ZPyIRu3PFKQkxB4+fS/wyAZ4hXWvZWawtaSMOTuV
         BwF5fqzoj4zppZuKe4wQLdXRBN0syFcQ22B5cwdB1nbi/GaoujKn2btV+tqMjCd1kg5r
         p4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795121341; x=1795726141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=px32SnLEIu5XcFTuQwUFsjPjpZpIjGqFg+ySxq62B5o=;
        b=XFT4t6664Xq/IsHb8cDbM+CK44gayXpqygAscPkyji9NeAleViMsnm5j6orHIY7b8T
         +8rBfKOQwS3o+Nu+o+sowirxK0KwHJF91GVdztESJRM2nyxLeKHEQNzPCEERrRZTOznL
         XB7v0Ugi2cwsjYFCBBj/PDMV3fpR5S+fjZd5k/DI7af2G+Ys5L5NYfv4DY/th0H9qyYP
         18s3aocvrWl9gwg1UmJ6lDpqAPUpmRjYNruOfudHBodwmizazAL6wyPLiqZbsGSALudy
         /45OT3BV2jawplwF31sBhAUnXgI+TJwrHI8X0K6e8GpXndHKhj+k0IqjULRM/625qmEv
         CEWg==
X-Gm-Message-State: APuU4Z9lPgQ0C8VF8stslIkVfwcF4u0NiWoV2pF5ySKsLGetnB2khpmk
	HCQLsjab0vuPntVHoGLN8qfYb8E+0AdyBTtUQQHYc9RmQv3tW+wHNoqHd5VgMFgp
X-Gm-Gg: AZFdTZeD7OTIYGNGHnZv9VeMak8+mp0t9vl0/wtCGjPplo07X+YjNoqNVdufGfiNM0/
	a2poA9v8vISpaHyyee2Fp3/ikaUUAZqoIJRZVwL1q3T4n0dF7nBLO3O4eOtYiqfT9S+4d+vcirS
	mFSpGjo/u6R7Soi7XG4VsNzidrf59S/rgKtrRBsQSRJTHqYAhxN8bP3OkQWPx3oW8IWWFIgskux
	CvbKKpZnfbSUWw7SOW4urxsXQUF1nvYFsU4WFtCAMtI46FNJzfSSRTQu1BmcdUyuwbLVAtXqDGL
	3sAkgWPJZKS9SCJBDXrbGwgLw3K/hkbRBGpwAbYDzfYJac21ibMnQtbnL4IVjFNXJh0wUyZ0U93
	ihazf08TJnmLbvlM4JxMT9C/roxhNkXp7w1OmhFQLf8rg2nAG2TB9xLMWwPOSKhokX2t1pk9pXR
	lmMcSA84LdxtKH7ciLloL8mvWHwPK2xZaoY0Ia+A/71bIkbOCSc/J8GGU82s5OYaRHUUJiK+geA
	AzE3iv1lFi+xJi6rboEB3bbZh/l6HEpwKcvVb+X++qo4se7ZQAWszDzewiTCnoAZXI1HVnPCNRP
	vDK9jNifHWyGrAhZhFlR9TXBAo+bwxKb
X-Received: by 2002:a05:6000:613:b0:498:88f:14c8 with SMTP id ffacd0b85a97d-4abb0f3bc7emr1310685f8f.9.1795121341304;
        Thu, 19 Nov 2026 12:49:01 -0800 (PST)
Return-Path: <stondo@gmail.com>
Received: from fedora ([165.225.94.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2c8csm1749597f8f.2.2026.11.19.12.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 12:49:00 -0800 (PST)
From: Stefano Tondo <stondo@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>,
	Alexander Kanavin <alex.kanavin@gmail.com>,
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
	Paul Barker <paul@pbarker.dev>,
	Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	Peter Marko <peter.marko@siemens.com>,
	stefano.tondo.ext@siemens.com
Subject: [PATCH v2 2/2] fetch: Return the package identity of crate, gomod and npm URLs
Date: Thu, 19 Nov 2026 21:48:56 +0100
Message-ID: <20261119204856.2930668-3-stondo@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119204856.2930668-1-stondo@gmail.com>
References: <20261119204856.2930668-1-stondo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Thu, 19 Nov 2026 20:49:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20464
Content-Type: text/plain; charset="utf-8"

From: Stefano Tondo <stefano.tondo.ext@siemens.com>

Implement package_identity() for the crate, gomod, gomodgit and npm
fetchers. Packages from a registry other than the default one get a
repository_url qualifier in the purl. A gomod URL with mod=1 downloads
only the go.mod file, which is not built into anything, so it has no
identity.

Signed-off-by: Stefano Tondo <stefano.tondo.ext@siemens.com>
---
 lib/bb/fetch/crate.py |  7 +++++
 lib/bb/fetch/gomod.py | 16 +++++++++++
 lib/bb/fetch/npm.py   |  7 +++++
 lib/bb/tests/fetch.py | 64 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 94 insertions(+)

diff --git a/lib/bb/fetch/crate.py b/lib/bb/fetch/crate.py
index 16ea02d8a..bf38fa45b 100644
--- a/lib/bb/fetch/crate.py
+++ b/lib/bb/fetch/crate.py
@@ -103,11 +103,18 @@ class Crate(Wget):
             ud.versionsurl = "%s://%s/%s/versions" % (proto, host, name)
 
         ud.parm['downloadfilename'] = "%s-%s.crate" % (name, version)
+        ud.crate = (name, version, None if host == 'crates.io' else "%s://%s" % (proto, host))
         if 'name' not in ud.parm:
             ud.parm['name'] = '%s-%s' % (name, version)
 
         logger.debug2("Fetching %s to %s" % (ud.url, ud.parm['downloadfilename']))
 
+    def package_identity(self, ud, d):
+        name, version, registry = ud.crate
+        qualifiers = {"repository_url": registry} if registry else None
+        purl = bb.fetch.package_url("cargo", name, version, qualifiers)
+        return bb.fetch.PackageIdentity(name, version, purl)
+
     def unpack(self, ud, rootdir, d):
         """
         Uses the crate to build the necessary paths for cargo to utilize it
diff --git a/lib/bb/fetch/gomod.py b/lib/bb/fetch/gomod.py
index a62d643fb..1950429d8 100644
--- a/lib/bb/fetch/gomod.py
+++ b/lib/bb/fetch/gomod.py
@@ -80,6 +80,13 @@ def escape(path):
     return re.sub(r'([A-Z])', lambda m: '!' + m.group(1).lower(), path)
 
 
+def go_package_identity(ud):
+    module = ud.parm['module']
+    version = ud.parm['version']
+    return bb.fetch.PackageIdentity(module, version,
+                                    bb.fetch.package_url("golang", module, version))
+
+
 class GoMod(Wget):
     """Class to fetch Go modules from a Go module proxy via wget"""
 
@@ -127,6 +134,12 @@ class GoMod(Wget):
 
         super().urldata_init(ud, d)
 
+    def package_identity(self, ud, d):
+        # A go.mod file alone is not built into anything
+        if ud.parm.get('mod', '0') == '1':
+            return None
+        return go_package_identity(ud)
+
     def unpack(self, ud, rootdir, d):
         """Unpack the module in the module cache."""
 
@@ -218,6 +231,9 @@ class GoModGit(Git):
 
         super().urldata_init(ud, d)
 
+    def package_identity(self, ud, d):
+        return go_package_identity(ud)
+
     def unpack(self, ud, rootdir, d):
         """Unpack the module in the module cache."""
 
diff --git a/lib/bb/fetch/npm.py b/lib/bb/fetch/npm.py
index c8995ba6b..be01591e6 100644
--- a/lib/bb/fetch/npm.py
+++ b/lib/bb/fetch/npm.py
@@ -225,6 +225,13 @@ class Npm(FetchMethod):
         ud.needdonestamp = False
         ud.resolvefile = self.localpath(ud, d) + ".resolved"
 
+    def package_identity(self, ud, d):
+        qualifiers = None
+        if ud.registry.rstrip("/") != "https://registry.npmjs.org":
+            qualifiers = {"repository_url": ud.registry}
+        purl = bb.fetch.package_url("npm", ud.package, ud.version, qualifiers)
+        return bb.fetch.PackageIdentity(ud.package, ud.version, purl)
+
     def _resolve_proxy_url(self, ud, d):
         """Resolve the tarball URL from the registry and cache it without any checksum.
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 61dc06660..104ee1f68 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -4731,3 +4731,67 @@ class GitUnpackUpdateTest(FetcherTest):
 
         with open(os.path.join(unpack_path, 'testfile.txt')) as f:
             self.assertEqual(f.read(), 'updated content\n')
+
+
+class PackageIdentityTest(FetcherTest):
+    """package_identity() works from the URL alone, without network access."""
+
+    def identity(self, url):
+        fetcher = bb.fetch.Fetch([url], self.d)
+        ud = fetcher.ud[url]
+        return ud.method.package_identity(ud, self.d)
+
+    def test_crate(self):
+        self.assertEqual(self.identity("crate://crates.io/glob/0.2.11"), bb.fetch.PackageIdentity(
+            name="glob", version="0.2.11",
+            purl="pkg:cargo/glob@0.2.11"))
+
+    def test_crate_alternate_registry(self):
+        self.assertEqual(self.identity("crate://crates.example.com/glob/0.2.11"), bb.fetch.PackageIdentity(
+            name="glob", version="0.2.11",
+            purl="pkg:cargo/glob@0.2.11?repository_url=https%3A%2F%2Fcrates.example.com"))
+
+    def test_gomod(self):
+        url = ('gomod://github.com/Azure/azure-sdk-for-go/sdk/storage/azblob;version=v1.0.0;'
+               'sha256sum=9bb69aea32f1d59711701f9562d66432c9c0374205e5009d1d1a62f03fb4fdad')
+        self.assertEqual(self.identity(url), bb.fetch.PackageIdentity(
+            name="github.com/Azure/azure-sdk-for-go/sdk/storage/azblob", version="v1.0.0",
+            purl="pkg:golang/github.com/Azure/azure-sdk-for-go/sdk/storage/azblob@v1.0.0"))
+
+    def test_gomod_go_mod_only(self):
+        # A go.mod file alone is not built into anything
+        url = ('gomod://github.com/Azure/azure-sdk-for-go/sdk/storage/azblob;version=v1.0.0;mod=1;'
+               'sha256sum=7873b8544842329b4f385a3aa6cf82cc2bc8defb41a04fa5291c35fd5900e873')
+        self.assertIsNone(self.identity(url))
+
+    def test_gomodgit(self):
+        url = ('gomodgit://golang.org/x/net;version=v0.9.0;repo=go.googlesource.com/net;'
+               'srcrev=694cff8668bac64e0864b552bffc280cd27f21b1')
+        self.assertEqual(self.identity(url), bb.fetch.PackageIdentity(
+            name="golang.org/x/net", version="v0.9.0",
+            purl="pkg:golang/golang.org/x/net@v0.9.0"))
+
+    def test_npm(self):
+        url = ('npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
+               ';sha512sum=f2dd7d88cb9a129fbb97eb87a8b5103bab24f783420fd7587f8000a355a12bf7'
+               '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc4de9223')
+        self.assertEqual(self.identity(url), bb.fetch.PackageIdentity(
+            name="@savoirfairelinux/node-server-example", version="1.0.0",
+            purl="pkg:npm/%40savoirfairelinux/node-server-example@1.0.0"))
+
+    def test_npm_alternate_registry(self):
+        url = ('npm://npm.example.com/registry;package=foo;version=1.2.3'
+               ';sha512sum=f2dd7d88cb9a129fbb97eb87a8b5103bab24f783420fd7587f8000a355a12bf7'
+               '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc4de9223')
+        self.assertEqual(self.identity(url), bb.fetch.PackageIdentity(
+            name="foo", version="1.2.3",
+            purl="pkg:npm/foo@1.2.3?repository_url=https%3A%2F%2Fnpm.example.com%2Fregistry"))
+
+    def test_git_has_none(self):
+        url = ("git://git.yoctoproject.org/git-submodule-test;branch=master;protocol=https;"
+               "rev=f280847494763cdcf71197557a81ba7d8a6bce42")
+        self.assertIsNone(self.identity(url))
+
+    def test_package_url_encoding(self):
+        self.assertEqual(bb.fetch.package_url("golang", "example.com/m", "v1.0.0+incompatible"),
+                         "pkg:golang/example.com/m@v1.0.0%2Bincompatible")
-- 
2.56.1

