Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBAC109B483
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 14:53:32 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22111.1774968806728137434
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2026 07:53:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=XJ+wPAI1;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=85502649bd=rob.woolley@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V4w3D9274792;
	Tue, 31 Mar 2026 14:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=aN+51oGesFcQGK4KG1xxQi0m3ns9ePeHgNSPKA6K/kY=; b=
	XJ+wPAI1RovKfHpHwbIsSuMu91RCTmgknjLhFp671dLGSIoIt9QQ8m2bdT0ytFD8
	xy/ak+jX3ROU5CRUF8f2bgakykAyxo9C5fhHNv1/0nIQh9obwZPUPt2QGffILwV+
	b4na5fRd4laVtFIx8E8FFUHudt4WZVP12OLKOBg+9rmrZPrCOrkPBpSrxGIFq+cI
	VyW3o6pA5TYEJ1zQFt7KDQFtxh0xAydLa8tegwBfWii51j1G7M9/X5tGP0lQihyj
	ZDN3Fx+4KzGPvTURCHKR5OYqoKNyDOerfAlsCYwPyIGpmITIbECRA1xzy9V4dgxo
	SqglGERuMg8bMFTKa9OvaA==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d65y4btqq-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 31 Mar 2026 14:53:24 +0000 (GMT)
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
Subject: [PATCH 4/6] gitignore: Ignore temporary staging directory
Date: Tue, 31 Mar 2026 07:53:17 -0700
Message-ID: <20260331145319.3125456-5-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260331145319.3125456-1-rob.woolley@windriver.com>
References: <20260331145319.3125456-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=QaZrf8bv c=1 sm=1 tr=0 ts=69cbdfe4 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8 a=eOszy7m5RXGtjJtd4NEA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE0NCBTYWx0ZWRfX9ywx0AiXPM67
 vA3WKi/dD1IZ7eGbAc1J/G61CNgVZ31fW2rouP3yC7AuGyuoQjBs4s/xn+81uH+MwY9BnZ5nIaO
 BiVIo0cl49mQuo+dMO1pDXZL1KjhcaWXoSSXXA/+62CngHuu7H3ZwKQleITPoJyqfbG+EY3QpSQ
 f5OYaGxiUyP5W4aXoqJg8CqG8VJWUhVLicdcelPW6b5yds8MhsJJ4hoHTaOuXFpBFn5QRVCiNA5
 eLAT9T4bwZTOsGt4BSlLHbiV2/79NNWCexSW3pgFm3QZi4dxk5keAwjqMuIgBzMHDqVrEhYZc3Q
 mPysP3q9De8+s1iyUQUVtCyotVOcsgSoFPiAyRwVYumrkxoz98+0DhRBFwCxoPaGmne19nC3qJQ
 Aoolcu89aPmVQjQIYTpqjVdDtHonyaaODF7DV0z7p4mZBCB0LfEFd9a7zut/yZKHFHSX0U4i65Q
 8u5bmr8lrinNmMYQG6Q==
X-Proofpoint-GUID: DWJptpe2yq8iqWUv2k57E05gKJjqeuGw
X-Proofpoint-ORIG-GUID: DWJptpe2yq8iqWUv2k57E05gKJjqeuGw
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
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2026 14:53:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19296

This directory gets created automatically by package-bitbake-setup.py
when packaging bitbake-setup for PyPI.

It is a temporary staging directory and should not be added to git.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index a6a256b2..9a5c4ec4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -17,3 +17,4 @@ lib/toaster/contrib/tts/backlog.txt
 lib/toaster/contrib/tts/log/*
 lib/toaster/contrib/tts/.cache/*
 lib/bb/tests/runqueue-tests/bitbake-cookerdaemon.log
+packaging_workspace/
-- 
2.49.0


