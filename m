Return-Path: <peter.marko@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D737EC282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 12:23:14 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.88])
 by mx.groups.io with SMTP id smtpd.web11.10398.1742300594013113143
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 Mar 2025 05:23:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FMc6pCtK;
 spf=pass (domain: siemens.com, ip: 40.107.103.88, mailfrom: peter.marko@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlvX5VCAf+cbDYh+MMcgdQVSQnKRBcXlXoleuxmtWgTAycr/2qQENQMgahr1szIyGKb8MHRSf9fUgWDK0mFAxl0m3LfE66ihZKMBm+VGOEO3LBrfKWLwvkgIhVK6i11XKdUlwZKD7ivFAAimDuifLHwIMrBHoV1Ff/r/1ByZY62B6dNGso9/A5R8jXoVjexBEIiBe3rui/6H8HxNqm3XzaAhVTG0a0snKvFUf30ZTzulLIFx6kQg38n/Ct7DglvBH9kPyCreR4QJ/6rebTJmqN6JA9ZwydNxeFoKgymtNTRFZYLJ12e+1Iq8ma7c9kNf5D5L4k/Fb1o8p50cL71bFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MK1bM4wGDFsFdLp6gQkO//XNI8JkQS7wCqG1rrZANo=;
 b=BJDKnuOPJldgJyTkfy7cRitWF4aNQRtXsvv1VYP6nmYL7RXs4R38dXJm917W0yhrgJeGsnWj3MASqQPp2Mr65vNXQoGpsgRd50gjDTFLI3q6i03UwX3qPTSoHeGoXgocJPWjqQHYpg4/VXX1sAFWYeERaSNNz0WCyy+ZlEiJ2GULBBRPqu3fxm8q+PXa/pqsOsFAPx7vMIAW7amOiNBVL+iK9sIMMpyO6pYiLIdTew8mcCt+1BijbOjT9aHuB4zLx7JQ8i/dvaGbTnCLqHPne/xiygajmvIl/HdGOEnrSUfa75q2ycY8k9+kVOiX67y77gd+2EbR5Dhn9FphBISoyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MK1bM4wGDFsFdLp6gQkO//XNI8JkQS7wCqG1rrZANo=;
 b=FMc6pCtKvLm00kY4gdnkRRXLnf2nj2s/QM/+A80UbsIiRJHqYwd5K/NJQFf3ApB0R349fS6uucaQk7vS6/vNCaZz3W0qUUaRx//7ADMvEl2HpxNZikhbNII7AMrAHy80qXxfh9RydQG7Snf5KeYNRCRM0W2YrnN+JmQvEEJcqsRa3zf+a9BXGmRtyYL5yE0jL571V+n7aEHJlLWmhgDPy7QbXFI8r5i4oNJPcnYdljjqAxdq2RKcOmBAaKTpjdfuv0ux9u0AIbbSsQfcFx1JLPhLu0mbhwwV0JaJ1EM3FxYXEm1zAb2rdyYFAJQH52m2WLbyKcpjJgH6zgBn94LEMw==
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::20)
 by DB9PR10MB7291.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 12:23:10 +0000
Received: from AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2]) by AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c68:267b:6fd1:d3f2%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 12:23:10 +0000
From: "Marko, Peter" <Peter.Marko@siemens.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH] fetch/git: Ensure tags work with shallow
 clones
Thread-Topic: [bitbake-devel] [PATCH] fetch/git: Ensure tags work with shallow
 clones
Thread-Index: AQHbl/995y2CzE1TSUSlPvcvSPOlprN4zzZQ
Date: Tue, 18 Mar 2025 12:23:10 +0000
Message-ID: 
 <AS1PR10MB5697E7F55CD2B6281ECDE6EEFDDE2@AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM>
References: <20250318121540.4123354-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20250318121540.4123354-1-richard.purdie@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=4aeb9c57-ebfc-492e-80aa-f9fa70c73bd1;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-03-18T12:16:40Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR10MB5697:EE_|DB9PR10MB7291:EE_
x-ms-office365-filtering-correlation-id: 2240d70a-372e-4a9c-6fef-08dd6617a5aa
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?LwQ4ihcxvewfps8JGSB+r+nJP9mIt7IPDyJ6CegYqj7+Rq5EQa4jKZE7AlWY?=
 =?us-ascii?Q?hzHTJazi5q/OqRTblx4Tr5DScd04B5JLk2WG5h5Fy5ex5ETXR3aH/zbsHyJN?=
 =?us-ascii?Q?59RTJKrqxnxAg2m5ZGetQgd0jQEm09khALOOzQZe3y81ZxDal+VsCUSUFiPw?=
 =?us-ascii?Q?IRmYqFX3ka+8DqSzkLmQZeVuhNHh5H6mg0qHMJaFuYNnlBRK8Vq0efsu7yHE?=
 =?us-ascii?Q?KBYLtEsqrq/LvdKHmsHbD7D91XJKg18q2erXGsk0d7ormCqaHDc223jjyxHE?=
 =?us-ascii?Q?+uVRVsssnDdxdKv4Y6ZIPeKVPEHnf3jgqoCxyhhMiPy+7TBcECJTIprzpQXf?=
 =?us-ascii?Q?/8oZlwI6+ZJcNSZZMVWvYkKVL4UXYpztzsopt2oC+bxqS8oGWPivAustI4KB?=
 =?us-ascii?Q?KMGLOdf0hEjYgudBblKmlp5DchPrK3ZotwmwPSlSB55AoMArDiMsh4RZqL4g?=
 =?us-ascii?Q?o7CbASU949+sb6xSUJZFzNUGmJQReIHcZ/l612X2slObPJBpcUAL7LO0DJZ/?=
 =?us-ascii?Q?lcxfH8X/5yvs7ondxgGiQeTbp+kqVcleEddzyC1l1ehf74Y5KBHGyoH+XTLi?=
 =?us-ascii?Q?3SOx3Lb4rKWuQWmH049BWTO3ClkQYcZZSBc8ornIBB0Go3PgNzuJow5FpFCT?=
 =?us-ascii?Q?c8vp7hR2HZRLeOltEEEbjSz0XdJOo+Yq78cvCBfxCkMg8e9AE4jjgjwsQqSU?=
 =?us-ascii?Q?z9UeoDp5xFQdvdLuq7K5KSBL0mh8cn5BeIJPGHOKh85pcJ4sBmZ9W5ezMq2+?=
 =?us-ascii?Q?qWL30sU26hZVCvWzcUC7HmFek3aFtk6BlZDopzumizooP5B+btAyVZeth/et?=
 =?us-ascii?Q?ckHfYdNqXFymxEONouIf/qYTtNDpUmaxjY94Tm5TZATrv3J2MRhTgN/eL6x3?=
 =?us-ascii?Q?Lk8qgBibPdBMYOcAt14QsKh1JV//nQX+hn1TdihI+EYaHF9aLxkeP1sQSilx?=
 =?us-ascii?Q?I9OcOQBXSLN2/NPLJAmbc8QKU8qUKdlo7jNcLPXk8hAgfiX/vi2i9hWTeXCX?=
 =?us-ascii?Q?stxDQ/7xSCCRgWv1IfCGahvly0y/E8yfsf3tKwsl9eSSgZoR75nvy9NijwFe?=
 =?us-ascii?Q?+iqJ2zkh4VjYYH9xJiYLfW5zevz7+sW/YDi1XD49GsnpV6bu/nXzFEB2KRIo?=
 =?us-ascii?Q?AShZAvFV9w3rLHUsOiZ2x0KXJRfe5Js49wwgQBcOsV6U0+Qha24TdRw8q2bI?=
 =?us-ascii?Q?IdBVxGkNkfMunX+4EjaVSHJEPVnItIQVOd8Uena7xi8RJDgx2R7K5WJcuRXx?=
 =?us-ascii?Q?h3sKqkN1nvBkh6FZYC2xSF7RFsNADu6nVjOU+6VfsqdtPZSyogVyy3inNQsS?=
 =?us-ascii?Q?Xar8SksdF8qKEHV0sLun6o4GE8gxzb0kpPI5EF4bT/A/PpPru2nY2RYZi3qW?=
 =?us-ascii?Q?2J7hoFuecPWClmttW8w9S7YFJ9IePs/yqeDAhjMu/rR+ofNuY5Z5To1aLL3V?=
 =?us-ascii?Q?sT7Og5QxwYIRwwByLeixA6Dp7SAI4Hio?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?utQtJyvxGA4jTE8rVDffQDL/x/ZwMyN9F9mEIq69YbfBS34IYkTAq8dAPwY0?=
 =?us-ascii?Q?sozUde0lidDHwLcNi7Sr2oXuSAoWjHsKcLNkL9rAvW0g0pCisD8meJuiACbr?=
 =?us-ascii?Q?DOkvDwiOYgKtYxdL0SNQnZ/6635Oa9tV4+AgKJh6UHHYKTgLEeODf1OxaWTh?=
 =?us-ascii?Q?9mh8ZoQFw34nNGwA1h+vlY8G5W6UkA6fjc3EGpsEgS1g+8xUHznJ5hVhr6ye?=
 =?us-ascii?Q?5f4SvibtFYjDJjWKZ9JFnh6gsZOdkWn0XQZlJkpgML+QUoaAbrFctNzGGz7R?=
 =?us-ascii?Q?t972mIQWdW8lFPIaDinU4dU7lSMb9mWfB+6ILmedIWnJzSL7px3Kr2jj4z11?=
 =?us-ascii?Q?lgyvUpguLxojjNqBZtwTS8bKt7J4tG90FT3X9aIXt+2VLxN5AQbRvEH7WdKZ?=
 =?us-ascii?Q?jjTu9EyLWQsM1Wj0L7ek2fsLjAqTCHntBEitlUJeIa91B0+/ihOp2dbDUm8n?=
 =?us-ascii?Q?pskbQTjXOeClkFrM3zy5EVJiK98K87r9uUvL4m5Y3SMIGJmp7s0deKX7ktBA?=
 =?us-ascii?Q?Kv+shdWu93yeWHzA6xaucCby63sTFvq1xQz7PNYTMG0IgPK9YV3HUchsJVez?=
 =?us-ascii?Q?x6utecCl5cA0Nlk2jtus4dh91Sg0BUwSUA7cqpHU+5Yc25YwrNzsWTdsav5L?=
 =?us-ascii?Q?JOQHGg9tpf2xLe8qiz6vVbHa0Re1bSTHh6qHRvnNStNSuM1NHi8kvrWOJaYm?=
 =?us-ascii?Q?wKZdLraTRjdsrIRNwceH7WViD+CX4nin6duCyQB+gaJAh+HcVMxLbJyLYp31?=
 =?us-ascii?Q?HllKzgWSiradR2/Jj/Xz3qI6dqygj1HO5kAfUj7Laqss9zU9CCE8vuRs7BMC?=
 =?us-ascii?Q?/qwJ+r98cFVd8K63cbElVAE0jmWCiHIO66OHLl9gJgDDICqn9PGJBXKLJSFr?=
 =?us-ascii?Q?Q+S0TuRkOLcbPAygBBGVcNxpwsP1AbITRf5PQbUtWqZj0l5dllMklQYKiI9O?=
 =?us-ascii?Q?SNdnMU5S5r6uYpuq8IOevcHtv6JKR6oFG+/vTsdZKBFhAcr02Cj3kuS0H+Lm?=
 =?us-ascii?Q?1dvcSuu/JbiT8bmYOZQCYzjhUnb/fZdvuoe8MtVNnKnZ80ERhxOFxefGsJUj?=
 =?us-ascii?Q?0l+nexPKsUIuqwq+1aU2idMGXXxsvHynI9CK43+vevH2ngtU7zaVyiUEWQ9I?=
 =?us-ascii?Q?nm0VeT3sWJrAg4gTcLR1c+4i1CSg66/vgH7bnlSQXrJAglM5Kr5MU6DzE/DI?=
 =?us-ascii?Q?9KQN6srPrdQ4p/S/5NdG3tK6UyOznA4FBo3UDjCncQRNJeHd+K0692aUne3D?=
 =?us-ascii?Q?Hrt+1inWH/Pgq02ralpEdlZtnluS5si3mYIM+dtWV7j2Wb39tyPFSQx6kCvU?=
 =?us-ascii?Q?MIDnJNDRRMU4ygMdzEGxg9BfmZ7laSoVnzbvzdEIUBEXDWy13oQAp3QpCmG2?=
 =?us-ascii?Q?cz9N0AGP++YzGJjCnqILL/3QuDI0Y5Py069qBX4yaqcM4vSK3ZNJcAtUUXFX?=
 =?us-ascii?Q?b8C8jZjqsGqV/yLsv3q8fSQpm6hK8BKKC8CcuowTZbXm2HGA3cx2tLmY0V2c?=
 =?us-ascii?Q?PmeVn9Ka2JmaVr95VVQNEmMA4JZW8hw0ZSyhcg0QLT4VlYzGTjQSTgcQvdJi?=
 =?us-ascii?Q?GgwwOcjlh0EnqHTpnNaOjXhsyt+Ab3fyE4CT6ls0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS1PR10MB5697.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2240d70a-372e-4a9c-6fef-08dd6617a5aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 12:23:10.5728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vMptmryEq5GHSFuWkMYj1eYA7wYWHqpzYJZ1EHEuosdtyHyyVISxBtxLGHRQHvhbNWDy77J4ZWxIYo09svJfhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7291
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 18 Mar 2025 12:23:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17457

Hello Richard,

Thanks for this patch,
Could we also add the tag to git shallow tarball filename?
Or make some other filename change?

I don't want to re-write all existing shallow tarballs in our mirror, which=
 would be now failing to verify the tag.

Thanks,
  Peter

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Richard Purdie via
> lists.openembedded.org
> Sent: Tuesday, March 18, 2025 13:16
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH] fetch/git: Ensure tags work with shallow=
 clones
>=20
> If we want to validate a tag when using shallow clones, we need to ensure
> the tag is imported to the clone. Adding to extra_refs allows this to hap=
pen
> ensuring tag validation in shallow clones works.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/fetch2/git.py | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
> index 53fdc4c3df..7fda9d2753 100644
> --- a/lib/bb/fetch2/git.py
> +++ b/lib/bb/fetch2/git.py
> @@ -674,6 +674,8 @@ class Git(FetchMethod):
>          for line in all_refs_remote:
>              all_refs.append(line.split()[-1])
>          extra_refs =3D []
> +        if 'tag' in ud.parm:
> +            extra_refs.append(ud.parm['tag'])
>          for r in ud.shallow_extra_refs:
>              if not ud.bareclone:
>                  r =3D r.replace('refs/heads/', 'refs/remotes/origin/')

