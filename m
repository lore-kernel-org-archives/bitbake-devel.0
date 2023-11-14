Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F49FC4167D
	for <webhook@archiver.kernel.org>; Tue, 14 Nov 2023 23:34:55 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.809.1700004892973973421
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Nov 2023 15:34:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Mo0uvND2;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-32d849cc152so4251484f8f.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 14 Nov 2023 15:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1700004891; x=1700609691; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrDDHmbx/TQl1ZR9zskYMPhmAVnLwNXB1qyb5nOvz+A=;
        b=Mo0uvND25JHcRpGgLFa4h/1KlUDl5Z4xlaRfy9QMQYgvwGmLelx/q5W0UVjkLuPxWF
         5G8SCVQY4BpDQRXs5xCt/qm6e5hzwJc13Gx61gUQE0wJbNh4hT2izFRmV/IP/2xGSByP
         GsKDxF9VR1RGcAp94I2yai48xZKifihasVeJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700004891; x=1700609691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OrDDHmbx/TQl1ZR9zskYMPhmAVnLwNXB1qyb5nOvz+A=;
        b=APhpxzkDNjHg+pGa/SKefESNXexBmYhyzv0cFjgww4ksRr2zvAuTFp1xBJPQWaHouQ
         Mq2uesIFH7DNd/pzEhKQ1eHThskYfUmNR6hh0FJYzS4+wqBh/joVYJZvTmIjUKMpvvvp
         GFVxtj6/furNVpgHVGLD2S3PcjMzQbbupVuju6nCqLgC5fTi55xHssYY0XqeMURq4+Xi
         K/LIcM1NjnAkERpcIfWUcNOIgpXPWzCCUMN5XDUGW4tV8M7Qv8XoMfiQYJ2v7xARg0wF
         JoXi54C6kyzrIyRf2TIEU3MUL4KinYHSL3vGyTlATgEHoIEKm/Fpf5SAHirBkrMo6H0I
         rX9w==
X-Gm-Message-State: AOJu0YwLLhcYaxmj7dhvc/7uNAHFfXz/scs3vn9hslcYzTo4ABaYsP6/
	vVUvQmGgjH2jWkU8JAmT3UJf5wTngbps+CBApbM=
X-Google-Smtp-Source: AGHT+IEhaS2/Y0oku2j2mlJqyt07x2+k6rllg+XD5iiPtI0TNo5gsXi1eYWgNcPZL8uuP5Po2oLk3w==
X-Received: by 2002:a05:6000:1108:b0:32d:9a36:b518 with SMTP id z8-20020a056000110800b0032d9a36b518mr8447601wrw.69.1700004891130;
        Tue, 14 Nov 2023 15:34:51 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:bbf9:c35a:2291:eb7c])
        by smtp.gmail.com with ESMTPSA id f15-20020a5d50cf000000b0032f78feb826sm8930203wrt.104.2023.11.14.15.34.50
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 15:34:50 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/3] runqueue: Refactor StaleSetSceneTasks event out of build_scenequeue_data
Date: Tue, 14 Nov 2023 23:34:48 +0000
Message-Id: <20231114233449.2567899-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231114233449.2567899-1-richard.purdie@linuxfoundation.org>
References: <20231114233449.2567899-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 14 Nov 2023 23:34:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15527

The event at the end of the function doesn't really belong there,
move it out so the function becomes cleaner. It also avoids having
to pass a number of parameters around, another sign this is the correct
thing to do. This continues refactoring started a while ago to improve
and modularise the code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 2a8b89b264..02d7ff9768 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1874,7 +1874,23 @@ class RunQueueExecute:
 
         #if self.rqdata.runq_setscene_tids:
         self.sqdata = SQData()
-        build_scenequeue_data(self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self)
+        build_scenequeue_data(self.sqdata, self.rqdata, self)
+
+        update_scenequeue_data(self.sqdata.sq_revdeps, self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self, summary=True)
+
+        # Compute a list of 'stale' sstate tasks where the current hash does not match the one
+        # in any stamp files. Pass the list out to metadata as an event.
+        found = {}
+        for tid in self.rqdata.runq_setscene_tids:
+            (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+            stamps = bb.build.find_stale_stamps(taskname, taskfn)
+            if stamps:
+                if mc not in found:
+                    found[mc] = {}
+                found[mc][tid] = stamps
+        for mc in found:
+            event = bb.event.StaleSetSceneTasks(found[mc])
+            bb.event.fire(event, self.cooker.databuilder.mcdata[mc])
 
     def runqueue_process_waitpid(self, task, status, fakerootlog=None):
 
@@ -2773,7 +2789,7 @@ class SQData(object):
         # A list of normal tasks a setscene task covers
         self.sq_covered_tasks = {}
 
-def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
+def build_scenequeue_data(sqdata, rqdata, sqrq):
 
     sq_revdeps = {}
     sq_revdeps_squash = {}
@@ -2962,22 +2978,6 @@ def build_scenequeue_data(sqdata, rqdata, rq, cooker, stampcache, sqrq):
                 sqrq.sq_deferred[tid] = sqdata.hashes[h]
                 bb.debug(1, "Deferring %s after %s" % (tid, sqdata.hashes[h]))
 
-    update_scenequeue_data(sqdata.sq_revdeps, sqdata, rqdata, rq, cooker, stampcache, sqrq, summary=True)
-
-    # Compute a list of 'stale' sstate tasks where the current hash does not match the one
-    # in any stamp files. Pass the list out to metadata as an event.
-    found = {}
-    for tid in rqdata.runq_setscene_tids:
-        (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
-        stamps = bb.build.find_stale_stamps(taskname, taskfn)
-        if stamps:
-            if mc not in found:
-                found[mc] = {}
-            found[mc][tid] = stamps
-    for mc in found:
-        event = bb.event.StaleSetSceneTasks(found[mc])
-        bb.event.fire(event, cooker.databuilder.mcdata[mc])
-
 def check_setscene_stamps(tid, rqdata, rq, stampcache, noexecstamp=False):
 
     (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
-- 
2.39.2


