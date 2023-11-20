Return-Path: <ceggers@arri.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C66C197A0
	for <webhook@archiver.kernel.org>; Mon, 20 Nov 2023 13:41:09 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.103])
 by mx.groups.io with SMTP id smtpd.web11.50435.1700487664833777841
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Nov 2023 05:41:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arrigroup.onmicrosoft.com header.s=selector1-arrigroup-onmicrosoft-com header.b=Av3jsxAX;
 spf=pass (domain: arri.de, ip: 40.107.249.103, mailfrom: ceggers@arri.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jet30iLQv/tJ9TYeaACAIofbfAnVpyM6aiTWq2+/sfhaePNHuSht/lWLqu+l8Tn83YJIAJjpzWmuIk2M+4KgepglXAB+9+2NXePE28QgG5Q5KJlSxbjGoCacFGPLiF+k4/cr5fGUU1PmC4jfbN5mSU1c7BCOo8iiFUSAtZNR7Ldl4d4mPh1xGlz5R3I/MybISjsOH69ImQvQF5qkGRrHFMXmfZ290YhCyq3ZWwxD8whUuwVQ8R/WAISVWRTQjd3SKcxQov6Mvq9p7y8/Ws7JGBtw/6sjNNB3oIuz0Ae1wXX+FUyV2Liq0ILj2jnLLPdAs7jWomzM1XPvTHOuGNXWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FflnNB8YGIQuy1bgLNbBONlDRZy4z1qDSClORGfkylE=;
 b=Z0RILIyhfFJGa/1vum3lu6MFWe/a8dlKeeKELOpDiTRt8AjL/iP6toLDgpIP6Gys5TrOsP2Dul5SWsAobRuYVMs+Wl8VaJTyl60oUeZyGZkX5sHaKaNRJ4e9ocLBzj8v9KfMTTqu3Jgvmnm7QvG3/YztL/Ae9BYSQOZcagIxbzTQZ4blFI3Z2w8qCkAGPN0SJKl0VndiRYY3bWSnKCV9HRpDJrl4Qc9mlS8z9Y3dc6luxM3W739+0MkkIQ4CEFgVg46Qd79ZgR1idZ9815tQ6wn0V8vP1VZiH+hUU8IQWk+L714FbtAxdFu8CXO1RRFQ9doDiDP9Li4rJpMmqOJ4XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 52.169.0.179) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de;
 dmarc=bestguesspass action=none header.from=arri.de; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FflnNB8YGIQuy1bgLNbBONlDRZy4z1qDSClORGfkylE=;
 b=Av3jsxAXUGPnC9ZkYfeJFo6iBiOEn9Rs/i3CBxciojFEiVtzG0SakmdZHeyT+HhPUMCkKsnCbR6wfxPp4FVrReQbW2ktJ2QU2sYnnoRFDF5zvrvlHDxIw1MYRIh1+MoO1MfPjVq0OXJTzQZ+V1Ojazfa/3hOBmfxCv7QIyCGBhk=
Received: from DUZPR01CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::12) by PR3PR07MB6586.eurprd07.prod.outlook.com
 (2603:10a6:102:69::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 13:41:00 +0000
Received: from DB5PEPF00014B90.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::1a) by DUZPR01CA0022.outlook.office365.com
 (2603:10a6:10:46b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 13:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.169.0.179)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=arri.de;
Received-SPF: Pass (protection.outlook.com: domain of arri.de designates
 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net; pr=C
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 DB5PEPF00014B90.mail.protection.outlook.com (10.167.8.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 13:40:59 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (104.47.14.51)
	 by eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
	 ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
	 tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Mon, 20 Nov 2023 13:41:00 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 17935667
X-ExclaimerImprintLatency: 2597032
X-ExclaimerImprintAction: 8f2131714dde4dfca61832f7571498f1
Content-Type: multipart/related;
	boundary="----_=_NextPart_93de770a-9ea4-47eb-84f1-8516ec1128e8"
Received: from DB7PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:10:36::32)
 by DB9PR07MB9051.eurprd07.prod.outlook.com (2603:10a6:10:3d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 13:40:56 +0000
Received: from DB5PEPF00014B9C.eurprd02.prod.outlook.com
 (2603:10a6:10:36:cafe::4b) by DB7PR05CA0019.outlook.office365.com
 (2603:10a6:10:36::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 13:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5PEPF00014B9C.mail.protection.outlook.com (10.167.8.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 13:40:55 +0000
Received: from n95hx1g2.localnet (10.30.5.31) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Nov
 2023 14:40:55 +0100
From: Christian Eggers <ceggers@arri.de>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] npm/npmsw fetchers: Support for "offline" builds?
Date: Mon, 20 Nov 2023 14:40:55 +0100
Message-ID: <2785264.BEx9A2HvPv@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CANNYZj8J+PQmKJOSzn=_CMJ4CGvo93ghArE1QrE4uuSK4qjQFg@mail.gmail.com>
References: <4851356.GXAFRqVoOG@n95hx1g2> <2250070.iZASKD2KPV@n95hx1g2> <CANNYZj8J+PQmKJOSzn=_CMJ4CGvo93ghArE1QrE4uuSK4qjQFg@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [10.30.5.31]
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: 
	DB5PEPF00014B9C:EE_|DB9PR07MB9051:EE_|DB5PEPF00014B90:EE_|PR3PR07MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d0c548-25ce-4f16-46fd-08dbe9ce54ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 iVUdkBP7PPJToGIJN28LnfSHbRDWg3KQc6zsbiIBra1Xszi0r2CsbOPAh7WLQscq8rY0u9AE9xYFKs5UweCT3zvM1Xmr1KyV5g11pPk4k9NcKPEondeHrYFtIet8To7irvESzbmInt7cC1/FgJw35PI+pM4dUaXYqoZZM4s2GrN0ItodKnOSxO+Ee88Oq6PZgkaOf+YZOhCukvD0sa2G8I5ulZFXDikxcEKscO5PCLX+OvZV6jH2hjItN3jwaZl8ewzPHS+JYmCVz2oM06U+1oOt4v+kxBsqhOMWmf7IuIQSCmPIJFYX+OmYNdntNeshXO48Z8jT9yxhTD8rvJlo77iQdzY2njoY9sleFUIvwMNXseHbckitaPr8rQNF3QJZmyAKG9o8fi+PUdj5rEseGY0YouoY5q081a4tREhm1dVlW/yeSCbjnePcQtrDIS2/pVz6a/f3AlLi/dDP3PW8p7Bx3makXJBP4Vt5pxuMg8ckZ/RHe96cMb89BMocjIpxe7OUaDxd2QTp0HxdUkF4tSoMcso+mmPDvCmyGOWP4G0JqTZgqIKGKhL9T4nUMcRRnJSL0qOL9vSIc+xIRBVl5K1ccSHgB+UeUxjWG8YIVPX3A6RhPpoU88shs8KLHZI9H2Cbct8YDZF7+U7TN4fErw7kSteXm0nJHwKHBPuPsFV2pWDypmYZaiwkH7CZ7ziMkGEzE2muKC4QaMnuICuUI31Rqscdf81wHBcfSuP74irGgIUHh5HY2JaqFRC26uQLryGYUov+sZ43glAbHH5eitLNKkp4MKIb+gYMai6lFLeAJAJKdAQIhG4awedI67IR
X-Forefront-Antispam-Report-Untrusted: 
 CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39850400004)(136003)(396003)(346002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799012)(46966006)(36840700001)(66574015)(83380400001)(426003)(336012)(16526019)(26005)(33716001)(9686003)(47076005)(36860700001)(41300700001)(4326008)(8676002)(8936002)(9576002)(2906002)(5660300002)(478600001)(966005)(36916002)(70586007)(70206006)(6916009)(316002)(81166007)(86362001)(82740400003)(356005)(40480700001)(39026012)(36900700001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9051
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DB5PEPF00014B90.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	1a9b9bcc-45cc-4c4c-d1d8-08dbe9ce5282
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Brt0YYnVOacCKuv61ZvqGlhfWoc01ZogID4lpj0i1X+fvvetZWzYHhADs545KuJxh3MWNG+JsY7Bl+Lwi6v0ggqjrqACJLWIpOtG0YuJHMzn1kCngUbj2EpgjvB9kNKXnxwr/u3dHNragkeJdjwpQI3z5ohkT7iQ2ipEQFM/QTnxlzzbZQDZfp9RkHMn5wLNzHJhTTNXKX9KIviMbxjtAy4AsdbArV3hps/JkRCOg35O2i/zFfoxbY+WJWFxWBFlrp0jFVVqt2e2g4q/vlLgC7cDE42LbPpMwzADdzsHDcAdl8nCMqaU5m6+MUOckZe8iLpb9w/kDA+ANT/Tt702PgeTT1wfrSxoGgctVoIwIUrJQBtfeQxHbHQVBosKnc6k2mfFapeOyGk14QpnWNFjMXY/tj3D6Kp+eHlFRh0KmfLZdoZYR5vYyHDHEQ6KGgiZp0baSLm+lJxCPpnQazQFn9PeTyw4bgdHJu1mM5p2JpbQx2/SMHGW+ax/u7ODwpzhKJXtFEXC1AWwcrxW/Bz+0Dycbm0Ph7Ak2A8cwhq8JPQ7TQ8kwCrzi7o7dz9rW3Sgm7s+rPxyYTEOEbOIvMbSZ4O1/I3Os/XoDe9a6sBxU0x68lcN0qOzQ4ociZYqxKyDB0Ofup+yMJBeQOu3XDiX8qE1UOjhQZFaxudRYaWXwGHQv71uuWLHZZiVipncjqvYcdnuiPvkl7CGfqzQGWcMq8B/umYyrRopvW+A6I0YN0xx7qh0ZVKQLuX6ll1B8ZiWmpNpOu4pY/Yvd6wVVlX681paCsP+n12I3K3XqN36C1jHYUD5X+b/atkUFyFufMdZ2N+ZKawp6QDeu3LPpDdqNj4/SMnC1E+3jzFzBBxtSYvITDlqH+sQ0jdNrVJVn+dC
X-Forefront-Antispam-Report: 
	CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(13230031)(4636009)(136003)(39850400004)(346002)(376002)(396003)(230922051799003)(186009)(82310400011)(64100799003)(7200799017)(451199024)(1690799017)(1800799012)(40470700004)(46966006)(36840700001)(426003)(336012)(66574015)(70206006)(70586007)(316002)(6916009)(16526019)(26005)(40460700003)(8936002)(4326008)(8676002)(41300700001)(166002)(7596003)(7636003)(82740400003)(36860700001)(47076005)(33716001)(86362001)(2906002)(5660300002)(15974865002)(9576002)(966005)(83380400001)(478600001)(9686003)(36916002)(33964004)(45080400002)(8400799017)(40480700001)(39026012);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 13:40:59.7389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d0c548-25ce-4f16-46fd-08dbe9ce54ff
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5PEPF00014B90.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6586
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Nov 2023 13:41:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15539

This is a multi-part message in MIME format.

------_=_NextPart_93de770a-9ea4-47eb-84f1-8516ec1128e8
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_41481bb4-a19b-4243-9742-7cec41fa98e1"

------_=_NextPart_41481bb4-a19b-4243-9742-7cec41fa98e1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Monday, 20 November 2023, 13:47:56 CET, Alexander Kanavin wrote:

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
> On Mon, 20 Nov 2023 at 13:19, Christian Eggers <ceggers@arri.de> wrote:
> 
> >
> > my intend is to run as few build scripts as possible as long as the bui=
ld
> > machine has access to the internet. For security reasons I would like t=
o
> > divide
> > the build into two stages, one stage for downloading (with internet acc=
ess
> > enabled)
> > and one stage for compiling (without internet access).
> >
> > While I highly trust the OpenEmbedded/Yocto projects, I fear that singl=
e
> > upstream
> > projects may become targets for supply chain attacks in the future. Run=
ning
> > the package Makefiles/scripts etc. on a machine (e.g. docker) without
> > network
> > access reduces the possibility for manipulated packages to retrieve
> > internal
> > secrets and upload them to the internet.
> >
> > Are there any other use cases why people want to perform an "offline"
> > build?
> >
> 
> Depending on whether your yocto version is recent enough, all tasks other
> than fetch already run with network disabled. You can try it yourself: tr=
y
> using wget from do_configure, and it's going to fail.

ok, I just found "utils: Add disable_network function" [1]. This is already=
 in
kirkstone (the version I currently use). I guess that this has been introdu=
ced
for ensuring that recipe don't fetch data outside of SRC_URI. But it could
also prevent malicious Makefiles from phoning home.

> 
> I think you can also set FETCHCMD_npm if you trust host distro vendor
> processes (that you can't audit) more than you trust OE build process. Ev=
en
> then, you still need to trust a compiler to build a compiler.

I have to rethink whether splitting my CI into "download" and "build" still=
 makes
sense (being able to ensure the disable_network functionality would help he=
re). 
Deciding who should I trust more is indeed a complex question. But giving m=
y
shell to hundreds of upstream package maintainers without ensuring at least=
 basic
security sounds a little bit like the past century...

> 
> Alex
> 

[1] https://patchwork.yoctoproject.org/project/bitbake/patch/20211222231907=
=2E1036709-1-richard.purdie@linuxfoundation.org/




------_=_NextPart_41481bb4-a19b-4243-9742-7cec41fa98e1
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8" /></head><body><div>On Monday, 20 November 2023, 13:47:56 CET, Al=
exander Kanavin wrote:<br /><div dir=3D"ltr" style=3D"mso-line-height-rule:=
exactly;-webkit-text-size-adjust:100%;font-size:1px;direction:ltr;"><table =
cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"width:100%;font-s=
ize:1px;"><tr style=3D"font-size:0;"><td align=3D"left" style=3D"vertical-a=
lign:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=
=3D"font-size:0;"><tr style=3D"font-size:0;"><td align=3D"left" style=3D"pa=
dding:0;vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" bor=
der=3D"0" style=3D"width:100%;font-size:0;"><tr style=3D"font-size:14.67px;=
color:#7F7F7F;font-style:normal;font-weight:400;white-space:nowrap;"><td al=
ign=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,sans-ser=
if;">_______________________________________________________<span style=3D"=
font-family:remialcxesans;font-size:1px;color:#FFFFFF;line-height:1px;">&#8=
203;</span></td></tr><tr style=3D"font-size:0;"><td align=3D"left" style=
=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=
=3D"0" style=3D"font-size:0;"><tr style=3D"font-size:0;"><td align=3D"left"=
 style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" b=
order=3D"0" style=3D"font-size:0;color:#7F7F7F;font-style:normal;font-weigh=
t:400;white-space:nowrap;"><tr style=3D"font-size:14.67px;"><td align=3D"le=
ft" style=3D"vertical-align:top;font-family:Calibri,Arial,sans-serif;">Chri=
stian</td><td align=3D"left" style=3D"vertical-align:top;color:#000001;font=
-family:Calibri,Arial,sans-serif;">&nbsp;<br /></td><td align=3D"left" styl=
e=3D"vertical-align:top;font-family:Calibri,Arial,sans-serif;">Eggers</td><=
/tr></table></td></tr><tr style=3D"font-size:0;"><td align=3D"left" style=
=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=
=3D"0" style=3D"font-size:0;color:#7F7F7F;font-style:normal;font-weight:400=
;white-space:nowrap;"><tr style=3D"font-size:14.67px;"><td align=3D"left" s=
tyle=3D"vertical-align:top;font-family:Calibri,Arial,sans-serif;">Software&=
nbsp;Engineer</td></tr><tr style=3D"font-size:14.67px;color:#000001;"><td a=
lign=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,sans-se=
rif;">&#8203;</td></tr></table></td></tr></table></td></tr><tr style=3D"fon=
t-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><table cellpadd=
ing=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;"><tr style=
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
td align=3D"left" style=3D"vertical-align:top;font-family:Arial;">Arriweg&n=
bsp;17</td><td align=3D"left" style=3D"vertical-align:top;font-family:Arial=
;">,&nbsp;<br /></td><td align=3D"left" style=3D"vertical-align:middle;font=
-family:Arial;">83071</td><td align=3D"left" style=3D"vertical-align:middle=
;font-family:Arial;">&nbsp;<br /></td><td align=3D"left" style=3D"vertical-=
align:middle;font-family:Arial;">Stephanskirchen</td></tr></table></td></tr=
></table></td></tr><tr style=3D"font-size:0;"><td align=3D"left" style=3D"v=
ertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0"=
 style=3D"font-size:0;"><tr style=3D"font-size:0;"><td align=3D"left" style=
=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=
=3D"0" style=3D"font-size:0;color:#1532B9;font-style:normal;font-weight:400=
;white-space:nowrap;"><tr style=3D"font-size:11px;"><td align=3D"left" styl=
e=3D"vertical-align:top;font-family:Arial;"><span style=3D"text-decoration:=
underline;"><a href=3D"http://www.arri.com/" target=3D"_blank" id=3D"LPlnk6=
89713" style=3D"text-decoration:underline;color:#1532B9;">www.arri.com&nbsp=
;<br /><br /></a></span></td></tr><tr style=3D"font-size:0;"><td align=3D"l=
eft" style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"=
0" border=3D"0" style=3D"font-size:0;color:#858080;font-style:normal;font-w=
eight:400;line-height:normal;white-space:nowrap;"><tr style=3D"font-size:14=
=2E67px;"><td align=3D"left" style=3D"padding:0;vertical-align:top;font-siz=
e:0;"><img src=3D"cid:image607302.png@31FB9BE4.BC340955" width=3D"20" borde=
r=3D"0" alt=3D"" style=3D"width:20px;min-width:20px;max-width:20px;font-siz=
e:0;" /></td><td align=3D"left" style=3D"padding:0;vertical-align:top;font-=
family:Calibri,Arial,sans-serif;"><a href=3D"tel:+49%208036%203009-3118" ta=
rget=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:none;color:#858=
080;">+49&nbsp;8036&nbsp;3009-3118</a></td></tr><tr style=3D"font-size:0;">=
<td align=3D"left" style=3D"padding:0;vertical-align:top;"></td><td align=
=3D"left" style=3D"padding:0;vertical-align:top;"></td></tr><tr style=3D"fo=
nt-size:0;"><td align=3D"left" style=3D"padding:0;vertical-align:top;"></td=
><td align=3D"left" style=3D"padding:0;vertical-align:top;"></td></tr><tr s=
tyle=3D"font-size:14.67px;"><td align=3D"left" style=3D"padding:0;vertical-=
align:top;font-size:0;"><img src=3D"cid:image125103.png@A2035EFD.02837868" =
width=3D"20" border=3D"0" alt=3D"" style=3D"width:20px;min-width:20px;max-w=
idth:20px;font-size:0;" /></td><td align=3D"left" style=3D"padding:0;vertic=
al-align:top;font-family:Calibri,Arial,sans-serif;"><a href=3D"mailto:CEgge=
rs@arri.de" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:n=
one;color:#858080;">CEggers@arri.de</a></td></tr></table></td></tr></table>=
</td></tr></table></td></tr><tr style=3D"font-size:14.67px;color:#000001;fo=
nt-style:normal;font-weight:400;white-space:nowrap;"><td align=3D"left" sty=
le=3D"vertical-align:top;font-family:Calibri,Arial,sans-serif;"><br />&#820=
3;</td></tr></table></td></tr><tr style=3D"font-size:0;line-height:normal;"=
><td align=3D"left" style=3D"padding:0;vertical-align:top;"><a href=3D"http=
s://www.arri.com/skypanelx" target=3D"_blank" id=3D"LPlnk689713" style=3D"t=
ext-decoration:none;"><img src=3D"https://assets.arri.com/media/sign/202309=
08a_Stardust_E-mail-Signature_800x170@2x.jpg" width=3D"660" border=3D"0" ti=
tle=3D"SkyPanel X" alt=3D"SkyPanel X" style=3D"width:660px;min-width:660px;=
max-width:660px;font-size:12px;" /></a></td></tr><tr style=3D"font-size:13p=
x;color:#7F7F7F;font-style:normal;font-weight:400;white-space:nowrap;"><td =
align=3D"left" style=3D"padding:0;vertical-align:top;font-family:Calibri,Ar=
ial,sans-serif;">Get&nbsp;all&nbsp;the&nbsp;latest&nbsp;information&nbsp;fr=
om&nbsp;<span style=3D"text-decoration:underline;"><a href=3D"https://www.a=
rri.com/" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:und=
erline;color:#7F7F7F;">www.arri.com</a></span>,&nbsp;<span style=3D"text-de=
coration:underline;"><a href=3D"https://www.facebook.com/TeamARRI" target=
=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:underline;color:#7F=
7F7F;">Facebook</a></span>,&nbsp;<span style=3D"text-decoration:underline;"=
><a href=3D"https://twitter.com/ARRIChannel" target=3D"_blank" id=3D"LPlnk6=
89713" style=3D"text-decoration:underline;color:#7F7F7F;">Twitter</a></span=
>,&nbsp;<a href=3D"https://www.instagram.com/arri/" target=3D"_blank" id=
=3D"LPlnk689713" style=3D"text-decoration:none;color:#7F7F7F;"><span style=
=3D"text-decoration:underline;">Instagram</span></a>,&nbsp;<a href=3D"https=
://www.linkedin.com/company/arri" target=3D"_blank" id=3D"LPlnk689713" styl=
e=3D"text-decoration:none;color:#7F7F7F;"><span style=3D"text-decoration:un=
derline;">LinkedIn</span></a>&nbsp;and&nbsp;<a href=3D"https://www.youtube.=
com/user/ARRIChannel" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-de=
coration:none;color:#7F7F7F;"><span style=3D"text-decoration:underline;">Yo=
uTube</span></a>&nbsp;and&nbsp;<a href=3D"https://twitter.com/ARRIChannel" =
target=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:none;color:#7=
F7F7F;"><span style=3D"text-decoration:underline;">X</span></a>.<br /></td>=
</tr><tr style=3D"font-size:0;"><td align=3D"left" style=3D"padding:0;verti=
cal-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" sty=
le=3D"font-size:0;color:#6A6A6A;font-style:normal;font-weight:400;white-spa=
ce:nowrap;"><tr style=3D"font-size:10px;"><td align=3D"left" style=3D"verti=
cal-align:top;font-family:Arial;"><br />Arnold&nbsp;&amp;&nbsp;Richter&nbsp=
;Cine&nbsp;Technik&nbsp;GmbH&nbsp;&amp;&nbsp;Co.&nbsp;Betriebs&nbsp;KG<br /=
>Sitz:&nbsp;M&#252;nchen&nbsp;=E2=80=91&nbsp;Registergericht:&nbsp;Amtsgeri=
cht&nbsp;M&#252;nchen&nbsp;=E2=80=91&nbsp;Handelsregisternummer:&nbsp;HRA&n=
bsp;57918<br />Pers&#246;nlich&nbsp;haftender&nbsp;Gesellschafter:&nbsp;Arn=
old&nbsp;&amp;&nbsp;Richter&nbsp;Cine&nbsp;Technik&nbsp;GmbH<br />Sitz:&nbs=
p;M&#252;nchen&nbsp;=E2=80=91&nbsp;Registergericht:&nbsp;Amtsgericht&nbsp;M=
&#252;nchen&nbsp;=E2=80=91&nbsp;Handelsregisternummer:&nbsp;HRB&nbsp;54477<=
br />Gesch&#228;ftsf&#252;hrer:&nbsp;Dr.&nbsp;Matthias&nbsp;Erb&nbsp;(Chair=
man);&nbsp;Lars&nbsp;Weyer;&nbsp;Stephan&nbsp;Schenk;&nbsp;Walter&nbsp;Trau=
ninger<br /></td></tr><tr style=3D"font-size:14.67px;color:#000001;"><td al=
ign=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,sans-ser=
if;"><br />&#8203;<br /></td></tr></table></td></tr></table></td></tr></tab=
le></div>&gt; On Mon, 20 Nov 2023 at 13:19, Christian Eggers &lt;ceggers@ar=
ri.de&gt; wrote:<br />&gt; <br />&gt; &gt;<br />&gt; &gt; my intend is to r=
un as few build scripts as possible as long as the build<br />&gt; &gt; mac=
hine has access to the internet. For security reasons I would like to<br />=
&gt; &gt; divide<br />&gt; &gt; the build into two stages, one stage for do=
wnloading (with internet access<br />&gt; &gt; enabled)<br />&gt; &gt; and =
one stage for compiling (without internet access).<br />&gt; &gt;<br />&gt;=
 &gt; While I highly trust the OpenEmbedded/Yocto projects, I fear that sin=
gle<br />&gt; &gt; upstream<br />&gt; &gt; projects may become targets for =
supply chain attacks in the future. Running<br />&gt; &gt; the package Make=
files/scripts etc. on a machine (e.g. docker) without<br />&gt; &gt; networ=
k<br />&gt; &gt; access reduces the possibility for manipulated packages to=
 retrieve<br />&gt; &gt; internal<br />&gt; &gt; secrets and upload them to=
 the internet.<br />&gt; &gt;<br />&gt; &gt; Are there any other use cases =
why people want to perform an &quot;offline&quot;<br />&gt; &gt; build?<br =
/>&gt; &gt;<br />&gt; <br />&gt; Depending on whether your yocto version is=
 recent enough, all tasks other<br />&gt; than fetch already run with netwo=
rk disabled. You can try it yourself: try<br />&gt; using wget from do_conf=
igure, and it&#39;s going to fail.<br /><br />ok, I just found &quot;utils:=
 Add disable_network function&quot; [1]. This is already in<br />kirkstone =
(the version I currently use). I guess that this has been introduced<br />f=
or ensuring that recipe don&#39;t fetch data outside of SRC_URI. But it cou=
ld<br />also prevent malicious Makefiles from phoning home.<br /><br />&gt;=
 <br />&gt; I think you can also set FETCHCMD_npm if you trust host distro =
vendor<br />&gt; processes (that you can&#39;t audit) more than you trust O=
E build process. Even<br />&gt; then, you still need to trust a compiler to=
 build a compiler.<br /><br />I have to rethink whether splitting my CI int=
o &quot;download&quot; and &quot;build&quot; still makes<br />sense (being =
able to ensure the disable_network functionality would help here). <br />De=
ciding who should I trust more is indeed a complex question. But giving my<=
br />shell to hundreds of upstream package maintainers without ensuring at =
least basic<br />security sounds a little bit like the past century...<br /=
><br />&gt; <br />&gt; Alex<br />&gt; <br /><br />[1] https://patchwork.yoc=
toproject.org/project/bitbake/patch/20211222231907.1036709-1-richard.purdie=
@linuxfoundation.org/<br /><br /><br /><br /></div></body></html>
------_=_NextPart_41481bb4-a19b-4243-9742-7cec41fa98e1--

------_=_NextPart_93de770a-9ea4-47eb-84f1-8516ec1128e8
Content-Type: image/png;
	name="image607302.png"
Content-Transfer-Encoding: base64
Content-ID: <image607302.png@31FB9BE4.BC340955>
Content-Description: image607302.png
Content-Disposition: inline;
	creation-date="Mon, 20 Nov 2023 13:40:59 +0000";
	filename=image607302.png;
	modification-date="Mon, 20 Nov 2023 13:40:59 +0000";
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

------_=_NextPart_93de770a-9ea4-47eb-84f1-8516ec1128e8
Content-Type: image/png;
	name="image125103.png"
Content-Transfer-Encoding: base64
Content-ID: <image125103.png@A2035EFD.02837868>
Content-Description: image125103.png
Content-Disposition: inline;
	creation-date="Mon, 20 Nov 2023 13:40:59 +0000";
	filename=image125103.png;
	modification-date="Mon, 20 Nov 2023 13:40:59 +0000";
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

------_=_NextPart_93de770a-9ea4-47eb-84f1-8516ec1128e8--

