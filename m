Return-Path: <jacob.kroon@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C7EC433F5
	for <webhook@archiver.kernel.org>; Thu, 18 Nov 2021 16:27:01 +0000 (UTC)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com
 [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web12.3852.1637252820737072387
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Nov 2021 08:27:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=pYi8EYrW;
 spf=pass (domain: gmail.com, ip: 209.85.167.53,
 mailfrom: jacob.kroon@gmail.com)
Received: by mail-lf1-f53.google.com with SMTP id k37so28891519lfv.3
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Nov 2021 08:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bfWw+YyzVvmmhzSqIjeq8dhXCAAbncPMkX2Z+BmpXkY=;
        b=pYi8EYrWI+HmnV4IbIiVI3pNqN45CSVJdeNm3a1T/N6yFGVyKybguc7aohJRh7MMKe
         dLst0sJFC10wFbNVtkEQ8LrRcd8iTcXCM08N2725ck9WLftsx1QY/tqOQl8KIz9+mvbo
         EohepfC/lXxxpjC5npr8H087O+aSUAUSmBaImEvxNHgMHPg+Kg7z7h2fC/K58Stw3yD2
         eq+HFkLu08x80u5qzdTe5VhcGLr7upmeuaY84nhb1IBN917GuS58B5OMKqB/LpnJbAKc
         V90wz7R67wkiuSN9JnnqpywcqrV6lViIDYYPAvFoogeUs5N76EVfksqp9MUdNm8GIiNi
         pgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bfWw+YyzVvmmhzSqIjeq8dhXCAAbncPMkX2Z+BmpXkY=;
        b=6ejs93GjsoTcPOV8Sr29SQ6PmTG3C+NRSRxeYpo6C76uw5d6trimrAtA9vdVVaiCOo
         REQmxDbsK4MMm91bF9Vp9QAmalr0A/rvjgUAxhDMuhWrTM3SoEWbUxVjnp1zNx1iyrIW
         sdeK6oR3oAB5j/MO1ynESTc3xqQHKho797tUTEwZIQylCuxU25zOfzeYq/HSsikiFjhc
         BYZy9mDmcaZ7BUMHF9WR+a3L+Jtm/Ms8aYGfpEQGeJcAvsccNLFlifYNs9gfsmgX4CsC
         mmDsOwN5Z1k8f5qkdbNHp6/XC0lgO2N7pUpd6pdkrna6C9PWUau+RBSBHV9izwjatbEJ
         BbDg==
X-Gm-Message-State: AOAM531kTNgsgRgwaxZz5ksxI4A1GzkU8oXWZhuZS4VhIvYBHRqJu21f
	Y8DO+2dlmlwGCGXnQM9jRcbuy2KaolU5HbCB
X-Google-Smtp-Source: 
 ABdhPJzv6/g478jXIR9dqV5UfPp59CS5F/tKl0hLDPRqiw5SUh+o1R0t+VtMguP4uvYYpeu6WRNRnA==
X-Received: by 2002:ac2:5d71:: with SMTP id
 h17mr25002275lft.642.1637252818482;
        Thu, 18 Nov 2021 08:26:58 -0800 (PST)
Received: from localhost.localdomain (37-247-29-68.customers.ownit.se.
 [37.247.29.68])
        by smtp.gmail.com with ESMTPSA id
 p17sm37252lfs.292.2021.11.18.08.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 08:26:58 -0800 (PST)
From: Jacob Kroon <jacob.kroon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>,
	Alexander Kanavin <alex@linutronix.de>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [1.50][PATCH 1/4] bitbake: correct the collections vs collections.abc
 deprecation
Date: Thu, 18 Nov 2021 17:26:20 +0100
Message-Id: <20211118162623.3117035-2-jacob.kroon@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211118162623.3117035-1-jacob.kroon@gmail.com>
References: <20211118162623.3117035-1-jacob.kroon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Nov 2021 16:27:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13069

From: Alexander Kanavin <alex.kanavin@gmail.com>

This becomes a hard error in python 3.10.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit ae219e1f7460077f4492b31ac91cef4cf9b17277)
Signed-off-by: Jacob Kroon <jacob.kroon@gmail.com>
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

