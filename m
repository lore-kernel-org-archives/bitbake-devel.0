Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2670710A88F6
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 17:40:00 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.53622.1774546796086357532
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 10:39:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=FT5Lyf85;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75450e5aee=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFhRYa3113430;
	Thu, 26 Mar 2026 17:39:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=YdYcmpynxOpL9aLcDce7OhkSsSY8EvP6lNDopgBWbBU=; b=
	FT5Lyf85tIxlOzIzfm8BRgewdgjV9AnZHa3Zw5sh0vx/dr2SqNoEc8OSm+FybfU7
	1nmozzN7W7k868OQBnVgRYQmmSEWJOI3nVwmP7hlIUD3fAdWAaQIgoAZzduak/LC
	2dKDJ5Fe0y5x64+YSj/qp+AeH6Pvy2piCSYCiJud+GBdk9rum4fQxCDv5xg+Js1t
	wE/jgq7qwot9bAOwsppGyTwB+otWsKQVcV3ZzL4NyLWBDPgSQQPe4LcrTlVe1d9t
	xcXextwXZZdCHs/CFHrZXwq67L0ApI7R6zZB+Iwb0tHVJCPdLoT/KPEBb6orjdV0
	eWDryo2rm24BBTs2kDrfpw==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj86y45-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Mar 2026 17:39:54 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 26 Mar 2026 10:39:52 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 26 Mar 2026 10:39:52 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>, <richard.purdie@linuxfoundation.org>
Subject: [PATCH 3/4] bitbake-setup: Add the conditional script stanza
Date: Thu, 26 Mar 2026 10:39:50 -0700
Message-ID: <20260326173951.519326-4-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326173951.519326-1-rob.woolley@windriver.com>
References: <20260326173951.519326-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0q_1hrDarUSIVvheaHiOsrxHRBWqufCB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEyNiBTYWx0ZWRfX7HZTzSeYqBcg
 xF2PnxDbVUHH17xOfy42jcfrfmTg0s1fQiO+jXKzuJNXhGvX54w0mMbbTAkIfpTYZ9/Frw6Cjf6
 h8UBQLn8jUtfkuXl0KfJL9bBiHP1dYzI7ybAOU1UjGvYOndtxdpSsHKq9dTC451k+CLYNrCA35x
 YCfuoeo2kapKXozpd4w3xKjtknzgRkTOmt4AfontwxEHTADqbuy9Z2/YnyoS4m6BcpS3Ju/yqae
 AXqWoOmcypm2Z6tBq5A8kJLVk6B9rSOuWNLJksk9I5dkXF+yvFbroQ9O385u8KVoXyW5QqBcXLH
 TJmuVhRumT89/o5wzD3Oj+QYEbBObA7Scr6KkRFDBsY9C6hFtzFhk1VQQEUXeI9fllPV1KcC4UF
 RAVZX3b2w8Kt/mjufSSBMzSwPA/BWF/7pfA36i6NMesfcbRCbrmDKQjILiTX3b31RvjhPC6J7tj
 Df5+Bvzu8mAbymvwAKg==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c56f6a cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=f1Ed6B2-FHGrvtuZyGsA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 0q_1hrDarUSIVvheaHiOsrxHRBWqufCB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1011 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260126
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 17:40:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19243

This ensures that the main function is only executed if
the module is executed in the top-level environment.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index b05894e01..d7e2e187c 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -1192,4 +1192,5 @@ def main():
         from argparse import Namespace
         parser.print_help()
 
-main()
+if __name__ == '__main__':
+    main()
-- 
2.39.5


