Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BF4CA0EC0
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 07:58:34 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.42990.1754899107292037338
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Aug 2025 00:58:27 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0318e6e81f=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 57B60BtR2237416
	for <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 00:58:26 -0700
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48e5uhs2s6-1
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
Subject: [PATCH 0/1] fetch2: try_mirrors(): Skip invalid local url
Date: Mon, 11 Aug 2025 00:58:31 -0700
Message-ID: <cover.1754898959.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA1MiBTYWx0ZWRfX8W5s7V97ximK
 kYPdwrA3IS0Xz2MG8hSDiy0Hfyf7rfQBmjoyCluMs0meTwNk7ryBChlCzcPM97Wjf+f5VO1hS2j
 yOEyfmByvvGMFfE+ydJ+mCN7ptTuaEpqxs/d3L6HdZVaiWbpsRKoMSWxy3UxkDTf77Hffo2/T5d
 IeXvtI9KyTxs0NvXdB5bKh+mhkUrHEmRZJHmBfVf3GbYtMDfZP0u0NG3aERtFFqoenUDcU5OJJq
 pOvveF2t5wtBpPmqxdyYSphylhKMPCmXaFmmiw/re9N4CmXjgGalmUA1NeQdtwhUu+frWG8agwF
 Q5O4zdNXjdjOVgBE9RnSMGJXZ0lDTLMzzh0zBwmdDlchgPY7cHyuioQDb7b9E0=
X-Proofpoint-GUID: b3RzkwOiVL4MOZWocADlUVkouZC8vKWH
X-Proofpoint-ORIG-GUID: b3RzkwOiVL4MOZWocADlUVkouZC8vKWH
X-Authority-Analysis: v=2.4 cv=cZzSrmDM c=1 sm=1 tr=0 ts=6899a2a2 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=2OwXVqhp2XgA:10 a=NEAV23lmAAAA:8 a=t7CeM3EgAAAA:8 a=VA8MGYyB8smEpNTFlcUA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 07:58:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17853

From: Robert Yang <liezhi.yang@windriver.com>

The following changes since commit 3b2f9c31dc17c3ba5f6a9971413afed3d450d826:

  poky.yaml.in: increase required disk space to 140G (2025-08-08 23:41:11 +0100)

are available in the Git repository at:

  https://github.com/robertlinux/bitbake rbt/mirror
  https://github.com/robertlinux/bitbake/tree/rbt/mirror

Robert Yang (1):
  fetch2: try_mirrors(): Skip invalid local url

 bitbake/lib/bb/fetch2/__init__.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.49.0


