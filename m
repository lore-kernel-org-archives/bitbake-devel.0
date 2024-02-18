Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C980AC54766
	for <webhook@archiver.kernel.org>; Sun, 18 Feb 2024 23:00:15 +0000 (UTC)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
 by mx.groups.io with SMTP id smtpd.web10.29044.1708297208134139715
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Feb 2024 15:00:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=KJWZH7tT;
 spf=pass (domain: gmail.com, ip: 209.85.166.50, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7c72294e3d1so131429439f.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 15:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708297206; x=1708902006; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaTwCVBHiMp2WMJhdaju/OW/ME4sPP5hS8BJw1s907w=;
        b=KJWZH7tTHfMqYiEcqM0FehHl/u8MCsMLjRdvFHw/GBWf/8k1bOAkMDHnqwEPshZjyh
         cl7IxTLvfC775H6DlNQfOTVTEBlidAEH7sfusY6P6YYSwSRkn1/wzKN22BuhMbs6Pt+f
         vgFaRvIG+Fpg1KJHUbStnOG945BN1PkcVn4XOzxNOzzASI32tSQu0nbk1Z7UcoyCNdJc
         E2RVJ4oX6O4wAMUAGPSb/E0RDJbSWgbiFEt2iIS0nNj0q/fU8nqfc8p2AKRt7qI2B0LZ
         uW5+NwhOjoIo6m6oVcr8sFqML5X/ap6rKp/Pnp84VdBkV0450vDEcl0tmx44Kiiz8G5C
         gFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708297206; x=1708902006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaTwCVBHiMp2WMJhdaju/OW/ME4sPP5hS8BJw1s907w=;
        b=fxbxr/looFjk1BM2mjXVpcZZdM/6HbUYx2ESJ11WfgoLCryRSNrI4BzkP4I4lKUbrH
         rW3/6iMCIQRDHiXr5P8jJGsnH1gdUHOTCPcosF//2iEHTYiVX7dSC5oNlcp74L67VjcX
         qEVWxC0DsjQ5GtcD///8CEtKTQecsWZgM15KL4vYPwkcSCQ6j8n5wOyz5H0Uyg269xto
         eSTgoLze7DNtiqXIcEZIlGTkq0Se2Z2/jFvXJ5/Yj5y8tq9XJeSoM9S9pMDgvix+/51t
         00jUFGdWNU0N9Evy9FJ6SOWSGBQ03VNFZ2/OOdbDpbvBj2XpliQTAi0/BdBqJRyqeblo
         +fXQ==
X-Gm-Message-State: AOJu0YxKQ0V3drgItUs1DpD3KvgI/prpjr/gVbG9p30jn0a2PNLkEkMa
	MVIgeWRo+Fk/0e/nsWLF9SnsKe0FRUApLRrNzgrRHACqL0GzcE9LHc82P5BZ
X-Google-Smtp-Source: AGHT+IH4FbQ9KT7sy4tZfztv4Q/fY7dHpCocs9tr61uThv/zfe5JCwXfZkB8OHLDa4zQHKiATtespw==
X-Received: by 2002:a6b:6d16:0:b0:7c7:22c3:12a0 with SMTP id a22-20020a6b6d16000000b007c722c312a0mr11258iod.13.1708297205734;
        Sun, 18 Feb 2024 15:00:05 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::44fb])
        by smtp.gmail.com with ESMTPSA id n3-20020a02cc03000000b004712a778fb4sm1214848jap.28.2024.02.18.15.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 15:00:05 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v2 2/8] hashserv: sqlalchemy: Use _execute() helper
Date: Sun, 18 Feb 2024 15:59:47 -0700
Message-Id: <20240218225953.2997239-3-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218225953.2997239-1-JPEWhacker@gmail.com>
References: <20240218200743.2982923-1-JPEWhacker@gmail.com>
 <20240218225953.2997239-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 23:00:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15924

Use the _execute() helper to execute queries. This helper does the
logging of the statement that was being done manually everywhere.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/sqlalchemy.py | 297 ++++++++++++++---------------
 1 file changed, 140 insertions(+), 157 deletions(-)

diff --git a/bitbake/lib/hashserv/sqlalchemy.py b/bitbake/lib/hashserv/sqlalchemy.py
index 89a6b86d9d8..873547809a0 100644
--- a/bitbake/lib/hashserv/sqlalchemy.py
+++ b/bitbake/lib/hashserv/sqlalchemy.py
@@ -233,124 +233,113 @@ class Database(object):
         return row.value
 
     async def get_unihash_by_taskhash_full(self, method, taskhash):
-        statement = (
-            select(
-                OuthashesV2,
-                UnihashesV3.unihash.label("unihash"),
-            )
-            .join(
-                UnihashesV3,
-                and_(
-                    UnihashesV3.method == OuthashesV2.method,
-                    UnihashesV3.taskhash == OuthashesV2.taskhash,
-                ),
-            )
-            .where(
-                OuthashesV2.method == method,
-                OuthashesV2.taskhash == taskhash,
-            )
-            .order_by(
-                OuthashesV2.created.asc(),
-            )
-            .limit(1)
-        )
-        self.logger.debug("%s", statement)
         async with self.db.begin():
-            result = await self.db.execute(statement)
+            result = await self._execute(
+                select(
+                    OuthashesV2,
+                    UnihashesV3.unihash.label("unihash"),
+                )
+                .join(
+                    UnihashesV3,
+                    and_(
+                        UnihashesV3.method == OuthashesV2.method,
+                        UnihashesV3.taskhash == OuthashesV2.taskhash,
+                    ),
+                )
+                .where(
+                    OuthashesV2.method == method,
+                    OuthashesV2.taskhash == taskhash,
+                )
+                .order_by(
+                    OuthashesV2.created.asc(),
+                )
+                .limit(1)
+            )
             return map_row(result.first())
 
     async def get_unihash_by_outhash(self, method, outhash):
-        statement = (
-            select(OuthashesV2, UnihashesV3.unihash.label("unihash"))
-            .join(
-                UnihashesV3,
-                and_(
-                    UnihashesV3.method == OuthashesV2.method,
-                    UnihashesV3.taskhash == OuthashesV2.taskhash,
-                ),
-            )
-            .where(
-                OuthashesV2.method == method,
-                OuthashesV2.outhash == outhash,
-            )
-            .order_by(
-                OuthashesV2.created.asc(),
-            )
-            .limit(1)
-        )
-        self.logger.debug("%s", statement)
         async with self.db.begin():
-            result = await self.db.execute(statement)
+            result = await self._execute(
+                select(OuthashesV2, UnihashesV3.unihash.label("unihash"))
+                .join(
+                    UnihashesV3,
+                    and_(
+                        UnihashesV3.method == OuthashesV2.method,
+                        UnihashesV3.taskhash == OuthashesV2.taskhash,
+                    ),
+                )
+                .where(
+                    OuthashesV2.method == method,
+                    OuthashesV2.outhash == outhash,
+                )
+                .order_by(
+                    OuthashesV2.created.asc(),
+                )
+                .limit(1)
+            )
             return map_row(result.first())
 
     async def get_outhash(self, method, outhash):
-        statement = (
-            select(OuthashesV2)
-            .where(
-                OuthashesV2.method == method,
-                OuthashesV2.outhash == outhash,
-            )
-            .order_by(
-                OuthashesV2.created.asc(),
-            )
-            .limit(1)
-        )
-
-        self.logger.debug("%s", statement)
         async with self.db.begin():
-            result = await self.db.execute(statement)
+            result = await self._execute(
+                select(OuthashesV2)
+                .where(
+                    OuthashesV2.method == method,
+                    OuthashesV2.outhash == outhash,
+                )
+                .order_by(
+                    OuthashesV2.created.asc(),
+                )
+                .limit(1)
+            )
             return map_row(result.first())
 
     async def get_equivalent_for_outhash(self, method, outhash, taskhash):
-        statement = (
-            select(
-                OuthashesV2.taskhash.label("taskhash"),
-                UnihashesV3.unihash.label("unihash"),
-            )
-            .join(
-                UnihashesV3,
-                and_(
-                    UnihashesV3.method == OuthashesV2.method,
-                    UnihashesV3.taskhash == OuthashesV2.taskhash,
-                ),
-            )
-            .where(
-                OuthashesV2.method == method,
-                OuthashesV2.outhash == outhash,
-                OuthashesV2.taskhash != taskhash,
-            )
-            .order_by(
-                OuthashesV2.created.asc(),
-            )
-            .limit(1)
-        )
-        self.logger.debug("%s", statement)
         async with self.db.begin():
-            result = await self.db.execute(statement)
+            result = await self._execute(
+                select(
+                    OuthashesV2.taskhash.label("taskhash"),
+                    UnihashesV3.unihash.label("unihash"),
+                )
+                .join(
+                    UnihashesV3,
+                    and_(
+                        UnihashesV3.method == OuthashesV2.method,
+                        UnihashesV3.taskhash == OuthashesV2.taskhash,
+                    ),
+                )
+                .where(
+                    OuthashesV2.method == method,
+                    OuthashesV2.outhash == outhash,
+                    OuthashesV2.taskhash != taskhash,
+                )
+                .order_by(
+                    OuthashesV2.created.asc(),
+                )
+                .limit(1)
+            )
             return map_row(result.first())
 
     async def get_equivalent(self, method, taskhash):
-        statement = select(
-            UnihashesV3.unihash,
-            UnihashesV3.method,
-            UnihashesV3.taskhash,
-        ).where(
-            UnihashesV3.method == method,
-            UnihashesV3.taskhash == taskhash,
-        )
-        self.logger.debug("%s", statement)
         async with self.db.begin():
-            result = await self.db.execute(statement)
+            result = await self._execute(
+                select(
+                    UnihashesV3.unihash,
+                    UnihashesV3.method,
+                    UnihashesV3.taskhash,
+                ).where(
+                    UnihashesV3.method == method,
+                    UnihashesV3.taskhash == taskhash,
+                )
+            )
             return map_row(result.first())
 
     async def remove(self, condition):
         async def do_remove(table):
             where = _make_condition_statement(table, condition)
             if where:
-                statement = delete(table).where(*where)
-                self.logger.debug("%s", statement)
                 async with self.db.begin():
-                    result = await self.db.execute(statement)
+                    result = await self._execute(delete(table).where(*where))
                 return result.rowcount
 
             return 0
@@ -417,21 +406,21 @@ class Database(object):
             return result.rowcount
 
     async def clean_unused(self, oldest):
-        statement = delete(OuthashesV2).where(
-            OuthashesV2.created < oldest,
-            ~(
-                select(UnihashesV3.id)
-                .where(
-                    UnihashesV3.method == OuthashesV2.method,
-                    UnihashesV3.taskhash == OuthashesV2.taskhash,
-                )
-                .limit(1)
-                .exists()
-            ),
-        )
-        self.logger.debug("%s", statement)
         async with self.db.begin():
-            result = await self.db.execute(statement)
+            result = await self._execute(
+                delete(OuthashesV2).where(
+                    OuthashesV2.created < oldest,
+                    ~(
+                        select(UnihashesV3.id)
+                        .where(
+                            UnihashesV3.method == OuthashesV2.method,
+                            UnihashesV3.taskhash == OuthashesV2.taskhash,
+                        )
+                        .limit(1)
+                        .exists()
+                    ),
+                )
+            )
             return result.rowcount
 
     async def insert_unihash(self, method, taskhash, unihash):
@@ -461,11 +450,9 @@ class Database(object):
         if "created" in data and not isinstance(data["created"], datetime):
             data["created"] = datetime.fromisoformat(data["created"])
 
-        statement = insert(OuthashesV2).values(**data)
-        self.logger.debug("%s", statement)
         try:
             async with self.db.begin():
-                await self.db.execute(statement)
+                await self._execute(insert(OuthashesV2).values(**data))
             return True
         except IntegrityError:
             self.logger.debug(
@@ -474,16 +461,16 @@ class Database(object):
             return False
 
     async def _get_user(self, username):
-        statement = select(
-            Users.username,
-            Users.permissions,
-            Users.token,
-        ).where(
-            Users.username == username,
-        )
-        self.logger.debug("%s", statement)
         async with self.db.begin():
-            result = await self.db.execute(statement)
+            result = await self._execute(
+                select(
+                    Users.username,
+                    Users.permissions,
+                    Users.token,
+                ).where(
+                    Users.username == username,
+                )
+            )
             return result.first()
 
     async def lookup_user_token(self, username):
@@ -496,70 +483,66 @@ class Database(object):
         return map_user(await self._get_user(username))
 
     async def set_user_token(self, username, token):
-        statement = (
-            update(Users)
-            .where(
-                Users.username == username,
-            )
-            .values(
-                token=token,
-            )
-        )
-        self.logger.debug("%s", statement)
         async with self.db.begin():
-            result = await self.db.execute(statement)
+            result = await self._execute(
+                update(Users)
+                .where(
+                    Users.username == username,
+                )
+                .values(
+                    token=token,
+                )
+            )
             return result.rowcount != 0
 
     async def set_user_perms(self, username, permissions):
-        statement = (
-            update(Users)
-            .where(Users.username == username)
-            .values(permissions=" ".join(permissions))
-        )
-        self.logger.debug("%s", statement)
         async with self.db.begin():
-            result = await self.db.execute(statement)
+            result = await self._execute(
+                update(Users)
+                .where(Users.username == username)
+                .values(permissions=" ".join(permissions))
+            )
             return result.rowcount != 0
 
     async def get_all_users(self):
-        statement = select(
-            Users.username,
-            Users.permissions,
-        )
-        self.logger.debug("%s", statement)
         async with self.db.begin():
-            result = await self.db.execute(statement)
+            result = await self._execute(
+                select(
+                    Users.username,
+                    Users.permissions,
+                )
+            )
             return [map_user(row) for row in result]
 
     async def new_user(self, username, permissions, token):
-        statement = insert(Users).values(
-            username=username,
-            permissions=" ".join(permissions),
-            token=token,
-        )
-        self.logger.debug("%s", statement)
         try:
             async with self.db.begin():
-                await self.db.execute(statement)
+                await self._execute(
+                    insert(Users).values(
+                        username=username,
+                        permissions=" ".join(permissions),
+                        token=token,
+                    )
+                )
             return True
         except IntegrityError as e:
             self.logger.debug("Cannot create new user %s: %s", username, e)
             return False
 
     async def delete_user(self, username):
-        statement = delete(Users).where(Users.username == username)
-        self.logger.debug("%s", statement)
         async with self.db.begin():
-            result = await self.db.execute(statement)
+            result = await self._execute(
+                delete(Users).where(Users.username == username)
+            )
             return result.rowcount != 0
 
     async def get_usage(self):
         usage = {}
         async with self.db.begin() as session:
             for name, table in Base.metadata.tables.items():
-                statement = select(func.count()).select_from(table)
-                self.logger.debug("%s", statement)
-                result = await self.db.execute(statement)
+                result = await self._execute(
+                    statement=select(func.count()).select_from(table)
+                )
                 usage[name] = {
                     "rows": result.scalar(),
                 }
-- 
2.34.1


