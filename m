Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E63E67807
	for <webhook@archiver.kernel.org>; Sat,  2 Nov 2024 16:22:00 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web10.19992.1730564514467651654
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 02 Nov 2024 09:21:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=g3lscPwY;
 spf=pass (domain: smile.fr, ip: 209.85.128.46, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-431481433bdso25209875e9.3
        for <bitbake-devel@lists.openembedded.org>; Sat, 02 Nov 2024 09:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1730564512; x=1731169312; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V2fwjCy9h4ZZhgDUd/yaT0y6M28t6Acd+56HRaGfBng=;
        b=g3lscPwYw+kynGHi4S1Dj6Nipr/cTVx9Z1LNS+4EMlH0FNMyqNE1uHIqGccNehoeB4
         FldwP52laYuysWRv+GkQGeQUFp+AE5RHPwNdnLk2oz+f8d6wwEaxCUO6eXMKbcAXnll1
         kFo7hLUD1x/Rx8mlTb6hXjpjN39NXkVsp7Eso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730564512; x=1731169312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2fwjCy9h4ZZhgDUd/yaT0y6M28t6Acd+56HRaGfBng=;
        b=Cx/045s5H+GIsM33sUimhc7yVLdGvKTXUq65OzH6bAvSgS2R0zC2AB9UwhoUP0YqDQ
         ujZwDQyW4YO3Ug7trpuUCbpvppLnBh6G3RxyShr4+p5UTB2zLu91rkjcyoWPsooLyIQ1
         4xvMGsPHMtTlb8UGz8TUIydtqBat8+MpDZvEA9h/YwHpNhi0mMCdwPZfyXziWdShD0CB
         Lgkx0gYwFo3exrG76YTL9cUVL+Tm0gNmDilzGhqZnPpc6LWZRgr7RcaRCasoOPpLlI5m
         MLH31ThXDG9hCIKs/F+8zGRHyr3WJ4bbto1EnVCH5tVl2mgp4NKHdhAHCg/uKVhfZKyA
         tgnA==
X-Gm-Message-State: AOJu0YybJwoyKe2JPwFmrXS+oVasl6DlnNV9ds5JMwDzpePjLuddWsId
	anDxXGqRqJRiXTzor13XxBMSG+Y/JmOq929/ImHqPg2iESRP50ko7Ta7mA8w+A5BxL1a0ELoLBf
	0
X-Google-Smtp-Source: AGHT+IE80rVKj/Mbup3Tc8Ezeboo7N8FYBzFa5/Snv288m1IKM6ZhIxDdjTSsOUDpWmW1N+oBc58zw==
X-Received: by 2002:a05:6000:42c2:b0:37d:f4b:b6ab with SMTP id ffacd0b85a97d-381bea29202mr7025956f8f.59.1730564512469;
        Sat, 02 Nov 2024 09:21:52 -0700 (PDT)
Received: from P-ASN-ECS-830T8C3.local (53.1.159.89.rev.sfr.net. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113e6b5sm8517566f8f.88.2024.11.02.09.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 09:21:52 -0700 (PDT)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [RFC PATCH] bitbake-getvar: Expand keys and run anonymous functions to get identical result to "bitbake -e"
Date: Sat,  2 Nov 2024 17:21:25 +0100
Message-Id: <20241102162124.2048662-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 02 Nov 2024 16:22:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16771

From: Yoann Congal <yoann.congal@smile.fr>

With this path, outputs of
  bitbake-getvar DISTRO_FEATURES
and
  bitbake -e |grep '^DISTRO_FEATURES='
are the same.

Fixes [YOCTO #15638]

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>

---
RFC:
* I don't know if a "sync command" is the right choice here.
* Maybe the runAnonFunc call needs to be more integrated in the default
  flow?
---
 bin/bitbake-getvar | 5 +++++
 lib/bb/command.py  | 4 ++++
 lib/bb/tinfoil.py  | 6 ++++++
 3 files changed, 15 insertions(+)

diff --git a/bin/bitbake-getvar b/bin/bitbake-getvar
index 8901f99ae..1002d827b 100755
--- a/bin/bitbake-getvar
+++ b/bin/bitbake-getvar
@@ -45,6 +45,11 @@ if __name__ == "__main__":
             tinfoil.prepare(quiet=2, config_only=True)
             d = tinfoil.config_data
 
+        # Expand keys and run anonymous functions to get identical result to
+        # "bitbake -e"
+        bb.data.expandKeys(d)
+        tinfoil.runAnonFuncs()
+
         value = None
         if args.flag:
             value = d.getVarFlag(args.variable, args.flag, expand=not args.unexpand)
diff --git a/lib/bb/command.py b/lib/bb/command.py
index 1fcb9bf14..27e99a584 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -24,6 +24,7 @@ import io
 import bb.event
 import bb.cooker
 import bb.remotedata
+import bb.parse
 
 class DataStoreConnectionHandle(object):
     def __init__(self, dsindex=0):
@@ -582,6 +583,9 @@ class CommandsSync:
         return DataStoreConnectionHandle(idx)
     parseRecipeFile.readonly = True
 
+    def runAnonFuncs(self, command, params):
+        bb.parse.ast.runAnonFuncs(command.cooker.data)
+
 class CommandsAsync:
     """
     A class of asynchronous commands
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index dcd3910cc..4d6d07539 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -633,6 +633,12 @@ class Tinfoil:
         fn = self.get_recipe_file(pn)
         return self.parse_recipe_file(fn)
 
+    def runAnonFuncs(self):
+        """
+        Run anonymous functions
+        """
+        self.run_command('runAnonFuncs')
+
     def parse_recipe_file(self, fn, appends=True, appendlist=None, config_data=None):
         """
         Parse the specified recipe file (with or without bbappends)

