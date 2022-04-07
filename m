Return-Path: <ceggers@arri.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDFEC38A04
	for <webhook@archiver.kernel.org>; Thu,  7 Apr 2022 15:41:15 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.121])
 by mx.groups.io with SMTP id smtpd.web11.7327.1649341030881026011
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Apr 2022 07:17:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arrigroup.onmicrosoft.com
 header.s=selector1-arrigroup-onmicrosoft-com header.b=u843p9FY;
 spf=pass (domain: arri.de, ip: 40.107.6.121, mailfrom: ceggers@arri.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmyJjC2/vOM49c415NpboWmsUtUQhbdypwkuodNBFNA8Wjjv/0TRYtTo6tDoADF+823hP3PiCgYsNhgU9mHaQlW5UdCUYsg90cw17x4i5HygHNFALeLzO2kTPcCSECCVhUhPnA8zCXsSITpCZ/8pgHdsh89b2rEEL6chK3zn2hWLauFQ6iCO7ZvbZQF5fnHiI1R0wmXTknhSpfemWab6LHXjJ+lt50E653GloyAVZkesffjIODcgZ7CGDlPtW6OSINmeLBH6Yu+57A3TdmGJzaSARFb2exPSsIUhzEWszmxqvzjnzs+0zUrsCeTjM4wp0d1l8zrbU3Y7cByNbRh5BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6zlhA7o2iXFYJlBIf5Zoj1mikzgnfuX4DKpEcmOEww=;
 b=X8Uro+Kf8kYIc1npCYwDtla5tSBPyaFx3IE2tU2XsdJxt/FhWZ49iFVGVNLr+gD4eksaTaQjN/VJlW0PSDC2jUWVoIAbiiLQFfCAUKK4t+qAdnchPDxf2xM/Rd9r7xI/PoJ5uOAwNiGQ0M5U+CaxP3DCFQw6QhB9a131VTtgQk86E8HJUv/r1E5xP5s/3gJUDQ0nJZMBn4xymIW9UUSwhqVu6Nt+mJBjOK260+3niyZpyTDK04kYKAZMJnl6Y1ZXCt+uEhJKzTw7PLnoV7FxPTRLSup/4Ekx5Fv+Ne+62E1/FRgrXGY87ZNAGsF/p+F08n9ixB2Yt/4DqhHnkocc/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 104.40.229.156) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=arri.de; dmarc=bestguesspass action=none header.from=arri.de;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6zlhA7o2iXFYJlBIf5Zoj1mikzgnfuX4DKpEcmOEww=;
 b=u843p9FY2/L/vp+UqGCe/QHS+/AR72hguBbKzxo2EW8h0RUCxbBpw6VQdvw7FkTMVYy1KTfQyI9cDaKx+1ZOUBimX+j9ApL8+mvYIramKRPFUeshLZbN/zhXpRZa79Xsajdr9LivLR0+J288gWtQfgsu5Rq9JS3XoEZJtf49hhc=
Received: from AM5PR0101CA0019.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::32) by AM0PR07MB4018.eurprd07.prod.outlook.com
 (2603:10a6:208:48::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.8; Thu, 7 Apr
 2022 14:17:07 +0000
Received: from AM5EUR02FT054.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:206:16:cafe::f7) by AM5PR0101CA0019.outlook.office365.com
 (2603:10a6:206:16::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22 via Frontend
 Transport; Thu, 7 Apr 2022 14:17:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 104.40.229.156)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=arri.de;
Received-SPF: Pass (protection.outlook.com: domain of arri.de designates
 104.40.229.156 as permitted sender) receiver=protection.outlook.com;
 client-ip=104.40.229.156; helo=eu1.smtp.exclaimer.net;
Received: from eu1.smtp.exclaimer.net (104.40.229.156) by
 AM5EUR02FT054.mail.protection.outlook.com (10.152.8.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Thu, 7 Apr 2022 14:17:06 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (104.47.17.173)
	 by eu1.smtp.exclaimer.net (104.40.229.156) with Exclaimer Signature Manager
	 ESMTP Proxy eu1.smtp.exclaimer.net (tlsversion=TLS12,
	 tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Thu, 7 Apr 2022 14:17:07 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 7653937
X-ExclaimerImprintLatency: 3646468
X-ExclaimerImprintAction: fd64756116734bc194ad7d2d89599d1d
Content-Type: multipart/related;
	boundary="----_=_NextPart_ef33fcb1-8d01-4b38-862d-e74034112f4b"
Received: from AM6P194CA0067.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::44)
 by AM0PR07MB4705.eurprd07.prod.outlook.com (2603:10a6:208:78::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.7; Thu, 7 Apr
 2022 14:17:04 +0000
Received: from VE1EUR02FT004.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:84:cafe::aa) by AM6P194CA0067.outlook.office365.com
 (2603:10a6:209:84::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22 via Frontend
 Transport; Thu, 7 Apr 2022 14:17:03 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 VE1EUR02FT004.mail.protection.outlook.com (10.152.12.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Thu, 7 Apr 2022 14:17:03 +0000
Received: from localhost.localdomain (192.168.55.136) by mta.arri.de
 (10.10.18.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Apr
 2022 16:17:03 +0200
From: Christian Eggers <ceggers@arri.de>
To: <bitbake-devel@lists.openembedded.org>
Subject: conditional inheriting classes does not work with bbappends
Date: Thu, 7 Apr 2022 16:17:02 +0200
Message-ID: <1839335.tdWV9SEqCh@localhost.localdomain>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
MIME-Version: 1.0
X-Originating-IP: [192.168.55.136]
X-EOPAttributedMessage: 1
X-MS-Office365-Filtering-Correlation-Id: fd5e3618-8393-4297-6810-08da18a14c01
X-MS-TrafficTypeDiagnostic: 
	AM0PR07MB4705:EE_|AM5EUR02FT054:EE_|AM0PR07MB4018:EE_
X-Microsoft-Antispam-PRVS: 
	<AM0PR07MB4018906C2ED7AD6FA1E11815BFE69@AM0PR07MB4018.eurprd07.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 oSSFfdOlyRfzF8tWoiEHNt1Lt6KHW8HSZucqHNGLXVvm7/M4PnbWLxgZ6rSExTx0oeZtacFKGYqOE8s13EFBaPQbidw8rUoampXb3tDdDiPfEBU/lZNXwP1P9kCzo5XajNtOo9hyFWZnjVb0T3VhTlCLCKmatVaP5VtEj2a8liiXDIQv1dMKxfACLyAg2qM9yiwHA+Kkhp0za7niEjX3E/ffedIHExGGfRl2A+fokBhgHrOZp5DBtwq2uA4zny+CBG4mzAzEbQn98wWfkUPYGb3Ry0wixf/5RSE2i0DW70aHjU5laa+OzHZRNcJESMq4vhzK3H48RrSlvmniZ0r81aTV8AHjP6G7P++9r3y1X6XL82GFWM6evSfalMAzqCJojOzUFuQNAm4kAdlzEaYDbLm8Et3kceKZFIuH2F9X/MAbF4wysPFtY5JMlNt7VD7xgz9hFTjpUXdPYG0nJI/rDAGjC1gMzG78iKm2eZqbAN4/LWI4ZSs3+nBB9+chIX4Xzia/AnItWmG/NRaF7dzjouSVMkQVNHHkS75d4gCejv1/AZnVjkKnedqZT6ihP3+tOwgUEauEzYm69hO+gWFCF0HD+mcTPW01f02fbYAt0Qd5cdEUig/CxG3P34DWbKRiXsXkeEdy6iLsakd6ILljDu/Xc8ieERYKfMrGsq32dSM0Fw3B5NLDIe/wBkqMm1IKIlz1ytycOu/EwrJVCpSmtJlrF6kxBYhP0DMkM2ZwGLoF4H+IxdHboYbu6nV1t92ysU/SrjTDh8DdUCVnkyMaxqyCE+RlPbnpGWv1676vulA=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(508600001)(8936002)(40460700003)(81166007)(36860700001)(5660300002)(86362001)(2906002)(8676002)(16526019)(316002)(82310400005)(70206006)(55016003)(186003)(26005)(336012)(47076005)(426003)(83380400001)(36916002)(356005)(70586007)(9686003)(7696005)(6916009)(39026012)(36900700001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB4705
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM5EUR02FT054.eop-EUR02.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	effd67d5-adc6-4b70-3133-08da18a14a06
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	haOwpOWmDeVUUmi95v836Lm/et8YSnMvMb2wMQ8nwXpvQdjXneXoeSY0JjjQ6mePFNL9DnQ2+609+0vAHa4kxTiwnTjrltVIn0YvyzYAXz18eUS7Zbg2iTEFt6J5jGvbc43NdUtf1cjbc/el8pKy3AmhFHvVsB/BrV4RKDB6E3yL6YBu1XhEe+nUZGhWRohgXuKAhYaTJ0Z10cG6LlwTTphMq5+xUU0bjrHJO8kJTsK0eAQuGLzZFndqkRMUfMxomE3Ut5Q90YPaqOND+ddA5IV637dvnYFb3Xs2CnPJWNKzDeRUlUzN0+XpY99FxG+ZKaKtQTnfP506HstPgQCHq6FfEwaWmBalUjWVtGVxT4Xq9ds3RvPcgUjEiBkKJWvJX94VgkOLdqGxTvo78pm+tyQzIPTpq9t/TXurOEUPu7EMr9OHXM3Bd/fWOEbx3QmmIPuMuxlA/QzX+vlLNlAencaEQcMJu90n9B/WzUGSi0LoR9XIcgYoLzimVdO3c3ClFNRmmBs/MfatdlZ8mz+PKULkzmXwyUcUCYlDHpjBhRBb8HhUsn545SDxo56842QkuyJEo7bXGoo09T0lwTL7fyq1+rcp63zx8y/kYzwz1DJ6Rk9iuvqXdmcVRvuxD5RwFZAAxSFl7yhBeh7T80YLxkIWLqwPgk9JGtAl0z4KxAu/1rHsiFX0o5MVAF75jZKg0hdWGCLA6ycw7bxlIEZ7dfvC46zGVczACwrquC274R4Erg8VArKcYjTp4Io62KBdK+UJA0Ho8V/kgl5WQ/MSxGTZHbX44Fk25w+O0CHNnznljnx6JNAtjHmjnCJq5xt63jQZupFC1vxk5L9AKOku2Q==
X-Forefront-Antispam-Report: 
	CIP:104.40.229.156;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu1.smtp.exclaimer.net;PTR:eu1.smtp.exclaimer.net;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8936002)(15974865002)(86362001)(36916002)(45080400002)(508600001)(5660300002)(2906002)(166002)(7596003)(426003)(336012)(40460700003)(83380400001)(6916009)(55016003)(7636003)(82310400005)(9686003)(16526019)(26005)(316002)(186003)(47076005)(7696005)(33964004)(8676002)(70206006)(36860700001)(70586007)(39026012);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 14:17:06.5766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 fd5e3618-8393-4297-6810-08da18a14c01
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[104.40.229.156];Helo=[eu1.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM5EUR02FT054.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB4018
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Apr 2022 15:41:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13594

This is a multi-part message in MIME format.

------_=_NextPart_ef33fcb1-8d01-4b38-862d-e74034112f4b
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_e363a0dd-d791-4cb2-8567-d40f6fc26cd6"

------_=_NextPart_e363a0dd-d791-4cb2-8567-d40f6fc26cd6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Example: meta-openembedded/meta-networking/recipes-support/chrony/chrony_4.=
2.bb

--------------------------------8<--------------------------------
# Add chronyd user if privdrop packageconfig is selected
inherit ${@bb.utils.contains('PACKAGECONFIG', 'privdrop', 'useradd', '', d)=
}
USERADD_PACKAGES =3D "${@bb.utils.contains('PACKAGECONFIG', 'privdrop', '${=
PN}', '', d)}"
USERADD_PARAM:${PN} +=3D "${@bb.utils.contains('PACKAGECONFIG', 'privdrop',=
 '--system -d / -M --shell /bin/nologin chronyd;', '', d)}"

=2E..

PACKAGECONFIG ??=3D ...
-------------------------------->8--------------------------------


Problem #1: useradd is not inherited because PACKAGECONFIG is set below the=
 conditional "inherit"
statement. Even when I add "privdrop" to PACKAGECONFIG here, useradd.bbclas=
s is not inherited. I
must move the PACKAGECONFIG line above the inherit statement to make this w=
ork.

Problem #2: Due to problem #1, useradd.bbclass is also not inherited when I=
 add "privdrop" to
PACKAGECONFIG in bbappend file (in a custom layer).

regards
Christian





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

------_=_NextPart_e363a0dd-d791-4cb2-8567-d40f6fc26cd6
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8" /></head><body><div>Example: meta-openembedded/meta-networking/re=
cipes-support/chrony/chrony_4.2.bb<br /><br />-----------------------------=
---8&lt;--------------------------------<br /># Add chronyd user if privdro=
p packageconfig is selected<br />inherit ${@bb.utils.contains(&#39;PACKAGEC=
ONFIG&#39;, &#39;privdrop&#39;, &#39;useradd&#39;, &#39;&#39;, d)}<br />USE=
RADD_PACKAGES =3D &quot;${@bb.utils.contains(&#39;PACKAGECONFIG&#39;, &#39;=
privdrop&#39;, &#39;${PN}&#39;, &#39;&#39;, d)}&quot;<br />USERADD_PARAM:${=
PN} +=3D &quot;${@bb.utils.contains(&#39;PACKAGECONFIG&#39;, &#39;privdrop&=
#39;, &#39;--system -d / -M --shell /bin/nologin chronyd;&#39;, &#39;&#39;,=
 d)}&quot;<br /><br />...<br /><br />PACKAGECONFIG ??=3D ...<br />---------=
-----------------------&gt;8--------------------------------<br /><br /><br=
 />Problem #1: useradd is not inherited because PACKAGECONFIG is set below =
the conditional &quot;inherit&quot;<br />statement. Even when I add &quot;p=
rivdrop&quot; to PACKAGECONFIG here, useradd.bbclass is not inherited. I<br=
 />must move the PACKAGECONFIG line above the inherit statement to make thi=
s work.<br /><br />Problem #2: Due to problem #1, useradd.bbclass is also n=
ot inherited when I add &quot;privdrop&quot; to<br />PACKAGECONFIG in bbapp=
end file (in a custom layer).<br /><br />regards<br />Christian<br /><br />=
<br /><br /><br /></div><div dir=3D"ltr" style=3D"mso-line-height-rule:exac=
tly;-webkit-text-size-adjust:100%;direction:ltr;"><table cellpadding=3D"0" =
cellspacing=3D"0" border=3D"0" style=3D"width:100%;"><tr style=3D"font-size=
:0;"><td align=3D"left" style=3D"vertical-align:top;"><table cellpadding=
=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;"><tr style=3D"f=
ont-size:0;"><td align=3D"left" style=3D"padding:0;vertical-align:top;"><ta=
ble cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"width:100%;fo=
nt-size:0;"><tr style=3D"font-size:14.67px;color:#7F7F7F;font-style:normal;=
font-weight:400;white-space:nowrap;"><td align=3D"left" style=3D"vertical-a=
lign:top;font-family:Calibri,Arial,sans-serif;">___________________________=
____________________________<span style=3D"font-family:remialcxesans;font-s=
ize:1px;color:#FFFFFF;line-height:1px;">&#8203;</span></td></tr><tr style=
=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><table c=
ellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;"><tr =
style=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><ta=
ble cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;c=
olor:#7F7F7F;font-style:normal;font-weight:400;white-space:nowrap;"><tr sty=
le=3D"font-size:14.67px;"><td align=3D"left" style=3D"vertical-align:top;fo=
nt-family:Calibri,Arial,sans-serif;">Christian</td><td align=3D"left" style=
=3D"vertical-align:top;color:#000001;font-family:Calibri,Arial,sans-serif;"=
>&nbsp;<br /></td><td align=3D"left" style=3D"vertical-align:top;font-famil=
y:Calibri,Arial,sans-serif;">Eggers</td></tr></table></td></tr><tr style=
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
n:top;font-size:0;"><img src=3D"cid:image372264.png@B779705B.AEB47B54" widt=
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
:0;"><img src=3D"cid:image543396.png@DE15F7C4.2F912BD5" width=3D"20" border=
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
/table></td></tr></table></div></body></html>
------_=_NextPart_e363a0dd-d791-4cb2-8567-d40f6fc26cd6--

------_=_NextPart_ef33fcb1-8d01-4b38-862d-e74034112f4b
Content-Type: image/png;
	name="image372264.png"
Content-Transfer-Encoding: base64
Content-ID: <image372264.png@B779705B.AEB47B54>
Content-Description: image372264.png
Content-Disposition: inline;
	creation-date="Thu, 07 Apr 2022 14:17:07 +0000";
	filename=image372264.png;
	modification-date="Thu, 07 Apr 2022 14:17:07 +0000";
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

------_=_NextPart_ef33fcb1-8d01-4b38-862d-e74034112f4b
Content-Type: image/png;
	name="image543396.png"
Content-Transfer-Encoding: base64
Content-ID: <image543396.png@DE15F7C4.2F912BD5>
Content-Description: image543396.png
Content-Disposition: inline;
	creation-date="Thu, 07 Apr 2022 14:17:07 +0000";
	filename=image543396.png;
	modification-date="Thu, 07 Apr 2022 14:17:07 +0000";
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

------_=_NextPart_ef33fcb1-8d01-4b38-862d-e74034112f4b--

