Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB49C4167B
	for <webhook@archiver.kernel.org>; Thu, 30 Nov 2023 17:03:54 +0000 (UTC)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
 by mx.groups.io with SMTP id smtpd.web10.77817.1701363828957718407
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Nov 2023 09:03:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=CUiMDYCE;
 spf=pass (domain: gmail.com, ip: 209.85.210.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6d852e06b07so721943a34.3
        for <bitbake-devel@lists.openembedded.org>; Thu, 30 Nov 2023 09:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701363827; x=1701968627; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eCprqp7QogI4F1pHrRkc0YzO3JFksdjRJe/CNqFm06c=;
        b=CUiMDYCERjjS3a/w2t8EFMtVa8XRKWJ8+Cbs2Cb12FW+kdnLtRGh4A6EN0l9ptBNNZ
         qpbQ0b9dDmCT/Nq11n5lVd8FjePhuW78vvHP5KzsY3EgMeBK7H85rTTtWi2uLbXhhehY
         oRUgSpkOvnQQKN/UJMdEzQrmBiR/FiHSY3m3e1npo67d0d1Ccu/Veww+Syq5SEIvufiU
         VpqaEFH1nqswHmgY0XPMIzrgge0SB4oDM/YGJ1PQtu9ye+iyEyU3t7mD7zY/eabOBt4+
         HCeWAycHscztpH38OplN6avuIgnui/bxVafuUdefPU45xGrbWiipspkdhRV2nRoj91eX
         Zfgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701363827; x=1701968627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eCprqp7QogI4F1pHrRkc0YzO3JFksdjRJe/CNqFm06c=;
        b=ghzcSO/OqM6qZkHG2mkdm1LY7FWJGKKnDI3yqd2Z7lAahlZqPfk9qz44WjtdEQlrMI
         +sJkM4Gc+qLtTIgVqKZvewwOJuyfx9/bqzaYZO/f/WQbRuz2tLJai4b4qDrKlD2oX3Rl
         fGehDVURoKJxhb2IS5e0IbHmB7S2DA65bNoaxMIT2H9Ygcx1b9QC7IvhWn96dSJfyTMb
         WlKGPHBj/TO7fkGCCsJtDsxbnazRMNP+Nq1VqkN9Ey0Cu4tXrywv+rL+EDSeXcXJYJ49
         Y7VsPevGeK54vDh1SwZTLmqnACInrnT+A+96Xkzj9hSiJCoPR9cdfn+/rhBro5T/fI8i
         AuLQ==
X-Gm-Message-State: AOJu0YzgIucS/Nla9k6ulUKmynEQ5j22TDtSgOrSMOcehz0CUuu5K51p
	1WM2WrggFMOsWuR4Gif3UTDove9Xn7k=
X-Google-Smtp-Source: AGHT+IGTn8mTGP4H91jKruvb6byKZGFh587pViy5lsl1K2iww3JOQ34HZag6lgly+YmOXw7ju3INVw==
X-Received: by 2002:a05:6830:1bc7:b0:6ce:25a2:67cf with SMTP id v7-20020a0568301bc700b006ce25a267cfmr145778ota.26.1701363826806;
        Thu, 30 Nov 2023 09:03:46 -0800 (PST)
Received: from localhost.localdomain ([2601:282:4300:19e0::2176])
        by smtp.gmail.com with ESMTPSA id u12-20020a056830118c00b006ce2db9e6c4sm208576otq.36.2023.11.30.09.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 09:03:46 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] bitbake-hashclient: Add commands to get hashes
Date: Thu, 30 Nov 2023 10:03:43 -0700
Message-Id: <20231130170343.332113-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 30 Nov 2023 17:03:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15589

Adds subcommands to query the server for equivalent hashes and for
output hashes.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-hashclient | 27 +++++++++++++++++++++++++++
 lib/hashserv/tests.py  | 20 ++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/bin/bitbake-hashclient b/bin/bitbake-hashclient
index 3ff7b763..2cb63386 100755
--- a/bin/bitbake-hashclient
+++ b/bin/bitbake-hashclient
@@ -52,6 +52,22 @@ def print_user(u):
 
 
 def main():
+    def handle_get(args, client):
+        result = client.get_taskhash(args.method, args.taskhash, all_properties=True)
+        if not result:
+            return 0
+
+        print(json.dumps(result, sort_keys=True, indent=4))
+        return 0
+
+    def handle_get_outhash(args, client):
+        result = client.get_outhash(args.method, args.outhash, args.taskhash)
+        if not result:
+            return 0
+
+        print(json.dumps(result, sort_keys=True, indent=4))
+        return 0
+
     def handle_stats(args, client):
         if args.reset:
             s = client.reset_stats()
@@ -189,6 +205,17 @@ def main():
 
     subparsers = parser.add_subparsers()
 
+    get_parser = subparsers.add_parser('get', help="Get the unihash for a taskhash")
+    get_parser.add_argument("method", help="Method to query")
+    get_parser.add_argument("taskhash", help="Task hash to query")
+    get_parser.set_defaults(func=handle_get)
+
+    get_outhash_parser = subparsers.add_parser('get-outhash', help="Get output hash information")
+    get_outhash_parser.add_argument("method", help="Method to query")
+    get_outhash_parser.add_argument("outhash", help="Output hash to query")
+    get_outhash_parser.add_argument("taskhash", help="Task hash to query")
+    get_outhash_parser.set_defaults(func=handle_get_outhash)
+
     stats_parser = subparsers.add_parser('stats', help='Show server stats')
     stats_parser.add_argument('--reset', action='store_true',
                               help='Reset server stats')
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index a9e6fdf9..869f7636 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -842,6 +842,26 @@ class TestHashEquivalenceClient(HashEquivalenceTestSetup, unittest.TestCase):
     def get_server_addr(self, server_idx):
         return "unix://" + os.path.join(self.temp_dir.name, 'sock%d' % server_idx)
 
+    def test_get(self):
+        taskhash, outhash, unihash = self.create_test_hash(self.client)
+
+        p = self.run_hashclient(["--address", self.server_address, "get", self.METHOD, taskhash])
+        data = json.loads(p.stdout)
+        self.assertEqual(data["unihash"], unihash)
+        self.assertEqual(data["outhash"], outhash)
+        self.assertEqual(data["taskhash"], taskhash)
+        self.assertEqual(data["method"], self.METHOD)
+
+    def test_get_outhash(self):
+        taskhash, outhash, unihash = self.create_test_hash(self.client)
+
+        p = self.run_hashclient(["--address", self.server_address, "get-outhash", self.METHOD, outhash, taskhash])
+        data = json.loads(p.stdout)
+        self.assertEqual(data["unihash"], unihash)
+        self.assertEqual(data["outhash"], outhash)
+        self.assertEqual(data["taskhash"], taskhash)
+        self.assertEqual(data["method"], self.METHOD)
+
     def test_stats(self):
         p = self.run_hashclient(["--address", self.server_address, "stats"], check=True)
         json.loads(p.stdout)
-- 
2.34.1


