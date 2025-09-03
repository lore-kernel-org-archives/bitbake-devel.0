Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66977CA1009
	for <webhook@archiver.kernel.org>; Wed,  3 Sep 2025 15:45:53 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.81])
 by mx.groups.io with SMTP id smtpd.web10.16241.1756914348552190559
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Sep 2025 08:45:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=GrENfFlI;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.236.81, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IM8jqNIFuk5xSngj4O8qDUB1u8NyAj+q6T56OSfPZvIutTS0OOQK4gx6UJrS93EWLl6y185iJUrTA+MdX1N7zZTSUZDVW2CNJWoBzUOrbvJOLtIOGspf8NIOt8LvKHn+NgMpUpISFvJrngrFA//+CA1TBzg1ipfU6vySOumwmjtx251fvArcHRX4xdXL/xUBv9jAQz1CfQymkwEMSPUS2/TWe77qQmZAGJx2tB/xl8R9g/7UFoCn4eE5h8QkQb5H8ZvbaivtLzAjl8FYL6EJxjdUYWCiZnxy5NT7dwywToRR3RQoRRPQHTuNabTiOHyMc1Hty6pqyfZzgjJW19qbtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=auxzOmfCKUm6J82SXqdqpZNZdsEi8wHZH34nt0ZI888=;
 b=N7cUO7Q7e7Ve2vOYP8B1FVsya8FJ8yjGFTOIEKCvt9wXzsrcsYFOqPFbkQRbsVPZLWaE2+ttD52I1uLSRlIpg+hwQEkofYAt/PQxGxO6pnW+JQ5cFnh+O7X+en1ErmjKANAchmTujNr0zfIlT0nZSAhwQYBiD8tznqPy7pqR7Z8wa3QXTKhCbHw7uiDY42rx8g9KKXrELIoFMxi7n44YODMZnk+gMbYx6nlb7PREzne6AM3y3l09hOCbUgQ+piZhv5WwsnWdozm9gjJo8FMX3DlqCIB6+mJHuwfUdxETQmz/iI+Zm5TLzt5PqahBKHKRhv7w08SAFKABaEQAGRI4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=auxzOmfCKUm6J82SXqdqpZNZdsEi8wHZH34nt0ZI888=;
 b=GrENfFlI04n43GOGmJN6H3sBxQunUvRH0gnOGmy8sN7xXsa4NP7HMLBGykVkfFoi8PLU1/gsntCSAaoWLX21Sv7Tvt/4nf4iVqrhYaiyQ+oBgZCrJmrDIflJBeOxZg+3sWHj3PQB72oaSCn46nUL4MunShcS4kDDNx7KsUvg0EdoRrhcYbru0zqLEWdXehEbYstekohB9Cr9Qa20FGwKIZ4bfOU5Qrw4WkayfwNSzsNIeU+y0rzsdXoeS49IMbCeXU5+u37yTJL9338yAhUfgacKZbfTDzPcjNUw+QyOdavBcK8c9uRzab+HQ/Ld8HsI5sofZT7oCZXYj2V6kVIP2Q==
Received: from SN1PR12CA0105.namprd12.prod.outlook.com (2603:10b6:802:21::40)
 by CH0PR12MB8462.namprd12.prod.outlook.com (2603:10b6:610:190::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 15:45:39 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:802:21:cafe::7d) by SN1PR12CA0105.outlook.office365.com
 (2603:10b6:802:21::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Wed,
 3 Sep 2025 15:45:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.41) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 15:45:38 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.58; Wed, 3 Sep 2025 09:45:31 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH] fetch2/git: when raising ParameterError for an invalid proto, include the proto in the message
Date: Wed, 3 Sep 2025 11:45:03 -0400
Message-ID: <20250903154503.3288644-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|CH0PR12MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 49918550-0c0f-4f3f-b94a-08ddeb00ee7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1Lyya3Px4mgUXlcG5Ie41fSe22inxtUTMEOdkgIjH1qpTgbQoGAfqAv5hM1m?=
 =?us-ascii?Q?5SLcozQx8feBs9ocwhevTnzLA/wE5/yCHVGLMyvHpGdLdu/O9IQkJmBSSWqx?=
 =?us-ascii?Q?yVM3A2EeXAReYVmY6kOeMIX1xc1fGPF5WpB+o3nF8KfSwClMCql6Va5rVl+c?=
 =?us-ascii?Q?bqfgSCsMZqMWhJjefT+JFNwSEd7U2LtxsXII5P/geIB4ATvo8JyR4BTWhOvS?=
 =?us-ascii?Q?jGvjoJ8FkehtV4qI5CnZioNTRmWL5VR/enX9VfSARMEfWRUgzeqKDqn9vypd?=
 =?us-ascii?Q?1wa6HWY/03CVkTBHiPSlAuxH1hITsmd+NklgHw4vuMy87vTmLxSBmdcb0UGb?=
 =?us-ascii?Q?Sir1OZCcIKmrhn/Ath5TpQG4TiG4KA3FMuYFGmvQNJr7TgiQTmyNB1MiYZPl?=
 =?us-ascii?Q?dGbVTJcbUkhleJVYTczbnWxKuvess7twAvpJooVZ8uaaxKvOawUIjZc5NyY4?=
 =?us-ascii?Q?lckrlunjDxYxWf+A32v3kOddPPxKk+D+e1F3iildyhiwUANDrlqOAfAaM3hD?=
 =?us-ascii?Q?E/YzZSEiB1A6gXXRH6W1ntioEdaDsX/2NsJAzGEiQ+jZptZUT6xF5RNHCBc8?=
 =?us-ascii?Q?36GAKH/o0/LQwRNYEUo866xD+aKUDPAYFHP5phob5oEuuhwhhJZCyDLpsACB?=
 =?us-ascii?Q?SkvzbnUe0+6wAJaEXp0FG2TQe6qlHPc5pHmHH3Bh7tfrcgtoVH+cXtQShv+V?=
 =?us-ascii?Q?VAoGLg2uXjWePIKbjkj1bgqW9lwNJRcZX9+SpqWDxB/P7ypW81LGOuCRJynX?=
 =?us-ascii?Q?URjouDHNguM/FE4oGJrGnnasSji3O1VwS//bZorpnA98CaiDJ6jXquq79YJt?=
 =?us-ascii?Q?Mp25lPDqt0tBLCin6F7ob5jQz9BjJtp6MdB4NakwQVeq6/0BAYCe2KeM6dtC?=
 =?us-ascii?Q?m19Jye/ujt8XBZbBzFUnLA3u7wDgCfcTF5/iyLSU56t0x7BVlp5SfCSv125b?=
 =?us-ascii?Q?ypy/toQsg9tHNSAvffmKq44z83LZQ3ithWwG7ZhY45yx8seBTZPXLvIvZ/1S?=
 =?us-ascii?Q?0qypfduztway7cCJV8tcsX0qRE0v884F47ThAS4Gw8twPAK03iUp+7yFOhGj?=
 =?us-ascii?Q?YBS48LMeslzKc5S1eMYIFgHgzhJUuhfyO1oXiIvbycLfDGgdpNtRidJimrBq?=
 =?us-ascii?Q?AvvX1t14MaHWoungpET0Q8rMGn9AM3kRimD6G+pyyZN3sSqYJxWYPWNBYq+i?=
 =?us-ascii?Q?leHEDXnv+aXmiKXr4hGgqQupedLSZlxk4GHzWrSjNhQzdfb6poctdvZF1Z2U?=
 =?us-ascii?Q?JRWToVsGluLgzmHZleb7a3ibbJc4Ku68nnm6dp4H7GDd7v9twibxq28EpJJO?=
 =?us-ascii?Q?gxuG1aiNuw3NApDx+0h5266lITE7dgPcXEYGwxnDsyD392xj/d9tx67puQzZ?=
 =?us-ascii?Q?1vKh9sEGoq3iPR14kxD5VqYjJ7AGxfcN5Ek7h3IXFZP8NE0MbS1dV4gxUyW0?=
 =?us-ascii?Q?meTgybuYJKouVHAZ+eZ1CtmmK5Ww0iCTHwlxK5W8u4ijCbmXiCoGbXaN0Gok?=
 =?us-ascii?Q?M05huyGvtyH6T/2FQkKCjlMwzdPMbw02y6K0?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 15:45:38.9426
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49918550-0c0f-4f3f-b94a-08ddeb00ee7d
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8462
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 03 Sep 2025 15:45:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17952

From: Chris Laplante <chris.laplante@agilent.com>

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 52fffe21d..0fcdb19df 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -163,7 +163,7 @@ class Git(FetchMethod):
             bb.warn("URL: %s uses git protocol which is no longer supporte=
d by github. Please change to ;protocol=3Dhttps in the url." % ud.url)
=20
         if not ud.proto in ('git', 'file', 'ssh', 'http', 'https', 'rsync'=
):
-            raise bb.fetch2.ParameterError("Invalid protocol type", ud.url=
)
+            raise bb.fetch2.ParameterError(f"Invalid protocol type: '{ud.p=
roto}'", ud.url)
=20
         ud.nocheckout =3D ud.parm.get("nocheckout","0") =3D=3D "1"
=20
--=20
2.43.0


