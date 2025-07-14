Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747E2C83F25
	for <webhook@archiver.kernel.org>; Mon, 14 Jul 2025 09:49:09 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.9])
 by mx.groups.io with SMTP id smtpd.web11.74466.1752486544330613813
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 14 Jul 2025 02:49:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=Zy2XZ68i;
 spf=pass (domain: cherry.de, ip: 52.101.65.9, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4iaxfWfPknbsaNNZ8IdhdRxgBngJ8080SZX2VhTLPsC3CTOTFZm5hY+9x6eNAcKaFCKJ1K7qviIhlTbq6uDiPU9gYzi+pHX32V6ZbQCn8jYC+zaoK8Yw3VPo9JgCTPCAwFzkhxQ8bS7yY1Cbp/JFUaY5sS+1gvNQoQbhMklbd4XwSeYeGkvfefZHRRz7gNAt8bIi6kvZljUgu+pZp94UHtfyw2hhancq+6UbXlrbc1QTOBKBrSgTbtbWsCcug37ZWAZm/fHKBeyMr5kBigUbzRHo2pH11yJh0GKSRPO0rHN4O1rLlYQO6AR/uYZuLLQlz2Q+GRk0KeWLa8tjEveGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvGp8vl6YK/PILGUwLxLUYBW1hF9XP7DF5xfy2zfGHM=;
 b=eWW7YuCtBwMTwT/d5bFM3yXiLmSnsobGHPOaRvXYbGCX9tMqPb8J6yITQyGmj6/WLCiUlHAifsUCLuqLAkznH004BfnN3WxnM1MSAbSJLcP3m7wgb0nGoPjZTGkAYy0VnCzHbK/IkAp+nxYqYn+D6Ejgg/3JEnl/+ttrIEM50od2CYsD7LJWSUwVmek+nBt03Rw2OGxLjNWaqmMOT4z480HvgBID5l6wTHWG6Gyd3rWyowGaz7ValBcSnbtYkedzXYsm7AZhUV+9Ko3adtTUaKfqt5S8juEEe9IyW7/x57nW/+hM4a0/IRl6JXRztIJxAVF4g4Qg6Q0OCer6lRTQFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvGp8vl6YK/PILGUwLxLUYBW1hF9XP7DF5xfy2zfGHM=;
 b=Zy2XZ68iLZXpIn1wzeIZWhzTm1l+dXQtR8QfdXKrAxjdAqpW4eCvxgBi7R1dTcbzRxSKz7/kav11ePBtx6+OAohNr/Hzf2N3LMvmxDMhu4NtLlXNESRqUVEOd+19ew/ndimE9inmxDpSgsHs717ouP9+hLW0n3iZTcavRBdg0oI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by OSKPR04MB11438.eurprd04.prod.outlook.com (2603:10a6:e10:9d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Mon, 14 Jul
 2025 09:48:59 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 09:48:59 +0000
Message-ID: <66607ae7-55f6-4125-a91b-b8988e8e74fd@cherry.de>
Date: Mon, 14 Jul 2025 11:48:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: bitbake-user-manual-ref-variables: fixups
To: Antonin Godard <antonin.godard@bootlin.com>,
 bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20250630-bb-pressure-doc-fixups-v1-1-d5463a3cff2f@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250630-bb-pressure-doc-fixups-v1-1-d5463a3cff2f@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VI1PR07CA0264.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::31) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|OSKPR04MB11438:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eff0509-be3d-4133-baac-08ddc2bba82f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZmV1eWw1RmMra0Jtc21tR3lIV0gzeDlpNFpwYmwvZ3lXNlkvNE83SjJiNXg4?=
 =?utf-8?B?azJ3ZU5WVlhKNjMvT0lQTTRHazM4RElBOG1YU2d4S05CczlMZE9Yc3JVZTZw?=
 =?utf-8?B?NElXUE9yWG1GQlhXWFd0aTV1U2hhMlNQTVBab0lab1g0WW1RMlBHWUlNMG8v?=
 =?utf-8?B?SndtWGdsUHlob1BQSnE2ZmM3ZmV5b3VUQzc0QkJRTVNHcTNVc1p0M05obTZh?=
 =?utf-8?B?UDR3SVRBSWo5dU5qK2lGc3BRcUdsaElmajc5alQ3V1dYSXBGMW5reEhaTEkr?=
 =?utf-8?B?UXNjclVKc2QyQ0UxVlAzR2tsRWtGbmJ3MDdVYS9QbFoyRnVPMEVRMkRqdGw5?=
 =?utf-8?B?dUdLbnpJejdRUXpucUhFSEdndHVJM0hEeFFrbGNnRjd6alhGd0p3SXVJajZL?=
 =?utf-8?B?alBXU0ZZY0RjcVdWT3gybnNIS0drd0xTL1NscDZnYlo2T0Y2QWhlUDdCaDlo?=
 =?utf-8?B?dG1lRlN5TkpkbFozOTFDQVBWSTBidFRqZVpBd0RTV2NPMm8xYms2Z3BnSlJs?=
 =?utf-8?B?UFFXODJmK1JMc0MyRnZRTXNtaGQ5OENIN2E1REJwUVBFREpReFNPTUtTWUxI?=
 =?utf-8?B?Q1FuOG11Z0I1dXJKZTBQMktRMnphMHh2dG56TzhSWm5LYTBHSlBWS0VzZk1x?=
 =?utf-8?B?bWFGcjJXUGJFWFovUUcrME1yTzRyeGhETUp6Y1QvbGNYOHQ5SXhDZHdiUXAz?=
 =?utf-8?B?SHh0TXVaSnVDZEdQR0srL1BBeXNCdHhQY2NLeXNIbCsxOWlwMWtlV3M4MGUv?=
 =?utf-8?B?d0puMjI3aW5UcGtnaUJYS3lVQVV4MllrczZtTHdxQ0FScDNRaFlLdkg4OU0x?=
 =?utf-8?B?Y3oyUFVycHh4TUpCLzZhbm9EU0pZWDZsaWJURndTZ1JHNEs3L3Zjc1NId2Zk?=
 =?utf-8?B?TEFQZ3l5b1dTd1lZUTJYU1lRRFNYMGw1bUZ1SjVHSlcxUWpoaTdhWHhCVERI?=
 =?utf-8?B?ZERVMlFNWHNWVlJuNnZGQmprcDJiMDdpMjNPM0pEUmh0T0VCeFFXbG1lY010?=
 =?utf-8?B?ak9tQUhYMmUzaDdsSURMRThyRUdmRGp0Szh5S3dUV1pad0pTOHZVNzE4d2Vz?=
 =?utf-8?B?WkJET3ZQRjhWbVdEVE9ObnJSNWRBbHZQMDE5ekpIUnhzeitMM1ErRXdQYm12?=
 =?utf-8?B?Skw5NWNIZVBlSCswRWdqVUNQQ2paWHRNOUI0ci9sSmZtOW9teGJFUUFCSVEr?=
 =?utf-8?B?V3NEWGxLNzJoSkROeXVhZWlHYmwrZW1zc3lwUmZ4dlZ3eFJRTytoczhnRXdX?=
 =?utf-8?B?VUNHcFp0SEY4K3MwMFBIN1N5NkZTaUNKcHo3WURTTncwNHBFc1hHb2JSRFdY?=
 =?utf-8?B?ZXU1T3FnSUtFM2pHQ0dselZFeGh5SVBmLzZqK0xLQ3lEUEYwNXBKbkROd0kv?=
 =?utf-8?B?b010Q05lRXZtZk9pRTFjRTA5aG9rQVN0QU4rejRZWmx5QStoOVhPUWNBQXZD?=
 =?utf-8?B?VlRkeHo3cFF3R2t2ZitoR3NEUU4zU3drMHVUUEZLQ0ZLaE5FTVM0eFBNa0xo?=
 =?utf-8?B?QjBCUWFDbzVuUDh2SDUvYm1HMmRZRVBxWVZQdnJ6NGVQUmU5RWtFd3ltZFBr?=
 =?utf-8?B?Vm0rTXlHVzdrVmg0eitBZU1IclNXMkcwbHNjZTFwR2tyd29RNzJ3N2JwZVE2?=
 =?utf-8?B?ZXFVaWs3TWtEeHpEY25PYWRKU3Q1cVRhWEVUeVRQVXhvUXRuQ1QyZzJaN1dN?=
 =?utf-8?B?RUlqSmQ3Ym9tYlJoVHgxVm9zb29oUHdJc3U2emlqaUFLMTdESyszU1d6RW9s?=
 =?utf-8?B?Y3o0OXExR2JKZ0wwY3JmeW1qTm15ZDVoRjg1RWg2ODE2Z2wrMzU3K2wrL3g3?=
 =?utf-8?B?Vko5Njh5R1AvOG53NVFJeTFzcXk1V2JkNVFCZlVGZlBCWnM3Mi9Hc2JjOE5R?=
 =?utf-8?B?NzJvZ1p6ZE4zYVBPblJsT3UxNmNzRnl6RmlHK2lWRVo5V2YzZnQxNm5VYitw?=
 =?utf-8?Q?HykF3D040rg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UmtaRnVQZW1pVGpUNnBGTXEvZ1k5R0ttMllMSWhQSmRMd0ZUbXFxTW94STdn?=
 =?utf-8?B?RjYyT3luZXlSU2ZCNUZJa0NFYVdUYzVuOElKeGJ3d0JTQzZEMmYxd3FZL2dC?=
 =?utf-8?B?UUkxR09tc1hRV1lqdkRIK0FQL00wWEtvQTRPS1gwdUxLWnovWG5uWDgzcDBr?=
 =?utf-8?B?eWZwYWNQMFhmWUd0MlVaVkJjcjFZeTJqUFdNcmJya09PRVhpT3RicENCaHg4?=
 =?utf-8?B?Z2w2QmdFdE9SRHkxUVNYd3NtS1J2aERHTTdEYlA1aHpGbkM0WndRUTNiUnZD?=
 =?utf-8?B?Z3JMOGJoRUg3U2FzRjdVT1N1RFJJNjZJYVlQakcxNlhmZ3pqaUFlUkVWbnhL?=
 =?utf-8?B?Rk1UajI3YnVjNE50Y25tR0RMVVRJRmZQWC9pNStQNXFKTHhUZU5Pb0hlOFVu?=
 =?utf-8?B?MW1ETnFKRDc2NktlcGpSYzVsTmN0SDNsUHVkVi9ZL2xNTFVaT0FBWUNBbVQ5?=
 =?utf-8?B?VHM3WjE0SzBxaEEva0dlTkVaSDYxT2JwZ21VWWZxOERoUEtlZU8xNkYzeG0y?=
 =?utf-8?B?QVpTcGpZNVRWN1N6bHFSYUM5a001VExGVTh3cnkxTnphRzZTSUZFZHFZS05Y?=
 =?utf-8?B?VkQzazdPbUlBVk0xeXpaVWhWZ0NXSW00c3pvME9KYmgxeFhnTC9tMVJGL2pL?=
 =?utf-8?B?Ky90bXFvd2RBS2FrV24vbm14VUJFc1RFSUpxSWxaUy9pdWJyUjRnWGZFWC9N?=
 =?utf-8?B?aG4yc3JabkxUMkxxVnk1OEF2aW13OCt2cUN5cmJCZjVjYU91TkU3WjZEeGVp?=
 =?utf-8?B?R0w0amtNejZmY0w2c2dFb1pYNFRPd2xXbHNCb0tWaXZiRUZiNWtLSkh4b0Fi?=
 =?utf-8?B?cnZ5MkZQYnZ0d2dpc2Y4R3YrM0YwQmc5L1QwY3o0ZzhydkZ6OCtCdDQwK2JB?=
 =?utf-8?B?M3JFSjI0cmprK0laZTJVN2I2aWFNTWNDV2RaUEN2cGhFd1hWOTI0Z2JJTC9C?=
 =?utf-8?B?YmJHMTBSNHQxZXFMTkVDK001UEdVdnFzNzEzRERCYnNDK3RzaXJoa2NJL0R0?=
 =?utf-8?B?WUdIV1diNDJKY2hZV1FCSjZpVWtWTXQ2SUpocWQ0UmxvS2JMOFZ1MHdBdity?=
 =?utf-8?B?dEZzL2M5K01rK0xRYWJUR1Y0SGk0YmhwanA4cVdOTEcxL3g0RDZoczMyYVlL?=
 =?utf-8?B?RGFBNWpMV3JGZFpabkJWVkNuTFVoVktwWjJmSnU3VGx4NmF6QUg0WllwR25O?=
 =?utf-8?B?TENkYlFkZ2poWHJQRGJKaUtsOUl5OGorNWJQRFNCUDZMYlovQzRxNFdxUlB3?=
 =?utf-8?B?NVk1emVuVmg4VG9wMTZRMzlXZythazZ0cG5lSEpHdXl2dzl3UXBLTGJVZDFH?=
 =?utf-8?B?MFMxa2pGWXhIczRNRWw1dzc5Y2syQ0g3dFBHaXJBSy9JRU5sTXBWVVl4c1lq?=
 =?utf-8?B?WHJteFU3cnVDaUlNa2Fma25xcmtrT0xzZGl3WmU5S1FmZTZjc0g5Y0tpS3Y3?=
 =?utf-8?B?a3FJWi9GZVZQK3pYZGVkMEEva2RZd2VEeU0zbGh6Y2JXbHhvaFRyV3NaTGJk?=
 =?utf-8?B?dGM2aWZMUkZpbTJ0dXJMaGVyaE1aVWxoUUJ2UVFyN3dmQzRsZ0UrRXo4TnBx?=
 =?utf-8?B?eENFSncvMVl6V1A3YVVQNkgwWm5kbVV6bk92TVpVdlRIK3NXNjBZZ2liYlEx?=
 =?utf-8?B?dWhuYzJobW9Oc0VpdmdIMEZMT3VORkJlRlJFYmRybEg2ZlA0dkZsVFRNV2JS?=
 =?utf-8?B?VXVKQjFIQnZpMVppcXdBUmxSUmxVOHk1Q2dhUmxzN3hhLzNONFdKZmx6L3d4?=
 =?utf-8?B?ZkRkOThEOHdDM0xUMHM3RDZPM0dvRURIc1FXRG1ZUjBhZkZJenVzWmZJclpy?=
 =?utf-8?B?YWRBSE9hNE5PME5BNXZYbzdPcTliZkgxV0JnVSsvSUhhcW82OFRIdlJVaDVW?=
 =?utf-8?B?dFFBU0dBOUJPMjB1NDNRb01qWkFYQ0pscm1uSG41Rnh3SjNZR1A1Zy9LM0hS?=
 =?utf-8?B?L01CQ2Vxc000dm9PUXA1S01yTHYzaEpFUkU0YWV1UU5yWS83M1VTRENlcUFQ?=
 =?utf-8?B?S3N6TGlpYk1FOXNyald5enk1VzZkWkJkYWpqWUM4SGw2alM2bjdUWHRLU0py?=
 =?utf-8?B?TUg4Ym4wZ2FnVlRUbzlXMytka2dVQ3UzN0JzaU5XVmtOdk5saVk1M1FTR0Zy?=
 =?utf-8?B?dVNwQnlYK3VGNmZNa1U5aEdNdTZuNnZNbjBRVkhlbndDRHYyNERwS1NMS282?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eff0509-be3d-4133-baac-08ddc2bba82f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 09:48:59.4299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GpsWnU+Yqmq8Av87W0E7k05LvfH3KJ3PveXFgcbAKP52pwPqi0wUckz6f0C2IlDm1AOV6gXFHTAOzxDDqFgzY/770CdhFbCdPA9HGUFQ92U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11438
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 14 Jul 2025 09:49:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17771

Hi Antonin,

On 6/30/25 2:44 PM, Antonin Godard wrote:
> Fix typos reported by Quentin here:
> https://lore.kernel.org/r/cee995db-4c3d-4bf0-813d-ce3f5f8f92e3@cherry.de
> https://lore.kernel.org/r/73497b5e-721e-4e5f-beb4-c56ab9178c9f@cherry.de
> 
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

