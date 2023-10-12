Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51280CDB483
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 22:17:15 +0000 (UTC)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
 by mx.groups.io with SMTP id smtpd.web11.25715.1697149029895080522
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 12 Oct 2023 15:17:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=MtwFh4DV;
 spf=pass (domain: gmail.com, ip: 209.85.160.53, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1e58a522e41so792748fac.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 15:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697149028; x=1697753828; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MN5XDKoLnVFhVPvrKohUvvTipxaPzK1pFJIVUZg2BEw=;
        b=MtwFh4DV5EJB7MJihfaEGosnLQXC6CtlQiDU40CMpMv96LZxNjMTcwkrUfp8GEexlj
         hhZSB9+xwbMuWwIDniDAQUazWNxRznrfqd7yH38oEsZ0x7hDAFzhAmOm8Jo0vgvuxBq3
         ZVEuz/uJzD+FgMBrBCL2qzuPM3j1vMk6ME8eKG3b+HBXpfh4JwodCkYrMsKeicdgDopI
         TnRbC3x2Ese83FP8mcKQgH8rDh4BUFY8LGMM/4r9pSVIbpUB7B50AYpRAsfOBok2vBa5
         lCPw4kyFJQ2i/IYy1VRR8mKNY4Owj78yvFmaU9Jj4x6ve0Ykeb4uay5zxJamIwDW7ORR
         HjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697149028; x=1697753828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MN5XDKoLnVFhVPvrKohUvvTipxaPzK1pFJIVUZg2BEw=;
        b=c3bhBP4fwYKJxGHZihx4Od4nNBi/yg+OCfdYNC3g6RKijq9XkVtMv2UrGe6Vy8Xo8Y
         mr3zSzZ6Qr+BX0ucemM4uveQD4wMtqtPIUQdY5MikG2Ki9OBxP9JJuEhg57R5DiaqIXE
         Y/SaORgMoXTrmlkmqmlkh0RhsAO1wKHYb35DBWS8z4cBhIPjQbydB8IPvUX2quMgfD3F
         WgkYjRHHKl1N3Zj/oAGsYNGomoa45Zfur1r8WarGxFKz3J8edtyyo6Kd7hZUr7siy3qF
         NtGo+vySx+g7Ps4Ip2xcnZNakcLzG8mtK0ZqVeYmuUycTdyK7cStu5SyBHZOnrNVXcAG
         WsOg==
X-Gm-Message-State: AOJu0Yy99Lrp2AmI62JpSCQDkvvI0tKxtFYvDK3cn81WqkOC1/hjlEgg
	Xixnamy+5hsvcBn7gok8f27boTPW3IA=
X-Google-Smtp-Source: AGHT+IHmmFxvSIYO1t0bNnwqjIPuUmQjp3xH/nhbjI4DFNps25JEgoBquG1Kvecg4Uid04L1cn03tw==
X-Received: by 2002:a05:6870:1051:b0:1e9:c224:bb91 with SMTP id 17-20020a056870105100b001e9c224bb91mr2845049oaj.38.1697149027860;
        Thu, 12 Oct 2023 15:17:07 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::8282])
        by smtp.gmail.com with ESMTPSA id d22-20020a056870719600b001e195682b2esm524039oah.58.2023.10.12.15.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 15:17:06 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 04/18] hashserv: tests: Add external database tests
Date: Thu, 12 Oct 2023 16:16:41 -0600
Message-Id: <20231012221655.632637-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012221655.632637-1-JPEWhacker@gmail.com>
References: <20231003145249.1166276-1-JPEWhacker@gmail.com>
 <20231012221655.632637-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Oct 2023 22:17:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15222

Adds support for running the hash equivalence test suite against an
external hash equivalence implementation.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 lib/hashserv/tests.py | 54 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 44 insertions(+), 10 deletions(-)

diff --git a/lib/hashserv/tests.py b/lib/hashserv/tests.py
index 01ffd52c..4c98a280 100644
--- a/lib/hashserv/tests.py
+++ b/lib/hashserv/tests.py
@@ -51,13 +51,20 @@ class HashEquivalenceTestSetup(object):
         server.serve_as_process(prefunc=prefunc, args=(self.server_index,))
         self.addCleanup(cleanup_server, server)
 
+        return server
+
+    def start_client(self, server_address):
         def cleanup_client(client):
             client.close()
 
-        client = create_client(server.address)
+        client = create_client(server_address)
         self.addCleanup(cleanup_client, client)
 
-        return (client, server)
+        return client
+
+    def start_test_server(self):
+        server = self.start_server()
+        return server.address
 
     def setUp(self):
         if sys.version_info < (3, 5, 0):
@@ -66,7 +73,9 @@ class HashEquivalenceTestSetup(object):
         self.temp_dir = tempfile.TemporaryDirectory(prefix='bb-hashserv')
         self.addCleanup(self.temp_dir.cleanup)
 
-        (self.client, self.server) = self.start_server()
+        self.server_address = self.start_test_server()
+
+        self.client = self.start_client(self.server_address)
 
     def assertClientGetHash(self, client, taskhash, unihash):
         result = client.get_unihash(self.METHOD, taskhash)
@@ -206,7 +215,7 @@ class HashEquivalenceCommonTests(object):
 
     def test_stress(self):
         def query_server(failures):
-            client = Client(self.server.address)
+            client = Client(self.server_address)
             try:
                 for i in range(1000):
                     taskhash = hashlib.sha256()
@@ -245,8 +254,10 @@ class HashEquivalenceCommonTests(object):
         # the side client. It also verifies that the results are pulled into
         # the downstream database by checking that the downstream and side servers
         # match after the downstream is done waiting for all backfill tasks
-        (down_client, down_server) = self.start_server(upstream=self.server.address)
-        (side_client, side_server) = self.start_server(dbpath=down_server.dbpath)
+        down_server = self.start_server(upstream=self.server_address)
+        down_client = self.start_client(down_server.address)
+        side_server = self.start_server(dbpath=down_server.dbpath)
+        side_client = self.start_client(side_server.address)
 
         def check_hash(taskhash, unihash, old_sidehash):
             nonlocal down_client
@@ -351,14 +362,18 @@ class HashEquivalenceCommonTests(object):
         self.assertEqual(result['method'], self.METHOD)
 
     def test_ro_server(self):
-        (ro_client, ro_server) = self.start_server(dbpath=self.server.dbpath, read_only=True)
+        rw_server = self.start_server()
+        rw_client = self.start_client(rw_server.address)
+
+        ro_server = self.start_server(dbpath=rw_server.dbpath, read_only=True)
+        ro_client = self.start_client(ro_server.address)
 
         # Report a hash via the read-write server
         taskhash = '35788efcb8dfb0a02659d81cf2bfd695fb30faf9'
         outhash = '2765d4a5884be49b28601445c2760c5f21e7e5c0ee2b7e3fce98fd7e5970796f'
         unihash = 'f46d3fbb439bd9b921095da657a4de906510d2cd'
 
-        result = self.client.report_unihash(taskhash, self.METHOD, outhash, unihash)
+        result = rw_client.report_unihash(taskhash, self.METHOD, outhash, unihash)
         self.assertEqual(result['unihash'], unihash, 'Server returned bad unihash')
 
         # Check the hash via the read-only server
@@ -373,7 +388,7 @@ class HashEquivalenceCommonTests(object):
             ro_client.report_unihash(taskhash2, self.METHOD, outhash2, unihash2)
 
         # Ensure that the database was not modified
-        self.assertClientGetHash(self.client, taskhash2, None)
+        self.assertClientGetHash(rw_client, taskhash2, None)
 
 
     def test_slow_server_start(self):
@@ -393,7 +408,7 @@ class HashEquivalenceCommonTests(object):
         old_signal = signal.signal(signal.SIGTERM, do_nothing)
         self.addCleanup(signal.signal, signal.SIGTERM, old_signal)
 
-        _, server = self.start_server(prefunc=prefunc)
+        server = self.start_server(prefunc=prefunc)
         server.process.terminate()
         time.sleep(30)
         event.set()
@@ -500,3 +515,22 @@ class TestHashEquivalenceWebsocketServer(HashEquivalenceTestSetup, HashEquivalen
         # case it is more reliable to resolve the IP address explicitly.
         host = socket.gethostbyname("localhost")
         return "ws://%s:0" % host
+
+
+class TestHashEquivalenceExternalServer(HashEquivalenceTestSetup, HashEquivalenceCommonTests, unittest.TestCase):
+    def start_test_server(self):
+        if 'BB_TEST_HASHSERV' not in os.environ:
+            self.skipTest('BB_TEST_HASHSERV not defined to test an external server')
+
+        return os.environ['BB_TEST_HASHSERV']
+
+    def start_server(self, *args, **kwargs):
+        self.skipTest('Cannot start local server when testing external servers')
+
+    def setUp(self):
+        super().setUp()
+        self.client.remove({"method": self.METHOD})
+
+    def tearDown(self):
+        self.client.remove({"method": self.METHOD})
+        super().tearDown()
-- 
2.34.1


