Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08652C433F5
	for <webhook@archiver.kernel.org>; Thu, 29 Sep 2022 12:16:06 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.53])
 by mx.groups.io with SMTP id smtpd.web10.9286.1664453755385472240
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 29 Sep 2022 05:15:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@theobroma-systems.com header.s=selector1
 header.b=DpJW5hCA;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.22.53,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8mLw+KeCrYb2xNJTykgJDKzk77SJOd5xAUuLGfzRWC0Wtq7dT218bPza0XAEWMEJXcQp0Wtgolw1vZLEnadHf1bRnQ0BXipzNvLX7IHuIs1KNpqtHLxTGy8Mg/jPf8I81TxyzgQKY2omUBDCgppU0ib1l5LI1WCW5zgaieSlCzKmnaGx2W1c9ZgFtLlnO6MyZ+9OyZO32QVPApFZTShtM8Q3OeSoty9Cd7I39jw/ZfNIj1KKAxGUeB+9HLfsUbw0sCTu93wcn+ZW53+VRMpF6RtbDpCdGt7LW6z+aMKSrJHSwu129hyx+EFD5yksA9pfibqLncsT6iy2pyYtnnXjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AIE5BtMpLC4OSH6wdpdC+PoVxlUt8XJeiYX2S//JL8=;
 b=H8CVoOEvd+yOpjBP75pwfY3aBh4Dy5ueDBo0hr/ZuepZ+aXOm/ruCiPZnVH5nBXLV2nluQE6YGvdan8y6TBCD9QQ46E3gbfS5CxTIPesmYuB5y4tOKhoJk9qMHF1EHk7V1PZpCAQWFihEl1pdaMsVpHkvFLtAd9cxsDevr8TUZoen19yitzsSX64+5aDPyw3zxh7Js0gmz1ChZbV1nTqO1GJOCFXzTiWgPXCdtHdLdG3YXtC0EXkEuZ1wRAL/EVHuAoNA8itpOOabB85B0Nme7vi4wQ7NY/3YTkldC7+Vt7YopvnEXp3ghA4FS61amuDh466livpaYuwubcMn447Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AIE5BtMpLC4OSH6wdpdC+PoVxlUt8XJeiYX2S//JL8=;
 b=DpJW5hCA5yotuVyzGhWBtRogFSgBt5pIVE2o7tPurcOEat1yAy4uLca1rDRUvyoAE5wdf27cGeBXXR4g/adHdMyec59D2c5JaZSLHtYhJfJIgasTDHiC/JnoVC6jyYZfNrICu2khU8b5VtQP6mDV7nvldaYZ2pLscoglQk7xq4YpSRNvpoBstt/9fYghticX2wri9Lp/O6Idx/sASIZ6MGDu4HPPkbtNi5Un2/HtQuCx3Zb/Ffe4veFj7hBchlWeMt3pweQwfqGPyNcChh2CKaQQRNj5cc+BvNwcupddVwLrb/l2Pa9EKb0M3jnCowK2Ls0VFua3avW92uTffU4Tyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by VE1PR04MB7406.eurprd04.prod.outlook.com (2603:10a6:800:1ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Thu, 29 Sep
 2022 12:15:51 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5e5e:1989:e5ec:c833]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::5e5e:1989:e5ec:c833%3]) with mapi id 15.20.5654.025; Thu, 29 Sep 2022
 12:15:51 +0000
Message-ID: <0dc89f5a-b634-84fb-c914-19b6cc7d3bee@theobroma-systems.com>
Date: Thu, 29 Sep 2022 14:15:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From: quentin.schulz@theobroma-systems.com
To: Johan Korsnes <johan.korsnes@remarkable.no>, docs@lists.yoctoproject.org,
 bitbake-devel@lists.openembedded.org,
 Johan Korsnes <johan.korsnes@remarkable.no>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 Ross Burton <ross.burton@arm.com>,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>
Subject: Re: [PATCH] bitbake: user-manual: inform about spaces in :remove
References: <20220929121135.259094-1-johan.korsnes@remarkable.no>
In-Reply-To: <20220929121135.259094-1-johan.korsnes@remarkable.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0008.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::11) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|VE1PR04MB7406:EE_
X-MS-Office365-Filtering-Correlation-Id: 650ad1b0-afa3-4176-b263-08daa214597a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xiJjniw5GRtFmvSf+YVIi9VhhNam/oL9RzKmXdMy8GzPP+rTHNuM1hxtHEHQ05i9/PYmZtomb1pd2f7t2u/aD33dFyeFaU/Jl8KGj/lQKRqOjo+nXOEPe1/nJi4IEH1jmt+ywpviHOFzYgGYvsQsH20wt6XeRtO/aPs3AczsVNPtOguAPNnjM2OwvhrAbQKeMuW70S3LZPVoomaglIW3ViT3MLhNKoF1KTquROwUw6bOtZGqkczkcTXKD81SPPiaKl/WaQk53a7LJSYkXiaAaTn1niWX/ChfoBDm9jJdMT2JLYQNRvyqkKfG1f4pMo0yAQqWi0e3sE7AwbqRfwNgMBSgzz4SmfNTzmHj+lTn2YTqDDHrfAso1RxcsaN95a/wQ6Emfdu5ITT5J0OikUfg7kNNnLi1V9cImU4gHQy247re5C6hPrkM1KMwls3dphrfL0YHryHcleqrGexfnsKjN6zpWC9HsU//9YwGvZFw9OZBHMO1QEDhfQb5zGIdSyGEa2lmyrpUYta84M51ewRIeCazFvg2rbjZAVD23v5TqRGnx0pbYd3WqWbyo9TUVBeQN5oPS1AuR+bVa2uyIyxlgucoE4QV0Bx1/ud0COGfB9bbJqvxzTfFFwQx8JFHma8FBYBMID+FbkTe0d959J5rxzeYLFZqUHwynBlFab18Mb2kMq6wulmsNM347jri/8PI1049r8jVKhatkkxzqHQLAC0yEWaki12w0WsO8nprbJkvDRbhUL06+P+ewM9fkIc1KzH9gxA3ZHwzMBcBOlNCAA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39840400004)(376002)(396003)(136003)(366004)(346002)(451199015)(36756003)(38100700002)(31696002)(86362001)(41300700001)(6506007)(5660300002)(8676002)(6512007)(66556008)(53546011)(8936002)(26005)(110136005)(66476007)(316002)(66946007)(6486002)(83380400001)(478600001)(2906002)(2616005)(9686003)(186003)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V2VXempIUy9IV084NitXcmZxM0Vuc0VxdVQ0VFd6UFE4MFc3eHJHSFF3SXhy?=
 =?utf-8?B?V3d3NzYySThBRGlhbGZEdHBVRWxnb1BJck5QQnpFTVpic05sbnVTZ2hLbFVG?=
 =?utf-8?B?aGQ3MXJVZXlMMzBpWnlNY2pHbjQvZFE5eHFwY01ZTjlKbWFHNlRyWFlwZTZU?=
 =?utf-8?B?RFpNTUNtVjdQa0tEVDNpai9EeGFnc1F4alVlWW9acGg2OFpOTVhUVWlpYWJX?=
 =?utf-8?B?U2htNXZoclpNYmNrOFF2WE84SVk4ZEdwY25mcjQzSjRpdDBlZ0Z3V2pYTEI5?=
 =?utf-8?B?QzhCRFYxUDBpc0JvL0VvQUZwd1FWYXY5L2JQV3d5ZXBDQm9rbmNMTzVKWUk2?=
 =?utf-8?B?WFlJZWt6UjR2Zy9nZUl4TzFQbVlrcEVpSG5NZFRqaUJuSjREZnU1NUZpRElL?=
 =?utf-8?B?ZFZVVFVvUFkreUVYOFRQcjRzUTVpd0dIbjZreTBBa1hrMHZVUDZzd05qOHMv?=
 =?utf-8?B?Vy9NaUZURVFEVE1GYXorekNCWUFFRk5XbFBCbkNoREtabnJJdW82TkdwQ1pD?=
 =?utf-8?B?MVp1dmdBT2cyQndWelJlc0RIRG9GUERQSHNDdVJyNlJZaXJJN2NJblFvdUFt?=
 =?utf-8?B?SUpqMS9EOVdRbDNtUmtZOG5PaFQ2WVZOTXNUeitTQ0tlNGtaYlh4eHphK0M2?=
 =?utf-8?B?SGJmT0ZDbmp0ZGhqeU9nSnpmYlloZzJPMTZUeENTbWRPQWgvbFU2QkhEeXc5?=
 =?utf-8?B?dWFZajV0dXNVLzBvZ095SFZHdGtuNm1WUTFmUjFBaXdyeGFFYXMvK2Jpc2hU?=
 =?utf-8?B?SUwxeXdTcWRKRHdDYktXZ3hMaGp0YWVDNUFqZGY3aFVKNWo5cXc4bVB3YWRx?=
 =?utf-8?B?N0NJRHJhSjZicTZMMGMwSG5URGFHUUU3UmVzM2tENEJudUticDdxRWViOERa?=
 =?utf-8?B?d2RKdlpNVjZ3VUIyMThFV0ZGVk0zUnFWaTY4VU5sVVV1ZFc1aGJOZnJGaHZI?=
 =?utf-8?B?dTFsNzVzcGplUU14NkN4ZkFxaXdrYmdWcFhQUktYL2RkYVBIRHBtODN5ZEJF?=
 =?utf-8?B?anFCN21XRmI2Nnk1RjZQOURXRk9qSE5TcU4xdFU3d21rTUd1djQ3Z1NIcnlo?=
 =?utf-8?B?VjFiMVBXanpZQXZQVG94WDZRbnpwdWtieitIaEtOWUh5RWxpS00yb29WZGp5?=
 =?utf-8?B?M0l3RVI1U1kvNlhGSWp5VW55UXVGSXNyM2JLZm1aeEFCeXg3WFgwR3JHSWlB?=
 =?utf-8?B?KzM2YjJETVFEdjM0QkFUZGtrcW8wcXowd0FBNmVSRXg2dFVUMEpORDhCUzVs?=
 =?utf-8?B?a1F1QTNpdVpuM2kyNmdmOEtqck9qWHJvQUFPc2M1NmNaeU9kRU02VkFLNXlO?=
 =?utf-8?B?SXhIcFJidGtrUXVIdi82RUc1QWdVNjJDT0tDNXlvZGI2c0tFV1hQbFpVcEdD?=
 =?utf-8?B?QjJlTzBIZlh3SlZxSW9NUDF3V3o4R21sSE1BV0lVZmpwNkF6UEZkT1pFV3ho?=
 =?utf-8?B?QWdzeWsxUGozdG9Oa1NVeXJqK0JJSVNpSmFSUUpINVgxTjNJc3VuQmtaZ0dL?=
 =?utf-8?B?MnY5bXJrbE9KL01kRStrOFF6eVZUWUZhUm5ENEViYkJvaDFvdzRRc3ZKM1lp?=
 =?utf-8?B?Q2xuWWpKK1NaK1lOL0l1QlBTdmxBMWZQZ2Vza3pjSHJjbGlWdFljSmxtQThm?=
 =?utf-8?B?R1NZT2lCVDFXSEJkVzczTEFXZTNDRzhoQjZ5V3RtOWYrdXhwQzlFUHZaUm9h?=
 =?utf-8?B?ajBNcnpDRVUwRzgzTnFpTWJ0M0xpQjlvT1EzemkwTFdSSU4xWk9PZCsyNmtq?=
 =?utf-8?B?a3NObVA4RjhWbnR6TVMwZjA3NGtDZGJpUUpzWUhPcURCTVdZUnM0ZHFLeklr?=
 =?utf-8?B?R2RqendOUEpQV1hsMDVFeUV3M1RyS3VPMWRiT2xHZ1h2MnRvaTErVDNhblF5?=
 =?utf-8?B?S09DeWsrTjRiWG1kcDI1Wk5wR0tQamNkWXo1OEhHMm8zRE5MY2VicTlUVzhS?=
 =?utf-8?B?c2crY3hMVnZXNTUwdG9FQUp4eXZqcDlXdXdQS3dJOGREUDNpMzZWZTgzOTht?=
 =?utf-8?B?UldtMVl0SVdLYzFNY2FHNy9ENHpaMkxtcWsvRmpPOHZ0c2J1ZHk0VldMVmkx?=
 =?utf-8?B?U2Yxek41RWs2Q2xveGdtbmx3Y3BjU3V3TGFvRU13OExyQWhKYVNwS2pXV2Zu?=
 =?utf-8?B?SkhkMFdFd1NDN1RpOVBINHpnNXFKRlZTN1A3bnhMbTlrdUNib2YrbDZwbU5o?=
 =?utf-8?Q?cbR4RqbO0b80bJELZg7l7Dc=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 650ad1b0-afa3-4176-b263-08daa214597a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 12:15:51.2636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 gsx7dPNS6S0D2L7dn9HVQizKLCXPVBflRzUnn0K5qxCi67Yq0MPcmEjxjHt2aLjijkADmNvhQrRVull1jIJgoOUzCojqsChRMLyv22nI3uXtr4gae4HMqkHXXkA8le4M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7406
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 29 Sep 2022 12:16:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13997

Hi Johan,

On 9/29/22 2:11 PM, Johan Korsnes <johan.korsnes@remarkable.no> wrote:
> Inform the reader that there should be no need for spaces in the value
> when using removal override `:remove`.
> 
> Considering why spaces are used in the other override operators, it
> might seem obvious that they aren't needed for the removal operator.
> But, it seems like I'm not the first to be confused about this.
> 
> Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
> Cc: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> Cc: Ross Burton <ross.burton@arm.com>
> Cc: Nicolas Dechesne <nicolas.dechesne@linaro.org>
> Signed-off-by: Johan Korsnes <johan.korsnes@remarkable.no>
> ---
>   .../doc/bitbake-user-manual/bitbake-user-manual-metadata.rst   | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index 337821612c..0cc3ba18eb 100644
> --- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -330,7 +330,8 @@ Removal (Override Style Syntax)
>   
>   You can remove values from lists using the removal override style
>   syntax. Specifying a value for removal causes all occurrences of that
> -value to be removed from the variable.
> +value to be removed from the variable. Unlike ":append" and ":prepend",
> +it should never be necessary to pre/post-fix the value with a space.
>   

s/it should never be/it is not/

or "there is no need to add a leading or trailing space to the value"?

Cheers,
Quentin

>   When you use this syntax, BitBake expects one or more strings.
>   Surrounding spaces and spacing are preserved. Here is an example::
> 

