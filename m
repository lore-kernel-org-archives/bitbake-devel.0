Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E451C8303D
	for <webhook@archiver.kernel.org>; Sat,  5 Jul 2025 06:26:12 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.12850.1751696765473395450
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 04 Jul 2025 23:26:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cjBOIa1q;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a528243636so831044f8f.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 04 Jul 2025 23:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751696763; x=1752301563; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dTTXNaVSmzEVF3mhaNgW9DupMsE4GMus2QraxwTdC+s=;
        b=cjBOIa1qwNRU4mlkTtFxHgReXHFBg0Ei4Hy2G0nMe/lVz/NGnjWVRqn5+1MqNU3kOy
         BKcrhHdoMPwSESrDjFeJHLRw0AoHNCv0GW/l8Zi4Z0NUEOYC/MItUsH2aM9hxirPDpmC
         mI/S09NPBhg8vEELBdmFFI9/zJNuoe827C+NM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751696763; x=1752301563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dTTXNaVSmzEVF3mhaNgW9DupMsE4GMus2QraxwTdC+s=;
        b=tJmXay+ZEe8W8lx7Me6dv2Sa20wm2Zjt75khrd/gNI84pTVHSrqMHrSP5LtZ8ghym3
         xEBUp9HVCz7X6o6XOfGFldPHZshj1YeI8v9h1tZx4rkoSI3eW7Cl3w5GHV9zi1WyTaIC
         tW17S9fVK+euHj0qv/dym719hluzXR7M1m6QCKi8kFIo/CRCWi6ud7vShGIaXkbVT1A4
         Hkw+x3djvmrmrJuBOF8c/Bkp9XYj2FSrOZ8qyeLc3TajSGBJi7TSRLFzsPnA0T+ck77j
         kCyhHwaF9grk8ZWYz7rpMvZqiucIRxkfCgljMX3YFnRXVlDDUBI85flfObXRdWcJ+l3U
         peng==
X-Gm-Message-State: AOJu0YxCQlVYa7nJW8c5b8athGNyQ6d0sPxyQ2lIleZp0ZpKixHehJQ/
	5OYsN2GVLfIMAXSQPNqmddDotWBV1OuymlrshE0rd8cHLpf2z7IlwUjmZaEGYb5neh+FtQRotXm
	54B98
X-Gm-Gg: ASbGnctg4NGdzFndLNzuhX23CgC41retYGjAoCXEITF77umrlJ6k5UfxfhHTAWyQYXS
	JxAHv26lCak+6WqJiNy3yFbEmmARG6ZVEsjXd9Isrr6WT78Y921c6EhUGBNll9gL2DfLx9xD3v9
	FlHQMjRxQup4YFs93UgxhvHdUie8CG1J65ocazL60z1+RKjBIzmZem2pL9fq/p/GknoBE0Dn7h5
	8U8oTJc2AzmtTH0myTVXRN3vKnk/dz9A8aXFvgXL5ps46PP7cZnL4AaOdaK0h4z6jWbUfvl1GzN
	6XRXM9rq2FVHVVwSG0CE4EZB1N5hoxy5j44vj9RfjBOSWFvNezZGBa1bwjpw1eGJ69eJ1rfNLBV
	jQBQvRNpR5k7kOg==
X-Google-Smtp-Source: AGHT+IHlTAo5Vd/SvGobJvxXVOFlMNw+KBPX5TmcIkbjgEkbeboOnIRQ+XwiVBQ/scw52az2p9BfGw==
X-Received: by 2002:a05:6000:481c:b0:3a4:f663:acb9 with SMTP id ffacd0b85a97d-3b49a9fe75amr926289f8f.9.1751696763076;
        Fri, 04 Jul 2025 23:26:03 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:af5:483d:7f18:d9ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9bde35dsm73873815e9.30.2025.07.04.23.26.02
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 23:26:02 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] cooker: Use a queue to feed parsing jobs
Date: Sat,  5 Jul 2025 07:26:01 +0100
Message-ID: <20250705062601.3875763-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 05 Jul 2025 06:26:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17748

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
 lib/bb/cooker.py | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 91e3ee025ea..8b959cc942e 100644
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
@@ -2064,12 +2065,14 @@ class Parser(multiprocessing.Process):
                 if self.quit.is_set():
                     break
 
-                job = None
+                jobid = None
                 try:
-                    job = self.jobs.pop()
-                except IndexError:
+                    jobid = self.jobid_queue.get(True, 0.5)
+                except (ValueError, OSError, queue.Empty) as e:
                     havejobs = False
-                if job:
+
+                if jobid is not None:
+                    job = self.jobs[jobid]
                     result = self.parse(*job)
                     # Clear the siggen cache after parsing to control memory usage, its huge
                     bb.parse.siggen.postparsing_clean_cache()
@@ -2082,6 +2085,7 @@ class Parser(multiprocessing.Process):
                     except queue.Full:
                         pending.append(result)
         finally:
+            self.jobs.close()
             self.results.close()
             self.results.join_thread()
 
@@ -2134,13 +2138,13 @@ class CookerParser(object):
 
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
 
@@ -2159,22 +2163,26 @@ class CookerParser(object):
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

