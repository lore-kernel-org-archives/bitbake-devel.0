Return-Path: <eekmecic@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79955C001DF
	for <webhook@archiver.kernel.org>; Wed,  2 Aug 2023 13:06:49 +0000 (UTC)
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
 by mx.groups.io with SMTP id smtpd.web11.14388.1690981599225273268
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Aug 2023 06:06:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=Vxjcp1QP;
 spf=pass (domain: snapchat.com, ip: 209.85.210.194, mailfrom: eekmecic@snapchat.com)
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-686b91c2744so4934751b3a.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 02 Aug 2023 06:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1690981598; x=1691586398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3d6Zm7xQiZw5MoizeDJeWSy+PZPYIWjF/0QCXnqqoOA=;
        b=Vxjcp1QP2MqXtuxhpspMPUF2tE35tC79PrdutUR0x/v//Kvr3WTLuOzU8oyIKD9P8d
         TLLdjL11KS/ZSAH0fEXCC9inUn/QrqEATBxMdZrx6vII0uF4BvXZBcIID74RPBYL/ROB
         8tEIE6cOnyc7jOJRSYB0lyUFK8AQZghdAXxEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690981598; x=1691586398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3d6Zm7xQiZw5MoizeDJeWSy+PZPYIWjF/0QCXnqqoOA=;
        b=jFYs1GduYaEVplNRqzufa7xmUcSniC/cmRABLin4fVtL/+riiTknszxJzb+KzBXMts
         i3SdQ8k4BxGP/1ad2A2ARjem6g4TsBdCHyw7Gz3CH6tAbGy3AOosig5qvCDFx/9pn6lJ
         nD64vKJX3HOMl0lxs1Hv70zwP6FcKLPXODhA3cYCpDDc9M3hd6JRsA1YWh8fUfXfM70/
         ejyxY3S1kwYpF4HJ9GeJLMCPkxkVAW4ctnlLn+PqYA9pz/bUDSDFN+A1T7JRpndTyX0L
         0oug9NESQ1An/CinY1qkmT/Atgw96d4OX7drH2GZSNriiQ0cfaUBaeOj9Tf5fyW1X4I4
         DR+g==
X-Gm-Message-State: ABy/qLZs9VRKraE86I2RbmPQs66yw6nDsU+YgTHGEKtpRlc54fdPdhic
	mDiYebS4JDSgVoBSD3eU9m5b7Ek9d6txOnoQEAhInWO5o/nzqw==
X-Google-Smtp-Source: APBJJlFDfJ7jqXQWJkZHGP8WfcycjQ/aHVQJUOYiepLRmlPrnyvwyIntlqYi0XwcLfrE2HfUf4r0EA==
X-Received: by 2002:a17:90a:2c8:b0:267:ee56:4c59 with SMTP id d8-20020a17090a02c800b00267ee564c59mr12382812pjd.35.1690981598081;
        Wed, 02 Aug 2023 06:06:38 -0700 (PDT)
Received: from 4SK64Z2.sc-core.net ([144.232.179.190])
        by smtp.gmail.com with ESMTPSA id t9-20020a639549000000b005646bc58f07sm2976985pgn.17.2023.08.02.06.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 06:06:37 -0700 (PDT)
From: eekmecic@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: =?UTF-8?q?Emil=20Ekme=C4=8Di=C4=87?= <eekmecic@snap.com>
Subject: [bitbake-devel][PATCH v3] fetch2: add Google Cloud Platform (GCP) fetcher
Date: Wed,  2 Aug 2023 06:06:32 -0700
Message-Id: <20230802130632.805865-1-eekmecic@snap.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Aug 2023 13:06:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14908

From: Emil Ekmečić <eekmecic@snap.com>

This fetcher allows BitBake to fetch from a Google Cloud Storage
bucket. The fetcher expects a gs:// URI of the following form:

SSTATE_MIRRORS = "file://.* gs://<bucket name>/PATH"

The fetcher uses the Google Cloud Storage Python Client, and
expects it to be installed, configured, and authenticated prior
to use.

There is also documentation for the fetcher added to the User
Manual. I'm still not completely sure about the recommends_checksum()
being set to True. As I've noted in the mailing list, it will throw
warnings if the fetcher is used in recipes without specifying a
checksum. Please let me know if this is intended behavior or if it
should be modified.

If accepted, this patch should merge in with the corresponding oe-core
patch titled "Add GCP fetcher to list of supported protocols".

Here is how this fetcher conforms to the fetcher expectations
described at this link:
https://git.yoctoproject.org/poky/tree/bitbake/lib/bb/fetch2/README

a) Yes, network fetching only happens in the fetcher

b) The fetcher has nothing to do with the unpack phase so there is no
network access there

c) This change doesn't affect the behavior of DL_DIR. The GCP fetcher
only downloads to the DL_DIR in the same way that other fetchers,
namely the S3 and Azure fetchers do.

d) The fetcher is identical to the S3 and Azure fetchers in this
context

e) Yes, the fetcher output is deterministic because it is downloading
tarballs from a bucket and not modifying them in any way.

f) I set up a local proxy using tinyproxy and set the http_proxy
variable to test whether the Python API respected the proxy. It
appears that it did as I could see traffic passing through the
proxy. I also did some searching online and found posts indicating
that the Google Cloud Python APIs supported the classic Linux proxy
variables, namely:
  - https://github.com/googleapis/google-api-python-client/issues/1260

g) Access is minimal, only checking if the file exists and downloading
it if it does.

h) Not applicable, BitBake already knows which version it wants and
the version infomation is encoded in the filename. The fetcher has no
concept of versions.

i) Not applicable

j) Not applicable

k) No tests were added as part of this change. I didn't see any tests
for the S3 or Azure changes either, is that OK?

l) I'm not 100% familiar but I don't believe this fetcher is using any
tools during parse time. Please correct me if I'm wrong.

Signed-off-by: Emil Ekmečić <eekmecic@snap.com>
---
 .../bitbake-user-manual-fetching.rst          |  36 ++++++
 lib/bb/fetch2/__init__.py                     |   4 +-
 lib/bb/fetch2/gcp.py                          | 104 ++++++++++++++++++
 3 files changed, 143 insertions(+), 1 deletion(-)
 create mode 100644 lib/bb/fetch2/gcp.py

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
index c061bd70..f5723d67 100644
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
index 00000000..66efbbdd
--- /dev/null
+++ b/lib/bb/fetch2/gcp.py
@@ -0,0 +1,104 @@
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
+        Initialize GCP client.
+        """
+        self.get_gcp_client()
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
2.40.1


