Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EEBF46C6A
	for <webhook@archiver.kernel.org>; Mon,  6 Apr 2026 17:21:16 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.60363.1775496073002311905
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 06 Apr 2026 10:21:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=hFIUZrqV;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=85563bbf72=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636ASbBu1474696
	for <bitbake-devel@lists.openembedded.org>; Mon, 6 Apr 2026 10:21:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=M/2C/6262SS6swz87Dx2DpaVj3FZUkBYtiyZ7SIk8mY=; b=hFIUZrqVVJkC
	MFeTNCaFP4Y/+NsRhurXN7pJ9NQ2P+pGKF5XQhkh90C/4nuDtCzHzDN1EO64xsI+
	0xSBgYu9f6QtdTkQwPI+aQSa5r05freDZ4AT2jCdjmrM9txiBCbDMMRQ8TrHlJ8l
	Bi57J33OjaX2hkpIknn3gljA5mTbnZjm+yUfSFGxWAFvX1uxQxR3QhM6+NmZi6tJ
	XH1v+NKo5qnnxngGtzcVHUbvbU44osv9NpzRBUGYKCSHQBRwWcoWrR4OZNLF36KH
	7AeuYYMixTlRm2LX6jlw7+vRmxoFHwGmaQz5QTWWTqCpMGVzPH1lOc6pTSyufgFA
	GGmaLF8cNw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dawwx9rha-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 06 Apr 2026 10:21:12 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 6 Apr 2026 10:21:11 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 6 Apr 2026 10:21:11 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 4/8] bitbake-setup.schema.json: Remove trailing period
Date: Mon, 6 Apr 2026 10:21:06 -0700
Message-ID: <20260406172110.2050236-5-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260406172110.2050236-1-rob.woolley@windriver.com>
References: <20260406172110.2050236-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE3MCBTYWx0ZWRfX8z0xvb9MP8T4
 cqHuakYzsVDfTBB2zSNF4hMQC9MCrvsznMVh1ZWoAsj8+VmHNayxPvsBpKAcTKw6jt53WwCf+26
 NcABuS9O//Y3KD6mhJHmzHgPNvA9CbPEVOFV0Q73+H637BWFoYy61kDzwskWlHvXBckv8kK53Ip
 HI8+Ed+avEEyC7AYUbVargeky2GQFG5l2LC8eStCnX1GMC+FMN1X0ptVGa7mo5KthJ2X8uX2Em3
 y40ZnQMXfb24Is9QEj0bl9OpOXmqlRUjLKz8MfBn+RuXkiZulSgZNEdtY3NVxgXpWEerue/iQdj
 DCrIGcuF/tIJk9KWOZkb5YMpK2q8ztenpdF8Rwgsl+xriAmrdD+oFn7NliH12iXz07J6VI3sAzn
 dGGOdCtRptGtgUTkLT7OmYnjFvoQPk7Kh75P2TJNI+4IPjWwXKPlM8IsZ704FEEUbapWyST1C59
 w3crKTJiFHvuXes5+yw==
X-Proofpoint-ORIG-GUID: uDbZvFBR_RTJbzNvwW409KiL6kqWe5JJ
X-Proofpoint-GUID: uDbZvFBR_RTJbzNvwW409KiL6kqWe5JJ
X-Authority-Analysis: v=2.4 cv=AZm83nXG c=1 sm=1 tr=0 ts=69d3eb88 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8 a=5koV8NlHODIScN3rBmcA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060170
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 06 Apr 2026 17:21:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19327

This resolves the jsonschema linting error:
  Descriptions should not end with a period to give user interfaces
  flexibility in presenting the text (description_trailing_period)

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/bitbake-setup.schema.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index a1d41d228..6db5557ae 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -144,7 +144,7 @@
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


