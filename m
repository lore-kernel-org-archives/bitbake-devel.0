Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BBAC5479D
	for <webhook@archiver.kernel.org>; Sat, 31 Dec 2022 16:59:02 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.web11.45614.1672505934919659975
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 31 Dec 2022 08:58:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=TcE9+FxT;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f54.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso11121378wms.5
        for <bitbake-devel@lists.openembedded.org>; Sat, 31 Dec 2022 08:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xzEkTuDCEqi8EJUfsRwlIRpYqBNbkQJ5BumzLYhXEoU=;
        b=TcE9+FxTlaZENudwsVDuAda6JHm2/1Ctg5n4LulUJG++HcH9wGOXxnZmoIpXZTb8/k
         EhknZOMV+91xyTF0iYaqcbpRFnaLsBryWnrA8q446Ol97qEg6xVr4YKScfzZKeEksRFk
         d4N7iu3VMQzyv4FntX6kxK2Mkn1fRByVHCTFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xzEkTuDCEqi8EJUfsRwlIRpYqBNbkQJ5BumzLYhXEoU=;
        b=FAc4+lvMlJuUwIjA8yU8Q9LN2r2cDYtqgxBcf0BffXvyZUnNlzkKuVG0G9FS4ueVU/
         r5r0b+CCR7oXiKL5bA+5/9JAnZtnicI+uwB2tZd0IeO83h3ykClHOPWS2mWW9isfrA2S
         zEtVzLXK/KKmCLn0XIHumTnmEvAvyY7yzLnvMOljpruKepKlQ/WOfKoXwZ9MTRL8SIU6
         RwnCO0ZVCQ0l4EO+N/HMYecbuNKm5B+H3LHXWNFocoRYIhk2DHTrm6x+S7usXCVXhmOV
         QzFX5nv0JKC9Dw4U3ols+D7qnalqU065mIHXdcIw6sJkMNUPj7wctzG5y0Pyg/dKMFmM
         Zdjg==
X-Gm-Message-State: AFqh2koQ5CkYqoD9x3BxNFP47NKAkwEiK4dEu95x5TM8MT2vYUF8sh6K
	MVs8lr6hfdrlarMHYtIYga+LLACn9T9pxOBk
X-Google-Smtp-Source: AMrXdXtWaCdtTunV3dzpcFqRp/BtuWTpjylw5S0ZwdAc7b1vibVnNK5fq96d6IJbgNG96a6dSIpkwA==
X-Received: by 2002:a05:600c:34ce:b0:3cf:614e:b587 with SMTP id d14-20020a05600c34ce00b003cf614eb587mr27215418wmq.26.1672505933238;
        Sat, 31 Dec 2022 08:58:53 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1a1f:74ee:21ca:3bb])
        by smtp.gmail.com with ESMTPSA id a1-20020a05600c348100b003b47b80cec3sm36582812wmq.42.2022.12.31.08.58.52
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 08:58:52 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 04/11] server/process: Improve exception and idle function logging
Date: Sat, 31 Dec 2022 16:58:42 +0000
Message-Id: <20221231165849.964169-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221231165849.964169-1-richard.purdie@linuxfoundation.org>
References: <20221231165849.964169-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 31 Dec 2022 16:59:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14265

Currently if the idle functions loop suffers a traceback, it is
silently dropped and there is no log message to say what happened.
This change at least means the traceback is in the cooker log, making
some debugging possible.

Add some logging to show when handlers are added/removed to allow
a better idea of what the server code is doing from the server log
file.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 91eb6e0ad9..eba28ad983 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -106,6 +106,7 @@ class ProcessServer():
         """Register a function to be called while the server is idle"""
         assert hasattr(function, '__call__')
         self._idlefuns[function] = data
+        serverlog("Registering idle function %s" % str(function))
 
     def run(self):
 
@@ -361,6 +362,7 @@ class ProcessServer():
             try:
                 retval = function(self, data, False)
                 if retval is False:
+                    serverlog("Removing idle function %s" % str(function))
                     del self._idlefuns[function]
                     nextsleep = None
                 elif retval is True:
@@ -378,6 +380,7 @@ class ProcessServer():
                 if not isinstance(exc, bb.BBHandledException):
                     logger.exception('Running idle function')
                 del self._idlefuns[function]
+                serverlog("Exception %s broke the idle_thread, exiting" % traceback.format_exc())
                 self.quit = True
 
         # Create new heartbeat event?
@@ -395,6 +398,7 @@ class ProcessServer():
                 except Exception as exc:
                     if not isinstance(exc, bb.BBHandledException):
                         logger.exception('Running heartbeat function')
+                    serverlog("Exception %s broke in idle_commands, exiting" % traceback.format_exc())
                     self.quit = True
         if nextsleep and bb.event._heartbeat_enabled and now + nextsleep > self.next_heartbeat:
             # Shorten timeout so that we we wake up in time for
-- 
2.37.2


