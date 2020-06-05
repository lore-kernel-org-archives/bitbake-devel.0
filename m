Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web12.14243.1591372161010757451
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2020 08:49:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=DZq+I0Kx;
 spf=pass (domain: axis.com, ip: 195.60.68.18, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1252; q=dns/txt; s=axis-central1;
  t=1591372161; x=1622908161;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/l9GF7+f7JxtsfYFdVduRYtnm8p1aNKLIwar4j9+VWA=;
  b=DZq+I0KxNHPrRq3qbk05wnFr41GY+OUM+Q27+bWGVIjfbq9iUODJ1dmC
   60n4K9Cgerf2pOh1YcuqFmx/so4TxeM4ZCF45Z6b4L5O33fmoNQFqNcc9
   tMoczqpXLHrhRTvS2blzc4J4eNimjo6FD1autZ3FNHRIHgcXrcAREvDk/
   X2h11C/+rdOHa41YBszdq9pyOk5VQ58ln1wSfO9Yazlzt8NADffl/Z8j+
   q8cC57Rwjd73zhVF2iCdFFSccVRPBLJH+ZH6CarWB4DCx6WKRWKwgXT2T
   476Pbk6Ihcui3iYUJOpKrSWG7ruQvoAdxN5eoNBtUfebh9PcFH+qraQja
   A==;
IronPort-SDR: Uk5JK6ja+Je30dDT5b3hkK9bCRBhl9AiMNM0Dug8UimoETcXwr8FkG8pmA6NgT7cbaqVUq4mJX
 kQUzbs34euhdTqTeEik9WdgGd2fX7m52BEyGn6h3yKJWlZFmbcvpoW0duEZNPxMF0ZewQG79hA
 6wWnfopTqvdIfUysAEZoNZHIoYaZKD3l+3RitPHFJRevE88SleV098Fed/mUUcxI8YOSB+TKwh
 kBD55mbXXSRiBlnC5awU2e4OjhLvBcY7/VkrSCBmR5swkl1BzC61LkdLQXitSonKMgGKmvyL6v
 JUE=
X-IronPort-AV: E=Sophos;i="5.73,476,1583190000"; 
   d="scan'208";a="9267808"
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [master][dunfell] prserv/serv: Avoid exception with newer versions of Python
Date: Fri, 5 Jun 2020 17:49:15 +0200
Message-ID: <20200605154915.26496-1-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Return-Path: pkj@axis.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The following exception was received when doing `devtool modify ...`:

  Exception: ModuleNotFoundError: No module named '_sysconfigdata'

This was previously partially solved in OE-Core, in commit 4b26eaf7
(prservice.py: fix do_package with newer Python in Ubuntu
20.04). However, that only solved the problem for some cases where
prserv was imported. This should solve if for all of them.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/prserv/serv.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bitbake/lib/prserv/serv.py b/bitbake/lib/prserv/serv.py
index 25dcf8a0ee..48f4b5b05d 100644
--- a/bitbake/lib/prserv/serv.py
+++ b/bitbake/lib/prserv/serv.py
@@ -2,6 +2,12 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
 
+# Make sure _PYTHON_SYSCONFIGDATA_NAME is not set in the environment, which may
+# happen for recipes that, e.g., inherit python3native, which sets it. Otherwise
+# importing from xmlrpc.server fails with "No module named '_sysconfigdata'"
+if '_PYTHON_SYSCONFIGDATA_NAME' in os.environ:
+    del os.environ['_PYTHON_SYSCONFIGDATA_NAME']
+
 import os,sys,logging
 import signal, time
 from xmlrpc.server import SimpleXMLRPCServer, SimpleXMLRPCRequestHandler
