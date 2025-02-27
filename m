Return-Path: <l.goehrs@pengutronix.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E147BC1B0FF
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 09:09:07 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by mx.groups.io with SMTP id smtpd.web11.6976.1740647344010552241
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Feb 2025 01:09:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: pengutronix.de, ip: 185.203.201.7, mailfrom: lgo@pengutronix.de)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <lgo@pengutronix.de>)
	id 1tnZt8-0002IJ-29; Thu, 27 Feb 2025 10:09:02 +0100
Received: from dude03.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::39])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <lgo@pengutronix.de>)
	id 1tnZt7-0036DF-1a;
	Thu, 27 Feb 2025 10:09:01 +0100
Received: from lgo by dude03.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <lgo@pengutronix.de>)
	id 1tnZt7-006qee-1M;
	Thu, 27 Feb 2025 10:09:01 +0100
From: =?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org,
	yocto@pengutronix.de,
	=?UTF-8?q?Leonard=20G=C3=B6hrs?= <l.goehrs@pengutronix.de>
Subject: [PATCH v2 2/5] fetch2/github_release_artifact: fetcher for (private) release artifacts
Date: Thu, 27 Feb 2025 10:08:50 +0100
Message-Id: <20250227090853.1632280-3-l.goehrs@pengutronix.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227090853.1632280-1-l.goehrs@pengutronix.de>
References: <20250227090853.1632280-1-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: lgo@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: bitbake-devel@lists.openembedded.org
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 09:09:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17340

This fetcher enables downloading artifacts attached to GitHub releases
in _private repositories_ (public repositories can just use download URLs
like `https://github.com/rauc/rauc/releases/download/v1.13/rauc-1.13.tar.xz`
which work without authentication).

The `SRC_URI` includes the Github account and repository (`rauc/rauc`),
git tag of the release (`v1.13`) and the name of the artifact file
(`rauc-1.13.tar.xz`):

  SRC_URI = "ghra://github.com/rauc/rauc/v1.13/rauc-1.13.tar.xz"
  SRC_URI[sha256sum] = "1ddb218a5d713c8dbd6e04d5501d96629f1c8e252157...

Authentication is provided using tokens, for example by configuring them
in the `local.conf`¹:

  $ grep TOKEN build/conf/local.conf
  GH_TOKEN = "github_pat_123456789abc...

The token may also be provided using an environment variable,
e.g. for CI builds:

  $ export BB_ENV_PASSTHROUGH_ADDITIONS="GH_TOKEN"
  $ export GH_TOKEN="github_pat_123456789abc...
  $ bitbake rauc

It is also possible to provide per-URI tokens using an URI parameter:

  SRC_URI = "ghra://github.com/rauc/rauc/v1.13/rauc-1.13.tar.xz;token=g...
  SRC_URI[sha256sum] = "1ddb218a5d713c8dbd6e04d5501d96629f1c8e252157...

and per-recipe tokens by setting `GH_TOKEN` inside the recipe:

  GH_TOKEN = "github_pat_123456789abc...
  SRC_URI = "ghra://github.com/rauc/rauc/v1.13/rauc-1.13.tar.xz"
  SRC_URI[sha256sum] = "1ddb218a5d713c8dbd6e04d5501d96629f1c8e252157...

¹ Note:

  When using a personal access token, it should be restricted in scope to
  only allow downloading of release artifacts for the required
  repositories.

Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
---
 lib/bb/fetch2/__init__.py                |  4 +-
 lib/bb/fetch2/github_release_artifact.py | 93 ++++++++++++++++++++++++
 2 files changed, 96 insertions(+), 1 deletion(-)
 create mode 100644 lib/bb/fetch2/github_release_artifact.py

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 06d4fd011..1946ca6cb 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1293,7 +1293,7 @@ class FetchData(object):
             elif checksum_plain_name in self.parm:
                 checksum_expected = self.parm[checksum_plain_name]
                 checksum_name = checksum_plain_name
-            elif self.type not in ["http", "https", "ftp", "ftps", "sftp", "s3", "az", "crate", "gs", "gomod", "npm"]:
+            elif self.type not in ["http", "https", "ftp", "ftps", "sftp", "s3", "az", "crate", "gs", "gomod", "npm", "ghra"]:
                 checksum_expected = None
             else:
                 checksum_expected = d.getVarFlag("SRC_URI", checksum_name)
@@ -2069,6 +2069,7 @@ from . import az
 from . import crate
 from . import gcp
 from . import gomod
+from . import github_release_artifact
 
 methods.append(local.Local())
 methods.append(wget.Wget())
@@ -2093,3 +2094,4 @@ methods.append(crate.Crate())
 methods.append(gcp.GCP())
 methods.append(gomod.GoMod())
 methods.append(gomod.GoModGit())
+methods.append(github_release_artifact.GitHubReleaseArtifact())
diff --git a/lib/bb/fetch2/github_release_artifact.py b/lib/bb/fetch2/github_release_artifact.py
new file mode 100644
index 000000000..d5a2646ce
--- /dev/null
+++ b/lib/bb/fetch2/github_release_artifact.py
@@ -0,0 +1,93 @@
+"""
+BitBake 'Fetch' GitHub release artifacts implementation
+
+"""
+
+# Copyright (C) 2025 Leonard Göhrs
+#
+# Based on bb.fetch2.wget:
+# Copyright (C) 2003, 2004  Chris Larson
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Based on functions from the base bb module, Copyright 2003 Holger Schurig
+
+import json
+
+from urllib.request import urlopen, Request
+
+from bb.fetch2 import FetchError
+from bb.fetch2.wget import Wget
+
+
+class GitHubReleaseArtifact(Wget):
+    API_HEADERS = {
+        "Accept": "application/vnd.github+json",
+        "X-GitHub-Api-Version": "2022-11-28",
+    }
+
+    DOWNLOAD_HEADERS = {
+        "Accept": "application/octet-stream"
+    }
+
+    def supports(self, ud, d):
+        return ud.type in ["ghra"]
+
+    def _resolve_artifact_url(self, ud, d):
+        """Resolve `ghra://` pseudo URLs to `https://` URLs and set auth header.
+
+        This method resolved URLs like `ghra://github.com/rauc/rauc/v1.13/rauc-1.13.tar.xz`
+        to a backing URL like `https://api.github.com/repos/rauc/rauc/releases/assets/222455085`
+        while optionally setting the required authentication headers to download from
+        private repositories.
+        """
+
+        try:
+            user, repo, tag, asset_name = ud.path.strip("/").split("/")
+        except ValueError as e:
+            raise FetchError(
+                f"Expected path like '/<user>/<repo>/<tag>/<asset_name>', got: '{ud.path}'"
+            ) from e
+
+        # The GitHub authentication token may be provided as URL parameter
+        # (to enable using different tokens for different URLs in the same recipe)
+        # or via a variable for cleaner URLs.
+        token = ud.parm.get("token") or d.getVar("GH_TOKEN")
+
+        meta_url = f"https://api.{ud.host}/repos/{user}/{repo}/releases/tags/{tag}"
+
+        auth_headers = {}
+
+        if token is not None:
+            auth_headers["Authorization"] = f"Bearer {token}"
+
+        try:
+            req = Request(url=meta_url, headers=(auth_headers | self.API_HEADERS))
+            with urlopen(req) as resp:
+                result = json.load(resp)
+
+        except Exception as e:
+            raise FetchError(f"Error downloading artifact list: {e}") from e
+
+        asset_urls = dict((asset["name"], asset["url"]) for asset in result["assets"])
+
+        if asset_name not in asset_urls:
+            asset_list = ", ".join(asset_urls.keys())
+            raise FetchError(
+                f"Did not find asset '{asset_name}' in release asset list: {asset_list}"
+            )
+
+        # Override the `url` and `headers` in the FetchData object,
+        # enabling the Wget class to perform the actual downloading.
+        ud.url = asset_urls[asset_name]
+        ud.headers = auth_headers | self.DOWNLOAD_HEADERS
+
+    def checkstatus(self, fetch, ud, d):
+        self._resolve_artifact_url(ud, d)
+
+        return super().checkstatus(fetch, ud, d)
+
+    def download(self, ud, d):
+        self._resolve_artifact_url(ud, d)
+
+        return super().download(ud, d)
-- 
2.39.5


