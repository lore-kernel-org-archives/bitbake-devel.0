Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36662C433F5
	for <webhook@archiver.kernel.org>; Sat, 26 Mar 2022 20:35:05 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.7422.1648326903990791198
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 26 Mar 2022 13:35:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ElKLF1vP;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id
 r204-20020a1c44d5000000b0038ccb70e239so1408876wma.3
        for <bitbake-devel@lists.openembedded.org>;
 Sat, 26 Mar 2022 13:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sYndZs6A1eX88S/gUxvFN/QfdvLC6ew57JSoQWAy1vE=;
        b=ElKLF1vPxrHtL8aTgwB4+Et2fIYGxi3D8Ww+JF9swbx8D5sOL4XtJ3sdXALdmmdEV0
         r9JWUv7G2UsFoYTw+pxBQZHGVenAAGqGtqnpAGrfaGGoyJawU4wB/BwEOgve3ToWXVLZ
         hAr8aoEZ/9rCeF5pBFs5b2NOnTEux7UmhqX4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sYndZs6A1eX88S/gUxvFN/QfdvLC6ew57JSoQWAy1vE=;
        b=1VqYjqpg1GEfwbXX4Cqb4L/Vpn8EtIzCITQg/4O06KiIDfRS17F1qVb23Qw2PcsUhh
         C5BTgaF49YihBVPM+On2ti54eUucF2DvgrJx0HSKTGVntW0XkD+sGGwukcMEMfKBRRxQ
         VKKffkPuKAfb+gcEGxS8IOKdbIp7x16rtAHC+cSnC+jfVULMKOzeD/4jJLtqX0FhF/3Y
         D5lLE7pNsXUsM0HlhcD6XahCrNC0MaF1NixghcLkwlkn3jwTlCSOV3neNElWBDY2Fw80
         Pj1snN/DPV9G0fvJS2cM/qtHaRQXXVwlWDTRSLT5VO+rAD9kp7tXH8UMGVg7DHOrvchy
         b5IA==
X-Gm-Message-State: AOAM533BfTZe2mLchRSZn3oqJMizZlV2pjRMutSsUdH9l0cS01xfgXXx
	R4QRetLuM8IdNblOkEvUGH+ec6dti2y5p2bS
X-Google-Smtp-Source: 
 ABdhPJwNdukjn7OP8rHUVCy/4+PCry9VwgrSpA3IxWDja/7K2VBeNb9P++Vbc5cqVOqPyar3nz5low==
X-Received: by 2002:a05:600c:3c9d:b0:37f:a5c3:fccf with SMTP id
 bg29-20020a05600c3c9d00b0037fa5c3fccfmr16684681wmb.13.1648326902367;
        Sat, 26 Mar 2022 13:35:02 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:3949:59d4:6f55:52f])
        by smtp.gmail.com with ESMTPSA id
 a18-20020a05600c349200b0038ca453a887sm12242586wmq.19.2022.03.26.13.35.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 13:35:01 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/6] cooker: Fix main loop starvation when parsing
Date: Sat, 26 Mar 2022 20:34:54 +0000
Message-Id: <20220326203458.1391301-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220326203458.1391301-1-richard.purdie@linuxfoundation.org>
References: <20220326203458.1391301-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 26 Mar 2022 20:35:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13514

When parsing, the parser isn't servicing the main loop so a Ctrl+C in the
UI won't be seen on the cooker/server side. Fix this by returning when queue
timeouts occur. This helps where there is a hung or slow parsing thread.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index c4d720a6b6..fb71a968f2 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2249,7 +2249,7 @@ class CookerParser(object):
                 result = self.result_queue.get(timeout=0.25)
             except queue.Empty:
                 empty = True
-                pass
+                yield None, None, None
             else:
                 empty = False
                 yield result
@@ -2266,6 +2266,10 @@ class CookerParser(object):
             if isinstance(result, BaseException):
                 # Turn exceptions back into exceptions
                 raise result
+            if parsed is None:
+                # Timeout, loop back through the main loop
+                return True
+
         except StopIteration:
             self.shutdown()
             return False
-- 
2.32.0


