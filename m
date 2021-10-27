Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E33C433EF
	for <webhook@archiver.kernel.org>; Wed, 27 Oct 2021 09:53:20 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.80])
 by mx.groups.io with SMTP id smtpd.web09.9612.1635328398312464924
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Oct 2021 02:53:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify"
 header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=EgNERtw5;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.20.80,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpmXKhledeaz/6eoird+fdKoUNf3rs+CgYCG0/EV/5UWJ2GdlnHGEEKxpMRXjtuJLC5+JmuID2/kligl9FkRa8/ekRqzvgo9ax4EFT8VZ5aBJ4yofASlBOrSdbAM5QV6sM+FCgaTvid8gi31S6qzjiVNDXBQiFFmySEgLxJmfmqp5/ghYJTmYqN+aeIIzxDOsees9jSaeIi2ReXTcQDLxoxwf0L/HZSYpSYMyjVWcWij2zIMZdMPbJo+6zh/26wtwekPbGymeOTYcQsyKj88kUXicqCDxgtrqj1sh/nBlmKH1cbsjRj57xgBwu2YZCb4xdv0FZOd51odDUuqgaM7rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWJQOPxvnzhY3PtQyzP/ZjOrfz4a29lUKD/4LxCAwDI=;
 b=JPmmAXodepcrn60bOQp/YkdbhFqXGyY3HKwPDFH0zWSSMpprbDKuaIyRQbtJ0FFKnE8HxJ8XbaokmtpJ1abbBHbIheqFF+WnC5yP1RGgYPfcHog6Sdoe/jG52GVTMEuQxeMs6IKQk7RIP/9wW6YYX99/NtWJvFK39tAU/VvHVo5ufo1sJG4SmwUQRjx2ZBfAsQNGf56lrLnJEnTZfuBhI2DKZ+dkDU/UmjYWi4B6soiYIvm7gD0LUxkRwiADDARDo8mxUYxsje2+Hk2rizBhHCbjfTUokHp5IyWrp0OwC3WWpV/nQaC4pVt6SnpIdoJdFQG8c3cMJX4jlQ/9xpbk0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWJQOPxvnzhY3PtQyzP/ZjOrfz4a29lUKD/4LxCAwDI=;
 b=EgNERtw5sG9YE/+KkxD2Ok2ITlw7r7aUBZmK18UZVPsTK3A0oga5cLnfwlzccOJkd5s8OjZBimN/i5XEBNR8L2mjhAMmNd+lK6h42oFKknIx6wk9VaD6kiS89By/VHX/IKcrBk76CK8JEp63oRidVElaBZnlFY6K57qVu60Syx4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24) by AM0PR04MB5460.eurprd04.prod.outlook.com
 (2603:10a6:208:11c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Wed, 27 Oct
 2021 09:53:13 +0000
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::d56f:ec59:3bd0:6d7a]) by AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::d56f:ec59:3bd0:6d7a%5]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 09:53:13 +0000
Date: Wed, 27 Oct 2021 11:53:11 +0200
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
To: Scott Murray <scott.murray@konsulko.com>
CC: Richard Purdie <richard.purdie@linuxfoundation.org>,
	Konrad Weihmann <kweihmann@outlook.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] noexec varflag behavior vs documentation?
Message-ID: <20211027095311.yy3gr5uc7fwhkui4@fedora>
References: <d248a56-a985-952c-363c-7a642761c2b6@spiteful.org>
 <AM9PR09MB4642DA41A9B3F3FCF6CB23EDA8849@AM9PR09MB4642.eurprd09.prod.outlook.com>
 <7aabfa2b-2019-2dfb-3ae0-3ace4c4638d@spiteful.org>
 <16B1B4E0DFE93958.19566@lists.openembedded.org>
 <8bd2e9ff001261ae11beb8794f843965088c3162.camel@linuxfoundation.org>
 <CAFrvZPWhg6hw0yirR-Sq5=+hJwhuwOg7B+uH1ZYicDBoY18e2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: 
 <CAFrvZPWhg6hw0yirR-Sq5=+hJwhuwOg7B+uH1ZYicDBoY18e2g@mail.gmail.com>
X-ClientProxiedBy: AM6PR04CA0001.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::14) To AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24)
MIME-Version: 1.0
Received: from fedora (92.42.140.82) by
 AM6PR04CA0001.eurprd04.prod.outlook.com (2603:10a6:20b:92::14) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.22 via Frontend
 Transport; Wed, 27 Oct 2021 09:53:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb29a71d-7f9c-4129-e211-08d9992f976f
X-MS-TrafficTypeDiagnostic: AM0PR04MB5460:
X-Microsoft-Antispam-PRVS: 
	<AM0PR04MB5460634731A5C4BEB4BF9C39C2859@AM0PR04MB5460.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Md4VBO3HgPE+EZEXXgLKg5VA08MVYHaFToGI1QLaCYuK708YmwPSxddxkUAdezKK3Ef2+klNs/QQHvQmZhhWxsk9xHi4/6OQ4smslgwTOQTKPpa9DgcnGJtPIXPdiDbf3/WUEff/6qkzM9zfdKJzLBS7aqxNApHKyvU0HXRigx9OgoJlTv6GYLVrlJ7I9ryYiSGds6yDuVOsD667l3+Pt5QkDr4oLRYV+VoGznf2XbBm1v+nEfjb+rK+/4SjYMHH7RBACdUgTwyu+bPlo5x6z+fp48gWoBu4Kv71qUON8i+NnGEVpQNAy+9HkLPL8U6gNyBvnSBydaUHg/Z5cpw4yjfhvyDc9BOWYMAcIMoqkxtA3CM1Kyu8Pe+o0/12YY9c9PVWbvmGZrpiGlwBjofnEjh0jQNpskditz/Tx+97KDLZ0bR4qFSVdJ+n59vKSRGGEILLtb1mM4PXtRevH0Na/bUYSxfDh45xeC5ycxHrAjQ8Ab87yFZVg7dVDw5IKkr3LYjSZhuMe2xxL0fQxafH3CMFc764TacpW5zTJTNmPMNiKHSZ1g/yWHxuT7OUK5QTELGTmvlFlnEPEkmb426XKLfmLEaCfx+E7vpx6KzHWnEwrg915jnjXpHlvzBsxewDO6ygGjRWLHjI7XYnSWE/Aes8EJX+9VsMgTbAuF+ulja78WaKfeA74eQtsuJUa3iuZPN8Y1GRkwn/mfTgBQbDBFd5rEt4sSWWK+nO6t0z5sEYS2dZ8a/gpD2ACv51BLZhpx/X84bmOq54UkQGuQYAhgvingF+fb+R1JcEDFWJ/ILVZFVwha4QWaFsTEu60RKm
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3348.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(1076003)(966005)(55016002)(316002)(53546011)(66476007)(186003)(66946007)(83380400001)(6496006)(52116002)(66556008)(4001150100001)(508600001)(44832011)(2906002)(4326008)(5660300002)(54906003)(8676002)(9686003)(86362001)(38350700002)(26005)(33716001)(9576002)(38100700002)(8936002)(6916009)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZiABPbDfPpvTWkFkk8hdavxGkJB7gBlpJc7dQZQ3fVLLfQwFJiTT+OcpG9tL?=
 =?us-ascii?Q?+ovhPxCjWlfT/8Au9AL2hHsqrIU/lQne6zn4GRp77gkDNYBgCRRIZNXl82cR?=
 =?us-ascii?Q?Mpwv9YaDVfzDatffWhS/cSw6GCEiaJXelgMnDwRxcj9zISSQzxYBPpFKlBH4?=
 =?us-ascii?Q?4tizfhj+DExsbZmrCBTJl3VC7coZE084cs429TrBfoWLmD+3BJCh/q2TuSdk?=
 =?us-ascii?Q?pUttUWiBNmbNzewCzEiWVGRssKqRbacQyPX3BAWfFsPHCZtlHmztoU6bHiUC?=
 =?us-ascii?Q?HmCyrCeqRCHxRe11fLkF2iSzF/ElhH6U+UZ26ZR28uUUYIbOU2CrxBisSUD6?=
 =?us-ascii?Q?/nP/jLV2l0pcIPVMYckqXsXDUtoinzwoBXT+pQqPz1GhW4eYmBMY5vB+bxcl?=
 =?us-ascii?Q?lD8b9A2Kuu8tQ7XOoZs1K4xOKS9pAc5b+CBnpG/NlWDfaNd0ePZXz9fm/2ym?=
 =?us-ascii?Q?CxhfvpexK8pc2uGhTh5jR7DJ4RSIpGEzHDei/vPT3I/saU4ZJSgqphjJfq0e?=
 =?us-ascii?Q?I34eR5HdjOjBzh2hzl0dnYjoC96ktLacYFQP+6myeJCXWLGnPQfh441QJwTi?=
 =?us-ascii?Q?JppiA/sVIDW0uBOcKoYrAjhPnzWDbbKjvkQEZuULEEyrwxwr1DJvbf0U20Zj?=
 =?us-ascii?Q?jRgS5jlNcj2qP0+Pork1+WcOwCGjiZKoWtYg2oB26YUJF7JccSKYe1KhkRmU?=
 =?us-ascii?Q?3yAVWltuFGoL0tJj/r/Te83xyqakAVDzkz0BO9mQtL7jFD3DXS3CoGtJt2Hy?=
 =?us-ascii?Q?wTiu2+6K25cMcFCXk+yc5i3skTLwtUFPNPo4pPgJCn7fMei7iTXmSoxAKpnH?=
 =?us-ascii?Q?NXW9REYavDw9bGXhGvVjsgax1UcKN4MINveSti198rEb9pUBhHvMLTQ8PrTk?=
 =?us-ascii?Q?ujtWO5lhNHlhMCWFIhKwMxVH5JZiQRSYIo25VMeXQ1Hwv9t6HJQuG+J5rk3+?=
 =?us-ascii?Q?AktCHt1WcUk9sfGKzTJr9DEYvTT6U82CvT3QXUKM2GoAddwwO10q+i85sIZn?=
 =?us-ascii?Q?uGioMrP2zWw6b9sM+QR3aHMhA4ir0y3xO9Jmtb8JPAea9JRVGEBtrFQ5E3Td?=
 =?us-ascii?Q?rnK0SJPpA0XOs3opXc5eunluXym4BYCpMKR1MQ3cMjvCmdbfF0zQXPxUf18M?=
 =?us-ascii?Q?DZu4Hb8cynukbP0FohiSbvVTG62LaRSPhe5l7sqab8rYcu20H6NxHorKDGJa?=
 =?us-ascii?Q?M13A+DLIhxp1hkDb0cpqbb+7br1mkRlb6UakJ0cMw2RisEXKj+3+pgX7Cnmt?=
 =?us-ascii?Q?L+GGbCYhP1MBJsvM6ArnRtX7/Ruz1x1D1oqyf/M7pSnShLLCFQOIAbv22qaC?=
 =?us-ascii?Q?HSj4PY9WBCQNPeMlR3T8v/lDt/v6A712cJ+hOUr6rpnkoAQXOnE7Oj9Ddo8m?=
 =?us-ascii?Q?YNxnVkrDJv5gbDc9HZDY8V1l0gu5gt+tiTBbPsSfM2yffhInP4YPrHbpYGjP?=
 =?us-ascii?Q?bD72AN+O4mIB9mEyvo54f5eVYKz4TKZBZaOSdiPj9Pd8d0U8o1V7WkBFXNEs?=
 =?us-ascii?Q?BJl/ntszg+t9TuUyfaxLqJDDvFxT/fyfOSiw4BTnshKKOo0MCcB1gxPF6IDe?=
 =?us-ascii?Q?Fq6TXbl4BIzV/yAmf+v7kaT7ggZgEd2ZX0BPRlPfosjAgGSiHSjUVOquCfUk?=
 =?us-ascii?Q?Xa4SqqTUC8TzpwHZMNb8dSPXNyyeRzeyGQqaiW5R251HETWFvc2aHtK2ANGT?=
 =?us-ascii?Q?LWn15DC5BjE/rqWZMkHCg5wyQFpBB5kExTiBT3XEJLCRo23AIBobmZ+s0Gve?=
 =?us-ascii?Q?umDsmeDrBA=3D=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 eb29a71d-7f9c-4129-e211-08d9992f976f
X-MS-Exchange-CrossTenant-AuthSource: 
 AM0PR0402MB3348.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 09:53:13.4819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 XPVgZQTz4JzIl1mDUCGI4dOX53yKKPAzKFa5RxMJgIJtozi2cDKp+7B00DaSRGZBEqWADI456u4ldryAp2meq5FQ/qQicsTcwjS+Ddd+tOUfQ680suDFDNG68+72ixOZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5460
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Oct 2021 09:53:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12842

Hi all,

On Tue, Oct 26, 2021 at 06:52:13PM -0400, Scott Murray wrote:
> On Tue, Oct 26, 2021 at 6:44 PM Richard Purdie <
> richard.purdie@linuxfoundation.org> wrote:
>=20
> > On Tue, 2021-10-26 at 23:23 +0100, Richard Purdie via
> > lists.openembedded.org
> > wrote:
> > > On Tue, 2021-10-26 at 15:54 -0400, Scott Murray wrote:
> > > > On Tue, 26 Oct 2021, Konrad Weihmann wrote:
> > > >
> > > > > On 26.10.21 17:57, Scott Murray wrote:
> > > > > > As I brought up on the dev call earlier, the task noexec varfla=
g
> > > > > > documentation says:
> > > > > >
> > > > > > * [noexec]: When set to =E2=80=9C1=E2=80=9D, marks the task as =
being empty, with no
> > > > > > execution required. You can use the [noexec] flag to set up tas=
ks
> > as
> > > > > > dependency placeholders, or to disable tasks defined elsewhere
> > that are
> > > > > > not needed in a particular recipe.
> > > > > >
> > > > > > (from:
> > > > > >
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__docs.yoctoprojec=
t.org_bitbake_bitbake-2Duser-2Dmanual_bitbake-2Duser-2Dmanual-2Dmetadata.ht=
ml-3Fhighlight-3Dnoexec-23variable-2Dflags&d=3DDwIFaQ&c=3D_sEr5x9kUWhuk4_nF=
wjJtA&r=3DLYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&=
m=3D3MyfDNSSpgdyktGkBPxMbSTE5f_Zhd1LPfnJpB5RZKj7Y_kz1mNBKHiDRQIcQqVa&s=3DFt=
7skkAcV-DVdN9pgL86P8uC4YXvmaZAAxv_Z_b2RfI&e=3D=20
> > )
> > > > > >
> > > > > > However, as I discovered yesterday, the reality is that it bein=
g
> > set to
> > > > > > any value at all disables execution, which Richard mentioned on
> > the dev
> > > > > > call helps with performance.  The question Richard asked me to
> > bring here
> > > > > > is whether the documentation should be updated, or if the behav=
ior
> > should
> > > > > > be changed to match it?  I do not have a strong opinion either
> > way, but
> > > > > > would like this resolved somehow to avoid others spending time
> > scratching
> > > > > > their heads like I did for a bit yesterday.
> > > > >
> > > > > As I stumbled upon the very same, I'd love to see the docu being
> > updated - I
> > > > > mean implicitly it already does that as noexec can be only
> > deactivated by
> > > > > putting no value in it - but both cases should be properly
> > documented IMO
> > > >
> > > > Chris mentioned to me OOB this existing Bugzilla:
> > > >
> > > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__bugzilla.yoc=
toproject.org_show-5Fbug.cgi-3Fid-3D13808&d=3DDwIFaQ&c=3D_sEr5x9kUWhuk4_nFw=
jJtA&r=3DLYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=
=3D3MyfDNSSpgdyktGkBPxMbSTE5f_Zhd1LPfnJpB5RZKj7Y_kz1mNBKHiDRQIcQqVa&s=3D5Al=
gH0WAkrLyi_26gPtB36P6DpYuzhOLhAqWG9JYPUs&e=3D=20
> > > >
> > > > I don't see the discussed deprecation warning change in master,
> > though, so
> > > > I'm guessing it got dropped.
> > >
> > >
> > https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__git.yoctoproject.=
org_cgit.cgi_poky_commit_-3Fid-3D66f22c0bd19a81ee7ccb49543f24a4f90fc012ba&d=
=3DDwIFaQ&c=3D_sEr5x9kUWhuk4_nFwjJtA&r=3DLYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8y=
BP6m6qZZ4njZguQhZhkI_-172IIy1t&m=3D3MyfDNSSpgdyktGkBPxMbSTE5f_Zhd1LPfnJpB5R=
ZKj7Y_kz1mNBKHiDRQIcQqVa&s=3D2DxZLnNctIoF2d_HHDemxGxT74p51rChV-ZLG9bJz84&e=
=3D=20
> > >
> > > Is that code working?
> >
> > I did check and with do_compile[noexec] =3D "0" in the bash recipe, I s=
ee:
> >
> > WARNING: /xxx/meta/recipes-extended/bash/bash_5.1.8.bb: In a future
> > version of BitBake, setting the 'noexec' flag to something other than '=
1'
> > will result in the flag not being set. See YP bug #13808
> >
> > so it does appear to.
> >
>=20
> Yes, I did just try it here as well.  I've been working on dunfell and
> missed it in master
> when I looked through git grep, my apologies.  I guess there's still the
> questions of
> just when the deprecation takes effect and if anything should be done wit=
h
> respect to
> the documentation in the meantime (since it could IMO be argued it's
> incorrect ATM).
>=20

I'd keep that 1 is setting it as this is the expected behavior. I would
add a note that "due to a bug <insert link>, undoing a [noexec] requires to
unset the variable like so: <current way of undoing this varflag>" and
we remove this note once the bug is fixed (can already say we'll forget
but eh :) ).

Cheers,
Quentin

