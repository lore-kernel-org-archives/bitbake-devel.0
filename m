Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B464CDB474
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 22:17:35 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
 by mx.groups.io with SMTP id smtpd.web10.25788.1697149047266141796
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Oct 2023 15:17:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Gt3CIVmO;
 spf=pass (domain: gmail.com, ip: 209.85.167.176, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3af608eb367so927987b6e.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 15:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697149046; x=1697753846; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kVF4kTtuXIp4L229IG65cBbR+yZ1UhhYBoW6+BiBlIo=;
        b=Gt3CIVmOIS7CH/yxZ/qzVkkQ+NFjEhE/mxPfzeMtSPWSCQoyl5MVVCFqJb5/uuBvGI
         payuJ8aVwAXZOdAMNg6fUcbqnSwKftCqxZ1GZvBN1ygcbOSCYIvxU8BSy6Rr4f10pa43
         OzG6K2CYqyjVPLVrZLomSt34VnBXQHXXPBAPcN9fMPVpbCRYDg6VWBtk+JrlVYfXn8VO
         3mjLSJWahBtL97PSGBRstLj3FhCTyRFeOJLJtFbjDOzabdqI6IvgXTPJ5Vp13WUeez5A
         S1FcdpKRQ9kh1hVnF+XKo9jYe6/SEgu7aJFVeAsKlK4MGFVtvot2wbvd0//DnZmYXH3S
         29aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697149046; x=1697753846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kVF4kTtuXIp4L229IG65cBbR+yZ1UhhYBoW6+BiBlIo=;
        b=g6drVIthMmKKmPwycuE/2BeqglWUIQe1+EISt10w/5PVLPWZMKkFa4l5+c1fdeXh2S
         +D6mP7/4WJQj/brEeYtjnkbEFbpoM1GPSy0VYJrerWjyBlZ3jAFA1P5O9EJo4u3tX9WW
         ydzF+p6NGSr4X4S5Iceitkap+QtbJhWfzzKXZEyihfYWtQvNyR7/YghyOFlTmc97lYxC
         zvDIBQgnEdXGHjIuJUhvmzdio5+OCCKm9ikmwEKklh8YyQe6YFKLqjetk9x67j057bVk
         xwSVWa+nDxcYZSqjZXEnqwpEWv7RkP00VgCM2QCE6/UPsvLG+Wk8ZuofFF8StzGzA8Av
         swOw==
X-Gm-Message-State: AOJu0YzgBCB1d3xKABgqEn8yTbERIZ7HVbjzjWY/666x46fxQ9EvUEj6
	e9QKauaU3/KXQnVIFO7mHNBllHL4734=
X-Google-Smtp-Source: AGHT+IH2Fjs0yTlH9SXBo/IffnCDE2a9tu2IvQiOs4hTs7bSSy/JU0h5xynqRYuAtYr7dSjADYaFdQ==
X-Received: by 2002:a05:6870:8181:b0:1e9:b653:94d with SMTP id k1-20020a056870818100b001e9b653094dmr3387492oae.1.1697149045982;
        Thu, 12 Oct 2023 15:17:25 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::8282])
        by smtp.gmail.com with ESMTPSA id d22-20020a056870719600b001e195682b2esm524039oah.58.2023.10.12.15.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 15:17:25 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 16/18] hashserv: Add become-user API
Date: Thu, 12 Oct 2023 16:16:53 -0600
Message-Id: <20231012221655.632637-17-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012221655.632637-1-JPEWhacker@gmail.com>
References: <20231003145249.1166276-1-JPEWhacker@gmail.com>
 <20231012221655.632637-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 22:17:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15233

Adds API that allows a user admin to impersonate another user in the
system. This makes it easier to write external services that have
external authentication, since they can use a common user account to
access the server, then impersonate the logged in user.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bin/bitbake-hashclient |  3 +++
 lib/hashserv/client.py | 42 +++++++++++++++++++++++++++++++++++++-----
 lib/hashserv/server.py | 18 ++++++++++++++++++
 lib/hashserv/tests.py  | 39 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+), 5 deletions(-)

diff --git a/bin/bitbake-hashclient b/bin/bitbake-hashclient
index 0006c2f6..4b3dfcd6 100755
--- a/bin/bitbake-hashclient
+++ b/bin/bitbake-hashclient
@@ -166,6 +166,7 @@ def main():
     parser.add_argument('--log', default='WARNING', help='Set logging level')
     parser.add_argument('--login', '-l', metavar="USERNAME", help="Authenticate as USERNAME")
     parser.add_argument('--password', '-p', metavar="TOKEN", help="Authenticate using token TOKEN")
+    parser.add_argument('--become', '-b', metavar="USERNAME", help="Impersonate user USERNAME (if allowed) when performing actions")
     parser.add_argument('--no-netrc', '-n', action="store_false", dest="netrc", help="Do not use .netrc")
 
     subparsers = parser.add_subparsers()
@@ -248,6 +249,8 @@ def main():
     if func:
         try:
             with hashserv.create_client(args.address, login, password) as client:
+                if args.become:
+                    client.become_user(args.become)
                 return func(args, client)
         except bb.asyncrpc.InvokeError as e:
             print(f"ERROR: {e}")
diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
index 6b2bf54d..0a281a9b 100644
--- a/lib/hashserv/client.py
+++ b/lib/hashserv/client.py
@@ -18,10 +18,11 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
     MODE_GET_STREAM = 1
 
     def __init__(self, username=None, password=None):
-        super().__init__('OEHASHEQUIV', '1.1', logger)
+        super().__init__("OEHASHEQUIV", "1.1", logger)
         self.mode = self.MODE_NORMAL
         self.username = username
         self.password = password
+        self.saved_become_user = None
 
     async def setup_connection(self):
         await super().setup_connection()
@@ -29,8 +30,13 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         self.mode = self.MODE_NORMAL
         await self._set_mode(cur_mode)
         if self.username:
+            # Save off become user temporarily because auth() resets it
+            become = self.saved_become_user
             await self.auth(self.username, self.password)
 
+            if become:
+                await self.become_user(become)
+
     async def send_stream(self, msg):
         async def proc():
             await self.socket.send(msg)
@@ -100,7 +106,14 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
     async def get_outhash(self, method, outhash, taskhash, with_unihash=True):
         await self._set_mode(self.MODE_NORMAL)
         return await self.invoke(
-            {"get-outhash": {"outhash": outhash, "taskhash": taskhash, "method": method, "with_unihash": with_unihash}}
+            {
+                "get-outhash": {
+                    "outhash": outhash,
+                    "taskhash": taskhash,
+                    "method": method,
+                    "with_unihash": with_unihash,
+                }
+            }
         )
 
     async def get_stats(self):
@@ -128,6 +141,7 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         result = await self.invoke({"auth": {"username": username, "token": token}})
         self.username = username
         self.password = token
+        self.saved_become_user = None
         return result
 
     async def refresh_token(self, username=None):
@@ -136,13 +150,19 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         if username:
             m["username"] = username
         result = await self.invoke({"refresh-token": m})
-        if self.username and result["username"] == self.username:
+        if (
+            self.username
+            and not self.saved_become_user
+            and result["username"] == self.username
+        ):
             self.password = result["token"]
         return result
 
     async def set_user_perms(self, username, permissions):
         await self._set_mode(self.MODE_NORMAL)
-        return await self.invoke({"set-user-perms": {"username": username, "permissions": permissions}})
+        return await self.invoke(
+            {"set-user-perms": {"username": username, "permissions": permissions}}
+        )
 
     async def get_user(self, username=None):
         await self._set_mode(self.MODE_NORMAL)
@@ -157,12 +177,23 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
 
     async def new_user(self, username, permissions):
         await self._set_mode(self.MODE_NORMAL)
-        return await self.invoke({"new-user": {"username": username, "permissions": permissions}})
+        return await self.invoke(
+            {"new-user": {"username": username, "permissions": permissions}}
+        )
 
     async def delete_user(self, username):
         await self._set_mode(self.MODE_NORMAL)
         return await self.invoke({"delete-user": {"username": username}})
 
+    async def become_user(self, username):
+        await self._set_mode(self.MODE_NORMAL)
+        result = await self.invoke({"become-user": {"username": username}})
+        if username == self.username:
+            self.saved_become_user = None
+        else:
+            self.saved_become_user = username
+        return result
+
 
 class Client(bb.asyncrpc.Client):
     def __init__(self, username=None, password=None):
@@ -190,6 +221,7 @@ class Client(bb.asyncrpc.Client):
             "get_all_users",
             "new_user",
             "delete_user",
+            "become_user",
         )
 
     def _get_async_client(self):
diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 00ca1124..7bac7ab3 100644
--- a/lib/hashserv/server.py
+++ b/lib/hashserv/server.py
@@ -255,6 +255,7 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
                 "auth": self.handle_auth,
                 "get-user": self.handle_get_user,
                 "get-all-users": self.handle_get_all_users,
+                "become-user": self.handle_become_user,
             }
         )
 
@@ -706,6 +707,23 @@ class ServerClient(bb.asyncrpc.AsyncServerConnection):
 
         return {"username": username}
 
+    @permissions(USER_ADMIN_PERM, allow_anon=False)
+    async def handle_become_user(self, request):
+        username = str(request["username"])
+
+        user = await self.db.lookup_user(username)
+        if user is None:
+            raise bb.asyncrpc.InvokeError(f"User {username} doesn't exist")
+
+        self.user = user
+
+        self.logger.info("Became user %s", username)
+
+        return {
+            "username": self.user.username,
+            "permissions": self.return_perms(self.user.permissions),
+        }
+
 
 class Server(bb.asyncrpc.AsyncServer):
     def __init__(
diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index f92f37c4..311b7b77 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -728,6 +728,45 @@ class HashEquivalenceCommonTests(object):
             self.assertEqual(user["username"], "test-user")
             self.assertEqual(user["permissions"], permissions)
 
+    def test_auth_become_user(self):
+        admin_client = self.start_auth_server()
+
+        user = admin_client.new_user("test-user", ["@read", "@report"])
+        user_info = user.copy()
+        del user_info["token"]
+
+        with self.auth_perms() as client, self.assertRaises(InvokeError):
+            client.become_user(user["username"])
+
+        with self.auth_perms("@user-admin") as client:
+            become = client.become_user(user["username"])
+            self.assertEqual(become, user_info)
+
+            info = client.get_user()
+            self.assertEqual(info, user_info)
+
+            # Verify become user is preserved across disconnect
+            client.disconnect()
+
+            info = client.get_user()
+            self.assertEqual(info, user_info)
+
+            # test-user doesn't have become_user permissions, so this should
+            # not work
+            with self.assertRaises(InvokeError):
+                client.become_user(user["username"])
+
+        # No self-service of become
+        with self.auth_client(user) as client, self.assertRaises(InvokeError):
+            client.become_user(user["username"])
+
+        # Give test user permissions to become
+        admin_client.set_user_perms(user["username"], ["@user-admin"])
+
+        # It's possible to become yourself (effectively a noop)
+        with self.auth_perms("@user-admin") as client:
+            become = client.become_user(client.username)
+
 
 class TestHashEquivalenceUnixServer(HashEquivalenceTestSetup, HashEquivalenceCommonTests, unittest.TestCase):
     def get_server_addr(self, server_idx):
-- 
2.34.1


