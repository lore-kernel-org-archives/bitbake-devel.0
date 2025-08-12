Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8743CA0EC4
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 08:04:32 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.68879.1754985866745554781
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Aug 2025 01:04:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0319aaa3f0=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57C7BBu2505089
	for <bitbake-devel@lists.openembedded.org>; Tue, 12 Aug 2025 01:04:26 -0700
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48fvk206q1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 12 Aug 2025 01:04:26 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Tue, 12 Aug 2025 01:04:17 -0700
Received: from ala-lpggp7.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.57 via Frontend Transport; Tue, 12 Aug 2025 01:04:17 -0700
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v3 1/1] fetch2: try_mirror_url(): Skip invalid local url
Date: Tue, 12 Aug 2025 01:04:31 -0700
Message-ID: <fc732bac7b8fc7535e9cbacac05d8b6e118d8e73.1754985648.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754985648.git.liezhi.yang@windriver.com>
References: <cover.1754985648.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDA3NSBTYWx0ZWRfX84BSQmZmAtYk
 I+hmttmcGuUr6tVpcwL4tSPEZAPOc1pqTLdbcjNN3SaMlAG9VkzpCx5zPlRiKtQyW1m9Tr7zEra
 /WERI3gwOaDxLJE6YnQrA3t6+KVtsFFZCcSMhPte1oQelN8mUFeBG+rHZWpupH7xRVFj+quVonH
 r/Nol8RS50NPijOA9UhZWdKG7Unxgk9OuiHMan8FbHhkZ0vfHaa5VW4QrB+F/1ZcCfZycFjD+uI
 Z752BqJkjcGxUhsxK8reBGr6GYkyC9N2JURKU6C6FBLNQtEojHfwmeZ5Cwi3q0LOZOda7gr0Fzy
 fDOtssMJRDbvkikBwhQYMM8lZcajeHmIZ1eldDfhO6KCpEMEiqPilP2d814BR8=
X-Proofpoint-ORIG-GUID: e0ho12_G7DddpaRWo3i8WXRlFkncVskz
X-Proofpoint-GUID: e0ho12_G7DddpaRWo3i8WXRlFkncVskz
X-Authority-Analysis: v=2.4 cv=PsOTbxM3 c=1 sm=1 tr=0 ts=689af58a cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=2OwXVqhp2XgA:10 a=t7CeM3EgAAAA:8 a=WH53bJrpkkUMN2iF5J4A:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_03,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 12 Aug 2025 08:04:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17866

From: Robert Yang <liezhi.yang@windriver.com>

There can be multiple PREMIRRORs each PREMIRROR contains specifics sources for
each layer, each recipe will try the PREMIRRORs one by one until succeed, but
the trying would be failed if the PREMIRROR doesn't contain the required
sources, so return it immediately to make log.do_fetch clean, and tt also can
fix a warning when BB_GIT_SHALLOW and is enabled and failed to fetch the source
from the PREMIRROR:

WARNING: Fast shallow clone failed, try to skip fast mode now.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 0ad987c596..6149b1726a 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1067,6 +1067,22 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
     # Return of None or a value means we're finished
     # False means try another url
 
+    # Skip fetching it when the local url's path doesn't exist
+    if ud.parm.get('protocol', '') == 'file':
+        found = False
+        check_paths = [ud.path]
+        # Git works with or without '.git' suffix
+        if ud.path.endswith('.git'):
+            check_paths.append(ud.path[:-4])
+        else:
+            check_paths.append('%s.git' % ud.path)
+        for check_path in check_paths:
+            if os.path.exists(check_path):
+                found = True
+                break
+        if not found:
+            return False
+
     if ud.lockfile and ud.lockfile != origud.lockfile:
         lf = bb.utils.lockfile(ud.lockfile)
 
-- 
2.49.0


