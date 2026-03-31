Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BD1109B487
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 14:53:33 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22109.1774968805104877460
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2026 07:53:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=sAHqhg6h;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=85502649bd=rob.woolley@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V4w3D8274792;
	Tue, 31 Mar 2026 14:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=zncqOZQopmUy4dmIyKgDegLN3Y9jRAiSJvcTPJLHfUo=; b=
	sAHqhg6hj9ph+cFoVPsiYme1+g9kymt2HsouAIHiP91DoTvB1CSUxR4i76Fujm41
	6+YGYT4tYR58K9AyTNcrttZ3OAq0equlcKwN83MMCEh1Wuj8rX8Hqae1RJWEqwqK
	kbOTwvLXYeZvoGiUpGptyvlh4gvFIK2T47W70cJEBsWZLzvAoiaGo4b6OnFRkxGF
	ML6rHBiE7X2GRWWTLWKoTMsYTa8zVASaPwKPFBdbpLbuagZZ/nbNAZYs/kQ7pN3P
	yB/J/9ACJ13WWw2tHxGlUTlQdP2d1XjYV5nuNcD+BbYCGDhFUWyA4/pQ/onMdpds
	ZDwZmvLyPP+SGvUzFr5YrQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d65y4btqq-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 31 Mar 2026 14:53:23 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 31 Mar 2026 07:53:20 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 31 Mar 2026 07:53:20 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>
Subject: [PATCH 3/6] pypi: Add packaging documentation for developers
Date: Tue, 31 Mar 2026 07:53:16 -0700
Message-ID: <20260331145319.3125456-4-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260331145319.3125456-1-rob.woolley@windriver.com>
References: <20260331145319.3125456-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=QaZrf8bv c=1 sm=1 tr=0 ts=69cbdfe3 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8 a=SIW4pjiE_UkdO4QYDIoA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE0NCBTYWx0ZWRfXzojbzNQ6ak8P
 jnq2/gOWIq8+lx2gxIDLZgQ9XkrHoDCUkaKb2KRjAc5vDyuo++4vkWkFzXuYe9cLAdy+GO89Mrj
 EPo2Kk3yrbRNLZyl3++ZPboLXlBk7NVg4Fo8ic6v/mbSL44CWhtew79O3HGYmiNGK/46LY8jY7n
 TL6rekefrBE06zx56nqnYyV+srjJG+TLYkGRaaOKUdqSZIV2fQLusBd9KJhuIV6pSOlBj+uIIPd
 Ri0vTHrARjh+RlRjnwJJ75BeLt3dazEL6iqka3laHZvW6Arsthsu+7VakGYJ+/7g+axB4QiQv3T
 NtjdpYL8bdG8IrF/HX1vTVCmyGZWlY0lF4jaPxs4RwBIMNPi0Y7/goVZ1Z64jiD1w0atd1S1emX
 jTu0YlUpHDf/EnIGdkFVXu0k8rblNPtYGRfdgMUmBLOm7pf9B8MQW14/mjk9Trug1hf39hyxTkk
 X9IxVwpAbleCbDCBRAw==
X-Proofpoint-GUID: Xz4GwiEc3v-mcpQ5j8ZEjmyP-7aNoNSC
X-Proofpoint-ORIG-GUID: Xz4GwiEc3v-mcpQ5j8ZEjmyP-7aNoNSC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310144
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2026 14:53:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19295

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 contrib/pypi/BUILD.md | 50 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 contrib/pypi/BUILD.md

diff --git a/contrib/pypi/BUILD.md b/contrib/pypi/BUILD.md
new file mode 100644
index 00000000..b12fc083
--- /dev/null
+++ b/contrib/pypi/BUILD.md
@@ -0,0 +1,50 @@
+# Development Instructions
+
+## Requirements
+
+- Python >= 3.9
+- pip >= 19 (for installation)
+
+## Testing
+
+To lint the `bitbake-setup` pypi packaging, run the ruff tool.
+```bash
+ruff check bin/bitbake-setup contrib/pypi
+```
+
+The steps to build and test the `bitbake-setup` pypi packaging have been automated with the `bitbake-selftest` tool.  This tool automatically creates a Python virtual environment for you.
+
+Run the bitbake-selftest
+```bash
+BB_SKIP_PYPI_TESTS=no bin/bitbake-selftest -v bb.tests.setup.PyPIPackagingTest
+```
+
+## Packaging
+
+### Create the development sandbox
+
+To create the development sandbox run:
+```bash
+contrib/pypi/package-bitbake-setup.py
+cd packaging_workshop
+```
+
+### Building the package
+
+To install the development tools manually run:
+```bash
+python3 -m pip install -e '.[dev]'
+```
+
+To build a wheel (.whl) then use:
+```bash
+python3 -m build
+```
+
+This produces a wheel (.whl) file in the dist directory.  This may be installed using pip.
+
+### Installing the package
+
+```bash
+python3 -m pip install dist/bitbake_setup-*-py3-none-any.whl
+```
-- 
2.49.0


