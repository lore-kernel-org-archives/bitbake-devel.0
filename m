Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D6CE7719E
	for <webhook@archiver.kernel.org>; Mon, 13 Jan 2025 07:11:14 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.97])
 by mx.groups.io with SMTP id smtpd.web11.11889.1736752264440499306
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 12 Jan 2025 23:11:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=CHhLWVOi;
 spf=pass (domain: weidmueller.com, ip: 40.107.104.97, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ef7i8LDX16n5LzPfuesNhfPwuAJTs9AjGNvaLnE2zdE0+elXb6x5EGFAUI5rSfW/tsEOg6GZQ5161c4wefuGsqgx0CdUkVEKgut5tSV9f7LfCUJnIvHAi5gdZZsuXVGGu9qPYASAfh1Lx7KzClv0Tnyoeb4DKykRqXE/hNStex427dNzHnMnf+g99KDXgehiinV7/JsD7+QzAti8UImBd4pcRWI+8aTdLGS1sbnpNwho5PNNsyb2+xDVBKO8D3QHjdLASdmFZDHm4GlduUJIHH5R+OzPEAYmjFkZrFgP6HIM1GWXNH3Yn2P1S+kCgocZQqEatXqc4I57X2C33NUGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=My0cWcFaPF/idgq3z0V1OepNChKvuhcdiKmVncaMHdE=;
 b=C26heuKOZ4qzaSYUL83QX00Wv68NOS0lycxyXmNnrFPs68tV70RQGo02T5o1CBbRqR44qlo4nJXL4BDUnCjpG70YFPbsH48c9GCkEdDaRsa5D1MstfkmNlwOB1gxAjQ0oS8GfcZM3W9umOPs2Oe2zADOsKhtaCg+nr+To50uouL2+dQdjEqPU4CZAZbIgoiNN+y5MNvW9byvsYmOnjNZfaaWQGkCmop5yjvD0Yz1+lbKBdTfibBMtzTkwf15u5R3ESLCxQOaQZhdRJsL3CYEfr8fgj+x9llu9OhCCqTgZ8f5suoom063qNjuRpYWWN2RtqxmbkL2PvISvxijtEUjeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=My0cWcFaPF/idgq3z0V1OepNChKvuhcdiKmVncaMHdE=;
 b=CHhLWVOiSqBq1T9QI6fXA/pJ3J+XJi9plOTlGVxnZEWweBpChjS4Ixae5LU7aJ5AdEGob2StqTYPpkKQ4pMs/GHI1Wj+vgMbz1CM/rfh8d8DOp7pCrfJ3VHUUV1oGoCRKLLhx6+JoqAdPNbp/l/oq4BfEwTojIrarzKpyPLXDo+dV2rzZyORY3clghsv4YapYuxS65YhOAzljAT2PbnDAN6PjY3ox+0n0o5rShNlfpiBY75TpBJqtLa+onz0czIV7wV+1PUfqoeWHGiFYgh6T1FD2fIS8RiVFRu4xOtojVabTZdQ6h+wxmonXuWI4C3LpNIH/ZMuzO8GUbdS4caNOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PR3PR08MB5851.eurprd08.prod.outlook.com (2603:10a6:102:85::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 07:11:01 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 07:11:00 +0000
Content-Type: multipart/alternative;
 boundary="------------Z8A84n4PfYvJroBvECN50STz"
Message-ID: <1d86a392-db47-4fac-81fe-5262477bcd70@weidmueller.com>
Date: Mon, 13 Jan 2025 08:11:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: Bruce Ashfield <bruce.ashfield@gmail.com>
Cc: Alexander Kanavin <alex.kanavin@gmail.com>,
 richard.purdie@linuxfoundation.org, bitbake-devel@lists.openembedded.org,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <aeac8b24d43c57b7b426983ae50ec65680dafc24.camel@linuxfoundation.org>
 <CANNYZj9q6+D6AppzUbuV_cdMszt_KA3kfsamOtcRFxoWWFjV+A@mail.gmail.com>
 <513bf8f4-fb14-42dd-89fb-275e4b468924@weidmueller.com>
 <CANNYZj_z49bpc7fnvKO737La2YHy7zCPsgzwhS-G+=OQfi6uUQ@mail.gmail.com>
 <c164bf03-b00c-421e-a41c-441fe911eac5@weidmueller.com>
 <CANNYZj_-+uq0HmLYWAU1kEBPdkiCfyjkAu8cdSjxt6PsCB=-9A@mail.gmail.com>
 <7121dc06-215a-4481-be8e-7094a45e43ad@weidmueller.com>
 <CANNYZj_Ddh0zWbE79G5TAwQrU805WrrzDbjJTopT7EgLALBgQg@mail.gmail.com>
 <4f1f10ac-4a71-4b2b-9ea7-63e1da5d3e94@weidmueller.com>
 <CADkTA4MtLO90FW6YfeHDh7Lyo7=DRvxm6xf8Q0LkhC+u0U15iQ@mail.gmail.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <CADkTA4MtLO90FW6YfeHDh7Lyo7=DRvxm6xf8Q0LkhC+u0U15iQ@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::8) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|PR3PR08MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: 75403504-9e1c-4857-ede8-08dd33a16f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|4022899009|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aTlrNUtubjJ3R2RvNGlkRUMwVEJCOGk5N2czcVhkS20zdjJCSHBmMHpoRnlK?=
 =?utf-8?B?U2dGQVFwc0w1N0paN21zNFNsbWtTekRiRG84eFlodldKNGY1M1JiYkpvYVZP?=
 =?utf-8?B?a05yb29oNlJDZXh6VDg3QVFxeUpxUnRSSC93VWtza3l5MWYzM1BydG11RVpH?=
 =?utf-8?B?dmNoV3lXT1A1c3V0dGw2Qnh5WklFc1czdnVtQzY4VkhueUZYU2tzVk11eWtj?=
 =?utf-8?B?aHl3QjlsS0ZDR2F3Skw5RGNrMS8waklzeTY2MVRxSFBoMFZDOG9jcEhyNnBE?=
 =?utf-8?B?alJ1SUw2akNRK3BqckhWbjlrUmJTTlVkeGF5NS9MUTBiYkVreUJoKzRNWkUx?=
 =?utf-8?B?K0tpR3pMRTlBRnI5TW13ZVlBSGxNZTNoZGZldnFYTVhpUnI0OHh3T2xuekQ4?=
 =?utf-8?B?anNRMGlMa3JSaThydUcrMFlVY1FXaVZNUHBHbndaQWZDdkROUG1ScUExalYy?=
 =?utf-8?B?alluVkpLZWhWd1JrbitZZlVBZnV0ZVFndWtFU1J5eStuakpoSTV6b2xxdEU4?=
 =?utf-8?B?eWVrNGF4ajFsV3NtUzcrNWtwTVpKRXNmNmtDdzBnUFRRZkY5Q09kdW1QVlBr?=
 =?utf-8?B?RlFFbG82MEFYUnpsM3dWVldCUUtRSzZCbWpwUzNSdFdDNmZ0QWtYU3dPaWpY?=
 =?utf-8?B?K2JzYVpYSmExRFFMU2hXc3FnNEVveDVPb2l4ZXhIYldkZlpOdXFxNFNHS0oz?=
 =?utf-8?B?MWZsT1l5Nk5ZV3pJblFURFlHMGc5ZndTNGtpaEgzdEQyNm4xRzQvYlQyYWJL?=
 =?utf-8?B?QXc0b3F4TzNJc3RmWHlpVm9jVUd4MHRiTjB6VVdIYmkvcjdmSDZvS1lycG9B?=
 =?utf-8?B?cWYvYVFzZ2dGRk9XeWk5U0ZVNHpzQXVzNlBsUXFCdmVWRG9XM3NaY1NjK2NB?=
 =?utf-8?B?SzREblFFQkg5SmJ1VHY3RmlTcWVOZUo5S09RQWFGZk83bFVOSThmazdERnB4?=
 =?utf-8?B?ZDZLTVlRbEhYMWZmVjQxVmRPbkFhcGMvcHc2YlpOVXkyNG80dGl0Y3F1RWtH?=
 =?utf-8?B?Yi8zQ0JTQitOUzJidXBGeWNRbGIrejlhRlViU3paZWhJQlE3OUM5dVVqTFp3?=
 =?utf-8?B?ZnRnckdUOGZHMmFLdVRzZlJ3ZFQramFyMFhVYWhna0tMaXlseGFmcHJwNnhv?=
 =?utf-8?B?WCt1NXMxRVVWZmNEWmtCTGE3di9DeER6eW9aU29aYlNDTFkwcHk4ZS9yVlJ4?=
 =?utf-8?B?OGZIYWZZMHNveG02Zk83ZlVYWENCNXhQb2tJQ3B2TU1mdVlxbFV3dGRlZHlT?=
 =?utf-8?B?RjhFbTRWOVdkQ0hMeGp3cU4vM1lrYlYwSlJGQ3lrNG4zOGlIU3F6ckVSUm1z?=
 =?utf-8?B?WkRkQUdnc2FqTURHN2I5YUZ1VXB1aVVlUXErN1BCKzl3d2c2YlRFVHVaaFZk?=
 =?utf-8?B?VDVDOXo2Wk1zaWh2RllCYVhSNVlqWVlWdXY1R3dBLzU0Vkw2b1c0ZnhrNVc4?=
 =?utf-8?B?WTdRR3lUdkF2bjZQdFJ3WTdUWjdsY3gzNjdjaHBpN3ExRnFZbVNybkhqV1Jm?=
 =?utf-8?B?bzhGenJhWTg1dGF4TkFyVUVxVThUaExZdUt1L2ZRVGE3YytYU0cyUWV2N2Zh?=
 =?utf-8?B?TG9NeTYvdTRyVVFvU0JhSkhnL0FTeXNvVFpBaW15YXZmOW5qMDg1TVNDWlkw?=
 =?utf-8?B?dmhZcC9oZTYydlNhbS84a0sweThZa3dXNjNsQzRla093MHhReGdpejdCeDF4?=
 =?utf-8?B?eVR2aDhRaDcreHNPU1haR0RVOXhKMkZxKzlnUlZWcjdXeU5PSklLOXpqRW13?=
 =?utf-8?B?MGYwLzRLSDJQMnptYVVCMEI2L3dXTlRvZElqK3M4bWY5bE80Y1hMbTh0TUZs?=
 =?utf-8?B?MHh6dUZHZytaUDVKSlpOZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(4022899009)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZThFU0RLUGNNbmpRalJEeHBhUk80clVCYVhjTE13aDBGZG43Mm96N2Z6dEpP?=
 =?utf-8?B?VlJSWkVIaXJxMmQvVWNtSXE2SGdyMWZNWVhPUVIzVE9ISElqb1BzQ1dnL3N1?=
 =?utf-8?B?b3J4VURINThyVDU4OEVDZUhyMjFFeERZVGdNaHFHRWxtbUxVbnBkcGFxek9O?=
 =?utf-8?B?dGVrUEpnNGxPelFOaEl0ZnZMZE5qNVR2ZDlxT2h2bXFaYjRvSFI1Ny9HNmhK?=
 =?utf-8?B?RjRRUk9IVVJPL1N0Y3gySFBqM0dQSk4rMGN5dms5ZGxkcnExT2ZrNmtvQXd0?=
 =?utf-8?B?TVVjUzhCL21NVVQwM0Y1Qy9rZFNJYVZ4elVZYVFxcWtWdVRXNDhoMWgwN0Z6?=
 =?utf-8?B?dHR2SUdYblRBVHFjZVN1dExHK1Q1UWljODNKcXFWc0ZRQ0YxR2Y4NGx5SVVQ?=
 =?utf-8?B?Slp1SGttdW01YjgrWGJkaUFCOTJxYndvMHBSRkMyVHZWbHFyempHRElJS05Z?=
 =?utf-8?B?dTlSRk5abjVjMHFEMDdiWVQxTG5QbElub2lDV2VHWmJpYmtCdTRzOTl4UGhS?=
 =?utf-8?B?OVlsYjhXVW13U1dDMkh5NERKdTNsVEZjbmR1d0pFWkFqTFJJMmlIYm4vN1pn?=
 =?utf-8?B?M3BVVWo2NXI0VHVaL3A2UzRBZHVpZTYraS9TMnhZOCsyWXlMck5iMWV5SVVy?=
 =?utf-8?B?Q3VRQXpPVUYram1VRTdyWWJpcUtYZWtFT0syRTlvbGFYNVQ3dDROMVE0R2Ur?=
 =?utf-8?B?bXdKTEVxcWJHenF1YWk5L2NNdnNsWU0wMjU1SGNBWmswTTdranR6VWZEeU9y?=
 =?utf-8?B?bnY0ZG5zMlRQSkhvY0ZLblNpdHVSWVJBMGkyeWljQm56cXNHeHhQeUk3RnBN?=
 =?utf-8?B?OG45MG8zUzBVdjNsYVFIOHZuQ01pa0V5Vit5RytEVjN1dCtUaVp5dlhzYjEx?=
 =?utf-8?B?aHU1cllGWXNFLzVSUlZONURsU1ZhZjIxS0NnWFQybi9sODhCSEdpVFVCVU4z?=
 =?utf-8?B?TFdDQlY0MDRRZGlCMjZQaTBnOS9jWjhTaVg3WUF2TEtyUzNYUUI3NWJDYkwy?=
 =?utf-8?B?U3pKZmh4cWhWWmMwNGdLeVd1c2w4Q09YMVNUTFlqT3hPQzFwSjA2QlV6eTdz?=
 =?utf-8?B?Z1d0R3RQNytqeGdTNURvbTkwSUdyZXhLNkpIZjRSVFNNdk8vcG83UmlNSVJm?=
 =?utf-8?B?Wkl2OUlWNkZRcFVUMmtQQ1Ftbmtua3drTmhHVzJ6QUloM3U1Y09HQTBMaXN3?=
 =?utf-8?B?MDNCb0c1T1dsa3F1dWo5d25jK25kRENxa0tnU2lIU0pSSk9LZXdocStQSHBY?=
 =?utf-8?B?clg0bk9GNXRpODZYVzRST0VnVjVmc212VUNkdWZtSlBxSzF6TmxrR0s5bFdB?=
 =?utf-8?B?SGFLYWdjS3VRczVNVmtqM2lBdW5oeDc4VDhNTDNOakdKNGc1VXVNNCt5TUZX?=
 =?utf-8?B?dkYxTW9OUnZsSS9mQVNuUkpyTEJoalhMaWpPbUVSZjRTMnJKK05Jb2t4K1JM?=
 =?utf-8?B?dU1iWjJPQmZlSERHTWJFZVpXVG5QOWw1OThqelJHOXhVRVFVYUduS291YU1q?=
 =?utf-8?B?M1MvdVRMSkhQT0xpRFFUcDdReTdVb21kK2ZESEhNSUVDdDJGeEZyQjdzMjRL?=
 =?utf-8?B?ZUFHc1c1MFo0cTEybFNaaW8wanFJRDJSb2N0RkphWUNqb1A2ek83ekFNYkhT?=
 =?utf-8?B?Z1hpMTVUMWxoc2JMOGM4ZGNVbTQ1eWozbC9qS0xCN0tPR0lrVzZEcmd2YjI0?=
 =?utf-8?B?RTl6YlNYdGxpcXFPbXZWdEZQZmhDZFlYZUl6b3VObXpOTGxnNndGbWJQR1Yw?=
 =?utf-8?B?N3dsaWc0ekJPRFhMMXVOWG05dzc5NnZyckZQdGV6TzJQSURyd1BzZFhFRTRR?=
 =?utf-8?B?OE10a3ptYzV6SkNrVFRJQjRJUStKN0pEVzM1Smx3M3NoTkJ2NFhlekFMZ1Zo?=
 =?utf-8?B?eUkySFlpbWFpdzNLUFNXV0FwTzdJd1d2cW1FdTVENnVYZUVSb0ZuOXBMb1JW?=
 =?utf-8?B?N3czc3V5bUtocFppSDIyV1FZT09vNU9zdlNaVEtjeXkzU2JMcGY5dU1oQU1u?=
 =?utf-8?B?eFNiaU9ienlVRUh1ZmcrQ2Q3NERUVHJZa2FFN3RsMEpjT2VpZEJrcFRyUG5v?=
 =?utf-8?B?bjlrT2RhdlNDdGlZZFp3cklraEFzQWhBZGxtUXZIbFdpNFBtcDNJeFAweVNX?=
 =?utf-8?B?dmFZdytpME9ETnp5by9OTmZWNjZlQmxxS2tXQmN3MEdHeXp4K1FrT2RjM0ZQ?=
 =?utf-8?B?Zmc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75403504-9e1c-4857-ede8-08dd33a16f4e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 07:11:00.8197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfPHIJ/zMOZLO19Xw+uOuxBSf/PkHxLTxSsY76JpSK9/GovxD/aS3gQLl8CQulyJDgPnq7vXLr4EFdG1VPWCYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5851
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Jan 2025 07:11:14 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17017

--------------Z8A84n4PfYvJroBvECN50STz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 10.01.2025 um 21:24 schrieb Bruce Ashfield:
> On Fri, Jan 10, 2025 at 10:04 AM Stefan Herbrechtsmeier via 
> lists.openembedded.org <http://lists.openembedded.org> 
> <stefan.herbrechtsmeier-oss=weidmueller.com@lists.openembedded.org> wrote:
>
>     Am 10.01.2025 um 14:26 schrieb Alexander Kanavin:
>>     On Fri, 10 Jan 2025 at 12:32, Stefan Herbrechtsmeier
>>     <stefan.herbrechtsmeier-oss@weidmueller.com> <mailto:stefan.herbrechtsmeier-oss@weidmueller.com> wrote:
>>>     What is your opinion regarding gitsm. Should we remove the bitbake fetcher and use a update task to generate a inc file with the source uris and source revisions?
>>     That ship has sailed. We can't remove gitsm, it has users, and they
>>     will be very angry.
>
>     This makes it impossible to fix wrong design decision or remove
>     code with a low code quality.
>
>>>     Do you really review the changes of the inc file?
>>>     I understand the points but I have the feeling that they are more theoretically for package manager dependencies or could be solved in an other way (ex. caching)
>>     But do you? I have to restate the point: a solution that can be placed
>>     inside a layer is much more scalable and maintainable than adding code
>>     to bitbake. That's why I'm leaning towards drawing the line at
>>     existing fetchers that are wget/git convenience wrappers, and shifting
>>     dependency/lockfile management to layers. It's ultimately RP's call,
>>     but he does seek feedback :)
>     I'm working on it.
>
>>     I'm fine with large SRC_URI/sha256 diffs when recipes get updated to
>>     new versions. And since you asked, no, no one looks at them, they're
>>     auto-generated noise that we learned to block out, just as we learned
>>     to quickly skim over recipe patch changes that are just line number
>>     churn and similar non-functional changes.
>
>     Instead of an inc file the generated SRC_URIs could be saved
>     inside the work directory of the recipe. This will eliminate the
>     noise and avoid a manual run of an update task after a recipe changes.
>
>
> Except for those that want the .inc file changes to be version 
> controlled (as well as SRC_URI changes), but maybe I'm 
> misunderstanding what you described above

Why should somebody version control the generated SRC_URI?


> A generated temporary/build file is definitely more visible than 
> something that is programmatically done and held internally during 
> recipe processing and build.  It opens the door for extension and 
> doing version control on it. So I don't object to the concept, I just 
> don't think I have all the details straight in my head.

A generated build file will be saved in the work directory of the recipe 
like any other generated build file. It is impossible to add it to the 
version control system. The update task create a version controlled 
generated source file. I don't understand why the version control is 
needed because the source of the generator and the generator are version 
controlled. Especially if the output is ignored during patch review. I 
think it is much more straightforward to patch the source (lock file) 
because it is complicated to handle manual changes during regeneration 
of a generated file.

>>>     Even if we put all license information inside the inc file. Who should review the changes ? What tooling is used to review the change (license content)? If we blindly trust the inc file generator, the inc file is useless and we can generate the information on-the-fly.
>>     We won't blindly trust a generator. There are multiple gate-keeping
>>     steps, some of which already work, and some should still be
>>     implemented:
>>
>>     - when creating a recipe with devtool, devtool should discover all
>>     licenses and generate appropriate recipe metadata. For classic unix-y
>>     components this has to rely on 'guessing', but things like crates have
>>     deterministic licensing metadata (a field in Cargo.toml, and LICENSE-*
>>     files if I remember right). We can also propose adding such
>>     determinism upstream if it's not currently good enough.
>>
>>     - when updating a recipe with devtool to a new upstream release, it
>>     uses thefile:// entries in LIC_FILES_CHKSUM to generate a diff of
>>     previous license texts and the new ones, and writes that as a comment
>>     into the updated recipe. The diff is reviewed by a human performing
>>     the update, and condensed into an update to the LICENSE field (if
>>     needed), and an explanation of what changed in the License-Update tag
>>     in the commit message. This could be further automated if upstream has
>>     deterministic ways to specify licenses, e.g. LICENSE =
>>     "&".join(all_license_ids).
>>
>>     - when sending the resulting patch for review, there's a mailing list
>>     bot (patchtest), which will check that any update in license checksums
>>     is accompanied by an explanation in License-Update tag. There are also
>>     humans which will check that the licensing changes are sensible.
>>     Otherwise we do trust that submitters spot important changes in
>>     licensing (from the diff in the previous step or by manual comparison,
>>     if they want) and summarise them in LICENSE correctly.
>>
>>     - finally there are various license checks that run in recipe_qa task
>>     and implemented in insane.bbclass. They could be extended to verify
>>     that every dependency has a matching license entry in the recipe and
>>     so on. Anything that can be caught by looking at the source tree and
>>     the license metadata.
>     This works for individual project but become complicated for
>     dependencies because you have to handle the same change multiple
>     times. But lets stop the discussion for now because license is out
>     of scope of this series.
>
>>>     Nevertheless I will move my implementation to oe-core and add a task to generate an inc file as starting point.
>>     That would be much appreciated. The more I think about it the more I'm
>>     convinced we should have it standardized in core.
>     What do you mean by standardized?
>
>
>     -=-=-=-=-=-=-=-=-=-=-=-
>     Links: You receive all messages sent to this group.
>     View/Reply Online (#17006):
>     https://lists.openembedded.org/g/bitbake-devel/message/17006
>     Mute This Topic: https://lists.openembedded.org/mt/110212697/1050810
>     Group Owner: bitbake-devel+owner@lists.openembedded.org
>     <mailto:bitbake-devel%2Bowner@lists.openembedded.org>
>     Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub
>     [bruce.ashfield@gmail.com]
>     -=-=-=-=-=-=-=-=-=-=-=-
>
>
>
> -- 
> - Thou shalt not follow the NULL pointer, for chaos and madness await 
> thee at its end
> - "Use the force Harry" - Gandalf, Star Trek II
>
--------------Z8A84n4PfYvJroBvECN50STz
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 10.01.2025 um 21:24 schrieb Bruce
      Ashfield:<br>
    </div>
    <blockquote type="cite" cite="mid:CADkTA4MtLO90FW6YfeHDh7Lyo7=DRvxm6xf8Q0LkhC+u0U15iQ@mail.gmail.com">
      
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <div dir="ltr" class="gmail_attr">On Fri, Jan 10, 2025 at
            10:04 AM Stefan Herbrechtsmeier via <a href="http://lists.openembedded.org" moz-do-not-send="true">lists.openembedded.org</a>
            &lt;stefan.herbrechtsmeier-oss=<a href="mailto:weidmueller.com@lists.openembedded.org" moz-do-not-send="true" class="moz-txt-link-freetext">weidmueller.com@lists.openembedded.org</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <div>Am 10.01.2025 um 14:26 schrieb Alexander Kanavin:<br>
              </div>
              <blockquote type="cite">
                <pre>On Fri, 10 Jan 2025 at 12:32, Stefan Herbrechtsmeier
<a href="mailto:stefan.herbrechtsmeier-oss@weidmueller.com" target="_blank" moz-do-not-send="true">&lt;stefan.herbrechtsmeier-oss@weidmueller.com&gt;</a> wrote:
</pre>
                <blockquote type="cite">
                  <pre>What is your opinion regarding gitsm. Should we remove the bitbake fetcher and use a update task to generate a inc file with the source uris and source revisions?
</pre>
                </blockquote>
                <pre>That ship has sailed. We can't remove gitsm, it has users, and they
will be very angry.</pre>
              </blockquote>
              <p>This makes it impossible to fix wrong design decision
                or remove code with a low code quality.<br>
                <span style="white-space:pre-wrap">

</span></p>
              <blockquote type="cite">
                <blockquote type="cite">
                  <pre>Do you really review the changes of the inc file?
I understand the points but I have the feeling that they are more theoretically for package manager dependencies or could be solved in an other way (ex. caching)
</pre>
                </blockquote>
                <pre>But do you? I have to restate the point: a solution that can be placed
inside a layer is much more scalable and maintainable than adding code
to bitbake. That's why I'm leaning towards drawing the line at
existing fetchers that are wget/git convenience wrappers, and shifting
dependency/lockfile management to layers. It's ultimately RP's call,
but he does seek feedback :)</pre>
              </blockquote>
              I'm working on it.<br>
              <br>
              <blockquote type="cite">
                <pre>I'm fine with large SRC_URI/sha256 diffs when recipes get updated to
new versions. And since you asked, no, no one looks at them, they're
auto-generated noise that we learned to block out, just as we learned
to quickly skim over recipe patch changes that are just line number
churn and similar non-functional changes.</pre>
              </blockquote>
              <p> Instead of an inc file the generated SRC_URIs could be
                saved inside the work directory of the recipe. This will
                eliminate the noise and avoid a manual run of an update
                task after a recipe changes.<br>
                <span style="white-space:pre-wrap"></span></p>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div>
            <div class="gmail_default" style="font-size:small">Except
              for those that want the .inc file changes&nbsp;to be version
              controlled (as well as SRC_URI changes), but maybe I'm
              misunderstanding what you described above</div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>Why should somebody version control the generated SRC_URI?<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:CADkTA4MtLO90FW6YfeHDh7Lyo7=DRvxm6xf8Q0LkhC+u0U15iQ@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <div>
            <div class="gmail_default" style="font-size:small">A
              generated temporary/build file is definitely more visible
              than something that is programmatically done and held
              internally during recipe processing and build.&nbsp; It opens
              the door for extension and doing version control on it.&nbsp;
              So I don't object to the concept, I just don't think I
              have all the details straight in my head.<br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>A generated build file will be saved in the work directory of the
      recipe like any other generated build file. It is impossible to
      add it to the version control system. The update task create a
      version controlled generated source file. I don't understand why
      the version control is needed because the source of the generator
      and the generator are version controlled. Especially if the output
      is ignored during patch review. I think it is much more
      straightforward to patch the source (lock file) because it is
      complicated to handle manual changes during regeneration of a
      generated file.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:CADkTA4MtLO90FW6YfeHDh7Lyo7=DRvxm6xf8Q0LkhC+u0U15iQ@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <p><span style="white-space:pre-wrap">

</span></p>
              <blockquote type="cite">
                <blockquote type="cite">
                  <pre>Even if we put all license information inside the inc file. Who should review the changes ? What tooling is used to review the change (license content)? If we blindly trust the inc file generator, the inc file is useless and we can generate the information on-the-fly.
</pre>
                </blockquote>
                <pre>We won't blindly trust a generator. There are multiple gate-keeping
steps, some of which already work, and some should still be
implemented:

- when creating a recipe with devtool, devtool should discover all
licenses and generate appropriate recipe metadata. For classic unix-y
components this has to rely on 'guessing', but things like crates have
deterministic licensing metadata (a field in Cargo.toml, and LICENSE-*
files if I remember right). We can also propose adding such
determinism upstream if it's not currently good enough.

- when updating a recipe with devtool to a new upstream release, it
uses the <a moz-do-not-send="true">file://</a> entries in LIC_FILES_CHKSUM to generate a diff of
previous license texts and the new ones, and writes that as a comment
into the updated recipe. The diff is reviewed by a human performing
the update, and condensed into an update to the LICENSE field (if
needed), and an explanation of what changed in the License-Update tag
in the commit message. This could be further automated if upstream has
deterministic ways to specify licenses, e.g. LICENSE =
&quot;&amp;&quot;.join(all_license_ids).

- when sending the resulting patch for review, there's a mailing list
bot (patchtest), which will check that any update in license checksums
is accompanied by an explanation in License-Update tag. There are also
humans which will check that the licensing changes are sensible.
Otherwise we do trust that submitters spot important changes in
licensing (from the diff in the previous step or by manual comparison,
if they want) and summarise them in LICENSE correctly.

- finally there are various license checks that run in recipe_qa task
and implemented in insane.bbclass. They could be extended to verify
that every dependency has a matching license entry in the recipe and
so on. Anything that can be caught by looking at the source tree and
the license metadata.</pre>
              </blockquote>
              This works for individual project but become complicated
              for dependencies because you have to handle the same
              change multiple times. But lets stop the discussion for
              now because license is out of scope of this series.<br>
              <br>
              <blockquote type="cite">
                <blockquote type="cite">
                  <pre>Nevertheless I will move my implementation to oe-core and add a task to generate an inc file as starting point.
</pre>
                </blockquote>
                <pre>That would be much appreciated. The more I think about it the more I'm
convinced we should have it standardized in core.</pre>
              </blockquote>
              What do you mean by standardized?<br>
              <br>
              <p><span style="white-space:pre-wrap">
</span></p>
            </div>
            <br>
            -=-=-=-=-=-=-=-=-=-=-=-<br>
            Links: You receive all messages sent to this group.<br>
            View/Reply Online (#17006): <a href="https://lists.openembedded.org/g/bitbake-devel/message/17006" rel="noreferrer" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">https://lists.openembedded.org/g/bitbake-devel/message/17006</a><br>
            Mute This Topic: <a href="https://lists.openembedded.org/mt/110212697/1050810" rel="noreferrer" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">https://lists.openembedded.org/mt/110212697/1050810</a><br>
            Group Owner: <a href="mailto:bitbake-devel%2Bowner@lists.openembedded.org" target="_blank" moz-do-not-send="true">bitbake-devel+owner@lists.openembedded.org</a><br>
            Unsubscribe: <a href="https://lists.openembedded.org/g/bitbake-devel/unsub" rel="noreferrer" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">https://lists.openembedded.org/g/bitbake-devel/unsub</a>
            [<a href="mailto:bruce.ashfield@gmail.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">bruce.ashfield@gmail.com</a>]<br>
            -=-=-=-=-=-=-=-=-=-=-=-<br>
            <br>
          </blockquote>
        </div>
        <div><br clear="all">
        </div>
        <div><br>
        </div>
        <span class="gmail_signature_prefix">-- </span><br>
        <div dir="ltr" class="gmail_signature">- Thou shalt not follow
          the NULL pointer, for chaos and madness await thee at its end<br>
          - &quot;Use the force Harry&quot; - Gandalf, Star Trek II<br>
          <br>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------Z8A84n4PfYvJroBvECN50STz--

