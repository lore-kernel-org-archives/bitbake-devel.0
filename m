Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36177CA0FED
	for <webhook@archiver.kernel.org>; Fri,  5 Sep 2025 15:37:38 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.85])
 by mx.groups.io with SMTP id smtpd.web11.857.1757086652469240358
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Sep 2025 08:37:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=zgUfUFMD;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.93.85, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NXPqzx04VTJvv8cJVydCMsnmziRBizpaQM0vdMyd/xX7tMn0PqBdOgkEhs/IdtMyxXMj3eRugdlinkyJEmsIo6t/Mehiu6+VDsuyb3HvDwvYY9gWhWGKYtAOlU9kyrQWapnkezGKoTGo53WDUz37RjcwRN3Pjpb+9xetmNTu0vmU/Fl9RgZ28+fKikSk74qaJKNrc5ySUFmDoowiwPxbGOtND3LWNN4rTVO+Fn2OBB4xF7N5hTyqJtLl9s9GpiQg1aVvgSWcmWzjKrynSsmDDsNXPZKg818SaJO4avaY0EVl4tTwOGnxggeEmyaZRoN6sgFfUj1/426BS1Qn5pK9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/VF6ApbdVNjHkcAiOyjod9TUUfKF1OFCKVYbDpqyoU=;
 b=v8/I3FEIbFDb4ZlDWfSm+zXovNQIJcsKmA0VyHXn+lseJx26x53BdVc2WuJJ9T4As9k+dZodfOOk8psLqbIZe/e6J1bj277hJSesl79GERdfLg9HxvpMmUO00W9roXdWE1dgd8HBnW6v3dRuVXLE7ArKytmZzVPiI5gwdRupZ3wsJL85H+G73z+q0TJOBx+spIVGyvEUPfkIdBRwXjmfGUMN3Zq1BRASL5QjaJrAteU5Pp3hDTNrGuq4WgH/3Lmp0iqGdFVK6+gwgXYUuNI6RhvyWrpqV0KaIg0eMrXH7pFvDfVjtDaC2VHg4xuf7aB/KyIh8m58b5MaqM4O5Z0k4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.41) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/VF6ApbdVNjHkcAiOyjod9TUUfKF1OFCKVYbDpqyoU=;
 b=zgUfUFMDlZdZIss9StfYRfOBFyMnjzdHqTN0Mp6UEUZZvwTT0aIN3Pu9SxaTPBXxeEtcfh1PnMIF3TmQS+hSg4JHVimDLfg528AuA0miGqPw6bg7M++n5yPBpIFK4MuM3qfV3LRAdTxY7aoHniA6s8r4XF9U1vt97/73hrmfLdXu90UENyPb7/Hw8gSnczm0jeGW1B9L+zsmLaRVriPVoj7dUBiiQXbN7PfvVxQ1i6B119JtroRUOlVEOIuM4NrxOqFoam2/HjpruEpKj7VV9yuiYMJwaSyThy1ka6i3W2gTuunh5zN+p2ZkyF1v1mzK/wiUirWsezni1u0vRpqQWA==
Received: from BN8PR07CA0011.namprd07.prod.outlook.com (2603:10b6:408:ac::24)
 by MW4PR12MB6705.namprd12.prod.outlook.com (2603:10b6:303:1e3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 15:37:27 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::62) by BN8PR07CA0011.outlook.office365.com
 (2603:10b6:408:ac::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Fri,
 5 Sep 2025 15:37:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.41)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.41 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.41; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.41) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 15:37:26 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.5) by
 edgeappmail.agilent.com (192.25.218.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.58; Fri, 5 Sep 2025 09:36:59 -0600
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <steve@sakoman.com>, Bin Lan <bin.lan.cn@windriver.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>, Chris Laplante
	<chris.laplante@agilent.com>
Subject: [2.8][PATCH] bb/fetch2/__init__.py: remove a DeprecationWarning in uri_replace()
Date: Fri, 5 Sep 2025 11:36:32 -0400
Message-ID: <20250905153632.4073342-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|MW4PR12MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a531e4f-7f86-4ea6-c32a-08ddec921dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TZCNGCbcj710uRNi8iDhYJdY+uQ1AZNvy3R5bJkc++s2p7l6pfpSnq1ZyvP3?=
 =?us-ascii?Q?GFhrPk7eXcyO/WjdcO/b6oWZ/JLNwcbUkpsCD/VxAwzUBhz4nvfSUrDWvB0h?=
 =?us-ascii?Q?hL+EHsjvFm4ZXaDv0O1mukXcOdm0SnVYJLzDBKVXo5iD4fm6hiszN0g774rf?=
 =?us-ascii?Q?TtUUNhVPlAZX6Rv04eK5Xnl1d+v7igiFMwqQSxjIHMSNRQkkx6GSHfpKFQBf?=
 =?us-ascii?Q?3qLc64uly8/3mPGouITje5KJ2uuIuMV9KPR4EqRqSzVQ1CQnuD6FBu5ReuFV?=
 =?us-ascii?Q?G3RUEqOI79uagO0IuUQE0HPDDrKrTHeRb6+89d/VnaIsPN47eIrmo8ELf6NY?=
 =?us-ascii?Q?EwIJdrQc26lA9SnEq+SB6pTmXeL3c3KbBVUjxaVmgyr5d6avELjlWCaDbZuu?=
 =?us-ascii?Q?MChlT20UBwhhU3qrvP2niospG6mH1yzi7kjAyCDk7lmypQnQaIXjsVaQ7ZJ8?=
 =?us-ascii?Q?LOH4ryS0aeecSzByvWU7pwjqr1St9f8fxKgt+wyS+2yuhiZ63L7Ez9ChbGhT?=
 =?us-ascii?Q?bXHezYn0nei+wnDwkzl68XzUOqPJKnyWXOlW6pbzS61Vcn2JhLemFbG3GmC8?=
 =?us-ascii?Q?CqOPwHxMeVb71SE70paCS2BqMGXYEpDaRzPrvmBXZXhosQoW1XEsJDEJuovz?=
 =?us-ascii?Q?6kCPz+SEeue9wl8+3TnpUGTMUGebHQFg08docOHRD10xtPgdqIeb/3NqG2X6?=
 =?us-ascii?Q?6UH/S9fEfuKXr4e5lSzMZaSHn58JPvZBeiJRb0e8PJSckAz5iYdtdo9OHxT9?=
 =?us-ascii?Q?RTtuwROTwogHCUHGmzvVsegHv2XsjW2eTD8DhEquPB5b9njptRlOIMLFXpYO?=
 =?us-ascii?Q?o4zayBAMVyUrOXBo/4OWKRkVoS44UFIaPSzrQ6xAyP2AMZl20y7afXXPmSog?=
 =?us-ascii?Q?tuKDvXV+moatN9qSwLVkaqinB4jEnR5B5/COqqD73c6v8B7ZqwbXaMfmFXWm?=
 =?us-ascii?Q?CuNMiNRscJvmqA84TImiW5AdyngT5/cAGtxoV0LTR3wzDrIm9K9vPazX0vXG?=
 =?us-ascii?Q?Fzs7eqmof0T5wOdFDEBvHg2lAmcYqxtYFnQPfC9jIttHUY2/gddbLbCOriK4?=
 =?us-ascii?Q?Udwul2b2cgwSmd2pSR/49Mm+AJ9m2t4vM+xVdd6LkOo2PIco1273PHdqlCUV?=
 =?us-ascii?Q?v0GiGgJ4/hqGX4SOKNT4+N56nd0qgP+pstbwTDpwcaxvKuummvvLnwaBDxrr?=
 =?us-ascii?Q?d3t7ktTQgveiUF/7Z14htdtd2H472Br3cHTC8jta6HnDcLVOkUwypvvMUjwH?=
 =?us-ascii?Q?nFrl8MsYPq0wT6+3kvNqcvx2rqg1YvtK9BLhG5SPxvVK/NMJtCvP9fwPIIAt?=
 =?us-ascii?Q?BuifT8qcffCzMKGiqKaWlOKf5KtAKWZK+8Uk+MXlv8R/gYXMWsUiP4peI/1T?=
 =?us-ascii?Q?LUMcj78oE346WyDzMOT1mQJ4iVBtGNBik9OGEiuaI9Px3Ic5ocRSRqaFucH+?=
 =?us-ascii?Q?ONFD2hKGmqCNUqmfi7/8UwgqRdd2ulgli4erWv/L8hFBfc9FdxUBKYkLGkxR?=
 =?us-ascii?Q?QqJ5+xTXdslQDaqHQstBmI2sUBIJx9zQPinv?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.41;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:exch.smtp.agilent.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 15:37:26.2341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a531e4f-7f86-4ea6-c32a-08ddec921dab
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.41];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6705
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 05 Sep 2025 15:37:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17982

From: Bin Lan <bin.lan.cn@windriver.com>

There is the following warning when executing to bitbake linux-yocto:
  bitbake/lib/bb/fetch2/__init__.py:464: DeprecationWarning: 'count' is pas=
sed as positional argument

This is because the 4th parameter of re.sub(pattern, repl, string, count=3D=
0, flags=3D0)
is a keyword parameter. We use keyword arguments for parameters that are no=
t positional.

Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 1a6ff25d4..7b75d5d83 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -460,7 +460,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements=
, d, mirrortarball=3DNone):
                 for k in replacements:
                     uri_replace_decoded[loc] =3D uri_replace_decoded[loc].=
replace(k, replacements[k])
                 #bb.note("%s %s %s" % (regexp, uri_replace_decoded[loc], u=
ri_decoded[loc]))
-                result_decoded[loc] =3D re.sub(regexp, uri_replace_decoded=
[loc], uri_decoded[loc], 1)
+                result_decoded[loc] =3D re.sub(regexp, uri_replace_decoded=
[loc], uri_decoded[loc], count=3D1)
             if loc =3D=3D 2:
                 # Handle path manipulations
                 basename =3D None
--=20
2.43.0


