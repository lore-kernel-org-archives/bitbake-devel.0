Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CBCCD98E7
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 17:38:22 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.135105.1781545091913097994
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Jun 2026 10:38:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=g3pfCpIS;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=0626ff78a0=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFej791186413;
	Mon, 15 Jun 2026 17:38:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=ogbWJPIA/kYkl5ClZ7+yV7vQ7hrfVb381RLW1W8p1OA=; b=
	g3pfCpISGMVvU3YV9PYsL3CsOvcerIHlhLGajBHhI/NlXFjUa2xWay1gT8UrlKjK
	fIVFwrHwPBI5LckxQKogSlsBRSL1UgmkrQVxhbUZ2p2RFhW1WeER9Q2+UTKIAGhL
	JuuPcDctn5mn7T7XCMJKu96lX9L4GWEjUDB+u01dLfJOvUMJqKLVL+CTsZ2cYxe9
	cOHpezE48Fq3MXbxrnkdKou0+N+diso8lML7eWFtz7BKykgB5Ql3n5DKnmHwNucC
	KUnTlUj2aI8letcMOdgtIRpKgvzyDwo9Qq0Dvr69aFtolTkVI0C+/bD9oKIN/hGp
	yPaqC4N9lxegxm4+Q49sFA==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ervkp38se-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 15 Jun 2026 17:38:10 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 15 Jun 2026 10:38:07 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 15 Jun 2026 10:38:07 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Mon, 15 Jun 2026 10:37:46 -0700
Subject: [PATCH v3 04/10] bitbake-setup.schema.json: Remove trailing period
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260615-fix-bitbake-schema-v3-4-8dbb07d8765c@windriver.com>
References: <20260615-fix-bitbake-schema-v3-0-8dbb07d8765c@windriver.com>
In-Reply-To: <20260615-fix-bitbake-schema-v3-0-8dbb07d8765c@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>,
        Yoann Congal
	<yoann.congal@smile.fr>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4NiBTYWx0ZWRfX4lss7XMZf4+z
 Z5RtJ1U4cl0/cWoqwxBy15cVN2B5UQz9tkTDBBaqHFCErXFKha2dAzHm33u8nVTDOES/l8wwcOF
 IYft7QFLCG2lgqFvatsHp1oAdEQb3qHVyfTtybCBReijXcNvw/IP1xEIIwdqgJaBzTXK8ACLuk4
 L6WjXQu+R2K004SEs7cWpnmvlJmcYSJe/+fMxif7i5MwcZPBAq1+BJWnpunNSOL25rlGw28DR02
 S9D50qdpsBHWzjGmq2Phpkb2qKkZ8ADQI2YGXK3KgsCL3iqUjGW6DOXbfq5lFNFnl/UBxS1V6Ta
 Q5If3LjmJSuqAp1gq53hp7JAi49BvDPLfPNFzvpvNpQG/OPeqw8/mqX+EBKlUfh7ZC8uPnaPPfb
 sz6D3FR5Dy7FCmpyISpl0dXBPc9Su6HYV21vsVjBXqlg4Zgy13FS7mxFYRsxK+pyS2KXmeWTTp9
 B1IdPdpuvF/GiUTFDNA==
X-Authority-Analysis: v=2.4 cv=BK+DalQG c=1 sm=1 tr=0 ts=6a303882 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=5koV8NlHODIScN3rBmcA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4NiBTYWx0ZWRfX6H6NyuhSVMmg
 JyqRsYvembebL7bqocYnDKSQgae1uIhKRasvtr6ZpKJp7BCeltq6wsuF2QnwEr3aSwZYxQ9BR2q
 Muss5GegBVEu4pklY8OhSnVk8NiVPAMauMMSwSXuaS2zWBN3802S
X-Proofpoint-GUID: T0pSDdfvp-xoMKJls1VBrcllwGfrdjRn
X-Proofpoint-ORIG-GUID: T0pSDdfvp-xoMKJls1VBrcllwGfrdjRn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150186
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 17:38:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19692

This resolves the jsonschema linting error:
  Descriptions should not end with a period to give user interfaces
  flexibility in presenting the text (description_trailing_period)

Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/bitbake-setup.schema.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index 314b5f78e..b724dbadc 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -170,7 +170,7 @@
                             },
                             "setup-dir-name": {
                                 "type": "string",
-                                "description": "A suggestion for the setup directory name, $-prefixed keys from oe-fragments-one-of will be substituted with user selections."
+                                "description": "A suggestion for the setup directory name, $-prefixed keys from oe-fragments-one-of will be substituted with user selections"
                             }
                         },
                         "additionalProperties": false

-- 
2.49.0


