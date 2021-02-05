Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
 by mx.groups.io with SMTP id smtpd.web08.20.1612547962125059871
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Feb 2021 09:59:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cJGig30y;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f41.google.com with SMTP id d16so8589393wro.11
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Feb 2021 09:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=peQz3y3rU7ot7HOM64iWG5PySfZlY5NIFJJYe0u7WaU=;
        b=cJGig30y/bnWG79lbJ18xUPewgrLt3gEAlXiAwRSgq6FMy28vPgoSnO+JWk7bwi3IQ
         EZOx7nAEIx085ii1WFuAE+qqtc3j5Lz/1enkDfKAah9z9n61HggDAZMuiS3e5u+yzRmN
         qXc5JE233/jqOuDK+VwBq/CqjcayjeT6wsDvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=peQz3y3rU7ot7HOM64iWG5PySfZlY5NIFJJYe0u7WaU=;
        b=TurkIzJNQX+O23iMwEIc7n6UZ6IY2AYcLHHfdPipe2sW+TlVB1a8XJC1GLNIOOcLwe
         XXE1K0EPASEff13j3AORJpHRxCit1va6YK25u0lz7u0l85tdagTkVjf2fmn2Q1+PPE30
         QTL02yjUcaYQ5fPeoR5ugFxtyFPouS7mGpG/+6sJDrWri/rO+GZ2ia0L0ikmXljAqlxe
         PwR4koHUl4VhdnxlTFCmsa+SE2Eelw0xPhDcThayOQ2R1fr6A8xJzfOYnn1gFPdCll/O
         EVDgSxobjmakRQc0z53zO7q4/5bcflJkJ9qymuLbO5pOL5YifE2kti0QbwRLLHFB5wLw
         U4sQ==
X-Gm-Message-State: AOAM533I2ZRNG9HOIYmsCg2kKwf29ASE5+MEifw0N8NKcnf69f09Bozv
	9+Z/jNlvRPH+KWa86obfulkyZOi3preq4g==
X-Google-Smtp-Source: ABdhPJzQKBiEH5C7fxCBq8bW6878yYAYwOn/zUK3kFfeCrTwmCqKnpeD0mQOd6az/FTId609Ldkgpg==
X-Received: by 2002:a5d:6342:: with SMTP id b2mr6277891wrw.255.1612547960393;
        Fri, 05 Feb 2021 09:59:20 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:d1b2:8778:591e:ef47])
        by smtp.gmail.com with ESMTPSA id b4sm12462270wrn.12.2021.02.05.09.59.19
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 09:59:19 -0800 (PST)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] bitbake-worker: Try and avoid potential short write events issues
Date: Fri,  5 Feb 2021 17:59:18 +0000
Message-Id: <20210205175918.1645223-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're seeing occasional issues where builds fail as events were written from the
worker children in the form <event>partial data<event>full event</event>.

This causes failures as bitbake server can't parse that and exits. This could
be due to short writes to the worker event pipe which we weren't checking. Check
this and loop accordingly. Also add some asserts to detect other potential causes.

Thanks to Joshua Watt for help in spotting the issue.

[YOCTO #14181]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bin/bitbake-worker | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 9334f11fb8..40da7a0c2b 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -118,7 +118,9 @@ def worker_child_fire(event, d):
     data = b"<event>" + pickle.dumps(event) + b"</event>"
     try:
         worker_pipe_lock.acquire()
-        worker_pipe.write(data)
+        while(len(data)):
+            written = worker_pipe.write(data)
+            data = data[written:]
         worker_pipe_lock.release()
     except IOError:
         sigterm_handler(None, None)
@@ -321,7 +323,9 @@ class runQueueWorkerPipe():
         end = len(self.queue)
         index = self.queue.find(b"</event>")
         while index != -1:
-            worker_fire_prepickled(self.queue[:index+8])
+            msg = self.queue[:index+8]
+            assert msg.startswith(b"<event>") and msg.count(b"<event>") == 1
+            worker_fire_prepickled(msg)
             self.queue = self.queue[index+8:]
             index = self.queue.find(b"</event>")
         return (end > start)
-- 
2.27.0

