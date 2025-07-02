Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E314BC8303C
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 22:24:41 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web10.9229.1751495081247191925
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Jul 2025 15:24:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Az33LZ1+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a531fcaa05so3041078f8f.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 02 Jul 2025 15:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751495079; x=1752099879; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EO2wNueXKQRMafYsFqeqrWz5O5De4BpGh2yNNVHZdgs=;
        b=Az33LZ1+3WnPqluQpNowaQu9S6WmJvpXmuSoBgY+WteCyXA4z8xIb3WEwDWCT0ABp2
         UpPLgP61IFqG8ytT4VYVF0RQfbHLpOAbKz6rpgH+oUwj36iZ7EkFaX4xLJWnkv7nwvq7
         EwO9MKPRJZT9N+CdUqHc5jxaiGzGvr5CKDSdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751495079; x=1752099879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EO2wNueXKQRMafYsFqeqrWz5O5De4BpGh2yNNVHZdgs=;
        b=WpmWwr1iqUADKUoMQaeK4BZX+62xBVROB8Jz3Ewohufz4itjWDF04n+V6R7Y2tPfQI
         FCGVxooWV7diVxcTpSnuHRp5b1xx5jghRL4JUmYol5II5KJDVumCarOtGJyocOscZhXn
         grFX0cqVn9+Mj2SVpp39D7rkqJBzEHGsHWqzCMniovk0XmCCoDwystCnpMrfgmmJcgU/
         0yPx/EkX7/YsbO5ePVsW5Uwkb5TW2jYmb8L1h5J1AUBcE9eoSGm5OF2RrzpBxgfF66XH
         mjizHrfFpJX8SZFYnKO5dnykJMugJohBc5ge0K0qcEtxaw2po5K5gcFeqqKGW9vqE/Ql
         lMQA==
X-Gm-Message-State: AOJu0YzP3aduYYi4EMiQcQ1yM5VTNfGzZdKijcoqyMfAZyvM7hM7tU5v
	yOpQrBv8AzZM8V9rvhoHSc6Hf4dC1kuPIuozQ4d2E2iQQyCdJtzIaUTmkDMWnV1IM+WTiTD9vQg
	W+OIw
X-Gm-Gg: ASbGncs4f23ytHv1SXNWiEVq8q4xZy/qxAnnSOro6d7rAWMSJACyc3QLFYnSHCxAfzX
	nH4lK03ShY3zQXQfFOOa5fwEKiX10xuj+ZAveYsj7vZlIAS5xLlIu8IPaYIcFADyWCbOsqfYyzi
	tq16Mcioa8UCREP0MzIR3odhq17e17Ng8cpCeV3YXZmi+ZXtwD/tdFtORUWAQIZGtU1VWBlUTpV
	zFodWTSV8dkQIDg8xMiseonIN17OJo35HTvNEkLc1eR5mLlgWZZkRC/1LraOqdIobIkTlcEuqGP
	sqDT0LBonx78aXgHDMWnIrmLyx+tzAe2kX3SvIOzZ0BfY4luwb3k+GQwe/LwYQVh6k3L5uyjCdL
	0eseYDLArjvwV33Q=
X-Google-Smtp-Source: AGHT+IGnxUp4PO0dbeDNI7EDw4gWwgCzDGoRYErfJPv/4RzxOLtSe8/mQLhtQmmNg+8D6EBt4EmkxA==
X-Received: by 2002:a5d:5f42:0:b0:3a4:f6b7:8b07 with SMTP id ffacd0b85a97d-3b32e61729fmr609155f8f.48.1751495078880;
        Wed, 02 Jul 2025 15:24:38 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:acf3:9ed8:45ec:fd86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a892e61fa4sm17102775f8f.97.2025.07.02.15.24.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 15:24:38 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] cooker: Try and avoid parseing hangs
Date: Wed,  2 Jul 2025 23:24:36 +0100
Message-ID: <20250702222437.3733042-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Jul 2025 22:24:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17737

We sometimes see hangs in parsing during automated testing. It appears that
SIGINT was sent to the underlying processes which see KeyboardInterrupt but
they're stuck trying to write into the results pipe. The SIGINT was probably
from some kind of parsing failure which doens't happen often, hence the hang
being rare (in the incompatible license selftests from OE).

This patch:
  * sets a flag to indicate exit upon SIGINT so the exit is more graceful
    and a defined exit path
  * empties the results queue after we send the quit event
  * empties the results queue after the SIGINT for good measure
  * increases the 0.5s timeout to 2s since we now have some very slow to
    parse recipes due to class extensions (ptests)

This should hopefully make the parsing failure codepaths more robust.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1810bcc6049..91e3ee025ea 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2009,6 +2009,7 @@ class Parser(multiprocessing.Process):
         self.queue_signals = False
         self.signal_received = []
         self.signal_threadlock = threading.Lock()
+        self.exit = False
 
     def catch_sig(self, signum, frame):
         if self.queue_signals:
@@ -2021,7 +2022,7 @@ class Parser(multiprocessing.Process):
             signal.signal(signal.SIGTERM, signal.SIG_DFL)
             os.kill(os.getpid(), signal.SIGTERM)
         elif signum == signal.SIGINT:
-            signal.default_int_handler(signum, frame)
+            self.exit = True
 
     def run(self):
 
@@ -2059,7 +2060,7 @@ class Parser(multiprocessing.Process):
         pending = []
         havejobs = True
         try:
-            while havejobs or pending:
+            while (havejobs or pending) and not self.exit:
                 if self.quit.is_set():
                     break
 
@@ -2196,11 +2197,12 @@ class CookerParser(object):
 
         # Cleanup the queue before call process.join(), otherwise there might be
         # deadlocks.
-        while True:
-            try:
-               self.result_queue.get(timeout=0.25)
-            except queue.Empty:
-                break
+        def read_results():
+            while True:
+                try:
+                   self.result_queue.get(timeout=0.25)
+                except queue.Empty:
+                    break
 
         def sync_caches():
             for c in self.bb_caches.values():
@@ -2212,15 +2214,19 @@ class CookerParser(object):
 
         self.parser_quit.set()
 
+        read_results()
+
         for process in self.processes:
-            process.join(0.5)
+            process.join(2)
 
         for process in self.processes:
             if process.exitcode is None:
                 os.kill(process.pid, signal.SIGINT)
 
+        read_results()
+
         for process in self.processes:
-            process.join(0.5)
+            process.join(2)
 
         for process in self.processes:
             if process.exitcode is None:

