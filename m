Return-Path: <ceggers@arri.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B823C38A05
	for <webhook@archiver.kernel.org>; Fri,  8 Apr 2022 17:09:36 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.138])
 by mx.groups.io with SMTP id smtpd.web12.8572.1649436864316778793
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 08 Apr 2022 09:54:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arrigroup.onmicrosoft.com
 header.s=selector1-arrigroup-onmicrosoft-com header.b=wl6KVnpB;
 spf=pass (domain: arri.de, ip: 40.107.20.138, mailfrom: ceggers@arri.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbgkbSYxq8MbyBdel6TtASlS/MDQHdTI18bArsBokxwQQ68DULnY2HgbTdeFFt34HWrxAS0VbBO8JiGaEJsOWfwA6WbYNN7eY3jd05gHsgzMX8ndA0VUf9NdkKNcBP+yzfvkdkv5HE0ZVJ8VUqwTCB7Q8K6e5c7wRA8alH9aXLR7ElweEB0uM9Atp9TEqvz7MdeG0pGyiKYUV3pvjG5wLUSNL3Qomo0m/IPltS9N6adetg6SL/aDYQkKjnGDiSWiW3VAbE9XXrWjdH+ejqVmUGbMOskwakDqIfbTniFtsjRHXwGd2yvPJC6aZMhQGujPTLZ/bvMwZ/UZ7uA3wrArFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnm+MBoImg0sianDhaR9Ats8zraHVIqEJbhBMg7tMBg=;
 b=cyUcGLRFxYpLlPhCVvOI3mpfzO3tZ8z2fOhg522aLwBkKHVVioOVv5fVe8dWz5ey+d/0QpxSMCIN8enRzJoBxeEkDKut23jv87aEGqQJ9WbgOrjXQgQPeB0+ehA3ya94pCFi2mEmlMvutXlOZCWfxKvVBUlX0wfMPDwklne8mbgWoe0Tf66nBz62W/qVnYuUZ7+xH/BA9MAahSP7zadMsAHZ0Dgvk0+YxLmOCnV1wE7WYWuo5aWSn5t2BJlayGCmhm2/qElENYgiO/szG01xM64f3/XMVa3xkp8NHIp681sGPG970cj0/YYw2bTDWe/8Sckj1os/JfNpvAa2Qxa8EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 52.169.0.179) smtp.rcpttodomain=lists.openembedded.org smtp.mailfrom=arri.de;
 dmarc=bestguesspass action=none header.from=arri.de; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnm+MBoImg0sianDhaR9Ats8zraHVIqEJbhBMg7tMBg=;
 b=wl6KVnpBIbVwfbTzkjPN5f8WF2+sPxfJNCT4KPbpt9RULroHWFxDFmj+/UCsaIvlod/SsSyzB+z7fAbr2nHLU1ZgzyocpUKkuTz5sKya8frRRZobyVDiIAA3YHCeU0oqYs3Byhpz7v2qKZ7ocI0UOArBvqOYvKxLbsaOn/Dc/Us=
Received: from AM5PR0701CA0066.eurprd07.prod.outlook.com (2603:10a6:203:2::28)
 by HE1PR07MB3210.eurprd07.prod.outlook.com (2603:10a6:7:2c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.8; Fri, 8 Apr
 2022 16:54:19 +0000
Received: from VE1EUR02FT083.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:203:2:cafe::d6) by AM5PR0701CA0066.outlook.office365.com
 (2603:10a6:203:2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.8 via Frontend
 Transport; Fri, 8 Apr 2022 16:54:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.169.0.179)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=arri.de;
Received-SPF: Pass (protection.outlook.com: domain of arri.de designates
 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net;
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 VE1EUR02FT083.mail.protection.outlook.com (10.152.13.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 16:54:18 +0000
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (104.47.8.52) by
	 eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
	 ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
	 tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Fri, 8 Apr 2022 16:54:18 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 9493096
X-ExclaimerImprintLatency: 2166822
X-ExclaimerImprintAction: f6e84f110df34024ac2ed6512f364613
Content-Type: multipart/related;
	boundary="----_=_NextPart_f6873a77-2e8b-4639-8ef4-a93f05e17c5e"
Received: from AS9PR0301CA0038.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::9) by DB6PR0701MB2887.eurprd07.prod.outlook.com
 (2603:10a6:4:72::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.8; Fri, 8 Apr
 2022 16:54:16 +0000
Received: from AM5EUR02FT095.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:469:cafe::9f) by AS9PR0301CA0038.outlook.office365.com
 (2603:10a6:20b:469::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.25 via Frontend
 Transport; Fri, 8 Apr 2022 16:54:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM5EUR02FT095.mail.protection.outlook.com (10.152.9.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Fri, 8 Apr 2022 16:54:16 +0000
Received: from localhost.localdomain (192.168.55.135) by mta.arri.de
 (10.10.18.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 8 Apr
 2022 18:54:15 +0200
From: Christian Eggers <ceggers@arri.de>
To: <bitbake-devel@lists.openembedded.org>, Christopher Larson
	<kergoth@gmail.com>
Subject: Re: [bitbake-devel] conditional inheriting classes does not work with
 bbappends
Date: Fri, 8 Apr 2022 18:54:15 +0200
Message-ID: <3188702.aeNJFYEL58@localhost.localdomain>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <9b705184-11b1-48fa-98b5-814a754b1b5b@Spark>
References: <1839335.tdWV9SEqCh@localhost.localdomain>
 <9b705184-11b1-48fa-98b5-814a754b1b5b@Spark>
MIME-Version: 1.0
X-Originating-IP: [192.168.55.135]
X-EOPAttributedMessage: 1
X-MS-Office365-Filtering-Correlation-Id: 3113da9a-cd12-4cef-dfbe-08da19806c39
X-MS-TrafficTypeDiagnostic: 
	DB6PR0701MB2887:EE_|VE1EUR02FT083:EE_|HE1PR07MB3210:EE_
X-Microsoft-Antispam-PRVS: 
	<HE1PR07MB32100895866CD3ED4AE8D8C0BFE99@HE1PR07MB3210.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 zAL+GcJPPGID0CY1pnf3Wy54ulnrGp+L3Jt4SrJq3AHNvQBjvmEQX7fji7palGUPDGWKDHaE3UWOsRV0u8ei34u86uyMaJjUrTU+HqeHtwRfB8xTQtnns5BCg6VVcZpuEHdNczkv5UAFZ0DbptrxXy8dViLv1s7ggrSpJhFZCnj/JDsGmfLNWFnsMC1CAEL+28eUyT6iUxyKF+hMGjlwvWZrUpIax0FZJI0Jp2QLXbTHrRRrjDxr6QzpJzWup1bMwkFo/No1sY4UOdmlUr4FhkQOe6guyFOV+Pom+gbFfaxTwGUMVxY6nl2lRrEXhPgBEcRZ1yHm1nFI1cx7C9Um5fJZ0TPX/mbx3b0T2+oJShTsR9/I0BIGysO8gpWBjEly2ZzkxJzwQGZZ2xyBe3b4EY2tIqcz6a7qvcHTYdDbF57myg1xZKzzlhXj87qAbmpiuIhShy7dYaDvR05CXnKPAk+5ju1ke83ays9TgXvF1cWD4p0Zm8QjbuCKCn8IYR3TsjSOTw05DQON9Ixs3kcFlgXdiNSwsxuGB9gJThBL81/2FCbcjqwJSUOqVjV1aCwAQZG/G68NknQEt0ziPcwL7SgdwC9YUd2DSr/knGyUU8H6jrRUQADbZsSPHI1tOljNt7oY/5C9ddGOuBkFcEvh1vB7b9Z3xvhkaXKc+2Oo9IlsiNcnzCZ3aZRmajZcfu7XEH1Va+yOn/k3crz6AdMUHwikK71njp4YQHqbwPHWA4g=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(336012)(426003)(7696005)(47076005)(356005)(508600001)(81166007)(55016003)(8936002)(316002)(53546011)(86362001)(2906002)(110136005)(82310400005)(36860700001)(36916002)(9686003)(8676002)(16526019)(186003)(5660300002)(26005)(70586007)(83380400001)(70206006)(36900700001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0701MB2887
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 VE1EUR02FT083.eop-EUR02.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	4583d894-476c-4ed7-12a0-08da19806abe
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oGu/41tR00JJ1/ajK4IikJwVBj44680FDPngkWk/fqHSwxAQtPlP9ctB/fP/5x8jyAfI9JtbEAn+aT5YBESoPeIDEtKMvvwcJS0jgZ+V+dSmHXSAxSnNByA6/SlF3DRVeQ9Dp2FkQWwCc4I4+O6LfhbHsg+VxIclOR49VNOmB6wbSK5PIhLoNSJmvmu4c5C6zCQ96RuVLeUrmEmcIsUJ50vlFLTc0SLx085fUFCJ2OmuOLtQh+6w17nj/c8fGk/o0iGMgH+Iu9ziu+A9C4Kkr6F1Gw1bVxEOpTf99x9Y+5Vq6CftMhzBN6D9vplrQFKNdZt2IgEIC9xvl5pMfihv3wIfuwP0KkvB/mmALyNyTw4q+uU/Ll59fRGV8KM85X4LIb63TdGZqz5rki+FRx9BGk5F9EfdPGrgmDRWbW2O3GBIV/VI8bpDv4u+uY9EXjylnteC0rlSzh2wBqLShLHJQFOa2dGJ0OQJCJnvZ5w4N6TBPOqyVD5oZ8wUDfl8+9BdINzffdzy4t2C54Dgy4JzKrwhUrj2vM6hGIpJMnF2ZdUymBZAa1ubNjnzQFoOTpBwWQQWFIiGUi61zJ/GfeyXfK6BtWdG4L9Uey6gc0gsR1kByQP8ZSza0oaCmGlF3LUNqxRn+TMkgsYiXKa5QwX5ZOum03dragTladH+7mV5XltyLMNNSGQfYvf0jUuKFu6ON8xnthuQDKWhlnXFGBl7WRWgroV6NoIM1OqBQLwqWdvxzhaGhR11oTQmxExq5yw/TYeB8xuL15XCPFV7r8HeqYPhFUNAneulOgG9M+IKnBM=
X-Forefront-Antispam-Report: 
	CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(55016003)(45080400002)(33964004)(2906002)(316002)(508600001)(166002)(110136005)(8676002)(70206006)(70586007)(86362001)(7596003)(7636003)(15974865002)(40460700003)(26005)(83380400001)(336012)(8936002)(7696005)(426003)(66574015)(186003)(47076005)(53546011)(82310400005)(36916002)(16526019)(36860700001)(9686003)(5660300002);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 16:54:18.4219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 3113da9a-cd12-4cef-dfbe-08da19806c39
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR02FT083.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB3210
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 08 Apr 2022 17:09:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13598

This is a multi-part message in MIME format.

------_=_NextPart_f6873a77-2e8b-4639-8ef4-a93f05e17c5e
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_c50730d9-15b2-477c-9553-6947c2c70f22"

------_=_NextPart_c50730d9-15b2-477c-9553-6947c2c70f22
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Thursday, 7 April 2022, 23:59:39 CEST, Christopher Larson wrote:
> There=E2=80=99s no way to avoid that, inherit lines are evaluated *at the=
 moment of inherit* on that line, they aren=E2=80=99t postponed.

ok, this is what I would expect. So how to handle this:

- do not conditionally inherit in PACKAGECONFIG (may be impossible)?
- do not set PACKAGECONFIG in bbappend files (use distro/machine/layer/loca=
l config for this)?

regards
Christian


> 
> --
> Christopher Larson
> chris_larson@mentor.com, chris.larson@siemens.com, kergoth@gmail.com
> Principal Software Engineer, Embedded Linux Solutions, Siemens Digital In=
dustries Software

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
> On Apr 7, 2022, 7:17 AM -0700, Christian Eggers <ceggers@arri.de>, wrote:
> > Example: meta-openembedded/meta-networking/recipes-support/chrony/chron=
y_4.2.bb
> >
> > --------------------------------8<--------------------------------
> > # Add chronyd user if privdrop packageconfig is selected
> > inherit ${@bb.utils.contains('PACKAGECONFIG', 'privdrop', 'useradd', ''=
, d)}
> > USERADD_PACKAGES =3D "${@bb.utils.contains('PACKAGECONFIG', 'privdrop',=
 '${PN}', '', d)}"
> > USERADD_PARAM:${PN} +=3D "${@bb.utils.contains('PACKAGECONFIG', 'privdr=
op', '--system -d / -M --shell /bin/nologin chronyd;', '', d)}"
> >
> > ...
> >
> > PACKAGECONFIG ??=3D ...
> > -------------------------------->8--------------------------------
> >
> >
> > Problem #1: useradd is not inherited because PACKAGECONFIG is set below=
 the conditional "inherit"
> > statement. Even when I add "privdrop" to PACKAGECONFIG here, useradd.bb=
class is not inherited. I
> > must move the PACKAGECONFIG line above the inherit statement to make th=
is work.
> >
> > Problem #2: Due to problem #1, useradd.bbclass is also not inherited wh=
en I add "privdrop" to
> > PACKAGECONFIG in bbappend file (in a custom layer).
> >
> > regards
> > Christian




------_=_NextPart_c50730d9-15b2-477c-9553-6947c2c70f22
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8" /></head><body><div>On Thursday, 7 April 2022, 23:59:39 CEST, Chr=
istopher Larson wrote:<br />&gt; There=E2=80=99s no way to avoid that, inhe=
rit lines are evaluated *at the moment of inherit* on that line, they aren=
=E2=80=99t postponed.<br /><br />ok, this is what I would expect. So how to=
 handle this:<br /><br />- do not conditionally inherit in PACKAGECONFIG (m=
ay be impossible)?<br />- do not set PACKAGECONFIG in bbappend files (use d=
istro/machine/layer/local config for this)?<br /><br />regards<br />Christi=
an<br /><br /><br />&gt; <br />&gt; --<br />&gt; Christopher Larson<br />&g=
t; chris_larson@mentor.com, chris.larson@siemens.com, kergoth@gmail.com<br =
/>&gt; Principal Software Engineer, Embedded Linux Solutions, Siemens Digit=
al Industries Software<br /><div dir=3D"ltr" style=3D"mso-line-height-rule:=
exactly;-webkit-text-size-adjust:100%;direction:ltr;"><table cellpadding=
=3D"0" cellspacing=3D"0" border=3D"0" style=3D"width:100%;"><tr style=3D"fo=
nt-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><table cellpad=
ding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;"><tr style=
=3D"font-size:0;"><td align=3D"left" style=3D"padding:0;vertical-align:top;=
"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"width:10=
0%;font-size:0;"><tr style=3D"font-size:14.67px;color:#7F7F7F;font-style:no=
rmal;font-weight:400;white-space:nowrap;"><td align=3D"left" style=3D"verti=
cal-align:top;font-family:Calibri,Arial,sans-serif;">______________________=
_________________________________<span style=3D"font-family:remialcxesans;f=
ont-size:1px;color:#FFFFFF;line-height:1px;">&#8203;</span></td></tr><tr st=
yle=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><tabl=
e cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;"><=
tr style=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:top;">=
<table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:=
0;color:#7F7F7F;font-style:normal;font-weight:400;white-space:nowrap;"><tr =
style=3D"font-size:14.67px;"><td align=3D"left" style=3D"vertical-align:top=
;font-family:Calibri,Arial,sans-serif;">Christian</td><td align=3D"left" st=
yle=3D"vertical-align:top;color:#000001;font-family:Calibri,Arial,sans-seri=
f;">&nbsp;<br /></td><td align=3D"left" style=3D"vertical-align:top;font-fa=
mily:Calibri,Arial,sans-serif;">Eggers</td></tr></table></td></tr><tr style=
=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><table c=
ellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;color:=
#7F7F7F;font-style:normal;font-weight:400;white-space:nowrap;"><tr style=
=3D"font-size:14.67px;"><td align=3D"left" style=3D"vertical-align:top;font=
-family:Calibri,Arial,sans-serif;">Software&nbsp;Engineer</td></tr><tr styl=
e=3D"font-size:14.67px;color:#000001;"><td align=3D"left" style=3D"vertical=
-align:top;font-family:Calibri,Arial,sans-serif;">&#8203;</td></tr></table>=
</td></tr></table></td></tr><tr style=3D"font-size:0;"><td align=3D"left" s=
tyle=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" bor=
der=3D"0" style=3D"font-size:0;"><tr style=3D"font-size:0;"><td align=3D"le=
ft" style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0=
" border=3D"0" style=3D"font-size:0;color:#0E50AD;font-style:normal;font-we=
ight:400;white-space:nowrap;"><tr style=3D"font-size:13.33px;"><td align=
=3D"left" style=3D"vertical-align:top;font-family:&#39;Arial Black&#39;;">A=
RRI</td></tr><tr style=3D"font-size:10.67px;color:#7F7F7F;"><td align=3D"le=
ft" style=3D"vertical-align:top;font-family:Arial;"><span style=3D"font-siz=
e:11px;">Arnold&nbsp;&amp;&nbsp;Richter&nbsp;Cine&nbsp;Technik&nbsp;GmbH&nb=
sp;&amp;&nbsp;Co.&nbsp;Betriebs&nbsp;KG</span>&nbsp;<br /></td></tr></table=
></td></tr><tr style=3D"font-size:0;"><td align=3D"left" style=3D"vertical-=
align:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=
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
n:top;font-size:0;"><img src=3D"cid:image232494.png@6C91971A.9CB36BD3" widt=
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
:0;"><img src=3D"cid:image127421.png@B963EC3E.6171FBB5" width=3D"20" border=
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
/table></td></tr></table></div>&gt; On Apr 7, 2022, 7:17 AM -0700, Christia=
n Eggers &lt;ceggers@arri.de&gt;, wrote:<br />&gt; &gt; Example: meta-opene=
mbedded/meta-networking/recipes-support/chrony/chrony_4.2.bb<br />&gt; &gt;=
<br />&gt; &gt; --------------------------------8&lt;----------------------=
----------<br />&gt; &gt; # Add chronyd user if privdrop packageconfig is s=
elected<br />&gt; &gt; inherit ${@bb.utils.contains(&#39;PACKAGECONFIG&#39;=
, &#39;privdrop&#39;, &#39;useradd&#39;, &#39;&#39;, d)}<br />&gt; &gt; USE=
RADD_PACKAGES =3D &quot;${@bb.utils.contains(&#39;PACKAGECONFIG&#39;, &#39;=
privdrop&#39;, &#39;${PN}&#39;, &#39;&#39;, d)}&quot;<br />&gt; &gt; USERAD=
D_PARAM:${PN} +=3D &quot;${@bb.utils.contains(&#39;PACKAGECONFIG&#39;, &#39=
;privdrop&#39;, &#39;--system -d / -M --shell /bin/nologin chronyd;&#39;, &=
#39;&#39;, d)}&quot;<br />&gt; &gt;<br />&gt; &gt; ...<br />&gt; &gt;<br />=
&gt; &gt; PACKAGECONFIG ??=3D ...<br />&gt; &gt; --------------------------=
------&gt;8--------------------------------<br />&gt; &gt;<br />&gt; &gt;<b=
r />&gt; &gt; Problem #1: useradd is not inherited because PACKAGECONFIG is=
 set below the conditional &quot;inherit&quot;<br />&gt; &gt; statement. Ev=
en when I add &quot;privdrop&quot; to PACKAGECONFIG here, useradd.bbclass i=
s not inherited. I<br />&gt; &gt; must move the PACKAGECONFIG line above th=
e inherit statement to make this work.<br />&gt; &gt;<br />&gt; &gt; Proble=
m #2: Due to problem #1, useradd.bbclass is also not inherited when I add &=
quot;privdrop&quot; to<br />&gt; &gt; PACKAGECONFIG in bbappend file (in a =
custom layer).<br />&gt; &gt;<br />&gt; &gt; regards<br />&gt; &gt; Christi=
an<br /><br /><br /><br /></div></body></html>
------_=_NextPart_c50730d9-15b2-477c-9553-6947c2c70f22--

------_=_NextPart_f6873a77-2e8b-4639-8ef4-a93f05e17c5e
Content-Type: image/png;
	name="image232494.png"
Content-Transfer-Encoding: base64
Content-ID: <image232494.png@6C91971A.9CB36BD3>
Content-Description: image232494.png
Content-Disposition: inline;
	creation-date="Fri, 08 Apr 2022 16:54:18 +0000";
	filename=image232494.png;
	modification-date="Fri, 08 Apr 2022 16:54:18 +0000";
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

------_=_NextPart_f6873a77-2e8b-4639-8ef4-a93f05e17c5e
Content-Type: image/png;
	name="image127421.png"
Content-Transfer-Encoding: base64
Content-ID: <image127421.png@B963EC3E.6171FBB5>
Content-Description: image127421.png
Content-Disposition: inline;
	creation-date="Fri, 08 Apr 2022 16:54:18 +0000";
	filename=image127421.png;
	modification-date="Fri, 08 Apr 2022 16:54:18 +0000";
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

------_=_NextPart_f6873a77-2e8b-4639-8ef4-a93f05e17c5e--

