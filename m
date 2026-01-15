Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7311BD41178
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 11:51:03 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.140])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.33966.1768477858412627432
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 03:50:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=bjnQkxqd;
 spf=pass (domain: cherry.de, ip: 52.101.65.140, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOr/MmpaRxzwKWCETxRD8fw4W3rKt+S2cpBKkRNGg9dABt4vjT9o2rfQgwbXOlUTI2jifxSr4mne2VHRFURS/HmXCFcJ5yDCI8bHsW0b1AA+nUPifWLXpmd2pnU+XI6cTKOrn6XKqPiYe8xSqxiJBPi75K1YDC4PCGhvXIiqVIDAr7oY5p1wozfdjzdFeCUSfQV3Gzba0DdeXGzqPjsIPGke5uEif/v/i0kULslOqWmCGaUzOLx1r4Cj9e01ryQ6Rz+j0ULlmDRk/NcP+QWMbeJ/OjOsqpdRjU/A57ZbibuBNhHxBTl3ZRi/4eTX2bq48ny5lMCaGvdjaG6JB2T6ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LNQSchE27BTcl/lUjL4e2Kd+yAyOFBzMrOMsLnESZrI=;
 b=VvOozZVKdLCkQMhyYO2xvoQ6om7mVWxAZM0SoYvDzHK7IE6cLzDq6Ir842qrfTkbviz48rGpD92cywmTbRGTW6Jv1Qy00MF8Wnz8LntyPi+C0Xy8t6OO7K77cnbC5pwgmI00y3ivQ8dzfP/MnAJs9LlXNjpwEi4pI+C93IveWlefHJ6AAX5r6cMI+fkQnecNNHCwlbISC10Uf0hAzYCukryfw3QJg8WnM1PcFB3vn2faqYiwwgQaCp/UEgXyDiaRgobIKgBrkhqFq6K9dW8KTlj4Dxx0G892nrtFbVe+doxCTmJNiR5wYOY7ikYqbV4XDEdAzcQyVGqIjyYNBFpEyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNQSchE27BTcl/lUjL4e2Kd+yAyOFBzMrOMsLnESZrI=;
 b=bjnQkxqd+PhIi+gLWOWDmG+AwyuM3unUJ6h87LpX7jZnhZ8Bs4FCN8jDnZWEYYIod7PdOB3oFGtrAqXqoif4g9q5Ukfu9Buid3xE/5gk3VdGjwf3rE5735UZANArYQix0syyOSCczbYmBlrGWl/iyQx1mAkKODDPsRjKpnugqiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PAXPR04MB8767.eurprd04.prod.outlook.com (2603:10a6:102:20e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 11:50:50 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 11:50:50 +0000
Message-ID: <842ad162-22d4-4ff5-916b-7c8a4450f650@cherry.de>
Date: Thu, 15 Jan 2026 12:50:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 1/5] doc: document fixed revisions
 override in bitbake-setup manual
To: alex.kanavin@gmail.com, bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
References: <20260109132000.2372791-1-alex.kanavin@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260109132000.2372791-1-alex.kanavin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0319.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::17) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PAXPR04MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d16af37-d2c4-4417-ade0-08de542c549c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|41320700013;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bjQ3dmE2cVpuQXVNMWxoU1hNTVlMTFRxQmRrTnZpRXc3NWtpWDlRL3lkbjFx?=
 =?utf-8?B?N1FHTEcya2M5UjZGNVdxY3pWVGNaemJ1Uno5RWZKY0ptcnBxSVNHbVppNWZQ?=
 =?utf-8?B?Vi94YnZldTI3TEpjQkxmSjJxTnM0N0tvZmZpZUZiR25yR1E5MkZOdERCdWMy?=
 =?utf-8?B?bEhVaVVsU3NoRGhQMEJHaXVQUlpMeXJtNVFwWkg1NTVLcnBXZUZ0TkNKYVlV?=
 =?utf-8?B?d1hsSTRwM3BtUkd6NTlORkUwYUNOWjdONGRBYndMbUtSeXJNOFVkano0ZGtt?=
 =?utf-8?B?TVhiejRHR05SM1B4NlB5K3NjcjBjeE45cEdSa2ZHNm5xVzU3U3ErNW1zTFds?=
 =?utf-8?B?dzJOMjJpZ0JOenBMOHJPWG9YdTFzeVF0bFkzVjlBNHd3UktqR3p4ZlJ0dVBz?=
 =?utf-8?B?cVBDMVBZb0NHRG5CT2pVYldOdDRJMGE4SHdUSVltdzBydEk0MXkzS1RvVmZ2?=
 =?utf-8?B?NDVsQU9zSlRzWmxuT3FZb2dxeUNJMXY2d2dzMElHV1hvQjVWaU42YWZubWNh?=
 =?utf-8?B?MDJKb1FaZjBpRFZERWR5VjFYRW0zbXBSYkJtb0FIMHF0d2djWDlqckNua2l6?=
 =?utf-8?B?ZUFWM29XT0w0VmlmRGRDTGRIdFFrWTUyeG9ob2xZWXBBV212dkdiclNhd3dO?=
 =?utf-8?B?NHVBS2F5RFY4QVkvVGdWcFpsd2dUQUt2dExvS0xOR2MxbTQzN3FqZDVhVnJO?=
 =?utf-8?B?MURpNjJLU2JGTGRyeVBpdG5pRXk1SGhBZDlXQkNjQkhTd3VSQjlVRkNycVVk?=
 =?utf-8?B?d0kraitBcFR1VDNxMVNkUVg4ZlR2RThmQjFsY2lqNXRZZlhMU0x5aFBVYVhR?=
 =?utf-8?B?Skl6dGhIRkJOcldFT21DcEc3UldOK1JpK3NDRWNHSkROTUlJVitNSEFzOCtP?=
 =?utf-8?B?cG51Sitsak52d29pcDBQQ3BMNGtQWGVJN2VFbHY4TVptWnpOOURManJGR0Na?=
 =?utf-8?B?QUJ6ZHpXNmFKUmdjMnI4WU9OYkNPL1FHT1NKTzdjZE12NWdWQWU5VjRKcmU5?=
 =?utf-8?B?U3ZsUWZScXREVVhrejN1eGRFWnVyczFqYlI4dE56c3VoTXorZ0JnKzk2ODVp?=
 =?utf-8?B?b2RDM0s1aUxxWExZVXFLajBrU2FFQ1lSTjRlWUFUbmJ0d0tUSEdaTE9mdHJz?=
 =?utf-8?B?TjNvNDlvTllrRC8yaTdHbXdoZVh5MGZsR29POS85ZXozbkIxN2ZHVncyNmI5?=
 =?utf-8?B?NFZ0MjN3NjdIU1NndHcvUHBoS3dvU09rWjZnVHk4UTdmaFo2Qkx4bDZXZ0ha?=
 =?utf-8?B?dUUyaG1MM1R1RWhJc0xCZUUxUklIalprZXEzRWN5LytzTjArTVlyNU1zbTlQ?=
 =?utf-8?B?bWx5RkVZYmdrT2pqRThSL3pmZWx4eTR4Y2NDSUpmTnZsQ3FtTDdyR285bG5T?=
 =?utf-8?B?WnJqcDY3RHptUVp5WHRHWXNmbWg5MEtXa3RXMlhEZ21sTHNWMElwUkVJUGNp?=
 =?utf-8?B?b2RmTndJZVJEVjIxV1paWnR1QkZaYTVmZ1pDWkdHbmlQV3h0NE0wbitkRkhx?=
 =?utf-8?B?c0t2dHBwc09uMTFFdnlxRk54d29GTTFWWHkrYmczTEVUaFVRVFYzaVIzUVlG?=
 =?utf-8?B?WVBaYnlHWVhteVlSWGI4VXZRWGxuVERyaFEvajE3S2tVRTc3clpvejZnUDM4?=
 =?utf-8?B?TzJ2RFNWUGZJNHdsU20ycjFSb3VONzdqaGVUc0htN2NjaVZVVG9xa3g3aWNJ?=
 =?utf-8?B?bG84cWNIUWJkWTZGaFovMWg5ZTFzcitDdHViTVpjZ0E0eFNWeVc2RmUwb0ZW?=
 =?utf-8?B?cFhXcDg3TXdMTlhzcXV5azYzd29MWERFOS8wRmRWMkQ3UW5IcjdJUko4NHZo?=
 =?utf-8?B?ck9Eb3JyaEtwalc0aDZqQ0dSVTFmRFc1K3A0Z0kxYjFKMS9oc1hJejFVdHpR?=
 =?utf-8?B?aWxCcVFKTU43c3pTUmd2TDQ0QklEaGwzWWdaeENJNUttWHl3eUluOHRjeGxz?=
 =?utf-8?B?TllsaTFLYmJ5cVQwQ3Zna0loaGk5NGZNdm81NHJ1TUZSYzFreFJ5dG16Q1hD?=
 =?utf-8?B?aXQ1aWxMMHdMVkFrNDY4TTd4ODRMUWFuWVh3Z2F2L1VaWmU4cmdKRS81YzEv?=
 =?utf-8?B?TTdtWjE4RUtIaStVWjhwWjdSVnhiaFdmaXhtaEY3WG9peGREMjdiTmFTRkJF?=
 =?utf-8?Q?z5wI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(41320700013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UWtYRSsvVTEyZHVqbEZ6dXdJTzRQbkdGcWM1QlN1Z1ZCL0FGTmNXamZQNnpU?=
 =?utf-8?B?WlpIenFsQTk4bWZRVkhyOGh4TEFtcTRFZ20zUlpnTzVWUDVjSy8ycjVGRnA2?=
 =?utf-8?B?M2lpdE1aWUVvZEhlem5hdmVGenlSemtrQUtTbFk0T1VYbzIrTUthdXcrRkkv?=
 =?utf-8?B?TzluMEt1dFNyTXJZM1J5ampvVUIyWit3LzdtaVVtVll6bVBKdEFUdUlqSnBn?=
 =?utf-8?B?d0c4cmRIaE9KS1dSK21lOEdZbDlCRHJjbjlKOGNpTGpPN2wxM0NPWDdmNVR5?=
 =?utf-8?B?eXYrQzd6cms0RHh3WjdnYXVDM0lMRkp4YSt0T2YwUDhsSEFBZElkRmpwUnNk?=
 =?utf-8?B?RkpVdzBwNEpnTFdNdGtWa3FweVJLRUFaNEdBS2RDVmk3TkJ5RWcwcUxUTlVY?=
 =?utf-8?B?M2lnQ1dTY1dXQnhpMHlhclkrbEI5LzczLzNSRi9sd1NHUVZ5YS9FclV4T0d2?=
 =?utf-8?B?YUNXbHlwQnJYS3NUZUFZck4veFVvZjRwclZVbWY4czdOVHBXd1FQa2ppRm5E?=
 =?utf-8?B?c0I3aDhtd0t5ak9WOXR0T1hKeEYwcE9uL3hVNDNmd2RQZ05VUlVjVm1hNjlF?=
 =?utf-8?B?K1NvMWlVdEZQL2lteE9ieVhSV01GWFhBUzluV3NUOEZlSUcyMGVHNjZ4ZWUv?=
 =?utf-8?B?bnRUNU10V0Vjc2xBZndWTWRHTW1kVllzZ3oxT29jVTZmbVV5THB2ekdvNU5p?=
 =?utf-8?B?T1Vya3ErNG9uMVZaVE8yamZLMVloanVYTTdDVUh6T0tkNjdxTTBPOEpHbTJD?=
 =?utf-8?B?enhsMWQ5RUQxV2cxTUpIZHhqeUdjV1c0S3JnQkxFQmI3bktqMDFtU3NtM3lS?=
 =?utf-8?B?VXNtZzF5dGNzSGVIaWMva0tTNCtNZEZ3YTNqclZpRjVvWWJxQXRWcktTRXhY?=
 =?utf-8?B?RmFiSkN5bFIyTm9KNXlGd29ubzFlSGt2NVVGTHdCM0FDbEpESW9ZUm43OGZS?=
 =?utf-8?B?ZFo2elU4bVA4elp6clBtU0Y0WUM3MDRiTU1rcHVteG1QTVZMRFVHdlZFS2RH?=
 =?utf-8?B?SVBzN0phcXRTRVZ3b3pxc0p0aCtDSmFVOWthcTJSblNVellFWjFsN0w5YzZm?=
 =?utf-8?B?S3AycEVEWDF1YnRseWRucDVQa0Rmc2lNV01INHRxWjJMZkVGZXl6d3dVZk42?=
 =?utf-8?B?NlowbTRqNmQxcFgvZDRoY2lmVlVTK1ZGQWh4djRTZ2RCUWZNNHM0MSs4ZVNY?=
 =?utf-8?B?VGxldlBwYUFpdzJVWW5zMUJUMk1VQS9FN2hXeExHNmxZQ2JUZFRKWEMvWmZG?=
 =?utf-8?B?OTYyWDR2K0t0KzhoR3NjRFZrMG1OOUlpM2Q0ejcxMXNQNE5uYm9sY2JKaSs3?=
 =?utf-8?B?dmYzUWEyVWl4L0dnZitLcnZqdjdmeVRLTDNRdlQ4WnQ3WTJKbXRVNTVIV20x?=
 =?utf-8?B?alpPOGI1dDhMcWY1MzdZamhTd0hMOU9HYzJNRUJKUS91QWdaMmFZT1lyeFFU?=
 =?utf-8?B?Rk5EaUk2RFhQdkczUzhjVHdKejdFZmQ2czRjYTQ5WkI3MmJGTGNadlg0Qkgr?=
 =?utf-8?B?TkF3N2FXclNWL2xBZW5BQXNCVmFpR0s5aWY3dE1KeGdhbUo0Qno4UFVhaVdL?=
 =?utf-8?B?QVJoUjllbkFUNDVCdkVFbVhOZUcyUHBlWm05MDF5RlJMKzhpWXlGSjJCaXNp?=
 =?utf-8?B?RzhZSU5xNWZ3Z1M0MmRERlpDR09kMHovSEpaV0lQdnRzMjR2aDgwTS9valdE?=
 =?utf-8?B?bExZMEsxMHpadExsTTVUYnZRWWN5UDE5OGl4MUpaNU1IUmVjTU9xOUprN2Zp?=
 =?utf-8?B?VkhKMGMvWkZ5SFhmTTZUVFVxcEpnaEdQUUkxdUlSOWlUaTcyY092MGk5azlE?=
 =?utf-8?B?b0VhRGpOU0pVRXB2eWpyd0xPcGF2U1hpdHhnVG5kNDRWT1FnOXpoU2hUOTdX?=
 =?utf-8?B?QzNITm1Ubm50RElOeEdiZ0VTNU8wRzRCZVJ4YkdHM2dLTkwzZkdrakJHMGVR?=
 =?utf-8?B?K3RSWlFYdVBiN1ZYUEVNRkhkWlRSRWY0eFRJMGdVWnFiOTRNZVhrT3M2QkZY?=
 =?utf-8?B?TmpMa281YXpJaU1hRWlxb0ZpOW9nZnNtRXhzcWZsaEp6a05CUFFaUlZXTlNX?=
 =?utf-8?B?NE9QRXpsZG84dXJYc0pmOUhWOGZ5V2xHRHhSMWgraENLaE1xUi9TRGpmcFps?=
 =?utf-8?B?NXcrYW10UGFpdjBRSVRYdVJZUDBpejkyajFwalZiRWNTUmgyU0lNSnJUcVhB?=
 =?utf-8?B?a3hYNGp6SDByNW1hWFBnUi9ZSXNJRFBSMFAvRFVxTUxUdFVmMHZidHM2RkdC?=
 =?utf-8?B?Y0M0UUpXMWVYUzUyQU9uOUdJNVU4bThpL3ZlbFFWMmNmT2VHNHAwMFBvQWZ3?=
 =?utf-8?B?cnN6OU9uSktiOHFlNW5xUFd6SVZ3dGYrRkVIVDA2R2JLdnlKeXBFQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d16af37-d2c4-4417-ade0-08de542c549c
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 11:50:50.8787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccHAX2Uy6GdTcBeMZdAa91+uUvjhNQB8a+5TwmJeO9FF63/ucxcu0zvc6KhXYx3pvgAfM4XyMTbol0uyWWDKlII7/Eycv3DNQg1+RpOcBcQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8767
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 11:51:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18773

Hi Alex,

On 1/9/26 2:19 PM, Alexander Kanavin via lists.openembedded.org wrote:
> From: Alexander Kanavin <alex@linutronix.de>
> 
> Signed-off-by: Alexander Kanavin <alex@linutronix.de>
> ---
>   .../bitbake-user-manual-environment-setup.rst | 48 +++++++++++++++++++
>   1 file changed, 48 insertions(+)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> index ec1bdeecd..fcffab812 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> @@ -938,3 +938,51 @@ Here is an example file that overrides the branch of the BitBake repository to
>   -  The ``sources`` section contains the same options as the ``sources`` option
>      of a :term:`Generic Configuration` file. See the
>      :ref:`ref-bbsetup-section-config-reference` section for more information.
> +
> +.. _ref-bbsetup-fixed-revisions:
> +

We have autosectionlabel sphinx extension enabled, so this shouldn't be 
necessary. I know Antonin's got some opinion on when to use manual 
labels vs autolabels so up to him to decide. Would be nice to have some 
sort of rule documented somewhere :)

> +Fixed source revisions
> +======================
> +
> +:term:`Generic Configuration` can set source revisions in ``rev`` to a tag or a branch.

Will the tag be refetched every time or once it's available locally, if 
the tag is moved upstream it's not changed locally?

> +Bitbake-setup will make sure the actual revision will match the tag or branch when performing

Do not capitalize bitbake-setup, it is a tool that is named like that. 
Maybe highlight it as such as well:

``bitbake-setup``

> +initializations or updates, and will capture the revisions in a :ref:`_ref-bbsetup-source-overrides`
> +file.> +
> +This file is named ``sources-fixed-revisions.json`` and is available in ``layers/``
> +under the :term:`Setup` directory (as well as under ``config/`` for backwards compatibility).
> +It can be used to keep record of what was checked out when using configurations that do not
> +specify exact revisions.
> +
> +Also, as it is an override file, it can be combined with the original configurations
> +to initialize a setup in a reproducible way that guarantees an exact, never-changing
> +set of revisions, by using the ``--source-overrides`` option of the
> +:ref:`ref-bbsetup-command-init` command.
> +
> +For example if the original configuration had specified only a master branch
> +for a source::
> +

This is JSON I believe? So probably:

.. code-block:: json

instead?

> +     "bitbake": {
> +         "git-remote": {
> +             "remotes": {
> +                 "origin": {
> +                     "uri": "https://git.openembedded.org/bitbake"
> +                 }
> +             },
> +             "branch": "master",
> +             "rev": "master"
> +     }
> +
> +
> +the override will contain the exact revisions::
> +

Ditto.

Cheers,
Quentin

