Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF344C677F1
	for <webhook@archiver.kernel.org>; Wed, 11 Jan 2023 17:51:11 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.31182.1673459462935070580
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Jan 2023 09:51:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=HWDhFfh9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso14956920wms.5
        for <bitbake-devel@lists.openembedded.org>; Wed, 11 Jan 2023 09:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cB4Xy0JHWZj16drrMHjQj3uwQTqWpjYGCBoOHjqACfY=;
        b=HWDhFfh988O89wKuIBJwHjYW9YxPFKDXjyAS0SDgJq8VyP3LQCugDTg31IyB2rCQU/
         +IpHjXqgcb8gRbSFSJlKuTKKWDhsG+JeMIVRi/EQNaHOqIoE/Oa4gK+dQoPPxFb5Mmgm
         kRGQ5qIDqno9JIg9AQVhMyXIqNrPrcqdkqxuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cB4Xy0JHWZj16drrMHjQj3uwQTqWpjYGCBoOHjqACfY=;
        b=EOQgDq23x2TNHuRJ8AFnusnSGptV83EcklmlhGCy+O0R6DU9dy2dT7kb3bX0jtp4zi
         +yMASz+rWbRCiRHnqZZns61AB9ot+OvOTvl3y6FBaGbMHuyS5Pv2xMoh7p8kN1lPqagA
         fxuC61MgTobLnoZhhKn5R0c2sYw3eDabA3Fwwx0l9XOCiA/mM/YCW0MnkbA6bxti01af
         Lw27u0fAy5MfDVJQhZYpmxDgFNngOU9MDu8vTcukax5DSoYs5vRZR8q7Hgl0HRcWZYUS
         XQn2Vp30vApNwZj9pOqc16nfVI8jtRybGGy8epvknKP02XyUBd0AfACkG5rg/BxaPjLr
         iL8A==
X-Gm-Message-State: AFqh2koU0BECHjvTrrbKIq/v8QjMf899LydDyu5xCom2G7+dgYjwZfJq
	zkSP7P7bSz0Qz2ECn2RDbFSPcUgGtvZ7+AnV
X-Google-Smtp-Source: AMrXdXuQ89z0oSkgQL4Uz/b8SpGIa3SKRX5YEnTQNw/5y1+RzcKZfrVsLZuOX4/9cxJhn0AUO/oJNQ==
X-Received: by 2002:a05:600c:1f15:b0:3cf:98e5:f72 with SMTP id bd21-20020a05600c1f1500b003cf98e50f72mr56698394wmb.3.1673459461247;
        Wed, 11 Jan 2023 09:51:01 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a11f:4d56:748b:c178])
        by smtp.gmail.com with ESMTPSA id j30-20020a05600c1c1e00b003d9f14e9085sm11689624wms.17.2023.01.11.09.51.00
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 09:51:00 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/4] knotty: Improve shutdown handling
Date: Wed, 11 Jan 2023 17:50:57 +0000
Message-Id: <20230111175058.1526619-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230111175058.1526619-1-richard.purdie@linuxfoundation.org>
References: <20230111175058.1526619-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Jan 2023 17:51:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14303

There are three levels of shutdown, the initial "wait for current tasks",
then "stop current tasks" and "exit now". Change the code so that we don't
instantly exit after "stop current tasks" but allow the events to come
through from the server first. The new shutdown level allows that to then
be broken out of too.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/knotty.py | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 7370a1adfd..431baa15ef 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -631,7 +631,12 @@ def main(server, eventHandler, params, tf = TerminalFilter):
     termfilter = tf(main, helper, console_handlers, params.options.quiet)
     atexit.register(termfilter.finish)
 
-    while main.shutdown < 2:
+    # shutdown levels
+    # 0 - normal operation
+    # 1 - no new task execution, let current running tasks finish
+    # 2 - interrupting currently executing tasks
+    # 3 - we're done, exit
+    while main.shutdown < 3:
         try:
             if (lastprint + printinterval) <= time.time():
                 termfilter.keepAlive(printinterval)
@@ -644,7 +649,7 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                         termfilter.clearFooter()
                         print("No reply after pinging server (%s, %s), exiting." % (str(error), str(ret)))
                         return_value = 3
-                        main.shutdown = 2
+                        main.shutdown = 3
                     lastevent = time.time()
                 if not parseprogress:
                     termfilter.updateFooter()
@@ -756,15 +761,15 @@ def main(server, eventHandler, params, tf = TerminalFilter):
                 if event.error:
                     errors = errors + 1
                     logger.error(str(event))
-                main.shutdown = 2
+                main.shutdown = 3
                 continue
             if isinstance(event, bb.command.CommandExit):
                 if not return_value:
                     return_value = event.exitcode
-                main.shutdown = 2
+                main.shutdown = 3
                 continue
             if isinstance(event, (bb.command.CommandCompleted, bb.cooker.CookerExit)):
-                main.shutdown = 2
+                main.shutdown = 3
                 continue
             if isinstance(event, bb.event.MultipleProviders):
                 logger.info(str(event))
-- 
2.37.2


