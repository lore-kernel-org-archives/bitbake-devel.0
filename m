Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD40D262BE
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 02:47:48 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3864.1768963660311041026
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jan 2026 18:47:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=d67XGknd;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=548130ef9c=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L1hetC858135;
	Wed, 21 Jan 2026 02:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=XCsg31b74
	/Dl4KFl/Xe7a5d4iMOVuT2QXouqmnUZ7VM=; b=d67XGkndN/EvpScsl5J7/q3nD
	Y4ZAKsGmLW9V3QkqFovKiDn7Zw2aUevTtuDlE+/C9NCXaRKgIiQSNey8vTjCTILW
	jlFJ6p+agY3fd76qhGP6N4Y7/K6hEcv7iUUrwOuupzVk8kK8zMHVS0E3fApuOktQ
	dBkZRFeHrWzXbL3Hp4OW70AkAMEixh+sD3zsMpuZ4gpNVssKypaMuAiTL6pPyp96
	OoduMuAh6eCVraHnHPOKwPViw1Q6JE1f0X/pkhEm7dQm1G0WkdwZM1SD0PGSvy+3
	DccZuFoadDsyN8Gh85zsmGFDfDJsbJXH+5xPTXnZVq1stPxzc/yxUYDDaQX0g==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4btncwg1gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 21 Jan 2026 02:47:24 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 20 Jan 2026 18:47:23 -0800
Received: from ala-lpggp2.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 20 Jan 2026 18:47:23 -0800
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 0/5] Package bitbake-setup for PyPI
Date: Tue, 20 Jan 2026 18:47:18 -0800
Message-ID: <20260121024723.2634264-1-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: oiEUvTdHF6P3vxeZ2LlEBFBYM9PZpq71
X-Authority-Analysis: v=2.4 cv=ecwwvrEH c=1 sm=1 tr=0 ts=69703e3c cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Q4-j1AaZAAAA:8
 a=t5WWjRASgVkVwoJ9gTsA:9 a=9H3Qd4_ONW2Ztcrla5EB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDAyMiBTYWx0ZWRfXz7VTk1LpZ2kE
 qaaJf/Hpj6fU6fhu9+Q9HIZSf3nUN+iOm591tDdHdBwmO8a737GAtigyFafsIm4fp7itrt0UKJ+
 Zn3actialHhk8oISVkeqpUAnlF3RTjCsJM7uBKCYz+tlLxqbvZPwffF7K8T9Bp4Zzk8mqFG2mJy
 LQd8kRCQZip+b27/oRPAShnQRT9xZmnPCxwvCa3q2gEmALjMZqrd0c2FDYUSG7eZP3Yoh18/G7v
 YiV+xCJgriq4INlegvGfAkdBzV1uRG4GCaf2jwE1aB5OenJktoCevxiW9JyUKFaLlOkYtFohMjq
 57aUTo6TRGvMI4fcYCDkYcdfdPclXFwFwCxgXFlBE3+WgzIuA5o9Gl/Z5DE6ffz3oGfFvUFuJKa
 wo89nNCDUfhBj36/SNXrx1qOIDjZ36/jCu+8jNGqwqN0CelzFTaXqGNf5+E4F6iIFwGuc5JUCCz
 KbD61DPOSIez8X+uAjg==
X-Proofpoint-ORIG-GUID: oiEUvTdHF6P3vxeZ2LlEBFBYM9PZpq71
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1011 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601210022
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 02:47:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18825

Adding bitbake-setup to PyPI is helpful to developers who are already
comfortable with using pip in their workflow.

This series makes the necessary changes to build a wheel that may
be uploaded to PyPI.

The build sequence would be:
    git clone https://git.openembedded.org/bitbake

    python3 -m venv venv
    source venv/bin/activate

    python3 -m pip install build
    python3 -m build

This produces a wheel (.whl) file in the dist directory.  This may
be installed using pip.

Testing included "Setting Up the Environment With bitbake-setup" from
the Yocto Project manual. As well as testing the ability to build
using local configurations.

    bitbake-setup init poky-whinlatter.conf.json

For each scenario, a build of the core-image-minimal recipe was built
successfully.

Rob Woolley (5):
  gitignore: ignore Python packaging files
  bitbake-setup: Move into Python module
  bitbake-setup: Add wrapper script for bitbake_setup module
  Add Python packaging files
  bitbake-setup: Add the conditional script stanza

 .gitignore                    |    2 +
 bin/bitbake-setup             | 1108 +-------------------------------
 lib/bitbake_setup/__init__.py |    0
 lib/bitbake_setup/__main__.py | 1110 +++++++++++++++++++++++++++++++++
 pyproject.toml                |    3 +
 setup.cfg                     |   40 ++
 6 files changed, 1160 insertions(+), 1103 deletions(-)
 create mode 100644 lib/bitbake_setup/__init__.py
 create mode 100755 lib/bitbake_setup/__main__.py
 create mode 100644 pyproject.toml
 create mode 100644 setup.cfg

-- 
2.49.0


