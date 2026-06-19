Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53B9CDB473
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 17:40:51 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47894.1781890846374521518
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 19 Jun 2026 10:40:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=XaRxnMUi;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0630dc6626=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JHPvaa3160141;
	Fri, 19 Jun 2026 10:40:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=2xL1bwPrgSMIObjjOfJqa/ZLZCCmrEjRMEofZSThJZA=; b=
	XaRxnMUiMEQ6mHXFfb2BNvgVDycNtxnrzp0rYgWW4JWvlC1HVc6tMbGdZd862xRG
	IY7fPGWA+hpSF3EU/swxBxOdhVtTJjU/RiTZ0VgePnF+bthxIXKmbUB/VRr/M/Pq
	aNl8OsNzWHMYYU5XQj0WpFVMUi5D9XfA1Bs1EcYmkh+ycXAOns2VvYku9rnqcEkI
	0I4ZJ/6VJtrQHILOfK5d66qTDlKvpzrJZBnJkawlxjBkNHW8BxsifyfylGQEXtUS
	v1gVefEELLZLr+Vm4+33HDeosD11Xdhm03KrtGHMzkbuoFb7T4rVe5TNNAOohLl2
	mEASOUBFl5ycsw5d3YbIWw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4euefbvra8-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 19 Jun 2026 10:40:45 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Fri, 19 Jun 2026 10:40:45 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Fri, 19 Jun 2026 10:40:45 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Fri, 19 Jun 2026 10:39:27 -0700
Subject: [PATCH v4 1/9] bitbake-setup.schema.json: Add title for schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260619-b4-schema-v4-1-1e25a4651b80@windriver.com>
References: <20260619-b4-schema-v4-0-1e25a4651b80@windriver.com>
In-Reply-To: <20260619-b4-schema-v4-0-1e25a4651b80@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>,
        Yoann Congal
	<yoann.congal@smile.fr>
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: 7yNmIKVuh0o7v4hiTegqtY25bahNHepe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE2NyBTYWx0ZWRfX+EiI23BufgMT
 yNCyhIZfEEJ82bY0BBSGX4A3bVgQXItRAk7LzSjA/Rl3/vGYdNH9VcJE6v6Fowrh3LzT6BWruhV
 42udsq7/ZlctzayaBHCDc8JoaJ/mLF9ScfOyUX3abhTN3fUBMz53ccYmnI91OGg7TPVvX4QycrG
 ywSmOkUdNOIefsx5+LlLt97dzA84bNGPa1LF0m08l7X2gyWdcwBTjiuJdS95jG7DjHvlU7p7dEy
 KULnp52G0DmZrM38MIa2frmaQ594XJdWjPp+TjyqSB2EhoHFrrS8ePXT9Dk9QMfIvV5BQ0tnSbm
 221S2EEWzRiH/7MmSW25TCTua8Inh7+1fjak0N2jdMxp64m5OEA932huY2PsDZ3k3KFW87enyH4
 DWfTYenImJ5lKAuXgxDkxOqrdqXdUFtjWl7tJTuZUzCHsqAafNtghrYFXwWzIYKmsfPUlbOyMeG
 hAbQ8EvP8d2AQV1oFEQ==
X-Authority-Analysis: v=2.4 cv=B4qJFutM c=1 sm=1 tr=0 ts=6a357f1d cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=eRc3Im3UAAAA:8
 a=t7CeM3EgAAAA:8 a=p6DkDQ3WC7ss2oXzR5gA:9 a=QEXdDO2ut3YA:10
 a=6K7LhGdg8M_A9WyCZdwM:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 7yNmIKVuh0o7v4hiTegqtY25bahNHepe
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE2NyBTYWx0ZWRfX4h6+Cw1wg9hw
 ciUclBDXP7OcEiji09yiBVpsCQfvvyp6xhgscHbCAF21dS0Ryct4v8OiT8xSwcP5ygGW9qJyEEb
 6QzEePRY+PkvOZlU4DmYsUB4mNaHdb5hsmqpiVQh7i2jDcqprCqp
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
 <bitbake-devel@lists.openembedded.org>; Fri, 19 Jun 2026 17:40:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19753

Resolves the jsonschema linting error:
  Set a concise non-empty title at the top level of the schema to
  explain what the definition is about (top_level_title)

Reviewed-by: Yoann Congal <yoann.congal@smile.fr>
Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/bitbake-setup.schema.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
index 99f47f73d..309088348 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -1,6 +1,7 @@
 {
     "$schema": "https://json-schema.org/draft/2020-12/schema",
     "description": "Schema for bitbake-setup configuration files",
+    "title": "bitbake-setup configuration file",
     "type": "object",
     "required": [
         "description",

-- 
2.49.0


