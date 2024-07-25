Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAEEC3DA5D
	for <webhook@archiver.kernel.org>; Thu, 25 Jul 2024 14:34:47 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.97])
 by mx.groups.io with SMTP id smtpd.web11.37981.1721918080959513735
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Jul 2024 07:34:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=JwjK3RQu;
 spf=pass (domain: cherry.de, ip: 52.101.69.97, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVMJcQ733VTMSSWCokaRagy/Ywl7Ony15kugjYLUs1rVDZfJl27Uc65RG0t7s1dlCQRxKA/lfFYj1AUyirIkkhC8J9D+AhH/vbOCu4UQvCujBniAjTFdPciven7SQnKE4GLlUKD/GR5fw/TLUJ97kYTFyhH0hfCyQ26IC/gpCH267m6UkMPZMYFs/QPOnoluNUmWR4iKqno8ocIi0zX3f1tsyUk/iqp/HeVIvaQ2yWhLr1kuyHyjxIM5JnpZ9F+cIUYkmfJ3QdFSWvhqKRcLwp7JqKD8qr0qXlYAtLvsIm5qscsXneW++KdFnBE3pWAMfOkRwYPuTw8mOstHwWmuJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OZng3cYD5HSiPhOvbUZv4AmTPrV2XosDkpGuxbWpao=;
 b=uMSctYMual9MGgm0UabkL+gEsElY9kjHzQFv5TlXEj4gNIK8Qpbr7XYzVChOoPHnIivaZCQMEI5bNGXgutbi/FNFUdphBgNrlDjf7kqHbZCPkm9g+sbgS1vH9rDP6S6NrMy16A7UDs2Bgesa+5FjOmGMzTiUvQ/wAQU74M9LaaWtzKiiSRYLhyhELjVDITVlPpWLqrv9JgqmHG57xf7tZy+Wb7qDCTEJSXVGm3MYcljf7dC/784aHR9c+cpcqmHFB9NLI7jri2fCGqTv/Ax7rsRmKstHp4/mE8qjvdaVjZmtcunYb18u4EXMhc6+Hj56yZx2G2x9x0aec7JO+EdsIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OZng3cYD5HSiPhOvbUZv4AmTPrV2XosDkpGuxbWpao=;
 b=JwjK3RQuXEmxmCIRRNjn63QY/YfYt7meWhSrk0zcnTLiseL353WDfAwx6TJDolGnk6UkTa7xTddvMNjKyXqOIB3/RYAuwv264ak0Ok/TNt5tARWrD7DLz/HnRxiIhsSkgDBfrg3Y+iDGVuAv3jLrI5LxLFuv8WD5M9TISvzPh5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by VI1PR04MB9953.eurprd04.prod.outlook.com (2603:10a6:800:1d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Thu, 25 Jul
 2024 14:34:36 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7784.020; Thu, 25 Jul 2024
 14:34:34 +0000
Message-ID: <a82ab1b5-2151-48ac-8634-264459b3eace@cherry.de>
Date: Thu, 25 Jul 2024 16:34:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] Bitbake does not perform to unpack tarball after
 second and other downloads for PREMIRRORs and MIRRORS
To: andrii.sosiuk@seco.com, bitbake-devel@lists.openembedded.org
References: <CANNYZj9rgXQ-FgK_BiCip=_yA-m3AG8aMQDLZMNuM0=nMt5Bag@mail.gmail.com>
 <19753.1721917753465007832@lists.openembedded.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <19753.1721917753465007832@lists.openembedded.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::10) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|VI1PR04MB9953:EE_
X-MS-Office365-Filtering-Correlation-Id: 91624f79-4ada-42d5-27d4-08dcacb6e744
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?KzlRQTYwMkExeDBPa0JQVWdsVWRPWW8vaFhvMVVIaWNlMWE1d3NYUUY1a3hU?=
 =?utf-8?B?YklSdUpKejJYdEpKU2o0K0pKQno5OGRNTkF6cE5vWDY5WHFLUEEwWklrbG5w?=
 =?utf-8?B?bUE1Vnc3dnpwS0M5bWtxdW11aE1uOHR4Mkh0MHVUZWVVdGNXQnVrSnpkRDIz?=
 =?utf-8?B?Q2g1TDRBU0NtTmR1anliK0h6ZWswTTRqbU5vem9xVXJYOHFZMjE2SUdEL1ZR?=
 =?utf-8?B?OWVjeklaNlpWU0VtS0ZWbGtLM3BDNUNCeTdTc0o3UnFPSmJvRU5EK01mVnBs?=
 =?utf-8?B?aFdiQVVrUEJFOFJSd3hzWVhOZUxxVTUxdUlFMmE3cytIZm5YczFISnZiMGdz?=
 =?utf-8?B?bG1JK2FzNkRtNTdiYlBHUnVtRVpsaE8ydDcwWUp1T2pMS01NTnVwa1kwZEFU?=
 =?utf-8?B?ekdXYmRRV1h6MmdlZnR0TVQ1S1k4SStRV3hMUEJ1OFFaL3ZqdE9NelJQbldp?=
 =?utf-8?B?YzdBUVFVS012V3FsR1BHNzlxWng0b0EyU0daclAyUVBiVXFOeDNUQUhrNmUw?=
 =?utf-8?B?QUpMYjBmQVNnMGFxckxzYXFpa0R3THQrK2NTVDdsc2Y3OFlhVVB3VWJxQUZz?=
 =?utf-8?B?c2hLVnl0NFVITmkyM3R1SFhwY25oK3NtR3NsRUszVE9jUGZXcXByYjd2NEQ2?=
 =?utf-8?B?aWhyclo4bFFyeTZ3a00vMjdzL21zUWEvOFk5WWhBOTBWY2RFU3IvaDh3bjZv?=
 =?utf-8?B?d3BYMUVhZlVvNFkvaVp0SVhkc2RjdE9iem5SV0cwVG51QVFPN1ZSZmpJTjBy?=
 =?utf-8?B?anpPVlZHSHlzU01rZndJUzM1RWdWb21CcHQ2amVQeEIwd09sWDhHSUppNFh3?=
 =?utf-8?B?UHNSdXdHWnRkL1JHL1cwV3hwTnlzMUpHQjJhWkNBZWQ0TmZNRktuNE43a3lV?=
 =?utf-8?B?K2UxMStTRnM3RjZrVFVaOHhYby9lazU0cksyWVYwbnlGL1krSmlXZU5XMDB6?=
 =?utf-8?B?MU5lOXFodXpOTUFJdzY4TmlZNlNldmFqZnlGOEpNNEFEWHhIaElHN2JaNnlG?=
 =?utf-8?B?UkI1cEZHMThTSnVlV3B4YU1WYUtFRUpCcU5vK0dYNDBSU0d6MDgvQ1JXRHQ1?=
 =?utf-8?B?RnJaZFNKUVkrc1lwbFZkRTVSUm5uRk8zM25LV29XY3lPL2gvb3RzWURLaVdv?=
 =?utf-8?B?VzA0czF3M005WE43ajdURGpDQml3a2ZGZllWVHlmQkJkTFJFUnF3VVlzUzlO?=
 =?utf-8?B?WUZ4YWN1Y2h4YUhySzdPSzBJa0hVUXBSUlNhUG9NZlNCaDBvY05HV3I1Qldw?=
 =?utf-8?B?cXZtYTIwUlE3czd3ak1ETTk1YVl1TmtucUdIOEpReG1welFkSGFxNzFXb3p2?=
 =?utf-8?B?cDBDQzJwbHBWcWI3UkJWTGZmN3loblJ3RC95d2hsZzVtNmgyT1N4RjZPbTBx?=
 =?utf-8?B?eTUwOXBCZnVLbk9ZZlBjTFdRendHWmF2dGJXZmNOdHJBS3RnMjAzcmR5YXpy?=
 =?utf-8?B?Vnp5eTdCUDh2bzRBb0gwYktTK0twT0tyZG45Z0lXcWszbGQ3elpmMjcwYVNT?=
 =?utf-8?B?OXVabFJSWTh2KzJhZHB2ak9kdnNpNm5BN2xJYTZCRjdlMW9DOWtkVlpmOHdH?=
 =?utf-8?B?V1ErazRUaFRIaGR5VTNTc09KK0lYV3hwalkrcTEyTGVwMStnL0RaWlFQajl6?=
 =?utf-8?B?UHFmenlBK0NYWEVSbnZlV1BpeU16RWFJK1ZnWkcrQk1JQ2phVmxaR0t6bXow?=
 =?utf-8?B?Q2RGWUZvZ3dJZlNuRHd5Vk9ORDF5N3pGOVFJbW9jTGdpdUpDSGJvaXNqK1kw?=
 =?utf-8?Q?bRvdNEW+e/OiA5d8rc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8906.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VlA4VW9wd2FKTEtCVHBwYWpEbmhuVStIUU9QZlluN3JtMk5xTG5sWXR5MFRW?=
 =?utf-8?B?emdIcjZZcElhakUvcGw1MVp3V0lRMHp2bUVrdXN4ekJPTEpyUHY1UkUrUEpJ?=
 =?utf-8?B?N1Zydm50TTRsUmVscmVFTU51aFNPemZIVlNHM3VQdFBNeXE5MHhjVE5qdFE1?=
 =?utf-8?B?bnBORldIL2UxYWpOS3N0N1c4ME1XMXo3anFBa3Y1eE9zbm5FblFKb3BYOVRo?=
 =?utf-8?B?ZlB4KzZ6U0ZyNEkvdE5qL0FPak40OTJNWG9EZkIvNGZhUFZ6QmQxU3JsRXdE?=
 =?utf-8?B?ZVRwdVFTQ1Q1a0Y1cW5QM0lSei9Ld1ZnMit5M21rbDAzeHk0V3JZUDJETGtB?=
 =?utf-8?B?ZjMzL004dTFhdUJ2OUI0R05ubWN3WXZYZUZXcnltMnZaN2xxNklSOFkrbFJ2?=
 =?utf-8?B?S0h6WVBPUnhIRTZMcE5VejZBY1NEdzVYaEF3c1Z0cmhkbnJmaStRS2JuS2d5?=
 =?utf-8?B?WUhFU1BISjJXUURJTnhWSlp3UWFhckdKT1Jzc1NJWmJxdWYvbXJKQnE3L3ZW?=
 =?utf-8?B?NzZzMlEvcWpDcjdMbzFXeEpPZmhwU01CTlBoQ1dZY09VdkxkekQ5bk9Tc1hB?=
 =?utf-8?B?czVNQ0NhNnZiS1VYYnBhWEZianlEeGVYVWNhVmp2WmNVRXhidXh3THZLbGpC?=
 =?utf-8?B?T3B2WUJaYk1ZeFpPVWsvb3daL0E3YWUrTVVCY0FlRVhPWWZaL0l5NTM2RFhW?=
 =?utf-8?B?Z2gzNmcvR3FGWWhRQTYyajhpOFBxNlVzY3NUdWRDNFFPMWl3MG01S0szSVYx?=
 =?utf-8?B?U0pDaUJhaEQyZ2sxV2Zyd1hUa2c0Z3NuR1F3c1BLdG4vbVBkTndoNU9SMUw1?=
 =?utf-8?B?aDdNMHYwZlo3SDJTSDh0ZFVObU1pZ3pXeE5sNjJ1N3RDbUthcnhUOXRaZ3E0?=
 =?utf-8?B?QmtncXQzaU43cWc4MVJNa2J5ZnJGcXJrU2xqa2lUR0s5cXkxMW80U1N2RlB4?=
 =?utf-8?B?c01OOWtTQk10VEUrQmdPdWFjVkZVOW5rSkN4SmN3WFdNK2dsTm5UREJhL285?=
 =?utf-8?B?RGp4UWpyWk1iVmRLeCtMMldsdXBEeFNheVhwSjM2eWJqZmpQZG82UjB2emZi?=
 =?utf-8?B?cGk1MEh1bE1vS3JmbFQ4a1ZPRVdkWGlHeXNpdGhKcU1ZMnYzVGEzNzNBTGg5?=
 =?utf-8?B?TTMyZ2RqNDJFeEF4Qk95QkcydTdub2o5ZHRJV1hnZnpIeUpSbGxIV1FqLzN4?=
 =?utf-8?B?ZFZ1R24yMWJQY1FiSXlTU3I4TXI4dEZ2YzdScEpkK24yakZlOERNMUFjVnUz?=
 =?utf-8?B?d3M1NXBUNm5QKzR4aG9kSU1Ma3NiUW5xWFU4MzRXNGxEWTJEZ09haHBuTi9x?=
 =?utf-8?B?Vy9Td0Y0NXVOZ2EvTUxXT2Vqa0x6aC8xZ1BTYUZVMTlQREFkWlljdDdzRTBO?=
 =?utf-8?B?YjBZOS9aZ3VYNVc5dm8vR1d0Tjh5WDVmMVVNeHBSMFNQQzJYVlpGSzl1bXJ2?=
 =?utf-8?B?VVRGSEh5cVlVbWhKc0M0cWpZNnd3UjFjWFNEZWV3TFJMV1NhNGIycGNGaDJz?=
 =?utf-8?B?R2l4L1M1MUxRWjZRUTFJaUFyWkdBRFBQRnpkWjN3S1IyKytUU242MUs1ejRs?=
 =?utf-8?B?R0xxRFFZdi9jQlZFOEVxZXJEWTdiZVpHU0llVUxaYStxUFdWRXhlcjUrV2Vj?=
 =?utf-8?B?R09talR5Zy9qeHF4L1VCZldzUmFzZjhiVXJ3clROYk1YNStiQk9INW90RnRL?=
 =?utf-8?B?SWFBeUNEWWYyUm9sb2U2dWV0NkIzNmY4ODBrL2k0aXM1QmNqMDRZM0RQZWpS?=
 =?utf-8?B?UkxPM1JiTlE4d1BacEZrcE9lTUhZeG95ZTBOVHdyZ1huYVlCeGxmY3FrR3FU?=
 =?utf-8?B?QmpRTUNMbnp0NkhiamhZOGgrK0Z5eCtLbEVJU2hoaGROalBWcXB1Rytscloy?=
 =?utf-8?B?Y3h5Nk40c0w1U1JhaVNOeHdjOTQxRlF4NHJoWnV2YTdqOC81cWU5aG5QOHZk?=
 =?utf-8?B?RTBWd0tHa0dRRVBCOUpKUFlwMFh5TCt6aGhlU2hvNFdqWlAwN0pISVlTckc5?=
 =?utf-8?B?SERQM2JCVklxMU1BcjQzTVJ5RmduczJxT3gwQ2VBZVRGbkthZlRqTDJYMjFv?=
 =?utf-8?B?K25xREZLQ051bkI5OFYzOFRBdy9ESXlUWlVCQlY2dkF0NEFHVHNXbnAvdEhN?=
 =?utf-8?B?aE9GMlArZHRiTy8zaFY2SmhPR2ZRU1UzbXR0aDA0MUt5Z2RVdlJRZkR6UGZu?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 91624f79-4ada-42d5-27d4-08dcacb6e744
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 14:34:34.4768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzLQWLiWon0A7LwpIkWmErkV78GmrtpePOoOdvLaZleLOKLlSDp4xFH9UL9qivPMYQI0La6GNpm6j142N/mzw64QLy4aNWkg3DWzZRuekbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9953
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Jul 2024 14:34:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16437

Hi Andrii,

On 7/25/24 4:29 PM, andrii.sosiuk via lists.openembedded.org wrote:
> You don't often get email from andrii.sosiuk=seco.com@lists.openembedded.org. Learn why this is important<https://aka.ms/LearnAboutSenderIdentification>
> Thanks for the reply!
> I have analyzed the issue further and created tests in bitbake/lib/bb/tests/fetch.py.
> The initial version in which I encountered this issue was 1.46.
> As the tests showed the issue exist in the 1.46 but the latest version does not have this issue.
> 
> I also found the commits that resolve the issue:
> 
>    *   b47ecab3e3aad5c5c376ec023aa82a51aa0f3b86

This one is present in 2.2+.

>    *   69588e2a5c7c200e47b02b2391498dcb72388bd2

This one in 2.8+.

Considering we still support Kirkstone which is based on 2.0 and that 
those two patches aren't seemingly backported, it'd make sense to me to 
backport those iff 1) kirkstone is impacted, 2) those two patches fix 
the issue on kirkstone.

> 
> I am unsure if version 1.46 is still supported and whether it makes sense to backport the fix to 1.46.
> 

No, not maintained anymore, c.f. https://wiki.yoctoproject.org/wiki/Releases

Cheers,
Quentin

