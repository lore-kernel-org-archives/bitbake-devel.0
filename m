Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 598EDC433FE
	for <webhook@archiver.kernel.org>; Fri, 25 Mar 2022 09:29:17 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web08.3042.1648200556341582805
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Mar 2022 02:29:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eAZPJ1Iy;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id d7so10017876wrb.7
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 25 Mar 2022 02:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OkscGc+l1fxuX6R+HqF+eyvA5WuFdfrjftyHNI25bmw=;
        b=eAZPJ1Iy72rRF/elyJw+VegzTfcy/Cn5a5MGxWrpbPLV1S4z2QicV+XO6D4goP4c7v
         NsmM+86xd6UNjbJWwkw0VPP567w+WBe7OEjE3MfehayQQfYwEuVBJsM92BG1Y8g/Sgaj
         93Q28xuzfxaJGbtzI47FQomfnB7zvKgON8Mac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OkscGc+l1fxuX6R+HqF+eyvA5WuFdfrjftyHNI25bmw=;
        b=NS6bgXgvjTaI552237Ev/eGvQiSHVMxoeSsSMTvleYCuoysLpNkYlQdA8u111jZPmT
         6NOFzl/a0e8RRTZiHv18XcUmu+90kEjxd5ptdvyVzWMLQPYtZVc0IUzpDC29076YiSca
         qDCG2hKjhrdLALput2TWZiMrYcuz/wQP5ZWIJdjsVZVclFJoSxY3iF9c7JzglmJYQPBX
         KoiiEXz/6pjwQojdsMzJy6J+xCC0R2D5fe9bn7v+rky2c041DiRrhZfROodnMBf5zeI0
         gbEuSnNSnJaKt9XJIHTFUZRDUwbJI8WBB6C6R9tLS1yUwesP67cxN/rA9/pvMgdmKA8e
         IsZA==
X-Gm-Message-State: AOAM533xJxEOZmgdgRQJi9DeOZk9xuFw5+VqDeg/J4IjhfrsNtvghpz4
	bJJED9XIkZsXkY3Ax99t7ItNvm57yxELDVEi
X-Google-Smtp-Source: 
 ABdhPJwO5crCGKb7RMpT4Anpq0GKd004/q8trtPxTPWZ9r4VvNlNhuv2EpI4m9H8kHR5NObw4GNhkg==
X-Received: by 2002:adf:f604:0:b0:203:d9ca:bccf with SMTP id
 t4-20020adff604000000b00203d9cabccfmr8226780wrp.331.1648200554258;
        Fri, 25 Mar 2022 02:29:14 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:f167:7010:a0cc:679f])
        by smtp.gmail.com with ESMTPSA id
 p8-20020a5d4e08000000b002054b5437f2sm4478904wrt.115.2022.03.25.02.29.13
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 02:29:13 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] siggen: Add missing reset handler to hashserv signature
 generator
Date: Fri, 25 Mar 2022 09:29:11 +0000
Message-Id: <20220325092912.1350321-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220325092912.1350321-1-richard.purdie@linuxfoundation.org>
References: <20220325092912.1350321-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 25 Mar 2022 09:29:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13504

When we have a client connection, we should close that connection when reset()
is called on the siggen. Add the missing function.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index ff6b24ccda..39a5ebe6f5 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -492,6 +492,12 @@ class SignatureGeneratorUniHashMixIn(object):
             self._client = hashserv.create_client(self.server)
         return self._client
 
+    def reset(self):
+        if getattr(self, '_client', None) is not None:
+            self._client.close()
+            self._client = None 
+        return super().reset()
+
     def exit(self):
         if getattr(self, '_client', None) is not None:
             self._client.close()
-- 
2.32.0


