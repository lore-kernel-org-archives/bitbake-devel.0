Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C57CC4332F
	for <webhook@archiver.kernel.org>; Wed, 23 Nov 2022 10:25:34 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.58])
 by mx.groups.io with SMTP id smtpd.web11.17069.1669199126750434600
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 23 Nov 2022 02:25:28 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@weidmueller.onmicrosoft.com header.s=selector1-weidmueller-onmicrosoft-com header.b=TTTw21yA;
 spf=pass (domain: weidmueller.com, ip: 40.107.22.58, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/zETUM31m/VxVuRYnrgPCzG7tupFuglrtttDS9mnVo1iocWJP/SqQNdCIsWeF3Bxoq9SJOSo2gUsNeiH0wT+caqMq5qMOWiagohusDQEQj1tbhHCjixidtrtSKo9lAg+d64/jSVd4dytfkqQ2zKpzt2L2ol0yuKkeWqWGnRLeEW/nTHzDxxdNesVjD6HVS3HnhlcsMfq8cPbvY0HgpYcvWda1mvNLv1kMF00S/0GexVbkBI9yknof6q8ShXntMnsenEFEqt/mDhza5ElF8l7bXQj7uDK0zVUGLMMCpYqA2HJx+D9LS2Mt+lRnkljDPNYNvm1Ik80rhDZSl8sDsQGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNTrWiawco60zP7dDgxgGHSIr+uiXaw9lylXqAYVBBc=;
 b=bcJauBqPJ6ZKzZSehOboZdJ/RRMFiHJ3WIgxm2kE7RX+gtpm5MfrYcaQHb9W0jiQ5UQWjjbazvWuSDgv40GbYBcrGwDfoIOLOpg47Oa1iYtPGYpDlJ+oTNSNEvMHSkR/NYMh86opgnTqY+FB9C3IClux6aSH4+Onh/Z3kD7tnbVmombJ7imQdetdkrE2AuQL57E3ls+eW3Nl4KPZRVsBOO9v39oNFSszEo97phRagSxVDiK+3sQ6kTuIOt3vu5vixIEcMQy3jri2mNzDP+OrWq4HkDvdeu+8aSdPBx33szf7pb/HNY0yhTK3pyziy8s8m8wfYSJ2BaHMDD69KWushQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNTrWiawco60zP7dDgxgGHSIr+uiXaw9lylXqAYVBBc=;
 b=TTTw21yAt8JjLkXVqAgzpP6RPndQkH+dAkeus2VtLwG9UnXo9Ssb31KoVizHT9hZHt7ILqHZArUaE8traNBaWku1Niu0odYBaTQJqsGxb+g+4Bu14jFlz2aSlU5HCp8oo1+O9/NW/5Vy0Z6AcEAIoLOafretZz6XFRVvYsUopH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by DB9PR08MB7583.eurprd08.prod.outlook.com (2603:10a6:10:307::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Wed, 23 Nov
 2022 10:25:23 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::9167:8ae0:289:7af]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::9167:8ae0:289:7af%9]) with mapi id 15.20.5857.017; Wed, 23 Nov 2022
 10:25:23 +0000
Message-ID: <d0874b4e-9616-37bf-cd26-b26c2eedb619@weidmueller.com>
Date: Wed, 23 Nov 2022 11:25:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [bitbake-devel] [PATCH] gitsm: Fix regression in gitsm submodule
 path parsing
To: Steve Sakoman <steve@sakoman.com>
References: <20221113104638.7939-1-pavel@zhukoff.net>
CC: pavel@zhukoff.net, bitbake-devel@lists.openembedded.org
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <20221113104638.7939-1-pavel@zhukoff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::18) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|DB9PR08MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: 523aae17-a1c2-4fcc-7464-08dacd3d07a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IaZBLMAFzREAfkZnABRZrRMHWIvKyn8f9Jzx92V7nYz7EHk8M6/V6W1RLIRDF9xu6BBKhyshTy8LLKlmFccGHymnzwhWlTWuCz9BnYso3mBjj9zO/UDLGP/KXdgWUj9jSW4bnXw9sqk84gq9pKpXbBg2drLJHZP7A82cQTEWTskoac43c8iTckLmCx7USgloC0Xo4Q/OplCl9oE9Pb+aWL3+MVZby48OzIHbF4XRdO7kPkiN9MWD41sTDF5+nb8uQw0KaQBUCfkslmcgtnO5/PmJpSjgCXppJe0W+WAYnDFOd14h3oy1E614bA9fAKpkfdq4uYDMf3Vz+WOhLLvu8gYQR+qaZZDR9Cw3cTXuLAtvjJcAA6LAM3fag7j0TTv8HJgEnpOjFuWPyhPfviPIfbmKBpMAleOEAK9HkQNj75sHER81J8V3XnB/9nXrePm9crfl8jTsd77Ofl0XDxX0VnJgzAbmtQqrDbd2DkkcBJPxMslE1cCP1i25wNRvF8yxUzzPU2J8pwUpIKr7TWp8O6yep0E2CRK4sNsuVmaPi7wLXfFroC/nR29uUhVNIc7BdLZJFh1IaluhlzUaZ2jA3I2iXBms8d8+TQ6H/ZKPIM24v9nONZL6S++CmiJi7F7IEP2893Po8tStAzIYeppjc+fo3fedfqdkk2WPA5vEhSEsOtgzNghyhx0eIX82Z+o94VhU9nWTSK3Lj+xISdXPFwNYFCsskeID1ifg2s+/EGsvwyr0SlSQF01gj41rhFA7LLQtMhVP0qORVSvljDNSqw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199015)(36756003)(66899015)(31686004)(38100700002)(31696002)(86362001)(8676002)(83380400001)(4326008)(8936002)(2906002)(66946007)(316002)(478600001)(186003)(2616005)(6916009)(6486002)(966005)(38350700002)(66556008)(5660300002)(66476007)(41300700001)(6506007)(26005)(52116002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?if17OXiiwO7ciNLWC+zPQm6birz9Q69au+H7d8yCaz5I2R0Z5l9DYORJ4Ooc?=
 =?us-ascii?Q?/YmuFiLygc39iH7vt2VwcegXNTPIghN+EmB4X33YRKgDV3gIpGr5p00/grbB?=
 =?us-ascii?Q?oHofeX3t4UfscOpPNRp7m32b5LHsVYLL1OxrTxdClMFJOvWaHOKpF6miY1cT?=
 =?us-ascii?Q?ifu03l/vN83eS+dV+jd7M1/AGIQUron4HJYuFAzL7+eGHCHnhUA8U0yB0yRi?=
 =?us-ascii?Q?of8C7/JjymS3Ge3z+SlN0RUY40zijWUr2PkvNk6ag93bb2r5tD1GFUHEJRMq?=
 =?us-ascii?Q?v0EHM8IB7zh9zr4kP2n9DxK8SV1cUMDTyRKd5o9lnMz+VH/LkI/oOQfx7Nzn?=
 =?us-ascii?Q?r8DZuq7yBmcCNyinomT34vS5nCRqCV9j7/IOgVaFMAtaxbkLQT70S70svpvn?=
 =?us-ascii?Q?8n6+0u6RiY8+IAPQzjzmEztACcX5a1DTVyHAoT3k2no2WBkmi89m0UQQMwhB?=
 =?us-ascii?Q?uZ1sPeoxIVLuic+MoWBkyg440/3TN9ZbVjEqroCFQkO1Wy4Ktomxy1/j6obw?=
 =?us-ascii?Q?X3qmQC0ZLO4zn6Ec+85fE3Jmi3cceua2UM+BDWNuCeOVEjOUC2BxPbOHLsuf?=
 =?us-ascii?Q?lkXdbbsVjdQflVDvzDNrYD1a2paUe90kDB67/+kQ0O/uYsWDPVZNlMGC21Vz?=
 =?us-ascii?Q?kNk8VmYetfSOysalQHGGd1eAhyg5dBpDojx316BfkRR0qJZctB1/6xnT3vCD?=
 =?us-ascii?Q?8Ij8xNav0leNom0oJLlWtVbquDydNtEvUu48lnI7pGaICwabjBX2Jth3NUjk?=
 =?us-ascii?Q?ZqEqPmAvURjdZjNlYsH/PLjlT78Otdp+/ccv3Hn5GxPMyPT0g024Wis0/A2l?=
 =?us-ascii?Q?03hd+oC780FD7lQ6QlGlxHsx1CntgENfHiybR/MUeHaij1D5Jbi4TRQgEfcr?=
 =?us-ascii?Q?llOp8ve9MkRRXMJQ7hJUE7qiTkRl6q3RV4U5TtdQDzk/iX7oVVeG8rxf2Cti?=
 =?us-ascii?Q?CyhexgBkcper8544uSSK3XZEoTXjjYM9XIg0jP/KLpcn6aBbtcNQusFO7DiB?=
 =?us-ascii?Q?Gvl74S0fsu2JDdzRQbgjW8vUFAg1gseVa3v+xgGa0XnrPg6YpqSoHj1uE68p?=
 =?us-ascii?Q?bfj1VkOuD4++nguqWPVjC/wb2qvUadO4ZTv34nhGZqqDVs1t0rCtszHRjbNM?=
 =?us-ascii?Q?S2LnnPpozLdI6O98d37chM5V2KBM6bYIxIePDvfxSyRo8aA0aMTPFZkWGXbD?=
 =?us-ascii?Q?FzDXQgtBXv/AjgM4+F/JWGOyBsA5tqS/TApwXFc6oM5yqlrOoXfwDkJHKVFn?=
 =?us-ascii?Q?tsIWOTeRr0DWA3hM/CK98uD14kFq33cfXumrmXtUBijdZ7TqFwBdxGpR/oIO?=
 =?us-ascii?Q?OVHOdY1tJ7ZHQWR1pDfvX0poNs71k0voIg16H1n4W4dlkS6ichTGXCR+2Kra?=
 =?us-ascii?Q?H6z9awI8vapTQIlg2rUXV/ICwhxCJXjKdMBNDNcK9F5yHTjxO26dkFIh6zzN?=
 =?us-ascii?Q?PujVGJijXFlI+9aooBwu3DZGIyv8b65q4K2qPSCtih5Hc/hMY/iTtcNsIH8A?=
 =?us-ascii?Q?7sjQhBwaH5fb11SSVieGmiLwY3sCRf4yT7l4mHo3IcrH32Xxm7v0bwZaMl8A?=
 =?us-ascii?Q?iF2IloL7b40MQ40AXfUJ6VVNhu2vfeX+WGrBYG+NPjfbWT3V4uLW8GtVvk3i?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 523aae17-a1c2-4fcc-7464-08dacd3d07a4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 10:25:23.2982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oZn0mawTpk+NxnKMA6l48hZ0I5xjA1gl09udvF9A2G5ZpCrtPV0c/akCZ+yWlxQ6riD2kPKjgawOw+/wECrPIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7583
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 23 Nov 2022 10:25:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14101

Hi Steve,

please cherry pick this commit for bitbake 2.0 and poky kirkstone to fix=20
the introduced regression of cherry picked `gitsm: Error out if=20
submodule refers to parent repo` commit.

Regards
 =C2=A0 Stefan

Am 13.11.2022 um 11:46 schrieb Pavel Zhukov via lists.openembedded.org:
> Commit 0361ecf7eb82c386a9842cf1f3cb706c0a112e77 introduced regression
> in submodules path parsing. As the result gitsm fetcher fails on each
> submodule which name begins from the name of the parent repo which is
> totally valid usecase [Yocto #14045] [1]
> Fix the code to error out only if submodule's name is equal to parent
> name but not if it's part of it.
>
> [1] https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14045#c4
>
> Signed-off-by: Pavel Zhukov <pavel@zhukoff.net>
> ---
>   lib/bb/fetch2/gitsm.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
> index 25d5db0e..c5f7c03c 100644
> --- a/lib/bb/fetch2/gitsm.py
> +++ b/lib/bb/fetch2/gitsm.py
> @@ -115,7 +115,7 @@ class GitSM(Git):
>                       # This has to be a file reference
>                       proto =3D "file"
>                       url =3D "gitsm://" + uris[module]
> -            if "{}{}".format(ud.host, ud.path) in url:
> +            if url.endswith("{}{}".format(ud.host, ud.path)):
>                   raise bb.fetch2.FetchError("Submodule refers to the par=
ent repository. This will cause deadlock situation in current version of Bi=
tbake." \
>                                              "Consider using git fetcher =
instead.")
>  =20
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14076): https://lists.openembedded.org/g/bitbake-deve=
l/message/14076
> Mute This Topic: https://lists.openembedded.org/mt/94996241/6374899
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [stefan=
.herbrechtsmeier-oss@weidmueller.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

