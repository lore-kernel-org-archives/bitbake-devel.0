Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666F5CD98DA
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 17:38:21 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.135403.1781545095320722857
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Jun 2026 10:38:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=mBFv8Ttq;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=0626ff78a0=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFej7F1186413
	for <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 17:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=Lfjb0lcHhTQxqGeNKvoobTR0Tl/E2WbdMyLUc8WP4ys=; b=
	mBFv8Ttq3ZLH7TFxwnzk9CfweCZEJq7jt45ligO14zihS55fiEfsNOEd3EcjaRzw
	wkkKmOM+cwOXp8bvDYA21GGneu4W94wnFn5Ig7KjeeOoFdGSLUgaFKqKDtH+7r7H
	9roXN2md8JyoQW0G/fy3mSMWOmDnGMvDdExMKolVgV1vkOTFq4RsgtxwZfIXRJvj
	RHviiynROCUJdQ/uNJFcdvyJ5eKp+k56cLIJS3C8/0heYRUz25JG5RlfKY+bbkXH
	NtEN36IJmhoS+wOpV4YHKxi5q9queKB1HRFxQYwJNaf6F8FQKt4SBzP4IlX6plJs
	ETT6C6e8tUATDWnilE+ksw==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ervkp38se-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 17:38:13 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 15 Jun 2026 10:38:08 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 15 Jun 2026 10:38:08 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Mon, 15 Jun 2026 10:37:52 -0700
Subject: [PATCH v3 10/10] bitbake-setup.schema.json: Use anyOf for
 non-disjoint subschemas
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260615-fix-bitbake-schema-v3-10-8dbb07d8765c@windriver.com>
References: <20260615-fix-bitbake-schema-v3-0-8dbb07d8765c@windriver.com>
In-Reply-To: <20260615-fix-bitbake-schema-v3-0-8dbb07d8765c@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE4NiBTYWx0ZWRfX1UmMg8bnp9Hs
 DxkREor3Ky08Zg4mRITJCazvAoD6ZGX+FGN03RCWPAkk/eP5NrSFcovS1Im3gibdI6lpdawpJgE
 z6/cghVCWROkG2YuVwVfae7Tp1J/nxSyaPkbS3YxFXWkUX6fAg+igFo2xvt/b3+b9gItg+HVBHU
 3Fj83dA1T+XexsMts56c8ybw21/MrymEz/BJZ6EDMPbVEdJ5QDlbwC2CetCYFqmoJG32wh+bhUa
 inJQa1v7H1tDzEw18IYrBI2xnXuyPi9AhfWYDh452ZaSfj67Ww5atqIsfFTzZwwysADM0LbVuxl
 b1XI9tJ1AnGUXQYBBTcmKa3Fw0j9pzttlo07sgu5ZuL5Mk8XeOyy6MYoAFYIdjfM/UuxyXzsKxW
 IQ5JHBFGxRX6KTcLqMCg7ZSbM0ePzA3vgy6blfjI+9D5zQW0k4G/TmzlD8atwYaotJX1Vi5ib17
 W8n0HQcVUa/4lfESbeA==
X-Authority-Analysis: v=2.4 cv=BK+DalQG c=1 sm=1 tr=0 ts=6a303885 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=WRB5GERD_v5DdmlpiyYA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE4NiBTYWx0ZWRfXyregs+CLN3/E
 gyCpTyj6n0+2dQ8IxxLW+Qp3e3QGgYhwYL5X6DwQJFB1zY0GbSQv2l1dUp/OrBxMQUw2Ejuu+2i
 RtG7jIAlZTdJ0x2Js8dg7xLMttDCvWxHxoifm8GffQ7UXDFZOTpK
X-Proofpoint-GUID: Jc9Rf-KdE5kAyO0VhxzqhKGy-RC26yQS
X-Proofpoint-ORIG-GUID: Jc9Rf-KdE5kAyO0VhxzqhKGy-RC26yQS
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
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 17:38:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19699

The oneOf keyword is for matching exactly one subschema.
However, the branches have disjoint types so it can be safely
converted to anyOf.

This resolves the following jsonschema linting error:
  A `oneOf` where all branches have disjoint types can be safely
  converted to `anyOf` (oneof_to_anyof_disjoint_types)

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/bitbake-setup.schema.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index b724dbadc..177a8dc8c 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -76,7 +76,7 @@
                                 "description": "Human-readable description of the configuration"
                             },
                             "notes": {
-                                "oneOf": [
+                                "anyOf": [
                                     {
                                         "type": "string"
                                     },

-- 
2.49.0


