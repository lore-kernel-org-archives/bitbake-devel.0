Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C009C0018A
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 15:42:58 +0000 (UTC)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
 by mx.groups.io with SMTP id smtpd.web11.10740.1698853374962560665
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 08:42:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=khv+NuXQ;
 spf=pass (domain: gmail.com, ip: 209.85.167.170, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3b2b1af09c5so3569955b6e.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 08:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698853373; x=1699458173; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7hvYoh2S6qbXj4C1x0DKttkX+x6keospN6NMFKw+qA=;
        b=khv+NuXQvd0z4sYrN4gfh17y2jE8/IauQrz1mKiTHAZKN+QxR3rkr8SICMdwpqg0Sh
         o9LWN95eRatUAayDTgU2gYIasvZSm+9iVWoWRHBpJXOhxttYJKCXvWPBMRxUxtryYNgZ
         eRqN+3FdyFJ4fwyJMm5Iha/VkKt4m0zxlq+u7Cy78hbxEy59dgnWbZXQUP2iFvnoCFsU
         kJhFDuNO8flDtNGROjjLyqD0qR7fFD3PrBKAU+Xk86kEtGVkCa3T2QeThwjo17Hb/EGA
         njBpghnLHdKkcvHZcGDieUh2agn44MZ+xq6ih5XgQFjJJjW7SNPo2x16JUtqFxYVD2ba
         5Q9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698853373; x=1699458173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7hvYoh2S6qbXj4C1x0DKttkX+x6keospN6NMFKw+qA=;
        b=Fkgc2LEFyvkDZ5Q8lqg56pZx7I+TcmGwcEiIEHjIFxIXhg8f7X1COyWaArlv6H7m2N
         Yu4T9rLQDaUfWxCQXjWkD28rECAqIyuFIrkTYK5YDHNI6xYFg8LJJoCq1/y87osGOeQU
         SIdTcKArSlo2gfcee9BVdSpEoepEMWRHVH1nNKO/uimqJuhY6RQeWtPCjC9a0SdMO4CU
         dk4eJkMfM8s5PLKQm7s+Ix10PW2W9YhYr/+tEwvBd46Xqx0Nfe7bGiIY16i01AcR/Kmt
         ZMd3+aNMFUJg3isQK8JGsK6GR6JFmXpZsOyJwCKSyW+w7ky/QSSjC1gcIu5OauMeh2do
         ZVaw==
X-Gm-Message-State: AOJu0YyX71+uEXhnqAAFed8VWUylwJekQBzA+0664q5hknS4OhCdUx36
	u34B7OoPWQGPW3qSmYe1SzZDKVuzlEk=
X-Google-Smtp-Source: AGHT+IFEjQlG1gT6zIXcCEyOVLVSOApKwMZlJwSuey2LNa+FW34XCrZTuziv/dcKZaKdcmeReDURDw==
X-Received: by 2002:a05:6808:13d6:b0:3ae:5372:3790 with SMTP id d22-20020a05680813d600b003ae53723790mr17248073oiw.48.1698853373123;
        Wed, 01 Nov 2023 08:42:53 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l9-20020aca1909000000b003ae36d664a9sm249651oii.39.2023.11.01.08.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:42:52 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v5 20/22] hashserv: tests: Allow authentication for external server tests
Date: Wed,  1 Nov 2023 09:42:14 -0600
Message-Id: <20231101154216.2758185-21-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101154216.2758185-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231101154216.2758185-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 15:42:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15402

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


