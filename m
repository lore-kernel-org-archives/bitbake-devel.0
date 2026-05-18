Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4307CD4F3C
	for <webhook@archiver.kernel.org>; Mon, 18 May 2026 10:37:57 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.19])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5691.1779100669285379629
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 May 2026 03:37:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=eqypRJXZ;
 spf=pass (domain: cherry.de, ip: 40.107.159.19, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WczUCSnIg0SWM8FhTvZ5f4iMsjqfbqqZJuqWIB9HH+ycsdg9CAUtR5spkluHWyWWgyszXE+vTeMbYbqOSmACb4D7ap2uz1/FEsnoXw6rUOJcQXXxeRE5tOIft/A18TCHIUwP69bWy/DgjK6yvrDi8rb4fVm2AsXbmFmAygWILUXkxBeMSVSCOWPXLNRkOQ2Obc6QSbt0AH6nmEhCMQcYjfZNLrGgxajMUdFPyOQNceimh8ZjX9qNMVTwojFmgJv96twMe52nM4FPQN1Tcolo3Wx2WME6O/g392HWnWq3AKGfMFWzk7xWurF7JYtsANr7lMiP0kAGTr1jP5Q8Ktlviw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mcws5m0xuCgU+IzS0x7Dgvygow6mcaAy5ok6nsg+Nw=;
 b=DB4uyvQ8m9MuTLiwhgW3CFrg+GzHP73a8BBie8aLa5AxNSI+4gjzPaSWoN6SvgPMdzpApnQu2e5bC+ziycTd+vTvH9mSSbb5Q7p33YlMrXBnnc0dDMEsGrjGMtCq36ny0IUz7S06CDDV9903NmfeWWPepMWjfDjZk/PE95V4FjodCSB3Z5jBBOKa+vWW0WE0r+UW34xKJxQWuZbrRu5xVf2ukf1VSr/LTyFBYjrAtWfrCLjBqOp9stiNp+QWNKEUxzv2rPfVdaKZMS2I31GTcTBgkf0PecSltKlIApXqxXFAdqKKYZPCm+KnWTV6fHql8ISHcTS3dSIAEYgiI7zSeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mcws5m0xuCgU+IzS0x7Dgvygow6mcaAy5ok6nsg+Nw=;
 b=eqypRJXZrlz2WnXR2If32HCrrXLGnbrQ4MCtb3jkh6HP2FlZ9G3YfXBEpTXDFqlpSL2LjyN3zI8IZEErlXyBBXpNYKHp3oQDo179FLizxaLMoZb7jTlLbhUCHb096EAX/RCo8n+jPIxoiXgUmFH1oo9z36n9HdKVsKApn4+41Ic=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by VI1PR04MB7038.eurprd04.prod.outlook.com (2603:10a6:800:12d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 10:37:42 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 10:37:42 +0000
Message-ID: <0a69ffa7-6a98-49bf-b8fe-09a2195226c1@cherry.de>
Date: Mon, 18 May 2026 12:37:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] prserv/Dockerfile: Update to Alpine 3.23
To: Paul Barker <paul@pbarker.dev>, bitbake-devel@lists.openembedded.org
References: <20260518-prserv-v1-1-9625c3239954@pbarker.dev>
 <b3f4a0e2-7ea1-49c4-9825-377b94e3b788@cherry.de>
 <1396d06122a97c5e712b1d15f36c6b841d07187c.camel@pbarker.dev>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <1396d06122a97c5e712b1d15f36c6b841d07187c.camel@pbarker.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VIZP296CA0011.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a1::12) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|VI1PR04MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b83b17e-d672-4609-1d56-08deb4c97dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info: 
	1QXv6H1zXTFvrc3S9MzXWWf+6FYvC3xvXus4ixlhG+kpE87Ts2KyZZ0a7E+X+bqI2a9QPOtMnrr3N89MWIxSsjjSd1xxaYEEY7saBvcZlsTDYw5yr82CSvK+gx2JZPogDI4o9RAqFW1feJSi3jF5CbaYsB35PmnLS/Fm0mw+oyQmHGjY4MIRe9pTObA1Wxt3NzgS7Hd56nPrSl11c+2+jRBzstnFRVDWYpbL1D33di3H1BUDqQFxJeVgg03o2AcgXm5B+uVXMUJGHmk7N27/O76j9RQrHYrhIpNui7yrzyFlUyZ9gLAgamlyEdOaurJkRs5AFPWA+C3nW5fYN/oso+DvpPTZ+MFrLI04dwrKgQwBREr4saE2foiWOnUmpXwMNegQCUge5b+D5Rhas8cyUV4/8rQ1/KlXWixyb93+oAoGTE91ckMLyaBCVFWXNcIt5hlh4Z0ZKz18KWkC6riAWs2Ff9Y4xMg8x90dntgtSjbhe5LEvXK7kqxJG8oBEZRxKgwDKKPnxokiZzxKW7TtkPNV8D8kZDKwJCCqD4XVS65gatbKyWv3hCMFlIh+nv0kwniOR3Nx26N4ocHeZwHEwSoYl9zU0PKXyhgWjRHHBuUNX4ZB2h7TBJJe1SSHtYxu4+/wM5gw7kiPzTKjlPyUFNmX3g//RvZpUC8Gy0V2D8vH6E5XCaE6v5a2Ln0UAeYU
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OPxNZkEyKqzHZZistyKD05rdN7kvLU2CkulySn2qxceZ4xBeMx+lHTMohExZ?=
 =?us-ascii?Q?e4svIZhMvAcbDz4cD/FHiHoZD6fuBoJ2tSmjhX5EvysI9jStKO2h0iJDmnC3?=
 =?us-ascii?Q?p/Lgmw63HbF4Bp6p1sfGWYfAelPyyBqzRBX35oC4fBpdFvW1/h2cpbSRJZwy?=
 =?us-ascii?Q?5WHjOIZD3JMztQVNXOSIc8ahN/ygtJ9F4cWTCycIIwiQQ9zK/NjeT01RQ86o?=
 =?us-ascii?Q?33P5IG5NONh5Ombka2Xzx3BVe9QKh3tS473ZXgiC6nlXpYp8kGxl4LLOW8Mp?=
 =?us-ascii?Q?LoRj+RH4gy4x8elgeXO+KYdxYHTyjSnQgMoYEz6Yre1rPr3IanoZAhDmAoPN?=
 =?us-ascii?Q?WYV5hGj8vGtbcLql2MfNtxnHumP4laBH+tkraE8vWUsTdH6PbdmGbiYpoeJh?=
 =?us-ascii?Q?h2eOKGOtYsfCrggNHjPLZj4T3RWybbs1EPdC5kiKxqI2/5s8SGVTmETqH8KH?=
 =?us-ascii?Q?DR51bBww7ZNeUjwLs9SkaHwPPbvQe21ADrtPGGqKxfEEpJPI/hPFQDCfDMze?=
 =?us-ascii?Q?oiFn4swhvHx9pPUs0B7JLWOpRfDGfLx8Bl1gla0RfBXufjYcXDMY94dDVtav?=
 =?us-ascii?Q?kjAola93rQaPuMwifkBQGRX+fmV3tSiutrQ+FV4aEvdEpReowaFsplKwtvnF?=
 =?us-ascii?Q?NfSCqeMrh3NSmSJLf4v0OKftGH+JwUrnGmCrCEV0IfriLirNaouBGtMRATKX?=
 =?us-ascii?Q?qvobvwGafwLn66+D9QMEmK5nnHALWNJS00CfkW4suhEw3Zk2d1TxPVr3Bn9o?=
 =?us-ascii?Q?gDPRUbjb+g5dTBOB3Q6iqNNoMUpye6NE2SLfNLr1EBQaBPESExGZcskbBBmi?=
 =?us-ascii?Q?gcj4wTdbfKRmGRHQoTafXUtaVFfRX+NFjtqdm/RRb13fUVSbMkD4ff3whtiY?=
 =?us-ascii?Q?jY+bjq4Ek3bAa5HYd+4ZePMVucnl09r3YN80MxvUsX9pWU9xraMZSh9LdK79?=
 =?us-ascii?Q?D5MPgQbQISOhU5Isla5b9V15al1dyspigZTnFZmwmHRCewohzU+Z1QvMp+Hn?=
 =?us-ascii?Q?j7d+9+ODFqDfKtzUfaL5iGL2fVkgMm8bfH5mPITJ5lF6auURGg/fSH50tW2G?=
 =?us-ascii?Q?iDsMHzRTqd9WZJC3SXWoDk/Kx0DL1x/ZrkLa9qs8q3UOHQdunfhS/eflKUM0?=
 =?us-ascii?Q?4rhEChtViFA1nRNAfnfMUxA4gKZ5EC37xAsdbTvnuTq4f1X3sCy2OfKL8r/6?=
 =?us-ascii?Q?NRLGZw3CRByeCe7QYsqIBgpsEtfKzCEzQdnZvkGchwJyp0QeRHoZlPdj1AKd?=
 =?us-ascii?Q?jn0yflFbQ1cIeDazGpAiGnQqUJ37oO4BsB47JBTe6cjhwhsOgu5vCyXnNTjT?=
 =?us-ascii?Q?WJDLHUYgIgA+gaAWBvWLJGnz8uF/IOEM9vgTN8PpqUC7ueL+C9rhJg9lkWQD?=
 =?us-ascii?Q?4wr2ByzQMHhEuSyLV5sl8+oD1w0hukeAE9v9og7aApMnapESmcXs9DhfxKRu?=
 =?us-ascii?Q?fOlL+PLc8IeXRrplUUhujxiYREHb66ucoV5mvMl9P70pDzCa3RGR1rfRuGNp?=
 =?us-ascii?Q?52F9YUdok73FQnXKuKwGMKl3yVFVO1CKW5jxILKgQ+Oq+kEg8hArHB8K+EPB?=
 =?us-ascii?Q?GrchR5WOLCKgJGPdUe2c8Cj5wXWmL04XeVsLDtJyP9C8adZEL5LpPsXQ0X8S?=
 =?us-ascii?Q?wVhw8uGKl5zWxYgZ9kmCmIQOLM+T0EQF644kQGkhwmgPNXYvZhrUsvFIub3d?=
 =?us-ascii?Q?JwHpnVXo/WV7Sl87NYHXRVve77qnOssMi5o3xuLK5pbdNyJSo9svrB/Cdj5k?=
 =?us-ascii?Q?Xdj4+D5/Ag=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b83b17e-d672-4609-1d56-08deb4c97dbf
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 10:37:42.5409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OyXiHBfuOEY8EAuFoTYg8cJzjqDdaOQIiznNeSdUDiM1Fni1B87gbey90oDMfMannwhdDKwjuvyKbk1Nnir7FjoLT6bfyrzCjKS2w93CLUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7038
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 May 2026 10:37:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19537

Hi Paul,

On 5/18/26 12:31 PM, Paul Barker wrote:
> On Mon, 2026-05-18 at 12:28 +0200, Quentin Schulz wrote:
>> Hi Paul,
>>
>> On 5/18/26 11:15 AM, Paul Barker via lists.openembedded.org wrote:
>>> Alpine 3.13 is long obsolete, update to use the current version of
>>> Alpine as our base image
>>>
>>> Signed-off-by: Paul Barker <paul@pbarker.dev>
>>> ---
>>>    contrib/prserv/Dockerfile | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/contrib/prserv/Dockerfile b/contrib/prserv/Dockerfile
>>> index 9585fe3f076c..c630ce99722f 100644
>>> --- a/contrib/prserv/Dockerfile
>>> +++ b/contrib/prserv/Dockerfile
>>> @@ -28,7 +28,7 @@
>>>    # prserv
>>>    #
>>>   =20
>>> -FROM alpine:3.14.4
>>> +FROM alpine:3.23
>>>   =20
>>
>> FYI, these are "tags" but they have the same meaning as in git. They
>> aren't immutable and they actually are very often changed to point to a
>> different layer.
>>
>> e.g. 3.23 currently points at the same layer as 3.23.4, but a month ago
>> it very likely was pointing at 3.23.3.
>>
>> The only way to work around this limitation (if desired) is to use the
>> digest value of the tag as argument, this guarantees that alpine:3.23 is
>> the same from any machine and does not depend on when it was first
>> pulled or whether --pull=3Dalways was passed.
>>
>> I'm not sure this is a necessity here but wanted to bring this up :)
>=20
> Hi Quentin,
>=20
> We do want to pick up the latest updates in the Alpine 3.23 series when
> this container image is built. What we don't want is to automatically
> jump to 3.24 or later without some human review as that may need some
> other changes to be made in the Dockerfile.
>=20

Yup, :latest for sure is a bad idea.

Note that by default docker/podman will not pull a newer image base if=20
there's one available locally already. The pull policy for podman-build=20
by default is missing:

        =E2=80=A2 missing: Only pull the image when it does not exist in th=
e=20
local containers storage.
          Throw an error if no image is found and the pull fails.

You likely want --pull=3Dalways or --pull=3Dnewer.

docker-buildx has a --pull argument (which doesn't accept an argument)=20
to "Always attempt to pull all referenced images" which I'm assuming=20
means the default is the same as podman-build's and passing --pull would=20
be equivalent to podman-build's --pull=3Dalways.

Cheers,
Quentin

