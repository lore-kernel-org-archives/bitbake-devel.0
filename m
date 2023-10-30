Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D32C001B0
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 19:18:24 +0000 (UTC)
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
 by mx.groups.io with SMTP id smtpd.web11.158506.1698693504177610665
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 12:18:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=U/A7i01V;
 spf=pass (domain: gmail.com, ip: 209.85.210.46, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ce2c5b2154so3204574a34.3
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 12:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698693503; x=1699298303; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zo93hmXviq3GO3T30OQUviOfJN4dY8uKv3CaLZSIZTQ=;
        b=U/A7i01VhOqOORzMWqr6m5//u4aK9Eo47myNlwIli3nmNULaE6BbBTcPqX1pg5OikL
         Qy3WwI+Hj0Xr5wN3rQR9pSPfxr3WxLZzLMfwMyjG30zLtq2Ch691CnKR+yec55sB8zNf
         j0Evh7yMZuh6JyWZp8hByNq1FMdMcEllQdw13oyGH86Vjz0nSpNikq+WS1CKhjjzU39B
         t4XKi10eKmiUJuHCYtovIAtV0mGiP+VCHNNqfTCgzjdy8kebV0I0l/Q1NcDRzsshWWvG
         nrpxc/Zab7WzvDcMgVzxVVVGvKE5s8mnb1tMZEmjKjnknK34PChvlU9XNkWAWMJFwF74
         E+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698693503; x=1699298303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zo93hmXviq3GO3T30OQUviOfJN4dY8uKv3CaLZSIZTQ=;
        b=ap+z7P0K2Mi/bHhZf63HH32x37o290E6zRBvLE7Slpvu0wVKLQgJbdsB9sOO1Jm9Bu
         MMW6Ov7afCPABWBX0+oriUkqIKEZf2TBpbIwpFsMUt+MX7Rt9WnacVGiHuTIO7+In0go
         cy76C24LZBfhxWkxXKbRc43qkhrTFlDHnFzgKiBXw54nidyLX0/lU7cp8OW7Cf+uj1Wc
         6zcnSSdLaVSvzEaFfaX8SQ70I1qOXSf+d3lZXhZ58YpG1CrayFROo5TVuNac43BZTWN5
         0K3fI57n065rmFbSEZkeI56Qt+buywrCi9Dxdx2iI7GBIRubPFyV9SmPFDMCyWXd8J8H
         4hyQ==
X-Gm-Message-State: AOJu0YztvB8O+nxA9oUAnrN/XB4L9KHATHyH7ZdhWcV4K2qSEDAIodjp
	R7f/9EORxZv3D+PER+2N6bNIzW+4190=
X-Google-Smtp-Source: AGHT+IFI6DV+aPLdqRgpCAN2FS3EHVm02YEIGjjho+BXk8sA9gJKncD/8cbKdLpN2DGWcwFqgnFzgQ==
X-Received: by 2002:a05:6830:4103:b0:6bf:1f5f:ed18 with SMTP id w3-20020a056830410300b006bf1f5fed18mr13920341ott.1.1698693502956;
        Mon, 30 Oct 2023 12:18:22 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l38-20020a0568302b2600b006cd099bb052sm1510500otv.1.2023.10.30.12.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:18:22 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 22/22] hashserv: server: Add owner if user is logged in
Date: Mon, 30 Oct 2023 13:17:28 -0600
Message-Id: <20231030191728.1276805-23-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030191728.1276805-1-JPEWhacker@gmail.com>
References: <20231012221655.632637-1-JPEWhacker@gmail.com>
 <20231030191728.1276805-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 19:18:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15324

If a user is authenticated with the server, report them as the owner of
a report

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/server.py | 3 +++
 lib/hashserv/tests.py  | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 5362457e..0c11e37b 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -474,6 +474,9 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
             if k in data:
                 outhash_data[k] = data[k]
 
+        if self.user:
+            outhash_data["owner"] = self.user.username
+
         # Insert the new entry, unless it already exists
         if await self.db.insert_outhash(outhash_data):
             # If this row is new, check if it is equivalent to another
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index f0be8679..a9e6fdf9 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -828,6 +828,15 @@ class HashEquivalenceCommonTests(object):
         for col in columns:
             self.client.remove({col: ""})
 
+    def test_auth_is_owner(self):
+        admin_client = self.start_auth_server()
+
+        user = self.create_user("test-user", ["@read", "@report"])
+        with self.auth_client(user) as client:
+            taskhash, outhash, unihash = self.create_test_hash(client)
+            data = client.get_taskhash(self.METHOD, taskhash, True)
+            self.assertEqual(data["owner"], user["username"])
+
 
 class TestHashEquivalenceClient(HashEquivalenceTestSetup, unittest.TestCase):
     def get_server_addr(self, server_idx):
-- 
2.34.1


