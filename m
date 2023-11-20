Return-Path: <ceggers@arri.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA33CC54E76
	for <webhook@archiver.kernel.org>; Mon, 20 Nov 2023 13:25:29 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.108])
 by mx.groups.io with SMTP id smtpd.web11.50078.1700486720786642997
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Nov 2023 05:25:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arrigroup.onmicrosoft.com header.s=selector1-arrigroup-onmicrosoft-com header.b=fenAwIhz;
 spf=pass (domain: arri.de, ip: 40.107.20.108, mailfrom: ceggers@arri.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sm72sCEWXGHFl8JHCapKr0zKn5QVl085nSf0Xe98zQu3bCWXst/oxTuT8iMhtYJi7nZTIkGYq+V4xwqT6LYjGeVanyIc3bPDjD+UfZl3AWLJYeNx3Vn822rbQqi7mrw/GEhq38db/4ANX9kRxS40Yuejk56zRNHlOb1j5BWs1uFQeaA7UJpQbEiBRIc1uaBzTop1O3BW2ICLEA5hZso/+buXkLEos8cxMMIJ1IoWvJdpA+jWErNztrASbYxdhPFWtHA12Tn5jRmxYh65TvTEIqtGA0px17voayEJwXDhbTGRdncFKF/FJmuVIGBk1zDvIbjPE3lvGFLhtQJjMUJk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQlYonyGOJbyaKFr0hQBI2QcPHOD4P6fIiPWhgXpch4=;
 b=jqLr9oUaZCFXok8+jNkQo6f027pPOYnYiPRHuCUJIF41fx2Ehx4TULlTosHGniCi6NBb60idaVf5eyHl3VmblZSXZR+K2iuwJ0jyiH0QLVgf3Zb8/pzQmN6699RdU1UhSJZMjq09d8jJFLBXR0iGj26/YmPZ3psJQGPwUyLoBp3I64rTM6HS+G14wToc0qTUMfrz63bwhQmmhLmuAvZC5/PyKh8Pd+L7CUohTKUQfpsLlghIz6LIKl9DHgKUGhTX/O3awyuvshevArIE3qrmsBAQFmD7AvrMRiY90Qoy1zLpFhA7oS+WkOMK2Fr+/Ewgpws9JNHolC+APHYr0/gbgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 52.169.0.179) smtp.rcpttodomain=ew.tq-group.com smtp.mailfrom=arri.de;
 dmarc=bestguesspass action=none header.from=arri.de; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQlYonyGOJbyaKFr0hQBI2QcPHOD4P6fIiPWhgXpch4=;
 b=fenAwIhzvuBcOrKItfqWtoNuXNxfRfh0Pi9bViWQoVZU0mxAfEI1484OKYQaxSffAVgje/kiTyTxx+4d+vDYTaDJzP/qmegz33Y2E5VZFLhc6A5AltLTCrHhyRbF2Po132dtfEIA2QV5zvO83xHDC5lui3cVopOu43OTf95OZyY=
Received: from AM6P192CA0087.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::28)
 by PAWPR07MB9300.eurprd07.prod.outlook.com (2603:10a6:102:2f2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 13:25:17 +0000
Received: from AMS0EPF0000019C.eurprd05.prod.outlook.com
 (2603:10a6:209:8d:cafe::ce) by AM6P192CA0087.outlook.office365.com
 (2603:10a6:209:8d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26 via Frontend
 Transport; Mon, 20 Nov 2023 13:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.169.0.179)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=arri.de;
Received-SPF: Pass (protection.outlook.com: domain of arri.de designates
 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net; pr=C
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 AMS0EPF0000019C.mail.protection.outlook.com (10.167.16.248) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 13:25:15 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.50)
	 by eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
	 ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
	 tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Mon, 20 Nov 2023 13:25:16 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 30418870
X-ExclaimerImprintLatency: 3287481
X-ExclaimerImprintAction: ccc348b10a844e67b2cc96ae7dd78a03
Content-Type: multipart/related;
	boundary="----_=_NextPart_c0df72a8-71ea-4114-97a0-475f2ad34f12"
Received: from AM4PR07CA0011.eurprd07.prod.outlook.com (2603:10a6:205:1::24)
 by PAWPR07MB9204.eurprd07.prod.outlook.com (2603:10a6:102:2e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 13:25:08 +0000
Received: from AM3PEPF0000A796.eurprd04.prod.outlook.com
 (2603:10a6:205:1:cafe::f4) by AM4PR07CA0011.outlook.office365.com
 (2603:10a6:205:1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16 via Frontend
 Transport; Mon, 20 Nov 2023 13:25:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM3PEPF0000A796.mail.protection.outlook.com (10.167.16.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.13 via Frontend Transport; Mon, 20 Nov 2023 13:25:07 +0000
Received: from n95hx1g2.localnet (10.30.5.31) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Nov
 2023 14:25:06 +0100
From: Christian Eggers <ceggers@arri.de>
To: Markus Niebel <Markus.Niebel@ew.tq-group.com>, Martin Jansa
	<martin.jansa@gmail.com>
CC: Alexander Kanavin <alex.kanavin@gmail.com>,
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] npm/npmsw fetchers: Support for "offline" builds?
Date: Mon, 20 Nov 2023 14:25:06 +0100
Message-ID: <2178448.Icojqenx9y@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CA+chaQeFGqnDbKav6JbXOO4ouqEVDvUNofuhM5A_+t7dv9n81A@mail.gmail.com>
References: <4851356.GXAFRqVoOG@n95hx1g2> <70e7245a5f6b37f9045027f90c665c244a28a234.camel@ew.tq-group.com> <CA+chaQeFGqnDbKav6JbXOO4ouqEVDvUNofuhM5A_+t7dv9n81A@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [10.30.5.31]
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: 
	AM3PEPF0000A796:EE_|PAWPR07MB9204:EE_|AMS0EPF0000019C:EE_|PAWPR07MB9300:EE_
X-MS-Office365-Filtering-Correlation-Id: 3880d754-61e3-41de-ab7c-08dbe9cc22b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 icpB7eMDOOLJ/Smuw3ovdORQ7aQBDl7BywIiqMqtWLKbsQvL4yepFMEZFCf/RYO9cX4BnDeot5f6+wbNazt/ll/TIk0V/1DOCKqv4bwAvwEM5V7GV4Jgy8QRThrH3/AJURPr/MDoNXp3lwd+nT1FL2jXYZnJpHr10ehaj7eyw6vY3wI0glRtW/XuiS9eTA92arIPnWywhEKIc/Q0OSjbg95Ta8FR5fcghPgtGuNpJr33c9SlbQwHFyXZ7oAs2QqV5HNQKfHQ/FaXC8/QAKA9sRIj89L76sTQp+wZPMiGBiiQtoWa0eDlBbuKiv4LUSrIGrZdg/QqLgVdkLoIyowAiilCf+vZraCOMBmxXfFk6+DnoUHLfxxOST7RtRiMQV6MO61KjNBKeAsn4muFqNKHKQG7d45I2UcH6OLquPCtpmF7dBNFdK4084legbZDVemv3D6S5MWwYE3/pkCZ0N5MyI6IA+Qi+ivgocEwl0BDFEF2BvIALuwLollAK7QtkbZN6DMYEYQL2g4Elm94Pgaocw5R5+DzALBsoXSY9yRPqD/eVkJBIKzQinhset3T9gb/Q3fdLdIoSYXTYQY+jOxBEGg4WGB7nabs1MK7m8wdjwztnvGSOrhhTsB82/KoayQa33LXbDHy4teJ5toipPP+W2DQs2zYopWFBRHa1ywLaDB3V5AU3XWsSwhyDoguVCURUf9FiGVxP7Jkx/rYH5D8O1yhrXndWGowoUq8DUPt7UoERSZEXKxyoUsaR9kAradFddcPWmsSnNzLuM6NCaCgMFvhNkXwhzzplrblzY0Z7LlMvmnNLhhNgT1SoLi96r+F
X-Forefront-Antispam-Report-Untrusted: 
 CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39850400004)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(46966006)(36840700001)(110136005)(426003)(336012)(66574015)(70206006)(70586007)(316002)(54906003)(16526019)(26005)(8676002)(4326008)(8936002)(41300700001)(81166007)(356005)(36860700001)(47076005)(33716001)(86362001)(2906002)(82740400003)(5660300002)(9576002)(83380400001)(53546011)(36916002)(40480700001)(966005)(478600001)(9686003)(39026012)(36900700001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9204
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	0319e1eb-2ea4-4dee-1022-08dbe9cc1cfd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	u2Qqhx9jbkyx1DSLxyKBrIV2RC/163qkWB5exd8K8mp2+GwsDUMcMjJEcAy3OodSleqCRnuAKb7dgiakzilw0dshWd+qkxnY7s3ixJHFghDlyFR3rCNo836epntMCMToc2VJy8ob0+bQxDaFNxfJQaGyjo4yQD9alPRY+4dPRs4pkegXsBIaxE547WUJeWEobUPKhoXaHFOo9Kr276BKXwrCkpD9sbkWTBhWPHSfvGgvNNKdKmOiAuYUB5qrlj8RKpLu2KChjQiFdq9SNoC4jkC58nkMNuAf/ulplYiM0CbK4GwEBzpuAGgNTdhQpJHrzBZ6Y6uurPutXlNi4CfGW3dI8ffRsfDFQX4Vp8WckgUdRaVk0SbS3pcBB1x4fNj5jzurXXEaFCEaPQ3S3/wMjca8wghJuWmCuMuIpTqJWtbHHVCv5fSkqf0EWurikglqpyYXNiyD9mmDF0qYZ5MmWlglZgvYfqcSETDYVn+pB4JIImuNCYwWdVEhlxBT7JbH2mvsmaOFS4EyqqQ8zWJ93dl0rzsK2R2JZMkGsfYRTo8FLwaVvHIFc9vIZ9gDfp/rr8W3eFA9xERNM4q/yN7AjcDjxSb0DCYD1/trWNCyFADrd5n/UtsrVO1wE5gwdDa3zbN/HC3mzUsT1dnOAZVO+y7W9ZFUHM/gTz7pHqEQhXjMX0F9SlpBSN7Ra+AVKE278TFhRkOJy1PdRNJxC+xZ3sYH1qAC8LDTTkQCS3oNqLWne+hf670w47QF9ZCMEISiyH6TcAlYciJ4A0wjB5ymbroJbpJ+fl6gfKwfEjuq3s6mgul/ooCS0TdEITZm4/4S1A/wbqn+XxcCxPOEPHInoDi6yG+iLfhBqS0rWpOBz4Htf1jc1Sfh/PAmVt9Rm6Mb
X-Forefront-Antispam-Report: 
	CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(396003)(346002)(39850400004)(230922051799003)(1800799012)(82310400011)(451199024)(7200799017)(186009)(1690799017)(64100799003)(40470700004)(46966006)(36840700001)(40480700001)(8676002)(4326008)(8936002)(9576002)(45080400002)(26005)(82740400003)(8400799017)(70586007)(2906002)(54906003)(15974865002)(110136005)(316002)(86362001)(5660300002)(478600001)(70206006)(966005)(36916002)(33964004)(53546011)(7596003)(7636003)(36860700001)(166002)(40460700003)(47076005)(83380400001)(33716001)(16526019)(426003)(41300700001)(9686003)(66574015)(336012)(39026012);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 13:25:15.6723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3880d754-61e3-41de-ab7c-08dbe9cc22b0
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: 
	AMS0EPF0000019C.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9300
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Nov 2023 13:25:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15538

This is a multi-part message in MIME format.

------_=_NextPart_c0df72a8-71ea-4114-97a0-475f2ad34f12
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_b7492bad-f996-4d58-8f4c-cd69119fea37"

------_=_NextPart_b7492bad-f996-4d58-8f4c-cd69119fea37
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Monday, 20 November 2023, 14:14:32 CET, Martin Jansa wrote:
> On Mon, Nov 20, 2023 at 2:01=E2=80=AFPM Markus Niebel <Markus.Niebel@ew.t=
q-group.com>
> wrote:
> 
> > Am Montag, dem 20.11.2023 um 13:19 +0100 schrieb Christian Eggers:
> > >
> > > Hi Alex,
> > >
> > > On Monday, 20 November 2023, 12:05:28 CET, Alexander Kanavin wrote:
> > >
> > > > On Mon, 20 Nov 2023 at 11:59, Christian Eggers <ceggers@arri.de>
> > > wrote:
> > > >
> > > > > When having NPM based application in my SDK (e.g. quicktype [1],
> > > recipe is
> > > > > attached), the "fetch" tasks perform a full build of nodejs
> > > before starting
> > > > > the actual download of the quicktype sources. But building nodejs
> > > (and its
> > > > > dependencies) during the "fetch" stage, compromises my wish to
> > > perform the
> > > > > actual build in an offline environment.
> > > > >
> > > >
> > > > I'm not sure I understand what is being compromised here. If you
> > > want an
> > > > offline build, throw away the sstate cache that was created in the
> > > fetching
> > > > step, and nodejs will be again rebuilt together with everything
> > > else.
> > >
> > > my intend is to run as few build scripts as possible as long as the
> > > build
> > > machine has access to the internet. For security reasons I would like
> > > to divide
> > > the build into two stages, one stage for downloading (with internet
> > > access enabled)
> > > and one stage for compiling (without internet access).
> > >
> > > While I highly trust the OpenEmbedded/Yocto projects, I fear that
> > > single upstream
> > > projects may become targets for supply chain attacks in the future.
> > > Running
> > > the package Makefiles/scripts etc. on a machine (e.g. docker) without
> > > network
> > > access reduces the possibility for manipulated packages to retrieve
> > > internal
> > > secrets and upload them to the internet.
> > >
> > > Are there any other use cases why people want to perform an "offline"
> > > build?
> > >
> >
> > At least offline builds are useful for release builds to make sure no
> > recipe tries to bypass the normal fetch logic. We saw this several
> > times in the past with silicon vendor stuff - recipes tried to fetch
> > things during configuration or as part of compilation.
> >
> > Another thing I can imagine are builds against an internal PREMIRROR
> > for several reasons.
> >
> 
> Yes, but bitbake and oe do that automatically (even in "online" build) no=
w
> with following changes:
> 
>      bitbake can now restrict network access in various tasks based on
> "network" flag as implemented in:
> 
> https://git.openembedded.org/bitbake/commit/?id=3D0746b6a2a32fec4c18bf1a5=
2b1454ca4c04bf543
> 
> https://git.openembedded.org/bitbake/commit/?id=3D9d6341df611a1725090444f=
6f8eb0244aed08213
>     and oe now enables network mostly only in do_fetch and few special
> tasks as implemented in:
> 
> https://git.openembedded.org/openembedded-core/commit/?id=3D7ce1e88a3ad85=
bbb925bb9f7167dc0a5fd1c27f4
> 
> so unless your evil vendor doesn't enable network flag on (m)any tasks,
> they shouldn't be able to bypass the normal fetch logic.

If I had known all this before, this would have saved me some time for the
complex setup of my (docker) build pipeline ...

With my concrete intend to improve security on my build machine, being able
to ensure/enforce this behavior would be great (bb.utils.disable_network on=
ly
produces a debug message if unshare() returned an error).





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

------_=_NextPart_b7492bad-f996-4d58-8f4c-cd69119fea37
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8" /></head><body><div>On Monday, 20 November 2023, 14:14:32 CET, Ma=
rtin Jansa wrote:<br />&gt; On Mon, Nov 20, 2023 at 2:01=E2=80=AFPM Markus =
Niebel &lt;Markus.Niebel@ew.tq-group.com&gt;<br />&gt; wrote:<br />&gt; <br=
 />&gt; &gt; Am Montag, dem 20.11.2023 um 13:19 +0100 schrieb Christian Egg=
ers:<br />&gt; &gt; &gt;<br />&gt; &gt; &gt; Hi Alex,<br />&gt; &gt; &gt;<b=
r />&gt; &gt; &gt; On Monday, 20 November 2023, 12:05:28 CET, Alexander Kan=
avin wrote:<br />&gt; &gt; &gt;<br />&gt; &gt; &gt; &gt; <div dir=3D"ltr" s=
tyle=3D"mso-line-height-rule:exactly;-webkit-text-size-adjust:100%;font-siz=
e:1px;direction:ltr;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"=
0" style=3D"width:100%;font-size:1px;"><tr style=3D"font-size:0;"><td align=
=3D"left" style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacin=
g=3D"0" border=3D"0" style=3D"font-size:0;"><tr style=3D"font-size:0;"><td =
align=3D"left" style=3D"padding:0;vertical-align:top;"><table cellpadding=
=3D"0" cellspacing=3D"0" border=3D"0" style=3D"width:100%;font-size:0;"><tr=
 style=3D"font-size:14.67px;color:#7F7F7F;font-style:normal;font-weight:400=
;white-space:nowrap;"><td align=3D"left" style=3D"vertical-align:top;font-f=
amily:Calibri,Arial,sans-serif;">__________________________________________=
_____________<span style=3D"font-family:remialcxesans;font-size:1px;color:#=
FFFFFF;line-height:1px;">&#8203;</span></td></tr><tr style=3D"font-size:0;"=
><td align=3D"left" style=3D"vertical-align:top;"><table cellpadding=3D"0" =
cellspacing=3D"0" border=3D"0" style=3D"font-size:0;"><tr style=3D"font-siz=
e:0;"><td align=3D"left" style=3D"vertical-align:top;"><table cellpadding=
=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;color:#7F7F7F;fo=
nt-style:normal;font-weight:400;white-space:nowrap;"><tr style=3D"font-size=
:14.67px;"><td align=3D"left" style=3D"vertical-align:top;font-family:Calib=
ri,Arial,sans-serif;">Christian</td><td align=3D"left" style=3D"vertical-al=
ign:top;color:#000001;font-family:Calibri,Arial,sans-serif;">&nbsp;<br /></=
td><td align=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial=
,sans-serif;">Eggers</td></tr></table></td></tr><tr style=3D"font-size:0;">=
<td align=3D"left" style=3D"vertical-align:top;"><table cellpadding=3D"0" c=
ellspacing=3D"0" border=3D"0" style=3D"font-size:0;color:#7F7F7F;font-style=
:normal;font-weight:400;white-space:nowrap;"><tr style=3D"font-size:14.67px=
;"><td align=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial=
,sans-serif;">Software&nbsp;Engineer</td></tr><tr style=3D"font-size:14.67p=
x;color:#000001;"><td align=3D"left" style=3D"vertical-align:top;font-famil=
y:Calibri,Arial,sans-serif;">&#8203;</td></tr></table></td></tr></table></t=
d></tr><tr style=3D"font-size:0;"><td align=3D"left" style=3D"vertical-alig=
n:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"fo=
nt-size:0;"><tr style=3D"font-size:0;"><td align=3D"left" style=3D"vertical=
-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=
=3D"font-size:0;color:#0E50AD;font-style:normal;font-weight:400;white-space=
:nowrap;"><tr style=3D"font-size:13.33px;"><td align=3D"left" style=3D"vert=
ical-align:top;font-family:&#39;Arial Black&#39;;">ARRI</td></tr><tr style=
=3D"font-size:10.67px;color:#7F7F7F;"><td align=3D"left" style=3D"vertical-=
align:top;font-family:Arial;"><span style=3D"font-size:11px;">Arnold&nbsp;&=
amp;&nbsp;Richter&nbsp;Cine&nbsp;Technik&nbsp;GmbH&nbsp;&amp;&nbsp;Co.&nbsp=
;Betriebs&nbsp;KG</span>&nbsp;<br /></td></tr></table></td></tr><tr style=
=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><table c=
ellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;color:=
#7F7F7F;font-style:normal;font-weight:400;white-space:nowrap;"><tr style=
=3D"font-size:10.67px;"><td align=3D"left" style=3D"vertical-align:top;font=
-family:Arial;">Arriweg&nbsp;17</td><td align=3D"left" style=3D"vertical-al=
ign:top;font-family:Arial;">,&nbsp;<br /></td><td align=3D"left" style=3D"v=
ertical-align:middle;font-family:Arial;">83071</td><td align=3D"left" style=
=3D"vertical-align:middle;font-family:Arial;">&nbsp;<br /></td><td align=
=3D"left" style=3D"vertical-align:middle;font-family:Arial;">Stephanskirche=
n</td></tr></table></td></tr></table></td></tr><tr style=3D"font-size:0;"><=
td align=3D"left" style=3D"vertical-align:top;"><table cellpadding=3D"0" ce=
llspacing=3D"0" border=3D"0" style=3D"font-size:0;"><tr style=3D"font-size:=
0;"><td align=3D"left" style=3D"vertical-align:top;"><table cellpadding=3D"=
0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;color:#1532B9;font-s=
tyle:normal;font-weight:400;white-space:nowrap;"><tr style=3D"font-size:11p=
x;"><td align=3D"left" style=3D"vertical-align:top;font-family:Arial;"><spa=
n style=3D"text-decoration:underline;"><a href=3D"http://www.arri.com/" tar=
get=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:underline;color:=
#1532B9;">www.arri.com&nbsp;<br /><br /></a></span></td></tr><tr style=3D"f=
ont-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><table cellpa=
dding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;color:#8580=
80;font-style:normal;font-weight:400;line-height:normal;white-space:nowrap;=
"><tr style=3D"font-size:14.67px;"><td align=3D"left" style=3D"padding:0;ve=
rtical-align:top;font-size:0;"><img src=3D"cid:image482188.png@5B8F2484.C61=
CCDDC" width=3D"20" border=3D"0" alt=3D"" style=3D"width:20px;min-width:20p=
x;max-width:20px;font-size:0;" /></td><td align=3D"left" style=3D"padding:0=
;vertical-align:top;font-family:Calibri,Arial,sans-serif;"><a href=3D"tel:+=
49%208036%203009-3118" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-d=
ecoration:none;color:#858080;">+49&nbsp;8036&nbsp;3009-3118</a></td></tr><t=
r style=3D"font-size:0;"><td align=3D"left" style=3D"padding:0;vertical-ali=
gn:top;"></td><td align=3D"left" style=3D"padding:0;vertical-align:top;"></=
td></tr><tr style=3D"font-size:0;"><td align=3D"left" style=3D"padding:0;ve=
rtical-align:top;"></td><td align=3D"left" style=3D"padding:0;vertical-alig=
n:top;"></td></tr><tr style=3D"font-size:14.67px;"><td align=3D"left" style=
=3D"padding:0;vertical-align:top;font-size:0;"><img src=3D"cid:image340352.=
png@2596E0DB.EB038035" width=3D"20" border=3D"0" alt=3D"" style=3D"width:20=
px;min-width:20px;max-width:20px;font-size:0;" /></td><td align=3D"left" st=
yle=3D"padding:0;vertical-align:top;font-family:Calibri,Arial,sans-serif;">=
<a href=3D"mailto:CEggers@arri.de" target=3D"_blank" id=3D"LPlnk689713" sty=
le=3D"text-decoration:none;color:#858080;">CEggers@arri.de</a></td></tr></t=
able></td></tr></table></td></tr></table></td></tr><tr style=3D"font-size:1=
4.67px;color:#000001;font-style:normal;font-weight:400;white-space:nowrap;"=
><td align=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,s=
ans-serif;"><br />&#8203;</td></tr></table></td></tr><tr style=3D"font-size=
:0;line-height:normal;"><td align=3D"left" style=3D"padding:0;vertical-alig=
n:top;"><a href=3D"https://www.arri.com/skypanelx" target=3D"_blank" id=3D"=
LPlnk689713" style=3D"text-decoration:none;"><img src=3D"https://assets.arr=
i.com/media/sign/20230908a_Stardust_E-mail-Signature_800x170@2x.jpg" width=
=3D"660" border=3D"0" title=3D"SkyPanel X" alt=3D"SkyPanel X" style=3D"widt=
h:660px;min-width:660px;max-width:660px;font-size:12px;" /></a></td></tr><t=
r style=3D"font-size:13px;color:#7F7F7F;font-style:normal;font-weight:400;w=
hite-space:nowrap;"><td align=3D"left" style=3D"padding:0;vertical-align:to=
p;font-family:Calibri,Arial,sans-serif;">Get&nbsp;all&nbsp;the&nbsp;latest&=
nbsp;information&nbsp;from&nbsp;<span style=3D"text-decoration:underline;">=
<a href=3D"https://www.arri.com/" target=3D"_blank" id=3D"LPlnk689713" styl=
e=3D"text-decoration:underline;color:#7F7F7F;">www.arri.com</a></span>,&nbs=
p;<span style=3D"text-decoration:underline;"><a href=3D"https://www.faceboo=
k.com/TeamARRI" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-decorati=
on:underline;color:#7F7F7F;">Facebook</a></span>,&nbsp;<span style=3D"text-=
decoration:underline;"><a href=3D"https://twitter.com/ARRIChannel" target=
=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:underline;color:#7F=
7F7F;">Twitter</a></span>,&nbsp;<a href=3D"https://www.instagram.com/arri/"=
 target=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:none;color:#=
7F7F7F;"><span style=3D"text-decoration:underline;">Instagram</span></a>,&n=
bsp;<a href=3D"https://www.linkedin.com/company/arri" target=3D"_blank" id=
=3D"LPlnk689713" style=3D"text-decoration:none;color:#7F7F7F;"><span style=
=3D"text-decoration:underline;">LinkedIn</span></a>&nbsp;and&nbsp;<a href=
=3D"https://www.youtube.com/user/ARRIChannel" target=3D"_blank" id=3D"LPlnk=
689713" style=3D"text-decoration:none;color:#7F7F7F;"><span style=3D"text-d=
ecoration:underline;">YouTube</span></a>&nbsp;and&nbsp;<a href=3D"https://t=
witter.com/ARRIChannel" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-=
decoration:none;color:#7F7F7F;"><span style=3D"text-decoration:underline;">=
X</span></a>.<br /></td></tr><tr style=3D"font-size:0;"><td align=3D"left" =
style=3D"padding:0;vertical-align:top;"><table cellpadding=3D"0" cellspacin=
g=3D"0" border=3D"0" style=3D"font-size:0;color:#6A6A6A;font-style:normal;f=
ont-weight:400;white-space:nowrap;"><tr style=3D"font-size:10px;"><td align=
=3D"left" style=3D"vertical-align:top;font-family:Arial;"><br />Arnold&nbsp=
;&amp;&nbsp;Richter&nbsp;Cine&nbsp;Technik&nbsp;GmbH&nbsp;&amp;&nbsp;Co.&nb=
sp;Betriebs&nbsp;KG<br />Sitz:&nbsp;M&#252;nchen&nbsp;=E2=80=91&nbsp;Regist=
ergericht:&nbsp;Amtsgericht&nbsp;M&#252;nchen&nbsp;=E2=80=91&nbsp;Handelsre=
gisternummer:&nbsp;HRA&nbsp;57918<br />Pers&#246;nlich&nbsp;haftender&nbsp;=
Gesellschafter:&nbsp;Arnold&nbsp;&amp;&nbsp;Richter&nbsp;Cine&nbsp;Technik&=
nbsp;GmbH<br />Sitz:&nbsp;M&#252;nchen&nbsp;=E2=80=91&nbsp;Registergericht:=
&nbsp;Amtsgericht&nbsp;M&#252;nchen&nbsp;=E2=80=91&nbsp;Handelsregisternumm=
er:&nbsp;HRB&nbsp;54477<br />Gesch&#228;ftsf&#252;hrer:&nbsp;Dr.&nbsp;Matth=
ias&nbsp;Erb&nbsp;(Chairman);&nbsp;Lars&nbsp;Weyer;&nbsp;Stephan&nbsp;Schen=
k;&nbsp;Walter&nbsp;Trauninger<br /></td></tr><tr style=3D"font-size:14.67p=
x;color:#000001;"><td align=3D"left" style=3D"vertical-align:top;font-famil=
y:Calibri,Arial,sans-serif;"><br />&#8203;<br /></td></tr></table></td></tr=
></table></td></tr></table></div>On Mon, 20 Nov 2023 at 11:59, Christian Eg=
gers &lt;ceggers@arri.de&gt;<br />&gt; &gt; &gt; wrote:<br />&gt; &gt; &gt;=
 &gt;<br />&gt; &gt; &gt; &gt; &gt; When having NPM based application in my=
 SDK (e.g. quicktype [1],<br />&gt; &gt; &gt; recipe is<br />&gt; &gt; &gt;=
 &gt; &gt; attached), the &quot;fetch&quot; tasks perform a full build of n=
odejs<br />&gt; &gt; &gt; before starting<br />&gt; &gt; &gt; &gt; &gt; the=
 actual download of the quicktype sources. But building nodejs<br />&gt; &g=
t; &gt; (and its<br />&gt; &gt; &gt; &gt; &gt; dependencies) during the &qu=
ot;fetch&quot; stage, compromises my wish to<br />&gt; &gt; &gt; perform th=
e<br />&gt; &gt; &gt; &gt; &gt; actual build in an offline environment.<br =
/>&gt; &gt; &gt; &gt; &gt;<br />&gt; &gt; &gt; &gt;<br />&gt; &gt; &gt; &gt=
; I&#39;m not sure I understand what is being compromised here. If you<br /=
>&gt; &gt; &gt; want an<br />&gt; &gt; &gt; &gt; offline build, throw away =
the sstate cache that was created in the<br />&gt; &gt; &gt; fetching<br />=
&gt; &gt; &gt; &gt; step, and nodejs will be again rebuilt together with ev=
erything<br />&gt; &gt; &gt; else.<br />&gt; &gt; &gt;<br />&gt; &gt; &gt; =
my intend is to run as few build scripts as possible as long as the<br />&g=
t; &gt; &gt; build<br />&gt; &gt; &gt; machine has access to the internet. =
For security reasons I would like<br />&gt; &gt; &gt; to divide<br />&gt; &=
gt; &gt; the build into two stages, one stage for downloading (with interne=
t<br />&gt; &gt; &gt; access enabled)<br />&gt; &gt; &gt; and one stage for=
 compiling (without internet access).<br />&gt; &gt; &gt;<br />&gt; &gt; &g=
t; While I highly trust the OpenEmbedded/Yocto projects, I fear that<br />&=
gt; &gt; &gt; single upstream<br />&gt; &gt; &gt; projects may become targe=
ts for supply chain attacks in the future.<br />&gt; &gt; &gt; Running<br /=
>&gt; &gt; &gt; the package Makefiles/scripts etc. on a machine (e.g. docke=
r) without<br />&gt; &gt; &gt; network<br />&gt; &gt; &gt; access reduces t=
he possibility for manipulated packages to retrieve<br />&gt; &gt; &gt; int=
ernal<br />&gt; &gt; &gt; secrets and upload them to the internet.<br />&gt=
; &gt; &gt;<br />&gt; &gt; &gt; Are there any other use cases why people wa=
nt to perform an &quot;offline&quot;<br />&gt; &gt; &gt; build?<br />&gt; &=
gt; &gt;<br />&gt; &gt;<br />&gt; &gt; At least offline builds are useful f=
or release builds to make sure no<br />&gt; &gt; recipe tries to bypass the=
 normal fetch logic. We saw this several<br />&gt; &gt; times in the past w=
ith silicon vendor stuff - recipes tried to fetch<br />&gt; &gt; things dur=
ing configuration or as part of compilation.<br />&gt; &gt;<br />&gt; &gt; =
Another thing I can imagine are builds against an internal PREMIRROR<br />&=
gt; &gt; for several reasons.<br />&gt; &gt;<br />&gt; <br />&gt; Yes, but =
bitbake and oe do that automatically (even in &quot;online&quot; build) now=
<br />&gt; with following changes:<br />&gt; <br />&gt;      bitbake can no=
w restrict network access in various tasks based on<br />&gt; &quot;network=
&quot; flag as implemented in:<br />&gt; <br />&gt; https://git.openembedde=
d.org/bitbake/commit/?id=3D0746b6a2a32fec4c18bf1a52b1454ca4c04bf543<br />&g=
t; <br />&gt; https://git.openembedded.org/bitbake/commit/?id=3D9d6341df611=
a1725090444f6f8eb0244aed08213<br />&gt;     and oe now enables network most=
ly only in do_fetch and few special<br />&gt; tasks as implemented in:<br /=
>&gt; <br />&gt; https://git.openembedded.org/openembedded-core/commit/?id=
=3D7ce1e88a3ad85bbb925bb9f7167dc0a5fd1c27f4<br />&gt; <br />&gt; so unless =
your evil vendor doesn&#39;t enable network flag on (m)any tasks,<br />&gt;=
 they shouldn&#39;t be able to bypass the normal fetch logic.<br /><br />If=
 I had known all this before, this would have saved me some time for the<br=
 />complex setup of my (docker) build pipeline ...<br /><br />With my concr=
ete intend to improve security on my build machine, being able<br />to ensu=
re/enforce this behavior would be great (bb.utils.disable_network only<br /=
>produces a debug message if unshare() returned an error).<br /><br /><br /=
><br /><br /></div></body></html>
------_=_NextPart_b7492bad-f996-4d58-8f4c-cd69119fea37--

------_=_NextPart_c0df72a8-71ea-4114-97a0-475f2ad34f12
Content-Type: image/png;
	name="image482188.png"
Content-Transfer-Encoding: base64
Content-ID: <image482188.png@5B8F2484.C61CCDDC>
Content-Description: image482188.png
Content-Disposition: inline;
	creation-date="Mon, 20 Nov 2023 13:25:16 +0000";
	filename=image482188.png;
	modification-date="Mon, 20 Nov 2023 13:25:16 +0000";
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

------_=_NextPart_c0df72a8-71ea-4114-97a0-475f2ad34f12
Content-Type: image/png;
	name="image340352.png"
Content-Transfer-Encoding: base64
Content-ID: <image340352.png@2596E0DB.EB038035>
Content-Description: image340352.png
Content-Disposition: inline;
	creation-date="Mon, 20 Nov 2023 13:25:16 +0000";
	filename=image340352.png;
	modification-date="Mon, 20 Nov 2023 13:25:16 +0000";
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

------_=_NextPart_c0df72a8-71ea-4114-97a0-475f2ad34f12--

