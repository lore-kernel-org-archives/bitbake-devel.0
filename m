Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F186C41535
	for <webhook@archiver.kernel.org>; Wed, 21 Dec 2022 23:35:17 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.33950.1671665710834077800
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Dec 2022 15:35:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CpaeC2c+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id i82-20020a1c3b55000000b003d1e906ca23so13456wma.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 21 Dec 2022 15:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z14wn+fdObnCb4A98XEBqYC6JuHymdEstH4/N/oFOos=;
        b=CpaeC2c+KQ7WJsvjSDAgqFCk1I0xWRlA0aH9hweuM9N4Nehr2gFH3D9sWDY6T2nb5x
         0e5u99Nmh+QMuIjHHcRqDCIANvrTqyAKouhRTHy9S13l2G5Z8y3COt6lM96BGIr+21pP
         BxuevBI/iVbYTqR8grDWZbb5qBV91YRJnvnNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z14wn+fdObnCb4A98XEBqYC6JuHymdEstH4/N/oFOos=;
        b=LBK5RUzUK+wTLcGGVJsPayipruzscrMfXn3KVzRaUBVaZOvRkS8jSwRfqtETz0wM9x
         jDsOI+8KTIWFucTlcDh8VgS4aZCWIGPTQEgt6G/rhu4tINJC25RkGGoP1ntnwYdhSgOU
         I1dfCv/Laj0cd/yqP/V8hmWboQTWzze0eT66TKfRQas31LVG+OBNQfmesoV/XyXs0c7M
         iFjApcOHnXeG2k4Au7KQHZImNE9dWQVxlVnVyN/YxRbVPW16SJYcKAkwQ39ILItzZ5Vo
         Pca4gC9Bm/UsdB7hP6qY/hD2R1MZXjYGQ/5nbmsKGRm5aWfkLtZwah++zrn345uKjyzc
         Yt5Q==
X-Gm-Message-State: AFqh2kr+Hurct1W5W67xSAGANAkHe1E4SaNdJR5pJqO7wqEklosliN65
	AwMirAyUOBJV5OWP9o6DevOFFzcPs1oUwm8H
X-Google-Smtp-Source: AMrXdXu7faXsI2i/CA0FQn7HCZYD7KDYv7ddM7WHTCtC3lS2yhctL2C6TGVfrb2U26YIgPBcvFTN/w==
X-Received: by 2002:a1c:4c12:0:b0:3c6:e63e:89a6 with SMTP id z18-20020a1c4c12000000b003c6e63e89a6mr2861752wmf.2.1671665709205;
        Wed, 21 Dec 2022 15:35:09 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a8db:6d5d:f54f:c6b2])
        by smtp.gmail.com with ESMTPSA id g15-20020a05600c310f00b003b47e75b401sm4063967wmo.37.2022.12.21.15.35.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 15:35:08 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] server/process: Improve exception logging
Date: Wed, 21 Dec 2022 23:35:06 +0000
Message-Id: <20221221233507.519249-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221221233507.519249-1-richard.purdie@linuxfoundation.org>
References: <20221221233507.519249-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Dec 2022 23:35:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14228

Currently if either idle functions loop suffers a traceback, it is
silently dropped and there is no log message to say what happened.
This change at least means the traceback is in the cooker log, making
some debugging possible.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 51eb882092..a3f2829560 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -395,6 +395,7 @@ class ProcessServer():
                     if not isinstance(exc, bb.BBHandledException):
                         logger.exception('Running idle function')
                     del self._idlefuns[function]
+                    serverlog("Exception %s broke the idle_thread, exiting" % traceback.format_exc())
                     self.quit = True
 
             if nextsleep is not None:
@@ -424,6 +425,7 @@ class ProcessServer():
                 except Exception as exc:
                     if not isinstance(exc, bb.BBHandledException):
                         logger.exception('Running heartbeat function')
+                    serverlog("Exception %s broke in idle_commands, exiting" % traceback.format_exc())
                     self.quit = True
         if nextsleep and bb.event._heartbeat_enabled and now + nextsleep > self.next_heartbeat:
             # Shorten timeout so that we we wake up in time for
-- 
2.37.2


