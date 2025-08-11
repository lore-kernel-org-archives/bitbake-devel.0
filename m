Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CE2C87FD2
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 09:04:55 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.43715.1754903085865337811
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 11 Aug 2025 02:04:45 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=0318e6e81f=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.8/8.18.1.8) with ESMTP id 57B5vxbZ1937559
	for <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 02:04:44 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48e1m118n4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 02:04:44 -0700 (PDT)
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57B94iEW2245788;
	Mon, 11 Aug 2025 02:04:44 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 48e1m118n3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 02:04:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTEsGYeY9GFupPovUnG5e8Ic2ys+yIvbL8T9oh7mBNO27J5Hc2UOZXZ/oF5VSycTc5h8+yKDR0OmHOM/Aj9isXBj/r6HtgFAuXy/7kgt29rgX/RoQluYw/SF3WapHRCUrmzwWCCSGvTPlGAKxXR6mX0O5cwnZhpjBFaefOz1czYFyAoRfl9MFTCkC+/VEPUVueqcsFL0oJxBadmIkzTQAHJoFxO1n6QsinHvBTDOJrjWg5bpdPeIijnTnbxMlSSYQZEkDoP9Y8ygz4FDr2LNVN8GqnngZ9AjEJiCWSko5rUJMcU0OopAnX64dhLcKHOhXX1SSo1M6f1A3D59lufhnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8inTTEin3KN8ZzlIO3lNeSuQvdzuvVrAh9jiFeqvbk=;
 b=da5Ip7UhPyAhW28BrGr+z1DxW6XdC1OXbMDYZtlyhnUMuv8AlJmq8rLi4YG0ipI8a+GGZ4SJgBsuNVBXz0DQHJtAV/T1kniyIRahPsOaDjwo5LN7CxPRklDIanCc7aQxOLyS6hubzoSMRN7G3KH4mWI4ThNb0Ra1e+eVLFHXMyEHZzCGO7RuvXrZAf0+xToSygh9Jn1tuIbVL3dHQ3OAJ4tCjxIGJROIXuXitBpr/iWdND8rVt42yxLTaZARWnkzOhZaZwEgbqSI3zG6ywjV36H6KEXO6SsoFfwFeUnI5BvFZfo3ojiDwnwGFeeo/GCtlmK3kDG3BxbWmUD5IDg05g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15)
 by PH0PR11MB4901.namprd11.prod.outlook.com (2603:10b6:510:3a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Mon, 11 Aug
 2025 09:04:41 +0000
Received: from LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d]) by LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d%5]) with mapi id 15.20.9009.021; Mon, 11 Aug 2025
 09:04:41 +0000
Message-ID: <6f8d5232-c9f8-4068-bfda-6bb694f362ac@windriver.com>
Date: Mon, 11 Aug 2025 17:04:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2: try_mirrors(): Skip invalid
 local url
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
References: <cover.1754898959.git.liezhi.yang@windriver.com>
 <87f55606dfd70b12b5d7fe97ad889300a6884359.1754898959.git.liezhi.yang@windriver.com>
 <CANNYZj8920r0c1Po9ARajRpWazWw2KNFwFoLUcdNGjkke8EgQg@mail.gmail.com>
 <cbc5cc61-9aac-424a-83a4-f0bc1c21d1d8@windriver.com>
 <CANNYZj8cUAhA+j5t9Lc0UPELpbG8nx3UmbLyUy_Axrv9-AY+Rw@mail.gmail.com>
 <9afc76ad-bb5a-4114-8f20-5571a8bcb85d@windriver.com>
 <CANNYZj8LPVJxW+nk1iRfa9uY-Mq4eTbat-5EfDsFL+coMwP1BA@mail.gmail.com>
Content-Language: en-US
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <CANNYZj8LPVJxW+nk1iRfa9uY-Mq4eTbat-5EfDsFL+coMwP1BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0206.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::17) To LV3PR11MB8531.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8531:EE_|PH0PR11MB4901:EE_
X-MS-Office365-Filtering-Correlation-Id: d74efc83-80fd-4d13-01e4-08ddd8b61b56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZnBkcC9OWW5wVmZFMHR1L3pudUc4aDFrNldVQkhYUlk2VVZ4cm03SXB0aXFC?=
 =?utf-8?B?UTN1QWx6d2UzY2dVOWJubUt0L2ZjZjhndTVzWHYvSHFORmJyMDZBbEtIMnJL?=
 =?utf-8?B?TDZra0N0ZWNzYVE5L0FhT2pBc3ExeG5iM2pOajdrVmZWQWJNTVF3Y1Z1QnFZ?=
 =?utf-8?B?S0cwdDVwOWJKYlViTTVwR3A3MDhDWnlGYXdyb3p3T21yaDNRWUo2K2lLRVdH?=
 =?utf-8?B?Q0JFNXZGVHc0RElJbDVlTEtXcmUrT2Y0S1ROc1hUTzA5TjU5Z2JiRkNkUCtm?=
 =?utf-8?B?OHhNWmJRMm1QeEN5eHd4a0Y1dTB6MkxIR1dROGk0Wm5Fa3VxbVdCRHNiWWhP?=
 =?utf-8?B?RW1CUmZuM0JuSXN4QlNiU041VFh5cGpHS1NOTDdoNzYydGVjempPVlRRUDJ0?=
 =?utf-8?B?MzN6ZVh0Q2MrdDV3N05IZThFNWc5SU1lSWRIbWI2aXhZbjBIVTV2alNheWRC?=
 =?utf-8?B?UmpvM3VJazV5K1RsKzYycUhXcC94THJ0cmRCWUJnK0xDL005cmZKeGRYcmdV?=
 =?utf-8?B?Vko3K0R5R0pMVXg4RmNsYWpQUmY1dHNnZEYrdS8yeS9oZ1NxOXkzMEZPMUpl?=
 =?utf-8?B?RG4zUUtvN1J3emZQcFdyeURBQklYMEE1eGljcGRzRkh0SVkySmZ6a2pOQ2hv?=
 =?utf-8?B?K0pDZEtOZ25SVzRKVFRRNm5nZkRZQ1ZMbkdjNUhRdGhZU3dTR2VzVVRzZGdO?=
 =?utf-8?B?RG5VcllyZDlhSjhXcUlad01TZ09wZkM1RkxNTzVmUmNIN1dNSit4dGVGOTJm?=
 =?utf-8?B?MGNUUnRuOWsrOVVmeTljYThCQUc2RFVjTlB2b0VlY1k2cndMNTBWUENDQUk5?=
 =?utf-8?B?UWdTSHIwZG8rODVCQWc0SjBzcXJaZ3JPbmNtYnJCWVRtYkFxOXVNR3lwQkFi?=
 =?utf-8?B?a3VqZXFSWTQvMXlrdlRkMGVwelIzMklNR0haQUl6aiswWEg3emdPM1pOWXR2?=
 =?utf-8?B?WVZuRWZLV1RZOUdVRWNGYnZNQStZZDNHUjliRzZ5RHFpM1RxZDhpQktISytV?=
 =?utf-8?B?K0x5TDR1R1VpQkJyNDNvZ3o0bThtVUJ0T3FPQnhkRFg0eGE4aXN1TjNzaVJz?=
 =?utf-8?B?V2tpQ28vNVB1bWwydmh3SEF1dE5XdWpVajVDNjAvbkxJbXRQczZPVzFrZlhY?=
 =?utf-8?B?VE5KSjZSbUpiZWUyaXBEYzFkNXoycW1mQ0Fkb0grMVNjcnY4bHhCczBsSStC?=
 =?utf-8?B?ejZMeGV5eVBpUnVFUUZFRVVzWnJjV1Z4c0RRd0FwdXhSWS9sZVQrOXk3emtY?=
 =?utf-8?B?TmVLTUdmOHNvazFxcTFjdWdCdytwVkQzZEpOV1dkdUErV2ZHTVl6aFpjR2VZ?=
 =?utf-8?B?SHFJaUczcjZYSEVkZFg3SUZRMXJhd3ZORGZEWTM2UjZSMUtYN1J3YmhLd2Fk?=
 =?utf-8?B?Mm8xVHl5dzFaRjBqU3hoQ1RMWXd4OWM2N3p2S2dGS1NwSE5jNDJ3OVdicHlh?=
 =?utf-8?B?Rk8wbjFOdFptYWlVMUp1WUJIbExpYi9oMklkVHhienRFRUZKaGdjWjZ3c0dy?=
 =?utf-8?B?WEN6alBuQktSR2FqWU1OWVVxMDhLeTVnNFFaWnRncldRKyt6OHg4dG9SVWh6?=
 =?utf-8?B?bHNFS0RvS0U4S3haTTFacklZYUtuTng2VHJoa1VUVytYSVNScjVKMzFYdVVm?=
 =?utf-8?B?RnovYmdpdTBUc3JCeTdpcE1vZmhWK3RZZ2xkaW9ramRMNEVZQVlJWHczaExV?=
 =?utf-8?B?eHoyTk45RW5kSTgydHFOaU9WTWRZUkc2VXl6R3E5cW9CNmRtR1k2amtoeFNs?=
 =?utf-8?B?U1F5bEZnSFFnT2FKRksxRnAwNW42aVFrclNMZDBMNWdTaWpQWlYrbjgwekg0?=
 =?utf-8?B?eEt4ZXU4Z3Z2RUlscG93VkowMHptQUNFeGtCeHI5VkdsUzNkUUJ4YVkyMkhL?=
 =?utf-8?B?aGIrZEtLNU1oSXVsalRWNDdXNVVRODJaeGgrclprN1FSTmFqUWlvQTJqTy9Y?=
 =?utf-8?Q?8/RZTy38pcU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8531.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MU93ZDMreDQra2RmUStmaTRyQ3RxVDdxSWdNMktBVjhoRnlpTGxPT3pRU01i?=
 =?utf-8?B?ZEkrRXFoczh1cVB4RXVHd3dLWW53ZHBoNmtWOXJONzRQQWt3Qi95SWxSazFC?=
 =?utf-8?B?Sks2OTRSMk1hM1Jma0tnb0gxQ2RSK2hvTjhJTk14eHVRMU5YNVQ1L3RlV1BR?=
 =?utf-8?B?QjNxTTBYelYyTGxtckVpb29wUnV1MTg4TDYvR1JQd1pHZHp3b1VwaXZvUVZE?=
 =?utf-8?B?SE96UE9POWJnRE4yNnBXT2lyZ0ZjdVROa1EvdUFjSXhFK0dIazdXM0FIUmo2?=
 =?utf-8?B?SXhhUm5uVGxSWWRwYkwxTmNydzdPcUNQeEovL3FIMTRsVDBscUhpMEFwSWg2?=
 =?utf-8?B?b1VsYnJhR3ZPazgrUCtLUDkyR3krSTdOV1lYRm1OR1ZjWmtGTGk4OVlzVjBG?=
 =?utf-8?B?dDJwRUJ1cTBlRk1xM1psSG9FR1N6ZmhJcy9KbEtpUDMrak51c3B5WkExbDFk?=
 =?utf-8?B?VVVZaDJ3c29sdUU0cThIRDdtaTY0akNpWnRJaWd1S2ZneWtiZkYvMHlXSGVY?=
 =?utf-8?B?bXM4VytKQ3Njb0V4Q05XT0lkYW9YZFpQMDQzMnQvNnl3VGpCbTdlK3RpS3FV?=
 =?utf-8?B?c3lxaFhHbVBMbUtScy9Tek9WbWtFUEhsQUI4YXFWY0VlMXpTbWFhQnAwRDIw?=
 =?utf-8?B?aGFVQ1dxczdueTFEcmJkU3ZLMlNFYmduSFlLalZNdzFGUFl3d2tFbmt2Q2tN?=
 =?utf-8?B?RERNaS9Kc09kei8rdWVOMkJaQUg4ZE0wZXJWdFpob056ODk2N0t6U29oWEFC?=
 =?utf-8?B?Qld4TnNhSFhFOStKNlF5b1owM0RjWVFPeEdjWVhSVTRCb2NYdFEyZ09yTHI5?=
 =?utf-8?B?TFRscE9VT0dud0ZPNUxwcmw2b1JxV0ExTWVWSWZlMkNMSkJWOWZLZHpDbU1C?=
 =?utf-8?B?UW51b1dxRU5MWndTTTFGQTUvTEpVdHowV2Z6SEZSS0R1Rm0zRmVBSlRPRGdh?=
 =?utf-8?B?Zk9GcHpzK3d1SDRIbjhVT0FNSnRRcGloWUdZSDM2SFZXdGwyR2RpWFExcTJr?=
 =?utf-8?B?VXlicUsrRjV5TUxUeVl6UVQ3b01CSytnSVBnNjAveTlCSU9GZ0lrS2FNenps?=
 =?utf-8?B?dG8rZDFiZU5SQktiZGZJRnluT2wrMURranIyQnJxY2Nnd0I1MUxmci9RWFRl?=
 =?utf-8?B?UzB6NEhQN1dwTEgxcy9WYXRNT29Ub2tQR2VIM3V3WkliVFFFbFh1TDJXL2Yy?=
 =?utf-8?B?MXJHb3ZYc1Vpa2VCVEhTVW1uQTJiQnBkV0ZGMCt4NWwxdStWelBOak1CUXp6?=
 =?utf-8?B?ZVd3NFNxNllGQ2t6ZmpOQXA1NVVoKzlWTHlVS1BRR3JVdzdlVC95NUxvNDJn?=
 =?utf-8?B?aksxV0pEekpXTmV1VWZYaU5MdGdFbWQvRVhRT0pqKytFYmM2cWpDa1pqN2xj?=
 =?utf-8?B?UDlEWmxsSzQxTUcyL1Y0dlBkc0pBRHJJL04rdUhhU3VWWHBpS3Q0dk9LdXlB?=
 =?utf-8?B?K2dibVpYNlRJanRCd2R4Q2tmdFFZNGNjQXdmVHFXWlV3c0V1U243RFhVYVFl?=
 =?utf-8?B?OGVmZjNyOUxOL1RTbkx4VGR4T3VWejZnSkpwRk1vQ2g5bDBYdFNZRGViaUdt?=
 =?utf-8?B?Zk0yVTQwQnJQU1FmamdMWk5kTGljUElMeEEwZWNjWmtMOWtaODBQZW5aNXM3?=
 =?utf-8?B?NVdtUE5jcnNrS294U3Bua0lFOENNcmdkaHFPOXlUbjBzZ2hZWUpRajA3OUMx?=
 =?utf-8?B?YmNUV1RBKzZ5aGlEaDN5YWo0ZUFQeHNTQStRMWFGaWJ5NkNyZUliZVVtQlBT?=
 =?utf-8?B?dm9ocVhLcFlqSnpPdEJDaTJra3JaU3FBdExveWs4OXd2d1REYUd1d2JLVzNn?=
 =?utf-8?B?d3Z4eUpJd0NkRkxpK0wzQldxR0NwTWdFUmEvMlg2Mlp0Q0JXUEplUFB0aXdC?=
 =?utf-8?B?VGFpYVZoeU1jSWlweTRhbkVuU3JpN1NYS2xwanFWcnJIMW9QNHhuWEw5YjJo?=
 =?utf-8?B?VThDenFRejJTTGliRSs0TmpvZ0N5ZkVCdzF1WE4wLzgxTm81TDY4YkdWVmlh?=
 =?utf-8?B?MVFBTXl0bXUzVmx4RzVtQnZFVmFjYlIwWWJ0TENWNDQ3UmhCZGFtWXNPQnZ6?=
 =?utf-8?B?WjR6SVF2eTMwcUhaQjg4L3pzQ1JHM29ObE81dnhhNFNieGtqV3ZvVUZIeEY4?=
 =?utf-8?B?Vk5hS0NqK2pDZTQxUkVmQzNRYW1ubGNZNmVKMmZGcGtkNXluWG9PTklBYXVG?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d74efc83-80fd-4d13-01e4-08ddd8b61b56
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8531.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 09:04:41.2954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QG3i8j/qoshHCKvo7Uw5kGMKu6XI07vJcpqqEv1k7pRgIgSI+aCXeJoXDVV+sq89mv1WtMo/u3liVT4HNjVNRRF4jLJyIIWvSi6FSbJsjwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4901
X-Proofpoint-ORIG-GUID: JVf919rpTTAQV-4k0uQwGlIXA96O0Lsq
X-Authority-Analysis: v=2.4 cv=L90dQ/T8 c=1 sm=1 tr=0 ts=6899b22c cx=c_pps
 a=beKarbE+Mk3HYUGHxDyRTQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=t7CeM3EgAAAA:8
 a=Okdc3lanX8eKey-wk1QA:9 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2MCBTYWx0ZWRfX2ClWAsI0HMnJ
 yuiUgxZtnt0t+T7XPVTmMciAJUTg4oPtmceTUk61q/ZNSRUfLwJoEvHED8LHo/y2lmrdDnDtr8+
 gyLxJy91NrC5FtkHdp4Xj0rpaLx755doIBBJhXOwdsu46NtOsnPFIskknuSG1miC5gQ/q0okHjc
 +M3qMA/d6/oa91rhIks87tafh74Hf91X+9jgoiWQTH4V51cQ502cmrUeSazwrDH6gOKkMKYknYQ
 wXng53dmrjE5nRugsMXU8yTNjarmNUv9JvZnOkh2AW67sVAyiCbavMSJnE/ZF59iRPcrD8WaHNg
 ppDFYwpN0fFUtY7SAWazJSjjEofdmQN/1RLED/FJ1W+C0iD6MbenJjillgqD98=
X-Proofpoint-GUID: 2oud4T5cwJNLA_6iX825Xx1EuxImBFJc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2507300000 definitions=firstrun
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 11 Aug 2025 09:04:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17860



On 8/11/25 16:37, Alexander Kanavin wrote:
> On Mon, 11 Aug 2025 at 10:33, Robert Yang <liezhi.yang@windriver.com> wrote:
>>> But why is it specific to file protocol then? If the item doesn't
>>> exist on some remote server, there would be the same issue?
>>
>> Yes, they same issues to other protocols, but there isn't an easy way to check
>> that for other protocols, so we have to let the code go on for other protocols.
> 
> So the goal of the patch is remove clutter from log.do_fetch, and
> nothing else? This should be spelled out in the commit message, with
> examples of logs before the change and after.

It also fixed a warning when BB_GIT_SHALLOW and is enabled and failed to fetch the
source from the PREMIRROR:

Fast shallow clone failed, try to skip fast mode now.

This is because:
     def clone_shallow_local(self, ud, dest, d):
         """
         Shallow fetch from ud.clonedir (${DL_DIR}/git2/<gitrepo> by default):
         - For BB_GIT_SHALLOW_DEPTH: git fetch --depth <depth> rev
         - For BB_GIT_SHALLOW_REVS: git fetch --shallow-exclude=<revs> rev
         """

         progresshandler = GitProgressHandler(d)
         repourl = self._get_repo_url(ud)
         bb.utils.mkdirhier(dest)
         init_cmd = "%s init -q" % ud.basecmd
         if ud.bareclone:
             init_cmd += " --bare"
         runfetchcmd(init_cmd, d, workdir=dest)
         # Use repourl when creating a fast initial shallow clone
         # Prefer already existing full bare clones if available
         if not ud.shallow_skip_fast and not os.path.exists(ud.clonedir):
             remote = shlex.quote(repourl)

The repourl is an invalid local url from PREMIRRORS which caused the warnings.

> 
> I also wonder if this should be inside try_mirror_url (or further
> down), and not at the top level function. Otherwise other users of the
> function will have the same issue.

Yes, that makes sense, I will send a V2 for it.

// Robert

> 
> Alex


