Received: from IND01-MA1-obe.outbound.protection.outlook.com (IND01-MA1-obe.outbound.protection.outlook.com [40.107.138.112])
 by mx.groups.io with SMTP id smtpd.web09.28277.1604307125264946511
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 02 Nov 2020 00:52:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@jasmin-infotech.com header.s=selector2 header.b=Qsr8Uwze;
 spf=permerror, err=parse error for token &{10 18 mail.jasmin-infotech.com}: permanent DNS error (domain: jasmin-infotech.com, ip: 40.107.138.112, mailfrom: daniel.selvan@jasmin-infotech.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eV6FxNNUivFxWSKPqHEDZcpQOeoCeavkwuD1NRsuRvHuqmgPHUxhq9KMsBP/jgkSXpUh5uAFOextuqogOaDOYqLiaMpmsEEtN/dsaGHUx0S+BPaRTLuMLQWv5tYJ2bVRwcZWTMxWxNnCP7fmD05i48Ra90wNOVMkxH3CRpSPwPT7bf1a40CDjd2X77WA88qPFoYplc9LeepBBBfPBXEay5pnM+hMoZbUV3BIew8wA70nRAAgS6EkJmSlW53n7zLzBpe++mCLqrwo9j867w1OYOiR/5HT3K4iwc0x1EXXea1tV7+hJMZis8OHr+tUXVhvugj2DMqJMmM5sKh3AbymKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FloiNvc0mAOfy88ZyWrMszPmUEjr5xkr59oUr2Rp1w=;
 b=Uleso99Txl/7w3G/VKSwThPCthPgXCGU0k/OzaoUGoACSd/bOXoMNcn7SORrLsPyiOJdYs9cwcGYMsRWUWC2ONVc5X09GekUTgVMiYkddFaRUm28wo3k3lVAM78Dt2zH5ZXx/uhmMfK0gj2YVGndKcPnQd1DLUzTIuiyCxU3TlKp8q0yYPLYNGzxPIuwewb1PC5YnWRp0P05MgDoZ7EkoTgdwodQB0frKVDB/uA3wvYA+r7qFSrnKtl4uM8ZqtxbRCKtk/+/koJCTJLDk3WlCtlTsu+TbEbAKeWu9eylsPxRJeqfSa0VpPY8JBzagC+3LUmHFsgdcm/S3s3HnfvkvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=permerror (sender ip
 is 61.16.140.213) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=jasmin-infotech.com; dmarc=fail (p=none sp=none pct=100)
 action=none header.from=jasmin-infotech.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jasmin-infotech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FloiNvc0mAOfy88ZyWrMszPmUEjr5xkr59oUr2Rp1w=;
 b=Qsr8UwzeX11VoH1qsNHzfFmFcJf1rRxvdoRtRc6Ks5ACzI+EPWytCtfyycuZhgk6g32c5Ay5Jb6gG38W9nStW19YwaPqODc6v+WD9gZX4Nt2E5rmwb55s1dQk3+FwP2jRSdUITMek/t1GPVVvkCAIVU/CysdssXuhxZI1iROOBo=
Received: from PN1PR0101CA0011.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:e::21)
 by MAXPR0101MB1210.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:1d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Mon, 2 Nov
 2020 08:52:01 +0000
Received: from BO1IND01FT004.eop-IND01.prod.protection.outlook.com
 (2603:1096:c00:e:cafe::3c) by PN1PR0101CA0011.outlook.office365.com
 (2603:1096:c00:e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Mon, 2 Nov 2020 08:52:01 +0000
X-MS-Exchange-Authentication-Results: spf=permerror (sender IP is
 61.16.140.213) smtp.mailfrom=jasmin-infotech.com; lists.openembedded.org;
 dkim=none (message not signed) header.d=none;lists.openembedded.org;
 dmarc=fail action=none header.from=jasmin-infotech.com;
Received-SPF: PermError (protection.outlook.com: domain of jasmin-infotech.com
 used an invalid SPF mechanism)
Received: from mail.jasmin-infotech.com (61.16.140.213) by
 BO1IND01FT004.mail.protection.outlook.com (10.152.202.115) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3520.15 via Frontend Transport; Mon, 2 Nov 2020 08:51:59 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail.jasmin-infotech.com (Postfix) with ESMTP id 7499514019BD;
	Mon,  2 Nov 2020 14:21:26 +0530 (IST)
Received: from mail.jasmin-infotech.com ([127.0.0.1])
	by localhost (mail.jasmin-infotech.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id OCZ6iuRddlow; Mon,  2 Nov 2020 14:21:25 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by mail.jasmin-infotech.com (Postfix) with ESMTP id 410BC14019BC;
	Mon,  2 Nov 2020 14:21:25 +0530 (IST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
	mail.jasmin-infotech.com
X-Virus-Scanned: amavisd-new at jasmin-infotech.com
Received: from mail.jasmin-infotech.com ([127.0.0.1])
	by localhost (mail.jasmin-infotech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fIilHfCmojgE; Mon,  2 Nov 2020 14:21:25 +0530 (IST)
Received: from mail.jasmin-infotech.com (mail.jasmin-infotech.com [172.16.4.153])
	by mail.jasmin-infotech.com (Postfix) with ESMTP id 1D1FE14019B5;
	Mon,  2 Nov 2020 14:21:25 +0530 (IST)
Date: Mon, 2 Nov 2020 14:21:25 +0530 (IST)
From: "Daniel Selvan" <daniel.selvan@jasmin-infotech.com>
To: yocto <yocto@lists.yoctoproject.org>, bitbake-devel@lists.openembedded.org
Message-ID: <204888768.121393313.1604307085037.JavaMail.zimbra@jasmin-infotech.com>
Subject: How can I perform arithmetic operations in bitbake file?
MIME-Version: 1.0
X-Originating-IP: [49.207.131.149]
X-Mailer: Zimbra 8.6.0_GA_1242 (ZimbraWebClient - GC86 (Linux)/8.6.0_GA_1242)
Thread-Topic: How can I perform arithmetic operations in bitbake file?
Thread-Index: OcHjHn8sxn9amDW02BeXiPBNpmraYw==
Return-Path: daniel.selvan@jasmin-infotech.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b1ad1b7-b144-4ec2-d0ac-08d87f0c8f86
X-MS-TrafficTypeDiagnostic: MAXPR0101MB1210:
X-Microsoft-Antispam-PRVS: 
	<MAXPR0101MB12100D430D5FF1F62D0A44EEB8100@MAXPR0101MB1210.INDPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	h6mGP60xO5VBKfwLt8G000u+ABeiDgrBKq84rOV8W2rRnZE5lzr5pZcmkExZqRG5gZLxC98YpIUAwJpZ0Rhk+PIciuer6iz5SLEJlESUh69HI/U4QgmMsl8qmHERsdonZQdpOPj4j0fU4UGx0yi1PIqpS0PWEivT2u0Y7xIXhUBc0Qx1VrWD10JaFJzDBPzYFJMOjCGhUj4yQTreKnSJRwUD1BtpCQPQfipqldjSGdVdyJrlsN8E4VH6c90+INCBWV7lRvX7eGbxvmEvyWoWAT2lbHqvxVT5mE2L0e7+UMeViamPmwWi8QXJHMRaaUbWuJJ4vKeuIJaLcfEbP5R/qFIyznN8+BldBB48XsT6SUtOtTMmzwnv4OoXL0T8VeIUjFjtiuwFN9W7NSaUL94Tcu1/QiBJtEM1YbCrzVCbGO/UNqmNhcd31jCnlnIVFNfaUNszeDQiT0aEl4c5Syi7cJxqFbx3Y/PDPIv67Y5c4hVO364FdHbVzXZq25DnLhm/
X-Forefront-Antispam-Report: 
	CIP:61.16.140.213;CTRY:IN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.jasmin-infotech.com;PTR:mail.jasmin-infotech.com;CAT:NONE;SFS:(396003)(39840400004)(376002)(136003)(346002)(46966005)(82310400003)(5660300002)(83380400001)(186003)(2906002)(316002)(26005)(33310700002)(2616005)(426003)(36906005)(8676002)(478600001)(36756003)(70586007)(966005)(55236004)(336012)(8936002)(70206006)(86362001)(6266002)(47076004)(7696005)(33964004)(166002)(7636003)(7066003)(356005)(7596003);DIR:OUT;SFP:1102;
X-OriginatorOrg: jasmin-infotech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2020 08:51:59.6277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1ad1b7-b144-4ec2-d0ac-08d87f0c8f86
X-MS-Exchange-CrossTenant-Id: 5379b76d-5476-4c9f-a04c-fefa48abc331
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5379b76d-5476-4c9f-a04c-fefa48abc331;Ip=[61.16.140.213];Helo=[mail.jasmin-infotech.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BO1IND01FT004.eop-IND01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR0101MB1210
Content-Type: multipart/alternative; 
	boundary="----=_Part_121393312_1169650705.1604307085037"

------=_Part_121393312_1169650705.1604307085037
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi, 



Greetings of the day! 



I would like to get the size of binary generated and pad it to the next number divisible by 0x10 in a .bbappend file. 


    1. Can someone help me achieving this? 
    2. How can I perform arithmetic operations in bitbake file? 

I've raised this query in stackoverflow as well, have a look at it here: https://stackoverflow.com/q/64641596/10773894 

Thanks in advance, 


Daniel Selvan D. 


Systems Engineer | Jasmin Infotech 

-- 


P Please consider the environment before printing this email. 



------=_Part_121393312_1169650705.1604307085037
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman,new york,times,serif=
; font-size: 12pt; color: #000000"><div style=3D"color: #000000; font-famil=
y: 'times new roman', 'new york', times, serif; font-size: 16px; font-style=
: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-w=
eight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-tran=
sform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-tex=
t-stroke-width: 0px; background-color: #ffffff; text-decoration-style: init=
ial; text-decoration-color: initial; text-align: justify;" data-mce-style=
=3D"color: #000000; font-family: 'times new roman', 'new york', times, seri=
f; font-size: 16px; font-style: normal; font-variant-ligatures: normal; fon=
t-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: =
2; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #fffff=
f; text-decoration-style: initial; text-decoration-color: initial; text-ali=
gn: justify;"><span style=3D"font-size: 13pt;" data-mce-style=3D"font-size:=
 13pt;">Hi,</span></div><blockquote style=3D"color: #000000; font-family: '=
times new roman', 'new york', times, serif; font-size: 16px; font-style: no=
rmal; font-variant-ligatures: normal; font-variant-caps: normal; font-weigh=
t: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent:=
 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0=
px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decorat=
ion-style: initial; text-decoration-color: initial;" data-mce-style=3D"colo=
r: #000000; font-family: 'times new roman', 'new york', times, serif; font-=
size: 16px; font-style: normal; font-variant-ligatures: normal; font-varian=
t-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-=
align: start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-co=
lor: #ffffff; text-decoration-style: initial; text-decoration-color: initia=
l;"><div style=3D"text-align: justify;" data-mce-style=3D"text-align: justi=
fy;"><span style=3D"font-size: 13pt; font-family: 'comic sans ms', 'comic s=
ans', sans-serif;" data-mce-style=3D"font-size: 13pt; font-family: 'comic s=
ans ms', 'comic sans', sans-serif;">Greetings of the day!</span></div></blo=
ckquote><div style=3D"color: #000000; font-family: 'times new roman', 'new =
york', times, serif; font-size: 16px; font-style: normal; font-variant-liga=
tures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing:=
 normal; orphans: 2; text-indent: 0px; text-transform: none; white-space: n=
ormal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; backgr=
ound-color: #ffffff; text-decoration-style: initial; text-decoration-color:=
 initial; text-align: justify;" data-mce-style=3D"color: #000000; font-fami=
ly: 'times new roman', 'new york', times, serif; font-size: 16px; font-styl=
e: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-=
weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-tra=
nsform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-te=
xt-stroke-width: 0px; background-color: #ffffff; text-decoration-style: ini=
tial; text-decoration-color: initial; text-align: justify;"><span style=3D"=
font-size: 13pt; font-family: garamond, 'new york', times, serif;" data-mce=
-style=3D"font-size: 13pt; font-family: garamond, 'new york', times, serif;=
">I would like to get the size of&nbsp;binary generated and pad it to the n=
ext number divisible by 0x10 in a<span>&nbsp;</span><span style=3D"font-fam=
ily: 'lucida console', sans-serif;" data-mce-style=3D"font-family: 'lucida =
console', sans-serif;">.bbappend</span><span>&nbsp;</span>file.</span><br><=
/div><ol style=3D"color: #000000; font-family: 'times new roman', 'new york=
', times, serif; font-size: 16px; font-style: normal; font-variant-ligature=
s: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: nor=
mal; orphans: 2; text-indent: 0px; text-transform: none; white-space: norma=
l; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background=
-color: #ffffff; text-decoration-style: initial; text-decoration-color: ini=
tial; text-align: justify;" data-mce-style=3D"color: #000000; font-family: =
'times new roman', 'new york', times, serif; font-size: 16px; font-style: n=
ormal; font-variant-ligatures: normal; font-variant-caps: normal; font-weig=
ht: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-transfo=
rm: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-s=
troke-width: 0px; background-color: #ffffff; text-decoration-style: initial=
; text-decoration-color: initial; text-align: justify;"><li><span style=3D"=
font-size: 13pt; font-family: garamond, 'new york', times, serif;" data-mce=
-style=3D"font-size: 13pt; font-family: garamond, 'new york', times, serif;=
">Can someone help me achieving this?</span></li><li><span style=3D"font-si=
ze: 13pt; font-family: garamond, 'new york', times, serif;" data-mce-style=
=3D"font-size: 13pt; font-family: garamond, 'new york', times, serif;">How =
can I perform arithmetic operations in bitbake file?</span></li></ol><div s=
tyle=3D"color: #000000; font-family: 'times new roman', 'new york', times, =
serif; font-size: 16px; font-style: normal; font-variant-ligatures: normal;=
 font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orpha=
ns: 2; text-indent: 0px; text-transform: none; white-space: normal; widows:=
 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #f=
fffff; text-decoration-style: initial; text-decoration-color: initial; text=
-align: justify;" data-mce-style=3D"color: #000000; font-family: 'times new=
 roman', 'new york', times, serif; font-size: 16px; font-style: normal; fon=
t-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; l=
etter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none; =
white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-widt=
h: 0px; background-color: #ffffff; text-decoration-style: initial; text-dec=
oration-color: initial; text-align: justify;"><span style=3D"font-size: 13p=
t; font-family: garamond, 'new york', times, serif;" data-mce-style=3D"font=
-size: 13pt; font-family: garamond, 'new york', times, serif;">I've raised =
this query in stackoverflow as well, have a look at it here:&nbsp;<span cla=
ss=3D"Object" role=3D"link" id=3D"OBJ_PREFIX_DWT566_com_zimbra_url" style=
=3D"color: #005a95; text-decoration: none; cursor: pointer;" data-mce-style=
=3D"color: #005a95; text-decoration: none; cursor: pointer;"><a href=3D"htt=
ps://stackoverflow.com/q/64641596/10773894" target=3D"_blank" style=3D"colo=
r: #005a95; text-decoration: none; cursor: pointer;" data-mce-href=3D"https=
://stackoverflow.com/q/64641596/10773894" data-mce-style=3D"color: #005a95;=
 text-decoration: none; cursor: pointer;">https://stackoverflow.com/q/64641=
596/10773894</a></span></span></div><div style=3D"color: #000000; font-fami=
ly: 'times new roman', 'new york', times, serif; font-size: 16px; font-styl=
e: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-=
weight: 400; letter-spacing: normal; orphans: 2; text-indent: 0px; text-tra=
nsform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-te=
xt-stroke-width: 0px; background-color: #ffffff; text-decoration-style: ini=
tial; text-decoration-color: initial; text-align: justify;" data-mce-style=
=3D"color: #000000; font-family: 'times new roman', 'new york', times, seri=
f; font-size: 16px; font-style: normal; font-variant-ligatures: normal; fon=
t-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: =
2; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: #fffff=
f; text-decoration-style: initial; text-decoration-color: initial; text-ali=
gn: justify;"><br></div><div style=3D"color: #000000; font-family: 'times n=
ew roman', 'new york', times, serif; font-size: 16px; font-style: normal; f=
ont-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400;=
 letter-spacing: normal; orphans: 2; text-indent: 0px; text-transform: none=
; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-wi=
dth: 0px; background-color: #ffffff; text-decoration-style: initial; text-d=
ecoration-color: initial; text-align: justify;" data-mce-style=3D"color: #0=
00000; font-family: 'times new roman', 'new york', times, serif; font-size:=
 16px; font-style: normal; font-variant-ligatures: normal; font-variant-cap=
s: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-inden=
t: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing:=
 0px; -webkit-text-stroke-width: 0px; background-color: #ffffff; text-decor=
ation-style: initial; text-decoration-color: initial; text-align: justify;"=
><span style=3D"font-size: 13pt;" data-mce-style=3D"font-size: 13pt;">Thank=
s in advance,</span></div><div style=3D"color: #000000; font-family: 'times=
 new roman', 'new york', times, serif; font-size: 16px; font-style: normal;=
 font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 40=
0; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px;=
 text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -=
webkit-text-stroke-width: 0px; background-color: #ffffff; text-decoration-s=
tyle: initial; text-decoration-color: initial;" data-mce-style=3D"color: #0=
00000; font-family: 'times new roman', 'new york', times, serif; font-size:=
 16px; font-style: normal; font-variant-ligatures: normal; font-variant-cap=
s: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align=
: start; text-indent: 0px; text-transform: none; white-space: normal; widow=
s: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: =
#ffffff; text-decoration-style: initial; text-decoration-color: initial;"><=
p style=3D"caret-color: #000000; color: #000000; font-family: arial, helvet=
ica, sans-serif; font-size: 16px; font-style: normal; font-variant-caps: no=
rmal; font-weight: normal; letter-spacing: normal; text-align: justify; tex=
t-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0px=
; text-size-adjust: auto; -webkit-text-stroke-width: 0px; text-decoration: =
none; margin: 0px;" data-mce-style=3D"caret-color: #000000; color: #000000;=
 font-family: arial, helvetica, sans-serif; font-size: 16px; font-style: no=
rmal; font-variant-caps: normal; font-weight: normal; letter-spacing: norma=
l; text-align: justify; text-indent: 0px; text-transform: none; white-space=
: normal; word-spacing: 0px; text-size-adjust: auto; -webkit-text-stroke-wi=
dth: 0px; text-decoration: none; margin: 0px;"><span style=3D"font-family: =
georgia, serif;" data-mce-style=3D"font-family: georgia, serif;"><span styl=
e=3D"font-size: 13pt; color: #3366ff;" data-mce-style=3D"font-size: 13pt; c=
olor: #3366ff;">Daniel Selvan D.</span></span><br></p><p style=3D"caret-col=
or: #000000; color: #000000; font-family: arial, helvetica, sans-serif; fon=
t-size: 16px; font-style: normal; font-variant-caps: normal; font-weight: n=
ormal; letter-spacing: normal; text-align: justify; text-indent: 0px; text-=
transform: none; white-space: normal; word-spacing: 0px; text-size-adjust: =
auto; -webkit-text-stroke-width: 0px; text-decoration: none; margin: 0px;" =
data-mce-style=3D"caret-color: #000000; color: #000000; font-family: arial,=
 helvetica, sans-serif; font-size: 16px; font-style: normal; font-variant-c=
aps: normal; font-weight: normal; letter-spacing: normal; text-align: justi=
fy; text-indent: 0px; text-transform: none; white-space: normal; word-spaci=
ng: 0px; text-size-adjust: auto; -webkit-text-stroke-width: 0px; text-decor=
ation: none; margin: 0px;"><span style=3D"font-family: georgia, serif; colo=
r: #999999; font-size: 11pt;" data-mce-style=3D"font-family: georgia, serif=
; color: #999999; font-size: 11pt;">Systems Engineer<span>&nbsp;</span><str=
ong>|</strong>&nbsp;<span class=3D"Object" role=3D"link" id=3D"OBJ_PREFIX_D=
WT567_com_zimbra_url" style=3D"color: #005a95; text-decoration: none; curso=
r: pointer;" data-mce-style=3D"color: #005a95; text-decoration: none; curso=
r: pointer;"><a href=3D"http://www.jasmin-infotech.com/the-company/contact-=
us/" title=3D"Jasmin Infotech Chennai" target=3D"_blank" style=3D"color: #9=
99999; text-decoration: none; cursor: pointer;" data-mce-href=3D"http://www=
.jasmin-infotech.com/the-company/contact-us/" data-mce-style=3D"color: #999=
999; text-decoration: none; cursor: pointer;">Jasmin Infotech</a></span></s=
pan></p><p style=3D"caret-color: #000000; color: #000000; font-style: norma=
l; font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: justify; text-indent: 0px; text-transform: none; white-space: n=
ormal; word-spacing: 0px; text-size-adjust: auto; -webkit-text-stroke-width=
: 0px; text-decoration: none; margin: 0px; font-size: 11pt; font-family: ca=
libri, sans-serif;" data-mce-style=3D"caret-color: #000000; color: #000000;=
 font-style: normal; font-variant-caps: normal; font-weight: normal; letter=
-spacing: normal; text-align: justify; text-indent: 0px; text-transform: no=
ne; white-space: normal; word-spacing: 0px; text-size-adjust: auto; -webkit=
-text-stroke-width: 0px; text-decoration: none; margin: 0px; font-size: 11p=
t; font-family: calibri, sans-serif;"><span style=3D"font-size: 11pt; font-=
family: 'times new roman', 'new york', times, serif;" data-mce-style=3D"fon=
t-size: 11pt; font-family: 'times new roman', 'new york', times, serif;"><s=
pan style=3D"color: green;" data-mce-style=3D"color: green;"><span id=3D"_m=
ce_caret"><span style=3D"font-family: arial, helvetica, sans-serif; color: =
#000000;" data-mce-style=3D"font-family: arial, helvetica, sans-serif; colo=
r: #000000;">=EF=BB=BF--</span></span><br></span></span></p><p style=3D"car=
et-color: #000000; color: #000000; font-style: normal; font-variant-caps: n=
ormal; font-weight: normal; letter-spacing: normal; text-align: justify; te=
xt-indent: 0px; text-transform: none; white-space: normal; word-spacing: 0p=
x; text-size-adjust: auto; -webkit-text-stroke-width: 0px; text-decoration:=
 none; margin: 0px; font-size: 11pt; font-family: calibri, sans-serif;" dat=
a-mce-style=3D"caret-color: #000000; color: #000000; font-style: normal; fo=
nt-variant-caps: normal; font-weight: normal; letter-spacing: normal; text-=
align: justify; text-indent: 0px; text-transform: none; white-space: normal=
; word-spacing: 0px; text-size-adjust: auto; -webkit-text-stroke-width: 0px=
; text-decoration: none; margin: 0px; font-size: 11pt; font-family: calibri=
, sans-serif;"><span style=3D"font-size: 18pt; font-family: webdings; color=
: green;" data-mce-style=3D"font-size: 18pt; font-family: webdings; color: =
green;">P</span><span>&nbsp;</span><span style=3D"font-size: 10pt; font-fam=
ily: 'iskoola pota', sans-serif; color: green;" data-mce-style=3D"font-size=
: 10pt; font-family: 'iskoola pota', sans-serif; color: green;">Please cons=
ider the environment before printing this email.</span></p></div><div><br><=
/div></div>
<br>=
<html><body>Information in this email is proprietary and Confidential to Jasmin Infotech Pvt. Ltd. Any use, copying or dissemination of the information in any manner without prior approval, is strictly prohibited. If you are not the intended recipient, please destroy the message and please inform to us..</body></html>=0A
<br>=
</body></html>

------=_Part_121393312_1169650705.1604307085037--
