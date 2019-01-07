Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
	[209.85.128.48])
	by mail.openembedded.org (Postfix) with ESMTP id 511137BE3D
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Jan 2019 15:55:39 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id t200so1415320wmt.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 07 Jan 2019 07:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=07iFdNimbADJJ+pXeZvGpLMK/vJEPKCOeHuQbvUxXD4=;
	b=J6zSEBkxx2p7HSBd43So3iuEZVpIlMViJUVrIkwEPtrLDGxgLE2LGN2G1FDOZTXC9O
	07+ZPdmsrd1xCdcmXGc6Qiz8oX2hCKp9yWiMGY3nXCzkV9VDrUS1gWM2983eYQc9Qz8S
	Ie+5CV0vfIYOZv0jA56BG/B/SIipTTXiHMFRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=07iFdNimbADJJ+pXeZvGpLMK/vJEPKCOeHuQbvUxXD4=;
	b=F/O9/298RmmKGNh587bN2npLjcyY7jInPCx3D+dBhLam9aqnEc7lTT80/GYVpBZrDZ
	8tKb/jbBtem3jsXEOzrYFpRYhdrZRdeRS6RDlMwILtLpYuT4MkEUfzaycNbGgq/171H9
	gN7IASzrJmXV7teYcjj7lhHjQOeDY6PRjGETLtfAR4wBUpNG5E9tnYBCijn2/6JB6IAL
	KNpZphVRG/wz/vHPAzu0eJGb9/tqNDYZufA3vZCIm7N6YhzQeWtOK3BJoTw0kkMgSDWp
	j+PPTJ8nB4vkG+91TXT0d5L5pOGU7sGTr11vaRUyjCVMUx9TmSeXen1oOi4flIFc310i
	9hlQ==
X-Gm-Message-State: AJcUukf3bebIVQPAO4VT6PzmP8SPsQcsz3xIDef0Xg7ckddDlaC2m6Dn
	Muka62nIF6pDdj49/90OQgp/9ey9thmq6A==
X-Google-Smtp-Source: ALg8bN4gEmkQdl0mJvVtpXjVVhdWtHnBVd0TYLAySQq/Z3coWec6Bm6QBRZrr1r8/t/BDkruseqsyg==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr9623592wmf.38.1546876539244; 
	Mon, 07 Jan 2019 07:55:39 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	o9sm6400347wmh.3.2019.01.07.07.55.38
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 07 Jan 2019 07:55:38 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 Jan 2019 15:55:34 +0000
Message-Id: <20190107155536.6062-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190107155536.6062-1-richard.purdie@linuxfoundation.org>
References: <20190107155536.6062-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 2/4] cooker: Remove Feeder() since its no longer needed with moderm multiprocessing
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 07 Jan 2019 15:55:39 -0000
Content-Transfer-Encoding: 8bit

There used to be many bugs in multiprocessing and we implemented our own
feeder process to avoid them. Now that we have python 3.x, these are fixed
and just using the standard Queue mechanism appears to work fine. We can
therefore drop the unneeded code and simplify.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 42 +++++-------------------------------------
 1 file changed, 5 insertions(+), 37 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index db52964c3a..d1d2868d6f 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1895,35 +1895,6 @@ class ParsingFailure(Exception):
         self.recipe = recipe
         Exception.__init__(self, realexception, recipe)
 
-class Feeder(multiprocessing.Process):
-    def __init__(self, jobs, to_parsers, quit):
-        self.quit = quit
-        self.jobs = jobs
-        self.to_parsers = to_parsers
-        multiprocessing.Process.__init__(self)
-
-    def run(self):
-        while True:
-            try:
-                quit = self.quit.get_nowait()
-            except queue.Empty:
-                pass
-            else:
-                if quit == 'cancel':
-                    self.to_parsers.cancel_join_thread()
-                break
-
-            try:
-                job = self.jobs.pop()
-            except IndexError:
-                break
-
-            try:
-                self.to_parsers.put(job, timeout=0.5)
-            except queue.Full:
-                self.jobs.insert(0, job)
-                continue
-
 class Parser(multiprocessing.Process):
     def __init__(self, jobs, results, quit, init, profile):
         self.jobs = jobs
@@ -2058,12 +2029,13 @@ class CookerParser(object):
                 multiprocessing.util.Finalize(None, bb.codeparser.parser_cache_save, exitpriority=1)
                 multiprocessing.util.Finalize(None, bb.fetch.fetcher_parse_save, exitpriority=1)
 
-            self.feeder_quit = multiprocessing.Queue(maxsize=1)
             self.parser_quit = multiprocessing.Queue(maxsize=self.num_processes)
-            self.jobs = multiprocessing.Queue(maxsize=self.num_processes)
             self.result_queue = multiprocessing.Queue()
-            self.feeder = Feeder(self.willparse, self.jobs, self.feeder_quit)
-            self.feeder.start()
+
+            self.jobs = multiprocessing.Queue()
+            for j in self.willparse:
+                self.jobs.put(j)
+
             for i in range(0, self.num_processes):
                 parser = Parser(self.jobs, self.result_queue, self.parser_quit, init, self.cooker.configuration.profile)
                 parser.start()
@@ -2086,12 +2058,9 @@ class CookerParser(object):
                                             self.total)
 
             bb.event.fire(event, self.cfgdata)
-            self.feeder_quit.put(None)
             for process in self.processes:
                 self.parser_quit.put(None)
         else:
-            self.feeder_quit.put('cancel')
-
             self.parser_quit.cancel_join_thread()
             for process in self.processes:
                 self.parser_quit.put(None)
@@ -2104,7 +2073,6 @@ class CookerParser(object):
                 process.terminate()
             else:
                 process.join()
-        self.feeder.join()
 
         sync = threading.Thread(target=self.bb_cache.sync)
         sync.start()
-- 
2.19.1


