Return-Path: <mark.asselstine@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F2AC4332F
	for <webhook@archiver.kernel.org>; Mon,  7 Nov 2022 16:46:11 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web12.138.1667839569501579759
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Nov 2022 08:46:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=qmziga+1;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8310cc442d=mark.asselstine@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A7Dos4E004348
	for <bitbake-devel@lists.openembedded.org>; Mon, 7 Nov 2022 08:46:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PPS06212021;
 bh=BR/WNfcOKAiUA2mAYRciOwBz0jezhqR8i0McqVGY0N4=;
 b=qmziga+1zS+ayFURab/AqVEuOoj2MYKcTL7b20euS56CX9hfX/f4YwnRlbVquhljSe/M
 tdGPtBcpGRYSjB+qRb9h7vEiyVc6unqvsGnV2Wbafdl3Qr3en0BC58Pw0B0y2KfefA4S
 6sfLEVG2SpDy9IDA8XmHyEJLy8QMU6q79OvIVBfeaMkMBwZqyHU6pch444Oe4cRqZlsW
 dspDgXVGaur8NYVrOBlkTx2DVIU9cMxziMKeC27J9HHEC5qDva04wyjuKMWg0uCOc5zM
 pDrWkZOtfS/sZK/Jh5pyag0tZPVPpqV+J3lrkk3hZw+NOs9hcXZ4Bt358QXOL43nUqJT 7g== 
Received: from ala-exchng02.corp.ad.wrs.com (unknown-82-254.windriver.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3knqbkhkbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 07 Nov 2022 08:46:09 -0800
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 7 Nov 2022 08:46:08 -0800
Received: from yow-dellw-ma.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Mon, 7 Nov 2022 08:46:07 -0800
From: Mark Asselstine <mark.asselstine@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] data: drop unused __expand_var_regexp__ and __expand_python_regexp__
Date: Mon, 7 Nov 2022 11:45:20 -0500
Message-ID: <20221107164520.432783-1-mark.asselstine@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: KjMeCqua3tb1ZyeWCf6MCLcKA8o7JPer
X-Proofpoint-ORIG-GUID: KjMeCqua3tb1ZyeWCf6MCLcKA8o7JPer
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_08,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0 phishscore=0
 malwarescore=0 priorityscore=1501 clxscore=1011 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211070134
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Nov 2022 16:46:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14057

First, commit 81efd77987f6decf256967fa16521a40c14d3518 created a copy
of __expand_var_regexp__ and __expand_python_regexp__ when creating
the initial version of data_smart.py. A while later commit
db1c998b31da06d7f3eb09fc6f59a1915b7b549e dropped all references to
these variables from data.py.

This leaves us today with two versions of these variables in the
global scope. However, only those defined in data_smart.py are being
used, in data_smart.py.

Unfortunately there was no indication in the commit log for commit
db1c998b31da indicating why the variables were left in place despite
the functions referencing them were being removed. Additionally
data.py imports data_smart, thus the versions of __expand_var_regexp__
and __expand_python_regexp__ defined in data_smart.py would be used by
all bitbake code, beyond, potentially, some code in data.py which we
know has no references to these variables.

To remove any potential confusion around these variables drop the old
definitions from data.py.

Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
---
 lib/bb/data.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 53fe3482..4be26367 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -70,10 +70,6 @@ def keys(d):
     """Return a list of keys in d"""
     return d.keys()
 
-
-__expand_var_regexp__ = re.compile(r"\${[^{}]+}")
-__expand_python_regexp__ = re.compile(r"\${@.+?}")
-
 def expand(s, d, varname = None):
     """Variable expansion using the data store"""
     return d.expand(s, varname)
-- 
2.25.1


