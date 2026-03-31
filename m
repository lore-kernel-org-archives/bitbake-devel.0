Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB04109B489
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 14:53:33 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22114.1774968808601023264
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2026 07:53:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=PEqgHTwS;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=85502649bd=rob.woolley@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V4w3DB274792;
	Tue, 31 Mar 2026 14:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=hZ0vSibT4yXa8xE8eqe219UrsfmVHoUvbrMpoONcMRg=; b=
	PEqgHTwSDt3MIy3h+BZflFfoX+38S20vmhwxui41z4CdmSdwXhnlMZ5/HwmZY7IY
	FXqJZU6wmxFWro1a1LmXc49MgGSrCEdrMy/S4OVxmFcQvz066zWTOPqloPFz3Kug
	2qOXRaIFWtaZpS4YRAhu6sjJ9GV27ebKWIWid0qdR/7KTuJkOKDKhM8O1G6Ieij5
	rm9Tx/82O0RR7/jmQwO/erwN2qkYht9jEp+RYTOKvdyWxklpq8gCpUfSLTfdBImC
	gllNXcT0W2yEOwizmgaoIxK7WwOHgPreUoobDkq5pOMkecrNwRk7Dsqu9fm+32c9
	oHoeBUO0PnRjM/O/zUDOlQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d65y4btqq-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 31 Mar 2026 14:53:27 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 31 Mar 2026 07:53:20 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 31 Mar 2026 07:53:20 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>
Subject: [PATCH 6/6] bb: Move codegen.py inside module
Date: Tue, 31 Mar 2026 07:53:19 -0700
Message-ID: <20260331145319.3125456-7-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260331145319.3125456-1-rob.woolley@windriver.com>
References: <20260331145319.3125456-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=QaZrf8bv c=1 sm=1 tr=0 ts=69cbdfe7 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8 a=s_keFEVr-WujLWSdrMAA:9
 a=zZCYzV9kfG8A:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE0NCBTYWx0ZWRfXzCg53Ipf8G0I
 tYd2PQ3iKMsDYK+9XU3TsB8TqL7GbA4++QXRVImiusI5HmArPfG+v1mncG890boE9T/672DsTS/
 KCpx9kIxCoSS+ZvueFbf5q8Amw58DssAWsYb/Zu/zmE3Lw69FeA31uRc0X6KrTJbYXmRn+uMwot
 QUwdr8IcugtSgPEVcP4nOo4VIC2q0ESGyumEMa2F3Bek3Zb2TcqlgKrRCYbidPQIhj6CRNsdq9a
 V23HWb1UGUwu3sNLenQFsWi4bnRRK/AJ2wadii3BhJC3HbhtKmazQY7kWeSDR2fYNW+CY41oFsv
 elyr1bnyE5q6wIhN5/SgBbieGFAmgc8HQdpHnqZWppVq/K0+YC1ESjtSzYj96+wk8qMOMAqXFz8
 v2w2U3A/u8uVemD8TQR9qpb+X2HvVTGllzOyWVio5J2qOq+qeHo1j6QEcg52vYzFS55weXq1L7b
 mK8SykN90pkfUgwtPVA==
X-Proofpoint-GUID: HhVnSE1GD1T0X6FdkNned2S6oqMCT09x
X-Proofpoint-ORIG-GUID: HhVnSE1GD1T0X6FdkNned2S6oqMCT09x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310144
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2026 14:53:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19298

Codegen is used exclusively by bb.codeparser.PythonParser.

Move it inside the bb module to avoid exposing it externally
when installing bb as a package.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 lib/{ => bb}/codegen.py | 0
 lib/bb/codeparser.py    | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename lib/{ => bb}/codegen.py (100%)

diff --git a/lib/codegen.py b/lib/bb/codegen.py
similarity index 100%
rename from lib/codegen.py
rename to lib/bb/codegen.py
diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 4f70cf7f..76e4eea2 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -25,9 +25,9 @@ recipe caches don't trigger "Taskhash mismatch" errors.
 
 import ast
 import sys
-import codegen
 import logging
 import inspect
+import bb.codegen
 import bb.pysh as pysh
 import bb.utils, bb.data
 import hashlib
-- 
2.49.0


