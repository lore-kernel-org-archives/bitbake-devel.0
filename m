Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9EDC10F1B
	for <webhook@archiver.kernel.org>; Tue, 13 Dec 2022 23:25:10 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web10.89356.1670973905869727648
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Dec 2022 15:25:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=aovx4+TV;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f43.google.com with SMTP id h11so17501721wrw.13
        for <bitbake-devel@lists.openembedded.org>; Tue, 13 Dec 2022 15:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lxnWr1JNK/J2O6eKXfvKKYvtTUUfHnnR6EBRJGSTMMw=;
        b=aovx4+TVzkmhL2Q/0x1mujhliSQ+tYOrXxhZmoP2KrfXp12c1K8jgACorhcJ6yhu+J
         CDXYFNr4oXi5XqcqBXUISBZxUKkXyEV+BYDz+28aNKRSKSPCPjTNJjII6TE6CQNtGr20
         8u9G/2RINbDnDI/AmNFk/UIELVP/sJtjObWXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lxnWr1JNK/J2O6eKXfvKKYvtTUUfHnnR6EBRJGSTMMw=;
        b=jLmEYn/3k4YmfRrab+HE2nR1XAP8CoVSL+Pn80JtT6IroKq1u2ZXMnl738Z1+f+Goe
         uU0EfjOzHhygMRPT1A7Y/G9Ehj27vH5FX7PQIwtsqkxsjRDlM+GUqVjWaLaGdJrnH1wS
         aGu7b12SJ4VFs4EZBuj5xCRSYSHnDi88gN3U21AlOajwDdZmbxfr89rpMD4+ugB+wPS5
         IYM80BeVFV39xB4AtVyx4ioI6zg2bf0H9ilWCbrBQ1juDEKi8j0c0/PvuylK/QICR7HU
         3wMf4iQGqR1OLFJAF53/C4Q2x22U7lVBT9zAVo6zL6cSa+A2rh6TEPjyiZzt5GHs6/wn
         Vt4A==
X-Gm-Message-State: ANoB5pnGdtgnXE34T4Co+bO+fsmC6zVh4fwO5vCyqoK3aC4I2yI/HPVb
	Qyi/yuO3qNOAbtJluq9DOEGMmkfpjTRp5gwC
X-Google-Smtp-Source: AA0mqf4SAcGksCNcNG6hqNFgAWILWcTuoPhSH8eO9CnsSxjY5ocaoojF1trekDi0cLKRO7tzMQo/TA==
X-Received: by 2002:a5d:4045:0:b0:242:1415:ab02 with SMTP id w5-20020a5d4045000000b002421415ab02mr12671841wrp.9.1670973903607;
        Tue, 13 Dec 2022 15:25:03 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9b1a:807b:6e09:ff96])
        by smtp.gmail.com with ESMTPSA id t2-20020adfa2c2000000b002428c4fb16asm1097088wra.10.2022.12.13.15.25.02
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 15:25:03 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] main/process: Add extra sockname debugging
Date: Tue, 13 Dec 2022 23:25:02 +0000
Message-Id: <20221213232502.114660-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 13 Dec 2022 23:25:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14187

We're struggling to understand how bitbake.sock can sometimes disappear
in live builds when we can't see where it could have been deleted.
This causes connection failures to the server and failed builds.

Add some extra debugging around the server log and client retry
log messages to give more information for the next time this issue
occurs.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/main.py           | 3 ++-
 lib/bb/server/process.py | 7 ++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/bb/main.py b/lib/bb/main.py
index ee12256bc8..ed3e1ede61 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -446,7 +446,8 @@ def setup_bitbake(configParams, extrafeatures=None):
                         logger.info("Previous bitbake instance shutting down?, waiting to retry... (%s)" % timestamp())
                         procs = bb.server.process.get_lockfile_process_msg(lockfile)
                         if procs:
-                            logger.info("Processes holding bitbake.lock:\n%s" % procs)
+                            logger.info("Processes holding bitbake.lock (missing socket %s):\n%s" % (sockname, procs))
+                        logger.info("Directory listing: %s" % (str(os.listdir(topdir))))
                         i = 0
                         lock = None
                         # Wait for 5s or until we can get the lock
diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index f4ab80ba67..44c65451fc 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -154,9 +154,10 @@ class ProcessServer():
             fds.append(self.xmlrpc)
         seendata = False
         serverlog("Entering server connection loop")
+        serverlog("Lockfile is: %s\nSocket is %s (%s)" % (self.bitbake_lock_name, self.sockname, os.path.exists(self.sockname)))
 
         def disconnect_client(self, fds):
-            serverlog("Disconnecting Client")
+            serverlog("Disconnecting Client (socket: %s)" % os.path.exists(self.sockname))
             if self.controllersock:
                 fds.remove(self.controllersock)
                 self.controllersock.close()
@@ -246,7 +247,7 @@ class ProcessServer():
                 try:
                     serverlog("Running command %s" % command)
                     self.command_channel_reply.send(self.cooker.command.runCommand(command))
-                    serverlog("Command Completed")
+                    serverlog("Command Completed (socket: %s)" % os.path.exists(self.sockname))
                 except Exception as e:
                    stack = traceback.format_exc()
                    serverlog('Exception in server main event loop running command %s (%s)' % (command, stack))
@@ -273,7 +274,7 @@ class ProcessServer():
 
             ready = self.idle_commands(.1, fds)
 
-        serverlog("Exiting")
+        serverlog("Exiting (socket: %s)" % os.path.exists(self.sockname))
         # Remove the socket file so we don't get any more connections to avoid races
         try:
             os.unlink(self.sockname)
-- 
2.37.2


