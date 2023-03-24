Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D1AC76195
	for <webhook@archiver.kernel.org>; Fri, 24 Mar 2023 07:09:15 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.95729.1679641745989581075
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Mar 2023 00:09:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=pcPP7vTy;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=244794046a=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32O71reX016395
	for <bitbake-devel@lists.openembedded.org>; Fri, 24 Mar 2023 07:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PPS06212021;
 bh=1oSuptLPxxTKKSIRmGjr8FzZh1IsdI793PC9LObNVUg=;
 b=pcPP7vTyvRmWhgfcYYV4cMHIZIQaqeo+OeRPxmE0bJ939d88RjmSiKLenE6QGxicbQnx
 4S830VvO+820re2gwGhb2SRDTC7Wzi/Gby8R5PMJAUWwqPEdZb/jKMMmBr3XKkJJpnEh
 1GQk3y7j3oP/QGf3QBNMv+ZKg8a0FkX6Fwsu+m/tyUk+yY6EeAFAl0hoCJA/mmW8P/J4
 kXecqKvhhLCUwDZB+hJUG6BbFvFCYdRIu2fJVa4wPxvO4eth31ZqCTtKCMIdMDK1zcat
 OxgwZd+ZgDkQJQbxIxxrw1/Oy8FYLMFpeY8URi/IiCnJBmb0gMXwlcCOOkBX+DBcf9di eA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3pgxht8ddb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 24 Mar 2023 07:09:04 +0000
Received: from m0250811.ppops.net (m0250811.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32O794qm027191
	for <bitbake-devel@lists.openembedded.org>; Fri, 24 Mar 2023 07:09:04 GMT
Received: from ala-exchng02.corp.ad.wrs.com (unknown-82-254.windriver.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3pgxht8dd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 24 Mar 2023 07:09:04 +0000
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.18; Fri, 24 Mar 2023 00:09:03 -0700
Received: from ala-lpggp3.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.18 via Frontend Transport; Fri, 24 Mar 2023 00:09:03 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <sam@liddicott.com>, <troth@openavr.org>
Subject: [PATCH 1/1] fetch/git: Fix local clone url to make it work with repo
Date: Fri, 24 Mar 2023 00:09:02 -0700
Message-ID: <e763d75fb33b69bbfbf3350b2592b4eea7d3878d.1679641659.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1679641659.git.liezhi.yang@windriver.com>
References: <cover.1679641659.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: MlxZh71DMyc98K5wHpV2zmqh_R1IeHjB
X-Proofpoint-ORIG-GUID: MNiWtJF1TqVs2tOWxEn6L8KGJBO3gV0g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_03,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=761 malwarescore=0 priorityscore=1501 spamscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303240058
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Mar 2023 07:09:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14615

The "git clone /path/to/git/objects_symlink" couldn't work after the following
change:

https://github.com/git/git/commit/6f054f9fb3a501c35b55c65e547a244f14c38d56

But repo command manages the git repo as symlinks, so check whether the objects
is an symlink to fix the problem:

* Nothing is changed if git/objects is not a symlink
* Use "git clone file://" when git/objects is a symlink

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/git.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index d0d68538e2..2a3c06fe4e 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -367,9 +367,13 @@ class Git(FetchMethod):
 
         # If the repo still doesn't exist, fallback to cloning it
         if not os.path.exists(ud.clonedir):
-            # We do this since git will use a "-l" option automatically for local urls where possible
+            # We do this since git will use a "-l" option automatically for local urls where possible,
+            # but it doesn't work when git/objects is a symlink, only works when it is a directory.
             if repourl.startswith("file://"):
-                repourl = repourl[7:]
+                repourl_path = repourl[7:]
+                objects = os.path.join(repourl_path, 'objects')
+                if os.path.isdir(objects) and not os.path.islink(objects):
+                    repourl = repourl_path
             clone_cmd = "LANG=C %s clone --bare --mirror %s %s --progress" % (ud.basecmd, shlex.quote(repourl), ud.clonedir)
             if ud.proto.lower() != 'file':
                 bb.fetch2.check_network_access(d, clone_cmd, ud.url)
-- 
2.33.1


