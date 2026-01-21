Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEF8C44501
	for <webhook@archiver.kernel.org>; Wed, 21 Jan 2026 09:48:10 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.69])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8264.1768988885421494089
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Jan 2026 01:48:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=m1c0gojH;
 spf=pass (domain: cherry.de, ip: 52.101.84.69, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVCRMmTv9nRHoRrvXQ+k3pZDqmDveDJRaOVOKSMnYI7MbVroMAC1JaRwRtC2hyv15FzCH2h/uEL8dsmNQJX/ec8yHuAgjK1bxUKnM85D8pvoI30mW2qC8hufkYK/koCTcOX5i0UtH4WYha0L97MpMvX+87IcPh7wZ3enCZcEerTDkHSXFqKJw4Vr7ipmYrJ9BpQ7TrfYK9WHHnKGYmAXvhungpqfqejVSIjNQyZfLBBOgwGaFfbWzgUc5GPgt2UPoKsTj4V2GGvkBhip/I3iRGBpHO/N+gYGX6ZaHbH3846sAwETjRxV41Eg6qIhtxCtiO8WknyrBBne2PFARXCREQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRisgNjD9iSExGjXLKdNPbvnH668/SzX+Toxc5PtURE=;
 b=oQFPwTTodYlbuxqSeynneIku+1lH1MenRNFGImQP4aKVUTCrJB5nwon5nqYGbIfgEeN71KQSldkrOBd6Uv9bMC54gbaoasq4rihM3oFVeen14mMSDMRqmFl2WXBK3JWmtgSWXjiUYydP8MeCT77ElXw+++j+HaPjAGlPjxpJuiBX4ljGHXp2Pl8nZAuNnyzMfTl6C0kC9QyvEpfMZ6BQCPH5i6xUOruSAsewv58URaQ95kV6RcSPmmXIk/o8ISbuAseZKuyjpXDTmThUI/QFKKN++LQEx/ASqhIaCHkM6CW0lZ44BJH4zhUcjqfhFcd3qH76YlvrYV6OjfUvSGxrog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRisgNjD9iSExGjXLKdNPbvnH668/SzX+Toxc5PtURE=;
 b=m1c0gojH7ze4FbXuvy5ED0tj64lDTmYyE2+BXLU9ZYpupXr8+ae1CCUk7UB/Fbl4JzSwhYyVzjN5Bah7LszXSu72gmnXbIDx9/u1jrziGoxaaxkMwx1Rz5QQ9gcTbY8DrNUEVN88eX1inFZZjtj0N4h7um4oRpwCtay/UFV5TFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI0PR04MB10256.eurprd04.prod.outlook.com (2603:10a6:800:241::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 09:47:57 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 09:47:57 +0000
Message-ID: <2bc49581-757e-4fe2-91ad-3f5c693fe7d3@cherry.de>
Date: Wed, 21 Jan 2026 10:47:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 4/5] Add Python packaging files
To: rob.woolley@windriver.com, bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
References: <20260121024723.2634264-1-rob.woolley@windriver.com>
 <20260121024723.2634264-5-rob.woolley@windriver.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260121024723.2634264-5-rob.woolley@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI0PR04MB10256:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e88780e-f896-4b80-6c8f-08de58d2284f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UEdBQ2pQVlJHTjM4dU9VMk9kL0RiT3BnblJwaGpxTFl2aXhBbVdrR0ZpQXJK?=
 =?utf-8?B?TThRSEh2bGplMG5USDdIRkJIRi9icWNTK2FRNklTcm9HamVCbTlOU1NYRWhU?=
 =?utf-8?B?d0xDMEdCRXA1NkFkSmY1b04wMWVVVnFBQ0ZIUUNkRGVPNS9RdmJjbVFIR3dT?=
 =?utf-8?B?WHd3QlB3S010VzNTSmJCOWY1OHNvY1Yza2dZUUdCUWhJcElmOHhVSjRjV0VY?=
 =?utf-8?B?bkVoamMvZExzR1RLcGh5aFMzcTJla1l4TkpaOUpvRDhTclRTc1JObnU5SC9L?=
 =?utf-8?B?YTlpYSt5Vlc5VGJsd3YzS1c4MHQvb1BjT3pvQjNxZ1FvTGY1RkZFblpyTE1Y?=
 =?utf-8?B?SXVDWkU2WTJoUEJVd0VFenB2eVVkc0NYN1FBNmhkSUF6ajRabURHSURBcGQv?=
 =?utf-8?B?eXhzNUFCbUUxTGswNUsvUWJaOWJ4Yk50emZsYVphemE3VFl2SlB1Tko0MHJh?=
 =?utf-8?B?YjJGeGQvZmhyQm9ncGRxUmFWSlNWdWtrMzZlenpqMHViRzFDM2hDMkxiTVFV?=
 =?utf-8?B?WnVFQXRRMElrSVdobG13VU8wY1MxM1ZWZXVPVDNuYmNwWWpaMXFaSnh1TEI4?=
 =?utf-8?B?Nm5xVXIyRTE1cVYxeTNtRXEvL3N1R0FvZ3VWczIyVUFNQndsUzQwU2YreGVJ?=
 =?utf-8?B?K0RzL0g0T1JHQWduSEhYdmh2UDZQUkNJZzBTVHR4TGNib09ZY2psajdHUExj?=
 =?utf-8?B?OEt3eTFRTEo3dUNrcjJjQjdGenJjdGs4RUFkcmlqZFZVTkI4NW9QZ2g4Mkty?=
 =?utf-8?B?VFZTY2IycDcvWVpaak5QVEpzeW1nMlA5M0FpSG1wTEs1QjdEYzRJV3BnRVJG?=
 =?utf-8?B?UjNqS1dhaHdJa1oyU3FrbHNHQ2I2U2JReWNBN1RveDZZY01qQVhaNWlrN2oz?=
 =?utf-8?B?RTBiRlBYL2NXU0ErZEYrTnEyWGNsRll4eWpEYVpJbEpSd1RKZ05ueVFERjYy?=
 =?utf-8?B?RzI1SXAwZ1dxUGRWTUVqbW1nQnRBY01JclZiRllLaTBteU5MdnVET3FxMUNi?=
 =?utf-8?B?WjJtZzBPeWxmdDJwS1ZibXoyeXhsU0xlMEY1eXozZFd2WkRhZi9XLzBJa0k4?=
 =?utf-8?B?YkQ5Um9sekQ3OTB0NW53MnRsK21MZWNQdHphbExvS1hNc0VIdHJmRXcwRFBl?=
 =?utf-8?B?dFNoSHU5aTRrVjh5d2lNNDVYdTFVSFVMWnRlZkNERjhET0c5ay9pOVlPR3JK?=
 =?utf-8?B?TCt3RVU2UlcwaEs2eWdMQlJ0ejEwaTR5VVVablFGb0ZaVmlYVW5CT3ozZy94?=
 =?utf-8?B?TXo0MTArMzdXa2ljc21ENXFNVzhHS29IZG1VR1hTKytaZ0VsM21lUjhPMis1?=
 =?utf-8?B?V2ZiV0VnLzZpWG90Y0JkWGZnYVVKVnNZTEJwdFNyYUQ1b2tLdFZmekp3cDhB?=
 =?utf-8?B?NURLeVJLNmtEbThGSk53OUlaRTU1N0paUFlXVXBQMW9rdHFienpQL21HS2Nm?=
 =?utf-8?B?QWRFRWdpL1ZCTEpzeTE4VVZUSkhnT2ptbG51MEQ1eE82d0o1QUtXcHJOdk1F?=
 =?utf-8?B?cWN1a25FUHFWbVB1bUx6YVJwZ1BQMUlBNmlHZVRQbmYxVUVCd0ZMWDNOcWZy?=
 =?utf-8?B?d2FjMVYrcU54eHBLUGI1LzNXenJGenhDUmZQVzlCMjVpR3NLdTRNR21tL0Y1?=
 =?utf-8?B?c01ucWVWcXJYMzFkYkxKRXM1ak1zWnZ1RTRkT3lwQ3hMNlVhNVdRejRWY25i?=
 =?utf-8?B?Qk9LWXgwa3NPS3BXUkUxV0NGTkFySmlJTTVmbzd1QXkxQkNsNVNTcEpvbVE5?=
 =?utf-8?B?WGRDTEhmcUhFeWNpai9TcGsxaHRHRFp5cm5UNkxxd1orWkRwOVRJTXdEUSts?=
 =?utf-8?B?WE9Ka1dXVEZFdjZzdWxTTHVYbndPZ25veHBiUlVNbkY2ckY4U2NUa2NOS2p2?=
 =?utf-8?B?SWlNV3BDOU9DU3dHRll4Lzljb3VwanNKSGtQdkREc0wyeS9wcEsyS3E2ZnhG?=
 =?utf-8?B?QzRocS9Ya2xzWGhIKzYyRmhtWnJIVXB4UGRJeGQ2SW5IYzhacG5WdjhpbC9G?=
 =?utf-8?B?M3B0c0k2WmhEK3FTNHdmblFYbjZxUDhWVlNJTmhzbXN3TkRlR3ZBSlZuRFZV?=
 =?utf-8?Q?rK/S/+?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VUNoam1UNzFGcWtBaDVYS2V0d0NnaUozUjhLdkJSUDFjSEhUZHlmMGQ0TXNu?=
 =?utf-8?B?bkhFcmZZQjlWZk1MQldFSWlSUEh3Y2dQU3JLTVVLM2tGeGNxaWdVZWJ0aStn?=
 =?utf-8?B?WXl1UE1FaTNuTm80MzcrQXVRODVnWG1rcFNlamZRc0cxR293UzBKbW1uSDVT?=
 =?utf-8?B?aTBHOEtPTWd6Tk9lS2M3S1JTR0J5NElybmtzanErNWpDSmQ3aWJVanZhdWdZ?=
 =?utf-8?B?TGhmSFN5L0ovMmgwOU43UnF6dGg0Nm1XQ0o1aUQyVlY5OG9aczlRNy9YcW5t?=
 =?utf-8?B?VUhzSjdlSzdZNlQ2eU94eitsM0VSN1hsRkJxSGtaVzkrLzI2UXRXNk9OdTkz?=
 =?utf-8?B?dEEzalZjWWhOMVJKWDZITHp6UGRDMDhxdm1wOSsvcHZYcmNKRFZxTVoyNkp4?=
 =?utf-8?B?b1BldXVhK2ZyTlFrNm4xTEZuWEx3Yy9vQ0gwL0FOcThzaENCdGtsUWJobXFq?=
 =?utf-8?B?d044QWtDbjFJYWV1QU5jMjBsR2hSUEpnUkN6cFhFbU53RXBUZFk1eE5iTllo?=
 =?utf-8?B?T051TkkwWXJEVDNwMG41QjJtaTVCOUtLN3dqMTBhOEZlZC9VT0I5a2puWENw?=
 =?utf-8?B?UEd4QitCNXQ0R080bUUySzU1cm5sMEt2Q041T1IzSlhDdFhlZ2JUQ0J3RE9w?=
 =?utf-8?B?RUhpZmlTNFBONFREcUtFSmRGT0hBcjh4SWN6YXVXcHYvWmgwMkxBS3NBL1ND?=
 =?utf-8?B?Q25HVi95VVVMQWZZRlFhdXRsVG4xVkwvd29yL2kvRHNsLzc5VjZSa0U1U3Qz?=
 =?utf-8?B?OFh5RmlvbU9QczhUK3VjVVRvZUhORUZsaTVCb2J1R0NsYWhZMG56MkJuSnNE?=
 =?utf-8?B?REcvMTIxTVhkeUNRNmtvcFhEVXYxclJOc2Z1QXBFQ2d2c0s3eE1oc29FZmwr?=
 =?utf-8?B?Sno0VGFabzFleUxmMktNVjRIWnpPZWdORnZldHluQU1VKzdSRHd4T0E1S0hq?=
 =?utf-8?B?UHNzV3F0ZEIzU05DK3RYS0lJRW1WeXB2RFpEVzNvNzc3RE1lclMyM2xsQjZ4?=
 =?utf-8?B?aklzbXBmV3kvMmdjVjg4Tk95Wk02NXZLSForOWVkWExtVGg4dDZvV1hTa3NY?=
 =?utf-8?B?MmowbFR3NExySElzMTMzUk1KT2V5VGFvSGNOOHlrZjlxd3NlTnFIYWF6c2VU?=
 =?utf-8?B?R3JjNFkxWWZSakx2ZTlaSDZpZGJreEl6MVczZmVFWE9xTG5MWWV3akErQktH?=
 =?utf-8?B?bUUyS0R1YXgzMUFUWTBjbGNMVHVkNUx5TUV0Q1ZyQWlFK1UwMGJNSjQzU2ZU?=
 =?utf-8?B?WGtvSEc3T1dJMnNmSllLZkhQemNCQ2x3Um44NVBWdzZGQXdHcWFIMUltVnBq?=
 =?utf-8?B?Qys5WW5UenZUdjFwUUFPT3VMU2FXNHg1RFJ2K0U3clY1N3BzK25sWWlNTXFI?=
 =?utf-8?B?Z1hNcEdMS1ZYeVhLUHdPUHFHTTc5czZSU1dMcjRoTTBDbll6ZzNjME9tV2F1?=
 =?utf-8?B?d2d3dzZaWWlmWmthMWkvZngxbjVla1BKL0lybC84Rlk0ZHJvcExVSHFZRytP?=
 =?utf-8?B?NGpsQnYzcVlHYVZkaWFPV1JDcXVOOEM5K2pjSDU2STNyM2RKTGtCZ3dwUG11?=
 =?utf-8?B?Sk9ta3VwLzBIQzg3Wkt4VFdubnZQVWdaZ0dJbEtBME4zeDZ2WlRORlFxWDhI?=
 =?utf-8?B?RlpYeUFtZmcvMEl5R3RIODdDYzN5QUcyeXhXaVNGOTBjV0ZFbnNVdGN3VXdq?=
 =?utf-8?B?akROR0pJTVNiSDB5TFVQbkozMmxyK1ZzSmhvOEhQK244YU4wSHUxb2d4aDFr?=
 =?utf-8?B?UjFhUmxMYjZyVnhhVUtuait3ZFB4cTlZNG5VMzd1L1RGVUFITW1TdGFXbFlX?=
 =?utf-8?B?YmltZ1ZMNG5zS3RVc0phRVJQUHZLSm84TmJyQVcvRFBqSFk4c0k5eFlvOWdB?=
 =?utf-8?B?a1U2Skt4dHY3RDJIOHArQlplbTAyMytRNFFQZkNKY3B4OG85WUxZVXJranF6?=
 =?utf-8?B?RWxvL05aVmtGVkt2UjVLVUtTTmk2TWJUNFJQSGtpNjd4bDhHNTVlZUpUbDdy?=
 =?utf-8?B?YUMrbUFjVVZXRTFFc2JlNER1N2JiT0xuL1ZOL3F3VHV6YXlUZlVZUFVNUHo4?=
 =?utf-8?B?aVdnUHFJQyt0SnFJVS9LRXFueHdRTkdJSHpQTXdRVlpjWVZMaiswMWhXeVZE?=
 =?utf-8?B?VHhPcnJZU3A1RWxnTEcrVWZnb21JSWJSNWVWRjRGS2M2L2NkZmFKZEduVWYv?=
 =?utf-8?B?RHczVFloZmhkUVZrS2pKVFlUWTZ1WitHb0VuUGZ5WFdmYll1YTRucUR0b2Nj?=
 =?utf-8?B?MDBnV1RNNW1UT3hVV0Qxbm8zYWFaRnF5cVVGTzZUYkJmcEo5Y0U1ZmFVM09l?=
 =?utf-8?B?eHdXSVBFY3lMREVuYzNWeXFOcHN1YUs1UFJhUkEwckliSDlhSko0dllYVlhC?=
 =?utf-8?Q?o5bQPVcdzQhHjDajupI69TXjmMMwncKGht6Ej?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e88780e-f896-4b80-6c8f-08de58d2284f
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 09:47:57.6758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILNp2oUWd4OPsTriJdvi+twWnkWp2DLwpqt4xXReE/OK2QvZnzr7FjBCtNqaxkDZQoLPI6C+lHGeprO0EGXi3j8MPiQ7eB7eLv7oS5L61eA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10256
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 21 Jan 2026 09:48:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18834

Hi Rob,

On 1/21/26 3:47 AM, Rob Woolley via lists.openembedded.org wrote:
> This enables creating a pip package for PyPI with:
> 
>      python3 -m build
> 
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
> ---
>   pyproject.toml |  3 +++
>   setup.cfg      | 40 ++++++++++++++++++++++++++++++++++++++++

Please migrate everything in setup.cfg into pyproject.toml, there's no 
reason to use an ancient mechanism. (This may require a more recent 
setuptools)

>   2 files changed, 43 insertions(+)
>   create mode 100644 pyproject.toml
>   create mode 100644 setup.cfg
> 
> diff --git a/pyproject.toml b/pyproject.toml
> new file mode 100644
> index 00000000..4aff98bb
> --- /dev/null
> +++ b/pyproject.toml
> @@ -0,0 +1,3 @@
> +[build-system]
> +requires = ["setuptools>=61.0.0", "wheel"]
> +build-backend = "setuptools.build_meta"
> diff --git a/setup.cfg b/setup.cfg
> new file mode 100644
> index 00000000..3eaa3c49
> --- /dev/null
> +++ b/setup.cfg
> @@ -0,0 +1,40 @@
> +[metadata]
> +name = bitbake-setup
> +version = 2.16.0a1

100% we are going to forget updating this field. I'm wondering if we 
cannot simply use setuptools_scm to have a dynamic version?

Or use the version from lib/bb/__init__.py?

> +author = OpenEmbedded BitBake Developers
> +author_email = bitbake-devel@lists.openembedded.org
> +description = bitbake-setup
> +long_description = file: README.md
> +long_description_content_type = text/markdown
> +url = https://github.com/openembedded/bitbake.git
> +license = "GPL-2.0-only and MIT"

Must be uppercase, so AND. c.f. 
https://spdx.github.io/spdx-spec/v2.2.2/SPDX-license-expressions/#d2-case-sensitivity

> +classifiers =
> +    Programming Language :: Python :: 3
> +    License :: OSI Approved :: MIT License
> +    License :: OSI Approved :: GNU General Public License v2 (GPLv2)

This is deprecated since PEP639, c.f. 
https://peps.python.org/pep-0639/#deprecate-license-classifiers

> +    Operating System :: POSIX :: Linux
> +
> +[options]
> +package_dir =
> +    = lib
> +packages = find:
> +include_package_data = True
> +zip_safe = False
> +python_requires = >=3.6

3.9.0 as reported in __init__.py.

> +py_modules = codegen
> +
> +install_requires =
> +    ; List any non-standard dependencies BitBake needs
> +    ; BitBake is mostly self-contained, but check its documentation
> +
> +[options.packages.find]
> +where = lib
> +include =
> +    bb*

Is this meant to match both lib/bb/ and lib/bblayers/ ?

Why not explicitly list both?

> +    bs4*

What is this supposed to match except lib/bs4/?

Cheers,
Quentin

