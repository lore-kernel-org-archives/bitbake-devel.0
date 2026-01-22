Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A737AD3EE6F
	for <webhook@archiver.kernel.org>; Thu, 22 Jan 2026 14:54:09 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.62])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.39201.1769093643766196633
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Jan 2026 06:54:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=ed64nN5n;
 spf=pass (domain: weidmueller.com, ip: 52.101.69.62, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EeImuI0reyWKHCb3rCi2gEQCi4FAMZQNxhaYMTzS/EQ4Lg3keEEJx23vIag8fK2RFs+/YzWoaOQiTthar8IqZrY4isuGceqPq0kErltsZuxu6vVEw97In05iOVnjvNrSz6cDDLvhbUdwj417q20zWeA9/WWHHinD1mZ2UHdIV7n8wu3Ad4HAdrv/yXdB6lFNf22oRTyPwbgzvZFnwV6Sv2nEBcSvdsC8eHq1jWWtDd9MOUgSNAyQ/lWGYLWbRDywU3sucU3h+5Uxc5lpt20cicex/yXMJk3m7+vshmzI6+yI9Gwp3UpBiWw7YIYc/kM9pcW/Vq+cfLqTj2XfaefJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tKLU1Nd3DvdNvwWHMHl2jFISfrqyUwwPEpeE+bHaHs=;
 b=rWhAkK/NH1OSuhF+NUqGHkOuI4JjBvsBbC6LB6VGbKP/4+FK+cy9w36apHdHvReLuQovbgrFoIZd24nGAh2b2F9gexVHrH1GvWykdmQ/BNBftP8r6R7LfMTb22rl+C6xSscW2z7rSiUQwbg7JwG9Ko6vrBLI7oymlAmkpTXvQljZtvni3ycZJjgMSu7tBkH0iTKLxWY2g9hw7YohBHPgMVH+z1mQPkuys9iyA8lQGqU6YvyhgJOrl8XwP8biWKAVJsn6fwOFzz6PAyywbrIXIK0kE0odjBJ32gPOzX4d8uvUmE3CnmTNWzuBOmQo+wGd/GoXKa6ILhX5rcnCEJTcvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tKLU1Nd3DvdNvwWHMHl2jFISfrqyUwwPEpeE+bHaHs=;
 b=ed64nN5nDk1zz9ylBnPzB2A63+z4lxXKViYLKoNn0+XJCNGGmCUv62YiYf3oRLloAwYk1zi6uG7S+gIKv5hrJayovtwb/tG6EkxQsRKnnyOKeiUfAtaXg4Vs60M9PBUn+XeFg7qSYjjx0IorFG88qfYSU/y2mOyh0hFct0cl+NpiveL726q+ObLyp5X3j4uueqxUM3tk9G/ieU9TGRdn6j1+BYA5JYU6FCbulFAP3+2lk3phQpgHMXb5j+qhOzWoGUvBQmcnaDg757tseUE6LAcnOZG9LBmpzQwzGYQy/ZbdYEzO0vBIALq9+zzpGGLlSQNPgkoas/YHr5WHmZZ3/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by PAWPR08MB11039.eurprd08.prod.outlook.com (2603:10a6:102:46c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 14:53:54 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::a8fb:ac9a:8e2b:e561]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::a8fb:ac9a:8e2b:e561%7]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 14:53:54 +0000
Content-Type: multipart/alternative;
 boundary="------------IIu0KQN308BIsXc4dCUL0qZy"
Message-ID: <3f3a900e-f2fb-4596-9274-d2129799e498@weidmueller.com>
Date: Thu, 22 Jan 2026 15:53:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v3] fetch2/npm/npmsw: Disable npm and
 npmsw fetchers due to security concerns
To: richard.purdie@linuxfoundation.org
Cc: bitbake-devel@lists.openembedded.org, rybczynska@gmail.com
References: <20260122080922.1695912-1-richard.purdie@linuxfoundation.org>
 <CAApg2=R1ek+YS44f++taB-N2WpJkZ+3vJWD_dukZ+=WVhzuqnw@mail.gmail.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <CAApg2=R1ek+YS44f++taB-N2WpJkZ+3vJWD_dukZ+=WVhzuqnw@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0415.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::12) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|PAWPR08MB11039:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f16788c-fdd8-4cc3-042f-08de59c61000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|8096899003|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NERCTFBFWE9nRGxla3Q0MkJyQXh0OWxPMnd1OEpYTVlwYy84Q2UzV29KeDlJ?=
 =?utf-8?B?NFlXcG9JcnJFTjE0Zzh2YWFHWTVkWUhLbEFlUHJZZ2pVbGJ1R0MrdHJLbVhC?=
 =?utf-8?B?SklVSnVoSk9SM3Q4L0JZQ2JoUE1XcmcwUVlOUWI3VUN5N2MxeHpWdnRqT2xU?=
 =?utf-8?B?a3Zsdkg3aCtHUyt0bmFzTzdmS0Zwb1pBSW9aNkRCMFNnbEhxSHdFVm4wU2dZ?=
 =?utf-8?B?Nm9ockh0bjFaREY4OEtUVm5VYmZkQUhaemVLdm0yUERvYWxJaFdIZFdIbjFn?=
 =?utf-8?B?eGZXelNMVTRVSDFvb2tMSTBUTEtqNFBpWklNUnMvVk81K3BLN3d1MllRdEJ3?=
 =?utf-8?B?Sk9oUVU2WkxNS3lNcEhJMlpZUDB1T3RGb0h5SEpqSkRlWWpFbGhEQXJ1OXpS?=
 =?utf-8?B?aXRrTnpWdzAzbllRWmE5dUJLS0U0d3VqZVNwaFRRSmVzNHpKemhsKzh4VmlE?=
 =?utf-8?B?VERXYnQzcjFHTUlqeTNOQlRlWUlsNHQ2M0dDdzZvWTZqUnBERDd5cENzRXpS?=
 =?utf-8?B?dzRkTTR1cWdkMVBnNHFZeFV4c2t5R1YxZk55OVMrNStLWWZCL2VSQVRmMWRn?=
 =?utf-8?B?OTJlVGR6dU9CU1haNXBoNlZDZ2RvMzRRQ0tFeUJuNWhxNzNyY3dmSGlhcTN2?=
 =?utf-8?B?WHhIR3RGb2x6TGNNOG96elJ4bUNMSmk2YjUzNGkwR1Y1dGE3ZkZGeVJPWHhq?=
 =?utf-8?B?bjZXSVErdDdteUs3dHQrVkpUTDJyY3ZaMnhwamNDdndGUkxLeW9kU0NDSHRN?=
 =?utf-8?B?QjFkREtOMzJnZU52SjdPazhydHl4cXRnN2xVTThBQVN1a0M2anZNQ1ozUTVS?=
 =?utf-8?B?a3RtNHJqUFdabE9rUWR4SUxCK1JsRTF3a2VjRGU5cWx0V1FZLzUxZDA0Z1cw?=
 =?utf-8?B?aUxuZytzM1cxM242SG9KN1JnazhmNUVvSFdpS0tTdkdXVWRiZkV6ZkRTbkpM?=
 =?utf-8?B?UnVnbG9mWEJQMUo2QWdxL09URlVMOW5PZEFRRFJrczhISzZFZG1xTFpuUFJD?=
 =?utf-8?B?L0EyMHdMQWswalNJTmZZSFdrWGcrYThpY0VsS2p4ckE5eWtOTldRUmZ3czln?=
 =?utf-8?B?dm9hNWJQWldMZEFvNWpYN21uaHkvczVRRlZwZXVibDBkSDlvSTNiZGlIRTZX?=
 =?utf-8?B?dnRldjVMZm0yMHV5eHBnVmw1ZnFuSkQ3SHFEYW54NjRSeUg5NzdPRlBMY2hV?=
 =?utf-8?B?UUQxK0NxNmFvOHkyRVk0N1BsRUhGSU1VSE1MbEhFWk80anIwYTdJNTNGSTBD?=
 =?utf-8?B?UU5teVV4c1VzazZBNHY4SktOSjBPMmZXcE1vL2dHSVRUYWJzSmhwRGYxejVI?=
 =?utf-8?B?RFkxd2xOeG5OcWFyUjlGSkpzSmFaSTJiUnlPUWZ1RGpyT2liamh4VVBsQVJa?=
 =?utf-8?B?VFZBS3FwRlRVVG8xMVRJYUFPeDQxelU0NVBVeGF1M3pSaTlZSkp1ZU1BSEtM?=
 =?utf-8?B?aTJacUdkaTYrM2lnSUcyWGp1S203bmJrbVBIdUVKY0NwRE9rVjhKQisxOTFO?=
 =?utf-8?B?QVp0bm5GL0JwQmNkUnhXOURnV1hYcjl2SXpMb1lOTW9QWisrSTY4cW9Id01L?=
 =?utf-8?B?RWQyWDdZY3JldmVSTTI5QW45MzA4OEF2eGFnNkJZb2xVcFA4cFBtZnkzS3dq?=
 =?utf-8?B?ZmV0dkRxRGorejJLWFFIemdNOWs5d2pWaE1rYzV1QWRJRm1YbnFjaTRQcFpu?=
 =?utf-8?B?ajYrSnFRd2RxVmhKM0M3U2ZneFl3OVVUK2ZDRmhOVFFVcnppZ0I0aVhHbWcw?=
 =?utf-8?B?RkZNRHVFcDNPMjdZV1Bod1NDSWtOVDN5YzZocThFL3RPQUwyczJLd2NNUXJY?=
 =?utf-8?B?MXREU3Y5Y3VWY25RZmc3bEdXN1RvSFRuUFlTWHlLVlZJN0s4aGdQTUtEN1BN?=
 =?utf-8?B?TGRIelRaQ2psQkVXd0FnWHRibjhuSVo2YVp5MWJzZlg1THh0N3plK2FBQ21C?=
 =?utf-8?B?b3IvZ3JMaU9TYXQzSWpPeXZEU0hHNlBqMnZlZjBBSWVHbXhmVFVPbDVLQm1q?=
 =?utf-8?B?RFRpbGw5YlBBWllwdWtueUdCWXAxWi85N0VoaGZkVjFVbU5JYXFaQVBLeUxQ?=
 =?utf-8?Q?lx0hAT?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(8096899003)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T0VBRGtiSDJPMFNOL2dwL2pFL0xyaWJ5UDFkRUIxSERwcUhCNUNYbG44KzNn?=
 =?utf-8?B?bHlMOHNOZDloTHRFZXNublgraWVyYThsaVBIUzU0bFZWeWZTRmtTVnZYQmtq?=
 =?utf-8?B?Z0U1RDNnaVdhUFZGaVQvVlB6dU1ZZ0diUjBzeSsveXV3OE84WWh4Q2VaR21T?=
 =?utf-8?B?R3dMRFdlamtWTkR2Vyt2WTN2dCtWTEw3WWVGUDJJS2lFVGFNd0t0MnpadVh2?=
 =?utf-8?B?bHRWYW9JWElkY09LY09oZW9ZYVNocERpaStWdVRZUlp4QUV5bDErZkc2TE1K?=
 =?utf-8?B?aGQ3eTJ0UjBxRlhLekpFM2tqVmhteis5RmdHdXBld3NKam9icEFIalpaaytm?=
 =?utf-8?B?M1JrdmJCRFJrTmpaRE9VVzBXbkVzQm1jR2MzVFZ3ZTlyMk9iUWtoWHdta20y?=
 =?utf-8?B?cnprQW9qcVRrNWJrdnFxWnAzQVRMR2JrTEM4Zmk4bGpMVFBqRFVvc3dWaGxC?=
 =?utf-8?B?MDBMU3JDaUdXOHhsWVJ0aDFXS0txY2VKNjJjYWl1elRiUnRSaVpJbnNmS1Ji?=
 =?utf-8?B?aktReVh3Q01zSFV6V3ErSy8za21TNlZtRzBVL2ZDUE96ZGNSTDU0SStTY3I3?=
 =?utf-8?B?YmI4Q0pWTG9KdytkWHp4VEhISEFrOW41ZGtNV1BLcDdkRXlJQnJyeEFRTS84?=
 =?utf-8?B?N0pMYjFQWkJIOTVXeCtLWm5iVEcwMWViSHV4bDdsbi9lblVtbWJtQldSMVVu?=
 =?utf-8?B?dExycGUzTktGRHk5bk14ZEVtTzAyU3JJMGZYcSthT3U5cGdmT3ZDQ1d5Nk1h?=
 =?utf-8?B?RjByaTFZaVZTVldiNDRkWURMWU9XNUdGSGVWWFNzbk1kalo2ZFNlL0NrejIy?=
 =?utf-8?B?Rm1XeXVnWG40YjdtYStZb00rcGd1OWNCSjJrWmFONHIvdVNXdXRuMk5QQytZ?=
 =?utf-8?B?cDJzTXB1SVZuWW9relBxY3hoQVNJTExtSWtTSjJVZFBDMlNHdHovY0p1Y3BN?=
 =?utf-8?B?RjZENEl0bW1zYUZQU0ZqbUZvai9RVEV2MlM2dlRuaXRBS1hYazB1ZWRCZHB4?=
 =?utf-8?B?QUVZYTJqaDBDN0RlZmc2bGwycHE2T29kMUdlMWEvSS9Nb3BUdUVnNDViZ1Vu?=
 =?utf-8?B?cUl0d3ZiaWk2UWQ5NkdURzlGQklyQUNyZm5pZjlLci94dzE1NE1FWUN4OE9v?=
 =?utf-8?B?SFhQVkR3OTFRU09pU0p6K21GU2VPUEgrdkNLRiswZ3F2bWFNcVkvMkNQbmJU?=
 =?utf-8?B?Rm5TWUZFaFpXT2JXUTh0ZW9qMTRUQmJ6QS96VHRvdVJ0dkY0Sm1vNGE1TzhC?=
 =?utf-8?B?SFBwbS9qYnNZVE5Yc2tLZHJraTNialRleTV5Zlc4TXNjVmVNdHBXRHlpTGtv?=
 =?utf-8?B?THpCMk4xU1dNZGJQL2hHMmpiclp4R01aV1ZkN0FHT2RUUmZ6Tnh3K1ovbnNt?=
 =?utf-8?B?cWRJclR0cW9ZSlBHT2oxS0VGOWl1c0V4WmhWQ0Fua1RYS3MwMi9SUVVaVmtU?=
 =?utf-8?B?eEdLdmZnVjZjZTFCeVlISDJHT21HOElPd0g1cDRXZksvZGlacmJWU0RQZzVP?=
 =?utf-8?B?UnU1ejNoYk54cW5XbHlPWE5PbDhUYkd3R29iWVd2RDJXd1pHSmgzc0pQTW55?=
 =?utf-8?B?aE9uMlZmTUZEUEc3QnBaSmpBT1FDWVY3Q2wxY01uL1pNZFQ2V2xuSHdJQWRD?=
 =?utf-8?B?ektVckN5OHdsWVJiRG41TFlZbDdURDVWRlBmU3lOZ256VWFnV1F3bDB2S3RM?=
 =?utf-8?B?RmpqV3k2Qm9FVEYvendvVlU5K0lza2FQRHBpbHhMaS9VbGd2aHRSM1ErUW9Q?=
 =?utf-8?B?MzdrWkhaSUFHcXNPemhDRkVzaFVMeFNnN2N4OGxyZ3BtUkxhZWxQS3FNNmp2?=
 =?utf-8?B?di9NTWpXcXk3MW9IY0ZHSTdPTFFZdnRndDNuSGhlWEUxdWpHMWV3K2NpMEtU?=
 =?utf-8?B?TTBFbjFyYm42aXc2cUFTTUdKWk1sSENjb2ZxeW9kditEckU1bVY0UWtiaWg5?=
 =?utf-8?B?aDFnaGc1L2xKZTQ4R0QvRnEzSUx4UTNTcDk0cEFkYkJwTGk0MUxjU0c5NXRM?=
 =?utf-8?B?WFBUeVg3QldDMEJqMEl2N0ZIUy9KbGdPNUlxRFRLUmJKZFlmaXBXYmxyQW9k?=
 =?utf-8?B?T1JiVzBaRjIrWVI3NWFxK2ZITGxINjZKSnhVYjZXeGp1djREVmI4SitRN281?=
 =?utf-8?B?NnJTZVBNejJwelNybkVnU0tzdXFFbk1tUnFNUk1rRFFLZi9yVXdlVGpLMnZo?=
 =?utf-8?B?U1kxbUhCSThpYkZkWktYQzhSc1NQNG1QVmY1L01NTUVGM2xRajFwSUM3VnQv?=
 =?utf-8?B?R0JJL1R5TW16VlFOekMzeHR3UkQ1cE9Cbll2NmZxVjk2M1NvMlRIR0xIeGFw?=
 =?utf-8?B?QWlxLzFpMGc0N1NacEFYVjcwdlpaNGFJSk9TVFo5dGlBVW96NEJBZ0g1ZWNW?=
 =?utf-8?Q?rnYSQVoTgqTqXPdc=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f16788c-fdd8-4cc3-042f-08de59c61000
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 14:53:54.1951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrn2jYnfHCyhrKMuhf9SaV9bFAcKGba3kztMPLAwJzl+iE13BeNoN7ptIN7gkRiXk0dgm26EMjdYJ1vpltpZDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11039
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Jan 2026 14:54:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18846

--------------IIu0KQN308BIsXc4dCUL0qZy
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Richard,

Am 22.01.2026 um 14:01 schrieb Marta Rybczynska via lists.openembedded.org:

>
>
> On Thu, Jan 22, 2026 at 9:09 AM Richard Purdie via 
> lists.openembedded.org <http://lists.openembedded.org> 
> <richard.purdie=linuxfoundation.org@lists.openembedded.org> wrote:
>
>     We've been made aware that are security issues within the
>     npm/npmsw fetchers.
>     The issue is that the code accepts data like checksums from the
>     upstream
>     servers, rather than verifying it against local data from the
>     recipes. This
>     means the upstream servers could feed aritrary data into the build.
>
>     There have been maintainance issues on these fetchers for a while
>     and despite
>     asking in multiple forums, we've been unable to find anyone to
>     help fix the
>     issues. Until that issue is resolved and we can be convinced the
>     fetcher is
>     secure and modelling best practices for reproduciblity (inc.
>     mirroring), this
>     patch disables the fetchers. This has been discussed and agreed by
>     the OE TSC.
>
>     Parsing will not show errors but the recipes using these fetchers
>     will not be
>     available. Recipes will be skipped at parsing and will show an
>     error if a user
>     tries to build a recipe using them.
>
>     The import is local to the function to avoid circular dependencies
>     within
>     the hashserv selftests.
>
>     [YOCTO #16105]
>
>     Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>     ---
>      lib/bb/fetch2/npm.py   | 6 +++++-
>      lib/bb/fetch2/npmsw.py | 4 ++++
>      2 files changed, 9 insertions(+), 1 deletion(-)
>
>     diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py
>     index e469d667687..72a24c8c35f 100644
>     --- a/lib/bb/fetch2/npm.py
>     +++ b/lib/bb/fetch2/npm.py
>     @@ -150,7 +150,11 @@ class Npm(FetchMethod):
>
>          def supports(self, ud, d):
>              """Check if a given url can be fetched with npm"""
>     -        return ud.type in ["npm"]
>     +        #return ud.type in ["npm"]
>     +        if ud.type in ["npm"]:
>     +            from bb.parse import SkipRecipe
>     +            raise SkipRecipe("The npm fetcher has been disabled
>     due to security issues and there is maintainer to address them")
>     +        return False
>
>          def urldata_init(self, ud, d):
>              """Init npm specific variables within url data"""
>     diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py
>     index 2f9599ee9e2..322c7b331e5 100644
>     --- a/lib/bb/fetch2/npmsw.py
>     +++ b/lib/bb/fetch2/npmsw.py
>     @@ -64,6 +64,10 @@ class NpmShrinkWrap(FetchMethod):
>          def supports(self, ud, d):
>              """Check if a given url can be fetched with npmsw"""
>              return ud.type in ["npmsw"]
>
You forgot to remove or comment out this line.

>     +       if ud.type in ["npmsw"]:
>     +            from bb.parse import SkipRecipe
>     +            raise SkipRecipe("The npmsw fetcher has been disabled
>     due to security issues and there is maintainer to address them")
>     +        return False
>
>          def urldata_init(self, ud, d):
>              """Init npmsw specific variables within url data"""
>
>
Regard,
   Stefan

--------------IIu0KQN308BIsXc4dCUL0qZy
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>Hi Richard,<br>
      <br>
      Am 22.01.2026 um 14:01 schrieb Marta Rybczynska via
      lists.openembedded.org:</p>
    <blockquote type="cite" cite="mid:CAApg2=R1ek+YS44f++taB-N2WpJkZ+3vJWD_dukZ+=WVhzuqnw@mail.gmail.com">
      
      <div dir="ltr">
        <div dir="ltr"><br>
        </div>
        <br>
        <div class="gmail_quote gmail_quote_container">
          <div dir="ltr" class="gmail_attr">On Thu, Jan 22, 2026 at
            9:09 AM Richard Purdie via <a href="http://lists.openembedded.org" moz-do-not-send="true">lists.openembedded.org</a>
            &lt;richard.purdie=<a href="mailto:linuxfoundation.org@lists.openembedded.org" moz-do-not-send="true" class="moz-txt-link-freetext">linuxfoundation.org@lists.openembedded.org</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">We've
            been made aware that are security issues within the
            npm/npmsw fetchers.<br>
            The issue is that the code accepts data like checksums from
            the upstream<br>
            servers, rather than verifying it against local data from
            the recipes. This<br>
            means the upstream servers could feed aritrary data into the
            build.<br>
            <br>
            There have been maintainance issues on these fetchers for a
            while and despite<br>
            asking in multiple forums, we've been unable to find anyone
            to help fix the<br>
            issues. Until that issue is resolved and we can be convinced
            the fetcher is<br>
            secure and modelling best practices for reproduciblity (inc.
            mirroring), this<br>
            patch disables the fetchers. This has been discussed and
            agreed by the OE TSC.<br>
            <br>
            Parsing will not show errors but the recipes using these
            fetchers will not be<br>
            available. Recipes will be skipped at parsing and will show
            an error if a user<br>
            tries to build a recipe using them.<br>
            <br>
            The import is local to the function to avoid circular
            dependencies within<br>
            the hashserv selftests.<br>
            <br>
            [YOCTO #16105]<br>
            <br>
            Signed-off-by: Richard Purdie &lt;<a href="mailto:richard.purdie@linuxfoundation.org" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">richard.purdie@linuxfoundation.org</a>&gt;<br>
            ---<br>
            &nbsp;lib/bb/fetch2/npm.py&nbsp; &nbsp;| 6 +++++-<br>
            &nbsp;lib/bb/fetch2/npmsw.py | 4 ++++<br>
            &nbsp;2 files changed, 9 insertions(+), 1 deletion(-)<br>
            <br>
            diff --git a/lib/bb/fetch2/npm.py b/lib/bb/fetch2/npm.py<br>
            index e469d667687..72a24c8c35f 100644<br>
            --- a/lib/bb/fetch2/npm.py<br>
            +++ b/lib/bb/fetch2/npm.py<br>
            @@ -150,7 +150,11 @@ class Npm(FetchMethod):<br>
            <br>
            &nbsp; &nbsp; &nbsp;def supports(self, ud, d):<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;&quot;&quot;Check if a given url can be fetched with npm&quot;&quot;&quot;<br>
            -&nbsp; &nbsp; &nbsp; &nbsp; return ud.type in [&quot;npm&quot;]<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; #return ud.type in [&quot;npm&quot;]<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; if ud.type in [&quot;npm&quot;]:<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; from bb.parse import SkipRecipe<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; raise SkipRecipe(&quot;The npm fetcher has been
            disabled due to security issues and there is maintainer to
            address them&quot;)<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; return False<br>
            <br>
            &nbsp; &nbsp; &nbsp;def urldata_init(self, ud, d):<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;&quot;&quot;Init npm specific variables within url data&quot;&quot;&quot;<br>
            diff --git a/lib/bb/fetch2/npmsw.py b/lib/bb/fetch2/npmsw.py<br>
            index 2f9599ee9e2..322c7b331e5 100644<br>
            --- a/lib/bb/fetch2/npmsw.py<br>
            +++ b/lib/bb/fetch2/npmsw.py<br>
            @@ -64,6 +64,10 @@ class NpmShrinkWrap(FetchMethod):<br>
            &nbsp; &nbsp; &nbsp;def supports(self, ud, d):<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;&quot;&quot;Check if a given url can be fetched with
            npmsw&quot;&quot;&quot;<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return ud.type in [&quot;npmsw&quot;]<br>
          </blockquote>
        </div>
      </div>
    </blockquote>
    <p>You forgot to remove or comment out this line.<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:CAApg2=R1ek+YS44f++taB-N2WpJkZ+3vJWD_dukZ+=WVhzuqnw@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">+&nbsp;
            &nbsp; &nbsp; &nbsp; if ud.type in [&quot;npmsw&quot;]:<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; from bb.parse import SkipRecipe<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; raise SkipRecipe(&quot;The npmsw fetcher has been
            disabled due to security issues and there is maintainer to
            address them&quot;)<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; return False<br>
            <br>
            &nbsp; &nbsp; &nbsp;def urldata_init(self, ud, d):<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;&quot;&quot;Init npmsw specific variables within url data&quot;&quot;&quot;<br>
            <br>
          </blockquote>
          <div><br>
          </div>
        </div>
      </div>
    </blockquote>
    <p>Regard,<br>
      &nbsp; Stefan<br>
      <br>
    </p>
  </body>
</html>

--------------IIu0KQN308BIsXc4dCUL0qZy--

