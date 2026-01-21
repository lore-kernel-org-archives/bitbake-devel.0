Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1958DCA5FB6
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 02:47:48 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3866.1768963660538938967
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jan 2026 18:47:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=X8OM2SYU;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=548130ef9c=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L1hetG858135;
	Wed, 21 Jan 2026 02:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=b3oeAljtarYMz1oF5GPqVrshaK3ZzgddU2HF/rfw6ew=; b=
	X8OM2SYU8VoaJLcO0PB9jb6VbyF92ZvqgL7ZPtmp5i60uTczHF3QSTrIyepZ5iKx
	Oap2Hz14SArhlpRmcEZZn9gRtyUPlWBwUTspeKImN8u8f+q9d/VtvA5rkM99zfnC
	sw1jnhEmpG89VDuVqoFHfyVClbr48OOY0u28NRB2heU042QPYXtmFjI30UGO49Nl
	1NbaRiIsm904yIPNbZzHqA+iEaGh9L/L4EYQc0e0nIgZCR5fAEYv7lIvDJOWS9SZ
	xEfk9TiHqVspf2CB0goMQhm/2rBMOXIHdCM13UZN4Gc33jsWkTnuMllTrQfKeHW8
	fLw7T5aJpQDOaPoZZtuEYA==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4btncwg1gg-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 21 Jan 2026 02:47:26 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 20 Jan 2026 18:47:24 -0800
Received: from ala-lpggp2.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 20 Jan 2026 18:47:24 -0800
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 4/5] Add Python packaging files
Date: Tue, 20 Jan 2026 18:47:22 -0800
Message-ID: <20260121024723.2634264-5-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260121024723.2634264-1-rob.woolley@windriver.com>
References: <20260121024723.2634264-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: wqS0tsxwjux4H3GhtZeT8Gsyj8ZnHCJU
X-Authority-Analysis: v=2.4 cv=ecwwvrEH c=1 sm=1 tr=0 ts=69703e3e cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8
 a=Q4-j1AaZAAAA:8 a=v01NFZE1Ztd_FFm_sXkA:9 a=FdTzh2GWekK77mhwV6Dw:22
 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDAyMiBTYWx0ZWRfX81yeAfjk+64W
 WDxdws19S0sYIXrS5LjznbXnDVWnGRxsyyt9TzdKu/fu/ESTViElC5MrR9i+xJs7AaUyRkFWwnJ
 TpMc+qT+i6Y3nIxDaqQ8/fzlUUyDb2TJkVe3tuCmj38rSISRpH0Et3sZBefhcuGyV2wf6MR1tpm
 RbYyxiMV0G5GPo2onphsHTTpj8HH5T9JUIFRoY1YJRvQaTTejaXUBk/hpgXLfjIIZe+7DowUfLH
 7GI2ENtV31auPnxZUHd7CTTTk7tPqPUDDh1CGR2wfUPNb+lDEc8KiA7yg+2jL+1WTEZbUFk91nN
 QsaHPtnXzgI9sS7vXJq/NtUOfcQlb9P6j2keyrVG9iAUOGAInpLBghl+5V4x1FFuSMXtAdWoih0
 VR4n6E6IFIUYpE9Q7aaVo2Yvh0h5IO6aQ2vbVxHclPUfibWP7R5e4LtIRfiw4mhUcLJDfco8BjD
 nxfU7x/1lCEsoskv59w==
X-Proofpoint-ORIG-GUID: wqS0tsxwjux4H3GhtZeT8Gsyj8ZnHCJU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601210022
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 02:47:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18826

This enables creating a pip package for PyPI with:

    python3 -m build

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 pyproject.toml |  3 +++
 setup.cfg      | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 pyproject.toml
 create mode 100644 setup.cfg

diff --git a/pyproject.toml b/pyproject.toml
new file mode 100644
index 00000000..4aff98bb
--- /dev/null
+++ b/pyproject.toml
@@ -0,0 +1,3 @@
+[build-system]
+requires = ["setuptools>=61.0.0", "wheel"]
+build-backend = "setuptools.build_meta"
diff --git a/setup.cfg b/setup.cfg
new file mode 100644
index 00000000..3eaa3c49
--- /dev/null
+++ b/setup.cfg
@@ -0,0 +1,40 @@
+[metadata]
+name = bitbake-setup
+version = 2.16.0a1
+author = OpenEmbedded BitBake Developers
+author_email = bitbake-devel@lists.openembedded.org
+description = bitbake-setup
+long_description = file: README.md
+long_description_content_type = text/markdown
+url = https://github.com/openembedded/bitbake.git
+license = "GPL-2.0-only and MIT"
+classifiers =
+    Programming Language :: Python :: 3
+    License :: OSI Approved :: MIT License
+    License :: OSI Approved :: GNU General Public License v2 (GPLv2)
+    Operating System :: POSIX :: Linux
+
+[options]
+package_dir =
+    = lib
+packages = find:
+include_package_data = True
+zip_safe = False
+python_requires = >=3.6
+py_modules = codegen
+
+install_requires =
+    ; List any non-standard dependencies BitBake needs
+    ; BitBake is mostly self-contained, but check its documentation
+
+[options.packages.find]
+where = lib
+include =
+    bb*
+    bs4*
+    ply
+    bitbake_setup
+
+[options.entry_points]
+console_scripts =
+    bitbake-setup = bitbake_setup.__main__:main
-- 
2.49.0


