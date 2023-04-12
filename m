Return-Path: <mingli.yu@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBC4C7619A
	for <webhook@archiver.kernel.org>; Wed, 12 Apr 2023 07:32:56 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.37143.1681284767540314485
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Apr 2023 00:32:47 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3466d2cce5=mingli.yu@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C7WjJV019228;
	Wed, 12 Apr 2023 00:32:45 -0700
Received: from ala-exchng01.corp.ad.wrs.com (unknown-82-252.windriver.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3pu7snktsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 12 Apr 2023 00:32:45 -0700
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 00:32:44 -0700
Received: from pek-lpg-core2.wrs.com (128.224.153.41) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 00:32:43 -0700
From: <mingli.yu@eng.windriver.com>
To: <bitbake-devel@lists.openembedded.org>,
        <richard.purdie@linuxfoundation.org>, <frederic.martinsons@gmail.com>
Subject: [PATCH v2] event: add bb.event.ParseError
Date: Wed, 12 Apr 2023 15:32:42 +0800
Message-ID: <20230412073242.3735050-1-mingli.yu@eng.windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: lBZlrnzx3WlPCZ8zmX20wd-TWcimyHuk
X-Proofpoint-ORIG-GUID: lBZlrnzx3WlPCZ8zmX20wd-TWcimyHuk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_02,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120068
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Apr 2023 07:32:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14697

From: Mingli Yu <mingli.yu@windriver.com>

Add bb.event.ParseError to let error-report can catch this kind of error.

Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
---
 lib/bb/cooker.py | 5 +++--
 lib/bb/event.py  | 8 ++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 1797a1d4..c8ff3ce0 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -2223,7 +2223,7 @@ class CookerParser(object):
 
             self.results = itertools.chain(self.results, self.parse_generator())
 
-    def shutdown(self, clean=True):
+    def shutdown(self, clean=True, eventmsg="Parsing halted due to errors"):
         if not self.toparse:
             return
         if self.haveshutdown:
@@ -2238,6 +2238,7 @@ class CookerParser(object):
 
             bb.event.fire(event, self.cfgdata)
         else:
+            bb.event.fire(bb.event.ParseError(eventmsg), self.cfgdata)
             bb.error("Parsing halted due to errors, see error messages above")
 
         # Cleanup the queue before call process.join(), otherwise there might be
@@ -2355,7 +2356,7 @@ class CookerParser(object):
         except bb.parse.ParseError as exc:
             self.error += 1
             logger.error(str(exc))
-            self.shutdown(clean=False)
+            self.shutdown(clean=False, eventmsg=str(exc))
             return False
         except bb.data_smart.ExpansionError as exc:
             self.error += 1
diff --git a/lib/bb/event.py b/lib/bb/event.py
index 37cc630c..0d0e0a68 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -856,3 +856,11 @@ class FindSigInfoResult(Event):
     def __init__(self, result):
         Event.__init__(self)
         self.result = result
+
+class ParseError(Event):
+    """
+    Event to indicate parse failed
+    """
+    def __init__(self, msg):
+        super().__init__()
+        self._msg = msg
-- 
2.25.1


