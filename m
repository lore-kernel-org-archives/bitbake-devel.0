Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4DEC433FE
	for <webhook@archiver.kernel.org>; Thu, 17 Feb 2022 22:09:52 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.web09.3387.1645135790914260368
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Feb 2022 14:09:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=sm2F8pJ1;
 spf=pass (domain: konsulko.com, ip: 209.85.219.44,
 mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f44.google.com with SMTP id o5so11108547qvm.3
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Feb 2022 14:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=R73oPIKQkRvztHPs+7Or+xALhdsieIDsFg7IxQ6+moc=;
        b=sm2F8pJ10FhC7UWpdW6SGq4uyJUeNUAioKv9t4kTZWzUut65LlxF/7YaIYuV1632/K
         ufgd7H6ylctmcztaVqCPHfAy0OQH6L2Ug4y7BADg4pmgE4+px6L6OOaDPhVFNJAKw7TR
         Y5aQWEJP7JdS/GLLZ2yWlN0DHeLkC13jJL+7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R73oPIKQkRvztHPs+7Or+xALhdsieIDsFg7IxQ6+moc=;
        b=T9W0WI2LZVjnDhc78AbSrceVemiGzKRVxULj1YbS9iLmey59RM/QX1+ZoXauZV+0vG
         2jtEfkxQ+Va3qQd4MW8f6XGb5azCACN3lR3206Al+OSRmi/kzBoPYSnP+P8HC7spVK2k
         qixScgTCRdKYepYSL56QhAaZqbTJH9LFAFBlTrDWSXvr2zrsYa7Ne6RuX3WEr9QnXt76
         QlxhLCng4ynPcvDO+36wMIQjlFdSrecU/9RWfe7hjfjxThgVlpICoFONyqYUWTE+sYGd
         qO1mDglJNHl8C8cemQ1sL3rVrY25oL1q6gsyNHtLsjo3c1GGGtDIAsLSllLgfII7mEhK
         GJXQ==
X-Gm-Message-State: AOAM530JeYkufabHFlSaPk7UAIwzoxI9MiNzD//bbS3rkHa8XuOVOfcV
	lgKGhEzK8Q6UgTUcpu6Bsc70tqANTE3FTQ==
X-Google-Smtp-Source: 
 ABdhPJylr0YjQwT8Em4UPuDdN/cAASqgkHwMzbhYvPA9ntqwNZud/NBGhCmoRCeZxjmbs3SigCBdgQ==
X-Received: by 2002:a05:6214:238b:b0:430:842c:1863 with SMTP id
 fw11-20020a056214238b00b00430842c1863mr3647654qvb.105.1645135789433;
        Thu, 17 Feb 2022 14:09:49 -0800 (PST)
Received: from ghidorah.spiteful.org (192-0-174-222.cpe.teksavvy.com.
 [192.0.174.222])
        by smtp.gmail.com with ESMTPSA id
 q15sm5127572qtn.41.2022.02.17.14.09.48
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 14:09:48 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 3/4] Replace "ABORT" action in BB_DISKMON_DIRS
Date: Thu, 17 Feb 2022 17:09:34 -0500
Message-Id: 
 <b61e35198c98e63c304799b3fbb0dee962511807.1645135230.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1645135230.git.scott.murray@konsulko.com>
References: <cover.1645135230.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Feb 2022 22:09:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13363

In line with the inclusive language migration defined at:

https://wiki.yoctoproject.org/wiki/Inclusive_language

replace the "ABORT" action in BB_DISKMON_DIRS entries with "HALT".
In order to ease migration, code has been added to warn users to
update their configurations if the old name is used, as opposed to
to throwing an error.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../bitbake-user-manual-ref-variables.rst       | 10 +++++-----
 lib/bb/event.py                                 |  2 +-
 lib/bb/monitordisk.py                           | 17 +++++++++++------
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 7601d15a..315086a6 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -138,7 +138,7 @@ overview of their function and contents.
          where:
 
             <action> is:
-               ABORT:     Immediately abort the build when
+               HALT:      Immediately halt the build when
                           a threshold is broken.
                STOPTASKS: Stop the build after the currently
                           executing tasks have finished when
@@ -169,13 +169,13 @@ overview of their function and contents.
 
       Here are some examples::
 
-         BB_DISKMON_DIRS = "ABORT,${TMPDIR},1G,100K WARN,${SSTATE_DIR},1G,100K"
+         BB_DISKMON_DIRS = "HALT,${TMPDIR},1G,100K WARN,${SSTATE_DIR},1G,100K"
          BB_DISKMON_DIRS = "STOPTASKS,${TMPDIR},1G"
-         BB_DISKMON_DIRS = "ABORT,${TMPDIR},,100K"
+         BB_DISKMON_DIRS = "HALT,${TMPDIR},,100K"
 
       The first example works only if you also set the
       :term:`BB_DISKMON_WARNINTERVAL`
-      variable. This example causes the build system to immediately abort
+      variable. This example causes the build system to immediately halt
       when either the disk space in ``${TMPDIR}`` drops below 1 Gbyte or
       the available free inodes drops below 100 Kbytes. Because two
       directories are provided with the variable, the build system also
@@ -189,7 +189,7 @@ overview of their function and contents.
       directory drops below 1 Gbyte. No disk monitoring occurs for the free
       inodes in this case.
 
-      The final example immediately aborts the build when the number of
+      The final example immediately halts the build when the number of
       free inodes in the ``${TMPDIR}`` directory drops below 100 Kbytes. No
       disk space monitoring for the directory itself occurs in this case.
 
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 0454c753..b85a434d 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -486,7 +486,7 @@ class BuildCompleted(BuildBase, OperationCompleted):
         BuildBase.__init__(self, n, p, failures)
 
 class DiskFull(Event):
-    """Disk full case build aborted"""
+    """Disk full case build halted"""
     def __init__(self, dev, type, freespace, mountpoint):
         Event.__init__(self)
         self._dev = dev
diff --git a/lib/bb/monitordisk.py b/lib/bb/monitordisk.py
index 98f2109e..8d8cfbb9 100644
--- a/lib/bb/monitordisk.py
+++ b/lib/bb/monitordisk.py
@@ -76,7 +76,12 @@ def getDiskData(BBDirs):
             return None
 
         action = pathSpaceInodeRe.group(1)
-        if action not in ("ABORT", "STOPTASKS", "WARN"):
+        if action == "ABORT":
+            # Emit a deprecation warning
+            logger.warnonce("The BB_DISKMON_DIRS \"ABORT\" action has been been renamed to \"HALT\", update configuration")
+            action = "HALT"
+
+        if action not in ("HALT", "STOPTASKS", "WARN"):
             printErr("Unknown disk space monitor action: %s" % action)
             return None
 
@@ -177,7 +182,7 @@ class diskMonitor:
                     # use them to avoid printing too many warning messages
                     self.preFreeS = {}
                     self.preFreeI = {}
-                    # This is for STOPTASKS and ABORT, to avoid printing the message
+                    # This is for STOPTASKS and HALT, to avoid printing the message
                     # repeatedly while waiting for the tasks to finish
                     self.checked = {}
                     for k in self.devDict:
@@ -219,8 +224,8 @@ class diskMonitor:
                         self.checked[k] = True
                         rq.finish_runqueue(False)
                         bb.event.fire(bb.event.DiskFull(dev, 'disk', freeSpace, path), self.configuration)
-                    elif action == "ABORT" and not self.checked[k]:
-                        logger.error("Immediately abort since the disk space monitor action is \"ABORT\"!")
+                    elif action == "HALT" and not self.checked[k]:
+                        logger.error("Immediately halt since the disk space monitor action is \"HALT\"!")
                         self.checked[k] = True
                         rq.finish_runqueue(True)
                         bb.event.fire(bb.event.DiskFull(dev, 'disk', freeSpace, path), self.configuration)
@@ -245,8 +250,8 @@ class diskMonitor:
                         self.checked[k] = True
                         rq.finish_runqueue(False)
                         bb.event.fire(bb.event.DiskFull(dev, 'inode', freeInode, path), self.configuration)
-                    elif action  == "ABORT" and not self.checked[k]:
-                        logger.error("Immediately abort since the disk space monitor action is \"ABORT\"!")
+                    elif action  == "HALT" and not self.checked[k]:
+                        logger.error("Immediately halt since the disk space monitor action is \"HALT\"!")
                         self.checked[k] = True
                         rq.finish_runqueue(True)
                         bb.event.fire(bb.event.DiskFull(dev, 'inode', freeInode, path), self.configuration)
-- 
2.35.1


