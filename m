Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16265C4167B
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 17:22:23 +0000 (UTC)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
 by mx.groups.io with SMTP id smtpd.web10.1630.1698772937560926615
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 10:22:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lL4B9mZ2;
 spf=pass (domain: gmail.com, ip: 209.85.210.41, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6cd33d51852so3998790a34.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 10:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698772936; x=1699377736; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sb8Oz+vfrspWoVRMPfMobfEmIuUi+HH4bpY7OQ2q36w=;
        b=lL4B9mZ2yOWtMnDTUrpIdkhI8US/Wy2s0qKI5J34fXMb4acSr38DF1fNNfafRghJcj
         bmwjukxxmSml1MbgNSJWGbyR+xxGKarw3eVFcI7qd92s71QStPCjlolUk9gqh+vupYSX
         Y/ooEEpFxMYnAvRQ1FxyHaMUeRhgYxohnfy1u91s8//6ADNnhq+KEGzx93KAdlTuEoZi
         vVLjU8I0YQO1HNmh/1MKsB5X1F1YP9s2cpijH8N4k6EbJfUubAiMBrTKfXb7g+YrF+DO
         E64DBs6V5SeVYgBrBjo7HCOePlyPQeJCRPEPMbRFop+UXAJzHYZh5igCnW9OPJclz0DT
         UB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698772936; x=1699377736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sb8Oz+vfrspWoVRMPfMobfEmIuUi+HH4bpY7OQ2q36w=;
        b=ChIcLsZFIttUOFD0zdaATymn2cyj7gEwFTvhG/kX+r390Bo+WQ2yU8oFY1yQZzqmY9
         yvd1sm5GfwvEHNHDbP9vw71YBviNtWrQKA6Hl1J/dkiKCE8Bc75wrVc2iX0iva3o5g5+
         6WAwJLPtHOeuzDODMfKqkJJ9qIZc7mfK0YFrnZ67W/FmD/CvFLMcV6OmZP7biTDBVLDL
         adwIZ0M+/dZnRr7KTRgoKodi9gnYZ48/eTEiee98aaziccbHCYakN6402EQZ6mXBuUM5
         CTCJIdIt1WGvyVAAjpw38omNmO/VgLRCtWIbTaTglrCUME2nBtLX7URAy4NjelANUU7O
         5OkA==
X-Gm-Message-State: AOJu0YyP5fXjK2HIVHYiBsfYjNvJwjhilg+e+aibC2RsGdjG+XRBNPkc
	bZok75TvF6hZN4xhLrj35IvqbyNEIis=
X-Google-Smtp-Source: AGHT+IFFIu6ZMVgDIkaS77/vjxjqyIiIn5HSq/sqyUDOcIe3d3SEbSn/pfz7m1qtaf9UbdvN0ZGSlA==
X-Received: by 2002:a9d:62d0:0:b0:6b7:4a52:a33a with SMTP id z16-20020a9d62d0000000b006b74a52a33amr12256480otk.14.1698772935761;
        Tue, 31 Oct 2023 10:22:15 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id k6-20020a056830150600b006ce2e464a45sm282503otp.29.2023.10.31.10.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:22:14 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4 17/22] hashserv: test: Add bitbake-hashclient tests
Date: Tue, 31 Oct 2023 11:21:33 -0600
Message-Id: <20231031172138.3577199-18-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031172138.3577199-1-JPEWhacker@gmail.com>
References: <20231030191728.1276805-1-JPEWhacker@gmail.com>
 <20231031172138.3577199-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 17:22:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15367

The bitbake-hashclient command-line tool now has a lot more features
which should be tested, so add some tests for them.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/tests.py | 300 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 277 insertions(+), 23 deletions(-)

diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index fc69acaf..a80ccd57 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -19,6 +19,14 @@ import unittest
 import socket
 import time
 import signal
+import subprocess
+import json
+import re
+from pathlib import Path
+
+
+THIS_DIR = Path(__file__).parent
+BIN_DIR = THIS_DIR.parent.parent / "bin"
 
 def server_prefunc(server, idx):
     logging.basicConfig(level=logging.DEBUG, filename='bbhashserv-%d.log' % idx, filemode='w',
@@ -103,8 +111,22 @@ class HashEquivalenceTestSetup(object):
         result = client.get_unihash(self.METHOD, taskhash)
         self.assertEqual(result, unihash)
 
+    def assertUserPerms(self, user, permissions):
+        with self.auth_client(user) as client:
+            info = client.get_user()
+            self.assertEqual(info, {
+                "username": user["username"],
+                "permissions": permissions,
+            })
+
+    def assertUserCanAuth(self, user):
+        with self.start_client(self.auth_server.address) as client:
+            client.auth(user["username"], user["token"])
+
+    def assertUserCannotAuth(self, user):
+        with self.start_client(self.auth_server.address) as client, self.assertRaises(InvokeError):
+            client.auth(user["username"], user["token"])
 
-class HashEquivalenceCommonTests(object):
     def create_test_hash(self, client):
         # Simple test that hashes can be created
         taskhash = '35788efcb8dfb0a02659d81cf2bfd695fb30faf9'
@@ -117,6 +139,24 @@ class HashEquivalenceCommonTests(object):
         self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
         return taskhash, outhash, unihash
 
+    def run_hashclient(self, args, **kwargs):
+        try:
+            p = subprocess.run(
+                [BIN_DIR / "bitbake-hashclient"] + args,
+                stdout=subprocess.PIPE,
+                stderr=subprocess.STDOUT,
+                encoding="utf-8",
+                **kwargs
+            )
+        except subprocess.CalledProcessError as e:
+            print(e.output)
+            raise e
+
+        print(p.stdout)
+        return p
+
+
+class HashEquivalenceCommonTests(object):
     def test_create_hash(self):
         return self.create_test_hash(self.client)
 
@@ -161,7 +201,7 @@ class HashEquivalenceCommonTests(object):
         self.assertClientGetHash(self.client, taskhash, unihash)
 
     def test_remove_taskhash(self):
-        taskhash, outhash, unihash = self.test_create_hash()
+        taskhash, outhash, unihash = self.create_test_hash(self.client)
         result = self.client.remove({"taskhash": taskhash})
         self.assertGreater(result["count"], 0)
         self.assertClientGetHash(self.client, taskhash, None)
@@ -170,13 +210,13 @@ class HashEquivalenceCommonTests(object):
         self.assertIsNone(result_outhash)
 
     def test_remove_unihash(self):
-        taskhash, outhash, unihash = self.test_create_hash()
+        taskhash, outhash, unihash = self.create_test_hash(self.client)
         result = self.client.remove({"unihash": unihash})
         self.assertGreater(result["count"], 0)
         self.assertClientGetHash(self.client, taskhash, None)
 
     def test_remove_outhash(self):
-        taskhash, outhash, unihash = self.test_create_hash()
+        taskhash, outhash, unihash = self.create_test_hash(self.client)
         result = self.client.remove({"outhash": outhash})
         self.assertGreater(result["count"], 0)
 
@@ -184,7 +224,7 @@ class HashEquivalenceCommonTests(object):
         self.assertIsNone(result_outhash)
 
     def test_remove_method(self):
-        taskhash, outhash, unihash = self.test_create_hash()
+        taskhash, outhash, unihash = self.create_test_hash(self.client)
         result = self.client.remove({"method": self.METHOD})
         self.assertGreater(result["count"], 0)
         self.assertClientGetHash(self.client, taskhash, None)
@@ -193,7 +233,7 @@ class HashEquivalenceCommonTests(object):
         self.assertIsNone(result_outhash)
 
     def test_clean_unused(self):
-        taskhash, outhash, unihash = self.test_create_hash()
+        taskhash, outhash, unihash = self.create_test_hash(self.client)
 
         # Clean the database, which should not remove anything because all hashes an in-use
         result = self.client.clean_unused(0)
@@ -497,7 +537,7 @@ class HashEquivalenceCommonTests(object):
         admin_client = self.start_auth_server()
 
         # Create hashes with non-authenticated server
-        taskhash, outhash, unihash = self.test_create_hash()
+        taskhash, outhash, unihash = self.create_test_hash(self.client)
 
         # Validate hash can be retrieved using authenticated client
         with self.auth_perms("@read") as client:
@@ -534,14 +574,6 @@ class HashEquivalenceCommonTests(object):
         with self.start_client(self.auth_server.address) as client, self.assertRaises(InvokeError):
             client.refresh_token()
 
-    def assertUserCanAuth(self, user):
-        with self.start_client(self.auth_server.address) as client:
-            client.auth(user["username"], user["token"])
-
-    def assertUserCannotAuth(self, user):
-        with self.start_client(self.auth_server.address) as client, self.assertRaises(InvokeError):
-            client.auth(user["username"], user["token"])
-
     def test_auth_self_token_refresh(self):
         admin_client = self.start_auth_server()
 
@@ -650,14 +682,6 @@ class HashEquivalenceCommonTests(object):
         with self.auth_perms("@user-admin") as client, self.assertRaises(InvokeError):
             client.delete_user(user["username"])
 
-    def assertUserPerms(self, user, permissions):
-        with self.auth_client(user) as client:
-            info = client.get_user()
-            self.assertEqual(info, {
-                "username": user["username"],
-                "permissions": permissions,
-            })
-
     def test_auth_set_user_perms(self):
         admin_client = self.start_auth_server()
 
@@ -785,6 +809,236 @@ class HashEquivalenceCommonTests(object):
         for col in columns:
             self.client.remove({col: ""})
 
+
+class TestHashEquivalenceClient(HashEquivalenceTestSetup, unittest.TestCase):
+    def get_server_addr(self, server_idx):
+        return "unix://" + os.path.join(self.temp_dir.name, 'sock%d' % server_idx)
+
+    def test_stats(self):
+        self.run_hashclient(["--address", self.server_address, "stats"], check=True)
+
+    def test_stress(self):
+        self.run_hashclient(["--address", self.server_address, "stress"], check=True)
+
+    def test_remove_taskhash(self):
+        taskhash, outhash, unihash = self.create_test_hash(self.client)
+        self.run_hashclient([
+            "--address", self.server_address,
+            "remove",
+            "--where", "taskhash", taskhash,
+        ], check=True)
+        self.assertClientGetHash(self.client, taskhash, None)
+
+        result_outhash = self.client.get_outhash(self.METHOD, outhash, taskhash)
+        self.assertIsNone(result_outhash)
+
+    def test_remove_unihash(self):
+        taskhash, outhash, unihash = self.create_test_hash(self.client)
+        self.run_hashclient([
+            "--address", self.server_address,
+            "remove",
+            "--where", "unihash", unihash,
+        ], check=True)
+        self.assertClientGetHash(self.client, taskhash, None)
+
+    def test_remove_outhash(self):
+        taskhash, outhash, unihash = self.create_test_hash(self.client)
+        self.run_hashclient([
+            "--address", self.server_address,
+            "remove",
+            "--where", "outhash", outhash,
+        ], check=True)
+
+        result_outhash = self.client.get_outhash(self.METHOD, outhash, taskhash)
+        self.assertIsNone(result_outhash)
+
+    def test_remove_method(self):
+        taskhash, outhash, unihash = self.create_test_hash(self.client)
+        self.run_hashclient([
+            "--address", self.server_address,
+            "remove",
+            "--where", "method", self.METHOD,
+        ], check=True)
+        self.assertClientGetHash(self.client, taskhash, None)
+
+        result_outhash = self.client.get_outhash(self.METHOD, outhash, taskhash)
+        self.assertIsNone(result_outhash)
+
+    def test_clean_unused(self):
+        taskhash, outhash, unihash = self.create_test_hash(self.client)
+
+        # Clean the database, which should not remove anything because all hashes an in-use
+        self.run_hashclient([
+            "--address", self.server_address,
+            "clean-unused", "0",
+        ], check=True)
+        self.assertClientGetHash(self.client, taskhash, unihash)
+
+        # Remove the unihash. The row in the outhash table should still be present
+        self.run_hashclient([
+            "--address", self.server_address,
+            "remove",
+            "--where", "unihash", unihash,
+        ], check=True)
+        result_outhash = self.client.get_outhash(self.METHOD, outhash, taskhash, False)
+        self.assertIsNotNone(result_outhash)
+
+        # Now clean with no minimum age which will remove the outhash
+        self.run_hashclient([
+            "--address", self.server_address,
+            "clean-unused", "0",
+        ], check=True)
+        result_outhash = self.client.get_outhash(self.METHOD, outhash, taskhash, False)
+        self.assertIsNone(result_outhash)
+
+    def test_refresh_token(self):
+        admin_client = self.start_auth_server()
+
+        user = admin_client.new_user("test-user", ["@read", "@report"])
+
+        p = self.run_hashclient([
+            "--address", self.auth_server.address,
+            "--login", user["username"],
+            "--password", user["token"],
+            "refresh-token"
+        ], check=True)
+
+        new_token = None
+        for l in p.stdout.splitlines():
+            l = l.rstrip()
+            m = re.match(r'Token: +(.*)$', l)
+            if m is not None:
+                new_token = m.group(1)
+
+        self.assertTrue(new_token)
+
+        print("New token is %r" % new_token)
+
+        self.run_hashclient([
+            "--address", self.auth_server.address,
+            "--login", user["username"],
+            "--password", new_token,
+            "get-user"
+        ], check=True)
+
+    def test_set_user_perms(self):
+        admin_client = self.start_auth_server()
+
+        user = admin_client.new_user("test-user", ["@read"])
+
+        self.run_hashclient([
+            "--address", self.auth_server.address,
+            "--login", admin_client.username,
+            "--password", admin_client.password,
+            "set-user-perms",
+            "-u", user["username"],
+            "@read", "@report",
+        ], check=True)
+
+        new_user = admin_client.get_user(user["username"])
+
+        self.assertEqual(set(new_user["permissions"]), {"@read", "@report"})
+
+    def test_get_user(self):
+        admin_client = self.start_auth_server()
+
+        user = admin_client.new_user("test-user", ["@read"])
+
+        p = self.run_hashclient([
+            "--address", self.auth_server.address,
+            "--login", admin_client.username,
+            "--password", admin_client.password,
+            "get-user",
+            "-u", user["username"],
+        ], check=True)
+
+        self.assertIn("Username:", p.stdout)
+        self.assertIn("Permissions:", p.stdout)
+
+        p = self.run_hashclient([
+            "--address", self.auth_server.address,
+            "--login", user["username"],
+            "--password", user["token"],
+            "get-user",
+        ], check=True)
+
+        self.assertIn("Username:", p.stdout)
+        self.assertIn("Permissions:", p.stdout)
+
+    def test_get_all_users(self):
+        admin_client = self.start_auth_server()
+
+        admin_client.new_user("test-user1", ["@read"])
+        admin_client.new_user("test-user2", ["@read"])
+
+        p = self.run_hashclient([
+            "--address", self.auth_server.address,
+            "--login", admin_client.username,
+            "--password", admin_client.password,
+            "get-all-users",
+        ], check=True)
+
+        self.assertIn("admin", p.stdout)
+        self.assertIn("test-user1", p.stdout)
+        self.assertIn("test-user2", p.stdout)
+
+    def test_new_user(self):
+        admin_client = self.start_auth_server()
+
+        p = self.run_hashclient([
+            "--address", self.auth_server.address,
+            "--login", admin_client.username,
+            "--password", admin_client.password,
+            "new-user",
+            "-u", "test-user",
+            "@read", "@report",
+        ], check=True)
+
+        new_token = None
+        for l in p.stdout.splitlines():
+            l = l.rstrip()
+            m = re.match(r'Token: +(.*)$', l)
+            if m is not None:
+                new_token = m.group(1)
+
+        self.assertTrue(new_token)
+
+        user = {
+            "username": "test-user",
+            "token": new_token,
+        }
+
+        self.assertUserPerms(user, ["@read", "@report"])
+
+    def test_delete_user(self):
+        admin_client = self.start_auth_server()
+
+        user = admin_client.new_user("test-user", ["@read"])
+
+        p = self.run_hashclient([
+            "--address", self.auth_server.address,
+            "--login", admin_client.username,
+            "--password", admin_client.password,
+            "delete-user",
+            "-u", user["username"],
+        ], check=True)
+
+
+        self.assertIsNone(admin_client.get_user(user["username"]))
+
+    def test_get_db_usage(self):
+        p = self.run_hashclient([
+            "--address", self.server_address,
+            "get-db-usage",
+        ], check=True)
+
+    def test_get_db_query_columns(self):
+        p = self.run_hashclient([
+            "--address", self.server_address,
+            "get-db-query-columns",
+        ], check=True)
+
+
 class TestHashEquivalenceUnixServer(HashEquivalenceTestSetup, HashEquivalenceCommonTests, unittest.TestCase):
     def get_server_addr(self, server_idx):
         return "unix://" + os.path.join(self.temp_dir.name, 'sock%d' % server_idx)
-- 
2.34.1


