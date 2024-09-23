Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8301FCF9C6F
	for <webhook@archiver.kernel.org>; Mon, 23 Sep 2024 07:30:31 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.92.50.13])
 by mx.groups.io with SMTP id smtpd.web11.31135.1727076625434858393
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Sep 2024 00:30:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@outlook.com header.s=selector1 header.b=LzIvElDY;
 spf=pass (domain: outlook.com, ip: 40.92.50.13, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzDMPWqiGAY9zT/Q9H9KgJmReSZCxI8Q93hqabqmRZuSTqTv3ZfbjZqaDXsBWYUegw2r/TH/VPo+Dqt03ZT5OAhfXBJj3jd7Pv5ApJRYIaLgMM5BfQvWKdyp2M0lMBeeJN/MMuZ/XBV7hjkDvTCvzemtYK67sARn7gfjaZBxEwb8a66JF+dz2NCuU7BGafsyuLKtXP9cKkRvZ0B2n1eYNfv5CDnOyQOuwr6xn2BejIMRvvSB7Apftf6hymhbJYaZn1hQgoKjNWoMrI0lVWVVZQ5NvNYvoevwLm9HQgfQ/Yo2e8nQyTEivNn0QYFCu2+aFInsZ0hbJOArF31PK/s/wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKPfKMZAuk/GeIbWbf5UT+BW6nnA047PgMbGDWJjm9o=;
 b=Onwt4w69I8zRNTWQBsMBIECIi21dnHsivQtnqhibkvugXDVYs63uN+oZ1aXLu2fYYYQwi+JqcF/8qiURaqlXqs/5ejn5HEIrq9jl/btEQyzE0qBA2Y8jwB1Tf68d7zHHuMDOsDtMYV1JGQXhey4Cbryh6P/DIhrHGlzDuGm5fxe1cEvumdopzNUXcsk2R97dmPg5dHf/YT1ulCgtRrw1GCmRTmGdsO1HqMxFUcSrnsVjPndXrK27ewKIpUPIqaeMzGuVm9BktPAyM3n+uvHoMWfnIQ18+rfQzj3p6FqAMBoKwon4sGnSIdSxCNSsT0SVzEHKcQ0UXhiWAChwJejGtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKPfKMZAuk/GeIbWbf5UT+BW6nnA047PgMbGDWJjm9o=;
 b=LzIvElDYs+I1ydsG7mxZSD+gUKuUkjgrX8KdecBuwoOTkEgUKk0OJju1Tr6w09zBMA9FDdnzp6veRGqhkmScN8J4WhOgzbeBzH3NcZ+iLOJ4tqg1Ks9gp8jJRZZraGrTYOYStBe7Wa3Y62bNd8qkVt/NXKPiFqC0Fua6OMKTfH68TQT5L4iJbScWrT3d4s2ov+OZUfmn7YhbZUt4lQcn8OjqEQ4ru171PiWm5Ift28DYQkYEWfCYk6/A5d3cZrE6I245khj4Jphn+pjkV5R0vNlDiYbhLOizwNF0XG6JmqiejBtOHMitjPGPnsJUqwhVgnyqb3MTLiEE3y4w0hJb0A==
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com (2603:10a6:150:80::7)
 by VI1PR0701MB6749.eurprd07.prod.outlook.com (2603:10a6:800:195::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 07:30:22 +0000
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a]) by GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a%6]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 07:30:21 +0000
Message-ID: <GV1PR07MB91204368C096EDEF0107B58CA86F2@GV1PR07MB9120.eurprd07.prod.outlook.com>
Date: Mon, 23 Sep 2024 09:30:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 2/3] bb/data_smart: fix override syntax
 warning
To: Martin Jansa <martin.jansa@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>
CC: bitbake-devel@lists.openembedded.org
References: <GV1PR07MB91206C44D7FEA544DE6D6374A86D2@GV1PR07MB9120.eurprd07.prod.outlook.com>
 <1497c21f2add634469d205a55a155324f0e0bfab.camel@linuxfoundation.org>
 <DU0PR07MB9116AA51410D7EBC4F8982CAA86E2@DU0PR07MB9116.eurprd07.prod.outlook.com>
 <CA+chaQe3DCAxuvORYFrn4sr+0pUyrPR+oLrXkjor56+7XVaraw@mail.gmail.com>
Content-Language: en-US
From: Konrad Weihmann <kweihmann@outlook.com>
In-Reply-To: <CA+chaQe3DCAxuvORYFrn4sr+0pUyrPR+oLrXkjor56+7XVaraw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0133.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::16) To GV1PR07MB9120.eurprd07.prod.outlook.com
 (2603:10a6:150:80::7)
X-Microsoft-Original-Message-ID: <d48362e0-84e8-4733-86ef-1ef18d6209f7@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9120:EE_|VI1PR0701MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f28d8b1-7da6-4a5c-04b0-08dcdba194d8
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|461199028|19110799003|8060799006|5072599009|6090799003|15080799006|7092599003|440099028|4302099013|3412199025|10035399004|56899033|1602099012;
X-Microsoft-Antispam-Message-Info: 
	cXirb6nhgJIC/0Hz1RCYMDa0NeKn5dZSLiclltqg+Q/WJc66s3m23FINGA7VnFtm/HZb8jIxer9K4nL+Hm+jStN4zF+2obdl01Bs2pSaeAhIpCvndV30sJ3Jmf5JxF1T2ZFvoTBdZSKZl/6YRqvdb5lzGHbN7MGSXZnwiJpD1WtFh8Q3rZJz5sX48pVV0S9fsSM/nFsMLfn/1gOANg6j/7RGZsz7t2l/sHP0MAIeQuQn9wFjv+EF88y5GRKJ/gYhfiSSr8W2pf2U4mEBBT+JrtX7lZSLV90dbVz++50Z/TbAWdEUtpdDLWuvktwC/Ox/01kuwvfftS5qixjuaIS+K1+Gpiz6sWmSYLLOfyXvaZm+Itux/N80fJXZkbwqVEGNHai3fNmnJlVN0nm2tFuOuNeJHKJNrBgo5V/zKUgq5J/S5R+Oe/XJRc2w30i6LnS1O1xwKY46gWbaVIVsr5d74KmvaVHE+pS/h7XHvrMfoDao+lEEKPkEY8cNk//iLLHVHgBepIZqnvnnTCKlzGMjl+HoBjsy475glJIgUFdBWM8D0P8tlGq9VCmVI11/kBfZc6wVYI3g15eyMmUZv5fwc5wkLpyjSnJsfSqeIN3+MX3SyTI19QHdUavnVLirRFpFuIzx70xL9kkXS8iADwCXsT/YfyBm2sZLY/n9WKl36qSOHo2RNclt62EkL8XpI38CB5txraPdqczBm3hYGMie/oLbLdLmCBkLf/Ldlc96/RvHEPoKyYQDwrmq+PVshxaj50bU7uLPln3ah1f3u7hmBCsg5GjxgE8negCKUiAoHbuu35K8DrFqaQFiGYEaMslSCJQlEdl1+oa5jYkHotSKLy6jK/XIMtkUrsuNY15wJsIpBKQ24lIPwXnEoS6f4T/eHuASwC6bqbDf91gjwOs9w6YfT6fbKbMiedLElJFwfJs=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NgC+Ts9lN04zerLfhaQwPakkSbGNlc1/UFeKDgQ313p9YS9XkyJLqhpPqUrt?=
 =?us-ascii?Q?YybMdOVAo+hAcnG0c5IMFM1O9ix8oGlCubiWaLL+EhbCM3EurfYWMko8W8C6?=
 =?us-ascii?Q?f2alakOWMHQio6Ef721UYEBLK0SzUj04wRvbwP0EvkdcTnMQNz0sKSAdQ+GQ?=
 =?us-ascii?Q?kQmHPn7feZNPed5/yD2Ca3z5sDTFghTnSQJhPMLkX6pwChuTPa2b4jQfCQRS?=
 =?us-ascii?Q?3WLacne8PuE8LxVBtesccDDWgSuRh9PytcqIQ1HaseL2rTgz6Cp108SD6ilA?=
 =?us-ascii?Q?UA75FrglPJu2J6skdVERDJ1UsvrHRsDeoYnQJ+jAJXQms5pzJiC9xNLIWqFe?=
 =?us-ascii?Q?pswXt1tfOFLSbRf9akbP2beKpnFil5kAt+AqD/pkavXAoda5D6I5dZR4gGvs?=
 =?us-ascii?Q?/HiBOdK0uPSZTr0mIZKjQnET39QnBBLQ1ZTedscrAngZ2V8+CexoDCJ6K/67?=
 =?us-ascii?Q?FsdtpXd/rElsfofrcs81Rfc+IKITuAhyMPiOHk+8kQdIrAIESMRdYb6aq31o?=
 =?us-ascii?Q?qdX5OSfIJCGtQfz5q+u51mgMVvlURCovMfP+fsN6YIvuZ8qcOsMaQh+sMobW?=
 =?us-ascii?Q?ebLmgqJ/kp2N54lgBoFzR5p1GotW6XB8nOt3hcSFtqnRxBrchKkTz+FCz+P8?=
 =?us-ascii?Q?S/y99PWQYTlC6dKfEaYvDcRmw8hROdTVAuUWd4tK1w4/h2QKJ9y7ZtUgG6Mf?=
 =?us-ascii?Q?2cP/6stAqxdPhJIWLMwTIwZYsrfS7oWJ4xfsE3Reu3uRxsENIkNgXSFTZmBP?=
 =?us-ascii?Q?eHQF7yCJZfnOF7a1B1d57ula0urv2CRP2lFwfQv3Hwzi2RUQ62hqlkVNTO3u?=
 =?us-ascii?Q?0opLxCtGPB3XklWaRAOPp+eOuu+V6wxGFNBC5Csvb5LNxdm0UwnkSxC55Fj/?=
 =?us-ascii?Q?n1DA/G5OGppxPF5LgGcnVqrp7HYSKF5X3RGz7xzAI5pkZvyMOao/NONE6K4f?=
 =?us-ascii?Q?gKHxzaCrS4PZyERAeJx4QtY5yuzDNUkWu8YUuYIy2OIhrGFNEpR5aEBpaZdn?=
 =?us-ascii?Q?Cpx1z+9DD/WoZjY17l+0mvt6WXddvYtrIPEt2TSXDTUWOjEYES8e28Wvx27v?=
 =?us-ascii?Q?G946h6cidR/mMERUti+hhUIPRwJX/f5ii6qyWXc+4Z9HBZaLnbdo5C5PsWFN?=
 =?us-ascii?Q?l3Tgm37zd8yWwkQODj5yinfUA0Ad0u/LskCjz/fZc78N4Gy/+I5TLT+VN9VQ?=
 =?us-ascii?Q?W/NgcM2iM3E/QtMU+on8C88lzrb7q5Ecg7GkxXBXQappbUujkbm+FSwhfrje?=
 =?us-ascii?Q?ia7Ndj5gPgrkMr+m9h0e4jXWPEPkG6UVf6pXRSmrZAR/nhdlA4NDIPlylqNm?=
 =?us-ascii?Q?Zkk=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f28d8b1-7da6-4a5c-04b0-08dcdba194d8
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9120.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 07:30:21.6685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6749
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Sep 2024 07:30:31 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16586



On 22.09.24 11:27, Martin Jansa wrote:
> What about using precompiled re only in cases where the old "in" is
> triggered already?

Also acceptable for me - anything that makes the check less opaque.

@Richard please let me know how we could proceed from here.

My personal take, after digging into all the side effects, would be to=20
remove the check and treat all "old syntax" overrides as merely "typos",=20
hence letting them slip into the datasmart store, but adding a=20
(potentially warning level) note that a certain operation is using the=20
old syntax and therefore not being applicable in the current context.
(unless ofc there is some code path that does some bad things to the=20
store when using the old syntax, which haven't come across after looking=20
at the code)

>=20
> On Sun, Sep 22, 2024 at 10:48=E2=80=AFAM Konrad Weihmann via
> lists.openembedded.org <kweihmann=3Doutlook.com@lists.openembedded.org>
> wrote:
>>
>>
>> On 22.09.24 00:15, Richard Purdie wrote:
>>> On Sat, 2024-09-21 at 22:43 +0200, Konrad Weihmann wrote:
>>>> Richard, this is in my opinion wrong.
>>>
>>> Noted.
>>>
>>>> It's preventing, for no reason, valid tasks.
>>>> I agree that it's an expensive operation (potentially requiring to
>>>> making it precompiled), but I honestly don't follow your take that
>>>> this will be of any significance when taking a full (ordinary) build
>>>> into account - the penalty of the operation is in a millisecond range
>>>> while a typical task/image build is more considered within a minute
>>>> range.
>>>> If that "penalty" is unacceptable I at least would expect the
>>>> documentation to explicitly name this limitation (currently I don't
>>>> see that anywhere).
>>>
>>> The penalty I worry about is against parse time. That *is* a serious
>>> concern for usability. Lots of small changes like this mount up. I
>>> happen to know (as someone who as done a lot of performance and
>>> profiling work against bitbake) that setVar is on the hot path.
>>>
>>>> So either way we would require a change, it's just unclear to me
>>>> what's the consensus in the community.
>>>
>>> No, we don't *require* a change. You're asking for a change, I'm saying
>>> I don't think it is good for the performance penalty vs the gain.
>>>
>>>> My take would be to prefer precision over performance - not sure how
>>>> others think about it.
>>>>
>>>> Side note: the original patch never got any selftests, which just
>>>> kept hiding the problem IMO
>>>
>>> FWIW nothing is requiring you to have tasks named like that.
>>
>> I find it troublesome that a generic build system doesn't mention that
>> as reserved keyword/pattern - esp as the printed hint isn't exactly
>> helpful (tbh I was scratching my head for a minute to see the "old"
>> override syntax in the example)
>>
>> I agree (also as I believe setVar is fired million of times throughout
>> an ordinary build) about the performance penalty.
>> But what about removing this code path entirely and letting those vars
>> to be set in the data smart?
>> And then probe for variables having one of those pattern for instance
>> close to the finalization (which I believe should give a overall
>> performance gain) (line info can still be gathered from varhistory if
>> needed).
>> Would that be a way forward?
>>
>> Or one can even think about moving that stuff into a sanity check,
>> instead of erroring out that early here (and potentially often).
>>
>>>
>>> Cheers,
>>>
>>> Richard
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#16584): https://lists.openembedded.org/g/bitbake-dev=
el/message/16584
>> Mute This Topic: https://lists.openembedded.org/mt/108574686/3617156
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [marti=
n.jansa@gmail.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>

