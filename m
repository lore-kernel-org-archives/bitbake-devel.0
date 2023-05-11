Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C612C7EE22
	for <webhook@archiver.kernel.org>; Thu, 11 May 2023 11:10:45 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web11.55973.1683803435908820685
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 May 2023 04:10:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=Lw8IPJAT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-304935cc79bso7950807f8f.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 May 2023 04:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683803434; x=1686395434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CL8AhKNnPd0TuydhmuZH1fDYJWmTBpRXsXewte3e5Xk=;
        b=Lw8IPJAT4JEJhv5GydzBFnvVCwcE8cJaUq5ad470Sc3xEmWk2nXIJjBa8cbPTXEARK
         5cXcKzn36QpiWtxGfK1TpbX+xZGgNGI6F0RB3T33Q8yFTh7OjC/qEqi9jMmcTSPO/9TH
         wKehOGyHp5+H7MBOddydrXra9RtEFOn4g01+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683803434; x=1686395434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CL8AhKNnPd0TuydhmuZH1fDYJWmTBpRXsXewte3e5Xk=;
        b=IHnB8y+Ul5k8ERKOcCzl60oLRwEon9Xnk4Uye5jdjGt9pSvWHdXt8ycmOFZyRwf/Ko
         XfN/ZmUW7e08GSndt0Lm7YmoPmK1GtKjNrLneiZ+MMt8YNuCfhn1p2oC+2nDdeVS2UmR
         iaNbrxT04QK5orHbXRFG8i2g3jRcOcKNPtg16vzYwQZ10lLLCNY4fsUTbShwwLF43xTC
         3/xlnB/w0FX9bt3tBTE1IULMi0rKzz1dGQkElCoVksb0NIuUbawd7bf9p4yzBiKn0PCy
         8mQnBM+fTbkHbJ53nVB9bTrCOGEuTuf6gCiZbN6rvc2NdHgfsiZ0FVGA02SD1/bA14Oy
         Jp8A==
X-Gm-Message-State: AC+VfDyqaZcA0uqsJxdRfcVDVLJBtGvFjz8MT1QROpnVw0fHC1BLwm03
	Vgt0Sgb3Xh1/BvAskmzh8DNs1GLBaKcPx1C/7OY=
X-Google-Smtp-Source: ACHHUZ6Am5NFiB0i+hvoqzz4h1qZ9+thGa4IfaHvKDrISD7RVYviEp4t3U6spdUNcOk4u9GTqq7CMg==
X-Received: by 2002:adf:f9ca:0:b0:2ee:f1f0:14bb with SMTP id w10-20020adff9ca000000b002eef1f014bbmr12762284wrr.49.1683803433887;
        Thu, 11 May 2023 04:10:33 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:b4cd:cc57:565e:2ba8])
        by smtp.gmail.com with ESMTPSA id e6-20020adffc46000000b002fb60c7995esm20161589wrs.8.2023.05.11.04.10.33
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 04:10:33 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] fetch2: Clarify different localpaths functions
Date: Thu, 11 May 2023 12:10:32 +0100
Message-Id: <20230511111032.1798574-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 May 2023 11:10:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14781

To avoid confusion, rename the local fetcher localpaths function to
something more specific so it doesn't appear similar to the localpaths
top level function.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/fetch2/__init__.py | 2 +-
 lib/bb/fetch2/local.py    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 1a86d8fd81..770021de16 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1234,7 +1234,7 @@ def get_checksum_file_list(d):
         ud = fetch.ud[u]
         if ud and isinstance(ud.method, local.Local):
             found = False
-            paths = ud.method.localpaths(ud, d)
+            paths = ud.method.localfile_searchpaths(ud, d)
             for f in paths:
                 pth = ud.decodedurl
                 if os.path.exists(f):
diff --git a/lib/bb/fetch2/local.py b/lib/bb/fetch2/local.py
index 5332faafe2..8baec7d2e8 100644
--- a/lib/bb/fetch2/local.py
+++ b/lib/bb/fetch2/local.py
@@ -41,9 +41,9 @@ class Local(FetchMethod):
         """
         Return the local filename of a given url assuming a successful fetch.
         """
-        return self.localpaths(urldata, d)[-1]
+        return self.localfile_searchpaths(urldata, d)[-1]
 
-    def localpaths(self, urldata, d):
+    def localfile_searchpaths(self, urldata, d):
         """
         Return the local filename of a given url assuming a successful fetch.
         """
-- 
2.39.2


