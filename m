Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2099CD59F72
	for <webhook@archiver.kernel.org>; Wed,  6 Nov 2024 20:25:49 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web10.56328.1730924748516350644
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Nov 2024 12:25:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=DI89zCtF;
 spf=pass (domain: smile.fr, ip: 209.85.128.43, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4314f38d274so2716825e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 Nov 2024 12:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1730924747; x=1731529547; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=USB7bbXoMouf7RKgITmndff3eUW/ofqh69jVZ4Sn7uQ=;
        b=DI89zCtF9J1S0RXD+8SPK6v4uu5P9qHIQ9HjkWpHWdpjC8JyZz/aXt2vrOg7EwdzPk
         iUUD/CEf6ZLKrv/ZRZ7ZhTyQKEosE7X+K4s8vfRfrti+7mS6GQ9NcB2EtyE8za8VjdD9
         cwjN1i3612PyxEnmmbZKXd+xhAJTu0dPCkPZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730924747; x=1731529547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=USB7bbXoMouf7RKgITmndff3eUW/ofqh69jVZ4Sn7uQ=;
        b=MVGZHxbZKEqYo8bbE2NHOnbX4jjnzIWFDaL/XrXTA58ZWtPZNkgOcA5n984bRugt8h
         CWmAwG6RHAY2uaa97XKeQBUzoVGwoT/KDKoAwt0h1mtx+Yra4k7Vm4GkGcWT/4CjPIRu
         YfQpsgmzqctHCP+2MKMmVj+do+c4SsV+IqjgB6BOQwkcZrsGf2LK/69h7ZzAMml3+DCO
         uruxR81hqW612oMPWc/yXWwAkkzaJq9q0gwd5FFYv4eADSBtL+IgH1TEM4D/rbXEvEV+
         YGuUjoz/hBSy8RIX4af3gUEZUAgx6DfrofN//UJpTx8nt2muGNCMYiHs0uR0UN4/kBMY
         6qHQ==
X-Gm-Message-State: AOJu0YzTryXOSysEqW5p5OXUlziWIzJ5lP5ix+f9bJS6IEHtAyqdB8+z
	UqJz5Evj7+dZb4TS2bvyyktK/bhiahsahBeYTH+Cw9gGFiMrKJmjja2pgnsADwnVh5zIFZsaezF
	v
X-Google-Smtp-Source: AGHT+IFklfdvMvOO99SN38V+38YrWaP7lLnmV6U7IfdYWqnnClYty6ohM8t0OZn1T+WDg3LS9Dk8mg==
X-Received: by 2002:a7b:c5cc:0:b0:431:5c7b:e939 with SMTP id 5b1f17b1804b1-43283255a38mr235985895e9.18.1730924746711;
        Wed, 06 Nov 2024 12:25:46 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.local (53.1.159.89.rev.sfr.net. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6c1205sm37611725e9.26.2024.11.06.12.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 12:25:46 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [RFC PATCH v2] bitbake-getvar: Expand keys and run anonymous functions to mirror "bitbake -e"
Date: Wed,  6 Nov 2024 21:25:32 +0100
Message-Id: <20241106202531.1701148-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Nov 2024 20:25:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16788

From: Yoann Congal <yoann.congal@smile.fr>

Create a new tinfoil API "finalizeData" which does key expantion and
runs the anonymous function to allow bitbake-getvar to have the same
output as "bitbake -e"

Fixes [YOCTO #15638]

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
RFC:
* Return type of the API is currently a bb.data_smart.DataSmart instead
  of the expected bb.tinfoil.TinfoilDataStoreConnector because it is
  faster in my tests.
* Tinfoil API adding and bb-getvar usage should be split in separate
  commits.
* That bug most likely need a non-regression test.
---
 bin/bitbake-getvar | 4 ++++
 lib/bb/command.py  | 7 +++++++
 lib/bb/tinfoil.py  | 7 +++++++
 3 files changed, 18 insertions(+)

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
index 1fcb9bf14..8d01a9e5f 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -24,6 +24,7 @@ import io
 import bb.event
 import bb.cooker
 import bb.remotedata
+import bb.parse
 
 class DataStoreConnectionHandle(object):
     def __init__(self, dsindex=0):
@@ -582,6 +583,12 @@ class CommandsSync:
         return DataStoreConnectionHandle(idx)
     parseRecipeFile.readonly = True
 
+    def finalizeData(self, command, params):
+        newdata = command.cooker.data.createCopy()
+        bb.data.expandKeys(newdata)
+        bb.parse.ast.runAnonFuncs(newdata)
+        return newdata
+
 class CommandsAsync:
     """
     A class of asynchronous commands
diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index dcd3910cc..35c65cb88 100644
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
+        return self.run_command('finalizeData')
+
     def parse_recipe_file(self, fn, appends=True, appendlist=None, config_data=None):
         """
         Parse the specified recipe file (with or without bbappends)

