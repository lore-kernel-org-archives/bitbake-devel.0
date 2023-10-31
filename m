Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222E1C4167B
	for <webhook@archiver.kernel.org>; Tue, 31 Oct 2023 17:22:33 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
 by mx.groups.io with SMTP id smtpd.web11.1688.1698772942972443267
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Oct 2023 10:22:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Tsh234vb;
 spf=pass (domain: gmail.com, ip: 209.85.210.54, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ce2cc39d12so3726872a34.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 10:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698772941; x=1699377741; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7hvYoh2S6qbXj4C1x0DKttkX+x6keospN6NMFKw+qA=;
        b=Tsh234vbZgeQYJSme4av9ZPk/5JmYojO3KnzoHeUT6bHNmhH0zSjdaOP4yuOpjpWXO
         UXK9ceQvg/qkaGJyuE+lKElUQZaiLJSzCo1GKY+I5pRvhMTF/XcKavXyxtWjEVbfvbEY
         cJBosLvTmbS73jWLENjfmfV2U1CS04SdSmJZ0i6UM9fS7qhr5YeQouKQO/Dm43fwarAR
         a4v6nS0m3f5opyW7HJ/+174UIUhlyfaThIrplJ8g4uK7ER+Yvt+7AH9Jp670D9fIE8GK
         IiInzGbHaFASL/ncxFcyqs+fi4axJI+7O+3mg9fYBhAz5ZmvJ0xcJSLoBOX3h/f83WO3
         Zpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698772941; x=1699377741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7hvYoh2S6qbXj4C1x0DKttkX+x6keospN6NMFKw+qA=;
        b=O4VJCO7oyclvmUrDlFGHt8vjc6lDaL+yATMh3jCph0FtaECDnKnh85E3hzsuyNJRR6
         e/RkozoYG1FxPMZpLELqynki0N0cC7ElZZsoFJRwsv1dxlBe2YJ2rGfxHzO8AQdylAOS
         tGtI0P8sHNz7TwER667uvCRwW5Mba/KY3LJMP5BpkoUyuSAKaexFERwebMk5zDGAyG5o
         JqOawuApc0QWDXCfcxuu8h1NClgHrQPhVu01AIEfs17eordyEFZmT5FVA0FH9aMukoCI
         HCSxE6Lunk5q1AJ04Og9uZloeywn58ZCUx/gEkk97yIUq9qr9IpDNWPqyeWQtXN/M2a+
         eGYg==
X-Gm-Message-State: AOJu0YxozT6zc/k7jjnU1dvudJpzSFlIDW5jW2zt2wjrtY+rFrU7DPpm
	bYE/IqpBqkgy/iV0mENa+jjdgtvv56w=
X-Google-Smtp-Source: AGHT+IGpBu16utPkeVFf2pavEF0EXv7RwAHcVo34+DNr7syYgxX2UGaGb7lcOK1SZwgQ3T8QNciQhQ==
X-Received: by 2002:a9d:6ac3:0:b0:6bb:1071:ea72 with SMTP id m3-20020a9d6ac3000000b006bb1071ea72mr12847113otq.36.1698772941199;
        Tue, 31 Oct 2023 10:22:21 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id k6-20020a056830150600b006ce2e464a45sm282503otp.29.2023.10.31.10.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:22:19 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v4 20/22] hashserv: tests: Allow authentication for external server tests
Date: Tue, 31 Oct 2023 11:21:36 -0600
Message-Id: <20231031172138.3577199-21-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231031172138.3577199-1-JPEWhacker@gmail.com>
References: <20231030191728.1276805-1-JPEWhacker@gmail.com>
 <20231031172138.3577199-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Oct 2023 17:22:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15370

If BB_TEST_HASHSERV_USERNAME and BB_TEST_HASHSERV_PASSWORD are provided
for a server admin user, the authentication tests for the external
hashserver will run. In addition, any users that get created will now be
deleted when the test finishes.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/tests.py | 109 ++++++++++++++++++++++++++++--------------
 1 file changed, 74 insertions(+), 35 deletions(-)

diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 2d78f9e9..5d209ffb 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -84,17 +84,13 @@ class HashEquivalenceTestSetup(object):
         return self.server.address
 
     def start_auth_server(self):
-        self.auth_server = self.start_server(self.server.dbpath, anon_perms=[], admin_username="admin", admin_password="password")
-        self.admin_client = self.start_client(self.auth_server.address, username="admin", password="password")
+        auth_server = self.start_server(self.server.dbpath, anon_perms=[], admin_username="admin", admin_password="password")
+        self.auth_server_address = auth_server.address
+        self.admin_client = self.start_client(auth_server.address, username="admin", password="password")
         return self.admin_client
 
     def auth_client(self, user):
-        return self.start_client(self.auth_server.address, user["username"], user["token"])
-
-    def auth_perms(self, *permissions):
-        self.client_index += 1
-        user = self.admin_client.new_user(f"user-{self.client_index}", permissions)
-        return self.auth_client(user)
+        return self.start_client(self.auth_server_address, user["username"], user["token"])
 
     def setUp(self):
         if sys.version_info < (3, 5, 0):
@@ -120,11 +116,11 @@ class HashEquivalenceTestSetup(object):
             })
 
     def assertUserCanAuth(self, user):
-        with self.start_client(self.auth_server.address) as client:
+        with self.start_client(self.auth_server_address) as client:
             client.auth(user["username"], user["token"])
 
     def assertUserCannotAuth(self, user):
-        with self.start_client(self.auth_server.address) as client, self.assertRaises(InvokeError):
+        with self.start_client(self.auth_server_address) as client, self.assertRaises(InvokeError):
             client.auth(user["username"], user["token"])
 
     def create_test_hash(self, client):
@@ -157,6 +153,26 @@ class HashEquivalenceTestSetup(object):
 
 
 class HashEquivalenceCommonTests(object):
+    def auth_perms(self, *permissions):
+        self.client_index += 1
+        user = self.create_user(f"user-{self.client_index}", permissions)
+        return self.auth_client(user)
+
+    def create_user(self, username, permissions, *, client=None):
+        def remove_user(username):
+            try:
+                self.admin_client.delete_user(username)
+            except bb.asyncrpc.InvokeError:
+                pass
+
+        if client is None:
+            client = self.admin_client
+
+        user = client.new_user(username, permissions)
+        self.addCleanup(remove_user, username)
+
+        return user
+
     def test_create_hash(self):
         return self.create_test_hash(self.client)
 
@@ -571,14 +587,14 @@ class HashEquivalenceCommonTests(object):
     def test_auth_no_token_refresh_from_anon_user(self):
         self.start_auth_server()
 
-        with self.start_client(self.auth_server.address) as client, self.assertRaises(InvokeError):
+        with self.start_client(self.auth_server_address) as client, self.assertRaises(InvokeError):
             client.refresh_token()
 
     def test_auth_self_token_refresh(self):
         admin_client = self.start_auth_server()
 
         # Create a new user with no permissions
-        user = admin_client.new_user("test-user", [])
+        user = self.create_user("test-user", [])
 
         with self.auth_client(user) as client:
             new_user = client.refresh_token()
@@ -601,7 +617,7 @@ class HashEquivalenceCommonTests(object):
     def test_auth_token_refresh(self):
         admin_client = self.start_auth_server()
 
-        user = admin_client.new_user("test-user", [])
+        user = self.create_user("test-user", [])
 
         with self.auth_perms() as client, self.assertRaises(InvokeError):
             client.refresh_token(user["username"])
@@ -617,7 +633,7 @@ class HashEquivalenceCommonTests(object):
     def test_auth_self_get_user(self):
         admin_client = self.start_auth_server()
 
-        user = admin_client.new_user("test-user", [])
+        user = self.create_user("test-user", [])
         user_info = user.copy()
         del user_info["token"]
 
@@ -632,7 +648,7 @@ class HashEquivalenceCommonTests(object):
     def test_auth_get_user(self):
         admin_client = self.start_auth_server()
 
-        user = admin_client.new_user("test-user", [])
+        user = self.create_user("test-user", [])
         user_info = user.copy()
         del user_info["token"]
 
@@ -649,7 +665,7 @@ class HashEquivalenceCommonTests(object):
     def test_auth_reconnect(self):
         admin_client = self.start_auth_server()
 
-        user = admin_client.new_user("test-user", [])
+        user = self.create_user("test-user", [])
         user_info = user.copy()
         del user_info["token"]
 
@@ -665,7 +681,7 @@ class HashEquivalenceCommonTests(object):
     def test_auth_delete_user(self):
         admin_client = self.start_auth_server()
 
-        user = admin_client.new_user("test-user", [])
+        user = self.create_user("test-user", [])
 
         # No self service
         with self.auth_client(user) as client, self.assertRaises(InvokeError):
@@ -685,7 +701,7 @@ class HashEquivalenceCommonTests(object):
     def test_auth_set_user_perms(self):
         admin_client = self.start_auth_server()
 
-        user = admin_client.new_user("test-user", [])
+        user = self.create_user("test-user", [])
 
         self.assertUserPerms(user, [])
 
@@ -710,7 +726,7 @@ class HashEquivalenceCommonTests(object):
     def test_auth_get_all_users(self):
         admin_client = self.start_auth_server()
 
-        user = admin_client.new_user("test-user", [])
+        user = self.create_user("test-user", [])
 
         with self.auth_client(user) as client, self.assertRaises(InvokeError):
             client.get_all_users()
@@ -744,10 +760,10 @@ class HashEquivalenceCommonTests(object):
         permissions.sort()
 
         with self.auth_perms() as client, self.assertRaises(InvokeError):
-            client.new_user("test-user", permissions)
+            self.create_user("test-user", permissions, client=client)
 
         with self.auth_perms("@user-admin") as client:
-            user = client.new_user("test-user", permissions)
+            user = self.create_user("test-user", permissions, client=client)
             self.assertIn("token", user)
             self.assertEqual(user["username"], "test-user")
             self.assertEqual(user["permissions"], permissions)
@@ -755,7 +771,7 @@ class HashEquivalenceCommonTests(object):
     def test_auth_become_user(self):
         admin_client = self.start_auth_server()
 
-        user = admin_client.new_user("test-user", ["@read", "@report"])
+        user = self.create_user("test-user", ["@read", "@report"])
         user_info = user.copy()
         del user_info["token"]
 
@@ -898,7 +914,7 @@ class TestHashEquivalenceClient(HashEquivalenceTestSetup, unittest.TestCase):
         user = admin_client.new_user("test-user", ["@read", "@report"])
 
         p = self.run_hashclient([
-            "--address", self.auth_server.address,
+            "--address", self.auth_server_address,
             "--login", user["username"],
             "--password", user["token"],
             "refresh-token"
@@ -916,7 +932,7 @@ class TestHashEquivalenceClient(HashEquivalenceTestSetup, unittest.TestCase):
         print("New token is %r" % new_token)
 
         self.run_hashclient([
-            "--address", self.auth_server.address,
+            "--address", self.auth_server_address,
             "--login", user["username"],
             "--password", new_token,
             "get-user"
@@ -928,7 +944,7 @@ class TestHashEquivalenceClient(HashEquivalenceTestSetup, unittest.TestCase):
         user = admin_client.new_user("test-user", ["@read"])
 
         self.run_hashclient([
-            "--address", self.auth_server.address,
+            "--address", self.auth_server_address,
             "--login", admin_client.username,
             "--password", admin_client.password,
             "set-user-perms",
@@ -946,7 +962,7 @@ class TestHashEquivalenceClient(HashEquivalenceTestSetup, unittest.TestCase):
         user = admin_client.new_user("test-user", ["@read"])
 
         p = self.run_hashclient([
-            "--address", self.auth_server.address,
+            "--address", self.auth_server_address,
             "--login", admin_client.username,
             "--password", admin_client.password,
             "get-user",
@@ -957,7 +973,7 @@ class TestHashEquivalenceClient(HashEquivalenceTestSetup, unittest.TestCase):
         self.assertIn("Permissions:", p.stdout)
 
         p = self.run_hashclient([
-            "--address", self.auth_server.address,
+            "--address", self.auth_server_address,
             "--login", user["username"],
             "--password", user["token"],
             "get-user",
@@ -973,7 +989,7 @@ class TestHashEquivalenceClient(HashEquivalenceTestSetup, unittest.TestCase):
         admin_client.new_user("test-user2", ["@read"])
 
         p = self.run_hashclient([
-            "--address", self.auth_server.address,
+            "--address", self.auth_server_address,
             "--login", admin_client.username,
             "--password", admin_client.password,
             "get-all-users",
@@ -987,7 +1003,7 @@ class TestHashEquivalenceClient(HashEquivalenceTestSetup, unittest.TestCase):
         admin_client = self.start_auth_server()
 
         p = self.run_hashclient([
-            "--address", self.auth_server.address,
+            "--address", self.auth_server_address,
             "--login", admin_client.username,
             "--password", admin_client.password,
             "new-user",
@@ -1017,14 +1033,13 @@ class TestHashEquivalenceClient(HashEquivalenceTestSetup, unittest.TestCase):
         user = admin_client.new_user("test-user", ["@read"])
 
         p = self.run_hashclient([
-            "--address", self.auth_server.address,
+            "--address", self.auth_server_address,
             "--login", admin_client.username,
             "--password", admin_client.password,
             "delete-user",
             "-u", user["username"],
         ], check=True)
 
-
         self.assertIsNone(admin_client.get_user(user["username"]))
 
     def test_get_db_usage(self):
@@ -1104,19 +1119,43 @@ class TestHashEquivalenceWebsocketsSQLAlchemyServer(TestHashEquivalenceWebsocket
 
 
 class TestHashEquivalenceExternalServer(HashEquivalenceTestSetup, HashEquivalenceCommonTests, unittest.TestCase):
-    def start_test_server(self):
-        if 'BB_TEST_HASHSERV' not in os.environ:
-            self.skipTest('BB_TEST_HASHSERV not defined to test an external server')
+    def get_env(self, name):
+        v = os.environ.get(name)
+        if not v:
+            self.skipTest(f'{name} not defined to test an external server')
+        return v
 
-        return os.environ['BB_TEST_HASHSERV']
+    def start_test_server(self):
+        return self.get_env('BB_TEST_HASHSERV')
 
     def start_server(self, *args, **kwargs):
         self.skipTest('Cannot start local server when testing external servers')
 
+    def start_auth_server(self):
+
+        self.auth_server_address = self.server_address
+        self.admin_client = self.start_client(
+            self.server_address,
+            username=self.get_env('BB_TEST_HASHSERV_USERNAME'),
+            password=self.get_env('BB_TEST_HASHSERV_PASSWORD'),
+        )
+        return self.admin_client
+
     def setUp(self):
         super().setUp()
+        if "BB_TEST_HASHSERV_USERNAME" in os.environ:
+            self.client = self.start_client(
+                self.server_address,
+                username=os.environ["BB_TEST_HASHSERV_USERNAME"],
+                password=os.environ["BB_TEST_HASHSERV_PASSWORD"],
+            )
         self.client.remove({"method": self.METHOD})
 
     def tearDown(self):
         self.client.remove({"method": self.METHOD})
         super().tearDown()
+
+
+    def test_auth_get_all_users(self):
+        self.skipTest("Cannot test all users with external server")
+
-- 
2.34.1


