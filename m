Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.web12.32702.1612180423073648819
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Feb 2021 03:53:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=bL//TsQe;
 spf=pass (domain: konsulko.com, ip: 209.85.128.53, mailfrom: pbarker@konsulko.com)
Received: by mail-wm1-f53.google.com with SMTP id j18so12394580wmi.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Feb 2021 03:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C8SKEECUOeqw7+ywgSD4dqMAqdFJS5q5rY/4H6DMLbc=;
        b=bL//TsQeTOTwQs7OSycGNGMpUn+wYnNsjrOJN3S5Xf9NUxW0terIMD0UpcBaujfeRI
         647rK91jtleCAaZBJi8VJcGhkfU3p0/B7PKowALZ02QpkFoI+HIBl3nErBRq02LQt2VM
         TuYu3u2ZIDbwAgPe8ofLY/Ol0tj04M844c6WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C8SKEECUOeqw7+ywgSD4dqMAqdFJS5q5rY/4H6DMLbc=;
        b=dI7REdezmjsfkN1btPYEvE/TdlEpRPCTkHk/r61v2JkiodMxbZssTvlnw8nKB12gCu
         gvv3wuybfmcRRdaz1XiULcp2uhiwZqsQ+TgJVUZPmMbBJx4NEQq/8BqTuDvmDJaebMdd
         +fWFXN78NGY8C5bMTPDHIYEu6dNVUaNpnTfyBtG+Cgp4uMW6WjO5MYHRBPS7dNTsxTrv
         12LteJsew2jtPryQ6m/vujhnoPwZI/WO/O60roOK61Nn5166cy1RhrItcaHCnfBRU6lp
         It90wR/nwA3dqsYEAHL8KRqU7XcMryvOZLKNAHVUWX01NQtcpct81H5KAhtA1PoRqGFU
         eO/Q==
X-Gm-Message-State: AOAM530r8DZ9e/ype1OGVrzhAKn7MpFthM7qOwVaCXL4jKcrFLj/k7Rp
	Ejzy7tPdtLS/j+GDFNPK5sy+v9onJptw2L6d
X-Google-Smtp-Source: ABdhPJw6bwK8OftC23pqvNMPIL/FYKnxFF0H7TLIrnwFS+s1kouuZvDTdaAuBGzDfVqSYY1I0wVoGw==
X-Received: by 2002:a1c:7413:: with SMTP id p19mr14401648wmc.39.1612180421389;
        Mon, 01 Feb 2021 03:53:41 -0800 (PST)
Return-Path: <pbarker@konsulko.com>
Received: from tortoise.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id u6sm28120514wro.75.2021.02.01.03.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 03:53:40 -0800 (PST)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 7/8] hashserv: Add get-outhash message
Date: Mon,  1 Feb 2021 11:53:30 +0000
Message-Id: <20210201115331.13510-8-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210201115331.13510-1-pbarker@konsulko.com>
References: <20210201115331.13510-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get-outhash message can be sent via the get_outhash client method.
This works in a similar way to the get message but looks up a db entry
by outhash rather than by taskhash. It is intended to be used as a
read-only form of the report message.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/hashserv/client.py |  6 ++++++
 lib/hashserv/server.py | 28 ++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

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
index b1e8b2f89..054791b8b 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -152,6 +152,7 @@ class ServerClient(object):
 
         self.handlers = {
             'get': self.handle_get,
+            'get-outhash': self.handle_get_outhash,
             'get-stream': self.handle_get_stream,
             'get-stats': self.handle_get_stats,
             'chunk-stream': self.handle_chunk,
@@ -289,6 +290,33 @@ class ServerClient(object):
 
         self.write_message(d)
 
+    async def handle_get_outhash(self, request):
+        with closing(self.db.cursor()) as cursor:
+            cursor.execute('''
+                -- Find tasks with a matching outhash (that is, tasks that
+                -- are equivalent)
+                SELECT * FROM tasks_v2 WHERE method=:method AND outhash=:outhash
+
+                -- If there is an exact match on the taskhash, return it.
+                -- Otherwise return the oldest matching outhash of any
+                -- taskhash
+                ORDER BY CASE WHEN taskhash=:taskhash THEN 1 ELSE 2 END,
+                    created ASC
+
+                -- Only return one row
+                LIMIT 1
+                ''', {k: request[k] for k in ('method', 'outhash', 'taskhash')})
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
 
-- 
2.26.2

