Return-Path: <joe.slater@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14705C47DDB
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 21:56:59 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.9307.1706651809840735668
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Jan 2024 13:56:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=o2FrD1dL;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=27595d2623=joe.slater@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UIt0nw001079
	for <bitbake-devel@lists.openembedded.org>; Tue, 30 Jan 2024 13:56:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PPS06212021; bh=m2+Sb
	HHr7NXoGFb7ur30HHlVcyEcCJXYsii25PEK5qA=; b=o2FrD1dLe2WJQTUCv2Dkb
	RJKStiY/aaGlNjGVWvMGjiY/NTXJKDkmQW32puCws6B/NQV5q92yT1EmYim3agJ2
	Sm5jVHy0wMItYN+DoJHHOlmQH6ZFLfMXukN+OsO2wITV6McGOuizk6PLExMlltWA
	vqzBEZ0yi5AHPrZqRNwb4K5ml0U73PbH7UnsnXb76SynvfyU2AeW6fTku8d1MQOU
	+Uxb2L41VsF/1StldFqS5h0XBf/xdlfUmp+eEjHiBoTWMKV3O0fEMXC/1KSEjlH7
	hZ/m5eQ1AfxFFKkVXBPKqMx20vkXyjFpCfi1fTJYLQACE4o3NXPsASOUYvEi3khZ
	A==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vw27ku19e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 30 Jan 2024 13:56:49 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 13:56:52 -0800
Received: from ala-jslater-lx2.corp.ad.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 13:56:52 -0800
From: <joe.slater@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <joe.slater@windriver.com>, <randy.macleod@windriver.com>
Subject: [bitbake][PATCH 1/1] utils.py: add var_in_numeric_range()
Date: Tue, 30 Jan 2024 13:56:48 -0800
Message-ID: <20240130215648.3115416-1-joe.slater@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: VQqoe7SciEj4viRC5IMzNfGGaAyRNdCU
X-Proofpoint-ORIG-GUID: VQqoe7SciEj4viRC5IMzNfGGaAyRNdCU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_12,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=772 mlxscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300164
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Jan 2024 21:56:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15809

From: Joe Slater <joe.slater@windriver.com>

Add a function returning a value based on whether a
bitbake variable is in a numeric range.

Issue: LINUXEXEC-29701

(LOCAL REV: NOT UPSTREAM) - sent to bitbake/master

Signed-off-by: Joe Slater <joe.slater@windriver.com>
---
 lib/bb/utils.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 3f7f82d17..04b406ab1 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1780,6 +1780,17 @@ def is_local_uid(uid=''):
                 return True
     return False
 
+def var_in_numeric_range(d, var, first=1, last=0, truevalue="", falsevalue=""):
+    """
+    Return a value depending on whether a bitbake variable is in a numeric
+    range.  Conventionally, 0 as the end of the range matches all values.
+    """
+    try:
+        v = int(d.getVar(var))
+    except:
+        return falsevalue
+    return truevalue if v >= first and (v <= last or last == 0) else falsevalue
+
 def mkstemp(suffix=None, prefix=None, dir=None, text=False):
     """
     Generates a unique filename, independent of time.
-- 
2.25.1


