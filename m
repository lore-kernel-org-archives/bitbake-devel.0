Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60C7CF9C6F
	for <webhook@archiver.kernel.org>; Mon, 23 Sep 2024 14:58:04 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.16])
 by mx.groups.io with SMTP id smtpd.web10.38716.1727103475846453025
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Sep 2024 07:57:57 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=oGJx/xCN;
 spf=pass (domain: cherry.de, ip: 52.101.69.16, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZ0HPh4bqsY9JUahiPR/fjEVBrxrt0tknnlLtTqYgJFMpfwDVKFB9wi/6EqOL6IArm55Cwwm3st15wZZg1mzf9ue09wIGYqJIF2yo9GgkrrCGj1LS2pLyrgG2aGU1TVbG0Gewcjz9/SXxtwXBqaHDm/WwBn7KGjoWsDQmQI7wzudEj4B294twtVErQLzSVHESM2PovFvs1FaUUTTYD/7F1XGUtU8iyw/wwpw7WpL1Wv543ui7ZSICcFV5VETMUhyOu5+yrgBJMYHDLCULsjwBM08iw49My/GJyrvyOLcajixGPN4jbmabGY8rt0KVuTPc3i0NEawNFAH36+RtSqnMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKpO8um3m+y0kz17iqJx1LHFHjh5wrevDvE740R+758=;
 b=zPirchsO8/gFAmDLpNzdMUoQbimvfhobV+d4vWcjSddHhJIO2j3tGXNru18h0RiOrk0zFE+62kdpD0XE3VF4bcfD2MJYyrz9PKADcQYqwGOjynb9E7+8FOHu1M5DcJkTYRVr5bdO9dXtKapb6OsgNs50byKQLbvmsXsOx7sdMxSH/+rQGw9luPYYDJrl6cwg1Is4S5yMn7+EUS/IOP+7rawiNjYTobu9JX7leGGzsrJ6bSNQhhSHpE+9dv2t42jNupMAA+HCgHFlgIGMpWGv5bqdlQdolf4qts0oV2UnZmiXXQ4YisEHmI6d7AH17i7s8zDyVgojfgLiuoiYkhgitw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKpO8um3m+y0kz17iqJx1LHFHjh5wrevDvE740R+758=;
 b=oGJx/xCNOJotDzE3GkR2kN5GhYBrifJ0b7poGurOS7F9f93U1Y5+h6D43ZhGIpOlUXzq/YZ7h3FBV+bIFWHuRgQ8JbZdBh61nCKmVNgkhDQIllZjEh0+G+YQtEu2ocqneoo200tbnUBYt6w+d2I2yfD04Qs2jCSETfjq+Xfhfhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AM9PR04MB8422.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 14:57:44 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Mon, 23 Sep 2024
 14:57:44 +0000
Message-ID: <f8bb79e4-b752-4561-976a-a03c5c2f2039@cherry.de>
Date: Mon, 23 Sep 2024 16:57:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 2/3] bb/data_smart: fix override syntax
 warning
To: Konrad Weihmann <kweihmann@outlook.com>
CC: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
References: <GV1PR07MB91206C44D7FEA544DE6D6374A86D2@GV1PR07MB9120.eurprd07.prod.outlook.com>
 <1497c21f2add634469d205a55a155324f0e0bfab.camel@linuxfoundation.org>
 <DU0PR07MB9116AA51410D7EBC4F8982CAA86E2@DU0PR07MB9116.eurprd07.prod.outlook.com>
 <CA+chaQe3DCAxuvORYFrn4sr+0pUyrPR+oLrXkjor56+7XVaraw@mail.gmail.com>
 <GV1PR07MB91204368C096EDEF0107B58CA86F2@GV1PR07MB9120.eurprd07.prod.outlook.com>
 <06a9081a919ea08fdf0c6a43f82ac695a25f17d7.camel@linuxfoundation.org>
 <b69d0035-b4a2-420d-8ab3-d9df94f119d3@cherry.de>
 <GV1PR07MB912070578293398A70DD8198A86F2@GV1PR07MB9120.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <GV1PR07MB912070578293398A70DD8198A86F2@GV1PR07MB9120.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::16) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AM9PR04MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb095fb-2337-40ff-759e-08dcdbe01458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Q3o+kUizq+PZ4JFke4hMPhlJTZx91LwSkhqhVNpN1uODLNYSy5uBqFsOj8oH?=
 =?us-ascii?Q?Wxx+Gsx/HhymCUiOsrqWwmDfhL84eJdyLwC+59sInury0A66V094UsrGgac6?=
 =?us-ascii?Q?9KI8VOtV/VdOsdZo5jIFi/p446jXpYnEyrCctw/KCKgTXXIgentDaTxrWOKI?=
 =?us-ascii?Q?fPDspDQ7rqA6gs+qlIR8q1YRO4j6X6e/bNUpbdvJ3H9BokLPwmkH4afVASqw?=
 =?us-ascii?Q?2tQOlnaCg1WjGc837q9jItP2aXTFscDBgP1pq4m3pXmPuOf0t7XpppeB8Y2M?=
 =?us-ascii?Q?YtK/UcUakquhzzO8Wnmww8paS2q3xHS57+VNg48yrikXns6AmMMopdmwLQdL?=
 =?us-ascii?Q?PuYAt5QKmKk2X0PdtUBk/N8IukfH4jenqnI7h9Tn+p6Fqg8so6+vG6AXiVT+?=
 =?us-ascii?Q?3Rru5WvGH85uL0842BkU+AgdevGajMlzke1/u8AevxLpeAd4RA/BCnjySXVa?=
 =?us-ascii?Q?8qnDmmKxmDZI8Pnvr5cg2EKf8ypTt6bLdg/NR+yb8BiKsmY7iCTwx4Wa+A3+?=
 =?us-ascii?Q?np2PQGXH7YZr9JYGTgw8dlSmdf/XYOW0FNWipblFzJHc7bdCmM3OtQipiZ2a?=
 =?us-ascii?Q?bC0b/pW46CePnbKIhaxZrWnNOkdxhYzwodcerN9rdO5YTtaAnoOGSpwLS7AU?=
 =?us-ascii?Q?4BzlxtDurxPLWU2qj49Z5l22wi+yycDVcdx7qWe1AYywaqwtKKTsfFdeDRUM?=
 =?us-ascii?Q?Cu9kHSIssXzX3tRuXynAO8w7HwrpWFO7GSSSMKLFH50aOY0iFGD+VhrwQEJK?=
 =?us-ascii?Q?uLTZh3NuD/g7wvZBe04ayDWNFOEX413Vla1cTxfoE6dSdopOx+nqUXbsUCOh?=
 =?us-ascii?Q?Ue1h5I3dWi2nnHyAnZTnlRdDF4OK34sjHanmltOq0dIew3wGL32l6v8XtXwI?=
 =?us-ascii?Q?REU6vUn83a2k1EH0be85nboiZJA/cosppKtLsU4gCwaCsR5tnfB1Ez/K93QO?=
 =?us-ascii?Q?N1hMuiyUYHQjO5h08PRBhaIjA6vwCZzbMQEv4iPKUfmtgQsVgHR3ZOnffT0k?=
 =?us-ascii?Q?GyH2FM786om6SEvocGGqGFuCerHViAUVWd/QyvR+9L4USI2Ga+jCYY05KHmI?=
 =?us-ascii?Q?lII0juKQVCbF50kExgx+PMDFrOnGruuX9On2XVBA/0JTlweQ3t/fwF7KUeaU?=
 =?us-ascii?Q?idIUuZJHZiT/z0wUkRjiqu1r3gULToAK2eTTHfigquBmpQCo/z+rSvEl9xso?=
 =?us-ascii?Q?y44PXVERTLUJItPPi21CHMhU+qs4X7+4Rby7mD4csTVuHIv90v+e+g9982Nn?=
 =?us-ascii?Q?SbZbM6SQys3/NqYlgFWPTRswgfSvdUOtHSvjG8ToXj/NCPqj4ZVpHinf4L85?=
 =?us-ascii?Q?qvglP7KvTUjSokiku/Gbni52rCs7kZULzW+zHF39xcPX9A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?V52Yubn3Xl2AZt2V9lc89BkE5pzLx8ByBi2QuD+HA1YuvMgeKbnLjkM2SL9p?=
 =?us-ascii?Q?8vs0uagpF4ACVZGZb46n9GKyKQYCDnMrnT/fw482u535Ke/ldrhNrN8qrNju?=
 =?us-ascii?Q?d6AInd8B8zw11KqTMtDrsWEjS3Lm36IHT38tfZwUY07xZ+h5/irMo6pM7t6Z?=
 =?us-ascii?Q?Sj6bysMhBq0LcDbmvA4xcuQ0QrpgzCJZEW9OKflD0isLDnnL/gU9cm+C56NK?=
 =?us-ascii?Q?+MH02MADBHC50vND28CheTz55tlE+zXa4XN1EslCbIktgB3BuOzvKWdjSz2A?=
 =?us-ascii?Q?fkDOQwR2GcFQFwGA5jhMMsTfRhJVEyEvHNcyplM074cN86q8HhEFmrTyNiyg?=
 =?us-ascii?Q?bckkCIIdk9zk70IIQ0OkbyIX0Yqc/0htI6OdGGVIgOZc29rK4Po0qhJLv0y5?=
 =?us-ascii?Q?/Ko6u7AYpD4UjYaLqG9GeLLep3owTW6AqE9af5dCeNOZNdB/pPzS+DJ0VA6P?=
 =?us-ascii?Q?Xe+810Qz3pQkRC/fbQqj8GGNwG0wgNVMJLK7m+rtlKNhvJMee5JzyIgMBJio?=
 =?us-ascii?Q?o1ZAbQ/rVESfS45jFcY9z6XSP5hx2cAV5RPVtdw76NCa2WO9ukpV8E+Q3V3n?=
 =?us-ascii?Q?wEzKEpEsmgqEnxb4ozniaspb1PMiJopEUu61nLWtcM1Cb0i3v5GsnvQXD1z0?=
 =?us-ascii?Q?fs4VLa4sWAr3Y5w+7vZFu9pKlZYL5KKtVk772hFkXGrM3RfyDILRlJzEKrdx?=
 =?us-ascii?Q?2Wvn4Ghqd0hCGOhf6esCA16o0Lfz6GCtkpqmpt+wd92GWLqnW17ubIL1EV16?=
 =?us-ascii?Q?2PnLzSe0JL5RThcouRWFvUvM3EZcCq2BmU4xFiLDw6pU9sNT12Gfj+Vqn6Zr?=
 =?us-ascii?Q?3G35S8vzEGsghWmcKh/29hNcBukDoWsrQtxck7J86NFq0eFFYH3ojt0CZzdj?=
 =?us-ascii?Q?beHSYw6erQytvGpIUkb6BTGUeT2ZaalUdl8W5qvsA8GX7RqAaZJOKSgm9Naq?=
 =?us-ascii?Q?ixv9vCzg4j+fcTs7CcuxYRAILrfOeX+oKp1abBe369UW2rbyizXXhK/PVZJd?=
 =?us-ascii?Q?3YHwV51vfyPouWNtB5Vn2wfravnuCGwuAfMQCKB78XBRxGTF1xTWn5XWrPwT?=
 =?us-ascii?Q?B8CTZZqgxkhBpTBYAVCGG9wuOlxvcBddA3G3/rHcJkraNs/JwyUD2m0Ry7Wh?=
 =?us-ascii?Q?qvwLPSszzIxtzsFeJ7CDXfmVq6zM7rMCA4+QNpTLmh3JB0fel9j2sZgHKfdR?=
 =?us-ascii?Q?QSvtTbalsaSYdKg26zyQm0ndCMynqNknFEudIQkpbWHA6eZtbnL7ayJQ5Skv?=
 =?us-ascii?Q?XmZF139rkypLRLU/r3HsnP18vHH2qmX+36zwWCm6W3tRFDHGHo/1nm1Izt9Y?=
 =?us-ascii?Q?3YkoZ3Uicv2wn6um9x/SmJjme36+xBWLTfkigoZyxKRmMXSyUIY6cS6GQNFh?=
 =?us-ascii?Q?9oz43yvruysTh/gP+61OarVdhGiTAKVeJqFnKh4xNXel/+Fo+9BnPYZrh8sf?=
 =?us-ascii?Q?O5eHPgIUUCuYSHAgBI9EoyaytvgIW7P7tAEB1qLoh4AKlKLroCw5eJUXD7Tm?=
 =?us-ascii?Q?gC1S1X51WcBABtItTiiceKyb30x1GU8m1azXB+B4+xGCWIaOJQephYuyOh3t?=
 =?us-ascii?Q?0vYQYPh/m2nJi1Y9m0BN1p77rtQpeYNn8I1aEASqWM42bk5MNg+7doK9gVGb?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb095fb-2337-40ff-759e-08dcdbe01458
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 14:57:44.1848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5D+hiE0h0//bCfnvvLOAzdkcrgVSA98knNm3F+oLO8QwrSo/OQdcIA/Avixz/DqprU8FF0fVAZO49SDAayrZATWZ0mrCewLunKtaTK3wVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8422
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Sep 2024 14:58:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16592

Hi Konrad,

On 9/23/24 4:35 PM, Konrad Weihmann wrote:
>=20
>=20
> On 23.09.24 12:56, Quentin Schulz wrote:
>>
>> any(x in ("append", "prepend", "remove") for x in var.split("_"))
>=20
> I ran a test with timeit (5 repetitions, 100000 runs).
> with various ways to implement that check (not all of them perfect)
>=20
> here's the code
> ----
>=20
>=20
> import timeit
>=20
> pattern =3D [
> '''
> var =3D 'do_removesomething'
> if not var.startswith("__anon_") and re.search(r"(_append|_prepend|=20
> _remove)(_|$)", var):
>  =C2=A0=C2=A0=C2=A0 pass
> ''',
> '''
> var =3D 'do_removesomething'
> if not var.startswith("__anon_") and re.search(pattern, var):
>  =C2=A0=C2=A0=C2=A0 pass
> ''',
> '''
> var =3D 'do_removesomething'
> if not var.startswith("__anon_") and (var.endswith("_append") or=20
> var.endswith("_prepend") or var.endswith("_remove")):
>  =C2=A0=C2=A0=C2=A0 pass
> ''',
> '''
> var =3D 'do_removesomething'
> if not var.startswith("__anon_") and (var.rfind("_append") !=3D -1 or=20
> var.rfind("_prepend") !=3D -1 or var.rfind("_remove") !=3D -1):
>  =C2=A0=C2=A0=C2=A0 pass
> ''',
> '''
> var =3D 'do_removesomething'
> if not var.startswith("__anon_") and any(x in var for x in ["_append",=20
> "_prepend", "_remove"]):
>  =C2=A0=C2=A0=C2=A0 pass
> ''',
> '''
> var =3D 'do_removesomething'
> if not var.startswith("__anon_") and ("_append" in var or "_prepend" in=20
> var or "_remove" in var):
>  =C2=A0=C2=A0=C2=A0 pass
> ''',
> '''
> var =3D 'do_removesomething'
> if not var.startswith("__anon_") and any(x in ("append", "prepend",=20
> "remove") for x in var.split("_")) :
>  =C2=A0=C2=A0=C2=A0 pass
> ''',
> ]
> setup =3D '''
> import re
> pattern =3D re.compile(r"(_append|_prepend|_remove)(_|$)")

By having two variables named pattern, this was a bit confusing to read.

So, the thing is... those aren't actually testing the same things.

pattern2 only checks if the function ends with _append/_remove/_prepend=20
instead of checking if it also appears somewhere in the string (which is=20
what we do today). Additionally, we could merge all those into one=20
function with var.endswith(('_append', '_prepend', '_remove')).

Not sure why we would use rfind instead of find in pattern3?

For pattern4, I think you may want to use a tuple instead of an array,=20
it's usually better optimized as tuples are immutable in Python.

What about pattern6:

if not var.startswith("__anon_") and (("_append" in var and=20
(var.endswith("_append") or "_append_" in var)) or ("_prepend" in var=20
and (var.endswith("_prepend") or "_prepend_" in var)) or ("_remove" in=20
var and (var.endswith("_remove") or "_remove_" in var))):

and pattern7:

if not var.startswith("__anon_") and ((var.endswith("_append") or=20
"_append_" in var) or (var.endswith("_prepend") or "_prepend_" in var)=20
or (var.endswith("_remove") or "_remove_" in var)):

> '''
> res =3D []
>=20
> import statistics
>=20
> for index, pat in enumerate(pattern):
>  =C2=A0=C2=A0=C2=A0 print(f'Pattern {index} =3D {statistics.mean(timeit.r=
epeat(pat,=20
> setup=3Dsetup, number=3D1000000))}')
>=20

Why are we compiling the re for cases where we don't need it? I'm also=20
not entirely sure how much is kept in cache here? Should we spawn a new=20
interpreter and clear caches before each iteration of the pattern (the=20
same interpreter for the 1000000 instances of that one pattern).

Cheers,
Quentin

