Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF930C352A1
	for <webhook@archiver.kernel.org>; Wed,  7 Dec 2022 14:27:51 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.16507.1670423264264450581
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Dec 2022 06:27:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=c9rbk5AJ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id d1so28303074wrs.12
        for <bitbake-devel@lists.openembedded.org>; Wed, 07 Dec 2022 06:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0qn8dqz+B4+H1xWCxPNZ3W+CJF0COLbsvNYaej/TZAw=;
        b=c9rbk5AJ/CCNiWz9Kl7JCerBrObrJxkXFydC2/LtE9T7YnTdimZpBQ+0M2s/svVA+7
         cOfXuJduSMuEAkxSVhABxwh0LtCeWRu8BZD9Lg3AMTg1D2GMSpxXIDtf3HnBFVtSCFlg
         DeKEtxrAwqqJgXG3JejbfHhHrtKK7xzK1yCjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qn8dqz+B4+H1xWCxPNZ3W+CJF0COLbsvNYaej/TZAw=;
        b=Q0TMr5JEfB5OZu4QnuGsDlsI224l7VwPcVh0E7khGdFcMkmgMHkHDhu1E//hNVI1Mr
         4DRK8yFGm+Ds5EEiJ7coTDWHSVTbmn/l4geavM949aabbuHmizy+Cw8U+n50XHoMTdVA
         +7RAi3M8djaX0Do2Hu8wrqeDwkfuBx8I9DzMp2+hOuY+TA9Uf5QBrVONdontiy8lUos8
         T4TRx+vROublAPd1gVdcrYIo3hdv9lq02rDIRmbyJYz8/NVf+Rs3tWl3fXyYyUwfBQTO
         0qWm5rxSsRbXLbn6mSTc024nxjktRvVrFJ999YfW8G2V9Dzb34+oYuSML4HlR8P4BAJc
         GzxQ==
X-Gm-Message-State: ANoB5pkFkKVFDwZ377VVnDU/3i/igoxceU5k9z2WKmJEIjboJFSXm/68
	yZycaM9UYXmS3QLBWbZwu1Omw+Na3EFxv1X9
X-Google-Smtp-Source: AA0mqf4do8+c1lMt129nB6CQOoq0dWqgSuY2Ph6BK70TF9V+ItmD3ee99VRGYN2Agh50SHC0d+4gfg==
X-Received: by 2002:a5d:44c8:0:b0:242:2a46:6ff9 with SMTP id z8-20020a5d44c8000000b002422a466ff9mr20825687wrr.371.1670423262520;
        Wed, 07 Dec 2022 06:27:42 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a7cc:35cb:98f7:71b8])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003cfd4cf0761sm2264664wmq.1.2022.12.07.06.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:27:42 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [PATCH] cooker: Use event to terminate parser threads
Date: Wed,  7 Dec 2022 14:27:41 +0000
Message-Id: <20221207142741.2130790-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 07 Dec 2022 14:27:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14143

From: Joshua Watt <JPEWhacker@gmail.com>

Uses an event to terminate the parser threads instead of a queue. This
is not only simpler, but saves about 500ms on shutdown time

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 4be95dd7fb..7f232f2b36 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2093,11 +2093,7 @@ class Parser(multiprocessing.Process):
         pending = []
         try:
             while True:
-                try:
-                    self.quit.get_nowait()
-                except queue.Empty:
-                    pass
-                else:
+                if self.quit.is_set():
                     break
 
                 if pending:
@@ -2194,7 +2190,7 @@ class CookerParser(object):
         if self.toparse:
             bb.event.fire(bb.event.ParseStarted(self.toparse), self.cfgdata)
 
-            self.parser_quit = multiprocessing.Queue(maxsize=self.num_processes)
+            self.parser_quit = multiprocessing.Event()
             self.result_queue = multiprocessing.Queue()
 
             def chunkify(lst,n):
@@ -2226,8 +2222,7 @@ class CookerParser(object):
         else:
             bb.error("Parsing halted due to errors, see error messages above")
 
-        for process in self.processes:
-            self.parser_quit.put(None)
+        self.parser_quit.set()
 
         # Cleanup the queue before call process.join(), otherwise there might be
         # deadlocks.
@@ -2257,10 +2252,6 @@ class CookerParser(object):
             if hasattr(process, "close"):
                 process.close()
 
-        self.parser_quit.close()
-        # Allow data left in the cancel queue to be discarded
-        self.parser_quit.cancel_join_thread()
-
         def sync_caches():
             for c in self.bb_caches.values():
                 c.sync()
-- 
2.34.1


