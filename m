Return-Path: <rustyhowell@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63049EEB592
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 05:06:21 +0000 (UTC)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
 by mx.groups.io with SMTP id smtpd.web10.5131.1694581575752503594
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Sep 2023 22:06:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20221208 header.b=BsFsvZnJ;
 spf=pass (domain: gmail.com, ip: 209.85.214.171, mailfrom: rustyhowell@gmail.com)
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1c0ecb9a075so47485295ad.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 12 Sep 2023 22:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694581575; x=1695186375; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ozlyhvs6/9h9Q+BYpckiklSHkgQKWbEXdiiFQBGWk4=;
        b=BsFsvZnJOPMXQJiWDnce+rIprRfZHIoyMx/FEdr7FNGGgNBcamT4d1t6al9gX1d66Y
         cO6g4C/jtnNJ83T0Z+qFQnwr6JmNFHuUHps97darxCnG4nocL414Bd42q1vxY/IaS0Fp
         7yaixcaBCRGImXT0pKYN5cA6T6Uab7DI38yqNH227B75AVDb2KzYEgeU1if1ITMIcMLA
         emmK4v/M7SHBgx3lH+RJctIIdt6CH/N/pEaaEJhu9KxVM17mSk2V5/1Ct4rOe3XpwO93
         IrP2/hlH54dUnK785xDf6R58Tw3CpORp0/Cyraj/pDyLl5HxnoLEzDlnL52gRLt5psLB
         6EWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694581575; x=1695186375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/Ozlyhvs6/9h9Q+BYpckiklSHkgQKWbEXdiiFQBGWk4=;
        b=DRzlz8EGZIyqZk48a9dJrzT+26SiEUKUuaBRNbA5mlIQcGv3QoeMl9XX24UEYMqBw+
         VOqBKzgXodANj+Q0NYwcYLCxGzL5uo7xHrfY9S7hOBDwrdxKkA1pefdtM/i0YCVRrobw
         wDH2ZQYwj3qSXY/wRP96TD19zpf6qYwUmzJUwwyFvnKCyNSFYZ3BnNUVoyB6I6VQoK84
         gZXFvcVKMdrsvkKSZva2Aa7C47vN+HOhfI5Us493q+dSDtQmN5zuVLQiW6xN8po9FNkX
         X+eEZzLPNuZF1KJ1i3OEG/6EHz5s+qFm++BpyKkDcBOwHmBp3lMFee+Fxm/h3x8/g/15
         oOgg==
X-Gm-Message-State: AOJu0YzAve2gOXs/oIiTCvLzOB0v9j9PH0pc2w5LqhBS0C/DsR2HEkpG
	eaPekhF3QnnYsvpy5BfRYzvOSsb6GP8ecQ==
X-Google-Smtp-Source: AGHT+IEdGEFolpp03MbZYHoL59FhiNVrrbys2V0yxtUeF2vUz5gjxjfbZCLnQPgJrJaKjiwaPleY4A==
X-Received: by 2002:a17:902:8491:b0:1c0:ecbb:1831 with SMTP id c17-20020a170902849100b001c0ecbb1831mr1511143plo.16.1694581574547;
        Tue, 12 Sep 2023 22:06:14 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:a937:b200:28d:855a:5806:ab1c])
        by smtp.gmail.com with ESMTPSA id q10-20020a170902daca00b001bdca6456b9sm9473535plx.17.2023.09.12.22.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 22:06:14 -0700 (PDT)
From: Rusty Howell <rustyhowell@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Rusty Howell <rustyhowell@gmail.com>
Subject: [PATCH] prserver: add self-tests
Date: Tue, 12 Sep 2023 23:06:09 -0600
Message-Id: <20230913050609.13388-1-rustyhowell@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Sep 2023 05:06:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15039

Add some self tests for the prserver. As changes are made to the prserver, the tests will
help ensure that any behavioral changes are known, or that changes do not affect behavior.
---
 .gitignore                           |   1 +
 bitbake/bin/bitbake-selftest         |   5 +-
 bitbake/lib/prserv/db.py             |   2 +-
 bitbake/lib/prserv/tests/.gitignore  |   2 +
 bitbake/lib/prserv/tests/__init__.py |   0
 bitbake/lib/prserv/tests/prserver.py | 213 +++++++++++++++++++++++++++
 6 files changed, 221 insertions(+), 2 deletions(-)
 create mode 100644 bitbake/lib/prserv/tests/.gitignore
 create mode 100644 bitbake/lib/prserv/tests/__init__.py
 create mode 100644 bitbake/lib/prserv/tests/prserver.py

diff --git a/.gitignore b/.gitignore
index 8f48d452da..c227363e3c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -36,3 +36,4 @@ _toaster_clones/
 downloads/
 sstate-cache/
 toaster.sqlite
+.idea
diff --git a/bitbake/bin/bitbake-selftest b/bitbake/bin/bitbake-selftest
index f25f23b1ae..8b601aa2b8 100755
--- a/bitbake/bin/bitbake-selftest
+++ b/bitbake/bin/bitbake-selftest
@@ -16,6 +16,7 @@ try:
     import bb
     import hashserv
     import layerindexlib
+    import prserv
 except RuntimeError as exc:
     sys.exit(str(exc))
 
@@ -35,7 +36,9 @@ tests = ["bb.tests.codeparser",
          "hashserv.tests",
          "layerindexlib.tests.layerindexobj",
          "layerindexlib.tests.restapi",
-         "layerindexlib.tests.cooker"]
+         "layerindexlib.tests.cooker",
+         "prserv.tests.prserver",
+        ]
 
 for t in tests:
     t = '.'.join(t.split('.')[:3])
diff --git a/bitbake/lib/prserv/db.py b/bitbake/lib/prserv/db.py
index b4bda7078c..8cefb28f16 100644
--- a/bitbake/lib/prserv/db.py
+++ b/bitbake/lib/prserv/db.py
@@ -71,7 +71,7 @@ class PRTable(object):
     def sync(self):
         if not self.read_only:
             self.conn.commit()
-            self._execute("BEGIN EXCLUSIVE TRANSACTION")
+            #self._execute("BEGIN EXCLUSIVE TRANSACTION")
 
     def sync_if_dirty(self):
         if self.dirty:
diff --git a/bitbake/lib/prserv/tests/.gitignore b/bitbake/lib/prserv/tests/.gitignore
new file mode 100644
index 0000000000..8609a37b69
--- /dev/null
+++ b/bitbake/lib/prserv/tests/.gitignore
@@ -0,0 +1,2 @@
+*.log
+*.db
diff --git a/bitbake/lib/prserv/tests/__init__.py b/bitbake/lib/prserv/tests/__init__.py
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/bitbake/lib/prserv/tests/prserver.py b/bitbake/lib/prserv/tests/prserver.py
new file mode 100644
index 0000000000..52972bcf49
--- /dev/null
+++ b/bitbake/lib/prserv/tests/prserver.py
@@ -0,0 +1,213 @@
+import os
+import sys
+import json
+import socket
+import logging
+import itertools
+import random
+import unittest
+
+import sqlite3
+import time
+import bb
+
+
+this_dir = os.path.abspath(os.path.dirname(__file__))
+bitbake_dir = os.path.abspath(os.path.dirname(os.path.dirname(__file__)))
+sys.path.insert(0, os.path.join(bitbake_dir, 'lib'))
+import prserv
+import prserv.serv
+
+HOST = "localhost"
+PORT = 18585
+
+logger = logging.getLogger("prserv_unittest")
+logger.setLevel(logging.DEBUG)
+logger.addHandler(logging.FileHandler(os.path.join(this_dir, 'prserv_unittests.log'), mode='w'))
+
+logger.debug("-----------")
+logger.debug("global setup")
+logger.debug("bitbake_dir = %s", bitbake_dir)
+logger.debug("this_dir = %s", this_dir)
+
+sock = None
+conn = None
+def setUpModule():
+    global sock, conn
+    logger.debug("setUpModule")
+    dbfile = os.path.join(this_dir, 'pr_test.db')
+    if os.path.exists(dbfile):
+        os.remove(dbfile)
+
+    logfile = os.path.join(this_dir, 'prserv_daemon.log')
+    logging.getLogger("BitBake.PRserv").setLevel(logging.DEBUG)
+
+    if os.path.exists(logfile):
+        os.remove(logfile)
+
+    prserv.init_logger(os.path.abspath(logfile), "DEBUG")
+    prserv.serv.start_daemon(dbfile, HOST, PORT, logfile)
+    time.sleep(1)
+
+    conn = sqlite3.connect(dbfile, isolation_level="EXCLUSIVE", check_same_thread=False)
+
+    sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
+    sock.connect(('localhost', PORT))
+    msg = b'PRSERVICE 1.0\n\n'
+    sock.send(msg)
+
+
+def tearDownModule():
+    logger.debug("tearDownModule")
+    sock.close()
+    prserv.serv.stop_daemon(HOST, PORT)
+
+
+class PRServerTest(unittest.TestCase):
+    def setUp(self):
+        logger.info("inst setUp()")
+
+    def tearDown(self):
+        logger.info("inst tearDown()")
+
+    def ping(self):
+        return True
+
+    def getPR(self, version: str, arch: str, checksum: str) -> int:
+        bb.logger.info("getting PRAUTO")
+
+        p = {'get-pr': {'version': version, 'pkgarch': arch, 'checksum': checksum}}
+        data = "%s\n" % json.dumps(p)
+        sock.send(data.encode('utf-8'))
+
+        data = sock.recv(128)
+        data = json.loads(data.decode('utf-8'))
+        # Returns {'value': 1}
+        return data['value']
+
+    def test_first_query(self):
+        v = self.getPR("aaa", "bbb", "c")
+        assert v == 0, 'v = %s' % v
+
+        v = self.getPR("aaa", "bbb", "c")
+        assert v == 0
+
+        v = self.getPR("xyz", "y", "z")
+        assert v == 0
+
+        v = self.getPR("xyz", "y", "z")
+        assert v == 0
+
+    def test_bad_queries(self):
+        assert self.ping()
+        try:
+            self.getPR("aaa", "bbb", "c")
+            self.getPR("aaa", "bbb", "c")
+            self.getPR("aaa", "bbb", "c")
+            assert False, 'Should have gotten an error'
+        except Exception:
+            pass
+
+    def test_checksum_changes(self):
+        assert self.ping()
+
+        v1 = self.getPR("pkg-a", "arm64", "hash-a")
+        assert v1 == 0
+
+        v2 = self.getPR("pkg-a", "arm64", "hash-b")
+        assert v2 == 1
+
+        v3 = self.getPR("pkg-a", "arm64", "hash-c")
+        assert v3 == 2
+
+        v4 = self.getPR("pkg-a", "arm64", "hash-d")
+        assert v4 == 3
+
+        v5 = self.getPR("pkg-a", "arm64", "hash-b")
+        assert v5 == 4
+
+        v5 = self.getPR("pkg-a", "arm64", "hash-b")
+        assert v5 == 4
+
+    def test_arch_changes(self):
+        assert self.ping()
+        v = self.getPR("pkg-b", "arm64", "hash-a")
+        assert v == 0
+        v = self.getPR("pkg-b", "imx8mm", "hash-a")
+        assert v == 0
+        v = self.getPR("pkg-b", "aarch64", "hash-a")
+        assert v == 0
+        v = self.getPR("pkg-b", "8086", "hash-a")
+        assert v == 0
+
+    def test_autoinc(self):
+        assert self.ping()
+
+        sha1 = "12345"
+        sha2 = "23456"
+        sha3 = "34567"
+        v = self.getPR("AUTOINC-daemon-1.2.3+", "aarch64", "AUTOINC+%s" % sha1)
+        self.assertEqual(v, 0)
+
+        v = self.getPR("AUTOINC-daemon-1.2.3+", "aarch64", "AUTOINC+%s" % sha2)
+        self.assertEqual(v, 1)
+
+        v = self.getPR("AUTOINC-daemon-1.2.4+", "aarch64", "AUTOINC+%s" % sha1)
+        self.assertEqual(v, 0)
+
+        v = self.getPR("AUTOINC-daemon-1.2.3+", "x86_64", "AUTOINC+%s" % sha1)
+        self.assertEqual(v, 0)
+
+        v = self.getPR("AUTOINC-daemon-1.2.3+", "aarch64", "AUTOINC+%s" % sha3)
+        self.assertEqual(v, 2)
+
+
+    def test_full(self):
+
+        pkgs = ['pkg-x', 'pkg-y', 'pkg-z']
+        arches = ['arm64', 'x86_64']
+        hashes = ['hash-%d' % i for i in range(10)]
+
+        rand = random.Random(0)
+
+        # Populate database with basic stuff
+        for pkg, arch in itertools.product(pkgs, arches):
+            v = self.getPR(pkg, arch, "0")
+            assert v is not None
+
+        # Populate database with random-ish stuff
+        for _ in range(100):
+            pkg = rand.choice(pkgs)
+            arch = rand.choice(arches)
+            hash_ = rand.choice(hashes)
+            v = self.getPR(pkg, arch, hash_)
+            assert v is not None
+
+        table = 'PRMAIN_nohist'
+        old_versions = {}
+        old_versions_2 = {}
+
+        for pkg, arch, hash_ in itertools.product(pkgs, arches, hashes):
+            # verify that all OSv2 versions are less than the OSv1 version
+            query = 'select ifnull(max(value),0) from %s where version=? AND pkgarch=?;' % table
+            args = (pkg, arch)
+            data = conn.execute(query, args)
+
+            row = data.fetchone()
+            assert row is not None
+            value = row[0]
+
+            k = '%s-%s' % (pkg, arch)
+            old_v = old_versions.get(k, -1)
+            assert value >= old_v, "%s %s: old_v=%s, new_v=%s" % (pkg, arch, old_v, value)
+
+            old_versions[k] = value
+
+            k2 = '%s-%s' % (pkg, arch)
+            old_versions_2[k2] = value
+
+        print('\n')
+
+        for k in sorted(old_versions_2.keys()):
+            v = old_versions_2[k]
+            print("Max for %s is %s" % (k, v))
-- 
2.25.1


