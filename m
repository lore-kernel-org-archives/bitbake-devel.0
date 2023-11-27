Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A98CC4167B
	for <webhook@archiver.kernel.org>; Mon, 27 Nov 2023 13:40:39 +0000 (UTC)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
 by mx.groups.io with SMTP id smtpd.web11.94685.1701092438381269874
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Nov 2023 05:40:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Fe/sOdoW;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.174, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2c5071165d5so9484881fa.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Nov 2023 05:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701092436; x=1701697236; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=82/nfC20ZJmKgGUjgIO2Ce6Dc+iPRwN0jY6AEpNcjqY=;
        b=Fe/sOdoWe4FWFag/i8XMt5qWeWC2AmPaTVR25BZ1LIv+PCV/mHz0td1Ebgxie7dk/Q
         eIZJOO366O7CaQNST/VcV6W40/ecVsoaweqlPD6GQCB7Wkfw1gh5ad5QiVh1kPlCuSPG
         hiDr4+OGLNp7yjkn9mkqZitHp+kxUTzopMIPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701092436; x=1701697236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=82/nfC20ZJmKgGUjgIO2Ce6Dc+iPRwN0jY6AEpNcjqY=;
        b=mlBCsHscCIUqf0TGywOvMRzunzOZa3qM9fneAWfk+G1jkvQtDshMoudDEXp/bsfhw3
         zE54g6p6fVXckW2nK0jWobPlOM8LlqEX7h+pmwy1eN+X0mhZlWOFfFT68T+0oV0s3uI+
         vfS0rLj/uHGAeTLf26pzCOP0nEkuL5Fo6DQJThQXjetx24M84CUpVElFB4aftUkhpGDR
         Y051KyNtfehQGXp8B9eRGF25Df8RrCOIgH+tFt7va0B80mG3j0RzeCirtALs5KXbK4mi
         tljOpfg2aWqgOnpXKM5aA9AAYlyco268HJz8YT0fHYZoGE9blAMwBUlWHFrCUo77Tf/z
         Q3Jw==
X-Gm-Message-State: AOJu0Yzc6ARMKdxtAyi30EZiQiTrrJF3CUuuytSc9OOkBm/EjIOzTlKX
	2o3m4vL+3I/Eg8eMm/nyTF0uHXI+SJdcZA/mljA=
X-Google-Smtp-Source: AGHT+IHM5e+CIgpuS+mYk3WGMIPTUik4F/wy01wu/GptE3WIx/aWG/szQynu1KhlcuZNJm1pzOuPLQ==
X-Received: by 2002:a2e:8287:0:b0:2c5:1f5f:ed96 with SMTP id y7-20020a2e8287000000b002c51f5fed96mr7402855ljg.3.1701092435857;
        Mon, 27 Nov 2023 05:40:35 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:430c:b470:8466:3e0])
        by smtp.gmail.com with ESMTPSA id l6-20020a05600c4f0600b0040b3632e993sm14030780wmq.46.2023.11.27.05.40.35
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 05:40:35 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: Avoid variable listing lockups
Date: Mon, 27 Nov 2023 13:40:34 +0000
Message-Id: <20231127134034.4165783-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Nov 2023 13:40:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15572

If the event log is enabled and parsing the metadata triggers log messages,
the event code and deadlock. Iterating the variables inside the event handling
code causes this. SOURCE_DATE_EPOCH triggers a python function which calls
bb.debug() and can trigger a lockup as one example.

Move the code around and add it to the BuildStarted events explictly. This
does mean runs without builds no longer get variables added to the eventlog
however we can look into a more targetted version of data if/as/where neded.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index d658db9bd8..ab68c16594 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -102,12 +102,15 @@ class CookerFeatures(object):
 
 class EventWriter:
     def __init__(self, cooker, eventfile):
-        self.file_inited = None
         self.cooker = cooker
         self.eventfile = eventfile
         self.event_queue = []
 
-    def write_event(self, event):
+    def write_variables(self):
+        with open(self.eventfile, "a") as f:
+            f.write("%s\n" % json.dumps({ "allvariables" : self.cooker.getAllKeysWithFlags(["doc", "func"])}))
+
+    def send(self, event):
         with open(self.eventfile, "a") as f:
             try:
                 str_event = codecs.encode(pickle.dumps(event), 'base64').decode('utf-8')
@@ -117,28 +120,6 @@ class EventWriter:
                 import traceback
                 print(err, traceback.format_exc())
 
-    def send(self, event):
-        if self.file_inited:
-            # we have the file, just write the event
-            self.write_event(event)
-        else:
-            # init on bb.event.BuildStarted
-            name = "%s.%s" % (event.__module__, event.__class__.__name__)
-            if name in ("bb.event.BuildStarted", "bb.cooker.CookerExit"):
-                with open(self.eventfile, "w") as f:
-                    f.write("%s\n" % json.dumps({ "allvariables" : self.cooker.getAllKeysWithFlags(["doc", "func"])}))
-
-                self.file_inited = True
-
-                # write pending events
-                for evt in self.event_queue:
-                    self.write_event(evt)
-
-                # also write the current event
-                self.write_event(event)
-            else:
-                # queue all events until the file is inited
-                self.event_queue.append(event)
 
 #============================================================================#
 # BBCooker
@@ -1404,6 +1385,8 @@ class BBCooker:
         buildname = self.databuilder.mcdata[mc].getVar("BUILDNAME")
         if fireevents:
             bb.event.fire(bb.event.BuildStarted(buildname, [item]), self.databuilder.mcdata[mc])
+            if self.eventlog:
+                self.eventlog[2].write_variables()
             bb.event.enable_heartbeat()
 
         # Execute the runqueue
@@ -1547,6 +1530,8 @@ class BBCooker:
 
         for mc in self.multiconfigs:
             bb.event.fire(bb.event.BuildStarted(buildname, ntargets), self.databuilder.mcdata[mc])
+        if self.eventlog:
+            self.eventlog[2].write_variables()
         bb.event.enable_heartbeat()
 
         rq = bb.runqueue.RunQueue(self, self.data, self.recipecaches, taskdata, runlist)
-- 
2.39.2


