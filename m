Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBFE6C8303C
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 22:24:51 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.9231.1751495082964038665
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Jul 2025 15:24:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=g7/T/Szv;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a53359dea5so2867684f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 02 Jul 2025 15:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751495081; x=1752099881; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UW0uEPCgTT3AZSEHzo9AKXHVtmvvf9d4SW3n24PrWIc=;
        b=g7/T/SzviCvioDD4D2+Q/yyKM1iM9oXI1zIfHjSpS16H49QCUv7Sww7OOj8WQXKYXn
         j73RIumDGWNRM1qGloYQAKIpspd33SDTzR/7ebxLsGK9Wf317iDVbrETW26ymNFzgIEQ
         yGPLU4CF18+MZCrJn15w8jP66QvhKII8dPD7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751495081; x=1752099881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UW0uEPCgTT3AZSEHzo9AKXHVtmvvf9d4SW3n24PrWIc=;
        b=VURBaJzqmLn0wdl/PnlsSqIw5wpwgaIF1IKEV/JRIUkM4Zaw0UZT3piznMuQkPxPUj
         feK0pt3iGUV7XJu/x8tWcll6l476pktuwhjexLo3hkwdATf/tAm7b4JgnW9PbOXf9XFT
         EN5Dajv0VW2xYkqac9GLT//Dp+60/QisKuG/C1mt8No1uY0P01WIjKiIvn9cQEPv67mH
         4e4NJZ2Auj4TNNwaMauiB7sjfAtCBRN8AyKe7mBr9bemSPntRxzoDmKt24ifrFESWKHY
         KxosKIqTzdC7N7QhTyooAOBFlzFyBiqXw3Kuux5FnYwQi4ERqmcoMl/2f/1nHylyP3sY
         Z/UQ==
X-Gm-Message-State: AOJu0Yw/Jv/rqbTzwoNNonXFYz+Hysu/aC/3KNYRzmwdwnDiG2tnmpu3
	BMqXDcSb8P3DKMGhfhggFeZlepQKVVJ56AkK6Pk4fXvwVg3p4BR381cw0mefIJfo1hFANDmcNiT
	VYaev
X-Gm-Gg: ASbGncsiDLG/5gHBi7gXsqAe1MhTAZK2mbRb6XSFlFwYPN7IKeK2vIycnTlUS7a5Bg8
	4pRt0AigjYPrapuSrx9h1LunxF8F+kpyg9qJTRqzm/6/vF65nMy5MHABWIOgJsuPKwfJJfIe1nA
	uLG2/0B//S7jpLwBhZpDC6FrA3OtJP4UgKDK4ELsVsUovy9t1eZW1Z9Say94wpGGbS5osxd2iCY
	KIU/IXUDslERxSe6OuQPkblE6wHbH9RAyVwiLoVXSlUWl30AQMEkAqH+uzTm6y6mNkXIL8R7X6P
	A5vXH8LLe3jPlyP9cCrXqHOIl7c+djZHXn4BcQFKkdqjEiCBougg+MzCuvRUdgATZf0tbrQ3Txz
	grzQERqb58ErlMsc=
X-Google-Smtp-Source: AGHT+IG5pJWUXHpXAVAYLg0ZVBy9CDidXZDXXbLptw9i8/XNk63EtYg8dZhA7zmgKkLlna3LcBIGtQ==
X-Received: by 2002:a05:6000:4805:b0:3a5:3b63:58f0 with SMTP id ffacd0b85a97d-3b1fea8f858mr3273537f8f.18.1751495080910;
        Wed, 02 Jul 2025 15:24:40 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:acf3:9ed8:45ec:fd86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e61fa4sm17102775f8f.97.2025.07.02.15.24.38
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 15:24:39 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] cooker: Use a queue to feed parsing jobs
Date: Wed,  2 Jul 2025 23:24:37 +0100
Message-ID: <20250702222437.3733042-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250702222437.3733042-1-richard.purdie@linuxfoundation.org>
References: <20250702222437.3733042-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Jul 2025 22:24:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17738

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
 lib/bb/cooker.py | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 91e3ee025ea..e88ad24cf61 100644
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
+                except (ValueError, OSError):
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
 
@@ -2159,22 +2163,25 @@ class CookerParser(object):
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
+            for jobid in range(len(self.willparse)):
+                self.toparse_queue.put(jobid)
 
             for i in range(0, self.num_processes):
-                parser = Parser(self.jobs[i], self.result_queue, self.parser_quit, self.cooker.configuration.profile)
+                parser = Parser(self.willparse, self.toparse_queue, self.result_queue, self.parser_quit, self.cooker.configuration.profile)
                 parser.start()
                 self.process_names.append(parser.name)
                 self.processes.append(parser)
 
+            self.toparse_queue.close()
+
             self.results = itertools.chain(self.results, self.parse_generator())
 
     def shutdown(self, clean=True, eventmsg="Parsing halted due to errors"):

