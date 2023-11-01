Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF746C4167B
	for <webhook@archiver.kernel.org>; Wed,  1 Nov 2023 15:42:27 +0000 (UTC)
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
 by mx.groups.io with SMTP id smtpd.web10.10800.1698853347370271356
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 01 Nov 2023 08:42:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=NwFE9PBA;
 spf=pass (domain: gmail.com, ip: 209.85.167.179, mailfrom: jpewhacker@gmail.com)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b3f938331fso520216b6e.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 08:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698853345; x=1699458145; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MN5XDKoLnVFhVPvrKohUvvTipxaPzK1pFJIVUZg2BEw=;
        b=NwFE9PBAqB6eh5O/xWe2Nm5NrPGpsS3Qeeq+7clenNOn2gPV1klM5zGN3VNmEam2p9
         kIUUcygztgw16QT9KD39SsbEf+xwhGZVIYeJd0fG+TB2S9WANbZPuk/Is6gk2Xy+DM6S
         ZsqRXUK8fE+/zOQZQlGah56hCF4CwopiR61lt19z+ID62RBYnRP/XR6IIDR2Q71pzs2H
         TLtjyN8sqOwHJBANIb1GWQGbbuG9kWeGfsWSlp5j9prZPfrdWYbGDkLiyontC3omiOQP
         Uu0tesGYzLw/e6bCzAi1bSTRDN0prGQKaE6tFNupC23zts09xzbXkOHGEXddoWp3a7gL
         XzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698853345; x=1699458145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MN5XDKoLnVFhVPvrKohUvvTipxaPzK1pFJIVUZg2BEw=;
        b=p71Ygc3fyDEYKCgMOG91JpZB+Qw/l8vtfG5EX3QyePmgIS7oILnnpKQNpyQl2lwmrt
         YkulZ11ZU3z4N/FfoFycr8d9hxqOFz+S7ojCuwKozXNpQUZSmblekOILR8i0GJHvVss2
         tiIZRJkOOkZQmpHcJNG55PkuUtwIukVMry9NK3mazZ8NlnbvaaS3iOrSC0CcYgQ13zVA
         WSnlpf4aYCpRCrYK80WrrOaHXvxs0J2k74g6wKwjEup29TKYttZBH7zZfXT+aXwhMBVt
         EO/tTSbXKR122/90VwEIVAhoDkC5C/smJrWe3c6Dc1aZOUX/QptHNM80pIqxHZsNwoKW
         ohAg==
X-Gm-Message-State: AOJu0YwwCfuCzP/nOsuRjchygMoUWPFA83ZeCBXrOV/0SCKALEOtiDri
	yjQqLTD1l1Ew1bDEbFk5YrgkyjkfbAk=
X-Google-Smtp-Source: AGHT+IEa11PUe8yqEZ4DXFDEAQccrMR4uSGQfn1Elap8TVGl8V77H9w45iytnuv2NdgGLuwIiuQtew==
X-Received: by 2002:a05:6808:1782:b0:3b2:f335:63dc with SMTP id bg2-20020a056808178200b003b2f33563dcmr1941555oib.23.1698853345567;
        Wed, 01 Nov 2023 08:42:25 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l9-20020aca1909000000b003ae36d664a9sm249651oii.39.2023.11.01.08.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:42:24 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v5 04/22] hashserv: tests: Add external database tests
Date: Wed,  1 Nov 2023 09:41:58 -0600
Message-Id: <20231101154216.2758185-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231101154216.2758185-1-JPEWhacker@gmail.com>
References: <20231031172138.3577199-1-JPEWhacker@gmail.com>
 <20231101154216.2758185-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 01 Nov 2023 15:42:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15386

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


