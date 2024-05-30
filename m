Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028B8C25B74
	for <webhook@archiver.kernel.org>; Thu, 30 May 2024 14:27:07 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.10347.1717079218858222176
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 May 2024 07:26:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=eHxiBKz3;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4210aa00c94so9873895e9.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 May 2024 07:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717079217; x=1717684017; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OpaNrNQ0gGZw/kSt5fI3Hn6zzl69iol/3OplDpg3aXM=;
        b=eHxiBKz3t8FHthJ/adpXuJQOcHurRgCsDbcpHCKv3yvttUzPmu//hCZAem0NxK1GwP
         S9dtuWTrZkql2nTAb3DJLZwqPTfwXxF9GZmFZjyLqhZLT5GGrQI/UdVGKZTDnypPowPP
         OMAV9/a3KyTZ5swKxUMnbD6WJvZOVWdVyHJS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717079217; x=1717684017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpaNrNQ0gGZw/kSt5fI3Hn6zzl69iol/3OplDpg3aXM=;
        b=Wl7eWLIOa1uFMGZ4NQfeJ7YXGBJ44CtHA9tDESp/DK49Milm4xZxlpsCt69ZbVArTW
         3DvoRG9u/fH0kE1+qa+lCTmMI+U1hhxP/RyTmR0TeL6Dwqg3Mi9E5NtmMVLNN0kMeb/n
         zDa6f4kyqaEFgBVBFZuTrmlocZk4diMHA1sE/lT9X/rHeT6jRD6nXZF0vgJJAGj2kxal
         Ov7qM7WhdhsONbhOprIeTy1P4wwcjiYhAZS8KQqbSsWAKH/htOvX5pMhZalJxs1yPeSR
         COMttkA4B2pFSrLVsUYWRAJk+niXG06PqJwod5dQEpHHmNiwu2e1HEB3BYTIWDLH8OzT
         cy8Q==
X-Gm-Message-State: AOJu0Yywj8bbGWMVz1YpKJ7HJZB2BdQmuCGssRZStApDWFQ30DKLZ+rK
	9+B/jYm+gDeQ7S+RMOX3LvC3c+GjfKpUZTOFWw1hrcgAKMnzdVJEsjngCn6JPun5D5Nh8oOrCrD
	c
X-Google-Smtp-Source: AGHT+IERh92URInqMjGHE2xRrIbiBPUnGa67KCu5j3dUZTuQOZqiGmAQWZvZQgosk1cOoigp23OdYg==
X-Received: by 2002:a05:600c:4354:b0:41b:e416:43d3 with SMTP id 5b1f17b1804b1-421279295f0mr21578435e9.35.1717079216857;
        Thu, 30 May 2024 07:26:56 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:e2db:3695:26f3:1f11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421270791c7sm26684295e9.31.2024.05.30.07.26.56
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 07:26:56 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/2] bitbake: Drop older python version compatibility code
Date: Thu, 30 May 2024 15:26:54 +0100
Message-Id: <20240530142654.3095813-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240530142654.3095813-1-richard.purdie@linuxfoundation.org>
References: <20240530142654.3095813-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 May 2024 14:27:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16288

cooker: We can call multiprocessing close() unconditionally and tweak a
comment give 3.8 is now the minimum version.

lib/bb: We can drop the logger addition code only needed before 3.6

asyncrpc/hashserv: Since the minimum version is 3.8, we can drop the
conditional code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/__init__.py        | 20 --------------------
 lib/bb/asyncrpc/client.py |  3 +--
 lib/bb/asyncrpc/serv.py   |  3 +--
 lib/bb/cooker.py          |  9 ++++-----
 lib/hashserv/tests.py     |  3 ---
 5 files changed, 6 insertions(+), 32 deletions(-)

diff --git a/lib/bb/__init__.py b/lib/bb/__init__.py
index b04d4c8a83..574e0de5be 100644
--- a/lib/bb/__init__.py
+++ b/lib/bb/__init__.py
@@ -104,26 +104,6 @@ class BBLoggerAdapter(logging.LoggerAdapter, BBLoggerMixin):
         self.setup_bblogger(logger.name)
         super().__init__(logger, *args, **kwargs)
 
-    if sys.version_info < (3, 6):
-        # These properties were added in Python 3.6. Add them in older versions
-        # for compatibility
-        @property
-        def manager(self):
-            return self.logger.manager
-
-        @manager.setter
-        def manager(self, value):
-            self.logger.manager = value
-
-        @property
-        def name(self):
-            return self.logger.name
-
-        def __repr__(self):
-            logger = self.logger
-            level = logger.getLevelName(logger.getEffectiveLevel())
-            return '<%s %s (%s)>' % (self.__class__.__name__, logger.name, level)
-
 logging.LoggerAdapter = BBLoggerAdapter
 
 logger = logging.getLogger("BitBake")
diff --git a/lib/bb/asyncrpc/client.py b/lib/bb/asyncrpc/client.py
index b49de99313..f81ad92f48 100644
--- a/lib/bb/asyncrpc/client.py
+++ b/lib/bb/asyncrpc/client.py
@@ -249,8 +249,7 @@ class Client(object):
     def close(self):
         if self.loop:
             self.loop.run_until_complete(self.client.close())
-            if sys.version_info >= (3, 6):
-                self.loop.run_until_complete(self.loop.shutdown_asyncgens())
+            self.loop.run_until_complete(self.loop.shutdown_asyncgens())
             self.loop.close()
         self.loop = None
 
diff --git a/lib/bb/asyncrpc/serv.py b/lib/bb/asyncrpc/serv.py
index 46d54fb511..667217c5c1 100644
--- a/lib/bb/asyncrpc/serv.py
+++ b/lib/bb/asyncrpc/serv.py
@@ -388,8 +388,7 @@ class AsyncServer(object):
 
             self._serve_forever(tasks)
 
-            if sys.version_info >= (3, 6):
-                self.loop.run_until_complete(self.loop.shutdown_asyncgens())
+            self.loop.run_until_complete(self.loop.shutdown_asyncgens())
             self.loop.close()
 
         queue = multiprocessing.Queue()
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 673af8daec..6754f986bf 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1812,8 +1812,8 @@ class CookerCollectFiles(object):
             bb.event.fire(CookerExit(), eventdata)
 
         # We need to track where we look so that we can know when the cache is invalid. There
-        # is no nice way to do this, this is horrid. We intercept the os.listdir()
-        # (or os.scandir() for python 3.6+) calls while we run glob().
+        # is no nice way to do this, this is horrid. We intercept the os.listdir() and os.scandir()
+        # calls while we run glob().
         origlistdir = os.listdir
         if hasattr(os, 'scandir'):
             origscandir = os.scandir
@@ -2224,9 +2224,8 @@ class CookerParser(object):
 
         for process in self.processes:
             process.join()
-            # Added in 3.7, cleans up zombies
-            if hasattr(process, "close"):
-                process.close()
+            # clean up zombies
+            process.close()
 
         bb.codeparser.parser_cache_save()
         bb.codeparser.parser_cache_savemerge()
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 5349cd5867..cf74d9de7e 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -94,9 +94,6 @@ class HashEquivalenceTestSetup(object):
         return self.start_client(self.auth_server_address, user["username"], user["token"])
 
     def setUp(self):
-        if sys.version_info < (3, 5, 0):
-            self.skipTest('Python 3.5 or later required')
-
         self.temp_dir = tempfile.TemporaryDirectory(prefix='bb-hashserv')
         self.addCleanup(self.temp_dir.cleanup)
 

