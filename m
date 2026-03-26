Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDB510AB808
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 18:57:57 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.56448.1774551466195929523
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 11:57:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=CxXaZd0i;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75450e5aee=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFhRcI3113430;
	Thu, 26 Mar 2026 18:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=IGetQA9zr2P5el2Wb3vuXqoEFTAKlXErJkjERPHheEg=; b=
	CxXaZd0iCQgdWnkuZWNAMi0E2NSwlrEoDnuzgSED9CPstk7yrrsVaBuc/5E2dIn1
	ocB8tFml9db3fSmAitn4/dhSgNqZve9xxAn1t01L49RBOlhVHTaKzUxr+IUruFOD
	tNArDDGyCyc4Gk9aWmIDCjkyHy8lsuTVMbqKUSt0y2X5tuJs6aROdhGoErQ/4fnO
	AkQMBP0l8kHjUjOZpjZdwCSaPUumEvogJuZli9rxAJ9abc2MjvBrw2FGu+eH9Uga
	fR3/B+26NAIlzRySRsQrQGCVfbycuhusNbOasNBaVS2NacKKVTjdZY9n7m9wr16H
	Q/rw+2FiZxhEmYPHg1VX8w==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj872bp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Mar 2026 18:57:44 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 26 Mar 2026 11:57:43 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 26 Mar 2026 11:57:43 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>
Subject: [PATCH 01/11] bitbake-setup: Remove extraneous variable from str.format()
Date: Thu, 26 Mar 2026 11:57:32 -0700
Message-ID: <20260326185742.542268-2-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326185742.542268-1-rob.woolley@windriver.com>
References: <20260326185742.542268-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: KhJcDoBks0ZcBc8dOVh0axrNmfJy6TGz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzNiBTYWx0ZWRfXwSbIhiG2PIcW
 F5oh5H3lt4Si49V3gxT1QDhEBKjwYOqpP+F2HzGuDJYbWGPALOdm+MAc1pYUOH4f1HyxgBWCqUo
 KLcjeDTKKnwt5YezSTxBvkr8c2BGm9Wszg6peEtKG60HnWKP+4fE+ctpVZXh11kTNFPvjh+jOTq
 J5sXL1jgcqduWIRx0P7yxQkq90mzRuM35N3OKxrVs5CCNOqlvQj1BwRU96FnG8awkhzs5yYTSbS
 9cy4aosw76gpQGMgkEEqAQ1trWmrm+waaCwXatueSXtQ/F/8x37jtlkigEictOxKXV7B4/uKMpY
 08va7I2ocJiGKC1pSTMwZN1YoKgtJGzlMwu/rQ/NTtCJUhN6Aw48bOV5f22oyPMajqNTAGuhOMG
 IcxfsGobNMiZe5IfVoT6xEr98LqNksJy4bc3/9HcWfSQg4LudtcegkJzpoTZ2iLeIiwDy/nmANQ
 i9CuLzAczRRApAMSQfw==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c581a8 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=2V6DY6BgAAAA:8
 a=d8dENnQg9s709Fn3q1QA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=ldqKKs2zR4t-S6fqr-1n:22
X-Proofpoint-GUID: KhJcDoBks0ZcBc8dOVh0axrNmfJy6TGz
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19247

The invocation of str.format() supplied an extra parameter that
was not being referenced in the string.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index dcad9c169..212da4f88 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -1176,7 +1176,7 @@ def main():
             list_configs(all_settings, args)
             return
 
-        logger.info('Bitbake-setup is using {} as top directory.'.format(top_dir, global_settings_path(args)))
+        logger.info('Bitbake-setup is using {} as top directory.'.format(top_dir))
 
         if args.func == init_config:
             init_config(top_dir, all_settings, args)
-- 
2.39.5


