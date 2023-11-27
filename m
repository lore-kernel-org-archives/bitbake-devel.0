Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4A3C4167B
	for <webhook@archiver.kernel.org>; Mon, 27 Nov 2023 14:06:49 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.95455.1701094002872239571
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Nov 2023 06:06:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=CtawZ6tz;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40a4848c6e1so29682895e9.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Nov 2023 06:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1701094001; x=1701698801; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VWRvUOk01iLYur1yb6ilmDkF8Bx1MpU5U7w5BVGEfks=;
        b=CtawZ6tzao/UhzObh5xogTNK5GRS9+Blc4sKv5yHMmKCn43mcfuZgjZTaCKVk9zYo0
         2ijIwbVkMU34Zrz0oEMSXDaVWTKHhfQ8uIW/6LjVpX21OhFsRdDQiRUKScsAqqo4YfPZ
         JQqL7u4e/r0bSFKXV/wnZ2DApiJVtImF2pdRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701094001; x=1701698801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWRvUOk01iLYur1yb6ilmDkF8Bx1MpU5U7w5BVGEfks=;
        b=IS8z+/iCW34aUXGsXdk5odi208EGHGIloupp/xx950YQyieQQSlV6x86YBzGzZN4yy
         M7kE5yeDJBPIVn2kwP5ZL2UqJXZxsFADNWng958BhwbnsHYanwu6M+QrjsDX8oXTuATG
         0803BypUEa19yHTUm57+NSnU7sv33c664KbROoTriwA2muJ1NWDFdxGg9ZxPXT0zaPQn
         b2YtD+ZDg1fUVhzV9xCB1YyeWINWjRv7t43lSiVbr8UM8b3HW8p4vnby1H1A+q78bjbr
         CyYhlNUxMJU33Cou2SV+CIM8PoY/j7WXtfSZqW/12yOXrW9DdrRrxWJeoHORToM4b7vU
         jRbw==
X-Gm-Message-State: AOJu0YzqzM0jxeV2jKAkvyzWpIRnPAJcD7yRDzBHhgxPocAQGrstNvFb
	H+14dB0XLRP050F/6aHvEr7ddscCobwaUhNE1YI=
X-Google-Smtp-Source: AGHT+IHc+z8gKb6zIAckPpwozDlMg/nyUwG55C8a4enA1yXm2X9q80A0AK40FbeO58o/k/SD/u2EIA==
X-Received: by 2002:a05:600c:4749:b0:401:73b2:f043 with SMTP id w9-20020a05600c474900b0040173b2f043mr8152236wmo.1.1701093999927;
        Mon, 27 Nov 2023 06:06:39 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:430c:b470:8466:3e0])
        by smtp.gmail.com with ESMTPSA id h4-20020a05600c350400b003fee567235bsm14845081wmq.1.2023.11.27.06.06.39
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 06:06:39 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH v2] cooker: Avoid variable listing lockups
Date: Mon, 27 Nov 2023 14:06:38 +0000
Message-Id: <20231127140638.4171054-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Nov 2023 14:06:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15574

If the event log is enabled and parsing the metadata triggers log messages,
the event code and deadlock. Iterating the variables inside the event handling
code causes this. SOURCE_DATE_EPOCH triggers a python function which calls
bb.debug() and can trigger a lockup as one example.

Move the code around and add it to the BuildStarted events explictly. This
does mean runs without builds no longer get variables added to the eventlog
however we can look into a more targetted version of data if/as/where neded.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

v2 - add missing part of the commit

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index d658db9bd8..c5bfef55d6 100644
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
@@ -416,6 +397,7 @@ class BBCooker:
     def setupEventLog(self, eventlog):
         if self.eventlog and self.eventlog[0] != eventlog:
             bb.event.unregister_UIHhandler(self.eventlog[1])
+            self.eventlog = None
         if not self.eventlog or self.eventlog[0] != eventlog:
             # we log all events to a file if so directed
             # register the log file writer as UI Handler
@@ -423,7 +405,7 @@ class BBCooker:
                 bb.utils.mkdirhier(os.path.dirname(eventlog))
             writer = EventWriter(self, eventlog)
             EventLogWriteHandler = namedtuple('EventLogWriteHandler', ['event'])
-            self.eventlog = (eventlog, bb.event.register_UIHhandler(EventLogWriteHandler(writer)))
+            self.eventlog = (eventlog, bb.event.register_UIHhandler(EventLogWriteHandler(writer)), writer)
 
     def updateConfigOpts(self, options, environment, cmdline):
         self.ui_cmdline = cmdline
@@ -1404,6 +1386,8 @@ class BBCooker:
         buildname = self.databuilder.mcdata[mc].getVar("BUILDNAME")
         if fireevents:
             bb.event.fire(bb.event.BuildStarted(buildname, [item]), self.databuilder.mcdata[mc])
+            if self.eventlog:
+                self.eventlog[2].write_variables()
             bb.event.enable_heartbeat()
 
         # Execute the runqueue
@@ -1547,6 +1531,8 @@ class BBCooker:
 
         for mc in self.multiconfigs:
             bb.event.fire(bb.event.BuildStarted(buildname, ntargets), self.databuilder.mcdata[mc])
+        if self.eventlog:
+            self.eventlog[2].write_variables()
         bb.event.enable_heartbeat()
 
         rq = bb.runqueue.RunQueue(self, self.data, self.recipecaches, taskdata, runlist)
-- 
2.39.2


