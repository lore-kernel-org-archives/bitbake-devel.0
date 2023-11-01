Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028E9C4167D
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 15:42:48 +0000 (UTC)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
 by mx.groups.io with SMTP id smtpd.web10.10812.1698853364547697315
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 08:42:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=kgX0hMJy;
 spf=pass (domain: gmail.com, ip: 209.85.167.182, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3b2f507c03cso3698554b6e.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 08:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698853362; x=1699458162; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UVhH5sSNFwNw+6ksa+y2+PkL0npHGr++pun+hbPM5Q=;
        b=kgX0hMJyMF2GboZGNtUxid30QN+lp5midSzaScsbiLS6pjFUwtfvaU1Q/QqLEJi2A3
         /syXRIFS6BKeRMoj+67nYlvfJUMBsBOzChA3k0sNfEAtIXLAJmrxjjfbd7DD9gT4fOAz
         u65oKKcwjBLMtfYZHr/Oc0XRQQIzQuPcRyJIV93rHsOaNT4txLG6ztZ49RVXUb0tDco1
         apBb6THZWaUHCCaAE9sYKIDqD5QC0K7hAw+i6IgmckYAQSF9JMu3N7XWL2VhxhcYRXfs
         o9o43fpj3enEu/U185sK8xrS5k+HVzy3irY/tbdTwiVKnENLFmKfiWOzVkTTf+VBmfre
         5bZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698853362; x=1699458162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7UVhH5sSNFwNw+6ksa+y2+PkL0npHGr++pun+hbPM5Q=;
        b=hU5xvUSA5GwynruxpUAe4Zff04q1LO+eLzLGd6mjoMScAhfkglrGB/9w5TVlypnms+
         Xo9aVvfIkUmAtfDJcyltjOdz7xtl4WbwdxJofm6uRfNc2tzOpPSHqQ9MtcHkPtOqTW2V
         uA7WZEF9MlzryHpDXnh0VrwH7/jj70qnocHusBKE8twZzV3+LI1zW6RfnsFIcgQy9pJ/
         501+DxUQyLM48nQumibVx7BSer+m2uF1YnfAfqhJIdElVrTTfBN4NQN+EnccMewPFT9u
         4WMg1L4F735zoxKA8y5eAARcaOwxhZRl/m4RYToHUsdZwdVTAtK/rrE0sKX2Rx7A3awe
         CKAQ==
X-Gm-Message-State: AOJu0YyCJDd2IPArN1hdu7kFuix4j2aJYP/cwlLFUXIqpvQQkl9FK7lW
	tPbvnpIPnAF9MHAxxpn3n7W4n0jWSvY=
X-Google-Smtp-Source: AGHT+IE3s/UZyfJFXh05++CoojWQnfxVIRnbBkfJNO4z5a0B5SAWBCPZORHCDXaIv2de+PdjlpaU3Q==
X-Received: by 2002:aca:1115:0:b0:3b5:6599:ce4c with SMTP id 21-20020aca1115000000b003b56599ce4cmr4723390oir.57.1698853362264;
        Wed, 01 Nov 2023 08:42:42 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l9-20020aca1909000000b003ae36d664a9sm249651oii.39.2023.11.01.08.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:42:41 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v5 14/22] hashserv: Add become-user API
Date: Wed,  1 Nov 2023 09:42:08 -0600
Message-Id: <20231101154216.2758185-15-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101154216.2758185-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231101154216.2758185-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 15:42:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15396

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
index 328c15cd..cfbc197e 100755
--- a/bin/bitbake-hashclient
+++ b/bin/bitbake-hashclient
@@ -166,6 +166,7 @@ def main():
     parser.add_argument('--log', default='WARNING', help='Set logging level')
     parser.add_argument('--login', '-l', metavar="USERNAME", help="Authenticate as USERNAME")
     parser.add_argument('--password', '-p', metavar="TOKEN", help="Authenticate using token TOKEN")
+    parser.add_argument('--become', '-b', metavar="USERNAME", help="Impersonate user USERNAME (if allowed) when performing actions")
     parser.add_argument('--no-netrc', '-n', action="store_false", dest="netrc", help="Do not use .netrc")
 
     subparsers = parser.add_subparsers()
@@ -251,6 +252,8 @@ def main():
     if func:
         try:
             with hashserv.create_client(args.address, login, password) as client:
+                if args.become:
+                    client.become_user(args.become)
                 return func(args, client)
         except bb.asyncrpc.InvokeError as e:
             print(f"ERROR: {e}")
diff --git a/lib/hashserv/client.py b/lib/hashserv/client.py
index 5ed8d381..90f1dd71 100644
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
@@ -92,7 +98,14 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
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
@@ -120,6 +133,7 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
         result = await self.invoke({"auth": {"username": username, "token": token}})
         self.username = username
         self.password = token
+        self.saved_become_user = None
         return result
 
     async def refresh_token(self, username=None):
@@ -128,13 +142,19 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
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
@@ -149,12 +169,23 @@ class AsyncClient(bb.asyncrpc.AsyncClient):
 
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
@@ -182,6 +213,7 @@ class Client(bb.asyncrpc.Client):
             "get_all_users",
             "new_user",
             "delete_user",
+            "become_user",
         )
 
     def _get_async_client(self):
diff --git a/lib/hashserv/server.py b/lib/hashserv/server.py
index 5c70d81f..d506088e 100644
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


