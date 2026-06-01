Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DC7CD6E55
	for <webhook@archiver.kernel.org>; Mon,  1 Jun 2026 13:31:40 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.8])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28748.1780320689909664351
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Jun 2026 06:31:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=PxMx1Y3b;
 spf=pass (domain: cherry.de, ip: 52.101.84.8, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pziUIeHL7xScgn1FKGPLyBtWbdKR4C7BdOlaZr2MGCPNdX1Y+CsGe6drqXpLtQfYKZsbVlzu0MzljOX6vUzUVRVRYSy6uZFATUjxOOiUThXVZH7Hbd59oyn8CyZA5kvs6VbYSX/dBvNMieCvDJz3aUux3HEz7pwQE/Zon7Nc41cnqIjwnGOcTbk+kBGuoc9JzkaTzYtJ+2Qnks9XD8Md3zaMqnoLSMnrN+CuTEb6tvmXdu/ZH9pgcvOg5kxB6hgupkgSGO59o7VsyeCQ9gBUTyFmhqzVaz5KdhM6wC4JU7hN4VnGEf9BE6cy7IdCN0cj620auDVw7aX6XYgF44Rywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YvKYqC6NG8Oa/6iCmFM7fq1ScE61jbfPmE8waPOdcSY=;
 b=bf2KTySuur9ITu3WUGSbjN91EBj1SvQb+IKOJ2LY4VglkFgwHMIomYjb6fzyADUIqEYR1t45vKtKvylXjuAi1eM9hJsCOQ5+YSqhcIlNr47s5+Kj6NoRSdiClYdk14IqoA3mMhrNAQFssk+c/qozsRuKxbn19TDRqJoTbTJJUbYGO9Wek4PEeron9LKhhrygNSXcb6mSoN9C+8HaXEczc2tC5lSEnNzpM3JSozJe4bpsBhMkFagojCnp4S9W+FoCDTX/k33FA0xZ/cwQOj7oqhpoCX64AvZUg6fCmFp50Bj6uiw6EcrwOQCjpqOJj8b1WtPptvEVTiyEEz+Lpyf26Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvKYqC6NG8Oa/6iCmFM7fq1ScE61jbfPmE8waPOdcSY=;
 b=PxMx1Y3bCBHuXctcpGKdmgxZqYurfdiogwLRxIQF5sIepo7TGprJdX+8kGr1OAbnozMIzv2Qabl4l9n+FRYuefs6DQ2ya/eZ6linA7l+liKBtwsDYUVVSUWttps9vCEaU6bX7BSGsFF3BQb6XrrgTb4Naq+HxCGInDkf/bw3nKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by PA1PR04MB11333.eurprd04.prod.outlook.com (2603:10a6:102:4f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 13:31:25 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0071.010; Mon, 1 Jun 2026
 13:31:24 +0000
Message-ID: <d8535a6c-8ee8-493d-9129-7c73e678c03d@cherry.de>
Date: Mon, 1 Jun 2026 15:31:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH] doc/bitbake-user-manual-ref-variables: extend the
 MIRRORS documentation
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Ross Burton <ross.burton@arm.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, docs@lists.yoctoproject.org
References: <20260601-clarify-mirrors-syntax-v1-1-d9dbdbaf037f@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260601-clarify-mirrors-syntax-v1-1-d9dbdbaf037f@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0202CA0009.eurprd02.prod.outlook.com
 (2603:10a6:803:14::22) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|PA1PR04MB11333:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f43666e-9bb5-4148-f56d-08debfe213b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|3023799007|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	L/jlLLTEPT8wBz/0fsrimmEXCPa9/Lgy3NKiTSrvfdKrIPfTCSBLFPMll0Svkl8gvO9Bs1elQvBtfmIOtEvOXLSkUS34cuoVLvfEr1ISTk5+fTqSet3fmaxGHfmWGo7ht7YOwhZlBbFY6hsl8A9I9gJ3uKRs5qLXm66ykC78gbn+kCFdpyMuTjKRJ4N1aQcrkBFOglcSTFDU1a405ih+ii8j5JGYQYVmGj9/ixUncvDtoNyq/4+jRcXGz6bI22uIq3r3bLvk0Wgmg5/hex63BeH172WeYd981vK3vdjSlWORCJH2jzrpVqOMLmULR/z2nX9CMDRVkr5xCwuS5ZkuoMLeU3DmLYjh0vXp1RdrUDlv4/0fsIO6aa+lmSJlgcpDXOMNwYQSxsyPwmRnKtRoNsA8xMh+/jxV9vUbsfzRiNpPLsYVCtCkZsH2T8IbrJA4YN/+DfBItksCX3HBygTT2oDv8qqiuX++DMJJAYTAf639oyly72PDjPUbwAQQX1Yp8bbed9lzI4hCq8vxT7QLbQWd0ltMTPcz0eWbNxusNvc65wV4qptw6lGMQM1HL1qJUDw9jGHwHAmA6bQ6XLK4okVDGEaK5NVNPLy0m93cldsn+EIfzkgXaVeJkqeUbfW0sUqXIQOuO6Bt/2rEXJU7CkYE5yDMTcGLvoflf9HUyfq5jUlmANMiC8vTouNDEOXM
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7743.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y0tKY1NJamRPT1hQVDRBMkZOMmVYTXg0aEJ3M0piNHVkbXpLNDVkQmZ5Mm5K?=
 =?utf-8?B?TWYvNll4VUI0M2ZHVEU3dUtweWcydVREc213SnMyM0piMXdqdldlOExsWW1k?=
 =?utf-8?B?TzllWDA4NDVON1RPS29oa1hUemNQVWdGOUhqUlhRMzRFQzlXenBTcThndCtY?=
 =?utf-8?B?WnFFdnlmaktEUXZ4bUxwTTFodVRJNklhQzRyQ0luK2hSVnNZWmJ0VTNBemNI?=
 =?utf-8?B?VXdFNkNGOEd2RXQyRUdNTFgzNlJHUHlDbnNGYlI2YXU1K2JkR0RHL0RsenIx?=
 =?utf-8?B?RWUzY3M0L205bkNJMFFXQnNEZUwxRldwZFlrL1VXTGN6WWhRbWpkT0FjZzVE?=
 =?utf-8?B?ZlFBS0hBVWZXVGtvM3ZLODUxT3Q0UU80dXNWQUlRVklrWG5qRFNIMjFTaU90?=
 =?utf-8?B?QStNMlV2RTZHOXZBeExMT0dxakxHTzFZWFZvRk1VcnBmR3BnL1dOWFNnbzVx?=
 =?utf-8?B?OWloS1hCSjhBd2FxdTU1REQvSmViQkJ4UFhjdVR2UVpMY05GZzcveGdFQ3Jm?=
 =?utf-8?B?YVVSK1JUZGNRZkVrOExLQXF4YXdQc0c1YUpKNklBakV0bUpUNXFmQUNSTDl3?=
 =?utf-8?B?V0E4QjltQ2RQNDBWZVVjakFuYjV3ellnREU1bTRXekdkUmlYNThmcHZOcUFt?=
 =?utf-8?B?UHhPZHZoVmlja3pIenlUaGl3ZWQ0V0RzQ0l1Zy9rdkxOQjBmKzM5aDRFUDNO?=
 =?utf-8?B?ZWlGNTFIWHZtME5lWEZOWkhPcGMvU3lwa25WQXJPTTErNlVzKzNIR245bEw4?=
 =?utf-8?B?ZXFnd0hLVENubE5hZFJLR010TjZ5ZWo0M0tKYjJHZy8ybEM5UE5NNmtUaGxS?=
 =?utf-8?B?TnR3cVUrMTZLZlRReFVZTS9Oc1A4RWhuSGFCd2FqNkpIenk3elpJa1pMZDNi?=
 =?utf-8?B?ZlNnSjFYaHRRZUZwSm1YT29LVXd1UDMwMVVRaWRGTlphNFB1UWhYQ2VsYkRs?=
 =?utf-8?B?a2tRdmVHd0VVM3ZpM21sdlJtaXdoZG41ZW5GYkZYcTd1dFpmUnMxWGEvNGtq?=
 =?utf-8?B?ZFhSa0VBSDVOZHhWQ3h2TklkV1JQdU1TblVUaWJZTndzTWNTNEtGNlh3OGV4?=
 =?utf-8?B?d203R1JCY0duNzFJeUVCTThQdDhEUDVwbkd1UzNURW56bDRVaGRSUVArRmNU?=
 =?utf-8?B?LzJVdXB6dXFQaEdCUFR2YjVoeFNkWC9NejhIcU8yVHNPWmtkMmY3U2p6N0Rz?=
 =?utf-8?B?Qy9oSVR2VjhyRWQ1S0o3aVg4NkpoQzNOcTdJWDBSNW56Rk5VTnQyUWZMbmdr?=
 =?utf-8?B?TVR5UUp4cDN4ZGJuMktQc1VvcG41T0xoenU1T0hXVDNlZjFKRzZyeWF5S0gv?=
 =?utf-8?B?RzB4eDQyNmhJbW1zRlEvekN0SkRTRHkrQ3ZRM09MY0tsbEZGYUF3M2d5aitF?=
 =?utf-8?B?anZjWWttd29ZZHJVNXpNYTNENDlKVlFjMU9LV0UyNFNRRm9xSnZqazNnVG83?=
 =?utf-8?B?QUFSYXBQM3FTcWtKSHdWRlNxSWkvNGhhV2lwL25yRU9DV0ZaTFhlL2lUdDN0?=
 =?utf-8?B?WjIySkwva20wRWp2ZUNVOFc1VGJqdmN5elB5TU51KzFqQUMzZ3FzUndwUnhB?=
 =?utf-8?B?YlVBdFA0cTN3a1B5ak90Nzl6MzMyU2JRSVEyanRrVmhBSnFuZHMzczByeGIz?=
 =?utf-8?B?YURxcVk1OUJqVjFPK2tiV2w5WmxTakRLaUJNQ2hUczBOZFpramFSdUVkSnQ3?=
 =?utf-8?B?Tnl4OExON1QrYXU5Tit3ZCtlQ3MvdmlWQUl6SitzczQzZmtIc2xFTHBKcWZT?=
 =?utf-8?B?czZ1cjZUUmU0Q0lrdWRhdXBhR2RldGNIMzQ5eFRrVmtEMmErNjNtd29XNTdM?=
 =?utf-8?B?TXpKdlhiOUorRk8yMEw2U2FyMnpKdDQ4OGdQWXBIK3N6eXM4QSs2UTB4UjMx?=
 =?utf-8?B?UHlRellhZ2JCb2ZOM25JbW9neXk5T1MwZys1RWFNdWZHK1dPL3YraTZvTzFV?=
 =?utf-8?B?L0Fac01yZDZ5NGhzeUt4NXBiclhaN3UvcE1jd0NweDlMYmN6RExVWDBZUURR?=
 =?utf-8?B?TzltNU1PV0U5Y3YveEx0QUVHZ3NsdXdoenRjZmxyYjF4RWhpL3V2blVZcFRk?=
 =?utf-8?B?eGJsSjVTRlRubDh2ejZ5TXMvYWlEeS9NZ1Avd21lT0kvRVpVdkRpOFo5RUgr?=
 =?utf-8?B?QVdFYjlObEE3QS9LTWNJU2tsRm1nTGVKbDJqTVRrM0FSZEtLOFU0b1dJZ3B1?=
 =?utf-8?B?b3REZC9uQ0VERGdmb2JYZDdBMGdQcitIVUs3ODlEY0MrNjIzbERYNVNhZDla?=
 =?utf-8?B?VnhBdUpLdEZ1KzEyd2IwVE5VRVJzdXdYRWpXZm5CTzhySnFYWGVHcm9NNFhS?=
 =?utf-8?B?SUZJWkVnY2M2K0N4MUJqTnpJSC9uYUJiNmc5TTdZbEdkTS9odTVhdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f43666e-9bb5-4148-f56d-08debfe213b3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:31:24.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQcq2IgzG9e8pw4iO3UoiBc5e/xVXjx39F1UAUFF0WQx+eTs4XYpGrOszGqH4swglFez1jrFVS86IOfegLkpLzMsmJWCQ7Er0yavPAZobwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11333
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 01 Jun 2026 13:31:40 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19585

Hi Antonin,

On 6/1/26 3:21 PM, Antonin Godard via lists.yoctoproject.org wrote:
> The MIRRORS variable wasn't properly documented as Ross highlighted in
> bug 16297. Give it a proper description detailing its usage and which
> keywords are available. Also link PREMIRRORS to MIRRORS as they use the
> same syntax.
> 

Quick drive-by comment.

> [YOCTO #16297]
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>   .../bitbake-user-manual-ref-variables.rst          | 56 ++++++++++++++++++++++
>   1 file changed, 56 insertions(+)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> index 9824b58ef27..753e9a38f90 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
> @@ -1416,6 +1416,58 @@ overview of their function and contents.
>         upstream source, and then locations specified by :term:`MIRRORS` in that
>         order.
>   
> +      This variable has a specific syntax. Each line must contain a regular
> +      expression matching the original source URL on the leftmost part and a
> +      replacement URL for it on the rightmost part. For example::
> +

Leftmost and rightmost are confusing here. This is a space separated 
list which is expected to have an even number of elements as it contains 
a list of pairs (themselves separated by a space).

Note that the code handles newlines in MIRROR (see mirror_from_string in 
lib/bb/fetch2/__init__.py).

> +         MIRRORS:prepend = " \
> +             git://git.openembedded.org/.* git:///mirrors/openembedded/BASENAME \
> +         "
> +
> +      In the above example:
> +
> +      -  The leftmost part means that any Git repository (``git://`` fetcher)
> +         whose URL starts with ``git.openembedded.org/`` will be matched.
> +
> +      -  The rightmost part is the replacement URL for the original repository,
> +         which is hosted locally in the ``/mirrors/openembedded`` directory. It
> +         also uses the ``BASENAME`` keyword which is detailed below.
> +

This is mostly fine as it visually is leftmost/rightmost verbatim.

> +      The rightmost part of each line can contain keywords which are
> +      automatically replaced by BitBake. These keywords can contain either a
> +      sub-part of the original URL or meta-information about it.
> +
> +      For what follows, let's take the following URL as an example for the
> +      original source (matched by the leftmost part of the line):
> +      ``git://git.openembedded.org/project/repo.git``.
> +
> +      A replacement for this URL can be created using the following keywords:
> +
> +      -  ``TYPE``: the URL scheme or fetcher type. For the example above: ``git``.
> +      -  ``HOST``: the URL host. For the example above: ``git.openembedded.org``.
> +      -  ``PATH``: the URL path. For the example above: ``/project/repo.git``.
> +      -  ``BASENAME``: the URL basename. For the example above: ``repo.git``.
> +      -  ``MIRRORNAME``: a translation of the host and path with common
> +         characters substituted to dots (``.``). For the example above:
> +         ``git.openembedded.org.project.repo.git``.
> +
> +      The rightmost part of the line can also be a bare URL that uses no special
> +      keywords (usually ``https://`` or ``file://``). For example::
> +
> +         MIRRORS:prepend = " \
> +             git://git.openembedded.org/.* file:///mirrors/openembedded/ \
> +         "
> +
> +      In the above example, the fetcher will try to find a mirror tarball in the
> +      ``/mirrors/openembedded`` directory. The name of this tarball should follow
> +      the name of the tarball created by BitBake (for Git repositories,
> +      the :term:`BB_GENERATE_MIRROR_TARBALLS` variable must be set to "1" to
> +      generate them).
> +
> +      If we take ``git://git.openembedded.org/project/repo.git`` as an example,
> +      the tarball would have to be named
> +      ``git2_git.openembedded.org.project.repo.git.tar.gz``.
> +
>      :term:`OVERRIDES`
>         A colon-separated list that BitBake uses to control what variables are
>         overridden after BitBake parses recipes and configuration files.
> @@ -1544,6 +1596,10 @@ overview of their function and contents.
>         use ``file://`` URLs to point to local directories or network shares as
>         well.
>   
> +      The syntax of the :term:`PREMIRRORS` variable is the same as
> +      :term:`MIRRORS`. See the definition of the :term:`MIRRORS` for more
> +      details on it.
> +

s/on it//

It's implied.

Cheers,
Quentin

