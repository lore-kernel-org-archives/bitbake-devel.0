Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C17C4345F
	for <webhook@archiver.kernel.org>; Fri, 12 Apr 2024 20:28:34 +0000 (UTC)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
 by mx.groups.io with SMTP id smtpd.web11.1472.1712953706029906382
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Apr 2024 13:28:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VIC39HQx;
 spf=pass (domain: gmail.com, ip: 209.85.166.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d5e4097a9aso47345639f.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 12 Apr 2024 13:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712953704; x=1713558504; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=flmU+xlGT7VQ4A7IUdzQ8jpgwsUhXUxm4iaFHRQmlco=;
        b=VIC39HQxKs64gczlPER4xT2mFohvKPCz8oWt92JLW0aSRFAUTxZWp+LiD/lITDjXRo
         gzb668+OwC9fdTRpo4hIT4ApIF4m9xiozHu/VTz34+aopGkzS74sJaeag+nje9g0YoCq
         9yxvUIIn2e9u/WnDDCf8wF+UwjnIfxakcpUPXVoqmj7d/sTjVU1LOTvNUS+PIQdyzARU
         fDiJrMKkbaNqS8nLUuhJXIv9gEXo56Sb5vbiibtu5/h6USjdPPNe5e9X0SEAjkCEEr3H
         vbhIpTI/lMScijC0WM/38v5nE85oZYnBICHvmTXhgG50SirLWl0fMiWQ1ZFc/MGnDhjI
         7x5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712953704; x=1713558504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flmU+xlGT7VQ4A7IUdzQ8jpgwsUhXUxm4iaFHRQmlco=;
        b=gGFzU+6KgI3nXso6ItJMPl9AYrnvD72Lx2IVMJiWJwTVEru9v97eUyDcpJRPVxifKY
         S/z6ZJoS5IPqQTvIY6/4b4wNUbk5KPcs1vvS08ehWeyrXfFHc3uXoDyqgfWN7EVn95AA
         Y99dtEvxHKM/QXxODSnDnzbW+DzXFLebgm2MVnCkGrwf+6txGCUH7dtqU4J5J6tDB13n
         N09e2o81hIcn6P9bksBHhk3L8YIN14jJ5rhrSqrVCAXghYTKI6JADV86n3o4ZENHzkkx
         ZLffkV6nhev+TbpH5ammfaafkPu3CzmtwCP9t1tCJL1ZgEIitJETgs6v/wlryMCp2KNx
         k5YA==
X-Gm-Message-State: AOJu0YzBGsZ9akPEZXe/KkhwIsyXYI24uz/CR1MlOfpZjrkCFqj2Kp+p
	NCXbyQ34HdV8qKHr7jmQhDQgR98JyCo0yA6PR4gjxwaHtd5Rv/OyfncfLg==
X-Google-Smtp-Source: AGHT+IFAFWA27cRCSuJjgy98tvwruNBopUYb/Rz8Mdi/6VE2JWjlscOCSIbfXlWEOKvg9ApzgboG3A==
X-Received: by 2002:a05:6602:3808:b0:7d5:e8ed:21d1 with SMTP id bb8-20020a056602380800b007d5e8ed21d1mr4371599iob.17.1712953704194;
        Fri, 12 Apr 2024 13:28:24 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::78ab])
        by smtp.gmail.com with ESMTPSA id io13-20020a056638830d00b0048295e0b1d0sm1251980jab.39.2024.04.12.13.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 13:28:23 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] hashserv: client: Fix mode state errors
Date: Fri, 12 Apr 2024 14:28:16 -0600
Message-Id: <20240412202816.1965036-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Apr 2024 20:28:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16091

Careful reading of the code can contrive cases where poorly timed
ConnectionError's will result in the client mode being incorrectly reset
to MODE_NORMAL when it should actual be a stream mode for the current
command. Fix this by no longer attempting to restore the mode when the
connection is setup. Instead, attempt to set the stream mode inside the
send wrapper for the stream data, which means that it should always end
up in the correct mode before continuing.

Also, factor out the transition to normal mode into a invoke() override
so it doesn't need to be specified over and over again.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/client.py | 39 +++++++++-------------------------
 1 file changed, 10 insertions(+), 29 deletions(-)

diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index b269879ecfd..0b254beddd7 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -27,9 +27,7 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
 
     async def setup_connection(self):
         await super().setup_connection()
-        cur_mode = self.mode
         self.mode = self.MODE_NORMAL
-        await self._set_mode(cur_mode)
         if self.username:
             # Save off become user temporarily because auth() resets it
             become = self.saved_become_user
@@ -38,13 +36,20 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
             if become:
                 await self.become_user(become)
 
-    async def send_stream(self, msg):
+    async def send_stream(self, mode, msg):
         async def proc():
+            await self._set_mode(mode)
             await self.socket.send(msg)
             return await self.socket.recv()
 
         return await self._send_wrapper(proc)
 
+    async def invoke(self, *args, **kwargs):
+        # It's OK if connection errors cause a failure here, because the mode
+        # is also reset to normal on a new connection
+        await self._set_mode(self.MODE_NORMAL)
+        return await super().invoke(*args, **kwargs)
+
     async def _set_mode(self, new_mode):
         async def stream_to_normal():
             await self.socket.send("END")
@@ -84,14 +89,12 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         self.mode = new_mode
 
     async def get_unihash(self, method, taskhash):
-        await self._set_mode(self.MODE_GET_STREAM)
-        r = await self.send_stream("%s %s" % (method, taskhash))
+        r = await self.send_stream(self.MODE_GET_STREAM, "%s %s" % (method, taskhash))
         if not r:
             return None
         return r
 
     async def report_unihash(self, taskhash, method, outhash, unihash, extra={}):
-        await self._set_mode(self.MODE_NORMAL)
         m = extra.copy()
         m["taskhash"] = taskhash
         m["method"] = method
@@ -100,7 +103,6 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         return await self.invoke({"report": m})
 
     async def report_unihash_equiv(self, taskhash, method, unihash, extra={}):
-        await self._set_mode(self.MODE_NORMAL)
         m = extra.copy()
         m["taskhash"] = taskhash
         m["method"] = method
@@ -108,18 +110,15 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         return await self.invoke({"report-equiv": m})
 
     async def get_taskhash(self, method, taskhash, all_properties=False):
-        await self._set_mode(self.MODE_NORMAL)
         return await self.invoke(
             {"get": {"taskhash": taskhash, "method": method, "all": all_properties}}
         )
 
     async def unihash_exists(self, unihash):
-        await self._set_mode(self.MODE_EXIST_STREAM)
-        r = await self.send_stream(unihash)
+        r = await self.send_stream(self.MODE_EXIST_STREAM, unihash)
         return r == "true"
 
     async def get_outhash(self, method, outhash, taskhash, with_unihash=True):
-        await self._set_mode(self.MODE_NORMAL)
         return await self.invoke(
             {
                 "get-outhash": {
@@ -132,27 +131,21 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         )
 
     async def get_stats(self):
-        await self._set_mode(self.MODE_NORMAL)
         return await self.invoke({"get-stats": None})
 
     async def reset_stats(self):
-        await self._set_mode(self.MODE_NORMAL)
         return await self.invoke({"reset-stats": None})
 
     async def backfill_wait(self):
-        await self._set_mode(self.MODE_NORMAL)
         return (await self.invoke({"backfill-wait": None}))["tasks"]
 
     async def remove(self, where):
-        await self._set_mode(self.MODE_NORMAL)
         return await self.invoke({"remove": {"where": where}})
 
     async def clean_unused(self, max_age):
-        await self._set_mode(self.MODE_NORMAL)
         return await self.invoke({"clean-unused": {"max_age_seconds": max_age}})
 
     async def auth(self, username, token):
-        await self._set_mode(self.MODE_NORMAL)
         result = await self.invoke({"auth": {"username": username, "token": token}})
         self.username = username
         self.password = token
@@ -160,7 +153,6 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         return result
 
     async def refresh_token(self, username=None):
-        await self._set_mode(self.MODE_NORMAL)
         m = {}
         if username:
             m["username"] = username
@@ -174,34 +166,28 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         return result
 
     async def set_user_perms(self, username, permissions):
-        await self._set_mode(self.MODE_NORMAL)
         return await self.invoke(
             {"set-user-perms": {"username": username, "permissions": permissions}}
         )
 
     async def get_user(self, username=None):
-        await self._set_mode(self.MODE_NORMAL)
         m = {}
         if username:
             m["username"] = username
         return await self.invoke({"get-user": m})
 
     async def get_all_users(self):
-        await self._set_mode(self.MODE_NORMAL)
         return (await self.invoke({"get-all-users": {}}))["users"]
 
     async def new_user(self, username, permissions):
-        await self._set_mode(self.MODE_NORMAL)
         return await self.invoke(
             {"new-user": {"username": username, "permissions": permissions}}
         )
 
     async def delete_user(self, username):
-        await self._set_mode(self.MODE_NORMAL)
         return await self.invoke({"delete-user": {"username": username}})
 
     async def become_user(self, username):
-        await self._set_mode(self.MODE_NORMAL)
         result = await self.invoke({"become-user": {"username": username}})
         if username == self.username:
             self.saved_become_user = None
@@ -210,15 +196,12 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         return result
 
     async def get_db_usage(self):
-        await self._set_mode(self.MODE_NORMAL)
         return (await self.invoke({"get-db-usage": {}}))["usage"]
 
     async def get_db_query_columns(self):
-        await self._set_mode(self.MODE_NORMAL)
         return (await self.invoke({"get-db-query-columns": {}}))["columns"]
 
     async def gc_status(self):
-        await self._set_mode(self.MODE_NORMAL)
         return await self.invoke({"gc-status": {}})
 
     async def gc_mark(self, mark, where):
@@ -231,7 +214,6 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         kept. In addition, any new entries added to the database after this
         command will be automatically marked with "mark"
         """
-        await self._set_mode(self.MODE_NORMAL)
         return await self.invoke({"gc-mark": {"mark": mark, "where": where}})
 
     async def gc_sweep(self, mark):
@@ -242,7 +224,6 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         It is recommended to clean unused outhash entries after running this to
         cleanup any dangling outhashes
         """
-        await self._set_mode(self.MODE_NORMAL)
         return await self.invoke({"gc-sweep": {"mark": mark}})
 
 
-- 
2.34.1


