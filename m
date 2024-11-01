Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16ECE6B24A
	for <webhook@archiver.kernel.org>; Fri,  1 Nov 2024 11:59:04 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.36059.1730462339226677109
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 Nov 2024 04:58:59 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=1035258c17=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A19vvoM003243
	for <bitbake-devel@lists.openembedded.org>; Fri, 1 Nov 2024 11:58:58 GMT
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 42mf15gvtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 01 Nov 2024 11:58:58 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 04:58:57 -0700
Received: from ala-lpggp7.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 04:58:57 -0700
From: <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2 0/1] cooker: Sort pn-buildlist
Date: Fri, 1 Nov 2024 04:58:56 -0700
Message-ID: <cover.1730462200.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=PeqthThd c=1 sm=1 tr=0 ts=6724c282 cx=c_pps a=/ZJR302f846pc/tyiSlYyQ==:117 a=/ZJR302f846pc/tyiSlYyQ==:17 a=VlfZXiiP6vEA:10 a=t7CeM3EgAAAA:8 a=NEAV23lmAAAA:8 a=YX1c08XrpC9uEXSe2zQA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: icORBl7iNDHS27TvBlgkXen6zMA_7msA
X-Proofpoint-GUID: icORBl7iNDHS27TvBlgkXen6zMA_7msA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_06,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 mlxlogscore=723 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2409260000 definitions=main-2411010086
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 Nov 2024 11:59:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16767

From: Robert Yang <liezhi.yang@windriver.com>

* V2:
  Add '\n' to the end of file.

// Robert

The following changes since commit 91e268b11ed683bd197026f9b36001f6d54ee05c:

  tests/fetch: Use our own mirror of mobile-broadband-provider to decouple from gnome gitlab (2024-10-29 22:27:42 +0000)

are available in the Git repository at:

  https://github.com/robertlinux/bitbake rbt/sort
  https://github.com/robertlinux/bitbake/tree/rbt/sort

Robert Yang (1):
  cooker: Sort pn-buildlist

 lib/bb/cooker.py | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.25.1


