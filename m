Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29CBCF9C71
	for <webhook@archiver.kernel.org>; Mon, 23 Sep 2024 10:28:22 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.45])
 by mx.groups.io with SMTP id smtpd.web11.33506.1727087295439987303
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 23 Sep 2024 03:28:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=Ef7eKVMW;
 spf=pass (domain: cherry.de, ip: 52.101.69.45, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzeArecRaMN5tWO5oglfLgG/3BD0f5bSeXwCxBQ01kJjMBjGafy2tgwlv6cBDKQUKnasZuUdeEBmJW08cJvfu6+q0IgIseBOFH2auj01JluGPua6Z1ak+y1WrpGoNhloRkgIWBfweK7QP4w9+YqzEPZxe1x7pst6HJGtGnfDIzNjzy/t73+EORYdWhWJOjNxnmJ8dVtXgs2AS9OyJb20K+f9IklbFSw8+0hj3WEuNDKtogBpeLTTVor4TPKwl0y+fGjBqkGXSA/Bv6HezZdlToMiZ3O0FBq0Lg5u8qXn2MrCEKL8Io7noWw06kNiI0hwo4lY6k2kPUILr0ZhjCXwKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLCO8/Acghu9XjsatIJ9tnLMSsvsy/hkYd1funIHBIA=;
 b=zEcUN5twviTJ7ryhpdtVWtdaLQnSh0KhUiANpTCbrIpGrX8/uPbv2t6Iu4vxcEB5rJ+a6DgL82vJvuUCaDoRNlbDg6ZknUTSqPBO7M8xrqqN3dgwqoPBSTu39st25V1NoYlRtQnqGSS29wYweCiecVukve9z1q2CHxicpkBbDo6PsjGGbOfr8WhrJ5jmqbRpTS95bQk2EfNmMb0cCqiEJs/NiEbokK9heMWzVsYrk0ei/bxzpMy9XiYcOIIH09ZZA03Hdc/G0dOlfU9C3Jy00Vc671N5OoUCpQXLt5F9bZ9Ysr77/CEuE7N6tvfZMqkXU+2zXE/4xavAxlOGaS4pOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLCO8/Acghu9XjsatIJ9tnLMSsvsy/hkYd1funIHBIA=;
 b=Ef7eKVMWf9BChx9qgGBZNUWVsxGt1VUTJrQzBq1LnYz6RSNG9gTzU9RIrmwdWU1zqaAhgsHPtOHK3WSodiRp7FvoYZu1dKeoxOlND8PRv7g0m75fGiODtE4OAmCIJBpB+JvHN8RWggZIze0RquCS11FOY/X6vOcTFFP1io6Llh4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AM9PR04MB8890.eurprd04.prod.outlook.com (2603:10a6:20b:409::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 23 Sep
 2024 10:28:10 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%2]) with mapi id 15.20.7918.024; Mon, 23 Sep 2024
 10:28:10 +0000
Message-ID: <f41b36fe-4233-4d7b-b227-c19c72ebf97d@cherry.de>
Date: Mon, 23 Sep 2024 12:28:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] doc/user-manual: Refresh help output
To: yoann.congal@smile.fr, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
References: <20240921124433.1961318-1-yoann.congal@smile.fr>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240921124433.1961318-1-yoann.congal@smile.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0107.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::10) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AM9PR04MB8890:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a84dbb-30f8-43ed-042e-08dcdbba6c0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QXVhVm1GVlRDWjJ3VUlkWHZEa20rSHpTZk9OcGpDc2NmWWZDOE9OTHNmam5V?=
 =?utf-8?B?R0lXYXVYN09ZVmtXSERsZ0cwQitPTWQvWHdWSXZxQWdJeUUwY04zMk82dkFQ?=
 =?utf-8?B?V2lHcnMvQ0lscEZmOTl1MnFoSnRqUklGUElNZnpVY1FIT1M2OEppb1RIZGht?=
 =?utf-8?B?UFl1QW91aWp4dnZKdWljanVodmx6Mjd5d0VpUVFsclRBamNnL3d6cDNrQ3NN?=
 =?utf-8?B?SG5QdTR0RFFLN3EzaHliUlZTTWRIeE9KY3lUNTV0NHhUamx1QzJVODUxcEhi?=
 =?utf-8?B?bVBxTXZCdWFoVU1aWXBJL3hZUlIvSjh6a051Q1o2MG45K2VtLzlpODZQa0ox?=
 =?utf-8?B?ZzJvNFhuK3J2dGRjN1VMcUx6c3NGSGo5alJrcUI4cWU2OWtWTFFIZWQrRm1T?=
 =?utf-8?B?Z1ArcjZjcXF2cks0d01jUzlRSkNWWGh1cG96VCtJdEhrNkFsc3k4bThOS25Z?=
 =?utf-8?B?TnY1aVNuREwwUVd3UW9nTytWRWs1S0ZleHpQNDZncWk1TE5TbnBwSkVaa1gv?=
 =?utf-8?B?M1g1Qi9uTFI4RnFQTlMvR1FOQ0ozU2dHRFAwK0pERHMyTHI5VGNlVG1sNmRo?=
 =?utf-8?B?bm5VSzJsQ2wxdWtjb3JFMGFWcjA4dys1THEybkNHMG9tK3UyY3FtM202V2Nv?=
 =?utf-8?B?VDBMeTBKa1ZYREtDZ1o3SzVrM3lqRXVmV0NyeHJ5bTZOMUpkK1hzNmxxTWZ0?=
 =?utf-8?B?blZQVzRuQnh0TWpaWkpKcWZNWis3OFEwMEg0VHZwZ1FpcUptenNlZHhJMXdM?=
 =?utf-8?B?aGttREhoN0Q1S2xPS1UzUW9xNzlkcVhONGhraWFhbTl0N2F2Z3MwSFQyNWpT?=
 =?utf-8?B?cGpuZXFyTmhBdUl6ZU5MUE5UYTE3ZC9icnBWWVpZMmZPQnRHN0hsei94L0sr?=
 =?utf-8?B?OUxqWXRwQUp3NkkrR1BlL3lrRkFreXJDVEdHMTlXZy8wSE92VnRaaXViNGdQ?=
 =?utf-8?B?SGtqV09ZSU1CRnNEQjJWU1oxdmMxV0JnanE5YVd6Y1ZpQVN0Ti9jTnhKcDRC?=
 =?utf-8?B?dU5qeUdlTWdmOVRWb2IrVUg2RG9tSEs3UnRaTTMvbmk4Q1RycDdsSnRBRGJW?=
 =?utf-8?B?UTJmdmt1VllSZlh2MGlOZG5vbFJ4RVc3dyswcUN1Z0tjVW9tZ0pZYk9haE5C?=
 =?utf-8?B?UGdsWWF1NEhVNFBJQlI2cDYrQWh6TnVaTTUwdWp1MW5pbWs5U0llb24ySUdz?=
 =?utf-8?B?UTJRN1BKOGswV0lvaEdMd2t1eXd2RHB6T1ZjZHErZm5HbHdyZVJ4OVNrT2NG?=
 =?utf-8?B?Tk5lNlV2Uyt5TlM4WFR2cnYzTGRRbWFLbHpySmVOdHFzWGF5ckMvcWtUdHNv?=
 =?utf-8?B?MzFDOVJ4NFJZMlBQWEZWNE1kcTJQWHFsWEt3aVFLa2xCQTAvRSsyZUZuOE9i?=
 =?utf-8?B?MUJVTWhFZjJOV1dGcFpCM0RYOERBL3lUUEJOZW5xdzRjWW5HTW5US3ViWW9m?=
 =?utf-8?B?cllGalZieHlNdmNvVWZwYkhmZUVXME9KRGVBQlJhbDVmZTZJWnBYMCt0WlZp?=
 =?utf-8?B?ODZMQkliT3NpbU5SL0tNaDVoRTdRV1hyRUZYWXczUlZxeFFLNjVCeUpBUmp2?=
 =?utf-8?B?anZ4ejkrVld2aHUydDFiY0VzRmx6NkNLUnJhc0p2V2hxWFpLU05vNlJiaG53?=
 =?utf-8?B?Q1RaMmY0K1pFbW00bEZtdmJkb2dvV2M3L3o3Zm5CbGhEb0NMYkk4K0MralVC?=
 =?utf-8?B?Tlk4MmFzUDIzTnN5V3J2Y1IvdTJvWUk3a1hwMEFEdFdMRzVsMjF3L1lnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YXNnNXgzSHlLYUxTVTB0d2g1NHNYcDVaZlJZR2Q0ZUg3cloyU2dFeVNuSkN3?=
 =?utf-8?B?UFBsVlEyQTJLSEZkNFE4YXVoMVF0QkJiRnk2QUh5YkFuVHNVc2pJeXIxRnlS?=
 =?utf-8?B?aWJTbnFha2tHMjFzR011ZW9lYUhSTXhoWlhMMUdSZm14aUJGSERrejF5TU1l?=
 =?utf-8?B?bGFVVm03VzJkUkkxR1VtMlB3bzVQaE8ramxYNTUvUExVR1A2bmtWS2QySmx6?=
 =?utf-8?B?enJ3VXIwK0ZDM1dKRUE2RlkvWHQ4RFVXbVRMWUc1MHhhUjlPV0pvRngvNG1K?=
 =?utf-8?B?QU1qN1NZdHI0MG90Vjg1MEtRQ2hNWmZSU2lyVUtWTHNXRm9nRTBVYndnclp4?=
 =?utf-8?B?MDhPZWpYWHVZTldncGVzWFRJZkttOUZyOENuMFBGWUszSUFESUdzam5jQ0RC?=
 =?utf-8?B?T2NFL1dwV01LM2oyME1GYjJCSS84NmxzOWYvdGhzL01PMW1pTEFQUjg1NW9a?=
 =?utf-8?B?aWNkQ0sxM2FrQVFBWkdrNytSVmthRWdzLzJSWWxkT29JdS8yeVVwWEw4TlZu?=
 =?utf-8?B?YTdURzM4cmNWV1hEMGhwNzh1RDBydStDNjFXUUphOUt6aFF5OXVSRVJDU09Y?=
 =?utf-8?B?L1dTUUZReCtaalFsQXh0bzdPMDV6MnEwbTlsS29BSm1BTmRCb3hkaXI5cXBS?=
 =?utf-8?B?ZjRkNUFoeEVEZ1EvekxwbzRpWWhldkVhQ1N5bUk4dHpHRmVGWTNlU3E1V3Zw?=
 =?utf-8?B?Vmg5RDU5end3c0FkNm5HNFRCZXM5aFFrNkR0djhIbGJvelJuakxkTUtvVjk4?=
 =?utf-8?B?RGc1cDA0eGs1QXVwMmlxMHB5WVZEYm9qRHQxZ2puVm9KOWpsRWtOeWgxSlZG?=
 =?utf-8?B?eWlKTUdraEZwR0FhZWZIYWlOUzVZOHpSVXkrOTBHK0hsNTdCbTRTY0RmTk9I?=
 =?utf-8?B?RzF4d2FTbDlOb2JwK3psSGhUOTlxd0hjR2w4R0l3Ny9JUURQQWpRenhYVU1i?=
 =?utf-8?B?dXJNQnQrbkNtQXVNbnhsbk5SaVhOS0ZBcmtlUzM4VERLTlNCTDZSTmk5U1dD?=
 =?utf-8?B?UkFjRS9qLzhmNGs4NGlWbkRwbmFxc3QwcUtYK1FXR2lnNGlka2R3NE85OGRO?=
 =?utf-8?B?M3BNcFd1NDZIakRhZERtaE9iK0kyZlFkNnRtSS9xM0FRQWtVV3JpdTlBNm9N?=
 =?utf-8?B?a2NkUWVqWG83WWRIM0Q4VGtCdTNWRUZkQXFPdElFNW5CYmF1T2toSmpmVlh6?=
 =?utf-8?B?bW9pOVNlbWREWXptNmdmSjVwNW1FNTN6L25kd2V1a2lUUTZaYy8ydGI2cjM3?=
 =?utf-8?B?UlJuWWpDRTk2NzBXc2VDOUhBaG5qeC96K3VNSC9YUHdyaDFONGR4U1g2aFJM?=
 =?utf-8?B?U0pBbE51bHVJNldOdW56RkdpVFN3Ulprc0RHQ1FXRVM5UFRpM016eEdzanZW?=
 =?utf-8?B?cXFOSnR5SXlwdG1qaERnT1RaajRPTHE0eWNwUTRZeEZ4Rko2K05HTU9TbStS?=
 =?utf-8?B?TGdoSG8wK0VVOEZ1bHkzOEJmaUZoTGhxc0pKK1FXVjVNeUxVOTg3RkFqYjBs?=
 =?utf-8?B?YWFPZzM2YllIblM5c3grTkFiZTFVUEVOeFFmZzM4WTR3WTJWZUFRY0F4UUJK?=
 =?utf-8?B?YkY2ZWZ5V3ZsVEh1S0NFS2ROMG0vR2JnTzBqTnlDRVJxZ2I3cVp5QXN1eXh5?=
 =?utf-8?B?T0M3SElLZ3ZMN3d4b0U5d0YwTUpxd3lSWTZXaXUweGVaWm1rNFp2cEc1RHhu?=
 =?utf-8?B?WUJEK2pqY0JxTVU2Sm1HbnFGR2FicXdoYlpjcFV2K1QzZ1RtYnJucG8zaGZk?=
 =?utf-8?B?SzI2THgwdW4wbWYySXhKUEcxNGxxS3AwK3gxa0NZRlBZSElJTUNVendCMDRu?=
 =?utf-8?B?Z2NnT0ZreEYzWDBINVkrLzRIZklGVldEelkvQ2lFckNlYnpqOG1vcGU4NnFl?=
 =?utf-8?B?RG9pZkEzMXhWZ2t6UDJmQ1JxcHlDeHNOc08wSWdaNWdkaXdDeGdvT1p0OWs2?=
 =?utf-8?B?bUhqR0tZNDJWN1JLYmVYUkFMZytLQ3lwN0oxZDFoT2Mya0o4S3ZHcjRaQ2Zh?=
 =?utf-8?B?T1hNMDByT09wMjVkTzNXbzBENnIyeEpLeFZFd3VIWXdWTnFSMkx4VGlYUGcr?=
 =?utf-8?B?SVJibzhYNkFiTnZwR2hwMXBjdUVoK1R1NHUwbWwxU3BKelZQb28yVEpsa096?=
 =?utf-8?B?ckRlVmNTb1QyQ1pGbTJKVCtML1Nib0ZqVW13TVpXSmIzSXJQWTlJVk9nc1hk?=
 =?utf-8?B?U1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a84dbb-30f8-43ed-042e-08dcdbba6c0b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 10:28:10.4207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Gnt2ct7IHX7WpTb2/1ZSYarUSuiNnyts3DO88og8EDRvjoG61aStttMeJC0UbmgcS63DkFFdNQpvO+R6D1teTzN9pvd94uvKFaaBjSsI8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8890
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 23 Sep 2024 10:28:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16589

Hi Yoann,

On 9/21/24 2:44 PM, Yoann Congal via lists.openembedded.org wrote:
> From: Yoann Congal <yoann.congal@smile.fr>
> 
> In commit 9257c48c3e36 ("Group and reorder options in bitbake help"),
> help output was changed, update the doc to match the new output.
> 

For anyone wondering how to generate this diff:

$ stty columns 80; bin/bitbake -h

> Signed-off-by: Yoann Congal <yoann.congal@smile.fr>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

