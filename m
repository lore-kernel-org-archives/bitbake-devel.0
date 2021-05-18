Received: from IND01-MA1-obe.outbound.protection.outlook.com (IND01-MA1-obe.outbound.protection.outlook.com [40.107.138.133])
 by mx.groups.io with SMTP id smtpd.web09.5499.1621324783927009088
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 May 2021 00:59:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@jasmin-infotech.com header.s=selector2 header.b=mT0tuYrx;
 spf=permerror, err=parse error for token &{10 18 mail.jasmin-infotech.com}: permanent DNS error (domain: jasmin-infotech.com, ip: 40.107.138.133, mailfrom: daniel.selvan@jasmin-infotech.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeI0JOez9tkmr+EVXsN7bOWvwZY0nR/RRN6EMbEpCAdc5F6Q9QKJmsHRuGqnwelxIRKmU677H1EOBM/4ybTnfZyZWjkB7xdza5Cc75dpKFe1McWBukoEo9NgDZKWY/N/DF8ofrGlO+OyZ1BQP1tpAW/G+pHK2rOo51S7LwscMlOilc+B5sKxHx5JHc8UkWvwZ1D6966tHE89E0KHIezpRxSzjhmeWiN71HOyptOsL3KNno4i491BAmRQbOfy7MpXFOu+gviYDHNDUy66+ciIVnWpbcWXlSbEp2Qys7Jsu7UkMrC2b2kaO7AQDMeo9tnOK5R0zcwvVFCeYRYbOTE6ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xa8WoFbRE57lo2RydB3LUcng2iNQg+ZN4LpqxqxaPsA=;
 b=PmAEfAi+/be4Q1hrg4gfTVtdYnQa9J+RhM2gAzNPiv2C+C/pVdt3Bm7xhff4ALS6qh6UFYh5X0c7qWllsUsIad8wpySyi7ZiMJyNdTgSptp/t81e2fga8c4DwnRPHQvIIAIDUkI/fYEE1QaL9Zx96CeiuoZGpSR0idSIjK3j4Hk+Ny7DT4A19lSDMxKfUy1bsrdHtwT0NQQHK8s7QSHCj27ciGLVtC7arRG/RhPbg/SSq6VBqqGHfnateLvUncJB1wq2fC9pYohyabR3uekEvHoR7v6b+g61TWBXBNTnQ31idozDZ2/kkQP3aOi27d70DBlWylGrxCsF6H8I8qQvpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=permerror (sender ip
 is 61.16.140.213) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=jasmin-infotech.com; dmarc=fail (p=none sp=none pct=100)
 action=none header.from=jasmin-infotech.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jasmin-infotech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xa8WoFbRE57lo2RydB3LUcng2iNQg+ZN4LpqxqxaPsA=;
 b=mT0tuYrx2R7sMrN9wtEFei5HVYBObtjrrbzPlclMfBMCYFTVqD5/Y1y17sQ0FUm/3nrwGjgdCMEOPHbRQSEx3yzrw9R1exVCDWaR243w6wZLXGs5r37K3zRNr99naINj2jXmHpUA13eUbOAnrBzZ/yFgNYHrsiD5bZL9C4T9Tag=
Received: from BM1PR0101CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::23) by MAXPR01MB3597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:6a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 07:59:39 +0000
Received: from BO1IND01FT005.eop-IND01.prod.protection.outlook.com
 (2603:1096:b00:19:cafe::ac) by BM1PR0101CA0061.outlook.office365.com
 (2603:1096:b00:19::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Tue, 18 May 2021 07:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=permerror (sender IP is
 61.16.140.213) smtp.mailfrom=jasmin-infotech.com; lists.openembedded.org;
 dkim=none (message not signed) header.d=none;lists.openembedded.org;
 dmarc=fail action=none header.from=jasmin-infotech.com;
Received-SPF: PermError (protection.outlook.com: domain of jasmin-infotech.com
 used an invalid SPF mechanism)
Received: from mail.jasmin-infotech.com (61.16.140.213) by
 BO1IND01FT005.mail.protection.outlook.com (10.152.202.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25 via Frontend Transport; Tue, 18 May 2021 07:59:37 +0000
Received: from localhost (localhost [127.0.0.1])
	by mail.jasmin-infotech.com (Postfix) with ESMTP id 494371401A51;
	Tue, 18 May 2021 13:29:25 +0530 (IST)
Received: from mail.jasmin-infotech.com ([127.0.0.1])
	by localhost (mail.jasmin-infotech.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id u6dZTfFXvkSb; Tue, 18 May 2021 13:29:24 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by mail.jasmin-infotech.com (Postfix) with ESMTP id AE5281401A50;
	Tue, 18 May 2021 13:29:24 +0530 (IST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
	mail.jasmin-infotech.com
X-Virus-Scanned: amavisd-new at jasmin-infotech.com
Received: from mail.jasmin-infotech.com ([127.0.0.1])
	by localhost (mail.jasmin-infotech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zlMwWjmBM3CR; Tue, 18 May 2021 13:29:24 +0530 (IST)
Received: from mail.jasmin-infotech.com (mail.jasmin-infotech.com [172.16.4.153])
	by mail.jasmin-infotech.com (Postfix) with ESMTP id 8A16C1401A4F;
	Tue, 18 May 2021 13:29:24 +0530 (IST)
Date: Tue, 18 May 2021 13:29:24 +0530 (IST)
From: "Daniel Selvan" <daniel.selvan@jasmin-infotech.com>
To: Konrad Weihmann <kweihmann@outlook.com>
Cc: poky <poky@lists.yoctoproject.org>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Message-ID: <1263831117.91201115.1621324764469.JavaMail.zimbra@jasmin-infotech.com>
In-Reply-To: <AM9PR09MB46424A47140676C11DAD16D2A82C9@AM9PR09MB4642.eurprd09.prod.outlook.com>
References: <141358386.90607893.1621323974188.JavaMail.zimbra@jasmin-infotech.com> <1180155480.90839930.1621324248815.JavaMail.zimbra@jasmin-infotech.com> <AM9PR09MB46424A47140676C11DAD16D2A82C9@AM9PR09MB4642.eurprd09.prod.outlook.com>
Subject: Re: [bitbake-devel] Disable Reproducible Build - reg
MIME-Version: 1.0
X-Originating-IP: [49.207.142.66]
X-Mailer: Zimbra 8.6.0_GA_1242 (ZimbraWebClient - GC91 (Linux)/8.6.0_GA_1242)
Thread-Topic: Disable Reproducible Build - reg
Thread-Index: MbzsJx5wHf12aK6epU4jtbq/pe4PZw==
Return-Path: daniel.selvan@jasmin-infotech.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04f4d386-93b8-4d64-a05a-08d919d2e254
X-MS-TrafficTypeDiagnostic: MAXPR01MB3597:
X-Microsoft-Antispam-PRVS: 
	<MAXPR01MB3597DD51B7AF42D8B4F4ED9FB82C9@MAXPR01MB3597.INDPRD01.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fAhKrUcklvLDZyjAJD0/qGA1065CmbVAglFD6QY8Lok0IkE8IQLga4UK7k4EgO9OP9JAPog9wyS+5NueYGpYkI40SCIPcQ+sDDbHIkbPXtzdNAeRDT5Zph/re/9HcE1KVsCx057H9FffjKvdm7MM/RrRTsQ5TPo7RelPdDv8nu2nfjpxAXBZ44VNH9tkjQyqjZHlC9iv24kBDsmVNjO381uj1yy94/R2tP+vh8KTbySnMjTjYhhVgYe6m0agTFazZKU3vVrJmKD/ODBbDoQQqCg3Dmef0NDrRhq8j0lgXtwZG2keXqTFdDPV4g8sRD0BMA9QfG65beHTA69942+6qv+5V0UGScMlQwSPAr1RgLmghu1zKdFQ86q6kK/zDT7xI8gGj+xOTYlpUCC9PGWolRHX0VekP6s5Cb2q65oLqEHJWZ70quWTlZdYnRHQgmc36mC9U/LY1jiYXp4Kyv1a2nO5Al+qKPjy38LYptcOJqGtlt8Ba9GnfFnpqCyATAi8cUvKiEF+VLbsn1O4owbxUmq9XE8BaQrRU4e7o7XVHt4ZGRELwW/xH9Ymc6TbDIHl9GIxspr4kwJQvFPGoCye3EAXZdMwaiVn98z1UWNtXtJzq3BaWiKp5Xh3F6n/jIOS7z0/iV89NcvM8TvEX0A/HT8PRaMa7tfYvb/ftQxvEF4ReZpLVtNcfrW/3hYnt95mjI6mK9dC8444nubhyBxpIOVJrNlIK2MWYONiuOqRIuw=
X-Forefront-Antispam-Report: 
	CIP:61.16.140.213;CTRY:IN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.jasmin-infotech.com;PTR:mail.jasmin-infotech.com;CAT:NONE;SFS:(346002)(376002)(39840400004)(136003)(396003)(36840700001)(2906002)(4326008)(316002)(36756003)(54906003)(36906005)(186003)(82310400003)(32650700002)(6916009)(36860700001)(6266002)(83380400001)(356005)(5660300002)(7596003)(966005)(8936002)(336012)(86362001)(7696005)(7636003)(426003)(2616005)(53546011)(26005)(70206006)(8676002)(478600001)(70586007)(55236004)(45080400002);DIR:OUT;SFP:1102;
X-OriginatorOrg: jasmin-infotech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 07:59:37.9581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f4d386-93b8-4d64-a05a-08d919d2e254
X-MS-Exchange-CrossTenant-Id: 5379b76d-5476-4c9f-a04c-fefa48abc331
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5379b76d-5476-4c9f-a04c-fefa48abc331;Ip=[61.16.140.213];Helo=[mail.jasmin-infotech.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BO1IND01FT005.eop-IND01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAXPR01MB3597
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I already added the line "BUILD_REPRODUCIBLE_BINARIES =3D '0'" in by local=
.conf yet if I try to add __DATE__ I get the following error: "error: macro=
 "__DATE__" might prevent reproducible builds [-Werror=3Ddate-time]"

Can you comment on this?

Kind regards,=20


Daniel Selvan D.=20


--=20


P Please consider the environment before printing this email.

----- Original Message -----
From: "Konrad Weihmann" <kweihmann@outlook.com>
To: "Daniel D" <daniel.selvan@jasmin-infotech.com>, "poky" <poky@lists.yoc=
toproject.org>, "bitbake-devel" <bitbake-devel@lists.openembedded.org>
Sent: Tuesday, 18 May, 2021 13:26:19
Subject: Re: [bitbake-devel] Disable Reproducible Build - reg

You could either create a distro configuration of your own (one that=20
doesn't inherit the poky.conf) or set `BUILD_REPRODUCIBLE_BINARIES` to=20
`0` to reduce the impact of the inherited reproducible_build class

On 18.05.21 09:50, Daniel Selvan wrote:
> Hi,
>=20
> I wonder how to disable the Yocto reproducible builds, since it is=20
> enabled by default now=20
> (https://www.yoctoproject.org/docs/latest/ref-manual/ref-manual.html#mig=
ration-3.1-reproducible-builds=20
> <https://www.yoctoproject.org/docs/latest/ref-manual/ref-manual.html#mig=
ration-3.1-reproducible-builds>).
>=20
> Thanks in advance.
>=20
> Kind regards,
>=20
> Daniel Selvan D.
>=20
> Senior Systems Engineer*|* Jasmin Infotech=20
> <http://www.jasmin-infotech.com/the-company/contact-us/>
>=20
> *+91 9445556596 <callto:9445556596>*
>=20
> =EF=BB=BF--
>=20
> P Please consider the environment before printing this email.
>=20
>=20
>=20
> Information in this email is proprietary and Confidential to Jasmin=20
> Infotech Pvt. Ltd. Any use, copying or dissemination of the information=
=20
> in any manner without prior approval, is strictly prohibited. If you are=
=
=20
> not the intended recipient, please destroy the message and please inform=
=
=20
> to us..
>=20
>=20
>=20
>


