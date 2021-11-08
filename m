Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E51DC433EF
	for <webhook@archiver.kernel.org>; Mon,  8 Nov 2021 16:28:27 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web08.586.1636388906386472238
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 08:28:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=gu4dQXBS;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id u18so27877137wrg.5
        for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Nov 2021 08:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NgrfOkX5g9UuK8rZWn4PtQ9YDGKidDHYVJezxawg7Qo=;
        b=gu4dQXBSHrEVpv9TodAMzNufipau2OlqlFBpj+GMeo/+sSijIaABlUeRr9F9Tdu/y/
         aIoZQ+lFYDDYYXHwLiBf2z1JPhrCLOhHhqbjhRcUutOd37yo/7Bj0ZmA96bSHY3iJWmn
         YRhUvshbxkEQQxqIH5Y39FjslhdLaJYj1rQUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NgrfOkX5g9UuK8rZWn4PtQ9YDGKidDHYVJezxawg7Qo=;
        b=eEf2IxMcsV3SfwMcbVIB/6OmPlgohO1HsFY9H3oyigBeB+wciEpXVrixFUx1UjyUwl
         YW5+qNRng0pHxLsJyfZo1b4FoMq+Z0CNu22UDIT160PJHHsIjf/kP9ZuEdwVAl4IoUDs
         K9nQ+PXeg3IRecf6iiclruhuFiR9mfGhzL8Ew6m4sN9/vck2v2rNFJjsALeHCwwOuc8t
         xGbI6JqFpy+hbeCUxsnkZ6nz4b33yw/aM5pyr+orL+9mwNGLN0farRIEsDSX2tTKGYnk
         Fr3O1HBFxSN49IhmaikDvI9gxP0olJD9FvwFFe6JInDq/dCu9gafwa8n9sBiDUpAKIjR
         ANwQ==
X-Gm-Message-State: AOAM532NIrkYCRy4o+uKnpqApVuzFzGbsPIKQzOGo78HZtc/Y3sYGfVw
	Ypc+DBJmiqBY05z5fbA1zXbllGTsPmFPtg==
X-Google-Smtp-Source: 
 ABdhPJxJHryHCVUZk2dztmP7KVGZsBneoKw5WGR1Q6uZp0w2grCVxH563o7MiC7b9xssuPq/xGUccg==
X-Received: by 2002:a5d:4e52:: with SMTP id r18mr469138wrt.224.1636388904791;
        Mon, 08 Nov 2021 08:28:24 -0800 (PST)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:5c39:dba0:779a:3673])
        by smtp.gmail.com with ESMTPSA id
 q18sm20214614wmc.7.2021.11.08.08.28.24
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 08:28:24 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue: Fix runall option handling
Date: Mon,  8 Nov 2021 16:28:23 +0000
Message-Id: <20211108162823.3736163-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Nov 2021 16:28:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12945

The previous fix for runall option handling had a small but in it, it
didn't clear the originally processed task list which meant it was running
too many tasks. Fix this so the list is reset and rebuild correctly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 7d4cbed775..957c2d1806 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -933,6 +933,7 @@ class RunQueueData:
             for tid in list(self.runtaskentries.keys()):
                 if tid not in runq_build:
                    reduced_tasklist.remove(tid)
+            runq_build = {}
 
             for task in self.cooker.configuration.runall:
                 if not task.startswith("do_"):
-- 
2.32.0


