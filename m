Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269E0C47073
	for <webhook@archiver.kernel.org>; Tue,  9 Jan 2024 07:45:39 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.11954.1704786335422079151
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Jan 2024 23:45:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=lXLgYbpF;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=17384c4737=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4097damt005073
	for <bitbake-devel@lists.openembedded.org>; Mon, 8 Jan 2024 23:45:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PPS06212021; bh=DWKKI
	r6vDBbKqXvpMrs3jZ0gUqoN11F7w7BeZVFsR2c=; b=lXLgYbpFHbwDs05SgDMAF
	g7h/iQ9KZL+fF2kZc8WNZB8KMAUQsQgjYDVd5UYfrnzYo1LE8m966xc2QqG5/w/p
	0e1GHxFqiB5MCinfMWAu6rEwfdeu7xBWY1XlTaMB/jYdG9hca7Of7s/oCeTe0L6C
	84PBYDgDcPUO/YGL3hR7pPVg60DX4eYNFSWB+csJsAum5hHILRpprvEap5Cf7G6J
	Dv8gOtE32KUUaBcXInQ5mZzzSsOQACM77zcKfQ5sdd3ZsTtI3Pk0pxX/2FN7p7Cx
	4sku1SRWnWDd9YolT28SkC3+mGr8oN9sEegpkJCUkdoIVQ3AFw3cZqpZdbb1ibaH
	w==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vf78makn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 08 Jan 2024 23:45:34 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 23:46:08 -0800
Received: from ala-lpggp7.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 23:46:08 -0800
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v4 0/2] event: Inject empty lines to make code match lineno in filename
Date: Mon, 8 Jan 2024 23:45:32 -0800
Message-ID: <cover.1704786173.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.35.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: h81Jg6echs79_uh7r6xrL4CfeVP7pX7C
X-Proofpoint-ORIG-GUID: h81Jg6echs79_uh7r6xrL4CfeVP7pX7C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090059
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jan 2024 07:45:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15754

From: Robert Yang <liezhi.yang@windriver.com>

* V4:
  - Check lineno is not None
  - Add a testcase for it

// Robert

The following changes since commit 070aa227057e4913cf77c2465393a5a8398d5641:

  bitbake: toaster/tests: Delay driver first action on create new project page (2024-01-07 22:59:55 +0000)

are available in the Git repository at:

  https://github.com/robertlinux/yocto rbt/event
  https://github.com/robertlinux/yocto/tree/rbt/event

Robert Yang (2):
  bitbake: event: Inject empty lines to make code match lineno in
    filename
  bitbake: tests/event: Add test_lineno_in_eventhandler

 bitbake/lib/bb/event.py       |  5 +++--
 bitbake/lib/bb/tests/event.py | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

-- 
2.35.5


