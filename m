Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5FDC67861
	for <webhook@archiver.kernel.org>; Mon,  8 Apr 2024 08:43:01 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.101528.1712565780461813169
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Apr 2024 01:43:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=DJ1y6WVa;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=4828a5ab4f=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4385rxqJ030602
	for <bitbake-devel@lists.openembedded.org>; Mon, 8 Apr 2024 08:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=vZhurdDjPWXSotmwdAnsMjn1AXv1wzs0v58VUovmMmk=; b=
	DJ1y6WVaw19TXZJfcbTm5xaH59fIlaFKappWBXN9xAtfb1s445hzS1pkEJLK568e
	fA0N4zBUMpRtUnnEPQsfStiT0US2SdhOXeml/Vh0yOh+/gQmFCqGyiUzdAgTD9LD
	sIHn8tiMX5vUi40RF0lqu5Xjo2ry0aJG1F8gTIvPnPOBAAUosOL4qh2B6fgGSOTZ
	jxHFrfOGQi46eT1myA35GjNbb1SNj0ZCN6p62TuwGFg6hfyL1JQS1vtaQonap/vm
	RXLnOH3Vp7YPd82wQ49fDDyNnILas7IywZD+q1rTp9qAn9jBiMgVIz/c4WeU8WTB
	ro7iqA9cAjaslPvRJ5qEnA==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3xawc6hf4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 08 Apr 2024 08:42:59 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.37; Mon, 8 Apr 2024 01:42:58 -0700
Received: from ala-lpggp7.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.37 via Frontend Transport; Mon, 8 Apr 2024 01:42:58 -0700
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/1] fetch2/git: Fix File name too long error
Date: Mon, 8 Apr 2024 01:42:58 -0700
Message-ID: <02074341b8914bf7d1bf44291ec50a77853a4c5b.1712565610.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1712565610.git.liezhi.yang@windriver.com>
References: <cover.1712565610.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 71lKygjGktzgfGHPxAQ5MFQHZD69Owxc
X-Proofpoint-ORIG-GUID: 71lKygjGktzgfGHPxAQ5MFQHZD69Owxc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_07,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=933 impostorscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080066
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Apr 2024 08:43:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16064

From: Robert Yang <liezhi.yang@windriver.com>

There are "File name too long" errors when local PREMIRROR/MIRROR
is in a deep directory (len(path) > 255 (The NAME_MAX)).

This is becuase ud.path.replace() changes the path to filename, and
the errors when happens when len(path) > 255.

Use hashlib.md5(ud.path.encode('utf-8')).hexdigest() can fix the problem and
avoid potential file name conflicts, now the files are like:

$ bitbake mtd-utils-native -cfetch
$ ls downloads/git2
1625d71bc771b3c4d479337faeef324f.git.infradead.org.mtd-utils.git
git.infradead.org.mtd-utils.git -> /path/to/build/downloads/git2/1625d71bc771b3c4d479337faeef324f.git.infradead.org.mtd-utils.git
git.infradead.org.mtd-utils.git.done

The 1625d71bc771b3c4d479337faeef324f.git.infradead.org.mtd-utils.git is gitsrcname.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/git.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index c7ff769fdfe..7ed51af336d 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -83,6 +83,7 @@ import subprocess
 import tempfile
 import bb
 import bb.progress
+import hashlib
 from contextlib import contextmanager
 from   bb.fetch2 import FetchMethod
 from   bb.fetch2 import runfetchcmd
@@ -277,7 +278,10 @@ class Git(FetchMethod):
                     ud.unresolvedrev[name] = ud.revisions[name]
                 ud.revisions[name] = self.latest_revision(ud, d, name)
 
-        gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.').replace(' ','_').replace('(', '_').replace(')', '_'))
+        if ud.proto == "file":
+            gitsrcname = '%s.%s' % (hashlib.md5(ud.path.encode('utf-8')).hexdigest(), os.path.basename(ud.path))
+        else:
+            gitsrcname = '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.').replace(' ','_').replace('(', '_').replace(')', '_'))
         if gitsrcname.startswith('.'):
             gitsrcname = gitsrcname[1:]
 
-- 
2.42.0


