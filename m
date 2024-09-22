Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B582CCF9C69
	for <webhook@archiver.kernel.org>; Sun, 22 Sep 2024 08:48:44 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.92.89.94])
 by mx.groups.io with SMTP id smtpd.web10.11596.1726994918882328158
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 22 Sep 2024 01:48:39 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@outlook.com header.s=selector1 header.b=WPelDibc;
 spf=pass (domain: outlook.com, ip: 40.92.89.94, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cvfv8g/ESJxxpEvMf7QElzyKL+po47ZjJno2xg8RGpJ/H4PBeDJ3bdebzrMibOPPMHwY6ZtQXXAC+RzNHAKUztMwGtysFzHbFTpbduzHb3R71wAr67NQejDy4IR8m8ptHFTghR1k52tddAc4ZGNluvrCqOIvFkSOleuctbsNfZF6w+kHiDG9Y/5KVMc/XiBm52AORZxzg+AcK0t9RPYAR5yj9Jbtpy2aLVKDBvziBwvYTMYB+6nqED9CSvx9Nsl50UIcirJP1zrboqAmkOcd+w4oygikVgkR8lZ1AtQphYE5ZHxU6VQNaDV1cnjxGySSisc1SzDaqsiH4vicUX9exQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LlrrDbfMQhaprd883fbL31NsUUIb1f6efiiAD1SVq4s=;
 b=uWIUx50uCo4A16QCIJiaN3Gwq8FBXI3nplV2u6M2jSwfI57QEOLX+M4OClRt2bKx5t0ZSA49vE1lPu9Sk2yaLPrUr4oKJpfKRxOBRvn2J9Q7aE4ATIr26qo2SI39z7COUlx1zKnSmtq2PqDhUOFjlD13hX66CGvYHY7SqFdgzm+m+v2lswWYzOIQhhEb02C8lWc+Nu7NGmURBtTjzh8ZUc62NWbNzJhElVWwb2ZRTTYyP45t920QZ236DbeEcQNEcUXc99sacbGlJo2h34rR2HcWmOv+nO1Nx8iTxmhrnn6d2brJbXdLIrMnbZa9IOmqyW1mNDodl4c5GGk7ONB0MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LlrrDbfMQhaprd883fbL31NsUUIb1f6efiiAD1SVq4s=;
 b=WPelDibcboGw8Ms2EIn7GyEvobUBjky4CBI1+dof9x1Qw3q5ImIcO53HE3vKHrk7xLda0ECQQej/DYsfy6jKxjEvFIknzeY44lQCpT+/UH1z9bfcVoDYyjQ6AIZT7W1PqjqAiHHpvVTAHXqnkqp9dJ3wgYZn1sIkZ6M0b3VYte2qZ3RZfTn1s7jWOzy/oqspV/Hf+SDvmMeXcvoCwBkqY2dl10HwOJgMzPckSKk7Xt2TTcVjbpkbw9XExhy/kAIjopfZn8DGzg79P3TOVPSGQkBg8sN3Hxk4w0BBMvICe1upqXpxs4R9Cs2PPujD/OIuh7CZsDmgPP025qw7W3TWKg==
Received: from DU0PR07MB9116.eurprd07.prod.outlook.com (2603:10a6:10:404::12)
 by DB9PR07MB8870.eurprd07.prod.outlook.com (2603:10a6:10:2ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.22; Sun, 22 Sep
 2024 08:48:36 +0000
Received: from DU0PR07MB9116.eurprd07.prod.outlook.com
 ([fe80::e22b:b199:c63c:e253]) by DU0PR07MB9116.eurprd07.prod.outlook.com
 ([fe80::e22b:b199:c63c:e253%3]) with mapi id 15.20.7982.022; Sun, 22 Sep 2024
 08:48:36 +0000
Message-ID: <DU0PR07MB9116AA51410D7EBC4F8982CAA86E2@DU0PR07MB9116.eurprd07.prod.outlook.com>
Date: Sun, 22 Sep 2024 10:48:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 2/3] bb/data_smart: fix override syntax
 warning
To: Richard Purdie <richard.purdie@linuxfoundation.org>
CC: bitbake-devel@lists.openembedded.org
References: <GV1PR07MB91206C44D7FEA544DE6D6374A86D2@GV1PR07MB9120.eurprd07.prod.outlook.com>
 <1497c21f2add634469d205a55a155324f0e0bfab.camel@linuxfoundation.org>
Content-Language: en-US
From: Konrad Weihmann <kweihmann@outlook.com>
In-Reply-To: <1497c21f2add634469d205a55a155324f0e0bfab.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::13) To DU0PR07MB9116.eurprd07.prod.outlook.com
 (2603:10a6:10:404::12)
X-Microsoft-Original-Message-ID: <df6c335d-482a-41fc-8f25-f722b854cb81@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR07MB9116:EE_|DB9PR07MB8870:EE_
X-MS-Office365-Filtering-Correlation-Id: 404b58a7-be9e-410b-be48-08dcdae357c8
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|461199028|6090799003|8022599003|15080799006|7092599003|19110799003|8060799006|5072599009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: 
	3xuvZSFLa96Dx5Kd99ciQoTmjruXpq14WD9vqyoHSS2CM+k9gHv46ylxpvf72V1xodJmwIUUZ+i8587trMNJ05zEA7EPVsT5SvxoSYghIXtTKEyAsNFvZscVPEdck8LrXHbobw7sAypWq4CCOS/fkC9SOqcCCjsusvQglcqzr6tWGoCrGBy9mQ7jIRgILqgm+ViGli3w4N4PUe00FuwGCHxgsR2bhrdUjj04Ab5KjlzSovf73xr91of+cDY/cVB0xWaOsxB2aYvGIydIrGU9cudoguOJjn++alrvsVhJBsbkmhYAFHyPutCpc8yh7KotbUQb5ibkUCMuvPte4OmhbIdURnIY1ifd1NLNqA/fF5oU9Q4r0bQ/bz0cBzhmazawU9DX1OFC5j4cAuS2jbvoBtMjAGyXc1cRWtG9UX03t5+X39MOQ1yrclO6fMY+oAiDPQmtRDzxELlrA+EF1bEfnucYzUsJlPUVcUFHCjKnUtqujBuH5o0OCF3StX/nssILEYH7c3ipgVZ4V8Qq6oanNHxsGczdvp63Q2ZCKTYENDdf8Su0NWsoTHHBuvHxKmKSvA8YiKTgtM5CHwehDj0FyxgqS5VebN5VDp8h1YdFZfF8hkoM8r/eLCb5CvpOj9HnGctkhniSv9j3fiVtrM+wpihb7a7rifg1sBHpiDVMF4Ncea0eCO/u8JCXrVcYqNyqLUFiEIVOlYMJ0AvvPVPPEFphGaRPtZ3hM+UfFl0QaDyAPklrbUuuiEb17dS6WbYHUZbeP7lYTnX7x9ZLSwqVqoNARh7DcpBflvW5jPsXQqw=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?y6nl832EIngnz1upPLe3yocFykt09KwR+cHanMb1QUEr9Za1U6+ezN1R75Sa?=
 =?us-ascii?Q?RMihb82IVtovPf7WEYgaAggZTse/YZRIudG8zCO8sTbxTH+U7xaxD34BYoik?=
 =?us-ascii?Q?yMOlF/OqyER7eZCn77UYEcwgfFh78zmDyv4n6USGmYgjhuIYJ7AZ7YdWQ7x/?=
 =?us-ascii?Q?wThweBcmGybmIBb/ahVW0tTOXtxDHAR5QLMg3TDMON91lGTaH2/3dZ+xhGPw?=
 =?us-ascii?Q?EPX6sdlXXc8x+zQRqO//v5j4vYKD1ikKS08TBaozKq0yMau9vO/nfrIgz8w7?=
 =?us-ascii?Q?KdndNGSFmjPPysf//IS5RaGe5zpe0fBOf6VMyZGI1y8M6e0gMdWzsJhAZWxp?=
 =?us-ascii?Q?KhpmR+ymgZ0BepeEgfnKGWJAX5GpKsBHcu/cQagE8dg7aM7R0sMp3PvIk5mN?=
 =?us-ascii?Q?qGgCBjNTeumJcroL/anSXyYVQ6EmQs7K+pnM27/+ZoyZrUNSIoWJAVGseNSn?=
 =?us-ascii?Q?BUQ5ca/6NFeG5g4SdwIMk0IAZmZ7BRY3zR//HHfwHcz+8bOYRcma1gzbk5SJ?=
 =?us-ascii?Q?lrG6As4x246Gssa5cKAiupPZ5jOYtfag6b9IvAV8x3K2f4AIQ92VzSXbVBpS?=
 =?us-ascii?Q?uNgyyKe2mryduQX+cF9i02W12UIiVCYtLK9tKLfl5gLw8kE8AJ7TGMV2nJdO?=
 =?us-ascii?Q?BvOw41NG0ASpsWLztd6Uq7p2/uQOdUYDi3SvacgG9xmPjjoqjiEf6WNarfHw?=
 =?us-ascii?Q?Hhy+16LyOAoZGwXAeCFBtG2NC9GPv0XiqcabW6OLgNWm3SbRYVpA5kMelO+k?=
 =?us-ascii?Q?CnmpcvFmrv4l+XSt1GyqtWNZxKmTHG8W7y1UGxf33XuMQU4IXrcq4YUh8BTb?=
 =?us-ascii?Q?mbEC0ylp6OOik+0X30nrlWWWxE26ygY4nFXZ9WnDidc0MXggnJoYqsLITn6t?=
 =?us-ascii?Q?lu6L6yusRfwUv+MTIh5HsR5Hnnv3YrtL7RueHuCBna88y1Q6G2Ji5yFVb3Ld?=
 =?us-ascii?Q?wOprWVA65nLmQs9F9LY24BwgFxCFvgfGfugYYsbOzdElebIz9gApg7UsJ/Cw?=
 =?us-ascii?Q?AXzpHlbphUnKeiWNWNLGQoHbpusVLjWI3lg3hYIS6B7eYQ6oxa5Q546jpOUW?=
 =?us-ascii?Q?52ShBqdWZygMOkuCvh5wPnXiV9RGZNO4e1M0o4A4lZIVMKPE6mZlgUbwkKgM?=
 =?us-ascii?Q?1lvpyq35eeZEbdfq9Vmweo1DiA0Tbx9Pbdt3Nl3r1aTT50DBtIJdO0JDt5/s?=
 =?us-ascii?Q?ZL5051dGm3bDJF5VHyWhwepEaxoexDDCLgNuyHthkhF6gG7pmezB82PA35QX?=
 =?us-ascii?Q?O+XKWIIpfAVXwfF/FvCr1eUfGPsBT/doQKIAMejMJLRf2SsnWGhGexuj8dQE?=
 =?us-ascii?Q?c7E=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404b58a7-be9e-410b-be48-08dcdae357c8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR07MB9116.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2024 08:48:36.0211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8870
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 22 Sep 2024 08:48:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16584


On 22.09.24 00:15, Richard Purdie wrote:
> On Sat, 2024-09-21 at 22:43 +0200, Konrad Weihmann wrote:
>> Richard, this is in my opinion wrong.
>=20
> Noted.
>=20
>> It's preventing, for no reason, valid tasks.
>> I agree that it's an expensive operation (potentially requiring to
>> making it precompiled), but I honestly don't follow your take that
>> this will be of any significance when taking a full (ordinary) build
>> into account - the penalty of the operation is in a millisecond range
>> while a typical task/image build is more considered within a minute
>> range.
>> If that "penalty" is unacceptable I at least would expect the
>> documentation to explicitly name this limitation (currently I don't
>> see that anywhere).
>=20
> The penalty I worry about is against parse time. That *is* a serious
> concern for usability. Lots of small changes like this mount up. I
> happen to know (as someone who as done a lot of performance and
> profiling work against bitbake) that setVar is on the hot path.
>=20
>> So either way we would require a change, it's just unclear to me
>> what's the consensus in the community.
>=20
> No, we don't *require* a change.=C2=A0You're asking for a change, I'm say=
ing
> I don't think it is good for the performance penalty vs the gain.
>=20
>> My take would be to prefer precision over performance - not sure how
>> others think about it.
>>
>> Side note: the original patch never got any selftests, which just
>> kept hiding the problem IMO
>=20
> FWIW nothing is requiring you to have tasks named like that.

I find it troublesome that a generic build system doesn't mention that=20
as reserved keyword/pattern - esp as the printed hint isn't exactly=20
helpful (tbh I was scratching my head for a minute to see the "old"=20
override syntax in the example)

I agree (also as I believe setVar is fired million of times throughout=20
an ordinary build) about the performance penalty.
But what about removing this code path entirely and letting those vars=20
to be set in the data smart?
And then probe for variables having one of those pattern for instance=20
close to the finalization (which I believe should give a overall=20
performance gain) (line info can still be gathered from varhistory if=20
needed).
Would that be a way forward?

Or one can even think about moving that stuff into a sanity check,=20
instead of erroring out that early here (and potentially often).

>=20
> Cheers,
>=20
> Richard

