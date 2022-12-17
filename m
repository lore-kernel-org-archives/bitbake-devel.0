Return-Path: <yosuke.nky@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DA2C4167B
	for <webhook@archiver.kernel.org>; Sat, 17 Dec 2022 08:45:10 +0000 (UTC)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
 by mx.groups.io with SMTP id smtpd.web11.4009.1671266700951577278
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 17 Dec 2022 00:45:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=mUH31iFt;
 spf=pass (domain: gmail.com, ip: 209.85.216.47, mailfrom: yosuke.nky@gmail.com)
Received: by mail-pj1-f47.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so4621892pjd.0
        for <bitbake-devel@lists.openembedded.org>; Sat, 17 Dec 2022 00:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JzSaM3uP5giJbje1kSx0GzpYlzX52AwtpLfUHhA/zJk=;
        b=mUH31iFt8dhqeQ/wxJVs5H5QnRKAJrbNWIzoIPZFjvS5Qb6UNqJgfg6OzbPiGR98Jl
         2F4SSwU2m6koLHNz/UzdnZmDLB/3EXh1hTFtjDyZdgv+2cK6JjR6Dip2+EhZhbuHkP+I
         uBJW2dDP3zq9q72r4gyeZpPMsXfK54TZ5Th8cVQ7pQMvB5H8FcdM2/62XiBeCfTDJjro
         dYZXcvM3gdOvIgqRwAcl+1SJF8bgkp0W2H4w1cp69PDcYRyoHkZrI2Xgorp/kJRTV236
         45wqWQvPb8AqfFUaWx4KDv2wjzdV0b5y/0CDElCNPWiD80xWg61CHbCvtFxukqP8joTn
         0xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzSaM3uP5giJbje1kSx0GzpYlzX52AwtpLfUHhA/zJk=;
        b=6kA5q+D6e+LC378d9de/eVZNNoO2ohAHl07Miue98IMB8dJf2lbF5EOVwDl+RK4hRB
         S+MyoTRWeBxIDFPiZ+wRitLwdGYtxA4MXT76GOF3Wi4D6qMK2jsoBIDV/Ll68IDQBP8k
         6pkL610dr547OEJYcuIMxLv5m8MuO2v4yfxnfpOmzOP4M/h7K9/9wteAvGADxi6j6kW6
         DFHk86j47OBqiUB3sPxMQs6EYWUP6P013273ElfpsErEiMIrqw/kJfG6UI/5bfxr56/Z
         NueFAbO9nB/B7oAsesXhtkl705ZMACE8QuKs9h2a4uIQhhT+DMZWYI3D0CrA6wcdwZki
         ivyQ==
X-Gm-Message-State: ANoB5pmcFbX5xRhv2u2AA7JnuXETaPskf9iwtkimTRbaYxuBBjd2VYuP
	rBUlOSCYsqQV9Qir+LZz6dhOxzCNYoQ=
X-Google-Smtp-Source: AA0mqf5lFH3Pwcu8mEo8Hdr+2lbxJzaD1YRZ/iNYaZb9GnPRm9bLz3LgWjF3DEa4UIt68k2xWf69Uw==
X-Received: by 2002:a17:902:7104:b0:189:bf5d:c951 with SMTP id a4-20020a170902710400b00189bf5dc951mr33614647pll.26.1671266699992;
        Sat, 17 Dec 2022 00:44:59 -0800 (PST)
Received: from localhost.localdomain (147.142.237.160.cyberhome.jp. [160.237.142.147])
        by smtp.gmail.com with ESMTPSA id l16-20020a170902f69000b00186cd4a8aedsm2942855plg.252.2022.12.17.00.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Dec 2022 00:44:59 -0800 (PST)
From: yosuke.nky@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: "yosuke.nakayama" <yosuke.nky@gmail.com>
Subject: [PATCH] Enable to use some bitbake server commands
Date: Sat, 17 Dec 2022 17:44:54 +0900
Message-Id: <20221217084454.24346-1-yosuke.nky@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 17 Dec 2022 08:45:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14189

From: "yosuke.nakayama" <yosuke.nky@gmail.com>

Bitake server provides getRecipePackages, getRecipePackagesDynamic, getRProviders and dataStoreConnectorCmd.
getRecipePackages, getRecipePackagesDynamic and getRProviders always return data that can't be marshalled.
And dataStoreConnectorCmd also may return data that can't be marshalled, but this depends on sub command.
On the other hands, bitbake server uses xmlrpc module, but this supports only marshallizable data.
Therefore, when bitbake server returns data that can't be marshalled, xmlrpc raises an exception.
To fix this issue, this commit converts return-data to marshallizable data or None(if return-data can't be converted into marshallizable data)

Signed-off-by: yosuke.nakayama <yosuke.nky@gmail.com>
---
 bitbake/lib/bb/command.py | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index ec86885220..6efb5dfa26 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -21,6 +21,7 @@ Commands are queued in a CommandQueue
 from collections import OrderedDict, defaultdict
 
 import io
+import marshal
 import bb.event
 import bb.cooker
 import bb.remotedata
@@ -340,7 +341,7 @@ class CommandsSync:
             mc = params[0]
         except IndexError:
             mc = ''
-        return command.cooker.recipecaches[mc].packages
+        return CommandsSync.enable_marshel(command.cooker.recipecaches[mc].packages)
     getRecipePackages.readonly = True
 
     def getRecipePackagesDynamic(self, command, params):
@@ -348,7 +349,7 @@ class CommandsSync:
             mc = params[0]
         except IndexError:
             mc = ''
-        return command.cooker.recipecaches[mc].packages_dynamic
+        return CommandsSync.enable_marshel(command.cooker.recipecaches[mc].packages_dynamic)
     getRecipePackagesDynamic.readonly = True
 
     def getRProviders(self, command, params):
@@ -356,7 +357,7 @@ class CommandsSync:
             mc = params[0]
         except IndexError:
             mc = ''
-        return command.cooker.recipecaches[mc].rproviders
+        return CommandsSync.enable_marshel(command.cooker.recipecaches[mc].rproviders)
     getRProviders.readonly = True
 
     def getRuntimeDepends(self, command, params):
@@ -498,7 +499,7 @@ class CommandsSync:
             idx = command.remotedatastores.store(ret)
             return DataStoreConnectionHandle(idx)
 
-        return ret
+        return CommandsSync.enable_marshel(ret)
 
     def dataStoreConnectorVarHistCmd(self, command, params):
         dsindex = params[0]
@@ -573,6 +574,31 @@ class CommandsSync:
         return DataStoreConnectionHandle(idx)
     parseRecipeFile.readonly = True
 
+    @staticmethod
+    def enable_marshel(obj):
+        """
+        This function converts the data to be able to marshal as much as possible
+        because XML RPC can hands off only the data that can be marshalled.
+        """
+        try:
+            marshal.dumps(obj)
+            return obj
+        except Exception:
+            pass
+
+        try:
+            return dict(obj)
+        except Exception:
+            pass
+
+        try:
+            return list(obj)
+        except Exception:
+            pass
+
+        return None
+
+
 class CommandsAsync:
     """
     A class of asynchronous commands
-- 
2.34.1


