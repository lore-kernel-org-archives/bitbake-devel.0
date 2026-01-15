Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FE8D41153
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 09:55:32 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32186.1768470922822044269
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 01:55:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=MuGzgL/9;
 spf=pass (domain: cherry.de, ip: 52.101.69.44, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6xwdE3C4UbComVr8D0yYeQ4cUEckKbjcP9fMPQHIDaVOJC1HXXsuCGkM3tvXW9FQf74i6FCITth6yvhBMgP7TpCbc32ZN9HRdlb7LkVCPI0XvBie6qv5jFGfZDBsNcR/57pStrcPZcyM/Lzr3Q1Gt2TfrWtyiR/U7TW2FsuMsK3vLk0ORUhSt3GVpHrA5DlRL5knrj3xyidkFxDCIUVowfPI35gUuunObttrs7MbZrvHSGhH8UO5iPf6qpFhcU2eGHbh6tBQ6y9JAFDBPdgIMliSPzLEQoez5KMy77A+NFAXW4VfezCKczauOFZNZJOxqCgUo8Tc9TrbcjyX4oNDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXMhZcZj+QjGdIvoHx5X4lWQELDgewNCNOOFn8XSUS8=;
 b=Q1rhJ947cw/cMYLkCb9TYoMeju1IJ9wbsDVJJgcMJhaEJG1qzhI1qm3yraB0awxk+axIzlJFGfnowBhbHGRVyTwUkvBANGb+YqOWkOoPxxnII2hJeDCO1c8GfukCGPBR2kfk6O3LiC8JCyJIc/XdpcKDcWnrfAeYONU0iwnU7RYYHTe3nLOpl2QqlDCgQ3DQAhDei/hqteGKaFBmX5E5MS1XG6gxwV8amF6/+LIH80OT0Yj8weTIQvq3/dyq6VE25wMbszZLBRr9cZFU9V6rNUg+2qRC7cRo8H58mbwO2YfrZnwNYXCFcskN7L68BtMZc8F2DiBG9g36+9E+QAu6Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXMhZcZj+QjGdIvoHx5X4lWQELDgewNCNOOFn8XSUS8=;
 b=MuGzgL/9k1CAEV0gtpF5H1+9Nv+VnXpYyfEwTDjsqCzXOHKrCm9GpFTwPlMSLqGJIeFdChQ/oPFK6c3TK0KENZ7xWGwtSlJRamVTKxxGQhTK7ZlrfFMpVZrNlKT9llcQ9GcD8MSLt8hQbmcAcPAENveY1jroxAe+wgBnl0APtfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM9PR04MB8225.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 09:55:18 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 09:55:18 +0000
Message-ID: <d292b290-adc3-4680-a5e3-9842816ceb36@cherry.de>
Date: Thu, 15 Jan 2026 10:54:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v2] doc/releases.rst: add whinlatter, move
 walnascar to EOL
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20260109-update-releases-rst-v2-1-f4a92b7352e9@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260109-update-releases-rst-v2-1-f4a92b7352e9@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::7) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM9PR04MB8225:EE_
X-MS-Office365-Filtering-Correlation-Id: b43d7106-e137-454b-035d-08de541c3094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TjlvOG5MVmFUM0Rkd3E5b01kMVVxalFRVENQL3ZBaEpvbG5wRmM4MUZGUEt5?=
 =?utf-8?B?SnQyWDlyb0Y3VDV1SWM0Z0Mwa1M3ZzcvYzREazFiRnpvVEVRNmxnaDYzcDlT?=
 =?utf-8?B?ZXpjQWpvNEU0N3EvUllzaXZkMFRjY25ON2tIZldtN2ExcVV6MnZJd1ZhbHJI?=
 =?utf-8?B?TTJJMEJOZG1XMVBiWWJQNHN3ZEVMN3VmNFpzeDk2aVo2ODJKL2RyZi9kT2Nz?=
 =?utf-8?B?WFRGZGxqK0hLR3Z2NDRKZGdUdW5vUlhoR3NjT1Zpb24rRGVqVm01bHM1SlNx?=
 =?utf-8?B?VWR6MS9GdnJneTNQVGtwUVhURWxianBxSDhlTU5VZExLRmpyMXlseWpOTy9l?=
 =?utf-8?B?WGVjMkkzMEJpaHNUTjBGL3l3UGFTWFdJdWpaQUphSlNNUVZaT05vNHg0L1dV?=
 =?utf-8?B?Z2tFK2hHN0g1V3UxMjFDeVh0NnpsMVZVaWw2K3hIQzJjMXVaK2pzK2t0UkNo?=
 =?utf-8?B?S1VGTm9rVFdGNjRQdDVPbjZpajlHMjQrLzZibjQwZm5MZ0p6ZDNBa0ZLODRM?=
 =?utf-8?B?Qm52SXFuZkdFT3NodEVTcXRoOEdjNDY3clNEYXJackx2WnI1eGFCbUQzTEJY?=
 =?utf-8?B?MUUvdzR2REhCdzhpRFFtY1FCNFRtc2ZWOVJwVTkwYTcrZER3VDYzbHRreDBC?=
 =?utf-8?B?SXpBZUZVem5oSEJZWkU5Znp5d3hya0hxWjBXRFY0azZ6L2Jvc2RJK2tGWDdo?=
 =?utf-8?B?V1BSS2dqaS9tRHhUUVNacWM0OFZGTlpaVGU1OHhkRDFZZlAvTG9EYmFpNUt5?=
 =?utf-8?B?MVF3Njh4M3cvT0wxaTJrQlQrMTZwckxET2g2dkFNWWtyRSt1YlF1QVUwTkRu?=
 =?utf-8?B?RGlTVldWWDgxVUl0TFZEUG44Vm5LSlFiZ0Y3MFBRNTl6MDkvS2Z4Wjd0NlFR?=
 =?utf-8?B?L2Q0ZXRicnN6VERLNDlrV2tOZWVLdGVvN0F2eVZWc0wyeG5BQVQrcjZSYzI2?=
 =?utf-8?B?NEdkWHhtUytyeWhDUGhoT1J3NUthU3lmMU5HVVBBUnViQmFrckZleGY5akQz?=
 =?utf-8?B?bytlbG9uUzRMTitTM2lVRU45Y08wdER1cy84eDVlcFlZU0J1Y3lOdVpNTG5Y?=
 =?utf-8?B?bXh3L1hBN0hQTEkyTnUwZ3Z2a0FNbUdaaGxUSW5PNFFiODV1cGJOTnBXMzNZ?=
 =?utf-8?B?LzFFcjJnKzRrRy94R0pFaElqZlRWaTVoODBwQjRBN2JaOGozVEc3emIwOFhR?=
 =?utf-8?B?S09WNzl5T2RpOFp5TVpCVW9VRDdwMFNhVmliVVM2Z1NLcU1pNGk1a3Ntc25X?=
 =?utf-8?B?WWVoeno1dGpJcU8raUs1SDQvNFptSW9RckJPYWJmKzZiK0tpMW9JRFp4VTk5?=
 =?utf-8?B?TmR5WTA5Z2FPdzRKZ1dSaWx0eXJBZTJMdnhPeDdVSWlhRllkSHk4OTRFNDdU?=
 =?utf-8?B?bVVmNC85WXc2aVpySmtPeGVVOHFYWm81RStQT1dod1B4TXFUdStkRGFsNmVB?=
 =?utf-8?B?aDJ0UGVpZ0xSUCtQYkVWaXl1RmN6MmpGdWVlVXQ5TTNhYjlVNTFra3A0NWRU?=
 =?utf-8?B?Z2JXN2JuK0RDNXdRVzd6QjVKeG1UOGN0dUEzZDBLZ2NhY3A3S2xQaysxVG1j?=
 =?utf-8?B?V0JwT29PeEplOGxaUUlEY0dsNkF6bUIvY20yTFlQTzlTOEFlZndPdE5wbW5N?=
 =?utf-8?B?OFJqNjl1bFZOR2dFbmZ0M2tBQ05WSU5MWlg5cDkxMmVLWDJGcy96TUdQc2tt?=
 =?utf-8?B?Y253aWoxQUovb0traGxQRExOZ2RYa3hiVHlFaDA4RFBDd2hZODVFQVBWVlo0?=
 =?utf-8?B?ZWhZMGxQMk0zbCtHVUswdkIxRitjR0x6K3hYbHp6WExTVnFxUFNTS2pSS081?=
 =?utf-8?B?QWNpTGZzOWRrUFdJQ1AvR3BCU1g2WnlKTHJaT0cyWHg1TDhkTDNnQ0NuSlVM?=
 =?utf-8?B?dys0SC8rcklJZGZiT3dkaGZrZzkrMlovTzFRTWt6ckpIaGNPK1lhS1JieFlF?=
 =?utf-8?B?SkJFR3lLU2gyU0xYM09UZ29wVnBKNGk5SWR4Rm5EREE0Rkc3c0s5SUFqWG01?=
 =?utf-8?B?ZTMwSUZSb2JlSFE0ekV3cVFlRlN4VlpIL2JzV0NYSXBhelIrbkw3NUZ4SVNT?=
 =?utf-8?B?dlZZVmxzdVdwZVBReHFVQlZWNXArcGtOZTRMZElaSFNmQzdwRFl1d3FvUUJo?=
 =?utf-8?Q?Fo2k=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WlhHVzlSM2NJSElJQXJtcUZtdjhhVkwzUEhzRUVjcVRUWEN0Q1ZGY3gvcUVt?=
 =?utf-8?B?ZXRXZkdFQ1BYWWYvcVM2emdrMWRXOFRWL3hjUTdWc3RXZVhVRlZsSHhqVmFF?=
 =?utf-8?B?RFB3Q0Y3QmFyOXlFQ2FxWXJQdGtjdStSTzhlbTZPSDdEZkZSTlpzaVozMDVh?=
 =?utf-8?B?ZktJK3JRaUJTb2E2UXF2dlVNYnpVaksrLzg5MmtDVUFJSXM2Q0ZyckZLM0sw?=
 =?utf-8?B?VU93aUJSaXBrYlNzR0d2eWgrS1psY2hMZnBJcW5XYWxOZzRiN01zN1A0VDE0?=
 =?utf-8?B?ZlZVZFRlMWtPSkY3QmRxUThMQnFIRE1EVE11cFovR0hkZGxBc2ZpL1FZcFV1?=
 =?utf-8?B?cGZEYVZqL1J1U0cxZzdQeHNtWjV1Q1BGU2ZURHplUkxjc28vR29kQUNSMnNJ?=
 =?utf-8?B?MUp0Z2FOSGl5VkV5T1o0ZXdHTEJqellMNmozb3c3Vm9FTkZTZTB3TVAwaUFJ?=
 =?utf-8?B?ZzFyWldOMlFSUzVjU2xHdVN3S3d1N2poZVBZQWVFMHNHQU8wVzFWL3dZL0No?=
 =?utf-8?B?bDRUeExWMjhFVGlNZ1ZXUm1RL2VScnpUMFRQSy80VWxoaTA4R2ZkRERLcmox?=
 =?utf-8?B?aElUQnRHcDg4SEZBb1Y0b0RQdEVpbndLa0REVzNYYjBoc2w2NFFHa3Y4Q2xQ?=
 =?utf-8?B?aEFTVFIyeTRBZmlQVHBncDNaUWJhOHZsTWk5aFBhcFJLamVrZHZFTk9Bd1No?=
 =?utf-8?B?dUNlVE1WMnIwcGlDUVZVbWljM0JUOE96bllNZitMVHgrY2h3cWlNckIzQitT?=
 =?utf-8?B?R1lzclcrN21qd3dJdHBDYWhuVmlFRFpGbldxVHp0V0UySnVoNk51bFBCRmZ4?=
 =?utf-8?B?RW40WmNZZXhsY2MzWTR2aVdQK3Z1RmtGYklORkhFcEVQNE1nbWtCRkJLakV2?=
 =?utf-8?B?cnZDL0JxTWlmdkhDNTQzMVJHeVp5WnZiVnBrMHJvVEJlQXEza29LVlQrNkhP?=
 =?utf-8?B?aEJxa1VDR2N3Q0U4c0dVeEt6U3Q4b01WY29yUCswVHV1cXlCSGNMQ0dEMHE3?=
 =?utf-8?B?di9YYU9qSUZXU3EvOW1oU1k3STA4NXNEZjdHVTZRNm1BWkMxYlBlQlFJSkRa?=
 =?utf-8?B?NXdFSkZrMGZhbEI3L3hKYmZLYTFvYmkxQnR5RDlnZlJNYW1DNzEyRUZxNnly?=
 =?utf-8?B?YWwzSEt1ZTM4ekJnUHZQamFPd0ZORTV2L3Y2SjI1dVc0VVBtS2lpc0ZDVXln?=
 =?utf-8?B?VDRQV0tXZXZGNEZ5Y2pIZkZ5MVhTS1pYMHlsNDBVdmZ3b1M4RUcwRE5CenUw?=
 =?utf-8?B?Q2ZKSkFXWjhPZytpNDdaZkw2L1kvUlJHS0ZldFR3S3lWTndCZzlyL2VHU2Fz?=
 =?utf-8?B?dk0vOXQ2RlRlOFltditaQlYyRm9qSGk5ZnJQMFlxeXF1S0syeVNBNlhiZ2Fa?=
 =?utf-8?B?NWl3TDlRcGRxSHhwZWVxRzMzNE16cGQzWW5sSEt4L0wyeDZDV20yVnMycGc5?=
 =?utf-8?B?VjhDZWlIdXRvSmh5YzZvU2M0aTlhM0F4WHRzSThUSThNeWpDblA5QkVrZmhF?=
 =?utf-8?B?MlgwdHJURUlDbGxCMXJpbzVjU2hVbFREclFmR21vVGx1aTVQalVwSFd1TFR0?=
 =?utf-8?B?L2xWV3BJSHVpZzFrQ3g5ZU5MYSs4NDRnTFZYT2EyTWlyZkZ6WS9CMnp6bmgy?=
 =?utf-8?B?LzgyZGJ0S05raXVCZWNBaWhVNDA2OWRoRFMxWXlzc0xnd0tBSEk4YkxtV3E0?=
 =?utf-8?B?bmNaaWtDZkVQOGorUlZVV1ZuMDNPYlFHMDVBM25jYzBjK29YVWYwWDBkTGdV?=
 =?utf-8?B?c0NxWE42N0xRSml5elJYZVBEZExPRnFJSGFvQlpTOWZBYVk3NWpoMXUyN0Np?=
 =?utf-8?B?Sm1WMkpvbkVkVk45ZTVQaFdMUnRqM3c0b2tDNXVDb3JKaFhISGgxeCtDWWhC?=
 =?utf-8?B?ZTU3MTRNTEc1d3RTZk8rTGhnNjJid3ZMR1BEekhod3JiVTIzT1puVGJwL0Jv?=
 =?utf-8?B?cU11NEh0Q2ExUlJucXJETi92N2llS0N3MXh6OW9YV1YvalR0R1FKRmEyRzVr?=
 =?utf-8?B?enFod2d2cTNPVm9LcitveERkWGFCUmRYSC8zZ0U0VzR4QmhrT3MvVTVXMlI0?=
 =?utf-8?B?amhWMStjRW1rWkluOGNKdXloNEhVemxPR3djYlh4QWZtOVpQZjNJTFpYUi92?=
 =?utf-8?B?N0lmV01UeTZYMnVvSDlvczMvc3NMcTVrQ2FKUnlRai91L0dMOFRaWThLb25r?=
 =?utf-8?B?RUd1Wk8yUmpqbjBVbnRFM2xaTnp6M2E2VWdzSjFCZ3BDTXZ1U1ZLNVhxRkxs?=
 =?utf-8?B?MDJJeGpPaDVFNnR3QmlURnVKamZsMGVRd0s4eEpUcVQxcVArTVBlaTg2L0Zj?=
 =?utf-8?B?Rm56ZXB4a1h2N2ZNZW1Sbys1a0pYK2xEVEVDbmNlNWp4dk5rQmJJQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b43d7106-e137-454b-035d-08de541c3094
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 09:55:18.5566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTMNomCexsKA0xTkqU3BFIk3dgJKgExyRS6uyHC13hI9u/PziB7AJdCRmBrJHVG9gGiMiUz2W7RsLN3Zpd8u9fCFqSSYs+WJd+4tBeA5Xkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8225
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 09:55:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18770

Hi Antonin,

On 1/9/26 9:59 AM, Antonin Godard via lists.openembedded.org wrote:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

