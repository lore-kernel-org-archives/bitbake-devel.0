Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F168CA0ECD
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 15:41:47 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.51538.1754926905939436269
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Aug 2025 08:41:46 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=0318e6e81f=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 57B4S8771676710;
	Mon, 11 Aug 2025 15:41:44 GMT
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48dwa61pk2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 11 Aug 2025 15:41:44 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Mon, 11 Aug 2025 08:41:45 -0700
Received: from ala-lpggp7.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.57 via Frontend Transport; Mon, 11 Aug 2025 08:41:45 -0700
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>, <alex.kanavin@gmail.com>
Subject: [PATCH v2 1/1] fetch2: try_mirror_url(): Skip invalid local url
Date: Mon, 11 Aug 2025 08:41:48 -0700
Message-ID: <e56a4f7e3c7bff7b86cecc32c2fcd43a63db0620.1754925741.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754925741.git.liezhi.yang@windriver.com>
References: <cover.1754925741.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDEwMCBTYWx0ZWRfX1klvZT17nby0
 9V3pJMAfkyXzpNRH/kZ5j/3zVK2XlsuBQX/rBtu4nZf+BHFl+jfd5OlCXMpe9MPZmzj+c5FmqHQ
 JxoOAP9KHOz5rEsASBfXd5O4UYiOJsWY2M9gxj13UQtfCpq95xajhRh/L/NM+LFTxM5cZc1gzMR
 DhyuoZjH4V6Hl4pxgX8GzLEFcL/X0R4P6VFVEXzjqlmBZZwaN+Ju/htQIWju4GzVUDcP9h1xJMb
 7Bx5oYq8FPYPmQpu5tKUFZVb8wyp9io/lzpPnwRyXVwcVYCgrNgquZUDHajMWlueUy9V5b3Zmav
 Xka9mNerYe5I1FsGLrgtYGBmRSwoE6Eoee0TkP/EaYOJpDFkQUSP6lRCrWLVDw=
X-Proofpoint-ORIG-GUID: 6WWLSAyp50Zd9TSJN2bRF9XqcJumxqsa
X-Proofpoint-GUID: 6WWLSAyp50Zd9TSJN2bRF9XqcJumxqsa
X-Authority-Analysis: v=2.4 cv=Qcpmvtbv c=1 sm=1 tr=0 ts=689a0f38 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=2OwXVqhp2XgA:10 a=t7CeM3EgAAAA:8 a=WH53bJrpkkUMN2iF5J4A:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_03,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 15:41:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17861

From: Robert Yang <liezhi.yang@windriver.com>

There can be multiple PREMIRRORs each PREMIRROR contains specifics sources for
each layer, each recipe will try the PREMIRRORs one by one until succeed, but
the trying would be failed if the PREMIRROR doesn't contain the required
sources, so return it immediately to make log.do_fetch clean, and tt also can
fix a warning when BB_GIT_SHALLOW and is enabled and failed to fetch the source
from the PREMIRROR:

Fast shallow clone failed, try to skip fast mode now.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 0ad987c596..1bab8f7f57 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1067,6 +1067,10 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
     # Return of None or a value means we're finished
     # False means try another url
 
+    # Skip fetching it when the local url's path doesn't exist
+    if ud.parm.get('protocol', '') == 'file' and not os.path.exists(ud.path):
+        return False
+
     if ud.lockfile and ud.lockfile != origud.lockfile:
         lf = bb.utils.lockfile(ud.lockfile)
 
-- 
2.49.0


