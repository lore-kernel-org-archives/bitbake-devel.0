Return-Path: <jsbronder@cold-front.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1252BC433FE
	for <webhook@archiver.kernel.org>; Mon, 18 Oct 2021 19:01:55 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com
 [66.111.4.29])
 by mx.groups.io with SMTP id smtpd.web10.10.1634583713828679315
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Oct 2021 12:01:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cold-front.org header.s=mesmtp header.b=lQsFbtUR;
 spf=pass (domain: cold-front.org, ip: 66.111.4.29,
 mailfrom: jsbronder@cold-front.org)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 1EB0B5C00C6;
	Mon, 18 Oct 2021 15:01:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 18 Oct 2021 15:01:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cold-front.org;
	 h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=mesmtp; bh=SAD60WhGnh
	mAp4hxmX5v/iMkTppoKpo821ID3A4joxY=; b=lQsFbtURkKuVjl3h3Tor5PsN98
	8kQ5TUGaAhiwk0HZmaq1a0geF2fZcNsiKGPp4DiQ4vF81B07yOyzhrj5EmccnEmi
	rCWIo2ZLlUIdOboCeZB43usJmIl2XZWqvNaos+g9lRfkYLOBrNCVnSr2PR0gE7yK
	3R8H5zuhWLf64dZ3g=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:date:from
	:in-reply-to:message-id:mime-version:references:subject:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; bh=SAD60WhGnhmAp4hxmX5v/iMkTppoKpo821ID3A4joxY=; b=d2HDjTfK
	Kmi17Y1VVqpZbx4OD7ID6DB0nMBKNSL2/LsOVizuNLaGpM4zRkJ6c/XYOmbdWyMA
	3EBPpMJUZ1+oIhf5luFWHqGc5TNJL37JMq8LsZ7KtJSVYKPxbZrzUy0W018x/KYL
	E/ry84JzR+GG8rbwEe00IboagKEdCw62p/nyuBXQ6kpKnWhLIZeY1IU5ysCq9scY
	3B7fFaD/6mVfpKUlZs7tq5VpKbDYGBBHJgDts4fpslWltKUKZ4hiChcnoJEH932a
	veofgMUBjoX1qlW8m7zpnO+auQpD1nmIXzWhMke4zrEXNYDgMHmCfxH1ArAtB7s0
	ZLSpK0XUokKC2Q==
X-ME-Sender: <xms:oMRtYZ3zVmvaObFx_noCATBYOb7QGyjKAuF5Vz91rs_A0bmsfpajdg>
    <xme:oMRtYQHkltX5qsZM_-QxonZJBItc-76A411xDDHQN71LddlnRuuQmzCgW1Ke-Oyx_
    S6ip5xOhaDMGwvquw>
X-ME-Received: 
 <xmr:oMRtYZ5SZIgnHSfyuT3YAZhQRmPtyqwFe04B48i-j4mDBq81gIPBuU_6aScR-GUbQxJeBdgmfdl-84AoNpFRvoUnW73ExNNApCMjnI5a11vQ>
X-ME-Proxy-Cause: 
 gggruggvucftvghtrhhoucdtuddrgedvtddrvddvtddguddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhushht
    ihhnuceurhhonhguvghruceojhhssghrohhnuggvrhestgholhguqdhfrhhonhhtrdhorh
    hgqeenucggtffrrghtthgvrhhnpeetteehvedvhefglefftdekveeiledtueduffejjeef
    hfdugedtfeejtdegheevffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehjshgsrhhonhguvghrsegtohhlugdqfhhrohhnthdrohhrgh
X-ME-Proxy: <xmx:oMRtYW2NfKeoSiF5Sud0fhkZM4__4UXpj8I_c2AWUaWpJtKcQsyc5Q>
    <xmx:oMRtYcHp11lJoLPkwI_vxQZuxyXpE94_OkybzuY2Wir94CvG_8iwZA>
    <xmx:oMRtYX-JxJljSVVTatmoi9uWR05H2slQgHiu4Apoi6hIPhhDKVUXMA>
    <xmx:ocRtYRQOtBNqV9nQEBRoE9Z-SqMVi3DU2aPgFrTFCOVNuTUIBhpQWg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Oct 2021 15:01:52 -0400 (EDT)
From: Justin Bronder <jsbronder@cold-front.org>
To: bitbake-devel@lists.openembedded.org
Cc: Chris Laplante <chris.laplante@agilent.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>,
	Justin Bronder <jsbronder@cold-front.org>
Subject: [1.46][PATCH 1/8] compat.py: remove file since it no longer actually
 implements anything
Date: Mon, 18 Oct 2021 15:01:34 -0400
Message-Id: <20211018190141.15806-2-jsbronder@cold-front.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018190141.15806-1-jsbronder@cold-front.org>
References: <20211018190141.15806-1-jsbronder@cold-front.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Oct 2021 19:01:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12794

From: Chris Laplante <chris.laplante@agilent.com>

Now that compat.py just imports Python standard library stuff, get rid
of the layer of indirection.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
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
index d1359f01..cb0b3b33 100644
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
2.33.0


