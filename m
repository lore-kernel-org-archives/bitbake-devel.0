Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99707C87FCA
	for <webhook@archiver.kernel.org>; Fri,  1 Aug 2025 10:51:17 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.71])
 by mx.groups.io with SMTP id smtpd.web10.84831.1754045473835975928
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 01 Aug 2025 03:51:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=PBKP/Pjq;
 spf=pass (domain: cherry.de, ip: 52.101.65.71, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tol3CuCaliJW9DzZXmHI5k38Pr4NEL/wgxeDj74tBx1zDfB5AmnKs/GUAP+7TJUw8tJNKpikAE9RvPAFhV+efpDhJhWo6JKCsafYAW0Qkz3yV3ujJVpbva/g4XCp0X5/UXeECVmw8kkOCUKCfPPk91gz8YRAHhhShJJjbYrhyahv5Wpn+3vggYT8yNoJiy/H8VGPjk/9kTtJAXcdO3o0ZzkH1rwVMrujfr/J1Jp9IhdQ4bH8E+Pixdegvs+8rgIsBr+MmMEnJu35ABiO6k1ojr42yTmDvlPL9OIJJcT8utKHwflXiJamTOhMJD2vUnY3Mr0WArDhWdcgORCtbMfXIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x66B2+E2NSrWsQ6ds+iz0zJzs278PaTATkOe095OBGo=;
 b=QysD1tx8KN6HPlDKF0/Ljxz1D2/9q7kdX9NwGZJemK2YuqVtbZoCgn0UzuK4eEPclJ7+ewrNgxuZhkTjbqYsXo2LmjNH7UIKypiWIMx+D6CrxdgYqQ17dWbmoc2ZO9z89x5tXwv5gI4uxCnIZzRqgdaHPPpMXpLot5RDAsrnBoJcXDBP76udbUBJOxjC6fEHL1SD7GXiIVEQFlW9Y92kA5JYerL7s423BAOf2TDbS5gCdmPtoK4YsWNB7t+MKUjFOo+UBUW/nWW35c15dcgXr3TRqqP8N9dnvBTIy2VQWFs/q9t7QK9IRwdn9vPLC7hEgDTq9cz0fg59YHAmp4Y7Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x66B2+E2NSrWsQ6ds+iz0zJzs278PaTATkOe095OBGo=;
 b=PBKP/PjqPWUXZz7nH9GTkFGR8lHdE/H6Xjy6+gxGGkzWdxkx9XiQ5K/u2Ix9G566oMvFUYXiXnD4qrlwJ8MnA4fkYKu86gK3SdNZSaqAU41c77Ys8cvgE0gYqQDSIPl2SQlcbu153urlktEynuaXm7szm9LHhuRewwsYFmboUJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM9PR04MB7713.eurprd04.prod.outlook.com (2603:10a6:20b:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Fri, 1 Aug
 2025 10:51:10 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 10:51:10 +0000
Message-ID: <8b25f14c-90fc-4e29-b4e5-225b2711cedf@cherry.de>
Date: Fri, 1 Aug 2025 12:50:59 +0200
User-Agent: Mozilla Thunderbird
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v2 2/2] doc/bitbake-user-manual-fetching: remove 'rev'
 default value
To: Antonin Godard <antonin.godard@bootlin.com>,
 bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20250718-new-tag-git-fetcher-v2-0-11240d481a05@bootlin.com>
 <20250718-new-tag-git-fetcher-v2-2-11240d481a05@bootlin.com>
Content-Language: en-US
In-Reply-To: <20250718-new-tag-git-fetcher-v2-2-11240d481a05@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0084.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::29) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM9PR04MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: 76cec110-9150-4356-962a-08ddd0e9526f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dVdBZGlFZjJwekZ3TFZReGcyVysyRG1ub05kcHhnZ0F1WkhRaGYrMFVqakJn?=
 =?utf-8?B?SFFlWEhneG53MmRqbGJwSitRQ1FGQSszZllZam9mRTNlSDdSbm44R3pVQkM2?=
 =?utf-8?B?N1o3cVhySVMrV1huZW0wTmM4REdzNm8xVDMrM0JrdVA3MkZpdkEwTFRPNzBC?=
 =?utf-8?B?Z0Q5VkdDRW9JUjRRSnlDdW0yZkZvSUZkSkFCOU1GTFZKWUlUMzVadDUyRkpG?=
 =?utf-8?B?LytQMHpLdmxCN2g1elFxQm8waGVvOEQwVU05c3lrT2pEWHI0ZnNLeVpJNFY1?=
 =?utf-8?B?akxYMlE1SFVhZmZLeHdKYkVUbE5nRjVSMTZHWWJrOUFOc3dIWHIwWXJxeEJJ?=
 =?utf-8?B?U1hFSWVoNEk4anBJa3hZb2JyVzR4UDM3SDBpdlFBVGdyMXRLNXZ4aFJDRGFL?=
 =?utf-8?B?SEJEQXl1RDl4U2VkcnBOa3NjOTRuUFBpMXptNXBmWVAyZHhEelZNQ0JzeXpZ?=
 =?utf-8?B?WlhVWUhKaHF5SFU4WCtIU1FuV2JDb2Y3c1NWZ0xxTHh1WTJuYzVkNksxaDMw?=
 =?utf-8?B?UG9nbm9waFFFWG1NMkcwWGMxejR1WWdyKzRFd3F4SStwdFEzaTZpVklRUExZ?=
 =?utf-8?B?a1RHRGdIZXl6akg1aEdWT3U3WmJlTWdDME5ONUhmZEltRU5lV3hWaXRTeGkr?=
 =?utf-8?B?WUlpZzBpcWhqd1NtdjBjWG5aS1k0MHRtQnNnendib3hUaldSeWJ0eDdlWWpr?=
 =?utf-8?B?RjQ5bHZJS3VzSnNTcEFGcENuNC9lUWlmYXEwaFFjVlVkS2pIRXpUbzJ4amJJ?=
 =?utf-8?B?TjJ2bndERSsreDN0Z3p4VCsrYVlTVlBWQUN2ME9CQlRyQmo2d2o3QlRuajkz?=
 =?utf-8?B?QWpuTTR6YmtDdk1DSmJiVG01TjhuRkVYN1cyazFhMVo1eXBQTTdaekRYN2E4?=
 =?utf-8?B?V2ZhQlRDMUJhUmV0SkQvQU5UUkU4RHhySFI4ZXhzMkRCOS80VDFkTkh2QUxa?=
 =?utf-8?B?NWtIZXpQWXg2ekc1YnViT0ZIbDl1WmFzRjZJZm1zaTJ3Q0ljYzc1RTQ5VFVP?=
 =?utf-8?B?QUVBLzl2MTluSjI5eTA2a2xMdjVxYWFRZ3FZUmZnR1B3UjNiQVZmejBxdkV3?=
 =?utf-8?B?Vno0Y2dJcFVEZ051SkVhN3Y4dGpoVDVsOEpQMng4bHJMWXRVMGZpakIvV0Zn?=
 =?utf-8?B?WmRudVVvRzYwTGNNdWNEVThRVWppYkRVdDFKWURwSU1YQk5zWXpGcEtXell4?=
 =?utf-8?B?bnQ2UEx4dUZPbVFBYUdzK0w0ZFkvRTBJQW43eW84WjByb3gvZFZUaEs5RHpB?=
 =?utf-8?B?MlA1UjRTQmtkRTBYUG5hUk05VGxDR2h6ZlV4ajJTTG9DUUhUUFZ3aEFaNXpt?=
 =?utf-8?B?TWZtU1hTaStlcTU3d1VTMHBjQnVhVzVELzBFUkRXdGVrbjVScDMvQ0NiRmtp?=
 =?utf-8?B?aXpPbkVmWnpabnI1RWRrZjFSanVZM0tWWVk2S1pSV0Q4cjI3VkhtaU10Z3Zs?=
 =?utf-8?B?VEtjbXBaam52ZEorSDFWNGhHSittSW9vMm1yR01qbFZ0OXVmM1BrWmxDMW8y?=
 =?utf-8?B?cVpkUFdoS3JZcXhtWkRRTHlFWjh4VytzdnhJUFE4MHJPeHVPekxwRXN6NkVC?=
 =?utf-8?B?dVFEQk5JODJSL1llVDNrRUg0dzhYY1hpOUhuVXltYlpzM2dxU255d0FLQ2Nw?=
 =?utf-8?B?RDk0NWtXR1FFY2htb25kY2p5TnJJcklkcThBT2NXQkJhWitWMGZla05pN2k5?=
 =?utf-8?B?TzBZQklCL0xSUXBuN05tQ0xHQkZTMEpXaExwWDdNMHVlcXJ4SlkzS1g0dkhn?=
 =?utf-8?B?WktqMnRrM1Q1dnpZazlsK1FBRzA0TElWRGZzTGl6Y3V4TjFrUEY3TDA3WGdt?=
 =?utf-8?B?UmRRMk10RGh0WWdCU05CLzFETzhvdTB6N0Nxc1JlTEljREp3b1l3aUYxYlVF?=
 =?utf-8?B?aUNUcGR3QnpQcCsxMDZWVWN2WWFPZG9nWUMwRUVqZmx6Zlg0SU53ZXRqYXVi?=
 =?utf-8?Q?Z8cwwio7+ac=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c3VZd29SLzNoZ3pBbGkxTUR5ZUlWU1NXbVlueXlNejdkbktscERQYVIySHJS?=
 =?utf-8?B?WGpVUVBRWWh0azhiMHRhNThUNUlxcmJXSFRSb1Q5Mko3TUJDZkdaUGduWHEv?=
 =?utf-8?B?VlVrM2VCaEZsdXhXZlQvbHpQSlVPYUJweXZTVDBhV0xvY2JUNG9ncitSNUpw?=
 =?utf-8?B?MFlUVGJid2VVdHFYUVc1YU5NeWovbkVnakM2M0liTmE5UldJZFAvVnBBTUwy?=
 =?utf-8?B?TkVhVTYzRXJQNDJ6M2tVWlNrVUVXS0hESDNqWWpITGVRTkRNek1qdGFVTFdz?=
 =?utf-8?B?SkRMUkExOVdIdDZwcUcyMmI4SkR1MFRWaG9hK2p0SGlyNUVQN1Q1NW1Zb2Zs?=
 =?utf-8?B?NzRjb3JYYlJEeTI0WVh5aFY1dGhaTFNXdXhSYkk4eHpYOXhCSTlIck8rRjZ1?=
 =?utf-8?B?ZGpoK1RoV3ZLKzh5U3RtU3J1WS93VzdtcGhTQ3JZYWxlVllEQm1LTHhXTmo0?=
 =?utf-8?B?Tmg2b0tzWVc4alZzRWNKWEtRajZsc092ZFEvMG1mc3BKVXpvdkN3SzdYc0VO?=
 =?utf-8?B?YzFPdGxvRXgvQ0JFaXhxaHV3R3Z2dGtweExGN2x0bWpXa0s3VGpOWEVCRHRr?=
 =?utf-8?B?Y1JrZ1BaMXFibnZ5UTVLNkhQUnNSVlNqeU1MaGhQbWtaUTdnRE1jWUYxc0R4?=
 =?utf-8?B?c1JldjZ3MnJ3MXlZZE5uay9jdFZhZmIvc1BuUXZpYjFSSFZXTVE4alNHVk85?=
 =?utf-8?B?Z2x5TVVBcHhTZ3VBNWFSWXZLTnNGSWxWS3Z4TnlWNXp5YmFpdStwQjNuVXE2?=
 =?utf-8?B?QkhJTStmeHc5Ujh5MVV1c3BHaUwwZllCNjgwdWEvQ1Z0OWFFNVovZWlxZmlE?=
 =?utf-8?B?Qk5DTGZBTEo3VVBMYUxaSldqalZmQjkxUld0QTF2R1B3Z20yb0xrcG1FMmp3?=
 =?utf-8?B?bFAwMHRuTE90Wkw5V2cwVHZDOWFrakxWVWppWGhoNGZjbTRTbzlEQjZYTmlr?=
 =?utf-8?B?T2VubUNJdUNWRWdLRnhoOHN1cXlyWWMybGNGQUF1ZExZekpsUjRTaFlUWHlQ?=
 =?utf-8?B?SjhBSlZBdERuc2V6bDRvWEhRWkVGYzMrVGNNYWhKWUxlZUxPbXFQRWdla0hS?=
 =?utf-8?B?N3p5UFFubk5Tbkgzclc0QUoxSlF0VklxMWVRSnptYVRvSVREMWwvZjBTcDl6?=
 =?utf-8?B?WWhJSXc2UWw0RzByUlZJSHlSSmU5dGErVk5JbHBNc3I4ODJ1NHNoNXdFeEpk?=
 =?utf-8?B?TVhlZjNVaDFsbjhDNEY0NWFYdENHai9zekpQOWlNZEx4QkFXZnp3Tm1tNUsr?=
 =?utf-8?B?bnNHM1lWbFNkM2RiOFdOTnUzVm1Fbi9mbExLby9pbk5QL3N4a1FWZzJCZTVI?=
 =?utf-8?B?YkZyMzJaTiswYk1PeUlkY1d6TnVzVlZGWHRWNHpsbHZISVl4ZVk4T1BBeFZz?=
 =?utf-8?B?Vm03cTlwTGV3NlpMQzhvUTNkMjlialdINjNiVDZ6dzNra0p2QnN3QTgwWk5K?=
 =?utf-8?B?SEpoUWpSL1pvbmRkUnlWL1Q3QmVHUC9ZajgyMGVSWUVZM2pYUEtEMmN3czhj?=
 =?utf-8?B?VW9heHNnbU9YamphT3gvbVkzUCt1MzVTUlQvUXhKcS9KT3Y5UE1QM0tzWm5j?=
 =?utf-8?B?VUhxblY4UVBtaElqekZmMi93b3pwQ2xhaDhZVjRBSy81RGQ3WkFaTTNEdjlL?=
 =?utf-8?B?OStWU3ZXTkVoOVE1OU41UDJIUlhZa09MSjdTbURIbTl3aEpvUDZ6Qy91RC9x?=
 =?utf-8?B?OWQ0UndsdHducFZ5a2tWVm9NR3pvYVg1MXROLzNMdC90WEVjVUM1RHdqdjY4?=
 =?utf-8?B?blpobmhRNTZUYmJiMDJUbFlPSm4zL3ZXRmh0Yi91WVFyV25TZkpWbFRNd2xz?=
 =?utf-8?B?NldocTU5TDAwVGcvRC9YT3FYWHk3d1NPTjlyd3dpRXF4UnBxcUlJZmEwa1hT?=
 =?utf-8?B?SUR1YnlYMEFMckdURUVkYlQyUTRSOEFMUkwvdm5keFpYakVSNW1SbWtKUDhD?=
 =?utf-8?B?Q2MrRytqNWw2alNtUmxwQlJYMHQrR0kyVGlQUWJpSFE4OGx0aEF0YmxXaXls?=
 =?utf-8?B?N2lGTnA3RU9zd2ZuT1JsQUoySlBIeDZDWDYxbHQxMWg2ZkNoeXRyWFppaXYx?=
 =?utf-8?B?UkhQelJnQlg2THpINlRuUWdldzFJcUJ2U1h1WkVaWWxKVjNZTEJCaGgvS25y?=
 =?utf-8?B?T3NjeVo3Q3RxUnFQbFoxemNaSGZhNG5Gc0NDYkpDdFlORzlSdXVQRzVDanNO?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 76cec110-9150-4356-962a-08ddd0e9526f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 10:51:09.7013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f8TyQ2a1+5hrQHWijfCOyBsKM++8oVA8bJa9+e2Etvi9ZEbemhhgt868MnHknVt/dodaPZjbKWLre+O7hUneOf5Gchi/IpArUuihxpkRp/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7713
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 01 Aug 2025 10:51:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17833

Hi Antonin,

On 7/18/25 11:06 AM, Antonin Godard wrote:
> Remove rev's "master" default value. Mention that it must match SRCREV,
> if set.
> 
> Reported-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>   doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> index 51c9a81e03..d4496a9fb7 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> @@ -436,8 +436,8 @@ This fetcher supports the following parameters:
>      "nobranch" is set to "1", this is a mandatory parameter. The number of
>      branch parameters must match the number of name parameters.
>   
> --  *"rev":* The revision to use for the checkout. The default is
> -   "master".
> +-  *"rev":* The revision to use for the checkout. If :term:`SRCREV` is also set,
> +   this parameter must match its value.
>   

This seems correct to me.

There's a second occurrence of that rev parameter in the docs for svn, 
so we should probably document that as well. Funnily enough, the svn 
fetcher has the same logic as the git fetcher except that it overrides 
the revision with the one from the rev= parameter, but the SRCREV != rev 
param is still performed as well as checking for a tag.

Anyway, would be nice to update the description for the svn fetcher too!

Cheers,
Quentin

