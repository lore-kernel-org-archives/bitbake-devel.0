Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B556C433FE
	for <webhook@archiver.kernel.org>; Tue, 29 Mar 2022 14:28:03 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web08.7270.1648564082528197667
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 07:28:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ag3+smXu;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id r7so23973509wrc.0
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 29 Mar 2022 07:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=W9XSP6IqEHkSqSFcBt5RQaoQhdrVyChCox5y3wFHTOU=;
        b=ag3+smXuspf/QUiHErq1WqY01ik2NU+GRGWT6QBWkmAvGCPi8jFa98x80h7IzpFRBu
         hrws03+prbubvWsMp2BIoeLR/bQcTPuI2F13ZPC4LPGVAyTAdP3BkBSvBdyAsKNOemM3
         y7b8fGTo/NR+KznmbgN6GtAxhNEZYZaYYV3Ow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W9XSP6IqEHkSqSFcBt5RQaoQhdrVyChCox5y3wFHTOU=;
        b=RrYHr38jBzusIa+ELwV24Z3zSHtFj5YaWnnyxgD68U4c0UGGiga4FQSUa8xtavs6Me
         WmEMfJYhEe/cJchFDM5YQLON0SG4iIHwU/UwgAJXalHbVNhAU+az/w5w+xUvBlvcZ+As
         4aErhcweBsAi5UeLNQiczj1OLbxpKDD4wmY5UtTieoM9DCCg7LBT5S1jehWxXwKa9QCc
         xEZ9ozYHnFGAfcNSnn5mV+JlSFO2TI5W7TnsRpsGQt6wK5YfP0Zh6UwNOtGvQYHPi7JP
         J9MWBAKcQ/HTja26B/V09dNxwvpgHX2W7OdUtXUIBNgHRrQNfoVJJm7czedIb6Zc8NEB
         fZ3A==
X-Gm-Message-State: AOAM531Z7ZYTzc/VGWc6zwwun0FQLJ2kAZqC6G+za/OxKmL2aXhIpp9P
	V4krhtIkewLGBBqXFkbWqvkn+9GaywuvE0t/
X-Google-Smtp-Source: 
 ABdhPJwfvZqyJ4gMZRWb/6cqEiDp3O3oMHLYmlbWqe5dPWpg17hZ1xwJ8RhJz3JsjaVsKymV95T1Qg==
X-Received: by 2002:adf:eb48:0:b0:203:f854:86cc with SMTP id
 u8-20020adfeb48000000b00203f85486ccmr30904378wrn.102.1648564080821;
        Tue, 29 Mar 2022 07:28:00 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:a144:3266:4a07:b254])
        by smtp.gmail.com with ESMTPSA id
 bg42-20020a05600c3caa00b00380deeaae72sm2529043wmb.1.2022.03.29.07.27.59
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 07:27:59 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 4/6] cooker: Simplify parser init function handling
Date: Tue, 29 Mar 2022 15:27:53 +0100
Message-Id: <20220329142755.1473185-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220329142755.1473185-1-richard.purdie@linuxfoundation.org>
References: <20220329142755.1473185-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 29 Mar 2022 14:28:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13543

Not sure why this is so convoluted but we should simplify it!

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 2264b18c54..d6fcd9e05c 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2009,11 +2009,10 @@ class ParsingFailure(Exception):
         Exception.__init__(self, realexception, recipe)
 
 class Parser(multiprocessing.Process):
-    def __init__(self, jobs, results, quit, init, profile):
+    def __init__(self, jobs, results, quit, profile):
         self.jobs = jobs
         self.results = results
         self.quit = quit
-        self.init = init
         multiprocessing.Process.__init__(self)
         self.context = bb.utils.get_context().copy()
         self.handlers = bb.event.get_class_handlers().copy()
@@ -2037,8 +2036,12 @@ class Parser(multiprocessing.Process):
             prof.dump_stats(logfile)
 
     def realrun(self):
-        if self.init:
-            self.init()
+        signal.signal(signal.SIGTERM, signal.SIG_DFL)
+        signal.signal(signal.SIGHUP, signal.SIG_DFL)
+        signal.signal(signal.SIGINT, signal.SIG_IGN)
+        bb.utils.set_process_name(multiprocessing.current_process().name)
+        multiprocessing.util.Finalize(None, bb.codeparser.parser_cache_save, exitpriority=1)
+        multiprocessing.util.Finalize(None, bb.fetch.fetcher_parse_save, exitpriority=1)
 
         pending = []
         try:
@@ -2143,13 +2146,6 @@ class CookerParser(object):
         self.processes = []
         if self.toparse:
             bb.event.fire(bb.event.ParseStarted(self.toparse), self.cfgdata)
-            def init():
-                signal.signal(signal.SIGTERM, signal.SIG_DFL)
-                signal.signal(signal.SIGHUP, signal.SIG_DFL)
-                signal.signal(signal.SIGINT, signal.SIG_IGN)
-                bb.utils.set_process_name(multiprocessing.current_process().name)
-                multiprocessing.util.Finalize(None, bb.codeparser.parser_cache_save, exitpriority=1)
-                multiprocessing.util.Finalize(None, bb.fetch.fetcher_parse_save, exitpriority=1)
 
             self.parser_quit = multiprocessing.Queue(maxsize=self.num_processes)
             self.result_queue = multiprocessing.Queue()
@@ -2159,7 +2155,7 @@ class CookerParser(object):
             self.jobs = chunkify(list(self.willparse), self.num_processes)
 
             for i in range(0, self.num_processes):
-                parser = Parser(self.jobs[i], self.result_queue, self.parser_quit, init, self.cooker.configuration.profile)
+                parser = Parser(self.jobs[i], self.result_queue, self.parser_quit, self.cooker.configuration.profile)
                 parser.start()
                 self.process_names.append(parser.name)
                 self.processes.append(parser)
-- 
2.32.0


