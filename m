Return-Path: <joe.slater@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817BEC47DAF
	for <webhook@archiver.kernel.org>; Thu, 18 Jan 2024 17:38:26 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.19645.1705599503997715171
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jan 2024 09:38:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=nFeWMAyY;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=1747397340=joe.slater@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40I6fBYJ023396
	for <bitbake-devel@lists.openembedded.org>; Thu, 18 Jan 2024 17:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PPS06212021; bh=e/LFV
	0YgcZ1EmA0dDjp7s8G+tYzGijLMbgHxMUshgQk=; b=nFeWMAyYjV2Hyd9YJHc2u
	QOv0z4E5jwJq7DaCG1DYekHbgQ6LUiGy2TAOjWHZ+fMEVsDuc8ioxItCS9qA9BgS
	8+ms/IjcljQ0W3ZRE8i7wW1Y9lhuNdFSTAnJWoIal/PXf7eW7BdaONxNk2FwhBcv
	zcpnatcjtr5a4Pm+TcXjfDkBQiiBPakxjiy88m85lKLKxPW0E/RFUlio9egA8tOZ
	ShhHfeAmiAMwROelI7wrIq7s9TDkG9GaDI+29SJVp2wn6FQzny66HuRGhinxeZ9b
	DtPLchlgm1J3A7BNyvSuIJ0qWRbrK9HsQOlf5raOQKh3TGTXshrxzdQWmVVKc0zd
	w==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vkhg661wj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 18 Jan 2024 17:38:22 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 09:38:32 -0800
Received: from ala-jslater-lx2.corp.ad.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 09:38:32 -0800
From: <joe.slater@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <joe.slater@windriver.com>, <randy.macleod@windriver.com>
Subject: [bitbake][PATCH 1/1] utils.py: add ifVarInRange()
Date: Thu, 18 Jan 2024 09:38:21 -0800
Message-ID: <20240118173821.1579936-1-joe.slater@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Uk_wNvpXk6IqMkpjM06-1eKcBXE_DCMC
X-Proofpoint-GUID: Uk_wNvpXk6IqMkpjM06-1eKcBXE_DCMC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-18_08,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxlogscore=678
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1011
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401180127
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 18 Jan 2024 17:38:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15796

From: Joe Slater <joe.slater@windriver.com>

Add a function returning a value based on whether a
bitbake variable is in a numeric range.

Signed-off-by: Joe Slater <joe.slater@windriver.com>
---
 lib/bb/utils.py | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 068b631c..76f08623 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -1810,6 +1810,17 @@ def is_local_uid(uid=''):
                 return True
     return False
 
+def ifVarInRange(d, var, first=1, last=0, tval="", fval=""):
+    """
+    Return a value depending on whether a bitbake variable is in a numeric
+    range.  Conventionally, 0 as the emd pf the range matches all values.
+    """
+    try:
+        v = int(d.getVar(var))
+    except:
+        return fval
+    return tval if v >= first and (v <= last or last == 0) else fval
+
 def mkstemp(suffix=None, prefix=None, dir=None, text=False):
     """
     Generates a unique filename, independent of time.
-- 
2.25.1


