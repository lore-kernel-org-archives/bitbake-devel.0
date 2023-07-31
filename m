Return-Path: <eekmecic@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523A5C001E0
	for <webhook@archiver.kernel.org>; Mon, 31 Jul 2023 13:34:57 +0000 (UTC)
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
 by mx.groups.io with SMTP id smtpd.web10.7487.1690810489128026528
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 31 Jul 2023 06:34:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=fgc+XEG6;
 spf=pass (domain: snapchat.com, ip: 209.85.216.65, mailfrom: eekmecic@snapchat.com)
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-26830595676so3241856a91.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 31 Jul 2023 06:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1690810488; x=1691415288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lS6jIEkzfrh0bz6iqfCI5mxlK069y8vX46dUY5lPgR8=;
        b=fgc+XEG6XbB2ABvGU7hEPFcLZlcHuXzNPd04dXCberhKPO2W9sh7tbWD51C9bDbOjM
         FsyeOJN+9A6h7cxLJpwtwARcGJIW50HljCYKjDNzs8QcYLs1/EUThljF9fA3QGH78jVZ
         tPsCjWpNpdTNeC0oYXMqkt4lqRYjNcH580fjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690810488; x=1691415288;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lS6jIEkzfrh0bz6iqfCI5mxlK069y8vX46dUY5lPgR8=;
        b=QdcIFsRmvehcJTGaZSwQNNRg1lIm4Yujqp735Wba5INRWbCHx/fO+b73H/pMcGkB8R
         xmRvLc+SnUNGgcyoP56AY3Pe3h6UpTBpupBj2n5onr1PnFqYGMtORXbikiV3nNTcv1Ft
         EtGVjrjdftcJWc7IaPLPmSC+OM29xLwF+ENLQVVCMBcBywYSxblzok+nqKN3nce6Orl3
         4e0VRFfeT+ZwdChKCZzwWKi6hrB/ixTnwCemP0b9gMjKMRRNkwAcrMtn3S7oHZXAoTdf
         OcuryS/uttTM9HvTTpJZV/tLAA2O1Gv06t6bJPoxU4G8KgmJWRzR2eBomhBXBFQHeseu
         hGDA==
X-Gm-Message-State: ABy/qLYuMWaI25H1NyqiovlMxI100lf0070vKZLR4FWRlTG2SaY0DQEd
	5C/UmG68/L6jachxPJImwS1PKUzEFEeaB8o4e7WRZd0537R8VA==
X-Google-Smtp-Source: APBJJlFWzNE4gcV0lVnuKDxHOJRivxfu4refCuHlIJkIwAHbzi+ymLGRQ83KrSbipO01bvtSAWTbWw==
X-Received: by 2002:a17:90a:e281:b0:262:f0e6:9e09 with SMTP id d1-20020a17090ae28100b00262f0e69e09mr9161089pjz.14.1690810487981;
        Mon, 31 Jul 2023 06:34:47 -0700 (PDT)
Received: from 4SK64Z2.sc-core.net ([144.232.179.190])
        by smtp.gmail.com with ESMTPSA id iq14-20020a17090afb4e00b00262d6ac0140sm6291993pjb.9.2023.07.31.06.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 06:34:47 -0700 (PDT)
From: eekmecic@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Emil=20Ekme=C4=8Di=C4=87?= <eekmecic@snap.com>
Subject: [PATCH] fetch2: add Google Cloud Platform (GCP) fetcher
Date: Mon, 31 Jul 2023 06:34:44 -0700
Message-Id: <20230731133444.713728-1-eekmecic@snap.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 31 Jul 2023 13:34:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14894

From: Emil Ekmečić <eekmecic@snap.com>

This fetcher allows BitBake to fetch from a Google Cloud Storage
bucket. The fetcher expects a gs:// URI of the following form:

SSTATE_MIRRORS = "file://.* gs://<bucket name>/PATH"

In addition, a GCP project name must be specified using the
GCP_PROJECT_NAME variable like so:

GCP_PROJECT_NAME = "my-project"

The fetcher uses the Google Cloud Storage Python Client, and
expects it to be installed, configured, and authenticated prior
to use.

Signed-off-by: Emil Ekmečić <eekmecic@snap.com>
---
 lib/bb/fetch2/__init__.py |   4 +-
 lib/bb/fetch2/gcp.py      | 108 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 lib/bb/fetch2/gcp.py

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 8afe012e..0a3d7a58 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1290,7 +1290,7 @@ class FetchData(object):
 
             if checksum_name in self.parm:
                 checksum_expected = self.parm[checksum_name]
-            elif self.type not in ["http", "https", "ftp", "ftps", "sftp", "s3", "az", "crate"]:
+            elif self.type not in ["http", "https", "ftp", "ftps", "sftp", "s3", "az", "crate", "gs"]:
                 checksum_expected = None
             else:
                 checksum_expected = d.getVarFlag("SRC_URI", checksum_name)
@@ -1973,6 +1973,7 @@ from . import npm
 from . import npmsw
 from . import az
 from . import crate
+from . import gcp
 
 methods.append(local.Local())
 methods.append(wget.Wget())
@@ -1994,3 +1995,4 @@ methods.append(npm.Npm())
 methods.append(npmsw.NpmShrinkWrap())
 methods.append(az.Az())
 methods.append(crate.Crate())
+methods.append(gcp.GCP())
diff --git a/lib/bb/fetch2/gcp.py b/lib/bb/fetch2/gcp.py
new file mode 100644
index 00000000..7431ea4d
--- /dev/null
+++ b/lib/bb/fetch2/gcp.py
@@ -0,0 +1,108 @@
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
+from google.cloud import storage
+
+class GCP(FetchMethod):
+    """
+    Class to fetch urls via GCP's Python API.
+    """
+    def __init__(self):
+        self.gcp_client = None
+
+    def init(self, d):
+        """
+        Initialize GCP client with the correct project name.
+        """
+        self.get_gcp_client(d)
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
+    def get_gcp_client(self, d):
+        project = d.getVar("GCP_PROJECT_NAME") or ""
+        if project == "":
+            raise FetchError(f"No GCP project was specified using the GCP_PROJECT_NAME variable, unable to initialize GCP client!")
+        logger.debug2(f"Trying to get GCP client for GCP project '{project}'")
+        self.gcp_client = storage.Client(project=project)
+
+    def download(self, ud, d):
+        """
+        Fetch urls using the GCP API.
+        Assumes localpath was called first.
+        """
+        logger.debug2(f"Trying to download gs://{ud.host}{ud.path} to {ud.localpath}")
+        if self.gcp_client is None:
+            self.get_gcp_client(d)
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
+            self.get_gcp_client(d)
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
2.40.1


