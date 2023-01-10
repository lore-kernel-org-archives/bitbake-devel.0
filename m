Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DABBC46467
	for <webhook@archiver.kernel.org>; Tue, 10 Jan 2023 16:03:16 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.107481.1673366586001422338
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Jan 2023 08:03:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=V357euKB;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f44.google.com with SMTP id bk16so12269567wrb.11
        for <bitbake-devel@lists.openembedded.org>; Tue, 10 Jan 2023 08:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dPU+kx5Obn2qc9qsuDZEqzuMCYMgyK6T62Q5noWqIA8=;
        b=V357euKBDiL4WrNdsBiq4xtz7uDaZzSwUX3tIW6hEPnrY76tLla3VOGexDQ4Ars5cA
         dlGxbEgzpKzBdojD3lAf5PS0iZxAUVBg3Kd68/TmAuu1lypTIOcIrcpNrL35UNaMJ8cR
         5p2h4tvD5Q+5mYxsujUBK6PJ1LbUR89RJMpu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dPU+kx5Obn2qc9qsuDZEqzuMCYMgyK6T62Q5noWqIA8=;
        b=kHx6VESeU0QCGobKp/5s3xr4P0NhrWk1/pGrKUrpU7mZRCzec9u0O4kkP/M70/5gZk
         /eWeOCM1phXX3pgOOkl6ukn4rBeIEVGBWLuKJaDgjAtpDY1g2U75bVTlS+gNSHw5+jhu
         6xe0W2O+78tkF3kzEoAxN5xTzZkjEqv1Ofc8ddFvjj3iHhmzbNrwnm82SEWFgUL5+FA+
         4Qt16r9nBDhT7HFcVuHZWksLOD3LfJFGO7FhJeAMDnvgXPO9P++sqpNcZpGspr//qaK1
         gNjgh1rpW6j4r0rqcoGKVFqs6wEkVA34zDJ9aFoszM6cMUUSS7+x1DbRsd4xbcPfx61E
         h1yA==
X-Gm-Message-State: AFqh2kqPr6+zlOmvE4F3A9pOeSHk27u/7F358ctt42Q3lvroMfuzeNGz
	9U8NJVKZeli59u6j5OYcFo+Gy35A3Ei5tUxB
X-Google-Smtp-Source: AMrXdXt1H5Q6eJxm2ZjMmE87OodIti4pMzwXD2oQIydYN7AsdyEdg/+Xyn+7tD+YT93PwAymfoLJ0A==
X-Received: by 2002:adf:dd0e:0:b0:2bb:32f4:3697 with SMTP id a14-20020adfdd0e000000b002bb32f43697mr9218101wrm.39.1673366583704;
        Tue, 10 Jan 2023 08:03:03 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ef35:464f:aac3:7a])
        by smtp.gmail.com with ESMTPSA id j14-20020adff00e000000b0024cb961b6aesm11429379wro.104.2023.01.10.08.03.03
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 08:03:03 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/2] cooker/command: Drop async command handler indirection via cooker
Date: Tue, 10 Jan 2023 16:03:01 +0000
Message-Id: <20230110160302.1470163-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 Jan 2023 16:03:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14297

Indirecting the async command handler via cooker is confusing and no
longer needed. Drop it to make things slightly clearer.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py | 4 ++--
 lib/bb/cooker.py  | 9 ---------
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 5d321cf9fa..c325abbcda 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -108,10 +108,10 @@ class Command:
         if command not in CommandsAsync.__dict__:
             return None, "No such command"
         self.currentAsyncCommand = (command, commandline)
-        self.cooker.idleCallBackRegister(self.cooker.runCommands, self.cooker)
+        self.cooker.idleCallBackRegister(self.runAsyncCommand, None)
         return True, None
 
-    def runAsyncCommand(self):
+    def runAsyncCommand(self, _, _2, halt):
         try:
             self.cooker.process_inotify_updates_apply()
             if self.cooker.state in (bb.cooker.state.error, bb.cooker.state.shutdown, bb.cooker.state.forceshutdown):
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index d2c42c858d..13d6e9d847 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -535,15 +535,6 @@ class BBCooker:
             logger.debug("Base environment change, triggering reparse")
             self.reset()
 
-    def runCommands(self, server, data, halt):
-        """
-        Run any queued asynchronous command
-        This is done by the idle handler so it runs in true context rather than
-        tied to any UI.
-        """
-
-        return self.command.runAsyncCommand()
-
     def showVersions(self):
 
         (latest_versions, preferred_versions, required) = self.findProviders()
-- 
2.37.2


