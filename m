Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.18883.1599920994735200124
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 12 Sep 2020 07:29:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=F5qGCNDM;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.43, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f43.google.com with SMTP id s13so6840287wmh.4
        for <bitbake-devel@lists.openembedded.org>; Sat, 12 Sep 2020 07:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9KIkzvjkr84N/KJu7Vv+Fi6sqiC94+i4JJwZtXA8IZA=;
        b=F5qGCNDMOnf5FHqNlhSN+37PjcVH7ACX1LpiyHuupkrAoSx8+o84ynJMq/tx+2t276
         aY64lBfHORj+/d0SbUcuciRKGlpcDgJ9purUk9hyJMrtB1bUZKrRhXpqjPCEqDv5eOj8
         Y0QJAuTogDJZCFdM2GCwcViJ1gSBP4nSwmbi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9KIkzvjkr84N/KJu7Vv+Fi6sqiC94+i4JJwZtXA8IZA=;
        b=JTgVyPApMlkTr09l5r5eiIerjQYyArFxneALXnzBoUCnQF0GI01baKW21b0YZSfFSL
         FbBQV5XyS8U5NdTA9NoFDWhLPcgrAlheHOV1hqQHgi9Qh0UNjckR4rw32gj99mcy4+gn
         kfJqxue0JPk0gX3BKsVeQx5HupACtMEduMUozWJ17tOAkinFSppYdia4DdN+1TFLRJlS
         xeeWJ7YVhRuxtm1IGcXmyFhsQMafqShMzOEgMOJHTBnqdtMrbg6OV2euBkRt02LUR+/7
         t80NwR8ZIQh2v5vSSNts36s5iLlSsWEgrjcb/Nay5rSHQ3tM/r2ljFmjfhF10tUKXaLL
         OEHA==
X-Gm-Message-State: AOAM531bOzHX3guGkEoS8lRq8LLDc5CQ1W6ydxbTldtl8J5i2wp6M/LO
	z4NaxFYzJSbE+es5Kkg+HjqxPVkoBfm6Gg==
X-Google-Smtp-Source: ABdhPJzLYSb6QyljiDBFs5uAwBHke+b/bjIkLkcdq16H50F78IKnaTZzom3ZXodT8YkrXJzRLAs5Vg==
X-Received: by 2002:a1c:4303:: with SMTP id q3mr7096207wma.158.1599920992752;
        Sat, 12 Sep 2020 07:29:52 -0700 (PDT)
Return-Path: <richard.purdie@linuxfoundation.org>
Received: from hex.int.rpsys.net (8.4.6.b.e.8.e.4.6.7.0.3.a.2.d.2.c.3.f.5.a.b.a.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:aba:5f3c:2d2a:3076:4e8e:b648])
        by smtp.gmail.com with ESMTPSA id c25sm3997585wml.31.2020.09.12.07.29.51
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 07:29:52 -0700 (PDT)
From: "Richard Purdie" <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker/command: Fix disconnection handling
Date: Sat, 12 Sep 2020 15:29:51 +0100
Message-Id: <20200912142951.2109595-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the recent init changes, if a client disconnects before issuing a
command, the cooker can break in the reset handlers. Add some guards
in the code to prevent this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/command.py | 3 ++-
 lib/bb/cooker.py  | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index d4dcc653a0..f8c6a03bb9 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -143,7 +143,8 @@ class Command:
         self.cooker.finishcommand()
 
     def reset(self):
-        self.remotedatastores = bb.remotedata.RemoteDatastores(self.cooker)
+        if self.remotedatastores:
+           self.remotedatastores = bb.remotedata.RemoteDatastores(self.cooker)
 
 class CommandsSync:
     """
diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index e45755206e..58c223c1ca 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -1703,8 +1703,9 @@ class BBCooker:
         self.finishcommand()
         self.extraconfigdata = {}
         self.command.reset()
-        self.databuilder.reset()
-        self.data = self.databuilder.data
+        if hasattr(self, "data"):
+           self.databuilder.reset()
+           self.data = self.databuilder.data
         self.parsecache_valid = False
         self.baseconfig_valid = False
 
-- 
2.25.1

