Received: from EUR02-HE1-obe.outbound.protection.outlook.com (EUR02-HE1-obe.outbound.protection.outlook.com [40.92.68.107])
 by mx.groups.io with SMTP id smtpd.web08.5501.1621324583638331211
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 May 2021 00:56:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@outlook.com header.s=selector1 header.b=bJzZsggP;
 spf=pass (domain: outlook.com, ip: 40.92.68.107, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9RIepo+NnF8QF+YRE7F1/wdveA0yix3M9Xu5m2yApYet5ao7hjUfRCHp+OVNZ73zdNQ++W5/RkhJCokAUITAvmde27EEuGUew6kr474Mnoq/NnSCAQriJktUgZb0+RYWi9C8+oThJegiudzb464xk80D7bzISq8NpjybCZZmfQKIgUka3nQtnul8wRgC7WBn3syEYVZzdnsS75aaMBuQsZurnhrWKBomQtFtybUsbM3GD0vRps4loVeF6pg+HeU0DGdQ7EPUguo1JZyfTuSPltcoyf8KMHjxxSkXuDtPMy5FK5auoVT9e3vuZriMRVRZeEdve1cUin+AJ1ZAxv1sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1KBN5bo44dHaNsWlB9Ovgl/oiRlQYO2KmPsSMWj1FA=;
 b=nRKY40nD++a10/WQQNAYmAb0zlk21dJkt7cfQQ5hJLz3VE4ToorGLHMuN3LjoATIoFmGIijyX0Um1dysP3ffgUnc4tqOnX3IF82T0y9D8eKMQ2niz1asYfMCZJX9LfZcpfp0qeStzW/OhLtz+d8ijojRjMbCDVOgfOs+sZaAOnVN82G1xGu7OzeItj2XUgtqO7cFf3TY8Fy41kTkzxUG29jAn+CQjv5cFlOdcwMAfR1bHXH9COa/bIFsUlOa2a6LV6SIJ73DP5yiy1b9PJUF5iDmPjGGUt8FLG1fn2l4byIcqwq2yUfrB5i/ALKmpCoh6pcFt6Dh6shecFgy1/YS2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1KBN5bo44dHaNsWlB9Ovgl/oiRlQYO2KmPsSMWj1FA=;
 b=bJzZsggPLSQ/wmLJYxzwWB6FFO6Fl5xXZX1MZusQXuY7Jw8zj2a5GRF1darW2HTWdL7hXvKzY6gl7zP+WPiJgDZ6Kn8hMAhekQmwfTUTJo9V1lYLZOGcU7GGXtXDtBBnaYkmuc6JkNnJyqnxXYFB3m4UUDGTpiKbLbJxNQr4CgLBi2zIOOKYvOo4cy9fC+/jkVgtmSISCUcy6yLEsw4rZcV9tGHJQUu07HWA+U2UcB9RHPiXvnzQJLD8lGUVdreP5K5DmTf6lU4EmUqQ4Yn77xJEedgnpK2JH4IH7uoDqyljYPS8Zd58PKL3yUL4yf1LbtJp5UrFQxvYXFy+qRq3qg==
Received: from HE1EUR02FT041.eop-EUR02.prod.protection.outlook.com
 (2a01:111:e400:7e1d::52) by
 HE1EUR02HT219.eop-EUR02.prod.protection.outlook.com (2a01:111:e400:7e1d::353)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 18 May
 2021 07:56:20 +0000
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com
 (2a01:111:e400:7e1d::4a) by HE1EUR02FT041.mail.protection.outlook.com
 (2a01:111:e400:7e1d::402) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend
 Transport; Tue, 18 May 2021 07:56:20 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:7B81E8DB8737FCC0AB448F86B917A76E0F0674B252F50C451A0C3696A06E9BC2;UpperCasedChecksum:B2DE6CD302973F8009744E6C3D8DBAA509B55F61F647DCBE960EB040C100323B;SizeAsReceived:8840;Count:47
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::9c9b:9858:17df:de84]) by AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::9c9b:9858:17df:de84%6]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 07:56:20 +0000
Subject: Re: [bitbake-devel] Disable Reproducible Build - reg
To: Daniel Selvan <daniel.selvan@jasmin-infotech.com>,
 poky@lists.yoctoproject.org, bitbake-devel@lists.openembedded.org
References: <141358386.90607893.1621323974188.JavaMail.zimbra@jasmin-infotech.com>
 <1180155480.90839930.1621324248815.JavaMail.zimbra@jasmin-infotech.com>
From: "Konrad Weihmann" <kweihmann@outlook.com>
Message-ID: <AM9PR09MB46424A47140676C11DAD16D2A82C9@AM9PR09MB4642.eurprd09.prod.outlook.com>
Date: Tue, 18 May 2021 09:56:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <1180155480.90839930.1621324248815.JavaMail.zimbra@jasmin-infotech.com>
X-TMN: [fhdcA+Jtn1wicYQJrLw7t6QoeramT7N6]
X-ClientProxiedBy: AS8PR04CA0010.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::15) To AM9PR09MB4642.eurprd09.prod.outlook.com
 (2603:10a6:20b:284::24)
Return-Path: kweihmann@outlook.com
X-Microsoft-Original-Message-ID: <87c71c52-233c-2fa0-118b-b6fbd8d39a17@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.188.23] (87.141.92.134) by AS8PR04CA0010.eurprd04.prod.outlook.com (2603:10a6:20b:310::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 18 May 2021 07:56:20 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 0515b2ca-f7b5-414c-8203-08d919d26c91
X-MS-TrafficTypeDiagnostic: HE1EUR02HT219:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BSBQsXdR7OIi1XRE5Hx+xetAtqhEdS93EnrM6apUtybmdMjkZXWjVGaXBT/eBiCUBpr+3UKEnNtHTJISkLbPB0rc6xYP9vxE6y1quKAOTp4sdebdA3NnaRPxAL5+TZk3D2WZmfrErHZxmJ4ewo/qu+/I8njvFuEnOHLok/tBijUE1Eir9xpckYfNyFRNZyqdNeO0ZonOjVE/Cqt37xSenAoZdL5IZ79jWkkUhRX+2SkkktdWr5CrDPYJyBl0jECnUaSslRZpmhjkKMJtG8TMgVqLIZQ+2m97Ll/+vEsm+i1dcfJFqO18y4r6TcCHO23Sc+M9GCAt/388VDW1VM3IXK1Ae5c14GQC2V83Up21ggBVBj5NWcE8t9LTMK+0oE3iQJ1PPjvnswv6ApD+SlNTJIJSomn17sAc0s7TY3iHhy/T30pyBvAFVo92jnBDD9NSEA6N4YLudErfghiZfM362pK2pqBLrT1By0oj6allFOE=
X-MS-Exchange-AntiSpam-MessageData: 
	KECfM5czn65/+/3fYNN4EpBIETGOIz9KOT5mWZqQtckLZ0LiRDwKsCqH5gugLmOqjtW76j6aqv9gF9baIzsWd0KTs/xoMe1Zg3TCm+sZZsvAGFpFDDqVTypkkb3otmXj3BD0w8n3A0O7Kbx2+j2AOw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0515b2ca-f7b5-414c-8203-08d919d26c91
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 07:56:20.7815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR02FT041.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR02HT219
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

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
>=20
