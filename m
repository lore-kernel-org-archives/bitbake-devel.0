Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632C5CDB47F
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 17:20:42 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12960.1782321632449200939
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Jun 2026 10:20:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=GSdiauPE;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0635205cc7=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OEegxX2602576
	for <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 10:20:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=9c/U7jnamgo5eaNZ4JJAHRY/a2/keCC6TXSZGXyC2ME=; b=
	GSdiauPEAyhAY3X5JgSVFleuAzrosHmnR9ANm2yuU1GpJK2wkul9pjAFxIy/1Whs
	xl2gyF/KXHOEchBuGp/dBpMDpwLEOTvDRnCkrufaJSJFu8Iql9Zi2bivYXcj+bQo
	nBDH66kuwd5RqHciFy49vT9lD7HzpzMXtAawfbWzeYlHN/SUyGXhk3xqHQoxAITq
	m/HmbNyJrrawfImCsH2/zEYbpHCKuhxaW+GLukSzwD+b+iHX6FC1KO6SL8XJ62/Y
	/x3+ghpL8D8yalaOraDtZ+YfvLSly9hFLHJHsNuBowcpxhAvmFw2KyUaupcHs+to
	sAYQEuzm+1VNYY5nJnEqbw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eykj1jntn-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 10:20:31 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 24 Jun 2026 10:20:13 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 24 Jun 2026 10:20:13 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Wed, 24 Jun 2026 10:20:11 -0700
Subject: [PATCH v4 11/11] bitbake-setup: Add exception for E402 for
 bb.__version__
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260624-add-pypi-v8-v4-11-ff499f1fd5a5@windriver.com>
References: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
In-Reply-To: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfX+TOb7B6ZC/7H
 qk8wNEy7gbkRlyhTplPozWyp5fFg8gTO07gHX46mPIzsXWpeq3Y9aEOFTDLcbHZQ6COmXphOXcv
 w+826/m5BZSOBKMMreyPUmvrpLvhaYKMgjpzizVmj8HWlUFm5yJZQyMg7gWE/ZM74r9obT8gce6
 MWWTB4FU8+BfFMIKkmaY8X49inyQJJek1LhqRv0gy+iXsmVDYWtsog3OBfoPYiFNAmaM2l4NIAG
 TEiu1DxoMEis6i5CiO2Nj7rpYkB0lzqSGI02MfYgbbzXmX+cXeNtUfC0j42kxTOUbIg4eWvKdHO
 0qzRvSkn5S2gdodzx1p012y7UfOgRc+gFS6p+X8aqgvv9+Wn95b8AQtGeETklXv6ZpycAiDtLTm
 NRVBTmcSaHN+8UJDTq/1K5vK7rTOQQ==
X-Proofpoint-ORIG-GUID: vzUHnYZnBkCP1mHxzj8JP6YJ-WZ2d5QO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfX4LEXFzAJ4P0L
 83gKaxzydnaxLlipnvH+wTaWxl/LtFejGgRpLGfdTroAU+USjQESWRxFUqsfkHnap74r0uN0i49
 /QXmqmu5XPWLF2TZdByhM53zPeImconOzykprF5A04za1F3wHJj8
X-Proofpoint-GUID: vzUHnYZnBkCP1mHxzj8JP6YJ-WZ2d5QO
X-Authority-Analysis: v=2.4 cv=JNILdcKb c=1 sm=1 tr=0 ts=6a3c11df cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=HT31Qwe42N0YAzBbpOIA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
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
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 17:20:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19777

The ruff linter reported:
    E402 Module level import not at top of file

Add an exception for bb.__version__ to match the other imports
that are happening after the modifications to sys.path.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 525187ddf..ce80809e7 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -28,7 +28,7 @@ sys.path[0:0] = [os.path.join(os.path.dirname(bindir), 'lib')]
 
 import bb.msg  # noqa: E402
 import bb.process  # noqa: E402
-from bb import __version__ as libbb_version
+from bb import __version__ as libbb_version # noqa: E402
 
 if __name__ == "__main__":
     if __version__ != libbb_version:

-- 
2.49.0


