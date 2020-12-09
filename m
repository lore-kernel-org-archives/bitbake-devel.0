Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
 by mx.groups.io with SMTP id smtpd.web09.3470.1607550320379915105
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 09 Dec 2020 13:45:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=DCo8c79i;
 spf=pass (domain: gmail.com, ip: 209.85.210.47, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f47.google.com with SMTP id b18so2924283ots.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 09 Dec 2020 13:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SSltHwMUfNSxG7EF3iV6RxlR2Vr7vtvNJlwG22nAkjU=;
        b=DCo8c79iXL9Z89xe4rpk3FZQZOEAiAh/AZa+vWz4WjFtlZb82UhT746w7lXVhBE9ba
         8HtTAZPDJnMggv7IN0q3yyY9vlzCWzyOn1vjuFzr/0bGHXMQanur6RtH6Lwwues620aO
         Cp1Ey9VGEgYncJ4//6WbiAHaKsY/wtfmsMMTafsgQYOs00mUWctMKIUKKAvBPuYs73CJ
         yCHdgUAMOI8HKGlZwUlHetWpaRCOAhqiP6RG5yxBWwzF+OboCjRag2egwlOlzQydRgBv
         a0+OZw8KpyloIwIClgPd0BHX9QaKkfJgQoaS8kjhRakz3nWBjsB6+IwuuP/IF61MSZkG
         JkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SSltHwMUfNSxG7EF3iV6RxlR2Vr7vtvNJlwG22nAkjU=;
        b=pnJ0HG8EDIXD5uEszfyCZxLIHVOz8fVNqjNUbyl19ts1X0zxppzscjAdAcjWI6yD5w
         eUSONa0vI59oVwaI3g4NZdGAa849aPIrLvxiVaHtdpLHxBXU85lyJZKOq4zkwAcwPUiO
         ZcKo27g17IKmccRqUEN7J+LKBhLZYRmeqTNEx1rz0qETtQhaXnSsJN0NzQ2XaVh14Qha
         6562NCcvFSExfJ4ugbygqzlxV7h99VNJkFa+G9ciSv2jRtJ/fvfcrS3vTf3fG2t2VeeU
         t+3/rUr89TBy5VNQ+9qtdnID59vEv/V6a8N9jNzEqaRsTgfqNPwvWV3sp9CgA0uRuV1Y
         yFWA==
X-Gm-Message-State: AOAM532AznkAWgOk7KLLvUI/gh+KBx3Py61/9McWekyb5TGCaMcqLC4J
	nYJc+av7zJzz9NnRw5Ghp/KIR4sOd9TChg==
X-Google-Smtp-Source: ABdhPJxuuzkmQJsuL8M9CLBrWmuNm3g1BWOnKhBvTq9z9r2D2KKRUsG9dm5gvO9E1wKAiE3kr3qbfQ==
X-Received: by 2002:a9d:64c9:: with SMTP id n9mr3522566otl.282.1607550319450;
        Wed, 09 Dec 2020 13:45:19 -0800 (PST)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:e3e8:d9:3a56:e27d])
        by smtp.gmail.com with ESMTPSA id 186sm578640oof.16.2020.12.09.13.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 13:45:18 -0800 (PST)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Nicolas Dechesne <nicolas.dechesne@linaro.org>,
	Anuj Mittal <anuj.mittal@intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] hashserv: Fix broken AF_UNIX path length limit
Date: Wed,  9 Dec 2020 15:45:06 -0600
Message-Id: <20201209214506.29501-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the bug were long paths would break Unix domain socket clients
(for real this time; the previous attempt was missing os.path.basename).

Adds some tests to prevent regressions

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/client.py |  2 +-
 bitbake/lib/hashserv/tests.py  | 29 +++++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/hashserv/client.py b/bitbake/lib/hashserv/client.py
index 7bbf0865d5..0ffd0c2ae2 100644
--- a/bitbake/lib/hashserv/client.py
+++ b/bitbake/lib/hashserv/client.py
@@ -213,7 +213,7 @@ class Client(object):
         cwd = os.getcwd()
         try:
             os.chdir(os.path.dirname(path))
-            self.loop.run_until_complete(self.client.connect_unix(path))
+            self.loop.run_until_complete(self.client.connect_unix(os.path.basename(path)))
             self.loop.run_until_complete(self.client.connect())
         finally:
             os.chdir(cwd)
diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
index 3dd9a31bee..77a19b8077 100644
--- a/bitbake/lib/hashserv/tests.py
+++ b/bitbake/lib/hashserv/tests.py
@@ -23,7 +23,8 @@ def _run_server(server, idx):
     sys.stderr = sys.stdout
     server.serve_forever()
 
-class TestHashEquivalenceServer(object):
+
+class HashEquivalenceTestSetup(object):
     METHOD = 'TestMethod'
 
     server_index = 0
@@ -65,6 +66,8 @@ class TestHashEquivalenceServer(object):
         result = client.get_unihash(self.METHOD, taskhash)
         self.assertEqual(result, unihash)
 
+
+class HashEquivalenceCommonTests(object):
     def test_create_hash(self):
         # Simple test that hashes can be created
         taskhash = '35788efcb8dfb0a02659d81cf2bfd695fb30faf9'
@@ -240,15 +243,33 @@ class TestHashEquivalenceServer(object):
         self.assertClientGetHash(self.client, taskhash4, None)
 
 
-class TestHashEquivalenceUnixServer(TestHashEquivalenceServer, unittest.TestCase):
+class TestHashEquivalenceUnixServer(HashEquivalenceTestSetup, HashEquivalenceCommonTests, unittest.TestCase):
     def get_server_addr(self, server_idx):
         return "unix://" + os.path.join(self.temp_dir.name, 'sock%d' % server_idx)
 
 
-class TestHashEquivalenceTCPServer(TestHashEquivalenceServer, unittest.TestCase):
+class TestHashEquivalenceUnixServerLongPath(HashEquivalenceTestSetup, unittest.TestCase):
+    DEEP_DIRECTORY = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa/bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb/ccccccccccccccccccccccccccccccccccccccccccc"
+    def get_server_addr(self, server_idx):
+        os.makedirs(os.path.join(self.temp_dir.name, self.DEEP_DIRECTORY), exist_ok=True)
+        return "unix://" + os.path.join(self.temp_dir.name, self.DEEP_DIRECTORY, 'sock%d' % server_idx)
+
+
+    def test_long_sock_path(self):
+        # Simple test that hashes can be created
+        taskhash = '35788efcb8dfb0a02659d81cf2bfd695fb30faf9'
+        outhash = '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f'
+        unihash = 'f46d3fbb439bd9b921095da657a4de906510d2cd'
+
+        self.assertClientGetHash(self.client, taskhash, None)
+
+        result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
+        self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
+
+
+class TestHashEquivalenceTCPServer(HashEquivalenceTestSetup, HashEquivalenceCommonTests, unittest.TestCase):
     def get_server_addr(self, server_idx):
         # Some hosts cause asyncio module to misbehave, when IPv6 is not enabled.
         # If IPv6 is enabled, it should be safe to use localhost directly, in general
         # case it is more reliable to resolve the IP address explicitly.
         return socket.gethostbyname("localhost") + ":0"
-            
-- 
2.29.2

