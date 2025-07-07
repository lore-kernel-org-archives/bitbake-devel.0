Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C36C83F07
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 13:47:06 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.10.1751896020557486323
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Jul 2025 06:47:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=D0b8ryPc;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45348bff79fso34541445e9.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 07 Jul 2025 06:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751896018; x=1752500818; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=N5TLTrAmZfAsN7Y3BSLIQrqaQN10Y9yHL6UJoo0x47Q=;
        b=D0b8ryPc69PlVc0viakI/8ora9bE6fWAujj3Zw77BQuBKL4dr8enhjjF6qF8KcJ2GX
         1A6HYmtOFkaNs+81D5D177IhRlcxyNw+ipKG0I2Le+driARJ12HHc1GGU9F30HQaNeeL
         GNi1VrVsjXzG7/ajmtsBJ1pH8AiG3kM/k6JZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751896018; x=1752500818;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N5TLTrAmZfAsN7Y3BSLIQrqaQN10Y9yHL6UJoo0x47Q=;
        b=X2KywaqUH1f1ni8bbKgIBkIxiBTRdl+BXYl6sAcUGMr4SzGBzvYQ58qLIYSMUv3BfW
         TKQ8iJvuOURmeDBkEegeoCxiNG73iR/BXYw7TVIy5WXehJd8inmtjByZRFZupPu08O+8
         CWSnhde2p7iE+l6L+xiYIYcVLjKIFQ3dmz8jE39znCgoQ70aSqQpo4Qy8+GS8QWZt7RR
         +tMGehfWYXAwGor1+Qh8fkvS6HIKaUZMnxZpSWcqYmaKIfr1yhfCvmeyn/KXIan1iSeY
         pDBudrd+hN/bLcG6al3F9uQU0VjTUpiPOBdKQDQapJhueAInC/M/dOciHNBXmPuGFbZL
         QYmQ==
X-Gm-Message-State: AOJu0Yxd+xiRot+f64o+FPBh0TBQgoeMF59yyO8H1aHMGhntt7ZbnYuD
	4iPJE6Y3vH3+/1EXUUC+VouEzygl4XVq20hq8C/nezmX3qXMpZSRa9BQQf5h6d+z/OfnFWPnhtL
	6D735
X-Gm-Gg: ASbGncv5ax69al6J2nG7TWZucrX9G/cNz1w0OnEOqiuWhszcXoq5huINgZw2XSO6L/C
	whveR5j5AWVah5WDOyAhed9Jp1q0ZbulTvpq/U4vX4mXRuwxqks7XXJXL5raSSduUrx0X1uivuB
	MycksdzsmwZroZy57vS/lLzvR6vA+/PiWLb4t+eY+5p6FRz0MQ4Bgek952z/pgf9YkWLlggvJQr
	E57s+NKZ6Qllf7ELVLk94stk6chgx4TxSdvkpG0mk7Agb0DjHKnCZdsSQyus7k3NW7LP4ETQgYd
	GhxPPhEfId0E3tsmcM0t1UkVH0Z47Ljex7GLzgmYuY613aVJ+xjhKapXGASQPh+bzyl+SC29KRB
	PNY8lk2SwojmMOvZOJNtF5gVI
X-Google-Smtp-Source: AGHT+IF6FoTj3Wn4V75MjzVfL7sBGPHESnqCxlGUTfp2gu1AMIxrQsARbmgtPiFgh3k9Pvc2FEFGPg==
X-Received: by 2002:a05:600c:4694:b0:43c:ea1a:720c with SMTP id 5b1f17b1804b1-454c6a932d0mr32442875e9.18.1751896018207;
        Mon, 07 Jul 2025 06:46:58 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:522e:e734:aad7:114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454b1698e24sm112014705e9.34.2025.07.07.06.46.57
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 06:46:57 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v3] cooker: Use a queue to feed parsing jobs
Date: Mon,  7 Jul 2025 14:46:56 +0100
Message-ID: <20250707134656.4066536-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Jul 2025 13:47:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17752

Curerntly, recipes to parse are split into equal groups and passed to
each parse thread at the start of parsing. We can replace this with
a queue and collect a new job as each parsing process becomes idle
to better spread load in the case of slow parsing jobs.

Some of the data we need has to be passed in at fork time since it
can't be pickled, so the job to parse is only referenced as an index
in that list.

This should better spread load for slow to parse recipes such as those
with many class extensions.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 2bb80e330d3..0761f06e1ce 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1998,8 +1998,9 @@ class ParsingFailure(Exception):
         Exception.__init__(self, realexception, recipe)
 
 class Parser(multiprocessing.Process):
-    def __init__(self, jobs, results, quit, profile):
+    def __init__(self, jobs, jobid_queue, results, quit, profile):
         self.jobs = jobs
+        self.jobid_queue = jobid_queue
         self.results = results
         self.quit = quit
         multiprocessing.Process.__init__(self)
@@ -2064,12 +2065,15 @@ class Parser(multiprocessing.Process):
                 if self.quit.is_set():
                     break
 
-                job = None
+                jobid = None
                 try:
-                    job = self.jobs.pop()
-                except IndexError:
+                    # Have to wait for all parsers to have forked
+                    jobid = self.jobid_queue.get(True, 30)
+                except (ValueError, OSError, queue.Empty):
                     havejobs = False
-                if job:
+
+                if jobid is not None:
+                    job = self.jobs[jobid]
                     result = self.parse(*job)
                     # Clear the siggen cache after parsing to control memory usage, its huge
                     bb.parse.siggen.postparsing_clean_cache()
@@ -2082,6 +2086,7 @@ class Parser(multiprocessing.Process):
                     except queue.Full:
                         pending.append(result)
         finally:
+            self.jobs.close()
             self.results.close()
             self.results.join_thread()
 
@@ -2134,13 +2139,13 @@ class CookerParser(object):
 
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
 
@@ -2159,22 +2164,26 @@ class CookerParser(object):
     def start(self):
         self.results = self.load_cached()
         self.processes = []
+
         if self.toparse:
             bb.event.fire(bb.event.ParseStarted(self.toparse), self.cfgdata)
 
+            self.toparse_queue = multiprocessing.Queue(len(self.willparse))
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
+                parser = Parser(self.willparse, self.toparse_queue, self.result_queue, self.parser_quit, self.cooker.configuration.profile)
                 parser.start()
                 self.process_names.append(parser.name)
                 self.processes.append(parser)
 
+            for jobid in range(len(self.willparse)):
+                self.toparse_queue.put(jobid)
+            self.toparse_queue.close()
+
             self.results = itertools.chain(self.results, self.parse_generator())
 
     def shutdown(self, clean=True, eventmsg="Parsing halted due to errors"):

