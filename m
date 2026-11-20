Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6373.1795182810444553287
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Nov 2026 05:53:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20260707 header.b=fM/Lq7Tf;
 spf=pass (domain: gmail.com, ip: 209.85.221.41, mailfrom: stondo@gmail.com)
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-490d59c3edaso606666f8f.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 20 Nov 2026 05:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795182809; x=1795787609; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FE0aUcKRnVKPekxL0dOKkkysoCbktYzv+/oJNBIAyzI=;
        b=fM/Lq7TfTbto12RA3FfGJxUUw+VViwJWTuyfXO9Jvau82Dm9pwpV2jY7cPHrEe/3DI
         1x+UY83oambk/bhQ5WPWkq4BFPmbKl1rwuzYPXVaDaW7nJsg8WTITfDdT8JBtL1rhU9j
         FbcCprGl1SBQ7+7nSCir9VJVXMQ2PcTWkgGA1Qe6EC0UPVad2HpPy3WY0afMMb4hMNEN
         VnjPXArq1i73fEROXZTKrT1aS+u9B0/DP3qr0FB2oXxUDL58YvReNwnbeqVcDHnEQe13
         2/qt9k8Rx4GsBwIatxsddXwH9YA5fX4tU00Qet0OyaaC+CpTsHNbNIk9WiFeb5Lzs6oj
         mOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795182809; x=1795787609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FE0aUcKRnVKPekxL0dOKkkysoCbktYzv+/oJNBIAyzI=;
        b=vvx6D2TifcWPwb9tjpfCwSpV6QvtBjUjXQGlbHAewGEBV7df3MgJwMcGuWAyr3HT9k
         1h7CjB3gxJeK2NAcdSAVowwDIk4cINLH8ImPnQ56LFWClObgU2MhJ38RgXpxHqmSWI6D
         qIxemVY+AUrR0Jo6bOkphBm8Q+bDbygvrNqgSPbuEJ08IXvULdX2kaEO1GpQVwg60QGc
         NNM1gogxmnQ4hENsv0hgkxJPSLRAlXnkwVvHvSxsOamlVioY1WdUyr3iag/vdrjUAm2z
         p56QvJvKoRvxFDEqDDSzpsPndm11j4b+xWW/jRGE/KUKZuTSWkwy6H+K3npbOnrAO6Xo
         OU1A==
X-Gm-Message-State: APuU4Z+rgM+AQGTOx5aUOqkswNm/Im3v9R+ssn2U8e0vozMm+uomJ1W2
	tXPUOfjKRPcswQleipRksgMT03rAWrZ0uyajDzC3UViSKGuZoJIuxMZ4fLTx0Pj/
X-Gm-Gg: AZFdTZdcMgEnHwSJALJM60RjDtkllLMHuAbxQ5zrq1Rk33N0gzYzlVmp4dBlLbi9yeK
	Wez6UrczroagueREFiGwMkXteHqtLbYVpOtdo65MCFaSp9G2exN1KEOSTtrE64kWsuy8tOVQCAq
	nDVxcBI0EgrdU06/40MQW6TiBlF769efY5hYGko005A9RINYTeICDJ7oLjANobq4WQlmYEOlqqm
	VrzCNp4ZBE1NvLuOEcHoDZzGvUoAoiD9rzWDoPBjyHuAXsuxkRv7uL+oLfLtgpmwpaf6cy8o0pi
	QxBFQHR9rTIPuAcEuGenDmxDPC3NsEa2PYAmV4o0skq5vtUtfD3HDiGOV6vwpCzHqc6Bgr/NFf7
	UZcU7tNBZcnjIapTI7sMTxj3M6xLto+072MPwTte2XsJPMuSakfzj5R47+4TMDEo4Ha3azGwAWE
	cyMxIZjaodT8dgKnefA0o/oxEZidiy7rHzN5ExHRrQzTdo0b6MtmnRlGXHRaNnYUvwtJVED4V7U
	ppAxMDl0DGeMo0DOFtv3/sx2w7k7OHDWOX1UAg8yZsyZ9MWP1jbQtsvDBV9rnFpJJfpkLMcZ/Mp
	3W1kZlpa5p1qksqM0iiJYlaycHcgdNlF
X-Received: by 2002:a05:6000:4310:b0:4a9:6c58:178a with SMTP id ffacd0b85a97d-4aa55bfeb43mr11723372f8f.12.1795182808536;
        Fri, 20 Nov 2026 05:53:28 -0800 (PST)
Return-Path: <stondo@gmail.com>
Received: from fedora ([165.225.94.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110c3csm6018485f8f.36.2026.11.20.05.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 05:53:27 -0800 (PST)
From: Stefano Tondo <stondo@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Perrot <thomas.perrot@bootlin.com>,
	Alexander Kanavin <alex.kanavin@gmail.com>,
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
	Peter Marko <peter.marko@siemens.com>,
	stefano.tondo.ext@siemens.com
Subject: [PATCH 2/2] fetch/npm: Build the tarball URL without the npm executable
Date: Fri, 20 Nov 2026 14:53:23 +0100
Message-ID: <20261120135323.2627478-3-stondo@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120135323.2627478-1-stondo@gmail.com>
References: <20261120135323.2627478-1-stondo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Fri, 20 Nov 2026 13:53:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20467
Content-Type: text/plain; charset="utf-8"

From: Stefano Tondo <stefano.tondo.ext@siemens.com>

The npm fetcher ran "npm view" only to get the URL of the package
tarball. So it needed the npm executable and network access before
the download. In a build, base.bbclass in OE-Core makes do_fetch of a
recipe with an npm:// URL depend on nodejs-native for this reason.
The bitbake tests take npm from the host, and they skipped themselves
when the host had no npm.

The npm registry gives each tarball a fixed URL:
<registry>/<package>/-/<basename>-<version>.tgz, where basename is the
package name without its scope. Build this URL from the SRC_URI
parameters instead. The checksum still comes from the recipe only.

The tests no longer need npm. Add tests that build the URL and fetch
a package from a premirror without network access.

Signed-off-by: Stefano Tondo <stefano.tondo.ext@siemens.com>
---
 lib/bb/fetch/npm.py   | 50 +++----------------------
 lib/bb/tests/fetch.py | 85 ++++++++++++++++++++++---------------------
 2 files changed, 49 insertions(+), 86 deletions(-)

diff --git a/lib/bb/fetch/npm.py b/lib/bb/fetch/npm.py
index c8995ba6b..bf3f0ea3c 100644
--- a/lib/bb/fetch/npm.py
+++ b/lib/bb/fetch/npm.py
@@ -29,20 +29,16 @@ Supported SRC_URI options are:
 """
 
 import base64
-import json
 import os
 import re
-import shlex
 import tempfile
 import bb
 from bb.fetch import Fetch
-from bb.fetch import FetchError
 from bb.fetch import FetchMethod
 from bb.fetch import MalformedUrl
 from bb.fetch import MissingParameterError
 from bb.fetch import ParameterError
 from bb.fetch import URI
-from bb.fetch import check_network_access
 from bb.fetch import runfetchcmd
 from bb.utils import is_semver
 
@@ -213,9 +209,6 @@ class Npm(FetchMethod):
         else:
             ud.localfile = npm_localfile(ud.package, ud.version)
 
-        # Get the base 'npm' command
-        ud.basecmd = shlex.split(d.getVar("FETCHCMD_npm") or "") or ["npm"]
-
         # This fetcher resolves a URI from a npm package name and version and
         # then forwards it to a proxy fetcher. A resolve file containing the
         # resolved URI is created to avoid unwanted network access (if the file
@@ -226,45 +219,14 @@ class Npm(FetchMethod):
         ud.resolvefile = self.localpath(ud, d) + ".resolved"
 
     def _resolve_proxy_url(self, ud, d):
-        """Resolve the tarball URL from the registry and cache it without any checksum.
+        """Write the tarball URL of the package to the resolve file.
 
-        Checksums must never be sourced from the registry: a compromised registry
-        controls both the tarball and its advertised hash, so any checksum obtained
-        there provides no tamper detection. Checksums are applied in _setup_proxy
-        from the recipe-provided SRC_URI parameters instead.
+        The URL follows the layout of the npm registry, so it is known
+        without network access and without the npm executable. The URL
+        has no checksum: _setup_proxy adds the one from the recipe.
         """
-        def _npm_view():
-            args = []
-            args.append(("json", "true"))
-            args.append(("registry", ud.registry))
-            pkgver = ud.package + "@" + ud.version
-            cmd = ud.basecmd + ['view', pkgver]
-            env = NpmEnvironment(d)
-            check_network_access(d, cmd, ud.registry)
-            view_string = env.run(cmd, args=args)
-
-            if not view_string:
-                raise FetchError("Unavailable package %s" % pkgver, ud.url)
-
-            try:
-                view = json.loads(view_string)
-            except json.JSONDecodeError as e:
-                raise FetchError("Invalid view from npm: %s" % str(e), ud.url)
-
-            error = view.get("error")
-            if error is not None:
-                raise FetchError(error.get("summary") or str(error), ud.url)
-
-            if ud.version != view.get("version"):
-                raise ParameterError("Invalid 'version' parameter", ud.url)
-
-            return view
-
-        view = _npm_view()
-        tarball_url = view.get("dist", {}).get("tarball")
-
-        if tarball_url is None:
-            raise FetchError("Invalid 'dist.tarball' in view", ud.url)
+        basename = ud.package.split("/")[-1]
+        tarball_url = "%s/%s/-/%s-%s.tgz" % (ud.registry.rstrip("/"), ud.package, basename, ud.version)
 
         bb.utils.mkdirhier(os.path.dirname(ud.resolvefile))
         with open(ud.resolvefile, "w") as f:
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 61dc06660..e1784a460 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -3110,12 +3110,48 @@ class CrateTest(FetcherTest):
             fetcher.download()
 
 class NPMTest(FetcherTest):
-    def skipIfNoNpm():
-        if not shutil.which('npm'):
-            return unittest.skip('npm not installed')
-        return lambda f: f
+    def _make_npm_tarball(self, path, name, version):
+        """Create a npm package tarball and return its sha512sum."""
+        pkgdir = os.path.join(self.tempdir, 'pkgsrc', 'package')
+        bb.utils.mkdirhier(pkgdir)
+        with open(os.path.join(pkgdir, 'package.json'), 'w') as f:
+            json.dump({'name': name, 'version': version}, f)
+        bb.utils.mkdirhier(os.path.dirname(path))
+        with tarfile.open(path, 'w:gz') as tar:
+            tar.add(pkgdir, arcname='package')
+        with open(path, 'rb') as f:
+            return hashlib.sha512(f.read()).hexdigest()
+
+    def test_npm_offline(self):
+        # The tarball URL is built from the registry layout, so neither
+        # the npm executable nor network access is necessary.
+        mirrorfile = os.path.join(self.tempdir, 'mirror', '@savoirfairelinux-node-server-example-1.0.0.tgz')
+        checksum = self._make_npm_tarball(mirrorfile, '@savoirfairelinux/node-server-example', '1.0.0')
+        self.d.setVar('BB_NO_NETWORK', '1')
+        self.d.setVar('PREMIRRORS', 'https?$://.*/.* file://%s' % mirrorfile)
+        urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
+                ';sha512sum=' + checksum]
+        fetcher = bb.fetch.Fetch(urls, self.d)
+        ud = fetcher.ud[fetcher.urls[0]]
+        fetcher.download()
+        with open(ud.resolvefile) as f:
+            self.assertEqual(f.read(), 'https://registry.npmjs.org/@savoirfairelinux/'
+                             'node-server-example/-/node-server-example-1.0.0.tgz')
+        fetcher.unpack(self.unpackdir)
+        with open(os.path.join(self.unpackdir, 'npm', 'package.json')) as f:
+            self.assertEqual(json.load(f)['name'], '@savoirfairelinux/node-server-example')
+
+    def test_npm_tarball_url_alternate_registry(self):
+        urls = ['npm://npm.example.com/path/to/registry/;package=foo;version=1.2.3'
+                ';sha512sum=' + '0' * 128]
+        self.d.setVar('BB_NO_NETWORK', '1')
+        fetcher = bb.fetch.Fetch(urls, self.d)
+        ud = fetcher.ud[fetcher.urls[0]]
+        with self.assertRaises(bb.fetch.NetworkAccess):
+            fetcher.download()
+        with open(ud.resolvefile) as f:
+            self.assertEqual(f.read(), 'https://npm.example.com/path/to/registry/foo/-/foo-1.2.3.tgz')
 
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm(self):
         urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
@@ -3131,7 +3167,6 @@ class NPMTest(FetcherTest):
         unpackdir = os.path.join(self.unpackdir, 'npm')
         self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.json')))
 
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_bad_checksum(self):
         urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
@@ -3152,7 +3187,6 @@ class NPMTest(FetcherTest):
         self.assertTrue(os.path.exists(ud.localpath + '_bad-checksum_' + badsum))
         self.assertTrue(os.path.exists(ud.localpath))
 
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_premirrors(self):
         urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
@@ -3184,7 +3218,6 @@ class NPMTest(FetcherTest):
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
 
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_premirrors_with_specified_filename(self):
         urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
@@ -3207,7 +3240,6 @@ class NPMTest(FetcherTest):
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
 
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_mirrors(self):
         # Fetch once to get a tarball
@@ -3235,7 +3267,6 @@ class NPMTest(FetcherTest):
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
 
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_destsuffix_downloadfilename(self):
         urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
@@ -3249,7 +3280,6 @@ class NPMTest(FetcherTest):
         unpackdir = os.path.join(self.unpackdir, 'foo', 'bar')
         self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.json')))
 
-    @skipIfNoNpm()
     def test_npm_no_network_no_tarball(self):
         urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
                 ';sha512sum=f2dd7d88cb9a129fbb97eb87a8b5103bab24f783420fd7587f8000a355a12bf7'
@@ -3259,7 +3289,6 @@ class NPMTest(FetcherTest):
         with self.assertRaises(bb.fetch.NetworkAccess):
             fetcher.download()
 
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_no_network_with_tarball(self):
         urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
@@ -3276,7 +3305,6 @@ class NPMTest(FetcherTest):
         unpackdir = os.path.join(self.unpackdir, 'npm')
         self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.json')))
 
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_registry_alternate(self):
         urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
@@ -3288,13 +3316,11 @@ class NPMTest(FetcherTest):
         unpackdir = os.path.join(self.unpackdir, 'npm')
         self.assertTrue(os.path.exists(os.path.join(unpackdir, 'package.json')))
 
-    @skipIfNoNpm()
     def test_npm_version_latest_rejected(self):
         url = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=latest']
         with self.assertRaises(bb.fetch.ParameterError):
             bb.fetch.Fetch(url, self.d)
 
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_registry_invalid(self):
         urls = ['npm://registry.invalid.org;package=@savoirfairelinux/node-server-example;version=1.0.0'
@@ -3304,7 +3330,6 @@ class NPMTest(FetcherTest):
         with self.assertRaises(bb.fetch.FetchError):
             fetcher.download()
 
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_package_invalid(self):
         urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/invalid;version=1.0.0'
@@ -3314,40 +3339,23 @@ class NPMTest(FetcherTest):
         with self.assertRaises(bb.fetch.FetchError):
             fetcher.download()
 
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_version_invalid(self):
         urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example;version=invalid']
         with self.assertRaises(bb.fetch.ParameterError):
             fetcher = bb.fetch.Fetch(urls, self.d)
 
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_recipe_checksum(self):
         """A sha512sum param in SRC_URI is forwarded to the proxy and verified."""
-        import subprocess
-        from bb.fetch.npm import npm_integrity
-        result = subprocess.run(
-            ['npm', 'view', '--json', '@savoirfairelinux/node-server-example@1.0.0'],
-            capture_output=True, text=True)
-        if result.returncode != 0:
-            self.skipTest('npm view failed: %s' % result.stderr.strip())
-        try:
-            view = json.loads(result.stdout)
-        except json.JSONDecodeError:
-            self.skipTest('npm view returned invalid JSON')
-        integrity = view.get('dist', {}).get('integrity')
-        if not integrity:
-            self.skipTest('npm view response missing dist.integrity')
-        checksum_name, hexsum = npm_integrity(integrity)
         urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example'
-                ';version=1.0.0;%s=%s' % (checksum_name, hexsum)]
+                ';version=1.0.0;sha512sum=f2dd7d88cb9a129fbb97eb87a8b5103bab24f783420fd7587f8000a355a12bf7'
+                '83f1263230afc588123958b73e36bb241f63eaf08119aac5aa2a870bc4de9223']
         fetcher = bb.fetch.Fetch(urls, self.d)
         ud = fetcher.ud[fetcher.urls[0]]
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
 
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_bad_recipe_checksum_rejected(self):
         """A wrong sha512sum param in SRC_URI causes the fetch to fail."""
@@ -3357,7 +3365,6 @@ class NPMTest(FetcherTest):
         with self.assertRaises(bb.fetch.FetchError):
             fetcher.download()
 
-    @skipIfNoNpm()
     def test_npm_no_checksum_rejected(self):
         """A missing checksum in SRC_URI is rejected regardless of BB_STRICT_CHECKSUM.
 
@@ -3375,21 +3382,18 @@ class NPMTest(FetcherTest):
             with self.assertRaises(bb.fetch.MissingParameterError):
                 bb.fetch.Fetch(urls, self.d)
 
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_registry_none(self):
         urls = ['npm://;package=@savoirfairelinux/node-server-example;version=1.0.0']
         with self.assertRaises(bb.fetch.MalformedUrl):
             fetcher = bb.fetch.Fetch(urls, self.d)
 
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_package_none(self):
         urls = ['npm://registry.npmjs.org;version=1.0.0']
         with self.assertRaises(bb.fetch.MissingParameterError):
             fetcher = bb.fetch.Fetch(urls, self.d)
 
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npm_version_none(self):
         urls = ['npm://registry.npmjs.org;package=@savoirfairelinux/node-server-example']
@@ -3513,7 +3517,6 @@ class NPMTest(FetcherTest):
         with self.assertRaises(bb.fetch.NetworkAccess):
             fetcher.download()
 
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npmsw_no_network_with_tarball(self):
         # Fetch once to get a tarball
@@ -3597,7 +3600,6 @@ class NPMTest(FetcherTest):
         self.assertTrue(os.path.exists(localpath + '_bad-checksum_' + badsum))
         self.assertTrue(os.path.exists(localpath))
 
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npmsw_premirrors(self):
         # Fetch once to get a tarball
@@ -3626,7 +3628,6 @@ class NPMTest(FetcherTest):
         fetcher.download()
         self.assertTrue(os.path.exists(ud.localpath))
 
-    @skipIfNoNpm()
     @skipIfNoNetwork()
     def test_npmsw_mirrors(self):
         # Fetch once to get a tarball
-- 
2.56.1

