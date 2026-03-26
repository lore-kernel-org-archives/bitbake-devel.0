Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A6F10AB818
	for <webhook@archiver.kernel.org>; Thu, 26 Mar 2026 18:57:57 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.55633.1774551469405354091
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 26 Mar 2026 11:57:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=F4HLn+xR;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75450e5aee=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QFhRcO3113430;
	Thu, 26 Mar 2026 18:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=zOlDJsT8NTtqgquXjZosYz7RpuYTmfFREaCJ1a52RWo=; b=
	F4HLn+xRf5KHaCkF3piqPB8+S7mY9Db4/byysFjWpxU3bo8m3XHH+WMbBvN7r7Vp
	AahNJdTWsFgTM2DAqa5ysycwQ4eLQ6icx0CG2NDGeZFKR0R+yYlJuPOsXwLxohzm
	AGW5Sax/pz8te74KY3pTYNcvP4xn5HltshX+RjTyLiKGNtKtHTdZhOWRdkCx4Gs8
	hpH4oxwWf79gak65M3t6xAI7UecUbfnIacguN/tHeyBnlCDsrjsxeQ0fAL6QYsWr
	Rx+oPiFacagIxNkBFuZwTrQcf5HEV9gaYI2uO9uPtbjboG2+rUxT7LWIPZedkEk5
	5wtbVrbuZR5G2y4kf+jyyg==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1gj872bp-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Mar 2026 18:57:47 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Thu, 26 Mar 2026 11:57:44 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Thu, 26 Mar 2026 11:57:44 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>
Subject: [PATCH 07/11] bitbake-setup: Remove unused parser_settings_list
Date: Thu, 26 Mar 2026 11:57:38 -0700
Message-ID: <20260326185742.542268-8-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326185742.542268-1-rob.woolley@windriver.com>
References: <20260326185742.542268-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: k5hbhZU5fMZmhg57yMfLebr_l8LJ5l6F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDEzNiBTYWx0ZWRfX0pwGrFcHM11/
 93EP8Tz0QmAeJIPHD7BcyFfo6shvp1jX/YV1yWtQ/kbh7yKCyOyPdj4Q6PVR5CotUfUJsZDJ3Zo
 4K3CGj+qILzh2dD9OoHotOp07rl+lZ2VP7ImOleKvmQsXMeHXAbjm2l8uA0ZmzPBhPRujGmYdg3
 dP0JK08pCMZGkkml/7O7rZoGNOg30AM33uP/m/UyE4Jc9bHnLV7AQXbsCc5vM5Htl6jH3aOADWL
 yjmEZAskboKeYNG20ZMB8kB1JZRlbT383QbgKfpM1sR/W7wppgC1NWAHlq4re1b9bogBF+btYa0
 PjDk2rRNcHbYzQw8t/Pim/TlQJ2RQj2OvqeLOFEmEom2GG03ZRu4B/hHDqaSO0NlrA675Pl80jf
 DOVEcfA2v92DWbgmJPEIVDS9Bd622uzehUBEoluCSLIW4RO15J3/wJjby7JEdoUYsU3PqeFY3Be
 lt+iNgt6fNwuejsKrvQ==
X-Authority-Analysis: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=69c581ab cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8 a=RdzD27zFivnYBFE9EGsA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: k5hbhZU5fMZmhg57yMfLebr_l8LJ5l6F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260136
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 26 Mar 2026 18:57:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19252

The ruff lint tool detected an used variable:

    F841 Local variable `parser_settings_list` is assigned to but never used

The list_settings function  gets invoked through the parent command's
settings_func function. This means that creating this variable is
unnecessary.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 00be16438..7cc3f9253 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -1109,8 +1109,7 @@ def main():
 
     subparser_settings = parser_settings.add_subparsers(dest="subcommand", required=True, help="The action to perform on the settings file")
 
-    parser_settings_list = subparser_settings.add_parser('list',
-                                                         help="List all settings with their values")
+    subparser_settings.add_parser('list', help="List all settings with their values")
 
     parser_settings_set = subparser_settings.add_parser('set', parents=[parser_settings_arg_global],
                                                         help="In a Section, set a setting to a certain value")
-- 
2.39.5


