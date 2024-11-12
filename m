Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A55D597B6
	for <webhook@archiver.kernel.org>; Tue, 12 Nov 2024 23:06:30 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
 by mx.groups.io with SMTP id smtpd.web11.100834.1731452788596694523
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Nov 2024 15:06:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=KCVnVRzf;
 spf=pass (domain: smile.fr, ip: 209.85.167.49, mailfrom: yoann.congal@smile.fr)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53d9ff8f1e4so280085e87.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 12 Nov 2024 15:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1731452786; x=1732057586; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SbN6Ht5Hn6EK2eXW/S3jvDIbSbb/cgoTWhjlOK5dObM=;
        b=KCVnVRzf8SRTZ2agVci7fd6rHQz8W7o7ni4OzPBR5SG+/rjEyHURSgKcxTA0sVnBhR
         DzkaTXQGXjyeQoOoGA6rJ5c7l0NWruqXMfVVBpaSuDxBZagkoS6VjJ5xVNVCc4sVquZg
         ySrD9Ht5gmZT5Vsc+mV5m9wCwNOnyv33biPXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731452786; x=1732057586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SbN6Ht5Hn6EK2eXW/S3jvDIbSbb/cgoTWhjlOK5dObM=;
        b=tzuToUODivfH0CRVLGoRJOYKoKqgWmbwV4A5n7WMQd3QGY+nnrfIZGZz0d3oxAKVYZ
         O6oTu9yUyxS/45milRg11VYCPom5mCLa5wD2ApXLj8v0eXPqXr9+K1cGZ8Eos9lJHmL7
         2tRq3l8w2ZPlQs1nvghJ634BKg+FkIV2frQtx3pBQvUkMbHnqIHrFu7qZ5c1pyXPOE+k
         s74XZDf4TWAaIbGniIGn9BoI20zPjmFdl4Crmp+WHBAZMiv5x9EtHx9MdhJ80LwT93li
         9ZioAmqqreJem8qQSSGVEZkTVMnSMvquxYpd4amxD2fzIo3Yn6VhteILefH8LkrndO7O
         ldIQ==
X-Gm-Message-State: AOJu0YwWt4cnh23BunJgcvskft2E7ADixXM/ofyKopEY9khOyBaqU0ZL
	mMWf5ShlrTjManjHYdUPfUxjySY9C+L+nSIqiDiB/jMBstkvz0AGT2458T5alCHsQ7RmLuCcpwO
	q
X-Google-Smtp-Source: AGHT+IGQoh3rME9CHvyx8a/5mBCDs5LTaL390cqyA8FTkHoYzEQOqRYDcIqAjB4PlD7BQtXdzPlVAw==
X-Received: by 2002:a05:6512:23a0:b0:52e:9cc7:4461 with SMTP id 2adb3069b0e04-53d862cd266mr8862792e87.5.1731452785918;
        Tue, 12 Nov 2024 15:06:25 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.local (53.1.159.89.rev.sfr.net. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d550c505sm2283635e9.33.2024.11.12.15.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 15:06:25 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH 1/2] tinfoil: add new "finalizeData" API
Date: Wed, 13 Nov 2024 00:05:58 +0100
Message-Id: <20241112230559.2035910-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Nov 2024 23:06:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16793

From: Yoann Congal <yoann.congal@smile.fr>

Create a new tinfoil API "finalizeData" which does key expantion and
runs the anonymous functions to allow bitbake-getvar to have the same
output as "bitbake -e".

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 lib/bb/command.py | 8 ++++++++
 lib/bb/tinfoil.py | 6 ++++++
 2 files changed, 14 insertions(+)

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

