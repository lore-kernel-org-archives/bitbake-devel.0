Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77139D59F75
	for <webhook@archiver.kernel.org>; Wed,  6 Nov 2024 20:55:29 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.56756.1730926523897790420
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Nov 2024 12:55:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=1tTMDmY3;
 spf=pass (domain: smile.fr, ip: 209.85.128.51, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-431ac30d379so2050465e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 Nov 2024 12:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1730926522; x=1731531322; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vztkt8lzR679tnuE7fBmHNLRh4On484S8joacaKSqzE=;
        b=1tTMDmY3XP7TVFP0Vzwes9QEtGj0u/PhzHl7cQa6M9on7iyRwaUQoX7/zy8NpkmJ2z
         Pr8DwM7S3j2HbMHJAjXOJZ4G0aMxAON8xWAIgL4dsVv2R2xbuALtKKKZJBg5Q0KoAlsQ
         azEiDffC2PJ8oPFxThXciUDbXDH6iCXjVHzpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730926522; x=1731531322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vztkt8lzR679tnuE7fBmHNLRh4On484S8joacaKSqzE=;
        b=NBmR29JGysM5YAeMXPjHUH4Fua9uhojZ0jnEdkGZx2ILv6jFo9vi1shOKVKlXXdWQq
         jTtDqtw1mkx0g95hwIPK+myuYIT6Rzv/VlC/Q+bN7zEXj6Vtb2eB5MmpqK31vhiiGuGu
         MNTg5UJGyhvabcqXVkwp1gafryzPd62bCMZPbvQNDiW8xoXtORdb1KsQEjfmf/ymcFdC
         6/BLQ5xpCkI4u4FFsKJrKC6T6EKzxIqUot6edVN6fv7j1Rq7kwbg630AhzEtCczWNtAI
         b753h/T3ELCi0PvZDbBkpDeas3VDg5t6cNYUMtu2DGv4R3Iyc+h+TOLvcFrnYn8R7Gbo
         ztgg==
X-Gm-Message-State: AOJu0YxPbcg3av95VOlyt+5Q3v6A7K9nuwuhvHyZ+k7aRTHbLkG0wA+N
	wgbfnk3slalmP4PVMPBZTnWg5ov7DgPHdsxj+fgWXyaOJnZ95LWO82XwIj4x5SKhsbEF0g+4MmZ
	C
X-Google-Smtp-Source: AGHT+IFxU7pXRNaIV8KrZLx+ncjdPU/9oYV7cbc+MKzYIvCRYALPlTVD5cFiBYMv4mY1kOv74PNlbQ==
X-Received: by 2002:a05:600c:1d1c:b0:431:55bf:fe4 with SMTP id 5b1f17b1804b1-431b17365ffmr299776625e9.24.1730926521726;
        Wed, 06 Nov 2024 12:55:21 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.local (53.1.159.89.rev.sfr.net. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6da58fsm35132235e9.28.2024.11.06.12.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 12:55:21 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [RFC PATCH v3] bitbake-getvar: Expand keys and run anonymous functions to get identical result to "bitbake -e" (Connector version)
Date: Wed,  6 Nov 2024 21:54:45 +0100
Message-Id: <20241106205444.1706448-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Nov 2024 20:55:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16789

From: Yoann Congal <yoann.congal@smile.fr>

Create a new tinfoil API "finalizeData" which does key expantion and
runs the anonymous function to allow bitbake-getvar to have the same
output as "bitbake -e"

Fixes [YOCTO #15638]

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
RFC:
* In this version the API returns a connector and not a full object.
* Tinfoil API adding and bb-getvar usage should be split in separate
  commits.
* That bug most likely need a non-regression test.
---
 bin/bitbake-getvar | 4 ++++
 lib/bb/command.py  | 8 ++++++++
 lib/bb/tinfoil.py  | 7 +++++++
 3 files changed, 19 insertions(+)

diff --git a/bin/bitbake-getvar b/bin/bitbake-getvar
index 8901f99ae..bc0b989c8 100755
--- a/bin/bitbake-getvar
+++ b/bin/bitbake-getvar
@@ -45,6 +45,10 @@ if __name__ == "__main__":
             tinfoil.prepare(quiet=2, config_only=True)
             d = tinfoil.config_data
 
+        # Expand keys and run anonymous functions to get identical result to
+        # "bitbake -e"
+        d = tinfoil.finalizeData()
+
         value = None
         if args.flag:
             value = d.getVarFlag(args.variable, args.flag, expand=not args.unexpand)
diff --git a/lib/bb/command.py b/lib/bb/command.py
index 1fcb9bf14..3d094fc34 100644
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
index dcd3910cc..98f002af5 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -25,6 +25,7 @@ import bb.command
 import bb.remotedata
 from bb.main import setup_bitbake, BitBakeConfigParameters
 import bb.fetch2
+import bb.parse
 
 
 # We need this in order to shut down the connection to the bitbake server,
@@ -633,6 +634,12 @@ class Tinfoil:
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

