Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E677CD128A
	for <webhook@archiver.kernel.org>; Mon,  8 Apr 2024 08:43:01 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.101798.1712565780383344276
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Apr 2024 01:43:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=dl+KP/gT;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=4828a5ab4f=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4385VaCX012592
	for <bitbake-devel@lists.openembedded.org>; Mon, 8 Apr 2024 08:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PPS06212021; bh=XVEKP
	5PmIVMXIeQT4ggGRIvZQ6aMDeULyxQUrlUr1c4=; b=dl+KP/gTNlh7UNnAQQEHk
	YNRUM8694f7qf/83XRPgGab2qqe4lfY9tA0wYk7sNOKpZGJIIMwxIbidaAGIKtF2
	Eaos2SNV2mIDf9TWslvbSm+KHHRFh4+Og7jjQyeMwsoC/6EBmpHOf6UZfY1Y/LM1
	vqwXyUPZhmpDcGs3d83l8gT9qUmeJ7hy8v14aCi3+kIjAw7AB05pe7O81DrCc6ys
	ezN9M5i8OE2fPYXD6ft7Z0iuIZWq3W+FOIKd1jVoSvAR/Pugp+NyL1D0M+ECynI0
	sRB0251wpOYy4LpuxfkaLoCl7bUm0eYzhcR1jd1/Q+V3Vccod4dHMZxKaw6TY5fj
	w==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xaukxsgje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 08 Apr 2024 08:42:59 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Mon, 8 Apr 2024 01:42:58 -0700
Received: from ala-lpggp7.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.37 via Frontend Transport; Mon, 8 Apr 2024 01:42:58 -0700
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 0/1] fetch2/git: Fix File name too long error
Date: Mon, 8 Apr 2024 01:42:57 -0700
Message-ID: <cover.1712565610.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: QHLnhDG4gjqmbyXHKRbCR9FzyaKUf7hd
X-Proofpoint-ORIG-GUID: QHLnhDG4gjqmbyXHKRbCR9FzyaKUf7hd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_07,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=886 priorityscore=1501 spamscore=0 clxscore=1011
 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404080066
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Apr 2024 08:43:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16063

From: Robert Yang <liezhi.yang@windriver.com>

The following changes since commit 110ee701b33600f14e40544bf9354774cd85c5ce:

  sstatesig: fix netrc.NetrcParseError exception (2024-04-04 21:50:24 +0100)

are available in the Git repository at:

  https://github.com/robertlinux/yocto rbt/long
  https://github.com/robertlinux/yocto/tree/rbt/long

Robert Yang (1):
  fetch2/git: Fix File name too long error

 bitbake/lib/bb/fetch2/git.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.42.0


