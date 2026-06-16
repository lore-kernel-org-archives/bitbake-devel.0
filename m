Return-Path: <thomas.perrot@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE0BCD98E1
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 13:37:58 +0000 (UTC)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.154410.1781617071845213964
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2026 06:37:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=dkim header.b=QJiHpju3;
 spf=pass (domain: bootlin.com, ip: 185.171.202.116, mailfrom: thomas.perrot@bootlin.com)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A088CC2BB32
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 13:37:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 18B80601A9
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 13:37:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 83E3E106C9D97;
	Tue, 16 Jun 2026 15:37:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781617054; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LyrdtF7sEmt4a0ckWy9jhWH2IHtP/2BKj2P7Df4jZB4=;
	b=QJiHpju31MNAW6SOrOooCVxeRHw/o6Y9T06CkMpR8+XMFxOokAptOA1wp4RFgH/Iiwm0sg
	nbw46476s/Td5aUWfZJWzE3rVjhttil2u2IABDxih2NcRHsZlGyuncQHc+TsVwirvxAiBF
	eyAqfYl9Fspanf4Q8IiGbFF3Er9g/1F4Ux5ueplJrjNCM2Bv2Om8NyJHO2C1cauxTQRuKO
	dK8wqyek7gx/QrkDCJcONKudqHaf/oo/B66MsSvBF2P2B6U1ERvSq1NaPR5T1/z7OuDrV6
	qzxClHvRkiKvju5TUJCMMJTs5RSXqZ82YHPJecpEzkJSkZOtRAXiu2NFwQLQnQ==
From: Thomas Perrot <thomas.perrot@bootlin.com>
Date: Tue, 16 Jun 2026 15:37:04 +0200
Subject: [PATCH 1/2] fetch/{npm,npmsw}: fix security issue and re-enable
 fetchers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-dev-tprrt-fix-npm-v1-1-6fde95bf0a8b@bootlin.com>
References: <20260616-dev-tprrt-fix-npm-v1-0-6fde95bf0a8b@bootlin.com>
In-Reply-To: <20260616-dev-tprrt-fix-npm-v1-0-6fde95bf0a8b@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Thomas Perrot <thomas.perrot@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 13:37:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19706

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
  registry-sourced checksum into the npm proxy URL.  When no checksum
  is provided the proxy URL carries none, and BitBake's standard
  BB_STRICT_CHECKSUM machinery handles the missing-checksum case the
  same way the wget fetcher does; bb.warn() is emitted to give recipe
  authors a clear signal instead of a silent unsigned download.
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
 lib/bb/fetch2/npm.py   | 94 ++++++++++++++++++++++++++------------------------
 lib/bb/fetch2/npmsw.py | 12 +++----
 2 files changed, 55 insertions(+), 51 deletions(-)

diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
index 3c0cd9ff098c..f9b16a4e1ddb 100644
--- a/lib/bb/fetch2/npm.py
+++ b/lib/bb/fetch2/npm.py
@@ -33,6 +33,7 @@ import bb
 from bb.fetch2 import Fetch
 from bb.fetch2 import FetchError
 from bb.fetch2 import FetchMethod
+from bb.fetch2 import MalformedUrl
 from bb.fetch2 import MissingParameterError
 from bb.fetch2 import ParameterError
 from bb.fetch2 import URI
@@ -148,11 +149,7 @@ class Npm(FetchMethod):
 
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
@@ -174,11 +171,18 @@ class Npm(FetchMethod):
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
 
         # Using the 'downloadfilename' parameter as local filename
         # or the npm package name.
@@ -200,6 +204,13 @@ class Npm(FetchMethod):
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
@@ -215,50 +226,27 @@ class Npm(FetchMethod):
 
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
+            return view
 
-            integrity = view.get("dist", {}).get("integrity")
-            shasum = view.get("dist", {}).get("shasum")
+        view = _npm_view()
+        tarball_url = view.get("dist", {}).get("tarball")
 
-            if integrity is not None:
-                checksum_name, checksum_expected = npm_integrity(integrity)
-                uri.params[checksum_name] = checksum_expected
-            elif shasum is not None:
-                uri.params["sha1sum"] = shasum
-            else:
-                raise FetchError("Invalid 'dist.integrity' in view", ud.url)
-
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
@@ -266,13 +254,31 @@ class Npm(FetchMethod):
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
+            # Checksums from the remote registry are never used; only values
+            # the recipe author has explicitly committed are trusted.
+            for cp in ("sha512sum", "sha256sum", "sha384sum", "sha1sum"):
+                if cp in ud.parm:
+                    uri.params[cp] = ud.parm[cp]
+                    break
+            else:
+                bb.warn("No checksum specified for npm package '%s@%s'. "
+                        "Add sha256sum or sha512sum to the SRC_URI." % (ud.package, ud.version))
 
             # Avoid conflicts between the environment data and:
             # - the proxy url checksum
             data = bb.data.createCopy(d)
             data.delVarFlags("SRC_URI")
-            ud.proxy = Fetch([url], data)
+            ud.proxy = Fetch([str(uri)], data)
 
     def _get_proxy_method(self, ud, d):
         self._setup_proxy(ud, d)
@@ -296,8 +302,6 @@ class Npm(FetchMethod):
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
2.54.0


