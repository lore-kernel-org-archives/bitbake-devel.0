Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.72])
 by mx.groups.io with SMTP id smtpd.web12.59.1598374327696558807
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Aug 2020 09:52:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=kOgcRpkX;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.243.72, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c02sLMzMpOwFNt/eVeVeifBhDUsvPJrN5LHRwjWPkAso0vZtvTR2QZeid/AyaA80FZdOmALDeeOko2TZSYzxpKaTwRxCFlr8NsoG8IdtEFmxbk1Di+wjPrIrNgWMZBTiAi2EdhM7bkeKDVs6S6+lAJ5c6ky9SIOmgU+WmfdHHQ70hi5sKUyGaiQIWFz/L/YePv3PHZ2WXWuA3FeLq3hjFAFc34K9H/LOYBMnq7f8Q38fO8CqwnIhTU295KbOVLMQ2GHlDYeywFabu8Ymgh0RC1/cB1Ke2Q9ZIlqgscbbDTKAgPx11QPcFqu1h0nMt8oVEkmtqpCis4kdIpOIBLMokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpBd/Ehppti5iI1BdOhMKO3A+GFpu21iCkQqzCr7TLc=;
 b=UhrFpdW5orufnJUSPh6DK11F3kzi106kJN8g0D6MYsLTbvQqFttxrmAsRtQ/08n1hbTPEsmJ2S5GIXkpBnCIl0I3CvSy1inskWWYHgfAe3FKuluGpf+Ng8yujrGTaxyxMKeQVH1V1KdfQnpEYK1qY2nxsnGx2zHgrT5E4g1MkmEwwZuPbZxioIEub3aHVJYiG16B5FrkRnfsEkn8yqshXyL6yvBuL/zN1fzdQQGpqJLIyzndNDuBOS2t3PM3LOYAo3Ujmmp25pNNq4X0rzM6a3X1200+dqK+jr28OBBUaFFJ1MAW5T9ezylKJmqBcy08ulhdaO8KilEMxyuJMrckQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpBd/Ehppti5iI1BdOhMKO3A+GFpu21iCkQqzCr7TLc=;
 b=kOgcRpkXdrndxZATnB3H/+O/11AmwxfkWlyRjPFIBDrDiZETFwht4qMH1icj/7e2QtbcLO6unxcSjXRi1GL2iFZQaLIWB5lQVi//h3rDZyVikmta2moqZHtbS8tBlWwc7nmhecoWDVvpHfTn5jY10JPOwvhYVj5Ohr+Re+zQeiz1vf/xdnbxxBYZPN0ac3t3yz/14JNfP0vtCEHVrwlriguwMq+o1xUvqN2nhqCd9++ZSUqj7QTCCK1tadxVKaYvoAojeIhdschityV2ZC1vEgIaE/zzgFgttm4hjE0uekhMpDwH3lJiIA4c52rlMWtTmpjXXF+MEJcs5DUwg3709w==
Received: from BN6PR17CA0013.namprd17.prod.outlook.com (2603:10b6:404:65::23)
 by DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Tue, 25 Aug
 2020 16:52:05 +0000
Received: from BN8NAM12FT064.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::94) by BN6PR17CA0013.outlook.office365.com
 (2603:10b6:404:65::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Tue, 25 Aug 2020 16:52:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.41) by
 BN8NAM12FT064.mail.protection.outlook.com (10.13.182.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3326.19 via Frontend Transport; Tue, 25 Aug 2020 16:52:05 +0000
Received: from laplante-lm-19.localdomain (192.25.126.27) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server id
 15.1.1713.5; Tue, 25 Aug 2020 10:52:03 -0600
From: "Chris Laplante" <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH] compat.py: remove file since it no longer actually implements anything
Date: Tue, 25 Aug 2020 12:51:41 -0400
Message-ID: <20200825165141.64045-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Return-Path: chris.laplante@agilent.com
Received-SPF: SoftFail (wpcosapexchedg2.windmz.agilent.com: domain of
 transitioning chris.laplante@agilent.com discourages use of 192.25.126.27 as
 permitted sender)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec99de58-1f38-43e0-ef9c-08d84917327d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<DM6PR12MB39624546F8A5A08D0899C0038B570@DM6PR12MB3962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kcj7fCW90J8kzQD9YmlJvnsp7+LM6mxvA2Fw/ffQ8Xl/FA0VhoE8xUPsBwZFr+BLpNVhqQ8MVu4CjVKv+J/fqIulzqCU2qZA4Lo8rNKtef7Uv3WNOGuWnNvIXTlwWduoTvhK/vSad97PVZvQxkJzUIFaaBDS0K5ok8bboOladAO4SRjZuds5ZeM7RvjDQnjY9o+QYl7jxX1e7TcSGNiM4drQwGLw/yfk/qOsiZ/zWWFVjqnEDxyU+Gst2A2nmMchppG6G+jvjdhT5XAs44unviuhGLmqzmTl1nP+gqx8L/b/jpFU/RaMU+ISZnOodr0lToDwsRk4TdTHZ1T9CpcFAlmrD8MEKKQK6M7JmAiyBgUOMVaqaLBuYqzCW9XC79cnMfqZK7CdK7T9RSSvSb4Fg0YRj3KdvaLU59KBKCEOzFc=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(29502001)(46966005)(70206006)(426003)(2906002)(7636003)(478600001)(336012)(6666004)(86362001)(4326008)(47076004)(26005)(82740400003)(8676002)(83380400001)(5660300002)(186003)(6916009)(82310400002)(356005)(44832011)(956004)(36906005)(316002)(107886003)(1076003)(36756003)(8936002)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2020 16:52:05.1685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec99de58-1f38-43e0-ef9c-08d84917327d
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN8NAM12FT064.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3962
Content-Type: text/plain

Now that compat.py just imports Python standard library stuff, get rid
of the layer of indirection.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/compat.py       | 10 ----------
 lib/bb/event.py        | 16 ++++++++--------
 lib/bb/persist_data.py |  8 ++++----
 lib/bb/tests/event.py  | 17 +++++++++--------
 4 files changed, 21 insertions(+), 30 deletions(-)
 delete mode 100644 lib/bb/compat.py

diff --git a/lib/bb/compat.py b/lib/bb/compat.py
deleted file mode 100644
index 49356681..00000000
--- a/lib/bb/compat.py
+++ /dev/null
@@ -1,10 +0,0 @@
-#
-# SPDX-License-Identifier: GPL-2.0-only
-#
-
-"""Code pulled from future python versions, here for compatibility"""
-
-from collections import MutableMapping, KeysView, ValuesView, ItemsView, OrderedDict
-from functools import total_ordering
-
-
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 0e6d9b29..694b4705 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -10,17 +10,17 @@ BitBake build tools.
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-import sys
-import pickle
-import logging
-import atexit
-import traceback
 import ast
+import atexit
+import collections
+import logging
+import pickle
+import sys
 import threading
+import traceback
 
-import bb.utils
-import bb.compat
 import bb.exceptions
+import bb.utils
 
 # This is the pid for which we should generate the event. This is set when
 # the runqueue forks off.
@@ -56,7 +56,7 @@ def set_class_handlers(h):
     _handlers = h
 
 def clean_class_handlers():
-    return bb.compat.OrderedDict()
+    return collections.OrderedDict()
 
 # Internal
 _handlers = clean_class_handlers()
diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
index 7357ab2d..5f4fbe35 100644
--- a/lib/bb/persist_data.py
+++ b/lib/bb/persist_data.py
@@ -12,14 +12,14 @@ currently, providing a key/value store accessed by 'domain'.
 #
 
 import collections
+import contextlib
+import functools
 import logging
 import os.path
+import sqlite3
 import sys
 import warnings
-from bb.compat import total_ordering
 from collections import Mapping
-import sqlite3
-import contextlib
 
 sqlversion = sqlite3.sqlite_version_info
 if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
@@ -28,7 +28,7 @@ if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
 
 logger = logging.getLogger("BitBake.PersistData")
 
-@total_ordering
+@functools.total_ordering
 class SQLTable(collections.MutableMapping):
     class _Decorators(object):
         @staticmethod
diff --git a/lib/bb/tests/event.py b/lib/bb/tests/event.py
index 9229b63d..9ca7e9bc 100644
--- a/lib/bb/tests/event.py
+++ b/lib/bb/tests/event.py
@@ -6,17 +6,18 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
-import unittest
-import bb
-import logging
-import bb.compat
-import bb.event
+import collections
 import importlib
+import logging
+import pickle
 import threading
 import time
-import pickle
+import unittest
 from unittest.mock import Mock
 from unittest.mock import call
+
+import bb
+import bb.event
 from bb.msg import BBLogFormatter
 
 
@@ -75,7 +76,7 @@ class EventHandlingTest(unittest.TestCase):
 
     def _create_test_handlers(self):
         """ Method used to create a test handler ordered dictionary """
-        test_handlers = bb.compat.OrderedDict()
+        test_handlers = collections.OrderedDict()
         test_handlers["handler1"] = self._test_process.handler1
         test_handlers["handler2"] = self._test_process.handler2
         return test_handlers
@@ -96,7 +97,7 @@ class EventHandlingTest(unittest.TestCase):
 
     def test_clean_class_handlers(self):
         """ Test clean_class_handlers method """
-        cleanDict = bb.compat.OrderedDict()
+        cleanDict = collections.OrderedDict()
         self.assertEqual(cleanDict,
                          bb.event.clean_class_handlers())
 
-- 
2.17.1

