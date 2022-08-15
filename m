Return-Path: <mingli.yu@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CF2C00140
	for <webhook@archiver.kernel.org>; Mon, 15 Aug 2022 08:46:50 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web12.14505.1660553191844028019
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Aug 2022 01:46:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=CQmDtYDs;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=5226de2e5d=mingli.yu@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id
 27F8bRYM010366
	for <bitbake-devel@lists.openembedded.org>; Mon, 15 Aug 2022 01:46:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PPS06212021;
 bh=LBmmk86Cp1bU95vDk6Vtd8Nsg2usBwxR7KES6VSUHtY=;
 b=CQmDtYDsRjF13dzkAN9kiha9TZcj92iv/PJR08LTy6FhPTNxY7w2X0iK9NvOcX+qvypK
 V0zyXhgmH51RNICS1CAeP9wIv8F1evIwCRu8yoDbCvmqIx4LENQA0UnhD9bDXD0EeZIN
 Q31u/h92KlH+82kv05TPdg9MjxVynCax2TWuAifVyqxCCVwf3Ev0CX5zOiaY9tvxrpkf
 7uHThOt7kRlnKTouY23RzoUuRNl4IOMpcCLQicHCF6djaDJURqwrDpPEFJWUF81paVfm
 GjeN04hLAxTFpKeGa2OQswnDin6y2djnn4XDBfYjU4QXH4BEnq3KrEiNJZYvDD1roJTd vQ==
Received: from ala-exchng01.corp.ad.wrs.com (unknown-82-252.windriver.com
 [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3hxbfjh7x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 15 Aug 2022 01:46:31 -0700
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 15 Aug 2022 01:46:30 -0700
Received: from pek-lpg-core2.wrs.com (128.224.153.41) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Mon, 15 Aug 2022 01:46:29 -0700
From: <mingli.yu@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH] fetch: use BPN instead
Date: Mon, 15 Aug 2022 16:46:29 +0800
Message-ID: <20220815084629.30843-1-mingli.yu@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: mQy-jqUXFBhqr-rZC95HiavKGIn1P2MH
X-Proofpoint-ORIG-GUID: mQy-jqUXFBhqr-rZC95HiavKGIn1P2MH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_06,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=2
 mlxlogscore=865 clxscore=1011 phishscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208150030
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Aug 2022 08:46:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13896

From: Mingli Yu <mingli.yu@windriver.com>

When checking for the non-existing file, BPN is actually the acutal recipe
name. And we should use BPN for the error message and it also fix the below
test when multilib is enabled.
 $ oe-selftest -r bbtests.BitbakeTests.test_invalid_recipe_src_uri

Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 0fb718b2..43d07e56 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1236,7 +1236,7 @@ def get_checksum_file_list(d):
             if not found:
                 bb.fatal(("Unable to get checksum for %s SRC_URI entry %s: file could not be found"
                             "\nThe following paths were searched:"
-                            "\n%s") % (d.getVar('PN'), os.path.basename(f), '\n'.join(paths)))
+                            "\n%s") % (d.getVar('BPN'), os.path.basename(f), '\n'.join(paths)))
 
     return " ".join(filelist)
 
-- 
2.25.1


