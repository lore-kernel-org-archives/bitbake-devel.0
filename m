Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFDC10F92E3
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 16:07:18 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23974.1774973229601954478
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2026 09:07:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=SRVtYDKv;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=85502649bd=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V6nv8R2249206;
	Tue, 31 Mar 2026 16:07:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=8n99xtl4hIGYnko4AuVJLu+5N8KSGrao6fjGpaG/QT4=; b=
	SRVtYDKvYUKQvG6otGLVdcdzfNSqnalz34rSoSiZ7x8sXFbXifYgNrm9y8yY649b
	XtzHbkoaAZ8wvPeAKzXPMYKOxUS07767CQrx5I5tIEUoWSi2FD0JkGoxmnvgV51M
	/yZaMwyJnZ2fzlFOROZrZoVw/X4DoxN6wGNB3HyHuybp3WV0IcaknAYKJQ5RWJb4
	8sRYsxXft7o1kE9lndN3vtvXvKEk/UxEBmD5iaZZmFNATMQrDH0QT+4WrV3ZRDgN
	S8wOJiVpBuI6XxSsJLX75wvGMGqa/FWyaEAKaIvK6XkdNd344NvZGWKtB3m5w+nz
	LypRJvognnQhrmHnN4MtrA==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d646vuyv2-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 31 Mar 2026 16:07:07 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 31 Mar 2026 09:07:05 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 31 Mar 2026 09:07:05 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>
Subject: [PATCH v2 10/13] pypi: Add packaging documentation for developers
Date: Tue, 31 Mar 2026 09:07:00 -0700
Message-ID: <20260331160703.3137930-11-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260331160703.3137930-1-rob.woolley@windriver.com>
References: <20260331160703.3137930-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Zqjg6t7G c=1 sm=1 tr=0 ts=69cbf12b cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=SIW4pjiE_UkdO4QYDIoA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: O6iEFQk7aSftRL98mPxhALMsYW9ADpt3
X-Proofpoint-GUID: O6iEFQk7aSftRL98mPxhALMsYW9ADpt3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE1NCBTYWx0ZWRfX1O32HNCALCRe
 BKu+d41bDWhWhPgOGmD6LsrILFReirLJvju+FZkaZ+EUpgCsVPnr/n/qfSV2P1I0bso2x2R4l61
 ENl5FYxHOmIdH+IOScfl/RA8u9/iyIzkxka1rXMXfl8gwoKSWKmu9ezGUxlxax5KsiQs3zxieBv
 75yvQPI+1ZzGYlwotHlKozaeKQXQPz3pSgey4Tr+8Mumaklbrk/bTQmhICq5CJmfu7VzSPzKTiu
 l8ZAkgtxrYeGTzMgqH9Jki7RQikYDX0zuPpqWViNiOgyL1eCLHxE7rcuw+Ec/q1J3WV08ahBQ5r
 ixXARmHZ4dqUHU/wKXxtG0MCe5ivqqXPcGu+XOwFxlP50Nc+TeA7RkiHeTkvWJkd2XOS69httnL
 WQDQ3NO0AWvTDAd4aljR2NhidXFsMaMqEG+acveW12DgUYYcDgzMNhlt26wK+9ONzLKIJyUr46T
 XED2N/4Lh/Q8sNFS6tw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310154
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2026 16:07:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19309

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 contrib/pypi/BUILD.md | 50 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 contrib/pypi/BUILD.md

diff --git a/contrib/pypi/BUILD.md b/contrib/pypi/BUILD.md
new file mode 100644
index 000000000..b12fc0839
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


