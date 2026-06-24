Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4960ECDE00A
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 17:20:32 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12752.1782321628238634919
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Jun 2026 10:20:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=MPryFUil;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0635205cc7=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OEegxV2602576
	for <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 10:20:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=sLdluIFPn/oSxLzNpYY522wQBZaZjZ5tOco9E5ECa0s=; b=
	MPryFUil6/kt5s1uZrvfMPL7p3rPj7mefpc6J3pGyu9o1SjVKJvsXkaUWyKNDztZ
	ZPOzTyGW9o11PyuhsT0iTsSUQ96szR8/p5o1vCQx1iNCBuKAWt4gV1xVac3yqHHI
	owweb3vs0GgFtjuJXSqNSAHa3BHeCWmoxwcPbhtfVdqKyw96keqYzpXObCjmXuDH
	TFQF2c8ZuUU/B2PZLmQnIMi7F0mngzMidP04D4NcLOhBCUiB+kCyH3yvw2cuMTs0
	YihEGVLCnQLVo5k12k9kVNJ1a7ztoiUosYD4RcfbEl8AoKN6rDr5LEzkUW3wcLFe
	sZ/jbiQyHJanOTc8eOT9Ug==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eykj1jntn-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 10:20:26 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 24 Jun 2026 10:20:13 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 24 Jun 2026 10:20:13 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Wed, 24 Jun 2026 10:20:09 -0700
Subject: [PATCH v4 09/11] vendor.txt: Add typing_extensions for bs4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260624-add-pypi-v8-v4-9-ff499f1fd5a5@windriver.com>
References: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
In-Reply-To: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfX5em0YZBYrL+z
 i6yW0NOwSmjNvyeMccG8gTgShHA3bTEfAGXHM/xYYZX94T01/jbM+YUbcDHyA9BU3sXbNY5dgLz
 cVgF1JKU2H7G2G9lZkl4mv+MabtMaRj5UYg3xgZTPxs/Q4Ad36iJS7Jx39YHdWHt1DHj4FG4EVj
 7cVn+0ikZBP66GAolJ+veOmrA3S6YgE+Idg/jqL3ChJ56axJQNRMoi5cR7e/dIv4eRKvaDoDZte
 UTxotQHnne6PQcSNNAvgeyQ3BbVOlcv2iIqZO0PXfSsQz5pOPi9/KpnAGZKfldS5/UFKHziFjrt
 1c6g7F3VshKSJ//kQ0E38LstgdHX2opozMAjDwL/vWVA0ZJWNSNiSgWMru4z/Q/1EGGAf/AcVpf
 DDR8LZhSoFMi+QyXXb2ojNYT6xgSig==
X-Proofpoint-ORIG-GUID: UZRVs4qvz7NegN2QOk9WjNFx2OPqfxkQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfX6N5bbTjYgdns
 O9FrsmnoBU/3cPf+Qj2CZlI08aJqPfkeBzSrDxWlJqULmOcX8qfvSs1/RFJtihuuagJRXQ9Y3bi
 O5IGTuzk+hcU10LYW3jiFuG8WKqfqj8Ce4OaNDafRoajcKtNfd65
X-Proofpoint-GUID: UZRVs4qvz7NegN2QOk9WjNFx2OPqfxkQ
X-Authority-Analysis: v=2.4 cv=JNILdcKb c=1 sm=1 tr=0 ts=6a3c11da cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=xWQbeOxxGysSZDUvVC8A:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19775

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 vendor.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/vendor.txt b/vendor.txt
index c60d43092..6ce8846c8 100644
--- a/vendor.txt
+++ b/vendor.txt
@@ -2,3 +2,4 @@ beautifulsoup4==4.15.0
 ply==3.10
 progressbar==2.5
 simplediff==1.1
+typing_extensions==4.15.0

-- 
2.49.0


