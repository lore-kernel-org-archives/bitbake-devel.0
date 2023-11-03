Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93071C4332F
	for <webhook@archiver.kernel.org>; Fri,  3 Nov 2023 14:27:36 +0000 (UTC)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
 by mx.groups.io with SMTP id smtpd.web10.53517.1699021649954051603
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Nov 2023 07:27:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mtpFRFcm;
 spf=pass (domain: gmail.com, ip: 209.85.160.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1ea82246069so1106905fac.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 07:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699021648; x=1699626448; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmRYvKQH4mzkM8vqjwJmRNd9pdxPztZs0i8XEmLL9AM=;
        b=mtpFRFcmyCTrr0Ll/2ZZiRWiaWnMZDNBWSDdrWQ8l65Sq0C+gZ13wqrzvtSAFM9Ylh
         sv0lmj6IZ1TD21avbSt24d11LJCjYsXfBoe7DJULecD1COroXDWQQ0yRv2WXAptWrTXD
         8T3v26AZ52ykTnG51Xafh77wFSmcQFE1cLkv4gqH1sfPP2E6NHIh1i/Y4TAv/6Qkau6R
         z9f0lNNynv5JKfxm/N29NTRz1KtoCjJPjFUdsxPx6Vw3g3Pyx7G/a5WaajI4JKCpGdxK
         Foe3NaQ5M6gzKkeByfzGn1livmev4NLsFQzPrjhXD7x3gyc5vBZmNcPtRFyAjXCaqqjD
         xLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699021648; x=1699626448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmRYvKQH4mzkM8vqjwJmRNd9pdxPztZs0i8XEmLL9AM=;
        b=fksXVVacS1XAucYACRW0bgXAxqZfv7xp2XV4nomzaTft7BydOzh0O1+QHp534uxCdb
         5p0Kp1KL+GNemhuxj9dgo0KqOA+S5z6AqfAjMPrYzC9gHRn0zmJXOMOpZh6MSrP01ZJH
         BSdgg5IrmhQW1gio59z91iqlaW+xpZi+qtMiXpu2F6+9y8gFobT4n4Cglv7IOvOM3hDx
         64+OL+j2DvtnlXbZeDzkb3aWg6flkkunLrXIPJY8nne6q7LeWbF8HtRNZwDyJ32QmohT
         vpHPFbC0hrto+N6U5qH3XROjiKLyUltbjpH8dCKjIstAmxkgCty0ns/HVqQmeKpA6rHo
         dWtA==
X-Gm-Message-State: AOJu0YyUDb1DDM64i2aXJwBRnFImc8OsxArV2I3hLmVAqpkhiFmbWxx8
	Xipd7ZWbq8bvmhKvfH/TOhzfMAgh2j0=
X-Google-Smtp-Source: AGHT+IEkYse+CEcJqchtEu9uUo8QFxjOCYZ8iFHVyilqiyxzs32SkWlQbWlq0uFWgcII5RFqzybCJA==
X-Received: by 2002:a05:6871:3411:b0:1ea:50ec:7087 with SMTP id nh17-20020a056871341100b001ea50ec7087mr27156013oac.26.1699021648770;
        Fri, 03 Nov 2023 07:27:28 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::2fe0])
        by smtp.gmail.com with ESMTPSA id bb29-20020a056871b21d00b001dcde628a6fsm308272oac.42.2023.11.03.07.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 07:27:28 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v6 22/22] hashserv: server: Add owner if user is logged in
Date: Fri,  3 Nov 2023 08:26:40 -0600
Message-Id: <20231103142640.1936827-23-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103142640.1936827-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231103142640.1936827-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Nov 2023 14:27:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15442

If a user is authenticated with the server, report them as the owner of
a report

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/server.py | 3 +++
 lib/hashserv/tests.py  | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 439962f7..a8650783 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -475,6 +475,9 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
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


