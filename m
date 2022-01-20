Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60883C433EF
	for <webhook@archiver.kernel.org>; Thu, 20 Jan 2022 15:47:29 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.69])
 by mx.groups.io with SMTP id smtpd.web11.13703.1642693646431728784
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Jan 2022 07:47:28 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify"
 header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=QUQHnNlt;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.6.69,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvyBnH9iXNNAV8XY6aLihpLbmC3+OeDsmcC6uDU0BhO5WSxWsHtO+JbH++LINljxbsux/gnURiqDjNkDlVXetdT0ckUcBCt1B3o/rOyJyseUvERKpFZY5loZxxRzI/ocYNXar52k35pE8otbBzqUE+Up9oYQbuDiU8n4YbDbExqfyY1rYERxPAEq7jAL1ruNswjgZVb1NdLqTXnHXsIHWG46Ew9W5a3tfiaYcgjjGofawx4+ie1y8Bnb/qj48W3JgoiNxTwQBBaQH85XdCEmKnXOUjoT26OQHHyml7YBOe92b2cN5a0kU4Q3qwcPbTG1Rqr3p2ZYkBMbRLSG5nRKtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMOkrBzqFFMbvpiQyCoNqOzqpgxRZ4YP3R6/uf5oX9Q=;
 b=mq+SOeARJaA63IqEnIaz9tPV0Mi9oYI4usj5SoigoOp/1VHaVmvgoip/ZrkrbkVHKFPaCXxz0Fu2sTmg+B6dKq//rIgAi+2tqpp/oHdcZ/murTakBG30DXvnrEJB1wQIB6kHEF+0hngDRcZATFc20mfCYgYqFpT+4YU5QGhV5GJWL0l6FzJGwbmGshyWvvxPqZraF9iMLsEMCiseb7b4I5aJcV1AgG5Q5gE3meDPAcGAMIOfEujf8wmnXISUe0rIFvoCRj3NWLJRFTHzQZ8HiJ0uxIASfXsiPdEjBEGJOaKYgwpFU1Fpoe0w+fO8fKR1uZ2FzSsto3fl773BqsBANQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMOkrBzqFFMbvpiQyCoNqOzqpgxRZ4YP3R6/uf5oX9Q=;
 b=QUQHnNlt9vch8Hf2VC8jkOLbPgaexFTzLBC5p4EM/6hayei4RTMI35L7YPECwWghzyYGa9pkHPzlc9RTyzEEo+57x/FJSSKf6GtKPwqpYzLr0lXtc9pNxoz/jZlD2FBLP+U1LSG0ekQsqafTzMjssjQ2L0YOpTmuy9wsxkK9kSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by AS8PR04MB9207.eurprd04.prod.outlook.com (2603:10a6:20b:44e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Thu, 20 Jan
 2022 15:47:24 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::a8e8:87d3:e868:cc93]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::a8e8:87d3:e868:cc93%8]) with mapi id 15.20.4909.008; Thu, 20 Jan 2022
 15:47:24 +0000
Message-ID: <6d0658a8-e7fc-b645-787e-a1d411e8042b@theobroma-systems.com>
Date: Thu, 20 Jan 2022 16:47:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [docs] [bitbake-devel] [PATCH] bitbake-user-manual: add "crate"
 fetcher
Content-Language: en-US
To: Michael Opdenacker <michael.opdenacker@bootlin.com>,
 bitbake-devel@lists.openembedded.org
CC: docs@lists.yoctoproject.org
References: <20220120105438.1212027-1-michael.opdenacker@bootlin.com>
 <24786647-3cd2-d084-cc59-62ffa6cb241e@theobroma-systems.com>
 <d986349f-951e-1530-5514-f89101cb91b4@bootlin.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <d986349f-951e-1530-5514-f89101cb91b4@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VI1PR07CA0208.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::32) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1744711e-e4c9-4be0-58c4-08d9dc2c2701
X-MS-TrafficTypeDiagnostic: AS8PR04MB9207:EE_
X-Microsoft-Antispam-PRVS: 
	<AS8PR04MB9207BAD05C72856BA411ACB8C25A9@AS8PR04MB9207.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HHehb8mCs6DvLV1BFVG+v3Uoc296yMF8e0esKuW24nqyNAfeMcnr7FxySiOKqfRmKOyKM4LcmyIMd+x2B2ux8/GqZI2gTUocuJfo4hFcVP7qXr3fYoDa6aJqYPr/hQeDUxx94xrF2PqsQtD/Esnm4wMkvuI0ncGwA48jBOdOv8RIdd4LAh9ORTwmpbCTk3dmXpHw4+E97S39nq9IlN+Wg72AIBi8WCNtJy5+K53Y/Bi1zmy6kO8lu01GW7lZv/QEgZki7oNLtTrR7DbfM72ZmQfhcGD4uz+B++sQno0k43gfG45fzPl8+uGaKrZaOB+kHiraO1tS8UJoS/7EjvprFcb6AbnjiPXTgv6fOVNA3rZKIXAYzFKHuGc+I7uOA2NCzM7SlQsW0CuDZ08E3TSPXBDOsrRT8RVCpeX4znXZX4om+O+GhMi5Pd48co6R+ry68k2czlJpAdyXfEWlifN1MuqOBRjNPqUJSjuThMH/sV87UuPaBbQzsTZxuyn/tDQJVl86JGPEQrXnvFRJip3tyyYsEPl5we2RyS1N7RUVFNLSKYfTTm/clqGQfbN3k1saInkO7vtfx6gk7TsFHC0gae7BAh5e18xIA4ZsKDAEmEteGyS70jBfxZw3Os/cvQsGi2fR1Z9pkKlvuk+8VXZ7gnnvC0f7AsCsB+HsCq/PhPNG0QOu+SrsWEqkLcgEP9fJwFUcvxLGFyce6Zpg24L90qbeIn7riwffCtNHDYR5TyIMJhdqLdBejthQLL+1e0A/fmzuYerUWLwW3KeN7r431ByVDp13XurAdb/+LwkF7Rwl1jJJG3Vj10+Upusi350R
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(186003)(6486002)(66946007)(966005)(31696002)(8676002)(508600001)(38100700002)(5660300002)(36756003)(86362001)(316002)(4326008)(6512007)(2616005)(31686004)(2906002)(6666004)(44832011)(66476007)(8936002)(66556008)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DfljMkUNc+xitDlNlu8ePOASuV/5Xzz4iIUJD1F9zUKz7xE1e9t0EWP9uLlH?=
 =?us-ascii?Q?1GDWkBkiHMIc0NK/H8XrH06cra5xwwLaSmwajGS77FUqaX/UX44qPC58MD2A?=
 =?us-ascii?Q?PqRBJF8S32NVZVRpDUIJa9bPK1X6z4bF6z9DBE0xoy8+mP6+DpSSbvyBC4FC?=
 =?us-ascii?Q?DPR20ocfc50sC2Si2A3uI+vK+5ooEOZyTY+3Aiz1v0+tCKnWvKDIrBhKXt0j?=
 =?us-ascii?Q?71h/CTvdW8R/818m9vNJkAJJzFXjbRob+e7I056/TeuXuBJdS6DTgYnqPby7?=
 =?us-ascii?Q?DP5r7UafS600T+rLR5lDSK48beVAxkzGB5kzEZtc71/eP/PPFgjl7a7iTD7Y?=
 =?us-ascii?Q?oMeS/k3qaMuHSAY2iyuwyTxffnsa61go6F2TsXc5a/xJTisSyTUQ55KwIHIg?=
 =?us-ascii?Q?BYI0a85EAb2puni3WsIvO3iOPyUJvOAVPNhc4d37pRgJ61Wn7MqfYXoViP2i?=
 =?us-ascii?Q?vvF6N7NDI3iFnWFOdwKkLE0n+hpg9SH4AA21VOYCje5PfafWNlQzyWb3D0LQ?=
 =?us-ascii?Q?S33UShHrjRYiZZtN55ci1J1txqd4Ssxvh8OGgjmK4YsVwn/HEumIIcO2mrYu?=
 =?us-ascii?Q?CiOgo73yRda2iFbwQdYCz+nGQ67WsMJI08rgvA4VDEpIQDmOGx11RrMTuTRf?=
 =?us-ascii?Q?/z/p9W5T0SE/zzBnZ/dhI/yomAPvx75K9r30y29JAcniBNKjiFZdJIAlXqbX?=
 =?us-ascii?Q?OB9B3XvOMYoYJtQyiU060eZUgz4MegwCuwHSWofCRzE9I4K9p8tI5rvqpeLU?=
 =?us-ascii?Q?5HxoYTxz9M6NmsWuL8tMVgHBDkzAouvvxzr7wk3+XKsjTRB0LO06O4053txZ?=
 =?us-ascii?Q?LnzFBetLPuo3I61EjgMqRBgNN692Fbt3orNU1Gm3rlkDuyEhRlrQFEnvMT1L?=
 =?us-ascii?Q?Y2I8IyUYxQJtus9L/496hOHU4oZ9r/51UuFz4fJXieV/Mslphnax50xpAZof?=
 =?us-ascii?Q?1qWEVIoBKVrZuND2ml1JBy1zOUfqU4kiq65cQ9NHSWUooaSrQGbWYsozS75n?=
 =?us-ascii?Q?SL1fKtI7RbNUFzD4ysLedXv+MfT7Vo9dv5t/rezIWsX/CS4kGe2z0piCnbeQ?=
 =?us-ascii?Q?bY1w2C1UDz3vgot79rIEqlD99kuRNpfRBQRqAJ4tZYCQk0YJgIq/WL4jm9/H?=
 =?us-ascii?Q?0cLRy1bMkS0gFrCWqTyesVmI4S0SuG0Gqp+qN+XM1VpI0oNedqMJnwsycOUy?=
 =?us-ascii?Q?N+swhG7QwEvqPnJD+0eWEiEcjz0QdMw+oFXOwIs82puNVhI55+t9Ku5USeYq?=
 =?us-ascii?Q?18GMrext8x8igAqH85zp62vAt7/xc4TxoC2KIusoQGcBf3XF8S3jU21iKZru?=
 =?us-ascii?Q?dTL2cbjdAQHEwiJG/e/N6LuwIuIqx1ZrFwV/PPv/YxY+7lqLgn/bTAoOe1J+?=
 =?us-ascii?Q?cgDNjs6jgn8QepKig7GxbRcKki9HfzibUxpNvzSJ18Do1Aw7Ogx8Xn1XyIol?=
 =?us-ascii?Q?Ym+wtM3xL3rdJPAdp4URZJoaytxKGYcO88wSIuXezbUUUAduu9iFAuJ9e8Ux?=
 =?us-ascii?Q?6fBSgSsG6VV1Mm2Le8b2rH50JF3WAvovk8hNSfhg5jqDS/QK+Oc1jGZqjYER?=
 =?us-ascii?Q?7S7Evy8Lx+wpXIJL1lJj8tzJyblcdRmjf58tn3Eg966ZR7TlCTgzoGkJyo/k?=
 =?us-ascii?Q?YsBMxYt8P5ykMLmEFGdnIe/HUvz/zkPLVhQ8N2XqmKdSs628uvpnU5lU1tdd?=
 =?us-ascii?Q?sjj/EPIW+XZtR1EFSYXaS2A0PrtvhsJpqcYb/Aj4hlbmtPDGbBMNsByntC7i?=
 =?us-ascii?Q?J0AYeC2TqtmfzYzNqxX2+zFRRRnY4QQ=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1744711e-e4c9-4be0-58c4-08d9dc2c2701
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 15:47:24.2113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 ulmtuWSuJQHo4+W90pIzIcMyrQrJlrlL6mjlB3nszuDcYM90V/axgWxHnMnj7GLhenHEZDIiuK3lJgp8Iw6Ah2/1JcqnH2U+Efj1Wc40+dkY0eVxcCOd3Q7TQmC0uSrw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9207
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Jan 2022 15:47:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13259

Hi Michael,

On 1/20/22 16:41, Michael Opdenacker wrote:
> Hi Quentin,
>=20
> On 1/20/22 2:55 PM, Quentin Schulz wrote:
>> Hi Michael,
>>
>> On 1/20/22 11:54, Michael Opdenacker wrote:
>>> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>> ---
>>>  =C2=A0 ...itbake-user-manual-add-crate-fetcher.patch | 40 ++++++++++++=
+++++++
>>
>> This file shouldn't have made it to the patch :)
>=20
>=20
> Oops, I sent an incorrect patch file, indeed. My apologies!
>=20
>>
>> s/fetchers/fetcher/
>=20
>=20
> Thanks. Actually, this would have already been fixed if I had used the
> correct version.
>=20
>> Nitpick: above you say "fetcher supports other servers" and here you
>> mention "HOST", maybe we can write SERVER instead? or what is the
>> proper rustlang term?
>=20
> Well, I followed the comments in the fetcher code. Not being able to
> find rustlang specifications about this, I propose to say "other server
> hosts" for a little more clarity.
>=20

Seems like they call it "registry", c.f.=20
https://doc.rust-lang.org/cargo/reference/registries.html#registries

I can suggest "other crate registries" and "crate://REGISTRY/NAME/..." ?

Cheers,
Quentin

