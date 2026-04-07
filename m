Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78F3FEEF5D
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 15:03:01 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.83447.1775574172389021123
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Apr 2026 08:02:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=PTol5KdD;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8557d86685=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637BTJfK4040614
	for <bitbake-devel@lists.openembedded.org>; Tue, 7 Apr 2026 08:02:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=3jZQYaAzPN94DIjfILMRfYQA4ss8Dkd2C025uN4TvUI=; b=PTol5KdDPi5o
	DwAo/IRfYN1qQI6KKVe1WKwMaf/QdeEQ70NSxfC62Ay2pJuBgtsIo7BMFjFTbGFh
	ZFLhyLlnffeQ5HDUS31cFiViPrxnrhLZBmrBngatFpGa/L6YP0tVYM/MpSVUJD2s
	GJiwY+GQ40UYPFkOk+iOPcyevyCjD52IdOihtc7wk1ErMlXK4MLXEuViGpPf1ao/
	VTAJXr5yloyXuMllnVK2UATxCL5W9nvSKzGB06AbLZN4U3q0qHgp3+s/a0nMXuPE
	eprmRFSNo8xdGf8hrH9nTbb0CSYP1d3CVhqHjwsdG0EDfiNBWL1HciqdXPxnzMbD
	3FRJLD1ZqQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dcmrygvh5-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 08:02:51 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 7 Apr 2026 08:02:50 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 7 Apr 2026 08:02:50 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2 6/9] layers.schema.json: Add title for subschema
Date: Tue, 7 Apr 2026 08:02:47 -0700
Message-ID: <20260407150250.104135-7-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260407150250.104135-1-rob.woolley@windriver.com>
References: <20260407150250.104135-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZNaupN40t0izTfbgdg-zW9ckwTGHfWVP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEzNyBTYWx0ZWRfXzUqSre10MFKL
 De90jzLNpOV/cZmEiXmUhakNhiARyLqDgVOCCcoa+DmXPMb6nsFyFthiFPPMdVk+wkarZUPe13o
 lcU+j+07BeVh4yUApGa6nHdB3U5UCrFhz4FlkIY7LAJOUqH8nlmm5WRJ9UPq3MBRRaJLMoIJbZb
 Tc4GExPNkCwINupblM4lJ9MKTht4EAGjnsMxcVnZ1eZpqFyO++etb6wA42MJnP+2U+kFMD0foSJ
 MWsh8r/zx0w/+9QZonDOFEHLrBKkujC1JUGWi/fmvOHUQ2lMmZp2RxKLgf/7OWlIWfi0B2clSe3
 F/n1YEbZuFEffpXRzd+OrQvTCRzbweBCfLbrCcSBRMbF3+gay1t5Gtl3Ici1nQQ2KRyU7DPMS5x
 fxAhSmv2Qdk2lg7lwGWueOfiis1Z2CCib0hNFbHwP3lrmy+kJTpNXCAAdvHP3307F4/AcWZQQ7H
 PN9g5uuZd9HQ/durwtA==
X-Proofpoint-GUID: ZNaupN40t0izTfbgdg-zW9ckwTGHfWVP
X-Authority-Analysis: v=2.4 cv=Wcg8rUhX c=1 sm=1 tr=0 ts=69d51c9b cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=HK-ge7EqtdluswH-FwHe:22 a=eRc3Im3UAAAA:8 a=t7CeM3EgAAAA:8
 a=V4Hmb0OrWCgouu-Qn3EA:9 a=6K7LhGdg8M_A9WyCZdwM:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070137
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 15:03:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19342

Resolves the jsonschema linting error:
  Set a concise non-empty title at the top level of the schema to
  explain what the definition is about (top_level_title)

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 setup-schema/layers.schema.json | 1 +
 1 file changed, 1 insertion(+)

diff --git a/setup-schema/layers.schema.json b/setup-schema/layers.schema.json
index 2c192c8b0..8bc74a533 100644
--- a/setup-schema/layers.schema.json
+++ b/setup-schema/layers.schema.json
@@ -1,6 +1,7 @@
 {
     "$schema": "https://json-schema.org/draft/2020-12/schema",
     "description": "OpenEmbedder Layer Setup Manifest",
+    "title": "bitbake-setup layer subschema",
     "type": "object",
     "additionalProperties": false,
     "required": [
-- 
2.49.0


