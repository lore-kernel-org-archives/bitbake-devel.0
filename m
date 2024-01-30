Return-Path: <joe.slater@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986B6C46CD2
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 22:02:24 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.141.1706652135120001382
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Jan 2024 14:02:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=and3fmZb;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=27595d2623=joe.slater@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40U6cv3l001106
	for <bitbake-devel@lists.openembedded.org>; Tue, 30 Jan 2024 14:02:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PPS06212021; bh=AAQmM
	TR980Muq3c/s7HXvQxn/slXzP3dLoU4ACM5XlU=; b=and3fmZb+igUoVyr9r2Xa
	huEpKX/UTj29ySK24KLs/abWpAGx2RyGYrE348nsiYm3RXj6qYUOnm4qViYPv8ih
	H/ODr2mDvLNMbbbL06N4rZhPFwO4BKaFsHem6LyLbuV0qTE/4rbTZUezUlNZwShv
	mlflX5dKUxAGRCAAuxb8UiwXnhCnFSTVDBvYtFd1Ldd+3y14ijj9rI8nhBqFQWnz
	2OWsRFlnCcJoCNTIZ/+8i7uskhXKHzloJhqkn0ZQCDKcWQ4z9kfCe5u0EL2sbcPN
	0hitooHCNFKQVKgmyv8qMyijo7FeEE/lF72hfDrHEghCliRZMQFH/oi/aFwt6PKT
	Q==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vw27ku1eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 30 Jan 2024 14:02:14 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 14:02:18 -0800
Received: from ala-jslater-lx2.corp.ad.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 14:02:18 -0800
From: <joe.slater@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <joe.slater@windriver.com>, <randy.macleod@windriver.com>
Subject: [v2][bitbake][PATCH 1/1] utils.py: add var_in_numeric_range()
Date: Tue, 30 Jan 2024 14:02:13 -0800
Message-ID: <20240130220213.3124647-1-joe.slater@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: JjFJkPCnNl9YAAiqxvMwRx42V9oVPGMw
X-Proofpoint-ORIG-GUID: JjFJkPCnNl9YAAiqxvMwRx42V9oVPGMw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_12,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 mlxlogscore=722 mlxscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300165
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Jan 2024 22:02:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15811

From: Joe Slater <joe.slater@windriver.com>

Add a function returning a value based on whether a
bitbake variable is in a numeric range.

Signed-off-by: Joe Slater <joe.slater@windriver.com>
---
 lib/bb/utils.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 068b631c9..8bb2d5d2d 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1810,6 +1810,17 @@ def is_local_uid(uid=''):
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


