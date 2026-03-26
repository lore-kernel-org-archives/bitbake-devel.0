Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BDB10AB812
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 18:57:57 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.56450.1774551467556634840
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 11:57:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=RKNAmbB3;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75450e5aee=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFhRcL3113430;
	Thu, 26 Mar 2026 18:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=7dhn0Z5Jfy5+N8+qlC/oCAlEvIOQ8tii/VR+Zwds6q4=; b=
	RKNAmbB3rlTpvw6DyYwGQRJ7BEpq65/L9XwpBV0wdTDefJYfQL4cj//TVVd5W6ow
	/afQVUAERdma1RScqUiXE8nTWV7/H+xJa6hrBANjDUuZIRJq6YV+uALKrqHvRYY4
	DbW2MQD/W3HFHSvAR+8IpVWWeDi41jxtKtRYfnSseMv4EyIXqbd5OBFaovzaqJPi
	6Y8Xcok4P/4uri/nzaQSvz3O6RrF0CGOwQnFNsrnbWPoZhhF0uIQibEUr0+bknlg
	gjwJBSa2BZUx/R1k1TUqfvIBc1sLr0ehuGs5bboKuk47wNx1ZtPXLxidWbJ/LEaH
	yDabreOltGrAwUCcyXTdww==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj872bp-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Mar 2026 18:57:46 +0000 (GMT)
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
Subject: [PATCH 04/11] bitbake-setup: Remove unused stdout variable
Date: Thu, 26 Mar 2026 11:57:35 -0700
Message-ID: <20260326185742.542268-5-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326185742.542268-1-rob.woolley@windriver.com>
References: <20260326185742.542268-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xREXLFpNdgxuAeTuv_CnzeaonZVBMxjp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzNiBTYWx0ZWRfX1J+iJtolPtsj
 2PRWMRX+uVBUqhZO3TtEpe0Bt+BzDolmQJ19RTlvkAWl2uxhryWxwd8B/BZcM3MwL8571b6FI4q
 5LE1m7Xt5B406AqVWpMs0z9/UcwQVeMDh38SHWdeJJidWdpFMQgkWT/5wIR9pn3l85UO4I0PpYV
 NgcyMCfaF4gc4fpFDckPpO9haNCtA8GhNJRAd2lCCNirQNwx/vFG9YJJ0R/NKkk9fkoY/MAi/no
 PBmK/OS9lCnkbWxYLDptW7vWiwCLZ+5y2Ub7e+GFoTzb0FKNPwncdHuRRrON6nvii/yK8lLvLXQ
 +JRp2qqMMot91DQwE2CGOQVgPfEdmjyo3FQq+JrRswtAVBpFO60ZqE213nPIc8XDoevbiTjimBu
 wiLCYIuuFCeC6crggFMcG7Nu8d1OzjU7zRmlQin+7BW4FJDueDiTO1L197zVpSDz12EH1uMld4q
 J8l40//kQHRlBHJQ4iQ==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c581aa cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=ehVQGWA7s1bFufF4V4gA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: xREXLFpNdgxuAeTuv_CnzeaonZVBMxjp
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19249

The ruff lint tool reported that stdout was never used:

    F841 Local variable `stdout` is assigned to but never used

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 828459a00..47f02a46e 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -626,7 +626,7 @@ def init_config(top_dir, settings, args):
     create_siteconf(top_dir, args.non_interactive, settings)
 
     d = init_bb_cache(top_dir, settings, args)
-    stdout = sys.stdout
+
     def handle_task_progress(event, d):
         rate = event.rate if event.rate else ''
         progress = event.progress if event.progress > 0 else 0
-- 
2.39.5


