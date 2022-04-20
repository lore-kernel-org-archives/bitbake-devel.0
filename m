Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB084C49EA2
	for <webhook@archiver.kernel.org>; Thu, 21 Apr 2022 16:46:07 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web12.7080.1650458367808464894
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 05:39:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=b3Wxa8yP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id m14so2091183wrb.6
        for <bitbake-devel@lists.openembedded.org>;
 Wed, 20 Apr 2022 05:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bQdxo3Hp3VZ/wwWRBAtRavf4X+edwgD9CS1HQrcXQr0=;
        b=b3Wxa8yP8o3F2ETOtqPBKn4bKff1haHzoAHVv8lmYs0wUbzP695wnmjdIsRpf8e5Z2
         UBzHZJeCLV/J0hkGAp0qRsoWk6LaQGLSupZvzRE/7NPgHMWP1KamOKTLooOQ6tsqxGok
         CnRPloX924tgsf7+FZMyc/lXngH/5QP47/+38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bQdxo3Hp3VZ/wwWRBAtRavf4X+edwgD9CS1HQrcXQr0=;
        b=qo3+/fOo30jAz4i3CMKggyNEnTxxSwTOzwDBXT1GYbuVZOxmqr8yLGGtjSi/ca8JXg
         nSBgHXpxDiFXKe+NTH2bfL0rErHiMxj41JRUuxDE3+m4Xan2iGeFyZFdK7aTj3Ikw+vn
         NrDiNnYfb+lo4xyUF62P4BPobguf8OSdJVJJOg2OCIdaOG575XyelG7hTjSI9l2dsyDb
         zLf65XrYHdXMe857koUDzXk3FtU/c9ePVyQ5Hxhy3ev30A8MHhJlcliuwmshFIMIUsL4
         tdBGEmw6FATxcNiM8T1o9huF2FqVvD1b4P2My+ErNwyFvOC8XkvWShl4qaBVA+xbEIvE
         2ZYw==
X-Gm-Message-State: AOAM532hs/UvIuwCScMNnNK3tVbgjf3xwytWNmEJneJ6zEwnPRuJyWu0
	t5L/jU6EtVucm88NL0Kms/GZg3O+7fIBrQ==
X-Google-Smtp-Source: 
 ABdhPJyKoEIZl+18iKgw1dusjKZC4rQHwHi09vwNw29Fcn8RebpwCG6+URhjCkQSPtOnXyJ+8eHvlw==
X-Received: by 2002:a5d:4307:0:b0:207:9f82:e238 with SMTP id
 h7-20020a5d4307000000b002079f82e238mr16422276wrq.430.1650458365712;
        Wed, 20 Apr 2022 05:39:25 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:9745:8b8f:81da:af07])
        by smtp.gmail.com with ESMTPSA id
 i27-20020a1c541b000000b003928e866d32sm11731499wmb.37.2022.04.20.05.39.24
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 05:39:25 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tests/parse: Fix one test overwriting another
Date: Wed, 20 Apr 2022 13:39:24 +0100
Message-Id: <20220420123924.2528134-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 21 Apr 2022 16:46:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13642

Fix an issue where two tests have the same name with one overwriting the
other.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tests/parse.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tests/parse.py b/lib/bb/tests/parse.py
index 4d17f82edc..2898f9bb14 100644
--- a/lib/bb/tests/parse.py
+++ b/lib/bb/tests/parse.py
@@ -119,7 +119,7 @@ EXTRA_OECONF:class-target = "b"
 EXTRA_OECONF:append = " c"
 """
 
-    def test_parse_overrides(self):
+    def test_parse_overrides2(self):
         f = self.parsehelper(self.overridetest2)
         d = bb.parse.handle(f.name, self.d)['']
         d.appendVar("EXTRA_OECONF", " d")
-- 
2.32.0


