Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
 by mx.groups.io with SMTP id smtpd.web11.32771.1612180423930021584
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Feb 2021 03:53:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=rvD7OSFq;
 spf=pass (domain: konsulko.com, ip: 209.85.221.50, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f50.google.com with SMTP id 6so16243664wri.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 01 Feb 2021 03:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JWX36u8oziMGJz5yNKm1NDizgHo9gJMRUKiqBKfO4i0=;
        b=rvD7OSFqulnVvva9qBnXXun+dyKFasBiZ4ZjeJJaN/ffoXMx/arfI7jjbcMr2NyPG3
         pDR1qFhHogHdDSekEJ67Pk+rREEmCpc0mkgedGsa8ahm76ajRCe6QKeswkKDnWnakfgU
         IfC3brc91RJK4hsGUYADVP3TBqhZ6Hf04iXTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JWX36u8oziMGJz5yNKm1NDizgHo9gJMRUKiqBKfO4i0=;
        b=ntF+qae99ebuE9/tLVJtAiQY2j5h5hWteKBP3GsIpdaENoR/1ttCZStJeQxqIxdZ6k
         0LarEMvO0CX+E6ftIuMxj3Pfo0ziiyY7PsdWiU8a2b5BTX2E83Gdnx7PSWaU8CNUYyty
         EJCDHz4H0Gfrpc4mHA5VTNxL/AD9Ki9ULYZuw40KAf3rhxJoZpBQ2J9cePjsUPmuEbi8
         eFWn1YlGH19PSWNzazUR7y2cIeLdqiqbodz3S8T+UYTuiNaWDzBf+jlwzmj2JJLWRie9
         On8FUcGIysaamKqo8yxxEHYFWdx/QJRhwYLXPgPG6oVAQUKFD8RLwk+y71ecFRHJVxvb
         1jlA==
X-Gm-Message-State: AOAM5327Iia7SDU9rtuAdiM6Qja3HNG/WMEH7TFO+/vnlXE5IGlkttZX
	LVrDBYFee8U3O8NnRP/DgbXHcxUVq0WPHjbP
X-Google-Smtp-Source: ABdhPJyOPtINB5Mhne8TOQW4w0U0T0qBLty9fUSGyqvpxntzqrwAQBt/hGCbErv3wbwmnaAkRw3q8g==
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr17453717wrw.379.1612180422331;
        Mon, 01 Feb 2021 03:53:42 -0800 (PST)
Return-Path: <pbarker@konsulko.com>
Received: from tortoise.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id u6sm28120514wro.75.2021.02.01.03.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 03:53:41 -0800 (PST)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [RFC PATCH 8/8] hashserv: server: Support searching upstream for outhash
Date: Mon,  1 Feb 2021 11:53:31 +0000
Message-Id: <20210201115331.13510-9-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210201115331.13510-1-pbarker@konsulko.com>
References: <20210201115331.13510-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new get-outhash message to perform a read-only query against an
upstream server (if present) when a reported taskhash/outhash
combination is not found in the current database. If a matching entry is
found upstream it is copied into the current database so it can be found
by future queries.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/hashserv/server.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 054791b8b..5fb562b52 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -131,6 +131,20 @@ async def copy_from_upstream(client, db, method, taskhash):
         keys = sorted(d.keys())
 
 
+        with closing(db.cursor()) as cursor:
+            insert_task(cursor, d)
+            db.commit()
+
+    return d
+
+async def copy_outhash_from_upstream(client, db, method, outhash, taskhash):
+    d = await client.get_outhash(method, outhash, taskhash)
+    if d is not None:
+        # Filter out unknown columns
+        d = {k: v for k, v in d.items() if k in TABLE_COLUMNS}
+        keys = sorted(d.keys())
+
+
         with closing(db.cursor()) as cursor:
             insert_task(cursor, d)
             db.commit()
@@ -387,6 +401,14 @@ class ServerClient(object):
 
             row = cursor.fetchone()
 
+            if row is None:
+                # Try upstream
+                row = await copy_outhash_from_upstream(self.upstream_client,
+                                                       self.db,
+                                                       data['method'],
+                                                       data['outhash'],
+                                                       data['taskhash'])
+
             # If no matching outhash was found, or one *was* found but it
             # wasn't an exact match on the taskhash, a new entry for this
             # taskhash should be added
-- 
2.26.2

