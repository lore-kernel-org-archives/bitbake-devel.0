Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91784C48260
	for <webhook@archiver.kernel.org>; Sat, 10 Feb 2024 23:04:54 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.26810.1707606286506638980
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 10 Feb 2024 15:04:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=LqGuc3sA;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41093f79f05so4048745e9.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 10 Feb 2024 15:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1707606285; x=1708211085; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iC0dKmMMtABQ3gCVNSpJASFDkl1swI/FAbyEF7gGGdQ=;
        b=LqGuc3sAHmXjE4EFiTtyD+RuOp74ZI/u7NxOYVW2S1gDT64nAjn66veX4sGm2Rj5hw
         08BDMZQbOnwRILjPMvePRKDAuecmEwul+340PxxNDh9Rt4hMMY6v48XZUf34HPLfLjYv
         nZupX9QPubHGk7tNrK5IRVVkhrw8YIaBXY4E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707606285; x=1708211085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iC0dKmMMtABQ3gCVNSpJASFDkl1swI/FAbyEF7gGGdQ=;
        b=h8gUtr6tJtOmRX+L617u21DCj62xJorPpa7lRphmNYuSivZQKFNXJ90RXAko37gYFK
         ySO4sbqjF2WH3mKhRX4BbDpLf7qtDnCl7exBsvLjXD68BwNphwzIHEUTQslKn/kiWHJ5
         FvyO/63ArYDU+HmIpmQrlaOpWPVwqrBo7TsYGjbUxCqEACeXg2HIYmfJSgycfZ/OnIQx
         EkP3LzY6LnMg+v515NgJpMXGPxAeSRx8Mn2OHYSOClyXblOprsf2ev7Nn566Bn6LlEM6
         eok72R6DDa2Af/fvGJBYHWmWddGJmMmuXeluMLXoITMncJXuwu/5PYet0Fi2D6MvFwEZ
         FWCw==
X-Gm-Message-State: AOJu0Yyq4eOcS1u8u8KfDGX6wIYAQtwKATHcH6X4rG3dPqsmZ04m5X60
	wRx1G/w1+TYH5XqP7FKubvzOK+qA4ZswaSCBdHnnCssUsb/6QLWvKIqjbpzW01Jbi0LqrndmN/u
	F
X-Google-Smtp-Source: AGHT+IEfeYBtcGU7CLqeX0fEijIt7of7i0sCDXKvzATn6YKzk+ZvQFFjSwVvO8KoVWtbZDXvCP+E5A==
X-Received: by 2002:a05:600c:3d87:b0:410:9198:d18a with SMTP id bi7-20020a05600c3d8700b004109198d18amr2082368wmb.24.1707606284599;
        Sat, 10 Feb 2024 15:04:44 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:c350:b3c8:3bca:cef1])
        by smtp.gmail.com with ESMTPSA id n11-20020a05600c3b8b00b004105017f83fsm4486793wms.31.2024.02.10.15.04.44
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:04:44 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] runqueue: Optimise performance of setscene task execution
Date: Sat, 10 Feb 2024 23:04:42 +0000
Message-Id: <20240210230442.3633663-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240210230442.3633663-1-richard.purdie@linuxfoundation.org>
References: <20240210230442.3633663-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 10 Feb 2024 23:04:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15877

"time bitbake world -n" shows a lot of time being spent trying to execute the
setscene tasks when many of them are being skipped due to not being present.

The challenge is the "return True" back into the mainloop restarts the search
back at the start of the task list particularly when there are large numbers of
deferred tasks due to hard dependencies.

In this case we can use continue to continue within the list at the expense of
not returning so quickly to loop back through the main loop. This does significantly
improve performance in real world usage scenarios and we can probably afford the
potential loop starvation.

Thanks for the suggestion from Alexander Kanavin.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 95cab5132f..85669b80ee 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2204,7 +2204,9 @@ class RunQueueExecute:
                     if nexttask in self.sqdata.outrightfail:
                         logger.debug2('No package found, so skipping setscene task %s', nexttask)
                         self.sq_task_failoutright(nexttask)
-                        return True
+                        # Technically we should return True here but that would then start the task list back at the start
+                        # which is really bad for performance ("time bitbake world -n"). Instead, keep our place in the tasklist.
+                        continue
                     if nexttask in self.sqdata.unskippable:
                         logger.debug2("Setscene task %s is unskippable" % nexttask)
                     task = nexttask
-- 
2.40.1


