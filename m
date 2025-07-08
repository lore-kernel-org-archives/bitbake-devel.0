Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFBFC8303C
	for <webhook@archiver.kernel.org>; Tue,  8 Jul 2025 15:42:44 +0000 (UTC)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
 by mx.groups.io with SMTP id smtpd.web10.21988.1751989358887402702
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 08 Jul 2025 08:42:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AP08IIwd;
 spf=pass (domain: gmail.com, ip: 209.85.166.50, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-8731c3473c3so43922639f.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 08 Jul 2025 08:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751989357; x=1752594157; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w5iIIc8Nf88WTYpVsIB6wsF+AFKUc3kGq09mm8+FaZY=;
        b=AP08IIwdM6nQyaOBFCjTOQFfeJrFwuOHGqNyJXDY1VCtVSHFJMaWMC1JpN5RhMRqnz
         5N0iiNww9ue+pdsbBfn3J/pRU0TQh+1ClnomKX+Cf64t0SozpZB4QEiEEX39psc1N5rv
         iM52pPZFkUyAW1qGIuyp5v2jq+Oq+lb58RY0jGlVLoDPiDKRywzJ8aJ1TG3XQEY++mgL
         4IDTCAgoMmu58NnM1X4os3uY1zxt8rMIU4CwfJLZm4OJk4cHZXnhXP1mdfoJ0xXq2hu5
         vtz1C6EcUE8vO47iDRDETGkW+uQaxPzp1S0yqsDnw2uK/VfkSk/asV22cZRva9HtbdJy
         m19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751989357; x=1752594157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5iIIc8Nf88WTYpVsIB6wsF+AFKUc3kGq09mm8+FaZY=;
        b=XUmSFnKM+Z/hc4iiNmCg/3SyVdzsW42iNkB5AKqFHC4SzEnvwT/dN9BWk23OvhVKj9
         zSTx1Zzb+//CE2IbvlVgQaa9+M7qvAX/TzQd8Hk6bZDHYcrU5cfYKbwJvGLDkmGgDfBG
         RUJo6zsBb8RqWUUYFzUZVpV4tzaGDJtQ0HPZuIQvxnq/abDU51hZk0rGdbita/PNXtTb
         FBqsKyv5tc+lpIJB9rih+lb//ZZkWvzv54d+82fow0Ipgldet9RCxldqX+mPldGhFYdk
         y3x4TadXulJLb+Z25UPpR7F8rntZMKdSXS0vclnIpFZjyTacFO4rfx4hsa/yJsz7AGft
         WmVA==
X-Gm-Message-State: AOJu0YycJ9IjbgWIess7DcGyTlf3cFeFp2IFLX5iwfommwXimfUOmo4b
	o6XrvlTBoLoqP37fJcW33dLky9S3rO8wx3j0hcNpCmgV2ajGGJpk3AIyEWmJaA==
X-Gm-Gg: ASbGncsbxSeVHxZjkGhKabBXUUxhdzePSIGf2ruFoC2IHugnMhGKRywYvLA2udLbEY1
	TbUXzjr4i4dVQ85Y7pSTX1aiMlR3Uq67W+y1SgP99z6WWFXcC+LBWr7DyfyR0bzB8rIgbTB8XZX
	CFwhw5pG6WSc0lN2dHaz9FL6eQk+Ie+Cbv/+24BvY1ViH/DEFAwNMpF4xLKUJj+QOrED2YYoCgM
	WAFq53gqUs6XfSVF1YacohTdbGvSh/IXgxuXY8ES2mPRg9TbTm7F/+s/LJ6ufpgFvb7UB55yrwf
	NUXS4z4SyZ8LUARjujpdtTFrBR4WeBMjteCcBDyR2m4KEs1xq1IGfage7qln3A1WClHlw9c=
X-Google-Smtp-Source: AGHT+IEv5DwW42sDEQOTf8b0j8mJ6YsqY6bzj4UvNek/uoYbPSv+hympdo1CkvJBQD2M+MJKPKrnUg==
X-Received: by 2002:a05:6602:368e:b0:875:ba1e:4d7e with SMTP id ca18e2360f4ac-876e47a50c2mr1565896839f.6.1751989357387;
        Tue, 08 Jul 2025 08:42:37 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::42c3])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-876e07a7392sm282724039f.9.2025.07.08.08.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 08:42:36 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] cooker: Use shared counter for processing parser jobs
Date: Tue,  8 Jul 2025 09:42:22 -0600
Message-ID: <20250708154222.1479350-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 08 Jul 2025 15:42:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17763

Instead of pre-partitioning which jobs will go to which parser
processes, pass the list of all jobs to all the parser processes
(efficiently via fork()), then used a shared counter of the next index
in the list that needs to be processed. This allows the parser processes
to run independently of needing to be feed by the parent process, and
load balances them much better.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/cooker.py | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 2bb80e330d3..dc131939ed0 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -26,6 +26,7 @@ import json
 import pickle
 import codecs
 import hashserv
+import ctypes
 
 logger      = logging.getLogger("BitBake")
 collectlog  = logging.getLogger("BitBake.Collection")
@@ -1998,8 +1999,9 @@ class ParsingFailure(Exception):
         Exception.__init__(self, realexception, recipe)
 
 class Parser(multiprocessing.Process):
-    def __init__(self, jobs, results, quit, profile):
+    def __init__(self, jobs, next_job_id, results, quit, profile):
         self.jobs = jobs
+        self.next_job_id = next_job_id
         self.results = results
         self.quit = quit
         multiprocessing.Process.__init__(self)
@@ -2065,10 +2067,14 @@ class Parser(multiprocessing.Process):
                     break
 
                 job = None
-                try:
-                    job = self.jobs.pop()
-                except IndexError:
-                    havejobs = False
+                if havejobs:
+                    with self.next_job_id.get_lock():
+                        if self.next_job_id.value < len(self.jobs):
+                            job = self.jobs[self.next_job_id.value]
+                            self.next_job_id.value += 1
+                        else:
+                            havejobs = False
+
                 if job:
                     result = self.parse(*job)
                     # Clear the siggen cache after parsing to control memory usage, its huge
@@ -2134,13 +2140,13 @@ class CookerParser(object):
 
         self.bb_caches = bb.cache.MulticonfigCache(self.cfgbuilder, self.cfghash, cooker.caches_array)
         self.fromcache = set()
-        self.willparse = set()
+        self.willparse = []
         for mc in self.cooker.multiconfigs:
             for filename in self.mcfilelist[mc]:
                 appends = self.cooker.collections[mc].get_file_appends(filename)
                 layername = self.cooker.collections[mc].calc_bbfile_priority(filename)[2]
                 if not self.bb_caches[mc].cacheValid(filename, appends):
-                    self.willparse.add((mc, self.bb_caches[mc], filename, appends, layername))
+                    self.willparse.append((mc, self.bb_caches[mc], filename, appends, layername))
                 else:
                     self.fromcache.add((mc, self.bb_caches[mc], filename, appends, layername))
 
@@ -2159,18 +2165,18 @@ class CookerParser(object):
     def start(self):
         self.results = self.load_cached()
         self.processes = []
+
         if self.toparse:
             bb.event.fire(bb.event.ParseStarted(self.toparse), self.cfgdata)
 
+            next_job_id = multiprocessing.Value(ctypes.c_int, 0)
             self.parser_quit = multiprocessing.Event()
             self.result_queue = multiprocessing.Queue()
 
-            def chunkify(lst,n):
-                return [lst[i::n] for i in range(n)]
-            self.jobs = chunkify(list(self.willparse), self.num_processes)
-
+            # Have to pass in willparse at fork time so all parsing processes have the unpickleable data
+            # then access it by index from the parse queue.
             for i in range(0, self.num_processes):
-                parser = Parser(self.jobs[i], self.result_queue, self.parser_quit, self.cooker.configuration.profile)
+                parser = Parser(self.willparse, next_job_id, self.result_queue, self.parser_quit, self.cooker.configuration.profile)
                 parser.start()
                 self.process_names.append(parser.name)
                 self.processes.append(parser)
-- 
2.49.0


