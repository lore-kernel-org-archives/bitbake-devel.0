Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E67C87FCF
	for <webhook@archiver.kernel.org>; Mon,  4 Aug 2025 12:11:04 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.32])
 by mx.groups.io with SMTP id smtpd.web10.16284.1754309462385731202
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 Aug 2025 05:11:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=Nxt35FSt;
 spf=pass (domain: axis.com, ip: 52.101.65.32, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxuTWmID+IemZVD3O2CZYCP4lmrEzt8S70Y8auVHNvUi14gqjrADPukMEEbLE+a7O19ueDt/xr+4ql9vYoool1CbgRE/jdzEUfJ6okIKy39wB1QYWT/zjRdcW/zniw60t+Hbh5I8Z16a64KpFLxM7qVSy7d9Q/KaMdP0Gi7ryzp1klakIu5xf5B0kjXpOGy6yoLhqgGqXVYQnE/XEY/M1A9dQc0vbvYYMFKgL6KV3N1XYqypW2GNRfUxsIZHhGBDdyner56qFlWKkLOU6ptu2AGEZuUNQtZGu33qZIj9rCmmub2oIpzhCjEQYmCl+pHlVdt1PTZOUwbyY55r8mYZRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCTgWPOWMLEuyF6o29p35bSAaqBZ/57dZ+X1nQBkBUU=;
 b=pNuTt+m/kizk5CFB/feRVxDB+k60F90Q+jHI2A3ns/nTlia22/0h8R/LUVfLCjaUBDjNZVOxpDZi+vo6AKJ3YGP7CYj2Wq5fqC+Y9ARUs7lvWJBsbnUAiKZL3o8pjOvf0WECmasSZ20sSmBMOZ6YzqSm7X81FQUbyzeWnDOFPzBoyrtVRlLgEU3BpO0RrqcNJI4DGWHKcucLf6xHTGiPZOIjBbVer7OzwGqir69C05AIwOscO22cdXVdI/tnlkfjpJSWS7/Anpe7aMZwPuoUYMTdaY3fBoIne7Cr4g9rkEi5nMfT67LIUcvf5JeckYxChV8Oo/xVKS4FyKmF395PlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCTgWPOWMLEuyF6o29p35bSAaqBZ/57dZ+X1nQBkBUU=;
 b=Nxt35FStDxZ1+wlSE1Un4jHVnODuKZZPoyBnjIk8QR8uQRXe99dwDLKVGyVF/QlapPGzH+3sujg7VyxwsiNSNHYtvOz6wQxWN4/bHUfoK6OaCcL2KwmDny2IZiAmk7q3McxKMMtOJuyrMsbnEK4ReYWK+dbkt3LkGtnNtMp2JIQ=
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com (2603:10a6:10:4a8::17)
 by VI0PR02MB10766.eurprd02.prod.outlook.com (2603:10a6:800:202::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 12:10:58 +0000
Received: from DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9]) by DB5PR02MB10213.eurprd02.prod.outlook.com
 ([fe80::1bee:3174:a078:5af9%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 12:10:58 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] cooker: Ignore KeyErrors duing shutdown
Thread-Topic: [bitbake-devel] [PATCH] cooker: Ignore KeyErrors duing shutdown
Thread-Index: AQHcAvInegmFu/JdJUujIPRJS+ofZrRSauPw
Date: Mon, 4 Aug 2025 12:10:57 +0000
Message-ID: 
 <DB5PR02MB102137670453ECB7B01D979BAEF23A@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20250801143948.932436-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20250801143948.932436-1-richard.purdie@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|VI0PR02MB10766:EE_
x-ms-office365-filtering-correlation-id: 45713d5c-b445-4095-6ba5-08ddd34ff86f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?si9GStciS15/141Wq3t5LLYT8A0F5tyuy6JmaODo/Jo3oLw9CLQw3HZdJJL2?=
 =?us-ascii?Q?qzbVtinS0yNDIz9ooP4NBumd2h6UXrH7BUpxGunvZsd2bXbfMZRTsQU5d08l?=
 =?us-ascii?Q?0dIQ1ccjGVZsbJyYLkAXXk++Ag2sPb6iouqjlvwPOavX+4NrL0d8mgGo4ObI?=
 =?us-ascii?Q?AAnABnwZ5gVctWn2Yr+pwiTaGUTwXSokbJdKEv1egfgDSkYHdIseKMzCVVnF?=
 =?us-ascii?Q?9+wCtz3Eb2A7G6ydHQkjNltZvcACW/s1e+8sryRI76rK9b4vAXvzgBLItcH4?=
 =?us-ascii?Q?91xTNIVmCEcpUvP0o279ugLRWJ9j5d6WX4VcdK8dEgeLzaw9KsncjrcCe3TV?=
 =?us-ascii?Q?EMS++wia9WUKlBy3L4pW/kFkLXQ2jtMeApsfxPvc8jMH+CkKi3J3QCsNkWDq?=
 =?us-ascii?Q?fjTRz8m+qPz1+PEl1VldR1t1ICwgVuZrf9ksslF8x5L/CnUDJdO1AisFvm7Z?=
 =?us-ascii?Q?AxsOwlzCcN+sAUP1+BihDvFqaBTH9jK+/PIstuEemPKQhCxbQ17cIwJXvrxp?=
 =?us-ascii?Q?ebyXq3Egyr89fQ+IABKvTHfsq6m1yilk5Ec4963vXueF7vkD0l5362O5ejjo?=
 =?us-ascii?Q?EHKqAEQF1Ku3zeOIERu73Gi8AGQzCjdXSwQPxUBEb2Z3yRmSVE9/bpXzDdEs?=
 =?us-ascii?Q?PeImFwEJT+qaEtvBN/U2eqwiIjkqt0c6epEepLi7mLSDT26sVa5iLUskfhtK?=
 =?us-ascii?Q?C8KqUzX85JrlBAQXzJZZV1gthusy2g1GPZAd3yrEsAz77ZNKKw4bWNlDYRx6?=
 =?us-ascii?Q?WQ2ZWTQSwmCIPnLeaab3A0kU3AwprxrMtfhZUaWqGVwRknS3vj9AA5lTIw5W?=
 =?us-ascii?Q?clqmj9SxWAOnxPtq+JKY3Pma2C22mmVaIxxAHVVkvvcvABY+Nbrd6tBYpTEE?=
 =?us-ascii?Q?4D9XPaMN/YfyCoFjYN3sI7LSzSv/yTcSIcntB3RSN6uyYQhnlUsn2MmnmVpG?=
 =?us-ascii?Q?XVK3IELSml6+OOXna3MbObUmz7HiJcKA55kO5U1i5Ixu7Sm0nmB5fGcFr3n4?=
 =?us-ascii?Q?h3HypEkOHUutlob8EtrhEXwwZWSuuUT3sZDzSn7Kj41XKsHpnm6qLpj85ziy?=
 =?us-ascii?Q?Cy5ZWnAqfO3K6D7wiUCxAIe9pTON0/Ne/Aj2bHdY303ZYtqZPyKVt5Zqv/5d?=
 =?us-ascii?Q?5SCWdXThRpceV+yVDJMVBaKny8zTL7N03nq4RRJ7hWVt5ELtfqbMiT3VN8Gr?=
 =?us-ascii?Q?+0xotRFH0qPYEXtZTVXdkyyXgD+21MPYU4aiG1sRpTj6fdcoJzj6TEiaLB8i?=
 =?us-ascii?Q?ntLhNSZQA3VKnU6wkHvH2WUNl+sXIiJMn6rq2nfZn4DVe4Uv9wX1NCD4iyH/?=
 =?us-ascii?Q?D6zaT/rexzqWNxYAHLk7Y9u9XOZ1PFd2/Iv883S8UEFId+RbWft/s2dDhmha?=
 =?us-ascii?Q?+QDX7u8mJYfNIMs68YJm8OGbVRNBFgnJmgXj3Rg9OmrYsQSpNju7T0ndNH3n?=
 =?us-ascii?Q?lHfYwQ+vL+YKhyJeQldyTGCYf4sgtW7FaUvOpTMDHKihtfGchfCcTQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?GAgXgTnm4yQ31tNVnm1cQ41HxecMDNcjNwYCwBGSEm2sEVYF06Lph3YQjE7a?=
 =?us-ascii?Q?mqQxbMMpJ6S17ZIRvM8hNqRy6OK+mWX0KQ+US2oIBYDXiTcu94PoNJeK1TSZ?=
 =?us-ascii?Q?5cj/FkJXLNvxOM+dq1lkBtfrt5RjUKfuUisi48fUOG75VdhY0oFXXPuxVssY?=
 =?us-ascii?Q?NmtX3hshu91DWT1lvxlWG39kWIgvkMXpHc/c7eB3gMFFSyL5AFit8ZROuFWQ?=
 =?us-ascii?Q?JUxlgDwrpMu0VFu0nnMqwzrHTsx39UNshzgKrn2ZEhwFvYFfiiUQE7ZFJX0O?=
 =?us-ascii?Q?Ap/JXddZeoje1sIQ/oWoFjG/VAdD0IYNFF6KkynXuIkhBak4ap1HQefvneR9?=
 =?us-ascii?Q?HT0e/JPlyJ3elSwLGQuo4bfxVJymEQDBE46UuAHwqnVrG25p9y5s5VSjpGiG?=
 =?us-ascii?Q?rghglhwkdvwls52eA8Cyc3+lD2SGRbXMfrbzJWcDjYHPs0RuKXOJkzztzXWb?=
 =?us-ascii?Q?UQBHj0+Z9zo8kbAvNpQ/eDIPjR/iE6cWSiViuYIvP05Vyubm/HZGjly12Wd1?=
 =?us-ascii?Q?yZeHGldWHb6EzQWLHvp9fk8ei5oozdwYUw0WFxeR4juzF184lgUdbgp4xKhW?=
 =?us-ascii?Q?DaKY5fhp9cJc+vB1yKSh4fMYygf0EHpPzhtLtJzz+A1f5PQJO6Hq549RuSK8?=
 =?us-ascii?Q?z+EfmTD3iFakYXgBTZdq0MdjObX2A8jy9dgwNu5i7GU1gXL3SoDeHWM4E5Dj?=
 =?us-ascii?Q?fpXl7v83WBQgt7hoIlvICS2C8rKGEYXaKN74dL5FSxmH7pJMovRaiQO+XPjK?=
 =?us-ascii?Q?8Gj4jNT3WkOh4GR5jCNBAR5olfvVX3RiSg/X1txrVUMOQpmdUZnapcRKOhAT?=
 =?us-ascii?Q?CZxKW9bYEpt184gbpQoFiZgeTrl9kYu7PyNlW1xmgOwHaNnq8oB6IjN492a2?=
 =?us-ascii?Q?K1oiKSZU9Pr9zwnQ5g7BMbAtnfj10xMVBM7Ahl38lMeu7uMuEl1VoWqn4Vop?=
 =?us-ascii?Q?tCY9jqaELYk3wi8jX9HrN1Yqg/yINJe1Osk595SuPDmJrscm0j1LLwgwt9Ji?=
 =?us-ascii?Q?zKz36jsv1gGh6ZosSyBPaHpqqjOOn/tZXkcFUSWIex5dnAB1iM0iHuehG8w/?=
 =?us-ascii?Q?teypB/iehF/0KLhU4vEWXg5KqJLg1klQCZUzIm9Av+2Su74z4gaV9yRaXg6P?=
 =?us-ascii?Q?8cmNrEo0LbfGxqTptUMaAYCsHJdQ5Y4sqwnVh8kuANLhJDHBrd36PtytOE5Q?=
 =?us-ascii?Q?MnhEDCRL1Fe0wpR4E4ysgyADM4AQuQuxfzEIhUW6QuLtdvSlnYCMNH7b/vuB?=
 =?us-ascii?Q?vofybytDFzT+J9R9RgXq+7B6eunUZ5sIhEsHE3ppfRVhO2UiZ+8eRSk+jx47?=
 =?us-ascii?Q?gj7AuPOeGwFM7BXpHFjbLrFtfrl+UbJ63S1doldugxalq6UwISjHzro7BjEV?=
 =?us-ascii?Q?3lixxd+eVkjo5ELOzEu2nOhI5Jki0vLhPIuzckly5YIMoNzLuO5QXQ3+HoEj?=
 =?us-ascii?Q?0eDoh5QYcQpCOzLrjKGIjjROwgthvQyDgdMqsrreAUJrJoVMqHIrTZ4OpGYS?=
 =?us-ascii?Q?m6+ndoYzeOV8vtvBiUfOtjOVViOJC8kPwIlr5XFK8dfzZrW43Gocjmo5HLWN?=
 =?us-ascii?Q?V2hM7ttpGy3LPzCh4L8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45713d5c-b445-4095-6ba5-08ddd34ff86f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 12:10:58.0168
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LQLaH0lEXPAsI2HRD2+PVwWsMq/ZlGxiIGZwTpMHAObMHY+Vrj0/C7q5Vi/66wqV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB10766
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Aug 2025 12:11:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17835

Two typos below.

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Richard Purdie via
> lists.openembedded.org
> Sent: den 1 augusti 2025 16:40
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] cooker: Ignore KeyErrors duing shutdown

duing -> during

>=20
> When parsing failures occur, trap KeyError to avoid these kinds
> of tracebacks (from a parsing error in meta-ti).
>=20
> bb.parse.ParseError: ParseError at /srv/pokybuild/yocto-worker/check-laye=
r-nightly/build/meta-ti/meta-ti-bsp/recipes-kernel/linux/linux-ti-mainline_=
git.bb:6: Could not inherit file classes/${KERNEL_BASE_CLASS}.bbclass
>=20
> During handling of the above exception, another exception occurred:
>=20
> Traceback (most recent call last):
>   File "/srv/pokybuild/yocto-worker/check-layer-nightly/build/lib/bb/comm=
and.py", line 123, in runAsyncCommand
>     self.cooker.updateCache()
>   File "/srv/pokybuild/yocto-worker/check-layer-nightly/build/lib/bb/cook=
er.py", line 1639, in updateCache
>     if not self.parser.parse_next():
>   File "/srv/pokybuild/yocto-worker/check-layer-nightly/build/lib/bb/cook=
er.py", line 2314, in parse_next
>     self.shutdown(clean=3DFalse, eventmsg=3Dstr(exc))
>   File "/srv/pokybuild/yocto-worker/check-layer-nightly/build/lib/bb/cook=
er.py", line 2209, in shutdown
>     read_results()
>   File "/srv/pokybuild/yocto-worker/check-layer-nightly/build/lib/bb/cook=
er.py", line 2195, in read_results
>     self.result_queue.get(timeout=3D0.25)
>   File "/usr/lib/python3.10/multiprocessing/queues.py", line 122, in get
>     return _ForkingPickler.loads(res)
>   File "/srv/pokybuild/yocto-worker/check-layer-nightly/build/lib/bb/cach=
e.py", line 338, in __setstate__
>     setattr(self, key, self._restore(state[key], pid))
>   File "/srv/pokybuild/yocto-worker/check-layer-nightly/build/lib/bb/cach=
e.py", line 318, in _restore
>     ret[dep] =3D map[mapnum]
> KeyError: 156
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/cooker.py | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 2eb64ef2372..9f88ae7a7d5 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -2195,6 +2195,11 @@ class CookerParser(object):
>                     self.result_queue.get(timeout=3D0.25)
>                  except queue.Empty:
>                      break
> +                except KeyError:
> +                    # The restore state from SiggenRecipeInfo in cache.p=
y can
> +                    # fail here if this is an unclean shutdown since the=
 state may be been

be been -> have been

> +                    # reset. Ignore key errors for that reason, we don't=
 care.
> +                    pass
>=20
>          def sync_caches():
>              for c in self.bb_caches.values():

//Peter


