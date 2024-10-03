Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698CECF856D
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 08:18:22 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.92.89.37])
 by mx.groups.io with SMTP id smtpd.web10.6457.1727943492898978403
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Oct 2024 01:18:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@outlook.com header.s=selector1 header.b=Dg5048rS;
 spf=pass (domain: outlook.com, ip: 40.92.89.37, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WFnetz4qRdyOIVrULSvvZqT7+/sao60MvWxhI8iHXF4gqhSF0GB0CL/0yfM+NA3N2LFYbdLJdNL7RfuCn+ErAg6TJA17qt3ioygGMy3Xp2d/dbl4bd8vQEG/+yhAyUTVv1WTE2BFGiWa0+ahNJZalDtVsPk2gHEGPmD4OGQwGWZan4kz4OP2tJ0sT4YSd7FIgZmlTSZGOKnV1RbGelB0pUQcKZa8bOwoftrrcKIlA9BWDfC9QDjiP8AqoK4kp15D1LlJFhwtelaFXC67fG+BC2sfVL5HLf7xZnB4wMNTY6OHNn8RRUvdm/TazQwQyPlVvkKXNcZq877AT8HCfSOAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6geLH6wIHRDJ+M3tGumgMOcek6rEjOVg7IiZ0Q6xZY=;
 b=MUa0GXA16haC2F1vl7dGjPizJGn/HzX1q6pz2wIn9zJfIG654+qYYL+qHcJgtWvIiBMETmhFG5tvfmrEUUpTYzcbI9BBReayTrJPTaRqP9t3pMFwZxUBachGcMvSkS+1Hm/Pb3ghCk6zFaNrKtu+Bn+oTWM0ihqDc6qsdAwxWQl/a8DpHqLHrQlAaCnclFQ5Ikxm1E2e3JPRNYn35PgnX9CUqNG4aEj6XFtiNTnpQiZ4Guzb29qZqPCd9845dhbMNXJVQtT73voAhdF7/cG6M/KRDQj3jgs6++waSpKnDqlJPsjxTXB2AQW6kqqX+uHBPh9jIt9RCm3dVRAwBNgqFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6geLH6wIHRDJ+M3tGumgMOcek6rEjOVg7IiZ0Q6xZY=;
 b=Dg5048rSmZ4fSeFxpwCnmzSmRiYcFRRQSbv9WZ3h45523ntZKUz1z37o8RtjlKfxE8He+g0Q4fVGtqV6eUl/mWDQlkm/QjJALviKzFhaSRRKu6vnjphQU7MfExWv6dgxdjrnTE5oD6IxjTvgyi2ZNaZsjVZzKcBf0I86iUYhNV1JsByC0DQDs+v24QU4i3vtB/j2i7N2YuaBWeQwM8JkeWBpa2sSSUkViRe59wNXXhDdLlSkrxFs7FRwimgMnFESAMCEuQz7vAS1VnsjnWDnnZW6mjJSByoFBwb9ngHQ8uwzN0a/KeFOzsQfDnw9oXHkgEc45LmJv0eTEtV07TvFwQ==
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com (2603:10a6:150:80::7)
 by AM0PR07MB6242.eurprd07.prod.outlook.com (2603:10a6:20b:152::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Thu, 3 Oct
 2024 08:18:09 +0000
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a]) by GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a%6]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 08:18:09 +0000
Message-ID: <GV1PR07MB9120BCEECD7A2BD204CF72A7A8712@GV1PR07MB9120.eurprd07.prod.outlook.com>
Date: Thu, 3 Oct 2024 10:18:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v3 2/3] bb/data_smart: fix override syntax
 warning
To: Quentin Schulz <quentin.schulz@cherry.de>,
 bitbake-devel@lists.openembedded.org
References: <GV1PR07MB91208FE4BD9DE31DFD4A7318A8742@GV1PR07MB9120.eurprd07.prod.outlook.com>
 <e6694732a1e929e0a33aeba62713433019ea1dc4.camel@linuxfoundation.org>
 <GV1PR07MB91202E0541450DC69A204E4FA8762@GV1PR07MB9120.eurprd07.prod.outlook.com>
 <342c2498-9580-4692-b5b2-1e3c3779d6ba@cherry.de>
Content-Language: en-US
CC: Richard Purdie <richard.purdie@linuxfoundation.org>
From: Konrad Weihmann <kweihmann@outlook.com>
In-Reply-To: <342c2498-9580-4692-b5b2-1e3c3779d6ba@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0202.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:89::18) To GV1PR07MB9120.eurprd07.prod.outlook.com
 (2603:10a6:150:80::7)
X-Microsoft-Original-Message-ID: <de93c127-dfeb-41bf-9fb4-b26d8576fedc@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9120:EE_|AM0PR07MB6242:EE_
X-MS-Office365-Filtering-Correlation-Id: aac68509-b2d5-45d8-ad23-08dce383ea47
X-MS-Exchange-SLBlob-MailProps: 
	AlkLxVwsndl3hkarQgdS299TQjAKjdZaQdsbzoz3SiKGSJjMXMUNt8Y3Xoic/Z0pc/3H/9V87X8EoNWJZssKlqNnXc0zAyzZb7PcN5W2c9ew9YEJyhSn2A8ERqpsf6xgRk5ZzaF2uy/871MCj7JMcFDfTWw8rp1LlVlOhtnimrZ4H3W5CuonwkGgnIyW4j0OTB95pN0vma4XpzuNrbINP5roUCanNt0TTtnni9c9PaDjrc/TihUHR3Ov8m48QoYDbBrdA7qy4ZOP5P0L1QgbrCRlvBCOqNtVI801ROdcg0KSx4+p5Zb160LUfpWQMydIZnZ1fZzHYJkpXKDUZq1b4S2dBC0EplX12uJHl8p9qhdpF5oLYyALaEzP1dvLxTdh57Y9bfeNNQLzVN7U0SfA8lcJa8N1GhK9QCOhp2OOxhNcf6C3wetjCvTvt6KgIzk3YHJYkBLCKHOPZuGwcUpGO4k2Xt5T/EIMJ+xSfQDzzArBtnqVvJfTFtlSZNbZivbn1Y6UnLsMkppWVvikGJwL9VrwAvrG5mEtoPXlHsMnGP94Eg2Q63B3xzSHj6pMCKkYHqzWB5vnHogAoLrFnZqu8PS2/EahOBxcyNzYU4GddjfeZdnnLaF8mZ8HLcBM5lD3wT2Idf768TonlflKDIGxvKJmdUYGLhlEGcUlKS7jJxotfxLNOy8YdhitOJgKNnIX7hgpsk00gM47VbOjQ/ql3TGwe7sMWOqK4x1oYpJR7ZuFsQsKVcrMKFPFYf2OIU2pJx+Mz67DJ9fR/zbcxcP7aoSkYXuoLwK1
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|7092599003|15080799006|19110799003|6090799003|461199028|8060799006|5072599009|1602099012|10035399004|440099028|3412199025|4302099013;
X-Microsoft-Antispam-Message-Info: 
	yCGYT1Jt4/xOa8vfr1dssUde32iW8coOf/LZqfPkd7Kz11eufsbxICVtJPR853V9dHh3iZwiLcmOKeJMzd0Btnn6eK5KC/V4VtRNIohhAPvHI9H1/vLjm426TzPHOKCiuRVW/mTXuzgKT0t7jeo37acHfASTYHv4/57GpCc9qSthLZRIe6FSjvN6o8ABAFeNjlXn53Fj9KOgMluEegRcQt6uAXhcMlGPfYUqz4KWhM2cC/9/Jp6+gv05Z7AshJXPyN3NOZEQDD/VQkpMFCuFfkvsrqrQlxmi0O+WhVM3N62l+vcxn7kQN/BxOsE225NNE00Wc0VwUq+qoQ1gFU8eOVP8Qe/QBFGBGl6j0NO6iZRZvbZUytvPz4ow80atzYi4QMmQ3JOyRjOQYDo4ftJDLyzPclQv0+EbqH5rAvolEPdEPmAacmWQQgnZv8J/MdjB3reeX2ZQnYk6MtKuY+r3xtZwAXafuAM4ZiW21LiXXDlouJGsLU6h9DI7uEDWwe7SB1oJPF/ciFiUVRqHulrbVIBSeLrKbTfef76wB3Iw9b1Y1E3Df/Ex8KWizKUuOMlZhFcq9HARE1h3ZFX+P4FGLYB0bF3GnmwBKCLgM8e6UPWSWmObXQUWO5bWost5ED2aI95PxsA47CAHuHW4BbJNoxWRv8XuIOh/V/kRpmfdE5wJGvNX4WsOI+xFarTPr65mHWdpFr+RA7gjL3lcUp9wDqY1/sHDRZv4cDK79THr4T5GWkBbQnvTJG+tB0sRZsNdYHGetjyyyQHdqc6O/7YCklFbazINYyLGZkSYObpMcjLxJYzS3mTIiBAPUpMIvMFn7PTqpT/UEJAmnouHOC6DGkF2M4lxGPyXdSi6F90QkttdSPj9+0jpEtDK/XySpSGnM2Dd71f9IC4QlrITtgHTvtyEzYwFfEvnSf6MhlZnGFwZy7aehm18UuCOY5WqCWeoGrnySxL9Tyd//XMhh05BoA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?H69zAgnViJ9LrgdsJU5i3JX9NErotBrH84xu2pxwfIp0DDfrBxNMbVJ3TZYS?=
 =?us-ascii?Q?UTpwZ+Nxt2lM0Xus0tM7Hya+VWoFLOjKLRgmFoBP2N/kOVsYWdDpM4MCTTLl?=
 =?us-ascii?Q?oXlXAbCm2tTCio5RNql0mrw1orm5gt6VAYWETEi2B2eM8QEf6yqgy+Vr8YtW?=
 =?us-ascii?Q?MNz5vbAfDzD5XXumV/PFqLs8gwjZmLbC3zVyjZ/ZEBTvXrIFnV+PW3dSbS2I?=
 =?us-ascii?Q?FF3uzLgyHaULiVozn5HzqYyO9a6d3oSxLPNdYj66ekMUDwiEHpJA7TXmsdSV?=
 =?us-ascii?Q?7naoBF/iXgQN+TSOccRDL838AEz/A6eVX7GSQavCaCSmuR2daZRNTaC2kj07?=
 =?us-ascii?Q?2vlrHb0OnebNpk5KF9kiI0AxJMKyMXa6gjYDOQX4zZZuyTX8uM3avLLUW1HD?=
 =?us-ascii?Q?sXoSFdIA/8uTnCZErS3if72kjWkNnQBZXX++2WOd7MMrVAJnmZJqNn3gytbu?=
 =?us-ascii?Q?rp0wW+I+vC66knrWx9NNHQ4HnGVEsZ1iyctYL0vYG3LKD80Tr4fw91TuIcvV?=
 =?us-ascii?Q?H2Q3Jtz/J2ppST52+RUh53KiLjdSnyt/n15VvoJUCMRHYZKQ58R/7MsEollK?=
 =?us-ascii?Q?uVdqgsxYJivip7QTMnfsh/SlekL6bGA1yHYx/Xfc/5XvASUgykUk94T8lJ33?=
 =?us-ascii?Q?FMWMSDm22CscWtqnzmqzERUWKYQYdXJ+SjS4tkbpzimGj8dpi4LTJCyCW7J6?=
 =?us-ascii?Q?6KVJoqK/+KwLSEMmLi/oUCnrUB/Qk53K0Gd/6MnDBy4UYV9Lrr+r1T+PlVKK?=
 =?us-ascii?Q?G5XAJh2Oo3TA/Lfn0XNapTwqfOdAShP8O7IjvFv7IPCbDwmmYFvBxgOIDRTX?=
 =?us-ascii?Q?vCAZTyRr8pnf7O9Lho46C9URehCUIK2yT44m1wzLWclD2WPl3CRtKtaLIyMP?=
 =?us-ascii?Q?fyF8mLrVtVdSxN46GI+eppjrOnWfAbCwJnXccUqNFI6FBSjQv165x2JkcXHL?=
 =?us-ascii?Q?1LRmtS2EK/Ng/aEIlEmaYIqnzgqF1iaFYC0/8kVdCHYRNwVagU1grOqt+1Fq?=
 =?us-ascii?Q?MZvr1HUDAU9Csu2ad3tO17HxV/Jq0e3XDEaPuZnR2MbDRqwi3fJWqZ4I6U09?=
 =?us-ascii?Q?Jb2A2Ig35PgJtQL/IkgPYaWi+ygLNlYSUYLvWP2zJ5IbvcjYqMfzVdBTeoLR?=
 =?us-ascii?Q?SVk13x6vghiE+AZlqXREXQm8+kYpGffoWiZexfJUY3ChSBwjVA8a805VFYfX?=
 =?us-ascii?Q?AbK0kuuhpkbAIgBsCAsqCcEf88SGd/Fp1ZzgQvOaY9qiVmTCK2tR6Byl48t0?=
 =?us-ascii?Q?T52TCX5WwL4cZaVVRwi6c/ODf6EW7EYgb7MSq98PtUDLKjAfhXh/XZFlCSNY?=
 =?us-ascii?Q?+Tk=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac68509-b2d5-45d8-ad23-08dce383ea47
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9120.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 08:18:09.2336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6242
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Oct 2024 08:18:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16630



On 30.09.24 13:19, Quentin Schulz wrote:
> Hi Konrad,
>=20
> On 9/30/24 1:13 PM, Konrad Weihmann via lists.openembedded.org wrote:
>>
>>
>> On 30.09.24 11:13, Richard Purdie wrote:
>>> On Sat, 2024-09-28 at 09:00 +0200, Konrad Weihmann via
>>> lists.openembedded.org wrote:
>>>> when defining a function do_removesomething,
>>>> the parser warned about
>>>>
>>>> Variable do_removesomething contains an operation using the
>>>> old override syntax. Please convert this layer/metadata before
>>>> attempting to use with a newer bitbake
>>>>
>>>> correct it would be to search for a override operator at the end
>>>> of the string or for the next operator.
>>>>
>>>> To avoid running the expensive regex search on every setVar call
>>>> the current "cheap" check would be have to be triggered,
>>>> before the more precise check is run.
>>>>
>>>> Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
>>>> ---
>>>> =C2=A0=C2=A0 lib/bb/data_smart.py | 14 +++++++-------
>>>> =C2=A0=C2=A0 1 file changed, 7 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
>>>> index 4e15a43c2..0523744de 100644
>>>> --- a/lib/bb/data_smart.py
>>>> +++ b/lib/bb/data_smart.py
>>>> @@ -539,14 +539,14 @@ class DataSmart(MutableMapping):
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return va=
r in self.overridedata
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def setVar(self, var, value=
, **loginfo):
>>>> -
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not va=
r.startswith("__anon_") and ("_append" in var or
>>>> "_prepend" in var or "_remove" in var):
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 in=
fo =3D "%s" % var
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 "file" in loginfo:
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 info +=3D " file: %s" % loginfo["file"]
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 "line" in loginfo:
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 info +=3D " line: %s" % loginfo["line"]
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb=
.fatal("Variable %s contains an operation using the
>>>> old
>>>> override syntax. Please convert this layer/metadata before attempting
>>>> to
>>>> use with a newer bitbake." % info)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 re.search(r"(_append|_prepend|_remove)(_|$)", var) is
>>>> not None:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 info =3D "%s" % var
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if "file" in loginfo:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info +=3D " file: %s" % login=
fo["file"]
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if "line" in loginfo:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info +=3D " line: %s" % login=
fo["line"]
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bb.fatal("Variable %s contains an operation using
>>>> the
>>>> old override syntax. Please convert this layer/metadata before
>>>> attempting to use with a newer bitbake." % info)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sho=
rtvar =3D var.split(":", 1)[0]
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if shortv=
ar in self._var_renames:
>>>
>>> The patch appears line wrapped unfortunately (it appears as quoted
>>> above).
>>
>> O_O - okay that might have been my mail client.
>> Ever since Microsoft decided to drop plain TLS access to SMTP, I don't h=
ave any other way of contributing any kind of patches, but to pipe them int=
o a client that supports oauth :-(.
>> (P.s. before anyone jumps in gmail is not an option for me ;-) )
>>
>=20
> bitbake-devel is available on lore.kernel.org so you should be able to se=
nd patches via the web endpoint, c.f. https://b4.docs.kernel.org/en/latest/=
contributor/send.html#web-endpoint (I have not used it this setup, as I use=
 my personal mail address for sending patches because I got tired of MS and=
 my IT deciding what's best for me :) ).

Looks promising, but I couldn't get it to work for now.
Also I read of the limitation that the web endpoint applies only for projec=
ts hosted on kernel.org, not sure if that is the case for openembedded proj=
ects.

If there is a _b4_submit endpoint available, this might be worth documentin=
g in the contributors guide.
I saw various projects starting to add .b4-config files to their repos, may=
be that's the way to go.

>=20
>>>
>>> Also, I would still prefer a pre-compiled regex. I appreciate python
>>> just have a last used cache but I'd prefer not to rely on python's
>>> implementation details which can and do change.
>>
>> Wouldn't that have an overall penalty on the runtime behavior (I know it=
's only once)?
>> With this inline expression, it would actually only be applicable on the=
 pattern in question, so for an already converted layer set it runtime pena=
lty is +/- 0, while with the precompiled expression we would add something =
on top for all users.
>> Just want to make sure that is would be acceptable for you, as my unders=
tanding was that any penalty should be avoided
>>
>=20
> We could have a regex that is precompiled in the if condition so that the=
 penalty only happens if we go into that code path at least once? (I initia=
lly only wanted to provide another way of contribution but I guess I can al=
so chime in here).
>=20
> Cheers,
> Quentin

