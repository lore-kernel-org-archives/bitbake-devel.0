Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2A2C3DA7A
	for <webhook@archiver.kernel.org>; Sat, 31 Dec 2022 16:59:02 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web10.45725.1672505936049422241
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 31 Dec 2022 08:58:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PCAV0j/0;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso17659096wmp.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 31 Dec 2022 08:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tkaLMV/TXg2nYYXIFNhxmxwLEBZPUn1o58dOjIwSSU4=;
        b=PCAV0j/06SDucy5QeOlMI/eJhQcEX/AtKqOrOahIe0QEUurKNUFoRviH1NY2YPlQOs
         d6FQ6ZVLaA35sGlxVF+Xbgt+huc+ZW/l1f/SKDaBRqzS0AoNBbDCIL8dmA3s+/hgoIY2
         70N1drdUJ/buzq4HRaErvAbvyEKSnT68xuAlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkaLMV/TXg2nYYXIFNhxmxwLEBZPUn1o58dOjIwSSU4=;
        b=IRmPDUT6pgfiST4ukE9TtSv3fxMry+DOGQyBnUnDT3zbGtPxLuYgNWXMEewZv+eEWK
         DuFcdARTqcJ+9bnqJQD4jj2th05hBxNAU+QnVXtRUWw+Dbf56teLW/AnTEsYpYZwUEhO
         fv50NrBxiLbg2drNDS7LGrCGKBOXEEnVlYgHAnWulVUmiVx/5/jRJ5rED8+ZcnRWb/9o
         +0lgsafo6g2yzOvAIvoM9vcqO2gsJ51RwU58s/xpbDLVWyq28oxwSwcB7o+pZfJHqbUq
         83doOOqxx84tBss5uHj8LEKzxHU1VRtrXpOUrL3bxZFvtnkUrnfTuxYSJaU4BiFUJ4gI
         lJjA==
X-Gm-Message-State: AFqh2koI2U47LHq3Ic6WkAhprzaCebb+ZSG4tChEK0+ovPrLzixj866N
	jSTjPNTDZcrzFAKjH2JWcdpxI9Cc7NAV/GKG
X-Google-Smtp-Source: AMrXdXuy1J1Pem9QiLPonBEiFAZG0ShU4bbFZi6Un15vbz1AEaSt8XW39FJfmwTQsQscF2/3tsLq7g==
X-Received: by 2002:a05:600c:42d5:b0:3d6:e790:c9a0 with SMTP id j21-20020a05600c42d500b003d6e790c9a0mr30904283wme.10.1672505934436;
        Sat, 31 Dec 2022 08:58:54 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1a1f:74ee:21ca:3bb])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003b47b80cec3sm36582812wmq.42.2022.12.31.08.58.53
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 08:58:54 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 06/11] cooker: Ensure commands clean up any parser processes
Date: Sat, 31 Dec 2022 16:58:44 +0000
Message-Id: <20221231165849.964169-7-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221231165849.964169-1-richard.purdie@linuxfoundation.org>
References: <20221231165849.964169-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 31 Dec 2022 16:59:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14268

When finishing a command, we need to ensure any parsing processes that may have
been started are cleaned up before we reset the cooker state.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 7e0d6b47bf..adc232e288 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1768,6 +1768,9 @@ class BBCooker:
             self.parser.final_cleanup()
 
     def finishcommand(self):
+        if hasattr(self.parser, 'shutdown'):
+            self.parser.shutdown(clean=False)
+            self.parser.final_cleanup()
         self.state = state.initial
 
     def reset(self):
-- 
2.37.2


