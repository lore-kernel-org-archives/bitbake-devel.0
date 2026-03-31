Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F4110F92E7
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 16:07:18 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24325.1774973230896395242
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2026 09:07:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=cJ750TsX;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=85502649bd=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V6nv8U2249206;
	Tue, 31 Mar 2026 16:07:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=89SxVKN82X8uZvIAiDbuPOopuGkicbdujUVkyBZNDT8=; b=
	cJ750TsX1OlasTc7iDHenjHGntP8vTA32ZzEEUB8kOvx2djLvgwsfpnFD9x6Mn8C
	LKFkSut8uIqObzlFAQLnPP6XZsuL4Ti5RM2rl4OMs0STStN3GpVYLoCkVLmMn0+V
	sLD8f3YxtOxCSXWTDXlGEsDCpXWU5j0gB8EzjBKIUGU62j3xNTOnCmnz/cgHtLDK
	cz1jKw6tAxZwKL1SstFZ2CODH1yAva7QOJjwF+mDB/njLpXDBhSZ9bZBrmB/8vRJ
	h1zVSm5IWOT6Adf3Mo7d7aSsiEqcC9CQOT3hoqNC5xSbM+mi2Md/nKExhFzbWOj+
	RzXVODAjQKE4Uza4YpfODQ==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d646vuyv2-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 31 Mar 2026 16:07:09 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 31 Mar 2026 09:07:05 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 31 Mar 2026 09:07:06 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>
Subject: [PATCH v2 13/13] bb: Move codegen.py inside module
Date: Tue, 31 Mar 2026 09:07:03 -0700
Message-ID: <20260331160703.3137930-14-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260331160703.3137930-1-rob.woolley@windriver.com>
References: <20260331160703.3137930-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Zqjg6t7G c=1 sm=1 tr=0 ts=69cbf12d cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=s_keFEVr-WujLWSdrMAA:9
 a=zZCYzV9kfG8A:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: tukVcSXg54sPcoZfHAJk0c40mXWySR7X
X-Proofpoint-GUID: tukVcSXg54sPcoZfHAJk0c40mXWySR7X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE1NCBTYWx0ZWRfXx+wZoGPnF0jv
 gsMo9Z+vnf+HNlsbnPE7uojHK/w5QfHieRD7LCPSgdf1WDvNwAlhHuXWGIhW+AI5PGDi97XPC5O
 H3X768FeXEWEt31A2h/nSRNUCBLfh+y3+PC/biwKFjKs6TUuwLANAEygihs+nky+pJjFpm2Fm14
 UONCG8bafdqQQa8Xg46YnDiamz/a8SwCq/vm75qM+8nJ3zAiVyvPwvCObRRf4Bjd2kOJOGcL2v4
 iqKaEFeMgDzKIULgo8ymQNBbAGLLef38XO+VviO4vAW3vy9tykADNWsoV65vlQzbFDQVmwNcXS2
 I1Ho2IL6ZgKAwerYElthh26dVyUqpEZ62cXrCcUq9DgZ+EB+FjGK6lAr3esCX9YBimd8caHXuhR
 N9otOSg+tsm2lb88eka7xAefejMVB4ovgvPsTozF1uqjxOMxUVj23IdaPgkUFvgIqeQOvuuIVSG
 pP7TU8KbD921+pR++ig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310154
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2026 16:07:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19312

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
index 4f70cf7fe..76e4eea2e 100644
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


