Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B1410AB80C
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 18:57:57 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.55637.1774551471337215134
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 11:57:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=BxFJsuIs;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75450e5aee=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFhRcS3113430;
	Thu, 26 Mar 2026 18:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=pRZF5kGFJwDzXrslHoBSM9IChHph+t7fkfXJW695n8Y=; b=
	BxFJsuIsCFei+A8X5r/X//LGwHPr2MBGf77GcNTKiTl7T+ZU6zqmjbwG4IAOO54g
	Rmee/osUr5S3RQgGET2bBmUxqAmpy+hv16MMSJL5oE4PsOzGS+0VbRKkr+N1BjkG
	PFyVC+3PzJEYRtHFsylsMOpZfOWP4RhePtjx5KxrW43sGBz8lhgClP8+8t5sVJIA
	8XlipGiYWPpjc3b7zjhKsEcuXy2QYYTHW1n4WwQOjWSG9UcfFoFN3epovQLMRuol
	FNKKqyPGKkwVjV3I+XDymIYCmL4yNfNs+41sx0uPjltHiM+Un+GUxavVMU1/ypYW
	S7MN7lafMsTr8ZrsJLeCCw==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj872bp-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Mar 2026 18:57:49 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 26 Mar 2026 11:57:45 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 26 Mar 2026 11:57:45 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>
Subject: [PATCH 10/11] bitbake-setup: Set function default to None
Date: Thu, 26 Mar 2026 11:57:41 -0700
Message-ID: <20260326185742.542268-11-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326185742.542268-1-rob.woolley@windriver.com>
References: <20260326185742.542268-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ctOeRJtt6Vvh2ThDEELSvrm0O7iHnX5_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzNiBTYWx0ZWRfX0WF1XDCmqTKv
 K69Dip3yWxalrHYkG+7VVOgbZUloTh61QUy+GmaEsWP2OOqpXWcos+8kewFCJ01ODWzAaX8dXM1
 K0MLHCXDH+PE5UAZHR0eRXJQCTR0VHnQH2LZd/4aJojQMpjbGTZamz4R2diUsN7ZIoaP9uJYj7w
 nbJDCDqkZrEJYAzjnfaqzNKILGPz6G0ZnWDOCi/GyJeChTS6hvdLTGEh07br7h3tUWFnx3tKncP
 glwEAgGyvAJPgsxFPHNnUjuD0gPozv2txLKzX37HPWkkVHRwM5G0ohtIw/JoWcdKOLi82T0cWsq
 JAEG/Sxct01L69CpOcttUhb6CW4ia2kgPok8P6DeBV/NMxGj0d6u0nCl219WXx+kl00xOybRG9I
 uEePI2oBatZ7tIHABjCmROEb30ydOg6eSrLINUL26by9+VYMI6VuhRhcSHOrtDulXYLXEh2GlOs
 Yroyhl1H0CWZPu6Lcyg==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c581ad cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=aZRFCHUu4cexEaU8piMA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: ctOeRJtt6Vvh2ThDEELSvrm0O7iHnX5_
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
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 18:57:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19255

The function defaults are evaluated once and use across calls
can lead to unexpected behaviour.

Set the value to none and let the function initialize the value
in the case when the value is not set.

Resolves B006 from flake8-bugbear

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 2e1e347d6..6b210cd3e 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -45,7 +45,7 @@ def color_enabled() -> bool:
 def get_diff_color_param() -> str:
     return "--color=always" if color_enabled() else "--color=never"
 
-def print_configs(prompt: str, choices: list[str], descriptions: list[str] = []):
+def print_configs(prompt: str, choices: list[str], descriptions: list[str] = None):
     """
     Helper function to print a list of choices and align the output.
     Each option name is made bold to stand out, unless color is not enabled in
-- 
2.39.5


