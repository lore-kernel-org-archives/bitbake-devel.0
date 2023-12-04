Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5F4C4167B
	for <webhook@archiver.kernel.org>; Mon,  4 Dec 2023 16:03:53 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
 by mx.groups.io with SMTP id smtpd.web10.73229.1701705831499802700
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Dec 2023 08:03:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QkhnM/l1;
 spf=pass (domain: gmail.com, ip: 209.85.210.53, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6d8751c8e7eso1890076a34.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 04 Dec 2023 08:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701705829; x=1702310629; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4YWZSDhSPOKmhju5Bu4OGC1TaE8rYED83Dgmr5GMkeE=;
        b=QkhnM/l1UV8Rh1OoTABxjLCOCoIwZKcsK2Zop4C6sqWihUPTqy72/4bXn66im2JfPb
         P0zAT0QOYV5qIlAJYlFTMS8DUnKxYta97uZgGxjLVa4ZoCvsAwPknyu8Ll/EDQ6a2vJM
         xM5mGX+9DqkZQ9nPzj4lphtVcQALNMIKX6A9olveI0IE/AP4uniojGbTN80g7T2ekMi5
         s/QnEBYrGi5QkPnwfqvvbFlSOUgT28bl2hCW1/4uNI+UPIY/t22lfukNN2L/2EIfg7DU
         JLgvSgXUo+aLoykBjrMsUb3YgzVWuETc98V3ZDLsp5vsjn5OEKkIlWPt1fq3oCAZwcp/
         YX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701705829; x=1702310629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4YWZSDhSPOKmhju5Bu4OGC1TaE8rYED83Dgmr5GMkeE=;
        b=oi3y0K+yIH3K2dSzmyuR/d1D9sR++EgQ48kpc0j8DrJZnsFrGd+DOfKPSGmEe043Bu
         P7AiDIC8DPxDcoW43OAcXMnm7ZtydMChljkk7DpYOrGkQ/KGBKiBvvRhtASIRdlAKd0j
         W+DTidrAoHaaTPV5R0dHWMBX1bJRPB5K6OHsK0xeYkeDwI+f31n+08QLvdWjdYmaocM0
         015iuJ710CqItcqHNtU7wFfn/XHZ+VVajVmabPgLuXiZMP8qTuuWM3+69Znol860k+/g
         9zm3TZMeGAlui8QaTvJ/AWx9ObBxy0Xz3rJmsIoiavNuZICfyFKszbFjf++fP7E3XDhe
         +Z1w==
X-Gm-Message-State: AOJu0Ywu59QpJb/tq6nXqd3bkPtq+D7/mYzegXeQLTAIvXImneJ/Sr9P
	P3JoIDwl2xAQr22LKIjoyCNY5+sJ6OI=
X-Google-Smtp-Source: AGHT+IEtA6Toq4RD9KS5Jvl6IKTF1TQ9ii5xZ8CX/wwmiu/xrgBk9DDDINe0tvf1w/5oqy2FNkbJjw==
X-Received: by 2002:a05:6870:494b:b0:1fb:220f:4ec5 with SMTP id fl11-20020a056870494b00b001fb220f4ec5mr3282214oab.31.1701705829668;
        Mon, 04 Dec 2023 08:03:49 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::9c3a])
        by smtp.gmail.com with ESMTPSA id pk28-20020a0568704c1c00b001fafc32e808sm2161548oab.0.2023.12.04.08.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 08:03:49 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] hashserv: sqlite: Ensure sync propagates to database connections
Date: Mon,  4 Dec 2023 09:03:43 -0700
Message-Id: <20231204160343.1373871-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Dec 2023 16:03:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15606

When the sqlite database backend was restructured, the code to make the
databases run in WAL mode and to control if sync() is called was
accidentally dropped. This caused terrible database performance to the
point that server timeouts were occurring causing really slow builds.

Fix this by properly enabling WAL mode and setting the synchronous flag
as requested

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/sqlite.py | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/hashserv/sqlite.py b/bitbake/lib/hashserv/sqlite.py
index f65036be939..f93cb2c1dd9 100644
--- a/bitbake/lib/hashserv/sqlite.py
+++ b/bitbake/lib/hashserv/sqlite.py
@@ -109,11 +109,11 @@ class DatabaseEngine(object):
             )
 
     def connect(self, logger):
-        return Database(logger, self.dbname)
+        return Database(logger, self.dbname, self.sync)
 
 
 class Database(object):
-    def __init__(self, logger, dbname, sync=True):
+    def __init__(self, logger, dbname, sync):
         self.dbname = dbname
         self.logger = logger
 
@@ -121,6 +121,11 @@ class Database(object):
         self.db.row_factory = sqlite3.Row
 
         with closing(self.db.cursor()) as cursor:
+            cursor.execute("PRAGMA journal_mode = WAL")
+            cursor.execute(
+                "PRAGMA synchronous = %s" % ("NORMAL" if sync else "OFF")
+            )
+
             cursor.execute("SELECT sqlite_version()")
 
             version = []
-- 
2.34.1


