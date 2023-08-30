Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0976C6FA8F
	for <webhook@archiver.kernel.org>; Wed, 30 Aug 2023 21:33:11 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
 by mx.groups.io with SMTP id smtpd.web11.2775.1693431186929972776
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 30 Aug 2023 14:33:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=APgl+5t4;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-401c90ed2ecso1475235e9.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 30 Aug 2023 14:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693431185; x=1694035985; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=oMs1hpZtgH4UO0xqM58batcJ/0mNQ+FU55vDdXuukxk=;
        b=APgl+5t4i/Kodw+mpyVr5hXBJ0TpCvQQD8uq958j6zLCssEC2UcaSGNWd2RDKTMdXE
         D23EfljNrn+OoY8h6sTkhTUfnnKf7qxHAh9+RYIaCirALLlozxQ59cxPn90tVAtNtStu
         a0hgwKg2lN4j1TVnuRH+WO4B90QsDxMd8bfWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693431185; x=1694035985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMs1hpZtgH4UO0xqM58batcJ/0mNQ+FU55vDdXuukxk=;
        b=MwPQyhuey50bXzCmXAOfKP28ZIFmOnrbzigN3fA/NCzEtvhaQli+8RLS6BZHl8DPoG
         gU5mF6h8Uh7f4ARj22XZiFK2Jj1k8MOYOE922qDvu74+3sLe2zCYhik3tta/PGhEk45/
         wppVYkybdUc0DChAjcLGEjXFqvuMHXwY9EZ2cLKl3g0kXtNCnM11PSLTGCv96oc99BmA
         KX+Hf0mTYlsxTWgclUgKHyIb7Ec4ZsQeFAIqC5N7X9tWrqcma518ziD3wIEYDFC+rE6O
         KbspZLvfNjXJJTn2PomPcZ9obF6gZMc3sTIe2rDQvybEN03uGhxxK7rRfWDmQ8Wxcn/O
         rsLQ==
X-Gm-Message-State: AOJu0YzDk7KOAyBkGtnl0RYCkw6lfdCs6q0pI9p3LhEXfMzk6welVNJj
	YzQyTIsLceXTwkRyVi4JuHlfPWZQv9NFSrFRX/8=
X-Google-Smtp-Source: AGHT+IHR3ELB4wVzu4F5XAuY4ylrXuxUKxlmJIIvtiCQ8mkfZy6UPHlWiwOSsF3+6i0n+4QlutR6zQ==
X-Received: by 2002:a5d:6145:0:b0:319:6e6a:66e with SMTP id y5-20020a5d6145000000b003196e6a066emr3004557wrt.14.1693431184765;
        Wed, 30 Aug 2023 14:33:04 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:22b:9179:6474:7878])
        by smtp.gmail.com with ESMTPSA id j17-20020adff551000000b0031432f1528csm30639wrp.45.2023.08.30.14.33.03
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 14:33:04 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] command: Avoid time intensive distractions for ping
Date: Wed, 30 Aug 2023 22:33:03 +0100
Message-Id: <20230830213303.2043607-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 30 Aug 2023 21:33:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14993

We noticed some users were seeing very slow ping response times which
caused 'server timeout' issues. There were some function calls in runCommand
which could be slow such as the inotify callback processing.

Mark up the ping command such that it doesn't need configuration information,
it is allowed on a readonly server and specifically skip the inofity processing
too since ping would never need that.

This will hopefully resolve various ping timeout issues that were being reported.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index a355f56c60..b494f84a0a 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -65,7 +65,7 @@ class Command:
         command = commandline.pop(0)
 
         # Ensure cooker is ready for commands
-        if command != "updateConfig" and command != "setFeatures":
+        if command not in ["updateConfig", "setFeatures", "ping"]:
             try:
                 self.cooker.init_configdata()
                 if not self.remotedatastores:
@@ -85,7 +85,8 @@ class Command:
                 if not hasattr(command_method, 'readonly') or not getattr(command_method, 'readonly'):
                     return None, "Not able to execute not readonly commands in readonly mode"
             try:
-                self.cooker.process_inotify_updates_apply()
+                if command != "ping":
+                    self.cooker.process_inotify_updates_apply()
                 if getattr(command_method, 'needconfig', True):
                     self.cooker.updateCacheSync()
                 result = command_method(self, commandline)
@@ -169,6 +170,8 @@ class CommandsSync:
         Allow a UI to check the server is still alive
         """
         return "Still alive!"
+    ping.needconfig = False
+    ping.readonly = True
 
     def stateShutdown(self, command, params):
         """
-- 
2.39.2


