Return-Path: <mleonhardt@arri.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 988D2C433F5
	for <webhook@archiver.kernel.org>; Sun, 31 Oct 2021 20:00:37 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.102])
 by mx.groups.io with SMTP id smtpd.web08.35585.1635710433779339797
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 31 Oct 2021 13:00:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@arrigroup.onmicrosoft.com
 header.s=selector1-arrigroup-onmicrosoft-com header.b=f+3SoerE;
 spf=pass (domain: arri.de, ip: 40.107.15.102, mailfrom: mleonhardt@arri.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BuW//6QXj5gpzEeYdM93+PUJdkV0Bd9Z89PIeWYwYZ1M9JkgwWs1hz1Pu2j/Yc8uZbQnJB49hw3I8/Ae6CGJn4wBbnk3sC0bTw+WEP9fUaffFxXfFguEgnXMrOOHLnXwTmWDKCZV26NrxNpMYH7/+sx8eDniWioQzB3vHGvdD5AZaCvQbZ7nVsbuyu4zyrPys2gpMSgWVY/GWPWv5UOhQi0t/ctg4lGuevxfDva4GOedk7EDZc8b7UnfgnKtlRPS13GXIRSIzTFIXrHsHNbPzOyGaoiljOiNj8tOdu+nhN/5Xx7iHHUVWGspvAM6OgXFKFkrBQ3a8H1Dtl2bqaltrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDD+ZmgPsxSu2u55rM+53vESOWGWKw8Di2cgGPvwuik=;
 b=iBmrYZhZqDspNaoUnBKNVuNRYEtD/04CX/Qsjgqs03HgyrHPMl0Yk5+o2HefoT7nsNdissbVh41OzdQxLV93/11IDAHd3Mcaq6yWUF46p2IjlqiPtTurLUwTOdMpbtXt9MYsIWhXF0WHXNVc84B5GdTC9NTNMU1BMwVXtpeyY6HNtyLH8xq5jLOGyYMS6K5efg5bFsHnQ+WOv80kWt9bp4Q6nM7R4XQlc5EXxxE+WqW6noV7Othh4MwdiyzZab+dd+pGNmoPv6oSWBgvlNjeHmltFnFX/ijXH+ugUuXr1aHx0b1tSt+lIo21jzrv+0F/345uN6lV4zpYdG7TP29MGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 52.169.0.179) smtp.rcpttodomain=lists.openembedded.org smtp.mailfrom=arri.de;
 dmarc=bestguesspass action=none header.from=arri.de; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=arrigroup.onmicrosoft.com; s=selector1-arrigroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IDD+ZmgPsxSu2u55rM+53vESOWGWKw8Di2cgGPvwuik=;
 b=f+3SoerEAkFTl9OHbqUU/sm+aLf/4+QwD2zoIYKqHA6YckjbnyOLsCRsGv2VuSNU4CxeOz47wukuuW6vegOteA+irFdeaGMgDzfROixhFYyVvfMxRDSPl824ErP6Vh686LX18o8JmLV+fIfrDbt67tMW0nOt1Jwjl0HDHnoMc4E=
Received: from SV0P279CA0061.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:14::12)
 by AS8PR07MB7095.eurprd07.prod.outlook.com (2603:10a6:20b:257::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.5; Sun, 31 Oct
 2021 20:00:30 +0000
Received: from HE1EUR02FT006.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:f10:14:cafe::d5) by SV0P279CA0061.outlook.office365.com
 (2603:10a6:f10:14::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13 via Frontend
 Transport; Sun, 31 Oct 2021 20:00:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 52.169.0.179)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=arri.de;
Received-SPF: Pass (protection.outlook.com: domain of arri.de designates
 52.169.0.179 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.169.0.179; helo=eu2.smtp.exclaimer.net;
Received: from eu2.smtp.exclaimer.net (52.169.0.179) by
 HE1EUR02FT006.mail.protection.outlook.com (10.152.10.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4649.14 via Frontend Transport; Sun, 31 Oct 2021 20:00:28 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.57)
	 by eu2.smtp.exclaimer.net (52.169.0.179) with Exclaimer Signature Manager
	 ESMTP Proxy eu2.smtp.exclaimer.net (tlsversion=TLS12,
	 tlscipher=TLS_ECDHE_WITH_AES256_SHA384); Sun, 31 Oct 2021 20:00:28 +0000
X-ExclaimerHostedSignatures-MessageProcessed: true
X-ExclaimerProxyLatency: 13735237
X-ExclaimerImprintLatency: 2400580
X-ExclaimerImprintAction: 81f17211192b48b380d85c5c6b2fc693
Content-Type: multipart/related;
	boundary="----_=_NextPart_bb5d2268-8fda-47b3-8284-aec60f08e763"
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arri.de;
Received: from PA4PR07MB7309.eurprd07.prod.outlook.com (2603:10a6:102:d0::23)
 by PR3PR07MB6892.eurprd07.prod.outlook.com (2603:10a6:102:7b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.8; Sun, 31 Oct
 2021 20:00:23 +0000
Received: from PA4PR07MB7309.eurprd07.prod.outlook.com
 ([fe80::a150:27f6:7b27:fd22]) by PA4PR07MB7309.eurprd07.prod.outlook.com
 ([fe80::a150:27f6:7b27:fd22%6]) with mapi id 15.20.4669.009; Sun, 31 Oct 2021
 20:00:23 +0000
From: Manuel Leonhardt <mleonhardt@arri.de>
To: bitbake-devel@lists.openembedded.org
CC: Manuel Leonhardt <mleonhardt@arri.de>
Subject: [PATCH] Raise when filename of lockfile is too long to avoid infinite
 loop
Date: Sun, 31 Oct 2021 20:59:38 +0100
Message-ID: <20211031195938.79586-1-mleonhardt@arri.de>
X-Mailer: git-send-email 2.33.1
X-ClientProxiedBy: AM6PR10CA0068.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:80::45) To PA4PR07MB7309.eurprd07.prod.outlook.com
 (2603:10a6:102:d0::23)
MIME-Version: 1.0
Received: from MN-C02ZH1SVLVDR.fritz.box
 (2001:a61:ab1:ef01:bd53:518:f031:ec01) by
 AM6PR10CA0068.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::45) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13 via Frontend
 Transport; Sun, 31 Oct 2021 20:00:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78479f8f-c737-4b71-d97d-08d99ca91676
X-MS-TrafficTypeDiagnostic: PR3PR07MB6892:|AS8PR07MB7095:
X-Microsoft-Antispam-PRVS: 
	<AS8PR07MB7095572B3E81C5F2BD52E506D3899@AS8PR07MB7095.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;OLM:663;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 Ybl/9SC1+M39gr5taa2IDfcDnBiRS85PvPexoKqvyoAXCnThSFuLLHdyVtq008r/4DRIlgsiQnK4ducwNNo1J6OxQ66XccB0QKee3TRKZEKgMdEmmQiAq5iXitcDfPuD6LtqQxYkrfVqw5hNLkquYAKDJQUZ/LMgJErwe6Zl6q3ipq381D0PDyE2iS38GprQjiekhRVmPa11LDSDDV7NG9j9+38oHzvVzrO7K4cks1n7O6yoruifA1+bsMKb3307UyDNERzP12Fs+37ZjuvEZX6xqBT8TunRRiitUIHn9eJrkfDRoUuya1f7hyGr15RvPw6r/8hHBdtieH7Kg8J7ABIKXsmUylYq5IYcQ1faGzmLBT52Y5ZR+Z00XkesXlziV0wK7ZzJvItGiKWXSvSxS+DavUpvvIVFShC7IqIAdfEQ2Qulskxzr2r3YQeXtgrGkVg+iuS2SVaJHkig/G8NJrq6AhoUNE1EEm9wm7wnedcJjajt/XY/NzFlNCtR/+HJG1oQcFK2AbGXkJ0B+cUHLj2zRM9AfRfY8DPEAoPu2RzxVHdUX/1FLONVNom4fQB9lPp+pCn/bS7pfPdipDv7Pxg0gwcxwnrJqIQ6q/NxSujYwqwdp3NRQTnfUZovLhi7DHR5PNbGQhJKohEXMCAkLg==
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR07MB7309.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(6916009)(83380400001)(38100700002)(6666004)(52116002)(6506007)(107886003)(66476007)(66946007)(66556008)(8936002)(508600001)(4326008)(8676002)(186003)(6486002)(6512007)(316002)(2906002)(86362001)(5660300002)(36756003)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6892
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 HE1EUR02FT006.eop-EUR02.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	81d0ce73-6b13-4f37-76b1-08d99ca91325
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	e5HR/bH/Qdi7KJ0dsaW/HuFcTQ4IcfUjFM0ViWBqlRNakvBVQNdX58h7NH7XoYYZreLcz1nf/TkiuGerBjUIbivVui3MnzmDRZ58YL9pX/ZJtuuSb0KssFVkLCgk0gb3a1haI3oOeVdoDOGICDUjV2Sm293nWy29OfY4vpX2a84WBeN/m/PGQ27zZmGkgSBFSshfbc4CJkff4KsWJYlxLvK/rvir8VIhplKmtuPCbSEfAYc3y60PS9CZlYj0qanJewXZEeBkZ+vCVFEmEuMJ+KhJjbD4EP+qenWnZQ/+4VILLIwn8f2KMM5MwT6dVA7ybSB3f6JtiFrIMNPcKHLlmdv4IlmCwZQuLPHAIruRbsjTDa2z1l8QitmKb9L0E0B2ukdRg8NRumtnLZr9yCdMkmBHwwd0RtWUCq3Zipx14FwiMEXjA61A6H/nwaIKUrABzOGbHB0ps2U0XOSRNkzjN/ZsCJavZaLkNbo53hHUQAz65EwUvRjRI4v59+jpmy0NfC6sxzzAPQ67Ut4sW5Ygl6PyNu6yuvmiuDozYtK/Sw8kuwRs4zvBSya4TOdn2TuPUAPJyVtpZtgY25TsHa+kbFyi3etvWrB1HDBV0QbnxFrieHIcWTrnA412fqJo9gNf1SkdMJREAqZUyDrdGghyqMKIppnarkhfcXQqtEYBtZGXD0n/FNwhn1liV6EYezd5bTGU3qb5UPqT6i4KtTkTGn8mB2iVpgMCWACGvvND0iqmq0kMubUY9iFdxagQZoE8w69SOs+c6e1Dt3e1ulf1L9joCT+lhnoKOPwdTucug4ZW4npj+wfZghnaa17tB6UkSXjywPUGR23h3/zjvx0tRQ==
X-Forefront-Antispam-Report: 
	CIP:52.169.0.179;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu2.smtp.exclaimer.net;PTR:eu2.smtp.exclaimer.net;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(508600001)(6916009)(107886003)(336012)(66574015)(86362001)(2616005)(47076005)(15974865002)(82310400003)(1076003)(36860700001)(6486002)(6512007)(7066003)(7596003)(36756003)(4326008)(70586007)(7636003)(6506007)(5660300002)(70206006)(8936002)(356005)(8676002)(166002)(33964004)(2906002)(6666004)(26005)(186003)(316002)(83380400001);DIR:OUT;SFP:1102;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2021 20:00:28.5161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 78479f8f-c737-4b71-d97d-08d99ca91676
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[52.169.0.179];Helo=[eu2.smtp.exclaimer.net]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR02FT006.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7095
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 31 Oct 2021 20:00:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12850

This is a multi-part message in MIME format.

------_=_NextPart_bb5d2268-8fda-47b3-8284-aec60f08e763
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_dbb399e0-1d11-42e5-b342-d872939d3314"

------_=_NextPart_dbb399e0-1d11-42e5-b342-d872939d3314
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

When a filename is passed to bb.utils.lockfile, which is longer than
the filesystem can handle (usually more than 255 characters), an
OSError with errno ENAMETOOLONG is thrown. Previously, this was not
handled, which resulted in the function being trapped in an infinite
loop.

This situation can happen easily when sharing an sstate cache with
SSTATE_MIRROR via HTTP/S. The function generate_sstatefn in
sstate.bbclass tries to reduce sstate filenames to less than 255
characters, however this function does not honor the ".lock" suffix
added to the sstate file's name when it's downloaded from a http mirror
in the pstaging_fetch function. Consequently, when the filename of the
sstate file has more than 250 characters and ".lock" is added to the
file's name the above described ENAMETOOLONG error is thrown, which
causes populate tasks to hang indefinitely.

Signed-off-by: Manuel Leonhardt <mleonhardt@arri.de>
---
 lib/bb/utils.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 70634910..d3b8d8ce 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -487,7 +487,7 @@ def lockfile(name, shared=3DFalse, retry=3DTrue, block=
=3DFalse):
                     return lf
             lf.close()
         except OSError as e:
-            if e.errno =3D=3D errno.EACCES:
+            if e.errno in (errno.EACCES, errno.ENAMETOOLONG):
                 logger.error("Unable to acquire lock '%s', %s",
                              e.strerror, name)
                 sys.exit(1)
-- 
2.33.1


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

------_=_NextPart_dbb399e0-1d11-42e5-b342-d872939d3314
Content-Type: text/html;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dutf-8" /></head><body><div>When a filename is passed to bb.utils.lockfil=
e, which is longer than<br />the filesystem can handle (usually more than 2=
55 characters), an<br />OSError with errno ENAMETOOLONG is thrown. Previous=
ly, this was not<br />handled, which resulted in the function being trapped=
 in an infinite<br />loop.<br /><br />This situation can happen easily when=
 sharing an sstate cache with<br />SSTATE_MIRROR via HTTP/S. The function g=
enerate_sstatefn in<br />sstate.bbclass tries to reduce sstate filenames to=
 less than 255<br />characters, however this function does not honor the &q=
uot;.lock&quot; suffix<br />added to the sstate file&#39;s name when it&#39=
;s downloaded from a http mirror<br />in the pstaging_fetch function. Conse=
quently, when the filename of the<br />sstate file has more than 250 charac=
ters and &quot;.lock&quot; is added to the<br />file&#39;s name the above d=
escribed ENAMETOOLONG error is thrown, which<br />causes populate tasks to =
hang indefinitely.<br /><br />Signed-off-by: Manuel Leonhardt &lt;mleonhard=
t@arri.de&gt;<br />---<br /> lib/bb/utils.py | 2 +-<br /> 1 file changed, 1=
 insertion(+), 1 deletion(-)<br /><br />diff --git a/lib/bb/utils.py b/lib/=
bb/utils.py<br />index 70634910..d3b8d8ce 100644<br />--- a/lib/bb/utils.py=
<br />+++ b/lib/bb/utils.py<br />@@ -487,7 +487,7 @@ def lockfile(name, sha=
red=3DFalse, retry=3DTrue, block=3DFalse):<br />                     return=
 lf<br />             lf.close()<br />         except OSError as e:<br />- =
           if e.errno =3D=3D errno.EACCES:<br />+            if e.errno in =
(errno.EACCES, errno.ENAMETOOLONG):<br />                 logger.error(&quo=
t;Unable to acquire lock &#39;%s&#39;, %s&quot;,<br />                     =
         e.strerror, name)<br />                 sys.exit(1)<br />-- <br />=
2.33.1<br /><br /></div><div dir=3D"ltr" style=3D"mso-line-height-rule:exac=
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
nt-family:Calibri,Arial,sans-serif;">Manuel</td><td align=3D"left" style=
=3D"vertical-align:top;color:#000001;font-family:Calibri,Arial,sans-serif;"=
>&nbsp;<br /></td><td align=3D"left" style=3D"vertical-align:top;font-famil=
y:Calibri,Arial,sans-serif;">Leonhardt</td></tr></table></td></tr><tr style=
=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><table c=
ellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;color:=
#7F7F7F;font-style:normal;font-weight:400;white-space:nowrap;"><tr style=
=3D"font-size:14.67px;"><td align=3D"left" style=3D"vertical-align:top;font=
-family:Calibri,Arial,sans-serif;">Softwareentwickler</td></tr><tr style=
=3D"font-size:14.67px;color:#000001;"><td align=3D"left" style=3D"vertical-=
align:top;font-family:Calibri,Arial,sans-serif;">&#8203;</td></tr></table><=
/td></tr></table></td></tr><tr style=3D"font-size:0;"><td align=3D"left" st=
yle=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" bord=
er=3D"0" style=3D"font-size:0;"><tr style=3D"font-size:0;"><td align=3D"lef=
t" style=3D"vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0"=
 border=3D"0" style=3D"font-size:0;color:#0E50AD;font-style:normal;font-wei=
ght:400;white-space:nowrap;"><tr style=3D"font-size:13.33px;"><td align=3D"=
left" style=3D"vertical-align:top;font-family:&#39;Arial Black&#39;;">ARRI<=
/td></tr><tr style=3D"font-size:10.67px;color:#7F7F7F;"><td align=3D"left" =
style=3D"vertical-align:top;font-family:Arial;"><span style=3D"font-size:11=
px;">Arnold&nbsp;&amp;&nbsp;Richter&nbsp;Cine&nbsp;Technik&nbsp;GmbH&nbsp;&=
amp;&nbsp;Co.&nbsp;Betriebs&nbsp;KG</span>&nbsp;<br /></td></tr></table></t=
d></tr><tr style=3D"font-size:0;"><td align=3D"left" style=3D"vertical-alig=
n:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"fo=
nt-size:0;color:#7F7F7F;font-style:normal;font-weight:400;white-space:nowra=
p;"><tr style=3D"font-size:10.67px;"><td align=3D"left" style=3D"vertical-a=
lign:top;font-family:Arial;">Herbert=E2=80=91Bayer=E2=80=91Str.&nbsp;10</td=
><td align=3D"left" style=3D"vertical-align:top;font-family:Arial;">,&nbsp;=
<br /></td><td align=3D"left" style=3D"vertical-align:middle;font-family:Ar=
ial;">80807</td><td align=3D"left" style=3D"vertical-align:middle;font-fami=
ly:Arial;">&nbsp;<br /></td><td align=3D"left" style=3D"vertical-align:midd=
le;font-family:Arial;">M&#252;nchen</td></tr></table></td></tr></table></td=
></tr><tr style=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align=
:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"fon=
t-size:0;"><tr style=3D"font-size:0;"><td align=3D"left" style=3D"vertical-=
align:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=
=3D"font-size:0;color:#1532B9;font-style:normal;font-weight:400;white-space=
:nowrap;"><tr style=3D"font-size:11px;"><td align=3D"left" style=3D"vertica=
l-align:top;font-family:Arial;"><span style=3D"text-decoration:underline;">=
<a href=3D"http://www.arri.com/" target=3D"_blank" id=3D"LPlnk689713" style=
=3D"text-decoration:underline;color:#1532B9;"><strong style=3D"font-weight:=
400;">www.arri.com&nbsp;<br /><br /></strong></a></span></td></tr><tr style=
=3D"font-size:0;"><td align=3D"left" style=3D"vertical-align:top;"><table c=
ellpadding=3D"0" cellspacing=3D"0" border=3D"0" style=3D"font-size:0;color:=
#858080;font-style:normal;font-weight:400;line-height:normal;white-space:no=
wrap;"><tr style=3D"font-size:14.67px;"><td align=3D"left" style=3D"padding=
:0;vertical-align:top;font-size:0;"><img src=3D"cid:image392099.png@A5E227E=
9.D18879F5" width=3D"20" border=3D"0" alt=3D"" style=3D"width:20px;min-widt=
h:20px;max-width:20px;font-size:0;" /></td><td align=3D"left" style=3D"padd=
ing:0;vertical-align:top;font-family:Calibri,Arial,sans-serif;"><a href=3D"=
tel:+49%2089%203809-1719" target=3D"_blank" id=3D"LPlnk689713" style=3D"tex=
t-decoration:none;color:#858080;"><strong style=3D"font-weight:400;">+49&nb=
sp;89&nbsp;3809-1719</strong></a></td></tr><tr style=3D"font-size:0;"><td a=
lign=3D"left" style=3D"padding:0;vertical-align:top;"></td><td align=3D"lef=
t" style=3D"padding:0;vertical-align:top;"></td></tr><tr style=3D"font-size=
:0;"><td align=3D"left" style=3D"padding:0;vertical-align:top;"></td><td al=
ign=3D"left" style=3D"padding:0;vertical-align:top;"></td></tr><tr style=
=3D"font-size:14.67px;"><td align=3D"left" style=3D"padding:0;vertical-alig=
n:top;font-size:0;"><img src=3D"cid:image685150.png@1723A27B.81EF60F2" widt=
h=3D"20" border=3D"0" alt=3D"" style=3D"width:20px;min-width:20px;max-width=
:20px;font-size:0;" /></td><td align=3D"left" style=3D"padding:0;vertical-a=
lign:top;font-family:Calibri,Arial,sans-serif;"><a href=3D"mailto:MLeonhard=
t@arri.de" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:no=
ne;color:#858080;"><strong style=3D"font-weight:400;">MLeonhardt@arri.de</s=
trong></a></td></tr></table></td></tr></table></td></tr></table></td></tr><=
tr style=3D"font-size:14.67px;color:#000001;font-style:normal;font-weight:4=
00;white-space:nowrap;"><td align=3D"left" style=3D"vertical-align:top;font=
-family:Calibri,Arial,sans-serif;"><br />&#8203;</td></tr></table></td></tr=
><tr style=3D"font-size:0;line-height:normal;"><td align=3D"left" style=3D"=
padding:0;vertical-align:top;"><a href=3D"https://www.arri.com/hi-5" target=
=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:none;"><img src=3D"=
https://assets.arri.com/media/sign/2021-06-16-E-mail-signature-Hi-5-01.jpg"=
 border=3D"0" title=3D"Hi-5: Further. Stronger. Faster" alt=3D"Hi-5: Furthe=
r. Stronger. Faster" style=3D"font-size:12px;" /></a></td></tr><tr style=
=3D"font-size:13px;color:#7F7F7F;font-style:normal;font-weight:400;white-sp=
ace:nowrap;"><td align=3D"left" style=3D"padding:0;vertical-align:top;font-=
family:Calibri,Arial,sans-serif;">Get&nbsp;all&nbsp;the&nbsp;latest&nbsp;in=
formation&nbsp;from&nbsp;<span style=3D"text-decoration:underline;"><a href=
=3D"http://www.arri.com/" target=3D"_blank" id=3D"LPlnk689713" title=3D"www=
=2Earri.com" style=3D"text-decoration:underline;color:#7F7F7F;"><strong sty=
le=3D"font-weight:400;">www.arri.com</strong></a></span>,&nbsp;<span style=
=3D"text-decoration:underline;"><a href=3D"https://www.facebook.com/TeamARR=
I" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:underline;=
color:#7F7F7F;"><strong style=3D"font-weight:400;">Facebook</strong></a></s=
pan>,&nbsp;<span style=3D"text-decoration:underline;"><a href=3D"https://tw=
itter.com/ARRIChannel" target=3D"_blank" id=3D"LPlnk689713" style=3D"text-d=
ecoration:underline;color:#7F7F7F;"><strong style=3D"font-weight:400;">Twit=
ter</strong></a></span>,&nbsp;<span style=3D"text-decoration:underline;"><a=
 href=3D"http://instagram.com/arri" target=3D"_blank" id=3D"LPlnk689713" st=
yle=3D"text-decoration:underline;color:#7F7F7F;"><strong style=3D"font-weig=
ht:400;">Instagram</strong></a></span>&nbsp;and&nbsp;<span style=3D"text-de=
coration:underline;"><a href=3D"http://www.youtube.com/user/ARRIChannel" ta=
rget=3D"_blank" id=3D"LPlnk689713" style=3D"text-decoration:underline;color=
:#7F7F7F;"><strong style=3D"font-weight:400;">YouTube</strong></a></span>.<=
br /></td></tr><tr style=3D"font-size:0;"><td align=3D"left" style=3D"paddi=
ng:0;vertical-align:top;"><table cellpadding=3D"0" cellspacing=3D"0" border=
=3D"0" style=3D"font-size:0;color:#6A6A6A;font-style:normal;font-weight:400=
;white-space:nowrap;"><tr style=3D"font-size:10px;"><td align=3D"left" styl=
e=3D"vertical-align:top;font-family:Arial;"><br />Arnold&nbsp;&amp;&nbsp;Ri=
chter&nbsp;Cine&nbsp;Technik&nbsp;GmbH&nbsp;&amp;&nbsp;Co.&nbsp;Betriebs&nb=
sp;KG<br />Sitz:&nbsp;M&#252;nchen&nbsp;=E2=80=91&nbsp;Registergericht:&nbs=
p;Amtsgericht&nbsp;M&#252;nchen&nbsp;=E2=80=91&nbsp;Handelsregisternummer:&=
nbsp;HRA&nbsp;57918<br />Pers&#246;nlich&nbsp;haftender&nbsp;Gesellschafter=
:&nbsp;Arnold&nbsp;&amp;&nbsp;Richter&nbsp;Cine&nbsp;Technik&nbsp;GmbH<br /=
>Sitz:&nbsp;M&#252;nchen&nbsp;=E2=80=91&nbsp;Registergericht:&nbsp;Amtsgeri=
cht&nbsp;M&#252;nchen&nbsp;=E2=80=91&nbsp;Handelsregisternummer:&nbsp;HRB&n=
bsp;54477<br />Gesch&#228;ftsf&#252;hrer:&nbsp;Dr.&nbsp;Michael&nbsp;Neuh&#=
228;user;&nbsp;Stephan&nbsp;Schenk;&nbsp;Walter&nbsp;Trauninger;&nbsp;Marku=
s&nbsp;Zeiler<br /></td></tr><tr style=3D"font-size:14.67px;color:#000001;"=
><td align=3D"left" style=3D"vertical-align:top;font-family:Calibri,Arial,s=
ans-serif;"><br />&#8203;<br /></td></tr></table></td></tr></table></td></t=
r></table></div></body></html>
------_=_NextPart_dbb399e0-1d11-42e5-b342-d872939d3314--

------_=_NextPart_bb5d2268-8fda-47b3-8284-aec60f08e763
Content-Type: image/png;
	name="image392099.png"
Content-Transfer-Encoding: base64
Content-ID: <image392099.png@A5E227E9.D18879F5>
Content-Description: image392099.png
Content-Disposition: inline;
	creation-date="Sun, 31 Oct 2021 20:00:28 +0000";
	filename=image392099.png;
	modification-date="Sun, 31 Oct 2021 20:00:28 +0000";
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

------_=_NextPart_bb5d2268-8fda-47b3-8284-aec60f08e763
Content-Type: image/png;
	name="image685150.png"
Content-Transfer-Encoding: base64
Content-ID: <image685150.png@1723A27B.81EF60F2>
Content-Description: image685150.png
Content-Disposition: inline;
	creation-date="Sun, 31 Oct 2021 20:00:28 +0000";
	filename=image685150.png;
	modification-date="Sun, 31 Oct 2021 20:00:28 +0000";
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

------_=_NextPart_bb5d2268-8fda-47b3-8284-aec60f08e763--

