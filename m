Received: from NAM02-BL2-obe.outbound.protection.outlook.com (NAM02-BL2-obe.outbound.protection.outlook.com [40.107.75.82])
 by mx.groups.io with SMTP id smtpd.web11.28595.1598560784097831082
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2020 13:39:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=OdHakYDP;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.75.82, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSm6r1YfHRURBLto4+UBt8LFHXw/8zHhi9Vw7RjI/9BGlRq3YXHZD8bMIZqM0kr+fFX1Td3sssDTfvHi8mM0/hEsbnew8+iwGKczTFwIAFv+lzuhkz/dQm5gLZl/wl4g5hiDOl/UI2jPxv+Kb7m2I5OER1abgoTC5grouS+cXfWg4tF/7oTlco8ArNnP7Fsi0BxIZWL6Z/JwsXwBuCPLNfjcjjzI8DsjE9GbuAsOyTImEOnyjbgqhI7AfsEnKo3lrMv5d4tCWrSw+iixlNnoeUuEnODYGVkghYo0WDX7z/euDWKHV+HLT0w9hR8BS5HcrQvmvfz2ZT1wreulz812mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PWl8X56pA5kH6ytL74rXhurUBRePOL9Pig/8v4bNzw=;
 b=M8nDhhS8aRdKr64A9BLhAozh0TGjtDZEJlYDRy/eco1as+HR20ocOKLaTzV4MIBmNn9Wjxfe+5axcsW9pUxQSOeC+VWA8ZQpxckyrKxTBIw/0hlxJN5eYKyS+PhfOsnqx+fI+/3T2p72FZKrtQFlQ2a3g9z5bAuGlt8t066/fbRu+fDsCYsOlBXOFx+hJgzdUNWp8+W8ragstWCAEMFayukGkrJR3uTr9GuJleGOrDWHNguswLR/sTIRTUzwHC+pBH81TXdZfpsUHm8pcFIm7KHG6Jb6bC2UBm0LtifS101i/ze9HjGlKLWaIuWHNOV5iEFIJZtEjAJ0JaZ5Bi0yrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PWl8X56pA5kH6ytL74rXhurUBRePOL9Pig/8v4bNzw=;
 b=OdHakYDPUPTtLgWmwgHu6lJ9J0uxp6VhVbPQAGB82zs1jsdPG5UNqNi0P8+D5hHZwCsxLC3VcfqfOKXCzKtByRpsXLSGajSf1VsuGANG79Mtjx1+qAEQnvvb/iy5cx7pZ2erKc4AKVhOmYHbW6j77MFTe4h+8Ar+zg249OkopJJ3hNYlkVchpBm2W2ktXjZ45Sk0yFvmROK2vHx6oSmtha22D38HRNBGjOEaYdWBbX3TNx6xKZIumyMQSnF5jyJ2YEY1sFzN4XPkSCn8IT5Vxf57b4Lxb9eE6HKqnHJHwyaa73XVXkSyc9p59EDx8U7S/HlTCZgPaCaDTp/pO6oNqg==
Received: from BN6PR16CA0007.namprd16.prod.outlook.com (2603:10b6:404:f5::17)
 by CY4PR12MB1654.namprd12.prod.outlook.com (2603:10b6:910:3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 20:39:38 +0000
Received: from BN8NAM12FT004.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::b8) by BN6PR16CA0007.outlook.office365.com
 (2603:10b6:404:f5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend
 Transport; Thu, 27 Aug 2020 20:39:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 BN8NAM12FT004.mail.protection.outlook.com (10.13.183.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 20:39:38 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.1713.5; Thu, 27 Aug 2020 14:39:16 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 2/2] COW: migrate test suite into tests/cow
Date: Thu, 27 Aug 2020 16:38:39 -0400
Message-ID: <20200827203839.29669-2-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200827203839.29669-1-chris.laplante@agilent.com>
References: <20200827203839.29669-1-chris.laplante@agilent.com>
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee072138-c8fb-4ac2-d474-08d84ac9510f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1654:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<CY4PR12MB16541A78C443D8B805FF1A218B550@CY4PR12MB1654.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:61;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6f63ArguQ+j6VKgxqMD3dCzQuG9ADRDSWxHiXYq3mhqXsWLVsvYKk0+OjNLUiQRfXAhQEpVzXBZ0JLqdOZ5w5s9KfKi0zSEqkZ0dI8K/BQDjDucBpK+vItp/uWaHzM8sLZxhWlpTi8laE/DZ5WgMw9HfCvdYHHnE9M9Sz0m3Aq6jtuE+oajvE/ges8lhroH70MtWnJxKUYBHE+T1md6/7EfSppTZE8gEs1yDU6uZUc+4aHpq5Nbuo1icXJ+t3ldx28MnbnncKqdXZ2Sx3zIA9kF93xPkNheI1dkRf9ACtGRNPrmBxngLbOLgxN/HgBb+sNx+EEmJ6qSslf3W/KUP6zZPE1RwTm6zfo5u+7VYXrqfhFDTl/DxtqxzRJzJiIB5GGbroqNq6jlVYes2P+IFM2FUGTq8is2tRQ7kORN4G28=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(29502001)(46966005)(26005)(316002)(36906005)(1076003)(36756003)(107886003)(5660300002)(336012)(47076004)(4326008)(70206006)(186003)(83380400001)(6916009)(8936002)(82740400003)(82310400002)(30864003)(7636003)(6666004)(426003)(478600001)(356005)(956004)(86362001)(8676002)(2906002)(2616005)(44832011);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 20:39:38.0409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee072138-c8fb-4ac2-d474-08d84ac9510f
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN8NAM12FT004.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1654
Content-Type: text/plain

Convert the test suite that was in COW.py into something that
will actually run as part of bitbake-selftest. This is in
preparation for some cleanups I plan in COW.py.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/COW.py       | 122 -------------------------
 lib/bb/tests/cow.py | 218 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 206 insertions(+), 134 deletions(-)

diff --git a/lib/bb/COW.py b/lib/bb/COW.py
index 3785a8b0..23c22b65 100644
--- a/lib/bb/COW.py
+++ b/lib/bb/COW.py
@@ -193,125 +193,3 @@ class COWDictBase(metaclass=COWDictMeta):
 
 class COWSetBase(metaclass=COWSetMeta):
     __count__ = 0
-
-if __name__ == "__main__":
-    import sys
-    COWDictBase.__warn__ = sys.stderr
-    a = COWDictBase()
-    print("a", a)
-
-    a['a'] = 'a'
-    a['b'] = 'b'
-    a['dict'] = {}
-
-    b = a.copy()
-    print("b", b)
-    b['c'] = 'b'
-
-    print()
-
-    print("a", a)
-    for x in a.iteritems():
-        print(x)
-    print("--")
-    print("b", b)
-    for x in b.iteritems():
-        print(x)
-    print()
-
-    b['dict']['a'] = 'b'
-    b['a'] = 'c'
-
-    print("a", a)
-    for x in a.iteritems():
-        print(x)
-    print("--")
-    print("b", b)
-    for x in b.iteritems():
-        print(x)
-    print()
-
-    try:
-        b['dict2']
-    except KeyError as e:
-        print("Okay!")
-
-    a['set'] = COWSetBase()
-    a['set'].add("o1")
-    a['set'].add("o1")
-    a['set'].add("o2")
-
-    print("a", a)
-    for x in a['set'].itervalues():
-        print(x)
-    print("--")
-    print("b", b)
-    for x in b['set'].itervalues():
-        print(x)
-    print()
-
-    b['set'].add('o3')
-
-    print("a", a)
-    for x in a['set'].itervalues():
-        print(x)
-    print("--")
-    print("b", b)
-    for x in b['set'].itervalues():
-        print(x)
-    print()
-
-    a['set2'] = set()
-    a['set2'].add("o1")
-    a['set2'].add("o1")
-    a['set2'].add("o2")
-
-    print("a", a)
-    for x in a.iteritems():
-        print(x)
-    print("--")
-    print("b", b)
-    for x in b.iteritems(readonly=True):
-        print(x)
-    print()
-
-    del b['b']
-    try:
-        print(b['b'])
-    except KeyError:
-        print("Yay! deleted key raises error")
-
-    if 'b' in b:
-        print("Boo!")
-    else:
-        print("Yay - has_key with delete works!")
-
-    print("a", a)
-    for x in a.iteritems():
-        print(x)
-    print("--")
-    print("b", b)
-    for x in b.iteritems(readonly=True):
-        print(x)
-    print()
-
-    b.__revertitem__('b')
-
-    print("a", a)
-    for x in a.iteritems():
-        print(x)
-    print("--")
-    print("b", b)
-    for x in b.iteritems(readonly=True):
-        print(x)
-    print()
-
-    b.__revertitem__('dict')
-    print("a", a)
-    for x in a.iteritems():
-        print(x)
-    print("--")
-    print("b", b)
-    for x in b.iteritems(readonly=True):
-        print(x)
-    print()
diff --git a/lib/bb/tests/cow.py b/lib/bb/tests/cow.py
index bf6e79fc..75142649 100644
--- a/lib/bb/tests/cow.py
+++ b/lib/bb/tests/cow.py
@@ -4,9 +4,17 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 # Copyright 2006 Holger Freyther <freyther@handhelds.org>
+# Copyright (C) 2020  Agilent Technologies, Inc.
 #
 
+import io
+import re
+import sys
 import unittest
+import contextlib
+import collections
+
+from bb.COW import COWDictBase, COWSetBase, COWDictMeta, COWSetMeta
 
 
 class COWTestCase(unittest.TestCase):
@@ -14,11 +22,61 @@ class COWTestCase(unittest.TestCase):
     Test case for the COW module from mithro
     """
 
+    def setUp(self):
+        self._track_warnings = False
+        self._warning_file = io.StringIO()
+        self._unhandled_warnings = collections.deque()
+        COWDictBase.__warn__ = self._warning_file
+
+    def tearDown(self):
+        COWDictBase.__warn__ = sys.stderr
+        if self._track_warnings:
+            self._checkAllWarningsRead()
+
+    def trackWarnings(self):
+        self._track_warnings = True
+
+    def _collectWarnings(self):
+        self._warning_file.seek(0)
+        for warning in self._warning_file:
+            self._unhandled_warnings.append(warning.rstrip("\n"))
+        self._warning_file.truncate(0)
+        self._warning_file.seek(0)
+
+    def _checkAllWarningsRead(self):
+        self._collectWarnings()
+        self.assertSequenceEqual(self._unhandled_warnings, [])
+
+    @contextlib.contextmanager
+    def checkReportsWarning(self, expected_warning):
+        self._checkAllWarningsRead()
+        yield
+        self._collectWarnings()
+        warning = self._unhandled_warnings.popleft()
+        self.assertEqual(warning, expected_warning)
+
+    def checkStrOutput(self, obj, expected_levels, expected_keys):
+        if obj.__class__ is COWDictMeta:
+            expected_class_name = "COWDict"
+        elif obj.__class__ is COWSetMeta:
+            expected_class_name = "COWSet"
+        else:
+            self.fail("obj is of unknown type {0}".format(type(obj)))
+        s = str(obj)
+        regex = re.compile(r"<(\w+) Level: (\d+) Current Keys: (\d+)>")
+        match = regex.match(s)
+        self.assertIsNotNone(match, "bad str output: '{0}'".format(s))
+        class_name = match.group(1)
+        self.assertEqual(class_name, expected_class_name)
+        levels = int(match.group(2))
+        self.assertEqual(levels, expected_levels, "wrong # levels in str: '{0}'".format(s))
+        keys = int(match.group(3))
+        self.assertEqual(keys, expected_keys, "wrong # keys in str: '{0}'".format(s))
+
     def testGetSet(self):
         """
         Test and set
         """
-        from bb.COW import COWDictBase
         a = COWDictBase.copy()
 
         self.assertEqual(False, 'a' in a)
@@ -27,16 +85,14 @@ class COWTestCase(unittest.TestCase):
         a['b'] = 'b'
         self.assertEqual(True, 'a' in a)
         self.assertEqual(True, 'b' in a)
-        self.assertEqual('a', a['a'] )
-        self.assertEqual('b', a['b'] )
+        self.assertEqual('a', a['a'])
+        self.assertEqual('b', a['b'])
 
     def testCopyCopy(self):
         """
         Test the copy of copies
         """
 
-        from bb.COW import COWDictBase
-
         # create two COW dict 'instances'
         b = COWDictBase.copy()
         c = COWDictBase.copy()
@@ -94,30 +150,168 @@ class COWTestCase(unittest.TestCase):
         self.assertEqual(False, 'e' in b_2)
 
     def testCow(self):
-        from bb.COW import COWDictBase
+        self.trackWarnings()
+
         c = COWDictBase.copy()
         c['123'] = 1027
         c['other'] = 4711
-        c['d'] = { 'abc' : 10, 'bcd' : 20 }
+        c['d'] = {'abc': 10, 'bcd': 20}
 
         copy = c.copy()
 
         self.assertEqual(1027, c['123'])
         self.assertEqual(4711, c['other'])
-        self.assertEqual({'abc':10, 'bcd':20}, c['d'])
+        self.assertEqual({'abc': 10, 'bcd': 20}, c['d'])
         self.assertEqual(1027, copy['123'])
         self.assertEqual(4711, copy['other'])
-        self.assertEqual({'abc':10, 'bcd':20}, copy['d'])
+        with self.checkReportsWarning("Warning: Doing a copy because d is a mutable type."):
+            self.assertEqual({'abc': 10, 'bcd': 20}, copy['d'])
 
         # cow it now
         copy['123'] = 1028
         copy['other'] = 4712
         copy['d']['abc'] = 20
 
-
         self.assertEqual(1027, c['123'])
         self.assertEqual(4711, c['other'])
-        self.assertEqual({'abc':10, 'bcd':20}, c['d'])
+        self.assertEqual({'abc': 10, 'bcd': 20}, c['d'])
         self.assertEqual(1028, copy['123'])
         self.assertEqual(4712, copy['other'])
-        self.assertEqual({'abc':20, 'bcd':20}, copy['d'])
+        self.assertEqual({'abc': 20, 'bcd': 20}, copy['d'])
+
+    def testOriginalTestSuite(self):
+        # This test suite is a port of the original one from COW.py
+        self.trackWarnings()
+
+        a = COWDictBase.copy()
+        self.checkStrOutput(a, 1, 0)
+
+        a['a'] = 'a'
+        a['b'] = 'b'
+        a['dict'] = {}
+        self.checkStrOutput(a, 1, 4)  # 4th member is dict__mutable__
+
+        b = a.copy()
+        self.checkStrOutput(b, 2, 0)
+        b['c'] = 'b'
+        self.checkStrOutput(b, 2, 1)
+
+        with self.checkReportsWarning("Warning: If you aren't going to change any of the values call with True."):
+            self.assertListEqual(list(a.iteritems()),
+                                 [('a', 'a'),
+                                  ('b', 'b'),
+                                  ('dict', {})
+                                  ])
+
+        with self.checkReportsWarning("Warning: If you aren't going to change any of the values call with True."):
+            b_gen = b.iteritems()
+        self.assertTupleEqual(next(b_gen), ('a', 'a'))
+        self.assertTupleEqual(next(b_gen), ('b', 'b'))
+        self.assertTupleEqual(next(b_gen), ('c', 'b'))
+        with self.checkReportsWarning("Warning: Doing a copy because dict is a mutable type."):
+            self.assertTupleEqual(next(b_gen), ('dict', {}))
+        with self.assertRaises(StopIteration):
+            next(b_gen)
+
+        b['dict']['a'] = 'b'
+        b['a'] = 'c'
+
+        self.checkStrOutput(a, 1, 4)
+        self.checkStrOutput(b, 2, 3)
+
+        with self.checkReportsWarning("Warning: If you aren't going to change any of the values call with True."):
+            self.assertListEqual(list(a.iteritems()),
+                                 [('a', 'a'),
+                                  ('b', 'b'),
+                                  ('dict', {})
+                                  ])
+
+        with self.checkReportsWarning("Warning: If you aren't going to change any of the values call with True."):
+            b_gen = b.iteritems()
+        self.assertTupleEqual(next(b_gen), ('a', 'c'))
+        self.assertTupleEqual(next(b_gen), ('b', 'b'))
+        self.assertTupleEqual(next(b_gen), ('c', 'b'))
+        self.assertTupleEqual(next(b_gen), ('dict', {'a': 'b'}))
+        with self.assertRaises(StopIteration):
+            next(b_gen)
+
+        with self.assertRaises(KeyError):
+            print(b["dict2"])
+
+        a['set'] = COWSetBase()
+        a['set'].add("o1")
+        a['set'].add("o1")
+        a['set'].add("o2")
+        self.assertSetEqual(set(a['set'].itervalues()), {"o1", "o2"})
+        self.assertSetEqual(set(b['set'].itervalues()), {"o1", "o2"})
+
+        b['set'].add('o3')
+        self.assertSetEqual(set(a['set'].itervalues()), {"o1", "o2"})
+        self.assertSetEqual(set(b['set'].itervalues()), {"o1", "o2", "o3"})
+
+        a['set2'] = set()
+        a['set2'].add("o1")
+        a['set2'].add("o1")
+        a['set2'].add("o2")
+
+        # We don't expect 'a' to change anymore
+        def check_a():
+            with self.checkReportsWarning("Warning: If you aren't going to change any of the values call with True."):
+                a_gen = a.iteritems()
+                self.assertTupleEqual(next(a_gen), ('a', 'a'))
+            self.assertTupleEqual(next(a_gen), ('b', 'b'))
+            self.assertTupleEqual(next(a_gen), ('dict', {}))
+            self.assertTupleEqual(next(a_gen), ('set2', {'o1', 'o2'}))
+            a_sub_set = next(a_gen)
+            self.assertEqual(a_sub_set[0], 'set')
+            self.checkStrOutput(a_sub_set[1], 1, 2)
+            self.assertSetEqual(set(a_sub_set[1].itervalues()), {'o1', 'o2'})
+
+        check_a()
+
+        b_gen = b.iteritems(readonly=True)
+        self.assertTupleEqual(next(b_gen), ('a', 'c'))
+        self.assertTupleEqual(next(b_gen), ('b', 'b'))
+        self.assertTupleEqual(next(b_gen), ('c', 'b'))
+        self.assertTupleEqual(next(b_gen), ('dict', {'a': 'b'}))
+        self.assertTupleEqual(next(b_gen), ('set2', {'o1', 'o2'}))
+        b_sub_set = next(b_gen)
+        self.assertEqual(b_sub_set[0], 'set')
+        self.checkStrOutput(b_sub_set[1], 2, 1)
+        self.assertSetEqual(set(b_sub_set[1].itervalues()), {'o1', 'o2', 'o3'})
+
+        del b['b']
+        with self.assertRaises(KeyError):
+            print(b['b'])
+        self.assertFalse('b' in b)
+
+        check_a()
+
+        b.__revertitem__('b')
+        check_a()
+        self.assertEqual(b['b'], 'b')
+        self.assertTrue('b' in b)
+
+        b.__revertitem__('dict')
+        check_a()
+
+        b_gen = b.iteritems(readonly=True)
+        self.assertTupleEqual(next(b_gen), ('a', 'c'))
+        self.assertTupleEqual(next(b_gen), ('b', 'b'))
+        self.assertTupleEqual(next(b_gen), ('c', 'b'))
+        self.assertTupleEqual(next(b_gen), ('dict', {}))
+        self.assertTupleEqual(next(b_gen), ('set2', {'o1', 'o2'}))
+        b_sub_set = next(b_gen)
+        self.assertEqual(b_sub_set[0], 'set')
+        self.checkStrOutput(b_sub_set[1], 2, 1)
+        self.assertSetEqual(set(b_sub_set[1].itervalues()), {'o1', 'o2', 'o3'})
+
+        self.checkStrOutput(a, 1, 6)
+        self.checkStrOutput(b, 2, 3)
+
+    def testSetMethods(self):
+        s = COWSetBase()
+        with self.assertRaises(TypeError):
+            print(s.iteritems())
+        with self.assertRaises(TypeError):
+            print(s.iterkeys())
-- 
2.17.1

