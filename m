Return-Path: <thomas.perrot@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3145C5516F
	for <webhook@archiver.kernel.org>; Fri, 31 Jul 2026 12:46:16 +0000 (UTC)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5773.1785501966549865250
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 31 Jul 2026 05:46:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=SezFdkDs;
 spf=pass (domain: bootlin.com, ip: 185.246.84.56, mailfrom: thomas.perrot@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D8A2C1A1354
	for <bitbake-devel@lists.openembedded.org>; Fri, 31 Jul 2026 12:46:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id AD2726039A
	for <bitbake-devel@lists.openembedded.org>; Fri, 31 Jul 2026 12:46:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1397611C16813;
	Fri, 31 Jul 2026 14:46:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785501960; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=aTSW4w2Bc2gk6qBF0mEQ6J3v+cB2vAVT9J3sBWk5Cxs=;
	b=SezFdkDswuQRcZTd3Lbmc4ZOdEPvi1k0taiq8Feq7zUGuQZBjrFf5cC7jwwzHnThyR92TB
	SNdsoJZGnke2f9q5xaDKpV6nQ5oufPdVKycWzyI+bCQ6lsv8shRoLWccHsiWNNg6EN4U1c
	cBL5b7dOSL6W0l+l2O4e/Fmx/ZmKEvAkZ7Nx3k3m6eCUp4g/rWYgQ7nUcZlvLQ7h7d7Tv7
	kPgjlV9A3jXuVFuCGk6t8rc4dAKnd85qGgNSOn8uN+SlCntUotRIRKvFIY3sf73NlYX/X3
	wrgolbYDXlBVJqz9p4w4G2xmomHbn89BbIOd7vNYrykTk0VDEuntoXn4cS/Rig==
From: Thomas Perrot <thomas.perrot@bootlin.com>
Date: Fri, 31 Jul 2026 14:45:51 +0200
Subject: [PATCH v2 1/2] fetch/{npm,npmsw}: re-enable fetchers now that
 checksums come from SRC_URI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-dev-tprrt-fix-npm-v2-1-67b65c67de4e@bootlin.com>
References: <20260731-dev-tprrt-fix-npm-v2-0-67b65c67de4e@bootlin.com>
In-Reply-To: <20260731-dev-tprrt-fix-npm-v2-0-67b65c67de4e@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Thomas Perrot <thomas.perrot@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 31 Jul 2026 12:46:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19893

The npm and npmsw fetchers were disabled in 355cd226 because the npm
fetcher accepted checksums from the remote registry rather than from
the recipe. A compromised registry controls both the tarball and its
advertised hash, making checksum verification meaningless.

npmsw was also disabled at that point, but its security model is
already correct: checksums come from the locally-committed
npm-shrinkwrap.json file, not from the network. Re-enable it with a
fix for the missing FetchError import that would cause a NameError on
malformed shrinkwrap files. Also fix two correctness bugs:
- change 'if not packages' to 'if packages is None' in
  foreach_dependencies so a valid zero-dependency shrinkwrap
  (packages={}) no longer raises FetchError.
- add 'elif resolved is None' guard before the startswith chain in
  _resolve_dependency so missing 'resolved' fields raise
  ParameterError instead of AttributeError.

For npm, fix the root cause by separating URL resolution from checksum
handling:
- _resolve_proxy_url now stores only the bare tarball URL in the
  .resolved file; the registry-supplied dist.integrity / dist.shasum
  values are ignored entirely.
- _setup_proxy builds the proxy URL from that bare tarball URL and
  injects the checksum from the recipe's SRC_URI parameters
  (sha512sum=, sha256sum=, etc.).  uri.params is cleared before
  rebuilding so that a .resolved file written by the npmsw fetcher
  (which stores the full URI with checksum params) cannot smuggle a
  registry-sourced checksum into the npm proxy URL.
- A checksum is now mandatory: urldata_init raises
  MissingParameterError if none of sha512sum/sha256sum/sha384sum/
  sha1sum is present in SRC_URI. Unlike wget, npm has no independent
  anchor for the fetched content (no pinned commit, no fixed path) --
  the registry is exactly the party this fetcher was disabled for not
  trusting -- so, unlike the rest of BitBake's fetchers, this
  requirement is unconditional and does not depend on
  BB_STRICT_CHECKSUM.
- version=latest is now a hard ParameterError instead of a warning;
  it is inherently non-reproducible. The dead
  'if ud.version == "latest": return True' branch in need_update() is
  also removed, since version=latest is rejected at urldata_init time.
- Narrow the broad 'except Exception' in _npm_view to only catch
  json.JSONDecodeError; FetchError and ParameterError now propagate
  directly to the caller instead of being re-wrapped as a generic
  FetchError, fixing typed exception handling for version mismatches.
  Fall back to str(error) when 'summary' is absent in the registry
  error dict so the message is never silently None.

Note: existing .resolved files written by the old fetcher embed a
registry-sourced checksum in the URL and must be removed before
rebuilding.

[YOCTO #16105]

Signed-off-by: Thomas Perrot <thomas.perrot@bootlin.com>
---
 lib/bb/fetch2/npm.py   | 111 +++++++++++++++++++++++++++++--------------------
 lib/bb/fetch2/npmsw.py |  12 +++---
 2 files changed, 72 insertions(+), 51 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 3c0cd9ff098c..a429a8292677 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -16,6 +16,11 @@ Supported SRC_URI options are:
 - version
     The npm package version. This is a mandatory parameter.
 
+- sha512sum / sha256sum / sha384sum / sha1sum
+    The expected checksum of the downloaded tarball. Exactly one is
+    mandatory: the registry cannot be trusted to supply its own tamper
+    detection, so the checksum must come from the recipe.
+
 - downloadfilename
     Specifies the filename used when storing the downloaded file.
 
@@ -33,6 +38,7 @@ import bb
 from bb.fetch2 import Fetch
 from bb.fetch2 import FetchError
 from bb.fetch2 import FetchMethod
+from bb.fetch2 import MalformedUrl
 from bb.fetch2 import MissingParameterError
 from bb.fetch2 import ParameterError
 from bb.fetch2 import URI
@@ -40,6 +46,9 @@ from bb.fetch2 import check_network_access
 from bb.fetch2 import runfetchcmd
 from bb.utils import is_semver
 
+# Preference order matches strength; the first one present in SRC_URI wins.
+CHECKSUM_PARMS = ("sha512sum", "sha256sum", "sha384sum", "sha1sum")
+
 def npm_package(package):
     """Convert the npm package name to remove unsupported character"""
     # For scoped package names ('@user/package') the '/' is replaced by a '-'.
@@ -148,11 +157,7 @@ class Npm(FetchMethod):
 
     def supports(self, ud, d):
         """Check if a given url can be fetched with npm"""
-        #return ud.type in ["npm"]
-        if ud.type in ["npm"]:
-            from bb.parse import SkipRecipe
-            raise SkipRecipe("The npm fetcher has been disabled due to security issues and there is no maintainer to address them")
-        return False
+        return ud.type in ["npm"]
 
     def urldata_init(self, ud, d):
         """Init npm specific variables within url data"""
@@ -174,11 +179,32 @@ class Npm(FetchMethod):
         if not ud.version:
             raise MissingParameterError("Parameter 'version' required", ud.url)
 
-        if not is_semver(ud.version) and not ud.version == "latest":
+        if ud.version == "latest":
+            raise ParameterError(
+                "Version 'latest' is not reproducible; specify an exact semver version",
+                ud.url)
+
+        if not is_semver(ud.version):
             raise ParameterError("Invalid 'version' parameter", ud.url)
 
         # Extract the 'registry' part of the url
         ud.registry = re.sub(r"^npm://", "https://", ud.url.split(";")[0])
+        if not ud.url.split(";")[0][len("npm://"):]:
+            raise MalformedUrl(ud.url)
+
+        # A checksum is mandatory: the registry cannot be trusted to supply
+        # its own tamper detection, so the recipe must commit to one.
+        for cp in CHECKSUM_PARMS:
+            if cp in ud.parm:
+                ud.checksum_name = cp
+                ud.checksum_expected = ud.parm[cp]
+                break
+        else:
+            raise MissingParameterError(
+                "Missing checksum for npm package '%s@%s': a compromised "
+                "registry could otherwise serve a tampered tarball undetected. "
+                "Add one of %s to SRC_URI." % (ud.package, ud.version, ", ".join(CHECKSUM_PARMS)),
+                ud.url)
 
         # Using the 'downloadfilename' parameter as local filename
         # or the npm package name.
@@ -200,6 +226,13 @@ class Npm(FetchMethod):
         ud.resolvefile = self.localpath(ud, d) + ".resolved"
 
     def _resolve_proxy_url(self, ud, d):
+        """Resolve the tarball URL from the registry and cache it without any checksum.
+
+        Checksums must never be sourced from the registry: a compromised registry
+        controls both the tarball and its advertised hash, so any checksum obtained
+        there provides no tamper detection. Checksums are applied in _setup_proxy
+        from the recipe-provided SRC_URI parameters instead.
+        """
         def _npm_view():
             args = []
             args.append(("json", "true"))
@@ -215,50 +248,27 @@ class Npm(FetchMethod):
 
             try:
                 view = json.loads(view_string)
-
-                error = view.get("error")
-                if error is not None:
-                    raise FetchError(error.get("summary"), ud.url)
-
-                if ud.version == "latest":
-                    bb.warn("The npm package %s is using the latest " \
-                            "version available. This could lead to " \
-                            "non-reproducible builds." % pkgver)
-                elif ud.version != view.get("version"):
-                    raise ParameterError("Invalid 'version' parameter", ud.url)
-
-                return view
-
-            except Exception as e:
+            except json.JSONDecodeError as e:
                 raise FetchError("Invalid view from npm: %s" % str(e), ud.url)
 
-        def _get_url(view):
-            tarball_url = view.get("dist", {}).get("tarball")
+            error = view.get("error")
+            if error is not None:
+                raise FetchError(error.get("summary") or str(error), ud.url)
 
-            if tarball_url is None:
-                raise FetchError("Invalid 'dist.tarball' in view", ud.url)
+            if ud.version != view.get("version"):
+                raise ParameterError("Invalid 'version' parameter", ud.url)
 
-            uri = URI(tarball_url)
-            uri.params["downloadfilename"] = ud.localfile
-
-            integrity = view.get("dist", {}).get("integrity")
-            shasum = view.get("dist", {}).get("shasum")
+            return view
 
-            if integrity is not None:
-                checksum_name, checksum_expected = npm_integrity(integrity)
-                uri.params[checksum_name] = checksum_expected
-            elif shasum is not None:
-                uri.params["sha1sum"] = shasum
-            else:
-                raise FetchError("Invalid 'dist.integrity' in view", ud.url)
+        view = _npm_view()
+        tarball_url = view.get("dist", {}).get("tarball")
 
-            return str(uri)
-
-        url = _get_url(_npm_view())
+        if tarball_url is None:
+            raise FetchError("Invalid 'dist.tarball' in view", ud.url)
 
         bb.utils.mkdirhier(os.path.dirname(ud.resolvefile))
         with open(ud.resolvefile, "w") as f:
-            f.write(url)
+            f.write(tarball_url)
 
     def _setup_proxy(self, ud, d):
         if ud.proxy is None:
@@ -266,13 +276,26 @@ class Npm(FetchMethod):
                 self._resolve_proxy_url(ud, d)
 
             with open(ud.resolvefile, "r") as f:
-                url = f.read()
+                tarball_url = f.read().strip()
+
+            uri = URI(tarball_url)
+            # Discard any params that may have been embedded in the stored URL
+            # (e.g. from an npmsw-written .resolved file) and rebuild from
+            # scratch so that registry-sourced checksums can never flow through.
+            uri.params = {}
+            uri.params["downloadfilename"] = ud.localfile
+
+            # Inject the recipe-provided checksum into the proxy URL.
+            # Checksums from the remote registry are never used; only the
+            # value validated in urldata_init, sourced from the recipe, is
+            # trusted.
+            uri.params[ud.checksum_name] = ud.checksum_expected
 
             # Avoid conflicts between the environment data and:
             # - the proxy url checksum
             data = bb.data.createCopy(d)
             data.delVarFlags("SRC_URI")
-            ud.proxy = Fetch([url], data)
+            ud.proxy = Fetch([str(uri)], data)
 
     def _get_proxy_method(self, ud, d):
         self._setup_proxy(ud, d)
@@ -296,8 +319,6 @@ class Npm(FetchMethod):
         """Force a fetch, even if localpath exists ?"""
         if not os.path.exists(ud.resolvefile):
             return True
-        if ud.version == "latest":
-            return True
         proxy_m, proxy_ud, proxy_d = self._get_proxy_method(ud, d)
         return proxy_m.need_update(proxy_ud, proxy_d)
 
diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index 5255e8b465e1..f09ea5794856 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -21,6 +21,7 @@ import json
 import os
 import re
 import bb
+from bb.fetch2 import FetchError
 from bb.fetch2 import Fetch
 from bb.fetch2 import FetchMethod
 from bb.fetch2 import ParameterError
@@ -44,7 +45,7 @@ def foreach_dependencies(shrinkwrap, callback=None, dev=False):
             location = the location of the package (string)
     """
     packages = shrinkwrap.get("packages")
-    if not packages:
+    if packages is None:
         raise FetchError("Invalid shrinkwrap file format")
 
     for location, data in packages.items():
@@ -63,11 +64,7 @@ class NpmShrinkWrap(FetchMethod):
 
     def supports(self, ud, d):
         """Check if a given url can be fetched with npmsw"""
-        #return ud.type in ["npmsw"]
-        if ud.type in ["npmsw"]:
-            from bb.parse import SkipRecipe
-            raise SkipRecipe("The npmsw fetcher has been disabled due to security issues and there is no maintainer to address them")
-        return False
+        return ud.type in ["npmsw"]
 
     def urldata_init(self, ud, d):
         """Init npmsw specific variables within url data"""
@@ -126,6 +123,9 @@ class NpmShrinkWrap(FetchMethod):
                 extrapaths.append(resolvefile)
 
             # Handle http tarball sources
+            elif resolved is None:
+                raise ParameterError("Missing 'resolved' field for dependency '%s'" % name, ud.url)
+
             elif resolved.startswith("http") and integrity:
                 localfile = npm_localfile(os.path.basename(resolved))
 

-- 
2.55.0


