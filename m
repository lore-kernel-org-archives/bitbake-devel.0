Return-Path: <ceggers@arri.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23778C54E76
	for <webhook@archiver.kernel.org>; Mon, 20 Nov 2023 10:59:39 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.137])
 by mx.groups.io with SMTP id smtpd.web11.47902.1700477967470915833
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Nov 2023 02:59:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arrigroup.onmicrosoft.com header.s=selector1-arrigroup-onmicrosoft-com header.b=IQm1JjvB;
 spf=pass (domain: arri.de, ip: 40.107.22.137, mailfrom: ceggers@arri.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXzIPOR9KYaM2C6UC/Qk2Ha0HWW6b/5MBQbxMXbUGgFs27wq3rLrnPRDmVC0FhYIItuaZyRTUeJo60DQofj3M5bJeNRphbtMWXb5WrhxDhumx+6sG4wNKh5dQGllq8SYJFkaEiXWFen64fYbZLb8XMnl+9RHsTiMsoKS8ApwNRrCeG7Ml4AuskGiivP3o2gm/818rz8Uc3upIKRgASlTx0LslaKK6VAgACHFjnB6uCHxqWNQnkFJyAN3OmovRFEjG7T5sRM3mG95g7jhPm/tzSnob4OqwjBuyzTaS+nBLvDOnr7rHViyWIcN7a6eKUfAmsntBN1BXgvQYS0NsyD4Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDulijW0UyPJscQMahoONrtfTV6minKShO4EXi/5IwA=;
 b=cEXa4AlsiAH2R1emjuF5Zng2sMeOVlENfLHcNN2UXfSzPU3/BmczXRnSH3CbAXk4XvDlo7aFT04xMSsgBhqERjHIyiYqvCqapgr/3nivOF8SgopcZ0YyQryudEg/D+/dYXt4oqWLaG1m3uYLfZaPuHP7G/LJZGxf8j1U2R3ulnnNweZFbUvqKi46Ehj7rT2Htn/hV2JxPuSB4mX7dko5PGalGFj2FYow4xY/QCOMJheeNsyPOulmti7MNa3HwL+r6K7ztwZrzft329m0KqXZ0XNScq9jZbLvjMoQ+a+cehj8uFiD2Ty8xCqHmdnyxgkZor2rr7t16p8rByEf3sJ/yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 104.40.229.156) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=arri.de; dmarc=bestguesspass action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDulijW0UyPJscQMahoONrtfTV6minKShO4EXi/5IwA=;
 b=IQm1JjvBZouXAMnUAPsQTf/mStbfPOsQ6wI/4EMPic+3crsYi0FVzfnazpxxTl9LlKJlXk5BeuYkczTUyLLhBxj9ZHYVeGR3SVrZUi3M6eA8VTFdg5/+tMWltYO3SZuH4ZJ6tG1q+rTjWCTQP8jD0UZo86yCOoI5Sl+T7qGEJmM=
Received: from AM0PR07CA0026.eurprd07.prod.outlook.com (2603:10a6:208:ac::39)
 by DU2PR07MB9505.eurprd07.prod.outlook.com (2603:10a6:10:497::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 10:59:22 +0000
Received: from AM4PEPF00025F95.EURPRD83.prod.outlook.com
 (2603:10a6:208:ac:cafe::15) by AM0PR07CA0026.outlook.office365.com
 (2603:10a6:208:ac::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16 via Frontend
 Transport; Mon, 20 Nov 2023 10:59:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 104.40.229.156)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=arri.de;
Received-SPF: Pass (protection.outlook.com: domain of arri.de designates
 104.40.229.156 as permitted sender) receiver=protection.outlook.com;
 client-ip=104.40.229.156; helo=eu1.smtp.exclaimer.net; pr=C
Received: from eu1.smtp.exclaimer.net (104.40.229.156) by
 AM4PEPF00025F95.mail.protection.outlook.com (10.167.16.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.7046.3 via Frontend Transport; Mon, 20 Nov 2023 10:59:21 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (104.47.14.51)
	 by eu1.smtp.exclaimer.net (104.40.229.156) with Exclaimer Signature Manager
	 ESMTP Proxy eu1.smtp.exclaimer.net (tlsversion=TLS12,
	 tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Mon, 20 Nov 2023 10:59:21 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 7002488
X-ExclaimerImprintLatency: 2816620
X-ExclaimerImprintAction: 857055514a15450984a5a4ab45e1dd02
Received: from AS9PR05CA0108.eurprd05.prod.outlook.com (2603:10a6:20b:498::19)
 by DU2PR07MB8362.eurprd07.prod.outlook.com (2603:10a6:10:2f1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 10:59:18 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:498:cafe::ab) by AS9PR05CA0108.outlook.office365.com
 (2603:10a6:20b:498::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26 via Frontend
 Transport; Mon, 20 Nov 2023 10:59:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 10:59:17 +0000
Received: from n95hx1g2.localnet (10.30.5.31) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 20 Nov
 2023 11:59:17 +0100
From: Christian Eggers <ceggers@arri.de>
To: <bitbake-devel@lists.openembedded.org>
Subject: npm/npmsw fetchers: Support for "offline" builds?
Date: Mon, 20 Nov 2023 11:59:17 +0100
Message-ID: <4851356.GXAFRqVoOG@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart1873295.tdWV9SEqCh"
Content-Transfer-Encoding: 7Bit
X-Originating-IP: [10.30.5.31]
X-EOPAttributedMessage: 1
X-MS-TrafficTypeDiagnostic: 
	AMS1EPF0000004E:EE_|DU2PR07MB8362:EE_|AM4PEPF00025F95:EE_|DU2PR07MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: a80a266d-28d8-4b18-dee2-08dbe9b7c01e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 lXe7TuRKsTzjL7jna61KTP3PqAsiNXFBwUxz2vGVTboMdS2OGSCFOhw0DMDoA5VZmoeQT1TEBA7zKL+MVPl/35XmIU50AVpls0qX61VeX1VEcZQx+oO6v3/8/WYgyPAoxZ8X8RVEEylOrVp85Su3U6qhlKtogVe7MvgTZ2gtbQzT7supJgU+KpK9p5Ivw/RseTcL8dhjnrxsmFu9/Ly07OyzagHYNEBrpMxxSPK98pnIgve02Xe5u3wYTgtHx0l3d7TcIk9q9uOStx4GwQdpR5YG39j/EzyZeoTZ/SkQPAMFFhn7YRgusHUOTpvDcuKvWXY2BaTvputTVRurQD6aKNhlZz/PY5/2Ss1zccxnVMytUdwdFFBuuorur1WT6weIho0wYR1YiCRve065rDqzolr68YLjOCaM/7TupOfqnRFWQjkUSQ36ng4Y+hKLEICU4iOyvl8qI6l+MoH7/JlGOSb1E2VYgr6H/Qc3Qo9qnBHlJ8hm0v9ExzmuLTir09Ca2Knsx7ihylDb497qNob/sTyHBv4FBvDLkNWWsz6SrPryKzeKzmlPEmsuiGCaoIArZRnsJTC5bIdJhaWhh9YQLE5IOsPOnI3Pp3zH+J52clBrWB807mvA0q+xiWMw2iXb7k0COq9iiES7u2cyTXj0D5zyFsccMCkuwiSTfY8fgSaMZMZ0/bkisoU82SFOxU2yssNOzpc2qlg2Dt8yj5Wjojw5+sN5//6QitThCfAhrs+VBLqEnF/6zof2Q2QhnXucqCfjE4Vq6pg1HbTK7KyZkQ==
X-Forefront-Antispam-Report-Untrusted: 
 CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39850400004)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(36840700001)(46966006)(16526019)(66574015)(83380400001)(33716001)(336012)(426003)(82740400003)(356005)(81166007)(86362001)(47076005)(21490400003)(36860700001)(70586007)(70206006)(8676002)(8936002)(6916009)(41300700001)(316002)(9576002)(5660300002)(235185007)(2906002)(36916002)(9686003)(33964004)(40480700001)(26005)(966005)(478600001)(36900700001);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8362
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM4PEPF00025F95.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	bca9b9d1-2787-4679-bd75-08dbe9b7bdf6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WAPFp5bp1pJzzMJhlo2HJWDmyTAzu6MMKICrbypdKH0o1W16WawTXw5Iy598tRK76qcbwPv/czOpuSYbuNPSBZ+7JKn6tG/QVhT8/GuQfuhBDuvIyswrdeEHYePUyzJRhQPJYndjvFoxE7CYjk29zf7hFLpuBufwr2DEthvieRzCQaIDBbZhFZHn5z7QDEMf/V2QZihavwBzHqCDBBqmVvyx6gLpKzLuiDSYV0D54o8Eu5TnriP2XomvhefJ88PAfmqZ9vx6QxcABkPBgx5DZcALv1W2Exr4hUpo//DRbE7CBhvY0+n1r3xX2ojHg/TNcq9hkJlLwzXe7ln9UxnXCmEZfa+kt2lEghmOR/ofPV4u9EhZjiV+Y2E8hzEpNCSgiDTUbZEOUORjQ8wE32flaZEDU1QBPbJJazz7jqw6RaK2CCZUwwvaChgvgDAXZ7004Xcn1cHR5zXFHX2Y7L6E1s/P9sJsBlZtyBPaXXHanArUVCnH2VglZm725h7b0Uq6Qh3BHx/iFDTpN/TpsP3DFXPle+tMRfumlWl9zjiFQderfcbNAO9Pk3ttBQ51YH0ODVwIhJMLyalQH/NGAFRz7v1IDn4sQ+yk66iwsnaFYfqHyId6Kg+FxM2x8K4VnfHyNiCCCrJEhbdLNwbN+9YLISyIktiPFANPATTDNYzNxmSaujqWLFQ5kAkdozHXQgOaOmHtCohaRgeRDia7YVdm43uHRoAlthUIgFzIi5VMpSy/mngh97VANeCOMXRelsxpUl3fVr/nQ/37BrXLSxlHBw==
X-Forefront-Antispam-Report: 
	CIP:104.40.229.156;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu1.smtp.exclaimer.net;PTR:eu1.smtp.exclaimer.net;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39850400004)(396003)(136003)(230922051799003)(1690799017)(7200799017)(451199024)(82310400011)(64100799003)(1800799012)(186009)(36840700001)(46966006)(41300700001)(9576002)(5660300002)(235185007)(2906002)(15974865002)(86362001)(33716001)(47076005)(7596003)(7636003)(8400799017)(66574015)(82740400003)(36916002)(33964004)(9686003)(26005)(16526019)(336012)(426003)(45080400002)(83380400001)(478600001)(966005)(21490400003)(36860700001)(70586007)(166002)(70206006)(40480700001)(8936002)(8676002)(6916009)(316002);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 10:59:21.0373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a80a266d-28d8-4b18-dee2-08dbe9b7c01e
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[104.40.229.156];Helo=[eu1.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM4PEPF00025F95.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB9505
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Nov 2023 10:59:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15532

This is a multi-part message in MIME format.

--nextPart1873295.tdWV9SEqCh
Content-Type: multipart/related;
	boundary="----_=_NextPart_97d2602d-8f54-4a38-8f04-2686522eb0a5"

------_=_NextPart_97d2602d-8f54-4a38-8f04-2686522eb0a5
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_3b937470-0a31-4140-9236-e25244596074"

------_=_NextPart_3b937470-0a31-4140-9236-e25244596074
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

I would like to run my CI build on a machine without internet access. For
this, I need to download all sources in advance:

bitbake <my images> --runall fetch
bitbake -c populate_sdk <my rootfs> --runall=3Dfetch

When having NPM based application in my SDK (e.g. quicktype [1], recipe is
attached), the "fetch" tasks perform a full build of nodejs before starting
the actual download of the quicktype sources. But building nodejs (and its
dependencies) during the "fetch" stage, compromises my wish to perform the
actual build in an offline environment.

Is it possible to download the necessary sources for quicktype without
prior building of nodejs? Perhaps by either by ...

- using curl/wget instead of npm for fetching the sources?
- by taking npm from the host distribution (instead of building it)?

regards,
Christian

[1] https://quicktype.io/
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

------_=_NextPart_3b937470-0a31-4140-9236-e25244596074
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8" /></head><body><div>I would like to run my CI build on a machine =
without internet access. For<br />this, I need to download all sources in a=
dvance:<br /><br />bitbake &lt;my images&gt; --runall fetch<br />bitbake -c=
 populate_sdk &lt;my rootfs&gt; --runall=3Dfetch<br /><br />When having NPM=
 based application in my SDK (e.g. quicktype [1], recipe is<br />attached),=
 the &quot;fetch&quot; tasks perform a full build of nodejs before starting=
<br />the actual download of the quicktype sources. But building nodejs (an=
d its<br />dependencies) during the &quot;fetch&quot; stage, compromises my=
 wish to perform the<br />actual build in an offline environment.<br /><br =
/>Is it possible to download the necessary sources for quicktype without<br=
 />prior building of nodejs? Perhaps by either by ...<br /><br />- using cu=
rl/wget instead of npm for fetching the sources?<br />- by taking npm from =
the host distribution (instead of building it)?<br /><br />regards,<br />Ch=
ristian<br /><br />[1] https://quicktype.io/</div><div dir=3D"ltr" style=
=3D"mso-line-height-rule:exactly;-webkit-text-size-adjust:100%;font-size:1p=
x;direction:ltr;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" s=
tyle=3D"width:100%;font-size:1px;"><tr style=3D"font-size:0;"><td align=3D"=
left" style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=
=3D"0" border=3D"0" style=3D"font-size:0;"><tr style=3D"font-size:0;"><td a=
lign=3D"left" style=3D"padding:0;vertical-align:top;"><table cellpadding=
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
rtical-align:top;font-size:0;"><img src=3D"cid:image368276.png@DD87617E.5F8=
1EAC9" width=3D"20" border=3D"0" alt=3D"" style=3D"width:20px;min-width:20p=
x;max-width:20px;font-size:0;" /></td><td align=3D"left" style=3D"padding:0=
;vertical-align:top;font-family:Calibri,Arial,sans-serif;"><a href=3D"tel:+=
49%208036%203009-3118" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-d=
ecoration:none;color:#858080;">+49&nbsp;8036&nbsp;3009-3118</a></td></tr><t=
r style=3D"font-size:0;"><td align=3D"left" style=3D"padding:0;vertical-ali=
gn:top;"></td><td align=3D"left" style=3D"padding:0;vertical-align:top;"></=
td></tr><tr style=3D"font-size:0;"><td align=3D"left" style=3D"padding:0;ve=
rtical-align:top;"></td><td align=3D"left" style=3D"padding:0;vertical-alig=
n:top;"></td></tr><tr style=3D"font-size:14.67px;"><td align=3D"left" style=
=3D"padding:0;vertical-align:top;font-size:0;"><img src=3D"cid:image132625.=
png@8EEA9683.F7EFB9C5" width=3D"20" border=3D"0" alt=3D"" style=3D"width:20=
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
></table></td></tr></table></div></body></html>
------_=_NextPart_3b937470-0a31-4140-9236-e25244596074--

------_=_NextPart_97d2602d-8f54-4a38-8f04-2686522eb0a5
Content-Type: image/png;
	name="image368276.png"
Content-Transfer-Encoding: base64
Content-ID: <image368276.png@DD87617E.5F81EAC9>
Content-Description: image368276.png
Content-Disposition: inline;
	creation-date="Mon, 20 Nov 2023 10:59:21 +0000";
	filename=image368276.png;
	modification-date="Mon, 20 Nov 2023 10:59:21 +0000";
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

------_=_NextPart_97d2602d-8f54-4a38-8f04-2686522eb0a5
Content-Type: image/png;
	name="image132625.png"
Content-Transfer-Encoding: base64
Content-ID: <image132625.png@8EEA9683.F7EFB9C5>
Content-Description: image132625.png
Content-Disposition: inline;
	creation-date="Mon, 20 Nov 2023 10:59:21 +0000";
	filename=image132625.png;
	modification-date="Mon, 20 Nov 2023 10:59:21 +0000";
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

------_=_NextPart_97d2602d-8f54-4a38-8f04-2686522eb0a5--

--nextPart1873295.tdWV9SEqCh
Content-Disposition: attachment; filename="quicktype_15.0.260.bb"
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"; name="quicktype_15.0.260.bb"

SUMMARY = "Generate models and serializers from JSON, schema, and GraphQL for working with data quickly & safely in any programming language."
HOMEPAGE = "https://quicktype.io/"
LICENSE = "Apache-2.0 & BSD-2-Clause & BSD-3-Clause & PD & MIT & ISC"
LIC_FILES_CHKSUM = "file://LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e \
                    file://node_modules/@mark.probst/typescript-json-schema/LICENSE;md5=0b67423da558fa736d9ea82e9f7f8a74 \
                    file://node_modules/acorn/LICENSE;md5=f6e380cb54b7b0b1b2f8428b190f4f73 \
                    file://node_modules/ansi-regex/license;md5=915042b5df33c31a6db2b37eadaa00e3 \
                    file://node_modules/ansi-styles/license;md5=915042b5df33c31a6db2b37eadaa00e3 \
                    file://node_modules/array-back/LICENSE;md5=2613420a3157e6d11b6dbf4304a77ba9 \
                    file://node_modules/balanced-match/LICENSE.md;md5=7fa99ddc3424107350ca6e9a24552085 \
                    file://node_modules/brace-expansion/LICENSE;md5=a5df515ef062cc3affd8c0ae59c059ec \
                    file://node_modules/brfs/LICENSE;md5=aea1cde69645f4b99be4ff7ca9abcce1 \
                    file://node_modules/browser-or-node/LICENSE;md5=29050f388986652edb5d178a4e5605fe \
                    file://node_modules/buffer-from/LICENSE;md5=46513463e8f7d9eb671a243f0083b2c6 \
                    file://node_modules/camelcase/license;md5=915042b5df33c31a6db2b37eadaa00e3 \
                    file://node_modules/chalk/license;md5=915042b5df33c31a6db2b37eadaa00e3 \
                    file://node_modules/cliui/LICENSE.txt;md5=83623193d3051ca8068a89a455c699ca \
                    file://node_modules/code-point-at/license;md5=a12ebca0510a773644101a99a867d210 \
                    file://node_modules/collection-utils/LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e \
                    file://node_modules/color-convert/LICENSE;md5=9bdadfc9fbb3ab8d5a6d591bdbd52811 \
                    file://node_modules/color-name/LICENSE;md5=d301869b39e08b33665b7c4f16b8e41d \
                    file://node_modules/command-line-args/LICENSE;md5=c1ddfa64fc29dd875f8ea043ca8f93e9 \
                    file://node_modules/command-line-usage/LICENSE;md5=c1d0f392d6113887beeee9e0de58693f \
                    file://node_modules/concat-map/LICENSE;md5=aea1cde69645f4b99be4ff7ca9abcce1 \
                    file://node_modules/concat-stream/LICENSE;md5=3ad90c134f824ddfcea611ee1fa567a8 \
                    file://node_modules/convert-source-map/LICENSE;md5=bf595075ff556bc46c43e08f142fa4f5 \
                    file://node_modules/core-util-is/LICENSE;md5=6126e36127d20ec0e2f637204a5c68ff \
                    file://node_modules/cross-spawn/LICENSE;md5=6046ffd2c9edcd9052bb4dd794d12f95 \
                    file://node_modules/decamelize/license;md5=a12ebca0510a773644101a99a867d210 \
                    file://node_modules/deep-extend/LICENSE;md5=827bb5781213ff1e9d2fe309bbfc0115 \
                    file://node_modules/deep-is/LICENSE;md5=fb19b42ee6322a4b61b6277fb9e13d89 \
                    file://node_modules/duplexer2/LICENSE.md;md5=2ac3dfdce5a77f9cff9b5f70d216d17d \
                    file://node_modules/encoding/LICENSE;md5=a9992d70215d97e8b82d289cec0c1ffa \
                    file://node_modules/end-of-stream/LICENSE;md5=9befe7026bf915886cd566a98117c80e \
                    file://node_modules/escape-string-regexp/license;md5=a12ebca0510a773644101a99a867d210 \
                    file://node_modules/escodegen/LICENSE.BSD;md5=e74cede38e957fe3e525b0e53a510bcf \
                    file://node_modules/esprima/LICENSE.BSD;md5=e3c825c932a984958bafbac21e21f984 \
                    file://node_modules/estraverse/LICENSE.BSD;md5=e74cede38e957fe3e525b0e53a510bcf \
                    file://node_modules/esutils/LICENSE.BSD;md5=e74cede38e957fe3e525b0e53a510bcf \
                    file://node_modules/execa/license;md5=915042b5df33c31a6db2b37eadaa00e3 \
                    file://node_modules/falafel/LICENSE;md5=aea1cde69645f4b99be4ff7ca9abcce1 \
                    file://node_modules/falafel/node_modules/isarray/LICENSE;md5=a5df515ef062cc3affd8c0ae59c059ec \
                    file://node_modules/fast-levenshtein/LICENSE.md;md5=a3e99e82761a3c89e44fe0bc43f82b94 \
                    file://node_modules/find-replace/LICENSE;md5=2613420a3157e6d11b6dbf4304a77ba9 \
                    file://node_modules/find-replace/node_modules/array-back/LICENSE;md5=fc20ee5849f94fb5da737859f9226d5a \
                    file://node_modules/find-up/license;md5=915042b5df33c31a6db2b37eadaa00e3 \
                    file://node_modules/foreach/LICENSE;md5=b2225091caf5effa363ef7016fa2b0ba \
                    file://node_modules/fs.realpath/LICENSE;md5=062470525c8e380f8567f665ef554d11 \
                    file://node_modules/function-bind/LICENSE;md5=e7417c1a8ad83f88bcac21ad440d48b2 \
                    file://node_modules/get-caller-file/LICENSE.md;md5=d21aa422a43e9693d50143d612b58967 \
                    file://node_modules/get-stream/license;md5=915042b5df33c31a6db2b37eadaa00e3 \
                    file://node_modules/glob/LICENSE;md5=c727d36f28f2762b1011dd483aa1a191 \
                    file://node_modules/graphql/LICENSE;md5=833914992eac6aa446395558eaa7bfb7 \
                    file://node_modules/has/LICENSE-MIT;md5=d000afc3c9ff3501a5610197db76a246 \
                    file://node_modules/has-flag/license;md5=915042b5df33c31a6db2b37eadaa00e3 \
                    file://node_modules/iconv-lite/LICENSE;md5=f942263d98f0d75e0e0101884e86261d \
                    file://node_modules/inflight/LICENSE;md5=90a3ca01a5efed8b813a81c6c8fa2e63 \
                    file://node_modules/inherits/LICENSE;md5=5b2ef2247af6d355ae9d9f988092d470 \
                    file://node_modules/invert-kv/license;md5=915042b5df33c31a6db2b37eadaa00e3 \
                    file://node_modules/is-core-module/LICENSE;md5=02b0fb5ff4014a08fd4193bc3e2349e2 \
                    file://node_modules/is-fullwidth-code-point/license;md5=a12ebca0510a773644101a99a867d210 \
                    file://node_modules/is-stream/license;md5=a12ebca0510a773644101a99a867d210 \
                    file://node_modules/is-url/LICENSE-MIT;md5=02923a2128d47ed2acf6bdef5ea58e37 \
                    file://node_modules/isexe/LICENSE;md5=82703a69f6d7411dde679954c2fd9dca \
                    file://node_modules/isomorphic-fetch/LICENSE;md5=fca6efcc9db8601df3166e16e15207c3 \
                    file://node_modules/isomorphic-fetch/node_modules/node-fetch/LICENSE.md;md5=89fabe2fb10f72e48c2b3be506237d1e \
                    file://node_modules/iterall/LICENSE;md5=0e88639dbc5b6587f3f3817161fcbf88 \
                    file://node_modules/js-base64/LICENSE.md;md5=7fb7031fc9f5f39701c0f3bab23af010 \
                    file://node_modules/json-stable-stringify/LICENSE;md5=aea1cde69645f4b99be4ff7ca9abcce1 \
                    file://node_modules/lcid/license;md5=915042b5df33c31a6db2b37eadaa00e3 \
                    file://node_modules/levn/LICENSE;md5=7733af876e78a187f3a51e7c276ae883 \
                    file://node_modules/locate-path/license;md5=915042b5df33c31a6db2b37eadaa00e3 \
                    file://node_modules/lodash/LICENSE;md5=8e2fca844c70b3833d7228885447c026 \
                    file://node_modules/lodash.padend/LICENSE;md5=a3b2b7770df62392c164de4001b59f8f \
                    file://node_modules/map-age-cleaner/license;md5=a775f12cfff35aa8881152fa96fb8d0a \
                    file://node_modules/mem/license;md5=915042b5df33c31a6db2b37eadaa00e3 \
                    file://node_modules/merge-source-map/LICENSE;md5=0ceb9034c469f8ce8f74ad9b7e61177c \
                    file://node_modules/merge-source-map/node_modules/source-map/LICENSE;md5=b1ca6dbc0075d56cbd9931a75566cd44 \
                    file://node_modules/mimic-fn/license;md5=915042b5df33c31a6db2b37eadaa00e3 \
                    file://node_modules/minimatch/LICENSE;md5=82703a69f6d7411dde679954c2fd9dca \
                    file://node_modules/minimist/LICENSE;md5=aea1cde69645f4b99be4ff7ca9abcce1 \
                    file://node_modules/moment/LICENSE;md5=397bb5fedab22612d8d69f1458a9321e \
                    file://node_modules/nice-try/LICENSE;md5=ae2c9097ed1d346901fdc318eff30d78 \
                    file://node_modules/node-fetch/LICENSE.md;md5=89fabe2fb10f72e48c2b3be506237d1e \
                    file://node_modules/npm-run-path/license;md5=a12ebca0510a773644101a99a867d210 \
                    file://node_modules/number-is-nan/license;md5=a12ebca0510a773644101a99a867d210 \
                    file://node_modules/object-inspect/LICENSE;md5=aea1cde69645f4b99be4ff7ca9abcce1 \
                    file://node_modules/object-keys/LICENSE;md5=0026e638d7d5c5f2768864ce0074f8ad \
                    file://node_modules/once/LICENSE;md5=82703a69f6d7411dde679954c2fd9dca \
                    file://node_modules/optionator/LICENSE;md5=7733af876e78a187f3a51e7c276ae883 \
                    file://node_modules/os-locale/license;md5=915042b5df33c31a6db2b37eadaa00e3 \
                    file://node_modules/p-defer/license;md5=a12ebca0510a773644101a99a867d210 \
                    file://node_modules/p-finally/license;md5=a12ebca0510a773644101a99a867d210 \
                    file://node_modules/p-is-promise/license;md5=915042b5df33c31a6db2b37eadaa00e3 \
                    file://node_modules/p-limit/license;md5=915042b5df33c31a6db2b37eadaa00e3 \
                    file://node_modules/p-locate/license;md5=915042b5df33c31a6db2b37eadaa00e3 \
                    file://node_modules/p-try/license;md5=915042b5df33c31a6db2b37eadaa00e3 \
                    file://node_modules/pako/LICENSE;md5=a4f08d6b2d1bf3f3a1bc296a6109a25b \
                    file://node_modules/path-exists/license;md5=a12ebca0510a773644101a99a867d210 \
                    file://node_modules/path-is-absolute/license;md5=a12ebca0510a773644101a99a867d210 \
                    file://node_modules/path-key/license;md5=a12ebca0510a773644101a99a867d210 \
                    file://node_modules/path-parse/LICENSE;md5=4b940f9668dfcb796d2cb98ad94692df \
                    file://node_modules/pluralize/LICENSE;md5=7eeeb5a4f2ac933c251575809e29300c \
                    file://node_modules/prelude-ls/LICENSE;md5=7733af876e78a187f3a51e7c276ae883 \
                    file://node_modules/process-nextick-args/license.md;md5=216769dac98a78ec088ee7cc6fad1dfa \
                    file://node_modules/pump/LICENSE;md5=9befe7026bf915886cd566a98117c80e \
                    file://node_modules/quote-stream/LICENSE;md5=aea1cde69645f4b99be4ff7ca9abcce1 \
                    file://node_modules/readable-stream/LICENSE;md5=a67a7926e54316d90c14f74f71080977 \
                    file://node_modules/readable-stream/node_modules/process-nextick-args/license.md;md5=216769dac98a78ec088ee7cc6fad1dfa \
                    file://node_modules/readable-stream/node_modules/string_decoder/LICENSE;md5=14af51f8c0a6c6e400b53e18c6e5f85c \
                    file://node_modules/reduce-flatten/LICENSE;md5=89b0669afc8c7ddb483a7cab7860548e \
                    file://node_modules/require-directory/LICENSE;md5=903997d26b12b72b43aa60018387bb90 \
                    file://node_modules/require-main-filename/LICENSE.txt;md5=8fd106383180f7bbb8f534414fdf7d35 \
                    file://node_modules/resolve/LICENSE;md5=baa47288b5bd3e657a01886ce3dd0cb6 \
                    file://node_modules/safe-buffer/LICENSE;md5=badd5e91c737e7ffdf10b40c1f907761 \
                    file://node_modules/safer-buffer/LICENSE;md5=3baebc2a17b8f5bff04882cd0dc0f76e \
                    file://node_modules/semver/LICENSE;md5=82703a69f6d7411dde679954c2fd9dca \
                    file://node_modules/set-blocking/LICENSE.txt;md5=8fd106383180f7bbb8f534414fdf7d35 \
                    file://node_modules/shallow-copy/LICENSE;md5=aea1cde69645f4b99be4ff7ca9abcce1 \
                    file://node_modules/shebang-command/license;md5=1801ea63a6ba2dfc429eb5f36d09e06f \
                    file://node_modules/shebang-regex/license;md5=a12ebca0510a773644101a99a867d210 \
                    file://node_modules/signal-exit/LICENSE.txt;md5=e29e20260a1c78dba16a233048565cde \
                    file://node_modules/source-map/LICENSE;md5=b1ca6dbc0075d56cbd9931a75566cd44 \
                    file://node_modules/static-eval/LICENSE;md5=17b15c42072231f9ebd9f287fc7793fc \
                    file://node_modules/static-eval/node_modules/escodegen/LICENSE.BSD;md5=cfaad9edcc0e58ef57eb2b4df5a00121 \
                    file://node_modules/static-eval/node_modules/esprima/LICENSE.BSD;md5=e3c825c932a984958bafbac21e21f984 \
                    file://node_modules/static-module/LICENSE;md5=aea1cde69645f4b99be4ff7ca9abcce1 \
                    file://node_modules/static-module/node_modules/readable-stream/LICENSE;md5=a67a7926e54316d90c14f74f71080977 \
                    file://node_modules/stream-chain/LICENSE;md5=48c5102ef717a1da65cc85f55c42f70a \
                    file://node_modules/stream-json/LICENSE;md5=5afefd2452b073c881a558f89735fb58 \
                    file://node_modules/string-to-stream/LICENSE;md5=fb42e5aa12bb9e365d38b4b5691d6984 \
                    file://node_modules/string-width/license;md5=915042b5df33c31a6db2b37eadaa00e3 \
                    file://node_modules/string_decoder/LICENSE;md5=14af51f8c0a6c6e400b53e18c6e5f85c \
                    file://node_modules/strip-ansi/license;md5=915042b5df33c31a6db2b37eadaa00e3 \
                    file://node_modules/strip-eof/license;md5=a12ebca0510a773644101a99a867d210 \
                    file://node_modules/supports-color/license;md5=915042b5df33c31a6db2b37eadaa00e3 \
                    file://node_modules/table-layout/LICENSE;md5=15a318bc4fd8f01eb4196c7418b4cb1c \
                    file://node_modules/test-value/LICENSE;md5=fc20ee5849f94fb5da737859f9226d5a \
                    file://node_modules/test-value/node_modules/array-back/LICENSE;md5=fc20ee5849f94fb5da737859f9226d5a \
                    file://node_modules/through2/LICENSE.md;md5=86fc40a92fe89e4ec72daa6fab2f9c21 \
                    file://node_modules/through2/node_modules/readable-stream/LICENSE;md5=a67a7926e54316d90c14f74f71080977 \
                    file://node_modules/tiny-inflate/LICENSE;md5=9e3a041ed5f3f1d795271af7b4f52159 \
                    file://node_modules/type-check/LICENSE;md5=7733af876e78a187f3a51e7c276ae883 \
                    file://node_modules/typedarray/LICENSE;md5=6085b70b74c7dcf7df4e955725e3153d \
                    file://node_modules/typescript/CopyrightNotice.txt;md5=435edc9bf4ec470ea6a28f258ecd7f52 \
                    file://node_modules/typescript/LICENSE.txt;md5=55a8748c7d5c7253f3e4bb7402ff04db \
                    file://node_modules/typical/LICENSE;md5=616a79a0ccc4cd477c5a06494d7c9206 \
                    file://node_modules/unicode-trie/node_modules/pako/LICENSE;md5=6b8c8aad0a85200097ec8f989636baf0 \
                    file://node_modules/urijs/LICENSE.txt;md5=208faacdc29d1dbd0fdbe20fbfcf7949 \
                    file://node_modules/util-deprecate/LICENSE;md5=b7c99ef4b0f3ad9911a52219947f8cf0 \
                    file://node_modules/uuid/LICENSE.md;md5=c9420736e23afb538ba5fbe44197f0b4 \
                    file://node_modules/vlq/LICENSE;md5=b2254373d77f8d68d1312f9eb402210f \
                    file://node_modules/webidl-conversions/LICENSE.md;md5=44d86433f305935cb0c3d3cd320e7a34 \
                    file://node_modules/whatwg-fetch/LICENSE;md5=aeee7dd4dc9409a4621a2d02147284f1 \
                    file://node_modules/whatwg-url/LICENSE.txt;md5=5ab9113efe10eeab888f7502d1c2e894 \
                    file://node_modules/which/LICENSE;md5=82703a69f6d7411dde679954c2fd9dca \
                    file://node_modules/which-module/LICENSE;md5=42624e59bd3dabedcca59e1b54e3af50 \
                    file://node_modules/word-wrap/LICENSE;md5=c8f80ed52c9074414e8a69541cdc1587 \
                    file://node_modules/wordwrap/LICENSE;md5=aea1cde69645f4b99be4ff7ca9abcce1 \
                    file://node_modules/wordwrapjs/LICENSE;md5=2613420a3157e6d11b6dbf4304a77ba9 \
                    file://node_modules/wrap-ansi/license;md5=a12ebca0510a773644101a99a867d210 \
                    file://node_modules/wrap-ansi/node_modules/ansi-regex/license;md5=a12ebca0510a773644101a99a867d210 \
                    file://node_modules/wrap-ansi/node_modules/is-fullwidth-code-point/license;md5=a12ebca0510a773644101a99a867d210 \
                    file://node_modules/wrap-ansi/node_modules/string-width/license;md5=a12ebca0510a773644101a99a867d210 \
                    file://node_modules/wrap-ansi/node_modules/strip-ansi/license;md5=a12ebca0510a773644101a99a867d210 \
                    file://node_modules/wrappy/LICENSE;md5=82703a69f6d7411dde679954c2fd9dca \
                    file://node_modules/xtend/LICENSE;md5=66787c5cd698a0b30b358c7e30f500ca \
                    file://node_modules/y18n/LICENSE;md5=55e5f88040679148136545002139a8b1 \
                    file://node_modules/yaml/LICENSE;md5=f43d95a153ee2ee3d2169246bae2f14b \
                    file://node_modules/yargs/LICENSE;md5=becfe5b407a6b8b768960384631232c9 \
                    file://node_modules/yargs-parser/LICENSE.txt;md5=8fd106383180f7bbb8f534414fdf7d35 \
                    file://package.json;md5=d94f2e9082454bafd44ebbb41140f077 \
                    file://node_modules/@mark.probst/typescript-json-schema/package.json;md5=7be744186e8d9bc589a3537fee65503c \
                    file://node_modules/@mark.probst/unicode-properties/package.json;md5=6c121f2adbd42dd05cc33a52c6ef80b9 \
                    file://node_modules/acorn/package.json;md5=f4df9c4532d1d8b98d2403f383028cf2 \
                    file://node_modules/ansi-regex/package.json;md5=d7acde142774ab8845b52b59dbab92d4 \
                    file://node_modules/ansi-styles/package.json;md5=50f97f15be9377b1110c7a68f76fff0f \
                    file://node_modules/array-back/package.json;md5=6f53c28b58a70bda91da3673d813cd6b \
                    file://node_modules/balanced-match/package.json;md5=fa13802cf9109f23db7cc107f33cbf0a \
                    file://node_modules/brace-expansion/package.json;md5=effd91994b1b7ddb8a33060ad4541e6a \
                    file://node_modules/brfs/package.json;md5=2514d1b66ee2d280edf673452145df0c \
                    file://node_modules/browser-or-node/package.json;md5=49da96fa370f2705d14fff46e2ed5645 \
                    file://node_modules/buffer-equal/package.json;md5=8c5867543ce829daea20563905f68505 \
                    file://node_modules/buffer-from/package.json;md5=5d307ad7d2ccde25a82e944fb224ebe2 \
                    file://node_modules/camelcase/package.json;md5=31d66d63d07c9d3ab05757ac887e555b \
                    file://node_modules/chalk/package.json;md5=a21f60da989d4bf1cd5396df6c638a98 \
                    file://node_modules/cliui/package.json;md5=833c50be4572cd5d75b98b4c2a538b36 \
                    file://node_modules/code-point-at/package.json;md5=4e85e8a583ebac72e2065d9e576c92cf \
                    file://node_modules/collection-utils/package.json;md5=66fb3396940dfb332353fa68ff730c5a \
                    file://node_modules/color-convert/package.json;md5=51a202f6ab9b016f0f7219701f1f5e70 \
                    file://node_modules/color-name/package.json;md5=7599aecb8597ca603c711d49a83dab59 \
                    file://node_modules/command-line-args/package.json;md5=c842fdc9bf2cf72936204989a2ab91f4 \
                    file://node_modules/command-line-usage/package.json;md5=222a5fbac7668bf243e1b273e097f484 \
                    file://node_modules/concat-map/package.json;md5=85d8a674998927862b17adef4aa6a7b1 \
                    file://node_modules/concat-stream/package.json;md5=61caf8dd4ec0cd0fe58d27f28dc499d1 \
                    file://node_modules/convert-source-map/package.json;md5=f0df68581711c15f53d31c92d10b845a \
                    file://node_modules/core-util-is/package.json;md5=ce4cfe45404dea29ac581e68ba998ecc \
                    file://node_modules/cross-spawn/package.json;md5=916737048c596ce06c92128f5c188742 \
                    file://node_modules/decamelize/package.json;md5=494b4faeb16e12979e988b49de7684d6 \
                    file://node_modules/deep-extend/package.json;md5=843d8bcf451f015c3a6b3930e0b6eaee \
                    file://node_modules/deep-is/package.json;md5=94a3d6fcba92a0be65e34b4ee45a69e8 \
                    file://node_modules/duplexer2/package.json;md5=4eb79ce818182efe036989dc61691910 \
                    file://node_modules/encoding/package.json;md5=86287e8ff03616352dde34f4d1f87a7e \
                    file://node_modules/end-of-stream/package.json;md5=36be3e35e3740830415138528c4237d4 \
                    file://node_modules/escape-string-regexp/package.json;md5=6050cf06c06dcb38dce670ff96b21aa9 \
                    file://node_modules/escodegen/package.json;md5=79feba5f4f85109cbf84598fe572016f \
                    file://node_modules/esprima/package.json;md5=749f1091cf5bd58fa9e8d34ea19574bb \
                    file://node_modules/estraverse/package.json;md5=7046f02ae6e8ae55b27f236ad1a9649f \
                    file://node_modules/esutils/package.json;md5=fd59d94811d2143cd317e51fc1b8e3e3 \
                    file://node_modules/execa/package.json;md5=b14eefcf052ebdb86371fac485cd8e5d \
                    file://node_modules/falafel/node_modules/isarray/package.json;md5=7efcba14ed8a9ab09e4c277b21936b7a \
                    file://node_modules/falafel/package.json;md5=6b78551db4f83986810cac337cfeaaa2 \
                    file://node_modules/fast-levenshtein/package.json;md5=d35b9aae1427262e3eecd92beadd93a7 \
                    file://node_modules/find-replace/node_modules/array-back/package.json;md5=25116030244f33c235cbde398814f513 \
                    file://node_modules/find-replace/package.json;md5=e54785e21fefc8eef05cb87c2e590517 \
                    file://node_modules/find-up/package.json;md5=ef55d36c375ead3172f98f4f4655419e \
                    file://node_modules/foreach/package.json;md5=a01d1df68e94076fe2a3c72b92a7b661 \
                    file://node_modules/fs.realpath/package.json;md5=3aa3d67ce378e330e293496dd3b9a506 \
                    file://node_modules/function-bind/package.json;md5=f453e26c8d3482b4c3736f53303b4ec5 \
                    file://node_modules/get-caller-file/package.json;md5=28d7830f0080c10a7a680f82a0faac37 \
                    file://node_modules/get-stream/package.json;md5=a9999627668552d0afc9661299ee601c \
                    file://node_modules/glob/package.json;md5=4e6fa4c445ac2568ca23fc13b2a39e4c \
                    file://node_modules/graphql/package.json;md5=537e5ef7ece06209ef14bb18bf857c34 \
                    file://node_modules/has/package.json;md5=2fee243336ba5aeebed1e0145472cd49 \
                    file://node_modules/has-flag/package.json;md5=73cc8d1e96c19ce85a7abb8f9468a86c \
                    file://node_modules/iconv-lite/package.json;md5=549e620fd864ffd8abf14bea34a2d7ce \
                    file://node_modules/inflight/package.json;md5=85ba25624378c23e1ee9b33d3d103bf0 \
                    file://node_modules/inherits/package.json;md5=f73908dab55d4259f3ed052ce9fb2fbb \
                    file://node_modules/invert-kv/package.json;md5=3ff5c671b10a31cc20eb10f43c88a7a0 \
                    file://node_modules/is-core-module/package.json;md5=52b3be31bbd64740ff6dbd1c87d4a495 \
                    file://node_modules/is-fullwidth-code-point/package.json;md5=e199d7053a4c1508b8654c3965a58b20 \
                    file://node_modules/is-stream/package.json;md5=85ba3dbdbccd3e5f8505dd02a538db06 \
                    file://node_modules/is-url/package.json;md5=321c67d4ee61c2c86607dcabf25ff309 \
                    file://node_modules/isarray/package.json;md5=a490f11007b2cc9d19c4a250592c2e71 \
                    file://node_modules/isexe/package.json;md5=b7340828ee0e123814f9b855953de714 \
                    file://node_modules/isomorphic-fetch/node_modules/node-fetch/package.json;md5=553f35e957f48f5a8478f8265fa57799 \
                    file://node_modules/isomorphic-fetch/package.json;md5=c324efaef9a045f4199adff2bbc23f47 \
                    file://node_modules/iterall/package.json;md5=34bdbca237fb401245af6a61dd742882 \
                    file://node_modules/js-base64/package.json;md5=c2b4c6fa095c1e1d1c1c21a480dfb042 \
                    file://node_modules/json-stable-stringify/package.json;md5=1dbe798eb3166c30676d76d9d0ecc249 \
                    file://node_modules/jsonify/package.json;md5=4d6afd81aded57a3818e2bc4327c8868 \
                    file://node_modules/lcid/package.json;md5=3111e27b5939c2989ce545b0ac8edaaa \
                    file://node_modules/levn/package.json;md5=2d755c2552dec6775de6ba470c1130eb \
                    file://node_modules/locate-path/package.json;md5=a3beabab01f511b388b76801632e0ef6 \
                    file://node_modules/lodash/package.json;md5=188f386c15507c982c3e0d5a2db5b60d \
                    file://node_modules/lodash.padend/package.json;md5=a00b7a298d91f05f574b467ac30eb59b \
                    file://node_modules/magic-string/package.json;md5=1ddfdca13c0c0554b99bfa2a9293a388 \
                    file://node_modules/map-age-cleaner/package.json;md5=e23807677e64af31d5414e511af75d0f \
                    file://node_modules/mem/package.json;md5=4c58b48790fea1a0df6d449f0508e773 \
                    file://node_modules/merge-source-map/node_modules/source-map/package.json;md5=7d1d048f81843bb704a2c69b3bcf3018 \
                    file://node_modules/merge-source-map/package.json;md5=77f3644f2028f973fe4cd007908a6802 \
                    file://node_modules/mimic-fn/package.json;md5=b1982703f9d28bda97282ecd1399df51 \
                    file://node_modules/minimatch/package.json;md5=b763d93b18d070a6449399d2e92d8c32 \
                    file://node_modules/minimist/package.json;md5=84505571ecc56b8071068f44de7c79b2 \
                    file://node_modules/moment/package.json;md5=5d9728f5a9fc2ae272061e8b08757505 \
                    file://node_modules/nice-try/package.json;md5=231f69dd25df732ba25c841f15ef1cd1 \
                    file://node_modules/node-fetch/package.json;md5=ef6a1723498708af975e3f9299978efb \
                    file://node_modules/npm-run-path/package.json;md5=accdf7ebabfc9ba8d04808f263d0b89e \
                    file://node_modules/number-is-nan/package.json;md5=2b5b5a279c98be57ebafdaa605a14584 \
                    file://node_modules/object-inspect/package.json;md5=bc0703b08d10514e50475aae25d95504 \
                    file://node_modules/object-keys/package.json;md5=f008c51545b8133eebae07e2046d241f \
                    file://node_modules/once/package.json;md5=afb6ea3bdcad6397e11a71615bd06e3b \
                    file://node_modules/optionator/package.json;md5=1ca878efe9f14a5a74b677f3909776a4 \
                    file://node_modules/os-locale/package.json;md5=49d94aee3c66c22ae6a634f6776b7f56 \
                    file://node_modules/p-defer/package.json;md5=18fcafe6b02428f735f35e36eff7f1a8 \
                    file://node_modules/p-finally/package.json;md5=48bdb4e7489f258943b736ea0487bd13 \
                    file://node_modules/p-is-promise/package.json;md5=672442e5832808171a56253b31a464d7 \
                    file://node_modules/p-limit/package.json;md5=05ea6bd0b1f47d88b1328a020729de28 \
                    file://node_modules/p-locate/package.json;md5=602118ccca6207d1f7f1ca4639be5ab2 \
                    file://node_modules/p-try/package.json;md5=c3ec2260c0b640c43f15e99e4fa7b593 \
                    file://node_modules/pako/package.json;md5=313da501a381d9a74ba74a95100a44a4 \
                    file://node_modules/path-exists/package.json;md5=914ca2e089e5356c9b42652cc96ba260 \
                    file://node_modules/path-is-absolute/package.json;md5=ef6e018bdf67b82ab1285bc799b5367b \
                    file://node_modules/path-key/package.json;md5=a9bda66c8caf7e0ac15a63d36c72f535 \
                    file://node_modules/path-parse/package.json;md5=e225588668693d527d2a82f0db68088c \
                    file://node_modules/pluralize/package.json;md5=7cbf12d598424f8a945935e7a2dbd526 \
                    file://node_modules/prelude-ls/package.json;md5=3cc64486b87ad251ccce2d0b817ad7c4 \
                    file://node_modules/process-nextick-args/package.json;md5=6bd1fff965ff97b4aff54e6b4e382ed0 \
                    file://node_modules/pump/package.json;md5=aaae9cf98124b7abea552bfa6b4ec7d5 \
                    file://node_modules/quote-stream/package.json;md5=d2ee293ac9e7f5a5fa518d982b596db7 \
                    file://node_modules/readable-stream/node_modules/process-nextick-args/package.json;md5=333915c9adf7622e21223958d9b4650e \
                    file://node_modules/readable-stream/node_modules/string_decoder/package.json;md5=0ad782f961f15a738a10c1321a1460b7 \
                    file://node_modules/readable-stream/package.json;md5=60359e3b617c1b6f33f12c47367ff218 \
                    file://node_modules/reduce-flatten/package.json;md5=ca638518528d3dbde3012de4df5d126e \
                    file://node_modules/require-directory/package.json;md5=77d2cd39b67ccdf73bfc037d229cf0f8 \
                    file://node_modules/require-main-filename/package.json;md5=2ee14064e9bc0f188f29365afff7ab2c \
                    file://node_modules/resolve/package.json;md5=4b824b9e44bae4d06d457f8eed27ff40 \
                    file://node_modules/safe-buffer/package.json;md5=bd7ef6f38f0ba20882d2601bd3ecaf11 \
                    file://node_modules/safer-buffer/package.json;md5=274d956f400350c9f6cf96d22cdda227 \
                    file://node_modules/semver/package.json;md5=735f6ede2a644d292066a9813d8b9da6 \
                    file://node_modules/set-blocking/package.json;md5=e37224b4c865b4464d6d41b1f8a870a4 \
                    file://node_modules/shallow-copy/package.json;md5=13891e74b4e677cf77e62be84e0fb6d1 \
                    file://node_modules/shebang-command/package.json;md5=e3e9b8da6c97c9b272d0dfbaefaca5ca \
                    file://node_modules/shebang-regex/package.json;md5=d0ffe7f7078a4ff229a06822fb3ced86 \
                    file://node_modules/signal-exit/package.json;md5=c3707ed007d40f7e32a28f4a523816e9 \
                    file://node_modules/source-map/package.json;md5=5f7feb368962c3130c5accf22ffd047c \
                    file://node_modules/static-eval/node_modules/escodegen/package.json;md5=274f504792dbac57ff14ff2ff722faba \
                    file://node_modules/static-eval/node_modules/esprima/package.json;md5=0394ebc64b1f0c98e6b1e3fd65c2ee37 \
                    file://node_modules/static-eval/package.json;md5=4313c2b27e252a1090fe14bdd142b586 \
                    file://node_modules/static-module/node_modules/readable-stream/package.json;md5=55d646ab9e50735393b18c874d0bd5ab \
                    file://node_modules/static-module/package.json;md5=5e71f4b369f7244f0933ccf16b12bb43 \
                    file://node_modules/stream-chain/package.json;md5=2e1051fbb7ae286316d999ed2b1915a0 \
                    file://node_modules/stream-json/package.json;md5=9db55f4b2c41072b371d2cc661cc8633 \
                    file://node_modules/string-to-stream/package.json;md5=ff199131a563a46438c02254196cba52 \
                    file://node_modules/string-width/package.json;md5=9e0cb0da60820ee09789b5537fee5d81 \
                    file://node_modules/string_decoder/package.json;md5=4a56e8c1789fe3bc13c55f8fec7e3ce2 \
                    file://node_modules/strip-ansi/package.json;md5=75c599f3b1853e4b8f25db1fb10881e1 \
                    file://node_modules/strip-eof/package.json;md5=04e04cb47dd8a9978d7e12d08da68c39 \
                    file://node_modules/supports-color/package.json;md5=79d88f702d689c72ebe1798d2853a96e \
                    file://node_modules/table-layout/package.json;md5=29b9b809b2552100c137bd676fa92e20 \
                    file://node_modules/test-value/node_modules/array-back/package.json;md5=25116030244f33c235cbde398814f513 \
                    file://node_modules/test-value/package.json;md5=0c3eba95196e77f6defd0a53fe11f659 \
                    file://node_modules/through2/node_modules/readable-stream/package.json;md5=55d646ab9e50735393b18c874d0bd5ab \
                    file://node_modules/through2/package.json;md5=c584f7fcdc313c175710c330eff82712 \
                    file://node_modules/tiny-inflate/package.json;md5=1a87762e48195e5c3c81e833e0460521 \
                    file://node_modules/tr46/package.json;md5=36ce158498fb4f35c9a42edb60665bbe \
                    file://node_modules/type-check/package.json;md5=73bed18b048b3ae9e3d3496e4fd4f2af \
                    file://node_modules/typedarray/package.json;md5=252085c44894a63cd58d8c343f2ba589 \
                    file://node_modules/typescript/package.json;md5=acc3e2797dc83a6529482fedf5d44997 \
                    file://node_modules/typical/package.json;md5=0779a06d69646806db0f0a45cfe47926 \
                    file://node_modules/unicode-trie/node_modules/pako/package.json;md5=7445f115aef220a5177b5e02c5306436 \
                    file://node_modules/unicode-trie/package.json;md5=7591763acb3fccd1d37c7c1f189a6840 \
                    file://node_modules/urijs/package.json;md5=e4dab61fe66de26e3b37d65e8c6552bf \
                    file://node_modules/util-deprecate/package.json;md5=73e6c3ff1709538c921d13a75cae485d \
                    file://node_modules/uuid/package.json;md5=a114f1fa334f6add6b4e4b8c0ca6057b \
                    file://node_modules/vlq/package.json;md5=add7fdd7ba8a8833d2d7ebadcf2077d4 \
                    file://node_modules/webidl-conversions/package.json;md5=d7bd86551914eb9227e095c120c44a20 \
                    file://node_modules/whatwg-fetch/package.json;md5=6600255bf5274b189ec6cb33a513ac03 \
                    file://node_modules/whatwg-url/package.json;md5=6e30b7bcedf322ac0d987b6a02d1918a \
                    file://node_modules/which/package.json;md5=9db3fcd8026f288ba3aaad83200f5a35 \
                    file://node_modules/which-module/package.json;md5=b4ab6a39c5e86263ade16635797218d2 \
                    file://node_modules/word-wrap/package.json;md5=66ca9ca5c5cc8228664502f5eaaca60c \
                    file://node_modules/wordwrap/package.json;md5=de042387ba8d3842c4c36e626516e03c \
                    file://node_modules/wordwrapjs/package.json;md5=ed43e20ce679b92821bf347fe9cc8b02 \
                    file://node_modules/wrap-ansi/node_modules/ansi-regex/package.json;md5=fbd3a8909a47de214c7288046091267c \
                    file://node_modules/wrap-ansi/node_modules/is-fullwidth-code-point/package.json;md5=6bd5a684a5081f2d099cb800cf53ebd6 \
                    file://node_modules/wrap-ansi/node_modules/string-width/package.json;md5=97dfb4a5985832f6a8c070ca4481b96c \
                    file://node_modules/wrap-ansi/node_modules/strip-ansi/package.json;md5=0b615dc471f5f434dd297c8655ed0c7f \
                    file://node_modules/wrap-ansi/package.json;md5=1ea40ca7800b0656e6fdf08ec2787947 \
                    file://node_modules/wrappy/package.json;md5=788804d507f3ed479ea7614fa7d3f1a5 \
                    file://node_modules/xtend/package.json;md5=9a88dd08c469a5a8b2ea15f999bf5db8 \
                    file://node_modules/y18n/package.json;md5=8257402a42ebdf07c8246fbd3bc7a312 \
                    file://node_modules/yaml/package.json;md5=b777e909af1dd36b761a5e88df2ce9f2 \
                    file://node_modules/yargs/package.json;md5=2788b0454e2252335ee88add2972183f \
                    file://node_modules/yargs-parser/package.json;md5=3ebb04559ef0340e0bc70d65e89fee28"

SRC_URI = " \
    npm://registry.npmjs.org/;package=quicktype;version=${PV} \
    npmsw://${THISDIR}/${BPN}/npm-shrinkwrap.json \
    "

S = "${WORKDIR}/npm"

inherit npm

LICENSE:${PN} = "Apache-2.0"
LICENSE:${PN}-markprobst-typescript-json-schema = "BSD-3-Clause"
LICENSE:${PN}-markprobst-unicode-properties = "MIT"
LICENSE:${PN}-acorn = "MIT"
LICENSE:${PN}-ansi-regex = "MIT"
LICENSE:${PN}-ansi-styles = "MIT"
LICENSE:${PN}-array-back = "MIT"
LICENSE:${PN}-balanced-match = "MIT"
LICENSE:${PN}-brace-expansion = "MIT"
LICENSE:${PN}-brfs = "MIT"
LICENSE:${PN}-browser-or-node = "MIT"
LICENSE:${PN}-buffer-equal = "MIT"
LICENSE:${PN}-buffer-from = "MIT"
LICENSE:${PN}-camelcase = "MIT"
LICENSE:${PN}-chalk = "MIT"
LICENSE:${PN}-cliui = "ISC"
LICENSE:${PN}-code-point-at = "MIT"
LICENSE:${PN}-collection-utils = "Apache-2.0"
LICENSE:${PN}-color-convert = "MIT"
LICENSE:${PN}-color-name = "MIT"
LICENSE:${PN}-command-line-args = "MIT"
LICENSE:${PN}-command-line-usage = "MIT"
LICENSE:${PN}-concat-map = "MIT"
LICENSE:${PN}-concat-stream = "MIT"
LICENSE:${PN}-convert-source-map = "MIT"
LICENSE:${PN}-core-util-is = "MIT"
LICENSE:${PN}-cross-spawn = "MIT"
LICENSE:${PN}-decamelize = "MIT"
LICENSE:${PN}-deep-extend = "MIT"
LICENSE:${PN}-deep-is = "MIT"
LICENSE:${PN}-duplexer2 = "BSD-3-Clause"
LICENSE:${PN}-encoding = "MIT"
LICENSE:${PN}-end-of-stream = "MIT"
LICENSE:${PN}-escape-string-regexp = "MIT"
LICENSE:${PN}-escodegen = "BSD-2-Clause"
LICENSE:${PN}-esprima = "BSD-2-Clause"
LICENSE:${PN}-estraverse = "BSD-2-Clause"
LICENSE:${PN}-esutils = "BSD-2-Clause"
LICENSE:${PN}-execa = "MIT"
LICENSE:${PN}-falafel-isarray = "MIT"
LICENSE:${PN}-falafel = "MIT"
LICENSE:${PN}-fast-levenshtein = "MIT"
LICENSE:${PN}-find-replace-array-back = "MIT"
LICENSE:${PN}-find-replace = "MIT"
LICENSE:${PN}-find-up = "MIT"
LICENSE:${PN}-foreach = "MIT"
LICENSE:${PN}-fsrealpath = "ISC & MIT"
LICENSE:${PN}-function-bind = "MIT"
LICENSE:${PN}-get-caller-file = "ISC"
LICENSE:${PN}-get-stream = "MIT"
LICENSE:${PN}-glob = "ISC"
LICENSE:${PN}-graphql = "MIT"
LICENSE:${PN}-has = "MIT"
LICENSE:${PN}-has-flag = "MIT"
LICENSE:${PN}-iconv-lite = "MIT"
LICENSE:${PN}-inflight = "ISC"
LICENSE:${PN}-inherits = "ISC"
LICENSE:${PN}-invert-kv = "MIT"
LICENSE:${PN}-is-core-module = "MIT"
LICENSE:${PN}-is-fullwidth-code-point = "MIT"
LICENSE:${PN}-is-stream = "MIT"
LICENSE:${PN}-is-url = "MIT"
LICENSE:${PN}-isarray = "MIT"
LICENSE:${PN}-isexe = "ISC"
LICENSE:${PN}-isomorphic-fetch-node-fetch = "MIT"
LICENSE:${PN}-isomorphic-fetch = "MIT"
LICENSE:${PN}-iterall = "MIT"
LICENSE:${PN}-js-base64 = "BSD-3-Clause"
LICENSE:${PN}-json-stable-stringify = "MIT"
LICENSE:${PN}-jsonify = "PD"
LICENSE:${PN}-lcid = "MIT"
LICENSE:${PN}-levn = "MIT"
LICENSE:${PN}-locate-path = "MIT"
LICENSE:${PN}-lodash = "MIT"
LICENSE:${PN}-lodashpadend = "MIT"
LICENSE:${PN}-magic-string = "MIT"
LICENSE:${PN}-map-age-cleaner = "MIT"
LICENSE:${PN}-mem = "MIT"
LICENSE:${PN}-merge-source-map-source-map = "BSD-3-Clause"
LICENSE:${PN}-merge-source-map = "MIT"
LICENSE:${PN}-mimic-fn = "MIT"
LICENSE:${PN}-minimatch = "ISC"
LICENSE:${PN}-minimist = "MIT"
LICENSE:${PN}-moment = "MIT"
LICENSE:${PN}-nice-try = "MIT"
LICENSE:${PN}-node-fetch = "MIT"
LICENSE:${PN}-npm-run-path = "MIT"
LICENSE:${PN}-number-is-nan = "MIT"
LICENSE:${PN}-object-inspect = "MIT"
LICENSE:${PN}-object-keys = "MIT"
LICENSE:${PN}-once = "ISC"
LICENSE:${PN}-optionator = "MIT"
LICENSE:${PN}-os-locale = "MIT"
LICENSE:${PN}-p-defer = "MIT"
LICENSE:${PN}-p-finally = "MIT"
LICENSE:${PN}-p-is-promise = "MIT"
LICENSE:${PN}-p-limit = "MIT"
LICENSE:${PN}-p-locate = "MIT"
LICENSE:${PN}-p-try = "MIT"
LICENSE:${PN}-pako = "MIT"
LICENSE:${PN}-path-exists = "MIT"
LICENSE:${PN}-path-is-absolute = "MIT"
LICENSE:${PN}-path-key = "MIT"
LICENSE:${PN}-path-parse = "MIT"
LICENSE:${PN}-pluralize = "MIT"
LICENSE:${PN}-prelude-ls = "MIT"
LICENSE:${PN}-process-nextick-args = "MIT"
LICENSE:${PN}-pump = "MIT"
LICENSE:${PN}-quote-stream = "MIT"
LICENSE:${PN}-readable-stream-process-nextick-args = "MIT"
LICENSE:${PN}-readable-stream-stringdecoder = "MIT"
LICENSE:${PN}-readable-stream = "MIT"
LICENSE:${PN}-reduce-flatten = "MIT"
LICENSE:${PN}-require-directory = "MIT"
LICENSE:${PN}-require-main-filename = "ISC"
LICENSE:${PN}-resolve = "MIT"
LICENSE:${PN}-safe-buffer = "MIT"
LICENSE:${PN}-safer-buffer = "MIT"
LICENSE:${PN}-semver = "ISC"
LICENSE:${PN}-set-blocking = "ISC"
LICENSE:${PN}-shallow-copy = "MIT"
LICENSE:${PN}-shebang-command = "MIT"
LICENSE:${PN}-shebang-regex = "MIT"
LICENSE:${PN}-signal-exit = "ISC"
LICENSE:${PN}-source-map = "BSD-3-Clause"
LICENSE:${PN}-static-eval-escodegen = "BSD-2-Clause"
LICENSE:${PN}-static-eval-esprima = "BSD-2-Clause"
LICENSE:${PN}-static-eval = "MIT"
LICENSE:${PN}-static-module-readable-stream = "MIT"
LICENSE:${PN}-static-module = "MIT"
LICENSE:${PN}-stream-chain = "BSD-3-Clause"
LICENSE:${PN}-stream-json = "BSD-3-Clause"
LICENSE:${PN}-string-to-stream = "MIT"
LICENSE:${PN}-string-width = "MIT"
LICENSE:${PN}-stringdecoder = "MIT"
LICENSE:${PN}-strip-ansi = "MIT"
LICENSE:${PN}-strip-eof = "MIT"
LICENSE:${PN}-supports-color = "MIT"
LICENSE:${PN}-table-layout = "MIT"
LICENSE:${PN}-test-value-array-back = "MIT"
LICENSE:${PN}-test-value = "MIT"
LICENSE:${PN}-through2-readable-stream = "MIT"
LICENSE:${PN}-through2 = "MIT"
LICENSE:${PN}-tiny-inflate = "MIT"
LICENSE:${PN}-tr46 = "MIT"
LICENSE:${PN}-type-check = "MIT"
LICENSE:${PN}-typedarray = "MIT"
LICENSE:${PN}-typescript = "Apache-2.0"
LICENSE:${PN}-typical = "MIT"
LICENSE:${PN}-unicode-trie-pako = "MIT"
LICENSE:${PN}-unicode-trie = "MIT"
LICENSE:${PN}-urijs = "MIT"
LICENSE:${PN}-util-deprecate = "MIT"
LICENSE:${PN}-uuid = "MIT"
LICENSE:${PN}-vlq = "MIT"
LICENSE:${PN}-webidl-conversions = "BSD-2-Clause"
LICENSE:${PN}-whatwg-fetch = "MIT"
LICENSE:${PN}-whatwg-url = "MIT"
LICENSE:${PN}-which = "ISC"
LICENSE:${PN}-which-module = "ISC"
LICENSE:${PN}-word-wrap = "MIT"
LICENSE:${PN}-wordwrap = "MIT"
LICENSE:${PN}-wordwrapjs = "MIT"
LICENSE:${PN}-wrap-ansi-ansi-regex = "MIT"
LICENSE:${PN}-wrap-ansi-is-fullwidth-code-point = "MIT"
LICENSE:${PN}-wrap-ansi-string-width = "MIT"
LICENSE:${PN}-wrap-ansi-strip-ansi = "MIT"
LICENSE:${PN}-wrap-ansi = "MIT"
LICENSE:${PN}-wrappy = "ISC"
LICENSE:${PN}-xtend = "MIT"
LICENSE:${PN}-y18n = "ISC"
LICENSE:${PN}-yaml = "ISC"
LICENSE:${PN}-yargs = "MIT"
LICENSE:${PN}-yargs-parser = "ISC"

RDEPENDS:${PN}:append:class-nativesdk = " nodejs"

BBCLASSEXTEND = "native nativesdk"

--nextPart1873295.tdWV9SEqCh
Content-Disposition: attachment; filename="npm-shrinkwrap.json"
Content-Transfer-Encoding: base64
Content-Type: application/json; name="npm-shrinkwrap.json"

ewogICJuYW1lIjogInF1aWNrdHlwZSIsCiAgInZlcnNpb24iOiAiMTUuMC4yNjAiLAogICJsb2Nr
ZmlsZVZlcnNpb24iOiAxLAogICJyZXF1aXJlcyI6IHRydWUsCiAgImRlcGVuZGVuY2llcyI6IHsK
ICAgICJAbWFyay5wcm9ic3QvdHlwZXNjcmlwdC1qc29uLXNjaGVtYSI6IHsKICAgICAgInZlcnNp
b24iOiAiMC4zMi4wIiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMu
b3JnL0BtYXJrLnByb2JzdC90eXBlc2NyaXB0LWpzb24tc2NoZW1hLy0vdHlwZXNjcmlwdC1qc29u
LXNjaGVtYS0wLjMyLjAudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGE1MTItT29EKzVEN01r
YTgwRkljbXZQeXVBS1Y3ZzVPZjVTMDRSNzRTNERUQUc4cHI5UkVEV3lTVWg5cE9sb3JvN1NORndX
dC8rMmY5MHd5UCtEdEdIeWtWZmc9PSIsCiAgICAgICJyZXF1aXJlcyI6IHsKICAgICAgICAiZ2xv
YiI6ICJ+Ny4xLjMiLAogICAgICAgICJqc29uLXN0YWJsZS1zdHJpbmdpZnkiOiAiXjEuMC4xIiwK
ICAgICAgICAidHlwZXNjcmlwdCI6ICJ+My4yLjEiLAogICAgICAgICJ5YXJncyI6ICJeMTIuMC41
IgogICAgICB9CiAgICB9LAogICAgIkBtYXJrLnByb2JzdC91bmljb2RlLXByb3BlcnRpZXMiOiB7
CiAgICAgICJ2ZXJzaW9uIjogIjEuMS4wIiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVn
aXN0cnkubnBtanMub3JnL0BtYXJrLnByb2JzdC91bmljb2RlLXByb3BlcnRpZXMvLS91bmljb2Rl
LXByb3BlcnRpZXMtMS4xLjAudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGE1MTItN0FRc08w
aE1tcHFEbGVkVjdBaEJ1U1lxWVBGc0tQOVBhbHRNZWNYOW5sbnN5RnhxdHNxVWc5L3B2QjJML2p4
dnNrckRyTmtkS1l6MktUYlF6bkN0bmc9PSIsCiAgICAgICJyZXF1aXJlcyI6IHsKICAgICAgICAi
YnJmcyI6ICJeMS40LjAiLAogICAgICAgICJ1bmljb2RlLXRyaWUiOiAiXjAuMy4wIgogICAgICB9
CiAgICB9LAogICAgImFjb3JuIjogewogICAgICAidmVyc2lvbiI6ICI3LjQuMSIsCiAgICAgICJy
ZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9hY29ybi8tL2Fjb3JuLTcuNC4x
LnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEyLW5ReXAwbzEvbU5kYlRPMVBPNmtIa3dT
cm1nWjBNVC9qQ0NwTml3YlVqR29STjRkbEJocUp0b1F1Q25FT0t6Z1RWd2cwWldpQ29ReTZTeE1l
YlFWaDhBPT0iCiAgICB9LAogICAgImFuc2ktcmVnZXgiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjMu
MC4wIiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL2Fuc2kt
cmVnZXgvLS9hbnNpLXJlZ2V4LTMuMC4wLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhMS03
UU1Yd3lJR1QzbEdiQUtXYTkyMkJhczMyWmc9IgogICAgfSwKICAgICJhbnNpLXN0eWxlcyI6IHsK
ICAgICAgInZlcnNpb24iOiAiMy4yLjEiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdp
c3RyeS5ucG1qcy5vcmcvYW5zaS1zdHlsZXMvLS9hbnNpLXN0eWxlcy0zLjIuMS50Z3oiLAogICAg
ICAiaW50ZWdyaXR5IjogInNoYTUxMi1WVDBaSTZrWlJkVGg4WXlKdzNTTWJZbS91K05xZnNBeEVw
V08wUGY5c3E4L2U5NFd4eE9wUEt4OUZSMUZseUN0T1ZETk9RKzhudGxxRnhpUmMrcjVxQT09IiwK
ICAgICAgInJlcXVpcmVzIjogewogICAgICAgICJjb2xvci1jb252ZXJ0IjogIl4xLjkuMCIKICAg
ICAgfQogICAgfSwKICAgICJhcnJheS1iYWNrIjogewogICAgICAidmVyc2lvbiI6ICIyLjAuMCIs
CiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9hcnJheS1iYWNr
Ly0vYXJyYXktYmFjay0yLjAuMC50Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTUxMi1lSnY0
cExMdWZQM2c1a2NacnkwajZXWHBJYnpZdzlHVUI0bVZKWm5vOXdmd2lCeGJpelRuSEN3M1ZKYjA3
Y0JpaGJGWDQ4WTdvU3JXOXkrZ3Q0Z2x5dz09IiwKICAgICAgInJlcXVpcmVzIjogewogICAgICAg
ICJ0eXBpY2FsIjogIl4yLjYuMSIKICAgICAgfQogICAgfSwKICAgICJiYWxhbmNlZC1tYXRjaCI6
IHsKICAgICAgInZlcnNpb24iOiAiMS4wLjIiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9y
ZWdpc3RyeS5ucG1qcy5vcmcvYmFsYW5jZWQtbWF0Y2gvLS9iYWxhbmNlZC1tYXRjaC0xLjAuMi50
Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTUxMi0zb1NlVU8wVE1WNjdoTjFBbWJYc0s0eWFx
VTd0amlIbGJ4UkRaT3BIMEtXOStDZVg0YlJBYVgwQW54dDB0eDJNcnBScFd3UWFQd0lsSVNFSmhZ
VTVQdz09IgogICAgfSwKICAgICJicmFjZS1leHBhbnNpb24iOiB7CiAgICAgICJ2ZXJzaW9uIjog
IjEuMS4xMSIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9i
cmFjZS1leHBhbnNpb24vLS9icmFjZS1leHBhbnNpb24tMS4xLjExLnRneiIsCiAgICAgICJpbnRl
Z3JpdHkiOiAic2hhNTEyLWlDdVBIREZnckhYN0gydkVJLzV4cHowN3pTSEIwMFRwdWdxaG1ZdFZt
TU82NTE4bUN1Uk1vT1lGbGRFQmwwZzE4N3Vmb3pkYUhnV0tjWUZiNjFxR2lBPT0iLAogICAgICAi
cmVxdWlyZXMiOiB7CiAgICAgICAgImJhbGFuY2VkLW1hdGNoIjogIl4xLjAuMCIsCiAgICAgICAg
ImNvbmNhdC1tYXAiOiAiMC4wLjEiCiAgICAgIH0KICAgIH0sCiAgICAiYnJmcyI6IHsKICAgICAg
InZlcnNpb24iOiAiMS42LjEiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5u
cG1qcy5vcmcvYnJmcy8tL2JyZnMtMS42LjEudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGE1
MTItT2ZacEFCUlFRZitYc21qdThYRTliRGpzK3VVNHZMUkVHb2xQN2JEZ2Nwc0kxN1FSRXlaNEJs
KzJLTHh4eDFrQ2dBMGZBSWhLUUJhQlloK1BFY0NxWVE9PSIsCiAgICAgICJyZXF1aXJlcyI6IHsK
ICAgICAgICAicXVvdGUtc3RyZWFtIjogIl4xLjAuMSIsCiAgICAgICAgInJlc29sdmUiOiAiXjEu
MS41IiwKICAgICAgICAic3RhdGljLW1vZHVsZSI6ICJeMi4yLjAiLAogICAgICAgICJ0aHJvdWdo
MiI6ICJeMi4wLjAiCiAgICAgIH0KICAgIH0sCiAgICAiYnJvd3Nlci1vci1ub2RlIjogewogICAg
ICAidmVyc2lvbiI6ICIxLjMuMCIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5
Lm5wbWpzLm9yZy9icm93c2VyLW9yLW5vZGUvLS9icm93c2VyLW9yLW5vZGUtMS4zLjAudGd6IiwK
ICAgICAgImludGVncml0eSI6ICJzaGE1MTItMEYyei9WU25MYm1FZUJjVXJTdURINWwwSHhUWGRR
UXpMamttQlI0Y1lmdmcxekpyS1NsbUlaRnF5RlI4b1gwTnJ3UGh5M2MzSFE2aTNPeE1iZXc0VGc9
PSIKICAgIH0sCiAgICAiYnVmZmVyLWVxdWFsIjogewogICAgICAidmVyc2lvbiI6ICIwLjAuMSIs
CiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9idWZmZXItZXF1
YWwvLS9idWZmZXItZXF1YWwtMC4wLjEudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGExLWti
eDBzUjZrQmJ5UmE4YXFrSStxK2x0S3JFcz0iCiAgICB9LAogICAgImJ1ZmZlci1mcm9tIjogewog
ICAgICAidmVyc2lvbiI6ICIxLjEuMiIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lz
dHJ5Lm5wbWpzLm9yZy9idWZmZXItZnJvbS8tL2J1ZmZlci1mcm9tLTEuMS4yLnRneiIsCiAgICAg
ICJpbnRlZ3JpdHkiOiAic2hhNTEyLUUrWFFDUndTYmFhaUNodHY2azZEd2djK2J4K0JzNnZ1S0pI
SGw1a294L0JhS2JoaVh6cVFPd0s0Y08yMnlFbEdwMk9DbWp3VmhUM0hteGd5UEduSmZRPT0iCiAg
ICB9LAogICAgImNhbWVsY2FzZSI6IHsKICAgICAgInZlcnNpb24iOiAiNS4zLjEiLAogICAgICAi
cmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvY2FtZWxjYXNlLy0vY2FtZWxj
YXNlLTUuMy4xLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEyLUwyOFNUQjE3MG53V1M2
M1VqdGxFT0UzZGxkUUFwYUpYWmtPSTF1TUZmemYzclJ1UGVnSGFIZXN5ZWUrWXhRK1c2U3ZSRFFW
NlVyZE9kUmlSMTUzd0pnPT0iCiAgICB9LAogICAgImNoYWxrIjogewogICAgICAidmVyc2lvbiI6
ICIyLjQuMiIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9j
aGFsay8tL2NoYWxrLTIuNC4yLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEyLU10aStm
OWxwSk5jd0Y0dFdWOC9PclRUdEYxZ1ppK2Y4RnFseUFkb3VyYWxjRldGUVdGMitOZ0NIU2hqa0Ni
K0lGQkxxOWJ1WndFMXhja1FVNHBlU3VRPT0iLAogICAgICAicmVxdWlyZXMiOiB7CiAgICAgICAg
ImFuc2ktc3R5bGVzIjogIl4zLjIuMSIsCiAgICAgICAgImVzY2FwZS1zdHJpbmctcmVnZXhwIjog
Il4xLjAuNSIsCiAgICAgICAgInN1cHBvcnRzLWNvbG9yIjogIl41LjMuMCIKICAgICAgfQogICAg
fSwKICAgICJjbGl1aSI6IHsKICAgICAgInZlcnNpb24iOiAiNC4xLjAiLAogICAgICAicmVzb2x2
ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvY2xpdWkvLS9jbGl1aS00LjEuMC50Z3oi
LAogICAgICAiaW50ZWdyaXR5IjogInNoYTUxMi00RkcrUlNHOURMN3VFd1JVWlhabjNTUzM0RGlE
UGZ6UDBWT2lFd3RVV2xFK0FSMkVJZytoU3l2cklnVVVmaGRnUi9Va0FlVzJRSGdlUCtoV3JYczdq
UT09IiwKICAgICAgInJlcXVpcmVzIjogewogICAgICAgICJzdHJpbmctd2lkdGgiOiAiXjIuMS4x
IiwKICAgICAgICAic3RyaXAtYW5zaSI6ICJeNC4wLjAiLAogICAgICAgICJ3cmFwLWFuc2kiOiAi
XjIuMC4wIgogICAgICB9CiAgICB9LAogICAgImNvZGUtcG9pbnQtYXQiOiB7CiAgICAgICJ2ZXJz
aW9uIjogIjEuMS4wIiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMu
b3JnL2NvZGUtcG9pbnQtYXQvLS9jb2RlLXBvaW50LWF0LTEuMS4wLnRneiIsCiAgICAgICJpbnRl
Z3JpdHkiOiAic2hhMS1EUWNMVFFRNlcrb3pvdkdrRGk3YlBacE16M2M9IgogICAgfSwKICAgICJj
b2xsZWN0aW9uLXV0aWxzIjogewogICAgICAidmVyc2lvbiI6ICIxLjAuMSIsCiAgICAgICJyZXNv
bHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9jb2xsZWN0aW9uLXV0aWxzLy0vY29s
bGVjdGlvbi11dGlscy0xLjAuMS50Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTUxMi1MQTJZ
VElsUjdiaVNwWGtLWXd3dXpHandMNXJqV0VaVk9TbnZkVWM3Z09idldlNFdranhPcGZyZGhvUDdI
czA5WVdEVmZnME1hbDlCcEFxTGZWRXpRZz09IgogICAgfSwKICAgICJjb2xvci1jb252ZXJ0Ijog
ewogICAgICAidmVyc2lvbiI6ICIxLjkuMyIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3Jl
Z2lzdHJ5Lm5wbWpzLm9yZy9jb2xvci1jb252ZXJ0Ly0vY29sb3ItY29udmVydC0xLjkuMy50Z3oi
LAogICAgICAiaW50ZWdyaXR5IjogInNoYTUxMi1RZkFVdGQrdkZkQXRGUWNDOENDeVl0MWZZV3hT
cUFpSzJjU0Q2ekRCOE4zY3BzRUJBdlJ4cDl6T0dnNkcvU0hISllBVDg4L2F6L0l1REdBTHNOVmJH
Zz09IiwKICAgICAgInJlcXVpcmVzIjogewogICAgICAgICJjb2xvci1uYW1lIjogIjEuMS4zIgog
ICAgICB9CiAgICB9LAogICAgImNvbG9yLW5hbWUiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjEuMS4z
IiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL2NvbG9yLW5h
bWUvLS9jb2xvci1uYW1lLTEuMS4zLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhMS1wOUJW
aTlpY1F2ZVYzVUl5ajNRSU1jcFR2Q1U9IgogICAgfSwKICAgICJjb21tYW5kLWxpbmUtYXJncyI6
IHsKICAgICAgInZlcnNpb24iOiAiNC4wLjciLAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9y
ZWdpc3RyeS5ucG1qcy5vcmcvY29tbWFuZC1saW5lLWFyZ3MvLS9jb21tYW5kLWxpbmUtYXJncy00
LjAuNy50Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTUxMi1hVWRQdlFSQXlCdlFkMm43alhj
c01EejY4Y2tCSkVMWE56QnliQ0hPaWJVV0VnMG1XVG5hWUNTUlU4aDlSK2FOUlN2RGloSnRzc1NS
Q2lEUnBMYWV6QT09IiwKICAgICAgInJlcXVpcmVzIjogewogICAgICAgICJhcnJheS1iYWNrIjog
Il4yLjAuMCIsCiAgICAgICAgImZpbmQtcmVwbGFjZSI6ICJeMS4wLjMiLAogICAgICAgICJ0eXBp
Y2FsIjogIl4yLjYuMSIKICAgICAgfQogICAgfSwKICAgICJjb21tYW5kLWxpbmUtdXNhZ2UiOiB7
CiAgICAgICJ2ZXJzaW9uIjogIjUuMC41IiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVn
aXN0cnkubnBtanMub3JnL2NvbW1hbmQtbGluZS11c2FnZS8tL2NvbW1hbmQtbGluZS11c2FnZS01
LjAuNS50Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTUxMi1kOE5yR3lsQTVvQ1hTYkdvS3ow
NUZrZWhEQXpTbUltNEswM1M1VkRoNGQ1bFpBdFRXZmMzRDFSdUVUdHVRQ244MTI5bllmSmZEZEY3
UC9sd2N6MUJsQT09IiwKICAgICAgInJlcXVpcmVzIjogewogICAgICAgICJhcnJheS1iYWNrIjog
Il4yLjAuMCIsCiAgICAgICAgImNoYWxrIjogIl4yLjQuMSIsCiAgICAgICAgInRhYmxlLWxheW91
dCI6ICJeMC40LjMiLAogICAgICAgICJ0eXBpY2FsIjogIl4yLjYuMSIKICAgICAgfQogICAgfSwK
ICAgICJjb25jYXQtbWFwIjogewogICAgICAidmVyc2lvbiI6ICIwLjAuMSIsCiAgICAgICJyZXNv
bHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9jb25jYXQtbWFwLy0vY29uY2F0LW1h
cC0wLjAuMS50Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTEtMktscjEzL1dqZmQ1T25NRGFq
dWcxVUJkUjNzPSIKICAgIH0sCiAgICAiY29uY2F0LXN0cmVhbSI6IHsKICAgICAgInZlcnNpb24i
OiAiMS42LjIiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcv
Y29uY2F0LXN0cmVhbS8tL2NvbmNhdC1zdHJlYW0tMS42LjIudGd6IiwKICAgICAgImludGVncml0
eSI6ICJzaGE1MTItMjdIQmdoSnhqaVp0SWszWWN2bi80a2JKay8xdVp1SkZmdVBFbnM2TGFFdnB2
RzFmMGhUZWE4bGlscm91eW85bVZjMkdXZGNFWjhPTG9HbVNBRGxyQ3c9PSIsCiAgICAgICJyZXF1
aXJlcyI6IHsKICAgICAgICAiYnVmZmVyLWZyb20iOiAiXjEuMC4wIiwKICAgICAgICAiaW5oZXJp
dHMiOiAiXjIuMC4zIiwKICAgICAgICAicmVhZGFibGUtc3RyZWFtIjogIl4yLjIuMiIsCiAgICAg
ICAgInR5cGVkYXJyYXkiOiAiXjAuMC42IgogICAgICB9CiAgICB9LAogICAgImNvbnZlcnQtc291
cmNlLW1hcCI6IHsKICAgICAgInZlcnNpb24iOiAiMS44LjAiLAogICAgICAicmVzb2x2ZWQiOiAi
aHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvY29udmVydC1zb3VyY2UtbWFwLy0vY29udmVydC1z
b3VyY2UtbWFwLTEuOC4wLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEyLStPUWRqUDQ5
elZpSS82aTduSUpwQThyQWw0c1YvSmRQZlU5blpzM1ZxT3dHSWdpeklDdnVOMnJ1NmZNZCs0bGxM
MHRhcjE4VVlKWGZaL1RXdG1oVWpBPT0iLAogICAgICAicmVxdWlyZXMiOiB7CiAgICAgICAgInNh
ZmUtYnVmZmVyIjogIn41LjEuMSIKICAgICAgfQogICAgfSwKICAgICJjb3JlLXV0aWwtaXMiOiB7
CiAgICAgICJ2ZXJzaW9uIjogIjEuMC4zIiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVn
aXN0cnkubnBtanMub3JnL2NvcmUtdXRpbC1pcy8tL2NvcmUtdXRpbC1pcy0xLjAuMy50Z3oiLAog
ICAgICAiaW50ZWdyaXR5IjogInNoYTUxMi1aUUJ2aTFEY3BKNEdEcWFuanVjWjJIajN3RU81cFpE
Uzg5Qldia2NydmR4a3NKb3J3VUREWmFtWDlsZEZrcDlhdzJsbUJETGdrT2JFQTREV05KOUZZUT09
IgogICAgfSwKICAgICJjcm9zcy1zcGF3biI6IHsKICAgICAgInZlcnNpb24iOiAiNi4wLjUiLAog
ICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvY3Jvc3Mtc3Bhd24v
LS9jcm9zcy1zcGF3bi02LjAuNS50Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTUxMi1lVFZM
ckJTdDdmamJEeWd6ODA1cE1uc3RJczJWVEJOa1JtMHF4WmQrTTdBNVhEZHhWUldPNU14R0JYWmhq
WTRjcUxZTGR0ckdxUmY4bUJQbXp3U3BXUT09IiwKICAgICAgInJlcXVpcmVzIjogewogICAgICAg
ICJuaWNlLXRyeSI6ICJeMS4wLjQiLAogICAgICAgICJwYXRoLWtleSI6ICJeMi4wLjEiLAogICAg
ICAgICJzZW12ZXIiOiAiXjUuNS4wIiwKICAgICAgICAic2hlYmFuZy1jb21tYW5kIjogIl4xLjIu
MCIsCiAgICAgICAgIndoaWNoIjogIl4xLjIuOSIKICAgICAgfQogICAgfSwKICAgICJkZWNhbWVs
aXplIjogewogICAgICAidmVyc2lvbiI6ICIxLjIuMCIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRw
czovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9kZWNhbWVsaXplLy0vZGVjYW1lbGl6ZS0xLjIuMC50Z3oi
LAogICAgICAiaW50ZWdyaXR5IjogInNoYTEtOWxOTkZSU0NhYklEVXVlKzRtOVFINW9aRXBBPSIK
ICAgIH0sCiAgICAiZGVlcC1leHRlbmQiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjAuNi4wIiwKICAg
ICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL2RlZXAtZXh0ZW5kLy0v
ZGVlcC1leHRlbmQtMC42LjAudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGE1MTItTE9IeElP
YVBZZEhsSlJ0Q1FmRElWWnRmdy91Zk04K3JWajY0OVJJSHpjbS92R3dRUlhGdDZPUHFJRldzbTJY
RU1yTklFdFdSNjRzWTFMRUtEMnZBT0E9PSIKICAgIH0sCiAgICAiZGVlcC1pcyI6IHsKICAgICAg
InZlcnNpb24iOiAiMC4xLjQiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5u
cG1qcy5vcmcvZGVlcC1pcy8tL2RlZXAtaXMtMC4xLjQudGd6IiwKICAgICAgImludGVncml0eSI6
ICJzaGE1MTItb0lQemtzbVRnNC9NcmlpYVlHTytva1hEVDd6dG4vdzNFcHR2LytnU0lkTWRLc0pv
MHU0Q2ZZTkZKUHkrNFNLTXVDcUd3Mnd4bkErVVJNZzN0OGEvYlE9PSIKICAgIH0sCiAgICAiZHVw
bGV4ZXIyIjogewogICAgICAidmVyc2lvbiI6ICIwLjEuNCIsCiAgICAgICJyZXNvbHZlZCI6ICJo
dHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9kdXBsZXhlcjIvLS9kdXBsZXhlcjItMC4xLjQudGd6
IiwKICAgICAgImludGVncml0eSI6ICJzaGExLWl4TGF1SGpBMXA0K2VKRUZGbUtqTDhhOTNNRT0i
LAogICAgICAicmVxdWlyZXMiOiB7CiAgICAgICAgInJlYWRhYmxlLXN0cmVhbSI6ICJeMi4wLjIi
CiAgICAgIH0KICAgIH0sCiAgICAiZW5jb2RpbmciOiB7CiAgICAgICJ2ZXJzaW9uIjogIjAuMS4x
MyIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9lbmNvZGlu
Zy8tL2VuY29kaW5nLTAuMS4xMy50Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTUxMi1FVEJh
dW93MVQzNVkvV1pNa2lvOWppTTBaNXhqSEhtSjRYbWpaT3ExbC9kWHozbHIyc1JuODduSnkyMFJ1
cHFTaDFGMm0zSEhQU3A4U2hJUFFKckozQT09IiwKICAgICAgInJlcXVpcmVzIjogewogICAgICAg
ICJpY29udi1saXRlIjogIl4wLjYuMiIKICAgICAgfQogICAgfSwKICAgICJlbmQtb2Ytc3RyZWFt
IjogewogICAgICAidmVyc2lvbiI6ICIxLjQuNCIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczov
L3JlZ2lzdHJ5Lm5wbWpzLm9yZy9lbmQtb2Ytc3RyZWFtLy0vZW5kLW9mLXN0cmVhbS0xLjQuNC50
Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTUxMi0rdXcxaW5JSFZQUW9hVnVIelJ5WGQyMWlj
TStjbnQ0Q3pENXJXK05DMXdqT1VTVE9zK1RlN0ZPdjdBaE43dlM5eC9vSXloTFA1UFIxSCtwaFFB
SHU1UT09IiwKICAgICAgInJlcXVpcmVzIjogewogICAgICAgICJvbmNlIjogIl4xLjQuMCIKICAg
ICAgfQogICAgfSwKICAgICJlc2NhcGUtc3RyaW5nLXJlZ2V4cCI6IHsKICAgICAgInZlcnNpb24i
OiAiMS4wLjUiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcv
ZXNjYXBlLXN0cmluZy1yZWdleHAvLS9lc2NhcGUtc3RyaW5nLXJlZ2V4cC0xLjAuNS50Z3oiLAog
ICAgICAiaW50ZWdyaXR5IjogInNoYTEtRzJIQVZpR1FxTi8ycmp1eXp3SUF5aE1MaHRRPSIKICAg
IH0sCiAgICAiZXNjb2RlZ2VuIjogewogICAgICAidmVyc2lvbiI6ICIxLjkuMSIsCiAgICAgICJy
ZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9lc2NvZGVnZW4vLS9lc2NvZGVn
ZW4tMS45LjEudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGE1MTItNmhUak8xTkFXa0huRGsz
T3FRNFlyQ3V3d21HSEw5UzNuUGx6Qk9VRy9SNDRyZGEzd0xOcmZ2UTVma1NHanloSEZLTTdBTFBL
Y0tHcnd2Q0xlMGxDN1E9PSIsCiAgICAgICJyZXF1aXJlcyI6IHsKICAgICAgICAiZXNwcmltYSI6
ICJeMy4xLjMiLAogICAgICAgICJlc3RyYXZlcnNlIjogIl40LjIuMCIsCiAgICAgICAgImVzdXRp
bHMiOiAiXjIuMC4yIiwKICAgICAgICAib3B0aW9uYXRvciI6ICJeMC44LjEiLAogICAgICAgICJz
b3VyY2UtbWFwIjogIn4wLjYuMSIKICAgICAgfQogICAgfSwKICAgICJlc3ByaW1hIjogewogICAg
ICAidmVyc2lvbiI6ICIzLjEuMyIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5
Lm5wbWpzLm9yZy9lc3ByaW1hLy0vZXNwcmltYS0zLjEuMy50Z3oiLAogICAgICAiaW50ZWdyaXR5
IjogInNoYTEtL2NwUnp1WVRPSlhqeUkxVFhPU2R2L1lxUmpNPSIKICAgIH0sCiAgICAiZXN0cmF2
ZXJzZSI6IHsKICAgICAgInZlcnNpb24iOiAiNC4zLjAiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0
cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvZXN0cmF2ZXJzZS8tL2VzdHJhdmVyc2UtNC4zLjAudGd6
IiwKICAgICAgImludGVncml0eSI6ICJzaGE1MTItMzlubktmZld6OHhOMUJVLzJjNzluOW5COUhE
em8wbmlZVXF4Nnh5cVVueW9BblF5eVdwT1RkWkVlaUNjaDhCQnU1MTV0NHdwOVptZ1ZmVmhuOUVC
cHc9PSIKICAgIH0sCiAgICAiZXN1dGlscyI6IHsKICAgICAgInZlcnNpb24iOiAiMi4wLjMiLAog
ICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvZXN1dGlscy8tL2Vz
dXRpbHMtMi4wLjMudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGE1MTIta1ZzY3FYazRPQ3A2
OFNaMGRrZ0VLVmk2LzhpajMwMEtCV1RKcTMyUC9kWWVXVFN3SzQxV3lUeGFsTjFlUm1BNVo5VVUv
TFg5RDdGV1NtVjlTQVl4Nmc9PSIKICAgIH0sCiAgICAiZXhlY2EiOiB7CiAgICAgICJ2ZXJzaW9u
IjogIjEuMC4wIiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3Jn
L2V4ZWNhLy0vZXhlY2EtMS4wLjAudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGE1MTItYWRi
eGN5V1Y0NnFpSHl2U3A1MFRLdDA1dEI0dEszSGNtRjcvbnhmQWRobm94ODNzZVREYnduYXFLTzRz
WFJ5N3JvSEFJRnFKUC9Sdy9BdUViWDYxTEE9PSIsCiAgICAgICJyZXF1aXJlcyI6IHsKICAgICAg
ICAiY3Jvc3Mtc3Bhd24iOiAiXjYuMC4wIiwKICAgICAgICAiZ2V0LXN0cmVhbSI6ICJeNC4wLjAi
LAogICAgICAgICJpcy1zdHJlYW0iOiAiXjEuMS4wIiwKICAgICAgICAibnBtLXJ1bi1wYXRoIjog
Il4yLjAuMCIsCiAgICAgICAgInAtZmluYWxseSI6ICJeMS4wLjAiLAogICAgICAgICJzaWduYWwt
ZXhpdCI6ICJeMy4wLjAiLAogICAgICAgICJzdHJpcC1lb2YiOiAiXjEuMC4wIgogICAgICB9CiAg
ICB9LAogICAgImZhbGFmZWwiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjIuMi40IiwKICAgICAgInJl
c29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL2ZhbGFmZWwvLS9mYWxhZmVsLTIu
Mi40LnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEyLTBIWGpvOFhBU1dSbXNTMFgxRWto
d0VNWmFEM1F2cDdGZlVSd2pMS2pHMWdoZlJtL01HWmwycjRjV1VUdjQxS2ROZ2hUdzRPVU1tVnRk
R1FwMytIK3VRPT0iLAogICAgICAicmVxdWlyZXMiOiB7CiAgICAgICAgImFjb3JuIjogIl43LjEu
MSIsCiAgICAgICAgImZvcmVhY2giOiAiXjIuMC41IiwKICAgICAgICAiaXNhcnJheSI6ICJeMi4w
LjEiLAogICAgICAgICJvYmplY3Qta2V5cyI6ICJeMS4wLjYiCiAgICAgIH0sCiAgICAgICJkZXBl
bmRlbmNpZXMiOiB7CiAgICAgICAgImlzYXJyYXkiOiB7CiAgICAgICAgICAidmVyc2lvbiI6ICIy
LjAuNSIsCiAgICAgICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcv
aXNhcnJheS8tL2lzYXJyYXktMi4wLjUudGd6IiwKICAgICAgICAgICJpbnRlZ3JpdHkiOiAic2hh
NTEyLXhIamhEcjNjTkJLMEJ6ZFVKU1BYWm50UVV4L213TVM1Unc0QTdsUEo5MFhHQU82SVNQL2VQ
RE51bzB2aHFPWlUrVUQ1Sm9vZHdDQUFvWlFkM0ZlQUt3PT0iCiAgICAgICAgfQogICAgICB9CiAg
ICB9LAogICAgImZhc3QtbGV2ZW5zaHRlaW4iOiB7CiAgICAgICJ2ZXJzaW9uIjogIjIuMC42IiwK
ICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL2Zhc3QtbGV2ZW5z
aHRlaW4vLS9mYXN0LWxldmVuc2h0ZWluLTIuMC42LnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAi
c2hhMS1QWXBjWm9nNkZxTU1xR1EraFI4WnVxZDVlUmM9IgogICAgfSwKICAgICJmaW5kLXJlcGxh
Y2UiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjEuMC4zIiwKICAgICAgInJlc29sdmVkIjogImh0dHBz
Oi8vcmVnaXN0cnkubnBtanMub3JnL2ZpbmQtcmVwbGFjZS8tL2ZpbmQtcmVwbGFjZS0xLjAuMy50
Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTEtdUk1elpOTFp5VmxWbnppTVptY05ZVEJFSDZB
PSIsCiAgICAgICJyZXF1aXJlcyI6IHsKICAgICAgICAiYXJyYXktYmFjayI6ICJeMS4wLjQiLAog
ICAgICAgICJ0ZXN0LXZhbHVlIjogIl4yLjEuMCIKICAgICAgfSwKICAgICAgImRlcGVuZGVuY2ll
cyI6IHsKICAgICAgICAiYXJyYXktYmFjayI6IHsKICAgICAgICAgICJ2ZXJzaW9uIjogIjEuMC40
IiwKICAgICAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9hcnJh
eS1iYWNrLy0vYXJyYXktYmFjay0xLjAuNC50Z3oiLAogICAgICAgICAgImludGVncml0eSI6ICJz
aGExLVpFdW44SlgzLzg5OFE3WHczRG5Ud2ZBOEJqcz0iLAogICAgICAgICAgInJlcXVpcmVzIjog
ewogICAgICAgICAgICAidHlwaWNhbCI6ICJeMi42LjAiCiAgICAgICAgICB9CiAgICAgICAgfQog
ICAgICB9CiAgICB9LAogICAgImZpbmQtdXAiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjMuMC4wIiwK
ICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL2ZpbmQtdXAvLS9m
aW5kLXVwLTMuMC4wLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEyLTF5RDZSbUxJMVhC
Znh1Z3ZPUndsY2s2Zjc1dFlMK2lSMGpxd3NPck94TVp5R1lxVXVEaEowbDRBWGRPMWlYL0ZUczlj
QkFNRWsxZ1dTRXgxa1NieWxnPT0iLAogICAgICAicmVxdWlyZXMiOiB7CiAgICAgICAgImxvY2F0
ZS1wYXRoIjogIl4zLjAuMCIKICAgICAgfQogICAgfSwKICAgICJmb3JlYWNoIjogewogICAgICAi
dmVyc2lvbiI6ICIyLjAuNSIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5w
bWpzLm9yZy9mb3JlYWNoLy0vZm9yZWFjaC0yLjAuNS50Z3oiLAogICAgICAiaW50ZWdyaXR5Ijog
InNoYTEtQys0QVVCaXVzbURRbzY4NjVsamRBVGJzRzVrPSIKICAgIH0sCiAgICAiZnMucmVhbHBh
dGgiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjEuMC4wIiwKICAgICAgInJlc29sdmVkIjogImh0dHBz
Oi8vcmVnaXN0cnkubnBtanMub3JnL2ZzLnJlYWxwYXRoLy0vZnMucmVhbHBhdGgtMS4wLjAudGd6
IiwKICAgICAgImludGVncml0eSI6ICJzaGExLUZRU3RKU01WaktwQTIwb25oOHNCUVJtVTZrOD0i
CiAgICB9LAogICAgImZ1bmN0aW9uLWJpbmQiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjEuMS4xIiwK
ICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL2Z1bmN0aW9uLWJp
bmQvLS9mdW5jdGlvbi1iaW5kLTEuMS4xLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEy
LXlJb3ZBek1YNDlzRjhZbDU4ZlNDV0o1c3ZTTHVhaWJQeFhRSkZMbUJPYlR1Q3IwTWYxS2lQb3BH
TTlOaUZqaVlCQ2JmYWEyRmg2YnJlUTZBTlZUSTBBPT0iCiAgICB9LAogICAgImdldC1jYWxsZXIt
ZmlsZSI6IHsKICAgICAgInZlcnNpb24iOiAiMS4wLjMiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0
cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvZ2V0LWNhbGxlci1maWxlLy0vZ2V0LWNhbGxlci1maWxl
LTEuMC4zLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEyLTN0NnJWVG9lb1pmWVNHZDhZ
b0xGUjJESmtpUXJJaVVyR2NqdkZYMm1EdzNibjZrMk90d0hOMFROQ0xiQk8rdzhxVHZpbWhEa3Yr
TFNzY2JKWTF2RTZ3PT0iCiAgICB9LAogICAgImdldC1zdHJlYW0iOiB7CiAgICAgICJ2ZXJzaW9u
IjogIjQuMS4wIiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3Jn
L2dldC1zdHJlYW0vLS9nZXQtc3RyZWFtLTQuMS4wLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAi
c2hhNTEyLUdNYXQ0RUo1MTYxa0l5MkhldkxscjRsdU5qQmd2bWo0MTNLYVFBN2p0NFY4QjRSRHNm
cEhrN1dROUdWcWZZeXl4OE9TL0w2NktveCtySlJOa2xMSzd3PT0iLAogICAgICAicmVxdWlyZXMi
OiB7CiAgICAgICAgInB1bXAiOiAiXjMuMC4wIgogICAgICB9CiAgICB9LAogICAgImdsb2IiOiB7
CiAgICAgICJ2ZXJzaW9uIjogIjcuMS43IiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVn
aXN0cnkubnBtanMub3JnL2dsb2IvLS9nbG9iLTcuMS43LnRneiIsCiAgICAgICJpbnRlZ3JpdHki
OiAic2hhNTEyLU92RDlFTnpQTGJlZ0VObllQNVVVZkpJaXJUZzQrWHdNV0dhUWZRVFkwSmVueE52
dklLUDNVMy90QVFTUEl1L2xIeFhZU1ptcFhsVUhlcUFJZEt6QkxRPT0iLAogICAgICAicmVxdWly
ZXMiOiB7CiAgICAgICAgImZzLnJlYWxwYXRoIjogIl4xLjAuMCIsCiAgICAgICAgImluZmxpZ2h0
IjogIl4xLjAuNCIsCiAgICAgICAgImluaGVyaXRzIjogIjIiLAogICAgICAgICJtaW5pbWF0Y2gi
OiAiXjMuMC40IiwKICAgICAgICAib25jZSI6ICJeMS4zLjAiLAogICAgICAgICJwYXRoLWlzLWFi
c29sdXRlIjogIl4xLjAuMCIKICAgICAgfQogICAgfSwKICAgICJncmFwaHFsIjogewogICAgICAi
dmVyc2lvbiI6ICIwLjExLjciLAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5u
cG1qcy5vcmcvZ3JhcGhxbC8tL2dyYXBocWwtMC4xMS43LnRneiIsCiAgICAgICJpbnRlZ3JpdHki
OiAic2hhNTEyLXg3dURqeXo4SngrUVBicENGQ01ROGxsdG5RYTRwNHZTWUh4NkFEZThyVllSVGRz
eWhDSmJ2U3R5NURBc0xWbVU2Y0dha2wrcjhIUVlvbEtIeGsvdGl3PT0iLAogICAgICAicmVxdWly
ZXMiOiB7CiAgICAgICAgIml0ZXJhbGwiOiAiMS4xLjMiCiAgICAgIH0KICAgIH0sCiAgICAiaGFz
IjogewogICAgICAidmVyc2lvbiI6ICIxLjAuMyIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczov
L3JlZ2lzdHJ5Lm5wbWpzLm9yZy9oYXMvLS9oYXMtMS4wLjMudGd6IiwKICAgICAgImludGVncml0
eSI6ICJzaGE1MTItZjJkdk8wVlU2T2VqN1JrV0pHcmVoamJ6TUFqRnA1L1ZLUHA1dFRwV0lWNEpI
SFpLMS9CeGJGUnRmL3NpQTJTV1RlMDljYURtVnRZWXpXRUliQlM0enc9PSIsCiAgICAgICJyZXF1
aXJlcyI6IHsKICAgICAgICAiZnVuY3Rpb24tYmluZCI6ICJeMS4xLjEiCiAgICAgIH0KICAgIH0s
CiAgICAiaGFzLWZsYWciOiB7CiAgICAgICJ2ZXJzaW9uIjogIjMuMC4wIiwKICAgICAgInJlc29s
dmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL2hhcy1mbGFnLy0vaGFzLWZsYWctMy4w
LjAudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGExLXRkUlUzQ0dacmlKV21mTkdmbG9IODds
VnV2MD0iCiAgICB9LAogICAgImljb252LWxpdGUiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjAuNi4z
IiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL2ljb252LWxp
dGUvLS9pY29udi1saXRlLTAuNi4zLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEyLTRm
Q2s3OXdzaE1kek1wMnJIMDZxV3JKRTRpb2xxTGhDVUgrT2l1SWdVKytSQjArOTRObERMODFhdE83
R1g1NXVVS3VlbzB0eEhOdHZFeUk2RDdXZE13PT0iLAogICAgICAicmVxdWlyZXMiOiB7CiAgICAg
ICAgInNhZmVyLWJ1ZmZlciI6ICI+PSAyLjEuMiA8IDMuMC4wIgogICAgICB9CiAgICB9LAogICAg
ImluZmxpZ2h0IjogewogICAgICAidmVyc2lvbiI6ICIxLjAuNiIsCiAgICAgICJyZXNvbHZlZCI6
ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9pbmZsaWdodC8tL2luZmxpZ2h0LTEuMC42LnRn
eiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhMS1TYjFqTWRmUUxRd0p2SkVLRUhXNmdXVzFiZms9
IiwKICAgICAgInJlcXVpcmVzIjogewogICAgICAgICJvbmNlIjogIl4xLjMuMCIsCiAgICAgICAg
IndyYXBweSI6ICIxIgogICAgICB9CiAgICB9LAogICAgImluaGVyaXRzIjogewogICAgICAidmVy
c2lvbiI6ICIyLjAuNCIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpz
Lm9yZy9pbmhlcml0cy8tL2luaGVyaXRzLTIuMC40LnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAi
c2hhNTEyLWsvdkdhWDQvWWxhM1d6eU1DdlRRT1hZZUlIdnFPS3RucUJkdXpUSHB6cFFaekFza0tN
aFoySytFbkJpU005ekdTb0lGZU1wWEt4YTRkWWVaSVFxZXdRPT0iCiAgICB9LAogICAgImludmVy
dC1rdiI6IHsKICAgICAgInZlcnNpb24iOiAiMi4wLjAiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0
cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvaW52ZXJ0LWt2Ly0vaW52ZXJ0LWt2LTIuMC4wLnRneiIs
CiAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEyLXdQVnYveS9RUS9VaWlyai92aDNvUCsxV3crQVdl
aG1pMWc1ZkZXR1BGNklwQ0JDRFZyaGdIUk12ckxmZFljd0RoM1FKYkdYRFc0SkF1enhFbExTcUtB
PT0iCiAgICB9LAogICAgImlzLWNvcmUtbW9kdWxlIjogewogICAgICAidmVyc2lvbiI6ICIyLjgu
MCIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9pcy1jb3Jl
LW1vZHVsZS8tL2lzLWNvcmUtbW9kdWxlLTIuOC4wLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAi
c2hhNTEyLXZkMTVxSHNhcXJSTDdkdEg2UU51eTBuZEptUkRyUzlIQU0xQ0FpU2lmTlVGdjR4MWEw
Q0NWc2oxOGhKMW1TaHhJRzZUMmkxc083OE1rUDU2cjBuWVJ3PT0iLAogICAgICAicmVxdWlyZXMi
OiB7CiAgICAgICAgImhhcyI6ICJeMS4wLjMiCiAgICAgIH0KICAgIH0sCiAgICAiaXMtZnVsbHdp
ZHRoLWNvZGUtcG9pbnQiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjIuMC4wIiwKICAgICAgInJlc29s
dmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL2lzLWZ1bGx3aWR0aC1jb2RlLXBvaW50
Ly0vaXMtZnVsbHdpZHRoLWNvZGUtcG9pbnQtMi4wLjAudGd6IiwKICAgICAgImludGVncml0eSI6
ICJzaGExLW83TUtYRThaa1lNV2VxcTVPKzc2NDkzN1pVOD0iCiAgICB9LAogICAgImlzLXN0cmVh
bSI6IHsKICAgICAgInZlcnNpb24iOiAiMS4xLjAiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6
Ly9yZWdpc3RyeS5ucG1qcy5vcmcvaXMtc3RyZWFtLy0vaXMtc3RyZWFtLTEuMS4wLnRneiIsCiAg
ICAgICJpbnRlZ3JpdHkiOiAic2hhMS1FdFNqM1U1bzRMZWM2NDI4aEJjNjZBMlJ5a1E9IgogICAg
fSwKICAgICJpcy11cmwiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjEuMi40IiwKICAgICAgInJlc29s
dmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL2lzLXVybC8tL2lzLXVybC0xLjIuNC50
Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTUxMi1JVHZHaW04RmhSaVllNElRNXVIU2tqN3BW
YVBEckNUa05kM3lxM2NWN2laQWNKZEhUVU1QTUVIY3FTT3k5eFo5cUZlblFDdmkrMndqSDlhMW5Y
cUh3dz09IgogICAgfSwKICAgICJpc2FycmF5IjogewogICAgICAidmVyc2lvbiI6ICIxLjAuMCIs
CiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9pc2FycmF5Ly0v
aXNhcnJheS0xLjAuMC50Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTEtdTVOZFNGZ3N1aGFN
Qm9OSlY2VktQZ2NTVHhFPSIKICAgIH0sCiAgICAiaXNleGUiOiB7CiAgICAgICJ2ZXJzaW9uIjog
IjIuMC4wIiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL2lz
ZXhlLy0vaXNleGUtMi4wLjAudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGExLTZQdnpkTnhW
Yi9pVWVoRGNzRmN0WXo4cytoQT0iCiAgICB9LAogICAgImlzb21vcnBoaWMtZmV0Y2giOiB7CiAg
ICAgICJ2ZXJzaW9uIjogIjIuMi4xIiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0
cnkubnBtanMub3JnL2lzb21vcnBoaWMtZmV0Y2gvLS9pc29tb3JwaGljLWZldGNoLTIuMi4xLnRn
eiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhMS1ZUnJoclBGUFhvSDNLVkIwY29HZjZYTTFXS2s9
IiwKICAgICAgInJlcXVpcmVzIjogewogICAgICAgICJub2RlLWZldGNoIjogIl4xLjAuMSIsCiAg
ICAgICAgIndoYXR3Zy1mZXRjaCI6ICI+PTAuMTAuMCIKICAgICAgfSwKICAgICAgImRlcGVuZGVu
Y2llcyI6IHsKICAgICAgICAibm9kZS1mZXRjaCI6IHsKICAgICAgICAgICJ2ZXJzaW9uIjogIjEu
Ny4zIiwKICAgICAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9u
b2RlLWZldGNoLy0vbm9kZS1mZXRjaC0xLjcuMy50Z3oiLAogICAgICAgICAgImludGVncml0eSI6
ICJzaGE1MTItTmhaNENzS3g3Y1ltMnZTckJBcjJQdkZPZTZzV0RmMFVZTFJxQTZzdlVZZzcrL1RT
ZlZBdTQ5allDNEJ2UTRTbXM5U1pnZHFHQmdyb3FmRGhKZFR5S1E9PSIsCiAgICAgICAgICAicmVx
dWlyZXMiOiB7CiAgICAgICAgICAgICJlbmNvZGluZyI6ICJeMC4xLjExIiwKICAgICAgICAgICAg
ImlzLXN0cmVhbSI6ICJeMS4wLjEiCiAgICAgICAgICB9CiAgICAgICAgfQogICAgICB9CiAgICB9
LAogICAgIml0ZXJhbGwiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjEuMS4zIiwKICAgICAgInJlc29s
dmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL2l0ZXJhbGwvLS9pdGVyYWxsLTEuMS4z
LnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEyLUN1L2tiKzRIaU5TZWpBUGhTYU4xVnVr
ZE5UVGkvcjQvZSt5eWtxamxHL0lXKzFnWkg1YjQrQnEzd2hEWDR0dmJZdWd0YTNyOEtUTVVpcVQz
ZklHeHVRPT0iCiAgICB9LAogICAgImpzLWJhc2U2NCI6IHsKICAgICAgInZlcnNpb24iOiAiMi42
LjQiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvanMtYmFz
ZTY0Ly0vanMtYmFzZTY0LTIuNi40LnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEyLXBa
ZS8vR0dtd0puZHViN1pnaFZIejd2amIyTGdDMW04QjA3QXUzZVlxZXF2OWVtaEVTQnlNWHhhRWdr
VWtFcUplODdvQmJTbmlHWW9RTklCa2xjN0lRPT0iCiAgICB9LAogICAgImpzb24tc3RhYmxlLXN0
cmluZ2lmeSI6IHsKICAgICAgInZlcnNpb24iOiAiMS4wLjEiLAogICAgICAicmVzb2x2ZWQiOiAi
aHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvanNvbi1zdGFibGUtc3RyaW5naWZ5Ly0vanNvbi1z
dGFibGUtc3RyaW5naWZ5LTEuMC4xLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhMS1tbldk
T2NYeS8xQS8xVEFHUnUxRVg0akUrYTg9IiwKICAgICAgInJlcXVpcmVzIjogewogICAgICAgICJq
c29uaWZ5IjogIn4wLjAuMCIKICAgICAgfQogICAgfSwKICAgICJqc29uaWZ5IjogewogICAgICAi
dmVyc2lvbiI6ICIwLjAuMCIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5w
bWpzLm9yZy9qc29uaWZ5Ly0vanNvbmlmeS0wLjAuMC50Z3oiLAogICAgICAiaW50ZWdyaXR5Ijog
InNoYTEtTEhTMjdrSFpQS1ViZTFxdTZQVURZeDBsS25NPSIKICAgIH0sCiAgICAibGNpZCI6IHsK
ICAgICAgInZlcnNpb24iOiAiMi4wLjAiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdp
c3RyeS5ucG1qcy5vcmcvbGNpZC8tL2xjaWQtMi4wLjAudGd6IiwKICAgICAgImludGVncml0eSI6
ICJzaGE1MTItYXZQRWI4UDhFR253WEtDbHdzTlVncnlWamxsY1JxdE1ZYTQ5TlRzYlFhZ1l1VDFE
Y1hubDE5MTVveFdqb3lHclhSNnpIL1kwWmM5NnhXc1Bjb0RLZUE9PSIsCiAgICAgICJyZXF1aXJl
cyI6IHsKICAgICAgICAiaW52ZXJ0LWt2IjogIl4yLjAuMCIKICAgICAgfQogICAgfSwKICAgICJs
ZXZuIjogewogICAgICAidmVyc2lvbiI6ICIwLjMuMCIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRw
czovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9sZXZuLy0vbGV2bi0wLjMuMC50Z3oiLAogICAgICAiaW50
ZWdyaXR5IjogInNoYTEtT3dtU1R0K2ZDRHdFa1AzVXdMeEVJZUJIWk80PSIsCiAgICAgICJyZXF1
aXJlcyI6IHsKICAgICAgICAicHJlbHVkZS1scyI6ICJ+MS4xLjIiLAogICAgICAgICJ0eXBlLWNo
ZWNrIjogIn4wLjMuMiIKICAgICAgfQogICAgfSwKICAgICJsb2NhdGUtcGF0aCI6IHsKICAgICAg
InZlcnNpb24iOiAiMy4wLjAiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5u
cG1qcy5vcmcvbG9jYXRlLXBhdGgvLS9sb2NhdGUtcGF0aC0zLjAuMC50Z3oiLAogICAgICAiaW50
ZWdyaXR5IjogInNoYTUxMi03QU83NDh3V25JaE5xQXVhdHkyWldIa1FIUlNOZlBWSXNQSWZ3RU9X
TzIyQW1hb1ZyV2F2bE9jTVI1bnpUTE5ZdnAzNlgyMjAvbWFhUnNyZWMxRzY1QT09IiwKICAgICAg
InJlcXVpcmVzIjogewogICAgICAgICJwLWxvY2F0ZSI6ICJeMy4wLjAiLAogICAgICAgICJwYXRo
LWV4aXN0cyI6ICJeMy4wLjAiCiAgICAgIH0KICAgIH0sCiAgICAibG9kYXNoIjogewogICAgICAi
dmVyc2lvbiI6ICI0LjE3LjIxIiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnku
bnBtanMub3JnL2xvZGFzaC8tL2xvZGFzaC00LjE3LjIxLnRneiIsCiAgICAgICJpbnRlZ3JpdHki
OiAic2hhNTEyLXYya0RFZTU3bGVjVHVsYURJdU5UUHkzUnk0Z0xHSjZaMU8zdkUxa3JnWFpOcnNR
K0xGVEdIVnhWamNYUHMxN0xoYlpWR2VkQUp2OFhaMXR2ajVGdlNnPT0iCiAgICB9LAogICAgImxv
ZGFzaC5wYWRlbmQiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjQuNi4xIiwKICAgICAgInJlc29sdmVk
IjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL2xvZGFzaC5wYWRlbmQvLS9sb2Rhc2gucGFk
ZW5kLTQuNi4xLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhMS1VOHk2QkgwRzRWalRFZlJk
cGlYMDVKNXZGbTQ9IgogICAgfSwKICAgICJtYWdpYy1zdHJpbmciOiB7CiAgICAgICJ2ZXJzaW9u
IjogIjAuMjIuNSIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9y
Zy9tYWdpYy1zdHJpbmcvLS9tYWdpYy1zdHJpbmctMC4yMi41LnRneiIsCiAgICAgICJpbnRlZ3Jp
dHkiOiAic2hhNTEyLW9yZWlwOXJKWmt6dkE4UXprOUhGczhmWkdGL3U3SC9ndHJFOEVONlJqS0o5
a2gySGxDK3lRMlFlemlmcVRaZkd5aXVBVjBkUnY1YSt5LzhnQmIxbTl3PT0iLAogICAgICAicmVx
dWlyZXMiOiB7CiAgICAgICAgInZscSI6ICJeMC4yLjIiCiAgICAgIH0KICAgIH0sCiAgICAibWFw
LWFnZS1jbGVhbmVyIjogewogICAgICAidmVyc2lvbiI6ICIwLjEuMyIsCiAgICAgICJyZXNvbHZl
ZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9tYXAtYWdlLWNsZWFuZXIvLS9tYXAtYWdl
LWNsZWFuZXItMC4xLjMudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGE1MTItYkp6eDZuTW9Q
NlBETFBCRm1nNyt4UktlRlp2RmJvTXJHbHhtTmo5Q2x2WDUzS3Jtdk01YlhGWEVXamJ6NGN6MUFG
bitqV0o5ei9ESlN6N2hyczB3M3c9PSIsCiAgICAgICJyZXF1aXJlcyI6IHsKICAgICAgICAicC1k
ZWZlciI6ICJeMS4wLjAiCiAgICAgIH0KICAgIH0sCiAgICAibWVtIjogewogICAgICAidmVyc2lv
biI6ICI0LjMuMCIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9y
Zy9tZW0vLS9tZW0tNC4zLjAudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGE1MTItcVgyYkc0
OHBUcVlSVm1EQjM3cm4vNlBUN0xjUjhUN29BWDNiZjk5dTFUdDFuenhZZnhrZ3FEd1V3b2xQbFh3
ZU0wWHpCT0JGelN4NGtmcDdLUDFzL3c9PSIsCiAgICAgICJyZXF1aXJlcyI6IHsKICAgICAgICAi
bWFwLWFnZS1jbGVhbmVyIjogIl4wLjEuMSIsCiAgICAgICAgIm1pbWljLWZuIjogIl4yLjAuMCIs
CiAgICAgICAgInAtaXMtcHJvbWlzZSI6ICJeMi4wLjAiCiAgICAgIH0KICAgIH0sCiAgICAibWVy
Z2Utc291cmNlLW1hcCI6IHsKICAgICAgInZlcnNpb24iOiAiMS4wLjQiLAogICAgICAicmVzb2x2
ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvbWVyZ2Utc291cmNlLW1hcC8tL21lcmdl
LXNvdXJjZS1tYXAtMS4wLjQudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGExLXBkNUdVNDJ1
aE5RUlRNWHFBclIzS21OR2NCOD0iLAogICAgICAicmVxdWlyZXMiOiB7CiAgICAgICAgInNvdXJj
ZS1tYXAiOiAiXjAuNS42IgogICAgICB9LAogICAgICAiZGVwZW5kZW5jaWVzIjogewogICAgICAg
ICJzb3VyY2UtbWFwIjogewogICAgICAgICAgInZlcnNpb24iOiAiMC41LjciLAogICAgICAgICAg
InJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL3NvdXJjZS1tYXAvLS9zb3Vy
Y2UtbWFwLTAuNS43LnRneiIsCiAgICAgICAgICAiaW50ZWdyaXR5IjogInNoYTEtaWdPZExSQWgw
aTBlb1V5QTJPcEdpNkx2UDh3PSIKICAgICAgICB9CiAgICAgIH0KICAgIH0sCiAgICAibWltaWMt
Zm4iOiB7CiAgICAgICJ2ZXJzaW9uIjogIjIuMS4wIiwKICAgICAgInJlc29sdmVkIjogImh0dHBz
Oi8vcmVnaXN0cnkubnBtanMub3JnL21pbWljLWZuLy0vbWltaWMtZm4tMi4xLjAudGd6IiwKICAg
ICAgImludGVncml0eSI6ICJzaGE1MTItT3FiT2s1b0VRZUFaOFdYV3lkbHU5SEpqejlXVmRFSXZh
bU1DY1htdXFVWWpUa25IL3Nxc1d2aFEzdmd3S0ZSUjFIcGp2TkJLUTM3bmJKZ1l6R3FHY2c9PSIK
ICAgIH0sCiAgICAibWluaW1hdGNoIjogewogICAgICAidmVyc2lvbiI6ICIzLjAuNCIsCiAgICAg
ICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9taW5pbWF0Y2gvLS9taW5p
bWF0Y2gtMy4wLjQudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGE1MTIteUpIVlFFaHlxUExV
VGd0OUI4M1BYdTZXM3J4NE12dkh2U1V2VG9vZ3B3b0dET1VRK3lEclIwSFJvdCt5T0NkQ083dTRo
WDNwV2Z0NmtXQkJjcWgwVUE9PSIsCiAgICAgICJyZXF1aXJlcyI6IHsKICAgICAgICAiYnJhY2Ut
ZXhwYW5zaW9uIjogIl4xLjEuNyIKICAgICAgfQogICAgfSwKICAgICJtaW5pbWlzdCI6IHsKICAg
ICAgInZlcnNpb24iOiAiMS4yLjUiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3Ry
eS5ucG1qcy5vcmcvbWluaW1pc3QvLS9taW5pbWlzdC0xLjIuNS50Z3oiLAogICAgICAiaW50ZWdy
aXR5IjogInNoYTUxMi1GTTluTlVZclJCQUVMWlFUM3hlWlE3Zm1NT0JnNm5XTm1KS1RjZ3NKZWFM
c3RQL1VPRFZwR3NyNU9oWGhoWGc2ZitxdEo4dWlaK1BVeGtEV2NnSVhMdz09IgogICAgfSwKICAg
ICJtb21lbnQiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjIuMjkuMSIsCiAgICAgICJyZXNvbHZlZCI6
ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9tb21lbnQvLS9tb21lbnQtMi4yOS4xLnRneiIs
CiAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEyLWtIbW95YmNQVjhTcXk1OUR3TkRZM0plZnI2NGxL
L2J5L2RhMFZpRmN1QTRESDB2UWc1UTZaZTVWaW14a2ZRTlNDK01scy9LeDUzczdUalAxUmhGRURR
PT0iCiAgICB9LAogICAgIm5pY2UtdHJ5IjogewogICAgICAidmVyc2lvbiI6ICIxLjAuNSIsCiAg
ICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9uaWNlLXRyeS8tL25p
Y2UtdHJ5LTEuMC41LnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEyLTFuaDQ1ZGVlYjVv
bE5ZN2VYODJCa1BPN1NTeFI1U1NZSmlQVHJUZEZVVll3QWw4Q0tNQTVOOVBqVFlrSGlSamlzVmN4
Y1ExSFhkTGh4MnF4eEp6TE5RPT0iCiAgICB9LAogICAgIm5vZGUtZmV0Y2giOiB7CiAgICAgICJ2
ZXJzaW9uIjogIjIuNi42IiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBt
anMub3JnL25vZGUtZmV0Y2gvLS9ub2RlLWZldGNoLTIuNi42LnRneiIsCiAgICAgICJpbnRlZ3Jp
dHkiOiAic2hhNTEyLVo4LzZ2UmxUVUNoU2RJZ01hNTFqeFE0bHJ3L0p5NVNPVzEwT2JhQTQ3L1JF
bHNBTjJjNVBuOGJUZ0ZHV24vaWJ3elhURThxd3IxWXp4Mjh2c2VjWEVBPT0iLAogICAgICAicmVx
dWlyZXMiOiB7CiAgICAgICAgIndoYXR3Zy11cmwiOiAiXjUuMC4wIgogICAgICB9CiAgICB9LAog
ICAgIm5wbS1ydW4tcGF0aCI6IHsKICAgICAgInZlcnNpb24iOiAiMi4wLjIiLAogICAgICAicmVz
b2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvbnBtLXJ1bi1wYXRoLy0vbnBtLXJ1
bi1wYXRoLTIuMC4yLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhMS1OYWtqTGZvMTF3WjdU
TExkOGpWN0dIRlRiRjg9IiwKICAgICAgInJlcXVpcmVzIjogewogICAgICAgICJwYXRoLWtleSI6
ICJeMi4wLjAiCiAgICAgIH0KICAgIH0sCiAgICAibnVtYmVyLWlzLW5hbiI6IHsKICAgICAgInZl
cnNpb24iOiAiMS4wLjEiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1q
cy5vcmcvbnVtYmVyLWlzLW5hbi8tL251bWJlci1pcy1uYW4tMS4wLjEudGd6IiwKICAgICAgImlu
dGVncml0eSI6ICJzaGExLUNYdGdLMU5DS2xJc0d2dUhrREdETnBRYUFSMD0iCiAgICB9LAogICAg
Im9iamVjdC1pbnNwZWN0IjogewogICAgICAidmVyc2lvbiI6ICIxLjQuMSIsCiAgICAgICJyZXNv
bHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9vYmplY3QtaW5zcGVjdC8tL29iamVj
dC1pbnNwZWN0LTEuNC4xLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEyLXdxZGhMcGZD
VWJFc29Fd2wzRlh3R3l2OGllZjFrLzFhVWRJUENxVm51cE02ZThsNjNCRUpkaUYvMHN3dG4wNC84
cDA1dEcvVDBGcnBUbGZ3dmxqT2R3PT0iCiAgICB9LAogICAgIm9iamVjdC1rZXlzIjogewogICAg
ICAidmVyc2lvbiI6ICIxLjEuMSIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5
Lm5wbWpzLm9yZy9vYmplY3Qta2V5cy8tL29iamVjdC1rZXlzLTEuMS4xLnRneiIsCiAgICAgICJp
bnRlZ3JpdHkiOiAic2hhNTEyLU51QUVTVU9VTXJsSVhPZkhLekQ2YnBQdTN0WXQzeHZqTmRSSVEr
RmVUMGxOYjRLOFdSNzBDYUR4aHVOZ3VTMlhHK0dqa3lNd096c041Wmt0SW1maExBPT0iCiAgICB9
LAogICAgIm9uY2UiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjEuNC4wIiwKICAgICAgInJlc29sdmVk
IjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL29uY2UvLS9vbmNlLTEuNC4wLnRneiIsCiAg
ICAgICJpbnRlZ3JpdHkiOiAic2hhMS1XRHNhcDNXV0hVc1JPc0Y5bkZDNjc1M1hhOUU9IiwKICAg
ICAgInJlcXVpcmVzIjogewogICAgICAgICJ3cmFwcHkiOiAiMSIKICAgICAgfQogICAgfSwKICAg
ICJvcHRpb25hdG9yIjogewogICAgICAidmVyc2lvbiI6ICIwLjguMyIsCiAgICAgICJyZXNvbHZl
ZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9vcHRpb25hdG9yLy0vb3B0aW9uYXRvci0w
LjguMy50Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTUxMi0rSVc5cEFDZGszWFdtbVRYRzht
M3VwR1VKc3Q1WFJHenhNUmpYekF1SjFYbklGTnZmaGpqSXVZa0R2eXNuUFE3cXpxVnpMdDc4QkNy
dW50cVJoV1FiQT09IiwKICAgICAgInJlcXVpcmVzIjogewogICAgICAgICJkZWVwLWlzIjogIn4w
LjEuMyIsCiAgICAgICAgImZhc3QtbGV2ZW5zaHRlaW4iOiAifjIuMC42IiwKICAgICAgICAibGV2
biI6ICJ+MC4zLjAiLAogICAgICAgICJwcmVsdWRlLWxzIjogIn4xLjEuMiIsCiAgICAgICAgInR5
cGUtY2hlY2siOiAifjAuMy4yIiwKICAgICAgICAid29yZC13cmFwIjogIn4xLjIuMyIKICAgICAg
fQogICAgfSwKICAgICJvcy1sb2NhbGUiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjMuMS4wIiwKICAg
ICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL29zLWxvY2FsZS8tL29z
LWxvY2FsZS0zLjEuMC50Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTUxMi1aOGwzUjR3WVdN
NDAvNTJaK1MyNjVva2ZGajhLdDJjQzJNS1kreE5pM2tGcytYR0k3V1h1L0kzMDlRUVFZYlJXNGlq
aVoreXhzOXBxRWhKaDBEcVczUT09IiwKICAgICAgInJlcXVpcmVzIjogewogICAgICAgICJleGVj
YSI6ICJeMS4wLjAiLAogICAgICAgICJsY2lkIjogIl4yLjAuMCIsCiAgICAgICAgIm1lbSI6ICJe
NC4wLjAiCiAgICAgIH0KICAgIH0sCiAgICAicC1kZWZlciI6IHsKICAgICAgInZlcnNpb24iOiAi
MS4wLjAiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvcC1k
ZWZlci8tL3AtZGVmZXItMS4wLjAudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGExLW4yNnhn
dmJKcW96WFF3QktmVStXc1phdyt3dz0iCiAgICB9LAogICAgInAtZmluYWxseSI6IHsKICAgICAg
InZlcnNpb24iOiAiMS4wLjAiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5u
cG1qcy5vcmcvcC1maW5hbGx5Ly0vcC1maW5hbGx5LTEuMC4wLnRneiIsCiAgICAgICJpbnRlZ3Jp
dHkiOiAic2hhMS1QN3o3RmJpWnBFRWpzMHR0ekJpM0pETnFMSzQ9IgogICAgfSwKICAgICJwLWlz
LXByb21pc2UiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjIuMS4wIiwKICAgICAgInJlc29sdmVkIjog
Imh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL3AtaXMtcHJvbWlzZS8tL3AtaXMtcHJvbWlzZS0y
LjEuMC50Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTUxMi1ZM1cwd2xSUEs4Wk1SYk5xOTds
NE01b3Rpb2VBNWxtMXo3YmtOa3hDa2E4SFNQalIweFJXbXBDbWM5dXRpYUxQOUpiMWVEOEJnZUl4
VFc0QUlGNDVQZz09IgogICAgfSwKICAgICJwLWxpbWl0IjogewogICAgICAidmVyc2lvbiI6ICIy
LjMuMCIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9wLWxp
bWl0Ly0vcC1saW1pdC0yLjMuMC50Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTUxMi0vLzg4
bUZXU0p4OGx4Q3p3ZEFBQlRKTDJNeVdCMTIrZUlZN01ETDJTcUxtQWtlS1U5cXhSdld1U3lUam0z
RlVtcEJFTXVGZmNrQUlxRWFWR1VEeGI2dz09IiwKICAgICAgInJlcXVpcmVzIjogewogICAgICAg
ICJwLXRyeSI6ICJeMi4wLjAiCiAgICAgIH0KICAgIH0sCiAgICAicC1sb2NhdGUiOiB7CiAgICAg
ICJ2ZXJzaW9uIjogIjMuMC4wIiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnku
bnBtanMub3JnL3AtbG9jYXRlLy0vcC1sb2NhdGUtMy4wLjAudGd6IiwKICAgICAgImludGVncml0
eSI6ICJzaGE1MTIteCsxMncvVG8rNEdGZmdKaEJFcGlEY0xvelJKR2VnWStFaTcvejB0U0xrTW14
R1pOeWJWTVNmV2o5YUpuOFo1RmM3ZEJVTkpPT1ZnUHYySDdJd3VsU1E9PSIsCiAgICAgICJyZXF1
aXJlcyI6IHsKICAgICAgICAicC1saW1pdCI6ICJeMi4wLjAiCiAgICAgIH0KICAgIH0sCiAgICAi
cC10cnkiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjIuMi4wIiwKICAgICAgInJlc29sdmVkIjogImh0
dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL3AtdHJ5Ly0vcC10cnktMi4yLjAudGd6IiwKICAgICAg
ImludGVncml0eSI6ICJzaGE1MTItUjRuUEFWVEFVMEI5RDM1L0drM3VKZi83WFliUWN5b2hTS2R2
QXhJUlNOZ2hGbDRlNzFoVm9HbkJOUXo5Y1dhWHhPMkkxMEtUQyszak1kdnZvS3c2ZFE9PSIKICAg
IH0sCiAgICAicGFrbyI6IHsKICAgICAgInZlcnNpb24iOiAiMS4wLjExIiwKICAgICAgInJlc29s
dmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL3Bha28vLS9wYWtvLTEuMC4xMS50Z3oi
LAogICAgICAiaW50ZWdyaXR5IjogInNoYTUxMi00aExCOFB5NHpaY2U1czR5ZDlYem9wcXdWdi95
R05oVjFCbDhOVG1DcTE3NjNIZUsyK0V3VlR2K2xlR2VMMTNEbmgyd2ZicW93VlBYQ0lPMHo0dGFZ
dz09IgogICAgfSwKICAgICJwYXRoLWV4aXN0cyI6IHsKICAgICAgInZlcnNpb24iOiAiMy4wLjAi
LAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvcGF0aC1leGlz
dHMvLS9wYXRoLWV4aXN0cy0zLjAuMC50Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTEtemc2
K3FsOTR5eGlTWHFmWUVOZTFtd0VQMVJVPSIKICAgIH0sCiAgICAicGF0aC1pcy1hYnNvbHV0ZSI6
IHsKICAgICAgInZlcnNpb24iOiAiMS4wLjEiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9y
ZWdpc3RyeS5ucG1qcy5vcmcvcGF0aC1pcy1hYnNvbHV0ZS8tL3BhdGgtaXMtYWJzb2x1dGUtMS4w
LjEudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGExLUYwdVNhSE5WTlArOGVzNXI5VHBhbmh0
Y1gxOD0iCiAgICB9LAogICAgInBhdGgta2V5IjogewogICAgICAidmVyc2lvbiI6ICIyLjAuMSIs
CiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9wYXRoLWtleS8t
L3BhdGgta2V5LTIuMC4xLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhMS1RUnl0dFhURm9V
RFRwTEdSRFVEWURNbjBDMEE9IgogICAgfSwKICAgICJwYXRoLXBhcnNlIjogewogICAgICAidmVy
c2lvbiI6ICIxLjAuNyIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpz
Lm9yZy9wYXRoLXBhcnNlLy0vcGF0aC1wYXJzZS0xLjAuNy50Z3oiLAogICAgICAiaW50ZWdyaXR5
IjogInNoYTUxMi1MREp6UFZFRUVQUit5NDh6OTNBMEVkMHlYYjhwQUJ5R1dvL2s1WVlkWWdwWTIv
MkVzT3Nrc0pycTdsT0h4cnlyVk9uMWVqRzZvQXA4YWh2T0lRRDhzdz09IgogICAgfSwKICAgICJw
bHVyYWxpemUiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjcuMC4wIiwKICAgICAgInJlc29sdmVkIjog
Imh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL3BsdXJhbGl6ZS8tL3BsdXJhbGl6ZS03LjAuMC50
Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTUxMi1BUmhCT2R6UzNlNDFGYmtXL1hXclRFdHVr
cXFMb0s1K1ovNFVlRGFMdVNXKzM5SlBlRmdzNGdDR3FzckpIVlpYMGZVcngvLzRPRjBLMUNVR3ds
SUZvdz09IgogICAgfSwKICAgICJwcmVsdWRlLWxzIjogewogICAgICAidmVyc2lvbiI6ICIxLjEu
MiIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9wcmVsdWRl
LWxzLy0vcHJlbHVkZS1scy0xLjEuMi50Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTEtSVpN
cVZKOWVVdi9acUNmMWNPQkw1aXFYMmxRPSIKICAgIH0sCiAgICAicHJvY2Vzcy1uZXh0aWNrLWFy
Z3MiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjIuMC4xIiwKICAgICAgInJlc29sdmVkIjogImh0dHBz
Oi8vcmVnaXN0cnkubnBtanMub3JnL3Byb2Nlc3MtbmV4dGljay1hcmdzLy0vcHJvY2Vzcy1uZXh0
aWNrLWFyZ3MtMi4wLjEudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGE1MTItM291VU9wUWh0
Z3JiT2ExN0o3K3V4T1RwSVRZV2FHUDcvQWhvUjMrQSsvMWU5c2tyemVsR2kvZFh6RVl5dmJ4dWJF
RjZXbjJ5cHNjVEtpS0pGRm4xYWc9PSIKICAgIH0sCiAgICAicHVtcCI6IHsKICAgICAgInZlcnNp
b24iOiAiMy4wLjAiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5v
cmcvcHVtcC8tL3B1bXAtMy4wLjAudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGE1MTItTHda
eStwM1NGczFQeXRkL2pZY3Q0d3B2NDlIaVlDcWQ5UmxjNVpWZGswVis4WXp2NmpSNUJsazNUUm1Q
TDFmdDY5VHhQMElNWkdKK1dQRlUyQkZod3c9PSIsCiAgICAgICJyZXF1aXJlcyI6IHsKICAgICAg
ICAiZW5kLW9mLXN0cmVhbSI6ICJeMS4xLjAiLAogICAgICAgICJvbmNlIjogIl4xLjMuMSIKICAg
ICAgfQogICAgfSwKICAgICJxdW90ZS1zdHJlYW0iOiB7CiAgICAgICJ2ZXJzaW9uIjogIjEuMC4y
IiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL3F1b3RlLXN0
cmVhbS8tL3F1b3RlLXN0cmVhbS0xLjAuMi50Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTEt
aEpZL2pKd211VUxoVS83clU2cm5SbEszNExJPSIsCiAgICAgICJyZXF1aXJlcyI6IHsKICAgICAg
ICAiYnVmZmVyLWVxdWFsIjogIjAuMC4xIiwKICAgICAgICAibWluaW1pc3QiOiAiXjEuMS4zIiwK
ICAgICAgICAidGhyb3VnaDIiOiAiXjIuMC4wIgogICAgICB9CiAgICB9LAogICAgInJlYWRhYmxl
LXN0cmVhbSI6IHsKICAgICAgInZlcnNpb24iOiAiMi4zLjAiLAogICAgICAicmVzb2x2ZWQiOiAi
aHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvcmVhZGFibGUtc3RyZWFtLy0vcmVhZGFibGUtc3Ry
ZWFtLTIuMy4wLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEyLWM3S01YR2Q0YjQ4bk4z
T0oxVTlxT3NuNnBYTnpmNmtMZDNrZFpDa2cyc3hBY29pdWZJbnFGMFhja3dFbmxyY3d1YVl3b25s
Tks4R1FVSU9DL1dDN3NnPT0iLAogICAgICAicmVxdWlyZXMiOiB7CiAgICAgICAgImNvcmUtdXRp
bC1pcyI6ICJ+MS4wLjAiLAogICAgICAgICJpbmhlcml0cyI6ICJ+Mi4wLjMiLAogICAgICAgICJp
c2FycmF5IjogIn4xLjAuMCIsCiAgICAgICAgInByb2Nlc3MtbmV4dGljay1hcmdzIjogIn4xLjAu
NiIsCiAgICAgICAgInNhZmUtYnVmZmVyIjogIn41LjEuMCIsCiAgICAgICAgInN0cmluZ19kZWNv
ZGVyIjogIn4xLjAuMCIsCiAgICAgICAgInV0aWwtZGVwcmVjYXRlIjogIn4xLjAuMSIKICAgICAg
fSwKICAgICAgImRlcGVuZGVuY2llcyI6IHsKICAgICAgICAicHJvY2Vzcy1uZXh0aWNrLWFyZ3Mi
OiB7CiAgICAgICAgICAidmVyc2lvbiI6ICIxLjAuNyIsCiAgICAgICAgICAicmVzb2x2ZWQiOiAi
aHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvcHJvY2Vzcy1uZXh0aWNrLWFyZ3MvLS9wcm9jZXNz
LW5leHRpY2stYXJncy0xLjAuNy50Z3oiLAogICAgICAgICAgImludGVncml0eSI6ICJzaGExLUZR
NGd0MVpaQ3RQNUVKUHlXazhxMkwvekM2TT0iCiAgICAgICAgfSwKICAgICAgICAic3RyaW5nX2Rl
Y29kZXIiOiB7CiAgICAgICAgICAidmVyc2lvbiI6ICIxLjAuMyIsCiAgICAgICAgICAicmVzb2x2
ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvc3RyaW5nX2RlY29kZXIvLS9zdHJpbmdf
ZGVjb2Rlci0xLjAuMy50Z3oiLAogICAgICAgICAgImludGVncml0eSI6ICJzaGE1MTItNEFINlo1
ZnpOTkJjSCs2WERNZkEvQlR0ODdza3hxSmxPMGxBaDNEa2VyNXpUaGNBeEc2bUt6K2lHdTMwOFVL
b1BQUThEY3F4LzRKaHVqemx0UmEraFE9PSIsCiAgICAgICAgICAicmVxdWlyZXMiOiB7CiAgICAg
ICAgICAgICJzYWZlLWJ1ZmZlciI6ICJ+NS4xLjAiCiAgICAgICAgICB9CiAgICAgICAgfQogICAg
ICB9CiAgICB9LAogICAgInJlZHVjZS1mbGF0dGVuIjogewogICAgICAidmVyc2lvbiI6ICIxLjAu
MSIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9yZWR1Y2Ut
ZmxhdHRlbi8tL3JlZHVjZS1mbGF0dGVuLTEuMC4xLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAi
c2hhMS1KWXg0NzlGVDNmazh0V0VqZjJFWVR6YVc0eWM9IgogICAgfSwKICAgICJyZXF1aXJlLWRp
cmVjdG9yeSI6IHsKICAgICAgInZlcnNpb24iOiAiMi4xLjEiLAogICAgICAicmVzb2x2ZWQiOiAi
aHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvcmVxdWlyZS1kaXJlY3RvcnkvLS9yZXF1aXJlLWRp
cmVjdG9yeS0yLjEuMS50Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTEtakdTdFg5TU5xeHlY
YmlORS8rZjNrcWFtMzBJPSIKICAgIH0sCiAgICAicmVxdWlyZS1tYWluLWZpbGVuYW1lIjogewog
ICAgICAidmVyc2lvbiI6ICIxLjAuMSIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lz
dHJ5Lm5wbWpzLm9yZy9yZXF1aXJlLW1haW4tZmlsZW5hbWUvLS9yZXF1aXJlLW1haW4tZmlsZW5h
bWUtMS4wLjEudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGExLWwvY1h0cDFJZUU5ZlVtcHNX
cWovM2FCVnBORT0iCiAgICB9LAogICAgInJlc29sdmUiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjEu
MjAuMCIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9yZXNv
bHZlLy0vcmVzb2x2ZS0xLjIwLjAudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGE1MTItd0VO
QlB0NHlTemc0eWJGUVcyVFQxek1RdWNQSzk1SFNoL25xMkNGVFpWT0d1dDIrcFF2U3NndGRhNGQy
NllyWWNyMDY3d2pibXpPRzhieURQQlg2M0E9PSIsCiAgICAgICJyZXF1aXJlcyI6IHsKICAgICAg
ICAiaXMtY29yZS1tb2R1bGUiOiAiXjIuMi4wIiwKICAgICAgICAicGF0aC1wYXJzZSI6ICJeMS4w
LjYiCiAgICAgIH0KICAgIH0sCiAgICAic2FmZS1idWZmZXIiOiB7CiAgICAgICJ2ZXJzaW9uIjog
IjUuMS4yIiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL3Nh
ZmUtYnVmZmVyLy0vc2FmZS1idWZmZXItNS4xLjIudGd6IiwKICAgICAgImludGVncml0eSI6ICJz
aGE1MTItR2QyVVpCSkRrWGxZN0diSnhmc0U4L252S2tVRVUxRzM4YzFzaU42UVA2YTlQVDlNbUhC
OEducHNjU21NSlNvRjhMT0lydDh1ZC93UHRvanlzNEc2K2c9PSIKICAgIH0sCiAgICAic2FmZXIt
YnVmZmVyIjogewogICAgICAidmVyc2lvbiI6ICIyLjEuMiIsCiAgICAgICJyZXNvbHZlZCI6ICJo
dHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9zYWZlci1idWZmZXIvLS9zYWZlci1idWZmZXItMi4x
LjIudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGE1MTItWVpvM0s4MlNEN1JpeWkwRTFFUVBv
akx6N2twZXBuU1FJOUl5UGJISGcxWFhYZXZiNWRKSTd0cHlOMkFEeEdjUWJIRzd2Y3lSSGswY2J3
cWNRcmlVdGc9PSIKICAgIH0sCiAgICAic2VtdmVyIjogewogICAgICAidmVyc2lvbiI6ICI1Ljcu
MSIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9zZW12ZXIv
LS9zZW12ZXItNS43LjEudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGE1MTItc2F1YURmL1Ba
ZFZnckxUTllIUnRwWGExaVJpS2NhZWJpS1ExQkpkcFFsV0gybEN2ZXhRZFg1NXNuUEZ5SzdRenB1
ZHFiQ0kwcVhGZk9hc0hkeU5ER1E9PSIKICAgIH0sCiAgICAic2V0LWJsb2NraW5nIjogewogICAg
ICAidmVyc2lvbiI6ICIyLjAuMCIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5
Lm5wbWpzLm9yZy9zZXQtYmxvY2tpbmcvLS9zZXQtYmxvY2tpbmctMi4wLjAudGd6IiwKICAgICAg
ImludGVncml0eSI6ICJzaGExLUJGK1hndEFScnBwb0E5M1RnckpEa3JQWWtQYz0iCiAgICB9LAog
ICAgInNoYWxsb3ctY29weSI6IHsKICAgICAgInZlcnNpb24iOiAiMC4wLjEiLAogICAgICAicmVz
b2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvc2hhbGxvdy1jb3B5Ly0vc2hhbGxv
dy1jb3B5LTAuMC4xLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhMS1RVjlDY0MxejJCQXpB
cExNWHVodXJob1JvWEE9IgogICAgfSwKICAgICJzaGViYW5nLWNvbW1hbmQiOiB7CiAgICAgICJ2
ZXJzaW9uIjogIjEuMi4wIiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBt
anMub3JnL3NoZWJhbmctY29tbWFuZC8tL3NoZWJhbmctY29tbWFuZC0xLjIuMC50Z3oiLAogICAg
ICAiaW50ZWdyaXR5IjogInNoYTEtUktyR1cybGJBem1KYU1PZk5qL3VYZXI5OGVvPSIsCiAgICAg
ICJyZXF1aXJlcyI6IHsKICAgICAgICAic2hlYmFuZy1yZWdleCI6ICJeMS4wLjAiCiAgICAgIH0K
ICAgIH0sCiAgICAic2hlYmFuZy1yZWdleCI6IHsKICAgICAgInZlcnNpb24iOiAiMS4wLjAiLAog
ICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvc2hlYmFuZy1yZWdl
eC8tL3NoZWJhbmctcmVnZXgtMS4wLjAudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGExLTJr
TDBsMERBdEMyeXlwY29WeHl4a01tTy9xTT0iCiAgICB9LAogICAgInNpZ25hbC1leGl0Ijogewog
ICAgICAidmVyc2lvbiI6ICIzLjAuNiIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lz
dHJ5Lm5wbWpzLm9yZy9zaWduYWwtZXhpdC8tL3NpZ25hbC1leGl0LTMuMC42LnRneiIsCiAgICAg
ICJpbnRlZ3JpdHkiOiAic2hhNTEyLXNEbDRxTUZwaWpjR3cyMlU1dzYzS21EM2NaSmZCdUZsVk5i
Vk1LamUya2VvS01MN1gyVXpXYmM0WHJtRWJEd2cwTlhKYzN5djQvb3g3YitKV2I1N2tRPT0iCiAg
ICB9LAogICAgInNvdXJjZS1tYXAiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjAuNi4xIiwKICAgICAg
InJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL3NvdXJjZS1tYXAvLS9zb3Vy
Y2UtbWFwLTAuNi4xLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEyLVVqZ2FwdW1XbGJN
aGtCZ3pUN1lrYzVZWFVUNDZGMGlLdThTR1hxMGJjd1A1ZHovaDBQbGo2ZW5KcWp6MVpicTJsNVdh
cVluclZid1dPV015RjNGNDdnPT0iLAogICAgICAib3B0aW9uYWwiOiB0cnVlCiAgICB9LAogICAg
InN0YXRpYy1ldmFsIjogewogICAgICAidmVyc2lvbiI6ICIyLjEuMCIsCiAgICAgICJyZXNvbHZl
ZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9zdGF0aWMtZXZhbC8tL3N0YXRpYy1ldmFs
LTIuMS4wLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEyLWFndHhaL2tXU3NDa0k1RTRR
aWZSd3NhUHMwUDBKbVpWNmRrTHo2SUxZZkZZUUduKzVwbGN0YW5STitJQzhkSlJpRmt5WEhyd0VF
M1c5V214Njd1RGJ3PT0iLAogICAgICAicmVxdWlyZXMiOiB7CiAgICAgICAgImVzY29kZWdlbiI6
ICJeMS4xMS4xIgogICAgICB9LAogICAgICAiZGVwZW5kZW5jaWVzIjogewogICAgICAgICJlc2Nv
ZGVnZW4iOiB7CiAgICAgICAgICAidmVyc2lvbiI6ICIxLjE0LjMiLAogICAgICAgICAgInJlc29s
dmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL2VzY29kZWdlbi8tL2VzY29kZWdlbi0x
LjE0LjMudGd6IiwKICAgICAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEyLXFGY1gwWEprZGcrUEIz
eGpaWkcvd0tTdVQxUG5RV3g1NytUVlNqSU1tSUxkMnlDLzZCeVlFbFB3Sm5zbERzdVd1U0FwNEF3
Skd1bWFyQUFtSmNoNUt3PT0iLAogICAgICAgICAgInJlcXVpcmVzIjogewogICAgICAgICAgICAi
ZXNwcmltYSI6ICJeNC4wLjEiLAogICAgICAgICAgICAiZXN0cmF2ZXJzZSI6ICJeNC4yLjAiLAog
ICAgICAgICAgICAiZXN1dGlscyI6ICJeMi4wLjIiLAogICAgICAgICAgICAib3B0aW9uYXRvciI6
ICJeMC44LjEiLAogICAgICAgICAgICAic291cmNlLW1hcCI6ICJ+MC42LjEiCiAgICAgICAgICB9
CiAgICAgICAgfSwKICAgICAgICAiZXNwcmltYSI6IHsKICAgICAgICAgICJ2ZXJzaW9uIjogIjQu
MC4xIiwKICAgICAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9l
c3ByaW1hLy0vZXNwcmltYS00LjAuMS50Z3oiLAogICAgICAgICAgImludGVncml0eSI6ICJzaGE1
MTItZUd1RkZ3N1VwZGErZzRwK1FIdm5XMFJ5VFgvU1ZlSkJETS9nQ3RNQVJPMGNMdVQySGNFS25U
UHZoalY2YUdlcXJDQi9zYk5vcDBLc3ptMGpzYVdVNEE9PSIKICAgICAgICB9CiAgICAgIH0KICAg
IH0sCiAgICAic3RhdGljLW1vZHVsZSI6IHsKICAgICAgInZlcnNpb24iOiAiMi4yLjUiLAogICAg
ICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvc3RhdGljLW1vZHVsZS8t
L3N0YXRpYy1tb2R1bGUtMi4yLjUudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGE1MTItRDh2
djgyRS9LcG16M1RYSEtHOFBQc0NQZytSQVg2Y2JDT3l2ak02eDA0cVp0UTQ3RXRKRlZ3UnNkb3Yz
bjVkNi82eW5yT1k5WEI0SmthWndCMnhvUlE9PSIsCiAgICAgICJyZXF1aXJlcyI6IHsKICAgICAg
ICAiY29uY2F0LXN0cmVhbSI6ICJ+MS42LjAiLAogICAgICAgICJjb252ZXJ0LXNvdXJjZS1tYXAi
OiAiXjEuNS4xIiwKICAgICAgICAiZHVwbGV4ZXIyIjogIn4wLjEuNCIsCiAgICAgICAgImVzY29k
ZWdlbiI6ICJ+MS45LjAiLAogICAgICAgICJmYWxhZmVsIjogIl4yLjEuMCIsCiAgICAgICAgImhh
cyI6ICJeMS4wLjEiLAogICAgICAgICJtYWdpYy1zdHJpbmciOiAiXjAuMjIuNCIsCiAgICAgICAg
Im1lcmdlLXNvdXJjZS1tYXAiOiAiMS4wLjQiLAogICAgICAgICJvYmplY3QtaW5zcGVjdCI6ICJ+
MS40LjAiLAogICAgICAgICJxdW90ZS1zdHJlYW0iOiAifjEuMC4yIiwKICAgICAgICAicmVhZGFi
bGUtc3RyZWFtIjogIn4yLjMuMyIsCiAgICAgICAgInNoYWxsb3ctY29weSI6ICJ+MC4wLjEiLAog
ICAgICAgICJzdGF0aWMtZXZhbCI6ICJeMi4wLjAiLAogICAgICAgICJ0aHJvdWdoMiI6ICJ+Mi4w
LjMiCiAgICAgIH0sCiAgICAgICJkZXBlbmRlbmNpZXMiOiB7CiAgICAgICAgInJlYWRhYmxlLXN0
cmVhbSI6IHsKICAgICAgICAgICJ2ZXJzaW9uIjogIjIuMy43IiwKICAgICAgICAgICJyZXNvbHZl
ZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9yZWFkYWJsZS1zdHJlYW0vLS9yZWFkYWJs
ZS1zdHJlYW0tMi4zLjcudGd6IiwKICAgICAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEyLUViaG84
SzRqSWJIQXhudXhpN280Mk9yWmdGL1pUTmNzWmo2blJLeVVta2hMRnE4Q0hJdHAvZnk2aFFadVpt
UC9uM3laOVZCVWJwNHp6L21YOGhtWVB3PT0iLAogICAgICAgICAgInJlcXVpcmVzIjogewogICAg
ICAgICAgICAiY29yZS11dGlsLWlzIjogIn4xLjAuMCIsCiAgICAgICAgICAgICJpbmhlcml0cyI6
ICJ+Mi4wLjMiLAogICAgICAgICAgICAiaXNhcnJheSI6ICJ+MS4wLjAiLAogICAgICAgICAgICAi
cHJvY2Vzcy1uZXh0aWNrLWFyZ3MiOiAifjIuMC4wIiwKICAgICAgICAgICAgInNhZmUtYnVmZmVy
IjogIn41LjEuMSIsCiAgICAgICAgICAgICJzdHJpbmdfZGVjb2RlciI6ICJ+MS4xLjEiLAogICAg
ICAgICAgICAidXRpbC1kZXByZWNhdGUiOiAifjEuMC4xIgogICAgICAgICAgfQogICAgICAgIH0K
ICAgICAgfQogICAgfSwKICAgICJzdHJlYW0tY2hhaW4iOiB7CiAgICAgICJ2ZXJzaW9uIjogIjIu
Mi40IiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL3N0cmVh
bS1jaGFpbi8tL3N0cmVhbS1jaGFpbi0yLjIuNC50Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNo
YTUxMi05bHNsM1lNNTNWNU4vSTFDMnVKdGMzS2F2eWkza05ZTjgzVmtLYi9iTVdSazdEOWltaUZ5
VVBZYTBQb1piTG9oU1ZPWDFtWUU5WXNtd09iWlVzdGg2UT09IgogICAgfSwKICAgICJzdHJlYW0t
anNvbiI6IHsKICAgICAgInZlcnNpb24iOiAiMS4xLjMiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0
cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvc3RyZWFtLWpzb24vLS9zdHJlYW0tanNvbi0xLjEuMy50
Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTUxMi15K0NoaENvdjJBNW5EcUMyYVo2SEtYczNP
dkRsdkFwMFBzM0JGMVAvSXY4dFVaSlFRc01WYVN6azBXcnlWVFZvR0lUS3YwMVVZYWhDWE1wQXM3
STBsUT09IiwKICAgICAgInJlcXVpcmVzIjogewogICAgICAgICJzdHJlYW0tY2hhaW4iOiAiXjIu
MC4zIgogICAgICB9CiAgICB9LAogICAgInN0cmluZy10by1zdHJlYW0iOiB7CiAgICAgICJ2ZXJz
aW9uIjogIjEuMS4xIiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMu
b3JnL3N0cmluZy10by1zdHJlYW0vLS9zdHJpbmctdG8tc3RyZWFtLTEuMS4xLnRneiIsCiAgICAg
ICJpbnRlZ3JpdHkiOiAic2hhNTEyLVF5U0YyKzNSd3EwU2RPM3M3QkFwNHgrYzNxc0NscFBRNmFi
QW1iMERHVmlpU0JBa1Q1a0w2SlQyaXl6RVZQK1QxU216SHJRRDFUd2xQOVFBSENjK1N3PT0iLAog
ICAgICAicmVxdWlyZXMiOiB7CiAgICAgICAgImluaGVyaXRzIjogIl4yLjAuMSIsCiAgICAgICAg
InJlYWRhYmxlLXN0cmVhbSI6ICJeMi4xLjAiCiAgICAgIH0KICAgIH0sCiAgICAic3RyaW5nLXdp
ZHRoIjogewogICAgICAidmVyc2lvbiI6ICIyLjEuMSIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRw
czovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9zdHJpbmctd2lkdGgvLS9zdHJpbmctd2lkdGgtMi4xLjEu
dGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGE1MTItbk9xSDU5ZGVDcTlTUkhseHExQXc4NUpu
dDR3Nkt2TEtxV1ZpazZvQTlaa2xYTE5JT2xxZzRGMnlyVDFNVmFUakFxdlZ3ZGZlWjd3N2FDdkpE
N3Vna3c9PSIsCiAgICAgICJyZXF1aXJlcyI6IHsKICAgICAgICAiaXMtZnVsbHdpZHRoLWNvZGUt
cG9pbnQiOiAiXjIuMC4wIiwKICAgICAgICAic3RyaXAtYW5zaSI6ICJeNC4wLjAiCiAgICAgIH0K
ICAgIH0sCiAgICAic3RyaW5nX2RlY29kZXIiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjEuMS4xIiwK
ICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL3N0cmluZ19kZWNv
ZGVyLy0vc3RyaW5nX2RlY29kZXItMS4xLjEudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGE1
MTItbi9TaG52RGk2RkhiYlZmdmlybytXb2ppRnp2K3M4TVBNSEJjelZlUGZVcERKTHdvTFQwaHQx
bDRZd0JDYmk4cEpBdmVFRWRua0h5UHlUUC9telJmd2c9PSIsCiAgICAgICJyZXF1aXJlcyI6IHsK
ICAgICAgICAic2FmZS1idWZmZXIiOiAifjUuMS4wIgogICAgICB9CiAgICB9LAogICAgInN0cmlw
LWFuc2kiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjQuMC4wIiwKICAgICAgInJlc29sdmVkIjogImh0
dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL3N0cmlwLWFuc2kvLS9zdHJpcC1hbnNpLTQuMC4wLnRn
eiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhMS1xRWVRSXVzYXcyaW9jVGliWTFKaXhRWHVObzg9
IiwKICAgICAgInJlcXVpcmVzIjogewogICAgICAgICJhbnNpLXJlZ2V4IjogIl4zLjAuMCIKICAg
ICAgfQogICAgfSwKICAgICJzdHJpcC1lb2YiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjEuMC4wIiwK
ICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL3N0cmlwLWVvZi8t
L3N0cmlwLWVvZi0xLjAuMC50Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTEtdTBQL1ZaaW02
d1hZbTFuODBTbkpnekUyQnI4PSIKICAgIH0sCiAgICAic3VwcG9ydHMtY29sb3IiOiB7CiAgICAg
ICJ2ZXJzaW9uIjogIjUuNS4wIiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnku
bnBtanMub3JnL3N1cHBvcnRzLWNvbG9yLy0vc3VwcG9ydHMtY29sb3ItNS41LjAudGd6IiwKICAg
ICAgImludGVncml0eSI6ICJzaGE1MTItUWpWandkWEl0NDA4TUlpQXFDWDRvVUtzZ1UyRXFBR3pz
MlBwa200YVFZYmptK1pFV0VjVzRTZkZOVHI0dU1OWm1hMGV5NGY1bGdMcmtCMGFYMFFNb3c9PSIs
CiAgICAgICJyZXF1aXJlcyI6IHsKICAgICAgICAiaGFzLWZsYWciOiAiXjMuMC4wIgogICAgICB9
CiAgICB9LAogICAgInRhYmxlLWxheW91dCI6IHsKICAgICAgInZlcnNpb24iOiAiMC40LjUiLAog
ICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvdGFibGUtbGF5b3V0
Ly0vdGFibGUtbGF5b3V0LTAuNC41LnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEyLXpU
dmYwbWNnZ3JHZVRlLzJqSjZFQ2tKSEFRUElZRXdEb3FzaXFCakkyNG12Um1RYkluSzVqcTMzZnl5
cGFDQnhYMDhoTWtmbWRPcWo2aGFUMzNFcVd3PT0iLAogICAgICAicmVxdWlyZXMiOiB7CiAgICAg
ICAgImFycmF5LWJhY2siOiAiXjIuMC4wIiwKICAgICAgICAiZGVlcC1leHRlbmQiOiAifjAuNi4w
IiwKICAgICAgICAibG9kYXNoLnBhZGVuZCI6ICJeNC42LjEiLAogICAgICAgICJ0eXBpY2FsIjog
Il4yLjYuMSIsCiAgICAgICAgIndvcmR3cmFwanMiOiAiXjMuMC4wIgogICAgICB9CiAgICB9LAog
ICAgInRlc3QtdmFsdWUiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjIuMS4wIiwKICAgICAgInJlc29s
dmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL3Rlc3QtdmFsdWUvLS90ZXN0LXZhbHVl
LTIuMS4wLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhMS1FZHB2OW5EelJ4cHp0aVhLVHov
Yzk3dDBncEU9IiwKICAgICAgInJlcXVpcmVzIjogewogICAgICAgICJhcnJheS1iYWNrIjogIl4x
LjAuMyIsCiAgICAgICAgInR5cGljYWwiOiAiXjIuNi4wIgogICAgICB9LAogICAgICAiZGVwZW5k
ZW5jaWVzIjogewogICAgICAgICJhcnJheS1iYWNrIjogewogICAgICAgICAgInZlcnNpb24iOiAi
MS4wLjQiLAogICAgICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3Jn
L2FycmF5LWJhY2svLS9hcnJheS1iYWNrLTEuMC40LnRneiIsCiAgICAgICAgICAiaW50ZWdyaXR5
IjogInNoYTEtWkV1bjhKWDMvODk4UTdYdzNEblR3ZkE4QmpzPSIsCiAgICAgICAgICAicmVxdWly
ZXMiOiB7CiAgICAgICAgICAgICJ0eXBpY2FsIjogIl4yLjYuMCIKICAgICAgICAgIH0KICAgICAg
ICB9CiAgICAgIH0KICAgIH0sCiAgICAidGhyb3VnaDIiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjIu
MC41IiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL3Rocm91
Z2gyLy0vdGhyb3VnaDItMi4wLjUudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGE1MTItL21y
Um9kOHhxcEErSUhTTHlHQ1EyczhTUEhpQ0RFZVFKU2VwMWpxTFllRVVDbE9GRzJRc2grNEZVNkc5
VmVxcFpuR1cvU3U4TFFHYzRZS25pNXJZU1E9PSIsCiAgICAgICJyZXF1aXJlcyI6IHsKICAgICAg
ICAicmVhZGFibGUtc3RyZWFtIjogIn4yLjMuNiIsCiAgICAgICAgInh0ZW5kIjogIn40LjAuMSIK
ICAgICAgfSwKICAgICAgImRlcGVuZGVuY2llcyI6IHsKICAgICAgICAicmVhZGFibGUtc3RyZWFt
IjogewogICAgICAgICAgInZlcnNpb24iOiAiMi4zLjciLAogICAgICAgICAgInJlc29sdmVkIjog
Imh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL3JlYWRhYmxlLXN0cmVhbS8tL3JlYWRhYmxlLXN0
cmVhbS0yLjMuNy50Z3oiLAogICAgICAgICAgImludGVncml0eSI6ICJzaGE1MTItRWJobzhLNGpJ
YkhBeG51eGk3bzQyT3JaZ0YvWlROY3NaajZuUkt5VW1raExGcThDSEl0cC9meTZoUVp1Wm1QL24z
eVo5VkJVYnA0enovbVg4aG1ZUHc9PSIsCiAgICAgICAgICAicmVxdWlyZXMiOiB7CiAgICAgICAg
ICAgICJjb3JlLXV0aWwtaXMiOiAifjEuMC4wIiwKICAgICAgICAgICAgImluaGVyaXRzIjogIn4y
LjAuMyIsCiAgICAgICAgICAgICJpc2FycmF5IjogIn4xLjAuMCIsCiAgICAgICAgICAgICJwcm9j
ZXNzLW5leHRpY2stYXJncyI6ICJ+Mi4wLjAiLAogICAgICAgICAgICAic2FmZS1idWZmZXIiOiAi
fjUuMS4xIiwKICAgICAgICAgICAgInN0cmluZ19kZWNvZGVyIjogIn4xLjEuMSIsCiAgICAgICAg
ICAgICJ1dGlsLWRlcHJlY2F0ZSI6ICJ+MS4wLjEiCiAgICAgICAgICB9CiAgICAgICAgfQogICAg
ICB9CiAgICB9LAogICAgInRpbnktaW5mbGF0ZSI6IHsKICAgICAgInZlcnNpb24iOiAiMS4wLjMi
LAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvdGlueS1pbmZs
YXRlLy0vdGlueS1pbmZsYXRlLTEuMC4zLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEy
LXBrWTFmajFjS0hiMnNlV0R5MEIxNkhlV3ljemxKQTkvV1czdTNjNHovTmlXRHNPM0RPVTVEN25o
VExFOUNGMHlYdi9RWkZZN3NFSm1qMjRkSytScnF3PT0iCiAgICB9LAogICAgInRyNDYiOiB7CiAg
ICAgICJ2ZXJzaW9uIjogIjAuMC4zIiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0
cnkubnBtanMub3JnL3RyNDYvLS90cjQ2LTAuMC4zLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAi
c2hhMS1nWVQ5Tkgyc25Od1lXWkx6cG1JdUZMblpxMm89IgogICAgfSwKICAgICJ0eXBlLWNoZWNr
IjogewogICAgICAidmVyc2lvbiI6ICIwLjMuMiIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczov
L3JlZ2lzdHJ5Lm5wbWpzLm9yZy90eXBlLWNoZWNrLy0vdHlwZS1jaGVjay0wLjMuMi50Z3oiLAog
ICAgICAiaW50ZWdyaXR5IjogInNoYTEtV0lUS3RSTFBIVFZlUDdlRTh3Z0VzclVnMjNJPSIsCiAg
ICAgICJyZXF1aXJlcyI6IHsKICAgICAgICAicHJlbHVkZS1scyI6ICJ+MS4xLjIiCiAgICAgIH0K
ICAgIH0sCiAgICAidHlwZWRhcnJheSI6IHsKICAgICAgInZlcnNpb24iOiAiMC4wLjYiLAogICAg
ICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvdHlwZWRhcnJheS8tL3R5
cGVkYXJyYXktMC4wLjYudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGExLWhuckhUamhrR0hz
ZFBVZlpscWVPeGNpREIzYz0iCiAgICB9LAogICAgInR5cGVzY3JpcHQiOiB7CiAgICAgICJ2ZXJz
aW9uIjogIjMuMi40IiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMu
b3JnL3R5cGVzY3JpcHQvLS90eXBlc2NyaXB0LTMuMi40LnRneiIsCiAgICAgICJpbnRlZ3JpdHki
OiAic2hhNTEyLTBSTkRiU2RFb2tCZUVBa2dOYnhKK0JMd1NNYW5GeTlUZVh6OHVXKzQ4ai94aEVY
djFlUE1FNjBvbHl6dzJYelVxVUJOQVlGZUphZElxQWdOcUlBQ3dnPT0iCiAgICB9LAogICAgInR5
cGljYWwiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjIuNi4xIiwKICAgICAgInJlc29sdmVkIjogImh0
dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL3R5cGljYWwvLS90eXBpY2FsLTIuNi4xLnRneiIsCiAg
ICAgICJpbnRlZ3JpdHkiOiAic2hhMS1YQWdPWFdZY3UrT0NXZExuQ2p4eVUraHppQjA9IgogICAg
fSwKICAgICJ1bmljb2RlLXRyaWUiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjAuMy4xIiwKICAgICAg
InJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL3VuaWNvZGUtdHJpZS8tL3Vu
aWNvZGUtdHJpZS0wLjMuMS50Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTEtMW5IZDNZa1FH
Z2k2dzN0cVVXRUJCZ0lGSUlVPSIsCiAgICAgICJyZXF1aXJlcyI6IHsKICAgICAgICAicGFrbyI6
ICJeMC4yLjUiLAogICAgICAgICJ0aW55LWluZmxhdGUiOiAiXjEuMC4wIgogICAgICB9LAogICAg
ICAiZGVwZW5kZW5jaWVzIjogewogICAgICAgICJwYWtvIjogewogICAgICAgICAgInZlcnNpb24i
OiAiMC4yLjkiLAogICAgICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMu
b3JnL3Bha28vLS9wYWtvLTAuMi45LnRneiIsCiAgICAgICAgICAiaW50ZWdyaXR5IjogInNoYTEt
OC9kU0wwNzNnalNOcUJZYnJaN1AxUnY0T25VPSIKICAgICAgICB9CiAgICAgIH0KICAgIH0sCiAg
ICAidXJpanMiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjEuMTkuNyIsCiAgICAgICJyZXNvbHZlZCI6
ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy91cmlqcy8tL3VyaWpzLTEuMTkuNy50Z3oiLAog
ICAgICAiaW50ZWdyaXR5IjogInNoYTUxMi1JZCtJS2pkVTBIeCs3Wng3MTdqd0xQc1BlVXF6N3JB
dHVWQlJMTHMrcW4rSjJuZjlOR0lUV1ZDeGNpamdZeEJxZTgzQzdzcXNRUHM2SDFweXozeDlnQT09
IgogICAgfSwKICAgICJ1dGlsLWRlcHJlY2F0ZSI6IHsKICAgICAgInZlcnNpb24iOiAiMS4wLjIi
LAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvdXRpbC1kZXBy
ZWNhdGUvLS91dGlsLWRlcHJlY2F0ZS0xLjAuMi50Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNo
YTEtUlExTnlmcHczbk1uWXZ2UzFLS0pnVUdhRE04PSIKICAgIH0sCiAgICAidXVpZCI6IHsKICAg
ICAgInZlcnNpb24iOiAiMy40LjAiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3Ry
eS5ucG1qcy5vcmcvdXVpZC8tL3V1aWQtMy40LjAudGd6IiwKICAgICAgImludGVncml0eSI6ICJz
aGE1MTItSGpTRFJ3NmdaRTVKTWdnY3RIQmNqVmFrMDgrS0VWaFNJaUR6Rm5UOVM5YWVnbXA4NVMv
YlJlQlZUYjRRVEZhUk5wdEo5a3VZYU5obmJORU9rYktiL0E9PSIKICAgIH0sCiAgICAidmxxIjog
ewogICAgICAidmVyc2lvbiI6ICIwLjIuMyIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3Jl
Z2lzdHJ5Lm5wbWpzLm9yZy92bHEvLS92bHEtMC4yLjMudGd6IiwKICAgICAgImludGVncml0eSI6
ICJzaGE1MTItRFJpYlpMNkRzTmhJZ1lRK3dOZFdETDJTTDNiS1BsVnJSaUJxVjV5dU1tKytvcDhX
NGtHRnRhUWZDczRLRUpuMHdCWmNIVkhKM2VveXdYODk4M2sxb3c9PSIKICAgIH0sCiAgICAid2Vi
aWRsLWNvbnZlcnNpb25zIjogewogICAgICAidmVyc2lvbiI6ICIzLjAuMSIsCiAgICAgICJyZXNv
bHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy93ZWJpZGwtY29udmVyc2lvbnMvLS93
ZWJpZGwtY29udmVyc2lvbnMtMy4wLjEudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGExLUpG
TkNkZUtudkd2bnZJWmhITUZxNEtWbFNIRT0iCiAgICB9LAogICAgIndoYXR3Zy1mZXRjaCI6IHsK
ICAgICAgInZlcnNpb24iOiAiMy42LjIiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdp
c3RyeS5ucG1qcy5vcmcvd2hhdHdnLWZldGNoLy0vd2hhdHdnLWZldGNoLTMuNi4yLnRneiIsCiAg
ICAgICJpbnRlZ3JpdHkiOiAic2hhNTEyLWJKbGVuMEZjdVUvMEVNTHJkYko3ek9uVzZJVFpMclpN
SWFyTVVWbWRLdHNHdlpuYTh2eEtZYWV4SUNXUGZaOHF3Zjlmek5xK1VFSVpyblNhQXB0NlJBPT0i
CiAgICB9LAogICAgIndoYXR3Zy11cmwiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjUuMC4wIiwKICAg
ICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL3doYXR3Zy11cmwvLS93
aGF0d2ctdXJsLTUuMC4wLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhMS1sbVJVNkhaVVl1
TjJSTk5pYjJkQ3pvdHdsbDA9IiwKICAgICAgInJlcXVpcmVzIjogewogICAgICAgICJ0cjQ2Ijog
In4wLjAuMyIsCiAgICAgICAgIndlYmlkbC1jb252ZXJzaW9ucyI6ICJeMy4wLjAiCiAgICAgIH0K
ICAgIH0sCiAgICAid2hpY2giOiB7CiAgICAgICJ2ZXJzaW9uIjogIjEuMy4xIiwKICAgICAgInJl
c29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL3doaWNoLy0vd2hpY2gtMS4zLjEu
dGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGE1MTItSHhKZFlXcTFNVElRYkozbncwY3Fzc0hv
VE5VMjY3S2xyRHVHWjFXWWx4RFN0VXRLVWhPYUptaDExMi9UWm1IeHhVZnVKcVBYU09tN3REeWFz
ME9TSVE9PSIsCiAgICAgICJyZXF1aXJlcyI6IHsKICAgICAgICAiaXNleGUiOiAiXjIuMC4wIgog
ICAgICB9CiAgICB9LAogICAgIndoaWNoLW1vZHVsZSI6IHsKICAgICAgInZlcnNpb24iOiAiMi4w
LjAiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvd2hpY2gt
bW9kdWxlLy0vd2hpY2gtbW9kdWxlLTIuMC4wLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hh
MS0yZThIM09kN21RSzRvNmo2U3pIRDQvZm02SG89IgogICAgfSwKICAgICJ3b3JkLXdyYXAiOiB7
CiAgICAgICJ2ZXJzaW9uIjogIjEuMi4zIiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVn
aXN0cnkubnBtanMub3JnL3dvcmQtd3JhcC8tL3dvcmQtd3JhcC0xLjIuMy50Z3oiLAogICAgICAi
aW50ZWdyaXR5IjogInNoYTUxMi1Iei9tck53aXROUmgvSFVBdE0vVlQvNVZIK3lnRDZEVjdtWUta
QXRIT3JiczhVN2x2UFM2eGY3RUpLTUYwdVcxS0pDbDBINzAxZzNaR3VzK211RTV2UT09IgogICAg
fSwKICAgICJ3b3Jkd3JhcCI6IHsKICAgICAgInZlcnNpb24iOiAiMS4wLjAiLAogICAgICAicmVz
b2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvd29yZHdyYXAvLS93b3Jkd3JhcC0x
LjAuMC50Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTEtSjFoSUVJa1VWcVFYSEkwQ0prUWEz
cERMeXVzPSIKICAgIH0sCiAgICAid29yZHdyYXBqcyI6IHsKICAgICAgInZlcnNpb24iOiAiMy4w
LjAiLAogICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcvd29yZHdy
YXBqcy8tL3dvcmR3cmFwanMtMy4wLjAudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGE1MTIt
bU84WHRxeVB2eWtWQ3Nyd2o1TWxPVld2U25DZFQrQytRVmJtNmJscmFkUjdKRXhBaGJrWjdoWjlB
KzlOVXR3elNxcmxVbzlhNjd3czBFaUlMcnZScHc9PSIsCiAgICAgICJyZXF1aXJlcyI6IHsKICAg
ICAgICAicmVkdWNlLWZsYXR0ZW4iOiAiXjEuMC4xIiwKICAgICAgICAidHlwaWNhbCI6ICJeMi42
LjEiCiAgICAgIH0KICAgIH0sCiAgICAid3JhcC1hbnNpIjogewogICAgICAidmVyc2lvbiI6ICIy
LjEuMCIsCiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy93cmFw
LWFuc2kvLS93cmFwLWFuc2ktMi4xLjAudGd6IiwKICAgICAgImludGVncml0eSI6ICJzaGExLTJQ
dzlLRTNRVjVUK2hKYzhyczNSejRKUDNZVT0iLAogICAgICAicmVxdWlyZXMiOiB7CiAgICAgICAg
InN0cmluZy13aWR0aCI6ICJeMS4wLjEiLAogICAgICAgICJzdHJpcC1hbnNpIjogIl4zLjAuMSIK
ICAgICAgfSwKICAgICAgImRlcGVuZGVuY2llcyI6IHsKICAgICAgICAiYW5zaS1yZWdleCI6IHsK
ICAgICAgICAgICJ2ZXJzaW9uIjogIjIuMS4xIiwKICAgICAgICAgICJyZXNvbHZlZCI6ICJodHRw
czovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy9hbnNpLXJlZ2V4Ly0vYW5zaS1yZWdleC0yLjEuMS50Z3oi
LAogICAgICAgICAgImludGVncml0eSI6ICJzaGExLXc3TTZ0ZTQyRFliZzVpandSb3JuN3lmV1ZO
OD0iCiAgICAgICAgfSwKICAgICAgICAiaXMtZnVsbHdpZHRoLWNvZGUtcG9pbnQiOiB7CiAgICAg
ICAgICAidmVyc2lvbiI6ICIxLjAuMCIsCiAgICAgICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6Ly9y
ZWdpc3RyeS5ucG1qcy5vcmcvaXMtZnVsbHdpZHRoLWNvZGUtcG9pbnQvLS9pcy1mdWxsd2lkdGgt
Y29kZS1wb2ludC0xLjAuMC50Z3oiLAogICAgICAgICAgImludGVncml0eSI6ICJzaGExLTc1NHhP
RzhER244TlpEcjRMOTVReEZmdkFNcz0iLAogICAgICAgICAgInJlcXVpcmVzIjogewogICAgICAg
ICAgICAibnVtYmVyLWlzLW5hbiI6ICJeMS4wLjAiCiAgICAgICAgICB9CiAgICAgICAgfSwKICAg
ICAgICAic3RyaW5nLXdpZHRoIjogewogICAgICAgICAgInZlcnNpb24iOiAiMS4wLjIiLAogICAg
ICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL3N0cmluZy13aWR0
aC8tL3N0cmluZy13aWR0aC0xLjAuMi50Z3oiLAogICAgICAgICAgImludGVncml0eSI6ICJzaGEx
LUVZdmZXNHpjVWFLbjV3MGhIZ2Zpc0xteEI5TT0iLAogICAgICAgICAgInJlcXVpcmVzIjogewog
ICAgICAgICAgICAiY29kZS1wb2ludC1hdCI6ICJeMS4wLjAiLAogICAgICAgICAgICAiaXMtZnVs
bHdpZHRoLWNvZGUtcG9pbnQiOiAiXjEuMC4wIiwKICAgICAgICAgICAgInN0cmlwLWFuc2kiOiAi
XjMuMC4wIgogICAgICAgICAgfQogICAgICAgIH0sCiAgICAgICAgInN0cmlwLWFuc2kiOiB7CiAg
ICAgICAgICAidmVyc2lvbiI6ICIzLjAuMSIsCiAgICAgICAgICAicmVzb2x2ZWQiOiAiaHR0cHM6
Ly9yZWdpc3RyeS5ucG1qcy5vcmcvc3RyaXAtYW5zaS8tL3N0cmlwLWFuc2ktMy4wLjEudGd6IiwK
ICAgICAgICAgICJpbnRlZ3JpdHkiOiAic2hhMS1hamhmdUlVOWxTMWY4RjBPaXErVUo0M0dQYzg9
IiwKICAgICAgICAgICJyZXF1aXJlcyI6IHsKICAgICAgICAgICAgImFuc2ktcmVnZXgiOiAiXjIu
MC4wIgogICAgICAgICAgfQogICAgICAgIH0KICAgICAgfQogICAgfSwKICAgICJ3cmFwcHkiOiB7
CiAgICAgICJ2ZXJzaW9uIjogIjEuMC4yIiwKICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVn
aXN0cnkubnBtanMub3JnL3dyYXBweS8tL3dyYXBweS0xLjAuMi50Z3oiLAogICAgICAiaW50ZWdy
aXR5IjogInNoYTEtdFNROWp6N0Jxalh4TmtZRnZBMFFOdU1LdHA4PSIKICAgIH0sCiAgICAieHRl
bmQiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjQuMC4yIiwKICAgICAgInJlc29sdmVkIjogImh0dHBz
Oi8vcmVnaXN0cnkubnBtanMub3JnL3h0ZW5kLy0veHRlbmQtNC4wLjIudGd6IiwKICAgICAgImlu
dGVncml0eSI6ICJzaGE1MTItTEtZVTFpQVhKWFVnQVhuOVVSaml1K01XaHlVWEhzdmZwN21jdVlt
OWRTVUtLMC9DanRyVXdGQXhEODIvbUNXYnRMc0dqRklhZDB3SXNvZDR6clRBRVE9PSIKICAgIH0s
CiAgICAieTE4biI6IHsKICAgICAgInZlcnNpb24iOiAiNC4wLjMiLAogICAgICAicmVzb2x2ZWQi
OiAiaHR0cHM6Ly9yZWdpc3RyeS5ucG1qcy5vcmcveTE4bi8tL3kxOG4tNC4wLjMudGd6IiwKICAg
ICAgImludGVncml0eSI6ICJzaGE1MTItSktocVRPd1NycU5BMU5ZNWxTenRKMUdyQmlVb2RMTW1J
WnVMaURhTVJKK2l0RmQrQUJWRThYQmpPdklXTCtyU3FOREM3NExDU0ZtbGIvVTRVWjRoSlE9PSIK
ICAgIH0sCiAgICAieWFtbCI6IHsKICAgICAgInZlcnNpb24iOiAiMS4xMC4yIiwKICAgICAgInJl
c29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL3lhbWwvLS95YW1sLTEuMTAuMi50
Z3oiLAogICAgICAiaW50ZWdyaXR5IjogInNoYTUxMi1yM3ZYeUVyUkNZSjd3ZzI4eXZCWTVWU29B
RjhadmxjVzkvQndVekV0VXNqdlgvREtzMjRkSWt1d2p0dXByd0pKSHNieVViTEFwZXBZVFIxQk40
dUhyZz09IgogICAgfSwKICAgICJ5YXJncyI6IHsKICAgICAgInZlcnNpb24iOiAiMTIuMC41IiwK
ICAgICAgInJlc29sdmVkIjogImh0dHBzOi8vcmVnaXN0cnkubnBtanMub3JnL3lhcmdzLy0veWFy
Z3MtMTIuMC41LnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEyLUxoejhUTGFZbnhxLzJP
YnFIRHFsOGRYOENKaTk3b0h4cmpVY1l0ektiYnlrUHRWVzlXQitwb3hJK05NMlVJenNNZ05DWlRJ
ZjBBUXdzaks1eU1BcVp3PT0iLAogICAgICAicmVxdWlyZXMiOiB7CiAgICAgICAgImNsaXVpIjog
Il40LjAuMCIsCiAgICAgICAgImRlY2FtZWxpemUiOiAiXjEuMi4wIiwKICAgICAgICAiZmluZC11
cCI6ICJeMy4wLjAiLAogICAgICAgICJnZXQtY2FsbGVyLWZpbGUiOiAiXjEuMC4xIiwKICAgICAg
ICAib3MtbG9jYWxlIjogIl4zLjAuMCIsCiAgICAgICAgInJlcXVpcmUtZGlyZWN0b3J5IjogIl4y
LjEuMSIsCiAgICAgICAgInJlcXVpcmUtbWFpbi1maWxlbmFtZSI6ICJeMS4wLjEiLAogICAgICAg
ICJzZXQtYmxvY2tpbmciOiAiXjIuMC4wIiwKICAgICAgICAic3RyaW5nLXdpZHRoIjogIl4yLjAu
MCIsCiAgICAgICAgIndoaWNoLW1vZHVsZSI6ICJeMi4wLjAiLAogICAgICAgICJ5MThuIjogIl4z
LjIuMSB8fCBeNC4wLjAiLAogICAgICAgICJ5YXJncy1wYXJzZXIiOiAiXjExLjEuMSIKICAgICAg
fQogICAgfSwKICAgICJ5YXJncy1wYXJzZXIiOiB7CiAgICAgICJ2ZXJzaW9uIjogIjExLjEuMSIs
CiAgICAgICJyZXNvbHZlZCI6ICJodHRwczovL3JlZ2lzdHJ5Lm5wbWpzLm9yZy95YXJncy1wYXJz
ZXIvLS95YXJncy1wYXJzZXItMTEuMS4xLnRneiIsCiAgICAgICJpbnRlZ3JpdHkiOiAic2hhNTEy
LUM2a0IvV0pEaWF4T05MSlFuRjhjY3g5U0Vlb1RUTGVrOFJWYmFPSXNyQVVTOFZyQkVYZm1lU25D
Wnh5Z2MrWEMyc05NQkl3T09uZmN4aXluakhzVlNRPT0iLAogICAgICAicmVxdWlyZXMiOiB7CiAg
ICAgICAgImNhbWVsY2FzZSI6ICJeNS4wLjAiLAogICAgICAgICJkZWNhbWVsaXplIjogIl4xLjIu
MCIKICAgICAgfQogICAgfQogIH0KfQo=


--nextPart1873295.tdWV9SEqCh--

