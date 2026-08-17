Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F042FC5B572
	for <webhook@archiver.kernel.org>; Mon, 17 Aug 2026 14:17:49 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com (SJ2PR03CU001.outbound.protection.outlook.com [52.101.43.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.31552.1786976263450003803
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 17 Aug 2026 07:17:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=vzK1OSq6;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 52.101.43.51, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ErrY2KH7+3vy2cmamgsKbas9OyWY1P5IpyUOjEzAn/FcY6OpFSGNce3Y4fZbhtYiFvcE2QHuiKif2pPyXpQWfWqLzphLFUwMZX8YBzlWCmnFekrNBa33ktz7Tlj++EdENc1k7wdbXSmZm4+eGu/9AIP0LFbmDi1JbxkARNxLua2lOfirfxKHYDaXfyH/fmW4rWmaopHBToBRnDANh391ww30A1epVnU8sjCyI4t2/J32BIDy/3Z6ellG2z4DHFQ4GQaDJ32MlR6FAAbnk8JAW42dVwNldeWgSkHO7ERB2Z6ePgzr8m+qQb3Sx5oLKDP918GsKSOmSJk7LkKidH2FTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/JBZbF6b/eS/l7vrQftYNUoLFjgTq/cETmtMPqbaxyk=;
 b=tFeO6cawyPMfSiQSrxuFgzV39kyyYpxPzI4UqxPJ4J4td3IthfdZSi//A1MZEQdyRcN2nveaMN2CCseId4PKHOI0v9PQpL3Spv4enrAvuHQy+P5XBJha8mu3MaQ8mwpD2DWIA1NVIYjcvUEdo9cRWuHJscoORZig9Ly9qAkarXbejSAjwufTVEjlfpMW7UJWemZ/JxNIFmTGHpy5/9yQsQKdB9iEMfWOiANZ8uCnsgZrnMkIPhqiba1JrOb862Ecam/e6mmaPVaF8C1Ex7hzTgfHIZo0hqkczu+PXFvWUwkk27JgH29fDIlQgO4NoGW22ENIRzEvxtO6JGoWTNb85Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JBZbF6b/eS/l7vrQftYNUoLFjgTq/cETmtMPqbaxyk=;
 b=vzK1OSq6kQOFfutF1JlxJpcFImsks+zWeh1f8g/cvpHp5Wkrq1neXEn1Vuv01GhEVrFWq5t9f5mll92/epHzLaXUL7jBccKRM3XcJ1ZsvnfjNjtAJ8t05qD2fl8lzbjjbr0CWTpLD3GTaPYIbT42AdWia0WTxidOiHVheYzSX/aK5lRSxaorXlBRmhRcAiUoMpEmKbzMuStvaItD808gHt30Z/JeF0KFY4ff2uTrOMQRdapsGvrGhuwJ28rwJ7Q0ilC0jNziOJI0C0dmi3+IGzXDLN3PWuMHAwjn+yROMkLaECDXVp99u8or+QpKFPdqQ0Mt/W3MQltHG6olwtLU9w==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 SJ0PR12MB8168.namprd12.prod.outlook.com (2603:10b6:a03:4e7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.17; Mon, 17 Aug 2026 14:17:40 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2%6]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 14:17:40 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "Fredrik Svensson (svsvenss)" <svsvenss@cisco.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: 
 =?iso-8859-1?Q?RE:_[PATCH=A0v2]=A0fetch2/wget:=A0reuse=A0cached=A0HTTPS?=
 =?iso-8859-1?Q?=A0connections?=
Thread-Topic: 
 =?iso-8859-1?Q?[PATCH=A0v2]=A0fetch2/wget:=A0reuse=A0cached=A0HTTPS=A0con?=
 =?iso-8859-1?Q?nections?=
Thread-Index: AQHdKnxaqgOfbFZ0Nk+1fTBcZToMq7aiSJ6AgAAG972AAAE6IA==
Date: Mon, 17 Aug 2026 14:17:40 +0000
Message-ID: 
 <DM8PR12MB5430D56BA600CBBB0DB41C428BA72@DM8PR12MB5430.namprd12.prod.outlook.com>
References: 
 <DM6PR11MB39625FB901F43B181E8B7C38CBDC2@DM6PR11MB3962.namprd11.prod.outlook.com>
 <DM8PR12MB54309AEE365DF999981829528BA72@DM8PR12MB5430.namprd12.prod.outlook.com>
 <DM6PR11MB39628059FA2D29F9B3F74295CBA72@DM6PR11MB3962.namprd11.prod.outlook.com>
In-Reply-To: 
 <DM6PR11MB39628059FA2D29F9B3F74295CBA72@DM6PR11MB3962.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=910e671e-f650-4ece-ba89-b6868c0f2a60;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2026-08-17T13:46:25Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|SJ0PR12MB8168:EE_
x-ms-office365-filtering-correlation-id: 66740908-57a9-4c6f-92fa-08defc6a4c16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|56012099006|38070700021|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info: 
 9DcfvYuYcqSRVeyZ7zr2hJDrwFj6xCdmkEOB+0CD6AL97m4qcWK6GAh23Yq54kkPLLc+OIcqb4T+5tV/PFl64Eik/kvGP78snDnbwDBbIvD8Wva9UGv/DM+YEhT2gMLRtwP2TajGKCT0Ej4GKXzIGArrsT4So6j8bl8kWQzw6+oKU6s6DEuGz78xXdPwXuykYAiCz405E/pnfXfvWltH+PxgL1qpHnQ66WnFiMl8lCLh+dBQq1eAwu4SBHxrC13YNfhAp6NZnBjQ+dhTJqxI0AZBB3z8ZwilDpDXHz+abB6rCp1qwgdo4U8KyqUyFlRBhlWXCdES+LperGFIPPfsjVT4I3TXa9LI5LDne8KB0fNZkNpVkgxmQiV+AMkKRM1Pyh6xMNcO6CMrOt73mLyJus5JVj3gkN4p279txxp3qGpP5gCob1sGt5hcjajoL4wyVLNvKwMYGc5cIKR9EcX1jmxJMWoDFdbfcM5WLHJc8TPdI3rKQwYSj9jlyIn+AccZr2uNzHfYkse3AecSlNmPzQjk5aKeGsa92U7JoIgS1HikSa4Zlp7m8MIqKQ9J+Ri2mFlX4J3ph/jujEWzGmNJqstzec5LdJRhc0WwGXDGoqFTvX+luPIhoA7VLRk71Yx9wX7qAfhRoXXngsFNQrspKMv73Z0wrcF/cGEnMvpu2fgB0Ur2w8JFa9XxUHhCxmwmyWzGTwdiiTzY814w2UCvIelR4a5qkB6IZh52r2/oT/0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(38070700021)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?o1yYujbhk94Z7h8/Pz8jvtP5CS6VRfY5GU6ikz6VyPY1gn7Nf565d/HxxR?=
 =?iso-8859-1?Q?AelwwNegBA3N+xc/Kg0yyRBREuv7ner3ycPvD1rSbtgqxfBoYiAWwOgbAn?=
 =?iso-8859-1?Q?Co5Gp71qoCMwHoC8pUv5UaigRi2kqrTGgB1c7LlGarWKG16cip4G4XM9TC?=
 =?iso-8859-1?Q?X2AsuDtNSAKxtPIN24yxyZpJ6CtG6AnNeCmFjpcg+tXDZxLKcGyoVKR8SA?=
 =?iso-8859-1?Q?DLvnEtr4qSyMKk7zAymGiPveyRZ1tEomicABuGhvoPeMJpKDG8Z1gafSgD?=
 =?iso-8859-1?Q?PjxlatC2zpMPqLGPqOGMLFgvVqwuLKqCFMqLA3udKmmo3lDJqqgw5MXJsf?=
 =?iso-8859-1?Q?ZlNudwxSo4XBIAxG7KD4+SLr8z7z69QLK1Et9lJd0XQ42uA+5JC3CTHOF+?=
 =?iso-8859-1?Q?o8niMlLAXftwuSG8xdOW7bSj1HSKXxG/4MncxJ8XqjSRCrVbgLQ9no5yXW?=
 =?iso-8859-1?Q?nc1Rt7LQixgZWDFNpnLcQTFBl4hLplQMEvY1vcwZygSUrx1lG2BRy5bZAN?=
 =?iso-8859-1?Q?pZhrBksCaV2TG4aWSWWkQTbCv34UuJjiGLqRbaCEzIgLMaEE4rA60OrEZJ?=
 =?iso-8859-1?Q?Wq+CgW8FTEPN6mYj97ZGjwGh6UF5yN1IhR+N6EN1YPgO2/9n5BKGOWr9xv?=
 =?iso-8859-1?Q?aU7OoTnCMfl3kJfDyepsMwaq/wJSLX5h9EEeFQRIf4tSFQD2caviUSPvSB?=
 =?iso-8859-1?Q?GJIa/S+pdGpbMlGbL7DFyAnLP+Pp9DiIHAQ7axLNRx5vPF3uleHriepjEY?=
 =?iso-8859-1?Q?WM6ORkr446v9SkrKdoL3Yjv22XEelQJ2aMDDFxdb5x46FRn0uFWTQBZc1S?=
 =?iso-8859-1?Q?NIxzNWebtOeR189AYU4NoWJGymYGPZM6aYc+XAVHti76otvs61eAdpkI3q?=
 =?iso-8859-1?Q?TStINYLAfx75nrzfj2LEK3YUV7/8P9qe7VitowHSwuK3RgcWU67NTVRpzD?=
 =?iso-8859-1?Q?+vaE6vWgCvi9EyTKCKxLMKcZ+qsfB6zy6wacNlbwdH4htPEUQnqaQNh8/b?=
 =?iso-8859-1?Q?eL/Od3r41e+ANQkKZFSU1qgq/o7nnObaIjIvzOBI6Z7x8oORIZH2HqbiMb?=
 =?iso-8859-1?Q?O3SIXQALe6B0GpHsawzX7fhIRwt1gEfbEtQyQyZ7s2+qOiiKeql6Xmh5Pk?=
 =?iso-8859-1?Q?sa+wZn0D0b3h6vJSEE9ElsnoATqlG/MpEQoXs0jvAkOXk+fWXsp5UKrtIJ?=
 =?iso-8859-1?Q?7Qs3v7wYxdz4SGVRD3Td6DGVdGy6To3SqClAiduAzR260m7Zg+djZ/u36m?=
 =?iso-8859-1?Q?qTk8N5WvVtWNxkhTNQmQGSVBgAWxbWHi2CQkuT36CPs/rGzNXePKAkyZSu?=
 =?iso-8859-1?Q?rL8rHF/dZxOo3JSOFY7youW7k1M2OFJLTyWW1XdXPOflycYaaVYyUcx8gP?=
 =?iso-8859-1?Q?vbtFyopgiBOgSiv3K10wUbbUVp3oCmdYk/imPDfbjd+sZ5vs4K7/CiGDHN?=
 =?iso-8859-1?Q?2wMRi9DkX1oUGgOt4r8I42h4mut7PCg8FkEEGGD+MSa6o26kEFFbqxwj47?=
 =?iso-8859-1?Q?KgYBHFIY0gcQjPDpWMCgI8h/o6gEDVX1pv57GgMAqvBUYLYO/OOqaSVgsm?=
 =?iso-8859-1?Q?Aqae5R48bQrveeCL+f6yL8lR1x/vyXAX/wWfQxTBjnVgxpxQaAHFenyOXx?=
 =?iso-8859-1?Q?qoFL9Wv9s4GPPT/DkfATp+cCgFahh1PRmiJ8dLhpiNKzwZcRNBO2p8bmDg?=
 =?iso-8859-1?Q?rBIlevpFnk4jcyzBLEcDEKg5yThyfdPeO9KgzBzjL/QXGWB33NlS6isU90?=
 =?iso-8859-1?Q?sPV9Oj+CGfjZeuMtRbnKm1QLuCVcvyOO/dqdJem+BFeTLzlhMC7Zqh8bq8?=
 =?iso-8859-1?Q?pYLzXppcDA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66740908-57a9-4c6f-92fa-08defc6a4c16
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2026 14:17:40.6330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uYXZrK0el/gYhVojBkXTq8jUIHG4FDZpjq0oUqoaozqM1UndmKjdULWp0/eDfcILtqsWiZh0QcD5kBoX5ySLFlBRa57V2bS3u0aJ0oyihSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8168
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Aug 2026 14:17:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19972

Hi Fredik,

> Hi Chris,
> Caching the SSL context should provide an additional improvement, especia=
lly if
> context creation takes 100-200ms on your system.
>=20
> Please do send the patch; I think the two changes should work well togeth=
er.
>=20
> Cheers
> Fredrik
> ________________________________________
> From: mailto:chris.laplante@agilent.com <mailto:chris.laplante@agilent.co=
m>
> Sent: Monday, August 17, 2026 3:48 PM
> To: Fredrik Svensson (svsvenss) <mailto:svsvenss@cisco.com>; mailto:bitba=
ke-
> devel@lists.openembedded.org <mailto:bitbake-
> devel@lists.openembedded.org>
> Subject: RE: [PATCH=A0v2]=A0fetch2/wget:=A0reuse=A0cached=A0HTTPS=A0conne=
ctions
> =20
> ...
>
> Funny enough, just last week I was also poking around in this area using
> viztracer to do some profiling. I was preparing to send a patch that just=
 cached
> the SSL context creation, which on my system costs 100-200ms each time (s=
ince
> it has to load the certificate store from disk).

Will do. I think I'll hold off a bit until your changes land in master-next=
 though, to avoid merge conflicts.

Thanks,
Chris

