Return-Path: <eekmecic@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42369C2FC1A
	for <webhook@archiver.kernel.org>; Thu, 17 Aug 2023 12:50:39 +0000 (UTC)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
 by mx.groups.io with SMTP id smtpd.web11.186164.1692276634119688136
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Aug 2023 05:50:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=BfEK0gzE;
 spf=pass (domain: snapchat.com, ip: 209.85.210.177, mailfrom: eekmecic@snapchat.com)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-68934672e7bso774262b3a.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 17 Aug 2023 05:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1692276633; x=1692881433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c02v+3cJsOAaK+fEepQPk4Xyb8Au05Ae1/7GVBFV7Sc=;
        b=BfEK0gzEmE2M0m9buFVJ/mIkFz/KQKL6NBUyi5na3LNEaomsWrSjd25lX92X8Hu1WW
         tkQ2s3hb/+b/mUsDz+XUQEfLlZehS2Xto0s8U6WISSlP+WYfjqU5qgI68+biRW6gAPTQ
         SRNDkEI+GthpgBsYr7p+kOHENrxnSu4GXo2F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692276633; x=1692881433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c02v+3cJsOAaK+fEepQPk4Xyb8Au05Ae1/7GVBFV7Sc=;
        b=DE7JsUKj+M56sbk6jmZQqzhzn11yRsiwNEqMnidfE02W0Wfl6Yq8HB/W2jEF7nBBS6
         xtIStBQPdvQhtnpJCwM9H/CHHqZyXnp/3OrBjpaRbxpxZ4Q6EO5Dq8PNefx5A4qI27MS
         Om5+2cCW8SwFCOtC5Oq1r1ZOYEVzqi8O26rVfbJfilHfyaMPJ9G//RQguXG8Vvdh0w3m
         Zx9UY/DQTDhsHXmCwc9GkgXKU1rJnELgQphF7N/1XtLMSGqSeaHdSFBmuL3BVOBnmTjZ
         koCpmt79qobl3xGENeKfNZd8GzS7Q09oYQaqReNEPSd/HLgQCB3JPXfzGX/9PgoXUkkF
         pGdg==
X-Gm-Message-State: AOJu0YwcAgv/oGnZycGSHwMKQ4FGwjPZPjvgVsN1OjqvHY0Yo4ZdUh0j
	XNmnvv5wBpAbl2FaCROCXdqoGYflXi6ia/+i/0inxEUU
X-Google-Smtp-Source: AGHT+IGbwON9y0ezrrAP5U2Z/915LSbqEmMu0UPunD6oNx26vQBnXxcsV6cyCEcoUpLTsnvrNT5vcg==
X-Received: by 2002:a05:6a00:1685:b0:687:8417:ab51 with SMTP id k5-20020a056a00168500b006878417ab51mr5162451pfc.8.1692276633123;
        Thu, 17 Aug 2023 05:50:33 -0700 (PDT)
Received: from 4SK64Z2.sc-core.net ([144.232.179.190])
        by smtp.gmail.com with ESMTPSA id h5-20020a62b405000000b006878cc942f1sm12703182pfn.54.2023.08.17.05.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 05:50:32 -0700 (PDT)
From: eekmecic@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Emil=20Ekme=C4=8Di=C4=87?= <eekmecic@snap.com>
Subject: [bitbake-devel][kirkstone][2.0][PATCH] fetch2: add Google Cloud Platform (GCP) fetcher
Date: Thu, 17 Aug 2023 05:49:17 -0700
Message-ID: <20230817124916.1454665-2-eekmecic@snap.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Aug 2023 12:50:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14949

From: Emil Ekmečić <eekmecic@snap.com>

Requesting a backport of this patch to BitBake 2.0 to support
use of the GCP fetcher internally at our company, which is on
Kirkstone.

This fetcher allows BitBake to fetch from a Google Cloud Storage
bucket. The fetcher expects a gs:// URI of the following form:

SSTATE_MIRRORS = "file://.* gs://<bucket name>/PATH"

The fetcher uses the Google Cloud Storage Python Client, and
expects it to be installed, configured, and authenticated prior
to use. There is also documentation for the fetcher added to the User
Manual.

If accepted, this patch should merge in with the corresponding oe-core
backport request titled "Add GCP fetcher to list of supported protocols".

Some comments on the patch:

Signed-off-by: Emil Ekmečić <eekmecic@snap.com>
---
 .../bitbake-user-manual-fetching.rst          | 36 +++++++
 lib/bb/fetch2/__init__.py                     |  4 +-
 lib/bb/fetch2/gcp.py                          | 98 +++++++++++++++++++
 3 files changed, 137 insertions(+), 1 deletion(-)
 create mode 100644 lib/bb/fetch2/gcp.py

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index 519aec9a..bf3abd1c 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
@@ -688,6 +688,40 @@ Here is an example URL::
 
 It can also be used when setting mirrors definitions using the :term:`PREMIRRORS` variable.
 
+.. _gcp-fetcher:
+
+GCP Fetcher (``gs://``)
+--------------------------
+
+This submodule fetches data from a
+`Google Cloud Storage Bucket <https://cloud.google.com/storage/docs/buckets>`__.
+It uses the `Google Cloud Storage Python Client <https://cloud.google.com/python/docs/reference/storage/latest>`__
+to check the status of objects in the bucket and download them.
+The use of the Python client makes it substantially faster than using command
+line tools such as gsutil.
+
+The fetcher requires the Google Cloud Storage Python Client to be installed, along
+with the gsutil tool.
+
+The fetcher requires that the machine has valid credentials for accessing the
+chosen bucket. Instructions for authentication can be found in the
+`Google Cloud documentation <https://cloud.google.com/docs/authentication/provide-credentials-adc#local-dev>`__.
+
+The fetcher can be used for fetching sstate artifacts from a GCS bucket by
+specifying the :term:`SSTATE_MIRRORS` variable as shown below::
+
+   SSTATE_MIRRORS ?= "\
+       file://.* gs://<bucket name>/PATH \
+   "
+
+The fetcher can also be used in recipes::
+
+   SRC_URI = "gs://<bucket name>/<foo_container>/<bar_file>"
+
+However, the checksum of the file should be also be provided::
+
+   SRC_URI[sha256sum] = "<sha256 string>"
+
 .. _crate-fetcher:
 
 Crate Fetcher (``crate://``)
@@ -791,6 +825,8 @@ Fetch submodules also exist for the following:
 
 -  OSC (``osc://``)
 
+-  S3 (``s3://``)
+
 -  Secure FTP (``sftp://``)
 
 -  Secure Shell (``ssh://``)
diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index a3140626..4176ff4c 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1285,7 +1285,7 @@ class FetchData(object):
 
             if checksum_name in self.parm:
                 checksum_expected = self.parm[checksum_name]
-            elif self.type not in ["http", "https", "ftp", "ftps", "sftp", "s3", "az"]:
+            elif self.type not in ["http", "https", "ftp", "ftps", "sftp", "s3", "az", "gs"]:
                 checksum_expected = None
             else:
                 checksum_expected = d.getVarFlag("SRC_URI", checksum_name)
@@ -1961,6 +1961,7 @@ from . import npm
 from . import npmsw
 from . import az
 from . import crate
+from . import gcp
 
 methods.append(local.Local())
 methods.append(wget.Wget())
@@ -1982,3 +1983,4 @@ methods.append(npm.Npm())
 methods.append(npmsw.NpmShrinkWrap())
 methods.append(az.Az())
 methods.append(crate.Crate())
+methods.append(gcp.GCP())
diff --git a/lib/bb/fetch2/gcp.py b/lib/bb/fetch2/gcp.py
new file mode 100644
index 00000000..f42c81fd
--- /dev/null
+++ b/lib/bb/fetch2/gcp.py
@@ -0,0 +1,98 @@
+"""
+BitBake 'Fetch' implementation for Google Cloup Platform Storage.
+
+Class for fetching files from Google Cloud Storage using the
+Google Cloud Storage Python Client. The GCS Python Client must
+be correctly installed, configured and authenticated prior to use.
+Additionally, gsutil must also be installed.
+
+"""
+
+# Copyright (C) 2023, Snap Inc.
+#
+# Based in part on bb.fetch2.s3:
+#    Copyright (C) 2017 Andre McCurdy
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Based on functions from the base bb module, Copyright 2003 Holger Schurig
+
+import os
+import bb
+import urllib.parse, urllib.error
+from bb.fetch2 import FetchMethod
+from bb.fetch2 import FetchError
+from bb.fetch2 import logger
+
+class GCP(FetchMethod):
+    """
+    Class to fetch urls via GCP's Python API.
+    """
+    def __init__(self):
+        self.gcp_client = None
+
+    def supports(self, ud, d):
+        """
+        Check to see if a given url can be fetched with GCP.
+        """
+        return ud.type in ['gs']
+
+    def recommends_checksum(self, urldata):
+        return True
+
+    def urldata_init(self, ud, d):
+        if 'downloadfilename' in ud.parm:
+            ud.basename = ud.parm['downloadfilename']
+        else:
+            ud.basename = os.path.basename(ud.path)
+
+        ud.localfile = d.expand(urllib.parse.unquote(ud.basename))
+
+    def get_gcp_client(self):
+        from google.cloud import storage
+        self.gcp_client = storage.Client(project=None)
+
+    def download(self, ud, d):
+        """
+        Fetch urls using the GCP API.
+        Assumes localpath was called first.
+        """
+        logger.debug2(f"Trying to download gs://{ud.host}{ud.path} to {ud.localpath}")
+        if self.gcp_client is None:
+            self.get_gcp_client()
+
+        bb.fetch2.check_network_access(d, "gsutil stat", ud.url)
+
+        # Path sometimes has leading slash, so strip it
+        path = ud.path.lstrip("/")
+        blob = self.gcp_client.bucket(ud.host).blob(path)
+        blob.download_to_filename(ud.localpath)
+
+        # Additional sanity checks copied from the wget class (although there
+        # are no known issues which mean these are required, treat the GCP API
+        # tool with a little healthy suspicion).
+        if not os.path.exists(ud.localpath):
+            raise FetchError(f"The GCP API returned success for gs://{ud.host}{ud.path} but {ud.localpath} doesn't exist?!")
+
+        if os.path.getsize(ud.localpath) == 0:
+            os.remove(ud.localpath)
+            raise FetchError(f"The downloaded file for gs://{ud.host}{ud.path} resulted in a zero size file?! Deleting and failing since this isn't right.")
+
+        return True
+
+    def checkstatus(self, fetch, ud, d):
+        """
+        Check the status of a URL.
+        """
+        logger.debug2(f"Checking status of gs://{ud.host}{ud.path}")
+        if self.gcp_client is None:
+            self.get_gcp_client()
+
+        bb.fetch2.check_network_access(d, "gsutil stat", ud.url)
+
+        # Path sometimes has leading slash, so strip it
+        path = ud.path.lstrip("/")
+        if self.gcp_client.bucket(ud.host).blob(path).exists() == False:
+            raise FetchError(f"The GCP API reported that gs://{ud.host}{ud.path} does not exist")
+        else:
+            return True
-- 
2.41.0


