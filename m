Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45087CD4F39
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 20:06:28 +0000 (UTC)
Received: from Minsungs-MacBook-Air.local (Minsungs-MacBook-Air.local [24.205.142.70])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20356.1778789127566883781
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 May 2026 13:05:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=none, err=permanent DNS error (domain: minsungs-macbook-air.local, ip: 24.205.142.70, mailfrom: minsung@minsungs-macbook-air.local)
Received: by Minsungs-MacBook-Air.local (Postfix, from userid 501)
	id D56525C2A00B; Thu, 14 May 2026 13:05:26 -0700 (PDT)
From: ms98.cho@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: "minsung.cho" <ms98.cho@gmail.com>
Subject: [PATCH v2] fetch2/crate: support configurable registry and index URLs
Date: Thu, 14 May 2026 13:05:26 -0700
Message-ID: <20260514200526.98596-1-ms98.cho@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260514051143.67992-1-ms98.cho@gmail.com>
References: <20260514051143.67992-1-ms98.cho@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 May 2026 20:06:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19525

The crate fetcher previously hardcoded the crates.io download URL and
only supported a fixed /crate/versions API shape for custom registries.
This prevented recipes from using private registries or mirrors with
different download paths or Cargo sparse indexes.

Add BB_CRATE_REGISTRY_URL[host] and BB_CRATE_INDEX_URL[host] templates
with {crate}, {version}, and {index_path} placeholders. Keep the
existing crates.io defaults, allow custom API-style version endpoints,
and mark sparse indexes explicitly so latest-version checks parse Cargo
index NDJSON instead of JSON API responses.

Add non-network tests for default crates.io URLs, custom registry
templates, sparse index paths, trailing slash handling, and both
latest-version parser paths. Also make the fetch test cleanup chmod
invocation portable by placing -R before the mode.

[YOCTO #16276]

Signed-off-by: minsung.cho <ms98.cho@gmail.com>
---
 lib/bb/fetch2/crate.py |  39 +++++++++++--
 lib/bb/tests/fetch.py  | 122 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 156 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index bb12f4e..a6dfc6b 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -77,12 +77,43 @@ class Crate(Wget):
         # host (this is to allow custom crate registries to be specified
         host =3D '/'.join(parts[2:-2])
=20
-        # If using crates.io use the CDN directly as per https://crates.=
io/data-access
+        # Allow overriding the registry and index URLs via bitbake varia=
bles.
+        # Example:
+        # BB_CRATE_REGISTRY_URL[my-host] =3D "https://my-host.com/crates=
/{crate}/{version}/download"
+        #          BB_CRATE_INDEX_URL[my-host] =3D "https://my-host.com/=
index/{index_path}"
+        dl_url =3D d.getVarFlag('BB_CRATE_REGISTRY_URL', host)
+        index_url =3D d.getVarFlag('BB_CRATE_INDEX_URL', host)
+
         if host =3D=3D 'crates.io':
-            ud.url =3D "https://static.crates.io/crates/%s/%s/download" =
% (name, version)
-            ud.versionsurl =3D 'https://index.crates.io/' + self._genera=
te_index_path(name)
+            if not dl_url:
+                dl_url =3D "https://static.crates.io/crates/{crate}/{ver=
sion}/download"
+            if not index_url:
+                index_url =3D "https://index.crates.io/"
+
+        if dl_url:
+            ud.url =3D dl_url.replace('{crate}', name).replace('{version=
}', version)
         else:
             ud.url =3D "https://%s/%s/%s/download" % (host, name, versio=
n)
+
+        ud.crate_index_format =3D 'api'
+        if index_url:
+            index_path =3D self._generate_index_path(name)
+            # Support {index_path} for sparse index registries. If not p=
resent
+            # and it's crates.io, append it for backward compatibility.
+            if '{index_path}' in index_url:
+                ud.versionsurl =3D index_url.replace('{index_path}', ind=
ex_path)
+                ud.crate_index_format =3D 'sparse'
+            elif host =3D=3D 'crates.io' or index_url.startswith('https:=
//index.crates.io/'):
+                if not index_url.endswith('/'):
+                    index_url +=3D '/'
+                ud.versionsurl =3D index_url + index_path
+                ud.crate_index_format =3D 'sparse'
+            else:
+                ud.versionsurl =3D index_url
+
+            # Apply other placeholders
+            ud.versionsurl =3D ud.versionsurl.replace('{crate}', name).r=
eplace('{version}', version)
+        else:
             ud.versionsurl =3D "https://%s/%s/versions" % (host, name)
=20
         ud.parm['downloadfilename'] =3D "%s-%s.crate" % (name, version)
@@ -160,7 +191,7 @@ class Crate(Wget):
         Return the latest upstream version, dispatching to the appropria=
te
         parser based on the versionsurl format.
         """
-        if ud.versionsurl.startswith('https://index.crates.io/'):
+        if getattr(ud, 'crate_index_format', None) =3D=3D 'sparse':
             return self._latest_versionstring_from_index(ud, d)
         return self._latest_versionstring_from_api(ud, d)
=20
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 86dd929..0dff3fc 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -424,7 +424,7 @@ class FetcherTest(unittest.TestCase):
         if os.environ.get("BB_TMPDIR_NOCLEAN") =3D=3D "yes":
             print("Not cleaning up %s. Please remove manually." % self.t=
empdir)
         else:
-            bb.process.run('chmod u+rw -R %s' % self.tempdir)
+            bb.process.run('chmod -R u+rw %s' % self.tempdir)
             bb.utils.prunedir(self.tempdir)
=20
     def git(self, cmd, cwd=3DNone):
@@ -2590,6 +2590,126 @@ class FetchLocallyMissingTagFromRemote(FetcherTes=
t):
=20
=20
 class CrateTest(FetcherTest):
+    def test_crate_url_uses_crates_io_defaults(self):
+        ud =3D bb.fetch2.FetchData("crate://crates.io/glob/0.2.11", self=
.d)
+
+        self.assertEqual(ud.url,
+                         "https://static.crates.io/crates/glob/0.2.11/do=
wnload")
+        self.assertEqual(ud.versionsurl, "https://index.crates.io/gl/ob/=
glob")
+        self.assertEqual(ud.crate_index_format, "sparse")
+        self.assertEqual(ud.parm["downloadfilename"], "glob-0.2.11.crate=
")
+        self.assertEqual(ud.parm["name"], "glob-0.2.11")
+
+    def test_crate_url_supports_custom_registry_templates(self):
+        self.d.setVarFlag("BB_CRATE_REGISTRY_URL", "registry.example.com=
",
+                          "https://registry.example.com/api/v1/crates/{c=
rate}/{version}/download")
+        self.d.setVarFlag("BB_CRATE_INDEX_URL", "registry.example.com",
+                          "https://registry.example.com/api/v1/crates/{c=
rate}/versions")
+
+        ud =3D bb.fetch2.FetchData("crate://registry.example.com/glob/0.=
2.11", self.d)
+
+        self.assertEqual(ud.url,
+                         "https://registry.example.com/api/v1/crates/glo=
b/0.2.11/download")
+        self.assertEqual(ud.versionsurl,
+                         "https://registry.example.com/api/v1/crates/glo=
b/versions")
+        self.assertEqual(ud.crate_index_format, "api")
+
+    def test_crate_url_supports_custom_sparse_index_templates(self):
+        self.d.setVarFlag("BB_CRATE_REGISTRY_URL", "registry.example.com=
",
+                          "https://registry.example.com/crates/{crate}/{=
version}/download")
+        self.d.setVarFlag("BB_CRATE_INDEX_URL", "registry.example.com",
+                          "https://registry.example.com/index/{index_pat=
h}")
+
+        ud =3D bb.fetch2.FetchData("crate://registry.example.com/aho-cor=
asick/0.7.20", self.d)
+
+        self.assertEqual(ud.url,
+                         "https://registry.example.com/crates/aho-corasi=
ck/0.7.20/download")
+        self.assertEqual(ud.versionsurl,
+                         "https://registry.example.com/index/ah/o-/aho-c=
orasick")
+        self.assertEqual(ud.crate_index_format, "sparse")
+
+    def test_crate_url_adds_sparse_index_path_with_missing_trailing_slas=
h(self):
+        self.d.setVarFlag("BB_CRATE_INDEX_URL", "crates.io", "https://in=
dex.crates.io")
+
+        ud =3D bb.fetch2.FetchData("crate://crates.io/glob/0.2.11", self=
.d)
+
+        self.assertEqual(ud.versionsurl, "https://index.crates.io/gl/ob/=
glob")
+        self.assertEqual(ud.crate_index_format, "sparse")
+
+    def test_crate_latest_versionstring_supports_custom_sparse_index(sel=
f):
+        self.d.setVarFlag("BB_CRATE_INDEX_URL", "registry.example.com",
+                          "https://registry.example.com/index/{index_pat=
h}")
+        ud =3D bb.fetch2.FetchData("crate://registry.example.com/glob/0.=
2.11", self.d)
+        index =3D '\n'.join([
+            '{"vers":"0.2.10","yanked":false}',
+            '{"vers":"0.2.11","yanked":true}',
+            '{"vers":"0.2.12","yanked":false}',
+        ])
+
+        with unittest.mock.patch("bb.fetch2.crate.Crate._fetch_index", r=
eturn_value=3Dindex):
+            self.assertEqual(ud.method.latest_versionstring(ud, self.d),=
 ("0.2.12", ""))
+
+    def test_crate_latest_versionstring_supports_custom_api_index(self):
+        self.d.setVarFlag("BB_CRATE_INDEX_URL", "registry.example.com",
+                          "https://registry.example.com/api/v1/crates/{c=
rate}/versions")
+        ud =3D bb.fetch2.FetchData("crate://registry.example.com/glob/0.=
2.11", self.d)
+        index =3D '{"versions":[{"num":"0.2.10"},{"num":"0.2.12"}]}'
+
+        with unittest.mock.patch("bb.fetch2.crate.Crate._fetch_index", r=
eturn_value=3Dindex):
+            self.assertEqual(ud.method.latest_versionstring(ud, self.d),=
 ("0.2.12", ""))
+
+    def test_crate_fetches_from_local_sparse_registry(self):
+        registry =3D os.path.join(self.tempdir, "registry")
+        crate_name =3D "dummycrate"
+        crate_version =3D "1.0.0"
+        crate_basename =3D "%s-%s" % (crate_name, crate_version)
+        crate_path =3D os.path.join(registry, "crates", crate_name,
+                                  crate_version, "download")
+        index_path =3D os.path.join(registry, "index", "du", "mm", crate=
_name)
+        source_dir =3D os.path.join(self.tempdir, "crate-source", crate_=
basename)
+        bb.utils.mkdirhier(os.path.join(source_dir, "src"))
+        bb.utils.mkdirhier(os.path.dirname(crate_path))
+        bb.utils.mkdirhier(os.path.dirname(index_path))
+
+        with open(os.path.join(source_dir, "Cargo.toml"), "w") as f:
+            f.write('[package]\nname =3D "%s"\nversion =3D "%s"\n' %
+                    (crate_name, crate_version))
+        with open(os.path.join(source_dir, "src", "lib.rs"), "w") as f:
+            f.write("pub fn answer() -> u32 { 42 }\n")
+        with tarfile.open(crate_path, "w:gz") as tar:
+            tar.add(source_dir, arcname=3Dcrate_basename)
+        with open(crate_path, "rb") as f:
+            crate_checksum =3D hashlib.sha256(f.read()).hexdigest()
+        with open(index_path, "w") as f:
+            f.write('{"name":"%s","vers":"%s","yanked":false}\n' %
+                    (crate_name, crate_version))
+
+        server =3D HTTPService(registry, host=3D"127.0.0.1")
+        server.start()
+        try:
+            host =3D "127.0.0.1:%s" % server.port
+            self.d.setVarFlag("BB_CRATE_REGISTRY_URL", host,
+                              "http://%s/crates/{crate}/{version}/downlo=
ad" % host)
+            self.d.setVarFlag("BB_CRATE_INDEX_URL", host,
+                              "http://%s/index/{index_path}" % host)
+            self.d.setVarFlag("SRC_URI", "%s.sha256sum" % crate_basename=
,
+                              crate_checksum)
+            uri =3D "crate://%s/%s/%s" % (host, crate_name, crate_versio=
n)
+
+            fetcher =3D bb.fetch2.Fetch([uri], self.d)
+            ud =3D fetcher.ud[fetcher.urls[0]]
+            self.assertEqual(ud.crate_index_format, "sparse")
+            self.assertEqual(ud.method.latest_versionstring(ud, self.d),
+                             (crate_version, ""))
+
+            fetcher.download()
+            fetcher.unpack(self.tempdir)
+            unpacked_file =3D os.path.join(self.tempdir, "cargo_home", "=
bitbake",
+                                         crate_basename, "src", "lib.rs"=
)
+            self.assertTrue(os.path.exists(unpacked_file))
+        finally:
+            server.stop()
+
     @skipIfNoNetwork()
     def test_crate_url(self):
=20
--=20
2.50.1 (Apple Git-155)


