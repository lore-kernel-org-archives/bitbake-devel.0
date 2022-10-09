Return-Path: <mark.asselstine@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23BCC433F5
	for <webhook@archiver.kernel.org>; Sun,  9 Oct 2022 23:26:40 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web12.752.1665357995158626534
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 09 Oct 2022 16:26:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=bIWYiZhc;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.178.238,
 mailfrom: prvs=72811a6c6a=mark.asselstine@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id
 299NKESM003158;
	Sun, 9 Oct 2022 23:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PPS06212021;
 bh=Vo0/9q1tCNXuS41I6P4Ut5enIpLjozGqTRV//yVsV70=;
 b=bIWYiZhcnk5bOYa+o8FQcbFiDL+ZmI0G6UmD+3gW3xuN39qf7BrNEeDZHW5GIib8fCKu
 SdxoSHbd/nFmzpCsotEATLs394sNxROIkdP7UEA1nppSnVfCZ3Y0MXY/Fh9M4uq3n4Jn
 vUFGQWK00dif7Hc2gsbvdzweAW5itEU0Bop2LB0oj/pary00ZGl028u/KJCH7A8apZ7v
 gt3bHCNvHChby4BjyzKAjQl+dB1D4HrwNQFQoUku0FQhCSk0E1xSzmKahAIp7+FkEygs
 F0spnj+tRwgLALmuTl/Bj74A8g+cUbqpH43UKYO6fdNPSD+l2n0NOfADBRHRozOiT4cb Bw==
Received: from ala-exchng01.corp.ad.wrs.com (unknown-82-252.windriver.com
 [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3k3067s2t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 09 Oct 2022 23:26:29 +0000
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 9 Oct 2022 16:26:28 -0700
Received: from yow-dellw-ma.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Sun, 9 Oct 2022 16:26:28 -0700
From: Mark Asselstine <mark.asselstine@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <bluelightning@bluelightning.org>
Subject: [PATCH] bitbake: bitbake-layers: checkout layer(s) branch when clone
 exists
Date: Sun, 9 Oct 2022 19:26:24 -0400
Message-ID: <20221009232624.3165976-1-mark.asselstine@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 9n6ZzgGWrL7g3iaBqnaXXV6KYsF-b2IN
X-Proofpoint-ORIG-GUID: 9n6ZzgGWrL7g3iaBqnaXXV6KYsF-b2IN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210090151
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 09 Oct 2022 23:26:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14030

[YOCTO #7852]

Fixes 'bitbake-layers layerindex-fetch --branch kirkstone meta-arm'
not checking out the branch if the repo is already cloned and on a
different branch.

If a clone of a layer being added already exists check what branch it
is on and if necessary attempt to switch to the given branch. If the
switch fails to happen the git error will be reported. We also warn if
there are uncommitted changes as the changes might go unnoticed and
result in unexpected behaviors.

Signed-off-by: Mark Asselstine <mark.asselstine@windriver.com>
---

Paul, I was not able to determine how you were seeing (2) from the
bugzilla comment, ie. the oe-core or poky checked out on the wrong
branch getting a second clone. If you can provide a hint I can
ensure this fix addresses this as well. Thanks.

 lib/bblayers/layerindex.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/lib/bblayers/layerindex.py b/lib/bblayers/layerindex.py
index 0ac8fd2e..ba91fac6 100644
--- a/lib/bblayers/layerindex.py
+++ b/lib/bblayers/layerindex.py
@@ -49,6 +49,31 @@ class LayerIndexPlugin(ActionPlugin):
             else:
                 logger.plain("Repository %s needs to be fetched" % url)
                 return subdir, layername, layerdir
+        elif os.path.exists(repodir) and branch:
+            """
+            If the repo is already cloned, ensure it is on the correct branch,
+            switching branches if necessary and possible.
+            """
+            base_cmd = ['git', '--git-dir=%s/.git' % repodir, '--work-tree=%s' % repodir]
+            cmd = base_cmd + ['branch']
+            completed_proc = subprocess.run(cmd, text=True, capture_output=True)
+            if completed_proc.returncode:
+                logger.error("Unable to validate repo %s (%s)" % (repodir, stderr))
+                return None, None, None
+            else:
+                if branch != completed_proc.stdout[2:-1]:
+                    cmd = base_cmd + ['status', '--short']
+                    completed_proc = subprocess.run(cmd, text=True, capture_output=True)
+                    if completed_proc.stdout.count('\n') != 0:
+                        logger.warning("There are uncommitted changes in repo %s" % repodir)
+                    cmd = base_cmd + ['checkout', branch]
+                    completed_proc = subprocess.run(cmd, text=True, capture_output=True)
+                    if completed_proc.returncode:
+                        # Could be due to original shallow clone on a different branch for example
+                        logger.error("Unable to automatically switch %s to desired branch '%s' (%s)"
+                                     % (repodir, branch, completed_proc.stderr))
+                        return None, None, None
+            return subdir, layername, layerdir
         elif os.path.exists(layerdir):
             return subdir, layername, layerdir
         else:
-- 
2.25.1


