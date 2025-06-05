Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F72C5B543
	for <webhook@archiver.kernel.org>; Thu,  5 Jun 2025 14:58:20 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.9773.1749135495636252958
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Jun 2025 07:58:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=et3xxub0;
 spf=pass (domain: snapchat.com, ip: 209.85.128.51, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450cf2291bbso4167545e9.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 05 Jun 2025 07:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1749135493; x=1749740293; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vAuquE6pZDEvXzFO9Lqi5aFJfbCYwCpgWa25bA2+h9A=;
        b=et3xxub03nkLvQ3N16DiXl+ZveVjydVCx8/6o3vrrDn7QPmdbxTskp9LiRghTMvWCG
         T3H7dshs/c69oWLi5OzcCntRFZynLBPjCMpT5EVa/zkbe+iVHXdyPzs24ZcIsqJPVhEB
         Wu6friB6HZ46xcpFIJhY16qMCI9TpGE6ZibHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749135493; x=1749740293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vAuquE6pZDEvXzFO9Lqi5aFJfbCYwCpgWa25bA2+h9A=;
        b=GFmxEphhZG9P0bhstODCO3GgKoF358lBkelC0rlk5mtlk4yAr2LbA2y+pMQ0mx63Jo
         gBc+sTibEx0cqEIe64ZOMqha24YsuTM4i2yCBzcCKSJ+0zDQulJpmRCzt5XJRWU4eIF7
         nXDHjIvgA9CBM/Ynt8ukfAupn7bpBM8hAdT4D3Ad5W/4u5EeaiTypea7TD9RZsjbxuwS
         y3MVK/1ICkwMDmRgwv4rRyHvhzmEt0+EXnXVlMiJOb0Ryp8yeDfN7poon4RgaicMElsE
         B8aRJul1dFWt5Qvqd7ox1+29nwJPFVcs2BRUWGPSHmFQiJYxqdv5AX7ctE10IzVKWAGy
         8ZpA==
X-Gm-Message-State: AOJu0YwSbEBNUBZgoqJ6770WyEohe7N9lbje4BROAncJZmckUuv5IJkC
	6oVPsmu78WvwCn1f4cbuGoFTxRCnaGqtGtvOd6KhiltpXmmQrBEbEIONEL0dllxh8WfujqrWrjG
	KXbxz3Mc=
X-Gm-Gg: ASbGncu51tb7qo0KtD0bBvGTs6PsnYDvvGInuQMGcw3kDSUXxzQgTSvIAwdkNqctQrP
	AD6Z9wQ8R0UYL4pNTDVqvxLuhqwPyEO4Uu6wtNBLB8ufCipKZ0kWx9IUMUUKarHI/3qXCDL6pMF
	1cbXbecZqt4dJnBAFJpIIUyCVyn6lKDVdlIZZpZslfzEKbyvSDUgNC6kUMJmsw1h4yeC4giOjDQ
	7Yv2PoHcxRPbXOV/xrdtfEK9mOyAlK6AKd08stiSzXCWw6HEr3BcAesp48i9irl3iTUBEQyLsJM
	FEq8aT4eAR8vfIBI1c8587gijgg9HZRSCDZUeUODXfZ1Z40T2Gc5cj7bcdmTOgE=
X-Google-Smtp-Source: AGHT+IGC6OLHyqmIrJuPqSzHuGwHJgq2/9WtcSMw8YCD8zzgnucQjuL81u5KfUAuM3O3TV/aC0+Q4w==
X-Received: by 2002:a05:6000:1a8e:b0:3a5:2ec5:35ba with SMTP id ffacd0b85a97d-3a52ec539e3mr1303753f8f.30.1749135493466;
        Thu, 05 Jun 2025 07:58:13 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a522ab67dbsm4304054f8f.62.2025.06.05.07.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 07:58:13 -0700 (PDT)
From: ecordonnier@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [bitbake-devel][scarthgap] bitbake: gcp.py: remove slow calls to gsutil stat
Date: Thu,  5 Jun 2025 16:57:36 +0200
Message-ID: <20250605145736.2782365-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Jun 2025 14:58:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17686

From: Etienne Cordonnier <ecordonnier@snap.com>

The changes of 1ab1d36c0af6fc58a974106b61ff4d37da6cb229 added calls to "gsutil stat" to avoid unhandled exceptions, however:
- in the case of checkstatus() this is redundant with the call to self.gcp_client.bucket(ud.host).blob(path).exists() which already returns True/False
 and does not throw an exception in case the file does not exist.
- Also the call to gsutil stat is much slower than using the python client to call exists() so we should not replace the call to exists() with a call to gsutil stat.
- I think the intent of calling check_network_access in checkstatus() was to error-out in case the error is disabled. We can rather change the string "gsutil stat" to something else to make the code more readable.
- add a try/except block in download() instead of the extra call to gsutil

[RP: Tweak to avoid import until needed so google module isn't required for everyone]
(Bitbake rev: dd120f630e9ddadad95fe83728418335a14d3c3b)

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/fetch2/gcp.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/gcp.py b/bitbake/lib/bb/fetch2/gcp.py
index eb3e0c6a6bb..2ee9ed21948 100644
--- a/bitbake/lib/bb/fetch2/gcp.py
+++ b/bitbake/lib/bb/fetch2/gcp.py
@@ -23,7 +23,6 @@ import urllib.parse, urllib.error
 from bb.fetch2 import FetchMethod
 from bb.fetch2 import FetchError
 from bb.fetch2 import logger
-from bb.fetch2 import runfetchcmd
 
 class GCP(FetchMethod):
     """
@@ -48,7 +47,6 @@ class GCP(FetchMethod):
             ud.basename = os.path.basename(ud.path)
 
         ud.localfile = d.expand(urllib.parse.unquote(ud.basename))
-        ud.basecmd = "gsutil stat"
 
     def get_gcp_client(self):
         from google.cloud import storage
@@ -59,17 +57,20 @@ class GCP(FetchMethod):
         Fetch urls using the GCP API.
         Assumes localpath was called first.
         """
+        from google.api_core.exceptions import NotFound
         logger.debug2(f"Trying to download gs://{ud.host}{ud.path} to {ud.localpath}")
         if self.gcp_client is None:
             self.get_gcp_client()
 
-        bb.fetch2.check_network_access(d, ud.basecmd, f"gs://{ud.host}{ud.path}")
-        runfetchcmd("%s %s" % (ud.basecmd, f"gs://{ud.host}{ud.path}"), d)
+        bb.fetch2.check_network_access(d, "blob.download_to_filename", f"gs://{ud.host}{ud.path}")
 
         # Path sometimes has leading slash, so strip it
         path = ud.path.lstrip("/")
         blob = self.gcp_client.bucket(ud.host).blob(path)
-        blob.download_to_filename(ud.localpath)
+        try:
+            blob.download_to_filename(ud.localpath)
+        except NotFound:
+            raise FetchError("The GCP API threw a NotFound exception")
 
         # Additional sanity checks copied from the wget class (although there
         # are no known issues which mean these are required, treat the GCP API
@@ -91,8 +92,7 @@ class GCP(FetchMethod):
         if self.gcp_client is None:
             self.get_gcp_client()
 
-        bb.fetch2.check_network_access(d, ud.basecmd, f"gs://{ud.host}{ud.path}")
-        runfetchcmd("%s %s" % (ud.basecmd, f"gs://{ud.host}{ud.path}"), d)
+        bb.fetch2.check_network_access(d, "gcp_client.bucket(ud.host).blob(path).exists()", f"gs://{ud.host}{ud.path}")
 
         # Path sometimes has leading slash, so strip it
         path = ud.path.lstrip("/")
-- 
2.43.0


