Return-Path: <ms98.cho@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AEFCD6E6E
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 21:22:33 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1518.1780608149334859162
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Jun 2026 14:22:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=HdgBu0Jo;
 spf=pass (domain: gmail.com, ip: 74.125.82.180, mailfrom: ms98.cho@gmail.com)
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304cf518c9dso1505529eec.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Jun 2026 14:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780608149; x=1781212949; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KiX0R9mGTIvkCSjhZSMPEwLgmRkBS386+I8ScD7f2i4=;
        b=HdgBu0JodcEoDsMA4FKqfJY0Yl7Rln5AGUi709hD/TfFemNdtUH0hQ6+Fw5/umymDj
         W6Fw9EwUld9nHqFJTdq8kFUxNtxXpNTekH2mpSut0Tdi4xUPeCMmDqdRaF7m74r7pB86
         k4dEOI3/4SlJnLkBmsRn0oNPT1z6K8a5cIvt8gfJpT7HwLckWRE3/zieis/UGjmnIgg9
         z1grPvsC20YXf79gexI3Vx0QRL6zLGDWHKehwswm/97tfF7la2PftsPbapJ79oJxa1iD
         cv91g66S9cmc9AlST7hyB0Ch9cuKf6SvF1xVmBZtUK4/PdzEd9cSoBxt8+7uCZagIRNx
         mSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780608149; x=1781212949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KiX0R9mGTIvkCSjhZSMPEwLgmRkBS386+I8ScD7f2i4=;
        b=ExeMeqfbEMtBQC2vBmF3IZJNNNFtBU5+SzjEQ+vEwvwM5A0aQE8YAx2jI7CEfIC5JG
         qr35Xhx59C8YBbGn7WSslrd5d8MIXa6Vf55uVEm7/eXftyne1IKhbVCDosKa013XMjkR
         DwA3yJsxfNxRA0csKigABx0sDvWcpp4FcLSDePcQXwbg9cY5fb8TF4bl6JmH5up7kqiD
         VpGXnP8VSXCcd2rYM3RxtHfJRqVVNCpj/zSd//7ZG4+xWtBKVH487qBR3mrwPAxGdW89
         PA4cFvzSLLjmBkPc6uJlOvz8NRWLO2tzj6MpHKqDqNIaplLYP8LjJzS70RW3GTZl01td
         Ufqg==
X-Gm-Message-State: AOJu0YygQPlOqpn7I/fTUz5xaC4GmDbV43tyhmBlmoxadxjwQzEWWp2E
	ncsrOQRvjc+mVfxvUx6WZ+5HPvvICxpPFcy1DOdEO0Keqosb1iGHr2loMXzyTn1X/F8NNw==
X-Gm-Gg: Acq92OEyCH7Dmjgny5L6TKknsqEOn9iY/ksGFTI7b8dXvzHWrrQn5tW4acjX0eA3MM+
	UqLWpnGN+FHyR9/KOOOebx2mgIWB+lbw8Gg4OoZHcVoq5Bxp8vPbipThBxeUG5QxAkUjNLFLfJ2
	EQN1QL23n6M42g4phEThtqhEt8G5zQ0DlpcUbhJVwtFvAHjaEio+vRCLwrKfp9JCeSuX1grW0TW
	K7Pp6aMw3WXNVqyFihhua7RGNOlxzBRNgWr6p1hqZaVDW+sxUDA0I7JDdJkNRecvyTUhbqaAEMd
	lWh8wbaOEzPLZ0T0CMIWAq5LOBXxkvzbwS4pDgk2ABW3gJckMiRbG5jb9JEB99yOh1uE3q1rcXv
	XWLpE3+EEWK4hFLYfiIYHL5hSixFdGbViiEh2zNN7MuDhgsWT4muO0InCbiMLkBzjD5P0wfHvwU
	9vhBr35u0NpHDB7yleqJHq6skPXhIN4cl7apN0HFr32fjxuT/bPYZvHOZV98yTpSe5UGQk9iV3Q
	pHY33nojPmOsv8=
X-Received: by 2002:a05:7301:fa0d:b0:304:e6fb:f2f0 with SMTP id 5a478bee46e88-3077b311064mr239493eec.34.1780608148519;
        Thu, 04 Jun 2026 14:22:28 -0700 (PDT)
Received: from localhost.localdomain (ip50-159-79-16.lv.lv.cox.net. [50.159.79.16])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db55f60sm7747165eec.6.2026.06.04.14.22.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 04 Jun 2026 14:22:27 -0700 (PDT)
From: "minsung.cho" <ms98.cho@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: "minsung.cho" <ms98.cho@gmail.com>,
	Ross.Burton@arm.com,
	mathieu.dubois-briand@bootlin.com
Subject: [PATCH v4] fetch2/crate: support configurable registry and index URLs
Date: Thu,  4 Jun 2026 14:19:54 -0700
Message-ID: <20260604212153.79056-1-ms98.cho@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260521163033.40871-1-ms98.cho@gmail.com>
References: <20260521163033.40871-1-ms98.cho@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Jun 2026 21:22:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19611

The crate fetcher hardcoded the crates.io download URL and assumed every
other host served a fixed /name/versions JSON API. Recipes pointing at a
private registry or a Cargo sparse index mirror just did not work.

Two new per-host varflags fix this: BB_CRATE_REGISTRY_URL[host] and
BB_CRATE_INDEX_URL[host]. Both take {crate} and {version} placeholders;
the index template additionally takes {index_path}, and its presence is
how the fetcher knows to treat the response as a Cargo sparse index
(NDJSON) rather than as a JSON versions API. The crates.io defaults are
expressed with the same templates, so there is no separate code path for
that host.

Tests cover the crates.io defaults, custom API and sparse templates, both
latest-version parser paths, and an end-to-end fetch+unpack against a
local sparse registry served over HTTP.

[YOCTO #16276]

Signed-off-by: minsung.cho <ms98.cho@gmail.com>
---
v4: address Ross Burton's review of v3
  - build the download/index URLs with str.format() instead of chained
    .replace() calls, as the templates are already f-string shaped
  - express the crates.io index default with the {index_path} template
    too, so the generic path handles it and the crates.io-specific
    index branch (and its trailing-slash handling) is gone
  - latest_versionstring() dispatches on ud.crate_index_format directly
    instead of a getattr() guard; it is always set in _crate_urldata_init
  - dropped the separate test-cleanup chmod tweak: master already
    converted that call to an argument list
  - dropped the test for the removed trailing-slash branch
  Rebased onto master (resolved against the filter_regex series so
  latest_versionstring keeps the filter_regex parameter).

 lib/bb/fetch2/crate.py |  29 +++++++++--
 lib/bb/tests/fetch.py  | 112 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+), 4 deletions(-)

diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
index 8f928ea..fe8e70a 100644
--- a/lib/bb/fetch2/crate.py
+++ b/lib/bb/fetch2/crate.py
@@ -78,12 +78,33 @@ class Crate(Wget):
         # host (this is to allow custom crate registries to be specified
         host = '/'.join(parts[2:-2])
 
-        # If using crates.io use the CDN directly as per https://crates.io/data-access
+        # Allow overriding the registry and index URLs per host via varflags.
+        # The templates accept {crate}, {version} and {index_path} placeholders:
+        #   BB_CRATE_REGISTRY_URL[my-host] = "https://my-host/crates/{crate}/{version}/download"
+        #   BB_CRATE_INDEX_URL[my-host] = "https://my-host/index/{index_path}"
+        # A {index_path} placeholder marks a Cargo sparse index; without it the
+        # index URL is treated as a JSON versions API endpoint.
+        dl_url = d.getVarFlag('BB_CRATE_REGISTRY_URL', host)
+        index_url = d.getVarFlag('BB_CRATE_INDEX_URL', host)
+
+        # crates.io uses the CDN directly as per https://crates.io/data-access
         if host == 'crates.io':
-            ud.url = "https://static.crates.io/crates/%s/%s/download" % (name, version)
-            ud.versionsurl = 'https://index.crates.io/' + self._generate_index_path(name)
+            if not dl_url:
+                dl_url = "https://static.crates.io/crates/{crate}/{version}/download"
+            if not index_url:
+                index_url = "https://index.crates.io/{index_path}"
+
+        if dl_url:
+            ud.url = dl_url.format(crate=name, version=version)
         else:
             ud.url = "https://%s/%s/%s/download" % (host, name, version)
+
+        if index_url:
+            ud.crate_index_format = 'sparse' if '{index_path}' in index_url else 'api'
+            ud.versionsurl = index_url.format(crate=name, version=version,
+                                              index_path=self._generate_index_path(name))
+        else:
+            ud.crate_index_format = 'api'
             ud.versionsurl = "https://%s/%s/versions" % (host, name)
 
         ud.parm['downloadfilename'] = "%s-%s.crate" % (name, version)
@@ -161,7 +182,7 @@ class Crate(Wget):
         Return the latest upstream version, dispatching to the appropriate
         parser based on the versionsurl format.
         """
-        if ud.versionsurl.startswith('https://index.crates.io/'):
+        if ud.crate_index_format == 'sparse':
             return self._latest_versionstring_from_index(ud, d, filter_regex)
         return self._latest_versionstring_from_api(ud, d, filter_regex)
 
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 95cf6c4..c4a1f33 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2756,6 +2756,118 @@ class FetchLocallyMissingTagFromRemote(FetcherTest):
 
 
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


