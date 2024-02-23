Return-Path: <tobias.hagelborn@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B61C5478C
	for <webhook@archiver.kernel.org>; Fri, 23 Feb 2024 10:58:46 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.57])
 by mx.groups.io with SMTP id smtpd.web11.8145.1708685920553524718
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 23 Feb 2024 02:58:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=gqKZAnc1;
 spf=pass (domain: axis.com, ip: 40.107.8.57, mailfrom: tobias.hagelborn@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N3Zckj13z92A+OFtVxEtdQMdXula9RwE74ljdfQeCy3GB8+EDZp2TRuKj7ldwwlYF8iajL7+z/TPvCv8qXLk3BH/VDWu0VX8t6YVProQYWUgZQESRia86ZVWxxQxX0knMjUiX5RkpWDVen3tvaQG4p84Mm8kaygL1M1nvBOYdKR6AaNAV0qXRg3lbY9CrrqwATJ/9R75F0UmqGmaeNmrn5ztmSY5ql9dQtqJJ/rxUa9u6aE+7ap5LVKfNp6wo0VkStHvrhhVQANBJlloV5PqiklFfFqTmspkhMvhQvYovmWr3uh599q7JkigglgSxhxnrCn6e6Q0YdlMGBKKXCK2RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zM1IJdW93fntaqZFXphfD5HeCfqrGkMZeO3ZTXMhcSA=;
 b=DivF7Lc7j+zKRgmDM0L3+NdNrFvxop2x+u1/gacvKz1+YfwjybviMjJrnG51esyVPAiDlae2APQOo8MCt4NBYPo9XAi9LbkBBAm3ti9oIEI1snhw+3TyyvB4DFwSQwDKOaM92w60DM+39ZpOUFnPVT3ovPWpnjeh0krMaemVLXTvoSi0UsKmGLkS1KOBCA2XfFiXRxyNwncDon9O4TZGPYInJ2Z74sYHlt7/a2zWvgkRHvajJLXpui0/XqRyz63J9c3DGkvzU60lAV9Nvy0ouJxWaE6jPLCBA6ikrHXLuAI3hpz+PvBFWHrMHjURcBqD31zsMEnDGtiIy3rudCI0bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zM1IJdW93fntaqZFXphfD5HeCfqrGkMZeO3ZTXMhcSA=;
 b=gqKZAnc1MuyqjBMkevzDzzSVgKTVa4xczOTcQQULXjRIeB47VyggGDTqBHxDG4tBZPmdWVIdgPVU3F2IFS598aLLnxkX6cT1bLb5jjr7vB/fDGECr873kB5L9DQzogbc8AaL1B0YqNvLMvViY2LOYHII570gdPNeSBUNfApk9zA=
Received: from AS8PR02MB9483.eurprd02.prod.outlook.com (2603:10a6:20b:5a6::5)
 by DB4PR02MB9647.eurprd02.prod.outlook.com (2603:10a6:10:3f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 10:58:36 +0000
Received: from AS8PR02MB9483.eurprd02.prod.outlook.com
 ([fe80::13e3:1d0:81cf:64f4]) by AS8PR02MB9483.eurprd02.prod.outlook.com
 ([fe80::13e3:1d0:81cf:64f4%3]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 10:58:36 +0000
From: Tobias Hagelborn <Tobias.Hagelborn@axis.com>
To: Joshua Watt <jpewhacker@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] Re-enable connection pooling with psycopg
 3 driver
Thread-Topic: [bitbake-devel] [PATCH] Re-enable connection pooling with
 psycopg 3 driver
Thread-Index: AQHaZBKGbDNneVst2kCTI+VUO0lvT7EXwnyY
Date: Fri, 23 Feb 2024 10:58:36 +0000
Message-ID: 
 <AS8PR02MB94833C59F481899B382B8842EC552@AS8PR02MB9483.eurprd02.prod.outlook.com>
References: <20240220062705.3611869-1-tobiasha@axis.com>
 <CAJdd5GaHiakYT4W0kaVhp6NvU4nBccR6MKHtjR_YsMehi-Lg6w@mail.gmail.com>
In-Reply-To: 
 <CAJdd5GaHiakYT4W0kaVhp6NvU4nBccR6MKHtjR_YsMehi-Lg6w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR02MB9483:EE_|DB4PR02MB9647:EE_
x-ms-office365-filtering-correlation-id: 6f169d34-4ce1-4deb-241a-08dc345e6273
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 i2USgeadnGh1NhmoiT9KnCFVsWSGwN90GEq+cD0fCHhkvxHE94I5TS3MmtHwIRR1AKbIfkFfrPAdkyHoyhp5iAKr0Vd3tzfmonUQv7zT1Qp4AgYn3fePFrCJdee4n2zRElTFjiOco7+3m87Z/5nJQ/XuBLmExsRrQXX9/E2FMUbodf0lIvnVZAdoY5yYKVOw1U9qLtVkXO52oa65Tp1x6sy75l0ci9gMs8rjj/KF3KgJzSbYmElNjT6NeS3/kNA5xEFyxtTpBeWkU6kl0x+n0IngDY+14ZQhLzUFMipv5LlEptnw3Mn1hOpm/dK7+0tzC6AsK5xW/XVCi9JRIqH2fkG+SZZiTPZz6Mvi9eaAbJRfWFKNK6dlVDeT062+MH8H7MUcmkOe7tNJcKERTgZX95Add2TrP2JUwMIL6drOfdKqpfHbWApOnu07+AK3OeEuAQMgNzfTUWx2cLqNLrnFsYJ/uy1XM8EcE5u2qa1ZKlLMCrGGn9VEGad5H7nb96kSvnrGW+60DuIgEmDDu0n3jkW6FNv2u4C4F5nluVWScYZR1YW/9jtA0KbQy7OT3diP0cnTlK2dew6MqZfNr8OXC/n0lSaOdBYAC/DZZ7L81Ns=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9483.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?STgYkBvNn1LHpOM6nEvkEWOCyQuXLgXrCMG2sS/n5wUMxLSRDTG4n58fth?=
 =?iso-8859-1?Q?88frU/8IfhTp4LWxZGKhZqruuinOn29zpnt6v0rkkxhe7YldHsUpvn92hi?=
 =?iso-8859-1?Q?3pr6FDwOJjcHW2H0yN2LmiRRkfAU1J6IlaaqynsSvkQ6HrPwVdYbe/Dikd?=
 =?iso-8859-1?Q?P6iemjB9gr0vhtpQ5CYyg92js/WwbQenU9d8dCc1svt8WdKkIopT96h3pS?=
 =?iso-8859-1?Q?qEC8jkx3ku0gGso64oaYd0sx4yKvpluz2aIrwfoqTn245VOi9H14j3yRoX?=
 =?iso-8859-1?Q?G2k312ERpoCW/pW8nfzr3rBNNrlY03xcLWLm+Rxf4X8dVaR9bgY9B+Pf9X?=
 =?iso-8859-1?Q?A3a7pCzfGxP6N8hEM5p6llNRiTzzsDEJEiwEUnhHXs3Rok72M1suEkqKw4?=
 =?iso-8859-1?Q?eK5V5GUSv0p/kjqVxvX5y6br+5IfD+EYsi9R28vOdmX+Rgt54VV7ZjLDxv?=
 =?iso-8859-1?Q?nkjBKDW/gkjNNXSGMIE7OL2V6DOSMmlUHM279ccGIB6l+t2ngj9ZmnEEe+?=
 =?iso-8859-1?Q?h2qL6zNboXt2F6vbYodCl0mP9FWUbBhUQtD9RwQE9BRqijXCYuiVfgdi7y?=
 =?iso-8859-1?Q?gEQB3UVLWRvXahatGpL8g8BH1M/1l+0ly5NE4ulgz+F3b16SlDhQfrY0j2?=
 =?iso-8859-1?Q?at4UO17zGrARJ/3eBWtn5gvmaRc3G+lImXfDhXAG4EhAS+t5d33SUDPnrq?=
 =?iso-8859-1?Q?23WJHrxXlZtvjbfBPvICs/1t0hL1i8SZu1XtEO7RFO+JFVfyYTzfn54zjt?=
 =?iso-8859-1?Q?K7VQdjmLIE8l1Q9cLM30uF2/tumGYSHslgQP9L7kmY6M16WXddhfZDpkmg?=
 =?iso-8859-1?Q?0zBUJ7VFcDm91+W6ob3qmZqvCWlqWJccPM5NZBw6OFKXRWnoQwabjSFryu?=
 =?iso-8859-1?Q?L0uSTBNKr5ji6ne5ylkfJaX/cTfTTrADz8kBnscxHhp9KpeEgVtTcR2N4D?=
 =?iso-8859-1?Q?psUBU+6dcPYP/SLNUV3K/4gn6m5f8RgSdKEi8EN/QDIMKL9cUseNsjoR4N?=
 =?iso-8859-1?Q?t/2tTWZyJB/PLudDiyLar54S6BawUsF8V15w3jJuPcET4f5KspNQtI9KYK?=
 =?iso-8859-1?Q?Agkll/CpJLgN6VGoEgzMV91ulbyEgHawSrlY9tiLY/K93nrnDrvJRONpGH?=
 =?iso-8859-1?Q?4UTJsv4fsGZ6JBNHJ6+wwAcRvuU0+CROSIhkBDLMEth378FfdEKxjABoGF?=
 =?iso-8859-1?Q?+JvjW2rAeO1v2mARgfzxCJNxAthYD4VHOghk6kIh8JQg8OL+UutvuawZw0?=
 =?iso-8859-1?Q?IMJXnPdjaDV0EerQmHEs8S2ApvwdG24uCweqDkfIiz6aDn1bMHCc6Mesnd?=
 =?iso-8859-1?Q?7rQWCN6LMUwf3CoCBaPhzh1B44thMudRylwTUTra5Lpvmyqndw514ZZ+jg?=
 =?iso-8859-1?Q?TxNABmHXuk2sDx2qxBKXurJHXbmKBy97LIrmH2LUnTJi0S4lC6Weh7JlJL?=
 =?iso-8859-1?Q?rqQelZLdWgRB8AZfKBAavLdKsbodbHABBg8I1Qiq/4b7TswvBWt/La+hhb?=
 =?iso-8859-1?Q?I/7POMJS+/iAVhfbtO16vpCx5K10rLk8zk0hiWZpj3awZptMuBJKHYAqXF?=
 =?iso-8859-1?Q?gT+JxxdjLArmHfrjpKYumnTKzZztFrL0GThMh0ycVasoyff6bGzi6fvc8s?=
 =?iso-8859-1?Q?MqGynl7IPZxGY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9483.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f169d34-4ce1-4deb-241a-08dc345e6273
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 10:58:36.3003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wAO81Qt7nEeDqPAnM8/iMXBXRAk/3bjw3TOWh9b6ELCXQPi6MvNQI8LS8DvWJl7iIPHxTYKhnJXQcRQvEVGg8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB9647
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 23 Feb 2024 10:58:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15954

=0A=
=A0>This approach is fine with me. If we need an argument in the future we=
=0A=
>can make one that does "yes", "no", "auto" options. Do you happen to=0A=
>know if this is version dependent or if it's just because I didn't=0A=
>test with the psycopg driver?=0A=
=0A=
Since I saw your commit earlier on removing the use of pool [1] , I assumed=
 asyncpg did not support it and it also seems to be aligned with whatever w=
as written in different forums.=0A=
I have only tested psycopg v3 (package: psycopg) and verified that this wor=
ks.=0A=
I intend to commit a new patch-set since the default pool is very limited. =
I suggest allowing an unlimited pool size when required.=0A=
=0A=
[1] https://github.com/JoshuaWatt/bb-hashserver/commit/1a5483d0d96e2a429b1a=
f0dca5a523955c8aeb1f=0A=

