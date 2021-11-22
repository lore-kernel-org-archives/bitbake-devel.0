Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBF8C433F5
	for <webhook@archiver.kernel.org>; Mon, 22 Nov 2021 02:24:58 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by mx.groups.io with SMTP id smtpd.web10.1441.1637547896753547701
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 21 Nov 2021 18:24:57 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 192.55.52.43, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10175"; a="320933684"
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800";
   d="scan'208";a="320933684"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2021 18:24:57 -0800
X-IronPort-AV: E=Sophos;i="5.87,253,1631602800";
   d="scan'208";a="588848656"
Received: from kkleong1-mobl1.gar.corp.intel.com (HELO
 anmitta2-mobl3.intel.com) ([10.215.239.135])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2021 18:24:55 -0800
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 1/8] bitbake: correct the collections vs collections.abc
 deprecation
Date: Mon, 22 Nov 2021 10:24:42 +0800
Message-Id: 
 <8e76cfcd9a88329fcbf80cfe4bbd839c32c9187f.1637547674.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1637547674.git.anuj.mittal@intel.com>
References: <cover.1637547674.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 Nov 2021 02:24:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13085

From: Alexander Kanavin <alex.kanavin@gmail.com>

This becomes a hard error in python 3.10.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit ae219e1f7460077f4492b31ac91cef4cf9b17277)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/cache.py        | 3 ++-
 lib/bb/data_smart.py   | 2 +-
 lib/bb/persist_data.py | 5 +++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/bb/cache.py b/lib/bb/cache.py
index 27eb2717..5f9c0a77 100644
--- a/lib/bb/cache.py
+++ b/lib/bb/cache.py
@@ -19,7 +19,8 @@
 import os
 import logging
 import pickle
-from collections import defaultdict, Mapping
+from collections import defaultdict
+from collections.abc import Mapping
 import bb.utils
 from bb import PrefixLoggerAdapter
 import re
diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
index 8291ca65..aa9ac2c8 100644
--- a/lib/bb/data_smart.py
+++ b/lib/bb/data_smart.py
@@ -17,7 +17,7 @@ BitBake build tools.
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
 import copy, re, sys, traceback
-from collections import MutableMapping
+from collections.abc import MutableMapping
 import logging
 import hashlib
 import bb, bb.codeparser
diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
index c6a209fb..6f32d81a 100644
--- a/lib/bb/persist_data.py
+++ b/lib/bb/persist_data.py
@@ -12,6 +12,7 @@ currently, providing a key/value store accessed by 'domain'.
 #
 
 import collections
+import collections.abc
 import contextlib
 import functools
 import logging
@@ -19,7 +20,7 @@ import os.path
 import sqlite3
 import sys
 import warnings
-from collections import Mapping
+from collections.abc import Mapping
 
 sqlversion = sqlite3.sqlite_version_info
 if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
@@ -29,7 +30,7 @@ if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
 logger = logging.getLogger("BitBake.PersistData")
 
 @functools.total_ordering
-class SQLTable(collections.MutableMapping):
+class SQLTable(collections.abc.MutableMapping):
     class _Decorators(object):
         @staticmethod
         def retry(*, reconnect=True):
-- 
2.33.1


