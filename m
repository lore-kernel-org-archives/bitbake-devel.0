Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10B7C433F5
	for <webhook@archiver.kernel.org>; Tue, 19 Oct 2021 20:06:31 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mx.groups.io with SMTP id smtpd.web09.15498.1634673991359578096
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Oct 2021 13:06:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=GBrtrzan;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.174,
 mailfrom: steve@sakoman.com)
Received: by mail-pf1-f174.google.com with SMTP id 187so920594pfc.10
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Oct 2021 13:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=fNrScSfFWWhcZakJr8s9la29OYibp5NUhKGqZKA53bI=;
        b=GBrtrzanyTKqABBy3yY5V/gX67sOm+4SIlFQn8bMwVLfY8mj37KZhB/QL7WGLmbume
         Q992Pal/cUN6Ek7ot4gUmT5PR3+hm+l+p5CyQsHmOTUws3bxW+2Aohypn/rthxPilJDY
         XXrTDhV5w7nhT2J1fK2vtuaVXktQ7bZbbESY8VD3NWclriEB0x2aNuo4JrLY3Fqhv84c
         w6jIaiveYxDzG7mGHVRWpwvFvybljpjUnMX0AUfXOee4iuFEzmY4/HdAS9aSsAfD/i/i
         BpFcXkZuV+805FpCfx6MDg2TYG2ScyHw8jlRTjAZL3KYhzLsJn1sBVDHdRGuniJooe5o
         G32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fNrScSfFWWhcZakJr8s9la29OYibp5NUhKGqZKA53bI=;
        b=gXTMwViz0/KVKYLL+tdNA5gfn2LLfBuRSjGhwV0er5JGP33ghJ4IhuxslTOt+s4M1g
         N4qiTmInqhI8LKP1MvT03iuCRwf/a7cieD0pCE4V705TTc9wZO1jVlcK/fbTub07/thL
         3QUryTx06IG/SUCw/3PwjPcJnjX1MbqpYnPIEcA9VzjEXVRF2zu5I5jVtVOZi9blSwX7
         gCOhLCyxsKjCX3/l6+3Ndb8stAFNSMD6IIcQzQhwmGub6ztNm6mvml9KflBGLepAYGeq
         hKWfH9PXEh8IKRJITHBDxNSEyhv1UwQN2VojDXrl9KbVQNJUgPHP93zIOx1z+9XnMi9U
         cTSw==
X-Gm-Message-State: AOAM533qlQl2UpR4hVhCGcPw0ERAttT7mBi06igIam8io70JCjt/JGwJ
	oDE7b/5DS3ditwUA8+bg2/U/t79HSwefO6jo0lU=
X-Google-Smtp-Source: 
 ABdhPJweUq1o0DjFj3EELv5psMnIYUUMeWa95GWLkOWUZj5L2egdxtYrDcsWEZyb3OK3g1VWDBykDQ==
X-Received: by 2002:a05:6a00:1142:b0:44d:d43a:ac5d with SMTP id
 b2-20020a056a00114200b0044dd43aac5dmr1906402pfm.30.1634673990221;
        Tue, 19 Oct 2021 13:06:30 -0700 (PDT)
Received: from hexa.router0800d9.com (rrcs-66-91-142-162.west.biz.rr.com.
 [66.91.142.162])
        by smtp.gmail.com with ESMTPSA id
 l6sm3533562pjy.23.2021.10.19.13.06.29
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 13:06:29 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 1/8] compat.py: remove file since it
 no longer actually implements anything
Date: Tue, 19 Oct 2021 10:06:09 -1000
Message-Id: 
 <cc6ed47574fc087d30e54f9f5029fbac87ba13fa.1634673786.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634673786.git.steve@sakoman.com>
References: <cover.1634673786.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 19 Oct 2021 20:06:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12803

From: Chris Laplante <chris.laplante@agilent.com>

Now that compat.py just imports Python standard library stuff, get rid
of the layer of indirection.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit e2be6defbb9fcf25f9df04c3b452d0dba48dfd03)
Signed-off-by: Justin Bronder <jsbronder@cold-front.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
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
2.25.1


