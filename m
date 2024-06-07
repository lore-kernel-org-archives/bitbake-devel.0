Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF0FC41513
	for <webhook@archiver.kernel.org>; Fri,  7 Jun 2024 09:34:58 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.107])
 by mx.groups.io with SMTP id smtpd.web10.37660.1717752895511833659
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Jun 2024 02:34:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=Eo59TZ44;
 spf=pass (domain: cherry.de, ip: 40.107.15.107, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaQMY6ATW/ULglMd7p9U6OVswZIaTS0VEQZkfKZvVPDQ8UHh7eeEHIt2bzsEre99AMWh2evvHoTonkxGb4pWDVIV1GGwBeH9kQyHSm5JZexcmdC3MmwU1Cow/Omp28JPR4O+ZutRrYCJT84NL5jRSudXgZLNBdkJ0MemLioSI1KCYmuMpK1guiklCRImomB1+qmu/teDueBW3ki3vlJrwjfOIrzeY+B0yV8WCgu5yqrJQ7+RTQIlnPmzW8ca2Al4aJzFV4t70YGjiXydxUskB3QVn3dJ1SSIbiMxyseASxM2pi6Eetw9wz8CRBz2Iqr1Mm2PEMMvgC9LQ06LvNRGBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkYdhSIJgJslFXKDFSoA3QEQcNjo4gFAL9hT84ExmPs=;
 b=UrSlb1TuUjvH47l9ONO7H8pq30w7JuND3SyPYgY6l+Ejt1eBjcnFv8KSDBtfKOcxUmwW1PN4CrlvGtVDH2BxbMhPW5izoTOrz+MOAlr5qhr0EDzH0de/PnDzXTRc4upyPCrNC/rspAvhAsQQ7F5dydMmX7UeQg7zunr5ZlMnHXmmwTSi557PPEyuoKGZpk9uqBhGUChr8M5X9di7oA6bckORe+ttoyVvcK4mzTeFRC5jYZaAUlR5lsn/0lnjQ+GOSy1kYzZ2WV2nMQOo3tgDsdr0FLdO7+bysYmKqu/L99xsfbyVguDjE3Iq2Mjezex+hllOkz6CNU2aRVAus6yZNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkYdhSIJgJslFXKDFSoA3QEQcNjo4gFAL9hT84ExmPs=;
 b=Eo59TZ44mVAtTtYp+pZYfYYOpwrnf1RARbiJlhOUTpx7Z4IyYORr2xF9y1XrnEdTTGvyrBdXbaOaLwbVNsYe1YDON1C5AOqYwzFPUoA8SPUHWfal1KuV3cD4IGb60Y6IbiQehtSRtesI5/nGCDRLaHRPmJSQUax6c5jnw0r1E30=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by AM9PR04MB7681.eurprd04.prod.outlook.com (2603:10a6:20b:286::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 09:34:51 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 09:34:51 +0000
Message-ID: <9415e6df-a35d-4e0c-b70e-0b30f32d5c06@cherry.de>
Date: Fri, 7 Jun 2024 11:34:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] fetch2/wget: Add user_agent parameter so
 it can be used optionally
To: egyszeregy@freemail.hu, bitbake-devel@lists.openembedded.org
CC: docs@lists.yoctoproject.org
References: <20240606203103.910-1-egyszeregy@freemail.hu>
 <20240606203103.910-2-egyszeregy@freemail.hu>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240606203103.910-2-egyszeregy@freemail.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: WA2P291CA0001.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::20) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|AM9PR04MB7681:EE_
X-MS-Office365-Filtering-Correlation-Id: ed43ec5c-60a4-4fd1-bbf3-08dc86d514d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?e5M7ff9rh7NSlIwpGiBHtPBBarE83UQmhAEHNLtaRZVERaQtvfvZDar/MTR6?=
 =?us-ascii?Q?3wCSrmw4X/izFtYEv1N22B8J/oPGJz1eL8NhXvs6nrpYgMXoA0+/EOr2vlWz?=
 =?us-ascii?Q?NPbmx458KrPKpmH+0Vqw0OHGJScmChvUE1kn702Yfiaq/ySKU465btRFgRoQ?=
 =?us-ascii?Q?kOG1yEQcgTqw1aok9T3Z5pnlVA3RCI+70+Sk7+yZDFc8P5qIKfqyL86Puzfb?=
 =?us-ascii?Q?iTfU/7cRhQ+bwAjAlikfDWIh5t0svEtkVnG9tvWSit2n40PehAWoAw1QGDqK?=
 =?us-ascii?Q?lk/9n9kVDvRdVuliADqijoYGahqJaqGs4bKOjjU8zEgVlci0TJxDw8SBBAHC?=
 =?us-ascii?Q?6g3bwfIU2m/pVFzoVU3Poe/OSdznwAbhS3jbcZbHgVL2EPq3UqkR11gzQ+Ma?=
 =?us-ascii?Q?odHqy6fL43m1VTTDaOYAuCWVdD7NBpcM9mCahPfmhqgctcKBJfQzPuzbupO6?=
 =?us-ascii?Q?ZeFzxPREAcg4+GwcpAnFB7HYvEX5p7Os+sTcEh+uS3DhjQKVKcsBWurr8BqM?=
 =?us-ascii?Q?CsIGWZf3JvjdHiy1qigFB8vscz25quMtRIbyZ5YEc26u8QLvcClf0hjmqn8a?=
 =?us-ascii?Q?lviuN7lHjJAVYDfsBamUcsWGb/rc1HWwiLFDEQMk5IgOJfgYjMpsEGBQn5pM?=
 =?us-ascii?Q?dfBPaapunYLfuQ3I51lfS7ebpgNQK2+RMyBFtkL3nBB8RG+AgvLsFl2a7Pie?=
 =?us-ascii?Q?X8HLdVK/aqk6DjD65UTIeWmtgoVlxSklffhgso13PxBhzWkeMfJFHUjYST+0?=
 =?us-ascii?Q?kr+GJkqs8dX3OEGAPmnD6IX7LcvA+WWsywvqIfhZt7kM5ndvyC93ur3ps4aw?=
 =?us-ascii?Q?poeyPhP/FiBRUoPZN7WGNtYg9KVLVVEdwl0FvbGXybM9E+Yrgo/wL/6BqBYU?=
 =?us-ascii?Q?pM7Wh98y9FIlA/sVof6vqkhhVR6lwBl5Dxjb2P69B7YETSwzzQxrzB8U3Y+R?=
 =?us-ascii?Q?4GxWxPuabwXMoTTYVXAjMOcCuJ4olgPgEOHGJymCVhPNVnqonUZZv2GPWvXB?=
 =?us-ascii?Q?fXVjAS92D4owzy1olvpFfk0HtXYndw3OueuCdtrv9HRRDczgnVtpF+wSHha1?=
 =?us-ascii?Q?KSr4m/R7j7C8Ap67pnLyUdbP1Og1CfFIpiiET791KD3yc2OhsOljq+EPCBKq?=
 =?us-ascii?Q?uQ7yK0vYGqdR8I0KiSB88XUzuxqd8Y63xDSYzS//u3ZkRGcEboBNBD0/q2gf?=
 =?us-ascii?Q?Lmx7Vlp3eef8NaYOZIpO2ESvnxJ6mRpmEOID2epYqVtQydICqDoS9EhaqQJ3?=
 =?us-ascii?Q?belMzAIhLCVgyEda29Cs?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7982.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3KOiz2OkOicycSQiBc6PFGW2/jPTorometcEhlJSd/HClHRU06wuKbc7L5Vz?=
 =?us-ascii?Q?EtMKgVY0Zxy0z49dLmD/Ro+k9utePPJ0scti85/6AzEOVAcVkzEVQ3xIYE/W?=
 =?us-ascii?Q?mILIiJBv3ssB16ekIN0zK/9njpEf3vg2wwsGY0gJAREa/6NGTFKISPkAfse2?=
 =?us-ascii?Q?xL1CXFJI0g1KwotvE9MHBXRtDfAKpk/ZozFnPQsKP3jLb7SLWynqpZ9t808W?=
 =?us-ascii?Q?uLTgfKFL2Kal6u4Y9gOYWKUNEEunfsKYltQpRT9yXzQpD4nlYVhTLTeDGi0S?=
 =?us-ascii?Q?qSUxVWhhupyjLsfCJ21BJbXOqMtPYFC1qJTIUm9rVoHXhbyNFw2CZ18e7rmK?=
 =?us-ascii?Q?QwpsinKkZGrdD91Ljyim89CzwlxgIt0VowPerBDUbo6lnODOYLJsgt0RhXTM?=
 =?us-ascii?Q?joRVKEocBfBs147QYGN8ixdmX1+8O4f7eNxkPW0imKIo6xiCgTqV0XRWptaF?=
 =?us-ascii?Q?TJQ+i9TdDb3vwZ/cjURNAYA+0k5CsZvGaKkWT+41LxH7PIUKWJIyhT3wENJE?=
 =?us-ascii?Q?acvRMp7rNjbs4es9ItViKGMq3B/DQqjMyTrCAfqJg8DHeEyhGbV42hP5USh3?=
 =?us-ascii?Q?WcEPhCaVL8Ep6pkl+mwHZITH3miJuq0wF97SdHdMU7Akykz9LbsYWolSMLoS?=
 =?us-ascii?Q?Ht/RL1WQU8TS4OByese6E/XK+3qim/kWchODiKU3ytBYQlzGpKPCd6sJDMs9?=
 =?us-ascii?Q?0cqyf8jIz22qDwkdKfudFSiP0/AUopIx7wnJmx1Qd41b6i8vBD3fvMrXAlCC?=
 =?us-ascii?Q?F3dPZ9bjhr3iP9R0zjoA7tzoAU6zHBX04vgGkD2PfMrNPEd2Q1YA6d/Q6OmL?=
 =?us-ascii?Q?/CrojSE5E5iWSHz/X/aJtD/FN7cKdZj5nyXzEylBmTuiUFPn90fhdqy6ep9v?=
 =?us-ascii?Q?l1khuDsF0sPEkPeAAKGqaOkOZstgw82+T0cytJmSH3Y+Edsn8FROEnHhVqy+?=
 =?us-ascii?Q?r4IOrdI9fhZKQTys4uGx/wXf6RqiEQl+X0DYrfFpn4le4EH2i6ZLyA6oDIny?=
 =?us-ascii?Q?jKk5l6F2/2OoDGX83RdRbubbhlQKPusdfUNEi3fiV8xUrjclimQDr7WWz7mQ?=
 =?us-ascii?Q?/+ZWj2GlM50K58mJiOqX8rfi8uPQ5iYa7w+V59PlDP7EGxZdUWZtR6yb1N1Y?=
 =?us-ascii?Q?RUD+9npm8ExOYNVsdt8bxdmZdS0vW0Lu63FTpelnWs8u9gROU0LrHnDycsT8?=
 =?us-ascii?Q?y1UtCF8DrSnvnZ20wFJlAywQ0p28bTM5b4nAhoI7tVhA1T+p+wEDsCwG0EyQ?=
 =?us-ascii?Q?HF24ND5bhPkrSkNsojckqNTh7dG4jdTvsoxRObgFwuTTNksczS2hcKC1QJKx?=
 =?us-ascii?Q?CSpPpOA/Q8SaTQHWbwL4ugMpZ6EKWeipr+sghi31J8kZ4P3/R++/0UXoxCge?=
 =?us-ascii?Q?RHvdllk1PPjHn82QdH04/FEgQXksTVy7gvUiC5LAkyLviwbaMeA+OFCl2Q+/?=
 =?us-ascii?Q?uegDVqNTccyU98TXLYXXhjHtNzZcc034hSds3AskUYBrK0t7/heQvfPj6/Rj?=
 =?us-ascii?Q?jV9hqCQ5/eYWuq+b0Ev0DWIkc1gRvgfie7xiOwm8YR+x0X4WQP+y9nB0xIlK?=
 =?us-ascii?Q?Bg/fdDz2aoKoe7JyQjh0dVIhFOQfWjeA9ZjB7TJpWtmCEu46ETaeKIIqo2Lw?=
 =?us-ascii?Q?boTiyw02dpH0ro9CiNmmqnE=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ed43ec5c-60a4-4fd1-bbf3-08dc86d514d3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 09:34:51.6535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eg/etlvNxxJEDpcyiR79gFTeumsUn0Ojst9D9Ha5j9TvWt+tDNDke5soKBRJlMCU5YMryC4NQUtlieUZGOQSlvgnO5Jl/9s/ETCxClprlKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7681
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Jun 2024 09:34:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16327

Hi Benjamin,

On 6/6/24 10:31 PM, Livius via lists.openembedded.org wrote:
> From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>=20
> Add the "user_agent" optional parameter for wget fetcher to able
> to use it if HTTP servers block requests with the default wget
> user agent.
>=20
> Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
> ---
>   .../bitbake-user-manual-fetching.rst          | 20 ++++++++++++-------
>   .../bitbake-user-manual-ref-variables.rst     |  4 ++++
>   lib/bb/fetch2/wget.py                         | 11 +++++++++-
>   3 files changed, 27 insertions(+), 8 deletions(-)
>=20
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/d=
oc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> index fb4f0a23d..899fa2f33 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> @@ -221,13 +221,18 @@ HTTP/FTP wget fetcher (``http://``, ``ftp://``, ``h=
ttps://``)
>   This fetcher obtains files from web and FTP servers. Internally, the
>   fetcher uses the wget utility.
>  =20
> -The executable and parameters used are specified by the
> -``FETCHCMD_wget`` variable, which defaults to sensible values. The
> -fetcher supports a parameter "downloadfilename" that allows the name of
> -the downloaded file to be specified. Specifying the name of the
> -downloaded file is useful for avoiding collisions in
> -:term:`DL_DIR` when dealing with multiple files that
> -have the same name.
> +The executable and parameters used are specified by the ``FETCHCMD_wget`=
`
> +variable, which defaults to sensible values. The fetcher supports
> +parameters, "downloadfilename" that allows the name of the downloaded
> +file to be specified and "user_agent" parameter which enable to use
> +a default ``Mozilla/5.0`` user-agent or a custom string value
> +via usage of :term:`BB_USER_AGENT`.
> +
> +Specifying the name of the downloaded file is useful for avoiding
> +collisions in :term:`DL_DIR` when dealing with multiple files
> +that have the same name. A few HTTP servers block requests with
> +the default wget user-agent, in this case specifying a valid
> +user-agent can solve this issue.
>  =20

If I may suggest, could you please make a list of all supported=20
parameters, the same way it is currently done for=20
https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manu=
al-fetching.html#the-unpack=20
or=20
https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manu=
al-fetching.html#cvs-fetcher-cvs=20
?

>   If a username and password are specified in the ``SRC_URI``, a Basic
>   Authorization header will be added to each request, including across re=
directs.
> @@ -239,6 +244,7 @@ Some example URLs are as follows::
>      SRC_URI =3D "http://oe.handhelds.org/not_there.aac"
>      SRC_URI =3D "ftp://oe.handhelds.org/not_there_as_well.aac"
>      SRC_URI =3D "ftp://you@oe.handhelds.org/home/you/secret.plan"
> +   SRC_URI =3D "https://oe.handhelds.org/not_there.aac;user_agent=3D1"
>  =20
>   .. note::
>  =20
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rs=
t b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 899e584f9..a6c05a6bf 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -699,6 +699,10 @@ overview of their function and contents.
>         Within an executing task, this variable holds the hash of the tas=
k as
>         returned by the currently enabled signature generator.
>  =20
> +   :term:`BB_USER_AGENT`
> +      Specifies a user-agent string which BitBake uses if "user_agent"
> +      parameter is enabled for HTTP/FTP wget fetcher.
> +
>      :term:`BB_VERBOSE_LOGS`
>         Controls how verbose BitBake is during builds. If set, shell scri=
pts
>         echo commands and shell script output appears on standard out
> diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
> index d76b1d0d3..db4327ead 100644
> --- a/lib/bb/fetch2/wget.py
> +++ b/lib/bb/fetch2/wget.py
> @@ -56,7 +56,7 @@ class Wget(FetchMethod):
>       # CDNs like CloudFlare may do a 'browser integrity test' which can =
fail
>       # with the standard wget/urllib User-Agent, so pretend to be a mode=
rn
>       # browser.
> -    user_agent =3D "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:84.0) Gec=
ko/20100101 Firefox/84.0"
> +    user_agent =3D "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0) Ge=
cko/20100101 Firefox/126.0"
>  =20

What about moving this to conf/bitbake.conf as

BB_USER_AGENT ?=3D "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:126.0)=20
Gecko/20100101 Firefox/126.0"

or even ??=3D

(I see that we don't have weak operators in that file and it's pretty=20
small, so maybe it isn't the right place?)

>       def check_certs(self, d):
>           """
> @@ -89,6 +89,15 @@ class Wget(FetchMethod):
>  =20
>           self.basecmd =3D d.getVar("FETCHCMD_wget") or "/usr/bin/env wge=
t -t 2 -T 30"
>  =20
> +        is_user_agent_enabled =3D ud.parm.get("user_agent","0") =3D=3D "=
1"
> +        if is_user_agent_enabled:
> +            bb_user_agent =3D d.getVar("BB_USER_AGENT")
> +            if bb_user_agent is not None:
> +                cmd_user_agent =3D bb_user_agent
> +            else:
> +                cmd_user_agent =3D self.user_agent

It would allow to not have to check that BB_USER_AGENT is defined, just=20
use it.

I think we should probably expand the tests to account for this new=20
parameter, e.g. in lib/bb/tests/fetch.py?

> +            self.basecmd +=3D f" --user-agent=3D'{cmd_user_agent}'"
> +

Should we shlex (https://docs.python.org/3/library/shlex.html) it? to=20
avoid the quote in the string in BB_USER_AGENT to break the command?

Cheers,
Quentin

