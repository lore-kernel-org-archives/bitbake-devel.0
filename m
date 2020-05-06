Received: from EUR02-AM5-obe.outbound.protection.outlook.com (EUR02-AM5-obe.outbound.protection.outlook.com [40.92.67.61])
 by mx.groups.io with SMTP id smtpd.web11.403.1588784630938388281
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 May 2020 10:03:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@outlook.com header.s=selector1 header.b=qeb0Mv6v;
 spf=pass (domain: outlook.com, ip: 40.92.67.61, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idcpFnJze1BbkhDXu7Jozjtr5Vdxz8fv3pMi+YmWGjvbPdczjDVM2wSXjDXio+GB9rxHBfEjw2JzKlroQ7xvTN5KBwTfT//y+ZYQZ4jZJmOKe3bjURBhZ6xjnj1p4otmIwSv7fhTsleo2KpP2prAh4yhugcp0YPUsIatA+gPA2WAbSh2e7CRIiPXDhuiJJkVXJjgqUEXE2C4ubwDSnRmmd8I46uoFAuBSSkGPnokSddRkQXbce33UD9wtJHa1oCdNFydPKXD2H50sufZ7AzI99sXxl7tZaf1cC0n9y/ZexCpTh/JgWFE4YuazKQNzg3ylLG0iY8LofAQJOaLSNpUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHuJqMX/XtzknqnuKLJeexqNp9lt5sJCtEbFx4YpWXI=;
 b=XSlITBGLPeeVGjGyaPgIFr8GvB6TAXeJs89Gwq5SgEeBQ3WLPCUfKswOEr4mKHf3nNBpfON+pHvoik24NrK3vUilmqM+C4apKA1BZ/YCpNcFgr3CjUYJegOi5p1EI0Wk6bHr5eyOfPMiES9uUZ6pdu92wjB4ym/AACikSPrS8zJZqMB8Df7m0VfUn6/N5jStI/iXIkX2Rd/UZ0AvVzGJn7cH309UUj0WkvfXXkkAvg44ac8IKJFONoGitL3d/HpjYLO99elDVTJyQHhqqqCd9R3MIrTf7DXYF2QkXNa27CKiD1UK/Mue+oUD4EunwJ4QJ0hwJn414QyNJpukhgwTgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=outlook.com; dmarc=pass action=none header.from=outlook.com;
 dkim=pass header.d=outlook.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHuJqMX/XtzknqnuKLJeexqNp9lt5sJCtEbFx4YpWXI=;
 b=qeb0Mv6vQhGvpJvQxG9OxcPt4/uFFf/4Rii8j50Ld/AWZ8jCDfBfZxekcEelgVHB+7yfF5u10vs5EkcgDDYccn2zd+80jk5WPG2kq7RcMACl2ZyMsokaDwIRgZb5VELgFz3hDpN4qRmD5KCOmcdbEINB0SqEaS5JgZmmzakrePHqglUG/bk5kcGkEFhn5YhlQPzvqjhjIhJ/CUeCCJlDJJh3MYcEnk9MXV0N+rq6NaNBb5zSQpkaVizwsl774XFm8y248vSmosIeSUbIPhYEUTkyuKJVfCbFgTFfJLc5ObZ3sxCwxP+7uzAQte88pCAgKDgK6mcObtAVwPLXFqR0FQ==
Received: from HE1EUR02FT045.eop-EUR02.prod.protection.outlook.com
 (2a01:111:e400:7e1d::4e) by
 HE1EUR02HT237.eop-EUR02.prod.protection.outlook.com (2a01:111:e400:7e1d::409)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Wed, 6 May
 2020 17:03:48 +0000
Received: from AM7PR05MB6881.eurprd05.prod.outlook.com
 (2a01:111:e400:7e1d::4f) by HE1EUR02FT045.mail.protection.outlook.com
 (2a01:111:e400:7e1d::494) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend
 Transport; Wed, 6 May 2020 17:03:48 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:A4035318E7515E3880D4B5A13F67A0B3C59E4027274FDEB3E30FD300385E6F6D;UpperCasedChecksum:57BC60B378D740554BB158894C7ADDB868F929021A65349EC907301BF949BC15;SizeAsReceived:8780;Count:49
Received: from AM7PR05MB6881.eurprd05.prod.outlook.com
 ([fe80::f5f1:b5e3:66d7:e590]) by AM7PR05MB6881.eurprd05.prod.outlook.com
 ([fe80::f5f1:b5e3:66d7:e590%6]) with mapi id 15.20.2979.028; Wed, 6 May 2020
 17:03:48 +0000
Subject: Re: [bitbake-devel] Best practice to debug a bbclass customization
To: bitbake-devel@lists.openembedded.org
References: <bR66.1588783648151158143.yuJt@lists.openembedded.org>
From: "Konrad Weihmann" <kweihmann@outlook.com>
Message-ID: <AM7PR05MB68810C1E5A6BE83C097E6D26A8A40@AM7PR05MB6881.eurprd05.prod.outlook.com>
Date: Wed, 6 May 2020 19:03:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <bR66.1588783648151158143.yuJt@lists.openembedded.org>
X-ClientProxiedBy: AM6P191CA0049.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::26) To AM7PR05MB6881.eurprd05.prod.outlook.com
 (2603:10a6:20b:1a9::19)
Return-Path: kweihmann@outlook.com
X-Microsoft-Original-Message-ID: <aae3af17-1c3c-e87e-aadb-efa102b7ad6d@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.188.20] (79.215.8.105) by AM6P191CA0049.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend Transport; Wed, 6 May 2020 17:03:45 +0000
X-Microsoft-Original-Message-ID: <aae3af17-1c3c-e87e-aadb-efa102b7ad6d@outlook.com>
X-TMN: [OhQMz8TibZUOnLAJLAvoRwJwNODRcdWi]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 49
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 74ba27a9-9215-4e9f-26ff-08d7f1df7010
X-MS-TrafficTypeDiagnostic: HE1EUR02HT237:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EXa0YJ9P9s5N/w7juhOvkIQa5/QIrijFVxdeUznxBUokyF09AgkH0m62UUv1LorNUV0TCzd9lgVPScauqt15OhksQmA9NADOEqyUWMLIRIbKN0sSbcx7Qpv/R1QcRroBpA+rigKGpsDjTeEXh7DigEZEnQsJ9+tzsz45VmdvRV0QSFk9KFt0pUKmKaFSa5eWz4Z2WkrlE5ANNDdHDmiVW8PnZJYpWDMHKl5DoMVUwKP1CTjQaT06MO9V1yBUmXfu
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR05MB6881.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: 
	3ffdjiGTMsSOpzHucezBPKECEWIfCdybPj7zTgGo5FtSHMtI5jbh7xY12p1ljwJx7Ednf67xqs/moMvc9Saevleu5N2tEez+6kf4vDTJqorG8jVCmezUvBmufMO/YECWq8srNHcXFd6ySiYx8Wb8Pg==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ba27a9-9215-4e9f-26ff-08d7f1df7010
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 17:03:48.1929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1EUR02HT237
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Something like this does actually do the trick but isn't the most=20
charming way (as it influences hashing a lot)

do_foo[vardepvalue] =3D "1"
do_foo() {
     bbwarn ${PN}
}
do_install[postfuncs] +=3D "do_foo"

Now you can alter the "do_foo" function as much as you want for the=20
hashing part "do_foo" will always remain "1"

On 06.05.20 18:47, Marco Cavallini wrote:
> Hello,
> I am experimenting bbclass customization creating a very trivial task=20
> called do_marco() to get a list of the recipes built during a bitbake ca=
ll.
> I need to run this task each time bitbake is taking a recipe into=20
> account, adding INHERIT +=3D "mycustom" in local.conf.
>=20
> The problem is that whenever I modify the task source and I run bitbake=
=20
> I have a lot of recipes rebuilt as result.
> Is this expected or there is anything to set to avoid that?
> What is the best practice to debug a bbclass customization?
>=20
> # mycustom.bbclass
> python do_marco () {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 package =3D d.getVar('PN', T=
rue)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 version =3D d.getVar('PV', T=
rue)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s =3D "$ \"{0}\",\"{1}\"\n".=
format(package,version)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 with open("marco.txt", "a") =
as logFile:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 logFile.write(s);
> }
> do_package[postfuncs] +=3D "do_marco"
>=20
> Thank you
> --
> Marco
>=20
>=20
>=20
