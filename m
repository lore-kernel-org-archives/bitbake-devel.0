Return-Path: <ms98.cho@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BA9CD5BAC
	for <webhook@archiver.kernel.org>; Thu, 21 May 2026 16:34:39 +0000 (UTC)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.41019.1779381272743620933
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 21 May 2026 09:34:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=CPH1+1Es;
 spf=pass (domain: gmail.com, ip: 74.125.82.172, mailfrom: ms98.cho@gmail.com)
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2f00a567cfaso3827852eec.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 21 May 2026 09:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779381272; x=1779986072; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YLG+BRZtWi1APyJRVr3Z+mJRZJG/n0vK6PQO+7Ireg=;
        b=CPH1+1Es5vskays857O8v/2P6b0qZDOZ+UWNCDAGCnVEe4sO7RPUf7msnUHlEEKK1p
         QS5mwUwJCJd9YOhSrqUpKy5JChzyW3hyL1F0kMu8DKxt3o4dD04YYr4zPIQe0WLC33+g
         lDr8nJuKIEGzVXzlgGCL9STxSv4yZDhIBW1KZ9uP65Gbe8+6CZ9cAVcUX+JHFDXNVhbT
         7cnXB2Uc52pXLvO/JxGtKRd/jXn+iuWucMrf+/ZQ/Es2Xv3ebCQPd0Bm0wr3LSL5wey5
         ig+9oEpklAjIErsCj4jL2cq3rYoryyVN6rUBvuG7kFYWZ7zws9VSnRqKSu9uQRoVQTMn
         tKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779381272; x=1779986072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1YLG+BRZtWi1APyJRVr3Z+mJRZJG/n0vK6PQO+7Ireg=;
        b=RYrzPP6FcCnPhNFVMQ+iIDQJoHFc9ew1/m7i0UUzSR1xwkgwHjhrr8tRuXbIIilj1y
         xiOEJ8awGZK56Iq2DAItuIwz/404EZsOUdyFcUsDjjANSEttQenU5yH1aM0v/lLhHwmi
         oBp5v6u9PKINnVqcuaPxg6PzZLV7mgGNqPC7bZ9W+0IApEJrr3BRQ9gzTuGEyF3CTPP8
         sP7MBjyeQxJmFletqpOlHdQbxj3Yx8MJXNcvq++l535o2Yd/m3g75u5r8PvfKYU6LvWu
         vEeFnWptyOLnbWjYdgykchrbvFxVWtc2D4TkaAwq/2GyusGbAKHopa3NvnOvH1V1U0sF
         IAvg==
X-Gm-Message-State: AOJu0YwljN5KpoaENyp3UcjnqYqXSpoqZ6UxA7/zs+aoOoSFd4eMINOD
	z2HQOrjNeXMcpsurQ4jaEjQc2v52POQftESRIxLp3IICbC3yF3gkwEbGCUfJl8rLBgc=
X-Gm-Gg: Acq92OHsBXK12HCl3YHPZ17DwqQn8+UZpQx/4kf7+QKCjir8xACQJ3KDBfpTluSCKUl
	41zDMf3RvMzvnPX1bTurGZ7kx6FPu3cmd0LjM1p6jMN74Lq8kTOUowyVqBJng8RjocJcoqATi/O
	MuetlpkJtdnXajPWrVzM937YOu9u7jr2/XKo8Jd/dcecjUyRLQ7ECbkT94wFvZktnEOLZQ8FAdn
	1oQLYrCukq1m+lVx72iRWgkplktUfDcmbKCcFVSh8w72tprHt6JlBcO6SERDQcMNP1PR2KYxebJ
	6pN3sEzayWr+ZVEfKTEfeywpKK7GMl9v/+sVE8HWcw7Otfkwz7ooh2Plmimz/GmbpRpsAbR4gGt
	EpROusaF46Xln/Cw/1tjkmqexeC3Dumf9zxGp73x8x/n6feuorXut88ih2a5GZfOB9CXKd2lNwA
	isKSzvH9hRC/czsCGafneEG6WR5o93DtlrfjIDCOujtEmUvkeXQMGl6QN0g/tC58Vo1WC3dXNW/
	zr1
X-Received: by 2002:a05:7300:5412:b0:2c1:82c2:bc31 with SMTP id 5a478bee46e88-30430e3f3camr1905398eec.10.1779381271837;
        Thu, 21 May 2026 09:34:31 -0700 (PDT)
Received: from localhost.localdomain (ip50-159-79-16.lv.lv.cox.net. [50.159.79.16])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304432ddfcdsm880754eec.5.2026.05.21.09.34.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 21 May 2026 09:34:31 -0700 (PDT)
From: "minsung.cho" <ms98.cho@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: mathieu.dubois-briand@bootlin.com,
	"minsung.cho" <ms98.cho@gmail.com>
Subject: [PATCH v3] fetch2/crate: support configurable registry and index URLs
Date: Thu, 21 May 2026 09:30:33 -0700
Message-ID: <20260521163033.40871-1-ms98.cho@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260514200526.98596-1-ms98.cho@gmail.com>
References: <20260514200526.98596-1-ms98.cho@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 May 2026 16:34:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19549

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
index 8f928ea..3989c31 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -78,12 +78,43 @@ class Crate(Wget):
         # host (this is to allow custom crate registries to be specified
         host = '/'.join(parts[2:-2])
 
-        # If using crates.io use the CDN directly as per https://crates.io/data-access
+        # Allow overriding the registry and index URLs via bitbake variables.
+        # Example:
+        # BB_CRATE_REGISTRY_URL[my-host] = "https://my-host.com/crates/{crate}/{version}/download"
+        #          BB_CRATE_INDEX_URL[my-host] = "https://my-host.com/index/{index_path}"
+        dl_url = d.getVarFlag('BB_CRATE_REGISTRY_URL', host)
+        index_url = d.getVarFlag('BB_CRATE_INDEX_URL', host)
+
         if host == 'crates.io':
-            ud.url = "https://static.crates.io/crates/%s/%s/download" % (name, version)
-            ud.versionsurl = 'https://index.crates.io/' + self._generate_index_path(name)
+            if not dl_url:
+                dl_url = "https://static.crates.io/crates/{crate}/{version}/download"
+            if not index_url:
+                index_url = "https://index.crates.io/"
+
+        if dl_url:
+            ud.url = dl_url.replace('{crate}', name).replace('{version}', version)
         else:
             ud.url = "https://%s/%s/%s/download" % (host, name, version)
+
+        ud.crate_index_format = 'api'
+        if index_url:
+            index_path = self._generate_index_path(name)
+            # Support {index_path} for sparse index registries. If not present
+            # and it's crates.io, append it for backward compatibility.
+            if '{index_path}' in index_url:
+                ud.versionsurl = index_url.replace('{index_path}', index_path)
+                ud.crate_index_format = 'sparse'
+            elif host == 'crates.io' or index_url.startswith('https://index.crates.io/'):
+                if not index_url.endswith('/'):
+                    index_url += '/'
+                ud.versionsurl = index_url + index_path
+                ud.crate_index_format = 'sparse'
+            else:
+                ud.versionsurl = index_url
+
+            # Apply other placeholders
+            ud.versionsurl = ud.versionsurl.replace('{crate}', name).replace('{version}', version)
+        else:
             ud.versionsurl = "https://%s/%s/versions" % (host, name)
 
         ud.parm['downloadfilename'] = "%s-%s.crate" % (name, version)
@@ -161,7 +192,7 @@ class Crate(Wget):
         Return the latest upstream version, dispatching to the appropriate
         parser based on the versionsurl format.
         """
-        if ud.versionsurl.startswith('https://index.crates.io/'):
+        if getattr(ud, 'crate_index_format', None) == 'sparse':
             return self._latest_versionstring_from_index(ud, d, filter_regex)
         return self._latest_versionstring_from_api(ud, d, filter_regex)
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 7026645..7855422 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -424,7 +424,7 @@ class FetcherTest(unittest.TestCase):
         if os.environ.get("BB_TMPDIR_NOCLEAN") == "yes":
             print("Not cleaning up %s. Please remove manually." % self.tempdir)
         else:
-            bb.process.run('chmod u+rw -R %s' % self.tempdir)
+            bb.process.run('chmod -R u+rw %s' % self.tempdir)
             bb.utils.prunedir(self.tempdir)
 
     def git(self, cmd, cwd=None):
@@ -2666,6 +2666,126 @@ class FetchLocallyMissingTagFromRemote(FetcherTest):
 
 
 class CrateTest(FetcherTest):
+    def test_crate_url_uses_crates_io_defaults(self):
+        ud = bb.fetch2.FetchData("crate://crates.io/glob/0.2.11", self.d)
+
+        self.assertEqual(ud.url,
+                         "https://static.crates.io/crates/glob/0.2.11/download")
+        self.assertEqual(ud.versionsurl, "https://index.crates.io/gl/ob/glob")
+        self.assertEqual(ud.crate_index_format, "sparse")
+        self.assertEqual(ud.parm["downloadfilename"], "glob-0.2.11.crate")
+        self.assertEqual(ud.parm["name"], "glob-0.2.11")
+
+    def test_crate_url_supports_custom_registry_templates(self):
+        self.d.setVarFlag("BB_CRATE_REGISTRY_URL", "registry.example.com",
+                          "https://registry.example.com/api/v1/crates/{crate}/{version}/download")
+        self.d.setVarFlag("BB_CRATE_INDEX_URL", "registry.example.com",
+                          "https://registry.example.com/api/v1/crates/{crate}/versions")
+
+        ud = bb.fetch2.FetchData("crate://registry.example.com/glob/0.2.11", self.d)
+
+        self.assertEqual(ud.url,
+                         "https://registry.example.com/api/v1/crates/glob/0.2.11/download")
+        self.assertEqual(ud.versionsurl,
+                         "https://registry.example.com/api/v1/crates/glob/versions")
+        self.assertEqual(ud.crate_index_format, "api")
+
+    def test_crate_url_supports_custom_sparse_index_templates(self):
+        self.d.setVarFlag("BB_CRATE_REGISTRY_URL", "registry.example.com",
+                          "https://registry.example.com/crates/{crate}/{version}/download")
+        self.d.setVarFlag("BB_CRATE_INDEX_URL", "registry.example.com",
+                          "https://registry.example.com/index/{index_path}")
+
+        ud = bb.fetch2.FetchData("crate://registry.example.com/aho-corasick/0.7.20", self.d)
+
+        self.assertEqual(ud.url,
+                         "https://registry.example.com/crates/aho-corasick/0.7.20/download")
+        self.assertEqual(ud.versionsurl,
+                         "https://registry.example.com/index/ah/o-/aho-corasick")
+        self.assertEqual(ud.crate_index_format, "sparse")
+
+    def test_crate_url_adds_sparse_index_path_with_missing_trailing_slash(self):
+        self.d.setVarFlag("BB_CRATE_INDEX_URL", "crates.io", "https://index.crates.io")
+
+        ud = bb.fetch2.FetchData("crate://crates.io/glob/0.2.11", self.d)
+
+        self.assertEqual(ud.versionsurl, "https://index.crates.io/gl/ob/glob")
+        self.assertEqual(ud.crate_index_format, "sparse")
+
+    def test_crate_latest_versionstring_supports_custom_sparse_index(self):
+        self.d.setVarFlag("BB_CRATE_INDEX_URL", "registry.example.com",
+                          "https://registry.example.com/index/{index_path}")
+        ud = bb.fetch2.FetchData("crate://registry.example.com/glob/0.2.11", self.d)
+        index = '\n'.join([
+            '{"vers":"0.2.10","yanked":false}',
+            '{"vers":"0.2.11","yanked":true}',
+            '{"vers":"0.2.12","yanked":false}',
+        ])
+
+        with unittest.mock.patch("bb.fetch2.crate.Crate._fetch_index", return_value=index):
+            self.assertEqual(ud.method.latest_versionstring(ud, self.d), ("0.2.12", ""))
+
+    def test_crate_latest_versionstring_supports_custom_api_index(self):
+        self.d.setVarFlag("BB_CRATE_INDEX_URL", "registry.example.com",
+                          "https://registry.example.com/api/v1/crates/{crate}/versions")
+        ud = bb.fetch2.FetchData("crate://registry.example.com/glob/0.2.11", self.d)
+        index = '{"versions":[{"num":"0.2.10"},{"num":"0.2.12"}]}'
+
+        with unittest.mock.patch("bb.fetch2.crate.Crate._fetch_index", return_value=index):
+            self.assertEqual(ud.method.latest_versionstring(ud, self.d), ("0.2.12", ""))
+
+    def test_crate_fetches_from_local_sparse_registry(self):
+        registry = os.path.join(self.tempdir, "registry")
+        crate_name = "dummycrate"
+        crate_version = "1.0.0"
+        crate_basename = "%s-%s" % (crate_name, crate_version)
+        crate_path = os.path.join(registry, "crates", crate_name,
+                                  crate_version, "download")
+        index_path = os.path.join(registry, "index", "du", "mm", crate_name)
+        source_dir = os.path.join(self.tempdir, "crate-source", crate_basename)
+        bb.utils.mkdirhier(os.path.join(source_dir, "src"))
+        bb.utils.mkdirhier(os.path.dirname(crate_path))
+        bb.utils.mkdirhier(os.path.dirname(index_path))
+
+        with open(os.path.join(source_dir, "Cargo.toml"), "w") as f:
+            f.write('[package]\nname = "%s"\nversion = "%s"\n' %
+                    (crate_name, crate_version))
+        with open(os.path.join(source_dir, "src", "lib.rs"), "w") as f:
+            f.write("pub fn answer() -> u32 { 42 }\n")
+        with tarfile.open(crate_path, "w:gz") as tar:
+            tar.add(source_dir, arcname=crate_basename)
+        with open(crate_path, "rb") as f:
+            crate_checksum = hashlib.sha256(f.read()).hexdigest()
+        with open(index_path, "w") as f:
+            f.write('{"name":"%s","vers":"%s","yanked":false}\n' %
+                    (crate_name, crate_version))
+
+        server = HTTPService(registry, host="127.0.0.1")
+        server.start()
+        try:
+            host = "127.0.0.1:%s" % server.port
+            self.d.setVarFlag("BB_CRATE_REGISTRY_URL", host,
+                              "http://%s/crates/{crate}/{version}/download" % host)
+            self.d.setVarFlag("BB_CRATE_INDEX_URL", host,
+                              "http://%s/index/{index_path}" % host)
+            self.d.setVarFlag("SRC_URI", "%s.sha256sum" % crate_basename,
+                              crate_checksum)
+            uri = "crate://%s/%s/%s" % (host, crate_name, crate_version)
+
+            fetcher = bb.fetch2.Fetch([uri], self.d)
+            ud = fetcher.ud[fetcher.urls[0]]
+            self.assertEqual(ud.crate_index_format, "sparse")
+            self.assertEqual(ud.method.latest_versionstring(ud, self.d),
+                             (crate_version, ""))
+
+            fetcher.download()
+            fetcher.unpack(self.tempdir)
+            unpacked_file = os.path.join(self.tempdir, "cargo_home", "bitbake",
+                                         crate_basename, "src", "lib.rs")
+            self.assertTrue(os.path.exists(unpacked_file))
+        finally:
+            server.stop()
+
     @skipIfNoNetwork()
     def test_crate_url(self):
 
-- 
2.50.1 (Apple Git-155)


