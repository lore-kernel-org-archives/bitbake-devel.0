Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E884C02183
	for <webhook@archiver.kernel.org>; Fri, 17 Jan 2025 07:45:47 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.102])
 by mx.groups.io with SMTP id smtpd.web10.6255.1737099945890127614
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Jan 2025 23:45:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@weidmueller.com header.s=selector2 header.b=Dsh0f98+;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.102, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmOGaar3LaMRVhPl3Y+n55ZM0CRurZ6ETZ/br/dNo8ZX/oBORfihxcwYs3Qv/jFZOSV4lH0bpKH6ishLYQF7T2nOHqFxFPzGRkvOwBxV0q7NS9NQzQRNLBQS/sjrK4p7veMb10ASJffsoxuT/fjofcMyu51Sa0XoShTzF7mXiyF++G3TXjWnixwfaf+xggA7PlcCaM/aG1QTsbREvVdIKb955b9pP+Uzpcbe2oul8JQunUnTU1mwkbhHE/X0WzNgHeCjfCK0XIyxILRZmo2YWKnWNvjjCcE7opVb+irCcsmA7DJfJICv5PhJ0pAsR0WwjOy0Be+fnCXU/7uqRLnBxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilaYzjwzi+lSjo1ODQblHu0OUQ232mhY1fbw4W0Fwqc=;
 b=OE6Sh5NHMlZLTu7Q7Z0Lky+vaoesqIwDU6QlWicn+QAcce6HbQy2C+KWZ1hyYS+Mt7+CpUOeQi0WVfUzrol60p1JzFVF6TuaJuazeT927TRozqCePW72CWznn+GHGG+L8a/0nlhlW0QFDH1ARwBIl8d4p4MvqA1cuA20GXxRW1DZFS1RVpduE06AYng7tCWnnxMn9GMigYA0D21P9Hw9HRqXd1/Vp9+2DGwtN/XjpbAuRewe+6hi7Bdhed9UipwHOzKCL0OBezHQ6kaQ7fPybZQ0/AT4FDgnOgltR+/jvXIPC5tF/HY/Idol4pya8vwEaAe/1BMTjbnwScqSu4bEsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilaYzjwzi+lSjo1ODQblHu0OUQ232mhY1fbw4W0Fwqc=;
 b=Dsh0f98+XHfSC+PZ4mP0KKcrkARiwHGwP/uJIIsf9V85/KkufBJH9VEJCouP5b4cJlToEeIkdUSkQXbV7pbaULzoEV/i5PBH2tlu1rJrVJZt2Ee55d/wjv9CzJNu4Kfb3jH41zba//UpjVbh2RYx5S+e6Jq/dJrQqcjUMpn/RTvSU5GAkZZOYJEwPfrnUiaBM1rWbCIBDC/FB8eh/6WowXWXnd3sc0tEEcUlIvUY2dEsdOhCWxUkpKuYNIU/KVNycbEF4wB6ohUzb9d32evQEYMIhSkEDTJeAPF6ZYLpIZNGpzc6gZdkAeltNuePjajnE4SynaMAfmL+/5FtLpXckw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by PR3PR08MB5721.eurprd08.prod.outlook.com (2603:10a6:102:84::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Fri, 17 Jan
 2025 07:45:42 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 07:45:42 +0000
Content-Type: multipart/alternative;
 boundary="------------50nrcNXhSOev51199TiK1Sau"
Message-ID: <fbe116ef-f544-4d21-8b36-796fd6429811@weidmueller.com>
Date: Fri, 17 Jan 2025 08:45:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 00/21] Concept for tightly coupled
 package manager (Node.js, Go, Rust)
To: bitbake-devel@lists.openembedded.org
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
 <1d86a392-db47-4fac-81fe-5262477bcd70@weidmueller.com>
 <CADkTA4PeRvBoR-F3pM-XOjWKEjsgLX+entDPv1uL+uTiFxjc=w@mail.gmail.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <CADkTA4PeRvBoR-F3pM-XOjWKEjsgLX+entDPv1uL+uTiFxjc=w@mail.gmail.com>
X-ClientProxiedBy: FR4P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::16) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|PR3PR08MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: dd969428-57d4-42a7-a258-08dd36caf193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UU8yNThaTGVLWEcrSGdkdlZPTEx4eTl4VnNNRXFxUkgyOWM4UXdkTDBXTjY1?=
 =?utf-8?B?K245VFdBWkVXMEtXa3g5aHdoMVdXUGVER3VUbEkyMWVpQVdYT2w2U1crenpD?=
 =?utf-8?B?dVRuUk9LK0VYOHcxMkorSWMvYndGdWhrMWpSbTZQN01vS0wvM3F0WmFiNVI4?=
 =?utf-8?B?OGZVUldXOFpiMVkxVU5WekFna09mUllESnN3SGhMVk1yZGJFR3dBVDVQWlNZ?=
 =?utf-8?B?dG1CQUxFT05pMXB4bDdVVnN5cTJ6V0F4M0FuM2l3NFZUdnF4cDUydnF1NnpV?=
 =?utf-8?B?VFhYS3VJN011V3l4M0Y1MTFaZExsY3hoMEJ5VFRFN3RjazZlUXB1eklaU09E?=
 =?utf-8?B?S1RBQjRVM2hUei9KOTRtbGVsTjhsTnRnNWNTV1ZxWHR5VGJYWGpDbnVRSFN5?=
 =?utf-8?B?ZElmN0t5NG5ZeE85Si95SndZWlN6VG1DNERyWHBnRVYzZGlIVzRtQ3g1YVJ3?=
 =?utf-8?B?N3MveHJoeG5hTjNuYkVmb1hBM1VQVCtKNXpianJTR3FaSDVtYjBQRjEwNXFt?=
 =?utf-8?B?SDVTQ1N3VnFXQjQrajR1eS8vVXJxa2FLOVdpSFN2YUVpUGRmWkFGRURYbXll?=
 =?utf-8?B?bWp5aWI3anFZTGloNlRITkFwVm9SLzhkQktWNjBiek8zTGNneFU3ejhwMWNj?=
 =?utf-8?B?d045RitqNnU4ZTkzVkFVWE9SNThBbjhhOWM2UVpGRVVyL3A4ajF6TkV4cEkw?=
 =?utf-8?B?bExBb2d3Rnk0cVZwUzhsSlM5MkN5WnB2RHBZakd2VUxXbkJCUVVaaUs3RTRC?=
 =?utf-8?B?VjZUdGM3M3pVZTh2N1ZMd1cwKzJ1b2k3NTl6cWh2cE1SQVUrb1hqcytWTUhR?=
 =?utf-8?B?Sm5PNks5c1BnVEh3cFc1Ky9VMWQ3dlE1Y0JHUUF1R1BGR1JGd0tKK0Q3YkJ5?=
 =?utf-8?B?a3ZrdzFJUDBJanNRakhsaEJURGltN2pKUFZiTzg1bFFaclRSdFAzZS9DNUhh?=
 =?utf-8?B?L0IxVVVEQTBVbGp0aGpnbFlMb040eEFoeWVLenUxZ1BWVHFyald1QzRYRExN?=
 =?utf-8?B?SHZpWHViS0kzQklIdVI4Sk16YU1hR1k0NVFQd08vRlZoY2dBcTYzeFJycmNu?=
 =?utf-8?B?a3VOcGUwMlk3Ymhma0dubitsTHhIVjNFYnowQk03ckFENENBRXZsSHBkdUtl?=
 =?utf-8?B?MlI4RjBzelVrWkJNRWdvd1hNazhNQlpWN3RCL1pXeWtsQ1J3ZUJrTm1nU0Qx?=
 =?utf-8?B?Y3NYWDVEcUJyV1pnMkJqMjVDWGVYK0lndXpyS0JXcit1bHl6SGRueDFMbVEv?=
 =?utf-8?B?Tm12Tlp4NkZLTWJFOGd4R1h0V3lkWnVLc0VOTkdQRFMrV3FXR0UzQkN1b0l5?=
 =?utf-8?B?VjhIcUppWkI3djRsL2tyaGcwWXZ1SHdDN3ptRWlVVEgrZUdGMlRjdkIvSkhn?=
 =?utf-8?B?L3dWa2JGYnpiV29ibjJQdllNTithSFNPa2tMRTBBZTlTb1g1V1pRbkw2dVk1?=
 =?utf-8?B?bG1RVkdPWnI2eTJZckhZelFKLytkRjhYeklGV2cyQUFOZVJKNlpIQWtoNkc2?=
 =?utf-8?B?QzZtOGpQc25ZcmNUM2Z1SnJIdzZmQkFHVUtYQjk3ZnhPUWJJcGRjVUZ5MEV2?=
 =?utf-8?B?VGFJQm1DczRPQ0ZIbnp4Q0tZZWtNc2NBSDJIUW9TNC9hekl2UHlPRlVvSmtl?=
 =?utf-8?B?anVOL1hqaWx4WkJpUXBJNDdNaVdQU0RJa2tTMHI0eE9Galoxb0s5M0tqOTdv?=
 =?utf-8?B?RUlEQVA1WXQwVU8xZUFYTmF0Rzh4ZXEvL2RvZkFJQ1p1YlZ2amFZNW8zRldm?=
 =?utf-8?Q?Jop0kVSnu9uUsawkNYGrndFICD5XzmWP8NEyOUd?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(8096899003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TDZaWnlqb1RhMFRtN2tQU0VydVJPanRHY01lYmNqVXZ6Vm1RMElvUmYzL2pZ?=
 =?utf-8?B?VktoNGh3MHgybnErckU2TGd6bFljOUdwYWhNdzU5MDZmRkthbW9qeXo2dGlZ?=
 =?utf-8?B?WitPTFZ5YmFwNzJzOGZYc0xubnI1ZEdBQW05TmMwTjNscmxhc3JEenF0ekM2?=
 =?utf-8?B?K3pNRHoydFJXejl5aGpkWnFMdk5aQVpkZGoxZEJ3Q2VxRGd5cnBXM3BGeCtB?=
 =?utf-8?B?M1pnR2V4bkFiMVlRS1FIQmlUWDhkN2c5ajFyUmdoa0NRZ3hMNjlZZlIvbjdx?=
 =?utf-8?B?ZzIzVVRVQVd0MEliTFlBaWJsUmNtaWQyY3hDU1RObUxmVDVJaWN0czhtM2Rv?=
 =?utf-8?B?bDNWYmUxaEszUmVjRHlHYnlhWDNuYkhQZHlMKzhMZUNHVkJlMEdFZzFwZW5r?=
 =?utf-8?B?bitaUHNEUDE4SUt5TlE2a2lWdWtGSEZLWXVrbFhhVnc3eDJWRUlFNWZOekF4?=
 =?utf-8?B?QkVhZC9tM1NNNUFmU25vRHZlT3JFa3l1Sks3Rmdod1NPTTlCakJmVXpCMWxj?=
 =?utf-8?B?MitNbjVJOGFXSlk1NlBGUlBTcTFGdlN4cko5d2V2K05tdERjT3g3bXdwUWgx?=
 =?utf-8?B?eUxpTzZhSkgwQS9CSmhpcWdKQ1JDL2Z6WkV4NzRXNmp5V2kzc2padUxEdm5z?=
 =?utf-8?B?ejF3QzR2M0ZkSER4d3MxYW5Uam96K2h3dFh3enQ0ME51RS82MkhnZ1N3aytR?=
 =?utf-8?B?OGZEdThyVEUvWVJuakcwbXFJOUpBdnl3N3RibWNMaW5BU3BRWGltS2I4b3Fs?=
 =?utf-8?B?Zmx0d205SE92WmhaeHFFQlJLTE5qeFhuM2NTb0VCVGU1d1AwL28vWHUxdWZM?=
 =?utf-8?B?UWo3MEwyM3FEcEhBNndpMm9mZG9TdHgzU0NUMnZwMmZDNnJZbnMvajJzRFNI?=
 =?utf-8?B?UFdhZXFXV3F2dHpGd0NBSlpobjVvcmNiNVBvekt2Uy9IVTdNbnRLeVNXdnFk?=
 =?utf-8?B?cFBnOU9qbTNNZGxGcmNtZ0Nlb0RFZW1WbnUzZjJ2b1RObkF4MlFyOHorQXNW?=
 =?utf-8?B?SExqS0Z3ZVliZEhhTUNsK0Q2NVpZMkRKMmlqYWxkNGlOUFYxT2FMZTlJZC9I?=
 =?utf-8?B?NklzcllnS1E1M2E3aWtZNnF3VUJBWmI5UDZsWTRobUJFSEFOOFoxNEpGU3V1?=
 =?utf-8?B?bUh4NDBibXNNL1JhbVZ1SlJ6SVZHT3BwVmpSN1Nnd2FMRzQzRWtJeUZhMmR6?=
 =?utf-8?B?NGl1WFczUjFiSlprR2dCdTBBcURSSU81TzdSRnI1aCttZ29YWEdXd3hicW15?=
 =?utf-8?B?UFJ2Tk1FcVBJZlQwRGhtdG1kY01RaCs5ZFpNWDNiWkx4R1BucFdmNkR6NHNm?=
 =?utf-8?B?MHQyN3hxd2V6bmkvV2F6MWs4OWQwRXFZa0JKUFAyVWpEVGYwUGxJN2J4Zm1l?=
 =?utf-8?B?Szgwckt2dUlnekFoVFRxeGxOQm9tRVpSRzBReWdoakRUb1IzakZzT3lkZUg0?=
 =?utf-8?B?VkthRlk1Z2ljaXpDWXVvWXNJNzY0cXYzd1VQMGRiazFGVEs4cVVqbkEvWnlU?=
 =?utf-8?B?clRuU2FhNnZaV1E1RWtBRjQxSkZ2elAxcnBHRkZaUTdjTWlpbVJNYlVOdzd3?=
 =?utf-8?B?RHBrQTJjZlgxaGV5VGhCd25ENitpZ1ludVBmeHFkdTQySHJKV0tYdis1UnNE?=
 =?utf-8?B?NFVvRncrS3BQaURyblRhSDFxbDVqWFE1ckF1QUNDbnBzc3U0a2RTT3VjdVgz?=
 =?utf-8?B?UWtTMUkvTTVYaXd5bDZSVS8zdzJNVXhYUXhYbmZKV1c1SEk5UDhqajBkZlY2?=
 =?utf-8?B?ZU1WYTJsb1Z1QVdJeFdCTlFEcmZLV0QxaktPWlZVTldMS0kyMjdpanVvS2lm?=
 =?utf-8?B?VWpBYVdWVENPT0tudU5FSGNzdnlqRHR3MGdxTzdhMDZxOVdOaEEzQmRvaXZZ?=
 =?utf-8?B?SWJLZ2pLL09ibDh5UUZYOXd1QXhOSVJrQ3lVKytzUGNFYk1ScTRrc0JLVTVE?=
 =?utf-8?B?amtySkh0T3ZnZ0w2d0NWT3FBemlyWEcxbStydTFiYkhSSGJwWG5xT2lCQklB?=
 =?utf-8?B?b0VEMDZ5VlI3TGZ2YlVtMlJEWS9wN1FZRE54MkpuM25QN3pyVlAvQ21xamcx?=
 =?utf-8?B?T2VmaTR3ZFEvRlJPaUNhODVYOHdiWXM4UDdCd2djbFdZaFZmWjh5Ri9QY01v?=
 =?utf-8?B?NXE5eXhqSVNDYmpsNUxKZ0owU3VtRkdUdENJN01zTWRxaXovb3UyaGtQUXQ0?=
 =?utf-8?B?dUE9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd969428-57d4-42a7-a258-08dd36caf193
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 07:45:42.2434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMxmjYuracgnaqCnA+BvVEH1qmzYgB30CnzWc7WyqTnONHgzV0lcGE99EWVC8wszs7HIU0UY8OKe1Beos5jAYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5721
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Jan 2025 07:45:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17022

--------------50nrcNXhSOev51199TiK1Sau
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.01.2025 um 05:19 schrieb Bruce Ashfield via lists.openembedded.org:
> On Mon, Jan 13, 2025 at 2:11 AM Stefan Herbrechtsmeier 
> <stefan.herbrechtsmeier-oss@weidmueller.com> wrote:
>
>     Am 10.01.2025 um 21:24 schrieb Bruce Ashfield:
>>     On Fri, Jan 10, 2025 at 10:04 AM Stefan Herbrechtsmeier via
>>     lists.openembedded.org <http://lists.openembedded.org>
>>     <stefan.herbrechtsmeier-oss=weidmueller.com@lists.openembedded.org>
>>     wrote:
>>
>>         Am 10.01.2025 um 14:26 schrieb Alexander Kanavin:
>>>         On Fri, 10 Jan 2025 at 12:32, Stefan Herbrechtsmeier
>>>         <stefan.herbrechtsmeier-oss@weidmueller.com> <mailto:stefan.herbrechtsmeier-oss@weidmueller.com> wrote:
>>>>         What is your opinion regarding gitsm. Should we remove the bitbake fetcher and use a update task to generate a inc file with the source uris and source revisions?
>>>         That ship has sailed. We can't remove gitsm, it has users, and they
>>>         will be very angry.
>>
>>         This makes it impossible to fix wrong design decision or
>>         remove code with a low code quality.
>>
>>>>         Do you really review the changes of the inc file?
>>>>         I understand the points but I have the feeling that they are more theoretically for package manager dependencies or could be solved in an other way (ex. caching)
>>>         But do you? I have to restate the point: a solution that can be placed
>>>         inside a layer is much more scalable and maintainable than adding code
>>>         to bitbake. That's why I'm leaning towards drawing the line at
>>>         existing fetchers that are wget/git convenience wrappers, and shifting
>>>         dependency/lockfile management to layers. It's ultimately RP's call,
>>>         but he does seek feedback :)
>>         I'm working on it.
>>
>>>         I'm fine with large SRC_URI/sha256 diffs when recipes get updated to
>>>         new versions. And since you asked, no, no one looks at them, they're
>>>         auto-generated noise that we learned to block out, just as we learned
>>>         to quickly skim over recipe patch changes that are just line number
>>>         churn and similar non-functional changes.
>>
>>         Instead of an inc file the generated SRC_URIs could be saved
>>         inside the work directory of the recipe. This will eliminate
>>         the noise and avoid a manual run of an update task after a
>>         recipe changes.
>>
>>
>>     Except for those that want the .inc file changes to be version
>>     controlled (as well as SRC_URI changes), but maybe I'm
>>     misunderstanding what you described above
>
>     Why should somebody version control the generated SRC_URI?
>
>
> Why wouldn't they ? I'm talking about when the SRC_URI is generated to 
> git fetches (or whatever), that is part of the recipe and version 
> controlled.
>
> My point is that this is not throw away / transient information for 
> many use cases. It is something that can be tracked between updates to 
> the recipes.
>
>>     A generated temporary/build file is definitely more visible than
>>     something that is programmatically done and held internally
>>     during recipe processing and build.  It opens the door for
>>     extension and doing version control on it.  So I don't object to
>>     the concept, I just don't think I have all the details straight
>>     in my head.
>
>     A generated build file will be saved in the work directory of the
>     recipe like any other generated build file. It is impossible to
>     add it to the version control system. The update task create a
>     version controlled generated source file. I don't understand why
>     the version control is needed because the source of the generator
>     and the generator are version controlled. Especially if the output
>     is ignored during patch review. I think it is much more
>     straightforward to patch the source (lock file) because it is
>     complicated to handle manual changes during regeneration of a
>     generated file.
>
> *sigh*. I'm quite aware of what can and cannot be done. That's not 
> what I meant. I'm obviously not talking about something in WORKDIR. 
> I'm just saying that if something is written to disk, then depending 
> on how things are implemented it can be viewed, debugged and 
> manipulated. If it is always generated, held internally to the classes 
> and used, I have no options to do that sort of debug. Similarly, 
> anything that is generated, it would be ideal if there was a way to 
> re-use a previously generated artifact and not generate it on the fly 
> .. that's the element that opens the door to version control and tracking.

Why do we need to track the generated file if the source is version 
control and the generated file is cached like any other task output. I 
working on a prototype with the following steps:

1. Fetch the sources from the recipe (do_fetch)
2. Unpack the sources from the recipe (do_unpack)
2. Apply patches which are marked as early to patch the lock file 
(do_patch_early)
3. Resolve dependencies from the lock file and write it into a file 
(do_vendor_resolve)
4. Fetch dependencies (do_vendor_fetch)
5. Unpack dependencies into a package manager cache (do_vendor_unpack)
6. Create a vendor directory below the source folder (do_vendor)
7. Apply patches (do_patch)

The go, rust and npm fetchers work. The go vendor folder works. I'm 
still working on the vendor directory for crate, a solution for npm 
without JavaScript and the integration of the dynamic sources into the 
SBOM, archiver and so on.

Do you have a recommendation for an example project for the Rust, Go and 
npm fetcher?

> We'll agree to disagree on what is or isn't efficient or complicated. 
> Luckily, this is all opt-in, so I'll never really have to use it. I'm 
> just sharing what it would take to get me to consider it based on what 
> I've learned/suffered in my time maintaining quite a few go recipes.

My problem is to understand the reasons or use cases behind the inc for 
generated content and its version control. I understand that is must be 
possible to manipulate the fetches dependencies, to cache the generated 
fetcher URIs, to make the fetcher URIs viewable and to manipulate the 
fetched dependency sources.

Regards
   Stefan

--------------50nrcNXhSOev51199TiK1Sau
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 17.01.2025 um 05:19 schrieb Bruce
      Ashfield via lists.openembedded.org:<br>
    </div>
    <blockquote type="cite" cite="mid:CADkTA4PeRvBoR-F3pM-XOjWKEjsgLX+entDPv1uL+uTiFxjc=w@mail.gmail.com">
      
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <div dir="ltr" class="gmail_attr">On Mon, Jan 13, 2025 at
            2:11 AM Stefan Herbrechtsmeier &lt;<a href="mailto:stefan.herbrechtsmeier-oss@weidmueller.com" moz-do-not-send="true" class="moz-txt-link-freetext">stefan.herbrechtsmeier-oss@weidmueller.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <div>Am 10.01.2025 um 21:24 schrieb Bruce Ashfield:<br>
              </div>
              <blockquote type="cite">
                <div dir="ltr">
                  <div class="gmail_quote">
                    <div dir="ltr" class="gmail_attr">On Fri, Jan 10,
                      2025 at 10:04 AM Stefan Herbrechtsmeier via <a href="http://lists.openembedded.org" target="_blank" moz-do-not-send="true">lists.openembedded.org</a>
                      &lt;stefan.herbrechtsmeier-oss=<a href="mailto:weidmueller.com@lists.openembedded.org" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">weidmueller.com@lists.openembedded.org</a>&gt;
                      wrote:<br>
                    </div>
                    <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                      <div>
                        <div>Am 10.01.2025 um 14:26 schrieb Alexander
                          Kanavin:<br>
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
                        <p>This makes it impossible to fix wrong design
                          decision or remove code with a low code
                          quality.<br>
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
                        <p> Instead of an inc file the generated
                          SRC_URIs could be saved inside the work
                          directory of the recipe. This will eliminate
                          the noise and avoid a manual run of an update
                          task after a recipe changes.<br>
                          <span style="white-space:pre-wrap"></span></p>
                      </div>
                    </blockquote>
                    <div><br>
                    </div>
                    <div>
                      <div style="font-size:small">Except for those that
                        want the .inc file changes&nbsp;to be version
                        controlled (as well as SRC_URI changes), but
                        maybe I'm misunderstanding what you described
                        above</div>
                    </div>
                  </div>
                </div>
              </blockquote>
              <p>Why should somebody version control the generated
                SRC_URI?<br>
              </p>
              <p><br>
              </p>
            </div>
          </blockquote>
          <div><span class="gmail_default" style="font-size:small">Why
              wouldn't they ? I'm talking about when the SRC_URI is
              generated to git fetches (or whatever), that is part of
              the recipe and version controlled.<br>
            </span></div>
          <div><br>
          </div>
          <div>
            <div class="gmail_default" style="font-size:small">My point
              is that this is not throw away / transient information for
              many use cases. It is something that can be tracked
              between updates to the recipes.</div>
            <br>
          </div>
          <div>&nbsp;</div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div>
              <p> </p>
              <blockquote type="cite">
                <div dir="ltr">
                  <div class="gmail_quote">
                    <div>
                      <div style="font-size:small">A generated
                        temporary/build file is definitely more visible
                        than something that is programmatically done and
                        held internally during recipe processing and
                        build.&nbsp; It opens the door for extension and
                        doing version control on it.&nbsp; So I don't object
                        to the concept, I just don't think I have all
                        the details straight in my head.<br>
                      </div>
                    </div>
                  </div>
                </div>
              </blockquote>
              <p>A generated build file will be saved in the work
                directory of the recipe like any other generated build
                file. It is impossible to add it to the version control
                system. The update task create a version controlled
                generated source file. I don't understand why the
                version control is needed because the source of the
                generator and the generator are version controlled.
                Especially if the output is ignored during patch review.
                I think it is much more straightforward to patch the
                source (lock file) because it is complicated to handle
                manual changes during regeneration of a generated file.<br>
              </p>
            </div>
          </blockquote>
          <div><span class="gmail_default" style="font-size:small">*sigh*.
              I'm quite aware of what can and cannot be done. That's not
              what I meant. I'm obviously not talking about something in
              WORKDIR. I'm just saying that if something is written to
              disk, then depending on how things are implemented it can
              be viewed, debugged&nbsp;and manipulated. If it is always
              generated, held internally to the classes and used, I have
              no options to do that sort of debug. Similarly, anything
              that is generated, it would be ideal if there was a way to
              re-use&nbsp;a previously generated artifact and not generate it
              on the fly .. that's the element that opens the door to
              version control and tracking.</span></div>
        </div>
      </div>
    </blockquote>
    <p>Why do we need to track the generated file if the source is
      version control and the generated file is cached like any other
      task output. I working on a prototype with the following steps:<br>
    </p>
    <p>1. Fetch the sources from the recipe (do_fetch)<br>
      2. Unpack the sources from the recipe (do_unpack)<br>
      2. Apply patches which are marked as early to patch the lock file
      (do_patch_early)<br>
      3. Resolve dependencies from the lock file and write it into a
      file (do_vendor_resolve)<br>
      4. Fetch dependencies (do_vendor_fetch)<br>
      5. Unpack dependencies into a package manager cache
      (do_vendor_unpack)<br>
      6. Create a vendor directory below the source folder (do_vendor)<br>
      7. Apply patches (do_patch)<br>
      <br>
      The go, rust and npm fetchers work. The go vendor folder works.
      I'm still working on the vendor directory for crate, a solution
      for npm without JavaScript and the integration of the dynamic
      sources into the SBOM, archiver and so on.</p>
    <p>Do you have a recommendation for an example project for the Rust,
      Go and npm fetcher?<br>
      <br>
    </p>
    <blockquote type="cite" cite="mid:CADkTA4PeRvBoR-F3pM-XOjWKEjsgLX+entDPv1uL+uTiFxjc=w@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote gmail_quote_container">
          <div>
            <div class="gmail_default" style="font-size:small">We'll
              agree to disagree on what is or isn't efficient or
              complicated. Luckily, this is all opt-in, so I'll never
              really have to use it. I'm just sharing what it would take
              to get me to consider it based on what I've
              learned/suffered in my time maintaining&nbsp;quite a few go
              recipes.<br>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>My problem is to understand the reasons or use cases behind the
      inc for generated content and its version control. I understand
      that is must be possible to manipulate the fetches dependencies,
      to cache the generated fetcher URIs, to make the fetcher URIs
      viewable and to manipulate the fetched dependency sources.<br>
      <br>
      Regards<br>
      &nbsp; Stefan<br>
      <br>
      <span style="white-space: pre-wrap">
</span></p>
  </body>
</html>

--------------50nrcNXhSOev51199TiK1Sau--

