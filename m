Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE4BC3DA63
	for <webhook@archiver.kernel.org>; Tue, 23 Jul 2024 19:27:57 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.65])
 by mx.groups.io with SMTP id smtpd.web11.3977.1721762873574337211
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 Jul 2024 12:27:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=WMph7oUA;
 spf=pass (domain: axis.com, ip: 52.101.70.65, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDAdiW3oJluo4MPa8HYxs91+IUAdbjILEAiUKPE1RjbHAGHRu0coiL91lsBwTJCia1kM8dXfDILTUzhjMmGpIOFzQbmn4nO4T+fWBznPqJsQ7E2JJTCG8xU0iNqjSm16NyaTDj2QRhabD8Eu+xh+5AGgJ6s8S6qcoh+DSiqI2yx1jiG0WC1tGz0fLi+xZP16PZE+ahkgarl1XJG7TLkCeVMevcenuSST5ysYeuWxLFX0ImRmU6Uedx3tObzCHHL5Dv3wsq1fL+yf99dot3yGZ2reg4Xwg+tm83wRYKEy9ye9ComVWJSJFVKVkD0kq8DIPWs/E9t78kNQHgTcqj94Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEv03w5hueG/TlI8UwkVyJ3iY9DWhk77RN5RrPAbYtI=;
 b=lpBVm2TRmqC7SIBFCTSjstZLr7FQZbcjzpQN6GMGay4cF/NQQsUYRpCOSwz/dwJJo9Xre6xZiy9X1F/eiRWJ+sBz0WLSHSNHN9XhpzQzUXFO5DNbkzr1NdyURuewH6nO5JwO2zVuryTHWwIKNmEm4dfmdnEd08DhpOUWM1jbKjP+JMaoO4JG+ANuK4tiP3wHTbYyjPK1n/cbSw0WEQkk+GMktgBrmUWKCKMU721vXULa98LAHTHMaUif4Qaz8VepVT/uVfSK3AiHJ7dsXMSKtIGvBwzueXeKGzMJQ0N9c+rIJOPReHp3ere919qCnEY0Zu7nO+iEjwOwHSF3l9ofmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEv03w5hueG/TlI8UwkVyJ3iY9DWhk77RN5RrPAbYtI=;
 b=WMph7oUACBWQgoUzvi4hyMILFjxFjrlQB42BL3R+dIh5oG3HDxGRLF9jVeIkD/B2wEoE0CQ2UYq40gAPQYSZJjUyEjCirEXCPpD0y2F6d6uCON/+ygb0UMt1HJ3OpZpPLtH1Xn+tbDHjGwN2r6r6Q2ad9ITuzgmxybDeGMVQVaM=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by DU0PR02MB8899.eurprd02.prod.outlook.com (2603:10a6:10:409::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Tue, 23 Jul
 2024 19:27:49 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%2]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 19:27:49 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [RFC PATCH] ui/knotty: print log paths for failed
 tasks in summary
Thread-Topic: [bitbake-devel] [RFC PATCH] ui/knotty: print log paths for
 failed tasks in summary
Thread-Index: AQHawPIapS/6pGKeAESDdgOaEDjIOLHNuM1QgDcBcXA=
Date: Tue, 23 Jul 2024 19:27:49 +0000
Message-ID: 
 <DB5PR02MB10213FAD2E238F7AB9390A4D2EFA92@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <17D9E3841C981E13.27929@lists.openembedded.org>
 <DM8PR12MB5430FE1BDE5343FD142CA3D78BCE2@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: 
 <DM8PR12MB5430FE1BDE5343FD142CA3D78BCE2@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=df634e94-fdaf-4c67-8d26-2b3b695eef37;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-06-18T16:34:10Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|DU0PR02MB8899:EE_
x-ms-office365-filtering-correlation-id: a32c7dfe-4a07-442e-5449-08dcab4d8a14
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?8h5HvmaJsj+eCkDS19KgtcWwTUKkrAXGRhamW/3cugV8OQTyDv2Ux4JU3wM8?=
 =?us-ascii?Q?Uwt9P/B8UzpTFhTHgWbxJzdgQLJlOsp/rNrXWBuE1g7DRs70j0QIkumntkPm?=
 =?us-ascii?Q?7M7WzFIeTIlGTLxO6qMWiqTN+ZlEaD0NHbqNkCIizlxOfS3nc6h1DTmm0Zam?=
 =?us-ascii?Q?Hb8K/8eZFERNaZnwrDbVB3QsJF44dmOZn9M9krDtYpBVRWzYOwDGJwlW6kcq?=
 =?us-ascii?Q?GgiKL8ITuyx9OI4fFEHLZ2IWaYrxWQyvZWbZBR7k9naWrPHOiI/v2KBWzhEV?=
 =?us-ascii?Q?MUfdTqebUriUrMtDObcuIHx6E+kiYdqKUE/hCc5N2Dv1NgSjhF4G3frtBPYv?=
 =?us-ascii?Q?yo1dbSUHK4mn/tikiQyrB6b85nYo8xr/E4YPgIAV3BAwCKO37EtIa1VEdqhp?=
 =?us-ascii?Q?5XmyBdWnaABh/01KvSvaf9nawICgIpkfQiQbYjljI+QQt4ft2tlQoD8J/TNM?=
 =?us-ascii?Q?loQeuLXifPgtX5oRqZktFKwunAqQcaSNCBcYIlFzZ3Cb8eUZ2V4Y18XBbISb?=
 =?us-ascii?Q?FPMY0+Thtynm+9CsZ25yrO5HBjmE9CYe4HMCOHwFpcvOLFqy2AmaMHDNp9on?=
 =?us-ascii?Q?4m8XgQWxUlOzKaIZywFRK2wCdMMsgGcR9Rv+mZt251MYwH6qsG4wtdoqSL8y?=
 =?us-ascii?Q?JAfQsdGjOptK5ocYlqUG0PAjHGLCh1Vd0Akpf8xFbje6MFBLa4CTF02HPyUF?=
 =?us-ascii?Q?diFbqldAHgfcJLmxGUQsb+VgaM8JS2N5HCfma/DW6yeGIAX5oxx7n/WGoE2Y?=
 =?us-ascii?Q?qmGY815F1JXr8HcjilxbQxtakyTOyH3a6vAdMtjZbTzNdAry/y7rYOCAuBkE?=
 =?us-ascii?Q?Ex9OQj+uW9UzIrWqr1msWOOIJtl6oaFpJGn5IIEqT5upLQYOaIDhDurtsiKP?=
 =?us-ascii?Q?8ZEiN+5afIrXV9dD2kdC75dk3fpCs3SZqDQeYXP69MQZ09gdzr4Ti8rCJH9m?=
 =?us-ascii?Q?IkqvkUiYZm/zTXhfAcpOCzd9OipfZtPWhCzwhrRWOXD6hngOmgC4g76ZuwNB?=
 =?us-ascii?Q?gQ3/hZak4ztiC2mR7WwX/7qv7SrF8CES3h3anvlRV8Zip9/pMdxTXdq9u7qo?=
 =?us-ascii?Q?xHFmfC91+B1jaAJT26aBrMnuRhlPewdQiThuXnqBNci1Ue20640WbeD0Y3AD?=
 =?us-ascii?Q?AaRtEWD4quB6SZVf/WsCJE72+AmSRasmdu5+R+VzR4NB5ud0Dey807MSaVFc?=
 =?us-ascii?Q?IhdbE+D3Jv8gys7+cxc+RB0fwcl6PHNSSE40LwajN4o3OyqxD1do1tHpBmA/?=
 =?us-ascii?Q?DNESIovOrcO7YSyUzurLY7cCLFhizfgrDu8P93fxG4EsGx8p/vujCnuxWVvC?=
 =?us-ascii?Q?qs97dT5AXtz7GgCTDCaXS85+3KDOLdxc7+X1MAxONm8kyppFufl3FFsfoxza?=
 =?us-ascii?Q?t4i4ltM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?rG1KWrlMpxcDlU2QzAi+t37RCqyeyRx8FqDDR964Kn3Wu6MkbkeTbk5iwjwg?=
 =?us-ascii?Q?UuNGyjRfQ7D0eHd/3Wpa/fqbrckeBbCzTd6eYB6wP/KMNxBuShGOj6nLNygA?=
 =?us-ascii?Q?aQYt1YhrzJLKnNFvitovy4A7CMFcSx1LYQULMSqJqT6VM/6hf3dgf0F7CqAr?=
 =?us-ascii?Q?frEF3ncYGVjodqyso+xtUp8plKTU3w331aESgN4IEtGMWbJPhnNuXYuF7vl/?=
 =?us-ascii?Q?+VeCwJ0hp8pQAWwqpH6yS3mM0bguwVJuBz1KxUH71vW/AMExsuGDjzuck764?=
 =?us-ascii?Q?ajax/cXapMwljI2W9o3L8byseJbZy4SJ/dpRHu3U4ryW/au37qtWH9lWwom2?=
 =?us-ascii?Q?sv/+AmQIQcXJw1rK9N0nchF5mR5nqvBPymO6HpDnOfy0QTbTzXBMbgDSvvjv?=
 =?us-ascii?Q?tfmOTmfJV28neLuOT11e/7K9G8favp6p0/LySRLWOTEReAyz57AqH/bfvlFx?=
 =?us-ascii?Q?fiT7Aspx+WlLrgPySj4oDdIipsqlakUP8yr1uRxeZ1I79dgNxFsGVRtB17rV?=
 =?us-ascii?Q?GNKtwJV0NTK26te2TdKQFMl9vr93DU2K6YpsLokjftthdaablBdpr1NzmDPt?=
 =?us-ascii?Q?5kjE2O+89oGMMg91jbyIHA8JkI+y6M9x4oextaIA9O9Hb2ahLLUaKCic9g1e?=
 =?us-ascii?Q?2Q0n9YEH2/H/CYPpCD00WaAI463xRpBBkeFWoajLPRmQgvV+PcXPzQZPp7Va?=
 =?us-ascii?Q?aYbzzd4LMyK5SK/aMa4OLGfKLHsSzICpnmC+60LwFAdSE/S1n08SL1x3rPLr?=
 =?us-ascii?Q?2y/Z8jb1eJmikyaw1lfnNSLNex4utqN+JYskpw70Gb9q6cnLoZw4Ddy89zZL?=
 =?us-ascii?Q?CNxrtnNMrsNvIlYmGXrD2/Ohc+GaFoqxcHCCxLD/4akqrurHvVXC96KPQVdk?=
 =?us-ascii?Q?pMRha3kPCLn6YyjQlKSxLlMEtYp2z/4dBsF/g9cIMyF1jQCUhCgXPk0OOPFa?=
 =?us-ascii?Q?DKxjZiaxul72WhWPcCmsTJK0hBIwiwTjTqwDO4iMqv9/hxQwGz/OT1umsnhz?=
 =?us-ascii?Q?mvadLlOpVzxX56XiJqUB2YigAj4UqgTIyWYixHE7CmE6Cdo1PJ7hOvqgx3/N?=
 =?us-ascii?Q?XwpQ/p1HV7uNBT/IvffM6RUL36XQqYGzUG5IpuYrrbeJ/syiWx7VMboyfMWH?=
 =?us-ascii?Q?4dAXMRz2RmM/ieM4ou08x54zIFW3NudOMaUR6nE668nxkeDUaOUF8h4GZw99?=
 =?us-ascii?Q?MQN1moVSASylepoWmJotkkwLDgu0u5yckkyoqbDAIWLPtDwPSM0IbHRDbgry?=
 =?us-ascii?Q?hsZDMUufHPXbS2P41nvKT/wONNy7je9gY3e0zkfBokLylvhP4mkBUZomOz8K?=
 =?us-ascii?Q?J4NRsSeQkqNYnBBtXhO/mhwe0Zue65FdBtay7PLY3iJPZ25VAJo+Qkcu3/yP?=
 =?us-ascii?Q?HdBFB/o0eKf7c0FZk3t2VHoytmt9ffLjgvxRyFgDl+0PZWzm5GbL4Siyk8r5?=
 =?us-ascii?Q?ZHnq0bDyDu385aLPkjcobX/MfUCRrkB9YFjA92CW897lG0JwMBFRM6D/TEby?=
 =?us-ascii?Q?AO3b3mJ512iHD3TYwaL7WZdk9S5q2xcwvrBDShFMHLoH2kxw8sPFkAOeGx6U?=
 =?us-ascii?Q?jsesjcCtDo08ZvSMP/E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a32c7dfe-4a07-442e-5449-08dcab4d8a14
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 19:27:49.6686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jbIrVPqO9TEjjnGRi2ftX890hMGAHAJO6eKMFPwPWSqKWzpitgQkCgTslfd1w+/U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB8899
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 Jul 2024 19:27:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16434

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Chris Laplante via lists.opene=
mbedded.org
> Sent: den 18 juni 2024 18:37
> To: bitbake-devel@lists.openembedded.org
> Subject: Re: [bitbake-devel] [RFC PATCH] ui/knotty: print log paths for f=
ailed tasks in summary
>=20
> > From: Chris Laplante <chris.laplante@agilent.com>
> >
> > When tasks fail, it's very frustrating to have to scroll up to find the=
 log path(s).
> > Many of us have the muscle memory to navigate to the 'temp'
> > directories under tmp/work/, but new users do not.
> >
> > This change enhances the final summary to include log paths (reported v=
ia
> > bb.build.TaskFailed events). Here's an example:
> >
> > NOTE: Tasks Summary: Attempted 856 tasks of which 853 didn't need to be
> > rerun and 3 failed.
> >
> > Summary: 3 tasks failed:
> >   virtual:native:/home/chris/repos/poky/meta/recipes-
> > core/ncurses/ncurses_6.5.bb:do_fetch
> >     log: /home/chris/repos/poky/build/tmp/work/x86_64-linux/ncurses-nat=
ive/6.5/temp/log.do_fetch.1253462
> >   /home/chris/repos/poky/meta/recipes-core/ncurses/ncurses_6.5.bb:do_fe=
tch
> >     log: /home/chris/repos/poky/build/tmp/work/core2-64-poky-linux/ncur=
ses/6.5/temp/log.do_fetch.1253466
> >   virtual:nativesdk:/home/chris/repos/poky/meta/recipes-core/ncurses/nc=
urses_6.5.bb:do_fetch
> >     log: /home/chris/repos/poky/build/tmp/work/x86_64-nativesdk-pokysdk=
-linux/nativesdk-ncurses/6.5/temp/log.do_fetch.1253467
> > Summary: There were 3 WARNING messages.
> > Summary: There were 6 ERROR messages, returning a non-zero exit code.
> >
> > Each log is rendered as a clickable hyperlink in the terminal. See
> > https://gist.github.com/egmontkob/eb114294efbcd5adb1944c9f3cb5feda
>=20
> I probably should have included a cover letter, but FYI the reason this i=
s
> RFC is that I'm unsure if we should disable the hyperlinking in response
> to NO_COLOR being set. I'm leaning towards 'yes, it should disable'.
>=20
> Unfortunately there is no universal reliable way to detect if hyperlinkin=
g
> is supported by the terminal (at least according to
> https://gist.github.com/egmontkob/eb114294efbcd5adb1944c9f3cb5feda).
>=20
> Thanks,
> Chris

I don't have anything to say about the link support as the terminal I use=20
does not support it, but I would very much like to have the support for=20
listing the log files integrated. I have added this patch to my two main=20
build trees and it helps a lot to not have to go hunt for the log files=20
when there is a build error.

//Peter


