Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.6857.1612524383946014907
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Feb 2021 03:26:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=kGCh9eRq;
 spf=pass (domain: konsulko.com, ip: 209.85.221.49, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f49.google.com with SMTP id g10so7321622wrx.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Feb 2021 03:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DFWzOSnl65RlOTpt8B0auvM93FG3OXC7SZLSoE13HqM=;
        b=kGCh9eRqUFeJoK/TeSM8RXdoXbN0RISTH+ivXU3LihIQkfvcu7mdjcN6ecJVdztyJh
         HWJmYQFTT4v3c0ZOMGi6J+RctcdRZ1vVkEL5bJfZSWNnobQBs2kG5jhDK6ofaTdjvsw1
         J42YN9OTIJ5HBh42Dvsc1kBEd6o7+V7L8c/6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DFWzOSnl65RlOTpt8B0auvM93FG3OXC7SZLSoE13HqM=;
        b=K0/n8UULeOTP9Gt3BrJJCRGucf9qxwPbqI+uT+VeQEpXBsvjI04JrU32EWoqxvYRMR
         ItlzgJ9yo43xAPHGpQQUZd0ricIoA/VfA110qTU8ZSkKEXEk2V078sAgyWt/cgYDx77/
         ba8FjsXOk/a3xxDFPis6xxjmeUmL5RfTnq0RAzpnO0oAG3SRlkxrvfD3r53cBw6kE5zV
         Gqy9qA2W6AyEgaTPHwTOFWUIPhSwIe3O6bRedeMRXHlFkyqcYdXejvb7tC03bT9Ga63K
         vjnqdbGiMSDfo0iW+8bbtXIla5DfFudbAbS9O7PSK7rs+bVgNwd7HqSwvJj3j/sH1rWS
         2n2g==
X-Gm-Message-State: AOAM532thMrr7lYtyY4MGXCUtJPcP9uG2ankBCLoTaKd5RsJvhC7rEcN
	23Nh5WzpqMNA0gZOI/H7GXqUTt+mO08mlHBB
X-Google-Smtp-Source: ABdhPJyQiFyQ+hqxG/keLwg/s1Jv8wD1K0TVKVG2F6uv65MDYFAx21557XbRV8mX09yfiqOqgUIWZg==
X-Received: by 2002:adf:ce10:: with SMTP id p16mr4583881wrn.97.1612524382352;
        Fri, 05 Feb 2021 03:26:22 -0800 (PST)
Return-Path: <pbarker@konsulko.com>
Received: from tortoise.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id y18sm11881716wrt.19.2021.02.05.03.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 03:26:21 -0800 (PST)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH v2 7/8] hashserv: Add get-outhash message
Date: Fri,  5 Feb 2021 11:26:10 +0000
Message-Id: <20210205112611.17167-8-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210205112611.17167-1-pbarker@konsulko.com>
References: <20210205112611.17167-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get-outhash message can be sent via the get_outhash client method.
This works in a similar way to the get message but looks up a db entry
by outhash rather than by taskhash. It is intended to be used as a
read-only form of the report message.

As both handle_get_outhash and handle_report use the same query string
we can factor this out.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/hashserv/client.py |  6 ++++++
 lib/hashserv/server.py | 46 +++++++++++++++++++++++++++++-------------
 2 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
index 0b7f4e42e..e05c1eb56 100644
--- a/lib/hashserv/client.py
+++ b/lib/hashserv/client.py
@@ -170,6 +170,12 @@ class AsyncClient(object):
             {"get": {"taskhash": taskhash, "method": method, "all": all_properties}}
         )
 
+    async def get_outhash(self, method, outhash, taskhash):
+        await self._set_mode(self.MODE_NORMAL)
+        return await self.send_message(
+            {"get-outhash": {"outhash": outhash, "taskhash": taskhash, "method": method}}
+        )
+
     async def get_stats(self):
         await self._set_mode(self.MODE_NORMAL)
         return await self.send_message({"get-stats": None})
diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index b1e8b2f89..64d1a9d15 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -140,6 +140,20 @@ async def copy_from_upstream(client, db, method, taskhash):
 class ServerClient(object):
     FAST_QUERY = 'SELECT taskhash, method, unihash FROM tasks_v2 WHERE method=:method AND taskhash=:taskhash ORDER BY created ASC LIMIT 1'
     ALL_QUERY =  'SELECT *                         FROM tasks_v2 WHERE method=:method AND taskhash=:taskhash ORDER BY created ASC LIMIT 1'
+    OUTHASH_QUERY = '''
+        -- Find tasks with a matching outhash (that is, tasks that
+        -- are equivalent)
+        SELECT * FROM tasks_v2 WHERE method=:method AND outhash=:outhash
+
+        -- If there is an exact match on the taskhash, return it.
+        -- Otherwise return the oldest matching outhash of any
+        -- taskhash
+        ORDER BY CASE WHEN taskhash=:taskhash THEN 1 ELSE 2 END,
+            created ASC
+
+        -- Only return one row
+        LIMIT 1
+        '''
 
     def __init__(self, reader, writer, db, request_stats, backfill_queue, upstream, read_only):
         self.reader = reader
@@ -152,6 +166,7 @@ class ServerClient(object):
 
         self.handlers = {
             'get': self.handle_get,
+            'get-outhash': self.handle_get_outhash,
             'get-stream': self.handle_get_stream,
             'get-stats': self.handle_get_stats,
             'chunk-stream': self.handle_chunk,
@@ -289,6 +304,21 @@ class ServerClient(object):
 
         self.write_message(d)
 
+    async def handle_get_outhash(self, request):
+        with closing(self.db.cursor()) as cursor:
+            cursor.execute(self.OUTHASH_QUERY,
+                           {k: request[k] for k in ('method', 'outhash', 'taskhash')})
+
+            row = cursor.fetchone()
+
+        if row is not None:
+            logger.debug(1, 'Found equivalent outhash %s -> %s', (row['outhash'], row['unihash']))
+            d = {k: row[k] for k in row.keys()}
+        else:
+            d = None
+
+        self.write_message(d)
+
     async def handle_get_stream(self, request):
         self.write_message('ok')
 
@@ -342,20 +372,8 @@ class ServerClient(object):
 
     async def handle_report(self, data):
         with closing(self.db.cursor()) as cursor:
-            cursor.execute('''
-                -- Find tasks with a matching outhash (that is, tasks that
-                -- are equivalent)
-                SELECT taskhash, method, unihash FROM tasks_v2 WHERE method=:method AND outhash=:outhash
-
-                -- If there is an exact match on the taskhash, return it.
-                -- Otherwise return the oldest matching outhash of any
-                -- taskhash
-                ORDER BY CASE WHEN taskhash=:taskhash THEN 1 ELSE 2 END,
-                    created ASC
-
-                -- Only return one row
-                LIMIT 1
-                ''', {k: data[k] for k in ('method', 'outhash', 'taskhash')})
+            cursor.execute(self.OUTHASH_QUERY,
+                           {k: data[k] for k in ('method', 'outhash', 'taskhash')})
 
             row = cursor.fetchone()
 
-- 
2.26.2

