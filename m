Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3152ACDE007
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 17:20:32 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12949.1782321622298720958
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Jun 2026 10:20:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=qh/MNyh/;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0635205cc7=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OEegxR2602576
	for <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 10:20:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=imcY5tMdpJQljCCp+n4HfWFsCR0ft6OFKVT9qMI6Opo=; b=
	qh/MNyh/F4Ciz8q1oukXsJPxEemnFEaaxzBAwzeNRpFsTBE++WFVcs1rM3S/bS45
	L9ZYm9N/OJxs60+Xuz4vdwbr7hKCQfkMnfNHe+xvH3Pu0cs8+T8Q2/E4s9aYlDOB
	Df4JECA1y0C30vvAsp++hK6QDklninUJdujSb6dVFR+XeDlYZTGum6uOQHJO6ObK
	XNYJRItNoVQtKgVmj6TpsfOAp+i/hBpz+9MxuF0nPs/WzuMytFNCgCZS80gxctGm
	KHlYtqWiZQdb7x+1X63iZ/vDghhsIOhfjRhleRvUtkJElXZNd3kWmnTu75YQ2giK
	4q7sql6yIjLSr+DDVorO4Q==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eykj1jntn-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 10:20:20 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 24 Jun 2026 10:20:12 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 24 Jun 2026 10:20:12 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Wed, 24 Jun 2026 10:20:04 -0700
Subject: [PATCH v4 04/11] pypi: Add packaging documentation for developers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260624-add-pypi-v8-v4-4-ff499f1fd5a5@windriver.com>
References: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
In-Reply-To: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfX8PNc8QT9ylYK
 OBA6hxNgscMRvEK5hsC7t8sUy6anfSLqSMhyLWThkcdaRODxzZsznwFAFSqdIQZGEJZ1lrjRyFd
 OKSxJWjh2DcS2JwYE2QcOwrJd7ZXOKoTAXFQIjDB3pCyQUNHPhRJ0dPvGpzcv65hPliYZtDK+DM
 e26he6C6btYZvTKvT6+oChcSDD6k8NpnFbKhT62w+UEUmfpgoE6XRIFmzx4634UrmYun/AV9avK
 1vaFvZcHCmK3e1F1fNCQQTh2EhkgFihtMhFt2TLDGDxAXc2geL7CecqLNTVAt1PIj5Zn1zVHATh
 BlNwowXHrCUpSOG/9AzekKLkWWPlx+S8TmRTaGFGSMYC/oXVWFtULV7lRLugPDoG/B7ro6WRWKH
 YS6/hOos7K9is6WMCnxqddXD/b90Bg==
X-Proofpoint-ORIG-GUID: CPEG6bDcxZmTTqKzb5Duulq6q3oBDF2K
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfX1Hz7kjLPhJSp
 ++zkrl+CFb1P1FLF3yMVrDTmynjnSkymUJmw3KlfojY7HDDyZsOH/EEIR4b7XgvPh/fnDXXDVBx
 kyoRDi0vpkDVkYfYYeYU3KE6S8qb2+rn+48QbM0ZdLEUpuT32XFN
X-Proofpoint-GUID: CPEG6bDcxZmTTqKzb5Duulq6q3oBDF2K
X-Authority-Analysis: v=2.4 cv=JNILdcKb c=1 sm=1 tr=0 ts=6a3c11d4 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=SIW4pjiE_UkdO4QYDIoA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240145
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 17:20:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19771

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 contrib/pypi/BUILD.md | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/contrib/pypi/BUILD.md b/contrib/pypi/BUILD.md
new file mode 100644
index 000000000..35a125ccd
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
+cd packaging_workspace
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


