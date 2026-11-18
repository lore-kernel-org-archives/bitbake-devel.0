Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9004.1794994129965465178
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 18 Nov 2026 01:28:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=kxZ/XZWN;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: stondo@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so6641175e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 18 Nov 2026 01:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794994128; x=1795598928; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HOIs6CgJGHWZMj6qU8sO/Ckm+ezSEMcW27NRetgcMOM=;
        b=kxZ/XZWNdXnXa2wf4PiUmkvW/hrVG1lHRARg6ytRngLKhK1LI8whe3ylOdkxzp1AZe
         qJgP3/yIzwZlYqHy2YqKdiFPDUshz20xVbAhQFGjgjFt10auKkXo1+wijKdoivkK+OPR
         F8rWvyj3G6GfQjM/uANlmBpbPzVFjAPEPMIu7rFu3stFSHlPQGQIaTPnAA6oGMtEUGF6
         jZPXjvspaWRKqFnxrDsPupG5MWMv4lT4ZHb2FXjcW/U6H5R4ip7oOoblQk2PRRE0DpIq
         llT1pQh5Dk9DUe6TwG74GSVkx/rm/3MB+zDVOytvuGNji5pvGryfEQgFIHYKc7h/WF8L
         mZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794994128; x=1795598928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HOIs6CgJGHWZMj6qU8sO/Ckm+ezSEMcW27NRetgcMOM=;
        b=PktkicMjnVgwcrFusqZw+cIxmXPNG3cj0dHqk3jTNZjkJ05Lt+RN5plTdqSxRkCnSw
         l/gGnPGMaoGlJAK3ZK8qLWaAWqolk/rWoKixbGiHyHXOsJw8CLiQ6LO29wvgVFUs7o6F
         wq2wEQfE/hWQ1rkD7FTPQO+7acHoIlp1lx9EF1DNFi19zI/+77qOczegpYe9YA40SbrF
         +HieOZm6DAJVbZm9u7dMTAuVrLtl8LAh2TVpnWO+5w24zk/GGEpxJy3FnP4wsDsOG0sM
         ioZ/Rl0YkSwNlE9zcGki3h+yrnwx375FtH3wpwoKaurZoUWvoPlYYvRvq9Bi6EiEy7Wn
         YZ1w==
X-Gm-Message-State: APuU4Z+sMhJkol3EK6BVJEc9v3uKhFXeKtrq0RcG57bObTDg07GLvPaG
	BYVyYYuS5ElHnnrs72cH2HVjeFY5BvqbVZAh0Y+ScOjo58wQsCGdHKwV3LP+1w==
X-Gm-Gg: AYBFou19gN/BOKrjZ0z0Klhsg6GtSNjn3MNyPUfStOwzq+fj8hkNHX4m1TyrGrzQsSR
	L2uf54sCv8dHaO/jXdk8IfBBWaSvRZ2SOCaJU0YjAgi0cs/YPgUw2GyvLtOwv4z2D0C9JKq9r+b
	WAq/pppSIA7AhqS3CBxJmp52PqaVn86A/zCcMTz+XHEYWZyshOD3AOAdtc47sdn8oag94KIf9w2
	DI26AG6iB7HGfb25bMo+Fs9fKlTya7au4EjvmwwJlZPR7SHcA/GQc1HMFZvOlR3uq7Mude4VA15
	WgVkTRZiyPWGEXTbA16BQ8QIAD8JcFiDYAma/2CmAiIpn7YWCuZq+MLdrxegr1n90r5w3/uO13/
	FzSpG/av4BcnlfiRFgGB+zHoWUZ/utRx+e1XU8cfU04180FdbYpLWEc/nYWWMnL4aiXByIKGQ0M
	fBjT+OKMX/k8Bez8XdgnjlziM75ExpPTu3YaXq7KLC0D1lMTTqV4IwJ2EttrNsc1RvUaA1qUXa8
	VtYIeNt6+D7V5/zRsbW/HUpUl7aMdaCM2m8KniaswgkUT9srGePc6aiSrYm1X/hY870qLSWLd4I
	Xc52oyvtAwM=
X-Received: by 2002:a05:600c:4e04:b0:4a1:fc98:1cb1 with SMTP id 5b1f17b1804b1-4bb7d5d4113mr33084885e9.2.1794994127968;
        Wed, 18 Nov 2026 01:28:47 -0800 (PST)
Return-Path: <stondo@gmail.com>
Received: from fedora ([165.225.94.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7defa59csm27007085e9.3.2026.11.18.01.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 01:28:43 -0800 (PST)
From: Stefano Tondo <stondo@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>,
	Alexander Kanavin <alex.kanavin@gmail.com>,
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
	Stefano Tondo <stondo@gmail.com>,
	Stefano Tondo <stefano.tondo.ext@siemens.com>
Subject: [PATCH 2/2] fetch: Return the package identity of crate, gomod and npm URLs
Date: Wed, 18 Nov 2026 10:28:31 +0100
Message-ID: <20261118092831.201831-3-stondo@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118092831.201831-1-stondo@gmail.com>
References: <20261118092831.201831-1-stondo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Wed, 18 Nov 2026 09:28:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20457
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
 lib/bb/tests/fetch.py | 63 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 93 insertions(+)

diff --git a/lib/bb/fetch/crate.py b/lib/bb/fetch/crate.py
index 16ea02d8a..bc0b032f2 100644
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
+        return {"name": name, "version": version, "purl": purl}
+
     def unpack(self, ud, rootdir, d):
         """
         Uses the crate to build the necessary paths for cargo to utilize it
diff --git a/lib/bb/fetch/gomod.py b/lib/bb/fetch/gomod.py
index a62d643fb..1ec640096 100644
--- a/lib/bb/fetch/gomod.py
+++ b/lib/bb/fetch/gomod.py
@@ -80,6 +80,13 @@ def escape(path):
     return re.sub(r'([A-Z])', lambda m: '!' + m.group(1).lower(), path)
 
 
+def go_package_identity(ud):
+    module = ud.parm['module']
+    version = ud.parm['version']
+    return {"name": module, "version": version,
+            "purl": bb.fetch.package_url("golang", module, version)}
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
index c8995ba6b..356002381 100644
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
+        return {"name": ud.package, "version": ud.version, "purl": purl}
+
     def _resolve_proxy_url(self, ud, d):
         """Resolve the tarball URL from the registry and cache it without any checksum.
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 61dc06660..26066f566 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -4731,3 +4731,66 @@ class GitUnpackUpdateTest(FetcherTest):
 
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
+        self.assertEqual(self.identity("crate://crates.io/glob/0.2.11"),
+                         {"name": "glob", "version": "0.2.11", "purl": "pkg:cargo/glob@0.2.11"})
+
+    def test_crate_alternate_registry(self):
+        self.assertEqual(self.identity("crate://crates.example.com/glob/0.2.11"),
+                         {"name": "glob", "version": "0.2.11",
+                          "purl": "pkg:cargo/glob@0.2.11?repository_url=https%3A%2F%2Fcrates.example.com"})
+
+    def test_gomod(self):
+        url = ('gomod://github.com/Azure/azure-sdk-for-go/sdk/storage/azblob;version=v1.0.0;'
+               'sha256sum=9bb69aea32f1d59711701f9562d66432c9c0374205e5009d1d1a62f03fb4fdad')
+        self.assertEqual(self.identity(url),
+                         {"name": "github.com/Azure/azure-sdk-for-go/sdk/storage/azblob", "version": "v1.0.0",
+                          "purl": "pkg:golang/github.com/Azure/azure-sdk-for-go/sdk/storage/azblob@v1.0.0"})
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
+        self.assertEqual(self.identity(url),
+                         {"name": "golang.org/x/net", "version": "v0.9.0",
+                          "purl": "pkg:golang/golang.org/x/net@v0.9.0"})
+
+    def test_npm(self):
+        url = ('npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
+               ';sha512sum=f2dd7d88cb9a129fbb97eb87a8b5103bab24f783420fd7587f8000a355a12bf7'
+               '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc4de9223')
+        self.assertEqual(self.identity(url),
+                         {"name": "@savoirfairelinux/node-server-example", "version": "1.0.0",
+                          "purl": "pkg:npm/%40savoirfairelinux/node-server-example@1.0.0"})
+
+    def test_npm_alternate_registry(self):
+        url = ('npm://npm.example.com/registry;package=foo;version=1.2.3'
+               ';sha512sum=f2dd7d88cb9a129fbb97eb87a8b5103bab24f783420fd7587f8000a355a12bf7'
+               '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc4de9223')
+        self.assertEqual(self.identity(url),
+                         {"name": "foo", "version": "1.2.3",
+                          "purl": "pkg:npm/foo@1.2.3?repository_url=https%3A%2F%2Fnpm.example.com%2Fregistry"})
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

