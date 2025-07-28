Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908D3C83F17
	for <webhook@archiver.kernel.org>; Mon, 28 Jul 2025 16:30:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.48])
 by mx.groups.io with SMTP id smtpd.web10.85677.1753720238603126680
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Jul 2025 09:30:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=OU6MGN6j;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.236.48, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufxVNFq+Vxvx/ImJZzhVHEqYCClg7fESe48lWWJlZgUCPOt/c1w/FcigL8IWV1sXS8rzOeTFItquy+eIHRuoHq5bakqgR2DG2oO+bUpdQtw6k5xH+TSeo49xK3r4ai6qCDdI1m9atwGM8b/ayQDHCxdJmZ2bgvmBJwEsv8Ubt4vZTVsuGpFou7xYePl+KOupd/9E++YgDAnL0RrNkgChwgfTcX38/vTkpELhFScfQp1yuanBf6JzBVn8KXYMohqmO522tLDLnmzqnRj7JrjiPfnjTChptMMnO6AV36IUw6nDVhBB0lCnWuvae2W7YxKgMW69PzpIUqF3Gm/k+NhjFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OhJZDJAYBfMQ/6lXm8nphBxZUBdkR/WNuRUMbnLMWU=;
 b=jTkoNDRfMfOa14nChTx67t5Qi5ij5B3xHA8OIXFqE7AnyqFnxGIisDX0KXJL3kLnReCNEjVVPB9R4lknp1We86vVU3aLerKOSawfXHiN5zF9IeppA/6dhMV8Mz+EQNZMbnSfZd6iEfa1xHe8VmO3I9g/r7gnylgJHLr/hKfyirn+S7bC524sL6/XCYkw9eJihTOVEWDkx8PQDDpjTwAD4yW7nddEq23cryBAisfMFW9JoekOs0YxeNPcFWQfF1bV1aDEhaOl3iU9AdQNOjJzrZrGJC5svtqMlcZ7GgGu9xuz7q2eg2wt7VNmuM240tbD2HsjEu2TR5BORVxAw3ZLmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OhJZDJAYBfMQ/6lXm8nphBxZUBdkR/WNuRUMbnLMWU=;
 b=OU6MGN6j2qH5RtptzqxclJKpZc2ONp2dOO0W754XCltHeiw30DqIAKQdbOHabia0dzj4jXTp9ILTy3DKPZtgN04DWBovJfrswx+ZXg9kfbrU6HiX3dvYRqVl7LW4D2guCE31RMLAntmzBpT4FW2++xLMO7R60omI5VAPu/f2HqL242w/6m9g1lt3PnwH/gTcpBBwATF9Q4ZHhJ2jjEpPKgs9J4/cpvQPCaJOUQaTPTuHhTQS1GXGJ+0D4H//tsuXjFWx3NRz00DAvoMCbs0blovlEAvs8d7IVPmNv9qiXDX7loOzkqZRRP9uv7h0nfcFUQkRJZ+FivxnvVdx8ODZnQ==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.27; Mon, 28 Jul 2025 16:30:32 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%4]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 16:30:32 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: Steve Sakoman <steve@sakoman.com>
Subject: RE: [bitbake-devel] [PATCH 1/2] utils: Optimise signal/sigmask
 performance
Thread-Topic: [bitbake-devel] [PATCH 1/2] utils: Optimise signal/sigmask
 performance
Thread-Index: AQHb9+uF8KM7bcNTukeelXLn+jrOubRHyDoA
Date: Mon, 28 Jul 2025 16:30:32 +0000
Message-ID: 
 <DM8PR12MB543065BB1FD2642696C540D88B5AA@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20250718135437.247096-1-richard.purdie@linuxfoundation.org>
In-Reply-To: <20250718135437.247096-1-richard.purdie@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=46537642-836e-45d7-80da-87d58a8cf1df;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2025-07-28T16:24:04Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|DM6PR12MB4451:EE_
x-ms-office365-filtering-correlation-id: 782b0eac-e69e-426e-852f-08ddcdf412ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?uwch13P73hwK2c5/besIW/xFfqvG64F+X7ltDqRcorzOzE6bM6XLRHj6z8gL?=
 =?us-ascii?Q?p2eoBRn0nBVt7SvYsiBnG5LIojosMeNLaqsSvBTXZl6CaziafLTTb1B7SzXJ?=
 =?us-ascii?Q?t1xp34CmGnC9a0Z0WSYQAeKoR3VVVrGrcxeMr9fr/pnlbLxQgYZBc66yPUK6?=
 =?us-ascii?Q?mej+DklajpaD2hGozhIdHYM00y2OagmktKrIEgiZn0v3Lfu+3wFXyDgYXXqu?=
 =?us-ascii?Q?A5mM7NnB/EiVfF5s0rZsK6fNc+piFU1VxmeOcJJp4BsN6wKA3IKcNEzTS86n?=
 =?us-ascii?Q?YJSaa/lzNe7QGdN3x8lCp27+kxeszEso/6Tl88NREVF+rkvVJ+oOi0UOuNo5?=
 =?us-ascii?Q?CBCyeFGN0xJhrC/V+7XxWOcO7uGOsSsvkuoxu3o5Stw5c8S+S60fEQS/FmnE?=
 =?us-ascii?Q?yPXg4JSJqogagq3hDGyUmpE10lvgrxv34Y6/kiRD8gjs2/J3mInBLZBezgeD?=
 =?us-ascii?Q?US2zcANmOmG4k9qu989Rjvs6YAKBvNG4VpQ/IHq7iGJaKCVOy4BinyDJ7FZz?=
 =?us-ascii?Q?zsw+vGk2NIGp5nuhmLeSr75O6D4ZjkSim/Ekur8mlMffafkS6moC6ithvA29?=
 =?us-ascii?Q?V3eAcHBOnpmRw9yF8dT7429mon/HyMvrS3GvC2QVXmS3Olic4BdNqSQcMxS1?=
 =?us-ascii?Q?c9Rz1Zx+zDMOlSkGw14lD6WHROsqmisAvGMpgeZG6FgpyNoc5smYeSz9dn0v?=
 =?us-ascii?Q?7gwehJwiHdwu1KIv1C/5ODhJlXNtBk1ygVngnbbPqmz5vHP4Gx+85wcvzDUb?=
 =?us-ascii?Q?lJCOTpaPgkqhUP6J+txz3Nj7TKTnG8kJdxs0mc+/FP65jnLjiy3Z55uG1YRT?=
 =?us-ascii?Q?daVthPL0s+Z6t2qEX4m/zHl5tsdqNYA4n85J+pc8QxYkKDGYlJa8aNbTs3Vu?=
 =?us-ascii?Q?gi1t7A5opqhUAPkvDp7O86rz33yWZcSTiVOJSCZlLziwLb3mCf27lrCD6UDL?=
 =?us-ascii?Q?OMfZmUXPw8H1i8InhBVnZlIEQpziIzQ4nyvezXMA2+nWD14+2+IbsbTEJB6u?=
 =?us-ascii?Q?vUHz0YANEvs1huBD1UPu8b8YebCNUrdHkG7U+Hw+b7q4epaET9hJMkZ0Cu6u?=
 =?us-ascii?Q?sBkfzRZdgJSmfTByUKiXwe4/4GtnKOe06pSB6xklk3J+QjkugbN4FsrIAETW?=
 =?us-ascii?Q?Ji+ehW6kFHcQkQ3tN//5Y4clzF1lksz+Ht7uANboSEperAZjxYgBhebxi4b5?=
 =?us-ascii?Q?IyzDSIweQBseds1MlY2x2KLQjGWiZARCLYFV84vfC2tzjypXU9o5G9Bk1igp?=
 =?us-ascii?Q?/W5Pe0k04Yb0OdaTM8F38kCiyte7Is66rB476VlrVhXas6NRsxfM8Il6HQ6W?=
 =?us-ascii?Q?xW/QVTxMigyRfPsb53EuOUQDxjd/S1czbG6wz2FBFRdEHC8arWepfC5Pjoxn?=
 =?us-ascii?Q?6W0CLeOyPMgg5c0NmDRDJFCFtWXM18P1LH4zyCh80mR2j8pWhruZwLnm1isD?=
 =?us-ascii?Q?9XOYKhj3DY8=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?O0tiV5vgS7/4jXi6tjq7Vh5vvBtPnA4nDjCxY4Wd9dKZIQ3qxzqW1qAzVuII?=
 =?us-ascii?Q?BpnDBDoZQk0PVYPzPte3cwGr8tOuymdx74UORkR8UOnIG3xCEBSnI72Qtmed?=
 =?us-ascii?Q?sprpOWby1VimuPvtWU1XUL3CquBarz3jZfrRRnylGWdK1dLsGCpR3EdhHCDz?=
 =?us-ascii?Q?GOyF/rR6Nc9+lmtc0XsK17WuP+jxbDb8pNVubAELYeiJjqANjQhd34IDh1pd?=
 =?us-ascii?Q?znEpuEnuVRpntv8HL9gfgQJuqas36o3Ud+ekm8PsuCadr+BfBmCx2X4IUm6d?=
 =?us-ascii?Q?4mc15nZMI0S0WLD2xBTnnaixYWGHd9aLn+vdY9UfQ1GYUEx4UPdvliKIIJCY?=
 =?us-ascii?Q?R9BkNy5RjIqAlyiPM20zgVjuz7I9bTXCXparsK39FM9Rwf+VT/eq62Sq8mle?=
 =?us-ascii?Q?jmpmXT8ovgriaqcO41ieic0JgIOlAdauV3D5Yaq+oBzbRsTFe5sTGuc8yVAv?=
 =?us-ascii?Q?jQhoV739EB4TxmJQZXfH4VJxtgN7IS31qGyJ0T3dOg7eC2pB/PM5bJ6S8WPx?=
 =?us-ascii?Q?6HcJnINVr59ZXoxuMvmPqQMDUu6z72wNby9QkmesMsVt95jwrsxpRkVrHQTE?=
 =?us-ascii?Q?jYq701LVbgI4w2xnOSmMI6+i3GBMemlIEUD627wRs07YPUzxBt3A5zo5iS0c?=
 =?us-ascii?Q?4cOsUhuNkEBJvjhgh/sAqHcoVW/Gc8bjmzGnc3CcRYOL6k0YfNGMVlv8nS0n?=
 =?us-ascii?Q?bM1gPECHg8xJc6F0mmRDW9jU3D90BIDw5zWNHKf9A/eJ9wteIXgH6F8S1+9P?=
 =?us-ascii?Q?znm1H7vnOkug8oJXwM9/ceq7JS3o8mIfs5De3os0B8zPTva6snmHvUCd/Xl4?=
 =?us-ascii?Q?F8TNTzrKvxYY3L3xImYB6VSLzpmBHp969g0Zx6bb1qOKHDjCNnt5RSbIzsms?=
 =?us-ascii?Q?TYP4biO88GaMkqK3OdBhDay3OWgeH3ZMPYxxAo3JIQiq7JmE2jlEuFQQlqZe?=
 =?us-ascii?Q?AYPg7mIAMuCT8W+Y55elptDA/GA7fky1XtjVlu9DMYyehaWWnD06spOm9t21?=
 =?us-ascii?Q?KJnEoWoSwSmyEJZ4P5J3QtruLl0bWmA2zkAeHwTlthM6d7ira2nB58yUCl4p?=
 =?us-ascii?Q?Mr6S7mKc6Qy+AGKLgrZwxI16/ZDZOAaWVeV9b/s9+ZLHLT3ZkjBEgLAex/m/?=
 =?us-ascii?Q?3DmabrPCOAqBkbPxcsW7+UJ/dpeDftTb0C1fHENHdOJ71OqCKZX4Mv05uHH+?=
 =?us-ascii?Q?sgd067A5EVxnZlVcJycl853CmRKHJSMa4lw3Dv31/HuJoyKzi78Z/9GHIMJe?=
 =?us-ascii?Q?esi1Pl7Hfl7VgmIZ8n6AEFy421Fg0U+tiYotfcE+57ndEXvsZRlUxrDjRkf5?=
 =?us-ascii?Q?XURp36X/xrIbG6lcnqDfKFVx9Bfk4NgLT6WdkYT7FpWAxQxSPEWSsDJc08dr?=
 =?us-ascii?Q?BEgIs09DHY8Vd39uFLzIC9g/2N/2wr3Fp+AH2vLDBuqm4lJTGM5q5FU+QPXk?=
 =?us-ascii?Q?G0PFnx4KnticSBtHJNWN7B4b6nigOHEZ9QCgh4Yzjc+I5qAWyICZczqdKrX8?=
 =?us-ascii?Q?/kw/UWiYjN44XamTbI5p21UHLhxrQld/2eZHqXYwzLpcwqWNptbuvJKDqaBt?=
 =?us-ascii?Q?wzwgZX/QeTn8hciLLxzjyo3Vhr139ORMhYjMej6W?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 782b0eac-e69e-426e-852f-08ddcdf412ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 16:30:32.7312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Sx/H566IeFTRExgyr4j+ZMja0k0mk91g+XUNk0XvtvWCxCYeXQT5l3M9CTGzA23BiIpjS3BLFyXIvmV371a3XeIGKgDMAmPIJD8pExamKQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Jul 2025 16:30:48 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17815

Hi Richard,

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Richard Purdie via
> lists.openembedded.org
> Sent: Friday, July 18, 2025 9:55 AM
> To: bitbake-devel@lists.openembedded.org
> Subject: [bitbake-devel] [PATCH 1/2] utils: Optimise signal/sigmask
> performance
>=20
>=20
>=20
> External Sender - Use caution opening files, clicking links, or respondin=
g to
> requests.
>=20
>=20
> Running "time bitbake -pP idle" with a valid cache shows around 800,000 c=
alls
> to enum creation from python's signal.py. We don't care about this overhe=
ad
> and it adversely affects cache load time quite badly.
>=20
> Try and use _signal directly, falling back to signal, which avoids this o=
verhead
> we don't need and makes cache loading much faster.
>=20
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

Coincidentally, for the past couple months I have occasionally been playing=
 around with VizTracer (https://github.com/gaogaotiantian/viztracer) for pr=
ofiling BitBake. Just today (on Scarthgap) while profiling the cache parsin=
g, I also observed the issue with the sigmask. In case anyone is curious, h=
ere is what the results look like: https://i.imgur.com/BGdzSe5.png

Two questions:=20
1. Would it be OK to backport this change to Scarthgap? (CC'd Steve as well=
)
2. Is there any interest in incorporating VizTracer into BitBake?=20

Thanks,
Chris

