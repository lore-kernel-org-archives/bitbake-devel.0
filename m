Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EC3CA0FED
	for <webhook@archiver.kernel.org>; Tue,  9 Sep 2025 12:48:43 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.79])
 by mx.groups.io with SMTP id smtpd.web10.12111.1757422114647773548
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Sep 2025 05:48:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=42spCoEb;
 spf=pass (domain: weidmueller.com, ip: 40.107.130.79, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvtI9DurPr6EdvGvc9TfuRslUhN4YOE2OXYrkzWIyA9SzPjWwbZUtr+xaIHiwjdL/k91a+pyoZRvnIOE02xZVX/+iy8gFIi5m3PCi7K1raPa1HI4PFpTZA/YaKIoEni8zHlugPLjKEWsddDcdW3Ql1boDIe+2GVQ934cbSp5mWkceP2Y2F7hKriby1CaHoCzvyHThD3bv0hVQnHrHNcWprkWecDEQgTpPRhbH1+btnf6hxILx+Av8OPmpOAhr+3UyYLWATTrRJ+lxWfl9e6NWcjIG9o6K/aZTMpqrBBfWoGuqm6UOWJLP+ojVJ6T05WopS5b4GreBk0SYk7LoM6bGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aV8o5z/W0qO3BMtC5RH+2DHIe8w/+wPu7YBCGK0DVoc=;
 b=uylR5f/iNnJswTJ68L5XcODR6kf+1w0ipfHCh7D7YXXUrHTwN7gI6Fj4uA98HZZrJNdJd7BfO8ldpFN+3ywrcnhWTpxN+rpDDbmJ60ZlwxsSdkmrHzcnNkXVyk0e5zuNbD1pBH7GT5dMU5H0GE6mFZbrbxDEYpHZyvSgYqOoNU8vK/8V/y3yUrTZ3UUJvMjkZPPoKcA8/vapRpQjaNU3YIL8ThqI9W5uF85fYhWBbt9G9jVLgvbDdQwl7Oan8JIrTKGWjFtpcyWrWlHq283QO77b5FZyvX1zNyQButWfDFbtLrygDJsK29cinZOwH0gITFLcdmMtHTyWUf7ztsF0Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aV8o5z/W0qO3BMtC5RH+2DHIe8w/+wPu7YBCGK0DVoc=;
 b=42spCoEb/SpanQ5jD1RnfVPt7HrQjnNuWYla+WFbEM2nO4ddXShshCbZmPJlub+9rVA29a787MQDQncEYP58xTEPxznU2MyDjiLoGrBTf49EjeGMPMKlh9Y70M2Qe4z3qTk2mCZXuhST4lfocF6HuOkKZsZi4Ieec0ZLi3oWLrv9cUt9val6SOGBV+Jv/XhS/nvCZjLUUjAm14LI0UUD8vTLjhUH4OjOx0vmgCVaGRtrlUrN2NFM1o7+7Q4MPcqLlNemX7zF14nRgxeXoLU6TRg2lNlV7pn3K3LjElplL68na+MAV08g+hZRKdT6uOCXPzg0Qsp8MvBWWch7pgI40Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DU0PR08MB9934.eurprd08.prod.outlook.com (2603:10a6:10:402::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 12:48:26 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 12:48:25 +0000
Content-Type: multipart/alternative;
 boundary="------------AzbCjl0WSMkiNPGKfAL28idk"
Message-ID: <2ad145ba-252c-4f00-8c33-368495ab122d@weidmueller.com>
Date: Tue, 9 Sep 2025 14:48:23 +0200
User-Agent: Mozilla Thunderbird
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
Subject: Re: [bitbake-devel] [RFC PATCH 0/6] fetch2: add support for implicit
 urls
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20250902065507.35737-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <c1124597a57241518f4ddee17c5786ecb11caf2f.camel@linuxfoundation.org>
 <be5703d4-00ee-45be-9183-7bb4a327ed79@weidmueller.com>
 <fa1466cf08081ce9812a90639925063fbd610292.camel@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <fa1466cf08081ce9812a90639925063fbd610292.camel@linuxfoundation.org>
X-ClientProxiedBy: FR2P281CA0164.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::14) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DU0PR08MB9934:EE_
X-MS-Office365-Filtering-Correlation-Id: d1b5b299-3547-4d2b-450f-08ddef9f2a79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|13003099007|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SjUxKzhrUFdCTlhZTnpldzNGZGgyV2RLRXJZQU5uS1hwSVVIeEg1Z0RNV005?=
 =?utf-8?B?MXZ5VVp3QkEwSkF4UmtTUG11MTc5QXRzVnBnWEgzOVlERWU2OURyVExWU1JU?=
 =?utf-8?B?Y1AySUpaWk5JVHFNQ3JZczcyeks5dDB3NHhhWVNxTUEyQkE4VnA1UTJ2RWdP?=
 =?utf-8?B?SklNQmducDNZcTVvVFdwcTdIVnFiYnNpK0xyYjVZYnJsK3NlZlB5WmdZbERB?=
 =?utf-8?B?a1RES25FQmM1Tm9kV3dUSjBXdWJlSlhYTm5MRlBQcXpzQ1VtK3FNWllMMldK?=
 =?utf-8?B?R0Q5RWZ2TUlFZjhCZVc3UGFRdEpPMEhYVGw3OURTQlNOTVhnL3JHNWhUdkdW?=
 =?utf-8?B?Q2pGcFJoMEJtWVhXcGJXNnhaL1FsRWNiUU1rdU9Tb21pZjZoTEQ2UGxVR0Q4?=
 =?utf-8?B?SzMvVjQycWo0anVsQ0N1NGgvUzYwV2p6bHlnL1g1UmNuRGdLVU9vRk16WGRL?=
 =?utf-8?B?T1lzRDFNS0JWYkU3M2JuTDQyd0NlMEJQMXVwRHZZOGlxblpmbmJUckNuLyto?=
 =?utf-8?B?NmJhLzVIRjVaUXJ2MmlXOG1oYkhzWTl6Z3RLZ2ZwWGw3enFKS2hDVmFHWlVO?=
 =?utf-8?B?NEJQenJYN293MGp6TlE2QllvNXczeXN5TDRTMjZkVWlnSUcvaUZkcFpJdVlM?=
 =?utf-8?B?M2pFUGJPcGN2NzNGd0VIeVdCczZ5dElsNVB3M09laUtkcXk0RFFwRDd1bFZp?=
 =?utf-8?B?QWxPbm5LVEhMbDNwNlB2MlhuYTQ2R05CMnJTeWhHaWlGWkpDZERkQnlESUpE?=
 =?utf-8?B?YjhIdHltWVIwZ3Y1dGFwY2t1OVdxUXdLcjF3KzJPWDNqUlYvZnlVZnozU0FE?=
 =?utf-8?B?b1owbGtnTktTam5pb2NhaEFDVmoxaHhiSGJHTTdmNEU0ZmVyeXBOT1k0cE1M?=
 =?utf-8?B?b0RTQmV2UHFUYytJM05VcGF1ZzQxeWx1c1daVzJuZWhGb3pQenpJVUNqSlVX?=
 =?utf-8?B?eXFNRkRhNmorMFladnRQZkhqeGJWVHFWZmFjalNVait3c0NpMjM4bUdPcjZp?=
 =?utf-8?B?NmR1Y2ZKL0kzQ3dqdEJWWFY0TGdvOWlDNHI1OVRXdStFOVI1R2J1d1h2MGRs?=
 =?utf-8?B?KzhYS0s5OUdkRXh0ZnlrN3BPQ014dGV3TXZLbTRyWXhrK1hFSXRtbUEycTQz?=
 =?utf-8?B?ejd6cEl3Qk1qenAxa1Z4aWZPa1RBbXNQNFFzYjh5RnRMY2kyQnM4L2hRTEFo?=
 =?utf-8?B?SGs2clQ3ZGlWNHdTVGFwWWhndHZQdWZ1MWpmNmtXaDRiaGJyWW5JTVdBSUQr?=
 =?utf-8?B?ekNOUFE4RkhQV2R5dWE4aWpOaUNZUzBSOFBzY2RtZVhSTXJJTEhQVDRzb0Q2?=
 =?utf-8?B?MXJNTU5qMGZtcUlTcytHU0wvcHdtVFZuTWRDM3duTGt6Sm0yLzIycFpjMTZG?=
 =?utf-8?B?TlFyb2NaS3NnZE82SVJqVFdxZTBQOVVqQlVtY1JDZTVoUmt0ZXB0K3g1OVhL?=
 =?utf-8?B?WkQyMlpIbVA0NmFwWlk2WkppQkU1b1Jaa0RXLzA3WW16VElwbktQZEt3L0RM?=
 =?utf-8?B?enlLMVlxOHBYVmpRbTc1RTBrWTZBMUpsdVNnZHZYai9pa2hEamtlcklKNlk5?=
 =?utf-8?B?UlJmN3pNd3J3U1dRM0xPRGRNcHBPZ0RNaGdnSWwwZW1VaFRlcTh0VnRUdDNV?=
 =?utf-8?B?aC9aMmJjR2VuQ1luSzRHUU0xa3d0cVVucW0wNExQQkhIZGpLSnJKVW1nTGJO?=
 =?utf-8?B?a3FuQmFEUXRWeGhxNnpZRzk3RzVtNEZzWnRtMEd5ZEFpTkVoQU9vZmJFZit1?=
 =?utf-8?B?UmtrY1FUd0o3bjBrTU54TkRWRmVtSFM2L3pQbkRNVWJhQmNIWUpJNTFtK3F1?=
 =?utf-8?B?dDdHSVIwZGJxdU5DVDdlR2dkTnMvTTA4M0JJSm0yZ1dSMjBKWGszTE1paVo4?=
 =?utf-8?Q?bl3RBmf0YtSVw?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aElCYVl1NHFkTFJQWE9HZDBrTGtTWG1JcTNuUCt1QWsrWFlKMjRMOWs3NVN0?=
 =?utf-8?B?K0NqVFlTcE9YTFgyelpIVTUxdEMzWitsTWJUMyt3bHdINFhpQ1pnQVlHeWNm?=
 =?utf-8?B?U090U1dSOHo3NUR5eDVuQklEa0RIWjkzc3JnZ0lRY1BEYlIvMmhwTmlaeDdF?=
 =?utf-8?B?cmVhMWIwcnJlYnhGeU83TVZ2YlBYZXdaWDgrMStQWG14R0pPZTFvZDdTcmFL?=
 =?utf-8?B?djRSNFFGTG5jdGpkWFpXRXN6bG94Q1NkUWM0SzFua0lQZzFvdVYrMDN3OTNF?=
 =?utf-8?B?THJPQ3QvS0xKcGpxMUNDRlNuTTNJZm1ybzNPdUZqejNhcDdreFRIMmNYMEZL?=
 =?utf-8?B?M2RhbDF1aFJCQ0xmbTMvT25jcUxXZGxyQm1BNERmZ3JaMm1zMGVBbjRnNzZD?=
 =?utf-8?B?dS95LzJTVlZQZkNGcmQrTnZiMXYrdkZYTFJUeGRWSGZwOU9IZzBGTHhOcU52?=
 =?utf-8?B?a2x5aGQ3c1lkb1RFcjZSVXFtY29kYlpXb0syN1BTWDN6SGF0bjF2eVUzYjNp?=
 =?utf-8?B?NjNQTlhBWGZMQ2I3ODduYjhJYnlyd2E1VXVWY1pVUzY0UUxGaDg0VUdpK1o4?=
 =?utf-8?B?eVJyOUFQbVBUMmd2VXZyZmhsRE9pUmJXRjY5Q0RIWkZhRFBjRmVKQmo1Y2pN?=
 =?utf-8?B?blUyblEzNTlPbEhWbkhSbm1CYmZQWFZ1TythS0hrNHZzR016SUMzaHVjbVpM?=
 =?utf-8?B?U215WEVMTTd0bjlmRGNHTHFiOGpGcUxSUkxhNStOaTI4QmIzR0JOQWpBbjFa?=
 =?utf-8?B?cFFHN1pNTVRBYUdRNko4RkZ6VnNNTVlEUzhFVHV2di9mWmw1VTZkL2N2VmEw?=
 =?utf-8?B?OG5UMG1xelJDdkxzZUpFMEQvcG9VWHhVMjcvNElYOUdRWTVCVGpLeStXVFdC?=
 =?utf-8?B?YmpGWWc1RjJvYTdPNTRMbHEyOTgrakw1Z2NUWldhdXl3eWF1cTVzTElwcVIx?=
 =?utf-8?B?QVRyQW1jTWUrZVprK2Q1RUhETmdpVE1obUdMRjlBY0N4QnBFakU1VW5GMVow?=
 =?utf-8?B?YTRyVXliSSt2K29BcVpQQkJzTUFkSmNiMWgzM0t3SWpDN0N2cUxkYmJiWU5J?=
 =?utf-8?B?ZzljNG13QjNicW5HdjJXSUpZVk0vS01lRFVETXFKcitHR1I2QndmSHpGSkw4?=
 =?utf-8?B?NW5NMTlOMHF0WTJIRGVKbHpSVS9hWVBnRzB6bzUzT2pvL255OGNkOGxSRmhK?=
 =?utf-8?B?NWMwS2FjWWw5SWFlVFVxeDVIZTdZc2syUHZUOTRtbVgydnJBeHQ4dFhsQ1B4?=
 =?utf-8?B?UjI5dEhCRjVORzVrNFhOTEUxcnBlMk9ZSEVJQmdRbjYvNTJ1TUQ3N3c0aUg4?=
 =?utf-8?B?b0lVYWh3SUdsancvNjZRQ3B4MmhIR0VtZkg2VFhBcTRKT3RDSFhOcStLU2N3?=
 =?utf-8?B?ZEhVclJjNUJNQWgvcXFsSXNDcmdUazNDOEg1ZlYwV2ZjejNhMmExempaWTJY?=
 =?utf-8?B?cmpFSmU1d0hXZDE5LzJGV2ViUnlyZXlwTWE2RlVLVFJrMytYTEdZUE9VQWV3?=
 =?utf-8?B?dGhKRmV4VExkdFBwWE11Sm9Zc3FvY1M1Zmh6cVBZNUJCdnhDd0tEUDNsUkRO?=
 =?utf-8?B?cDZ0SDdOSnFFVTBvbThORTFkdXM0MzFaUW9BTHRCN0prR2Fzc2hEMm1ueXhH?=
 =?utf-8?B?OTgzTWpLcnNBY0ZFWm5mTDJaN3pNenpnd3I0RmpQWVVueW1iZUJJLzdXTWZG?=
 =?utf-8?B?QTBUUmMxSG1VOEhVWm9oWlBHOVV2cWpGN1BMVnVWYmwrMlpGYnY3R2J6dXM1?=
 =?utf-8?B?UGVERndCNjBjbTNMeG95NXBjblFJYTVnTEY0R01KTlVZditrM3dzcGZBM0hy?=
 =?utf-8?B?R3ZrRHhNcU0vVGNPK3FrWkdTb1NvUzc5V1hWMENPTjlHbEoxeWV4cC9HMzBp?=
 =?utf-8?B?bmxpWmQxZHJEQ1NyM3I3KzgzMTBZdFF1eXc4QjJjSFgvVThvM2tKVVlWdzRs?=
 =?utf-8?B?RmdJWGRsUlhsM2RZSGt4R3hBWkNqOU1GbkxhUWUrMEtyMS91a293T2dCTU1U?=
 =?utf-8?B?RzNGOXIzY0plREhtaDhsOE5UK2RuNkdUQjlHNWh4ODR3WVhIYVFEdkZTTWJF?=
 =?utf-8?B?WGtIRi85R2prRGMreHFRbUc0QjlSU2xzaFpKc2dXY04xZEErYUlqN3ZCMk1v?=
 =?utf-8?B?K2hWODdJeXBjM2Z5SjFqK1E0VnFuOHMwOU9WZG9qdzVQTDZ3aEw2YzQ3N0Jq?=
 =?utf-8?B?cGc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1b5b299-3547-4d2b-450f-08ddef9f2a79
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 12:48:25.2694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRDVd+SIhsiFGGrZVDVdV1jyHeLws9zHinhkXUfyYp/2yB0bhBaVRH+JqahZK1mVs8NX7W6RJmkXZ7C+N8xK7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9934
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Sep 2025 12:48:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17992

--------------AzbCjl0WSMkiNPGKfAL28idk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 08.09.2025 um 12:26 schrieb Richard Purdie:
> On Mon, 2025-09-08 at 11:20 +0200, Stefan Herbrechtsmeier wrote:
>>   Am 07.09.2025 um 17:52 schrieb Richard Purdie via lists.openembedded.org:
>>   On Tue, 2025-09-02 at 08:55 +0200, Stefan Herbrechtsmeier via lists.openembedded.org wrote:
>>>> The patch series add support for implicit URLs inside the fetcher. The
>>>> implicit URLs could be defined inside a source like a version control
>>>> system (git submodule) or a lock file (package-lock.json, cargo.lock or
>>>> go.sum). The integration of implicit URLs beside explicit URLs
>>>> simplifies the fetcher classes and avoid bugs because of iterations
>>>> between the Fetch and FetchMethod classes.
>>>>
>>>> The series remove most methods inside the gitsm fetcher and only leaves
>>>> the parsing of the git submodules and the unpack functionality. It
>>>> allows the gitsm fetcher to use the premirror only feature. The current
>>>> implementation leads to problems because the download of the git
>>>> submodules is triggered via the download method which is called deeply
>>>> inside the fetcher code.
>>>   We had the discussion a while back and the conclusion seemed to be that
>>> implict urls were disliked by a significant number of people as the
>>> were too unclear about what was going on behind the scenes and also
>>> made things like software manifests harder.
>>>    
>>>
>> It looks like I miss some discussion and especially the conclusion.
>>   
>>
>>   I assume you mean recipes by software manifests.
> No, I did mean software manifests. If the urls are explict, it makes
> generating manifests of the sources being used more obvious for people
> to understand.
Do you think the following is really helpful for a software manifest?

npm://registry.npmjs.org/;package=xyz;version=1.2.3
gomod://xyz;version=1.2.3
crate://crates.io/xyz/1.2.3

I assume software manifests needs the real URLs and a common style for 
the name and version.

How do we solve the problem if we keep the gitsm fetcher and doesn't 
propose an alternative solution?

> Yes, there are programmatic ways of doing it with
> implicit urls but people don't like them.

Based on your reaction regarding the gitsm fetcher I would say a lot of 
people like the implicit URLs. But without details it is impossible to 
understand the real problem. Maybe a task to generate a generic include 
file or a file in the work directory with explicit and implicit URLs 
solve their problems.

> By conclusions, I was taking that as the outcome of the last set of
> discussions but there was a lot of different emails and it was hard to
> follow. Perhaps i got the conclusion wrong, I don't know.

My understand was that implicit URLs have drawbacks but nothing we 
couldn't overcome.

>>>   There was a strong
>>> preference for metadata helpers and explicit lists of components
>>> which
>>> we have for crates/rust and now for go too.
>>>   
>>   
>> Does this mean the npmsw and gitsm fetchers are obsolete and should
>> be replace by a metadata helpers to fix open issues?
> I really don't know about npmsw. I don't use it and I don't really
> follow development there. I'm don't know much about the current set of
> issues it may have.
>
> With gitsm, I think that is generally accepted by people and I don't
> see a strong reason to change it at present.

Doesn't you say that people don't like implicit URLs and that they are 
problematical for software manifests?

>   I would be interested in a
> clear summary of what the known issues are (e.g. the premirror issue
> you mentioned).
https://bugzilla.yoctoproject.org/show_bug.cgi?id=15875

The combination of BB_FETCH_PREMIRRORONLY and gitsm doesn’t work because 
the download of the submodules is handled inside the try_mirror_url 
function after the enable of BB_NO_NETWORK. The current code has a 
recurrence between the download method of the Fetch class and the 
download function of the FetchMethod class.

The need_update method is used to trigger a download of the submodules 
and the extract_urldata function is only acceptable after a download. It 
doesn't matter if bitbake support one or more fetchers with implicit 
URLs. Any user needs to handle it anyway. Either we should deprecate 
implicit URLs to simply the code or we should support it inside the 
Fetch class.

>>> It feels like this series is moving us back to the other direction.
>>> Is
>>> that correct and if so, what has changed in the approach since the
>>> last
>>> discussion?
>>>   
>>   
>> Do you mean the response to my last RFC? In this case it wasn't clear
>> to me that the project is against implicit URLs and that the npmsw
>> and gitsm fetcher are the wrong direction.
> I'm trying to read the "mood" of our developer community and right now,
> it feels like putting a lot of complexity hidden in the fetcher isn't
> what people want to see as they don't understand it and can't "see"
> what is going on. During the discussions, I think we identified some
> key fundamental issues with implict urls for some fetch types too.
That's the reason for this series. It adds native support for implicit 
URLs and doesn't misuse the need_update function. The implicit URL 
fetchers only need to implement the implicit_urls function.

> There is some hard work needs to be done in trying to summarise those
> discussions and writing down the "results" so that we don't have to
> redo this every time a new patch series comes along. By that, I mean a
> non-emotive list of the current advantages, disdtantages and known bugs
> of the current approach and any proposed alternatives we might choose.
>   It perhaps falls to me as the developer lead for bitbake to try and do
> it but I'd very much welcome help from anyone else in trying to do it
> as I simply don't have the mental bandwidth to try and do that for this
> topic right now (due to e.g. bitbake-setup). I certainly don't have to
> be the one who does it. I appreciate it isn't a fun task though.

What is the current approach? Do you mean implicit vs explicit URLs?

>> This series is only a cleanup of the existing functionally. The gitsm
>> fetcher uses implicit URLs but doesn't work correct because of the
>> misuses of the download code.
> I'm worried about where the series is trying to take the project and
> codebase though, hence the questions about intent.

I only rework the code and make features explicit. The fetchers already 
use implicit URLs but now it is clear that the localpaths method doesn't 
return the local paths of the implicit URLs. The implicit URLs are 
handled by the download method direct and not deeply inside the download 
method via the download method of the fetcher. A recursion inside the 
git submodules shouldn't be a problem because the outer download is 
finished before the inner download starts.

>> It is useless to start the discussion again. The project doesn't like
>> implicit URLs. It prefers a special task as a replacement for the
>> separate recipetool. It decides against the on-the-fly parse inside
>> the fetcher.
> The developers using the project feel much happier with that approach,
> yes.

I wonder why these developers prefer a single gitsm SRC_URI entry 
instead of a list of git entries because they lose the fine grain 
control in this case.

>> How should I proceed? I have working code which parse the cargo.lock,
>> go.sum and package-lock.json files and only use Git and Wget
>> fetchers. The code uses the vendor feature of the package managers to
>> create a patchable folder of the sources. It simplifies the npm class
>> and add additional classes to build packages. The code integrates
>> valid URLs inside the SBOM and creates components with name and
>> version per dependency. Furthermore, I have rework the gitsm fetcher
>> to hopefully fix some open issues. I can convert my cargo, go, npm
>> and gitsm parser into metadata helpers but this is useless if the
>> project dislike python functions to generate URLs like the pypi class
>> or prefer package manager specific code inside the fetcher.
> So you are proposing we drop the crate and gomod fetchers in favour of
> implict urls?
No. These changes are mutual exclusivity. In my case the crate and gomod 
fetcher aren't needed.

> I'd suggest sharing a branch of your changes so that others can see and
> understand the implications and hopefully experiment a bit, see if it
> can convince some people that implict urls are the way forward.
I will do but need some time because I focus on the rework of the gitsm 
fetcher.

Regards
   Stefan

--------------AzbCjl0WSMkiNPGKfAL28idk
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 08.09.2025 um 12:26 schrieb Richard
      Purdie:<br>
    </div>
    <blockquote type="cite" cite="mid:fa1466cf08081ce9812a90639925063fbd610292.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">On Mon, 2025-09-08 at 11:20 +0200, Stefan Herbrechtsmeier wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">&nbsp;Am 07.09.2025 um 17:52 schrieb Richard Purdie via lists.openembedded.org:
&nbsp;On Tue, 2025-09-02 at 08:55 +0200, Stefan Herbrechtsmeier via lists.openembedded.org wrote:
</pre>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="" class="moz-quote-pre">The patch series add support for implicit URLs inside the fetcher. The
implicit URLs could be defined inside a source like a version control
system (git submodule) or a lock file (package-lock.json, cargo.lock or
go.sum). The integration of implicit URLs beside explicit URLs
simplifies the fetcher classes and avoid bugs because of iterations
between the Fetch and FetchMethod classes.

The series remove most methods inside the gitsm fetcher and only leaves
the parsing of the git submodules and the unpack functionality. It
allows the gitsm fetcher to use the premirror only feature. The current
implementation leads to problems because the download of the git
submodules is triggered via the download method which is called deeply
inside the fetcher code.
</pre>
          </blockquote>
        </blockquote>
      </blockquote>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">&nbsp;We had the discussion a while back and the conclusion seemed to be that
implict urls were disliked by a significant number of people as the
were too unclear about what was going on behind the scenes and also
made things like software manifests harder.
&nbsp;&nbsp;

</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">It looks like I miss some discussion and especially the conclusion.
&nbsp;

&nbsp;I assume you mean recipes by software manifests.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">No, I did mean software manifests. If the urls are explict, it makes
generating manifests of the sources being used more obvious for people
to understand. </pre>
    </blockquote>
    Do you think the following is really helpful for a software
    manifest?<br>
    <br>
    npm://registry.npmjs.org/;package=xyz;version=1.2.3<br>
    gomod://xyz;version=1.2.3<br>
    crate://crates.io/xyz/1.2.3<br>
    <br>
    I assume software manifests needs the real URLs and a common style
    for the name and version.<br>
    <br>
    How do we solve the problem if we keep the gitsm fetcher and doesn't
    propose an alternative solution?<br>
    <br>
    <blockquote type="cite" cite="mid:fa1466cf08081ce9812a90639925063fbd610292.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">Yes, there are programmatic&nbsp;ways of doing it with
implicit urls but people don't like them.</pre>
    </blockquote>
    <p>Based on your reaction regarding the gitsm fetcher I would say a
      lot of people like the implicit URLs. But without details it is
      impossible to understand the real problem. Maybe a task to
      generate a generic include file or a file in the work&nbsp;directory
      with explicit and implicit URLs solve their problems.&nbsp;</p>
    <blockquote type="cite" cite="mid:fa1466cf08081ce9812a90639925063fbd610292.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">By conclusions, I was taking that as the outcome of the last set of
discussions but there was a lot of different emails and it was hard to
follow. Perhaps i got the conclusion wrong, I don't know.
</pre>
    </blockquote>
    <p>My understand was that implicit URLs have drawbacks but nothing
      we couldn't overcome.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:fa1466cf08081ce9812a90639925063fbd610292.camel@linuxfoundation.org">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">&nbsp;There was a strong
preference for metadata helpers and explicit lists of components
which
we have for crates/rust and now for go too.
&nbsp;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">&nbsp;
Does this mean the npmsw and gitsm fetchers are obsolete and should
be replace by a metadata helpers to fix open issues?
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">I really don't know about npmsw. I don't use it and I don't really
follow development there. I'm don't know much about the current set of
issues it may have.

With gitsm, I think that is generally accepted by people and I don't
see a strong reason to change it at present.</pre>
    </blockquote>
    <p>Doesn't you say that people don't like implicit URLs and that
      they are problematical for software manifests?<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:fa1466cf08081ce9812a90639925063fbd610292.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre"> I would be interested in a
clear summary of what the known issues are (e.g. the premirror issue
you mentioned).
</pre>
    </blockquote>
    <a class="moz-txt-link-freetext" href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=15875" moz-do-not-send="true">https://bugzilla.yoctoproject.org/show_bug.cgi?id=15875</a><br>
    <br>
    The combination of BB_FETCH_PREMIRRORONLY and gitsm doesn’t work
    because the download of the submodules is handled inside the
    try_mirror_url function after the enable of BB_NO_NETWORK. The
    current code has a recurrence between the download method of the
    Fetch class and the download function of the FetchMethod class.<br>
    <br>
    The need_update method is used to trigger a download of the
    submodules and the extract_urldata function is only acceptable after
    a download. It doesn't matter if bitbake support one or more
    fetchers with implicit URLs. Any user needs to handle it anyway.
    Either we should deprecate implicit URLs to simply the code or we
    should support it inside the Fetch class.&nbsp;<br>
    <br>
    <blockquote type="cite" cite="mid:fa1466cf08081ce9812a90639925063fbd610292.camel@linuxfoundation.org">
      <blockquote type="cite">
        <blockquote type="cite">
          <pre wrap="" class="moz-quote-pre">It feels like this series is moving us back to the other direction.
Is
that correct and if so, what has changed in the approach since the
last
discussion?
&nbsp;
</pre>
        </blockquote>
        <pre wrap="" class="moz-quote-pre">&nbsp;
Do you mean the response to my last RFC? In this case it wasn't clear
to me that the project is against implicit URLs and that the npmsw
and gitsm fetcher are the wrong direction.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">I'm trying to read the &quot;mood&quot; of our developer community and right now,
it feels like putting a lot of complexity hidden in the fetcher isn't
what people want to see as they don't understand it and can't &quot;see&quot;
what is going on. During the discussions, I think we identified some
key fundamental issues with implict urls for some fetch types too.
</pre>
    </blockquote>
    That's the reason for this series. It adds native support for
    implicit URLs and doesn't misuse the need_update function. The
    implicit URL fetchers only need to implement the implicit_urls
    function.<br>
    <br>
    <blockquote type="cite" cite="mid:fa1466cf08081ce9812a90639925063fbd610292.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">There is some hard work needs to be done in trying to summarise those
discussions and writing down the &quot;results&quot; so that we don't have to
redo this every time a new patch series comes along. By that, I mean a
non-emotive list of the current advantages, disdtantages and known bugs
of the current approach and any proposed alternatives we might choose.
&nbsp;It perhaps falls to me as the developer lead for bitbake to try and do
it but I'd very much welcome help from anyone else in trying to do it
as I simply don't have the mental bandwidth to try and do that for this
topic right now (due to e.g. bitbake-setup). I certainly don't have to
be the one who does it. I appreciate it isn't a fun task though.</pre>
    </blockquote>
    <p>What is the current approach? Do you mean implicit vs explicit
      URLs?<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:fa1466cf08081ce9812a90639925063fbd610292.camel@linuxfoundation.org">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">This series is only a cleanup of the existing functionally. The gitsm
fetcher uses implicit URLs but doesn't work correct because of the
misuses of the download code.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">I'm worried about where the series is trying to take the project and
codebase though, hence the questions about intent.
</pre>
    </blockquote>
    <p>I only rework the code and make features explicit. The fetchers
      already use implicit URLs but now it is clear that the localpaths
      method doesn't return the local paths of the implicit URLs. The
      implicit URLs are handled by the download method direct and not
      deeply inside the download method via the download method of the
      fetcher. A recursion inside the git submodules shouldn't be a
      problem because the outer download is finished before the inner
      download starts.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:fa1466cf08081ce9812a90639925063fbd610292.camel@linuxfoundation.org">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">It is useless to start the discussion again. The project doesn't like
implicit URLs. It prefers a special task as a replacement for the
separate recipetool. It decides against the on-the-fly parse inside
the fetcher.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">The developers using the project feel much happier with that approach,
yes.
</pre>
    </blockquote>
    <p>I wonder why these developers prefer a single gitsm SRC_URI entry
      instead of a list of git entries because they lose the fine grain
      control in this case.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:fa1466cf08081ce9812a90639925063fbd610292.camel@linuxfoundation.org">
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">How should I proceed? I have working code which parse the cargo.lock,
go.sum and package-lock.json files and only use Git and Wget
fetchers. The code uses the vendor feature of the package managers to
create a patchable folder of the sources. It simplifies the npm class
and add additional classes to build packages. The code integrates
valid URLs inside the SBOM and creates components with name and
version per dependency. Furthermore, I have rework the gitsm fetcher
to hopefully fix some open issues. I can convert my cargo, go, npm
and gitsm parser into metadata helpers but this is useless if the
project dislike python functions to generate URLs like the pypi class
or prefer package manager specific code inside the fetcher.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">So you are proposing we drop the crate and gomod fetchers in favour of
implict urls?
</pre>
    </blockquote>
    No. These changes are mutual exclusivity. In my case the crate and
    gomod fetcher aren't needed.<br>
    <br>
    <blockquote type="cite" cite="mid:fa1466cf08081ce9812a90639925063fbd610292.camel@linuxfoundation.org">
      <pre wrap="" class="moz-quote-pre">I'd suggest sharing a branch of your changes so that others can see and
understand the implications and hopefully experiment a bit, see if it
can convince some people that implict urls are the way forward.
</pre>
    </blockquote>
    I will do but need some time because I focus on the rework of the
    gitsm fetcher.<br>
    <br>
    Regards<br>
    &nbsp; Stefan<br>
    <br>
    <p><span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------AzbCjl0WSMkiNPGKfAL28idk--

