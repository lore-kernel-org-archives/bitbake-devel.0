Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C98C021A7
	for <webhook@archiver.kernel.org>; Thu, 13 Feb 2025 07:43:29 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.94])
 by mx.groups.io with SMTP id smtpd.web11.6053.1739432599735982990
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 Feb 2025 23:43:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=MZR/n8WS;
 spf=pass (domain: weidmueller.com, ip: 40.107.241.94, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHnOBmVhOK6AUaP38Bgsyqqk4JlV3F1z5k3T7MpIMNnvOxqeIARdyQQ8NAchC+InEdYLnqFfhbAoJWqyj82sSHLGXsdX8SkGv8cR0+5lIixwbPTi+kKZRNv+GzxNQOQDaMn1RwxD6hhvTVoAEnJcSRxEA9Xla9KihjnfTbYCZGPiqPtFy+1ushJjjoQlKcaf3scxnthPl3EACbQNB7L5bir+zDbeG3Zu8ge8I3qV8VujWZiFIMbMKGkQvAPNERhKSr7WYNSBp6/C7bDZorB3coJaxDQXl84r8lZzG4kCDJ715uOYT5ZTAF1KeJkF1LheIN0G0U862DcQRJli8Mue6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmB2ujJj2L7uo7ADhsSzEfhrkyM++3KU0D+sdiAqTcY=;
 b=dLk1dr19R5rRS6yE+MR8AFXexEGTT+w8ERQ2A0SWZCwP/eI0xYUHct9iTO7c/iQDlasm6oA94yYoFDTBmmavd7wbaDfTAwz3zsMgh80Qoz2JT2B0J136s+aMsHyndlWCY8/mBAcmBD0o15T9LJ6ba82YunSrfnJG+nUwlWAAGNI39KOefx8I038/ImWChAbdvP1gHTtQsvGS1/6/ULBPM1P0uNBwdulw8o/hQM+Gfp/PATIuxXXkscq/UTeVAp+hm78qvvoADvFG3Vd53B2h6750WXYSrfBKVvidGM7q4cxY5M+VeAGrbm81TEmpQCqSS68p3GIsAYRKeOXZJGKSaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmB2ujJj2L7uo7ADhsSzEfhrkyM++3KU0D+sdiAqTcY=;
 b=MZR/n8WSS6FCnSfqOxiVnzwT/IRHubi9e8t82h/5g7u7Gr5xNpM4fwGQ7HHIILrheFJxkU6EUv7g4amuo/Whn0d/qxEEZcLIjtpufsLOyDzH95I9iQZpLB54mKBBgs3+YOHvEt62ht6A4sj1C43ip4oWBL01iMy/V0xGKAXe1itcuK9/UgqREZuHzq6YvBI7lli4QeUaUl9Q9fCoCGAE8rK2fTn85Qc3/PMF2EejBC3Dc+TnV3oTWp+SPg4S55Wnfosn2QkUobEr7VcAiyWEmffJ7w4SC+bbNn+bExvjcMP5PUbxAoAMhkxrSSo1y8BFkO8C5LUiGFD0ILVLYDiDfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DU4PR08MB11151.eurprd08.prod.outlook.com (2603:10a6:10:574::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 07:43:15 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%7]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 07:43:15 +0000
Content-Type: multipart/alternative;
 boundary="------------ZtguGFG2M0Z6cqVzbgyKtr94"
Message-ID: <39c5f882-3502-465d-bb66-f4da5f97e434@weidmueller.com>
Date: Thu, 13 Feb 2025 08:43:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [OE-core] [bitbake-devel] [RFC PATCH 10/30] conf: bitbake: add
 SRC_URI_FILES variable
To: bitbake-devel@lists.openembedded.org
References: <20250211150034.18696-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <20250211150034.18696-11-stefan.herbrechtsmeier-oss@weidmueller.com>
 <DB5PR02MB10213E77A6A5281EE044BA688EFFD2@DB5PR02MB10213.eurprd02.prod.outlook.com>
 <81801173-8a60-4278-a8b1-70715fa5accc@weidmueller.com>
 <CANNYZj-D--g+ChmBH-9kP7vj7cSNrJ=fKVmSUi8zHoLJ_EUZ3w@mail.gmail.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <CANNYZj-D--g+ChmBH-9kP7vj7cSNrJ=fKVmSUi8zHoLJ_EUZ3w@mail.gmail.com>
X-ClientProxiedBy: FR2P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::10) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DU4PR08MB11151:EE_
X-MS-Office365-Filtering-Correlation-Id: f05a2fed-4422-480d-04f5-08dd4c0212f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?L1NJWnpWRlRMcmZOY0Q2d3hUZVhwWm5WeTJvblpSSkxqUjN0WERTYnR1M3dU?=
 =?utf-8?B?MHhqUS8yb29mczJTYkQ0ODd5YnMwUHRWZUkvM21ld2ZhUUFOK1J0RndFcGZS?=
 =?utf-8?B?WW5ZTHcrWWgrN29DUnUzRFZ0dW02RWNjenkyYzhWL1NxdS9PZEN0cDJ2TmFB?=
 =?utf-8?B?dUovb2FjY2p4Wnd4Tlo1Si9nM1FQM1craFNKSFF5RU90dUQ2dUNuY0FBcFBD?=
 =?utf-8?B?YkJyNzVvdXcyZWtPVUFNRDJNREtGZ203UVlWZVVIYVVtNHlpRkRESUZPMENm?=
 =?utf-8?B?TDRHTTEwd2R3dUxTQ3BrTlNFcEtndVlCQm9rcUU3K0Q2T0hISC8wMlcwTU5x?=
 =?utf-8?B?MDl6eSs4b1I1L2pyaEVCSlJOQUpBMDZLNk96Q3BodDl0UnRBbXg2QmRJWnZK?=
 =?utf-8?B?bUR1MXJLMnpET2xpaUM5QjBqWlNweHl3ZjFTMEl6L1Z5YnBYWGxhK3pjNUpS?=
 =?utf-8?B?S0tiQ09QWU1RWnQ1dlNGS1prQklMOUFwb052YXZ6ME9UK05kVjRDSmxUc3Zj?=
 =?utf-8?B?c2Qzai8zbmVpN1FqNWZ2cmFCbVprOXd3Sk1vRkdvWEgzUWhXMURRWnNUSDNE?=
 =?utf-8?B?RmZYMGYyL2pVWlFWbmUvbXdvNGhoMVRUU3RnSUVqQWZseGxGRGNtREF4VlFT?=
 =?utf-8?B?dXJ0M01md1ZOVEVQd0FOUDcrWGVvVXFobXFjZktheGM1dm1Qa2duMjRzV0Qr?=
 =?utf-8?B?S2ZXUEtJVzZzMDIzS1ZLdnNPaG5VdWVUeTFKNXN0R04xMGpWY1ZsallJTkV5?=
 =?utf-8?B?Ny9MWDRSS2lOL09WSnk2WlVUWWpzam5uUmlTOTZLUmpTeVVTNm53VFphQ3pm?=
 =?utf-8?B?Nk0wQzI4OEpmQmp1MzF1YmxCS0lBejUrRDlpMStOZnBUREdxL0NORFFqYXVx?=
 =?utf-8?B?TE0rMVBmRkltS1ZadmMvKzVITVVnRmtTdmhlTG9oUFRRNGpSek0zRjVITnhs?=
 =?utf-8?B?bjdQbHlHcmhnczAvQm80RldjN1E1K0poUU95dHk1aHVQOVFsdU5oWnVnUkxD?=
 =?utf-8?B?K2d2c3RKWlFicloyTk91TTc3aXVkakJ3djRRditPdXRPM05FbnQrT0xnMHhJ?=
 =?utf-8?B?VVUxMVg5aTU1bUdTS1l4UGFpVXNqSjBXM1cvT0lCcytrODYvcVlhVml3NU1Z?=
 =?utf-8?B?ajVWbTEwdHlpS3dJQ2tGRnhqVUs1cmpTWVo0bEI3SEJnNnlUNVVOZW5KRjB3?=
 =?utf-8?B?L2xqY2dtYitoMmtDR0dBVHdENHg3UzFFcDZQZE5aZldRWkp4OGdsYU0wblNh?=
 =?utf-8?B?MG5LVHF6cjBYYmUvUE9UandGbkVNQ1dTU29iTHQvQVRSTmt5bWlkMlplcnB3?=
 =?utf-8?B?L2VObzZBcWFEVGQxQ1V6a1hJUE1wS2pqT1c4a3V1SnJSZ3p3R0FnRTZiNnFn?=
 =?utf-8?B?cUpEVWxHY3dya0ZVNXFRSXF4bnlaUkdzVXd6L2tGQno2eTN0QmFIcFNTRmd6?=
 =?utf-8?B?S09FeHRTV3o5T0M4d3hMdE8zZ2d1Szc1c09OVkQxQVRzYlliQzdYMlJ1Ujk5?=
 =?utf-8?B?aWF5cGw0cWpNUjRMQUh5NkFUYU4xcy9GanFmNFpuVnl4aXZMNnFGVmpHRkJl?=
 =?utf-8?B?MFFBemdpbWI5VVlYbU1yajhqZVVMMy9iZisvRXA1Z050OU9VY0hQZUhyT1FW?=
 =?utf-8?B?Q2EyMkNQSFRqenRIYlM1eE5BQml5TmM3ZTFXanJ2WTkyUG9xTmdLNUlSMFF0?=
 =?utf-8?B?YktYcVNwVjBXTmI0bDYwbUVwdEwzZm1wcitzN0xPRmc1U2hVbGJ2d0wwTVRu?=
 =?utf-8?B?WUlyWVZ3Z3BHdDBmT1lBVVkvOUx0VHFyT3dKVVgvWkZBMmdYMlFmMjgrK25x?=
 =?utf-8?B?QkxrWURMSS9UR2ExY05XRE0zVzR4Sitqb0luWjFMR2daTk5GOXVuNytmeEFo?=
 =?utf-8?Q?ILNHat6Z+OFPg?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UWNMenRNRFlOQ0xlTEgxUHJtZmRlN2Y3L3c5aGNaWWZkMGZ0eFdnMTlNYTcr?=
 =?utf-8?B?SzdtT1NENU9yS01CM3NydHNveVNuRFFQLzdUTlNiaGZtb0ZiYmlYRTlxcU5O?=
 =?utf-8?B?UEV3eDVlSUFpdlVTd0hnWFJDTTQzTzlvRlhrek40eXhUMVJvaEx5bDNnak8y?=
 =?utf-8?B?aFZ6aFRlZ3lDMDI1VXVKeHdscEVLeElQU0lSZE9PNEY3bytuU1BqZWE4MERK?=
 =?utf-8?B?cFlNNGxpbGVVZU5vS2lBeU5LazdnRXVBeVhzSnJ6MVdHMjEzR1BOWVRic0pa?=
 =?utf-8?B?M1p1emRjbGtIWjRlby9jQ2ora1k4TFU2UzRFNXMvQ3VYb1A5S3BvSVlSMGtO?=
 =?utf-8?B?d0RYZ3JobDRaME82V3lSNGVXaWZjWStwRnNaV1hBbXJyZjdzdStjOGxKYkRa?=
 =?utf-8?B?OXpKKzFmWXNHc1pMb0RLR0dWdm9ZUHJoVDI0anplWXh4UE1qNUR6RjN2WURn?=
 =?utf-8?B?czZUWlk4RjJQRUJHdHpLMnExNEY1cGpvVUxCM0EzZnBIamM1dU4yNnk1ZHlR?=
 =?utf-8?B?eDVYRmhOZHQ2UVRnSW1OTm51YnhQZkhFV3lEWk9FV1JpcEdwZjFSd1R6azNx?=
 =?utf-8?B?bjZLeWtSTEE2UVJuM2I4bXVPUEV3YmRRQ2hLZFlHWGtqYzNVUEhYeXJ2NnRC?=
 =?utf-8?B?azR0My9HVnFWcTdMUmdNeFZ0QUhSRzN5VWJ5TFQ2bi8zUFpCblc1dHlYWDAy?=
 =?utf-8?B?N1JPdWs2MXVjdUZ0NHgxSlNWbjZHTDhtbUUzS0NWNmtrbVRBQU5UVG5XcFFp?=
 =?utf-8?B?RXdVSVZLa2UwY3V4bWpQYjdJTTN3QWFQbmJoSjhsUWkvSGh0K1N3ZnVSSXh5?=
 =?utf-8?B?d2xQd0tCSTBhNzlVdXIzUjBoVldPK0cvV1d0cGFjc3V3VFU1NmJIazUyRjg0?=
 =?utf-8?B?d0FmZVhSWGtTcWhyL3JyQkhiM3ppSVhCdTFMVGUxVmNXNnJNQVpOd2J0a0JQ?=
 =?utf-8?B?NUNxNXk2Sy85RUZFMDg4VVJxS1Jhb1doajNuUjBWQmVHRzZWTkNiQk95VFdN?=
 =?utf-8?B?S3dKcWVkRVdpa2dVT1Mvc3NYZXJFU1NZVWVpUmJhZU9FWVRrSTMweVl5Y3pY?=
 =?utf-8?B?R2ttcE9HMmdGbXpTTmdLZ1kvK0JaZitTbG53SGtWcWxoL1BXbUlHQ24vTDZq?=
 =?utf-8?B?NEVWWWw1SHR3ZzZQR2REOWVLOFZ5ekk5QWFEbmEwSEdYSDNSY1JNellmQUVY?=
 =?utf-8?B?ZGZHb0J4Yk9iL1Z3N1pYeFFzYkpwc2JWaFFoOU9DcTBVeHlWaU5WWkdxVWJQ?=
 =?utf-8?B?SGFZYWVvQ2V4VSsxa1ZiZ2NUTE1xZjBWMVJnbFhKd3QybDhYOVhSbnlTekVr?=
 =?utf-8?B?aGdBbTZ1bzBIMWx0NDBtUm1JaEVnOEZscG52MXZDQks0ek5oeDFmWFdkczg4?=
 =?utf-8?B?RnN6WW5PQ3k4TG5sK29McitNeXJGRmk0TGFDaFVtV0dYVWZuNjF1ZlBLSERY?=
 =?utf-8?B?K1pTZ0xsTkZyc0ZsYk1RZUxFMVRuSDdRbFd3d09yZG1lUGQxUXA4cDdaSkZj?=
 =?utf-8?B?Um0yZldNaEZxa2R2OGM1OUxEUjMyMzcxZk5xRkpLOWc4OG1HY2F1bFRxdnI5?=
 =?utf-8?B?KzByUXRSRFdZSDBHbTcyL0hyZVZlZ0kxNnVHT084alhXNEh5UkV1QTRIYklQ?=
 =?utf-8?B?TGN1aDhHcjZaZEdXWnczcmM0c3VZWXcxdjE3UGFJNUs4SmJrb0Z4MFZDRVp4?=
 =?utf-8?B?QkgzaFJJWnlyZjRRdkNjVzdobkl0bG9Yd2VOdUU0Z3lJNVdreXM2MlNrMk9S?=
 =?utf-8?B?c0Nqa01salFRRDNBZWd0L1A0OS9SSkozb1pvNUpJeFN2RWw0L2FBaElOQlhv?=
 =?utf-8?B?cXJiYXU4dGlWSXdDQlNyckUvUlQrU1p6Z2lweUpiU0FFdjBIVE5BRXdqekc2?=
 =?utf-8?B?ZE5WSFU4SXJOaEhsa3NaWm5nZHNTOFpHcm1MY2E3WGhFN3hSSDRFdXladTRy?=
 =?utf-8?B?NW1NeXNuaVpJamczdldiQW9TQSsvYlB3T3Jqdi83MUtmTmVJRWtLWTMzVnBj?=
 =?utf-8?B?VkRydHlqUDU4UFY4QTZDU24yN0MzQ3ZRVkpML2V0am1LdVR3S29IeGQwaC9R?=
 =?utf-8?B?clJyWjZzblk0T09TeldIVUhLNnRpUHYvQ1A4YVhuUm1sTFBCaUlPbmg1a3lu?=
 =?utf-8?B?MG8vbmJqN3BDYy84dVFvR2tXQ2VMS2p3cDk2bmNTRlI3Z1Q4Mm55RHF6UmZY?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05a2fed-4422-480d-04f5-08dd4c0212f2
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 07:43:14.9782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHekkCcEyyXSoixQqBUyBcv5cyS+2r0kCeXwt3HsXBZX3owh3tE5sK+qbp4GUCYHtCpTUHZGAONLjoGl3gd9ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11151
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Feb 2025 07:43:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17209

--------------ZtguGFG2M0Z6cqVzbgyKtr94
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 12.02.2025 um 10:49 schrieb Alexander Kanavin via lists.openembedded.org:
> On Wed, 12 Feb 2025 at 09:55, Stefan Herbrechtsmeier via
> lists.openembedded.org
> <stefan.herbrechtsmeier-oss=weidmueller.com@lists.openembedded.org>
> wrote:
>
>> The variable holds paths to files which contains dynamic generated SRC_URIs. The dynamic SRC_URIs are unknown at parse time and only the file paths are fix. The files are filled with generated SRC_URIs via a separate task.
> This doesn't explain why we need this separate new variable to begin
> with. In what scenarios it would be useful? How does the
> implementation rely on it?
We can't manipulate a global variable value inside a task. We need a 
file to exchange values between task. The vendor classes resolve the 
SRC_URIs of the dependency in the resolve task. The new variable 
contains the list of files with SRC_URIs inside it. The later tasks read 
the additional SRC_URIs from the files and merge them with the recipe 
SRC_URIs.

> I'd suggest SRC_URI_DYNAMIC, we have a precedent in PACKAGES_DYNAMIC.

The variable doesn't contain a dynamic for the SRC_URI but instead a 
list of files with SRC_URIs inside the file.

--------------ZtguGFG2M0Z6cqVzbgyKtr94
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 12.02.2025 um 10:49 schrieb
      Alexander Kanavin via lists.openembedded.org:<br>
    </div>
    <blockquote type="cite" cite="mid:CANNYZj-D--g+ChmBH-9kP7vj7cSNrJ=fKVmSUi8zHoLJ_EUZ3w@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Wed, 12 Feb 2025 at 09:55, Stefan Herbrechtsmeier via
lists.openembedded.org
<a class="moz-txt-link-rfc2396E" href="mailto:stefan.herbrechtsmeier-oss=weidmueller.com@lists.openembedded.org">&lt;stefan.herbrechtsmeier-oss=weidmueller.com@lists.openembedded.org&gt;</a>
wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">The variable holds paths to files which contains dynamic generated SRC_URIs. The dynamic SRC_URIs are unknown at parse time and only the file paths are fix. The files are filled with generated SRC_URIs via a separate task.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This doesn't explain why we need this separate new variable to begin
with. In what scenarios it would be useful? How does the
implementation rely on it?
</pre>
    </blockquote>
    We can't manipulate a global variable value inside a task. We need a
    file to exchange values between task. The vendor classes resolve the
    SRC_URIs of the dependency in the resolve task. The new variable
    contains the list of files with SRC_URIs inside it. The later tasks
    read the additional SRC_URIs from the files and merge them with the
    recipe SRC_URIs.<br>
    <br>
    <blockquote type="cite" cite="mid:CANNYZj-D--g+ChmBH-9kP7vj7cSNrJ=fKVmSUi8zHoLJ_EUZ3w@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">I'd suggest SRC_URI_DYNAMIC, we have a precedent in PACKAGES_DYNAMIC.
</pre>
    </blockquote>
    <p><span style="white-space: pre-wrap">The variable doesn't contain a dynamic for the SRC_URI but instead a list of files with SRC_URIs inside the file.
</span></p>
    <p><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------ZtguGFG2M0Z6cqVzbgyKtr94--

