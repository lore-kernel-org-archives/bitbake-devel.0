Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44F3CD343F
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 10:54:17 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.62])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8842.1778151252880623275
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 May 2026 03:54:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=Dg6wzHXh;
 spf=pass (domain: cherry.de, ip: 40.107.162.62, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5oJBaQtqGOVWn5z8di0TCN1GnGKQlZpMU6eEF5ByDcPISKlED/mrPxaUhehWUaAtQ/DtuRFhGLJQd0QSXKN70U/+S6BvM4oo50i8jfP8YCJa7eUalMiUJMjTbgUS4PIjrz2Fnxp1Ja9rZg83iku6bAhc0P/usK9qsvIZ/i9GByRDbUIaC2PA6j0iOqVdor6YwQ8jBHDEjncoZd0+goTUSASAfI79zd7/4iaUyliPMNVb47A/ydfv0ofLE7UqNNDVtjk1sxI83/wUmnxFRSugNl6P/BhFlGQAVl7l+qINDP6OVmOjY1MOabVjo7zMpMKLw/qJMIfthbPsCyy7Arj0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rZMnQJgvbxKpb9GDAqjjFlygBecxojXgfISPyvROUw=;
 b=D5nznDNVoIcVCkiiovnUa2W7yM6txpHSVNNwGFfkV2TmUWdITNKOSJVLWibT+slOuiEgZmMzZZFByi3Jqlubz20o7hkJKh3vwy1Yk/dgKOvpa2PDGTab6PoQQ7UAAgQpfGbdYuHj70PRxk/sczXty1eW8DjA96/MPzrGYDMKl8QdmCt/w2D753Nex8k4aEajRkVkix7kqBcM6uxhKC4hJTy+neTExdaZEtstGVmbj9U0pHBPj4IlvvKi2Y2R0fH0IBRv5xmN+4mIoZbysIZNzSLePkQIhzGVEzNv5EHTZkPPHgg62C5MiQECoJrjIjDMJnG52GI6yfP6vqQAPqDtAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rZMnQJgvbxKpb9GDAqjjFlygBecxojXgfISPyvROUw=;
 b=Dg6wzHXh/ShvNRb5cESR5L/nyWot0ii9KhYEdI5CGjb5+UtrgKYBaVlGgD2AUxhhTZHVGq2sgcXtjrKATbUSrR/obMMKhkWQXdrG3wYSQvlCmPdbPfQ/UcaJlVrpKVAIICdOHDSQ610eMVKfmVusqWzQJww3re1nqQFMjfDjxQM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM0PR04MB11996.eurprd04.prod.outlook.com (2603:10a6:20b:6fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 10:54:08 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 10:54:08 +0000
Message-ID: <f9997cf3-c53f-46e7-85bf-f376ec8e37e4@cherry.de>
Date: Thu, 7 May 2026 12:54:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v2] doc/setversions.py: add
 --get-latest-branch argument
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20260430-doc-get-latest-branch-v2-1-fda956696a61@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260430-doc-get-latest-branch-v2-1-fda956696a61@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR2P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::14) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM0PR04MB11996:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4537fb-71dd-48c2-1410-08deac26f6cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|4133799003|22082099003|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	ZT/s5BXTxA7wP5CYli4t1w8qI4mvqdCzIgd+hw9OyBJ+lrJxOUn+RUf07g7bng2xZIkSbRATu3VakXV4J8FVtHMcDJYnSpqab/pL3/SC7Jq+JAy+nVO3W65P4O6LSbEb+7XulkwOfP1Jxc79ALzk6HTq4Ciy0L26DGl69Ui8tiClR1vT1V9SCKo7TmwE25sAzq9k+rucD3U2DMjYkj5cJ3KVY6h+dUjvZr7LTQLVh8XfnR+H5sWcd01BPytrAk3b6uMfQf34oyvlBxDpiaDKoV2xwtMDMInoVxKmewMuHekCPOoDhicjpiiMyTyPHnsTvJYS0UXFuFGx92j11JdjT+b3M6D7BzwAHVSKZHg8whNOdb9JMqpRURNfoZuH00fMY6aLwY8BadCl7xASt0Jy2Bp2AVB+wqHUMMpIPNG72kxm6qXsIfgGaFMuBPvoVTJqxjPPoc1jiYmFRpImQffuUUzkRwPcXlqxyX1KXRV5exORvPaFDZ/e3oPBuraamQ3/OCBjjAwnSUjqaiK8wgF0N4hSsfJSkkaGaj5KILSwS3dGXsOm0yxWSRlQ11cOVgus6KWA4wHh1XM4VPU5J0f3GgkhHg6bsD38B74Fblb8OlvbRgDROXJmbUCHp67Z9CX5/UbRMwuLY30f1uUYyz1jAA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(4133799003)(22082099003)(13003099007)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bi9OZW5veXBleE0xbCtSb2ZqMWE1YTZFdjVvUzZvNWlPN2hjeUJOTlQvNWpw?=
 =?utf-8?B?aTdlNFg5N0kyUC8weXdiWnM4cTNpWmQ4RTZ3YTB1TkN2V0pFS2d4bEszZHhl?=
 =?utf-8?B?OHljbGp3SWptQmtwanEyKzB0eXBZNzNsSHd4akM0VkpyVkxUMFhCZGJVWXk4?=
 =?utf-8?B?NmlUQi9UQlR4alQ3KzkwRXZ3Y2gxc3Qva2Q4UGRDRkczMW5QaGFwQWNZYmtU?=
 =?utf-8?B?NXBvVkRyTGdyQUw3YWFYTXZxSDNCd29JRXhOS0FVUEd3aDdQZDdTQld5ci83?=
 =?utf-8?B?UldLclJ0cmVZRGVabmVxSWVrdGpaZXdFSmtKSlVobWxNckVCa3g2c3c4YlFv?=
 =?utf-8?B?MkhhN3lsYk1mbHB6YkxEeDhOWm96aW1Za2dnbHE2d2dVNEhtdW13VDVlcjgv?=
 =?utf-8?B?QTN0VTBaNHBIQWFrVE1rMElZTVJxZHBOb2R2NGJXZXQ3RWVoWmt0N1MwM05B?=
 =?utf-8?B?UlBXUUJwSnhjbEpPQlNyNi91ZWl3elFWcGJXYXNlSzcrYmdlekpZdm11M2h0?=
 =?utf-8?B?VnFhWlQzOHpYOHJhS01wL0lIeTZZL1JhdmJiaFBkQVhnaXRTOFlWYmZmaXJV?=
 =?utf-8?B?NDUxblNQT2owdEo3QXRNc3VJOElKWFRISEJRYVBvOW5XMXc4TFJtR3dxemRD?=
 =?utf-8?B?OHJMRzRTTkl3WlZJWG1EWnFBWkphQVNFcHowTytEQll6ZlVXNDkwcDI4Yk5t?=
 =?utf-8?B?ZzZ1RStlQWlOR2NQWHNldlU4VXFBYzIzc1NDaVU1WXR4akdNSUtFbWhVTFRQ?=
 =?utf-8?B?RmFobExvYVNjVVE0RitiNHhjOXVnVkY1WGxDTkd5TTlpTXdZdm5sb2JYVDJ6?=
 =?utf-8?B?eThuRFIzRm9UcFR4ZUdZWHFrSkVQU2hKTkZYeFM1WXozS2o1ZUJ5a0d5b2U0?=
 =?utf-8?B?NFpnMDRKd21YWlJuVXRtRENWcnNkbVV3Kzh5YTlVQk1sU2lZaG1jd1hPTUhv?=
 =?utf-8?B?S1BHZmlVUzZSdjRpbC9nbTBDYkdLSzZEck0wREo5RlJuZVE5ZnRCWUplaDBy?=
 =?utf-8?B?Rk5XOXBBU3BOQU9QQ2dFOVZXQVp6R2Vub1pvOGtsREpCUDlSSkd1RVAyd1Rp?=
 =?utf-8?B?Vk9BQTNhVGN2T1JtNEpUMkVFMUpiaDdIejdPUEl2MU1EYkFSSE81TVdNRzFB?=
 =?utf-8?B?ckJ4NUlpS1BVNFpZR3pnd0lSVXh4OE1DaERRNEFLdEdxSTE0K1JGOHE1amZw?=
 =?utf-8?B?QjhWdzdNWWtWK2Q2UUVWWHVYYnQ0OGJyRFUzbk12UkJxR0lNZW5TYTkvclZo?=
 =?utf-8?B?Mmp5OGt1cXF5K2QzMVAwbFE4aXpTc3paczF0MDVWaDI3Y0JrazhXa2c4azdj?=
 =?utf-8?B?dTZaNDBaME5ZZHEzNmJ0bTN3VUpzbFFYNjZJcmFyakpUTy9UcG8rTGM1cnF4?=
 =?utf-8?B?enlkY0k2dzZDMlY1NGZFcm80eXdjZVNQYXBQTFZ5cUV4WkF5Tm5GS0ZDdjg1?=
 =?utf-8?B?WUJrZERXbGdGMXlxTnZuMTUwZmg4YkkrU0R0QWc2ZDdOeTNEd0w1V3o4cWh4?=
 =?utf-8?B?cnBkZE1XZmc4VHE4bUZ0aU1DQ1FLSmtSRUwwaWpiZWtLK2NtNjhPUUFaZlR3?=
 =?utf-8?B?V2o4cFhPK3JKNnBYTk9CaFMxZytXbStpR0hFaW13R0dtSTR6SjhYNXRkejVC?=
 =?utf-8?B?NGNXU3lyS3J0UWltVTBEcURaZVhiYm5LSWFjQXdUNHlkR2FaM3dUTFpvZ1lm?=
 =?utf-8?B?MU1aRlZxWWhqelNldEhqeXhKbHl5N0VLRmg0WEVKQ0JMcWtQSm83cUMxRkxT?=
 =?utf-8?B?S0R6WURYVXpPVW9yUk8vcm9qYmdSK0d3VGtWS0FSbkRFMkYySUNaSzlCSjJu?=
 =?utf-8?B?UG8wOUhqOWwzMUdXTUdVNFVheDZ4Y1phMnlibU1WZ1lQaEkvS294L0FxKzVj?=
 =?utf-8?B?RTVZb2pkV1NVdXpLdzZjbC9TbHVUQ3FpaFB4YXNpOVBrYURmUFA1TjR5bU5o?=
 =?utf-8?B?ak1icGxVNXdVc0FKakpSRUVyd0pWdjFZRS8xR0VDVkJFa0pTRDAxK0lDckJC?=
 =?utf-8?B?bWdrdVN2dEZReUVqQk4xM1NCSzBFbXZ0QWRhaTF1YWJpUC9yRks4aXVMWTBO?=
 =?utf-8?B?OHFkS1l1YnAzT284Z1ViQXgwc1l0eWhPVm9nSjRiRGcydU5hdXlONTgvdTlo?=
 =?utf-8?B?a08xQ2NSUmp0NkdDMEd1Y0RzR01DTEZETld5R1ExdjQvNW5JM2h0R21qM3h0?=
 =?utf-8?B?Zkc1Y2hQOGY5Wm1KNG9Rckg3dHJjY2FoT3IvU1BYd3J4cjNPRTRoSXp1Tld3?=
 =?utf-8?B?TEdBalF5YjNKR1Q1bEpCejNqMzMzN09YbjA3ekdGYjA5cWxIODRORXRBc0xi?=
 =?utf-8?B?UlVoMnhramlLS3hVcDNleWVTZW04K2EwVXVXUmpVZGljOVg0dGtEZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4537fb-71dd-48c2-1410-08deac26f6cf
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 10:54:08.3707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 01qLmtD3i41eVb1oU9chDNECm1KVEMMbKX0tBaj/4HzIQU5THylQ2+2HR6dZvTP+tFjDddbVD+Po+bzG47LJA+ZM8G0hLHcJFhEzEvicscY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB11996
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 10:54:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19458

Hi Antonin,

On 4/30/26 3:18 PM, Antonin Godard via lists.openembedded.org wrote:
> Add a --get-latest-branch argument that can be used to show the latest
> branch from the parsed releases.json file. This will be used by the
> Autobuilder to know what the version of the default bitbake docs page
> should be.
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
> https://lore.kernel.org/r/20260429-fix-docs-bitbake-latest-branch-v1-1-25cce6bf4f26@bootlin.com
> 
> Note: Companion patch on yocto-autobuilder-helper:
> ---
> Changes in v2:
> - Fixup help message as suggested by Quentin
> - Link to v1: https://patch.msgid.link/20260429-doc-get-latest-branch-v1-1-e5a0ce87cec4@bootlin.com
> 
> To: bitbake-devel@lists.openembedded.org
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: docs@lists.yoctoproject.org
> ---
>   doc/setversions.py | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/doc/setversions.py b/doc/setversions.py
> index f1aea0a4225..dc0bb11e75e 100755
> --- a/doc/setversions.py
> +++ b/doc/setversions.py
> @@ -13,6 +13,7 @@
>   # SPDX-License-Identifier: MIT
>   #
>   
> +import argparse
>   import itertools
>   import json
>   import os
> @@ -23,6 +24,15 @@ import textwrap
>   
>   from urllib.request import urlopen, URLError
>   
> +parser = argparse.ArgumentParser(
> +    description="Parse https://dashboard.yoctoproject.org/releases.json to get current releases information"
> +)
> +parser.add_argument("--get-latest-branch",
> +                    help="Print current latest branch and exit",
> +                    action="store_true",
> +                    default=False)
> +args = parser.parse_args()
> +
>   # NOTE: the following variables contain default values in case we are not able to fetch
>   # the releases.json file from https://dashboard.yoctoproject.org/releases.json
>   DEVBRANCH = "2.18"
> @@ -85,6 +95,10 @@ if RELEASES_FROM_JSON:
>       # current releases is also an LTS
>       ACTIVERELEASES = list(dict.fromkeys([current_branch] + LTSSERIES))
>   
> +if args.get_latest_branch:
> +    print(ACTIVERELEASES[0])

I don't remember how https://dashboard.yoctoproject.org/releases.json is 
generated and whether the first entry in the array is necessarily the 
latest available release, but if that's the case then that's fine, so:

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

