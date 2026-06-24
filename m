Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476C5CDE008
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 17:20:32 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12746.1782321623492099853
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Jun 2026 10:20:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=lQ9HrlR4;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0635205cc7=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OEegxS2602576
	for <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 10:20:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=Dpm+W8rbb+hyIH5Vgsq7bK45VNPwAivdAzTDuAru60s=; b=
	lQ9HrlR4w+M7SC/mCNJlVT+9FdY/UfK4eB+fcT4nBoBVBTYLo9m402P+mibBp/ZD
	T0lx8nu3mMP9WQku9KlPdLhDbCTz2mgV9JOX6PaTrGrmQFaThxPt26YgdOmN3nWF
	yAwQD9Zu0ZhKYkq2oBIXiBi2oiItT/+x+p7i9hmWOehw2/nErY9iRhil1PGhpSEJ
	UYbFygIS9+a6sfinq+uPnAzPnxde+HjFl54QikiJ7vZa7SKTpF5npMylmGDRS+WO
	WsY1rNM8btu96ASwytIYmUikGuko692sDe1xYDX+Q5+SggDjt8RtdacBWqFPuMq/
	g4o38hKj+k/d0yXSK/ijXg==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eykj1jntn-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 10:20:22 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 24 Jun 2026 10:20:12 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 24 Jun 2026 10:20:12 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Wed, 24 Jun 2026 10:20:05 -0700
Subject: [PATCH v4 05/11] gitignore: Ignore temporary staging directory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260624-add-pypi-v8-v4-5-ff499f1fd5a5@windriver.com>
References: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
In-Reply-To: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfXzV3H7xN9abKj
 6K+u4qssDKO0AdkuQsIxMYYAJ8Rffa9xVXYme5Xz7YdMnS0HxY/QuI8SayH7NFIohL8cF9CxSo+
 +5BIZgBU7RSk4NOoMZptqazzf+iS43hgBVr6i2NvDbr0r+wLGSz6Y0Dpt84CN0eh45LHs6TvGSk
 7rw94I4XCHIa5zRAR6o/8prf2Ayo6Z6mQ3eFbvuD9Ybcdyv8HL5pno4CB3UobpIahPM7BtLxkrh
 3X1MpSq3eNigcu6soTF3lM/vdJi/2O2a9348iaA4eHLVyoONPU7qlPFHJ+ZPPhP2qmBLU2rM4n6
 wQ9CyyU+hC3czB4E4kkkPBYJ47d5XphhPRhPbALQLXsRcSaavAJOgSAMdFMNFwOqIBB88TWkgJg
 CtLERQlKsC+iQSOzHOV+qU5l/ehDXQ==
X-Proofpoint-ORIG-GUID: 3MuEA7INCaXWjcDNTJRrS0FbSYpdUVrO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfXySloqpIAA4IO
 OUBeXrw78EiZ5eTMDYFMPAAPD1LoCEB3qU0FVSUUzx7pEMDkRKyrObksw8Zop2Oj03q0HdMO1W0
 0w7rPTpG6I0WwD7FTQEmDk+Ckba/2V0La2mbCr+tvJ60kvRZ6Kya
X-Proofpoint-GUID: 3MuEA7INCaXWjcDNTJRrS0FbSYpdUVrO
X-Authority-Analysis: v=2.4 cv=JNILdcKb c=1 sm=1 tr=0 ts=6a3c11d6 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=0vOpnHimbWeZp4raT20A:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240145
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 17:20:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19772

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


