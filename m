Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C36C5479D
	for <webhook@archiver.kernel.org>; Thu, 29 Dec 2022 17:07:43 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.209996.1672333657013717810
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Dec 2022 09:07:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=J5iQriq3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id y8so17878357wrl.13
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 09:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovuyRg7h71SKWQRpouzEUKKFTjNE0toUW8yBGlQQYsQ=;
        b=J5iQriq313go9/IQnIADntH8/jly2ltcwnniNJN+GST4nr8rMGIgEFcHCu7lOnGomv
         Oq7ekQ6thnN4aISLy3FYayYWqPeczTiR7qgDSt9YNruS9Yx6jBBDhVpIJ+8yxs49iGb1
         4M2MjxMRLShr28ddLq5TPo5bMMRO/AMjpyUXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovuyRg7h71SKWQRpouzEUKKFTjNE0toUW8yBGlQQYsQ=;
        b=4PX9l8qsVOsT1JVvPGb5anILBfVuKS/Zj9dGa9DB0ANLpz9heCsY+r9VmZRhjRd9L0
         Qpjc+12r6b5LQ4XGqqJBIx57np2NT9YWPZTsqPvsmMnsrzvtyS48jliyrRPXANsN8XkH
         eEHltT9XYHs+sEn9auOl4Q9yoh+QCqLBC+alJ9P3vCsWXQ8zdoOXBlZ3fzxffKrttR4l
         VaOvvg6ar2PT1uk/37JRwT9TZ/VXPiar0SQ0MySHU8U8EOL+zdyFtOG1xKJ8sqgI7CWA
         n6ueifjq85QG+bFUriDYfh45GisGhDIXJW8pb+d85ydBHW88Mvf0JHjM8NxcRLXFxWAn
         i54w==
X-Gm-Message-State: AFqh2kozgo+5qSqVCUfZVqzYEeshNw7nLth/e0CmSkAqrOgqK3nABrgX
	+iY27I6jTBCdal55NKDpdc+QXJOMPOQelRty
X-Google-Smtp-Source: AMrXdXt+sHWwm/8XZ3zed3RpLWk8JZePlVWSIaUJPTgWuQOdnNJCV6lwf2svwzhJWk32GqjK1yLZuw==
X-Received: by 2002:a05:6000:18d1:b0:242:1f46:fb8c with SMTP id w17-20020a05600018d100b002421f46fb8cmr17274050wrq.41.1672333657398;
        Thu, 29 Dec 2022 09:07:37 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:43af:59a1:5bcf:54fb])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600001cc00b0027b35baf811sm12308721wrx.57.2022.12.29.09.07.36
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 09:07:37 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 11/15] server/process: Improve exception logging
Date: Thu, 29 Dec 2022 17:07:24 +0000
Message-Id: <20221229170728.880367-12-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
References: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 17:07:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14253

Currently if either idle functions loop suffers a traceback, it is
silently dropped and there is no log message to say what happened.
This change at least means the traceback is in the cooker log, making
some debugging possible.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 87b683ecf0..3038c63f55 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -397,6 +397,7 @@ class ProcessServer():
                     if not isinstance(exc, bb.BBHandledException):
                         logger.exception('Running idle function')
                     del self._idlefuns[function]
+                    serverlog("Exception %s broke the idle_thread, exiting" % traceback.format_exc())
                     self.quit = True
 
             # FIXME - the 1 is the inotify processing in cooker which always runs
@@ -430,6 +431,7 @@ class ProcessServer():
                 except Exception as exc:
                     if not isinstance(exc, bb.BBHandledException):
                         logger.exception('Running heartbeat function')
+                    serverlog("Exception %s broke in idle_commands, exiting" % traceback.format_exc())
                     self.quit = True
         if nextsleep and bb.event._heartbeat_enabled and now + nextsleep > self.next_heartbeat:
             # Shorten timeout so that we we wake up in time for
-- 
2.37.2


