Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADB4C83F22
	for <webhook@archiver.kernel.org>; Wed, 16 Jul 2025 15:22:56 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.25143.1752679374456471674
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 16 Jul 2025 08:22:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=ITusLlP9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b611665b96so238188f8f.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 16 Jul 2025 08:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752679372; x=1753284172; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EE5eqzPs1fr7gdra8X3hZDVtcYv4iKxxx5+gTGpMb7M=;
        b=ITusLlP96GuxzFwr98oBOcrhpWW6Zz8nCDr7lkUf86mbmcmZTcDO/x8eTIc+r+o14o
         dbs1TfQc5v9t7rLn/Qf9JwSUEg2A3X9QbDFcnDCrpLvmPR/eZPXCfDn/vt0bfeRBM276
         +KHgElk3IBs8wGJSM05HHtbPsCk1tQhm5rBkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752679372; x=1753284172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EE5eqzPs1fr7gdra8X3hZDVtcYv4iKxxx5+gTGpMb7M=;
        b=L7USYEoeVe5GGPek/70b+FicZaQGkH3+CmdJho9CkZM3yO8HX8TlKwnDPAEJCKTuVn
         czw3x9FHduIjXcqo0VNzTqfja/egZzm58ZMpMY6aeRqdhK6dwX8uNi2FZrB1a4jNcFJz
         pNyf9s8TZus/qPvBELTnJg6OVqUnNF5a6THW3/AzpEIFUhLM2dw6P/kKCEdrGCsim22B
         D43MU1bWPMX/rtMRa5GW3Dw6o0K5AB7XzAfGj6v3+M4YNbUOUc4igKV2w0lNEpsD2yTz
         EnoNURMEo1WCPu0aVhLecBv1YVcvVLiI5P309RTxV7tvnLF2lfBfCPjudaWwKznby5cl
         nqJA==
X-Gm-Message-State: AOJu0Yyssz3c2yXBtfYYQkrH/xtkw1daqW/HtKAOrQAbjGwFFmSc53MC
	ywBYkyKREkUbCvr3g1XhUK8vBZew42N/s1mdTAbf5fDe01S4c46ds26YRpoWdKDCOHQRQ/mdcCd
	B1VLr
X-Gm-Gg: ASbGncsnS2EW/NhZYX5/35/s3EiFEnPYOrv40HDhI6YNw13e8LOxh/i/7qVisrpZkcH
	UuUlRjrDcFk57/UHBRmLF7MbHAR3NYLSC8tHQTpvD6ExfZ6FT4OkviGVvY4qyT9fJL9eMYZyfvn
	6nT1lZMjR18ybQeLAB9+IuWZx2ah3+rzgH4hRyyb7g+5P+g4SnGZi5QJTgmdv6/sqHKafYfMgGg
	OtBCyujv6RoARkA/7soWW6BrPsrlo+BATZkbIIEGXZiZ6gUrurTf72irdbIZg51K/5INESIDMUb
	qdiiejiDG87BqhJ1LFrpBx57KFLZxZX+n//ukvdB2QMmfZPPmZRwodvhvPzE40xUBbfbc+qu23O
	+g4Ir6Ihlp7lC32w3f84oYV3MKO7vjV4taA5cDqOyQHH2slsFbxs=
X-Google-Smtp-Source: AGHT+IFIHBb4Fy9Ze6K2lwHE2swuJoP8aZRUX4H8TNx4bmX6gY4wYYsoGUu0NldgE2mCFn2Jb7BvFA==
X-Received: by 2002:a05:6000:2484:b0:3a5:276b:1ec0 with SMTP id ffacd0b85a97d-3b60e51cebamr2421140f8f.45.1752679372333;
        Wed, 16 Jul 2025 08:22:52 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:22ad:92e1:8848:8bb0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d872sm18362725f8f.60.2025.07.16.08.22.51
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:22:51 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/4] cooker/process/utils: Create profiling common function to remove code duplication
Date: Wed, 16 Jul 2025 16:22:47 +0100
Message-ID: <20250716152249.96126-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250716152249.96126-1-richard.purdie@linuxfoundation.org>
References: <20250716152249.96126-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Jul 2025 15:22:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17780

We have code duplication in the way we handle profiling of code sections.
Create a common function in utils which covers this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py         | 16 +---------------
 lib/bb/server/process.py | 33 ++-------------------------------
 lib/bb/utils.py          | 28 ++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 46 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index dc131939ed0..74b2d075d00 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2027,21 +2027,7 @@ class Parser(multiprocessing.Process):
             self.exit = True
 
     def run(self):
-
-        if not self.profile:
-            self.realrun()
-            return
-
-        try:
-            import cProfile as profile
-        except:
-            import profile
-        prof = profile.Profile()
-        try:
-            profile.Profile.runcall(prof, self.realrun)
-        finally:
-            logfile = "profile-parse-%s.log" % multiprocessing.current_process().name
-            prof.dump_stats(logfile)
+        bb.utils.profle_function(self.profile, self.realrun, "profile-parse-%s.log" % multiprocessing.current_process().name, process=False)
 
     def realrun(self):
         # Signal handling here is hard. We must not terminate any process or thread holding the write
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 4b35be62cd7..78d0a606e23 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -140,23 +140,7 @@ class ProcessServer():
             serverlog("Error writing to lock file: %s" % str(e))
             pass
 
-        if self.cooker.configuration.profile:
-            try:
-                import cProfile as profile
-            except:
-                import profile
-            prof = profile.Profile()
-
-            ret = profile.Profile.runcall(prof, self.main)
-
-            prof.dump_stats("profile.log")
-            bb.utils.process_profilelog("profile.log")
-            serverlog("Raw profiling information saved to profile.log and processed statistics to profile.log.processed")
-
-        else:
-            ret = self.main()
-
-        return ret
+        return bb.utils.profle_function(self.cooker.configuration.profile, self.main, "profile.log")
 
     def _idle_check(self):
         return len(self._idlefuns) == 0 and self.cooker.command.currentAsyncCommand is None
@@ -417,20 +401,7 @@ class ProcessServer():
                 serverlog("".join(msg))
 
     def idle_thread(self):
-        if self.cooker.configuration.profile:
-            try:
-                import cProfile as profile
-            except:
-                import profile
-            prof = profile.Profile()
-
-            ret = profile.Profile.runcall(prof, self.idle_thread_internal)
-
-            prof.dump_stats("profile-mainloop.log")
-            bb.utils.process_profilelog("profile-mainloop.log")
-            serverlog("Raw profiling information saved to profile-mainloop.log and processed statistics to profile-mainloop.log.processed")
-        else:
-            self.idle_thread_internal()
+        bb.utils.profle_function(self.cooker.configuration.profile, self.idle_thread_internal, "profile-idleloop.log")
 
     def idle_thread_internal(self):
         def remove_idle_func(function):
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 1cc74ed5466..0289862c5dd 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1418,6 +1418,34 @@ def cpu_count():
 def nonblockingfd(fd):
     fcntl.fcntl(fd, fcntl.F_SETFL, fcntl.fcntl(fd, fcntl.F_GETFL) | os.O_NONBLOCK)
 
+def profle_function(profile, function, output_fn, process=True):
+    """Common function to profile a code block and optionally process the
+    output using or processing function.
+
+    Arguments:
+
+    -  ``profile``: a boolean saying whether to enable profiling or not
+    -  ``function``: the function call to profile/run
+    -  ``outputfn``: where to write the profiling data
+    -  ``process``: whether to process the profiling data and write a report
+
+    Returns the wrapped function return value
+    """
+    if profile:
+        try:
+            import cProfile as profile
+        except:
+             import profile
+        prof = profile.Profile()
+        ret = profile.Profile.runcall(prof, function)
+        prof.dump_stats(output_fn)
+        if process:
+            process_profilelog(output_fn)
+            serverlog("Raw profiling information saved to %s and processed statistics to %s.processed" % (output_fn, output_fn))
+        return ret
+    else:
+        return function()
+
 def process_profilelog(fn, pout = None):
     # Either call with a list of filenames and set pout or a filename and optionally pout.
     if not pout:

