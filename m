Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EE1CF6497
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 11:19:30 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.14])
 by mx.groups.io with SMTP id smtpd.web10.51918.1727695162837274172
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Sep 2024 04:19:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=jh/3EdOF;
 spf=pass (domain: cherry.de, ip: 52.101.66.14, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c9SNLgqPMYra5zwJMD31lYpNpeRLptc/B5aB9QcSKQz/vnWxCP5qw7eqW7Suja14/SrcJzAWGFRoVHQZgGmnH9RrsRoTAnnn765ibzK5p7gmPgb2C1phnK9c3KpW05evuX5IfEsLp6LRompIo03t7XNTDgwNOsJic0cAD91wrDNgIm0FnBzdYklC8dXJW84hZ3G0T5leyaUPNu2aiv4i1w/uEb33ET4jHUs/A7rIp2KX4zjBH7TEwruBO4rxlWk/86iEvbyQbBehYwWLJogXeD/2QIsytFEAsOAxvTwmAFZpoDKxzTibpmWLZMwnboFfaIM8PJAXbsHy72cRzesqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbfEjfW+zBXfsdqfeILVRS46KtQ7019qUwKuRC01U0o=;
 b=OmPOS818SRJIgGiejLefqTq8rIdRg7NYyOv0u/bNxGIP+xiTSNdInicKXJx8f3QOKKI3kuBCdJcRnDwW93z7ASGzQt9iYr/2hHR9KkmAkFvLsX42ep4mVRtpDCMVIFKk2XLI8Z/QN7i1JsK/pw2H9ON16Wpf+w2hqqQzHrX8pof4yuo5f61ICQqycxytohiVHpBenNWpeBnDdZqOTLIhqVNlS8UwzG+RO75MBs6EBSBRshA+aXOQ20/xmoybKbUoP70NUM8stLe0ukMAzJkkf/Qt3n/7VZTfB+lSTuG30g8O6qvGj+3NGFxWU/aFB9JU3zecKvLcu+uqWbS+gCy3pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbfEjfW+zBXfsdqfeILVRS46KtQ7019qUwKuRC01U0o=;
 b=jh/3EdOFvLpJHBc71J7HbVASbz1pR/FAN0SQ+vGd0/g9UfwqY0xfHMtPm1OMTAm1bqTfIXVcq0aL0W+gCe1soKAHzJK87TQjLhr/wJCcE8hGYUmS/aNVz6McMc7VoIaP5nfpd5DZxGOGbvFj6aZQtcnsvRjAgOK5tnafcHloq+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AM8PR04MB8019.eurprd04.prod.outlook.com (2603:10a6:20b:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 11:19:19 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Mon, 30 Sep 2024
 11:19:19 +0000
Message-ID: <342c2498-9580-4692-b5b2-1e3c3779d6ba@cherry.de>
Date: Mon, 30 Sep 2024 13:19:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v3 2/3] bb/data_smart: fix override syntax
 warning
To: kweihmann@outlook.com, Richard Purdie
 <richard.purdie@linuxfoundation.org>, bitbake-devel@lists.openembedded.org
References: <GV1PR07MB91208FE4BD9DE31DFD4A7318A8742@GV1PR07MB9120.eurprd07.prod.outlook.com>
 <e6694732a1e929e0a33aeba62713433019ea1dc4.camel@linuxfoundation.org>
 <GV1PR07MB91202E0541450DC69A204E4FA8762@GV1PR07MB9120.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <GV1PR07MB91202E0541450DC69A204E4FA8762@GV1PR07MB9120.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0381.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::9) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AM8PR04MB8019:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f23edb4-9d23-4cba-1e54-08dce141ba2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?lZVBeJvZbmatAirfbgZTrvh5zIy9tF41ssLTt/rWRIArlaFJoSEY5fLQAqTW?=
 =?us-ascii?Q?IDSHhi4xgx21DokUhIbAmrbiicBUpaKcOAT65Gy0BO3zDfIJTitar5cekuJg?=
 =?us-ascii?Q?8MAqaTSaXT5b3+ul4Gwp1RbA2He5IU/YHdN+5/Kevjozf06iWByjBdud7Xlz?=
 =?us-ascii?Q?JsAsakVV1WRZJ7RUuq0shmw+gIzoUy6WfKVqdmAuOHCTkEGNMr89LJy5fgfe?=
 =?us-ascii?Q?q83378X16MHS7pO6TnPRaR63wiF1We7ZDwjSpUibp3etqBeO+3UVWDFSgZs6?=
 =?us-ascii?Q?Jn2Pijj20xdbmGHQOYo5sZoZae+MxV/G1StF6rYn/MuG287YxEqyNKxXNfx0?=
 =?us-ascii?Q?QZLM3SuG2ybv0AQJ1k8fQKj3eEt/r1m8E3wV5dV189EO4S/jhLKZaFZKnfJ9?=
 =?us-ascii?Q?2zV9Q12QB0DRBSfCAfrzeGNuCnW5xWrKuWRf+GH63HzoyZN+UsTn5ejjtIEV?=
 =?us-ascii?Q?zeoIHpgLNwlK4VZv1zwzeCbmbmXDSBkg8fYYX8NFzS5MtqAutGddZ8urXcqY?=
 =?us-ascii?Q?5iC3MPBbv9cToXK/mgOogg5DVpANomf2y7cpLmVVTa3gsHow8Secl+EFtUHG?=
 =?us-ascii?Q?b59Enw7IE0/e10e5GFfDN89tzPW8cWqGVEXUeLdIFdtQH1Ryte9h/plTe1sQ?=
 =?us-ascii?Q?mIj/yJ3wqjNy9KlbzDqG9ur8DqrSdwHiPEZU1YtF+Ig+ypV4sMCGc8be9Rn0?=
 =?us-ascii?Q?mvppmXPNdsYue8Zqqut7cBjdc4wtnCe1TeL5yWrvlL1qx+nByjC9+T348+uc?=
 =?us-ascii?Q?EXgqD64RUaSxAG8lVulaFPvHU2eUeLiiubDS0VKgZgRQbqIi3CbVbW7ubc3U?=
 =?us-ascii?Q?GKvwIp/QiVQlklo2gkQglFz0vA01umBavwOhKHHvvOBH52iLklh5zLFk0Pdb?=
 =?us-ascii?Q?Hlmt4KVDsN2Fw9MYnqWzSDixN1/QwHetSw9uQVr8bdNrsfiBYG4rffzmuSO+?=
 =?us-ascii?Q?JuD/XjtxVOeLxXPiNLxB5fmC1Y2hKvsFShsUmh/1iKZ2pDR7ucKA/ky6g3nh?=
 =?us-ascii?Q?Ba9fgFNhkdU/1R8zuBePV6G04tJdVL4Hy8u/yvfxp6H54j7TW+LwXtD0MLvC?=
 =?us-ascii?Q?XO7W9vIiWJrKqhbnfMGI8KODhJ/g6odz7NSYnOQE/L2tzmxFyWUbzIa53uzy?=
 =?us-ascii?Q?k4jthcdM4iX3sdFonqdZIpypU0tpBKrpjGfNpxVjWgOMhZdihPqDBPj5Igu+?=
 =?us-ascii?Q?kR286XVdPzo57BE+9jG/w1mJJnQpnyb0Tv6k+9H/AWPnbM4lsaVJszydmcv4?=
 =?us-ascii?Q?LgUGLd79Ces9HW6lrG6/P9mz9NNergtGeO5Ks7PQTw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QRXW8wM2+zdJQuh6A99y/+MQl9J8a5B6nLsPyXE4Y/hxzn8VMkML4TsgCJeM?=
 =?us-ascii?Q?uC/YO0F5o2Jd+qoYA7h9dMcnTUjXdx3szXJXTSqW4cNDw4954lYMC9YM0rM3?=
 =?us-ascii?Q?ORfjhL20GeyRftME+wg0UBNk8yUzFeymctZfz/Ctox1/shWKZbNTE7XiDsn4?=
 =?us-ascii?Q?eJtCAO+cstJYPfcdMbZZdjpr1eVf5vXeoS7RpVt5OBJGly85jcbE5oz4bl6+?=
 =?us-ascii?Q?DkGh80nNXf8a3mYp7WL7+huu2O3FEQn98i/BziiqHKy4+CDWSYdw32biqOLG?=
 =?us-ascii?Q?qkpCV/nlI71idgOAFYmUx/S14mz0h3ZmlkVheGdCCu/sUb4JDyyx432xI5+t?=
 =?us-ascii?Q?Yjzk++K0d6keLQh+k+9d6FsGx3NawASV30rqbkfPUxSc/gCRIAOzxeHQ/apg?=
 =?us-ascii?Q?j1MOUxAbwQ8wZjoCurZw32WUdY1T5zlv+A2/1bfnXYXzFgp4eRCwh07YC1nR?=
 =?us-ascii?Q?8x4xxohJ7wDlzhUkECbqfgrhK8/1O+qXX5qcFfA5CDR1lW36gRJpMuhIT9pQ?=
 =?us-ascii?Q?77xT9Hy04QGDmsX25IQXqtGcipGAn034z4lW6wvjgJuL2OVKUmKb31G1e+qX?=
 =?us-ascii?Q?kJy+fg+c4YB3XquPO7pvYHiGxBs5uQTQPD3BvcLYjeYaoGLReXMQ2UefWc5+?=
 =?us-ascii?Q?ij7omoPNxEGWdKBsiGs2o+MbOJnLmnlL3ranM9KkLY+hon+tIs7mSevO9EP1?=
 =?us-ascii?Q?1Sn9zJZPzAcjqmx6dRhIeqkP2zMOeWW3iBgyV0A3pWuBL+fXNGhtMxYDCIh9?=
 =?us-ascii?Q?6ZZ5BggnJ4hEeM2TwdzowTBtlNSLEA+D3ZQ6FQqwFLm4tFg1XZBArlFCVlRU?=
 =?us-ascii?Q?Q65dIRS4fItY9H3PkSbb6+530fS6UmlLucnC/EbqizA0uN/0JAZB3r/3PHrA?=
 =?us-ascii?Q?QU4fUnXq7LkgaGEYyiykxXAfICWaVc/+cAf78ca3GJiA4BLfUtfClNpFj3ok?=
 =?us-ascii?Q?8Bt0tkid/KsE6j9vlEY7KTjIf/6XagqBkRFH4oVDphHOwYPdnPh62ZRUBu+P?=
 =?us-ascii?Q?9p0o7ES4Hv/lstxO2Uzfj/ZbWJDOEj2m9bTTeNvCVTp/EobaCy9p0yoELtGv?=
 =?us-ascii?Q?mAE/7RvPiB9ngdwzK3nl7AOIo8qyPpXa0IP4m0C63nr1ydQbjob8y+UIQa4x?=
 =?us-ascii?Q?0PTEkH0vilHQMIa3WTh0Ou9InqTnzM8rnFhXnsFO+bgXHlRvtz664jHAzzBz?=
 =?us-ascii?Q?HNiTFtkN1MxKRVCx0neAELdoYnzy41pRsA+NGIpwJDdBxtG63O/uHiFilQUZ?=
 =?us-ascii?Q?3t+4gyx2XO6pdJZxzlYc8p+U4lOPw8ki1xO2BpP3CdANvEAKe9EIhWAuM0Ez?=
 =?us-ascii?Q?7gobvU9U0DIHbqUIt8vRK1TUUbNfPm6PxwcWebJEYPFyYa0Ooge3xcJC48QP?=
 =?us-ascii?Q?IcPFCSVX8WWoI/vnQHWookFd9qygXGrMUM18mrSVdF59c5n5JXWG2RYo1URG?=
 =?us-ascii?Q?B6C3xzNUckyzcpjbjowL7OLA95vMKVe4W7u6cYMvyWLZYmd7bESu+lhffEcv?=
 =?us-ascii?Q?NYp9Md90DGr98ARUtfBuGHVgE8jhr7VAbg10KCfCTUjOMRt/YwR0eXZXBJTJ?=
 =?us-ascii?Q?mxXDqqBL4atfxw3Lt/epeofhjm5QARYfEgxEBm8ceaoiah6G7jUO16Ic+5Uk?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f23edb4-9d23-4cba-1e54-08dce141ba2d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 11:19:19.3864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0OiH6zuFbAvv54CTeow5pLMB0myeJBn1LqlVre831XdvI2mHRRrdOxrNiEyH63Z3JCsLAazJBOpFpMtI2gq5PtPgnaZykOm5+HEikb/bfVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8019
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Sep 2024 11:19:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16618

Hi Konrad,

On 9/30/24 1:13 PM, Konrad Weihmann via lists.openembedded.org wrote:
>=20
>=20
> On 30.09.24 11:13, Richard Purdie wrote:
>> On Sat, 2024-09-28 at 09:00 +0200, Konrad Weihmann via
>> lists.openembedded.org wrote:
>>> when defining a function do_removesomething,
>>> the parser warned about
>>>
>>> Variable do_removesomething contains an operation using the
>>> old override syntax. Please convert this layer/metadata before
>>> attempting to use with a newer bitbake
>>>
>>> correct it would be to search for a override operator at the end
>>> of the string or for the next operator.
>>>
>>> To avoid running the expensive regex search on every setVar call
>>> the current "cheap" check would be have to be triggered,
>>> before the more precise check is run.
>>>
>>> Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
>>> ---
>>> =C2=A0=C2=A0 lib/bb/data_smart.py | 14 +++++++-------
>>> =C2=A0=C2=A0 1 file changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
>>> index 4e15a43c2..0523744de 100644
>>> --- a/lib/bb/data_smart.py
>>> +++ b/lib/bb/data_smart.py
>>> @@ -539,14 +539,14 @@ class DataSmart(MutableMapping):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return var=
 in self.overridedata
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def setVar(self, var, value,=
 **loginfo):
>>> -
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not var=
.startswith("__anon_") and ("_append" in var or
>>> "_prepend" in var or "_remove" in var):
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inf=
o =3D "%s" % var
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
"file" in loginfo:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 info +=3D " file: %s" % loginfo["file"]
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
"line" in loginfo:
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 info +=3D " line: %s" % loginfo["line"]
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.=
fatal("Variable %s contains an operation using the
>>> old
>>> override syntax. Please convert this layer/metadata before attempting
>>> to
>>> use with a newer bitbake." % info)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
re.search(r"(_append|_prepend|_remove)(_|$)", var) is
>>> not None:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 info =3D "%s" % var
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if "file" in loginfo:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info +=3D " file: %s" % login=
fo["file"]
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if "line" in loginfo:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info +=3D " line: %s" % login=
fo["line"]
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bb.fatal("Variable %s contains an operation using
>>> the
>>> old override syntax. Please convert this layer/metadata before
>>> attempting to use with a newer bitbake." % info)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shor=
tvar =3D var.split(":", 1)[0]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if shortva=
r in self._var_renames:
>>
>> The patch appears line wrapped unfortunately (it appears as quoted
>> above).
>=20
> O_O - okay that might have been my mail client.
> Ever since Microsoft decided to drop plain TLS access to SMTP, I don't=20
> have any other way of contributing any kind of patches, but to pipe them=
=20
> into a client that supports oauth :-(.
> (P.s. before anyone jumps in gmail is not an option for me ;-) )
>=20

bitbake-devel is available on lore.kernel.org so you should be able to=20
send patches via the web endpoint, c.f.=20
https://b4.docs.kernel.org/en/latest/contributor/send.html#web-endpoint=20
(I have not used it this setup, as I use my personal mail address for=20
sending patches because I got tired of MS and my IT deciding what's best=20
for me :) ).

>>
>> Also, I would still prefer a pre-compiled regex. I appreciate python
>> just have a last used cache but I'd prefer not to rely on python's
>> implementation details which can and do change.
>=20
> Wouldn't that have an overall penalty on the runtime behavior (I know=20
> it's only once)?
> With this inline expression, it would actually only be applicable on the=
=20
> pattern in question, so for an already converted layer set it runtime=20
> penalty is +/- 0, while with the precompiled expression we would add=20
> something on top for all users.
> Just want to make sure that is would be acceptable for you, as my=20
> understanding was that any penalty should be avoided
>=20

We could have a regex that is precompiled in the if condition so that=20
the penalty only happens if we go into that code path at least once? (I=20
initially only wanted to provide another way of contribution but I guess=20
I can also chime in here).

Cheers,
Quentin

