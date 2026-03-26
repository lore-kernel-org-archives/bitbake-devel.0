Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACDF10AB814
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 18:57:57 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.55629.1774551468104061720
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 11:57:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=L7Enhogw;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75450e5aee=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFhRcM3113430;
	Thu, 26 Mar 2026 18:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=OnTnjlEe/0BplJd+CWJCalEQZtC1uyCCJVxiXYPyl50=; b=
	L7Enhogwhl7XZIC3DNAY/LPu3x+MEHTKVL7vmPDIr/ZsQYUlCksut7OMnTEZ1Gvf
	JF4VnfswdUl/BNtZxIOczWXM8ZQELJ5PcSHlFhPxzCXLMDmjve4xvbhF+i1KBgG7
	xhtK5gQ3l1K17Rv8CSVEuwns8IMblW/Qd2/F8Hbc3CM73OOP0r1Nvh8yi0Um95Qu
	VnP8CmQbQOdL/NdWB8fioJ9GPrbU1ReT8oevcWOsN8gHm76xOHNQBZbJaElqrAgC
	jCiA+sEIO/QoQ2MFHmO/BbG9DSbzSE3WRNnTUa0fgVCjzyIQmRLF7JO82Mv3Rh2o
	sL777Rodmg3eH5UE1TM8GQ==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj872bp-6
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
Subject: [PATCH 05/11] bitbake-setup: Replace f-string without placeholders
Date: Thu, 26 Mar 2026 11:57:36 -0700
Message-ID: <20260326185742.542268-6-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326185742.542268-1-rob.woolley@windriver.com>
References: <20260326185742.542268-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: pISnWaoLgDAyRTM7DvEsHI_BnU0NwMmC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzNiBTYWx0ZWRfX7B8W1d9IbA1q
 N6TEZExeHZtIvJsJBLJTcEHFCfH8m57omYKD4DEVYqY908L37l/+mqMGsvCY4BqZBuTc71ivStj
 K7wQ9GszovoocbMkzaDpqaGbvT+qgH9UcJiLHsZyUADOPUM/iK2AmmflP9leoQhRkQbvI26GS4n
 FKuxG4mdiegQkbLEeega5nqRe7D+BJHBuKldXCI3TBuAhEYYK4LXzH/AnyQIE42Iy/v7a8KBX6k
 WYbUIjxXL7lfEWFkzTPIfe15DOesuI2azAJCOcnhv/30lWRNkZBZnEBsGYG2zshJZRJ/nYqv/uM
 WzkmuAy4FIjILiQzpRE4MsI1pyJXjDV9HcXAgRmxAdzu66PBEZADR0KBLloaYJCzbxnTXu9jStd
 9KhsQU/9lsqA4OeoxYfyUfZdbxlUX6kSE0sa8IJTjTCl45CPykuFDpyIa3N13PNQ7OFhK8/Rcw3
 N4RPhCD11RifZG5dijQ==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c581aa cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=DX4I7EJYZ07sDsrzdd8A:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: pISnWaoLgDAyRTM7DvEsHI_BnU0NwMmC
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19250

The ruff lint tool reported an f-string that didn't include any
placeholders:

    F541 f-string without any placeholders

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 47f02a46e..08d9a8d09 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -1040,7 +1040,7 @@ def merge_settings(builtin_settings, global_settings, topdir_settings, cmdline_s
     return all_settings
 
 def sigint_handler(sig, frame, func, top_dir):
-    logger.plain(f'\nShutting down...')
+    logger.plain('\nShutting down...')
     if isinstance(top_dir, str) and os.path.exists(top_dir):
         if func in [init_config, build_update]:
             logger.warning(f'{top_dir} may contain an incomplete setup!')
-- 
2.39.5


