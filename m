Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18536CDB46B
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 17:40:50 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48057.1781890849680461648
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Jun 2026 10:40:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=ev2X3aG6;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0630dc6626=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JHPvai3160141;
	Fri, 19 Jun 2026 10:40:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=j6PiTX8povpy3S0Y7AOJmGgda1PymLpz5IRs5YTiSMo=; b=
	ev2X3aG6qN1RZUm19p7PP6AKd2+bSrfNDzW+/7FSVaN+Uf4xzEzBvC6mK+UtHOIA
	HfP/NVOLLOWagBYwZDr6OBfr2iunSTqSGWz5hWPy8qrPukcPo5e3ict9oeyI5yWV
	ddkRYoCKbrjfxf8csv8sgJoOP9m4aWhLLwze5QnswEOZgQPy+FOGWQE1th1W9LeF
	z/6fLvLR9kMLSofn2QWMADYLfVPYWrbyNCwXoKAoE8U7Q1EDVpNs+OF6EWnrNpfS
	uPLaN+ZRWOxezJJA6Gsxjr1X5CnA0FO018Ctf4TqMsWNlyQ7h1OMnWh5rjvWxCOk
	pWYczOuhNOZjH+v+lwPSeQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4euefbvra8-10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 19 Jun 2026 10:40:49 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Fri, 19 Jun 2026 10:40:46 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Fri, 19 Jun 2026 10:40:46 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Fri, 19 Jun 2026 10:39:35 -0700
Subject: [PATCH v4 9/9] layers.schema.json: Fix typo in property name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260619-b4-schema-v4-9-1e25a4651b80@windriver.com>
References: <20260619-b4-schema-v4-0-1e25a4651b80@windriver.com>
In-Reply-To: <20260619-b4-schema-v4-0-1e25a4651b80@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>,
        Yoann Congal
	<yoann.congal@smile.fr>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: 7bq_7kG_l1NycM9cRCBTbi89BILmVADC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE2NyBTYWx0ZWRfXzyiKfzI+NgJ+
 udW3oGSp5Jd4gWsaxrGSgMg0I+nW2k6H2yTEcrHHbnQH4xKA2XGTrQNAyrcnGkIpIA3Dq3yFZXm
 BMtw0DWqbjAYwFjB62i+pPqeqdPRpizifvQumB89trufjJrMo4Zmyr8m61nvq+Cg7OgAS8rxYm8
 e1HPZx88YM1h2nH1g7blStukGda3Owky5l391XJsAjS32DOWRqGn93qn5FApHpGHvDaUNaWbnU/
 OE2TRtP3oWTJw5/h5fLyDPrhOtuCyT/LtozXNaq1CJgy/KY30SelT1v4mRFMDuPbYL9eugUmdAD
 jQ8lwF526QQm5X3DHf+gnbAnfm3Pjz6hPaxGL7K2TIWUzL8dMVsvyoFsFYbvwE2lhSqq2csu5WF
 4smAPceBec46pJwBN5kjqcI94wxZ4j9C2SG2YpunigE38IKmIOk9NL7wZgjPeYKAMvtULitoJI2
 ovjYgmhTAje/ayGCiBQ==
X-Authority-Analysis: v=2.4 cv=B4qJFutM c=1 sm=1 tr=0 ts=6a357f21 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=HQmm94sMRVIn4oapxyAA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 7bq_7kG_l1NycM9cRCBTbi89BILmVADC
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE2NyBTYWx0ZWRfX+xFhuCWlFiZp
 elrCsq5IrllkyRH+PRE9mMNTkDpOyBVQ/ilOrW6RFAjKZCMhBoOjnDzu98EGYbOLddIoGLBoRQM
 rpuP7M5OJVS41vZsH9uKKxKTCnb+8EmFPUkK6QfBi2K5hoZv+SG8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190167
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Jun 2026 17:40:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19761

Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/layers.schema.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema.json
index f9a26dc15..3ed40d080 100644
--- a/setup-schema/layers.schema.json
+++ b/setup-schema/layers.schema.json
@@ -72,7 +72,7 @@
                                 "patternProperties": { ".*" : {
                                     "description": "A git remote",
                                     "type": "object",
-                                    "addtionalProperties": false,
+                                    "additionalProperties": false,
                                     "required": [
                                         "uri"
                                     ],

-- 
2.49.0


