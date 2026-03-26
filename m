Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B207A10AB816
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 18:57:57 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.55632.1774551468639780572
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 11:57:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=FNn4A+hH;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75450e5aee=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFhRcN3113430;
	Thu, 26 Mar 2026 18:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=8rMcHtTRmWJ/T4T0x6TCTN8QRjujNf9EzVMjcimJHNo=; b=
	FNn4A+hH256w2r5JRqYyBpVRpxyMm46YiV3QcYcq0hVdhMurwY4ivUwqfQ4LVXr4
	Xw7vqYuQCTcEK4iNFGTUg0e2eJkq6ZW/bQ6azihqq9E4lE80mfhGP2hWEVZ6lnp3
	wIGQXWuFGF+LNqlfdNTQLGktKCYw+TKtYOyntfylWX+EfVYFSuYHMKl0hkDJuWDV
	D9D3vFfmn1BgY5h1267XSJj7nUQoHnVjJ71DGDKozk98pWkq49tp/fmjgoXRMEC9
	wpuCMR2aqJJtPAbnsYVHHeSgoKNKfFRaCb4Aig6MMzuv/eyt9TpK1sn90i9FW+uo
	Fj3jPfX24P/8OyhKjem/jw==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj872bp-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Mar 2026 18:57:47 +0000 (GMT)
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
Subject: [PATCH 06/11] bitbake-setup: Remove unused Namespace import
Date: Thu, 26 Mar 2026 11:57:37 -0700
Message-ID: <20260326185742.542268-7-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326185742.542268-1-rob.woolley@windriver.com>
References: <20260326185742.542268-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 6cHna1GBimL3DJRNv_NtNmciGG-RLitR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzNiBTYWx0ZWRfXz8BLKRcE8+cB
 uFku+BbSJTZhHD5qYLnIEWJMOVnQ8mTBHyEV8df0MB+N6Zi915HLz09hXWAD3MWa8/SCBmDH5UH
 bBZZfxHxM7KU0w9dyCHcwV2Jq+kbMHuEJVPwWRG7Zx0gn4t9bY0CABNqZUhK6MpIhAyYG8qN7xZ
 Y924Gwxh7MEaedKlhk+9odGKGO6oY4WwuiMHpc8N9xRhoSlFDLIxp3qxFhmfM+w313KfsceoJ+1
 LhBiuWMkdx4wRKiv6ubF4dwpm3O1zmTK9jHWfTcOznljOl4sUtINtGLVqAxXtE7hMQsekSCV2kQ
 GJjZYQq4tDmi+pElfvMK8Y/12oWo6ESFLLMiuakEI6surhaef0Lak6y8t7+qIm18EtGJf24wM5M
 lC2j/Im2I4Ihb2Otq/ftMGhoCq55Lr/Ka+it9/vOObZLGtcSYcwk5ad4dPk+s9yJ1io0JNlgLfs
 vF5qQQHsZCXzjK9PACw==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c581ab cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=wf95bx_M_9xtc5-G3zUA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 6cHna1GBimL3DJRNv_NtNmciGG-RLitR
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19251

The ruff lint tool reported that Namespace was not used:

    F401 `argparse.Namespace` imported but unused

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 1 -
 1 file changed, 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 08d9a8d09..00be16438 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -1186,7 +1186,6 @@ def main():
 
         save_bb_cache()
     else:
-        from argparse import Namespace
         parser.print_help()
 
 main()
-- 
2.39.5


