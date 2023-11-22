Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6BCC61D9D
	for <webhook@archiver.kernel.org>; Wed, 22 Nov 2023 14:16:29 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.20324.1700662588178606401
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Nov 2023 06:16:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=E59Z8pXB;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3316d3d11e1so549387f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Nov 2023 06:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1700662586; x=1701267386; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2OXxgi5XWw25EMa47R2D/6ikTeSghagm0JJFk1YPaqU=;
        b=E59Z8pXBbyMp2T7TQCgW3U0Pg0Wmetkur0lK0co1JIawmm3lUuFgvhuVDjCZGStKUp
         ArKOPM4iCdN8+lb6zrBYtpKAOIFSL25MyCJwucK+SFbIGs0MvK1L3T03/PpKbmv8nt/u
         CyVMb3GGxErBCLUMIQgMgELB4irVyIFcE6ej0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700662586; x=1701267386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OXxgi5XWw25EMa47R2D/6ikTeSghagm0JJFk1YPaqU=;
        b=YqkJhhFwa3E6sL7SjzP8W+fvLhGfgpBGl8/e+zTMuahY3x3YVs+ofYOxQqxY4/EFuB
         LroZkDKusF2iwutJ7jvjsGJYPaGqXewn9KSt+kOeDL2Vj09A06GBHswICIRKKDqrB4+G
         +jw8sUAZRVTYtMrElVcFOLwzyovVTBUOvFgQixF6XrqUdsnUS3sWi+YkG5JOw3h0909H
         UZSBqZT1E/UdwCeNcCAMjrvJe6GttLpjbtLeDMbjI5u76ZyYm2kDNGa9qyB/b0jhys6j
         L38l2R/KWld+mkw5yj9t9wxJ4Kp4PsKa6pUX/ycfRTknOttElO1Ue6dfhS6vGkpYfO/r
         Zqag==
X-Gm-Message-State: AOJu0YwpibP4b3pkBQQ0wBxZlqgGsjSYwEblr4PCXjotoaGzq5OQSnze
	5B8CHDGxAqJwQ0X8k1g5vIA8/HhD+mcP1FRRPaY=
X-Google-Smtp-Source: AGHT+IHNzasSZ5YROi6J9Ml9DS8TUj0t9UIoV6WavhP7ti3gN+fZ3SIkYYPcSLjMX25XBsxKZqhUNg==
X-Received: by 2002:a5d:66c5:0:b0:332:ca52:9914 with SMTP id k5-20020a5d66c5000000b00332ca529914mr2539216wrw.11.1700662586406;
        Wed, 22 Nov 2023 06:16:26 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1718:e534:44cc:c75e])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d5849000000b00332c6f1beccsm9576238wrf.66.2023.11.22.06.16.25
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 06:16:25 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: Avoid sideeffects for autorev from getAllKeysWithFlags
Date: Wed, 22 Nov 2023 14:16:24 +0000
Message-Id: <20231122141624.3484780-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Nov 2023 14:16:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15563

If we expand the variable AUTOREV in OE-Core, it triggers side effects in the
fetcher. The situation isn't ideal and needs improvement but this breaks
and is blocking enabling BB_DEFAULT_EVENTLOG.

Hack around the issue for now so we unblock things until we can work out
a better plan for how to improve AUTOREV support.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 9f84030962..d658db9bd8 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1557,7 +1557,13 @@ class BBCooker:
 
 
     def getAllKeysWithFlags(self, flaglist):
+        def dummy_autorev(d):
+            return
+
         dump = {}
+        # Horrible but for now we need to avoid any sideeffects of autorev being called
+        saved = bb.fetch2.get_autorev
+        bb.fetch2.get_autorev = dummy_autorev
         for k in self.data.keys():
             try:
                 expand = True
@@ -1577,6 +1583,7 @@ class BBCooker:
                             dump[k][d] = None
             except Exception as e:
                 print(e)
+        bb.fetch2.get_autorev = saved
         return dump
 
 
-- 
2.39.2


