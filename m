Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D16C48BF6
	for <webhook@archiver.kernel.org>; Sun, 18 Feb 2024 20:08:04 +0000 (UTC)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
 by mx.groups.io with SMTP id smtpd.web11.25649.1708286875846585219
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Feb 2024 12:07:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BkSugQFz;
 spf=pass (domain: gmail.com, ip: 209.85.166.52, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c72294e3d1so126766239f.1
        for <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 12:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708286874; x=1708891674; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GaTwCVBHiMp2WMJhdaju/OW/ME4sPP5hS8BJw1s907w=;
        b=BkSugQFznlFs3U93zaIeTSoLQX9D1EVmi4ggyUic3te01So68yQPB6/ypV+PdjzWVQ
         jHtt+DXSBVqGZVhZesxeNtQtBBvo6yxP7UAUpbdlq6+ih7tdVlTsJAROCKm1LWj8UIqg
         7EuwsbJ5Qyd1RXQ5aAsNmBA4ku2AYJPwKSNAYfsrNneGPfBRfKYeGxin/RCnw++zuxMQ
         hIOY28+rlfsthZoe8bgh2K+y24YBe/pNt0pB6mrYyueDHbTTmK7s4FvCl8h1bpU+bAmT
         h1Dq4I9wFDV16Kk5ubd9pHy3G9SvhvAt/fV/eF7z6UChTrww5tvsgZM1TqBIXpehTT6w
         ojvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708286874; x=1708891674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GaTwCVBHiMp2WMJhdaju/OW/ME4sPP5hS8BJw1s907w=;
        b=xD5/se4WzKnlSgvP7poFh/rksATF7LbQtF3symJKajlQIUwL8pOrMAM0uTzkj/vOa1
         ZiX43cV7iitM+80ZqhFwIfPfu7kEi6ndxAIRQcjpOK3uB1XG1nQ4iD1C9WFkSwftMVG8
         a/pWcBHX5Hx+yDyGIGDpXqDfK1fCWg9Xt2zu0zgHMzl6gL7Gy8dHicCGOQnlGLasLHiM
         9GRLyshypFckcGPVJCGo+yQyVoh1dTPRam0wsrIH0O+2G/BhkNSz442eCqkdJQBOXhHc
         hrLlBVs/hZkHZ6vu0CnKzzAqAxPyLfLxTys5f3+W0BimbQ4tpzHkuTuR77+p0HGyvwIK
         IhVw==
X-Gm-Message-State: AOJu0YwCovg7APZiPWwnULuw6ZBGmlEEqc5BA2v7p5FbNCCgG3ckAKdB
	NaRau7uWsfcPGfDbAWzZTTfELajCqqdAWBMUkL07XUVrbfEsuScabqyjE0lv
X-Google-Smtp-Source: AGHT+IHiCLUoGMGB2zhvkBlP5w/ZPdus1f9InMGryfJWtN1ExhfQBoOtKlljYAMEnZcB/UX+5bh0ww==
X-Received: by 2002:a5d:8e02:0:b0:7c4:9a35:40bd with SMTP id e2-20020a5d8e02000000b007c49a3540bdmr10633557iod.3.1708286873860;
        Sun, 18 Feb 2024 12:07:53 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::44fb])
        by smtp.gmail.com with ESMTPSA id u6-20020a02aa86000000b004741e1544b6sm549278jai.81.2024.02.18.12.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 12:07:53 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH 1/5] hashserv: sqlalchemy: Use _execute() helper
Date: Sun, 18 Feb 2024 13:07:39 -0700
Message-Id: <20240218200743.2982923-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218200743.2982923-1-JPEWhacker@gmail.com>
References: <20240218200743.2982923-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 20:08:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15917

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


