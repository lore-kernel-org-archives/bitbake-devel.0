Return-Path: <ceggers@arri.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9306FC3527C
	for <webhook@archiver.kernel.org>; Wed, 13 Apr 2022 15:48:06 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.98])
 by mx.groups.io with SMTP id smtpd.web08.3085.1649829814637653366
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 12 Apr 2022 23:03:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arrigroup.onmicrosoft.com
 header.s=selector1-arrigroup-onmicrosoft-com header.b=KTXJnx1O;
 spf=pass (domain: arri.de, ip: 40.107.7.98, mailfrom: ceggers@arri.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeLxkJ5tYH6jlCyDnynGnbLMJuVGFqEOuoOAWmEePQPIZld0HYwPhDwbUL0FkDf/CRGWLhW3DlQeIuDgh7j4RrfyivnSyv8UmVGGt/KIKWAADx1UDgAjYd24Gl/H4XMhRLdtqadQBlK5WnMbdm51wvUm3bppNDSV2yqfAAy3VWDiNX2FAlLmYYIJugk4aoYWmsmH+VYUHOEff6mGbGAEWagJ27XZ82tI3kCpndx2QLbLGxWbkaqrTZQ/g6LhA9eoDD4BG6VJpHRAzssZQNAeeY+55gK9FDV8X1iU4GO/kMgwfkan+IbQGbDAsjmv0nykEF8amhtCGkieBPLMFJUEjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/5rblLdhoZQ/kZjy9CXAFvHtQBD6QQ1CuoUM2kG5VU=;
 b=CDnYO+j5QXdbLZBUbIt55qOiPIcwN0TqQtWKeUsCNTxZK0thhE0+wIFVt681ujgacAIZOvBJbktswSVNgt0bwrJ8cYJT5/C418XjfK7P2SDG6hXsBoP3G3Wp03Bk+w+cmC7NbiJt8/gPeb4u9wY5jZcYFH540W/VAnw/q6DjK5hByimblJaHaPAvrzvMglKpmZ45CLP1mpfsbWB5bxcWSrHU/fCgEm/jwc2jRYm97kEoH6Ww3Jcg2mLAJY5bJX+LT0cmc7ReS9ZDAdgS3pXac79P6OwtvpWXR6JPCpY8Wne7p17GaXkdb1iwj38Esl2/f0+l8BhrftfeYEIh6rSHWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 104.40.229.156) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=arri.de; dmarc=bestguesspass action=none header.from=arri.de;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/5rblLdhoZQ/kZjy9CXAFvHtQBD6QQ1CuoUM2kG5VU=;
 b=KTXJnx1OXsLRbCRX4HTQA6wAQp+Rsqa4WRZs0CBGUu4uVj+vPCbSEZZ8hFCh36KeU2/4C74uqIBK+YmxOob9D3a5BOorsRWbaPDW2qQBijkpSgdWAHeIOorBwPKWehRA4+mWmnVUw4p3S3tgRqKzQnpSvsuxMlIYSDufSAx932g=
Received: from AM0PR08CA0019.eurprd08.prod.outlook.com (2603:10a6:208:d2::32)
 by VI1PR07MB4670.eurprd07.prod.outlook.com (2603:10a6:803:72::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Wed, 13 Apr
 2022 06:03:29 +0000
Received: from AM5EUR02FT038.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:208:d2:cafe::5b) by AM0PR08CA0019.outlook.office365.com
 (2603:10a6:208:d2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Wed, 13 Apr 2022 06:03:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 104.40.229.156)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=arri.de;
Received-SPF: Pass (protection.outlook.com: domain of arri.de designates
 104.40.229.156 as permitted sender) receiver=protection.outlook.com;
 client-ip=104.40.229.156; helo=eu1.smtp.exclaimer.net;
Received: from eu1.smtp.exclaimer.net (104.40.229.156) by
 AM5EUR02FT038.mail.protection.outlook.com (10.152.9.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 06:03:28 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.172)
	 by eu1.smtp.exclaimer.net (104.40.229.156) with Exclaimer Signature Manager
	 ESMTP Proxy eu1.smtp.exclaimer.net (tlsversion=TLS12,
	 tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Wed, 13 Apr 2022 06:03:28 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 12005956
X-ExclaimerImprintLatency: 3555699
X-ExclaimerImprintAction: 606d3251864a4ababed90d6a8a6f233e
Content-Type: multipart/related;
	boundary="----_=_NextPart_1c6a01c1-4c32-4e84-bf6a-a65d177b22ab"
Received: from SV0P279CA0018.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:11::23)
 by DB7PR07MB5402.eurprd07.prod.outlook.com (2603:10a6:10:79::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Wed, 13 Apr
 2022 06:03:24 +0000
Received: from HE1EUR02FT004.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:f10:11:cafe::b4) by SV0P279CA0018.outlook.office365.com
 (2603:10a6:f10:11::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.19 via Frontend
 Transport; Wed, 13 Apr 2022 06:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 HE1EUR02FT004.mail.protection.outlook.com (10.152.10.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Wed, 13 Apr 2022 06:03:24 +0000
Received: from dhcp-192-168-0-28.wgnetz.xx (192.168.54.189) by mta.arri.de
 (10.10.18.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 13 Apr
 2022 08:03:23 +0200
From: Christian Eggers <ceggers@arri.de>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, Christopher Larson
	<kergoth@gmail.com>, Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Subject: Re: [bitbake-devel] conditional inheriting classes does not work with
 bbappends
Date: Wed, 13 Apr 2022 08:03:22 +0200
Message-ID: <5561200.DvuYhMxLoT@dhcp-192-168-0-28.wgnetz.xx>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <4e01937824084bff8aadf5adfd965670@axis.com>
References: <1839335.tdWV9SEqCh@localhost.localdomain>
 <3188702.aeNJFYEL58@localhost.localdomain>
 <4e01937824084bff8aadf5adfd965670@axis.com>
MIME-Version: 1.0
X-Originating-IP: [192.168.54.189]
X-EOPAttributedMessage: 1
X-MS-Office365-Filtering-Correlation-Id: 24312403-5c0a-4439-1b51-08da1d13548f
X-MS-TrafficTypeDiagnostic: 
	DB7PR07MB5402:EE_|AM5EUR02FT038:EE_|VI1PR07MB4670:EE_
X-Microsoft-Antispam-PRVS: 
	<VI1PR07MB46704C203947D44F3787AC34BFEC9@VI1PR07MB4670.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 RhsGzjVylinB9UXihNghUCDsvgu4mesI7XakH7VFc3rdjn31F5OnJaFr6jvedqfZnTjKwR0auXoEBV6HX6pFXothxLqfjJVcRBYCpuFS2bfkqsWUS8kRVtI+2vJyATs+knoLOQtAXJGcdH4JsXBGYBA+O4dJyOACk+JcUH3o0XduAJVUmviWc5zDztU0nAV3mqhPAV0fGWJVDn3N1w2HC84R57NtUTspjaUN6av77kxCmFYWPONmQK1F9Wx5+hsNf6bAytV47Z1rmgikrnyFiJRABu7SxAYI1JCiovj90CPFm7OtkJZUxdUSKhKPyr9ioJmKJN5ky40WVujlf8z3sS0S/UXZOVYlbuups/FRFg8M7O5yv53PMy+Lkk1bQRvvOWLbu4mfwgpngxX8n2uOjoBa51dnzYLxGEPUtk4ykG/2k4XIiAYGLcJAAdncUX/UCMe51jREOzT0PjzXJiXvGpbjOG/donsDGA3dvzJkEBcleqjY+chGy0Fq8ru9sprhAIw7X3q+4xhX/2gOd9vxSRaEV230EInmFGCmIO8uroWVDq+u3Pe6UFa5nhbvkFYZaAPI0tlP2aajEua9/V5N4JPixNUd+ePdtnT91ydwyAO7bk7glrzVLQ2bT1Qmtu4qnx2uqz/LjSI1f+HTDlB6TpztueYtHTPn35r17hDg1QgtGms+mXY8emPjr+kvbm0ydQGkliBRS3YGz0Qa9zr2fQ==
X-Forefront-Antispam-Report-Untrusted: 
 CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(5660300002)(70586007)(8936002)(336012)(2906002)(426003)(70206006)(82310400005)(81166007)(508600001)(356005)(86362001)(316002)(110136005)(8676002)(36916002)(36860700001)(7696005)(53546011)(47076005)(55016003)(9686003)(26005)(83380400001)(186003)(16526019)(102196002)(36900700001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR07MB5402
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM5EUR02FT038.eop-EUR02.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	e11f4dda-4904-4823-255e-08da1d1351e4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7M6VFYqrBjG+Gw45oKLdG716gm4f7wWNhfO5K4bkIzAoLlYpsvJJuVs2DCrBj2zK1XyC+cblEj07H5nLEETE345rY2n5NfqCnbA/BSozz9J19xWnTpPLD+gYULVV6N1YLCb7UPy1QyNlArepFso3Gvr9xUKV9O4xLKEIVhY/lkT3LTHOTe3ScPSjqYqQyAiwsYoLRY99G3+0XCnDE4F/rEjgAPf44whVaM2zdXsdfIzd36dL8flnyeGwQA6kM1fS85PAeUTVmKw5+n81Pq1uJr1qOmK9mheaGEn1NxZa2iukNfbNsb8JEwRm/6hK1xMaFGeVCD/1Ux6uyZlty2DGDsvTnPz1kpNdpI3yG+PfKahUT+XHzKzZHqH+UZlxVgduYrd7BPFVy8YC1NUeEWICkpZkE9LZLbDoJYP1mTGcxqed1ldPa0kowruxXoqGSJAl5idH7iY3Kenzt44OnO0WrgilC++1S/MKN6xdYDuL8Ht37O3xp5uQ0+ZUPM/0fYIg9DHvuxPDcOJN+YoP54OXEb/72t/kWsN64dMzCpM3AD2w0d+GD7mVLd8tBGsISlOxt2th2hLWvcVORh/SEnxr6PsJkUYJ5rWv8RogUuToi2es0qWW8WfUogRvAxm5SAEC5rWgynE7+6tVJX7zCjrEaoPn0si9+C3y3+yhVMWg20STmiLymDWNxTXfd0VvZ7aPXJ/tdvCBrjik+KhaOCBDG9RfGL+qlPMz8mIgQkKE+K9YQhz6yw77FL6/sN++EooPTynsKqIBEdUGV5J8ve6ydG3NRsxGboOblo3zsZHfu62isAbgL5cBQ6XrUmJ02Yb6eUoAPh90FYwsXg7D9F7Sew==
X-Forefront-Antispam-Report: 
	CIP:104.40.229.156;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu1.smtp.exclaimer.net;PTR:eu1.smtp.exclaimer.net;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(16526019)(186003)(8936002)(83380400001)(40460700003)(9686003)(36916002)(26005)(70206006)(2906002)(5660300002)(8676002)(36860700001)(86362001)(426003)(66574015)(336012)(47076005)(53546011)(7596003)(166002)(316002)(7636003)(7696005)(33964004)(70586007)(110136005)(45080400002)(55016003)(82310400005)(508600001)(15974865002)(102196002);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 06:03:28.0970
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 24312403-5c0a-4439-1b51-08da1d13548f
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[104.40.229.156];Helo=[eu1.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM5EUR02FT038.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB4670
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 13 Apr 2022 15:48:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13610

This is a multi-part message in MIME format.

------_=_NextPart_1c6a01c1-4c32-4e84-bf6a-a65d177b22ab
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_304c9149-ac75-4cf2-b8ad-fee3330a43c7"

------_=_NextPart_304c9149-ac75-4cf2-b8ad-fee3330a43c7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Tuesday, 12 April 2022, 16:12:57 CEST, Peter Kjellerstedt wrote:
> I don=E2=80=99t think there is a generic solution to this problem. What w=
e do in the particular case is to enable the PACKAGECONFIG in a bbappend an=
d then also add an extra inherit useradd to the bbappend file. Not perfect,=
 but it works.
> 

I have also chosen this workaround. The problem is, that it does not work t=
he other way around:

If the default value for PACKAGECONFIG causes conditionally inheriting spec=
ific classes,
these classes will also be inherited if PACKAGECONFIG is overwritten later =
in a bbappend.


> //Peter
> 
> 
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
ram, LinkedIn and YouTube.

Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
Sitz: M=C3=BCnchen - Registergericht: Amtsgericht M=C3=BCnchen - Handelsreg=
isternummer: HRA 57918
Pers=C3=B6nlich haftender Gesellschafter: Arnold & Richter Cine Technik Gmb=
H
Sitz: M=C3=BCnchen - Registergericht: Amtsgericht M=C3=BCnchen - Handelsreg=
isternummer: HRB 54477
Gesch=C3=A4ftsf=C3=BChrer: Dr. Matthias Erb (Chairman); Dr. Michael Neuh=
=C3=A4user; Stephan Schenk; Walter Trauninger

=E2=80=8B
From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedde=
d.org> On Behalf Of Christian Eggers
> Sent: den 8 april 2022 18:54
> To: bitbake-devel@lists.openembedded.org; Christopher Larson <kergoth@gma=
il.com>
> Subject: Re: [bitbake-devel] conditional inheriting classes does not work=
 with bbappends
> 
> On Thursday, 7 April 2022, 23:59:39 CEST, Christopher Larson wrote:
> > There=E2=80=99s no way to avoid that, inherit lines are evaluated *at t=
he moment of inherit* on that line, they aren=E2=80=99t postponed.
> 
> ok, this is what I would expect. So how to handle this:
> 
> - do not conditionally inherit in PACKAGECONFIG (may be impossible)?
> - do not set PACKAGECONFIG in bbappend files (use distro/machine/layer/lo=
cal config for this)?
> 
> regards
> Christian
> 
> 
> >
> > --
> > Christopher Larson
> > chris_larson@mentor.com<mailto:chris_larson@mentor.com>, chris.larson@s=
iemens.com<mailto:chris.larson@siemens.com>, kergoth@gmail.com<mailto:kergo=
th@gmail.com>
> > Principal Software Engineer, Embedded Linux Solutions, Siemens Digital =
Industries Software
> _______________________________________________________=E2=80=8B
> 
> 
> 
> =E2=80=8B
> 
> 
> 
> > On Apr 7, 2022, 7:17 AM -0700, Christian Eggers <ceggers@arri.de<mailto=
:ceggers@arri.de>>, wrote:
> > > Example: meta-openembedded/meta-networking/recipes-support/chrony/chr=
ony_4.2.bb
> > >
> > > --------------------------------8<--------------------------------
> > > # Add chronyd user if privdrop packageconfig is selected
> > > inherit ${@bb.utils.contains('PACKAGECONFIG<mailto:$%7b@bb.utils.cont=
ains('PACKAGECONFIG>', 'privdrop', 'useradd', '', d)}
> > > USERADD_PACKAGES =3D "${@bb.utils.contains('PACKAGECONFIG', 'privdrop=
', '${PN}', '', d)}<mailto:$%7b@bb.utils.contains('PACKAGECONFIG',%20'privd=
rop',%20'$%7bPN%7d',%20'',%20d)%7d>"
> > > USERADD_PARAM:${PN} +=3D "${@bb.utils.contains('PACKAGECONFIG', 'priv=
drop', '--system -d / -M --shell /bin/nologin chronyd;', '', d)}<mailto:$%7=
b@bb.utils.contains('PACKAGECONFIG',%20'privdrop',%20'--system%20-d%20/%20-=
M%20--shell%20/bin/nologin%20chronyd;',%20'',%20d)%7d>"
> > >
> > > ...
> > >
> > > PACKAGECONFIG ??=3D ...
> > > -------------------------------->8--------------------------------
> > >
> > >
> > > Problem #1: useradd is not inherited because PACKAGECONFIG is set bel=
ow the conditional "inherit"
> > > statement. Even when I add "privdrop" to PACKAGECONFIG here, useradd.=
bbclass is not inherited. I
> > > must move the PACKAGECONFIG line above the inherit statement to make =
this work.
> > >
> > > Problem #2: Due to problem #1, useradd.bbclass is also not inherited =
when I add "privdrop" to
> > > PACKAGECONFIG in bbappend file (in a custom layer).
> > >
> > > regards
> > > Christian
> 
> 
> 





------_=_NextPart_304c9149-ac75-4cf2-b8ad-fee3330a43c7
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8" /></head><body><div>On Tuesday, 12 April 2022, 16:12:57 CEST, Pet=
er Kjellerstedt wrote:<br />&gt; I don=E2=80=99t think there is a generic s=
olution to this problem. What we do in the particular case is to enable the=
 PACKAGECONFIG in a bbappend and then also add an extra inherit useradd to =
the bbappend file. Not perfect, but it works.<br />&gt; <br /><br />I have =
also chosen this workaround. The problem is, that it does not work the othe=
r way around:<br /><br />If the default value for PACKAGECONFIG causes cond=
itionally inheriting specific classes,<br />these classes will also be inhe=
rited if PACKAGECONFIG is overwritten later in a bbappend.<br /><br /><br /=
>&gt; //Peter<br />&gt; <br />&gt; <div dir=3D"ltr" style=3D"mso-line-heigh=
t-rule:exactly;-webkit-text-size-adjust:100%;direction:ltr;"><table cellpad=
ding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"width:100%;"><tr style=
=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><table c=
ellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;"><tr =
style=3D"font-size:0;"><td align=3D"left" style=3D"padding:0;vertical-align=
:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"wid=
th:100%;font-size:0;"><tr style=3D"font-size:14.67px;color:#7F7F7F;font-sty=
le:normal;font-weight:400;white-space:nowrap;"><td align=3D"left" style=3D"=
vertical-align:top;font-family:Calibri,Arial,sans-serif;">_________________=
______________________________________<span style=3D"font-family:remialcxes=
ans;font-size:1px;color:#FFFFFF;line-height:1px;">&#8203;</span></td></tr><=
tr style=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:top;">=
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:=
0;"><tr style=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:t=
op;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-=
size:0;color:#7F7F7F;font-style:normal;font-weight:400;white-space:nowrap;"=
><tr style=3D"font-size:14.67px;"><td align=3D"left" style=3D"vertical-alig=
n:top;font-family:Calibri,Arial,sans-serif;">Christian</td><td align=3D"lef=
t" style=3D"vertical-align:top;color:#000001;font-family:Calibri,Arial,sans=
-serif;">&nbsp;<br /></td><td align=3D"left" style=3D"vertical-align:top;fo=
nt-family:Calibri,Arial,sans-serif;">Eggers</td></tr></table></td></tr><tr =
style=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><ta=
ble cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;c=
olor:#7F7F7F;font-style:normal;font-weight:400;white-space:nowrap;"><tr sty=
le=3D"font-size:14.67px;"><td align=3D"left" style=3D"vertical-align:top;fo=
nt-family:Calibri,Arial,sans-serif;">Software&nbsp;Engineer</td></tr><tr st=
yle=3D"font-size:14.67px;color:#000001;"><td align=3D"left" style=3D"vertic=
al-align:top;font-family:Calibri,Arial,sans-serif;">&#8203;</td></tr></tabl=
e></td></tr></table></td></tr><tr style=3D"font-size:0;"><td align=3D"left"=
 style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" b=
order=3D"0" style=3D"font-size:0;"><tr style=3D"font-size:0;"><td align=3D"=
left" style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=
=3D"0" border=3D"0" style=3D"font-size:0;color:#0E50AD;font-style:normal;fo=
nt-weight:400;white-space:nowrap;"><tr style=3D"font-size:13.33px;"><td ali=
gn=3D"left" style=3D"vertical-align:top;font-family:&#39;Arial Black&#39;;"=
>ARRI</td></tr><tr style=3D"font-size:10.67px;color:#7F7F7F;"><td align=3D"=
left" style=3D"vertical-align:top;font-family:Arial;"><span style=3D"font-s=
ize:11px;">Arnold&nbsp;&amp;&nbsp;Richter&nbsp;Cine&nbsp;Technik&nbsp;GmbH&=
nbsp;&amp;&nbsp;Co.&nbsp;Betriebs&nbsp;KG</span>&nbsp;<br /></td></tr></tab=
le></td></tr><tr style=3D"font-size:0;"><td align=3D"left" style=3D"vertica=
l-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=
=3D"font-size:0;color:#7F7F7F;font-style:normal;font-weight:400;white-space=
:nowrap;"><tr style=3D"font-size:10.67px;"><td align=3D"left" style=3D"vert=
ical-align:top;font-family:Arial;">Arriweg&nbsp;17</td><td align=3D"left" s=
tyle=3D"vertical-align:top;font-family:Arial;">,&nbsp;<br /></td><td align=
=3D"left" style=3D"vertical-align:middle;font-family:Arial;">83071</td><td =
align=3D"left" style=3D"vertical-align:middle;font-family:Arial;">&nbsp;<br=
 /></td><td align=3D"left" style=3D"vertical-align:middle;font-family:Arial=
;">Stephanskirchen</td></tr></table></td></tr></table></td></tr><tr style=
=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><table c=
ellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;"><tr =
style=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><ta=
ble cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;c=
olor:#1532B9;font-style:normal;font-weight:400;white-space:nowrap;"><tr sty=
le=3D"font-size:11px;"><td align=3D"left" style=3D"vertical-align:top;font-=
family:Arial;"><span style=3D"text-decoration:underline;"><a href=3D"http:/=
/www.arri.com/" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-decorati=
on:underline;color:#1532B9;"><strong style=3D"font-weight:400;">www.arri.co=
m&nbsp;<br /><br /></strong></a></span></td></tr><tr style=3D"font-size:0;"=
><td align=3D"left" style=3D"vertical-align:top;"><table cellpadding=3D"0" =
cellspacing=3D"0" border=3D"0" style=3D"font-size:0;color:#858080;font-styl=
e:normal;font-weight:400;line-height:normal;white-space:nowrap;"><tr style=
=3D"font-size:14.67px;"><td align=3D"left" style=3D"padding:0;vertical-alig=
n:top;font-size:0;"><img src=3D"cid:image459447.png@56CFF471.4E3B7C8D" widt=
h=3D"20" border=3D"0" alt=3D"" style=3D"width:20px;min-width:20px;max-width=
:20px;font-size:0;" /></td><td align=3D"left" style=3D"padding:0;vertical-a=
lign:top;font-family:Calibri,Arial,sans-serif;"><a href=3D"tel:+49%208036%2=
03009-3118" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:n=
one;color:#858080;"><strong style=3D"font-weight:400;">+49&nbsp;8036&nbsp;3=
009-3118</strong></a></td></tr><tr style=3D"font-size:0;"><td align=3D"left=
" style=3D"padding:0;vertical-align:top;"></td><td align=3D"left" style=3D"=
padding:0;vertical-align:top;"></td></tr><tr style=3D"font-size:0;"><td ali=
gn=3D"left" style=3D"padding:0;vertical-align:top;"></td><td align=3D"left"=
 style=3D"padding:0;vertical-align:top;"></td></tr><tr style=3D"font-size:1=
4.67px;"><td align=3D"left" style=3D"padding:0;vertical-align:top;font-size=
:0;"><img src=3D"cid:image329235.png@0657ABE0.6C3A644E" width=3D"20" border=
=3D"0" alt=3D"" style=3D"width:20px;min-width:20px;max-width:20px;font-size=
:0;" /></td><td align=3D"left" style=3D"padding:0;vertical-align:top;font-f=
amily:Calibri,Arial,sans-serif;"><a href=3D"mailto:CEggers@arri.de" target=
=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:none;color:#858080;=
"><strong style=3D"font-weight:400;">CEggers@arri.de</strong></a></td></tr>=
</table></td></tr></table></td></tr></table></td></tr><tr style=3D"font-siz=
e:14.67px;color:#000001;font-style:normal;font-weight:400;white-space:nowra=
p;"><td align=3D"left" style=3D"vertical-align:top;font-family:Calibri,Aria=
l,sans-serif;"><br />&#8203;</td></tr></table></td></tr><tr style=3D"font-s=
ize:0;line-height:normal;"><td align=3D"left" style=3D"padding:0;vertical-a=
lign:top;"><a href=3D"https://www.arri.com/trinity2_artemis2" target=3D"_bl=
ank" id=3D"LPlnk689713" style=3D"text-decoration:none;"><img src=3D"https:/=
/assets.arri.com/media/sign/20220401_trinity2_artemis2_E-mail_Signature_650=
x95.jpg" border=3D"0" title=3D"One modular system, two new stabilizers: ART=
EMIS 2 &amp; TRINITY 2" alt=3D"One modular system, two new stabilizers: ART=
EMIS 2 &amp; TRINITY 2" style=3D"font-size:12px;" /></a></td></tr><tr style=
=3D"font-size:13px;color:#7F7F7F;font-style:normal;font-weight:400;white-sp=
ace:nowrap;"><td align=3D"left" style=3D"padding:0;vertical-align:top;font-=
family:Calibri,Arial,sans-serif;">Get&nbsp;all&nbsp;the&nbsp;latest&nbsp;in=
formation&nbsp;from&nbsp;<span style=3D"text-decoration:underline;"><a href=
=3D"https://www.arri.com/" target=3D"_blank" id=3D"LPlnk689713" style=3D"te=
xt-decoration:underline;color:#7F7F7F;"><strong style=3D"font-weight:400;">=
www.arri.com</strong></a></span>,&nbsp;<span style=3D"text-decoration:under=
line;"><a href=3D"https://www.facebook.com/TeamARRI" target=3D"_blank" id=
=3D"LPlnk689713" style=3D"text-decoration:underline;color:#7F7F7F;"><strong=
 style=3D"font-weight:400;">Facebook</strong></a></span>,&nbsp;<span style=
=3D"text-decoration:underline;"><a href=3D"https://twitter.com/ARRIChannel"=
 target=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:none;color:#=
7F7F7F;"><strong style=3D"font-weight:400;">Twitter</strong></a></span>,&nb=
sp;<a href=3D"https://www.instagram.com/arri/" target=3D"_blank" id=3D"LPln=
k689713" style=3D"text-decoration:none;color:#7F7F7F;"><strong style=3D"fon=
t-weight:400;"><span style=3D"text-decoration:underline;">Instagram</span><=
/strong></a>,&nbsp;<a href=3D"https://www.linkedin.com/company/arri" target=
=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:none;color:#7F7F7F;=
"><strong style=3D"font-weight:400;"><span style=3D"text-decoration:underli=
ne;">LinkedIn</span></strong></a>&nbsp;and&nbsp;<a href=3D"https://www.yout=
ube.com/user/ARRIChannel" target=3D"_blank" id=3D"LPlnk689713" style=3D"tex=
t-decoration:none;color:#7F7F7F;"><strong style=3D"font-weight:400;"><span =
style=3D"text-decoration:underline;">YouTube</span></strong></a>.<br /></td=
></tr><tr style=3D"font-size:0;"><td align=3D"left" style=3D"padding:0;vert=
ical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" st=
yle=3D"font-size:0;color:#6A6A6A;font-style:normal;font-weight:400;white-sp=
ace:nowrap;"><tr style=3D"font-size:10px;"><td align=3D"left" style=3D"vert=
ical-align:top;font-family:Arial;"><br />Arnold&nbsp;&amp;&nbsp;Richter&nbs=
p;Cine&nbsp;Technik&nbsp;GmbH&nbsp;&amp;&nbsp;Co.&nbsp;Betriebs&nbsp;KG<br =
/>Sitz:&nbsp;M&#252;nchen&nbsp;=E2=80=91&nbsp;Registergericht:&nbsp;Amtsger=
icht&nbsp;M&#252;nchen&nbsp;=E2=80=91&nbsp;Handelsregisternummer:&nbsp;HRA&=
nbsp;57918<br />Pers&#246;nlich&nbsp;haftender&nbsp;Gesellschafter:&nbsp;Ar=
nold&nbsp;&amp;&nbsp;Richter&nbsp;Cine&nbsp;Technik&nbsp;GmbH<br />Sitz:&nb=
sp;M&#252;nchen&nbsp;=E2=80=91&nbsp;Registergericht:&nbsp;Amtsgericht&nbsp;=
M&#252;nchen&nbsp;=E2=80=91&nbsp;Handelsregisternummer:&nbsp;HRB&nbsp;54477=
<br />Gesch&#228;ftsf&#252;hrer:&nbsp;Dr.&nbsp;Matthias&nbsp;Erb&nbsp;(Chai=
rman);&nbsp;Dr.&nbsp;Michael&nbsp;Neuh&#228;user;&nbsp;Stephan&nbsp;Schenk;=
&nbsp;Walter&nbsp;Trauninger<br /></td></tr><tr style=3D"font-size:14.67px;=
color:#000001;"><td align=3D"left" style=3D"vertical-align:top;font-family:=
Calibri,Arial,sans-serif;"><br />&#8203;<br /></td></tr></table></td></tr><=
/table></td></tr></table></div>From: bitbake-devel@lists.openembedded.org &=
lt;bitbake-devel@lists.openembedded.org&gt; On Behalf Of Christian Eggers<b=
r />&gt; Sent: den 8 april 2022 18:54<br />&gt; To: bitbake-devel@lists.ope=
nembedded.org; Christopher Larson &lt;kergoth@gmail.com&gt;<br />&gt; Subje=
ct: Re: [bitbake-devel] conditional inheriting classes does not work with b=
bappends<br />&gt; <br />&gt; On Thursday, 7 April 2022, 23:59:39 CEST, Chr=
istopher Larson wrote:<br />&gt; &gt; There=E2=80=99s no way to avoid that,=
 inherit lines are evaluated *at the moment of inherit* on that line, they =
aren=E2=80=99t postponed.<br />&gt; <br />&gt; ok, this is what I would exp=
ect. So how to handle this:<br />&gt; <br />&gt; - do not conditionally inh=
erit in PACKAGECONFIG (may be impossible)?<br />&gt; - do not set PACKAGECO=
NFIG in bbappend files (use distro/machine/layer/local config for this)?<br=
 />&gt; <br />&gt; regards<br />&gt; Christian<br />&gt; <br />&gt; <br />&=
gt; &gt;<br />&gt; &gt; --<br />&gt; &gt; Christopher Larson<br />&gt; &gt;=
 chris_larson@mentor.com&lt;mailto:chris_larson@mentor.com&gt;, chris.larso=
n@siemens.com&lt;mailto:chris.larson@siemens.com&gt;, kergoth@gmail.com&lt;=
mailto:kergoth@gmail.com&gt;<br />&gt; &gt; Principal Software Engineer, Em=
bedded Linux Solutions, Siemens Digital Industries Software<br />&gt; _____=
__________________________________________________=E2=80=8B<br />&gt; <br /=
>&gt; <br />&gt; <br />&gt; =E2=80=8B<br />&gt; <br />&gt; <br />&gt; <br /=
>&gt; &gt; On Apr 7, 2022, 7:17 AM -0700, Christian Eggers &lt;ceggers@arri=
=2Ede&lt;mailto:ceggers@arri.de&gt;&gt;, wrote:<br />&gt; &gt; &gt; Example=
: meta-openembedded/meta-networking/recipes-support/chrony/chrony_4.2.bb<br=
 />&gt; &gt; &gt;<br />&gt; &gt; &gt; --------------------------------8&lt;=
--------------------------------<br />&gt; &gt; &gt; # Add chronyd user if =
privdrop packageconfig is selected<br />&gt; &gt; &gt; inherit ${@bb.utils.=
contains(&#39;PACKAGECONFIG&lt;mailto:$%7b@bb.utils.contains(&#39;PACKAGECO=
NFIG&gt;&#39;, &#39;privdrop&#39;, &#39;useradd&#39;, &#39;&#39;, d)}<br />=
&gt; &gt; &gt; USERADD_PACKAGES =3D &quot;${@bb.utils.contains(&#39;PACKAGE=
CONFIG&#39;, &#39;privdrop&#39;, &#39;${PN}&#39;, &#39;&#39;, d)}&lt;mailto=
:$%7b@bb.utils.contains(&#39;PACKAGECONFIG&#39;,%20&#39;privdrop&#39;,%20&#=
39;$%7bPN%7d&#39;,%20&#39;&#39;,%20d)%7d&gt;&quot;<br />&gt; &gt; &gt; USER=
ADD_PARAM:${PN} +=3D &quot;${@bb.utils.contains(&#39;PACKAGECONFIG&#39;, &#=
39;privdrop&#39;, &#39;--system -d / -M --shell /bin/nologin chronyd;&#39;,=
 &#39;&#39;, d)}&lt;mailto:$%7b@bb.utils.contains(&#39;PACKAGECONFIG&#39;,%=
20&#39;privdrop&#39;,%20&#39;--system%20-d%20/%20-M%20--shell%20/bin/nologi=
n%20chronyd;&#39;,%20&#39;&#39;,%20d)%7d&gt;&quot;<br />&gt; &gt; &gt;<br /=
>&gt; &gt; &gt; ...<br />&gt; &gt; &gt;<br />&gt; &gt; &gt; PACKAGECONFIG ?=
?=3D ...<br />&gt; &gt; &gt; --------------------------------&gt;8---------=
-----------------------<br />&gt; &gt; &gt;<br />&gt; &gt; &gt;<br />&gt; &=
gt; &gt; Problem #1: useradd is not inherited because PACKAGECONFIG is set =
below the conditional &quot;inherit&quot;<br />&gt; &gt; &gt; statement. Ev=
en when I add &quot;privdrop&quot; to PACKAGECONFIG here, useradd.bbclass i=
s not inherited. I<br />&gt; &gt; &gt; must move the PACKAGECONFIG line abo=
ve the inherit statement to make this work.<br />&gt; &gt; &gt;<br />&gt; &=
gt; &gt; Problem #2: Due to problem #1, useradd.bbclass is also not inherit=
ed when I add &quot;privdrop&quot; to<br />&gt; &gt; &gt; PACKAGECONFIG in =
bbappend file (in a custom layer).<br />&gt; &gt; &gt;<br />&gt; &gt; &gt; =
regards<br />&gt; &gt; &gt; Christian<br />&gt; <br />&gt; <br />&gt; <br /=
><br /><br /><br /><br /></div></body></html>
------_=_NextPart_304c9149-ac75-4cf2-b8ad-fee3330a43c7--

------_=_NextPart_1c6a01c1-4c32-4e84-bf6a-a65d177b22ab
Content-Type: image/png;
	name="image459447.png"
Content-Transfer-Encoding: base64
Content-ID: <image459447.png@56CFF471.4E3B7C8D>
Content-Description: image459447.png
Content-Disposition: inline;
	creation-date="Wed, 13 Apr 2022 06:03:28 +0000";
	filename=image459447.png;
	modification-date="Wed, 13 Apr 2022 06:03:28 +0000";
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

------_=_NextPart_1c6a01c1-4c32-4e84-bf6a-a65d177b22ab
Content-Type: image/png;
	name="image329235.png"
Content-Transfer-Encoding: base64
Content-ID: <image329235.png@0657ABE0.6C3A644E>
Content-Description: image329235.png
Content-Disposition: inline;
	creation-date="Wed, 13 Apr 2022 06:03:28 +0000";
	filename=image329235.png;
	modification-date="Wed, 13 Apr 2022 06:03:28 +0000";
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

------_=_NextPart_1c6a01c1-4c32-4e84-bf6a-a65d177b22ab--

