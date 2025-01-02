Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAD4E77188
	for <webhook@archiver.kernel.org>; Thu,  2 Jan 2025 08:28:06 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.121])
 by mx.groups.io with SMTP id smtpd.web10.4558.1735806478789164099
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Jan 2025 00:27:59 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=2Qp7uOrA;
 spf=pass (domain: weidmueller.com, ip: 40.107.241.121, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RW3JozgF5M7wGzVSFp00NmK3cq6HyjxUZxvhXSl5PyIVleK5VGIz/oE2tTF+m7s/7P+UHExwx4bKHzcjxa/yu/SV2L7SIr2ql5mSqCdI5hcNwx9iZdfB+oALIDv/z33vKET94ceZStp8dUz242UoP/M0m9ope15wr5c4U0/MZ5SSjLcQlIyh0FWyWa3q4uejqipExBil8HkIhpKuOhU6QeBjFNw20pRXiUb+XeYW0cIyj84lcAwdkkc0F75PanxZ6GCFLMLUynGz8YphgA/1L/B7D0g8kD5JiKBODSuEL1302pNQJvNe92L4i1PmANtSv8UfImA8q69blq2EzD7TZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xk5oaFIx1e4hpavQ+EHPPd5YNRvND00hqdOBrI989yk=;
 b=hoWgQExjgxMFsQXztPe7jKKdarJpUP3W7Tut9afO7jw2IB7kgJHDugnCZu/LJu/FE3OARakD1yZ/XnKASIvvg5G9WZCc6+rcug+hm8R4gNHefIdavSS90smzaqh3r+jYLy1m9G7x3699CEAPlQ87Ju1zZRn/WEHk6GasQttwnvTEu7SvxkxTnjDMERSY7UPsw6+3gU9Fbftr/XNXkb2COyqxPfd3WZd1UQ3PTs6+1ZIy57Eh2qMLIbZRWXHmi2zc+kPZKIT2jTacQxeCECVL/ckM4uPT8cFIBUqhmUGx666tb2qPpalT2hTBg+ddS+n2t+Vtu9SLpu7tQ0eYMFPEqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xk5oaFIx1e4hpavQ+EHPPd5YNRvND00hqdOBrI989yk=;
 b=2Qp7uOrA/94DpLo9nXceEvGWTe2z/SVzhnLqr0htHNpScuB7kbzpNDg55aRASXNfkF91yJueJ9KISqkxGV1byjfqTxbNrPCIIhPL/duZfm4kMZ73GSkdDrMVV4mYhVbGTW/K6vOG4dYepdGOsnFtc26NaeyHcerOKzzosgRrEVunDuC0Gc0FPc/kLQ7vht8qWKdihu504KmSj3wWWWmej4hlDiGoa1ypIvfM385tkMolIXYChAQ8SJgwiM2/t2ZasJSVF79Gz8JSBYPI0o1o+kT3O5Mb6y9XxD1zhz6J0ZFrjySIkZ54TzOZDZrD8dVfy8X/vts+lCvVwyOLtK/yzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by DU2PR08MB7357.eurprd08.prod.outlook.com (2603:10a6:10:2f0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 08:27:49 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8314.013; Thu, 2 Jan 2025
 08:27:49 +0000
Message-ID: <f22e3939-01d7-4d84-906f-b56c0f972fe5@weidmueller.com>
Date: Thu, 2 Jan 2025 09:27:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 08/21] utils: add Go mod h1 checksum
 support
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <20241220112613.22647-9-stefan.herbrechtsmeier-oss@weidmueller.com>
 <6e8dca0b11a0244465ae530cb698f6733cc17f10.camel@linuxfoundation.org>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <6e8dca0b11a0244465ae530cb698f6733cc17f10.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::10) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|DU2PR08MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: afd8bcf6-cba1-4c7e-42df-08dd2b0757cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rJiZav4PJV6p0VID+wm5buIGFvybs4pv59TyEvBgFGpo8Z+loyF6yspU6Ar2?=
 =?us-ascii?Q?qJ5St4F1Cbt/W5keSdyEpY0gtR77HnwP1SYY2t2cHVvpKVfp3wl0Xz/uv/gY?=
 =?us-ascii?Q?UAmJGVgm/MwMTZIjAPNx9e5wS2ef8BlIC7IJRWOEe7jAZc9EVmJi1UUCjNUE?=
 =?us-ascii?Q?R42SDxZJwPfpQSS5oVl4lbgcUeORf02ExEmJi1MSVrIKrNkMZsGKFIto7MWi?=
 =?us-ascii?Q?TbCi9ysh1j0lqSb/biVuc0jzVjI61Y9s9Drs4FJ/HkmHc51vLVDsNE43WlOg?=
 =?us-ascii?Q?Gfrqh0g4Z9pUzdqDWcCdo5KgPEgFJRgExTaplvrWZYVs3mkBLeLGAgZ3CAvf?=
 =?us-ascii?Q?49UquBTyGdafuLkqFPxO9mzScUzJH3Lgs7JwKbBZeFcWycJNHKJDSb53qvq6?=
 =?us-ascii?Q?e269c9Mn5576Gb9rs0LpaixVpMExBLdwMZnBgZ1gx30iILP0Pj9ZZOEZ61He?=
 =?us-ascii?Q?AjJJfZ7kpPzVadok6/Av0hrce9k6OgkTdW80IKCIYJMdxJOU1ftuVB3sfoEE?=
 =?us-ascii?Q?1m2oGxqTfV3AyMTGq6VOop94Mj2UnrM1ply2kDRrvl8FEWQ7UFz5fdpym997?=
 =?us-ascii?Q?C4yIvm09XlnXUt+yCUlobezx+Z9si5rDOMeEeUco6QAwpA2qdnCHXj+hC5yE?=
 =?us-ascii?Q?sbYPEn+H4CvHwqzQan0Npxgc61FmvwZ9yqRxiaudB41qlJigjRXF5PfkiKuV?=
 =?us-ascii?Q?TMuW5rTtSYaKjT/w1uHZxVxaFGKAE80pgPfnm1T2UQih9m9t3ybY0PTqEiD1?=
 =?us-ascii?Q?pW+A3rHGqh/3dIvtsreeLWbiBNi3I2S93vsTj2efnfTSg6tH29sijM/y+nbF?=
 =?us-ascii?Q?t3/cmNk056OjnRx0N8N7s6zIjwNGspjhBXnp/bd6VaW6C1dZJzbGHnT4BvWU?=
 =?us-ascii?Q?FHdguuVcW5cKSAAqsL9Kv/E7YKvUsQkV5oKKlkdkp865TvB50PSi+H3vf+1p?=
 =?us-ascii?Q?ngDqgfF7/WO7Tva1d42qsyB9BFG+qP/p2bLh73yV2LUbXu0SVJ1xNwhUbpjS?=
 =?us-ascii?Q?Y+fzi55h3QLL0ocj7pvqqeXPv9PYVp4vNXhpfAXkvNPj/l0hJzXjxydqsOui?=
 =?us-ascii?Q?yel1j33lGFY4EM+xrSKa8SR0J9cWWkvZtv7m0qSGcE/IBqjFcUwossigDb+t?=
 =?us-ascii?Q?YVJQGcqkXIMR+RNICIBNt8LIQDPOeb6XDww3599wENQc28MS79ej83wXMOjO?=
 =?us-ascii?Q?lWUd4/J24n0w6OOG6CoD4UmIt/VOZOrLFHsOeYi7niiV00rm5cR4kOqKMYzJ?=
 =?us-ascii?Q?XExgQYpLO6yYvGCQU8juhEMdvYfbGAsW0vx+9Rv00ZtVOCXcOxrSq+OEAhGC?=
 =?us-ascii?Q?JnZaq3TUXNy8v6SkV6j2WmWN1ryyIMhU2nFPvgR6U3Utww=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dMdkrol/2BtT+GvkFkgNZazBsYj7etIuNNrFCpIhdEvRlGY7qqnh3YGUwo5w?=
 =?us-ascii?Q?+FK652KtwzK+c+jXvCUp4QBQp1ozx2VTgTUCf6T6MGDR+dw8vWK1OxT9omTp?=
 =?us-ascii?Q?w7QY0OABEE3+7fijqT6DYawOyEDGKBgeNp+O42lFVIWHll7AjtSdZuR8NrmU?=
 =?us-ascii?Q?XDG+vLJgLskpKG2FVLwO45ezdURWAtsxsIr6315ecgGuE43BMYab0ZNMVecu?=
 =?us-ascii?Q?SJD+jHrMTuISN9maNAPMSDo1XXTXTlkvvzGThTtF9KSxIRrL6abFqDZWai8H?=
 =?us-ascii?Q?iMx8x7ZkDFEHV/Cgok/xlat9GGANiyFIG+Jh/y4A9XdK73cVtfvLnXYWTtUN?=
 =?us-ascii?Q?XiJLNinsM39D5O5dcryNVSigTgbMK87v8L3OQ2z8i6SWGz+GvzSZkb/pZ6vR?=
 =?us-ascii?Q?vGiJwKaeQWRN0sZTs1jdRYOGro48MtwhqEX300Q+oK55PJ59H659D+5BicWv?=
 =?us-ascii?Q?c9WgnVHalWm0Ww0gplLkUXWnC63gSPjxF8P9pfQcyheCRQqdtNzL91WI5S4n?=
 =?us-ascii?Q?zBgCClscBbJ0XsvFPzfW4Hi5TzALbtRq8PJx9n+UWmYIZpV53A+5pvoYAOqM?=
 =?us-ascii?Q?Ym8rRcSau0mzPMxq6xerGznXaAf/AapASKtqyPR2KURL/xfsryoQGSAnOppE?=
 =?us-ascii?Q?NOx2SFbxugMgRGHVjEvILYnFzg4D6RfkE+MWvKlghJTpf7bDn/r6EoGnSRVW?=
 =?us-ascii?Q?H7ct2k5fapHhW8D0VmezLaIO57ifoNbcyoxqy57Rs0mV8RV/tc2ddIahSmWS?=
 =?us-ascii?Q?uAcuiN8fb2HzANumMGUw7V0zKY91cl1styFkp0R1cCyHaPt3fHJo6sxpu51w?=
 =?us-ascii?Q?4iEExnm8+gJdhZ2ox3Wu3D9xkcvfUjvHiysM/gUAsY/1OmXGBy4OBQAqWh50?=
 =?us-ascii?Q?wnZ5tJT9YIld4pTGpqcDzAyWJuKzKXIeLWF6xEjhfB/HPzsdXWVgY8Wk9ygh?=
 =?us-ascii?Q?RA74pzMFlH6O/FqOVKEjZH5iF4iLQ879RzYREapV/5OkGCWY6OrK3PQ5OFbq?=
 =?us-ascii?Q?AFq3hFI1vvTBIQYsHBU6mnJn7hHWvC0u5nYEC22MZJGJVQF1rYsEq54wITzP?=
 =?us-ascii?Q?vlsD0vLsELZFeGY6QfrQN1cyxOho3IlLXrFlbncn1tCKU1ctQl3ID40USU9F?=
 =?us-ascii?Q?XgqTfJRhcN1CZ535ZXx+WBs7u1L3jPvZabwIjYoU45dC+BKgez+GqWsb4jrQ?=
 =?us-ascii?Q?+Xn8YpcZ/TM/wbsYZCp3R9bQzUpW7pfIKrnhgdafyz/26QdUOKtGz0w4lDXb?=
 =?us-ascii?Q?zHwZNZFwsg0c7pvNjd+KsAk1vOl7Wl3F4Q9xlMlURwFBDG/6h2emshb+GEdR?=
 =?us-ascii?Q?VVs7/rw4qHOAbP/7yi6iA4OdyyEQaEbFGXuE/Mk27pgWdb/Bu8GqPghnVJO/?=
 =?us-ascii?Q?5qxwAaS3xKrU7Rd93Rq3k2hnFt7EvaT+b1mb8HY0NgN3RAfcBiAEJXSgFUOg?=
 =?us-ascii?Q?YwlnZ6hUeylwu5f1gAWgb0D05j5+pcZ/U0oewN6qJPjhKJYhXxJsqjvOjxuD?=
 =?us-ascii?Q?HZ/dsVfhS8jsDsqVr42P0b261imvORS0JhDm/yJK9+iD0YCXIWsY8T//2CdV?=
 =?us-ascii?Q?TH5S06TVH+uZxbJBSrtkaAxVYaS9f68t9RwzhtTjZu2vFYVb/TuiCSCsxXAW?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd8bcf6-cba1-4c7e-42df-08dd2b0757cc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 08:27:49.5083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /iOa5P9ZG64z3H9On7qksz1uR+8U95qCHrgNk1P2ROi1Fkva1eQYbrTgYQunWsLanesicS5s4JpEbOQ8WQDq/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7357
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Jan 2025 08:28:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16954

Am 23.12.2024 um 11:01 schrieb Richard Purdie:
> On Fri, 2024-12-20 at 12:25 +0100, Stefan Herbrechtsmeier via lists.opene=
mbedded.org wrote:
>> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
>>
>> Add support for the Go mod h1 hash. The hash is
>> based on the Go dirhash package. The package
>> defines hashes over directory trees and is uses
>> for Go mod files and zip archives.
>>
>> Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmuelle=
r.com>
>> ---
>>
>>  =C2=A0lib/bb/fetch2/__init__.py |=C2=A0 2 +-
>>  =C2=A0lib/bb/utils.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 25 +++++++++++++++++++++++++
>>  =C2=A02 files changed, 26 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>> index 7d8f71b20..0c2d6d73e 100644
>> --- a/lib/bb/fetch2/__init__.py
>> +++ b/lib/bb/fetch2/__init__.py
>> @@ -34,7 +34,7 @@ _revisions_cache =3D bb.checksum.RevisionsCache()
>>  =20
>>  =C2=A0logger =3D logging.getLogger("BitBake.Fetcher")
>>  =20
>> -CHECKSUM_LIST =3D [ "md5", "sha256", "sha1", "sha384", "sha512" ]
>> +CHECKSUM_LIST =3D [ "h1", "md5", "sha256", "sha1", "sha384", "sha512" ]
>>  =C2=A0SHOWN_CHECKSUM_LIST =3D ["sha256"]
>>  =20
>>  =C2=A0class BBFetchException(Exception):
>>
> The others are all generic checksum formats so I'm wondering if we need
> to indicate this one is go specific go-h1/goh1/go_h1?

It looks like the go dirhash (h1) [1] is different to the dirhash=20
standard [2] and the name should be go specific. The SRC_URI parameters=20
use composed words without separator (goh1sum). What do you prefer:

SRC_URI[package_name-1.2.3.go-h1sum]
SRC_URI[package_name-1.2.3.goh1sum]
SRC_URI[package_name-1.2.3.go_h1sum]

[1] https://pkg.go.dev/golang.org/x/mod/sumdb/dirhash
[2] https://github.com/andhus/dirhash


