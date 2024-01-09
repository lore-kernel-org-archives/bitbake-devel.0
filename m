Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269A3C46CD2
	for <webhook@archiver.kernel.org>; Tue,  9 Jan 2024 07:45:39 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.11956.1704786336978408731
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Jan 2024 23:45:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=CpNBJ+fo;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=17384c4737=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4094jKH6030167
	for <bitbake-devel@lists.openembedded.org>; Tue, 9 Jan 2024 07:45:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=JWgG/P5+0FGGtjYuH7jyu5BFNUtAmFilKEvMKYKeseI=; b=
	CpNBJ+fofTD6B0yashk3jru3eimUmFpdy+XfbWRVskcttjCoaPbWDaFyIFlwyYhg
	2a3qY/XMwIWdBDcNsywxqnrID3dPX1LBPikZm1OMLc/bAnQeTjOt9Q3LEEXD3uKR
	69lmPwYhqKD7MGbfOEChZcDqJ2KK7qPXj7Rmf0ZLD97aoYFWxOJca/dZdBJcciP2
	AWcEhRPfVTjs2h8twZXHjGgOO538oNM38wQKy2zasDn7PGR91GSTavu3Z4LXOH0L
	rqegYbq65zb0mlgmvGEsyG1VFVso/pGucYxkx4E2sqDNAHwfEiKCO8r/8bHpxh8U
	f1rWyy1yjxvaeQjpSFL6kA==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vewekayw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 09 Jan 2024 07:45:35 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 23:46:09 -0800
Received: from ala-lpggp7.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 23:46:09 -0800
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v4 2/2] bitbake: tests/event: Add test_lineno_in_eventhandler
Date: Mon, 8 Jan 2024 23:45:34 -0800
Message-ID: <4034b4a24d9ac56b13163ba2decff83a5f41be7f.1704786173.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.35.5
In-Reply-To: <cover.1704786173.git.liezhi.yang@windriver.com>
References: <cover.1704786173.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: eL8a746oG5A0qHwzW_t6rVD_eopP-jpH
X-Proofpoint-ORIG-GUID: eL8a746oG5A0qHwzW_t6rVD_eopP-jpH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 mlxlogscore=977 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090058
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jan 2024 07:45:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15756

From: Robert Yang <liezhi.yang@windriver.com>

Add test_lineno_in_eventhandler to test lineno in eventhandler.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/tests/event.py | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/bitbake/lib/bb/tests/event.py b/bitbake/lib/bb/tests/event.py
index d959f2d95db..ef61891d302 100644
--- a/bitbake/lib/bb/tests/event.py
+++ b/bitbake/lib/bb/tests/event.py
@@ -13,6 +13,7 @@ import pickle
 import threading
 import time
 import unittest
+import tempfile
 from unittest.mock import Mock
 from unittest.mock import call
 
@@ -468,6 +469,8 @@ class EventClassesTest(unittest.TestCase):
 
     def setUp(self):
         bb.event.worker_pid = EventClassesTest._worker_pid
+        self.d = bb.data.init()
+        bb.parse.siggen = bb.siggen.init(self.d)
 
     def test_Event(self):
         """ Test the Event base class """
@@ -950,3 +953,24 @@ class EventClassesTest(unittest.TestCase):
         event = bb.event.FindSigInfoResult(result)
         self.assertEqual(event.result, result)
         self.assertEqual(event.pid, EventClassesTest._worker_pid)
+
+    def test_lineno_in_eventhandler(self):
+        # The error lineno is 5, not 4 since the first line is '\n'
+        error_line = """
+# Comment line1
+# Comment line2
+python test_lineno_in_eventhandler() {
+    This is an error line
+}
+addhandler test_lineno_in_eventhandler
+test_lineno_in_eventhandler[eventmask] = "bb.event.ConfigParsed"
+"""
+
+        with self.assertLogs() as logs:
+            f = tempfile.NamedTemporaryFile(suffix = '.bb')
+            f.write(bytes(error_line, "utf-8"))
+            f.flush()
+            d = bb.parse.handle(f.name, self.d)['']
+
+        output = "".join(logs.output)
+        self.assertTrue(" line 5\n" in output)
-- 
2.35.5


