Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 711A2C7EE22
	for <webhook@archiver.kernel.org>; Thu, 11 May 2023 14:43:26 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web11.60984.1683816203224248051
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 11 May 2023 07:43:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=kZKrQOr7;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683816203;
  x=1715352203;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ob8zHeF0uPQJ6W2I3vXW0bi5UnCMBkFun0WZsB8taB8=;
  b=kZKrQOr7TfTsfSCci2Vk5pmuhEWItaBStdIEmA3TZF0mGbzoAlJxyDKu
   xFoObugDXHCCjUDNwHuGjtYtAeaLHlrwthDEUzEI2dzPMPOs4ypJ83bMs
   zJiRFEeywG8MbRZ/U9UdZkT2YU+zp7UakWmhoNIDrdB4Ft1FIm7GL0Fek
   SopoqG0/i84jzsZC4HIQ572gmeiaEkcvyWbroDnArSf7es/9YgIamamzT
   XdV/s180wrP4BhzRsKJO49Ccs9Zz6luZxHo3PWrcTAx048JfO2XUhH93h
   IXX0tB+lTlh/IKFuxBxlJNDAT+4raHITWOZ2iTYFMyllBvCWYtZBRN5dt
   w==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAB57i7SBzOqK2U/Zoc7ApJ7y+wL4vd44Qtgx2+4iMKed/Z7V7Blj3bwbJ+b3kGGcIXA6DQ+kfVraWQkEll0BM11JdkKRSsiSiDg3/RGZSXEAGZvmR0N9gt8Mab/qRPYCaB1uv2nYEYYII2gF5LFWiKejRFNEw23PH/3GSqM1r+Mg3XG/8u7zHCbRHcwZOaLHUaPD4LhG1LpNAoCkyBSgCSJhZxRfiF7MLNUDMotDjYdZOnjtWqeGdTElq/kroRzRdujQYtpDJBr8b7mFXdNHBAhnvngFZz4hdULQHe8+jXmnMSI5/Eam6yo5PGsHB8XQA1J0n2q7psyoRRSkfHCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ob8zHeF0uPQJ6W2I3vXW0bi5UnCMBkFun0WZsB8taB8=;
 b=GfvxsgVP3Bwyzyn84sRMXKLbwxyG35124mdgJWcPYzGjGDi0SSvDzTcOc5ieTm9q/AWiAKWMWEDUCw42JO4wBAtp0GVw/42A2fkVLW3KH4qH0KbPg/zhC/Bbb0M8djaRGpV5YBSIzZQDzwCgT8lIby7isGFxyVTuHWgHh3DgkSPULjtQHqp6o8Vey52COhcmVwI+ZlrDBMkV1CGO4uUF3vaJzk1LLgEpqOzALPxAiR5qfmtHYtephcAWYhwad9bbNAFXOSObHz/DKK6akk3ddkoaJKhc0qhLYldZSdHVUjl/OsrmHngpSit4ASCd4joG0kCISllWl6gux1KEr80yaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ob8zHeF0uPQJ6W2I3vXW0bi5UnCMBkFun0WZsB8taB8=;
 b=lMZRqwGIx3OzFrsda08LIVmEI6G5jJOy3+0Gge4kCFbjqS2vV4HoWMiz2oO46L9BxzYakZHk1hM3SZDobV3kEWpJ/U+mhVvn2EyNuy11Vv5gTQkTv2IOfc5X7wpFOBt1ZXkAVwPrfnxC38N/jJouydFFJooGPwj1vRGoyGBitok=
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] cooker: Fix/improve collections handling
Thread-Topic: [bitbake-devel] [PATCH] cooker: Fix/improve collections handling
Thread-Index: AQHZg37r0Tctf+HRLUiap9RtezyKQa9VJZFQ
Date: Thu, 11 May 2023 14:43:19 +0000
Message-ID: <DB5PR02MB1021331281BCA5B9A6C5C77A9EF749@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <20230510203459.1758249-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20230510203459.1758249-1-richard.purdie@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|DB3PR0202MB9058:EE_
x-ms-office365-filtering-correlation-id: bc22b95f-5e37-4e3e-a7a1-08db522e1010
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pSklXJhet2plOgmkGKX/UDxu05v9PtBxKVwrlRducPSWFXnqrv8uT0kUqE/WjLEQv9MOVvKc/o93Xrf4O/IaEg82nDGTKaRmCNSXoO70hgwvHLxpQZtMYWKuvXbRNa+EFvgxzIQCnynh8jTvRl6lghJtFcPoWxkGCEmI9GBVsT+buNTj0Kxvc32+oc2OsmdzixNge+BOO/k1nwVtjzRt+qWyG2uTdjbGWXxgSzSf3PFXdVUHnW1vcuJ8co/tTFeuUtbBEUgHDvz8f+OT6Gau4nVnm9uTvwk1a7YIFAgZFmD2dlXoehXsgmlAYbrLsUsRSq1+IeX3RM+pBaLr0vqq/vX4EArNSpaXWte7AbNUin26LzCvEBpvlHwKiFUTgToCu6sO69/96YIbc72iDExMU8XaBcaT8PZ8/plUaUJh0Za/ITCsyxLqSxO/zzBZKHtCnhBGZKwZyGGe9ETNYb6qAaeNmy04HiqG/OsHYsej8yHDnGro61fLtAGco/2qco9qRDkAv8aPFKe5KZho65nrEGjNIY+lX/97ko73qxL2LeGOuSkdNwUYiM1MOUTkUZgIBK4e0/80HFdAziZ8zkfwLC0P3vrurKU2V/WRM5M8RXpLTttVyrm5a1c5V5GBJXQl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39850400004)(366004)(376002)(346002)(451199021)(86362001)(7696005)(33656002)(64756008)(316002)(110136005)(478600001)(76116006)(66556008)(66946007)(66446008)(66476007)(52536014)(8676002)(8936002)(41300700001)(2906002)(5660300002)(38100700002)(122000001)(38070700005)(186003)(44832011)(26005)(9686003)(6506007)(71200400001)(83380400001)(55016003)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZFSFfXiiNRQN//KDCaxMvfhEGsWLi2HNPh6ETyFGHaGriTvbhTA5ONOg9rET?=
 =?us-ascii?Q?9/qXz7sRNFhaUTdYq/8ps5YLd5rBbTPnAhVgsBmxSZukyH04XENy3CYVkcKE?=
 =?us-ascii?Q?d9ep6qkeTFMJa6wWoC0b38v/aXXVLiWepBTrVU1EKLgZrP1IA2DovZqrEdsd?=
 =?us-ascii?Q?qWM+WTzXaawOE+Qqmm/9D3AzUxmrV5d+0vUutUSa3filGtmadFQ/g6A3CyK1?=
 =?us-ascii?Q?5+kw+eTeRtny5K0gflQrBNAAL78a8x2aHzED1AsEBXz0b37LagrQNFrFwkZl?=
 =?us-ascii?Q?pA7dcM3hY4TP8nNE91n27rv6sdTLLu9vomytkObOL+85TXGF/zhDduqaKuAV?=
 =?us-ascii?Q?SwT2kSkf+AIPKahPWtig7Q2YUGDV5/Q3vQIkhIKyzxqZYPyQ+0u9kqGqXGSF?=
 =?us-ascii?Q?98aYIZN1X5U6KLCSUY0DBznJJ3/e3qpgr/Hrr5Nun8x0NZWxZffMBFkvxMaE?=
 =?us-ascii?Q?QOynldRL20oAVvcswoexbEtL1qs3dBcFJLonXvHm7kFe2eu4fkpdD+/xBAeu?=
 =?us-ascii?Q?eHeIYGPjVKyZEK79JDIks2QCE9IonFJQ3mWKF6xrTtARWrdt5025bUasJfRx?=
 =?us-ascii?Q?e09nrCfyeqljsEzVYszdZn9fTzvrCqTPI8bN397UmqW/4ytY7V6c7RiKJAOB?=
 =?us-ascii?Q?S/2iH3Plb/fQANRWPacUBmXLvS1eNIfTOigatIjfG+G+sIGsCjHxGp/YbC+Y?=
 =?us-ascii?Q?+yOlm8RK9R9g5+gI5ngA9GNw0ExtJVNnvetplXPdcGd4FwxktDlQIcSLAp3S?=
 =?us-ascii?Q?MGYEALGWSy4GuHWtNiU9n9kbL0xCSHl1aBikBETNb343yvCR7WLELRG5yw63?=
 =?us-ascii?Q?Dx9CcHEakK8hOakcrnxsFuXl0eXi68PoOit0xQ5la1LRo7Dq9Aa1e2DBwu4N?=
 =?us-ascii?Q?+krscRVilcZOBA3BtaEKfZtbGwbn+dz+Z3cCIVLyfRV12pgdfsGxeQeQmuyw?=
 =?us-ascii?Q?UaTGrvNqCT0N6GfEqAzmemo6wJWDsanqF5BocdLIYDIgmnVnOb3uNhYPifeN?=
 =?us-ascii?Q?L7ZKVEPncLPCgkEmB7lMtQ1JRcmSoBlWwZUliS+QD7RtNlH5s/M2TsGBZf0H?=
 =?us-ascii?Q?G6xhN4PzDZOqcMyY09uGNCmmRo8+IFy7eTEEosDLgpXbIhuIiMDXsrZNwtBJ?=
 =?us-ascii?Q?+d64YUFvFexKey1URP13XpQolB8mruX0lRE96rGPkMc0Fg+dBCJa4vDGLEuz?=
 =?us-ascii?Q?1H8+MHL6l57GrK0Xc7gmefdUNSQWYDsfGCdQS9luWoH9FLt2WZbJnrE+GBME?=
 =?us-ascii?Q?PP0GBOIKVLEokseJujKwSeJjY+u+iQ2GsQ79xmQ4VmPXvhtrQN6NUs2xQ2Sp?=
 =?us-ascii?Q?65Ze2xt0v+a+ziEfoytUwIe1Yvrln9mGnL38Gm7pffHtwjWBf/cYeWI+gFNK?=
 =?us-ascii?Q?smsV0tlGvl2OcBaFe6C+mlQhPfgEedzf2eOis5enySjCto2eMBmL3rVsT2H4?=
 =?us-ascii?Q?CBIRU62HNhLdOfiH3HFaGwbES97bmHdDWM9JSKAydtyeRVk7HkXOZb59vL9z?=
 =?us-ascii?Q?yiHBdMeSL4qD5OR7lM+Ep67pyvmbTg+AUFvpF8oij54fX+xXJeh8SbiGjjbI?=
 =?us-ascii?Q?5Q01Bi1C6qYZ/ERhGpE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc22b95f-5e37-4e3e-a7a1-08db522e1010
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 14:43:19.4230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RAAWN7GgD9uYFGmFgItV1JtcDwGHzG9jpxyXzy/PCyZdqE+sO9UFNJTqQbM3aPAu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB9058
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 May 2023 14:43:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14783

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Richard Purdie
> Sent: den 10 maj 2023 22:35
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] cooker: Fix/improve collections handling
>=20
> Code changes for FILE_LAYERNAME exposed lifecycle issues around the colle=
ctions
> objection in Cooker which only appeared in devtool usage in eSDK. Move

Should that be "object" or "objects", rather than "objection"?

> the collections setup to an earlier stage after parsing compeltes to

compeltes -> completes

> avoid any kind of race around it.
>=20
> Also stop overwriting the code variable in MatchFiles. Ultimately we
> need to combine these codepaths but that is for another patch.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/cooker.py | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
> index 3e298c478b..0a21f1c2f8 100644
> --- a/lib/bb/cooker.py
> +++ b/lib/bb/cooker.py
> @@ -504,6 +504,9 @@ class BBCooker:
>              self.recipecaches[mc] =3D bb.cache.CacheData(self.caches_arr=
ay)
>=20
>          self.handleCollections(self.data.getVar("BBFILE_COLLECTIONS"))
> +        self.collections =3D {}
> +        for mc in self.multiconfigs:
> +            self.collections[mc] =3D CookerCollectFiles(self.bbfile_conf=
ig_priorities, mc)
>=20
>          self._parsecache_set(False)
>=20
> @@ -1379,8 +1382,8 @@ class BBCooker:
>          if bf.startswith("/") or bf.startswith("../"):
>              bf =3D os.path.abspath(bf)
>=20
> -        self.collections =3D {mc: CookerCollectFiles(self.bbfile_config_=
priorities, mc)}
> -        filelist, masked, searchdirs =3D self.collections[mc].collect_bb=
files(self.databuilder.mcdata[mc], self.databuilder.mcdata[mc])
> +        collections =3D {mc: CookerCollectFiles(self.bbfile_config_prior=
ities, mc)}
> +        filelist, masked, searchdirs =3D collections[mc].collect_bbfiles=
(self.databuilder.mcdata[mc], self.databuilder.mcdata[mc])
>          try:
>              os.stat(bf)
>              bf =3D os.path.abspath(bf)
> @@ -1678,13 +1681,10 @@ class BBCooker:
>                  for dep in self.configuration.extra_assume_provided:
>                      self.recipecaches[mc].ignored_dependencies.add(dep)
>=20
> -            self.collections =3D {}
> -
>              mcfilelist =3D {}
>              total_masked =3D 0
>              searchdirs =3D set()
>              for mc in self.multiconfigs:
> -                self.collections[mc] =3D CookerCollectFiles(self.bbfile_=
config_priorities, mc)
>                  (filelist, masked, search) =3D self.collections[mc].coll=
ect_bbfiles(self.databuilder.mcdata[mc], self.databuilder.mcdata[mc])
>=20
>                  mcfilelist[mc] =3D filelist
> --
> 2.39.2

//Peter



