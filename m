Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CB5C2D0CD
	for <webhook@archiver.kernel.org>; Thu, 15 May 2025 15:27:55 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
 by mx.groups.io with SMTP id smtpd.web11.15552.1747322866797799620
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 May 2025 08:27:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AvcPv+dr;
 spf=pass (domain: gmail.com, ip: 209.85.167.181, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4033c89f2aaso951662b6e.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 May 2025 08:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747322865; x=1747927665; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t8Be5/yHm43XB2MnTlIAImysUhOr42OE3Fg79UNup10=;
        b=AvcPv+drGOdrL6E3HXZgZ0e1R6SUd9mCaHEXnm9MOprohRx7SND9FbGefjz8dQXfJs
         N8xKBhT2ftP/9Y+qUZHI6tZVjz1IzX9Ed8n2ud2loRD2SOedGVenDN2S+RVNz5f3ipau
         DPZ0SvomPIPGDzbX0W7lCzB5rCqL+kcERTgrnDfof0oCd+IqHoauZSAyynYWYl6K3tjB
         DP/2H5+PpnwAF5CU1RUavQCmarS/g2v0Y67PaUCR0JNKUgXYVtapd+pz8roYvpjDQbhK
         RVc71k7B3VUXPJZ2MY43ll50JGh/pFdNYOqmsnK/i/aktZSY4gyTgWZeJBBaLK1R4ej1
         77hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747322865; x=1747927665;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t8Be5/yHm43XB2MnTlIAImysUhOr42OE3Fg79UNup10=;
        b=fAofXD8Hy2j1ieqNGFuWC8/O80fzMZZxkClS48nOw9tkO5cuF4D4rNVMqJknSiBOgh
         ewK4thTch0x4oXXFOYsqJCFIRstnTGM79EpLpgliAuIr2BwM0MxKILnk3+1vkwC0MUpb
         6xHCMssYkbkeIQPi6RsdUHRju8lPg4Ej+d6vTxOflqDjAjO41HXZ/GK4RXCWdTBtcAeQ
         LT5Id3jnPVFbWCSNi9sLcM+5383pHKdsCS+775pOjH6XQc6fqSi1qNNHQ90GDg57tWC2
         wpdyeDxd0MoE0Khqq0vQg+v+BRjUCGo/xc3KAGDYmRPob67cDLZ58GxIoRUk22Khac+2
         rVmA==
X-Gm-Message-State: AOJu0Yw/00BuSqW9KHXzNpLLFODEaYmF3HrBwUmkvDcmao6qRz4cSdPK
	vg9xmU/fCR63KtGQrSqTcGzxYnyMxe3fM40QW30YFySDoLMM7wL8s3kFpeW8cA==
X-Gm-Gg: ASbGncsafkv2eDQ7ryD74jquoumn0POqWz1dzrugzh7jj8FFW8qqtpKjQnYDsWdPVlt
	ZwmnnCuAKJG9x1X5LE/zHMeTnpId/I29PkROn5a91JrQ9BO9YFSFWdfnuWKJirb172b+3GyfQRa
	HRKoDxkeIDOmL6U5yYWK1r3JOvnL1FmvsTfPE3+c36biIOtLWjPjubVFGzIuVVgiUFExNJaqG//
	DjysJa9+Y313Iz1mK1eX6xOiEPYnYotLwP74/EFXFYt9mjlLuWIa5M1vCRxJRsCNRoComWojkpm
	S5wYWhytHzisr5oiJEfQLRHb6wztXNLf3wl6tnmzinMu4HV9Nw==
X-Google-Smtp-Source: AGHT+IG+0TCfEMZXjN8kTxoJbD3AKJ4Wm8UVxWUpNy211GfnJhClXnCW7zKQSiGl60SU+JzA5A6NCw==
X-Received: by 2002:a05:6808:338b:b0:3f6:729c:810 with SMTP id 5614622812f47-404d864ddb7mr194956b6e.4.1747322865315;
        Thu, 15 May 2025 08:27:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6342])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-609f3000cfasm10760eaf.25.2025.05.15.08.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 08:27:43 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] hashserv: Fix deprecation warning about sqlite adapter
Date: Thu, 15 May 2025 09:27:40 -0600
Message-ID: <20250515152740.3715261-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 May 2025 15:27:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17619

The default adapters for sqlite datetime are deprecated as of Python
3.12, so implement our own.

[YOCTO #15333]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/sqlite.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/bitbake/lib/hashserv/sqlite.py b/bitbake/lib/hashserv/sqlite.py
index da2e844a031..976504d7f44 100644
--- a/bitbake/lib/hashserv/sqlite.py
+++ b/bitbake/lib/hashserv/sqlite.py
@@ -4,6 +4,7 @@
 #
 # SPDX-License-Identifier: GPL-2.0-only
 #
+from datetime import datetime, timezone
 import sqlite3
 import logging
 from contextlib import closing
@@ -53,6 +54,22 @@ CONFIG_TABLE_DEFINITION = (
 CONFIG_TABLE_COLUMNS = tuple(name for name, _, _ in CONFIG_TABLE_DEFINITION)
 
 
+def adapt_datetime_iso(val):
+    """Adapt datetime.datetime to UTC ISO 8601 date."""
+    return val.astimezone(timezone.utc).isoformat()
+
+
+sqlite3.register_adapter(datetime, adapt_datetime_iso)
+
+
+def convert_datetime(val):
+    """Convert ISO 8601 datetime to datetime.datetime object."""
+    return datetime.fromisoformat(val.decode())
+
+
+sqlite3.register_converter("DATETIME", convert_datetime)
+
+
 def _make_table(cursor, name, definition):
     cursor.execute(
         """
-- 
2.49.0


