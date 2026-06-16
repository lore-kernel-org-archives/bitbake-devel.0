Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6A2CD98D2
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 21:31:49 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1855.1781645508705117995
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 16 Jun 2026 14:31:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=AZc/RJq4;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=062707f644=rob.woolley@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GLVM0h495812
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 14:31:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=9XhUG96xPVVprIE6Q/aZgWeUnQlMzVjQRWNStQ4rdz8=; b=
	AZc/RJq4eUIpl3UXGzSp/XC/+mhKHWVM3ZHSYTU/gEsadr3jm52ZtM6/NE3gx+XQ
	9SGQGIpA4gyHNosmm0Bdo5ZpUS36u5G8Ve5krPyAw8QnIinM3CDTH9HXC5Fqsi/S
	VuJKytCRFzYZP0/DqK654RvSVHIG3x4QB7EdBRv2rGFG3Mf0Vc2vh8ojBP5p5uru
	+1Vv3EkxVYYbBoeWsNCK3p5Q53IZ/AM+gYUXDFB0BKb9BWsZ6iUWOMKWNK2Yu96T
	ZwpWp2I3ZL82Fv1F5q7n+pS5xP3OxKxhiR7Kt3ubHonHddlCDgZKISY8Kogw2Ued
	p/qlhrw+MV15Vfnk449RQQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eueft0012-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 14:31:48 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 16 Jun 2026 14:31:46 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 16 Jun 2026 14:31:46 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Tue, 16 Jun 2026 14:31:28 -0700
Subject: [PATCH v3 08/10] pypi: Add packaging documentation for developers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260616-add-pypi-v7-v3-8-fe224e3ba878@windriver.com>
References: <20260616-add-pypi-v7-v3-0-fe224e3ba878@windriver.com>
In-Reply-To: <20260616-add-pypi-v7-v3-0-fe224e3ba878@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: QS4E9u1knP_bXWncD3RDkYUUTr9SEWrQ
X-Authority-Analysis: v=2.4 cv=B+2JFutM c=1 sm=1 tr=0 ts=6a31c0c4 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=t7CeM3EgAAAA:8
 a=SIW4pjiE_UkdO4QYDIoA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: QS4E9u1knP_bXWncD3RDkYUUTr9SEWrQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDIxOCBTYWx0ZWRfXyPE7XkCxwLzR
 Z08KD0iT2mP++oTMGIQuKiLFw7plzXkLT/uHSAtqXL53Sunc4DcGJ698BxreWHtEJVqfGsE1ohm
 WH9yUFkT4YQtfDLvCLGPWRi03WxU2aSAVWMXrIlhTewS7AHhWi4X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDIxOCBTYWx0ZWRfX3bs0bE4BZ+1Z
 aK5Sg3NhIlA76ev+Xpd4HVhdMxLa3VhPw8AQOZI8Oi0yLH7D9wtbzICKO2xeP65+yE21Ap5ZNs7
 CUuMK2D1tQGb/ze8bpUq9v0e7FejWetKPu5FvtFyURl3+BxHBVRC5xdt0yQRUhGw93Yc2QrjTpB
 F1y64c9tCqHdsSoqFaHG90i7xcjbt8KQyEcg7/tG4V8aKoD975Cbuu6s8l0sVqrPsUWJPnV5FDN
 RFZ/UDj5lDo9GUc5J+gb24XFqQA0bDqmJoc3r2ySpUID4zfYIW11TuqH1JEsVfqFz0/+eucmVPX
 qkGFQRNYfPyXayTYdj+a/qqeqT2dtWIFV0VKrXRBU2hWakwvVoQjcYNGEToOdF9ivX3PJGuzO9+
 GcvLUiCz/GtCJtOw6EGzvUEF/Xga5eWSRRtRkcOA9yi2W2UwWlfN9EdQWqL9LE1zKefBwhuSrq2
 HCeeEdvSYmNM10VCDeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606160218
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 16 Jun 2026 21:31:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19721

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 contrib/pypi/BUILD.md | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

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


