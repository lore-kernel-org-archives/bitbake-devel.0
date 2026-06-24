Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AB5CDB47F
	for <webhook@archiver.kernel.org>; Wed, 24 Jun 2026 17:20:21 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12948.1782321619828816596
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 Jun 2026 10:20:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=ONRRi8TZ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0635205cc7=rob.woolley@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OEegxP2602576
	for <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 10:20:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=fzqI1Joi8JMgLtZZ9GBSYGAa+UMlYZx3lRUHkL0YYj8=; b=
	ONRRi8TZ/r5fbsRiVruNMdHsnBjM48WQZC6WE5vUI2tFYrjMu7SVdME+sVf+n8eY
	h57n+9HN0V8DVk6/PBtQF2fU0eLK2qQtqcNGijy22imNW5WMxb1Kz8Emj6NCDc9S
	ht3Ld8PeHO1pAzT0MsUKLGAiZ8zxb3ajIPhCP9L1Mzp3MGgyBNJbo/r1Q0NfTnqr
	7eH+xr9oNtTiQuridwRNBqftm2VejdLLwBLQi1QE6GnUezORMGw+s5bA89PFdTp7
	J+mqfweqI0FnFVxSAlZTxJf36JIaMQtGdfekFW6oSeZJoTlDvoTDsZ70xYrwFRrk
	gbth0VzQKdOhrwARksJOMw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4eykj1jntn-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 10:20:18 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 24 Jun 2026 10:20:12 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 24 Jun 2026 10:20:12 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Wed, 24 Jun 2026 10:20:02 -0700
Subject: [PATCH v4 02/11] bitbake-setup: Add version option
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260624-add-pypi-v8-v4-2-ff499f1fd5a5@windriver.com>
References: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
In-Reply-To: <20260624-add-pypi-v8-v4-0-ff499f1fd5a5@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfXxeqHVBHpm82y
 2sxTVvuSz/rBIH7/q8xvhUj0reBIoFDMifbqAlUyxE0QDNHd+1eAroHOLouZIkIg6DAq2zWYNu6
 T7vMcaoVbZR+viGk5f4Io1nXtuypFfH8epbXLE96BH/M0X+Lb0MvkQKTaIodn4As0hqaBlJxMCc
 HwujnOUTDm1BuyZmR/ue+ZtSwLelP4ICa66hMKoa47iWtriMnbZDboJFuu71NPsMu6EcxhrFfwW
 1knhPgt7zV/FPpJ45DPYNg0a48rZleEaVRNkLNmuzzXMZMN0MtPeM42rNL4FnB3uv1lLx6g6wk8
 bwv6odMW1bJw98nlqlEF/RwamsTP0/u0uCF4kWOnPTGYj5WieZ+Y53Vq3qjICsClUH2KrECCNzy
 VaAmOwlCTdNsWLcOvlJmtmQpuVxaYA==
X-Proofpoint-ORIG-GUID: AgIQxOJRi2_H2MdB3puqgGvrpH1TiFkW
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0NSBTYWx0ZWRfX8WDIep6seEjX
 BVA7YJlAaIkEsxIKxF27ySRlc30CLku1ZfMVrf5jVAPTuot2ZUHb6Az77N2X9VrYqJu5p+153Ui
 2FwGgMtUS/7okZ/HZnf1fUkkv9VWkOiqUVJ3vD+2RlKcBBGf2dqF
X-Proofpoint-GUID: AgIQxOJRi2_H2MdB3puqgGvrpH1TiFkW
X-Authority-Analysis: v=2.4 cv=JNILdcKb c=1 sm=1 tr=0 ts=6a3c11d2 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=3MZ2cW2_6ngPcrpQ0mEA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240145
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 Jun 2026 17:20:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19769

This adds the long-form version option to match bitbake.

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-setup | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index d1e40c9a6..525187ddf 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -1250,6 +1250,7 @@ def main():
         )
     parser.add_argument('-d', '--debug', help='Enable debug output', action='store_true')
     parser.add_argument('-q', '--quiet', help='Print only errors', action='store_true')
+    parser.add_argument('--version', action='version', version='%(prog)s ' + __version__)
     parser.add_argument('--color', choices=['auto', 'always', 'never'], default='auto', help='Colorize output (where %(metavar)s is %(choices)s)', metavar='COLOR')
     parser.add_argument('--no-network', action='store_true', help='Do not check whether configuration repositories and layer repositories have been updated; use only the local cache.')
     parser.add_argument('--global-settings', action='store', metavar='PATH', help='Path to the global settings file.')

-- 
2.49.0


