Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web08.6164.1615470364774574070
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 Mar 2021 05:46:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=G16p1ae/;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id b18so1929122wrn.6
        for <bitbake-devel@lists.openembedded.org>; Thu, 11 Mar 2021 05:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s16Dszo+/i/OEYVTnMz/MaFKGA2ZruPUKLxgNyzpQAI=;
        b=G16p1ae/Zwt3+V+jK7dihYgp5pKn9QqcJG/WgI7kO4ZWLmL7GDViTn2BAGq1Oy8FLK
         fA/2g6kdwu60UI7BbfEnYrvp7ZSbvsRIdld5bZZtzUga6NMyy5/0oKHwKaMnjSp9EyMI
         Ri0Q3Tt3n4J8v+EPpIOpE9l1UwPMQI962aKc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s16Dszo+/i/OEYVTnMz/MaFKGA2ZruPUKLxgNyzpQAI=;
        b=K96w73h5cf2rScIxxFT3Zf0N8/BNvMPEapnCrjnDmf0eVvkzuwKnjnSVycHznFjG9p
         UTfJmrOEScQYD1ysALezZIyBkWDG+/u0Z3VBzshS0Tv2OtPWtxeD5uCM3kmFRuD4oRWU
         ozh7pRweHbaTtxJogv+bc+prhBof2aYfV6Y5daNeWWQD5EHig5JmJ6BbCNEh04L4F9gq
         jeu7IMDLh8vGhQV+xVfYJKKvfssV9i7KcpokNfwwd1/zlNTebe25tCxnTv1HDpcDgyAW
         17Hz/wE5BRvByuIV5DSab7RFPkI1Oo6SRoSqgTF+LJ7424TcHV5XNzbkWhifA5aWelZl
         ho9w==
X-Gm-Message-State: AOAM532H8GW6H2h6vIaWFMO+mzAk3MeYuQAyk6lKLZM8AcaDE2T6cb8d
	PNtyvR1vGGYceFNY8yfQ8xSGyxIBY1GV/g==
X-Google-Smtp-Source: ABdhPJw9gaZADnWhDcTvONfWy7gcztFGobdDPJFsBUjI9TAF3Wh36/4wZruQo2630/hF18DTe4kYKw==
X-Received: by 2002:a5d:58c9:: with SMTP id o9mr8848304wrf.181.1615470362678;
        Thu, 11 Mar 2021 05:46:02 -0800 (PST)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:79d1:e29:deac:3ff5])
        by smtp.gmail.com with ESMTPSA id g11sm3924796wrw.89.2021.03.11.05.46.02
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 05:46:02 -0800 (PST)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] event: Fix multiconfig event handler change performance regressions
Date: Thu, 11 Mar 2021 13:46:01 +0000
Message-Id: <20210311134601.2544696-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There were two issues in this code, firstly the code could stack duplicates
in the variable, secondly, calling "if data" caused the datastore to compute
len(data) which is comparitively expensive. Checking "if data is not None"
is much much faster/cheaper.

The issue was clear from "bitbake -p -P" output where the time in register()
showed large amounts of time in the __len__ function of the datastore.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/event.py | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 3e5718395b..22171a9ca5 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -118,7 +118,7 @@ def fire_class_handlers(event, d):
             if _eventfilter:
                 if not _eventfilter(name, handler, event, d):
                     continue
-            if d and not name in (d.getVar("__BBHANDLERS_MC") or []):
+            if d and not name in (d.getVar("__BBHANDLERS_MC") or set()):
                 continue
             execute_handler(name, handler, event, d)
 
@@ -232,15 +232,15 @@ noop = lambda _: None
 def register(name, handler, mask=None, filename=None, lineno=None, data=None):
     """Register an Event handler"""
 
-    if data and data.getVar("BB_CURRENT_MC"):
+    if data is not None and data.getVar("BB_CURRENT_MC"):
         mc = data.getVar("BB_CURRENT_MC")
         name = '%s%s' % (mc.replace('-', '_'), name)
 
     # already registered
     if name in _handlers:
-        if data:
-            bbhands_mc = (data.getVar("__BBHANDLERS_MC") or [])
-            bbhands_mc.append(name)
+        if data is not None:
+            bbhands_mc = (data.getVar("__BBHANDLERS_MC") or set())
+            bbhands_mc.add(name)
             data.setVar("__BBHANDLERS_MC", bbhands_mc)
         return AlreadyRegistered
 
@@ -278,16 +278,16 @@ def register(name, handler, mask=None, filename=None, lineno=None, data=None):
                     _event_handler_map[m] = {}
                 _event_handler_map[m][name] = True
 
-        if data:
-            bbhands_mc = (data.getVar("__BBHANDLERS_MC") or [])
-            bbhands_mc.append(name)
+        if data is not None:
+            bbhands_mc = (data.getVar("__BBHANDLERS_MC") or set())
+            bbhands_mc.add(name)
             data.setVar("__BBHANDLERS_MC", bbhands_mc)
 
         return Registered
 
 def remove(name, handler, data=None):
     """Remove an Event handler"""
-    if data:
+    if data is not None:
         if data.getVar("BB_CURRENT_MC"):
             mc = data.getVar("BB_CURRENT_MC")
             name = '%s%s' % (mc.replace('-', '_'), name)
@@ -299,8 +299,8 @@ def remove(name, handler, data=None):
         if name in _event_handler_map[event]:
             _event_handler_map[event].pop(name)
 
-    if data:
-        bbhands_mc = (data.getVar("__BBHANDLERS_MC") or [])
+    if data is not None:
+        bbhands_mc = (data.getVar("__BBHANDLERS_MC") or set())
         if name in bbhands_mc:
             bbhands_mc.remove(name)
             data.setVar("__BBHANDLERS_MC", bbhands_mc)
-- 
2.27.0

