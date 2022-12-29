Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1FBC54EBC
	for <webhook@archiver.kernel.org>; Thu, 29 Dec 2022 17:07:43 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.web11.209996.1672333657013717810
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Dec 2022 09:07:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=PkMrTSwd;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f47.google.com with SMTP id y8so17878299wrl.13
        for <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 09:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wnF4If3Dr/OaHy8ROycwg8tGZNXvY2VGiIzRtAMnOds=;
        b=PkMrTSwdhxs4dWL6aoRFkx9b7viRbPlujNuuATARaqRcKXlrVwhtsI2zEFWF3sijTE
         ZtEQ+H3xGGYbocxk+C4k94pQPSdZby5P5ARE09horQ+eAzOr46jFUQOJhBo5FZV24cjW
         2Tgdqui5LgmuzifAAbMAC35l2BTw4eO4FGWhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnF4If3Dr/OaHy8ROycwg8tGZNXvY2VGiIzRtAMnOds=;
        b=44KKGDm4U6NJFUgdcuDL7dJ9AUHKlCU4s+ezAW9hE7WLM3u22cEdmxXncN1hmX1mUf
         +EHbCJkY5TdDepNQwpaCdyfn+rOse81fFVAMomDr7uM9HwfjsXqtDsiHxkzjlMUfk9RX
         9LFhpuUVjjwfe6SfD/b1sCbYhn8Zaz9lo4cJnnTv9WogdF5S0x0pBVEbyQkz78D69BTi
         s95U0XwT9iIFEGAwlstmFXHtWKUgIJdOhBLi1YVgdtdDUtJqwzmaphni2Q44OphbNGRC
         J74HJC27IFz+Q/9Oja0o8gjwUnZfqM+eZ3SFK1QZiIhXwebDk3p4NUMxHg8jN/m+1o4F
         +IKQ==
X-Gm-Message-State: AFqh2kqcCZ3DwV1M+cEIN16/X9qfINIQVUqXBVMi77t1NlGNMl8gbHFJ
	UTsfUTk7coJGiyLYhQeRGkwi1Nl752p3w2g2
X-Google-Smtp-Source: AMrXdXtxPCvdpR2+LbRPhuK29tqT3fD+Sk8DlBOJZLAuTyjDlMI/99ef0ByU/eBRvBEUed+Tcxxe3g==
X-Received: by 2002:a5d:6808:0:b0:272:3a86:29c1 with SMTP id w8-20020a5d6808000000b002723a8629c1mr14818484wru.16.1672333655208;
        Thu, 29 Dec 2022 09:07:35 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:43af:59a1:5bcf:54fb])
        by smtp.gmail.com with ESMTPSA id t12-20020a05600001cc00b0027b35baf811sm12308721wrx.57.2022.12.29.09.07.34
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 09:07:34 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 08/15] process: Improve async command execution with idle interaction
Date: Thu, 29 Dec 2022 17:07:21 +0000
Message-Id: <20221229170728.880367-9-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
References: <20221229170728.880367-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Dec 2022 17:07:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14252

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
index d03f35a896..41903241ab 100644
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
index 503d5dd686..fefc5a64fc 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -264,7 +264,7 @@ class ProcessServer():
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


