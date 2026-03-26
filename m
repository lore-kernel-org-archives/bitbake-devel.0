Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD8410AB807
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 18:57:57 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.55635.1774551470450845025
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 11:57:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=mTGH8ka4;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75450e5aee=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFhRcP3113430;
	Thu, 26 Mar 2026 18:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=CeOCCyeiSsdjgQh4EeKuCplz3Ls3BsYnPB+bupfzfaw=; b=
	mTGH8ka4lFkLepaTrxDP1dXtIGw4nnLogv1vL0VgzNokBo1yo1kAh76QmDSK3PZW
	Dkva/8y9DZoXKyFL7WxhNj0bWgPFjMm6vnKE1Qc8iDkgWmm7ziaippdESR36cfA0
	oO6fe7DQHkH9VCQQ+BIOKRbW72JHDZqRIeXuVGyqcxSYeapWcfaYXalY2x6xXxgc
	v21nFlZ5pnbTFJ5g/2lD8jl1lSEWwh15io7TyMhwlnf9yFE1WSeykEHYPiuLUt7g
	8dp9tF2VfSJJr0U9xQbSmyvb8kFDIl+8tGjHP+GbwUYUNQ/vUZCye+v5U3u6tely
	d+BP4eifxtSNnoiFUvDMXQ==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj872bp-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Mar 2026 18:57:48 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 26 Mar 2026 11:57:44 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 26 Mar 2026 11:57:44 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>
Subject: [PATCH 08/11] bitbake-setup: Fix linting error related to membership
Date: Thu, 26 Mar 2026 11:57:39 -0700
Message-ID: <20260326185742.542268-9-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326185742.542268-1-rob.woolley@windriver.com>
References: <20260326185742.542268-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bubFR2OyQuAms0JrvCRkNOEYyhjeWFs1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzNiBTYWx0ZWRfX3zBR22EmcXoG
 aaLV4Up4s4lusN4oSzCrK7Be56w72Z+8pTK4WR5ClKybQYMhQrBQve1byibFk+X2BN9ONEAqL6W
 6LnYH3SPtL/jmOVT0td7SJM5TUxx9PwmH/gUp7Sx6IuyQcZVhQjGDBsSOKILeh0k/DlszwLmTYO
 XzJRl4sBSLM7NPZCPAnUlIzBl+p9cqrYY3OCnHlJ+XkulxVr5EcSDg7TuHQx/602X06sAFMg3fO
 19j/H6r4ocEWkynQEHKGSYvCbP0MYl2lYR7tBsm2iaM4dSmD5W5pQlmEw6D1v34LT+sgl4c2mgk
 mKd69Wq0un1zoz1pBaClVmzrDPkDmzrVYG88dTMfQe0N0rcKYVGeXdai10svFW70gDqm9xCALAR
 AtSAGSppQNdJQIAwaM7kBRNQLGwzSBHbtH+9+ZB2ShoA0kClHm/YdFhNC+YpqX/4g9+SfS48HaE
 sNrDm22U6elNfORIMcA==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c581ac cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=46D1iXCj2PQgXVORjeQA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: bubFR2OyQuAms0JrvCRkNOEYyhjeWFs1
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19253

The pycodestyle E713 recommends that negative tests for membership
use `foo not in bar` instead of `not foo in bar`.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 7cc3f9253..e2b2f1836 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -154,7 +154,7 @@ def add_unique_timestamp_to_path(path):
 def _get_remotes(r_remote):
     remotes = []
 
-    if not 'remotes' in r_remote and not 'uri' in r_remote:
+    if 'remotes' not in r_remote and 'uri' not in r_remote:
         raise Exception("Expected key(s): 'remotes', 'uri'")
 
     if 'remotes' in r_remote:
-- 
2.39.5


