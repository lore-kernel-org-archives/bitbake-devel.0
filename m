Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE179C3DA7F
	for <webhook@archiver.kernel.org>; Sun, 28 Jul 2024 03:39:43 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.29048.1722137973192655642
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 27 Jul 2024 20:39:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=79397ec828=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46S3W3ep000575
	for <bitbake-devel@lists.openembedded.org>; Sat, 27 Jul 2024 20:39:33 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40mv618hqh-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sat, 27 Jul 2024 20:39:32 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 27 Jul 2024 20:39:31 -0700
Received: from ala-lpggp7.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Sat, 27 Jul 2024 20:39:31 -0700
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/1] data_smart: Improve performance for VariableHistory
Date: Sat, 27 Jul 2024 20:39:31 -0700
Message-ID: <cd06a65773c4be6a51ccba0155cbebe42c2f355e.1722137668.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1722137668.git.liezhi.yang@windriver.com>
References: <cover.1722137668.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 1NeWeQWaY_KG2jcY6LpJbPbf3ahS7JVs
X-Proofpoint-ORIG-GUID: 1NeWeQWaY_KG2jcY6LpJbPbf3ahS7JVs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-27_19,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=863
 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2407110000 definitions=main-2407280024
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 28 Jul 2024 03:39:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16440

From: Robert Yang <liezhi.yang@windriver.com>

Fixed:
- BBMULTICONFIG = "qemux86-64 qemuarm64" and more than 70 layers in BBLAYERS
$ bitbake -p -P
Check profile.log.processed, the record() cost more than 20 seconds, it is less
than 1 second when multiconfig is not enabled, and there would be the following
error when more muticonfigs are enabled:

Timeout while waiting for a reply from the bitbake server

Don't change the type of loginfo['detail'] or re-assign it can make record()
back to less than 1 second, this won't affect COW since loginfo is a mutable
type.

The time mainly affected by two factors:
1) The number of enabled layers, nearly 1 second added per layer when the
   number is larger than 50.

2) The global var such as USER_CLASSES, about 1 ~ 2 seconds added per layer
   when the layers number is larger than 50.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/data_smart.py | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/data_smart.py b/bitbake/lib/bb/data_smart.py
index 0128a5bb17..c6049d578e 100644
--- a/bitbake/lib/bb/data_smart.py
+++ b/bitbake/lib/bb/data_smart.py
@@ -272,12 +272,9 @@ class VariableHistory(object):
             return
         if 'op' not in loginfo or not loginfo['op']:
             loginfo['op'] = 'set'
-        if 'detail' in loginfo:
-            loginfo['detail'] = str(loginfo['detail'])
         if 'variable' not in loginfo or 'file' not in loginfo:
             raise ValueError("record() missing variable or file.")
         var = loginfo['variable']
-
         if var not in self.variables:
             self.variables[var] = []
         if not isinstance(self.variables[var], list):
@@ -336,7 +333,8 @@ class VariableHistory(object):
                     flag = '[%s] ' % (event['flag'])
                 else:
                     flag = ''
-                o.write("#   %s %s:%s%s\n#     %s\"%s\"\n" % (event['op'], event['file'], event['line'], display_func, flag, re.sub('\n', '\n#     ', event['detail'])))
+                o.write("#   %s %s:%s%s\n#     %s\"%s\"\n" % \
+                    (event['op'], event['file'], event['line'], display_func, flag, re.sub('\n', '\n#     ', str(event['detail']))))
             if len(history) > 1:
                 o.write("# pre-expansion value:\n")
                 o.write('#   "%s"\n' % (commentVal))
@@ -390,7 +388,7 @@ class VariableHistory(object):
             if isset and event['op'] == 'set?':
                 continue
             isset = True
-            items = d.expand(event['detail']).split()
+            items = d.expand(str(event['detail'])).split()
             for item in items:
                 # This is a little crude but is belt-and-braces to avoid us
                 # having to handle every possible operation type specifically
-- 
2.25.1


