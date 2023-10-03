Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41219E7AD6A
	for <webhook@archiver.kernel.org>; Tue,  3 Oct 2023 14:53:02 +0000 (UTC)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
 by mx.groups.io with SMTP id smtpd.web11.110207.1696344781211647838
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Oct 2023 07:53:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=H1C+HA+J;
 spf=pass (domain: gmail.com, ip: 209.85.160.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1dcbd8a56d6so640138fac.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 07:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696344780; x=1696949580; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHOfWRNE725wx1i4dygib27SrIA8Wc1jTdYSYHf2HH0=;
        b=H1C+HA+Jy6/XTK1ErzZNO6LW7Ljswz76uNVlu/TvJYncccMxCstJ8U1+yhJET9PNXy
         hX6kDqgidKfaYmhb/O8MS1jQ0Za81wSqfOYgHW19CPHpPP1SYjdmaIMKN4f/3RsPjVvP
         +yiRBS+KiWdqpr6EqAy/MAuD1irNxZixaqaekAMYHN1B9z5rijn0hMgI2dA33SEYjkLI
         Nk0f1l/oTutKJToc3FqAtnhSntBWf6ZNvFal470sP6kUe4ntq7ZCED7lwpHpRMJmDFzN
         mJTE91p6o0qR0V/fCg8CFFI9kRvzJGwn+Ii1o1JqQguZiFRiVTFXPlREsQx8Gm6iiae0
         3jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696344780; x=1696949580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHOfWRNE725wx1i4dygib27SrIA8Wc1jTdYSYHf2HH0=;
        b=PlrbJJyAjQq/Ru5h7lj/wEAySr1spfJfybQUwosYBvAHmipf2DtOnOmufFDD5xO/3g
         fMe7f2iMgH4Hb7ju03vDylj20SSxDDjl14WRYOh8+I8Ky3z9Kcw+5jS6EFX+ealDUqI+
         uWvBOCIyb5qXY1r4Eu2rjVK3V1SkZUB39Ojo2Al/SDTVQ1efLFBb8UyVkjYv3pbmheVt
         HKP8onP7x+qVMROzmnPoykQ596tz/T/h4UyF9BCCPduJAq22g67Al02l41AviukUQsdn
         uWVZMFcSXoudAEWODxNE67GDb9Y2hiLzvL/KdBqXh9iaJO+vCznT6npgPIH3NP1fM1rK
         YYoA==
X-Gm-Message-State: AOJu0Yw00tfiPrMJ+Dvz793Gr9Fx8btArtQZIjnvdmudJEpUZ7yfEykx
	MZbVOVRKtu35alN6HoaKhUf95tGdKDE=
X-Google-Smtp-Source: AGHT+IFZiLR1wJnDRUb0JgtZlQtj9C1ylR8Rgl/ZcP3FbmRBjhNAz1EhFSLULC74OcOblgW05MmmGQ==
X-Received: by 2002:a05:6870:4202:b0:1be:f46d:a26c with SMTP id u2-20020a056870420200b001bef46da26cmr19160871oac.27.1696344779774;
        Tue, 03 Oct 2023 07:52:59 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::589])
        by smtp.gmail.com with ESMTPSA id du28-20020a0568703a1c00b001dd2b869a26sm253477oab.17.2023.10.03.07.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 07:52:58 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][RFC v2 06/12] hashserv: tests: Add external database tests
Date: Tue,  3 Oct 2023 08:52:43 -0600
Message-Id: <20231003145249.1166276-7-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003145249.1166276-1-JPEWhacker@gmail.com>
References: <20230928170551.4193224-1-JPEWhacker@gmail.com>
 <20231003145249.1166276-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Oct 2023 14:53:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15167

Adds support for running the hash equivalence test suite against an
external hash equivalence implementation.

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/hashserv/tests.py | 54 ++++++++++++++++++++++++++++-------
 1 file changed, 44 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/hashserv/tests.py b/bitbake/lib/hashserv/tests.py
index a2827e6a301..82bb005a66d 100644
--- a/bitbake/lib/hashserv/tests.py
+++ b/bitbake/lib/hashserv/tests.py
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
@@ -187,7 +196,7 @@ class HashEquivalenceCommonTests(object):
 
     def test_stress(self):
         def query_server(failures):
-            client = Client(self.server.address)
+            client = Client(self.server_address)
             try:
                 for i in range(1000):
                     taskhash = hashlib.sha256()
@@ -226,8 +235,10 @@ class HashEquivalenceCommonTests(object):
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
@@ -332,14 +343,18 @@ class HashEquivalenceCommonTests(object):
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
@@ -354,7 +369,7 @@ class HashEquivalenceCommonTests(object):
             ro_client.report_unihash(taskhash2, self.METHOD, outhash2, unihash2)
 
         # Ensure that the database was not modified
-        self.assertClientGetHash(self.client, taskhash2, None)
+        self.assertClientGetHash(rw_client, taskhash2, None)
 
 
     def test_slow_server_start(self):
@@ -374,7 +389,7 @@ class HashEquivalenceCommonTests(object):
         old_signal = signal.signal(signal.SIGTERM, do_nothing)
         self.addCleanup(signal.signal, signal.SIGTERM, old_signal)
 
-        _, server = self.start_server(prefunc=prefunc)
+        server = self.start_server(prefunc=prefunc)
         server.process.terminate()
         time.sleep(30)
         event.set()
@@ -481,3 +496,22 @@ class TestHashEquivalenceWebsocketServer(HashEquivalenceTestSetup, HashEquivalen
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


