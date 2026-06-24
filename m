Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DA2CDE002
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 17:20:32 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12749.1782321624764431472
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Jun 2026 10:20:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=L0xtAR6Y;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0635205cc7=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OEegxT2602576
	for <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 10:20:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=oDv9X9weBwQUpIx/I9WQodEEmFSBZ+IFbGQOmzBlkWQ=; b=
	L0xtAR6Y6tWFCrOEzlZAPozUFgzOVzPGPcR4w+gREuvIGDFKP4UL/4whNihwdW1l
	UTlwys3w+70TFyEEljBMkCW9VOCcqcEGE686w6jU9GpQaCA7b4P2ThpJwW6uXxW3
	XXfArW1ykhGNCNhDwB/iaLnebG801CrLjgLlVx+KkDej4GOD63+H3ptutrIgAhD9
	CDvWM0TDyxxdoY6pFGuqoaV4wRwyEYgmobAATe7mwkXZvVKEWXFtaQn/qYY3T6VP
	+suWVtEaecaXAuzb9z0aWGASaGi0Yy5es3V9JA0u04mzMissEuIk98Fnupr9IPCW
	Si1DFap+OsjwOB2cZuSlQQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eykj1jntn-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 10:20:23 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 24 Jun 2026 10:20:13 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 24 Jun 2026 10:20:13 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Wed, 24 Jun 2026 10:20:06 -0700
Subject: [PATCH v4 06/11] Add pyproject.toml and vendor.txt for vendoring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260624-add-pypi-v8-v4-6-ff499f1fd5a5@windriver.com>
References: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
In-Reply-To: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfX8d+NrTtUFi5M
 uvkSwXxaMJpe/07Lsv9zLmlmzrxmGkM6+ljFHL7Rg+/5JDmg1dXcwVveCzyuBCQIncoCYwHlF7K
 913Hat6KoKvnmYv89Y3D5zA9PnAUz4jh5LdujbIOq9C9UfAetZOAyPpjtFro9KeE7sK5B3P1rx9
 PalXjPkhGSRpu22WR5t8arRe+IcU+D6wRAYmUZ2MdwOYILTz4WUv8oMm2iSuxm6EzXGG9YoI1Ja
 oiRBOTJleRBW0c0OfxGeEyCMtW+tB7g04kY2yGvvlEivmSILokjyca7WDLaZ6TJIQAJlbcO2JQs
 ebwpRTmVf06tZeNXixPRRRYbL1dL8oJOOzVEMqA1cLcNMEP+2P1DThxVcVO5jws/H/MkBjI7G6Z
 4dr/GkOV+KIwL7+WmKnjn1n8Impl0Q==
X-Proofpoint-ORIG-GUID: pA7mLl6ZN2p9rTx6DAgajlgV7wSKjQZ0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfX6bznFcP/UHBV
 w7dVeqyFCQiVpcidsfe77tcqIVWJplDJ+82TOE1IKvGxA/jebvz1emxLh9ElhtX8GCynBB6robQ
 xjBwHTzGOeuXCKpHnbgLzliAprUb0cn/U90TGMRRc36MZKbvHO/u
X-Proofpoint-GUID: pA7mLl6ZN2p9rTx6DAgajlgV7wSKjQZ0
X-Authority-Analysis: v=2.4 cv=JNILdcKb c=1 sm=1 tr=0 ts=6a3c11d7 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=-SJoDt46AAAA:20
 a=t7CeM3EgAAAA:8 a=adcO8tCN0-mKZzeWj3YA:9 a=QEXdDO2ut3YA:10
 a=FdTzh2GWekK77mhwV6Dw:22 a=bA3UWDv6hWIuX7UZL3qL:22
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
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 17:20:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19773

Used for updateing the vendorized modules with:
    vendoring sync .

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 pyproject.toml | 19 +++++++++++++++++++
 vendor.txt     |  4 ++++
 2 files changed, 23 insertions(+)

diff --git a/pyproject.toml b/pyproject.toml
new file mode 100644
index 000000000..93508d92e
--- /dev/null
+++ b/pyproject.toml
@@ -0,0 +1,19 @@
+[build-system]
+requires = []
+build-backend = "setuptools.build_meta"
+
+[project]
+name = "bitbake"
+version = "2.19.0"
+
+[tool.vendoring]
+destination = "lib/bb/_vendor"
+requirements = "vendor.txt"
+namespace = "bb._vendor"
+patches-dir = "vendor/patches"
+
+[tool.vendoring.license.directories]
+ply = "vendor/licenses/ply/LICENSE"
+
+[tool.vendoring.license.fallback-urls]
+ply = "https://raw.githubusercontent.com/dabeaz/ply/refs/heads/master/src/ply/lex.py"
diff --git a/vendor.txt b/vendor.txt
new file mode 100644
index 000000000..c60d43092
--- /dev/null
+++ b/vendor.txt
@@ -0,0 +1,4 @@
+beautifulsoup4==4.15.0
+ply==3.10
+progressbar==2.5
+simplediff==1.1

-- 
2.49.0


