Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88113C3DA7C
	for <webhook@archiver.kernel.org>; Thu, 22 Dec 2022 23:47:34 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web11.60901.1671752850665460756
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Dec 2022 15:47:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=XOn5W+Pf;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.41, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f41.google.com with SMTP id o15so2564699wmr.4
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Dec 2022 15:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TAKaIm/rM9hNwILCcwB2RH+YraJeg3L9ZWheYT2NgnM=;
        b=XOn5W+PfEEvBjzPeeZpM/z950i+qxhPVl7+cmpeHNlh0F/eFJJgynsYexyFhM3iw0P
         3Ye2FS7aSOlUZoplUViSOT4cHL7NI4zJj285I6LYdE9cXZh/NDrMze7Okrk+N+EVAMFG
         jNI0muQ4YXWxhF9ROqnDJNRwXS0LNzWgPbTYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TAKaIm/rM9hNwILCcwB2RH+YraJeg3L9ZWheYT2NgnM=;
        b=UfQ6TbPtoI7PH2ZfeReGyLQkAtlXjURrGuUDlV6y4Bz92UbEnBRnAQSQZHRBwT3vAq
         ahqfyHey7XVW0qNx+zHb6sz4MMUSVY6/u7xnao4QYbgI80MvwG6j+PoCQE2WSyVp3gTO
         A8ic/+XEsQtpaeSg4sebyYEHwPNPKSwp6wV1Sia4KMd1/J62apHUxTqFG/Czsd7odsXp
         y0o6UC/MX8ZjBXeVikPZPTPfjF78Hy372DOmsVUVUgsCNnTDgSnrB2mHJ96HKO4IUf3a
         G0iuuFszzKc8jq7FGw3NMuizZzhm2BTRUFTznEYglq9GNBPU2VHlzTva4m2Q+8hQbABO
         eMOg==
X-Gm-Message-State: AFqh2kqNdHGqLNksbJs+fcywS+AhxQTDyptfqOwKyGuuQs10VqriIGi2
	Krgq6xanDkHPJ33K3m8j9VOwjFS+YQOOvIWa
X-Google-Smtp-Source: AMrXdXtGcsAK9/S0XqHNIl0MfXBrdsTfb0q2tXu+vfflsP6QI70R8w5lAVb5ZV7S8HG5nqfZaa/5oQ==
X-Received: by 2002:a05:600c:4f48:b0:3d6:8570:1239 with SMTP id m8-20020a05600c4f4800b003d685701239mr6602685wmq.16.1671752850929;
        Thu, 22 Dec 2022 15:47:30 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:bc21:fec7:83cf:e0c3])
        by smtp.gmail.com with ESMTPSA id bd25-20020a05600c1f1900b003cfd4cf0761sm7322189wmb.1.2022.12.22.15.47.30
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 15:47:30 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 06/10] process: Improve async command execution with idle interaction
Date: Thu, 22 Dec 2022 23:47:22 +0000
Message-Id: <20221222234726.579702-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221222234726.579702-1-richard.purdie@linuxfoundation.org>
References: <20221222234726.579702-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Dec 2022 23:47:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14234

When running a new async command, the previous one might not have
finished executing in the idle handler. Add some code to use the event
logic to wait for the idle loop to finish for 30s before saying the
server is busy.

This avoids build failures when a UI quickly starts the next async
command before the code has finished shutdown/cleanup from the last one.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py             | 8 ++++++--
 lib/bb/server/process.py      | 2 +-
 lib/bb/server/xmlrpcserver.py | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 20a8b86653..ebcee0b7eb 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -60,7 +60,7 @@ class Command:
         # FIXME Add lock for this
         self.currentAsyncCommand = None
 
-    def runCommand(self, commandline, ro_only = False):
+    def runCommand(self, commandline, process_server, ro_only = False):
         command = commandline.pop(0)
 
         # Ensure cooker is ready for commands
@@ -100,7 +100,11 @@ class Command:
             else:
                 return result, None
         if self.currentAsyncCommand is not None:
-            return None, "Busy (%s in progress)" % self.currentAsyncCommand[0]
+            # Wait for the idle loop to have cleared (30s max)
+            process_server.is_idle.clear()
+            process_server.is_idle.wait(timeout=30)
+            if self.currentAsyncCommand is not None:
+                return None, "Busy (%s in progress)" % self.currentAsyncCommand[0]
         if command not in CommandsAsync.__dict__:
             return None, "No such command"
         self.currentAsyncCommand = (command, commandline)
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 895e39cd0f..912f5f4091 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -260,7 +260,7 @@ class ProcessServer():
                     continue
                 try:
                     serverlog("Running command %s" % command)
-                    self.command_channel_reply.send(self.cooker.command.runCommand(command))
+                    self.command_channel_reply.send(self.cooker.command.runCommand(command, self))
                     serverlog("Command Completed (socket: %s)" % os.path.exists(self.sockname))
                 except Exception as e:
                    stack = traceback.format_exc()
diff --git a/lib/bb/server/xmlrpcserver.py b/lib/bb/server/xmlrpcserver.py
index 01f55538ae..2e65dc34a9 100644
--- a/lib/bb/server/xmlrpcserver.py
+++ b/lib/bb/server/xmlrpcserver.py
@@ -118,7 +118,7 @@ class BitBakeXMLRPCServerCommands():
         """
         Run a cooker command on the server
         """
-        return self.server.cooker.command.runCommand(command, self.server.readonly)
+        return self.server.cooker.command.runCommand(command, self.server, self.server.readonly)
 
     def getEventHandle(self):
         return self.event_handle
-- 
2.37.2


