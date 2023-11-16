Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752DCC197A0
	for <webhook@archiver.kernel.org>; Thu, 16 Nov 2023 16:52:39 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
 by mx.groups.io with SMTP id smtpd.web11.11776.1700153556954875931
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Nov 2023 08:52:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=W/q0zfWH;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.54, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-32dcd3e5f3fso737713f8f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Nov 2023 08:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1700153555; x=1700758355; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/9rFzahN87ekWlMG/8Z2Tw88zsDy4cxP6900Fxjxplg=;
        b=W/q0zfWHYQ3GnUx9GtOdLmHls7HH5fY3xqeLvf23AQTZ6i2AI60RbEzFArYftPF+N+
         wNjyi06/PnVoB0l1QnZ/lj0Wum4wza0N65XCkdf/ueLRHEuEWiUgYZnqAYUE3U+T+4En
         9jx0PrXoYuYaMfsNQf3VmeeAq/CwVTJlNhBYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700153555; x=1700758355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/9rFzahN87ekWlMG/8Z2Tw88zsDy4cxP6900Fxjxplg=;
        b=LfWHBGryZnnXakUq85OKIy4zY6RIXKAz3cSZRDLnw1m2RgpgSm/vcKCNnECRMnlXb8
         IsfY6t8RzRyZtbbX6aHIZgckuSxWIMEq+0V55bZ0/40xSnIUktiF/FzT+y6WukonNHwy
         n/yyhL7Jkvf2rIIKirAqYaRQBNgkYzwdfrp3tqGxQwYMmoemApqLihSdqrsgwaSv3q/4
         yY8551C930y4kkYGUIV5czlZbG102cV8BP+2t1T0AeckNQr8D/JkWtJDR+zLlW5tKUd0
         eax1qWvGgPWmJgE4gImkGCB/iOoyQS/nsEv+dxzBsMCDfObQsXKLnReLfoZ20mCxMlp+
         ibug==
X-Gm-Message-State: AOJu0YxevUTAaVda1Nan0uhX+8y+SQfk9yn1GszO2pGA1NNEOMpvFgDS
	3+fP4+jTmge5RiYDz5c2Bcjop8l+f280DSflHJg=
X-Google-Smtp-Source: AGHT+IF9A2nI0uhjEiWGO1KqH9Wn7tAWzDQGCPB6tSQmXq3ZcsYNwPtmVYXo6k2mBanUDsvJff0TUg==
X-Received: by 2002:a5d:54c1:0:b0:32d:90f7:ce50 with SMTP id x1-20020a5d54c1000000b0032d90f7ce50mr11706675wrv.17.1700153554595;
        Thu, 16 Nov 2023 08:52:34 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:f8ae:b070:36e4:3937])
        by smtp.gmail.com with ESMTPSA id w3-20020a5d4b43000000b0032cc35c2ef7sm14108092wrs.29.2023.11.16.08.52.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 08:52:34 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: Add support for BB_DEFAULT_EVENTLOG
Date: Thu, 16 Nov 2023 16:52:33 +0000
Message-Id: <20231116165233.2862786-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Nov 2023 16:52:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15531

Currently it is only possible to specify an eventlog on the bitbake
commandline. Add a variable that can be used in bitbake.conf so that
we can log data by default more easily.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 4bf1809bc0..9f84030962 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -303,6 +303,10 @@ class BBCooker:
         self.data_hash = self.databuilder.data_hash
         self.extraconfigdata = {}
 
+        eventlog = self.data.getVar("BB_DEFAULT_EVENTLOG")
+        if not self.configuration.writeeventlog and eventlog:
+            self.setupEventLog(eventlog)
+
         if consolelog:
             self.data.setVar("BB_CONSOLELOG", consolelog)
 
@@ -409,6 +413,18 @@ class BBCooker:
 
         self._parsecache_set(False)
 
+    def setupEventLog(self, eventlog):
+        if self.eventlog and self.eventlog[0] != eventlog:
+            bb.event.unregister_UIHhandler(self.eventlog[1])
+        if not self.eventlog or self.eventlog[0] != eventlog:
+            # we log all events to a file if so directed
+            # register the log file writer as UI Handler
+            if not os.path.exists(os.path.dirname(eventlog)):
+                bb.utils.mkdirhier(os.path.dirname(eventlog))
+            writer = EventWriter(self, eventlog)
+            EventLogWriteHandler = namedtuple('EventLogWriteHandler', ['event'])
+            self.eventlog = (eventlog, bb.event.register_UIHhandler(EventLogWriteHandler(writer)))
+
     def updateConfigOpts(self, options, environment, cmdline):
         self.ui_cmdline = cmdline
         clean = True
@@ -428,14 +444,7 @@ class BBCooker:
                 setattr(self.configuration, o, options[o])
 
         if self.configuration.writeeventlog:
-            if self.eventlog and self.eventlog[0] != self.configuration.writeeventlog:
-                bb.event.unregister_UIHhandler(self.eventlog[1])
-            if not self.eventlog or self.eventlog[0] != self.configuration.writeeventlog:
-                # we log all events to a file if so directed
-                # register the log file writer as UI Handler
-                writer = EventWriter(self, self.configuration.writeeventlog)
-                EventLogWriteHandler = namedtuple('EventLogWriteHandler', ['event'])
-                self.eventlog = (self.configuration.writeeventlog, bb.event.register_UIHhandler(EventLogWriteHandler(writer)))
+            self.setupEventLog(self.configuration.writeeventlog)
 
         bb.msg.loggerDefaultLogLevel = self.configuration.default_loglevel
         bb.msg.loggerDefaultDomains = self.configuration.debug_domains
-- 
2.39.2


