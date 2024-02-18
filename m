Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECACEC54764
	for <webhook@archiver.kernel.org>; Sun, 18 Feb 2024 23:00:25 +0000 (UTC)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
 by mx.groups.io with SMTP id smtpd.web11.29240.1708297220867705602
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Feb 2024 15:00:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BL1KjL+h;
 spf=pass (domain: gmail.com, ip: 209.85.166.53, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7c490498729so196268039f.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 15:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708297219; x=1708902019; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViAjo++gezT/3CcFCrEr+3T0+/E/MsB50nX8c9ej3uE=;
        b=BL1KjL+h5LyHQ1UQeYxjqBNKZCUDiZLjuiZxIIF7/nZLMyrgRabVbwFN5651jfT33w
         yCp2Gzxlsqbyxrt3ekXCHc2AJNRikTSMqmafzjrkiO0ye6UP87f7ZrHGrWSRN1LUyNvB
         yI0ILjycxQerWOO7pIpkRqwflz0ijeI7LV4ualFx93ruT4lEPBb9g+QndjOzNq2z2wID
         yJ/jkOjDVkH7iHTAd20GQL2kgjVKxNH0D9oITASruM7Y8e97elwbR3a70wwFh42/o7Ot
         qL6fbx1YayIhd906LVgY0FJD9mv/Asy4Mj/lHfrGWkd8XB8ImS8Rn7Ew7uapzyg8/TzE
         pX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708297219; x=1708902019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ViAjo++gezT/3CcFCrEr+3T0+/E/MsB50nX8c9ej3uE=;
        b=vRr6rupyyu+LKIY/MRkbEvBqq9YkRTc2fUYuKZNKiYAJXKdPWrHZaczpKsRonnlBon
         dNmJiCb+tybeY1lj206W6VcEXuJV53bEwfsOLKsvZDfG3rBWuXY9kLAlHDl/Etq0fyAh
         f+8kKPnXHm7FPUah+arh3dCv2SOrkRx/KwN8xDEwXbI8z3/4TUfFNn7j464/Dt4PRdim
         MV4U9utu0gYoZDbk6mrHhZr3IZs2dyq6AGoQZtDw1MRaG0HKKydbRdWzjQLjXsdjZ327
         oAtjST/MxU8omo2YeQ8Hz8dF+wDnXj28YLCqq/pthAy/MZeE3WUtYehatd9T7EiDlmMY
         xoMg==
X-Gm-Message-State: AOJu0YwpL5y4u4ftRKf+ptzMwLCnvTFUFPMy2xE2pvrmg5mfN4pOwOFQ
	02zdnQRDiqMhbABLKM+LWDCKyCd2gemTrbfstkYInBL45XjBHnHY0Ls9zEwY
X-Google-Smtp-Source: AGHT+IGfpEhnl0ZG7SEcJvoshhDycjMf3X/iqd1SuwZi0OqCOT89jb9PTzHwyg4o6/tL5C6QGT+eUg==
X-Received: by 2002:a05:6602:1c96:b0:7c4:5ea2:6d8b with SMTP id hf22-20020a0566021c9600b007c45ea26d8bmr12803355iob.8.1708297217748;
        Sun, 18 Feb 2024 15:00:17 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::44fb])
        by smtp.gmail.com with ESMTPSA id n3-20020a02cc03000000b004712a778fb4sm1214848jap.28.2024.02.18.15.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 15:00:16 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Tobias Hagelborn <tobias.hagelborn@axis.com>,
	Tobias Hagelborn <tobiasha@axis.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 8/8] bitbake: hashserv: Postgres adaptations for ignoring duplicate inserts
Date: Sun, 18 Feb 2024 15:59:53 -0700
Message-Id: <20240218225953.2997239-9-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218225953.2997239-1-JPEWhacker@gmail.com>
References: <20240218200743.2982923-1-JPEWhacker@gmail.com>
 <20240218225953.2997239-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 23:00:25 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15930

From: Tobias Hagelborn <tobias.hagelborn@axis.com>

Hash Equivalence server performs unconditional insert also of duplicate
hash entries. This causes excessive error log entries in Postgres.
Rather ignore the duplicate inserts.

The alternate behavior should be isolated to the postgres
engine type.

Signed-off-by: Tobias Hagelborn <tobiasha@axis.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/sqlalchemy.py | 53 +++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/bitbake/lib/hashserv/sqlalchemy.py b/bitbake/lib/hashserv/sqlalchemy.py
index 0e28d738f5a..fc3ae3d3396 100644
--- a/bitbake/lib/hashserv/sqlalchemy.py
+++ b/bitbake/lib/hashserv/sqlalchemy.py
@@ -33,6 +33,7 @@ from sqlalchemy import (
 import sqlalchemy.engine
 from sqlalchemy.orm import declarative_base
 from sqlalchemy.exc import IntegrityError
+from sqlalchemy.dialects.postgresql import insert as postgres_insert
 
 Base = declarative_base()
 
@@ -283,9 +284,7 @@ class Database(object):
     async def unihash_exists(self, unihash):
         async with self.db.begin():
             result = await self._execute(
-                select(UnihashesV3)
-                .where(UnihashesV3.unihash == unihash)
-                .limit(1)
+                select(UnihashesV3).where(UnihashesV3.unihash == unihash).limit(1)
             )
 
             return result.first() is not None
@@ -435,18 +434,30 @@ class Database(object):
             return result.rowcount
 
     async def insert_unihash(self, method, taskhash, unihash):
-        try:
-            async with self.db.begin():
-                await self._execute(
-                    insert(UnihashesV3).values(
-                        method=method,
-                        taskhash=taskhash,
-                        unihash=unihash,
-                        gc_mark=self._get_config_subquery("gc-mark", ""),
-                    )
+        # Postgres specific ignore on insert duplicate
+        if self.engine.name == "postgresql":
+            statement = (
+                postgres_insert(UnihashesV3)
+                .values(
+                    method=method,
+                    taskhash=taskhash,
+                    unihash=unihash,
+                    gc_mark=self._get_config_subquery("gc-mark", ""),
                 )
+                .on_conflict_do_nothing(index_elements=("method", "taskhash"))
+            )
+        else:
+            statement = insert(UnihashesV3).values(
+                method=method,
+                taskhash=taskhash,
+                unihash=unihash,
+                gc_mark=self._get_config_subquery("gc-mark", ""),
+            )
 
-            return True
+        try:
+            async with self.db.begin():
+                result = await self._execute(statement)
+                return result.rowcount != 0
         except IntegrityError:
             self.logger.debug(
                 "%s, %s, %s already in unihash database", method, taskhash, unihash
@@ -461,10 +472,22 @@ class Database(object):
         if "created" in data and not isinstance(data["created"], datetime):
             data["created"] = datetime.fromisoformat(data["created"])
 
+        # Postgres specific ignore on insert duplicate
+        if self.engine.name == "postgresql":
+            statement = (
+                postgres_insert(OuthashesV2)
+                .values(**data)
+                .on_conflict_do_nothing(
+                    index_elements=("method", "taskhash", "outhash")
+                )
+            )
+        else:
+            statement = insert(OuthashesV2).values(**data)
+
         try:
             async with self.db.begin():
-                await self._execute(insert(OuthashesV2).values(**data))
-            return True
+                result = await self._execute(statement)
+                return result.rowcount != 0
         except IntegrityError:
             self.logger.debug(
                 "%s, %s already in outhash database", data["method"], data["outhash"]
-- 
2.34.1


