Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9214C44509
	for <webhook@archiver.kernel.org>; Thu,  9 Jul 2026 02:03:56 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.400.1783562631873754580
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Jul 2026 19:03:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=qb/LrBzw;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=1650fcb189=rob.woolley@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6691gLpj1094724
	for <bitbake-devel@lists.openembedded.org>; Thu, 9 Jul 2026 02:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=RuqHvYKVT8QcNCoUqneF9Nb2cb8hPdet73hbaRJyUG4=; b=
	qb/LrBzwx+rW0hUK8JfcSlxkDNRLbX3FSbP3fRoIYjR6vvZeTez0d+/BdgMsBxLJ
	dYUkw02seid6UARydtXHadAtzB3R/zAl4UTTIaHaj5K1N6d9PvgRnWzjHbXko+TV
	eU1M2GhmfXKuWKrA0R/cYaVYrrncLM4ZMEmWWRZAOUG8oo7tftNYZeCFaSryKuuj
	bcRjLATHYgl9pOGCBekPWFNnU8WiPoebJPeiGmr5n+ofVwx+1wk4cCvDCMvslyU5
	cC05uedDUDRYJa4+vVy+O5L87z0qxFLQR1U7ZGI0ROz8wTbNqvtzbLKQXIowC9w4
	KQ4mbv7jufBXkHdikVy/nw==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fa1h202nm-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 09 Jul 2026 02:03:50 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 8 Jul 2026 19:03:48 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 8 Jul 2026 19:03:48 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Wed, 8 Jul 2026 19:03:35 -0700
Subject: [PATCH v5 3/9] pypi: Add packaging documentation for developers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260708-add-pypi-v10-v5-3-7d5f457f4b9c@windriver.com>
References: <20260708-add-pypi-v10-v5-0-7d5f457f4b9c@windriver.com>
In-Reply-To: <20260708-add-pypi-v10-v5-0-7d5f457f4b9c@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a4f0186 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=t7CeM3EgAAAA:8
 a=IFS6wosHp3F-r_7qPvIA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDAxNiBTYWx0ZWRfXwd9N5ppkXNLR
 hDgo5R7CpB/bTJeRGqaAAac083ZEANHqWp9+6aZK92jgNxm9lgwKO6gRPcyc0+CVeT9Mp6bzS8T
 7Xxpt7+iBzjxkBF4esYbPsZKaF3rJdxKKK0Bvh/QsYvMrruW8Iyp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDAxNiBTYWx0ZWRfXyLyU8p9Hgw51
 BFpq2MbnI6Uxx4qmB1KkrLT25wENzeY8Aj88AuLUHbsGXLmKqrxB3bbQpMQkuSBiIke1c1F5Exn
 ODUj1Kb3dW+l+GpbXjFhJRlVyuIINHqWD1soFt7GU5uz/9yTZOVQp5V930VLUq3+gHo3LyZT1Pl
 pLsgVw7PVEEL+/XPPD7yBJsgFUrKKoJ/3LTQJmCJA1WWJ8tW5SleOUAFcQ+xDO8Ajk8n6WqLiuo
 tWB47PMLbkH44E57S03q0nObO7eeVcbe5ECX0BaONwKzAaUBgRq0bqjK9YRa3AlNeEYalw+0zLJ
 IF9ITTBZIaA7pyj1SNv10pI42+1RcUFYZkyOyzuq7WXZ2xtG04HsaRMXX0FRuGILo4QOTnJb+DB
 ky4Ee9KvgEHSgdB6EP0OYHRKJh5syw7iLUrNuuxRTgsdNODHowLhS5aO4bMtkulo7J4tXuwsEme
 7RUxSTZITOBDa43lnGg==
X-Proofpoint-ORIG-GUID: hnAX8qSy0iEyvD5o8H98YU2WgyGf99wX
X-Proofpoint-GUID: hnAX8qSy0iEyvD5o8H98YU2WgyGf99wX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090016
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Jul 2026 02:03:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19824

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 packaging-pypi/bitbake-setup/BUILD.md | 67 +++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/packaging-pypi/bitbake-setup/BUILD.md b/packaging-pypi/bitbake-setup/BUILD.md
new file mode 100644
index 000000000..adb8d1839
--- /dev/null
+++ b/packaging-pypi/bitbake-setup/BUILD.md
@@ -0,0 +1,67 @@
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
+ruff check bin/bitbake-setup packaging-pypi/bitbake-setup
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
+packaging-pypi/bitbake-setup/package-bitbake-setup.py
+cd packaging-workspace
+```
+
+### Updating the vendored modules
+
+You may use the Python vendoring module to update the vendored modules. Its configuration can be found in the pyproject.toml under the tool.vendoring section.
+
+This information includes:
+- the destination directory where the vendored modules are stored (e.g. lib/bb/_vendor)
+- the module names and versions to vendor are found in the requirements file vendor.txt
+- the namespace to place the modules in (eg. bb._vendor)
+- the patches to apply to the pristine source code (eg. vendor/patches)
+
+To run the tool you may install it from pypi and run it from the top-level directory.
+
+```bash
+python3 -m pip install vendoring
+vendoring sync .
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


