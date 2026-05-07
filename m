Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE10CD343F
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 13:48:32 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.36])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12350.1778161704408076001
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 May 2026 06:48:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=WIev4H47;
 spf=pass (domain: cherry.de, ip: 40.107.130.36, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/NfFIrZCxa6lCvk9l6Bnt/GZttEnhX8TYRQchk/l5y3LK0uiBPoJuq+0a5NcD1274grEnc5P89waFCdWDnpd68aGtAsDp21dEynMgMpTZ8OzP9ZtjsQ6d05p9l/U7VIEjnPuzOIMX4FkrwcooKNBCI8rYWj5GrLIiuAv8+itHRCbAxmjChPJAzSimkUCPrdBILPrLJyT2k8g0juinDl1O8GOgzC/WWVKEGYOu/+IJk5MmgBLRpPZUmExkmVPDTkZLIJzOWlCfUVcEMbPzY92pVuzmSmgjdQcMcIkdUk70z6F4RhZ9D18xxpXe2f+nx83fxTxgJ703AdqPem39Xffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRKhgie9WYJcld/u2Y9XQ0BFX8Kc9yAqDpjtcE6dWYY=;
 b=D+bFhjJQRmT3YqRQ+pAbihDpNV5EZR1CbdJWWBa52xSYnZytlo8ACsyBtWgps6wnqCXFK9iDqiW9kqg9Y0wZNr/pwE78FX49U3hwY3Ii0TCySiRG3sxbvImMTC+9J7Sup+Fl8vNrpRRrxv6SU/zAEZeQfdRijHDwuKReoOlwIydX3Ft9a6DjbmfDn3DDosDa9zYKTMhReGZeQ3K7bs7YzmscbnNr96yPB+PFPp/xgg14y5Ipi8pUkRnR4DF19wk7232ypQ1iiG4WN+nPeYSLrImZg3al1Ny5Yau0SGgVx9t1n18qqx5T7uryjUA76SiOz7vDpzDz0ThJTCzNWjHrGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRKhgie9WYJcld/u2Y9XQ0BFX8Kc9yAqDpjtcE6dWYY=;
 b=WIev4H47uzCbtEaaItK9uxBHPmHX85047T+7PwqXaaU3TMCIqYHJPd8vakB4/YOpR4EzUf2VuVKPTDf9ZgsrKBQXLoKudfsvTfEX+cjeU5bTWKLzQIUw2CC5mb0voALAl094Osmd7lKHm97crmBg492yPk5gxt1KUacIveiQevk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM7PR04MB7189.eurprd04.prod.outlook.com (2603:10a6:20b:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 13:48:20 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%3]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 13:48:20 +0000
Message-ID: <aff89f3f-7bc6-4634-b834-1872d559c8e0@cherry.de>
Date: Thu, 7 May 2026 15:48:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] doc: bitbake-user-manual-metadata: remove
 incorrect claim
To: Dawid Bijak <bijak.dawid@gmail.com>, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org, richard.purdie@linuxfoundation.org
References: <20260501091418.76994-1-bijak.dawid@gmail.com>
 <20260501091418.76994-2-bijak.dawid@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260501091418.76994-2-bijak.dawid@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0190.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::8) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM7PR04MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: f5daba82-7780-4ff3-ada6-08deac3f4cc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	Y8lnkSwFJZdtzY/H7WXmgLK/ZuJ4Kny7XWs8FQ4YM/lDXHN+AJD0wHyET+sbBSjMJCEvWZIi2mbgS7gOfsICA316SgVchbGLcQF0xnlvCyQkZ7BnrhoHT/OTXluxi/+lCS2vMprLmbYHZCVu7qXt2QBy/zE9wNGPBSgEzSisWn+SIj6emrJ+W/IL/NePxptcHc5119J7u3F15JDWpAl4zS88DnMi00VY8RawqLTKCM/vBH4/D/eH5oiERv3UCkuJt7aVp9Mi4gNXDGhNMaJ1BFDUMZxKMN2JPfildu9qH7XV9b9Me0LsOdqPLM9oTgFOFe3Gi2614pbU0iv4CzPXdP0xpRtHOVZ2z5LV/aOZ9EzpJPuxMp01gfGXUB743ZaFb1WZIJ0qbCSKNlBcC36JeBRHWPAWEoVkduwE8qogjRag0G0/H6Wi3fOFjh0KnRnziazjrPvFGNtIGVa+hWBughp+4R6oMsPjie/XDmr4hwvmKj3O4IaMLotPZ4Z/ujP9DaeUjF+X37Vrlxg53+B5BjErRWglY+FBZwDN4fteUD/pgNVI77pbt98/8WY2IHcqv7DlsFM+PyFgP36GTlKvCRcp6OKA2hjEyyDX2iwYS8vmXrRY5lgSzK0DXvorqG60/FNtWpKJg4GVgNhVaG90ia/lmjl+O45rVMcExXEBRGMRaup88IOkaFN4qcqIVEwV
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7737.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MmZSa0JwVGpRWm81eVV6TmZXNkNvZ00rbHpDaHhoWjhQMmtMaXRnVUVSSThZ?=
 =?utf-8?B?b3hZSEkyR2hUU2gwT2ZYc1BYbTlqQ3I5b2QxVXFWcFNtVklqTzloOVd1TkZ3?=
 =?utf-8?B?dzhma1QxbGovVVNORTY1S0tMUWI1cEVWQmF5L01TY1p6UXAyczZZdDF5N2lj?=
 =?utf-8?B?UGpoMHUxdEF2djRhaTl1cVNLSWhNbFRseVN6SXBneGk4WTdURUd6Tm1HZTE5?=
 =?utf-8?B?cW9ESDNCQkwrSXhxRkNTNFNQbFVLeGt6OGJhYlM5ci9kU3BXMldmZW1oekNz?=
 =?utf-8?B?VU8yL3I1TWFVY0FHb0duQTVJdnIyNkJsemFLUXZLV0tiYktTNnJMeFRhYURa?=
 =?utf-8?B?S0FIdHlQazQzTFRvNG9GcDNCbVhKQURwcURXWHBpS2g3UzVLOWIwOGdDc0J4?=
 =?utf-8?B?RWZQMkpodlo4dnpqeDd4VnBGc3IvVGh2UjN5ekxVeWZ5S2JYQ0VqRG02VENQ?=
 =?utf-8?B?L1dSUUQwRzRXYU1rcGdwY0ZCWUcrNXBtVmxtUzVWNitrQi8waTJ6NDIrZjBR?=
 =?utf-8?B?TVZETDFsSGNMMjdHZ3gzOEg5QmN4MjltUFl5cEkxVXkzbFJ3VjJHV3haSWdk?=
 =?utf-8?B?TnQyWVVsL2JjY0x4aTJoelAzN3ZDTzR5b3JHWlFxR3lEM0tZa25ubjQ1Qmo4?=
 =?utf-8?B?WFNzaFZiOG9hY3ZxSS9xSDRmcGFvdGliWjBPU25HUXJGUG9VU0I3TE9peUNF?=
 =?utf-8?B?Z2t2VlVseloxeElFN3l6Y0pyYkVGVjlBclJsUWFTUFVaMnl2djBlRDdVTC9P?=
 =?utf-8?B?R2w1Vk9UVDJZYVRmMmZSeTVJL0Mya0dLNzVjMHI4MTFYZEJaL1FudXJLQjBZ?=
 =?utf-8?B?M2dkcDdRVUNMdzk1UVlXRFFjd3BJWEIxUTF5ektWcG8zZk1uQXo5eW8wUXJq?=
 =?utf-8?B?dEtOakdDTE8xOXNDSCtIWU9OaFJIczhTSmxXS1FjUWIyS1VoS0Z1eGdtQ1lh?=
 =?utf-8?B?Y3drcjRQTGt1VnF6MmNTcC92b1o4U2EzVkFBK3hxd1dXY2JFMENpR2o4WkIv?=
 =?utf-8?B?QVU0SC9MZERWeUZVWHVabklCcEc2OWZNL1Q0NFlhM1RGOGVZWTFFMWZnWnFJ?=
 =?utf-8?B?Y0RvalVkRng2WjdaQVVuWkllNXlMSUdmN1VHMjhMQ2xRT3pINm1zbGExN0ZL?=
 =?utf-8?B?OFNmaWJ5TVhMVG1EdWtrV0NKMHBRVkRUMVQxcWkwTnpQV1ZjT0YyR2t4amdH?=
 =?utf-8?B?TDMxbjhEdWNUaWpRemxWa3BpZEZjcjBxS2t4VExpd1lDUHEwZjFlaVNLNTlV?=
 =?utf-8?B?dHEwakFCOEFJaGJRaTdhL3VRcWExODR3MzBTbW05WjIwYXlKRzFicUtUejZL?=
 =?utf-8?B?MlFNNkpUeGhLOTVQWVhuSkJHNEZTNnRsTDBSZ2gyNlZqYmx6azhWQXI5V1Bp?=
 =?utf-8?B?NnJpVmI2UnVJaXgwTTQvbGRxakdnZDVpbnNocGpacFVaTzdwWGh4NGJMaVM1?=
 =?utf-8?B?VXFscmdxajl1S2JKT3JlQ1VlNkJBVDNvT2Q2T3phbkllMTF3SEtua0VqaXJ3?=
 =?utf-8?B?bHFpNEJ2amx2bHVLeno3cTFCd2N0MlRWN0hTam9iZGJCK0E4aU1MOVlHQ3RV?=
 =?utf-8?B?dUFzWmdLcytFMkhqVnFmTjF4TmV0c3RRYWFtU0ZxdXFpelI0ZHA3aXo5MVFB?=
 =?utf-8?B?UjRrYUdRSnk3OW0vWVNLZkx6cm5FYUUzT0FjejJBdVdUTFRia0pNMU1KTXQ4?=
 =?utf-8?B?R2xFNURYemtkYTIvWTVxS0VWcHA5ZWZtYTVubDN1WlIyNFplcmMxNS9CcHZZ?=
 =?utf-8?B?QmMxTU5UclVLNnd1aUlBS0grakE2UFpvNHNYSWRJM2FCZ00zbmpzcFYxUzFu?=
 =?utf-8?B?S093amtJYWJ0UnMxVlNQbTNacFVweHpWK3E2d0ZIU0YzVUlTZVBwckZ1bEZQ?=
 =?utf-8?B?STNlcWZJSXF6dnM2TTVnaHpTZXk3U3FQQkpjU2h6bjl3bDhTN2FjT1dDcCtI?=
 =?utf-8?B?bzZka2hMKzE5Qk1ZTGtkNVNEek5qUkFmMThHMkxMeHllSC9FYVJ0VkRCT3NZ?=
 =?utf-8?B?elNxMjVnNUZKbG02M2FiTzBFWlp0N20wZnEzZy94SEk4dlIxZXdISWlGTVQy?=
 =?utf-8?B?a3RhalBkVWNzZWZoRkVHR2cyTFB6cndUU21tL2RjTG1HNDFaR0Y0c1NXd1U3?=
 =?utf-8?B?YVVHZThKdzJ1aFdrUUxYU1B2Z2JXSUJLNm95QVJ5bkdwWWcvbHU0bWVoUktP?=
 =?utf-8?B?Sm5KV0toRHp0MHVXUmY3Vng3SnEvQ3lzMFhnTW1NWXhCaXdVNmtsZW1id1dN?=
 =?utf-8?B?UUVzSi80NG0ySmV1SFFkdDJmekNqT0tsYlUwR3FLWGZ6WWZhTE1ReHF6dWFQ?=
 =?utf-8?B?UWdDaTQzMDIvb3oyWG1RMmkyaWRlTGN4cGJpdXZ4UzV2djZ3Y1ZvZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f5daba82-7780-4ff3-ada6-08deac3f4cc1
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 13:48:20.5656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjVyvgTowRs5x95tKQg7DTyltp6yjt0kIzgUny0HCzt4uAZYpi+Ox48No9pNCymcaVn27hs9m/rRbZ6b64uz2ZR2D5rSelzyF3cOL06ZsSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7189
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 May 2026 13:48:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19462

Hi Dawid,

On 5/1/26 11:14 AM, Dawid Bijak wrote:
> The documentation for inherit_defer contained the claim
> "If VARNAME is going to be set, it needs to be set before the
> inherit_defer statement is parsed"
> which is incorrect and contradicts the purpose of inherit_defer.
> 
> Drop the incorrect statement.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

