Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B5FC46CD3
	for <webhook@archiver.kernel.org>; Tue, 26 Dec 2023 15:11:32 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.82629.1703603484407371095
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Dec 2023 07:11:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Nhu3jEus;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=072481253f=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BQElaHV019426
	for <bitbake-devel@lists.openembedded.org>; Tue, 26 Dec 2023 07:11:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PPS06212021; bh=I7A/O
	CfuueiEHvx9yt943ZM77t86b1mfqgmBTIDY6zM=; b=Nhu3jEus6ASmdULbMtw/b
	U5QMCOjKTKZdvaJ9UvzjV3ElShXR+i23dLIKwkQOOtyDuJXFMExy4oAf1hj0ypCV
	xC2XnbBLTb8BtViiK2exMq8XhCl4M1lwwoe/rAjjHjHburO3PiP48onBTUL3UikA
	dTH0RQ+eBhaCX169PXOCPygwc+uCcnWGfCzNstDBHDLL9dglrhQsqJiKXkdh1lX8
	QgROVs3jZFqacdZ3g+1p6aXrQSX94/TdgaMUXmgF643EF5ZEfiknMFFkEFUhUxFT
	6vqx6o47FHHUvGP3z/c0FVn4wIxBUAiNqZjJFp4e4G5Ku3dRPX3ULW7vI8h2LVBl
	w==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v5yxm23wx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 26 Dec 2023 07:11:23 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Dec 2023 07:11:26 -0800
Received: from ala-lpggp3.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 26 Dec 2023 07:11:26 -0800
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2 0/1] bitbake: event: Improve error message for eventhandler
Date: Tue, 26 Dec 2023 07:11:22 -0800
Message-ID: <cover.1703602054.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: lGFh1etPv5iCIsQeXg6VHXPYH252JWL2
X-Proofpoint-ORIG-GUID: lGFh1etPv5iCIsQeXg6VHXPYH252JWL2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=589
 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312260115
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Dec 2023 15:11:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15702

From: Robert Yang <liezhi.yang@windriver.com>

The following changes since commit 2d8e0802313ddfc904344b3cff3e0396e0d17fe8:

  oeqa/selftest/prservice: Improve test robustness (2023-12-24 10:39:07 +0000)

are available in the Git repository at:

  https://github.com/robertlinux/yocto rbt/event
  https://github.com/robertlinux/yocto/tree/rbt/event

Robert Yang (1):
  bitbake: event: Improve error message for eventhandler

 bitbake/lib/bb/event.py | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

-- 
2.42.0


