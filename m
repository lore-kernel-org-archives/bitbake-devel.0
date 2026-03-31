Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526EB10F92E6
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 16:07:18 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24323.1774973229696185800
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2026 09:07:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=k1UNo0g4;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=85502649bd=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V6nv8S2249206;
	Tue, 31 Mar 2026 16:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=MmlQEO3wOMbEOw5dgksO4ImhzwHPUEGpxvH0ZzgKuNY=; b=
	k1UNo0g4YyUrhe96419HIMvP9EVwHaMvNjXaVtgUodC189caXLNnJnUGuRaExqXy
	0dT/kyLdOlW35syL0CDnmTW7H/IiwNa3T5FftoC26SkB721yF2pafoB+5golTm7j
	DCtybxtU97XhZmSvWDtYc1GxYDiORMp3C7e/W7mVm5uY3ve0hxnhUqzOzeAuYmjE
	RswOD6Hcb6JTkh5PtqQYz7dAaR8lY3zdoyUgwlJ17p0VomRSauZ5g5O4T3rOEVlS
	c1vm4ASGnDYjSepwfCTXMg+V717LiuXL9mFAaFgqFYe0aVmLxIJmu5R7tCh4Ybcn
	237HQ2KjKV5TsKsHeKr/nA==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d646vuyv2-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 31 Mar 2026 16:07:08 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 31 Mar 2026 09:07:05 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 31 Mar 2026 09:07:05 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>
Subject: [PATCH v2 11/13] gitignore: Ignore temporary staging directory
Date: Tue, 31 Mar 2026 09:07:01 -0700
Message-ID: <20260331160703.3137930-12-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260331160703.3137930-1-rob.woolley@windriver.com>
References: <20260331160703.3137930-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Zqjg6t7G c=1 sm=1 tr=0 ts=69cbf12c cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=0vOpnHimbWeZp4raT20A:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: ysfWrnH0EySqedcMLfiO8mGQLKKjZ_ug
X-Proofpoint-GUID: ysfWrnH0EySqedcMLfiO8mGQLKKjZ_ug
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE1NCBTYWx0ZWRfX+HDLfZNQBdur
 SuikhkQLwyo8Vrv8gNjGWMyZBMKNSspnrPIMR+oCG6Tw0j2ys0ov95OQ7+lxREVtzJ9SDXbBmuR
 q34VWAFUu8biRZot31OMz7+HHNMb/c3lIE+6jotddPAmR87P5zokSympRX6/HIC65MDk8UcXVH1
 nIGXX+rJ9IUsU0NeqBfV7o9+6/lyTH1PJfb3g2al9MQS/Yld1xg6vbNZrvAErpxJ1aPQDBb2G4G
 TcBhJffOGHkhRbs56elu6OrneyB3kYnaq0h1TFQkxSrerIso/nk1UUSuYymRdEeBaA48isbBSEK
 vbEqL2vGRtJ4FR/KvjhJ0SuOhvO8SPSZi6ZgJrXpSgC1+ED8PGlK/DvT7RAZUCL/5d0bb39BfMt
 MBOrLuSHknFdMF+vvu6SEY+JcHbo5zRaM+bQnkfqKHuybV2KBFGqIVoEcXTfnAlajfPL1yv6rt+
 hjZFi/0FAlinTv7PIuA==
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19310

This directory gets created automatically by package-bitbake-setup.py
when packaging bitbake-setup for PyPI.

It is a temporary staging directory and should not be added to git.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index a6a256b2c..9a5c4ec49 100644
--- a/.gitignore
+++ b/.gitignore
@@ -17,3 +17,4 @@ lib/toaster/contrib/tts/backlog.txt
 lib/toaster/contrib/tts/log/*
 lib/toaster/contrib/tts/.cache/*
 lib/bb/tests/runqueue-tests/bitbake-cookerdaemon.log
+packaging_workspace/
-- 
2.49.0


