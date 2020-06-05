Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
 by mx.groups.io with SMTP id smtpd.web12.2228.1591322022718899439
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Jun 2020 18:53:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=gY9qRXDO;
 spf=pass (domain: gmail.com, ip: 209.85.214.175, mailfrom: jpewhacker@gmail.com)
Received: by mail-pl1-f175.google.com with SMTP id bg4so2993167plb.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Jun 2020 18:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=phdhXUn7VXwpNZ9tFQ8CNLu70J0F+dLJWPNEVVPX25Q=;
        b=gY9qRXDOWScWGXx/xc955EH1/E5yb3g8o67GQl/TDeZ8Y5jqfh1r3/v/mnZY655zpO
         twlSqDDWDDF7XxVWgIdBanGhS22sjhdX/AS0Nem0G61tq/QYIhwj7owreyRBQVhj4Em7
         3JMRQjMucKDbUT5ZgPBfxxlFF1Gi0BDy5q6lQdCS25diVhatAs5Xg4kBE7zqnMnHNRuj
         AwXt5/KgH/w4xHx09nT6g8InV80ng+L0wQJpQGF7NmJc9dCaVvkbnyYPIWZOGw6j7Gui
         ffehfVaYfcrIhKnk7tOGAhhlEviEyl1lghbZSftbjAhJLe+o1/5s/5XxInWsj3Uxa4f5
         QKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=phdhXUn7VXwpNZ9tFQ8CNLu70J0F+dLJWPNEVVPX25Q=;
        b=m7qgCQoOkWTOzqo+fq41IjIDGh+yUm1kdEHt8dObROidjqSfMwySPowDbJeyXvjFQQ
         ewDnTKd0IOCe77NkRZDGJD2o03YDHvMsNHGzBgCfIui31vioVjjFxoCZIsgqJdgjy+XL
         TESyNS5EaFdc0IvDGH+ATRXDtd/wrn79GpBDiy31s9lJhVz5GVIN9OAcrTJMFMxKkfBY
         N9WuHt5pokoLSCzKf0EHxhVdpldyDePqlkExxBrmYpO6pqyGG1PzXjBf95x8dEeBWOru
         J3alZ/DvpC8iV0UqDLuW7MRgHfvR7f/glrFnHybBdh8O053RvKY6PyIU+Nv2FCMqsZHC
         tmQQ==
X-Gm-Message-State: AOAM531FbVnyvqPCYmJsKmrozS0WdhOUK6Rhh6aVWcZGkQgvw9bS4+0n
	BWE4Ou+a6BMJoXPy4e0v8rjMkW/r+qo=
X-Google-Smtp-Source: ABdhPJygDE5KkthWdwPxZRJjGFzuMht7C18zMUD7YHl8cbS++jm5ufv08n5qpz5dPsTJ05weVgcNWw==
X-Received: by 2002:a17:90a:c258:: with SMTP id d24mr243483pjx.137.1591322022017;
        Thu, 04 Jun 2020 18:53:42 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:bdc6:d557:64ed:7ccf])
        by smtp.gmail.com with ESMTPSA id x12sm5673516pfo.72.2020.06.04.18.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 18:53:41 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4 8/8] bitbake: command: Move split_mc_pn to runqueue
Date: Thu,  4 Jun 2020 20:53:25 -0500
Message-Id: <20200605015325.35395-9-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605015325.35395-1-JPEWhacker@gmail.com>
References: <20200603025405.26885-1-JPEWhacker@gmail.com>
 <20200605015325.35395-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All of the other multiconfig splitting functions are located in runqueue
so move the function to split a pn/fn there also so that its easier to
see them all together. Fixes a case where the findBestProvider() command
wasn't working for multiconfig because it was looking for a prefix of
"multiconfig:" instead of the newer "mc:"

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/command.py  | 8 +-------
 bitbake/lib/bb/runqueue.py | 6 ++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index f45b6e5320..0890fe2887 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -138,12 +138,6 @@ class Command:
     def reset(self):
         self.remotedatastores = bb.remotedata.RemoteDatastores(self.cooker)
 
-def split_mc_pn(pn):
-    if pn.startswith("multiconfig:"):
-        _, mc, pn = pn.split(":", 2)
-        return (mc, pn)
-    return ('', pn)
-
 class CommandsSync:
     """
     A class of synchronous commands
@@ -438,7 +432,7 @@ class CommandsSync:
     findProviders.readonly = True
 
     def findBestProvider(self, command, params):
-        (mc, pn) = split_mc_pn(params[0])
+        (mc, pn) = bb.runqueue.split_mc(params[0])
         return command.cooker.findBestProvider(pn, mc)
     findBestProvider.readonly = True
 
diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 3d54c2b88a..5b7dab8d79 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -46,6 +46,12 @@ def split_tid(tid):
     (mc, fn, taskname, _) = split_tid_mcfn(tid)
     return (mc, fn, taskname)
 
+def split_mc(n):
+    if n.startswith("mc:"):
+        _, mc, n = n.split(":", 2)
+        return (mc, n)
+    return ('', n)
+
 def split_tid_mcfn(tid):
     if tid.startswith('mc:'):
         elems = tid.split(':')
-- 
2.26.2

