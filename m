Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8782CA0EDA
	for <webhook@archiver.kernel.org>; Tue, 12 Aug 2025 08:04:32 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.69444.1754985866618071292
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Aug 2025 01:04:26 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0319aaa3f0=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 57C7BBu1505089
	for <bitbake-devel@lists.openembedded.org>; Tue, 12 Aug 2025 01:04:26 -0700
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48fvk206q1-1
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
Subject: [PATCH v3 0/1] fetch2: try_mirror_url(): Skip invalid local url
Date: Tue, 12 Aug 2025 01:04:30 -0700
Message-ID: <cover.1754985648.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDA3NSBTYWx0ZWRfXy3ANcr9hf/7X
 x1RmacNdg5Yqhj7jbhnDkBbQxRshJJ17RMKhuYK8b0qMniSrYsxzcxEoKuAbB9T8N6+WuPSVzZP
 hvS+lAYZWGb2hsRKuxGVcMn7orgsR57Mz6ZcZRY3b0Avp5CpAKQ5mWOCGuRqiTg3E81h1/fJfcH
 zftt3LbZUKcK2+0I16ShUfWX1i/FKD/fnZe6VSwzMJBcnRUhvpjtqDrZzMVLdHlvfFuFqXp+FZT
 f7Rv3Wic7biTm8PtuBFbMLGeoPhhKdKwuZ5BprUFrjrDmhkIY7/NRKLHLnFyQOuz01Ad1xppme6
 j4tZS1jKo8DlQVD6fzOs20lalQi4pYLYZF+1NQRZ56z3POdN2tRhpsbZS41bqM=
X-Proofpoint-ORIG-GUID: ibMyrar3JK914R5MO9pOxfjUMYCPc1Bx
X-Proofpoint-GUID: ibMyrar3JK914R5MO9pOxfjUMYCPc1Bx
X-Authority-Analysis: v=2.4 cv=PsOTbxM3 c=1 sm=1 tr=0 ts=689af58a cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8 a=46oudPXdTaLkr-pSzlcA:9
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17865

From: Robert Yang <liezhi.yang@windriver.com>

* V3
  - Check both repo and rep.git since git works with both of them.

* V2
  - Move the code to try_mirror_url() as Alex suggested
  - Add more commit messages.

* V1
  - Initial version

// Robert

The following changes since commit 3b2f9c31dc17c3ba5f6a9971413afed3d450d826:

  poky.yaml.in: increase required disk space to 140G (2025-08-08 23:41:11 +0100)

are available in the Git repository at:

  https://github.com/robertlinux/bitbake rbt/mirror
  https://github.com/robertlinux/bitbake/tree/rbt/mirror

Robert Yang (1):
  fetch2: try_mirror_url(): Skip invalid local url

 bitbake/lib/bb/fetch2/__init__.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.49.0


