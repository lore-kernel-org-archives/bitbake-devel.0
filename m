Return-Path: <Nicholas.Jackson@zii.aero>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFD3C433FE
	for <webhook@archiver.kernel.org>; Mon, 10 Oct 2022 18:19:27 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (NAM04-BN8-obe.outbound.protection.outlook.com [40.107.100.54])
 by mx.groups.io with SMTP id smtpd.web10.1239.1665425958189735506
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 10 Oct 2022 11:19:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@zodiacii.onmicrosoft.com
 header.s=selector2-zodiacii-onmicrosoft-com header.b=NCZQtP/C;
 spf=pass (domain: zii.aero, ip: 40.107.100.54,
 mailfrom: nicholas.jackson@zii.aero)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akjPCouvQGC8Rae41K5bwzz2mJdTNbNDyCXwXJ6BGADWHPbhoT/xluPeavO3wKxkCQgd+GIzgYBlX/gHh2MsZ/T6DsTV/LrpNRWQiuB/khIpyUIYPZ0pn2YBjz8AEQwjGEb3aQleyuAZalMupGCwG9ZwkTlkvpZ6D/Tu+yw1qB+BXC3sjfgBtElMNmQfh+OmWkk3xhBZDLGbg06ZJG2ebkN2YgzPrpJBcBtjbZl49hDAgjlWMbyYjV6KyFwWTfp2ZjdqYFsq4D7VaKN0oTHLRN9tCKwpel4rqWVLNJZl2cb8xi4FBjUYrDDJAHsp+YTALDdPBl3JU89r6Zuf3EiIqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FcnH3uCJWBE2jvlIx6A4+4pbka6CJM8l/gJKVpfx+Ao=;
 b=VbKm22ZPaIy2pjbpt/FzjOry/Mva7dqMZfZlAkjNpM0/EZdF4YtPa/tuWuZbHYU6Ef27skeYtD09vC9debQwHMRGdXFpjEe/0/gj7r4docr1UZ1WYh1yOO0K+CZayLVoo3wtCCqnzcHUDblJvNEIpLs+XHy9yKc95o1vCWLzRFGRO7j+JVY2EBMyxSjQ+ZvkgRhElRkWkNcGnzeJck2bX/petFtSY2ClEh2L5q/D1WONnkVOv7+J1ZIuk/MThqputQDFo4sj6gV83qJQcaYH7qr5NtBX5gu9sIXiIbQi+xHTe2o7McVPFtOODIVi7gTqD9fTvS0/YLZBq+4GE3SUhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zii.aero; dmarc=pass action=none header.from=zii.aero;
 dkim=pass header.d=zii.aero; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=zodiacii.onmicrosoft.com; s=selector2-zodiacii-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FcnH3uCJWBE2jvlIx6A4+4pbka6CJM8l/gJKVpfx+Ao=;
 b=NCZQtP/CbF2OKNxn+YcUqcbDoGoC4/o/c/DKmkhSPiLhuD2IfVmrwXRaRfnol0QoNB3u7LLg7wtSyvXXH2e4+GMOl78Zjf2Yq0Mamsh3n5lolZl2sInDO6igV7BkAg7Gqn+AZbcJG9vH9UEAVztpL0FYg4nzLg9iKboTCT1zYXs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zii.aero;
Received: from BYAPR12MB2710.namprd12.prod.outlook.com (2603:10b6:a03:68::11)
 by MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 18:19:14 +0000
Received: from BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::cc41:66fb:c5b4:b623]) by BYAPR12MB2710.namprd12.prod.outlook.com
 ([fe80::cc41:66fb:c5b4:b623%7]) with mapi id 15.20.5676.032; Mon, 10 Oct 2022
 18:19:14 +0000
Message-ID: <818df083-80bb-e189-6466-ea161d35d566@zii.aero>
Date: Mon, 10 Oct 2022 11:19:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [bitbake-devel] [PATCH] bitbake: wget: fix netrc with pseudo
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 Ross Burton <ross.burton@arm.com>, Alexander Kanavin <alex.kanavin@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
References: 
 <BYAPR12MB2710069E5D018DBB8F800AECF5569@BYAPR12MB2710.namprd12.prod.outlook.com>
 <CANNYZj_Cr5QO31dqnrNV9051M4fVh79Z3ayq8xF9DxLyRriDgA@mail.gmail.com>
 <BYAPR12MB2710359C1636EC9716B3EB83F5569@BYAPR12MB2710.namprd12.prod.outlook.com>
 <CANNYZj9ETtBH1mY3x3G2Fe4Fjyni7zkRMcA9UsYtpBcTznUQDg@mail.gmail.com>
 <BYAPR12MB2710778AF2346FD1E8FAD51AF5569@BYAPR12MB2710.namprd12.prod.outlook.com>
 <1719BDC7DCD0DABC.17026@lists.openembedded.org>
 <CANNYZj95vsnNLd97LzL7ix=JC9HCReJo7VNa80EymiSRYNgRiQ@mail.gmail.com>
 <BYAPR12MB27105A444B6963892070AE56F5569@BYAPR12MB2710.namprd12.prod.outlook.com>
 <CANNYZj9RuBP-btf5ATGx7pTqiP=-bzeHttY2GM=A9t+HQLo=5A@mail.gmail.com>
 <EE055CF5-FB7C-436B-A526-3A05FE023513@arm.com>
 <9cb6f8f622cfcc8a9fc68846acceb89734889ef2.camel@linuxfoundation.org>
From: Nicholas Jackson <nicholas.jackson@zii.aero>
In-Reply-To: 
 <9cb6f8f622cfcc8a9fc68846acceb89734889ef2.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH0P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::12) To BYAPR12MB2710.namprd12.prod.outlook.com
 (2603:10b6:a03:68::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2710:EE_|MN0PR12MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d0f063-c684-47b6-48cd-08daaaebef18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eTtehm6CC1uYNTa4zRnVEpk0tO8UH8M0hKH3VSyULtN9NSMMGU4uq1biCpAKO4n5WMF2BYajFYUSUhPkrIgUvqfyR+P1/jBBzzU2T4BlGiyG0gVqogSHbhwiiy5wor4FISL+eZscDIHgCgPwsuKQwtpTvQo5/uLUmVwFawFtAW1upQ9UEaaViCtaQ6LDjAPqzLmF/1IXZzAg12+7Dc8gPY8Y+6nSzC/sYL0KgG2zMRiFN8IoLQcNf43IMTY84l2Nqx8ajXKMgQwyImwuLgFA+vumDgYHU/WHuJdjhC8p7PawZPLLfQysURhO52NR5tStXJC6/6BS3+nGz6YgxAm4oBtk/CtRlLCMuIxOgoWR2bDhqTOO/fcTWWRwo8RooUohSbrtt0+CeGl5IlcXIqfSiTd5l7mZk2gaGvL7cxoQXbxjk/Hg/v66CP0VxiBN6vmia2JSpm9WK1+zkwNwxtWpQzIgJuWgYhMkUmt3bf8H2z9xv6/HKCe3Choiwv3430n6xnZJg9CZCGZ356WSVghWNXKsVki4CKF4CTZFjmZMXy4n/Svf+Y5CA5N/SoCiDCgt0AbUfQQF1n9RfDjValR7xaptHuNLQMNRN7Qe2A60kXYeK6AZZcm33440BzApS0b4+Yh6ca7TTpaRsJmkVas/IWXDOqGrJluZ6WzyjKd8/tmDTWFpacTMMB9DZyy3KXNsD0DSqD7J+lRjGM/TutZYKA9SZPMlOlFGQCa9zvbFDvCKixg30gI2GFE5LgkACsfeZWvnNc5HopE4nzyuBjWCnXs2apPaYYGCktLfrRzcFktaMvP4KBorEwqo0bsnIQCoz334+h6m56HImeota3IgqA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2710.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(39850400004)(396003)(376002)(346002)(451199015)(66476007)(66556008)(66946007)(6666004)(44832011)(4326008)(8676002)(83380400001)(26005)(110136005)(8936002)(478600001)(53546011)(52116002)(38350700002)(41300700001)(6506007)(36756003)(6486002)(38100700002)(86362001)(2616005)(132210200001)(31686004)(2906002)(31696002)(316002)(6512007)(186003)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YnFTQlZlUG1sQjRuYzBXc1k5T0VYK3oxNGE5QzJYdkxPVjl4SWdTNWZKeE9H?=
 =?utf-8?B?cWV1SmhZeE1VMWlxNjIwU0M5bW5BVFYzaXFCcG5xWTcwNjYvWnlZQzZadW13?=
 =?utf-8?B?eFEwdFdHcHFZblFkd1lRM0NXUGNqdnBmYWtUaHpwOXhzOW91Qis3Yno0aTR1?=
 =?utf-8?B?UGFRKzhGeEVlazZKLyt4MUc1RnZ3dDdrSlc2WW5mRTF4VVJuc3d4bUJWTDA5?=
 =?utf-8?B?RnkweXJTcTBFNk4zU0t3UzhmbFJ5T0R1OHlQNk1aaUdwaHRvQWxJanljbG9U?=
 =?utf-8?B?WUQ0OXBrL2VxcFRYVnJaWEsxVy92NGN5UFJmVlEraG9TenVFRjV3R1hZeTlp?=
 =?utf-8?B?enNFOHEwVzhzTWY4aEMvOGhHQ2lQbGtCVkltMVRpaDlvUUVJcUlXMHI2NmlD?=
 =?utf-8?B?SlRDNE1pM3lGNWQ0Vzk2R1E3bVJzSXFOcUEyMlh1MnRrUXBYc0pHcXI2eWVi?=
 =?utf-8?B?ZmZYa0d4NjUzeHdvVFFFd2pPY0VYMGszQXNLajhNQ2JIeGI5QmJ2OVFMQkpV?=
 =?utf-8?B?UlRHNTdKNHZnRzVWVmNra3Z0cW52Ym4ranU1YmxVaEVGUmw0OU9ldzhhTnNw?=
 =?utf-8?B?M2M3TlMvQm9OOFVKc3A3QkZQRFRXNC9RWFZzMWp3b1RrT1FGd2ZGdEk3WWhj?=
 =?utf-8?B?MEJRZ2l6KzNESlJCczRXRHdjd0ZuNXpDd0VmbGNFV2owRVk4OGpkRzlnRWxl?=
 =?utf-8?B?RnZWMVBrZFBpblJGWEQvYS9IVWl6eWpKYk00c2FUcFBsd1NPeVQxRzFpcmpa?=
 =?utf-8?B?ZnpCeFRwK2hGRm5mRmxUYkFqeGpiQytxZFhpNTYvd2haK1BYUnRXbk00OEFM?=
 =?utf-8?B?VEltbTNCdGlRelRIc1hEY1hDTHVnSUgzVzVSUWNkejRxbzduSlk0Z1hPT0Iw?=
 =?utf-8?B?MEhXZ05TM1pyZFdJc1Q1TEp6clpwaUdXZVpJYnpLcUx6ZWM2SDMyQUx2RUJX?=
 =?utf-8?B?ZmlEYXJ4S3dQcHdkY0Q4RXZFWTQ3QVlIR1JCWUZtYjFnN2o2SVgraDF3VXJF?=
 =?utf-8?B?OVRGdlZYTDlwaklRSUM5UjdzUUFkTHllU1JiMFRjMkp6U1B3d3lCU0EvQmtw?=
 =?utf-8?B?ZXJnTmhlclVhVmdCQ1JRMlFHRDBMaEJ2SVhIa3BodWJRaXBUMG42UEdOYzFJ?=
 =?utf-8?B?amNiUjR5UHF0L3NvT09ZVkxkb1h1ZVFaREhMeDdFSDhMK3pBem1vc2tBYWVL?=
 =?utf-8?B?V0psbWt0MUU3VDBNM1FPUzJ0VmtoYkFENkhOR3h5OWNkSVFBeGdodi9VNlBU?=
 =?utf-8?B?QW1SZ0xsWFlmN1FicUlRL2taTS9UZUpzUmxNRzhicFZUaldxUmpCT1hyRWgw?=
 =?utf-8?B?cE8vN0dZZEQreTB3UmtTNTBOYThBbzd1K0t3YWJjYk1qNWQ5aDJWSE1pUnpG?=
 =?utf-8?B?SDFqeGtJTTVFNEhVT1RmbzNKdEdTWms1YzZKS2MyV0NZeVY0dW40czlqMmFR?=
 =?utf-8?B?MExDbWExTWJnc2RJMno4VC80MHdXbTNVOTRlNmxSUitNTFZodDZ6Z2d4U2Nh?=
 =?utf-8?B?UHE3REt3UlJQQzE4eGwzak4wYnRab0I5dGlxbDc0RnNNMDFRaml6NEdtVDV4?=
 =?utf-8?B?Ylcycmt5V0c2Vmp6blRsRG5EZkY1MzBFODF3dG9Oa0NyYWFFd2pGMGdZUS9p?=
 =?utf-8?B?MmV1RWxleTlNUWZQN3A5R3VxdnpBM1FyOEhNb1RuUzhSUm9zQTBLU3BKd21r?=
 =?utf-8?B?R3FSdmQzUnRGekpJdmtQdzRpUWZUZ05EbUt2aHVEeHZHS1pUV3lYMFR6TmdN?=
 =?utf-8?B?SGxPdVR4WFJ0VjdWLzg5SG5VRFNYd3A1cUY3Rkd4ejIxTkQzYk9TSXFQRGxh?=
 =?utf-8?B?Vkd3NFhlV3RmMmxlUzdqZHZ6LzBXU1c1cjBYelhIMjVUZ2RNTDBkWVNwZGxk?=
 =?utf-8?B?cnF6bkVMTFd5RUovZDcwTDBTOEljdWg4cjBycUhQcENrUWw4UGk2dDBKeGFM?=
 =?utf-8?B?K2hmaHpRZUhWOXVXM29xclp6MSs1OVJBMGFwK3drQ0EzUmtXVnZ1Q0pvSlJq?=
 =?utf-8?B?UERhM3Q3Tm9mTTE1eW1qb1ZVV1FwM3hXMGMrdTI0cXZPWW02U3FLZE1tbGdH?=
 =?utf-8?B?bTgwR1JUc3U5NERMR3dkY2hwREtFVzFoN2t0QXVOQWthL1UrWVlKVVZZcEo0?=
 =?utf-8?B?UDBqdzE2WDZUejB6QmxvdWVWL2VCSVB4clJ4SlZIQWI2ZDVvQUlFdjVydkRC?=
 =?utf-8?B?SGc9PQ==?=
X-OriginatorOrg: zii.aero
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e8d0f063-c684-47b6-48cd-08daaaebef18
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2710.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 18:19:14.0322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe9eec6b-f00c-4ada-ad1a-58bc081dc237
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 v7plYewev/+m71cA2j+pCkXhzSYKcP2feSAwRKxYaL6wV9ZK2XxRZ/BjAP+82VFPKqwSytFJ9Eo3yYD/hzFWgMsDWOcIqsbOZmjxnGq4DhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 10 Oct 2022 18:19:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14032


On 10/1/22 4:01 PM, Richard Purdie wrote:
> On Sat, 2022-10-01 at 19:57 +0000, Ross Burton wrote:
>> On 30 Sep 2022, at 22:36, Alexander Kanavin via
>> lists.openembedded.org
>> <alex.kanavin=3Dgmail.com@lists.openembedded.org> wrote:
>>> Thanks, I've reproduced this too using plain python3 and .netrc
>>> with tweaked permissions (e.g. run python as regular user, set
>>> .netrc ownership to root). I am not sure why fetching sstate items
>>> happens under pseudo, or whether the fix is correct, but the issue
>>> is real.
>> My hunch response would be that setscene tasks shouldn=E2=80=99t be fake=
root
>
> Since the setscene tasks replicate things like do_package whch need to
> preserve fileownership, they very much need fakeroot.


So do you think that getting netrc to work with pseudo is a necessary
fix after all?


>> or at least the fetch should drop that power.
> The fetcher does run commands with PSEUDO_DISABLED=3D1 set, the issue is
> that we're using library functions here. I'm not sure we can drop the
> power within a library funciton call so easily.
>
> Cheers,
>
> Richard
>
>
>

________________________________

This email and any files transmitted with it are confidential & proprietary=
 to Safran Passenger Innovations. This information is intended solely for t=
he use of the individual or entity to which it is addressed. Access or tran=
smittal of the information contained in this e-mail, in full or in part, to=
 any other organization or persons is not authorized.

