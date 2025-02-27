Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1BBC19776
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 02:59:06 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.44])
 by mx.groups.io with SMTP id smtpd.web10.2626.1740625134318877632
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Feb 2025 18:58:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=GhFU4fPE;
 spf=pass (domain: axis.com, ip: 40.107.162.44, mailfrom: peter.kjellerstedt@axis.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJwhIU70GDPwZMgwMO5y43Dnq3rqXB6bMiBq3rVGCy55CKsxqzhYiuPk2VYC4FMPd3jt5K/PZtC1Q1JDNn4cBYKGDzQt1oiFxWCjfgIBiuf0PkuKpkUz7pHhsWu70nOwBaEVNw8f+wum9nXlx+0D/hlzp9qAPmlHHYpptZkyMheXRd0HtY8F8lC+RjClyP+OBZNhhgPkvpVbcm8qXP/JprY/bC83HcpSyWXglBCPdfqrAsjT2OHhATvwHZdhLwI+1qXSEpjicAogf1TAShtIrfCm3WmBYk/KdWSIORUvT7+TdOmT8FtndS/1AXb54fUBjwcHvggBZkat6bnLPKHi7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyF/94GRjbwGd/aucmGH84i5drCedzImpkkyeGAujYM=;
 b=PbaiT+wuCTe+v+zSbxGN/1XoJuoKuo0O4W6IMqKS6T/d+sUB9l73i/kOohNO4j9+/Q18CauggU2PNyJaKkXUpNWeFUnBWG/N4oQxTY5Jmm8Rk+rLx6f6bAbywQqcUdaUD65YzaZuZ69fsqOIT2QcrHyqmcwIEh3jRFGX76gLRAjnTqk8uocNKNkYmed00fiXW4DIqL1krapgajObrpXKREe+S7DoA2d1N2CqzQ46nr59HtqtUKHD5MMwG+rlFX1TtOWlQf5PUPixus6MnqV2PMpJAXBODvCs5PW1kUdHlJ4TvaYHz0cm4o0qLAt08jyVmYDri/PE0Liyz9vrvlvYIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyF/94GRjbwGd/aucmGH84i5drCedzImpkkyeGAujYM=;
 b=GhFU4fPELUGPwBip98Gq2KslMRoiEbDJ8tVQP6J8oIqG5RNojrnvIwa8i1EINUVqF6y+6GSz6xhEwssamfHAilXul+Qjoi8woKohA6mVFCv3JGHtDwRI1mDjpCv1fiaMFNNwLURwvHzwvac1hT63yCrIWmYW0zXUa3A2H2mFI0E=
Received: from AS8PR02MB10201.eurprd02.prod.outlook.com (2603:10a6:20b:63d::6)
 by PAVPR02MB9866.eurprd02.prod.outlook.com (2603:10a6:102:310::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Thu, 27 Feb
 2025 02:58:50 +0000
Received: from AS8PR02MB10201.eurprd02.prod.outlook.com
 ([fe80::90d0:ca74:2479:bbdb]) by AS8PR02MB10201.eurprd02.prod.outlook.com
 ([fe80::90d0:ca74:2479:bbdb%3]) with mapi id 15.20.8489.019; Thu, 27 Feb 2025
 02:58:49 +0000
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: "stefan.herbrechtsmeier-oss@weidmueller.com"
	<stefan.herbrechtsmeier-oss@weidmueller.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: RE: [bitbake-devel] [PATCH 05/13] fetch2: remove duplicated code in
 url decode and encode
Thread-Topic: [bitbake-devel] [PATCH 05/13] fetch2: remove duplicated code in
 url decode and encode
Thread-Index: AQHbeV6W1ihL780LdkaHGXzN8W73ubNab8oA
Date: Thu, 27 Feb 2025 02:58:49 +0000
Message-ID: 
 <AS8PR02MB10201794A0F8A9E55844F4430EFCD2@AS8PR02MB10201.eurprd02.prod.outlook.com>
References: 
 <20250207124701.14787-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <20250207124701.14787-5-stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: 
 <20250207124701.14787-5-stefan.herbrechtsmeier-oss@weidmueller.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR02MB10201:EE_|PAVPR02MB9866:EE_
x-ms-office365-filtering-correlation-id: 1a7a2a71-ff5d-4d3e-e3d8-08dd56daa93b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?cv4u5IVFvjkjN25jtQn01JOF+iHAePw08VQmeo2GFsNhmHtJg8gvtH+AICw9?=
 =?us-ascii?Q?qNgnmSieISVLe3DlV3zqDQUpEz5fnSdlz82XCmdtd3vw/9xOoX8Q9AJoqVwb?=
 =?us-ascii?Q?Fa+MpNQlyb9I9OvEO9PcpEXG8qeEBFTwNAU9PBKUwhw9PORqeO7zOoYUuPH3?=
 =?us-ascii?Q?WsI/FbXpZPcEM/3S/0S15957KtRkcm82NXdNdQtRG6DWEcvxyvC11GrOV3Q7?=
 =?us-ascii?Q?zGh/LtPdBuy7D9msMfICbrHSyyJxxuYEXN5OjCWVu3B8RlmBsSOd7RPpn95e?=
 =?us-ascii?Q?ZrSg7xoiZ2vNt2/rkZqH+gBjqmml5lwj1X29Ib0Tt/id8PV5LDQPnLw1QPwu?=
 =?us-ascii?Q?+8w8UwBhQuiJhordw8w8Q4WWy4MI8t9zoIutmB1EvGmzo6igTQ+v9GrTGSqO?=
 =?us-ascii?Q?OjeqyUyS62r32RzbbmsJ1UKXlCYxbmxq7YGDCD4CEgHfx3T+LBRwk4GEcs0I?=
 =?us-ascii?Q?YEhgIVqVqRIuoFoMdt1VrjWMo8wHdUaKN/7dzF6hgu9XejyzxMBM/OIs37ig?=
 =?us-ascii?Q?glKOYEwijm8vj4AgVqJpWI6Mhi9eUJFdF8wPssyf45a4Cat95DTIAvg2zZgZ?=
 =?us-ascii?Q?Y71y3mIl8W8KC0Z8WGRGHDZ3HM4lR9FRF5XAtOkBd7iZT6AlC+2RnPpKwcM/?=
 =?us-ascii?Q?6F2v48hY7TQ0cbuCKtLvnq935bDozUydqtpAtoa0W3X95D3hJ/EW3qshGcdj?=
 =?us-ascii?Q?c9/O1V83DbQuEzWmPqBskTjDwQOCaxK3vAT/p5E6xF3W+mpcBM038TO6x2g/?=
 =?us-ascii?Q?u8Qw9bxzt51A6lzWL/zXN1WOB6R2l7JTu02xWnhIAqlsKVL5tCcjgCcmeC2i?=
 =?us-ascii?Q?VyXIJokx33mGjnnL6EPNYZrrxHnqWAxx3RZrMQWwfGODBDnrgR1DDYh8np9P?=
 =?us-ascii?Q?lpKs66tajg5UEUNbJRVC1e71MrUO/gJbN5xyqRhvvNORaBSoV/VApiugLgdn?=
 =?us-ascii?Q?5DsgPA3JBHyEw+UIMfKghtK4ssuGBi78lxxTtkgUlN6Jw0F+EJhIoluQfu/P?=
 =?us-ascii?Q?h39wN1haZ6crc9iNiuZSE4zPaAGDgWBP4TfB5ZMxzLr5a7ks5xcbbanxhaEH?=
 =?us-ascii?Q?x5+ecc9pv31goJ4bw5oebYy6h/nmxUgM3P5LK4Nd30XqPga4TxRq09pJNRab?=
 =?us-ascii?Q?CARlWmtU2HoKGTBTUxY/NtkFnMDXi9cnXi0YWkRYRP5Xbri4nRuxsj1h0q4/?=
 =?us-ascii?Q?7aL89HWQWg+GODa0/HwrXh27rOM7+wxHJzginWItlR7xGxIbFc62Vk/YIfr1?=
 =?us-ascii?Q?8QlgTJKosbWF6GiMcT/ddPQC8SVwhMXnvZE9RjSOqu1rUUyk3Fyq6NcyyQHc?=
 =?us-ascii?Q?rrM3h5VQ2bLruvFN1JI0eB5p32PEcNFUdS6yVCJw6aJ/vu76xBn54Y4X6z99?=
 =?us-ascii?Q?m5WP8fbXg55u3pXrg+Mxfspt1//j?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB10201.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?EbI7hArA9kR+B6QQ/sEuuFLkR7yxQ9/KWNVrN0Q+3tcZQILblxrsszlJfpe3?=
 =?us-ascii?Q?ZLt8iRTiP+5BTOR9p3ua8Hxi0v735ycG1JW8wmBLNjrlNNTc7ltyTUCJ7ku/?=
 =?us-ascii?Q?z6zraEZfrWpe9NOpAbumkh6xSAB2JAF/4VdObhibQ+hRUl4nABEyzsTLheHX?=
 =?us-ascii?Q?1pzjH46AQRyiZ7X6O03Hv64poqbswC7V2WaKVPt9pJMB1j9tQUAgsFKifASU?=
 =?us-ascii?Q?fSd6XG9kCZ4udUJzrmZatuGRFVwLAQVmsDCvNaAtPBMHBVuIfN7ZG1Yw5Hlw?=
 =?us-ascii?Q?59qZlxZExoMsEv7ZvA/EcIzWN7gJr/SAHOF0MRvoqAoWRlTvmruBvN3wsJt0?=
 =?us-ascii?Q?Aw3aS6s80bKhRsuPEFkM+TkbmdC9M9WVUIWi4zU9SBIEKWaB7NGXnYZtdJVU?=
 =?us-ascii?Q?12khDVSPEYaCgohoOVE4vaddx9oTTJVEqmPLrJ1TdjXRy29VmoXdYLKx6kkT?=
 =?us-ascii?Q?avxaeaWfV4ELSVm8KPKBM6XJFQEwCjmLGUboOwys8gwJ0lbkj0FB3e2RNNMw?=
 =?us-ascii?Q?PpHRDveoIdu04cL5XngyQ/hojKdogOScmJtUVpxmAS/qU/IK6JBDV0S7i9TZ?=
 =?us-ascii?Q?zZydOqbUVs/ttvZ4TNjCFwNpH3xXUDbDtMZHUHN3T+Ajkhi6JtfYUpZxykci?=
 =?us-ascii?Q?bVINYPoKtdWDcWpbArgcgqObGgZdRf0bqiiOavF5m4Oi5sgLlJ0LNP7X6Tqt?=
 =?us-ascii?Q?oRYPb/fA5J4/ne73HZbcf00q/vEkVOVoBdcxLWmyjG+u8y3bVVBrXkyyMNdG?=
 =?us-ascii?Q?27I+RdU/hA6b/3PoTpAV0wXHhI1hPrnXrudbPPbNOsCqd9Cv2jOhgOAWzvS2?=
 =?us-ascii?Q?uaOrxo35Wvf6iAz6dIkjGJf1h5OIX60TN0dDUtjRCXxd9IF85ja+76f0tc6s?=
 =?us-ascii?Q?RgHZge7YqSNR8m/oiXrhjWnjuUHh8DnHndoHP1r5s0CFvWaNXVB1IGUhegjn?=
 =?us-ascii?Q?J3ezIrwui2IwMAVKCRDGhPdp2ilz9HrQZFnTWCARAnzMhacGYoZxLeGZf49W?=
 =?us-ascii?Q?nuMZ8JnvhzNU6Gzdx5Qg7i3EY1SCYOivvMFdkN85tL1d7kehcvk+IjC0ED3Y?=
 =?us-ascii?Q?ONJMT/A/PHsbvetdaxwgTh8l3Yg6YWKzBWI/B0BZ8Oxp1uCdqzes0f2zo7AA?=
 =?us-ascii?Q?onHVou+tET2/9G0FmT2Nyc/kiWRIN1mg0uESwfME4zIdQVIved7f5Dvc5Tjh?=
 =?us-ascii?Q?PJ7eDO7tvX6cWrW8Hr/nRf+OpT6Mc0e3QBpsNX814vxwJWILbiAZbKMr6h5B?=
 =?us-ascii?Q?DSBZ/0NAY9EibDnflNE06+e5nw1ChEM69BoQDocYnGvhm0Ff7s/sRDkdS4lJ?=
 =?us-ascii?Q?6iQr+t12fh6u5FjY0hybD9VYWerf8sNwpshB+JQkZ4kbPvbobxCZB1MMeDen?=
 =?us-ascii?Q?FdUf2tIvOXVRAGwj5fgeFcpt27aNvQiCUjzVSqyHlbRz1+pPilZw20Hq2h/u?=
 =?us-ascii?Q?1GsgGGWex2qbT5Sxjq+AYaFgjLNkqm31PlTbkL6NYy7PC2x3Emb1UysYXeQp?=
 =?us-ascii?Q?09zjokPNsltyUBG6U3OqQjAGdg9bz9T0HuGlWybWsJ6Z9jM5V6FC4h+jkxQu?=
 =?us-ascii?Q?VZFB95JKI9SvezAQ7Tg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB10201.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7a2a71-ff5d-4d3e-e3d8-08dd56daa93b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 02:58:49.8541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QlfUepS7JMQS3VNmfOimYNpc/a4Yk6G3KhNijiZhuRgWlxObz2zfqeaO+jJ7C+FJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9866
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Feb 2025 02:59:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17335

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembed=
ded.org> On Behalf Of Stefan Herbrechtsmeier via lists.openembedded.org
> Sent: den 7 februari 2025 13:47
> To: bitbake-devel@lists.openembedded.org
> Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
> Subject: [bitbake-devel] [PATCH 05/13] fetch2: remove duplicated code in =
url decode and encode
>=20
> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
>=20
> Use the URI class to decode and encode an URL. Remove duplicate code and
> unify the behavior.
>=20
> Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller=
.com>
> ---
>=20
>  lib/bb/fetch2/__init__.py | 66 +++++++++------------------------------
>  1 file changed, 14 insertions(+), 52 deletions(-)
>=20
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index ab992b7ea..2a60e94ed 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -353,49 +353,9 @@ def decodeurl(url):
>      user, password, parameters).
>      """
>=20
> -    m =3D re.compile('(?P<type>[^:]*)://((?P<user>[^/;]+)@)?(?P<location=
>[^;]+)(;(?P<parm>.*))?').match(url)
> -    if not m:
> -        raise MalformedUrl(url)
> -
> -    type =3D m.group('type')
> -    location =3D m.group('location')
> -    if not location:
> -        raise MalformedUrl(url)
> -    user =3D m.group('user')
> -    parm =3D m.group('parm')
> -
> -    locidx =3D location.find('/')
> -    if locidx !=3D -1 and type.lower() !=3D 'file':
> -        host =3D location[:locidx]
> -        path =3D location[locidx:]
> -    elif type.lower() =3D=3D 'file':
> -        host =3D ""
> -        path =3D location
> -        if user:
> -            path =3D user + '@' + path
> -            user =3D ""
> -    else:
> -        host =3D location
> -        path =3D "/"
> -    if user:
> -        m =3D re.compile('(?P<user>[^:]+)(:?(?P<pswd>.*))').match(user)
> -        if m:
> -            user =3D m.group('user')
> -            pswd =3D m.group('pswd')
> -    else:
> -        user =3D ''
> -        pswd =3D ''
> -
> -    p =3D collections.OrderedDict()
> -    if parm:
> -        for s in parm.split(';'):
> -            if s:
> -                if not '=3D' in s:
> -                    raise MalformedUrl(url, "The URL: '%s' is invalid: p=
arameter %s does not specify a value (missing '=3D')" % (url, s))
> -                s1, s2 =3D s.split('=3D', 1)
> -                p[s1] =3D s2
> -
> -    return type, host, urllib.parse.unquote(path), user, pswd, p
> +    uri =3D URI(url)
> +    path =3D uri.path if uri.path else "/"
> +    return uri.scheme, uri.hostport, path, uri.username, uri.password, u=
ri.params

Unfortunately this does not work if you have a MIRRORS/PREMIRRORS with a=20
regular expression that contains a negative lookahead, which we do. We=20
have the following in our PREMIRRORS:

git://(?!our\.internal\.git\.server).*/.*    http://downloads.yoctoproject.=
org/mirror/sources/ \n \

since there is never any point in trying to fetch our internal repositories=
=20
from Yocto's server.

After the above change this now fails with:

  Exception: re.error: missing ), unterminated subpattern at position 0

since decodeurl() has stopped parsing the host part once it sees the "?",=20
which the old code did not do.=20

And while regular expressions with negative lookups may be a little=20
esoteric, this change also silently breaks all the mirrors in the=20
default MIRRORS that use npm://.*/?.* and https?://...

My recommendation is to revert the change to decodeurl() because the way=20
the regular expression "URLs" in MIRRORS and PREMIRRORS are written do=20
not match the expectations in urllib.parse.urlparse().

>=20
>  def encodeurl(decoded):
>      """Encodes a URL from tokens (scheme, network location, path,
> @@ -406,24 +366,26 @@ def encodeurl(decoded):
>=20
>      if not type:
>          raise MissingParameterError('type', "encoded from the data %s" %=
 str(decoded))
> -    url =3D ['%s://' % type]
> +    uri =3D URI()
> +    uri.scheme =3D type
>      if user and type !=3D "file":
> -        url.append("%s" % user)
> +        uri.username =3D user
>          if pswd:
> -            url.append(":%s" % pswd)
> -        url.append("@")
> +            uri.password =3D pswd
>      if host and type !=3D "file":
> -        url.append("%s" % host)
> +        uri.hostname =3D host
>      if path:
>          # Standardise path to ensure comparisons work
>          while '//' in path:
>              path =3D path.replace("//", "/")
> -        url.append("%s" % urllib.parse.quote(path))
> +        uri.path =3D path
> +        if type =3D=3D "file":
> +            # Use old not IETF compliant style
> +            uri.relative =3D False
>      if p:
> -        for parm in p:
> -            url.append(";%s=3D%s" % (parm, p[parm]))
> +        uri.params =3D p
>=20
> -    return "".join(url)
> +    return str(uri)

I believe using the URI class for encodeurl() is fine so this part=20
of the change should be ok to keep.

>=20
>  def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarbal=
l=3DNone):
>      if not ud.url or not uri_find or not uri_replace:
> --
> 2.39.5

//Peter


