Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.117])
 by mx.groups.io with SMTP id smtpd.web11.2546.1614626677383168312
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Mar 2021 11:24:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arrigroup.onmicrosoft.com header.s=selector1-arrigroup-onmicrosoft-com header.b=HGjruVgQ;
 spf=pass (domain: arri.de, ip: 40.107.7.117, mailfrom: mleonhardt@arri.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgIpcRCkfb2tttwQVcPT96sUmAlikBwOe25eHrkaduclOjtMMAeE2SwyhHg7PXWf1TREiszhVys+Y/pwlZSlc//XYaV9D3VOy8i9heSIvHox4+wnpmRslVRk3uaKp8trbggfZyMao1WmXI7h3lFIU5zTccj6Bj3KyZ5EMMzqfcMOE8S0gKYtvDYLw3jUDsUDVYiy+Wnj4SVl+XoWQFVsX85W+EZ8w3ckLieLRKfOC58wi7Q+KPV9/sgAQNJDTMO/vUEUT6LydrV/rpBc6eebkdF0Nn7Qp1h1aVjyyio9uRAC9JMiiHfM3sxpprZ3lt3Csu3lP+tX9lxqqI7ZNy2ERg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iAGOkjWqH8u9+w0L/InypPSLEyZT6RuBfVhvxY7ZWc=;
 b=espprvnQ8dHPQKfJ1zvb6mJlit1I76Z2I5pvptseqHOnc19sdHdD8CJ9ixbb4/4vku1UqsrCYYH6d2hSMFcnuVfPQvEdButUhGIJGfM8du/mMPbf532daAhGUr64q4NILDPiMtZLFendi8pizNGRTpPVuutXlvaOigaZkuNgo0u1LpBmRo1arG5/FGSD51GMMq7hWnzQtMSosPOgNyeZZwlFJDAmIw5Bss4DmaG9EyIfpjIhmM2NTBTU6TPHinMWYQarXFxqfCWIrTln6rU2WUZq6PlbWv5hhlT9KCdJ1H2hd7qejABABgSEhPVzMc+vXk4BzjitXNzXXmp19C3/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 52.169.0.179) smtp.rcpttodomain=lists.openembedded.org smtp.mailfrom=arri.de;
 dmarc=bestguesspass action=none header.from=arri.de; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8iAGOkjWqH8u9+w0L/InypPSLEyZT6RuBfVhvxY7ZWc=;
 b=HGjruVgQpKlJOGVuzFAF1dDEtXufGH3OtY/KHl3nwpOuV+MxkS/ywSLD9VHQDaJFt2wVzxQvi2PeYU2H2AATBHJUSaivTb2DMq579qvRh63jw/rGwgT1VDy7TDUEa/pweyKOB0ZGhe6ZkGssoeWtOd5P9TR8JZ0SZ9/fL7BbnhE=
Received: from AS8PR05CA0012.eurprd05.prod.outlook.com (2603:10a6:20b:311::17)
 by AM6PR07MB5286.eurprd07.prod.outlook.com (2603:10a6:20b:62::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.11; Mon, 1 Mar
 2021 19:24:34 +0000
Received: from HE1EUR02FT052.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:311:cafe::26) by AS8PR05CA0012.outlook.office365.com
 (2603:10a6:20b:311::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Mon, 1 Mar 2021 19:24:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.169.0.179)
 smtp.mailfrom=arri.de; lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=bestguesspass action=none
 header.from=arri.de;
Received-SPF: Pass (protection.outlook.com: domain of arri.de designates
 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net;
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 HE1EUR02FT052.mail.protection.outlook.com (10.152.11.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 19:24:32 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (104.47.4.56) by
	 eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
	 ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
	 tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Mon, 1 Mar 2021 19:24:33 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 9581565
X-ExclaimerImprintLatency: 3904311
X-ExclaimerImprintAction: c071ece161a34d7e97a040f6214d8a01
Authentication-Results-Original: lists.openembedded.org; dkim=none (message
 not signed) header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=arri.de;
Received: from AM0PR07MB5298.eurprd07.prod.outlook.com (2603:10a6:208:f7::27)
 by AM8PR07MB7604.eurprd07.prod.outlook.com (2603:10a6:20b:242::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.11; Mon, 1 Mar
 2021 19:24:29 +0000
Received: from AM0PR07MB5298.eurprd07.prod.outlook.com
 ([fe80::3c22:dd8:7408:771b]) by AM0PR07MB5298.eurprd07.prod.outlook.com
 ([fe80::3c22:dd8:7408:771b%6]) with mapi id 15.20.3912.015; Mon, 1 Mar 2021
 19:24:29 +0000
From: mleonhardt@arri.de
To: bitbake-devel@lists.openembedded.org
CC: Manuel Leonhardt <mleonhardt@arri.de>
Subject: [PATCH] tinfoil: Honor quiet when parsing recipes
Date: Mon,  1 Mar 2021 20:24:20 +0100
Message-ID: <20210301192420.19602-1-mleonhardt@arri.de>
X-Mailer: git-send-email 2.30.1
X-Originating-IP: [2001:a61:a94:a901:b87f:418c:7556:2913]
X-ClientProxiedBy: AM0P190CA0015.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::25) To AM0PR07MB5298.eurprd07.prod.outlook.com
 (2603:10a6:208:f7::27)
Return-Path: MLeonhardt@arri.de
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MN-C02ZH1SVLVDR.fritz.box (2001:a61:a94:a901:b87f:418c:7556:2913) by AM0P190CA0015.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28 via Frontend Transport; Mon, 1 Mar 2021 19:24:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 855cf37a-d791-4a1d-065d-08d8dce7a4d2
X-MS-TrafficTypeDiagnostic: AM8PR07MB7604:|AM6PR07MB5286:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<AM6PR07MB5286913ADA9ECF4507AE1063D39A9@AM6PR07MB5286.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;OLM:785;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 hDJ+Sc1wD6q0+PST6TmgoVoI3Cs8e1VT/mmrWHbemtjvcqB9orFXF9n/2IJf7Sd2guXP6k0zJnBp+pHehVENrxBHJSPjtqsOD6FPBb/piJlRqo4oKfqrgMgD01N6lgfZ6bTlVt78qKffilCMaLNcmcU12BWq+oEMqgkuctQAeMCBTqxBJvHYIjRYflhJoxrFII+56p0SjZGVpUA1PE15FUPjsLJfUfr/xJIiAVKUwHaZXDZB4h3iYEcXfRBVfo2DE61ikbJ7clN9DaXsJ7nh0OM0xpOR4CXx/FDjpIBVicga5N3PmzpabmxnJT27fPsWx8bbrqbPL/aoSZNC7VuxS0IgiXCxeFq17qTcQISdxz/F26Ju4go0smieKqnyFxtdLR1F+rq0U1XJXaJZBQlIe1IUJBryhkQPt3nt0zmhwvphfsUbVabVeQ/OG73UYa1NjPvijzRCjeRrARoV5FPPdagQlU+KmW/ME9cVhf4dVfORXYT2fNBzkviUqQ1IeeU/OxT22U47WRmeitujoEz+Ag==
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB5298.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39850400004)(346002)(136003)(376002)(6512007)(4744005)(66556008)(4326008)(66476007)(6486002)(1076003)(66946007)(6506007)(186003)(107886003)(16526019)(478600001)(2616005)(6916009)(5660300002)(2906002)(316002)(6666004)(8936002)(83380400001)(86362001)(8676002)(52116002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 
 =?us-ascii?Q?s8ibMMRo7h84k5sxHDS8ujNsBu0WvGf9ytqN4lHpncmkTx/c1Kr0FT+iVPuZ?=
 =?us-ascii?Q?scDMWZrTH/5Xepgux46T8zpmXRiq07e39CBkPA5A6ViPeP3+teOIz7/sHUgS?=
 =?us-ascii?Q?co5NaAFoqBwXtbshWQrnXVnJQ7mEY5grOxD0k1YtdeaneBMx9KS6rErEMVHN?=
 =?us-ascii?Q?s8LgCCHAbsnO78rHEVFCbasPOosh9FdAmfaOpbPIag+m+CScKziWX5Ojnw75?=
 =?us-ascii?Q?YFoRC30y0g4UohsuHRFdeBRslrXff9nThjvTalk9/elci9zwiThrJJwitUva?=
 =?us-ascii?Q?d4AzzOwaNJQXXYpE8+Yo1pICDYCoe08G1nbgXpEEundsrUflc6ywGi7wN8Iu?=
 =?us-ascii?Q?Pv0lFizqU8M3Kyzn0Y4mftsrVfGEsvZi1DQFkiGpYGl8EAYLJtnqZUenxNOe?=
 =?us-ascii?Q?So0zSkw8oOhOqzjfHHCv5q0nNSew+6UrPhUFI78k9nwGECeqbh3A75nVBOhU?=
 =?us-ascii?Q?1/AlvIx+e2JYHHdPstX2GrspWubCNGJ9bDHsF0DgDiuL/7XeS6SKAsZCL9Yq?=
 =?us-ascii?Q?yTcrMYVuvOqjqgTioYXOlKrTiea0GAOlZPtcZhkYE7qIAvSQShj+iMly/asb?=
 =?us-ascii?Q?zBTOV/aIfuZwSclopEIbNj0S+3lp5NzSYAJmKGZll7bBMDXBUboyzku/vBm0?=
 =?us-ascii?Q?XZwmxHT4qCQlbXekwTwScKCAa/uk+lVydkAdsN9YvVmONBpJ80YncdMOB3h/?=
 =?us-ascii?Q?SWn/8vHPB56GOmjGtF1QpPrOXL4yCLexY+WIrDJil9/+IklNMJoOLbhmAcEe?=
 =?us-ascii?Q?3dk3WVShQIkULen1rY1RdSg4xgQGfs2RSPeqR0vrFHzHAeWs7+6P/aqOaej/?=
 =?us-ascii?Q?TD5Rf+TN0b6c2Kp2D20vwaCAJX9CcEAXyc26lDzVHTSex3iCFh8yYxbHFWCn?=
 =?us-ascii?Q?V1M+IyB3tB9clFg8eJBnt3nzwRMLwVvjRTblawVjjw2QRtsvtQaxChEeQXLI?=
 =?us-ascii?Q?2T2Pir8T57x7Jt3Dcoc4jZRSqOmQ6K267eC5Yj7wd6Uk3ZHMQmVWaypKz7y3?=
 =?us-ascii?Q?3GhauHp3xX/7s3gUAdV2hEsqdWkEhKyW/COt7rtV9T0OjfM4GIW7ySRgeKUu?=
 =?us-ascii?Q?B4DDMyipBlGVgOKvG/GoPMEiFetrPMSYvfux4wLBz1ntPBh0xGfUgZghFItI?=
 =?us-ascii?Q?tsniGgPLraOshfHBcdt5+LEqq6DzyFJlBPPJ6MERFyGAoYpNRLTWioCkM0id?=
 =?us-ascii?Q?B1pRq4c8fxcax3o0C4QCkJdpLixlyK/4X/wRoZghh0FB9nBlfZhjouCCdU6M?=
 =?us-ascii?Q?+zSWKfIR1KHqvgTd9msvHesUOzIHVZGyr1LjaUe9FBS/i0vlc9/FG2JxD1LD?=
 =?us-ascii?Q?0r46rCTBsnaZADll0cjL1c6zS+tVRa9p48H8i0YXCsAjGP7Q9DB9E6NPQeWy?=
 =?us-ascii?Q?EHghzgqb5K0QCkVtX0CYtzdKa6Hu?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR07MB7604
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 HE1EUR02FT052.eop-EUR02.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	30f7acf9-dd94-4a74-1349-08d8dce7a22c
X-MS-Exchange-MinimumUrlDomainAge: youtube.com#5858
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YjdTcIIlawxU4iUhnFyXSW98e+J3/4KDPu7D45QWKZS9tcCDNq0MSaNLjBfD+vmOkFfqly8jQynFuXN+q42xJDEVWWcfxH099LBlO8Axgb8b4y9yYyWgh+6l3dZtJ5IauA2MY72Ci4GosddXTEEYfid7mSeSc0E3CgW9Xy0Kj4yYAKDe2eS0fxTQBw5GElHT+pglSu/W9Z1VolxvUoUdoNg1Q0xVydp1MNUo2xq4dZsLpMIGKssr/C73vwi0w/oamlpfJv0/HdidPnqWYXrEXtet2gKKXKXiRRN2DaFMMvnEC6hev3SZwrh6OjJRxAVPoUMpiAQHD4LANuuT/eBnVV1gSJoFIctaVKNBobGmCgUKpuz5+dXeA0Sezo0GogCFIWxEqyQJD2C4LO7vsErUZC9Ur4gnzGNTvknmlvJq6RKc+R0adnAfvVNYgDmanrHYzdlVaguWd1ApzWnBV+iIkSUugyTbhd0gbNMrlNmwFL22j/59116YdXEGjhgfxKv6fy7xKYSr33XMGQaGlMK1VMhjGrVohOZGrupIqOYpOYDPIapUEyQ6TvyT021/Hw+3GGB8bjwXOcemf2/KTmgf0eYZKiKzH5RMAxIgUrB1WUk/JQutpWyQ9wo/2Yl6neyF/MJwAoNX3Hy+EpdtvNUUc5/YeuCSLv5KqJUqSY/PBE4jMTic0/dVhNOcJnWeqXAVPaTAOxiHrS9Rmi9ZTBn8HyA7YslWSVT1OwM2lYE1sYI=
X-Forefront-Antispam-Report: 
	CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39850400004)(36840700001)(46966006)(478600001)(166002)(2906002)(8936002)(1076003)(66574015)(82740400003)(82310400003)(4326008)(6512007)(6506007)(6666004)(7066003)(8676002)(107886003)(15974865002)(47076005)(33964004)(7596003)(7636003)(70586007)(6916009)(186003)(5660300002)(83380400001)(86362001)(70206006)(316002)(36756003)(6486002)(356005)(336012)(16526019)(26005)(66576008)(2616005)(36860700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 19:24:32.8371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 855cf37a-d791-4a1d-065d-08d8dce7a4d2
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR02FT052.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR07MB5286
X-Groupsio-MsgNum: 12060
Content-Type: multipart/related;
	boundary="----_=_NextPart_19ec5bb3-2147-41c2-9f51-124fa075990d"

------_=_NextPart_19ec5bb3-2147-41c2-9f51-124fa075990d
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_6a1ed358-eeab-4298-8281-c48067e0df8f"

------_=_NextPart_6a1ed358-eeab-4298-8281-c48067e0df8f
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

When using parse_recipes, honor quiet so that scripts and custom plugins
for recipetool are able to mute progress bars from bitbake that would
otherwise print to STDOUT.

Signed-off-by: Manuel Leonhardt <mleonhardt@arri.de>
---
 lib/bb/tinfoil.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 763c3298..796a98f0 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -440,7 +440,7 @@ class Tinfoil:
         to initialise Tinfoil and use it with config_only=3DTrue first and
         then conditionally call this function to parse recipes later.
         """
-        config_params =3D TinfoilConfigParameters(config_only=3DFalse)
+        config_params =3D TinfoilConfigParameters(config_only=3DFalse, qui=
et=3Dself.quiet)
         self.run_actions(config_params)
         self.recipes_parsed =3D True
 
-- 
2.30.1


_______________________________________________________
Manuel 
Leonhardt
Softwareentwickler
=E2=80=8B
ARRI
Arnold & Richter Cine Technik GmbH & Co. Betriebs KG 
Herbert-Bayer-Str. 10, 
80807 
M=C3=BCnchen
www.arri.com 

+49 89 3809-1719
MLeonhardt@arri.de

=E2=80=8B
Get all the latest information from www.arri.com, Facebook, Twitter, Instag=
ram and YouTube.

Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Sitz: M=C3=BCnchen - Registergericht: Amtsgericht M=C3=BCnchen - Handelsreg=
isternummer: HRA 57918
Pers=C3=B6nlich haftender Gesellschafter: Arnold & Richter Cine Technik Gmb=
H
Sitz: M=C3=BCnchen - Registergericht: Amtsgericht M=C3=BCnchen - Handelsreg=
isternummer: HRB 54477
Gesch=C3=A4ftsf=C3=BChrer: Dr. Michael Neuh=C3=A4user; Stephan Schenk; Walt=
er Trauninger; Markus Zeiler

=E2=80=8B

------_=_NextPart_6a1ed358-eeab-4298-8281-c48067e0df8f
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8" /></head><body><div>When using parse_recipes, honor quiet so that=
 scripts and custom plugins<br />for recipetool are able to mute progress b=
ars from bitbake that would<br />otherwise print to STDOUT.<br /><br />Sign=
ed-off-by: Manuel Leonhardt &lt;mleonhardt@arri.de&gt;<br />---<br /> lib/b=
b/tinfoil.py | 2 +-<br /> 1 file changed, 1 insertion(+), 1 deletion(-)<br =
/><br />diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py<br />index 763c3=
298..796a98f0 100644<br />--- a/lib/bb/tinfoil.py<br />+++ b/lib/bb/tinfoil=
=2Epy<br />@@ -440,7 +440,7 @@ class Tinfoil:<br />         to initialise T=
infoil and use it with config_only=3DTrue first and<br />         then cond=
itionally call this function to parse recipes later.<br />         &quot;&q=
uot;&quot;<br />-        config_params =3D TinfoilConfigParameters(config_o=
nly=3DFalse)<br />+        config_params =3D TinfoilConfigParameters(config=
_only=3DFalse, quiet=3Dself.quiet)<br />         self.run_actions(config_pa=
rams)<br />         self.recipes_parsed =3D True<br /> <br />-- <br />2.30.=
1<br /><br /></div><div style=3D"mso-line-height-rule:exactly;-webkit-text-=
size-adjust:100%;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" =
style=3D"width:100%;"><tr style=3D"font-size:0;"><td align=3D"left" style=
=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=
=3D"0" style=3D"font-size:0;"><tr style=3D"font-size:0;"><td align=3D"left"=
 style=3D"padding:0;vertical-align:top;"><table cellpadding=3D"0" cellspaci=
ng=3D"0" border=3D"0" style=3D"width:100%;font-size:0;"><tr style=3D"font-s=
ize:14.67px;color:#7F7F7F;font-style:normal;font-weight:400;white-space:now=
rap;"><td align=3D"left" style=3D"vertical-align:top;font-family:Calibri,Ar=
ial,sans-serif;">_______________________________________________________<sp=
an style=3D"font-family:remialcxesans;font-size:1px;color:#FFFFFF;line-heig=
ht:1px;">&#8203;</span></td></tr><tr style=3D"font-size:0;"><td align=3D"le=
ft" style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0=
" border=3D"0" style=3D"font-size:0;"><tr style=3D"font-size:0;"><td align=
=3D"left" style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacin=
g=3D"0" border=3D"0" style=3D"font-size:0;color:#7F7F7F;font-style:normal;f=
ont-weight:400;white-space:nowrap;"><tr style=3D"font-size:14.67px;"><td al=
ign=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,sans-ser=
if;">Manuel</td><td align=3D"left" style=3D"vertical-align:top;color:#00000=
1;font-family:Calibri,Arial,sans-serif;">&nbsp;<br /></td><td align=3D"left=
" style=3D"vertical-align:top;font-family:Calibri,Arial,sans-serif;">Leonha=
rdt</td></tr></table></td></tr><tr style=3D"font-size:0;"><td align=3D"left=
" style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" =
border=3D"0" style=3D"font-size:0;color:#7F7F7F;font-style:normal;font-weig=
ht:400;white-space:nowrap;"><tr style=3D"font-size:14.67px;"><td align=3D"l=
eft" style=3D"vertical-align:top;font-family:Calibri,Arial,sans-serif;">Sof=
twareentwickler</td></tr><tr style=3D"font-size:14.67px;color:#000001;"><td=
 align=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,sans-=
serif;">&#8203;</td></tr></table></td></tr></table></td></tr><tr style=3D"f=
ont-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><table cellpa=
dding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;"><tr style=
=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><table c=
ellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;color:=
#0E50AD;font-style:normal;font-weight:400;white-space:nowrap;"><tr style=
=3D"font-size:13.33px;"><td align=3D"left" style=3D"vertical-align:top;font=
-family:&#39;Arial Black&#39;;">ARRI</td></tr><tr style=3D"font-size:10.67p=
x;color:#7F7F7F;"><td align=3D"left" style=3D"vertical-align:top;font-famil=
y:Arial;"><span style=3D"font-size:11px;">Arnold&nbsp;&amp;&nbsp;Richter&nb=
sp;Cine&nbsp;Technik&nbsp;GmbH&nbsp;&amp;&nbsp;Co.&nbsp;Betriebs&nbsp;KG</s=
pan>&nbsp;<br /></td></tr></table></td></tr><tr style=3D"font-size:0;"><td =
align=3D"left" style=3D"vertical-align:top;"><table cellpadding=3D"0" cells=
pacing=3D"0" border=3D"0" style=3D"font-size:0;color:#7F7F7F;font-style:nor=
mal;font-weight:400;white-space:nowrap;"><tr style=3D"font-size:10.67px;"><=
td align=3D"left" style=3D"vertical-align:top;font-family:Arial;">Herbert=
=E2=80=91Bayer=E2=80=91Str.&nbsp;10</td><td align=3D"left" style=3D"vertica=
l-align:top;font-family:Arial;">,&nbsp;<br /></td><td align=3D"left" style=
=3D"vertical-align:top;font-family:Arial;">80807</td><td align=3D"left" sty=
le=3D"vertical-align:top;font-family:Arial;">&nbsp;<br /></td><td align=3D"=
left" style=3D"vertical-align:top;font-family:Arial;">M&#252;nchen</td></tr=
></table></td></tr></table></td></tr><tr style=3D"font-size:0;"><td align=
=3D"left" style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacin=
g=3D"0" border=3D"0" style=3D"font-size:0;"><tr style=3D"font-size:0;"><td =
align=3D"left" style=3D"vertical-align:top;"><table cellpadding=3D"0" cells=
pacing=3D"0" border=3D"0" style=3D"font-size:0;color:#1532B9;font-style:nor=
mal;font-weight:400;white-space:nowrap;"><tr style=3D"font-size:11px;"><td =
align=3D"left" style=3D"vertical-align:top;font-family:Arial;"><span style=
=3D"text-decoration:underline;"><a href=3D"http://www.arri.com/" target=3D"=
_blank" id=3D"LPlnk689713" style=3D"text-decoration:underline;color:#1532B9=
;"><strong style=3D"font-weight:400;">www.arri.com&nbsp;<br /><br /></stron=
g></a></span></td></tr><tr style=3D"font-size:0;"><td align=3D"left" style=
=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=
=3D"0" style=3D"font-size:0;color:#858080;font-style:normal;font-weight:400=
;line-height:normal;white-space:nowrap;"><tr style=3D"font-size:14.67px;"><=
td align=3D"left" style=3D"padding:0;vertical-align:top;font-size:0;"><img =
src=3D"cid:image111135.png@9E9F7688.2748F5E0" width=3D"20" border=3D"0" alt=
=3D"" style=3D"width:20px;min-width:20px;max-width:20px;font-size:0;" /></t=
d><td align=3D"left" style=3D"padding:0;vertical-align:top;font-family:Cali=
bri,Arial,sans-serif;"><a href=3D"tel:+49%2089%203809-1719" target=3D"_blan=
k" id=3D"LPlnk689713" style=3D"text-decoration:none;color:#858080;"><strong=
 style=3D"font-weight:400;">+49&nbsp;89&nbsp;3809-1719</strong></a></td></t=
r><tr style=3D"font-size:0;"><td align=3D"left" style=3D"padding:0;vertical=
-align:top;"></td><td align=3D"left" style=3D"padding:0;vertical-align:top;=
"></td></tr><tr style=3D"font-size:0;"><td align=3D"left" style=3D"padding:=
0;vertical-align:top;"></td><td align=3D"left" style=3D"padding:0;vertical-=
align:top;"></td></tr><tr style=3D"font-size:14.67px;"><td align=3D"left" s=
tyle=3D"padding:0;vertical-align:top;font-size:0;"><img src=3D"cid:image777=
355.png@A74CDCCC.93C5CAB3" width=3D"20" border=3D"0" alt=3D"" style=3D"widt=
h:20px;min-width:20px;max-width:20px;font-size:0;" /></td><td align=3D"left=
" style=3D"padding:0;vertical-align:top;font-family:Calibri,Arial,sans-seri=
f;"><a href=3D"mailto:MLeonhardt@arri.de" target=3D"_blank" id=3D"LPlnk6897=
13" style=3D"text-decoration:none;color:#858080;"><strong style=3D"font-wei=
ght:400;">MLeonhardt@arri.de</strong></a></td></tr></table></td></tr></tabl=
e></td></tr></table></td></tr><tr style=3D"font-size:14.67px;color:#000001;=
font-style:normal;font-weight:400;white-space:nowrap;"><td align=3D"left" s=
tyle=3D"vertical-align:top;font-family:Calibri,Arial,sans-serif;"><br />&#8=
203;</td></tr></table></td></tr><tr style=3D"font-size:0;line-height:normal=
;"><td align=3D"left" style=3D"padding:0;vertical-align:top;"><a href=3D"ht=
tps://microsites.arri.com/orbiter/" target=3D"_blank" id=3D"LPlnk689713" st=
yle=3D"text-decoration:none;"><img src=3D"https://assets.arri.com/media/sig=
n/2021_arri_lighting_orbiter_sign.jpg" border=3D"0" alt=3D"" style=3D"font-=
size:0;" /></a></td></tr><tr style=3D"font-size:13px;color:#7F7F7F;font-sty=
le:normal;font-weight:400;white-space:nowrap;"><td align=3D"left" style=3D"=
padding:0;vertical-align:top;font-family:Calibri,Arial,sans-serif;">Get&nbs=
p;all&nbsp;the&nbsp;latest&nbsp;information&nbsp;from&nbsp;<span style=3D"t=
ext-decoration:underline;"><a href=3D"http://www.arri.com/" target=3D"_blan=
k" id=3D"LPlnk689713" title=3D"www.arri.com" style=3D"text-decoration:under=
line;color:#7F7F7F;"><strong style=3D"font-weight:400;">www.arri.com</stron=
g></a></span>,&nbsp;<span style=3D"text-decoration:underline;"><a href=3D"h=
ttps://www.facebook.com/TeamARRI" target=3D"_blank" id=3D"LPlnk689713" styl=
e=3D"text-decoration:underline;color:#7F7F7F;"><strong style=3D"font-weight=
:400;">Facebook</strong></a></span>,&nbsp;<span style=3D"text-decoration:un=
derline;"><a href=3D"https://twitter.com/ARRIChannel" target=3D"_blank" id=
=3D"LPlnk689713" style=3D"text-decoration:underline;color:#7F7F7F;"><strong=
 style=3D"font-weight:400;">Twitter</strong></a></span>,&nbsp;<span style=
=3D"text-decoration:underline;"><a href=3D"http://instagram.com/arri" targe=
t=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:underline;color:#7=
F7F7F;"><strong style=3D"font-weight:400;">Instagram</strong></a></span>&nb=
sp;and&nbsp;<span style=3D"text-decoration:underline;"><a href=3D"http://ww=
w.youtube.com/user/ARRIChannel" target=3D"_blank" id=3D"LPlnk689713" style=
=3D"text-decoration:underline;color:#7F7F7F;"><strong style=3D"font-weight:=
400;">YouTube</strong></a></span>.<br /></td></tr><tr style=3D"font-size:0;=
"><td align=3D"left" style=3D"padding:0;vertical-align:top;"><table cellpad=
ding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;color:#6A6A6=
A;font-style:normal;font-weight:400;white-space:nowrap;"><tr style=3D"font-=
size:10px;"><td align=3D"left" style=3D"vertical-align:top;font-family:Aria=
l;"><br />Arnold&nbsp;&amp;&nbsp;Richter&nbsp;Cine&nbsp;Technik&nbsp;GmbH&n=
bsp;&amp;&nbsp;Co.&nbsp;Betriebs&nbsp;KG<br />Sitz:&nbsp;M&#252;nchen&nbsp;=
=E2=80=91&nbsp;Registergericht:&nbsp;Amtsgericht&nbsp;M&#252;nchen&nbsp;=
=E2=80=91&nbsp;Handelsregisternummer:&nbsp;HRA&nbsp;57918<br />Pers&#246;nl=
ich&nbsp;haftender&nbsp;Gesellschafter:&nbsp;Arnold&nbsp;&amp;&nbsp;Richter=
&nbsp;Cine&nbsp;Technik&nbsp;GmbH<br />Sitz:&nbsp;M&#252;nchen&nbsp;=E2=80=
=91&nbsp;Registergericht:&nbsp;Amtsgericht&nbsp;M&#252;nchen&nbsp;=E2=80=
=91&nbsp;Handelsregisternummer:&nbsp;HRB&nbsp;54477<br />Gesch&#228;ftsf&#2=
52;hrer:&nbsp;Dr.&nbsp;Michael&nbsp;Neuh&#228;user;&nbsp;Stephan&nbsp;Schen=
k;&nbsp;Walter&nbsp;Trauninger;&nbsp;Markus&nbsp;Zeiler<br /></td></tr><tr =
style=3D"font-size:14.67px;color:#000001;"><td align=3D"left" style=3D"vert=
ical-align:top;font-family:Calibri,Arial,sans-serif;"><br />&#8203;<br /></=
td></tr></table></td></tr></table></td></tr></table></div></body></html>

------_=_NextPart_6a1ed358-eeab-4298-8281-c48067e0df8f--

------_=_NextPart_19ec5bb3-2147-41c2-9f51-124fa075990d
Content-Type: image/png;
	name="image111135.png"
Content-Transfer-Encoding: base64
Content-ID: <image111135.png@9E9F7688.2748F5E0>
Content-Description: image111135.png
Content-Disposition: inline;
	creation-date="Mon, 01 Mar 2021 19:24:33 +0000";
	filename=image111135.png;
	modification-date="Mon, 01 Mar 2021 19:24:33 +0000";
	size=528

iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAAAXNSR0IArs4c6QAAAARnQU1BAACx
jwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAAGlSURBVDhP1ZOxSgNBEIZ3o6QSSWGRwiJFCl9A
iCDEIqKFgo2FYGHjA1hYRZ0sGrURgq0WgkoqEUHQShJMYWFhmcLCwsIHsJBEs/5zmTvvJIE9sPGD
Zf7Zu/tvdndW/TVaogcRDSWVKlilMhvGVGQ6FoEhzAaTWt9AFji31q7C9Jh1HBISFSpbQPDMGK31
NlcsqTOBIRxmRPmkUTGJdubHUKmsxDA5ic6EDV8k+jRa1i6KdiYw/LL2QiTzDrNpY8yb5M4EhlvG
XKNdniXl9pkTHYvwkrlXDkTxIR3tEWUkcyZi2FbqBOGxm6lUR+tT7k/JnYgYYs8+sHfzkP7eTaJ1
LmGaktyjTDSGsSxphMjV89khyqGx7yG96rC3r7g5S5vGNHaJsrb7LI3RwPw6btQDv8f0NGRwTWYT
Wlch/eo+Mc5gPoWPfu9tpVgqrbGIHkoIVHOLQ5qAQVOmuNqVHma8guDK9jVkisY029aOQ/JhcYU9
wbLPRaoBiX2p1+utu1rtqpDPV9FKHVQziiqH5fETzMr40yHe68hcfPaJRnHyI5L+K5T6BsZ9gKi6
xb3hAAAAAElFTkSuQmCC

------_=_NextPart_19ec5bb3-2147-41c2-9f51-124fa075990d
Content-Type: image/png;
	name="image777355.png"
Content-Transfer-Encoding: base64
Content-ID: <image777355.png@A74CDCCC.93C5CAB3>
Content-Description: image777355.png
Content-Disposition: inline;
	creation-date="Mon, 01 Mar 2021 19:24:33 +0000";
	filename=image777355.png;
	modification-date="Mon, 01 Mar 2021 19:24:33 +0000";
	size=824

iVBORw0KGgoAAAANSUhEUgAAABQAAAAUCAYAAACNiR0NAAAAAXNSR0IArs4c6QAAAARnQU1BAACx
jwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAALNSURBVDhPtZQ/SNVRFMfv1Z/S4PCGBoeg1Uih
oaFB8j1wMGgweBJBgUNRUQ2BQaH2e79SaKipwcGhlkioQEiooT++7RUOBkYODg0GgiIOLyi1bp/v
/d3fL8U31hfuO/ec3z3nfM895z7zr2GDbIg4jgutxvQ6Yw5IRy5uGzOfJMmKP9AADQMSaH+LtQ/5
WEaNUutfEHj5t3OXbyfJTDDl2BNwPI7LxtoJthFOD5A1WM0hf7QY04FDB98vohdZjzeduwbjOnuP
piA9QrBnMJjl4KHRJBmD3hJlF5HdW8Z8HU6SqeFKpeScu4BLmUoepd4pcoYqs9XaLwo2UqkMoEfo
YjrIysreNs6dI+kk515b516wf4ptgETPdSBnqDtDRFuUIJ1g0s/jOE3pJ7TQZ30AY9pg4tmyn8E2
AYE29mlmdVMNwInrSFbG4vgq5kvY7lHeLZ0ROFcj0SrbCFYfZNM9N1n7XveLOucZajQQCl6TTsYr
MFv66dyo1wNItoFQg4QF/dAwL0GnfnxAnP2cqZu6S3WSD1MEwLQbnFVpdcpdlM6ZNcSatfaw9Cyg
2Ml5G7bd3ubcJ8md0D2RTEzmU0uOPLEPyM8yIiLqEYIXZMtY7wTJhsI2K1tJ2hHtEPgs3QfcVPdS
HGP5UijhtGSGO3F8EuOw9pmzGNOkSbYbkHkjGxWkGK9UXsGqk7Hp4tBLTN3oU2RcQvahH0VO49DP
XgxF4iyr8Is5zJ6hZyg08TY5XCDY3WbnzgTnMnKEz5FeBgN/ijG5gW1fSKLh7tr5pnOGguaPUjXQ
93l6GhlddlsYl13gmfZzVTXNbTB5NAfp8a5a/Vjq6flO0JsM6yD3sspaf1utruu77qy3WDzeWyo9
4T6HKO8bPunsBuximIHs+kfRo1eThA1KrHM46/w8pV/nzyNrZo6GATNwBRqjPtgeRK2H7i6MJEk+
Nv8ZxvwBPgIhrepF7fMAAAAASUVORK5CYII=

------_=_NextPart_19ec5bb3-2147-41c2-9f51-124fa075990d--
