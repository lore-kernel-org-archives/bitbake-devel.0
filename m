Return-Path: <eric.meyers15310@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02EFC02191
	for <webhook@archiver.kernel.org>; Mon, 27 Jan 2025 14:29:10 +0000 (UTC)
Received: from mail-il1-f193.google.com (mail-il1-f193.google.com [209.85.166.193])
 by mx.groups.io with SMTP id smtpd.web10.52715.1737988149264715500
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Jan 2025 06:29:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ii9W0z+G;
 spf=pass (domain: gmail.com, ip: 209.85.166.193, mailfrom: eric.meyers15310@gmail.com)
Received: by mail-il1-f193.google.com with SMTP id e9e14a558f8ab-3a81324bbdcso35900205ab.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Jan 2025 06:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737988148; x=1738592948; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lQEjHnKcawcBkbZEcyosDWvcnaRA08qu8LCtoqulvo=;
        b=Ii9W0z+Gz+noDupuq3IRJpqeNZ+NhpRfZ00Yy/E/fZa/P4XJDorSDzBHcGyMZEcWJ9
         gmv/zPuqThyx51/FbDeZ1fy1xvdTz299ynu7WDDsGyBky2OHvT2nbjTRMlkKBtEEcyCx
         T2kOpy2V9/RmPeyqkHkOPXpqK/ejQiLhmZmhlXV/IZvRZKnbd2v+pvXdHMjwzogVOhup
         kSD/4rHkCUb4YVLLtTYmAW5dwFi4KabswX6Rfg3RBZG3r0bOaS3iM06h559n1qT8wruo
         tqqpn89D5/nDp+ySx9cy0dcpdOSROgXelYNkPFRydhVRngZ5IVMSbh+iVo7M8EP0ulsi
         oVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737988148; x=1738592948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lQEjHnKcawcBkbZEcyosDWvcnaRA08qu8LCtoqulvo=;
        b=S9r5gBh2+0b1PUzfqTKpFaEKp+HDQTmPCNsme4bAybV54zwE6wGwhTgxXcXzE0tq35
         5RqgZu9LOnJi4pStBfjc4ucHnnjDm0Cu3xW8Khrq+0glIrYx+KfF+b8CjIAH0/Sok0Hn
         U587UPxiVH+Enlb4dO2hrIKZw4xR1QlGGg2dlubUwlXIhUk1msduwrA1egRkKL4RBER7
         DBfLo3BKMaIccZYO1XCXeY8Jk0aRj/FcTG6Cj3rmb/xxYF7hWDnkHLcH78JnlT6ri5U4
         mKQFV2g5DgvGGV7EtOXmyKl46yr4jAuM2MV+n1bVj3Yhp1m3jeX16oGzNIDbILhbreO0
         R/NQ==
X-Gm-Message-State: AOJu0YzQwEu3EXU5VJLdrIWUIOzhHXdd6UAV+leNvWKjBDHldVXD7ZZB
	Zba8ntjoCpXF9tp8ZT6ctvSJ+yWoMAKgkKYB9MzYyTs2zPmGFEgBqo/TawTuAnU=
X-Gm-Gg: ASbGncvt501pt/Cf5zbfWxaSNY6rjbCESVC1d2n+qdOOVK5x4+y/xAodM4JWYAYAs5E
	m13n7wAfbjxqwwZxShWrvSrOvWVuCEJKQHu+KjNxLPRU2PgDpkxhqWSeBrBhr2ATa4guBR9BiHs
	BCb45ktpP1l9oQn2HxfMRY/O5fnjpCNGvhmo11fDWNsVw3Dz/CQEkhoesK+MOUqZV7nzqMxhxig
	NCQ/1hYhBTKVxIGy7s28cTolSyaSkVoRMPqNCO8gFWC76r5n7CKt20D1pJarN8cC8Killdc1iiv
	fG+Y/XrGzWm7Khz/AAJ4XA06LWC0i5o9rOf96/92pLXRLUzGDxQiDJ3yS+5nMyw4xDBshMlK5Fx
	Vv9mi4ekAW377
X-Google-Smtp-Source: AGHT+IEf0GAEPNpMJAIG9YvTZ5djBAR/IcWas2spAEg1qNiiCaWmNpG71wDGxvEPebLoZg+XAZtbog==
X-Received: by 2002:a05:6e02:1f84:b0:3cf:b26f:ff7c with SMTP id e9e14a558f8ab-3cfb2700234mr213758755ab.5.1737988148239;
        Mon, 27 Jan 2025 06:29:08 -0800 (PST)
Received: from 95d5ae3229ef.yourbase.domain.local (c-73-168-239-54.hsd1.il.comcast.net. [73.168.239.54])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3cfc744be43sm26228645ab.33.2025.01.27.06.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 06:29:07 -0800 (PST)
From: eric.meyers15310@gmail.com
X-Google-Original-From: eric.meyers@arthrex.com
To: bitbake-devel@lists.openembedded.org
Cc: Eric Meyers <eric.meyers@arthrex.com>,
	Geoff Parker <geoffrey.parker@arthrex.com>
Subject: [PATCH 2/3] fetch2/npmsw: Add basic auth credential support for npmsw fetcher
Date: Mon, 27 Jan 2025 14:29:17 +0000
Message-Id: <20250127142918.163-3-eric.meyers@arthrex.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250127142918.163-1-eric.meyers@arthrex.com>
References: <20250127142918.163-1-eric.meyers@arthrex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Jan 2025 14:29:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17098

From: Eric Meyers <eric.meyers@arthrex.com>

Signed-off-by: Eric Meyers <eric.meyers@arthrex.com>
Cc: Geoff Parker <geoffrey.parker@arthrex.com>
---
 lib/bb/fetch2/npmsw.py | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
index 2f9599ee9..1c894c561 100644
--- a/lib/bb/fetch2/npmsw.py
+++ b/lib/bb/fetch2/npmsw.py
@@ -15,12 +15,24 @@ Supported SRC_URI options are:
 
 - destsuffix
     Specifies the directory to use to unpack the dependencies (default: ${S}).
+
+- username
+    Specifies the basic auth username to use when accessing an npm registry specified in the shrinkwrap.
+
+- password
+    Specifies the basic auth password (or API key) to use when accessing the npm registry specified in the shrinkwrap.
+
+- basic_auth_registry
+    Specifies the registry within the npm shrinkwrap to use basic authentication with.
+    NOTE: This parameter is optional - if nothing is passed in but a username/password IS supplied, then
+    fetcher will assume to use basic auth credentials for all registries within the shrinkwrap file.
 """
 
 import json
 import os
 import re
 import bb
+import urllib.parse
 from bb.fetch2 import Fetch
 from bb.fetch2 import FetchMethod
 from bb.fetch2 import ParameterError
@@ -67,10 +79,26 @@ class NpmShrinkWrap(FetchMethod):
 
     def urldata_init(self, ud, d):
         """Init npmsw specific variables within url data"""
+        ud.shrinkwrap_file = None
+        ud.dev = None
+        ud.deps = None
+        ud.basic_auth_registry = None
+        ud.username = None
+        ud.password = None
 
         # Get the 'shrinkwrap' parameter
         ud.shrinkwrap_file = re.sub(r"^npmsw://", "", ud.url.split(";")[0])
 
+        if "basic_auth_registry" in ud.parm:
+            ud.basic_auth_registry = ud.parm.get("basic_auth_registry")
+
+        if "username" in ud.parm:
+            ud.username = ud.parm.get("username")
+
+        if "password" in ud.parm:
+            ud.password = ud.parm.get("password")
+
+
         # Get the 'dev' parameter
         ud.dev = bb.utils.to_boolean(ud.parm.get("dev"), False)
 
@@ -107,6 +135,14 @@ class NpmShrinkWrap(FetchMethod):
                 checksum_name, checksum_expected = npm_integrity(integrity)
                 uri.params[checksum_name] = checksum_expected
 
+                # Check if the registry we are using matches the registry passed in
+                # that the user wants to use for basic authentication
+                if ud.basic_auth_registry is not None:
+                    use_basic_auth = urllib.parse.urlparse(resolved).hostname in ud.basic_auth_registry
+                    if (ud.username is not None and ud.password is not None and use_basic_auth):
+                        uri.params["user"] = ud.username
+                        uri.params["pswd"] = ud.password
+
                 url = str(uri)
 
                 localpath = os.path.join(d.getVar("DL_DIR"), localfile)

