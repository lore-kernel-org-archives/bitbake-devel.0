Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB3CC76196
	for <webhook@archiver.kernel.org>; Thu,  6 Apr 2023 03:40:42 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web11.150498.1680752432042452905
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Apr 2023 20:40:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=j9Vx7VlZ;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1680752432;
  x=1712288432;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3F61IFxc37Mteqtu5XhLEYplQD6e7aANrms37Zxspwc=;
  b=j9Vx7VlZh93rsVRSDVGSRs14jsnjMaTVqh9C8g7JFk+fbEOtAQ6lf3jw
   kB61SSdCEMKxLaON/1sdUdG7Bz5hHNu2zQ+OQFjRoDHRpfQPRoSGwMlMx
   1FqN1P30EGVVRMbzFbLqo7FmflQTohKHWifQV5tF3hMiIncY1HPFYELPv
   QH8hHbqV7o+vIPU1u4oV/6TT3l13dYgfXQlLZw0sVD7gDZoWcFZC3yp+o
   4v7Z0NFPE8MMjMtN7dugd5ICGajCxGxnvTkLEmCLQmkV5PPjXngJXga3V
   vjqJgWN0jJvumYanWJb3yMuyqHYcj98MtYtwQgQSxrzqOVkUNBWEtpiQe
   Q==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2sS5a73SuX9kc59t6zEFuGjgZsK1GcNnw54UXkXLYWhTzhbxwvaDPMMm50lzpBssxJ6QGwuT0FCmRQWicAkmlMqmjjkj5dUOIIpftYtsXfXZv3zyUqLkjieP0jaDB9ee9HH97boRhbnD8T+6nt5BgmWTCrtr0bYVt73rYrRS6EZe4c4BeQiBv/8yJWWT1wIz3WQjFDfO5lLB1Bn5pfrYUyGXS0CQKau3MrlNR1lCRxB0O3yHI0KTy6KskkLt+7NCo6aWbZ2RKNNIX0bOKcgSpCFd/Ze5gvkX+VtPSNBYZttaLyVdhtYFBve3r+MZrM8Fznnc742qng7D4DXnnEs2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3F61IFxc37Mteqtu5XhLEYplQD6e7aANrms37Zxspwc=;
 b=boaiL5KAbV+bptiaOd9wo73kDbsgVDBydFaitKNe3QIkPoBR2mogYxztHyWVCzGSl0NcV3cQeqQdLMEJEs+utOFoRew8iZYYf47/H7rDqYe0zjzAbiRfRZIUixYGR+fC0FvVZFbd58WJavEtVo/BzSrY4VU3SGy/KzQ0BDo0/8WsLgbVVB/9I5Rn5sPdgC3XszDWFlAQEBHwZTshS+sUj6/mm+hh5JCR02NhNQ7Dl9F47KdCBRXHgjrd78pl21EaB9xG1SsNApYWedueUsYo3j0evJUMszKkwuFDFr0QCW8ETr95B3FRAt3EFP+YnVwaZK9XIGPzTyHMI/6KWTp3OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3F61IFxc37Mteqtu5XhLEYplQD6e7aANrms37Zxspwc=;
 b=xA0PbYXuoWEN9E/3ojYvvACdGLOUJZVzkez5s1kWnXLMDMyDPD+b3eJ1wpe5YQg67oNpOwmeBOWDhwKcC05WUB9vEGuWQY+dcWmJ7Z4RAjuavNTFLUqIWZJtor+w3Kp7N4gc9NdCCLyq5+dCxfr0w4c8gY6rNF/n1FAoqilv03c=
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Steve Sakoman <steve@sakoman.com>
CC: Frederic Martinsons <frederic.martinsons@gmail.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel][PATCH v2 3/3] crate.py: authorize crate url with
 parameters
Thread-Topic: [bitbake-devel][PATCH v2 3/3] crate.py: authorize crate url with
 parameters
Thread-Index: AQHZWKlEMyO8sRYQxUK+C8NUZJA/aq8dv+zA
Date: Thu, 6 Apr 2023 03:40:27 +0000
Message-ID: <DB5PR02MB10213D211F48E6ACF5D4505BFEF919@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20230317081916.1857201-1-frederic.martinsons@gmail.com>
 <20230317081916.1857201-3-frederic.martinsons@gmail.com>
In-Reply-To: <20230317081916.1857201-3-frederic.martinsons@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|DB9PR02MB7306:EE_
x-ms-office365-filtering-correlation-id: 3b82c82a-bc69-413c-a182-08db3650a9e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KZBnikwkzqG/lciNeYK4TZKJmlEKa4ApqR9kSut1x0yVv0bLvBwQTM1DKG8QsSuUSphwwBk7Xe6Q/Rjwutv+2Wt1nCgdCV39ZNUnMLDCy7BKK44WvQjSO289mah41HmDz80f+BsWq4j6ZdFw4v6F19xeqbOKDzWplcdTVaLK6UTURauDmJPzRCA+L5/WIIYhdDfqrgYvbWzFTnu4z4JfxV501O4PrLd9rur4pwREuHkksAjE1I7rpea3qIoA52vnddpi6gcxJ1SzwlFTGwDQa6qMrKvX0jDypGyLMojhw3ng/4/ccEWqQ+Yd8TDgjOyGYDCsGwpDKRCStMqK/L7xUNk66x8j8s4noP1e/5R7aCFON354d5jIIqaTolEjHPzV07oO9OgwF/Pie890LPsVMX2m5CPexpe65P6Dh1VSFPeeU1key7AZswTP8PcHNNiopvZ5s+8ASVeVEk7iH3SJgs8rV4mWc6D4kNnZGVkfs+XREXSvTMX5QUduRQ4W8QEZemSFLsaaEznNCLIw5+n9Z4QQZOm9wzwTLbaiwtHD8NNppQSX1cO3QgHBDxNZycsx46CyNTqHrJrA4Z0c0/DXmMQu4xh8s27qlLuqkiVLW9FBURIFcJZ1dQLOfztAHa3e
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199021)(71200400001)(86362001)(7696005)(53546011)(55016003)(83380400001)(38100700002)(38070700005)(6506007)(122000001)(9686003)(33656002)(186003)(26005)(76116006)(316002)(8676002)(2906002)(44832011)(8936002)(52536014)(41300700001)(5660300002)(6916009)(4326008)(66446008)(66476007)(64756008)(66556008)(66946007)(478600001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qD36PMKGtvgHLnUZYeZcyzTEGO9DxUh2f0dIEjCm94oipWHaMXVZr8mAje3u?=
 =?us-ascii?Q?ADbFJvefMqX/rWhBX+ln7DH7fqMq/hHE1jX/LCqHbi7lalt9wn9hnfeQ+lYZ?=
 =?us-ascii?Q?y2ZkgoIw4Cczs/8RjXXlWHHovGsTSsbtJGhFdEAXIfhQ/e6WcouZhAeCiBi6?=
 =?us-ascii?Q?iI78x5HXxBaQd/z+aNWnItkCWX/GX/EWmfb+Gq5TvFw0TBnsYinqFoL9sTBc?=
 =?us-ascii?Q?kTOvsE79YhhuLeOSz1YpHXN5fVcxuwMigVfkn6d8Q0MohS8/h9Z8PML1UwMa?=
 =?us-ascii?Q?FhrVzITtkm7uz3JfVolHZoC3UljlGRKxnCB4JudLwJrWnAIRfMeTso/Sirs0?=
 =?us-ascii?Q?gVn6/pWm6Br32Z7IiGnj7/HvM2CsnSlerJ13umi5ehgGNmapJhVccV6glWGK?=
 =?us-ascii?Q?GXhgT2qtQEwUQgDo13X3wXf3Ib4MIwyTLJ2Wdvf2W9wwvIHJQySCdEg5ddFe?=
 =?us-ascii?Q?CqBs3rUTuzyCnruOPjGa6LLj8gHA7tlhUf70hInDAum4cYkvQ34erilDCitH?=
 =?us-ascii?Q?J8EKr1aX/fPAUg8TzvKhFJL0Ydqqfb3Tx7/YgE90Ot6CcpSz3K/twWf+FQLm?=
 =?us-ascii?Q?D2jA2yC0GV1y8pSJc1aldawLZtYn3wusEpkzikBIp3/BrN2H0gCNyY4mEBFh?=
 =?us-ascii?Q?lUziA9E1ql1Czs2gy04nkP3KzOVrw6WROg3gJawemseb/s36Az/exRqiKkmt?=
 =?us-ascii?Q?LNjTO4qMmnbeq1PijsA+QGgn4WNWmZv+YQfOtdwD8fLgOe7Q+Sa9eNfSNjkV?=
 =?us-ascii?Q?0yRNjvNLCKGlArJbovqItOYBFmP+DE2bSoFfaspuLgvLTqrzt5g/hHBRXw+6?=
 =?us-ascii?Q?SGbCwlfPuwP10K6SBHup4isjbH/Bt/V4iLtboKcQI0ztvwzMBgWyjFsRmzTT?=
 =?us-ascii?Q?CYOGDpRm3pIsoe87nqp500drlnDZy6e3a/z/oYRy8pLcaEP0ucPFMtqfpXTP?=
 =?us-ascii?Q?vS/VkMqlaJFlzumFqMHiPZvAziz/FcqxAC21GBop7MFuzk9D3boeraE4kAhF?=
 =?us-ascii?Q?Ebbw2SwqAJIuE7352IDgs/Ljjl0Ip1TF+atGN4XuKSEOvplJW3vR9wn40OVi?=
 =?us-ascii?Q?jH0UFFDnGsVxpUrHqspGbHj/r4KdHx2Cft1LqUaBbRvUVOT5p9ezCvNepsS4?=
 =?us-ascii?Q?iJkhr6E/n6vsTv+ql+DFIeKIkACoQSkTsXH+KGUZN+VMcxllyENFE/i7kDwh?=
 =?us-ascii?Q?SvhUwZyWD9HN3jmHs7kmy7tkoQa9t48aov299B+E/zf47XFiYE01bdg86hbQ?=
 =?us-ascii?Q?O3T27jndaTpVf3A7XtoHXD2+EfhshSfXupjVV6y9nSt9Ecnj880GZPs4oscb?=
 =?us-ascii?Q?zLgCei+AXy7fBjNuFC3+OaXbDcLw5vXDcR3qmf1FFZceb2z6Ab91KxWRnrgU?=
 =?us-ascii?Q?ez68HbxPT8+6CzXP2Dbx+23vwpuQuDopFxjF71LRyij95cy3wfLDjBy3QwSW?=
 =?us-ascii?Q?zhPvMjViUxJkQCeQa3/CQmT7p1uTdWo7zeNebOc0lImB1XAxzT6lVYFr9K+q?=
 =?us-ascii?Q?+iyVHzQVVL4evDTt3T3jwOi11/FchllthnAYBgtQWVqOHQmFkS6Yq4CxhIg3?=
 =?us-ascii?Q?KzXFNM50sQ4TvDUD4xE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b82c82a-bc69-413c-a182-08db3650a9e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2023 03:40:27.7943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pALyxfiw/R6ukBtkHJEVdvFUs51d7+Bfa5oZmFA8qxr6p4uWBe/QE0Y3RqFtdKrL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7306
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Apr 2023 03:40:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14663

Please cherry-pick this to Kirkstone and Langdale so that they can read=20
updated recipes that use crate:// URIs with parameters.

I assume it should be ok to cherry-pick part one of this series too, as=20
long as you do not cherry-pick part two, as it would be a breaking change.

//Peter

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Frederic Martinsons
> Sent: den 17 mars 2023 09:19
> To: bitbake-devel@lists.openembedded.org
> Cc: Frederic Martinsons <frederic.martinsons@gmail.com>
> Subject: [bitbake-devel][PATCH v2 3/3] crate.py: authorize crate url with=
 parameters
>=20
> From: Frederic Martinsons <frederic.martinsons@gmail.com>
>=20
> This allow to have classic fetch parameters
> (like destsuffix, sha256, name ...) not being
> considered by crate fetcher itself (and so mess
> up its download)
>=20
> Moreover, it allow to overload the name of the downloaded
> crate (maybe usefull if there is a naming clash between
> two crates coming from different repositories)
>=20
> Signed-off-by: Frederic Martinsons <frederic.martinsons@gmail.com>
> ---
>  lib/bb/fetch2/crate.py |  9 ++++++---
>  lib/bb/tests/fetch.py  | 24 ++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 3 deletions(-)
>=20
> diff --git a/lib/bb/fetch2/crate.py b/lib/bb/fetch2/crate.py
> index f8367ed3..590dc9c1 100644
> --- a/lib/bb/fetch2/crate.py
> +++ b/lib/bb/fetch2/crate.py
> @@ -56,8 +56,10 @@ class Crate(Wget):
>          if len(parts) < 5:
>              raise bb.fetch2.ParameterError("Invalid URL: Must be crate:/=
/HOST/NAME/VERSION", ud.url)
>=20
> -        # last field is version
> -        version =3D parts[len(parts) - 1]
> +        # version is expected to be the last token
> +        # but ignore possible url parameters which will be used
> +        # by the top fetcher class
> +        version, _, _ =3D parts[len(parts) -1].partition(";")
>          # second to last field is name
>          name =3D parts[len(parts) - 2]
>          # host (this is to allow custom crate registries to be specified
> @@ -69,7 +71,8 @@ class Crate(Wget):
>=20
>          ud.url =3D "https://%s/%s/%s/download" % (host, name, version)
>          ud.parm['downloadfilename'] =3D "%s-%s.crate" % (name, version)
> -        ud.parm['name'] =3D name
> +        if 'name' not in ud.parm:
> +            ud.parm['name'] =3D name
>=20
>          logger.debug2("Fetching %s to %s" % (ud.url, ud.parm['downloadfi=
lename']))
>=20
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index fd089bc8..85cf25e7 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -2423,6 +2423,30 @@ class CrateTest(FetcherTest):
>          self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bitba=
ke/time-0.1.35/.cargo-checksum.json"))
>          self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bitba=
ke/time-0.1.35/src/lib.rs"))
>=20
> +    @skipIfNoNetwork()
> +    def test_crate_url_params(self):
> +
> +        uri =3D "crate://crates.io/aho-corasick/0.7.20;name=3Daho-corasi=
ck-renamed"
> +        self.d.setVar('SRC_URI', uri)
> +
> +        uris =3D self.d.getVar('SRC_URI').split()
> +        d =3D self.d
> +
> +        fetcher =3D bb.fetch2.Fetch(uris, self.d)
> +        ud =3D fetcher.ud[fetcher.urls[0]]
> +
> +        self.assertIn("name", ud.parm)
> +        self.assertEqual(ud.parm["name"], "aho-corasick-renamed")
> +        self.assertIn("downloadfilename", ud.parm)
> +        self.assertEqual(ud.parm["downloadfilename"], "aho-corasick-0.7.=
20.crate")
> +
> +        fetcher.download()
> +        fetcher.unpack(self.tempdir)
> +        self.assertEqual(sorted(os.listdir(self.tempdir)), ['cargo_home'=
, 'download' , 'unpacked'])
> +        self.assertEqual(sorted(os.listdir(self.tempdir + "/download")),=
 ['aho-corasick-0.7.20.crate', 'aho-corasick-0.7.20.crate.done'])
> +        self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bitba=
ke/aho-corasick-0.7.20/.cargo-checksum.json"))
> +        self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bitba=
ke/aho-corasick-0.7.20/src/lib.rs"))
> +
>      @skipIfNoNetwork()
>      def test_crate_incorrect_cksum(self):
>          uri =3D "crate://crates.io/aho-corasick/0.7.20"
> --
> 2.34.1


