Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
 by mx.groups.io with SMTP id smtpd.web12.12646.1612647478302571798
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Feb 2021 13:37:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=X5u6N6wi;
 spf=pass (domain: gmail.com, ip: 209.85.208.179, mailfrom: tomasz.dziendzielski@gmail.com)
Received: by mail-lj1-f179.google.com with SMTP id r23so9994438ljh.1
        for <bitbake-devel@lists.openembedded.org>; Sat, 06 Feb 2021 13:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tt6f98qEdU39GMUJRQASaq71MfeSm1rMaCa5vj7LfWU=;
        b=X5u6N6wisU1JD/C03FK1jFg8bUBWPHG/iG0KDiLjDighs40VBsELFPEQXxZhcjeQoB
         0g7j45TbZen0iku0I975kaiE/TXjuNVV6OdHgRRRPRrIGtIXnIGsXJx6h0lnwph0qdKc
         tr3D+Z0xh/UzVySnB0MjvG9VDAvgzYqKgMclou6Iw3k7zxRlK6/csDX1xvKF2WcbRsN5
         Ycn/Z9mNmLKr5YHJ6L3gjxBq/CIuFVgixtgqKNAkEyfUl+fur0vGI8hQtjdxKJd+e3P4
         jc7StfKsP6CtdTiRn9qrlcTc83UV7aqX6YmQYmHV+IBsWz9WhJ2qUragEGgNZ3xRC3Sf
         vqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tt6f98qEdU39GMUJRQASaq71MfeSm1rMaCa5vj7LfWU=;
        b=IC1pOsZb4yIifFWuNodGTCG1yzOSyj6tUdB9rXw+MGqynmyOK27ypOFZkPqOEudK1C
         /wPMfGxkUX2FcCYzKIBQlkqdLE+J4AQrd4JNFli9XjkrS+4k9MBiw6yrIyVitZr+2ROG
         tx2Efhy+q8kSLa+XA3KZ2VGZKkU+deD8CmuYXxtkXwmmVmqQ514mK6y91OZCbNrQ/2/d
         bkf6/wOgu7im7ZKvzhzlRTERBbtd2tlWlPYYOh1xIlLoAJR/t9FJErodn35nA1cRIqE6
         uelFehUu+p1QEeSuxYq6bY6szGnQvi6imCicRRAjOeDi0ROYFwNfVL2spJEy4LZme+Rh
         G7Ow==
X-Gm-Message-State: AOAM533r7PF4s0ppP/gDW1cX0wekF92fZI72F7jaSTYwMtGs1mVV5iEW
	GDPBGvZo/fJqpYXgrStBFt7IYOpju30=
X-Google-Smtp-Source: ABdhPJyw9IPsJF05+tBrlZ3IBhT6C2nbkPZ8zeaiAth5iSjQGsfrO23SM/6IAj82SP4sbJttZrvM/A==
X-Received: by 2002:a2e:80da:: with SMTP id r26mr6532942ljg.78.1612647474449;
        Sat, 06 Feb 2021 13:37:54 -0800 (PST)
Return-Path: <tomasz.dziendzielski@gmail.com>
Received: from localhost.localdomain (h124200.man.tk-internet.pl. [93.175.124.200])
        by smtp.gmail.com with ESMTPSA id f6sm1444791lfc.96.2021.02.06.13.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Feb 2021 13:37:53 -0800 (PST)
From: "Tomasz Dziendzielski" <tomasz.dziendzielski@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>
Subject: [PATCH v3] event: Prevent bitbake from executing event handler for wrong multiconfig target
Date: Sat,  6 Feb 2021 22:40:34 +0100
Message-Id: <20210206214034.295239-1-tomasz.dziendzielski@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When multiconfig is used bitbake might try to run events that don't
exist for specific mc target. In cooker.py we pass
`self.databuilder.mcdata[mc]` data that contains names of events'
handlers per mc target, but fire_class_handlers uses global _handlers
variable that is created during parsing of all the targets.

This leads to a problem where bitbake runs event handler that don't
exist for a target or even overrides them - if multiple targets use
event handler with the same name but different code then only one
version will be executed for all targets.

See [YOCTO #13071] for detailed bug information.

Add mc target name as a prefix to event handler name so there
won't be two different handlers with the same name.

Signed-off-by: Tomasz Dziendzielski <tomasz.dziendzielski@gmail.com>

--- v2 compared to previous patch I added mc prefix before putting to __BBHANDLERS, so hashes are not changed during the build and oe-selftest paseses
--- v3 fix for test_stoptask_behavior, _bb_diskmonitor handler is an exception that is not created during parsing and was not added to __BBHANDLERS where I check if a handler should be executed. In this change I add it manually, so it is detected and executed
---
 lib/bb/cookerdata.py | 5 ++++-
 lib/bb/event.py      | 2 ++
 lib/bb/parse/ast.py  | 7 ++++++-
 lib/bb/runqueue.py   | 3 +++
 4 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index c39b5681..02995c8f 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -424,12 +424,15 @@ class CookerDataBuilder(object):
         # Nomally we only register event handlers at the end of parsing .bb files
         # We register any handlers we've found so far here...
         for var in data.getVar('__BBHANDLERS', False) or []:
+            nvar=var
+            if mc:
+                var = nvar[len(mc):]
             handlerfn = data.getVarFlag(var, "filename", False)
             if not handlerfn:
                 parselog.critical("Undefined event handler function '%s'" % var)
                 raise bb.BBHandledException()
             handlerln = int(data.getVarFlag(var, "lineno", False))
-            bb.event.register(var, data.getVar(var, False),  (data.getVarFlag(var, "eventmask") or "").split(), handlerfn, handlerln)
+            bb.event.register(nvar, data.getVar(var, False),  (data.getVarFlag(var, "eventmask") or "").split(), handlerfn, handlerln)
 
         data.setVar('BBINCLUDED',bb.parse.get_file_depends(data))
 
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 694b4705..afef7dbe 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -118,6 +118,8 @@ def fire_class_handlers(event, d):
             if _eventfilter:
                 if not _eventfilter(name, handler, event, d):
                     continue
+            if d and name not in (d.getVar("__BBHANDLERS") or []):
+                    continue
             execute_handler(name, handler, event, d)
 
 ui_queue = []
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 0714296a..b38978d3 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -261,6 +261,8 @@ class BBHandlerNode(AstNode):
     def eval(self, data):
         bbhands = data.getVar('__BBHANDLERS', False) or []
         for h in self.hs:
+            if data.getVar('BB_CURRENT_MC', False):
+                h = data.getVar('BB_CURRENT_MC', False) + h
             bbhands.append(h)
             data.setVarFlag(h, "handler", 1)
         data.setVar('__BBHANDLERS', bbhands)
@@ -331,11 +333,14 @@ def finalize(fn, d, variant = None):
     try:
         for var in d.getVar('__BBHANDLERS', False) or []:
             # try to add the handler
+            nvar=var
+            if d.getVar('BB_CURRENT_MC', False):
+                var = nvar[len(d.getVar('BB_CURRENT_MC', False)):]
             handlerfn = d.getVarFlag(var, "filename", False)
             if not handlerfn:
                 bb.fatal("Undefined event handler function '%s'" % var)
             handlerln = int(d.getVarFlag(var, "lineno", False))
-            bb.event.register(var, d.getVar(var, False), (d.getVarFlag(var, "eventmask") or "").split(), handlerfn, handlerln)
+            bb.event.register(nvar, d.getVar(var, False), (d.getVarFlag(var, "eventmask") or "").split(), handlerfn, handlerln)
 
         bb.event.fire(bb.event.RecipePreFinalise(fn), d)
 
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 28bdadb4..848ae574 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1464,6 +1464,9 @@ class RunQueue:
             bb.event.fire(bb.event.DepTreeGenerated(depgraph), self.cooker.data)
 
             if not self.dm_event_handler_registered:
+                 bbhands = self.cfgData.getVar('__BBHANDLERS', False) or []
+                 bbhands.append(self.dm_event_handler_name)
+                 self.cfgData.setVar('__BBHANDLERS', bbhands)
                  res = bb.event.register(self.dm_event_handler_name,
                                          lambda x: self.dm.check(self) if self.state in [runQueueRunning, runQueueCleanUp] else False,
                                          ('bb.event.HeartbeatEvent',))
-- 
2.30.0

