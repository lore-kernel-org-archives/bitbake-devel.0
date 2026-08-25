Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593BBC61DBE
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 13:03:15 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21363.1787662988161520696
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2026 06:03:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=n8i88BPA;
 spf=pass (domain: bootlin.com, ip: 185.246.85.4, mailfrom: antonin.godard@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 76A0D4E4138B
	for <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 13:03:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4793D604C4;
	Tue, 25 Aug 2026 13:03:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3702A11C794E5;
	Tue, 25 Aug 2026 15:03:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787662985; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OR53Nriv8qx7IYqtOoV3vkOHmCq2RtQKNm0SVYqzl6k=;
	b=n8i88BPAAcNrh44bAVlECWmy856hmVdlh10Yg/tCXQjSJX//MUOZAkA5UDyNwDEumyGM+p
	e7IhlHf7NZJva8uXEgFKytvWjci5WRVKAg7eVW3cxrNTos4VA+wsetU2GfTIbmQivJn3Sk
	Y9dGRozaiMXTdTHk5S/8KqTSsf+ZMRKVxEkDkjfjazs2Q/fkEEcBgYBJi5VIU2mye0fdf6
	J9QKBrUJXtYknJjK/m7L9vt48IRFzbl/x1ReXXMsbfRPqapiou/HPhU73ib512W4ffls85
	KzAAGn0eWrNb1OWT8LJTZh/xQ7iuQL3CQ/pYaUyCCRCDOo2NIlLt7hmzv1ZAvQ==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 25 Aug 2026 15:02:57 +0200
Subject: [2.18][PATCH 1/2] fetch/{npm,npmsw}: re-enable fetchers now that
 checksums come from SRC_URI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-enable-npmsw-fetcher-wrynose-v1-1-425c8cc1e111@bootlin.com>
References: <20260825-enable-npmsw-fetcher-wrynose-v1-0-425c8cc1e111@bootlin.com>
In-Reply-To: <20260825-enable-npmsw-fetcher-wrynose-v1-0-425c8cc1e111@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Thomas Perrot <thomas.perrot@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Richard Purdie <richard.purdie@linuxfoundation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13449;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=CJfuaeVWtT5o1aAIbuts44Qi3GoPRowX5o/pMFPDTx8=;
 b=owEBbQKS/ZANAwAKAdGAQUApo6g2AcsmYgBqjZKHNFae5Id49FpEffpcpAHPYhlxbpevplTmU
 vsIWQ5qiwKJAjMEAAEKAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCao2ShwAKCRDRgEFAKaOo
 NjD1D/993AQobShvXmF9gJqBZav+5pdjj0T4ajqZ4Pz5N8N5QNfkD/bbaA80EJntmm8lZ1hXDMT
 Wa/0f7M5P9bjTSoH/RZMHhFMwidU5txEeB3KnzZcX7RC3aa2jlmbP1wyjLH4lr8jko1k9jRiRq+
 mtgXQgiaUT1qFD/j4T8HwTx2Kz1/vqqkXigxNgyrrT1tqICdtnMSW4NDmDWXNf0L6uIah5kGgD3
 hokvpmyCHDEQ5+eJ+R6StZxpud44nyAb4WBf/4/BdjCtSr/iCeC0CQoYR+KkBgyxCc+S8Qxos5C
 +niemPvTGa59mOGFuZBuFrtBmI7NGbQvwVPuKfpTRliUj2IFKCX53ahXRDvIe6A0X8mwLgZCwpe
 UjGE3Ee7K/FzCUMXr1DZ98NLCHHdAtjhVjuInrN/mT4UESBtlgvWe+yBMy3/WkUf4tOD9Oi0V/c
 m/1xxmLcNq4py3a3qDzYfjKQqIotmpumkqe3SZZsaF5DdiV3V4zZYMNXKje6d5j3zm1pvkm/0De
 VlHHOEoqQJ2yUvEkxstrtP4N6rtwOsUBUbB7+HaTllxDjAO/NdZaraDMIjzCAVDrTje1Mq+JAqQ
 DqTIK7aGXIZgEhIgTTCbhIa2Ah927OfWWVAemtGb2g7CKQqlCl0p/GjYJzKeEyzOn5m06zercJ0
 ExRn1tjc+ouukiw==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Aug 2026 13:03:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20033

From: Thomas Perrot <thomas.perrot@bootlin.com>

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
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 9e45e00a2009f28829417c9517f5ab623f66dd5d)
Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 lib/bb/fetch2/npm.py   | 111 +++++++++++++++++++++++++++++--------------------
 lib/bb/fetch2/npmsw.py |  12 +++---
 2 files changed, 72 insertions(+), 51 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index ed9ed167946..0b4dc69fd96 100644
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
@@ -150,11 +159,7 @@ class Npm(FetchMethod):
 
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
@@ -176,11 +181,32 @@ class Npm(FetchMethod):
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
@@ -202,6 +228,13 @@ class Npm(FetchMethod):
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
@@ -217,50 +250,27 @@ class Npm(FetchMethod):
 
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
@@ -268,13 +278,26 @@ class Npm(FetchMethod):
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
@@ -298,8 +321,6 @@ class Npm(FetchMethod):
         """Force a fetch, even if localpath exists ?"""
         if not os.path.exists(ud.resolvefile):
             return True
-        if ud.version == "latest":
-            return True
         proxy_m, proxy_ud, proxy_d = self._get_proxy_method(ud, d)
         return proxy_m.need_update(proxy_ud, proxy_d)
 
diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index 85f4482ad7d..6066a1d3c55 100644
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


