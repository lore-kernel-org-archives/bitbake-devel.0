Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.web09.3292.1631823772034928032
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Sep 2021 13:22:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=Z84K/5C/;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id q11so11435751wrr.9
        for <bitbake-devel@lists.openembedded.org>; Thu, 16 Sep 2021 13:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fV7XnN6lyWYqnsBbUtbLZ48/w/sEivfmQ3QKvMmKc3k=;
        b=Z84K/5C/Gz35QWzM97P9jso+YNiSFp9GjlcsCspnw6iT1aggJ9YUF+OJhSeeB236sv
         Evf31/2X34QNCyQSp4X10Jrx0GTqYqkOewQLeRNjG2700Yx85uutt28C6866JVKWkdxv
         zR17FyRss+JTrn+4+RTVHHYqnmDW0ymwYKDeJgwyDCmW7LKTbAoqFYn4QnGaJDs5pgtY
         mVM7p7Mr4SJi/usAcXVT1ZVLn/hN8yeZmjqZ4X9uZ3yGndU+ZgDYbhRz4LWAlQrwMd38
         IkMu/Il5uYRcIK0Tkvbr36ppnmyRcsd7i4vqi6gnPdIpCRLkokYl983jgu5pG9keoWUw
         VgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fV7XnN6lyWYqnsBbUtbLZ48/w/sEivfmQ3QKvMmKc3k=;
        b=WAzZIlC2/sGOebvOl4uYzrWX8TVl+rof3v/VQt5/nmsihYl1MrGstUJUthnAidP2H8
         kgD6jp8cHYHj7Z453O3I8HRVsVGikx9VdTFcWpjnHU8SfnQnDfKP1WQ457lT28PgM2Hb
         2qESSibbMi4SoRzGBoINbIqGk6BWyS1c7DdEUXxU1TJ+v+uauJz7y4WxCEun7VyaDX9J
         5nffl75e1nXbZiBEQJkGVbr5lmPss2NDB42B0PXay1riFjid/TRwvZ9LE/tUfMSKF5j7
         +YIjvjPSMbRcyp8mIK1Cw/JJQFs89JVso0AsLtDqRZie8u6B8NM9QCznWp69o4o5rKvc
         XJNQ==
X-Gm-Message-State: AOAM531vmK0B0IeWVzaBIzZUDHKmXiFYZDjcWGECy1K/mzdTGgCfG8lp
	D1CbSFaYJSILr3YEVwSXtto6oH8Bvwk=
X-Google-Smtp-Source: ABdhPJzyS+d+s5wuJc+Qmzqc4+TQfuSUvnPPMec+9CW+STCzStlF76QiltKWXst5kDfUmCjdZZ0bPA==
X-Received: by 2002:a05:6000:1866:: with SMTP id d6mr2232789wri.205.1631823770703;
        Thu, 16 Sep 2021 13:22:50 -0700 (PDT)
Return-Path: <alex.kanavin@gmail.com>
Received: from nereus.lab.linutronix.de. (b2b-109-90-143-203.unitymedia.biz. [109.90.143.203])
        by smtp.gmail.com with ESMTPSA id q11sm8644586wmc.41.2021.09.16.13.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 13:22:50 -0700 (PDT)
From: "Alexander Kanavin" <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 3/7] bitbake: correct the collections vs collections.abc deprecation
Date: Thu, 16 Sep 2021 22:22:33 +0200
Message-Id: <20210916202237.1929584-3-alex@linutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210916202237.1929584-1-alex@linutronix.de>
References: <20210916202237.1929584-1-alex@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This becomes a hard error in python 3.10.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/bb/cache.py        | 3 ++-
 bitbake/lib/bb/data_smart.py   | 2 +-
 bitbake/lib/bb/persist_data.py | 5 +++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index 73bc6e96656..4e08c100ab2 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
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
diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index e4afac64b20..73e33ee10ec 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -17,7 +17,7 @@ BitBake build tools.
 # Based on functions from the base bb module, Copyright 2003 Holger Schurig
 
 import copy, re, sys, traceback
-from collections import MutableMapping
+from collections.abc import MutableMapping
 import logging
 import hashlib
 import bb, bb.codeparser
diff --git a/bitbake/lib/bb/persist_data.py b/bitbake/lib/bb/persist_data.py
index 286cc0a99d1..49c9a0d5109 100644
--- a/bitbake/lib/bb/persist_data.py
+++ b/bitbake/lib/bb/persist_data.py
@@ -12,13 +12,14 @@ currently, providing a key/value store accessed by 'domain'.
 #
 
 import collections
+import collections.abc
 import contextlib
 import functools
 import logging
 import os.path
 import sqlite3
 import sys
-from collections import Mapping
+from collections.abc import Mapping
 
 sqlversion = sqlite3.sqlite_version_info
 if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
@@ -28,7 +29,7 @@ if sqlversion[0] < 3 or (sqlversion[0] == 3 and sqlversion[1] < 3):
 logger = logging.getLogger("BitBake.PersistData")
 
 @functools.total_ordering
-class SQLTable(collections.MutableMapping):
+class SQLTable(collections.abc.MutableMapping):
     class _Decorators(object):
         @staticmethod
         def retry(*, reconnect=True):
-- 
2.20.1

