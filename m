Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816DDD6A249
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 22:18:08 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
 by mx.groups.io with SMTP id smtpd.web10.6940.1731622682107202076
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Nov 2024 14:18:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=eQugWm/4;
 spf=pass (domain: smile.fr, ip: 209.85.221.44, mailfrom: yoann.congal@smile.fr)
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d49ffaba6so744715f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 14 Nov 2024 14:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1731622680; x=1732227480; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RbOgv1FfVWtwzgD2fU/mGiMnkC7x/PAOffhLrnMZon0=;
        b=eQugWm/4nM6JKMJrNatQS8ijRWx2uArsod7D13a29rxZjxtpsO1c67T5Rd38ZTeNHT
         RWHNulfc2QflcPO3UtGRWa6YlsOc42yvMqaHfK3a3V0unNksqoDLfnUKXlsP7JrH2yCU
         jwv2CWMONZbBxEmiQWWdmj7MwHEx7wnLLQaJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731622680; x=1732227480;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RbOgv1FfVWtwzgD2fU/mGiMnkC7x/PAOffhLrnMZon0=;
        b=T4wPutJxCHPboY2hoNolf0gwlhVtXk1aWjpTySMstP4PFBa7vI6VgTlRdvdMppVnjm
         8JlLtSG8QezpQKMRGKHnfVhzsSOTW2ouvwNKrG8ra1ixlpNhr7r5vHCujbRB4JCo6kw5
         CHrgTD7kZ/HRk4u7lOliowl/DTqJcpeji6Ak+r/TV3Cjf1S5aozHdlp7qLzVnCtxbGFl
         jCFsWhzzbxg16oVPUGpS+GEYXYFGlCOcfZ5Y3z/T7Q1j6JDaV1zLGJNAvXy6k8AmOhnI
         Le7JwMOaKm3XOnOXaMtjaXE2ogMdBXlENPPAblQ7ywG4oJbu9O2zEELkAMxPig2Lw2ao
         yRJQ==
X-Gm-Message-State: AOJu0YyP1TxCn2aL9XuzmidyCmY85NTUVklooqkm0x0z79+zp8ggmW87
	TJp6AzQAXM7z5wUgKWeh+ME2Aw7h7UAxfW7efmf6XXplxlRjBPaideHMpmNL49khWGoi0OZIstc
	k
X-Google-Smtp-Source: AGHT+IG3/3GDb2qPuH8W6Hr++XezcEGserWcK8HaNb7AxovRWemBWEG2tXk9z1m+4UJEgKUmxinQ1w==
X-Received: by 2002:a05:6000:144f:b0:37c:d23a:1e4 with SMTP id ffacd0b85a97d-38225a26471mr241425f8f.30.1731622680311;
        Thu, 14 Nov 2024 14:18:00 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.local ([2a04:cec0:11fb:21bd:1f18:7aa1:7b8e:5f4a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae4c125sm2578731f8f.110.2024.11.14.14.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 14:18:00 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH v2 1/2] tinfoil: add new "finalizeData" API
Date: Thu, 14 Nov 2024 23:17:25 +0100
Message-Id: <20241114221725.3826753-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Nov 2024 22:18:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16801

From: Yoann Congal <yoann.congal@smile.fr>

Create a new tinfoil API "finalizeData" which does key expantion and
runs the anonymous functions to allow bitbake-getvar to have the same
output as "bitbake -e".

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
v1->v2: No change
---
 lib/bb/command.py | 8 ++++++++
 lib/bb/tinfoil.py | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 695277f1e..a63427660 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -24,6 +24,7 @@ import io
 import bb.event
 import bb.cooker
 import bb.remotedata
+import bb.parse
 
 class DataStoreConnectionHandle(object):
     def __init__(self, dsindex=0):
@@ -582,6 +583,13 @@ class CommandsSync:
         return DataStoreConnectionHandle(idx)
     parseRecipeFile.readonly = True
 
+    def finalizeData(self, command, params):
+        newdata = command.cooker.data.createCopy()
+        bb.data.expandKeys(newdata)
+        bb.parse.ast.runAnonFuncs(newdata)
+        idx = command.remotedatastores.store(newdata)
+        return DataStoreConnectionHandle(idx)
+
 class CommandsAsync:
     """
     A class of asynchronous commands
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index dcd3910cc..0e937fba3 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -633,6 +633,12 @@ class Tinfoil:
         fn = self.get_recipe_file(pn)
         return self.parse_recipe_file(fn)
 
+    def finalizeData(self):
+        """
+        Run anonymous functions and expand keys
+        """
+        return self._reconvert_type(self.run_command('finalizeData'), 'DataStoreConnectionHandle')
+
     def parse_recipe_file(self, fn, appends=True, appendlist=None, config_data=None):
         """
         Parse the specified recipe file (with or without bbappends)

