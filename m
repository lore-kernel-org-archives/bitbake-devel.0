Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB560C3271E
	for <webhook@archiver.kernel.org>; Mon,  8 Jul 2024 08:10:46 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.75006.1720426238223454368
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 08 Jul 2024 01:10:38 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7919c2be37=changqing.li@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468402il004566
	for <bitbake-devel@lists.openembedded.org>; Mon, 8 Jul 2024 08:10:37 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 406u4x1gjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 08 Jul 2024 08:10:37 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 8 Jul 2024 01:10:35 -0700
Received: from pek-lpg-core2.wrs.com (128.224.153.41) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Mon, 8 Jul 2024 01:10:35 -0700
From: <changqing.li@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <qi.chen@windriver.com>
Subject: [PATCH] bitbake-worker: skipping disable network when unprivileged userns is restricted
Date: Mon, 8 Jul 2024 16:10:34 +0800
Message-ID: <20240708081034.1474312-1-changqing.li@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: H-QLoBwEJ_QH7i8_h_nKdyqTZ-yjSHYd
X-Proofpoint-GUID: H-QLoBwEJ_QH7i8_h_nKdyqTZ-yjSHYd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_02,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1011 spamscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2406140001 definitions=main-2407080062
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 08 Jul 2024 08:10:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16397

From: Chen Qi <Qi.Chen@windriver.com>

From ubuntu24.04, apparmor is enabled by default, and unprivileged
userns is restricted, which causes following error when bitbake-worker
try to disable network:
Traceback (most recent call last):
  File "/poky/bitbake/bin/bitbake-worker", line 278, in child
    bb.utils.disable_network(uid, gid)
  File "/poky/bitbake/lib/bb/utils.py", line 1696, in disable_network
    with open("/proc/self/uid_map", "w") as f:
PermissionError: [Errno 1] Operation not permitted

Like what we have done for non local uid, skip disable network in above
condition to avoid have to disable profile unprivileged_userns for the
host or have to config a profile per project

[1] https://lists.yoctoproject.org/g/yocto/topic/workaround_for_uid_map_error/106192359

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
Signed-off-by: Changqing Li <changqing.li@windriver.com>
---
 bitbake/bin/bitbake-worker | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
index e8073f2ac3..0a042fdc7c 100755
--- a/bitbake/bin/bitbake-worker
+++ b/bitbake/bin/bitbake-worker
@@ -272,12 +272,21 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
 
                 bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN"), taskname.replace("do_", "")))
 
+                def skip_disable_network(taskname, uid):
+                    if not bb.utils.is_local_uid(uid):
+                        logger.debug("Skipping disable network for %s since %s is not a local uid." % (taskname, uid))
+                        return True
+                    if os.path.exists("/proc/sys/kernel/apparmor_restrict_unprivileged_userns"):
+                        with open("/proc/sys/kernel/apparmor_restrict_unprivileged_userns") as f:
+                            if f.readline().strip() == "1":
+                                logger.debug("Skipping disable network since sys.kernel.apparmor_restrict_unprivileged_userns is 1")
+                                return True
+                    return False
+
                 if not bb.utils.to_boolean(the_data.getVarFlag(taskname, 'network')):
-                    if bb.utils.is_local_uid(uid):
+                    if not skip_disable_network(taskname, uid):
                         logger.debug("Attempting to disable network for %s" % taskname)
                         bb.utils.disable_network(uid, gid)
-                    else:
-                        logger.debug("Skipping disable network for %s since %s is not a local uid." % (taskname, uid))
 
                 # exported_vars() returns a generator which *cannot* be passed to os.environ.update() 
                 # successfully. We also need to unset anything from the environment which shouldn't be there 
-- 
2.25.1


