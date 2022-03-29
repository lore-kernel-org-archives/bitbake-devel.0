Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B0D2C433EF
	for <webhook@archiver.kernel.org>; Tue, 29 Mar 2022 14:28:01 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web08.7268.1648564079918028520
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 07:28:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=NpuR0kQG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id
 125-20020a1c0283000000b0038d043aac51so1365803wmc.0
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 07:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sYndZs6A1eX88S/gUxvFN/QfdvLC6ew57JSoQWAy1vE=;
        b=NpuR0kQGOKGAUy8NX7A4jn7eMflwtWgaVpvofNflUunbeHyaB9ZmvQGDQVXp4PFn0U
         owHOOslG5+OysmtZbLicyqB/2w1KZL8waEGVg1wwOynpLF2PqcdWFsISfnfpjyEK+qjn
         61NrsMoVoKYFpgDLzd3H2oJvlonX8/sHMR3kA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sYndZs6A1eX88S/gUxvFN/QfdvLC6ew57JSoQWAy1vE=;
        b=xdBoFfin+sGbIsUV+Hxr1VPJbIUiJjGAG4Pb7KjLRWRm1T6O4EaJl/omQTMoDRDOuD
         Mo1Ogd3/6HRFqemdGQkhkSMaxOEapfY6GgirPk+Rb/sjLaSpytXKf5QqFwZCSKjSqS14
         e+SFH1wLA5t923neYONmoewbSNtupZEOkGnsSe6kW88z77AJnIYEpfjIjW8ijZXxbiam
         EYqxv69GXVCsEbWIWanq/DGspou/F08X4zaHApB0XGim+c8DR8L+mH+99dcEa2vPcKF7
         HsjK8u4qiCg3kPHCy4iSI5CUl5lT8MKya6bjBwq0JIWPcABOeNqUZqzqONIHzQvBgYM6
         DyIw==
X-Gm-Message-State: AOAM533Qf5SG3/OjdWaPZqVjjfGerQnbTjTehijt2EvV3KCjoHGvArvz
	SqSx3KkPgv4Wi6/LjOwnELcK2a/gX2V28K2c
X-Google-Smtp-Source: 
 ABdhPJzcgHCR5xvQjZGLtX6DON+t+EXI/edihyVBxvNeGGqVu5o6TtZRGo8c4WGt4azbbDXXgectsg==
X-Received: by 2002:a05:600c:3b24:b0:38c:dbdb:a35c with SMTP id
 m36-20020a05600c3b2400b0038cdbdba35cmr7316445wms.175.1648564077824;
        Tue, 29 Mar 2022 07:27:57 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:a144:3266:4a07:b254])
        by smtp.gmail.com with ESMTPSA id
 bg42-20020a05600c3caa00b00380deeaae72sm2529043wmb.1.2022.03.29.07.27.57
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 07:27:57 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/6] cooker: Fix main loop starvation when parsing
Date: Tue, 29 Mar 2022 15:27:51 +0100
Message-Id: <20220329142755.1473185-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220329142755.1473185-1-richard.purdie@linuxfoundation.org>
References: <20220329142755.1473185-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Mar 2022 14:28:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13540

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


