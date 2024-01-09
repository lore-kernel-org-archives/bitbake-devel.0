Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BFCC47079
	for <webhook@archiver.kernel.org>; Tue,  9 Jan 2024 07:45:39 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.11955.1704786335721458980
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Jan 2024 23:45:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=oGA7zhdp;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=17384c4737=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4097damu005073
	for <bitbake-devel@lists.openembedded.org>; Mon, 8 Jan 2024 23:45:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=UVYm9e3gsQp81KCoSBtf7qasryyfm3jHpDtFkX6oECM=; b=
	oGA7zhdpvCKQxi247ukopeLyCkVKDGmdkzamL5NohDDpVmkuu+N7dW7lVv/H5TEf
	jiqz5FCPf2HKMl3O1WY7H7wIY/C9tBvSfaXEkh4i+cIs9o6xiG3TcaB2WdzPkTaI
	vPyM3+ILRxsdZNnbrtYP8GIOi/M9a1bIOhUo2gBFIrIksyo6n6Wmt80c64rzxdfF
	Fji30EpUFEd4cO/vMztLkNCVYTH7gkQ/BxvD4RUYPiB+0opUCu2JH92HoMKUDytX
	x71ASahKJT/41QiMxbdDl0jRdFBegg8Q1MfJrsUUN0V4fbNBo638ShqkYs02YxsA
	jbQqpe3NYhTmOPZUl3Z2Qg==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vf78makn3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 08 Jan 2024 23:45:35 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 23:46:09 -0800
Received: from ala-lpggp7.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 8 Jan 2024 23:46:09 -0800
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v4 1/2] bitbake: event: Inject empty lines to make code match lineno in filename
Date: Mon, 8 Jan 2024 23:45:33 -0800
Message-ID: <69a77d4ef02fa6da92e7aca5457d7e03eb46959d.1704786173.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.35.5
In-Reply-To: <cover.1704786173.git.liezhi.yang@windriver.com>
References: <cover.1704786173.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: olHa8CsyIhIA64N2KmZkBZBKZCJO_MPe
X-Proofpoint-ORIG-GUID: olHa8CsyIhIA64N2KmZkBZBKZCJO_MPe
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15755

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
 bitbake/lib/bb/event.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
index f8acacd80d1..4761c868800 100644
--- a/bitbake/lib/bb/event.py
+++ b/bitbake/lib/bb/event.py
@@ -257,14 +257,15 @@ def register(name, handler, mask=None, filename=None, lineno=None, data=None):
         # handle string containing python code
         if isinstance(handler, str):
             tmp = "def %s(e, d):\n%s" % (name, handler)
+            # Inject empty lines to make code match lineno in filename
+            if lineno is not None:
+                tmp = "\n" * (lineno-1) + tmp
             try:
                 code = bb.methodpool.compile_cache(tmp)
                 if not code:
                     if filename is None:
                         filename = "%s(e, d)" % name
                     code = compile(tmp, filename, "exec", ast.PyCF_ONLY_AST)
-                    if lineno is not None:
-                        ast.increment_lineno(code, lineno-1)
                     code = compile(code, filename, "exec")
                     bb.methodpool.compile_cache_add(tmp, code)
             except SyntaxError:
-- 
2.35.5


