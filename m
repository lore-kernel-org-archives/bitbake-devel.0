Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C50C433EF
	for <webhook@archiver.kernel.org>; Fri, 25 Mar 2022 09:29:16 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web12.3213.1648200555613764768
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Mar 2022 02:29:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ZaGCtTF/;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id u3so10046923wrg.3
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Mar 2022 02:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8z4Pgx4CxP+WkFQ95Yj12nPdIbmDN+ajTvF2ytd+krY=;
        b=ZaGCtTF/mKKSI1G+uArhJ/WAzC6qr9O4kQxuZxdQ4W37KfvSocvHx9Q/1/bwVVuzl6
         x0zO5q2+G0TajzcF1/VZ5PQUalMMwBCf4F4g6M2q5r91qinKeXpURS2JjEn7o73fyS7i
         N4ueU2iPmBTcZXG8ee30DGQjz87fUg/3g54Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8z4Pgx4CxP+WkFQ95Yj12nPdIbmDN+ajTvF2ytd+krY=;
        b=aI5sDt6E5vUKlIauX9KEVgslG103K/YOvyyvm3rxhkVZKRuG0mZhLDH9+ra6o5a8nI
         3ZGc5ichMcjwVAQ8kkhlru/xBv4HCscpPKIvCUHK1r3enBb/P/zUX7CexO+CGu0AUR87
         gMWHV4Gbn3ojdaMWgte/ckzgvE79/kmxpOfBVxRwrMnQv2NLNZ/boJL9t29qkfgmjSvh
         GQmJKZAVsmZmMviC1p2PBFATBa09HQCbkY04y8qc5+hKgPYl58NiXyIxeMfaQOC2MBWn
         XYy033EH5Cmnh51agS/6jry+Q9HnSk+3gwAKS19IDeIvxzEYeL2FBjK0bovpEjSfdyRx
         TRCg==
X-Gm-Message-State: AOAM531hlh5bhler77Jq85JGECXtm2dCBzkBNtMlLveq+W4XzV5FqMtL
	BrVQqXPceJvle8KiubQhtKsrT2mPvCGZMizO
X-Google-Smtp-Source: 
 ABdhPJw0wLNzY8/FOufBhN0OGS4aSlJDvEYtQcGF5WQauYCfZ9jRFo++VKJOM7jGZcoBkB8m1JAQow==
X-Received: by 2002:adf:e44b:0:b0:1f0:250a:d3ef with SMTP id
 t11-20020adfe44b000000b001f0250ad3efmr8263703wrm.402.1648200553566;
        Fri, 25 Mar 2022 02:29:13 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:f167:7010:a0cc:679f])
        by smtp.gmail.com with ESMTPSA id
 p8-20020a5d4e08000000b002054b5437f2sm4478904wrt.115.2022.03.25.02.29.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 02:29:13 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/3] cooker/siggen: Support exit calls and use for hashserv
 client
Date: Fri, 25 Mar 2022 09:29:10 +0000
Message-Id: <20220325092912.1350321-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Mar 2022 09:29:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13503

We have shutdown functions within the async client code but the siggen
doesn't currently call them. We notice on python 3.10 (such as on fedora35)
that at exit, there is a stray asyncio process left behind. Usually this
doesn't cause problems but it could potentially be a cause of a hang.

For general cleanliness and completness, add in hooks to call the exit handler.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 1 +
 lib/bb/siggen.py | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index f79dc2770d..c0a7a2fd79 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1717,6 +1717,7 @@ class BBCooker:
     def post_serve(self):
         self.shutdown(force=True)
         prserv.serv.auto_shutdown()
+        bb.parse.siggen.exit()
         if self.hashserv:
             self.hashserv.process.terminate()
             self.hashserv.process.join()
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 96e16a45f8..ff6b24ccda 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -156,6 +156,9 @@ class SignatureGenerator(object):
 
         return DataCacheProxy()
 
+    def exit(self):
+        return
+
 class SignatureGeneratorBasic(SignatureGenerator):
     """
     """
@@ -489,6 +492,12 @@ class SignatureGeneratorUniHashMixIn(object):
             self._client = hashserv.create_client(self.server)
         return self._client
 
+    def exit(self):
+        if getattr(self, '_client', None) is not None:
+            self._client.close()
+            self._client = None
+        return super().exit()
+
     def get_stampfile_hash(self, tid):
         if tid in self.taskhash:
             # If a unique hash is reported, use it as the stampfile hash. This
-- 
2.32.0


