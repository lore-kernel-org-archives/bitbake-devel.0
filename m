Return-Path: <david.reyna@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3625AC83F16
	for <webhook@archiver.kernel.org>; Mon, 28 Aug 2023 09:22:18 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.9697.1693214537577288740
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Aug 2023 02:22:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=MCcLQtc6;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7604d1df4d=david.reyna@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37S90JsI016424
	for <bitbake-devel@lists.openembedded.org>; Mon, 28 Aug 2023 02:22:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PPS06212021; bh=uQgsoMO+l2jMdcmmeSYIE7ACvW0q4sLilK7+YUPYsk8=; b=
	MCcLQtc6ba0YHUDc875eXXdxIL8vXC+AbFgcT1xJG9hKvMbb5c/fv0pnbs1Yy4vQ
	RejNKMs9pz4eqdUP4ZRYdLbszk9Cpnae/hRIB3Ztyh5P1jPmJCD1TulP8uIQaKPU
	mmJ8Er8sllCC+E7UigIIcMnvcFoSsx9TK48MHNqrts1S3ft6JSKQK8uOmw7IKXdE
	a7fm1KXUb8VUgZgELQ62OI7uwZ+INVaSTSqdE+U+LVIoVK+KhMhw1xIC5KWTFUAT
	EABJ/K7j5mGyyfr8w6NCJxgI4AyMepLHbd/FQkBuTlj1agnShYVGZIFunpAOtWRV
	x0xJCrNQhuYdXOSOmI8VqA==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3sqgwfh7jg-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 28 Aug 2023 02:22:17 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 02:22:16 -0700
Received: from dreyna-honig-T5600.corp.ad.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 02:22:15 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 3/3] toaster: accommodate missing 'Image Name' value in buildinfohelper
Date: Mon, 28 Aug 2023 01:45:20 -0700
Message-ID: <e5414dbda807440ff3d619245c646ecedc934c5f.1693212183.git.david.reyna@windriver.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1693212183.git.david.reyna@windriver.com>
References: <cover.1693212183.git.david.reyna@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Xh5uC8S2Unr16bN82ulfNvbuY7MpCQxM
X-Proofpoint-ORIG-GUID: Xh5uC8S2Unr16bN82ulfNvbuY7MpCQxM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_06,2023-08-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2308100000
 definitions=main-2308280085
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Aug 2023 09:22:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14988

The value "Image Name" in bitbake events was missing for certain builds. Update 'buildinfohelper' to extract the
image name elsewhere in this circumstance and not crash.

[YOCTO #13191]

Signed-off-by: Kieran McNulty <Kieran.McNulty@windriver.com>
Signed-off-by: David Reyna <David.Reyna@windriver.com>
---
 lib/bb/ui/buildinfohelper.py | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 129bb329c38..8b212b78034 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -1746,7 +1746,6 @@ class BuildInfoHelper(object):
 
         buildname = self.server.runCommand(['getVariable', 'BUILDNAME'])[0]
         machine = self.server.runCommand(['getVariable', 'MACHINE'])[0]
-        image_name = self.server.runCommand(['getVariable', 'IMAGE_NAME'])[0]
 
         # location of the manifest files for this build;
         # note that this file is only produced if an image is produced
@@ -1767,6 +1766,18 @@ class BuildInfoHelper(object):
         # filter out anything which isn't an image target
         image_targets = [target for target in targets if target.is_image]
 
+        if len(image_targets) > 0:
+            #if there are image targets retrieve image_name
+            image_name = self.server.runCommand(['getVariable', 'IMAGE_NAME'])[0]
+            if not image_name:
+                #When build target is an image and image_name is not found as an environment variable
+                logger.info("IMAGE_NAME not found, extracting from bitbake command")
+                cmd = self.server.runCommand(['getVariable','BB_CMDLINE'])[0]
+                #filter out tokens that are command line options
+                cmd = [token for token in cmd if not token.startswith('-')]
+                image_name = cmd[1].split(':', 1)[0] # remove everything after : in image name
+                logger.info("IMAGE_NAME found as : %s " % image_name)
+
         for image_target in image_targets:
             # this is set to True if we find at least one file relating to
             # this target; if this remains False after the scan, we copy the
-- 
2.20.1


