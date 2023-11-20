Return-Path: <ceggers@arri.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A322C197A0
	for <webhook@archiver.kernel.org>; Mon, 20 Nov 2023 12:19:19 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.117])
 by mx.groups.io with SMTP id smtpd.web10.48802.1700482756225319195
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Nov 2023 04:19:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arrigroup.onmicrosoft.com header.s=selector1-arrigroup-onmicrosoft-com header.b=olyhPcwe;
 spf=pass (domain: arri.de, ip: 40.107.20.117, mailfrom: ceggers@arri.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJIDXdRhSvvAo2ymadWGP0vhker0KiAKguNA1Q4mir5KfRR2CZi0kWzGVFm+suW8E1EI5AhiX/RdonarHkCyNy17H4YAgCYhoyGSLL3rnl5jmy2d7tKGxtS66pUij0yX2QtbabkVX4XlJ1XkWVqh+y1XYgetgzRPLayQtypHxr2Wbs2N/KNzNmaXGpC+mjjD7coOgaHFBQMBiVE9SQt+HPYqPeG9Zkcy6ie3FwaOLzeP/uh8XrqungcyTDR5WzTOq9+Mvz2k3fCct7KtHYuiJuaKcbS0wz1J1rpSIlPdFw1DvYLGL8TbMofOhUWbwwkZMPE6JgfSBrg5VLPrHWG9nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+J+kmghLHgBpMyVH4FlZk+B6G0N1f5s9jK7JS+rB+e0=;
 b=m4sNPPBFvlwrYxXP4ZoxIa/dHC31TR00Iu16veEhpNfe+uR8kPLfhoZoom95eKWo2GVvfhRy1D2hM2Wk8VevhUaPxPrHZzpGL/g4LNSOQui6lEMmgLhNFv5POfjtb1NqHUsGkfJyC95IjoKvXXkrMeDwkqTgrbF355RCR3EjxrIWDfIsIuh+HOw12O3/fcnIPF08tK61FkMDsrW0x8463TveRi/gpPD0VgyNYRlwPMiBqPni6oa93KevtKnlQXbjE6MSMrWNrugeD0OHNecnrm93l7WOPZyuQUrmp+JMV/xP0tV1xFetehplcpK9h+h1XE+j6cMjjEAagj4zDFv0JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 52.169.0.179) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de;
 dmarc=bestguesspass action=none header.from=arri.de; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+J+kmghLHgBpMyVH4FlZk+B6G0N1f5s9jK7JS+rB+e0=;
 b=olyhPcwe5EjURv7w3qiLiPZdOR3HK+hOTBmfKs6e8dCgn6vMIRTpoXwiRUxM9zBb2dkC9QVcpBL5lMBlx0r4jCVesTEeHJkzw67VOcfvOEXxjqXTHrAspT+qdipsz/+JPoMGicJrWqQDBST1rOo2CzLimoRvbP3y7G41ajJIzSo=
Received: from AM6PR05CA0006.eurprd05.prod.outlook.com (2603:10a6:20b:2e::19)
 by PAXPR07MB9601.eurprd07.prod.outlook.com (2603:10a6:102:247::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 12:19:10 +0000
Received: from AM1PEPF000252DB.eurprd07.prod.outlook.com
 (2603:10a6:20b:2e:cafe::83) by AM6PR05CA0006.outlook.office365.com
 (2603:10a6:20b:2e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 12:19:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.169.0.179)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=arri.de;
Received-SPF: Pass (protection.outlook.com: domain of arri.de designates
 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net; pr=C
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 AM1PEPF000252DB.mail.protection.outlook.com (10.167.16.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 12:19:08 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (104.47.18.104)
	 by eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
	 ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
	 tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Mon, 20 Nov 2023 12:19:08 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 7747228
X-ExclaimerImprintLatency: 1948929
X-ExclaimerImprintAction: 1acb2dc1333c4feab7535e8b87720a71
Content-Type: multipart/related;
	boundary="----_=_NextPart_9019d6fb-ddff-461c-8348-22cfe73b6f01"
Received: from AM0PR06CA0091.eurprd06.prod.outlook.com (2603:10a6:208:fa::32)
 by VI1PR0701MB6797.eurprd07.prod.outlook.com (2603:10a6:800:198::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 12:19:05 +0000
Received: from AM3PEPF00009BA2.eurprd04.prod.outlook.com
 (2603:10a6:208:fa:cafe::e1) by AM0PR06CA0091.outlook.office365.com
 (2603:10a6:208:fa::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 12:19:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM3PEPF00009BA2.mail.protection.outlook.com (10.167.16.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.13 via Frontend Transport; Mon, 20 Nov 2023 12:19:05 +0000
Received: from n95hx1g2.localnet (10.30.5.31) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Nov
 2023 13:19:04 +0100
From: Christian Eggers <ceggers@arri.de>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] npm/npmsw fetchers: Support for "offline" builds?
Date: Mon, 20 Nov 2023 13:19:04 +0100
Message-ID: <2250070.iZASKD2KPV@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CANNYZj-cc2wDXUODqveROB6Hdpr0CnHoNLt49Nywfcpgs_19xA@mail.gmail.com>
References: <4851356.GXAFRqVoOG@n95hx1g2> <CANNYZj-cc2wDXUODqveROB6Hdpr0CnHoNLt49Nywfcpgs_19xA@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [10.30.5.31]
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: 
	AM3PEPF00009BA2:EE_|VI1PR0701MB6797:EE_|AM1PEPF000252DB:EE_|PAXPR07MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c8fa97-bb79-48ed-f43f-08dbe9c2e5c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 0aRinW3Rf+vgeT1b//kT1EWabM6wpWp/pMPGv+gyUKSVCpizBPS05mL7sOy86oh4rIfMnDC9dtWiKXkqvJSrZiUCnn+W+w3ZAW2x+Y5/dh0dZtimRvUtN/7n/NdJlJbBpWG6UEKBX8DTO8D+YjEd/hS/pjxI1LNHha9Kiywr9/9BgXAEWeE7qW3fkecR+CS4ffDcmIQGzc/6b+gDvScSlqQ/Yxf8iaGPzimgBRCZKt+EDHh9TONEUdswLRGosczbvEnY6TCcUAraPI2t+4yTFfStHWVa/7+CV3xKM+Tw5zjJboYmLtFMJL0H4nAFvECFYUCApB67xeO38i/uUt1lR1jDkux/qIfVDJtSNayqpZ3QqBjL+k8VhNUcqLOMqnnryaHM13r5fZEY7PvFnquee7HRPqehxmzT7lT49eUMt1vFgPYN8H6tlouHVlPJTszbTTp2tg8hRoEi7KYplVE9+uq1ZtGga+UCf5d3MN64qrf4mnQiMVAzbD4AGre0KTCi7QUWr+p/iGoRS3BGPBhSeo7wiA82mdB6m4rU9NcdlC4KvjGUerqIH951q2yw3HHe0ELNF6xO2+g18pSvV2MLlUxYGMrIAUVBe58T1wfyXODf8PF6EF+GriinDgn2Ma6uNzuAoXKukUd0ZrnXGfTFOMOx3tV0YkEnQWfakguaatbvX1bKdnuvrN4U+kgm9ch7gzyvC4CZRhf9CL+yQ4DCmXLs3+Y6Z2+ATkv5iN7EBY1Qp0z0I7Gn2zJen6RuG7OLt5YGs97JNTib9DH82khXx2kr9lJGH08vXpiuo7H9Ylys6/4w0ewbxxZ+kVnOfhYS
X-Forefront-Antispam-Report-Untrusted: 
 CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39850400004)(396003)(230922051799003)(1800799012)(82310400011)(451199024)(186009)(64100799003)(46966006)(36840700001)(40480700001)(8676002)(4326008)(8936002)(9576002)(26005)(82740400003)(70586007)(2906002)(6916009)(316002)(86362001)(5660300002)(478600001)(70206006)(36916002)(356005)(36860700001)(47076005)(81166007)(83380400001)(33716001)(16526019)(41300700001)(9686003)(336012)(66574015)(426003)(39026012)(36900700001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6797
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM1PEPF000252DB.eurprd07.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	0b6e2f35-0b71-4b58-1780-08dbe9c2e362
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ve/9LNALJJIhVMSh6vjwOan/54VVRKzxOAt4BoU0s5q9EyvAIPlKmwdRex0LBJx2pUVsZa9nxlWREOtQjfb7nbb6t36GASCIlHhVI91AVCKDerWxOrZ2iL3qb9/HnxEbWfkDsdPSIVLRDLhYtZNPtAHk9FKxWn+qBqNyZP9yq/QfYgAZVx8P5FCU5B6nDaBEE03nU5LgWWQ/QSUIO4OIWKr2E1B0HKxAtrAalQMnHEkLx5USheZ+vDYM7zca3xr+kNUbh2rzsWjxr+IV1N/ClYFD17x0nEiLQY51GSITG7MnIxSCLZq5v0mxZctGpM/htRB2H2LORHyiEloKmOtzMosQs9J82QXWu+FZUqz13UGD5ci5RUmtaAMj77wypnTzX201qNcN2g4FiiP9oEKCGB6WRtf9YWXW+sc6lhcRjk6PNBnjkstI/XI34FqQR229f3+Fk9dIIM1kXAFS2yuW2fhF70dCw6/R991yvlb0XNoNvv9wnclnzZWujE+SfBntUrGRZsrNfZe+SUqduYMsl+oMoHZdWlRvosccml9jLewVW7ej4TXqyIwC+Wn/Cgd5fuQ5bJzpIN2Yp06ELm+L4iQn84XqUgUiyO7flBaBO4BtFYyDHcvEiDjbmK3ScaSYQBfBkK2z1/qx0KBVO9+0eT02AplUDPnydW8JsairEUxSJR9K9WPaYRx8YckoxTFndxJ+w/6es7w2AiSmYn8XdvPIgdboURsfMoYrL1HuuYcLZYixkUD6jfT1u5SX3QMjPUnMznBP/lc+1dm6+qyFhbyI8El69V53oMSro7dRNf69YoqmoZuDZy6/U9alyHf8aN+n0iQDAjVghoXxYG2gKvzSkZqWHBljZaXZw/xXry2QW5uSaIf8h549dHYi1nlL
X-Forefront-Antispam-Report: 
	CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(13230031)(4636009)(376002)(39850400004)(396003)(346002)(136003)(230922051799003)(1800799012)(451199024)(7200799017)(186009)(1690799017)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(70586007)(70206006)(316002)(6916009)(33964004)(36916002)(45080400002)(478600001)(40480700001)(36860700001)(82740400003)(8400799017)(9686003)(26005)(40460700003)(2906002)(16526019)(8676002)(8936002)(4326008)(15974865002)(5660300002)(9576002)(166002)(47076005)(83380400001)(426003)(336012)(7596003)(7636003)(66574015)(41300700001)(86362001)(33716001)(39026012);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 12:19:08.7033
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c8fa97-bb79-48ed-f43f-08dbe9c2e5c5
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM1PEPF000252DB.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB9601
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Nov 2023 12:19:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15534

This is a multi-part message in MIME format.

------_=_NextPart_9019d6fb-ddff-461c-8348-22cfe73b6f01
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_7fd7098c-d382-4237-a1d7-021e4cea56d2"

------_=_NextPart_7fd7098c-d382-4237-a1d7-021e4cea56d2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hi Alex,

On Monday, 20 November 2023, 12:05:28 CET, Alexander Kanavin wrote:

_______________________________________________________
Christian 
Eggers
Software Engineer
=E2=80=8B
ARRI
Arnold & Richter Cine Technik GmbH & Co. Betriebs KG 
Arriweg 17, 
83071 
Stephanskirchen
www.arri.com 

+49 8036 3009-3118
CEggers@arri.de

=E2=80=8B
Get all the latest information from www.arri.com, Facebook, Twitter, Instag=
ram, LinkedIn and YouTube and X.

Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Sitz: M=C3=BCnchen - Registergericht: Amtsgericht M=C3=BCnchen - Handelsreg=
isternummer: HRA 57918
Pers=C3=B6nlich haftender Gesellschafter: Arnold & Richter Cine Technik Gmb=
H
Sitz: M=C3=BCnchen - Registergericht: Amtsgericht M=C3=BCnchen - Handelsreg=
isternummer: HRB 54477
Gesch=C3=A4ftsf=C3=BChrer: Dr. Matthias Erb (Chairman); Lars Weyer; Stephan=
 Schenk; Walter Trauninger

=E2=80=8B
> On Mon, 20 Nov 2023 at 11:59, Christian Eggers <ceggers@arri.de> wrote:
> 
> > When having NPM based application in my SDK (e.g. quicktype [1], recipe=
 is
> > attached), the "fetch" tasks perform a full build of nodejs before star=
ting
> > the actual download of the quicktype sources. But building nodejs (and =
its
> > dependencies) during the "fetch" stage, compromises my wish to perform =
the
> > actual build in an offline environment.
> >
> 
> I'm not sure I understand what is being compromised here. If you want an
> offline build, throw away the sstate cache that was created in the fetchi=
ng
> step, and nodejs will be again rebuilt together with everything else.

my intend is to run as few build scripts as possible as long as the build
machine has access to the internet. For security reasons I would like to di=
vide
the build into two stages, one stage for downloading (with internet access =
enabled)
and one stage for compiling (without internet access).

While I highly trust the OpenEmbedded/Yocto projects, I fear that single up=
stream
projects may become targets for supply chain attacks in the future. Running
the package Makefiles/scripts etc. on a machine (e.g. docker) without netwo=
rk
access reduces the possibility for manipulated packages to retrieve interna=
l
secrets and upload them to the internet.

Are there any other use cases why people want to perform an "offline" build=
?

regards,
Christian







------_=_NextPart_7fd7098c-d382-4237-a1d7-021e4cea56d2
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8" /></head><body><div>Hi Alex,<br /><br />On Monday, 20 November 20=
23, 12:05:28 CET, Alexander Kanavin wrote:<br /><div dir=3D"ltr" style=3D"m=
so-line-height-rule:exactly;-webkit-text-size-adjust:100%;font-size:1px;dir=
ection:ltr;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=
=3D"width:100%;font-size:1px;"><tr style=3D"font-size:0;"><td align=3D"left=
" style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" =
border=3D"0" style=3D"font-size:0;"><tr style=3D"font-size:0;"><td align=
=3D"left" style=3D"padding:0;vertical-align:top;"><table cellpadding=3D"0" =
cellspacing=3D"0" border=3D"0" style=3D"width:100%;font-size:0;"><tr style=
=3D"font-size:14.67px;color:#7F7F7F;font-style:normal;font-weight:400;white=
-space:nowrap;"><td align=3D"left" style=3D"vertical-align:top;font-family:=
Calibri,Arial,sans-serif;">________________________________________________=
_______<span style=3D"font-family:remialcxesans;font-size:1px;color:#FFFFFF=
;line-height:1px;">&#8203;</span></td></tr><tr style=3D"font-size:0;"><td a=
lign=3D"left" style=3D"vertical-align:top;"><table cellpadding=3D"0" cellsp=
acing=3D"0" border=3D"0" style=3D"font-size:0;"><tr style=3D"font-size:0;">=
<td align=3D"left" style=3D"vertical-align:top;"><table cellpadding=3D"0" c=
ellspacing=3D"0" border=3D"0" style=3D"font-size:0;color:#7F7F7F;font-style=
:normal;font-weight:400;white-space:nowrap;"><tr style=3D"font-size:14.67px=
;"><td align=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial=
,sans-serif;">Christian</td><td align=3D"left" style=3D"vertical-align:top;=
color:#000001;font-family:Calibri,Arial,sans-serif;">&nbsp;<br /></td><td a=
lign=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,sans-se=
rif;">Eggers</td></tr></table></td></tr><tr style=3D"font-size:0;"><td alig=
n=3D"left" style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspaci=
ng=3D"0" border=3D"0" style=3D"font-size:0;color:#7F7F7F;font-style:normal;=
font-weight:400;white-space:nowrap;"><tr style=3D"font-size:14.67px;"><td a=
lign=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,sans-se=
rif;">Software&nbsp;Engineer</td></tr><tr style=3D"font-size:14.67px;color:=
#000001;"><td align=3D"left" style=3D"vertical-align:top;font-family:Calibr=
i,Arial,sans-serif;">&#8203;</td></tr></table></td></tr></table></td></tr><=
tr style=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:top;">=
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:=
0;"><tr style=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:t=
op;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-=
size:0;color:#0E50AD;font-style:normal;font-weight:400;white-space:nowrap;"=
><tr style=3D"font-size:13.33px;"><td align=3D"left" style=3D"vertical-alig=
n:top;font-family:&#39;Arial Black&#39;;">ARRI</td></tr><tr style=3D"font-s=
ize:10.67px;color:#7F7F7F;"><td align=3D"left" style=3D"vertical-align:top;=
font-family:Arial;"><span style=3D"font-size:11px;">Arnold&nbsp;&amp;&nbsp;=
Richter&nbsp;Cine&nbsp;Technik&nbsp;GmbH&nbsp;&amp;&nbsp;Co.&nbsp;Betriebs&=
nbsp;KG</span>&nbsp;<br /></td></tr></table></td></tr><tr style=3D"font-siz=
e:0;"><td align=3D"left" style=3D"vertical-align:top;"><table cellpadding=
=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;color:#7F7F7F;fo=
nt-style:normal;font-weight:400;white-space:nowrap;"><tr style=3D"font-size=
:10.67px;"><td align=3D"left" style=3D"vertical-align:top;font-family:Arial=
;">Arriweg&nbsp;17</td><td align=3D"left" style=3D"vertical-align:top;font-=
family:Arial;">,&nbsp;<br /></td><td align=3D"left" style=3D"vertical-align=
:middle;font-family:Arial;">83071</td><td align=3D"left" style=3D"vertical-=
align:middle;font-family:Arial;">&nbsp;<br /></td><td align=3D"left" style=
=3D"vertical-align:middle;font-family:Arial;">Stephanskirchen</td></tr></ta=
ble></td></tr></table></td></tr><tr style=3D"font-size:0;"><td align=3D"lef=
t" style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0"=
 border=3D"0" style=3D"font-size:0;"><tr style=3D"font-size:0;"><td align=
=3D"left" style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacin=
g=3D"0" border=3D"0" style=3D"font-size:0;color:#1532B9;font-style:normal;f=
ont-weight:400;white-space:nowrap;"><tr style=3D"font-size:11px;"><td align=
=3D"left" style=3D"vertical-align:top;font-family:Arial;"><span style=3D"te=
xt-decoration:underline;"><a href=3D"http://www.arri.com/" target=3D"_blank=
" id=3D"LPlnk689713" style=3D"text-decoration:underline;color:#1532B9;">www=
=2Earri.com&nbsp;<br /><br /></a></span></td></tr><tr style=3D"font-size:0;=
"><td align=3D"left" style=3D"vertical-align:top;"><table cellpadding=3D"0"=
 cellspacing=3D"0" border=3D"0" style=3D"font-size:0;color:#858080;font-sty=
le:normal;font-weight:400;line-height:normal;white-space:nowrap;"><tr style=
=3D"font-size:14.67px;"><td align=3D"left" style=3D"padding:0;vertical-alig=
n:top;font-size:0;"><img src=3D"cid:image314283.png@1EECE2FC.F02F04B8" widt=
h=3D"20" border=3D"0" alt=3D"" style=3D"width:20px;min-width:20px;max-width=
:20px;font-size:0;" /></td><td align=3D"left" style=3D"padding:0;vertical-a=
lign:top;font-family:Calibri,Arial,sans-serif;"><a href=3D"tel:+49%208036%2=
03009-3118" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:n=
one;color:#858080;">+49&nbsp;8036&nbsp;3009-3118</a></td></tr><tr style=3D"=
font-size:0;"><td align=3D"left" style=3D"padding:0;vertical-align:top;"></=
td><td align=3D"left" style=3D"padding:0;vertical-align:top;"></td></tr><tr=
 style=3D"font-size:0;"><td align=3D"left" style=3D"padding:0;vertical-alig=
n:top;"></td><td align=3D"left" style=3D"padding:0;vertical-align:top;"></t=
d></tr><tr style=3D"font-size:14.67px;"><td align=3D"left" style=3D"padding=
:0;vertical-align:top;font-size:0;"><img src=3D"cid:image476265.png@397D941=
9.90C981F9" width=3D"20" border=3D"0" alt=3D"" style=3D"width:20px;min-widt=
h:20px;max-width:20px;font-size:0;" /></td><td align=3D"left" style=3D"padd=
ing:0;vertical-align:top;font-family:Calibri,Arial,sans-serif;"><a href=3D"=
mailto:CEggers@arri.de" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-=
decoration:none;color:#858080;">CEggers@arri.de</a></td></tr></table></td><=
/tr></table></td></tr></table></td></tr><tr style=3D"font-size:14.67px;colo=
r:#000001;font-style:normal;font-weight:400;white-space:nowrap;"><td align=
=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,sans-serif;=
"><br />&#8203;</td></tr></table></td></tr><tr style=3D"font-size:0;line-he=
ight:normal;"><td align=3D"left" style=3D"padding:0;vertical-align:top;"><a=
 href=3D"https://www.arri.com/skypanelx" target=3D"_blank" id=3D"LPlnk68971=
3" style=3D"text-decoration:none;"><img src=3D"https://assets.arri.com/medi=
a/sign/20230908a_Stardust_E-mail-Signature_800x170@2x.jpg" width=3D"660" bo=
rder=3D"0" title=3D"SkyPanel X" alt=3D"SkyPanel X" style=3D"width:660px;min=
-width:660px;max-width:660px;font-size:12px;" /></a></td></tr><tr style=3D"=
font-size:13px;color:#7F7F7F;font-style:normal;font-weight:400;white-space:=
nowrap;"><td align=3D"left" style=3D"padding:0;vertical-align:top;font-fami=
ly:Calibri,Arial,sans-serif;">Get&nbsp;all&nbsp;the&nbsp;latest&nbsp;inform=
ation&nbsp;from&nbsp;<span style=3D"text-decoration:underline;"><a href=3D"=
https://www.arri.com/" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-d=
ecoration:underline;color:#7F7F7F;">www.arri.com</a></span>,&nbsp;<span sty=
le=3D"text-decoration:underline;"><a href=3D"https://www.facebook.com/TeamA=
RRI" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:underlin=
e;color:#7F7F7F;">Facebook</a></span>,&nbsp;<span style=3D"text-decoration:=
underline;"><a href=3D"https://twitter.com/ARRIChannel" target=3D"_blank" i=
d=3D"LPlnk689713" style=3D"text-decoration:underline;color:#7F7F7F;">Twitte=
r</a></span>,&nbsp;<a href=3D"https://www.instagram.com/arri/" target=3D"_b=
lank" id=3D"LPlnk689713" style=3D"text-decoration:none;color:#7F7F7F;"><spa=
n style=3D"text-decoration:underline;">Instagram</span></a>,&nbsp;<a href=
=3D"https://www.linkedin.com/company/arri" target=3D"_blank" id=3D"LPlnk689=
713" style=3D"text-decoration:none;color:#7F7F7F;"><span style=3D"text-deco=
ration:underline;">LinkedIn</span></a>&nbsp;and&nbsp;<a href=3D"https://www=
=2Eyoutube.com/user/ARRIChannel" target=3D"_blank" id=3D"LPlnk689713" style=
=3D"text-decoration:none;color:#7F7F7F;"><span style=3D"text-decoration:und=
erline;">YouTube</span></a>&nbsp;and&nbsp;<a href=3D"https://twitter.com/AR=
RIChannel" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:no=
ne;color:#7F7F7F;"><span style=3D"text-decoration:underline;">X</span></a>.=
<br /></td></tr><tr style=3D"font-size:0;"><td align=3D"left" style=3D"padd=
ing:0;vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" borde=
r=3D"0" style=3D"font-size:0;color:#6A6A6A;font-style:normal;font-weight:40=
0;white-space:nowrap;"><tr style=3D"font-size:10px;"><td align=3D"left" sty=
le=3D"vertical-align:top;font-family:Arial;"><br />Arnold&nbsp;&amp;&nbsp;R=
ichter&nbsp;Cine&nbsp;Technik&nbsp;GmbH&nbsp;&amp;&nbsp;Co.&nbsp;Betriebs&n=
bsp;KG<br />Sitz:&nbsp;M&#252;nchen&nbsp;=E2=80=91&nbsp;Registergericht:&nb=
sp;Amtsgericht&nbsp;M&#252;nchen&nbsp;=E2=80=91&nbsp;Handelsregisternummer:=
&nbsp;HRA&nbsp;57918<br />Pers&#246;nlich&nbsp;haftender&nbsp;Gesellschafte=
r:&nbsp;Arnold&nbsp;&amp;&nbsp;Richter&nbsp;Cine&nbsp;Technik&nbsp;GmbH<br =
/>Sitz:&nbsp;M&#252;nchen&nbsp;=E2=80=91&nbsp;Registergericht:&nbsp;Amtsger=
icht&nbsp;M&#252;nchen&nbsp;=E2=80=91&nbsp;Handelsregisternummer:&nbsp;HRB&=
nbsp;54477<br />Gesch&#228;ftsf&#252;hrer:&nbsp;Dr.&nbsp;Matthias&nbsp;Erb&=
nbsp;(Chairman);&nbsp;Lars&nbsp;Weyer;&nbsp;Stephan&nbsp;Schenk;&nbsp;Walte=
r&nbsp;Trauninger<br /></td></tr><tr style=3D"font-size:14.67px;color:#0000=
01;"><td align=3D"left" style=3D"vertical-align:top;font-family:Calibri,Ari=
al,sans-serif;"><br />&#8203;<br /></td></tr></table></td></tr></table></td=
></tr></table></div>&gt; On Mon, 20 Nov 2023 at 11:59, Christian Eggers &lt=
;ceggers@arri.de&gt; wrote:<br />&gt; <br />&gt; &gt; When having NPM based=
 application in my SDK (e.g. quicktype [1], recipe is<br />&gt; &gt; attach=
ed), the &quot;fetch&quot; tasks perform a full build of nodejs before star=
ting<br />&gt; &gt; the actual download of the quicktype sources. But build=
ing nodejs (and its<br />&gt; &gt; dependencies) during the &quot;fetch&quo=
t; stage, compromises my wish to perform the<br />&gt; &gt; actual build in=
 an offline environment.<br />&gt; &gt;<br />&gt; <br />&gt; I&#39;m not su=
re I understand what is being compromised here. If you want an<br />&gt; of=
fline build, throw away the sstate cache that was created in the fetching<b=
r />&gt; step, and nodejs will be again rebuilt together with everything el=
se.<br /><br />my intend is to run as few build scripts as possible as long=
 as the build<br />machine has access to the internet. For security reasons=
 I would like to divide<br />the build into two stages, one stage for downl=
oading (with internet access enabled)<br />and one stage for compiling (wit=
hout internet access).<br /><br />While I highly trust the OpenEmbedded/Yoc=
to projects, I fear that single upstream<br />projects may become targets f=
or supply chain attacks in the future. Running<br />the package Makefiles/s=
cripts etc. on a machine (e.g. docker) without network<br />access reduces =
the possibility for manipulated packages to retrieve internal<br />secrets =
and upload them to the internet.<br /><br />Are there any other use cases w=
hy people want to perform an &quot;offline&quot; build?<br /><br />regards,=
<br />Christian<br /><br /><br /><br /><br /><br /><br /></div></body></htm=
l>
------_=_NextPart_7fd7098c-d382-4237-a1d7-021e4cea56d2--

------_=_NextPart_9019d6fb-ddff-461c-8348-22cfe73b6f01
Content-Type: image/png;
	name="image314283.png"
Content-Transfer-Encoding: base64
Content-ID: <image314283.png@1EECE2FC.F02F04B8>
Content-Description: image314283.png
Content-Disposition: inline;
	creation-date="Mon, 20 Nov 2023 12:19:08 +0000";
	filename=image314283.png;
	modification-date="Mon, 20 Nov 2023 12:19:08 +0000";
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

------_=_NextPart_9019d6fb-ddff-461c-8348-22cfe73b6f01
Content-Type: image/png;
	name="image476265.png"
Content-Transfer-Encoding: base64
Content-ID: <image476265.png@397D9419.90C981F9>
Content-Description: image476265.png
Content-Disposition: inline;
	creation-date="Mon, 20 Nov 2023 12:19:08 +0000";
	filename=image476265.png;
	modification-date="Mon, 20 Nov 2023 12:19:08 +0000";
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

------_=_NextPart_9019d6fb-ddff-461c-8348-22cfe73b6f01--

