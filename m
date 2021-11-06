Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529BBC433F5
	for <webhook@archiver.kernel.org>; Sat,  6 Nov 2021 10:30:17 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.92.90.44])
 by mx.groups.io with SMTP id smtpd.web09.17480.1636194615393717914
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 06 Nov 2021 03:30:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@outlook.com
 header.s=selector1 header.b=taWSIYo4;
 spf=pass (domain: outlook.com, ip: 40.92.90.44,
 mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyxFvbDyc1iB+5k1UhQzfJrZ/Iw35FaQ/icce6Ffz0yytzPxxo+fqOC0duhIrsFZaI8vyKM+g+M50EGYG3X9FhN5bBsVW8k1/mjGe27QsNp2xFHccEWTq2CL4qk8cCQbj244n7jCo/YS6CdDy3n+ie0JY5bvYUE5GiOEnWwVMFza6Phsd5NLaoEmA1oxmdhWGtvSGD+iWVk/2QKziv8A7EgMhJq+KKauRiDI8xhq0d0RXYJSM2ky6rIuHXqGZjAxYov60cE8Q48I1hSpdWNnXtsma739OLM4DxS7ZjbwnUvcsSBKQu3clpmD98wJG6jBCr9dNE7HNGyScOq3xAx43Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfZChrcl0N6lkkfXvs8WGgyJswsrdWxhVK6UFjPyJYM=;
 b=K70WOR1gQf/1/0YrHI80J3RnMy380L9s4Qg/Qy6WJWWVQFT/2HwzFcmWjwon4JYvvW+G+vAmUZuao4Sd7ib9ZAT1wy0fyh62AEnQORc2jmwWl7vsUAxD28E9aCSH89W4KSmeFVwSLyxa4lrz6rqO5XtCBX1AjhAjDCAKBLK/WxemfwK8chN0jLWZc5CgqGXlBzaOysDwhuYFVip2itX1yEcpg5GI65Mvn7cUlihG2fDjtHFhUDYNQuH6Kvsi/1g0I/2zI0uJGn+Y/dlAVbfv7NmI3CJSJ/7l3YB5y+ypFK5iJSIsr4Ye5kYOjZSpfYyukjt9LDUxtw1fUqUuWleDjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfZChrcl0N6lkkfXvs8WGgyJswsrdWxhVK6UFjPyJYM=;
 b=taWSIYo41FxWtH2VDI3NzuHgGZnFTkFg0vWFxv4iYxrbtLC0y6eT/+b0UHOnIKJhkk8i9PU1qNKEjqpdrPJtk1q6u5vofqgWoiHNCAk8CaCK8WblQkXBTl8ESPHQEngNajWy02rSbnw0k9MFUpw86zYGQtpCqthto1iL3N3iRtgqCBG0m2l/QsBdqkhL3W0BZ7iyJdYQY0r55QbpxNnaDJfUB3wNZfoCOWBHq026loZSHrZuKw2E5s42Agjsp7arPxvEZhfTxUopbyZ62+Y4mUaFtz83WzW6PwWzNrToW4cDKgXyUACsf5mnC+zv7BmSSsY8DSfL9moOnTseccCPhw==
Received: from AS8PR09MB4645.eurprd09.prod.outlook.com (2603:10a6:20b:292::8)
 by AS8PR09MB5000.eurprd09.prod.outlook.com (2603:10a6:20b:399::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Sat, 6 Nov
 2021 10:30:12 +0000
Received: from AS8PR09MB4645.eurprd09.prod.outlook.com
 ([fe80::f0c0:455d:26a8:99ac]) by AS8PR09MB4645.eurprd09.prod.outlook.com
 ([fe80::f0c0:455d:26a8:99ac%9]) with mapi id 15.20.4669.013; Sat, 6 Nov 2021
 10:30:12 +0000
Subject: Re: [bitbake-devel] Improving npm(sw) fetcher & integration within
 Bitbake
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 Jasper Orschulko <Jasper.Orschulko@iris-sensing.com>,
 "stefan.herbrechtsmeier-oss@weidmueller.com"
 <stefan.herbrechtsmeier-oss@weidmueller.com>,
 "jeanmarie.lemetayer@gmail.com" <jeanmarie.lemetayer@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>, "martin@mko.dev" <martin@mko.dev>,
 Daniel Baumgart <Daniel.Baumgart@iris-sensing.com>
References: <1c7d6bb2479af789132b3e94c44a54f1d1b5c304.camel@iris-sensing.com>
 <0b63fba531fc94bbe915dfc9915c0a2f42ad3ce9.camel@linuxfoundation.org>
 <42a0350d-991a-731d-29c2-83cd62da8c7b@weidmueller.com>
 <CAAdc0hwA12CiWHCXQV=MBHv-h=vopK7of3CUViR58fJ8k2rK1g@mail.gmail.com>
 <3556fec928b8b3f86c1a08b3cb4e2a2fb708cc9c.camel@iris-sensing.com>
 <5fb67154d576b74629e4836a86dcb5e479b73e67.camel@linuxfoundation.org>
From: Konrad Weihmann <kweihmann@outlook.com>
Message-ID: 
 <AS8PR09MB4645E17B929C31EC450EE636A88F9@AS8PR09MB4645.eurprd09.prod.outlook.com>
Date: Sat, 6 Nov 2021 11:30:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: 
 <5fb67154d576b74629e4836a86dcb5e479b73e67.camel@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-TMN: [JH3DTJ90pKl7FH7pxefnOw3FhNxg0ZyRL7BMt7G9/hxOLnEaknKsBzlzUY8j8kMo]
X-ClientProxiedBy: AM4PR05CA0007.eurprd05.prod.outlook.com (2603:10a6:205::20)
 To AS8PR09MB4645.eurprd09.prod.outlook.com (2603:10a6:20b:292::8)
X-Microsoft-Original-Message-ID: 
 <072a82e4-26b6-c042-1723-e3fef154d492@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:3103:205c:200:bed3:df7f:f488:16a2]
 (2a02:3103:205c:200:bed3:df7f:f488:16a2) by
 AM4PR05CA0007.eurprd05.prod.outlook.com (2603:10a6:205::20) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Sat, 6 Nov 2021 10:30:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2098f8d-2ddf-4ea8-1e1a-08d9a11069e6
X-MS-TrafficTypeDiagnostic: AS8PR09MB5000:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	rGsOdlJ/ZizqeCv4iVBZ76/yHSZdK9/j0N8dOkqXcC8RLPEKu9mQKp095Fj6ei0dgp/VRLklP5Z7LDbXM+EXuoGaG1g6PA5rdjqbmBs7pe3jP+YViBVMCAkuqeS5zLMbyD/ZRUjorKSGcRN/ftyRBqS7o7pKDtpEGmFOWPerYHYJCZneGakN4F0EFirkcNO9npw0PKeD8YK34IvyWVbPiXlHdC1qtLUwm4yYB3PFLxUXme2oVkqWR8jEU/nJuzNdTMKFcqq4uT1ECrylglMKhPcYGDsR6/CE0Z1yl8OMYFGcBEW0lKFOAyIJ8EJp1rbjnKJmBxrM+Gq76cIvU2on54UuDkVduqgbCvzJD+1vNKZiWgWIuYHv9h78TuFRdFDbjmL8UtvaEJdRQCFXByYCPPiwYk/jB+IJvBIDpIC+xAYNn/76XmLW8luZVptKGMjTmXV6M7oBcshTu2WkJRNulbFfzYc7nOj5jXz6S3Z30kVoGt9EDIkySFsDXAWEOGiwkOzTRCUbZw3iK5hoLjcKXGzvRbTlmFNJAjvpauTon90G9vS2c6t1NpLBMDaJkuJDRqFBk24HHAPMJlGHrf57BF5tN30xyRz1LdU2Io8+dN7fcK1rkT8ACRllQiFoYSAH
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	jYk8bm3RjQ3VpWjW74ci6e7Ux2DpZiiTbLk7ZFySHLpB7K9AUF6UopHqp0AFjyULixumTgkpN0jVY6IEfecmOyXUI+5ZCv/QI1W1jxGZ4n7WQh/IL+F7u1KoE60yOMHENBZvkCmoepuaTIxMfJlK8aHWAcp166XhO4dYw6m/hz3nQfwZLIc2uc8fvgItp+JA4oeUFgmpuhzTgjEzK4OPXVBZ2tKV6eMokjjoVdbktVEbjExZAjtBVBvqX0MmX1Ol+zzpaj3bXYw0MEdry8eees4y77DveGMeHnKzi8xz887XsKxRJQxGe9gRhgojXUxlSJAY5UgqMvMjdN2LParKhIBxRsqzyC5xCRVM4u7LJVR/3CIKTCevBQyOh8lA98DSIYL20uCy+zHj6Q175YvViMRTfa8sVYuc1dOd3TzjV6uDeAISwb+DqDo9qht4WcUU0BzBcfp8shwyM2uREh0+/yAOYHrZU4oRiOD3WDIP5vE50BeFooJpyNHuG9bo9VWgAcDN7dqNfLyMzml5PxlN0SEiY45oze3dcqiCzrUixP4z3oHsaK97ncu48QMKt1qAeSlYmAqUQemYjZ/Z8w1u5KkQIonXF/YTMgs94Yf2LbmzHsIzzfasnHv5BDve5Xtxv/nJ8ZRtxdEh34yf0Xarjdgw5036kg7ibaQJ5c0b/PdQGELtZun+c/TzyLpFDNCnWIWSKfIlpTwRuorAuP3nBl0wyoBUoK5DZamFnxBDyKfUAG6fQ95cR3/0JezU25FVqYZEkwgXPxSuZCnsXT9J7A==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 d2098f8d-2ddf-4ea8-1e1a-08d9a11069e6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR09MB4645.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2021 10:30:12.2293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR09MB5000
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 06 Nov 2021 10:30:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12924



On 06.11.21 11:06, Richard Purdie wrote:
> On Fri, 2021-11-05 at 16:02 +0000, Jasper Orschulko wrote:
>> Thanks @all for your input.
>>
>> It seems like there is a lot to be considered. When it comes to under-
>> the-hood development, the yocto project is fairly new to Martin and
>> myself. The term "bitbake requirements" has been used more than once in
>> this conversation, yet I am currently not aware of any formal
>> requirements. You wouldn't happen to have some documentation on this by
>> any chance? A common understanding of this and the actual usecases for
>> npm would be great, before we go into further details on how a possible
>> solution might look like.
>=20
> We've used that term as there is a set of things which the bitbake fetche=
r is
> expected to provide in terms of workflows and user experiences, effective=
ly what
> is it's API. Sadly there isn't a formal document, just a long understandi=
ng of
> what this looks like. It isn't a piece of the project that people have wa=
nted to
> change too often so writing such documentation hasn't been a priority.
>=20
> I can try and briefly summarise the expectations I can think of in the li=
st
> below and we should perhaps just put this as a text file in the fetcher
> directory of the codebase. If others see anything I'm missing please add =
to the
> list.
>=20
> Just to be clear, we're not trying to be awkward about making changes, th=
ere is
> just a long history with this codebase and end users tend to get upset if=
 we
> break the API. Different users do have very different use cases from the =
code.
>=20
>=20
> a) network access for sources is only expected to happen in the do_fetch =
step.
> This is not enforced or tested but is required so that we can:
>=20
>    i) audit the sources used (i.e. for license/manifest reasons)
>    ii) support offline builds with a suitable cache
>    iii) allow work to continue even with downtime upstream
>    iv) allow for changes upstream in incompatible ways
>    v) allow rebuilding of the software in X years time
>=20
> b) network access is not expected in do_unpack
>=20
> c) you can take DL_DIR and use it as a mirror for offline builds
>=20
> d) access to the network is only made when explicitly configured in recip=
es
>     (e.g. use of AUTOREV, or use of git tags which change revision)
>=20
> e) fetcher output is deterministic
>     (i.e. if you fetch configuration XXX now it will match in future exac=
tly in
>      a=C2=A0clean build with a new DL_DIR)
>=20
> f) network access is expected to work with the standard linux proxy varia=
bles
>     so that access behind firewalls works (the fetcher sets these in the
>     environment but only in the do_fetch tasks)
>=20
> g) access during parsing has to be minimal, a "git ls-remote" for an AUTO=
REV
>     git=C2=A0recipe might be ok but you can't expect to checkout a git tr=
ee
>=20
> h) we need to provide revision information during parsing such that a ver=
sion
>     for the recipe can be constructed.
>=20
> i) versions are expected to be able to increase in a way which sorts allo=
wing
>     package feeds to operate (see PR server required for git revisions to=
 sort)
>=20
> j) API to query for possible version upgrades of a url is highly desireab=
le to
>     allow out automated upgrage code to function (it is implied this does=
 always
>     have=C2=A0network access)
>=20
> k) Where fixes or changes to behaviour in the fetcher are made, we ask th=
at
>     test=C2=A0cases are added (run with "bitbake-selftest bb.tests.fetch"=
). We do
>     have=C2=A0fairly extensive test coverage of the fetcher as it is the =
only way
>     to track all of it's corner cases, it still doesn't give entire cover=
age
>     though sadly.

That list looks very good and I'd really like to see that as a small=20
README as part of the bitbake source tree.
One (maybe optional) addition from my side:
Each fetcher has to mind the resource control flags offered by bitbake=20
(like BB_NUMBER_THREADS) to allow the user to control that behavior=20
globally and not having the fetcher code allocate resources in a=20
uncontrolled manner, if that is not desired by the user's configuration.

>=20
> Not all fetchers support all features, autorev is optional and doesn't ma=
ke
> sense for some. Upgrade detection means different things in different con=
texts
> too.
>=20
> Also, I did realise the npm fetcher tests simply don't work anymore. They=
're not
> run as standard as our infrastructure didn't have npm on it to run the te=
sts so
> they have bitrotted :(.
>=20
> Cheers,
>=20
> Richard
>=20
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12923): https://lists.openembedded.org/g/bitbake-deve=
l/message/12923
> Mute This Topic: https://lists.openembedded.org/mt/86814331/3647476
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [kweihm=
ann@outlook.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

