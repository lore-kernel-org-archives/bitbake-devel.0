Received: from IND01-BO1-obe.outbound.protection.outlook.com (IND01-BO1-obe.outbound.protection.outlook.com [40.107.139.137])
 by mx.groups.io with SMTP id smtpd.web12.5519.1621324268854887199
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 May 2021 00:51:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@jasmin-infotech.com header.s=selector2 header.b=s9vRYxQT;
 spf=permerror, err=parse error for token &{10 18 mail.jasmin-infotech.com}: permanent DNS error (domain: jasmin-infotech.com, ip: 40.107.139.137, mailfrom: daniel.selvan@jasmin-infotech.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZ4xB74wSmmcW6wxTpO9oVhwoW9ADrytkoTfawoLC3prQAtQmRA3vPZsAIUOHZhVQNWUatELytp8KPxJYqkZSTX1hqwFFjFcboQsgUkzs7L+r+eArKIKR3Cq0pu1MdsbJSBY8K0VRUkktZjm3HBl6k0KvUk81DDwXgjC8GsQEYr2xDzBY2dCoAtILj14zsEID4stTH5fexkHvYe/6fTcOCsCD3VjeV0NtOc5q3iPfDGvzP/KtJO+hekxnslvV2SV7xT85V3MSmRGew03JoFNtYUH+8XjplPU7hz91VS27IStioYhYoTTrAU82qma2qBS32P3kc2444Z3WDVr1Jd4zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sibQPQewmeGOzU4FMn/6LljtBtCYP0weXUKaLjwzJPQ=;
 b=XmUEMBts/yqJUANzDCGbHV6B37OGf36jJHWUDH7J1JtIuLzP+8xxcvbRNATICvjq6wz80JZXDDh6+h899O8DHVZtU6vFdO877AaZmfqnbytoqqSzW6Ov2qRR3rjHAmmynDPb9xid8I6D02npmnSNH+XzcpeD1Qys6VIfLgblMBVE38xuaa9CEvDuD7RCpEHwqsjdBS1kXv8Zf52106qBks6Dx9GqXCXm1KfI68gBJkU9QeT1EHF19R/qpYRcHf9ryFU6jmhlbBP1knd0Ezz4wTCKdH45zASnA2I3yrkQvSdwFksCneFUxJCM5vsfWCarryEuBh7HHbw4r0fQ6FHg9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=permerror (sender ip
 is 61.16.140.213) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=jasmin-infotech.com; dmarc=fail (p=none sp=none pct=100)
 action=none header.from=jasmin-infotech.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jasmin-infotech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sibQPQewmeGOzU4FMn/6LljtBtCYP0weXUKaLjwzJPQ=;
 b=s9vRYxQTZZ08q8khCVyWiU0nGBAmE5Wn0bYwQIJxF4z9WAwcjjdtM8G+epPIyK6oWfE4DBAZ2Z31QawyhUWXXEVA6EcEkawbpjnpHn7F/y8LAoD3MXCZthEe9z+FZnfS020jVVFbg4faxZImazPgR7xRzKgcQDaNUETo8gbyL20=
Received: from BM1PR01CA0131.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:40::25)
 by MA1PR01MB3978.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:74::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 07:51:03 +0000
Received: from BO1IND01FT010.eop-IND01.prod.protection.outlook.com
 (2603:1096:b00:40:cafe::11) by BM1PR01CA0131.outlook.office365.com
 (2603:1096:b00:40::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Tue, 18 May 2021 07:51:03 +0000
X-MS-Exchange-Authentication-Results: spf=permerror (sender IP is
 61.16.140.213) smtp.mailfrom=jasmin-infotech.com; lists.openembedded.org;
 dkim=none (message not signed) header.d=none;lists.openembedded.org;
 dmarc=fail action=none header.from=jasmin-infotech.com;
Received-SPF: PermError (protection.outlook.com: domain of jasmin-infotech.com
 used an invalid SPF mechanism)
Received: from mail.jasmin-infotech.com (61.16.140.213) by
 BO1IND01FT010.mail.protection.outlook.com (10.152.202.124) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25 via Frontend Transport; Tue, 18 May 2021 07:51:01 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail.jasmin-infotech.com (Postfix) with ESMTP id 7394F1401A55;
	Tue, 18 May 2021 13:20:49 +0530 (IST)
Received: from mail.jasmin-infotech.com ([127.0.0.1])
	by localhost (mail.jasmin-infotech.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id htoZQaVHPkfl; Tue, 18 May 2021 13:20:49 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by mail.jasmin-infotech.com (Postfix) with ESMTP id 0D6F71401A51;
	Tue, 18 May 2021 13:20:49 +0530 (IST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
	mail.jasmin-infotech.com
X-Virus-Scanned: amavisd-new at jasmin-infotech.com
Received: from mail.jasmin-infotech.com ([127.0.0.1])
	by localhost (mail.jasmin-infotech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vNwyO5kQoS3f; Tue, 18 May 2021 13:20:48 +0530 (IST)
Received: from mail.jasmin-infotech.com (mail.jasmin-infotech.com [172.16.4.153])
	by mail.jasmin-infotech.com (Postfix) with ESMTP id DB8B81401A50;
	Tue, 18 May 2021 13:20:48 +0530 (IST)
Date: Tue, 18 May 2021 13:20:48 +0530 (IST)
From: "Daniel Selvan" <daniel.selvan@jasmin-infotech.com>
To: poky@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
Message-ID: <1180155480.90839930.1621324248815.JavaMail.zimbra@jasmin-infotech.com>
In-Reply-To: <141358386.90607893.1621323974188.JavaMail.zimbra@jasmin-infotech.com>
References: <141358386.90607893.1621323974188.JavaMail.zimbra@jasmin-infotech.com>
Subject: Disable Reproducible Build - reg
MIME-Version: 1.0
X-Originating-IP: [49.207.142.66]
X-Mailer: Zimbra 8.6.0_GA_1242 (ZimbraWebClient - GC91 (Linux)/8.6.0_GA_1242)
Thread-Topic: Disable Reproducible Build - reg
Thread-Index: ydH4eOxv/wvCpKrwql6MgoTLVEqBC5Gw89WJ
Return-Path: daniel.selvan@jasmin-infotech.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34d10cfd-c31f-4843-bdc2-08d919d1aeca
X-MS-TrafficTypeDiagnostic: MA1PR01MB3978:
X-Microsoft-Antispam-PRVS: 
	<MA1PR01MB397874F3938E821024B4C835B82C9@MA1PR01MB3978.INDPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rw9FMybq+Bd6X2iIZRCv2YfU91hLg1F599qn8kfZ/ijyPkWpVvSY8gmwEyAuFx+aOulITSX1E0dV65/9Mn1gK2IztMBKkGasQ7Yb1c3pABQFWTtZKbBLXlYG3wMwxTj+kvTVcKAfUnOpq0S7TopN5fnmW+T/RySH2a5LYdTa7hD12rkK+BOmHTdoY3tghlg/HOGoppXXpcA324Ljr7GAY51wskRm6nPCvZMW8tBf2/nqXPyt95OVRKKN6gjq216d2j1/SEYO0s08XE1apWhY456WhYXE5xvOZYLrnMUIyvX7g8P7D8hMrcZv70rD87/fqB+PvpPfXHqR55rwdoNMSxj4CDvhWjv0d4eiP1TFs//K1wAwzkWrUTsCMH3JrxSqHb0Ii1nxIWcBA4r7ZA0Gc8NUE+8CiDM9p0x1IgWIp7SyG9SWZ8K3/YMtw4iTGKHtzoDM1yejvvfBHcYsLYEPHQBmapzjcpL5d9gPASeHbY4jX9ajolK4/VRn6mcitvSR5z265Ab3piZH3j29IqdLFxGo34+huJxGErDzxzL+APdqAeP+GbcQWeW4QTa2LjSLKONycvRFwnJLzP5Ioez9U0fvXLng8bcGx3BiQwkP77/F2L6Ki2ol9wV7UUh44zNj3dT5bmYNc9XX3ORuAxAo/knuyiwMsFq0Vudj/lQ0y31WyXhTnhW//ADx1gU26YoX1nauUGy2M2hyqVdFIvgs81roCJiD78t0fYPEcBdDiHaTiY+duY7KHhXEwC30SyLaJVwe+mdU4ZFwXAZW0218Iw==
X-Forefront-Antispam-Report: 
	CIP:61.16.140.213;CTRY:IN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.jasmin-infotech.com;PTR:mail.jasmin-infotech.com;CAT:NONE;SFS:(136003)(39840400004)(376002)(396003)(346002)(46966006)(36840700001)(5660300002)(26005)(36906005)(8936002)(6266002)(86362001)(7066003)(36860700001)(7596003)(7636003)(316002)(83380400001)(70206006)(2906002)(82310400003)(166002)(186003)(966005)(426003)(7696005)(33964004)(36756003)(336012)(2616005)(47076005)(8676002)(55236004)(478600001)(356005)(70586007);DIR:OUT;SFP:1102;
X-OriginatorOrg: jasmin-infotech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 07:51:01.9634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d10cfd-c31f-4843-bdc2-08d919d1aeca
X-MS-Exchange-CrossTenant-Id: 5379b76d-5476-4c9f-a04c-fefa48abc331
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5379b76d-5476-4c9f-a04c-fefa48abc331;Ip=[61.16.140.213];Helo=[mail.jasmin-infotech.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BO1IND01FT010.eop-IND01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PR01MB3978
Content-Type: multipart/alternative; 
	boundary="----=_Part_90839929_959234939.1621324248815"

------=_Part_90839929_959234939.1621324248815
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi, 

I wonder how to disable the Yocto reproducible builds, since it is enabled by default now ( https://www.yoctoproject.org/docs/latest/ref-manual/ref-manual.html#migration-3.1-reproducible-builds ). 

Thanks in advance. 



Kind regards, 


Daniel Selvan D. 


Senior Systems Engineer | Jasmin Infotech 

+91 9445556596 

-- 


P Please consider the environment before printing this email. 



------=_Part_90839929_959234939.1621324248815
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman,new york,times,serif=
; font-size: 12pt; color: #000000"><div>Hi,<br></div><div data-marker=3D"__=
QUOTED_TEXT__"><div style=3D"font-family: times new roman,new york,times,se=
rif; font-size: 12pt; color: #000000;" data-mce-style=3D"font-family: times=
 new roman,new york,times,serif; font-size: 12pt; color: #000000;"><br><div=
>I wonder how to disable the Yocto reproducible builds, since it is enabled=
 by default now (<a href=3D"https://www.yoctoproject.org/docs/latest/ref-ma=
nual/ref-manual.html#migration-3.1-reproducible-builds" target=3D"_blank">h=
ttps://www.yoctoproject.org/docs/latest/ref-manual/ref-manual.html#migratio=
n-3.1-reproducible-builds</a>).</div><br><div>Thanks in advance.</div><br><=
div><p style=3D"margin: 0px; font-variant-caps: normal; letter-spacing: nor=
mal; text-align: start; text-indent: 0px; text-transform: none; white-space=
: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" data-mce-styl=
e=3D"margin: 0px; font-variant-caps: normal; letter-spacing: normal; text-a=
lign: start; text-indent: 0px; text-transform: none; white-space: normal; w=
ord-spacing: 0px; -webkit-text-stroke-width: 0px;"><span style=3D"font-fami=
ly: 'courier new', courier, monaco, monospace, sans-serif; font-size: 13pt;=
" data-mce-style=3D"font-family: 'courier new', courier, monaco, monospace,=
 sans-serif; font-size: 13pt;">Kind regards,</span><br></p><p style=3D"marg=
in: 0px; font-variant-caps: normal; letter-spacing: normal; text-align: sta=
rt; text-indent: 0px; text-transform: none; white-space: normal; word-spaci=
ng: 0px; -webkit-text-stroke-width: 0px;" data-mce-style=3D"margin: 0px; fo=
nt-variant-caps: normal; letter-spacing: normal; text-align: start; text-in=
dent: 0px; text-transform: none; white-space: normal; word-spacing: 0px; -w=
ebkit-text-stroke-width: 0px;"><span style=3D"font-family: georgia, serif; =
color: #3366ff; font-size: 13pt;" data-mce-style=3D"font-family: georgia, s=
erif; color: #3366ff; font-size: 13pt;">Daniel Selvan D.<br></span></p><p s=
tyle=3D"color: #000000; font-size: 16px; font-style: normal; font-variant-l=
igatures: normal; font-variant-caps: normal; font-weight: normal; letter-sp=
acing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transf=
orm: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-=
stroke-width: 0px; background-color: #ffffff; text-decoration: none; caret-=
color: #000000; font-family: arial, helvetica, sans-serif; text-size-adjust=
: auto; margin: 0px;" data-mce-style=3D"color: #000000; font-size: 16px; fo=
nt-style: normal; font-variant-ligatures: normal; font-variant-caps: normal=
; font-weight: normal; letter-spacing: normal; orphans: 2; text-align: star=
t; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #fffff=
f; text-decoration: none; caret-color: #000000; font-family: arial, helveti=
ca, sans-serif; text-size-adjust: auto; margin: 0px;"><span style=3D"font-f=
amily: georgia, serif; color: #999999; font-size: 11pt;" data-mce-style=3D"=
font-family: georgia, serif; color: #999999; font-size: 11pt;">Senior Syste=
ms Engineer<span>&nbsp;</span><strong>|</strong>&nbsp;<a href=3D"http://www=
.jasmin-infotech.com/the-company/contact-us/" title=3D"Jasmin Infotech Chen=
nai" target=3D"_blank" style=3D"color: #999999;" data-mce-style=3D"color: #=
999999;">Jasmin Infotech</a></span></p><p style=3D"color: #000000; font-siz=
e: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-c=
aps: normal; font-weight: normal; letter-spacing: normal; orphans: 2; text-=
align: start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-co=
lor: #ffffff; text-decoration: none; caret-color: #000000; font-family: ari=
al, helvetica, sans-serif; text-size-adjust: auto; margin: 0px;" data-mce-s=
tyle=3D"color: #000000; font-size: 16px; font-style: normal; font-variant-l=
igatures: normal; font-variant-caps: normal; font-weight: normal; letter-sp=
acing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transf=
orm: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-=
stroke-width: 0px; background-color: #ffffff; text-decoration: none; caret-=
color: #000000; font-family: arial, helvetica, sans-serif; text-size-adjust=
: auto; margin: 0px;"><span style=3D"font-family: 'courier new', courier, m=
onaco, monospace, sans-serif;" data-mce-style=3D"font-family: 'courier new'=
, courier, monaco, monospace, sans-serif;"><strong><span style=3D"font-size=
: 12pt;" data-mce-style=3D"font-size: 12pt;"><span style=3D"color: #999999;=
" data-mce-style=3D"color: #999999;"><span><span style=3D"caret-color: #336=
6ff;" data-mce-style=3D"caret-color: #3366ff;"><span class=3D"Object" id=3D=
"OBJ_PREFIX_DWT98_com_zimbra_phone" style=3D"text-decoration: none; cursor:=
 pointer;" data-mce-style=3D"text-decoration: none; cursor: pointer;">+91&n=
bsp;<a href=3D"callto:9445556596" target=3D"_blank" style=3D"color: #999999=
; text-decoration: none; cursor: pointer;" data-mce-style=3D"color: #999999=
; text-decoration: none; cursor: pointer;">9445556596</a></span></span></sp=
an></span></span></strong></span></p><p style=3D"margin: 0px; font-size: 11=
pt; font-family: Calibri, sans-serif; color: #000000; font-variant-caps: no=
rmal; letter-spacing: normal; text-align: start; text-indent: 0px; text-tra=
nsform: none; white-space: normal; word-spacing: 0px; -webkit-text-stroke-w=
idth: 0px;" data-mce-style=3D"margin: 0px; font-size: 11pt; font-family: Ca=
libri, sans-serif; color: #000000; font-variant-caps: normal; letter-spacin=
g: normal; text-align: start; text-indent: 0px; text-transform: none; white=
-space: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;"><span s=
tyle=3D"font-size: 13pt; font-family: arial, helvetica, sans-serif; color: =
#000000;" data-mce-style=3D"font-size: 13pt; font-family: arial, helvetica,=
 sans-serif; color: #000000;"><span id=3D"_mce_caret">=EF=BB=BF--</span><br=
></span></p><p style=3D"margin: 0px; font-size: 11pt; font-family: Calibri,=
 sans-serif; color: #000000; font-variant-caps: normal; letter-spacing: nor=
mal; text-align: start; text-indent: 0px; text-transform: none; white-space=
: normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" data-mce-styl=
e=3D"margin: 0px; font-size: 11pt; font-family: Calibri, sans-serif; color:=
 #000000; font-variant-caps: normal; letter-spacing: normal; text-align: st=
art; text-indent: 0px; text-transform: none; white-space: normal; word-spac=
ing: 0px; -webkit-text-stroke-width: 0px;"><span style=3D"font-size: 18pt; =
font-family: webdings; color: green;" data-mce-style=3D"font-size: 18pt; fo=
nt-family: webdings; color: green;">P</span> <span style=3D"font-size: 10pt=
; font-family: 'iskoola pota', sans-serif; color: green;" data-mce-style=3D=
"font-size: 10pt; font-family: 'iskoola pota', sans-serif; color: green;">P=
lease consider the environment before printing this email.</span></p></div>=
</div><br></div></div>
<br>=
<html><body>Information in this email is proprietary and Confidential to Jasmin Infotech Pvt. Ltd. Any use, copying or dissemination of the information in any manner without prior approval, is strictly prohibited. If you are not the intended recipient, please destroy the message and please inform to us..</body></html>=0A
<br>=
</body></html>

------=_Part_90839929_959234939.1621324248815--
