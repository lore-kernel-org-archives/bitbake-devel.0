Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B21CA0EC1
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 07:58:34 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.42991.1754899107319721129
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Aug 2025 00:58:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0318e6e81f=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 57B60BtS2237416
	for <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 00:58:27 -0700
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48e5uhs2s6-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 00:58:26 -0700 (PDT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Mon, 11 Aug 2025 00:58:29 -0700
Received: from ala-lpggp7.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.57 via Frontend Transport; Mon, 11 Aug 2025 00:58:29 -0700
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 1/1] fetch2: try_mirrors(): Skip invalid local url
Date: Mon, 11 Aug 2025 00:58:32 -0700
Message-ID: <87f55606dfd70b12b5d7fe97ad889300a6884359.1754898959.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1754898959.git.liezhi.yang@windriver.com>
References: <cover.1754898959.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA1MiBTYWx0ZWRfX2Q1ekQHmK1GY
 x5IfvWW1YRpsDyzQwGiGzJ2lDhcbEPM0/hW/XCwWMFf7MnokNwxdB3kSFJPBG87oNRISBzvC8DT
 UZ50P7xk7jau+r6NQ5esZ3nFPviWKbUOg0vNi4cmX00E6vO4fLLE+65tgZ38d0rhjd3QGAetYBc
 uP26b2w6EH9jIGjC/gkwYsPi5jU58IOyplwjJ7kOLaumNRdQWRsW8ORyy+Gu5jW/rlEkf9JajCB
 fTlkg+kg0FztOjt5NDJOQynwCXgBsIP8eBhqTquKq8GJG9P4bhWldna0FGfLZbE+tfC9jTu19yx
 nVdY5V8tN7kd98SBFhSsptr8KHRN2XdAidhCUuJkd0Nu+lbG34c8pwhFxxtVqQ=
X-Proofpoint-GUID: hRADwNh-45vbwRUjTxk0qiTgiYlbSaVT
X-Proofpoint-ORIG-GUID: hRADwNh-45vbwRUjTxk0qiTgiYlbSaVT
X-Authority-Analysis: v=2.4 cv=cZzSrmDM c=1 sm=1 tr=0 ts=6899a2a2 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=2OwXVqhp2XgA:10 a=t7CeM3EgAAAA:8 a=rHY-G172poNAejeJpNkA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 07:58:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17854

From: Robert Yang <liezhi.yang@windriver.com>

Skip fetching from an invalid local url since it would be failed.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 0ad987c596..e4c9cecd86 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1168,7 +1168,11 @@ def try_mirrors(fetch, d, origud, mirrors, check = False):
     uris, uds = build_mirroruris(origud, mirrors, ld)
 
     for index, uri in enumerate(uris):
-        ret = try_mirror_url(fetch, origud, uds[index], ld, check)
+        ud = uds[index]
+        # Skip fetching it when the local url's path doesn't exist
+        if ud.parm.get('protocol', '') == 'file' and not os.path.exists(ud.path):
+            continue
+        ret = try_mirror_url(fetch, origud, ud, ld, check)
         if ret:
             return ret
     return None
-- 
2.49.0


