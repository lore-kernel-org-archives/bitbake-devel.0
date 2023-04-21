Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73000C7618E
	for <webhook@archiver.kernel.org>; Fri, 21 Apr 2023 13:50:32 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web10.12354.1682085031372140064
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Apr 2023 06:50:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@axis.com header.s=axis-central1 header.b=mE2LxN0C;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1682085031;
  x=1713621031;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=enp+W+qTi+YZpkfLD+xVxdRgrAu61pexqr1RgZeER6M=;
  b=mE2LxN0CyqWJVsx/8Tl4DgFQTL/qUdgorQ7n39NUOS6qpiVghGmTUQZ3
   dycyedv9GK+6NTLJExILjH5ESxoKr1gUnobtbq38cT2RePWUFFUu6ymsN
   jbBWcqFGmmyAkKnys4ueX6Y7rBv+1f1hxEXEUFGT4bRFCLDbdwSbYSf50
   cDJOLvYCfbZXgA4OctyEo6OTNal9AmppsjtjqGiP83eO3cqMSG7hb68SX
   dnYcpIyNz5IWuslpyv4l/CruF8LsL6svON8i4mfdjzet8r7E6jqIDCALB
   /RlnSihIFkRYuGAOAS8edbFDtb6Ki0sHWY8hUXBJbMAUWYJ+KQ+4Vi8TY
   g==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDS67QUJWcBGK1uEcGNG+z+GL9Ha4EpsGwtxzHwUD2WwbqKmQXc1JXVVEEWuAgExfgrtFdPr1/l+LXU3UEOwExLEFLsJJNt3QrtdmOjqFnhBEk6T8H2UnTCp+xyFGYwcXLT2129PME+CiLk0Gw73mffnXNb5cbcHPxGyekgKu9yzpQsuq3nv6Edu2J7APyoM9o3yu0dQ8pZFt8hrsy4Ha0OhKjAdQ7r+ZVkPbe4TUMBg0bS+FakJfWoTRfEEzS6VLw3T/WpyFeC5jUOMYy7hdokwnoIH4dMUrRTHTwywY9LE/3JcluVO2compAW0d0G/3x1s2T+bl1+0NTQYcmVTnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=enp+W+qTi+YZpkfLD+xVxdRgrAu61pexqr1RgZeER6M=;
 b=DdSOfRnmfHMlAlnE5QWrJCNtURA7fkw3nlpgLi6edMHDORZLz/eC271GkWcCY1NgqRgAgVjhamxUyeGFrGGsgCKFbt/cHMrheJwCm06IXmgx4DaRUKEOEEW6dO41F5/J/MiJFzs0xewSHEzDHwHQMgDaYBskacEX+a9LKc0qX4ZaLf+TewD342z3UODkn0Fpm6bCuPq3WLIodM3K5Y0b3954spTDVtgZfAvwmsuoMIK2PTfvVfCvflVW9YvRBf0ptmLA2mRfbZPD25Ho/5GEnKa/j9GXkyAOuRR5Rf1/wllT9WuThNkD18pxqrljNASahefu57vflMEPKer9TfuSiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enp+W+qTi+YZpkfLD+xVxdRgrAu61pexqr1RgZeER6M=;
 b=AuFvF0ZzX8BZZi4eicwf5lKFvVtgE3z5ls+sZJMoQZOh0FTjo5Y9wDT7ZUeogp25Fvdc3BPJVhPkrse6flw5ARoXTw4UV6Vi4sbfU2EfbvHSD3hP617zjICd4pptG6e5UBJKom9OIgr9zq0bIbt6bG6Nv5QnwtGqn2dAenb9DOw=
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Alberto Pianon <alberto@pianon.eu>, Luca Ceresoli
	<luca.ceresoli@bootlin.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH v2 1/3] upstream source tracing: base
 process
Thread-Topic: [bitbake-devel] [PATCH v2 1/3] upstream source tracing: base
 process
Thread-Index: AQHZdB+z07Gg3PEQ0U6EbVFCap98n681XV6AgABav4CAAA4oAA==
Date: Fri, 21 Apr 2023 13:50:25 +0000
Message-ID: <DB5PR02MB102133408DCA18D8EB0999BEBEF609@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20230421070525.333494-1-alberto@pianon.eu>
 <20230421092803.081e3cd6@booty> <3afd4fe2d1581be5720508538c0c2287@pianon.eu>
In-Reply-To: <3afd4fe2d1581be5720508538c0c2287@pianon.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|AS2PR02MB9509:EE_
x-ms-office365-filtering-correlation-id: d083c0d2-e2b5-4362-be2f-08db426f5c07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w/oKGChl5iO6bk6ePn9jZRDXYv4k0IEETmpWZpzhkS7qvXYjeP7KDDu/Ac2DmYBXqH68kps+0gYlWWWAodllRBPcV3HR3nZiDp8KxIzuY7ZWZV52TW8xbLrRLSUFiylSjv2cmJfJspsN3MN2yS/HZeAtwIgy8/p4OKf4R8FKPQ157OJ3t/U4GtpSy8WDYbPJFuzKLIGtbdUNt5oAdDs1ITdqUyppZQBJPUH0h1u2T2j8mhihMNvGkMQmi3JZXxFiHBH74+12hB9M9S7bQWA+yNDz4Eispr5iqMTNuxd2V430BdbIexv02G79DQe8iMFuJ1Z6Oh+MUQ/0hSKCmGxTKi3Ued42OQxAecGFhAAqZrkzRefzzG8XocRvsrgn65j189NyfzSqJEl3ywzUHEuwSQ+vRfPugI5If/MoGKYf24EWVB/hteNaiGTFblBkHRD8R9DaadXCyFkl0VEww87tuauZj588p4bL5F0eQ7J+oHiVmoRLzdMReLVUdcpCU8/cyrv4JmZFkLnxnYOLfBxW0hpCGBN4ltgR+Nxj3jRGBU+rWq5/Qa4R5GIDDfNxSMO4J+Klhdn60JQPARRyCWO0OHpnxUu9i0hLFYTVjGlQbwIvgLHQJ/bz43VkrO3Q4bH/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(451199021)(186003)(53546011)(7696005)(71200400001)(55016003)(86362001)(110136005)(26005)(6506007)(9686003)(478600001)(4326008)(83380400001)(64756008)(66946007)(66476007)(76116006)(66556008)(66446008)(316002)(52536014)(41300700001)(122000001)(5660300002)(44832011)(8676002)(2906002)(38070700005)(8936002)(38100700002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LjRKqTLg08Sp9bS9DV6RlcHqf+tDjQrVlHHeMmtDtPzSxFvBOlwM1bB2ZLwx?=
 =?us-ascii?Q?EsbHQXFSBpyN1NIu3WMUpbwivoC0fUA2V+iOldiUVugONUH+Gm3L0lWn6xeE?=
 =?us-ascii?Q?GMVlxm1qtVbtodEnSyBFzguZQuedASf6JaWl8oiMkqMPUDts+iUbTi3fgovS?=
 =?us-ascii?Q?4CzbLw/wCTDdTKo9INDjO2WTosXmm3y2hSuCUOQvE1Xh845fInOzy1TKH7y7?=
 =?us-ascii?Q?6JFKY7ZZwElBDWrE5EKes1VCwi+SogFpcQkVP5wZqJgGpfaLRPt/rauvn08t?=
 =?us-ascii?Q?Fi1CgV9YsIiaqBpHACMiOhobQcIWrm5Ade3fUjsssJyZA0pKC+lVvNYXzxZn?=
 =?us-ascii?Q?6TlknnUJ3DbcUZ/njw78bkQyhyT9eTtPlGmalaA9Px0rINI/Xm2qbc/YWXR1?=
 =?us-ascii?Q?WyiD48XjvNk9LMcTU6oUB1qlrRXIFLTFujVSBFDWN6hZSIEVgumNQqP4zyhM?=
 =?us-ascii?Q?rcQaO53xE8fp/bae5CJG14sprm+DuSty4/gx55DtjPQvd7xuwb3SoRor4gdV?=
 =?us-ascii?Q?fjbfu1LEQC1kmjL3dMomEXQwEQQJRkzDZlBDZlkCsvcjXQEmdL3aNPRohamA?=
 =?us-ascii?Q?wFAvPwHZQgX8fUBa6oS5J89ikio5YT6ZtK8QOxP94XFHEg3v1RKT35dNCsjy?=
 =?us-ascii?Q?jBhKC6s85zmS+L8m308axKZzjPPKH/xXVt+STVPZA+qcxcTtsyBWJSS8Xv4o?=
 =?us-ascii?Q?frXVe0w4TDY61VamBZaH9n8HLw9EnnediPM6qcB6oN9PAUBZ3xps7q9wNhts?=
 =?us-ascii?Q?Vp7PVLvfpHV5KVUVCPbsXxxp3uMpxaqZC+q7iRPdZO8wsChTeGG/zXcWTTkl?=
 =?us-ascii?Q?+P6S4wQomx9xIJOCV+Tv+xZjZ1V0LbKfRi+cxFxTlhrh/T4Mfo9yRns6xUfF?=
 =?us-ascii?Q?/8q6ZY2ZnmcUt5wOSt8ZD25xOucZsn6e8agg08KY2/irN4133fYtbD1TVWGf?=
 =?us-ascii?Q?dm0HR617lFVzeBAQotifn1jtSatBwUxTcCGsQDNNYqlFWhZsdut3UTfM++g4?=
 =?us-ascii?Q?/JGHjRP59YbzMhmW9jZUmIyMIkeAKGjwqT2hNZC4Ambz4sosQrwmT7rttZxU?=
 =?us-ascii?Q?ttKvrNnCE75d3C2XxXoviiN1Gwv1BQibIS/1+W54vxNTVCAezDvSr2e4e5hw?=
 =?us-ascii?Q?HfZJB9vquVVZCK+fd6ilAOhY4UhDparbhnW1efUstgHRj2utJfmIDIpykl5G?=
 =?us-ascii?Q?SkLY/A2Unaqh8B3ICI4yCVm59ShhMxkF1XQTfwF0gmjhl3Y1Z6NYBtz9PePP?=
 =?us-ascii?Q?siWhErjBd0w7gibh/2vF9r+7EDBveoGHdS9gW7xAcNgELwXlXCoVtV6MCGA1?=
 =?us-ascii?Q?AlkfIptn3+nOxjfrNJpf1dOFfYOAB7aHgaJhVDfWB57gp/SxHZe1ko8+tQaL?=
 =?us-ascii?Q?BCYakwKC21ZB3b4y//PzVT3+iCgfKx1vU2Yo98/6AuAG/sOeLi8u6JYlAdoq?=
 =?us-ascii?Q?9ZcGa2Lfsv6JsMKVupZ1r4z4KG8r7Zw1i8XX8PVSOa3bfJH3x+dgZ++AA8hO?=
 =?us-ascii?Q?lVi7V+YE9cD+Daz9hhr+aYiAhJ8CnMRnW2NGhkn7Ya9mDQSd5cBJHKInX3c2?=
 =?us-ascii?Q?zq3KRUdehevSXzyEQD0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d083c0d2-e2b5-4362-be2f-08db426f5c07
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2023 13:50:25.4592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oDE1ytfqSbLMD+Hxn8lQlfuhEROPPuXyAJkJYAjSBEO4Go3p1YCJY3TaZJIruIiB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9509
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Apr 2023 13:50:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14733

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Alberto Pianon
> Sent: den 21 april 2023 14:53
> To: Luca Ceresoli <luca.ceresoli@bootlin.com>
> Cc: bitbake-devel@lists.openembedded.org
> Subject: Re: [bitbake-devel] [PATCH v2 1/3] upstream source tracing: base
> process
>=20
> Il 2023-04-21 09:28 Luca Ceresoli ha scritto:
> > Hello Alberto,
> >
> > On Fri, 21 Apr 2023 09:05:23 +0200
> > "Alberto Pianon" <alberto@pianon.eu> wrote:
> >
> >> From: Alberto Pianon <alberto@pianon.eu>
> >>
> >> License compliance, SBoM generation and CVE checking require to be
> >> able
> >> to trace each source file back to its corresponding upstream source.
> >> The
> >> current implementation of bb.fetch2 makes it difficult, especially
> >> when
> >> multiple sources are combined together.
> >>
> >> This patch provides an interface to solve the issue by implementing a
> >> process that unpacks each SRC_URI element into a temporary directory,
> >> creates an entrypoint to collect relevant provenance metadata on each
> >> source file, moves everything to the recipe rootdir, and saves
> >> metadata
> >> in a JSON file.
> >>
> >> This patch contains required modifications to fetchers' code plus a
> >> TraceUnpackBase class that implements the above described process.
> >> Data
> >> collection logic should be separately implemented by subclassing
> >> TraceUnpackBase, implementing _collect_data() and _process_data()
> >> methods.
> >>
> >> Splitting the above described solution in multiple patches aims
> >> at easing review and merge process, and also at decoupling the
> >> development of the data processing logic from the process that enables
> >> it.
> >>
> >> Signed-off-by: Alberto Pianon <alberto@pianon.eu>
> >
> > Thank you for having fixed the subject! Now I can apply your patches
> > with a clean git commit.
> >
> > Do you think the build failures I reported on the v1 series are fixed
> > by this v2? If you think so, then I can test v2 on the autobuilders.
>=20
> No but I'm working on it. Actually, I should have found the problem:
> it's just that in some tests WORKDIR/temp is not created so I added
> a check to create it if it's not present. I'm testing it, but
> oe-selftest is taking forever in my build machine. So far, no error
> in the logs...
>=20
> >
> > Also, I see this patch set is not bisectable as well as v1: you define
> > class TraceUnpack in patch 2 and use it in patch 1.
> >
>=20
> do you mean that:
>=20
> import TraceUnpackBase as TraceUnpack
>=20
> in patch 1 is not good, and that I should use just TraceUnpackBase
> as a class name/alias in patch 1?

My guess is that Luca missed the `import ... as` line. I believe you=20
should be fine as you are. However, one thing I would point out is the=20
commit subjects. For changes to the fetcher, the subject should=20
typically start with "fetch2: " so that one can clearly see with, e.g.,=20
`git log --oneline` where you are making changes. If it was up to me,=20
I would change the subjects for the three commits to:

  fetch2: Add support for upstream source tracing
  fetch2: Add metadata collection for upstream source tracing
  fetch2: Add tests for upstream source tracing

//Peter

