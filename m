Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE0E10AB805
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 18:57:47 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.55625.1774551465862197426
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 11:57:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=U7wVwNL2;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75450e5aee=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFhRcH3113430;
	Thu, 26 Mar 2026 18:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=0uDM6SD75
	yD3iKBMuRirqlDuBHMHrXyJ4x5a3us0BGM=; b=U7wVwNL2VZGzhHFUKWFHisrGs
	jw3RHH9KA6ocwj85RTO0ZIpGzVI8mVBTulsk5nn/DQzVXAdEu4p8C/cLYEK+GIE4
	vKI9aWdIHcBiGY0LXPkQ5Gx4UN6TXogK2g/exCddnEyM3WpGjkrYjiD0d9t80cQo
	QcbBPC/YjgbvNii2txL2XwpYHZ5PWQ9xyz298pckodaCQSm9UX+rOsJ3PlcSGkzG
	ArM8g0ZKWcI8d0134nMw8qWGLwFYeHkdFtzPSgQMDi8rlwvX30XL+6Lq6CmPgx9g
	0QmROBMC0fCPHAW20cO8Cwp7ugFnQ77A2vs+ZGwbYw4FuIm25meU9H42y2DtQ==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj872bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Mar 2026 18:57:44 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 26 Mar 2026 11:57:42 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 26 Mar 2026 11:57:42 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>
Subject: BitBake Linting Errors
Date: Thu, 26 Mar 2026 11:57:31 -0700
Message-ID: <20260326185742.542268-1-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: shP5wbkz5YcFk4nrS3tLYwR1Bx-nCY_x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzNiBTYWx0ZWRfX+/3yxm3r/tx6
 vx3t4xSX2V0rfUVlnoJhsN9IJqfuTNSRKCGgc2NDcKEiWd8gLVw2BvUQiSOdqYmltVfOftGav4D
 OSG73bEdFfDxcZjDHWCY0P1a5FC9UObALLHA1bzXskEohipMM8BxW+NshQbfLWuqy9pHmz1wGxV
 i1+rfiMU2/dFoxQsNuciQ8uN05CIwkIyZkpdOoZLSbM+TBOsk42+YNas3Irf/UzYPti/1t9A3Sd
 7gigjmARdV5Buv9ZC2/qGaKzaQl2lXrnHM5qk4mUN1Jilm5s/RiN56gzWmtpV4w4HRh2PGePZM6
 DAU3ZW84QNpQk+a2GY21xUCgdECDt+trVFAxgfoj9DcqAct+TeDpmA/H13GnZTvdWB4Jvj17ITi
 UwS0xqd4UbQLroeHE72g8J30G6hEW2OXLduDnsYhjSx7V8xxMfSO4uou+Y++1AwaezwGdntSppc
 w4qa9GXxvRWWl6+YazA==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c581a8 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=dqah1FQsXnk2Ss3SCjIA:9
X-Proofpoint-GUID: shP5wbkz5YcFk4nrS3tLYwR1Bx-nCY_x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260136
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 18:57:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19245

Using the ruff tool on bitbake-setup reports a number of linting errors.

This patch series resolves those errors to give bitbake-setup a clean bill
of health:
    bitbake-setup: Remove extraneous variable from
    bitbake-setup: Resolve unused loop control variables
    bitbake-setup: Fix ambiguous variable names
    bitbake-setup: Remove unused stdout variable
    bitbake-setup: Replace f-string without placeholders
    bitbake-setup: Remove unused Namespace import
    bitbake-setup: Remove unused parser_settings_list
    bitbake-setup: Fix linting error related to membership
    bitbake-setup: Maintain exception chain
    bitbake-setup: Set function default to None
    bitbake-setup: Sort and format imports
    bitbake-setup: Remove extraneous variable from
    bitbake-setup: Resolve unused loop control variables
    bitbake-setup: Fix ambiguous variable names
    bitbake-setup: Remove unused stdout variable
    bitbake-setup: Replace f-string without placeholders
    bitbake-setup: Remove unused Namespace import
    bitbake-setup: Remove unused parser_settings_list
    bitbake-setup: Fix linting error related to membership
    bitbake-setup: Maintain exception chain
    bitbake-setup: Set function default to None
    bitbake-setup: Sort and format imports

