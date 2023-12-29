Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F16EC47073
	for <webhook@archiver.kernel.org>; Fri, 29 Dec 2023 06:06:54 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.140294.1703830005054045812
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Dec 2023 22:06:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=bLa+Fr52;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=17273a50bb=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BT50A5i023573
	for <bitbake-devel@lists.openembedded.org>; Fri, 29 Dec 2023 06:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=rM5RLxfUIxpILMnW84znBQoeABSq3nMi66zYE5mT4cE=; b=
	bLa+Fr52SzvvpvlfwAJp0K+g1pD3SwGOfRA/ROMoCjgkw9niVyVJzBtRBKWwzCT3
	jjtiKFIRtAHEpFZrkSoAX5NyV9azzIy9qaqECq1wdy8HMdBTTyigS4fShun6o8BV
	+aOcwltAd1o/JdPNqfGdGfJht+UGyhhPgAbD2q+o5IbLogeXRD6rAagQbH0afgsQ
	+0D29oxgnnSWp0udvj5pRnOV1RB9JvFaXTpx7AP4xD63/JX/z5EwITXsez8odD7C
	ZVy0eqEezlk7LMO/2imzN9z1xHZrTU6u279yt9IVTtJkKyDlw5uHjrfOfg2AgEFW
	dK5Ffh9zw3GSyS3IXb9d6Q==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v5mrxw11d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 29 Dec 2023 06:06:44 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Dec 2023 22:06:47 -0800
Received: from ala-lpggp3.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Thu, 28 Dec 2023 22:06:47 -0800
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v3 1/1] bitbake: event: Inject empty lines to make code match lineno in filename
Date: Thu, 28 Dec 2023 22:06:42 -0800
Message-ID: <b64c2496383eb263e6fd2d636ec7a2d88b424db6.1703829627.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1703829627.git.liezhi.yang@windriver.com>
References: <cover.1703829627.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: yzM6PlKDg6h3bE9IzD4Qu7KD4Fn3QOJ8
X-Proofpoint-GUID: yzM6PlKDg6h3bE9IzD4Qu7KD4Fn3QOJ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312290045
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Dec 2023 06:06:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15717

From: Robert Yang <liezhi.yang@windriver.com>

So that we can get the correct error messages.

* In python 3.10.9, the error message was:
  ERROR: Unable to register event handler 'defaultbase_eventhandler':
    File "/path/to/poky/meta/classes-global/base.bbclass", line 4
      # SPDX-License-Identifier: MIT
             ^^^^^
  SyntaxError: invalid syntax

  This is hard to debug since the error line number 4 is incorrect, but nothing
  is wrong with the code in line 4.

* Now the error message and lineno is correct:
  ERROR: Unable to register event handler 'defaultbase_eventhandler':
    File "/path/to/poky/meta/classes-global/base.bbclass", line 256
      an error line
         ^^^^^
  SyntaxError: invalid syntax

And no impact on parsing time:
* Before:
$ rm -fr cache tmp; time bitbake -p
real    0m27.254s

* Now:
$ rm -fr cache tmp; time bitbake -p
real    0m27.200s

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/event.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index f8acacd80d1..7722258b7e8 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -257,6 +257,8 @@ def register(name, handler, mask=None, filename=None, lineno=None, data=None):
         # handle string containing python code
         if isinstance(handler, str):
             tmp = "def %s(e, d):\n%s" % (name, handler)
+            # Inject empty lines to make code match lineno in filename
+            tmp = "\n" * (lineno-1) + tmp
             try:
                 code = bb.methodpool.compile_cache(tmp)
                 if not code:
-- 
2.42.0


