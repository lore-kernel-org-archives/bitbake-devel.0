Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D21D6E2AB
	for <webhook@archiver.kernel.org>; Wed, 20 Nov 2024 04:09:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (NAM12-BN8-obe.outbound.protection.outlook.com [40.107.237.45])
 by mx.groups.io with SMTP id smtpd.web10.5674.1732075784340407329
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 19 Nov 2024 20:09:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=U+u9Mb0E;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.237.45, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iD/YVc6jWuNdewPk1jxBVn65nAsQKh6n8x1WmcF49rm1seJq1andxqSCoz0orLQ98ReLwGzPFGA2vJ/iwjSS2WNOkD/ndX0V9fcBuzb+p2jLkd8ZwnozHrqIsCQXUcpJdWIVex31K30bMDhQQ4Nlw2jfVrwWEjXJ3DahjhT5vWrdE5/66ECOS7/JeOj3xGD8hOdENJZE4TJWsuStnD/US0HlyV4+eygMB0ZyN1eeeGbbPIYRn1tFTnwjh+WVPEeayRz/A+SfTNUNAmR41pdNLXQYslWrC3XLEWwygMNeQDkP2CzkiXn4wwN6pBG/Lxt9pmJMw/fyshs891nHKCmw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhIXfHtU+yzhUTJnKc5e0LzozuMjDs9+Va7vwYznn1A=;
 b=VDc46WKid6U5bnJyY6jfsIT72ArFMVZ8wKerJufCAMXH8OXJHVfhjST8xLvccwa4oiHJ6N9WD4MBhLA/3BDgkwBOpKkyYSuL9ZAsU3UUXY5J+yhY7/jajL2xMlfgcO87/Unrj2GbqhESh9frhMbyCf2ONmjkG8QSbWR6A7bpSEU4CGb+l+Z1Hk0pAulI2gBen1rxEbS8gp8crUwWt+/fDLlBu0TpVwDOu+ODNNLa2IYAOLfp9grk2/u/N5zy1aVFERpNJWDM2W2HbbEEax6jToebJRbLlHAnchFyaRsqO7k5uCr5uObxjVAKe1jLS900S6liepyLeM/LwxMTey7G3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhIXfHtU+yzhUTJnKc5e0LzozuMjDs9+Va7vwYznn1A=;
 b=U+u9Mb0EWRcrIqnjz901NS/HtfPOcGAZPzUmtBk4avzaYzz3TNRhCLz/Eu6jjPxpscXWOyx0U5uCLX3EVdD0WuHxO+FT5YCc2U17aOXWHUfLAJAvR7T35TlPDIxbVoZXwmscnoVMmcvY9w7aJdhzdSMPxdrC26GXdPX7Avs4clUweqM52SKwLDO8rc5Maox/5lt076MBL64UlHusV+JNX31lfVJOUEurudWvXKUbNM2v+CwfY/HgHl38rElU7lBqNulmZugohu6yCeL44JVJDGj3tJAK/VdMVV99FhnxXDiXvqGerg3VxtJFAgkV1wHGVIKoUZDIlUDaUagDXq7k0Q==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 PH7PR12MB9175.namprd12.prod.outlook.com (2603:10b6:510:2e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Wed, 20 Nov
 2024 04:09:41 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%5]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 04:09:41 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "steve@sakoman.com" <steve@sakoman.com>
Subject: RE: [bitbake-devel] [PATCH 3/8] checksum/fetch2: Switch from
 persist_data to a standard cache file
Thread-Topic: [bitbake-devel] [PATCH 3/8] checksum/fetch2: Switch from
 persist_data to a standard cache file
Thread-Index: AQHbGX65WALcs3wjNUOGQEjavFXHBLK/znQw
Date: Wed, 20 Nov 2024 04:09:41 +0000
Message-ID: 
 <DM8PR12MB5430F82E66A733A5687F5FB78B212@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20241008123627.252307-1-richard.purdie@linuxfoundation.org>
 <20241008123627.252307-3-richard.purdie@linuxfoundation.org>
In-Reply-To: <20241008123627.252307-3-richard.purdie@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=44e0bf41-855f-4f53-9c35-8f715c8e71d4;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-11-20T04:00:22Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|PH7PR12MB9175:EE_
x-ms-office365-filtering-correlation-id: 962a5332-cc60-469a-3235-08dd09192844
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?u4/iTCkV/D9m+KmZwIRDLxkgjU753HIjZVFWw6Sji/O8X9Y1pW9rn8jk0T5F?=
 =?us-ascii?Q?1Nqqahz6w4J/F3ugBLZRMZF8GtYxVprAizZP8WU34LhpXnkHbM7ET2tMmBfJ?=
 =?us-ascii?Q?GTfaOCKkzlROHhXXl0m8j6VtHkI42joXojrGzUBbFrD9T6Jp2QLPWuOmuA9u?=
 =?us-ascii?Q?9ZDXFyBjsqSJO2IEIt0IAf3yS7P2AM//7O4MJvPpZ7FjfceLlk35dQ0aEEy/?=
 =?us-ascii?Q?1Na2hYdJZVy0Omst03xztyv75IKy7W+wKuIOpJwEpbBxlhSTlF8NoXnhVgkA?=
 =?us-ascii?Q?9F67irCm3JCutEwn0x9zSgPPRzuemDxTvjJKi8hcaHcUK4gGpH0vECGtMtVM?=
 =?us-ascii?Q?0qjA54qKHzUDEM5CcWF2fOYOUiCvL1Rsfo0PsbfqXHMnEhq0wfPWLfYia+l0?=
 =?us-ascii?Q?6lwkEmyhKj/flDcangUbHqTD8NoeJcsSoJe+cO3xQkn9sgfeVzTw4MX+v40u?=
 =?us-ascii?Q?vRyYuVRJPlu195dax/wMw7Lz5asb/TMtb/2YKjNeT7AelfzbR4CAI2MTQb2+?=
 =?us-ascii?Q?6h/Bw7B/8f3aYvBVt0WupTbEztcGy/XtytxYbf+sz4ryn8KSh3inQGsJH9KV?=
 =?us-ascii?Q?dODFtxwF7Ri7TG2hUq9oBZkr8xXyjLNv+owgYnr57/z00NgXdiVTxGFyRDDg?=
 =?us-ascii?Q?uPS+R7D2Bs+CDVfG/24soPaUHfE0L1hVhygti3IOm4gef5d+Y26fxc66NlYD?=
 =?us-ascii?Q?2bjqzf9e0NRD9NyUIKcg2cn+iVuPws9eKSu9xEy22iGo/AnhM1Ohx4ufOFL5?=
 =?us-ascii?Q?LBvO9Z4JXj3io4yPczBQFlyBkqlaucE4qIUIU/5/pVLfwLW28DPwHDhdYOME?=
 =?us-ascii?Q?bKWxThhEUzTxbUEYMdcXF2WPyke3qmAbqzeLrFEzaG1q+kC7y6WtyNS7SJPK?=
 =?us-ascii?Q?YESOYihwO0E8Vh2RL/3rEmpJ+M7U2RO7JlmYVh5bjnY3HVuIN01PGC1SEn2c?=
 =?us-ascii?Q?M8kOLLQJ6f+ez7eZJbKr53d9yUGbPh/MuDu2Vhy3HQFjuKjbaOjRWRWXSO5L?=
 =?us-ascii?Q?+WigiUw03BsXtlWYDXA0jMr08Bkfb9edCG38pIVcies+0tRetX6h2Er9xGp+?=
 =?us-ascii?Q?mWRdU4wCzAXB24hTQB7CZBKBqzBWG2ldfoX7tpSmQc0pj6z69G51VoyInnR7?=
 =?us-ascii?Q?mbiSVRDeVgju9+S0Cr42WuygQGpXjWEDFy+qsB/2hArHXNCGe3IgyndbMwrm?=
 =?us-ascii?Q?UhGeerSGeGY/irKZu4QcNylhbzNDjfghYwpGA2y46RgBtKUl8E+J6sWSBlsc?=
 =?us-ascii?Q?GfBAA228Bazlcx8oqluK0u5z8fXNzv5wJzEAfpsf24JhWN3rCEJO1SGan4ry?=
 =?us-ascii?Q?WlRfYOVQXWmhxKWKpYsok1tdiQu+DmvlfbnKZfToc5hRMqJ1DVMYBG/lJmrS?=
 =?us-ascii?Q?3NB+0cfb/JfNdQeouncc0mvqQCmW?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?8+z+gPqUyQOtbHwWma411hrAH6gjdZoBAJbAIF7+Kp2sh7CHaf54tvJrdxOx?=
 =?us-ascii?Q?RuqzongEJ7J//oCmQEFwtLT+a1S26CIrzel5e02tMjdhg8Y8/VqbGmRcR+1N?=
 =?us-ascii?Q?E87paVPXNS/YEBlcgzNfKLMXNcuywB+zmJu5U8Kpb80nYCx8uNhTG+bmJaJa?=
 =?us-ascii?Q?LLA/Ez4ETEVJaqUi8ZsRdaq0jZ4ritS1gfLQiU65PWAUP4aMnWm2QfCE0aYy?=
 =?us-ascii?Q?IhTz760Wo1Z8ApIuPF4TA9rPQLN/i2L5I/QorthVdlbk9Uk3Q3ngifw4Z/Ri?=
 =?us-ascii?Q?ylstU3GOZ9uiuHw6jwQL/WD5hghlWXIONshB29UCajtoQQvtBPQkw+Fe/xW8?=
 =?us-ascii?Q?tnx1nTlnrh9Drq9LZ3PqrjyaJSXuiwTemj6n7b3u5S8BSLEkP47e7C7OsHw+?=
 =?us-ascii?Q?o8tEPQFth0vOfq1iePE2Aglpa/EzG4klreNLXt5u2zYlSZ0l7T9W43ZM8ou5?=
 =?us-ascii?Q?Yn4OGzq63rYZ7f5HIH5D8vaT1wWhYSPJ5MhcC2KUqJhdRZPYwuEUuxKwfVJG?=
 =?us-ascii?Q?nVXKujWD4IjQjrklvTTIa1QBuVSL8JJfFrTgag0oi1WMmkGka2UaCdbujYwR?=
 =?us-ascii?Q?A2sNYaw23fcs+0Bn89Bc1N5u2yegH+x9VmnzwBaJfV88yDcV2Xvc6MAgVdJT?=
 =?us-ascii?Q?CycyjJoR25j1kjqJ4oXGESwAHexdXi5uQG1DMtSlcTshUXt/VZg1TlihowNW?=
 =?us-ascii?Q?ypkSYse5mYjn3meMn2xMCg4cKBsMmArNw2kUbSwlBW/8XwpQN+aXGDRnTGbf?=
 =?us-ascii?Q?Y35GeKKUgiIJVYfcPPwCuZ3Lrw1wgTAY0W6iqqb3kJ548sx/GnUOciFK2wd4?=
 =?us-ascii?Q?Lb3I0Md70pUZDd+hzv9xMH+9gSiOYsBUz54ndPrd60Qfkb4nX1tUYnF0cyRg?=
 =?us-ascii?Q?bZGeQv5ODYKX0AV/IjScU6IVLMGVlRM34SCX+ragye9tO5TPVq0a4hSU9lXt?=
 =?us-ascii?Q?ytV4qeJKQ8qFD94NZpx5yEqa6BjIPcSUme4gJx5U+ldnUbpZCSOo9bV1+bbo?=
 =?us-ascii?Q?j+xZsOdljj91hPfF9bS6/L3Rpuy+Hn1WZwTvW17qslI51ClTHrBWZ2y53F+w?=
 =?us-ascii?Q?gws9SmfqXLGkG0kbQZn+ilvwjjvE3RaFwW56M7fbfz+hRvtdgfEdFgjdMA1X?=
 =?us-ascii?Q?r2i7Dwk6JYbu32OP1ja3+kCFZhdj+D2fq4x2cuanV5GbxtdKQqot2tymE5jk?=
 =?us-ascii?Q?OPJWN/ZS/YVtvMU5WUagNkRrh+3NUBHpCFsjcggLbfMKKOMh4Mzd/hPbL8bV?=
 =?us-ascii?Q?jMqnYNro27jC8Nq4OneY/JtaiAZtT3OQ/PWXtt5IxddWRBFEJU28kcgbPlfU?=
 =?us-ascii?Q?JyyVHXihgtyyVe3a0Di/kBrLT4ns0hn/PSjfOu8QeA9h8KglEgryMEKf8HV+?=
 =?us-ascii?Q?4VXUlVk9tTCcjMoMT0EmxeHaZj3Q7C4C2JmVz8P16/7Hnz363SgvV6H11Ftn?=
 =?us-ascii?Q?Y+WF6tXQ9GGk7kiDM//3oxoe3EN22OyUFpIiu+schIEAZBDPRrX6JxwQ6sV6?=
 =?us-ascii?Q?bnL3cGEkVM5/oG/BMSZY2p1izMIIro7xcHH6PxY6J3m8/yLT4Ev7WxBeaxTj?=
 =?us-ascii?Q?AnYgYrFr5pKj7YVghklSxLIkdf2JxWlG5oV42/ad?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962a5332-cc60-469a-3235-08dd09192844
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 04:09:41.0543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mtZkyNfUpYCUXxS2OxaYhHNA2akaD13r0ccchF7yMQzx5YJvNMLWoXMK/X2iB9VwvVU1sVO0Yns2yW6INGABAij80sRLNvxDo0up84Sv23U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9175
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 20 Nov 2024 04:09:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16814

Hi Richard, Steve,

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Richard Purdie via
> lists.openembedded.org
> Sent: Tuesday, October 8, 2024 8:36 AM
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 3/8] checksum/fetch2: Switch from
> persist_data to a standard cache file
>=20
>=20
> The sqlite connection handling is causing problems with python 3.13. The
> connection can be closed at gc time which causing warnings and those can
> appear at 'random' points and break output, causing weird failures in dif=
ferent
> tinfoil tools and other tests.
>=20
> Using sqlite as an IPC was never a great idea so drop that usage entirely=
 and
> just use the standard cache mechanism we already have for other situation=
s.

I revisited these warnings on Scarthgap (which doesn't yet have the persist=
_data changes), and was able to resolve them. Ultimately, it seemed the con=
text managers were just not set up correctly for managing the Connection.

The __exit__ method of Connection only deals with transactions, and doesn't=
 close any connection to the database: https://docs.python.org/3/library/sq=
lite3.html#how-to-use-the-connection-context-manager. But we were never usi=
ng a context manager anyway when dealing with persist_data.

I was able to get rid of the warnings by adding this 'close' method to SQLT=
able:

    def close(self):
        self.connection.close()

And then changing usages of persist_data in fetch2 from something like this=
:

revs =3D bb.persist_data.persist('BB_URI_HEADREVS', d)

to this:

with contextlib.closing(bb.persist_data.persist('BB_URI_HEADREVS', d)) as r=
evs:


I was wondering if you or Steve would be interested in a patch for this to =
apply to Scarthgap. If so, I'd be happy to send one in.=20

Thanks,
Chris

