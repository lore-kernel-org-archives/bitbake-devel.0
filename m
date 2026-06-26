Return-Path: <Sandeep.J@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2288ACDE008
	for <webhook@archiver.kernel.org>; Fri, 26 Jun 2026 05:20:47 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.28955.1782451242333530759
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Jun 2026 22:20:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=gPaAyrqo;
 spf=none, err=permanent DNS error (domain: oak-lpgbuild12.wrs.com, ip: 205.220.178.238, mailfrom: prvs=06372738ae=sj10@oak-lpgbuild12.wrs.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65Q4Vcwc2899052;
	Fri, 26 Jun 2026 05:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=8Gpa9Icry
	xSs+2S3wFnPvCfK4Xuhu0GuDuwVRmUApy8=; b=gPaAyrqolpHqb3PudEhAHYDNR
	5DSQsIARIX7Uk6k8TJdxpLZj843xXYY55YriJfDtradddaKPYfjzfoEMZ0nZ5uAu
	A2gTVnXmgddrq2d8sSGoT9PVL2bXWXtmv31ge92ItCg8XDlOr4NlWbSwDlI1mIOc
	0n9bm0EOkFjebG6DC9B4hqqqI44Ui3Og36y409fn1egcY46iTiL15lkzqSUlO5H3
	mWxNn/8NFGBV5B2PXHgboqJOUnKlP5X4UzLmOZr0QOHX/TMvMa2+mskuVGpOm8up
	wCizjWtXe7Rtk7oGqOatrF0EUA37RHTAqTZURQIT5u/B4LJOdQCfsn0o9D5iQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4f1f3sg6yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 26 Jun 2026 05:20:41 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 25 Jun 2026 22:20:39 -0700
Received: from oak-lpgbuild12.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 25 Jun 2026 22:20:39 -0700
Received: by oak-lpgbuild12.wrs.com (Postfix, from userid 1762445396)
	id 751A03900BBB; Fri, 26 Jun 2026 05:20:39 +0000 (UTC)
From: Sandeep J <Sandeep.J@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <docs@lists.yoctoproject.org>, <Shiva.Komati@windriver.com>,
        <Randy.MacLeod@windriver.com>, Sandeep J <Sandeep.J@windriver.com>
Subject: [PATCH] doc/README: update broken yocto-docs cgit URL
Date: Fri, 26 Jun 2026 05:20:39 +0000
Message-ID: <20260626052039.3401993-1-Sandeep.J@windriver.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: AyIYfSIxsjIfIj7PGNDWmz5-1xzmiCwV
X-Authority-Analysis: v=2.4 cv=AMMiSoaD c=1 sm=1 tr=0 ts=6a3e0c29 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=iGHA9ds3AAAA:8 a=t7CeM3EgAAAA:8
 a=yOoJCcBqZQQbqPRo5x0A:9 a=nM-MV4yxpKKO9kiQg6Ot:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfXzH4N3amCup3M
 J+W02eg6YG7+5ur/UO9OeSqqCYfIGdkxOZR/ppYXLdLxFyUrrWFPxwW4e+U8LaFruMmm5nflTTy
 OV54/gvVdbiZCyKtw5198HPcjscypYYPS/lleNxgAxvY9Oar5zDL
X-Proofpoint-GUID: AyIYfSIxsjIfIj7PGNDWmz5-1xzmiCwV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDA0MCBTYWx0ZWRfX2xrYcuFNh2CM
 HNY2sOWaixMOthGM5ZXArG9dPFOtGSba4pHueVBCPQCGJQCGxSF9y3lIdUKaimMhO2yXoOMukeV
 s4XTQPFfr5K7rNN0NKQk5qdC3yprzU27TrnWQcEu5vSnbD6WUc1gA44cRLbHfTDk56gUHVA5iip
 jaslyzyUdgq8PxFfO0c+Zv57dPtdLCo/W2oQbl5VKAIfMDPXo+NW6GKkiZRh8r6IW7Vk7SI3n+C
 Ul5pcQ/v9MSvx9+WkTHu06YF3wFrDLRmcpc0kGYLS3W9wo0XDijzvwEd8/WWntdG6CFKnL8Z9Rk
 MCb1lhC8+9fBAtOGsMwpqdnbrqX9TJG56G4Q6I80qKtRwD7A74DctzqoGaQ1w8UT9YVp7aZLvUI
 K7E/mzq+DZguE+9EZyx/CrP0Ytv0ApqxQ7fvoXeMPa74ckubVTjDoZKH8MuZ0jBXJexNNmUi+NB
 NDWeX1/OrvrSnU754Dg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260040
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Jun 2026 05:20:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19789

Update old URL:
   https://git.yoctoproject.org/cgit/cgit.cgi/yocto-docs/tree/documentation/README
to:
   https://git.yoctoproject.org/yocto-docs/tree/documentation/README

Signed-off-by: Sandeep J <Sandeep.J@windriver.com>
---
 doc/README | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/README b/doc/README
index d4f56afa3..9869d6e31 100644
--- a/doc/README
+++ b/doc/README
@@ -26,7 +26,7 @@ Additional information related to the Sphinx migration, and guidelines
 for developers willing to contribute to the BitBake documentation can
 be found in the Yocto Project Documentation README file:
 
-https://git.yoctoproject.org/cgit/cgit.cgi/yocto-docs/tree/documentation/README
+https://git.yoctoproject.org/yocto-docs/tree/documentation/README
 
 How to build the Yocto Project documentation
 ============================================

