Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web09.6542.1612524385044686865
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Feb 2021 03:26:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=suaOa9R8;
 spf=pass (domain: konsulko.com, ip: 209.85.221.43, mailfrom: pbarker@konsulko.com)
Received: by mail-wr1-f43.google.com with SMTP id g10so7321687wrx.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 05 Feb 2021 03:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jl06xmia6i+reapAH8yZfuyoOEe+HLXIli8TgcO99Ww=;
        b=suaOa9R8MYic8QvteKCTcAQZAxA3ca9dR6XPVkNPSqBhbk1UMPGfiMiyVF6jQpz7hT
         BFcG6HRSg8bAuBkFLApYcYSkGN4TRhG0a6b5ozoQOJixCqdIFAp3cKu71h42/VjvXZXM
         UDys3bVXyCnVMODRXBoP/6lH5g/vZx4V9Sipk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jl06xmia6i+reapAH8yZfuyoOEe+HLXIli8TgcO99Ww=;
        b=ZgfiNVl1aFqqO5eiZL/Jv4x1SjHU2VdFbmyFHUk+2FjVSPtoXCT9bxHorvdQHBw+Th
         8Uhjaqf6CwrMapf5uo9Gml4fxH846/BGUFi34GXDT2Bafkzjl90fnp5ydUMwPT6aahWi
         6PyQ14C6yhKEOTkfAuiedgQxguD/zAdIvmEjkQ6I90y0kXePC3MraVkmvnhKFbSneVDB
         LCIN32kVvo2rsJnO90XqXgRMZ9ABrZaN8spKo7bcyXqqyYDAzIlIDCqHzSMn5JUCorhL
         80cky8Mko1Mf66EtijtwHDhTKrjQEyCGkMOrOT/JEujgQk0YhPUZ9Ud0UHi4aWjGWlM9
         eGHw==
X-Gm-Message-State: AOAM530Ghg2LySZ5RKp2qL3ZH0auKU+jo8hAg7cHOP25t2VYNauRw/kl
	M4YoEl4B6ECwCTeY0fVZGMUVr/cS/r9tRGFX
X-Google-Smtp-Source: ABdhPJyWZowq6XwoqoH3S3vVAUSvna1JP1uBppUyfzhR5m7oIKAV8sQsPZDmKjmJVLy3Em27PXmg1w==
X-Received: by 2002:adf:ab10:: with SMTP id q16mr4442603wrc.297.1612524383448;
        Fri, 05 Feb 2021 03:26:23 -0800 (PST)
Return-Path: <pbarker@konsulko.com>
Received: from tortoise.home.b5net.uk (cpc76132-clif11-2-0-cust80.12-4.cable.virginm.net. [80.7.160.81])
        by smtp.gmail.com with ESMTPSA id y18sm11881716wrt.19.2021.02.05.03.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 03:26:22 -0800 (PST)
From: "Paul Barker" <pbarker@konsulko.com>
To: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Cc: Paul Barker <pbarker@konsulko.com>
Subject: [PATCH v2 8/8] hashserv: server: Support searching upstream for outhash
Date: Fri,  5 Feb 2021 11:26:11 +0000
Message-Id: <20210205112611.17167-9-pbarker@konsulko.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210205112611.17167-1-pbarker@konsulko.com>
References: <20210205112611.17167-1-pbarker@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new get-outhash message to perform a read-only query against an
upstream server (if present) when a reported taskhash/outhash
combination is not found in the current database. If a matching entry is
found upstream it is copied into the current database so it can be found
by future queries.

Signed-off-by: Paul Barker <pbarker@konsulko.com>
---
 lib/hashserv/server.py | 20 ++++++++++++++++++++
 lib/hashserv/tests.py  | 12 ++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 64d1a9d15..4b676cddc 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -130,6 +130,18 @@ async def copy_from_upstream(client, db, method, taskhash):
         d = {k: v for k, v in d.items() if k in TABLE_COLUMNS}
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
 
         with closing(db.cursor()) as cursor:
             insert_task(cursor, d)
@@ -377,6 +389,14 @@ class ServerClient(object):
 
             row = cursor.fetchone()
 
+            if row is None and self.upstream_client:
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
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 6f04e30d6..1a696481e 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -246,6 +246,18 @@ class HashEquivalenceCommonTests(object):
         self.assertClientGetHash(side_client, taskhash4, unihash4)
         self.assertClientGetHash(self.client, taskhash4, None)
 
+        # Test that reporting a unihash in the downstream is able to find a
+        # match which was previously reported to the upstream server
+        taskhash5 = '35788efcb8dfb0a02659d81cf2bfd695fb30faf9'
+        outhash5 = '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f'
+        unihash5 = 'f46d3fbb439bd9b921095da657a4de906510d2cd'
+        result = self.client.report_unihash(taskhash5, self.METHOD, outhash5, unihash5)
+
+        taskhash6 = '35788efcb8dfb0a02659d81cf2bfd695fb30fafa'
+        unihash6 = 'f46d3fbb439bd9b921095da657a4de906510d2ce'
+        result = down_client.report_unihash(taskhash6, self.METHOD, outhash5, unihash6)
+        self.assertEqual(result['unihash'], unihash5, 'Server failed to copy unihash from upstream')
+
     def test_ro_server(self):
         (ro_client, ro_server) = self.start_server(dbpath=self.server.dbpath, read_only=True)
 
-- 
2.26.2

