Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A3AC52D7C
	for <webhook@archiver.kernel.org>; Fri, 23 Aug 2024 08:41:41 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web10.11831.1724402491382633144
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Aug 2024 01:41:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=RQrRJosB;
 spf=pass (domain: snapchat.com, ip: 209.85.221.54, mailfrom: ecordonnier@snapchat.com)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37186c2278bso1494728f8f.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 23 Aug 2024 01:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1724402489; x=1725007289; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ESZt3qOkOPOssMLs3ItY7iQgbraOk5Ng7ODcFZZBMUc=;
        b=RQrRJosBncoCxcq6fPeNEq7JVZCcVNaMd1PZoQ3YV5XDQDkTfMeNpM+nNfADBeOJVc
         WeB0HJdMoBl5QhIdn/NWqF3P+G1GW9osJ2oYQj+446PNwJK7N2wd8PLZq2Fq7+byrzp7
         n1mMs6dLrinkuaZ9w03Z3B4uBdhXSXR2iebUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724402489; x=1725007289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESZt3qOkOPOssMLs3ItY7iQgbraOk5Ng7ODcFZZBMUc=;
        b=oY6+q8nG7L/5iR0Ecf3euBIFll1wEDyAsAs0K7rA4HxQ/UDb6MFzUB100LGo4inUcQ
         GiXFAdOtIvzGOY7ba0C84dtjFuIG7Z5cwsRAGJfRIqr8+566xsh7Lz1SVrqFZ6iZ7pne
         creLSJlbzL/Aoid88bxe8FhJVC/fjVWIVVD1+CPIYrgBt5deS3c3q2AlBRpS7PYMgdIX
         +gFyLGA7iT9OAhjgUhWRz6oz0hp66/oDcpQ/OWfs+fXcPrbT9Ei6lsiPC3OpvL5kaJd6
         7d5DUGL6tlpOYc3f7HTktqUbPKDHORNqmEf/dH4zD6ewknZe6gjN3gCXYvgBUho2r859
         jTNg==
X-Gm-Message-State: AOJu0YyIk5KUJhkeXTNt3269ILoV/PGREEqCJi7DYHHjDHSqwCnmDGqX
	2iNq1JNawtE4l4OqxWew1BArW5/vn6e24PoTd+ozfZbQnY8GCUn6O2YovKP7u3v8Cp9iCZfpSgb
	reSo=
X-Google-Smtp-Source: AGHT+IFdPbZYcJ9JRPyKfuxREIXGaK0ki2Qq0dvPXrTyQpx6rX654ReufmmWF5MAqGlRrMMHUir4kQ==
X-Received: by 2002:adf:e288:0:b0:371:938c:6f50 with SMTP id ffacd0b85a97d-3730526a598mr3173009f8f.16.1724402489309;
        Fri, 23 Aug 2024 01:41:29 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([213.249.125.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730810ffb9sm3661415f8f.7.2024.08.23.01.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 01:41:29 -0700 (PDT)
From: ecordonnier@snap.com
To: bitbake-devel@lists.openembedded.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [PATCH] gcp.py: remove slow calls to gsutil stat
Date: Fri, 23 Aug 2024 10:41:08 +0200
Message-ID: <20240823084108.1106312-1-ecordonnier@snap.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Aug 2024 08:41:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16519

From: Etienne Cordonnier <ecordonnier@snap.com>

The changes of 1ab1d36c0af6fc58a974106b61ff4d37da6cb229 added calls to "gsutil stat" to avoid unhandled exceptions, however:
- in the case of checkstatus() this is redundant with the call to self.gcp_client.bucket(ud.host).blob(path).exists() which already returns True/False
 and does not throw an exception in case the file does not exist.
- Also the call to gsutil stat is much slower than using the python client to call exists() so we should not replace the call to exists() with a call to gsutil stat.
- I think the intent of calling check_network_access in checkstatus() was to error-out in case the error is disabled. We can rather change the string "gsutil stat" to something else to make the code more readable.
- add a try/except block in download() instead of the extra call to gsutil

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 lib/bb/fetch2/gcp.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/bb/fetch2/gcp.py b/lib/bb/fetch2/gcp.py
index eb3e0c6a6..9ac2f752f 100644
--- a/lib/bb/fetch2/gcp.py
+++ b/lib/bb/fetch2/gcp.py
@@ -19,11 +19,11 @@ Additionally, gsutil must also be installed.
 
 import os
 import bb
+from google.api_core.exceptions import NotFound
 import urllib.parse, urllib.error
 from bb.fetch2 import FetchMethod
 from bb.fetch2 import FetchError
 from bb.fetch2 import logger
-from bb.fetch2 import runfetchcmd
 
 class GCP(FetchMethod):
     """
@@ -48,7 +48,6 @@ class GCP(FetchMethod):
             ud.basename = os.path.basename(ud.path)
 
         ud.localfile = d.expand(urllib.parse.unquote(ud.basename))
-        ud.basecmd = "gsutil stat"
 
     def get_gcp_client(self):
         from google.cloud import storage
@@ -63,13 +62,15 @@ class GCP(FetchMethod):
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


