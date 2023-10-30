Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED710C4167D
	for <webhook@archiver.kernel.org>; Mon, 30 Oct 2023 19:18:03 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
 by mx.groups.io with SMTP id smtpd.web11.158489.1698693479049650952
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Oct 2023 12:17:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nO6oFM57;
 spf=pass (domain: gmail.com, ip: 209.85.210.52, mailfrom: jpewhacker@gmail.com)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6ce2bcb131fso3347786a34.1
        for <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 12:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698693478; x=1699298278; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MN5XDKoLnVFhVPvrKohUvvTipxaPzK1pFJIVUZg2BEw=;
        b=nO6oFM57VOn9cRc8jBcxv43BbdaMn8CCUQ7NW1zKXeSurlkiIpewsalDmET6bQfg/B
         wDf6dYMOt30zvPpeSFhUc8LIDR47v64PuSb1NRRUj75pbnRU94g6cDaBLMT8G1/2tNBc
         0j5+EfhpJvqKideTkjugC9jKDMp3vI440SeQSXQvgwSWIt2/JHWZJGWyrYYGKWiDYdgW
         ugwW/L7vmSOgqx20EElAk1lcEsO+UQtVlRX/HXBM88T5sxamT8nn5PAbezGqeHiL+eqw
         D7skOQERO/1q1FoCDlOqDDsFCunOjFcfV+x1O1A2utnOzBcj/3VGHxbsBEy1hRzLmRuP
         tWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698693478; x=1699298278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MN5XDKoLnVFhVPvrKohUvvTipxaPzK1pFJIVUZg2BEw=;
        b=GkQ72VdI7dve0SYXXwBy179Rl5zpkJw4Yp8+c/bfzXMglIbEhbdesWxiq29G29k+S9
         TkgC5iCOeG4lJ3O8uEh0acWZNcPRcejdMmJIePNofRPVJuWn6RNPugbS/ga6GKAahk7F
         6Jh5M+rKwxwICh758CCComI5reoxHH9DCt2g63hDeHN36pDz7YcpgCWELxAwqqcZPL3H
         p2imW+2iETxAet378M85Z4ZtZXsIu3Ew95zwPKwPS0+C2p6uwA/1vJkK52yY+9UVuVDw
         fbXoAvjBhNqHzIRF01E67Vq8luHmylQpsr4l1djOtTZEfxBuBL7yfT/IcK0WzCS/hZ5H
         6W/w==
X-Gm-Message-State: AOJu0YyUEC+Oh794tF5o2p9tZm2rS5X/HlzQbcvdJCSu1eLyOQGs3B6K
	xfuP54KHQa/McoPYVsQZC6NozSjFQpk=
X-Google-Smtp-Source: AGHT+IERSuYSALqA9ZEnJrbVNr6NB8v1n24frTst2A79cGM+ZOZKPlUPlX/jItxNRFlXzBhNIXahkg==
X-Received: by 2002:a05:6830:42:b0:6c4:9ca1:f13a with SMTP id d2-20020a056830004200b006c49ca1f13amr11508497otp.35.1698693477777;
        Mon, 30 Oct 2023 12:17:57 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::6aa6])
        by smtp.gmail.com with ESMTPSA id l38-20020a0568302b2600b006cd099bb052sm1510500otv.1.2023.10.30.12.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:17:57 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH v3 04/22] hashserv: tests: Add external database tests
Date: Mon, 30 Oct 2023 13:17:10 -0600
Message-Id: <20231030191728.1276805-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030191728.1276805-1-JPEWhacker@gmail.com>
References: <20231012221655.632637-1-JPEWhacker@gmail.com>
 <20231030191728.1276805-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Oct 2023 19:18:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15306

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


