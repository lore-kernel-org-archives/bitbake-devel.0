Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BA5C433F5
	for <webhook@archiver.kernel.org>; Tue, 22 Feb 2022 11:50:44 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.68])
 by mx.groups.io with SMTP id smtpd.web08.11708.1645530642581422886
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 22 Feb 2022 03:50:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=UFWyXaMO;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.20.68,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPTBX7IwihMMDIPoR7S7/FVKYbiPihFw80ZgHQOfKeokoJYbOlEn5SDJUB9ecGyhnPsCcCeBV4XibPWsDizA00iAICgzt2ZrPlsDghHl9rLBCoiK91w+oGnRCP1OH4OlAwKADVkWJvgy7CjS6KHamRJ3MlR25aKSVyIUXAVWBcTjVnNk73s8Jhs3dzmq8TWtE0cgBrPqTN8qLGG+KjdkF7WMw7Hm/QgcU8iCxsyGth7GhitD01xNkdUWWJXxGDPjZAcIw2nbz/tsRWpD9bUtihiXzjTPB4Scp8lA9Ph1AzJNfWf364j72Tx1bS2F4oK8uWs+F28brix7MlCNGmYZ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftOPVWdCTWY1daG4BxFCP7ph2B3kG+OgL8doiOCfc40=;
 b=ldqw9AwF5B3kbpuxDAqlzZuxlzgSO3WlydlnpPD5Lj5uA5+3awCx0+IqnZlZ8kYEBA8gdgNsba71daJLh8/GqIct+3VIJ9BzYHWjpsEimRq3AB0/PLrD6LcDlJDzDSPonTCRhUkg3PXmyd9+YCm/i9BVrEAp1dn7XMNmv+30C81lGPd57RH9g6TWLCKO3+2jL49Nj8Q34hcxYT22HcxlVa2Y0Q9DwTHE5Fnb9gImlkNjFER8FafhnEckqzJ5houkjx2Qe+PpTXENLuuW/S/oqh9YNZ5lsh+hCm8h9S69Z8mRYniTBGsdk9cdfEVLj9fSqiSwI40pwbHzY/JH+Gg7Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftOPVWdCTWY1daG4BxFCP7ph2B3kG+OgL8doiOCfc40=;
 b=UFWyXaMOIen2I3z+ByuHX06bdyF9vpNjG0wPJ+T23uMCXRcosSfV9sf35p/BCH5jntUpAOPKO3ShyEODbb1lo79a+7wtffdZINMqLj6goVC7ECm8d7tkRy2wLOsgdCEspAcItqNpThr8IpJ1eo+a6I/Q9xxsULFzkuVB2XtmpcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DB9PR04MB9378.eurprd04.prod.outlook.com (2603:10a6:10:36a::6)
 by AM6PR04MB5415.eurprd04.prod.outlook.com (2603:10a6:20b:93::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Tue, 22 Feb
 2022 11:50:37 +0000
Received: from DB9PR04MB9378.eurprd04.prod.outlook.com
 ([fe80::e4b3:c724:ae87:e596]) by DB9PR04MB9378.eurprd04.prod.outlook.com
 ([fe80::e4b3:c724:ae87:e596%3]) with mapi id 15.20.4995.024; Tue, 22 Feb 2022
 11:50:37 +0000
Message-ID: <67fa258b-14ac-0ade-3851-5c632848a396@theobroma-systems.com>
Date: Tue, 22 Feb 2022 12:50:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bitbake-devel] [PATCH] data_smart: Avoid exceptions for non
 string data
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20220222113813.3213276-1-richard.purdie@linuxfoundation.org>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220222113813.3213276-1-richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::31) To DB9PR04MB9378.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f233435-7b15-470b-63f3-08d9f5f98a99
X-MS-TrafficTypeDiagnostic: AM6PR04MB5415:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR04MB541538236A94E4B99588888DC23B9@AM6PR04MB5415.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zCVgcNVdMKaCBwCzH/OMkrjC5kwspjN7Vw4eTH4okWuRlA4hWbowhEMmpOmEmfYj9oUDmazevqIrKmffyOTDMtc87wDUoWIt9cG5iTaPlLHGiQ19RoiPEDKqCTEc2MgW8I9PfsS0JpCbKkn7pKBVRbtIYLqJfeCO+TRLgtY/lgfth9Cr4GmHAuiLsu1aGzNakB7oKf48VWNPYg8qXC49OXme0yIC70TQGPUb9/t5yaQlYdrQD/KMkvvNBP/qg1ES1cvZASf+yuHGa0prymGvh9eRw8jT15bQZJEQP42C1YWSz8+kEXAephV3pgQ+Kd6uuxN3xA6S9gzJiz4yVgZuNYAnmiLgk85lJZibAfDxkLFxapyIXQrUUhSl+ZUIjzeoZKU0qD4YLaY8yQCLliKNXwraeuzGFk34QRU9iiVOHvH07og3dOWs9SswF0cfCPmXvQzFXpy1AWjpIAjufw1KInJ+7SeGZZpuDXsAhcjLu9YP1V7MLBsfo8FzwI/Zm07byZAYQDfSCnyduEh1LWz0bflnThG9xixL8SSfG0CO9Ie31qSjiPhvJed26j8gS3nl1YA5h7Cxg0H2dv5sEVlcgCKlgYuVzkIiAB8Nc2BHyNLECL4+peQ59SMje+6pwG4WFTssogkcfhuZmwqb5EItbOmSs6L7RQqzx0uwjw380zWBf/fQ6/ADEMtGxOPT0CAFb+N/7zyKr+jE3dr/Fe+9tI9LFQt82IysYLjTt7+ex2o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9378.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(6666004)(6512007)(6506007)(53546011)(508600001)(5660300002)(8936002)(38100700002)(44832011)(2906002)(31686004)(31696002)(6486002)(8676002)(66556008)(2616005)(83380400001)(316002)(86362001)(66946007)(66476007)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NjlsOC9iVktVY1ZWYlNmUEdDL0lRc0VwNXppdmQwbmE4OG1vL1NsZVRkSm9q?=
 =?utf-8?B?SisrYXozQnNZdU9RYmEyVGNxVkw5d2VvSVhNeVNTdHNUM3NxeVdzeGQ2amtp?=
 =?utf-8?B?NjZuNk5YMnNKU2NWcVFHb1ZySkY3dElCR21tSG5mMmFMc3d3OHowemJPTGpK?=
 =?utf-8?B?L3p6TWZyK1dwaXFtcmYzTTJRVTZuQjZWbTAraWxnN1gySzRQZmVLRGpSL1Vu?=
 =?utf-8?B?MlVFV1FTY0hIMlRVbGVKSVFrRVNNSGgzamdQMUkzaWNnNnRGWllkS2orTE81?=
 =?utf-8?B?djdrOHMyK3pFR1QvRkhpTFBJczd1L1p2K0hvUkwzSGdORnQxNStSRnJPbDkw?=
 =?utf-8?B?bTMwOCtjR3BsR0lXUG1Pd0xzTGFnWTBLT1FWOUlhbXc1aGM3WTdtWXkrTzJH?=
 =?utf-8?B?OU54YWFIWmdLY282LzdSNGJBV3ZMelZSWDVOME4wckwyZ2MvdFRnWVVNUG9o?=
 =?utf-8?B?YXNoL0p6QUVYWDZkb3VOeWpxcE15WVdNemRoaDlvdDA0QVNndHU0ZUpRSHlM?=
 =?utf-8?B?cVhCOHNVczZKV3hGc2NHOC8yMWJ6bFZVY2QyRm5JN2xxdnBRaVZodnRnU1Yz?=
 =?utf-8?B?RnRRZEdkcjNjSzVId1VvZE04cnltZmRmTUNtZmN2Zy8wMzZjc2owVlpBM0V1?=
 =?utf-8?B?ZHpEQzRJQ2J6dGFCaDdMWjF3alFjMVEza1hBbWtQTm1UL3Jaby95UiszUU5I?=
 =?utf-8?B?YWN0SE5tNkY1VGFLN2VsUHBKK1JNWkxrcENJR0pUWWxHMERtTHRlLzBQSEZ6?=
 =?utf-8?B?M1F3djE5dUZoVWQrR2FKVW8vNTlLa29NVVh2VVdiMytaWmd6UjQ5SU5Id0dv?=
 =?utf-8?B?eDBHQ1prRGlMUVBKdktQZ2k5R3hLY3RwaENmRElTMy9KYk80Rm9qZTB6YllJ?=
 =?utf-8?B?TzIrellNUkVqRE5rMU9ISnVyZTM5RFpMdUZ1ZmJhKzMwQmV1dS9VZXRqN3kx?=
 =?utf-8?B?SFZhNkdTSTVvSFBqckE4WDQ2cDdKaFhMblVCaUJVWXJuT1FOTHJrZEVLaGF6?=
 =?utf-8?B?SzdDVXVyUUR5RjlBK0JpTU1VSkRvMjlBdDE1S0QyZXdLODR4UWQ3V0UyWXox?=
 =?utf-8?B?ZklTamJCYlVZQmpnTnovWEdtZU9ENFk4dnpQZ09yMUsySHN0V1RqcXgzN0Fy?=
 =?utf-8?B?RStibzNHMGxsTXRISHdrZDAvc29WME10UEVCRVNGWmh3UEhyQ1JHbUhqMmhY?=
 =?utf-8?B?NXpod2lwSWNTbGtROERYemFnTDFlT0g3YWI4SzFZc3JXS0ZaOU0xVjJpRHE2?=
 =?utf-8?B?YWRpK1RjZ0dLUzIyMnVuMVc2TEh0WUppZFdsMDFUWGp5eUdpOFhVV2RFQm5J?=
 =?utf-8?B?amszaVZFbXVyRGN3WlRJdmh6MkVrMGVlNjM0K1BiVUdCZDlzdm9IbzkvT0Ey?=
 =?utf-8?B?eHBpbmUzTkRLb25RTmJNWVhkVUczbWFaTTlWcUt3Y2VDTVlJb2lrNUVDZEJD?=
 =?utf-8?B?MU95OTRSYTY1RzBrNjd6UEhBbzZqcHRYNnF2ZW1hZGdaUmFIWWNsMHY3azNi?=
 =?utf-8?B?TzhUYnlPUTRoR1kySnlLWUFFZFNVTC84VkRiUGNtTGd3SU12bTJXSGMwSW5H?=
 =?utf-8?B?cDJMcitaZjI5bUUxNExiaXl3QllLc3gyQjlTaVdiazk3TkFlNWNjM25mTTBn?=
 =?utf-8?B?NkdNWWlRaktXUU1vdG41YzFVSHVBUVBUcGxJMThCUmF2T3FFNlpmT2R1ZThl?=
 =?utf-8?B?ekQ4OFBmMjhPZjlzYXJYNkEyUFIyVnJhTnRsbGxyeWJGTE1JS2xpMTFjK3Yz?=
 =?utf-8?B?UEFnaVpKVnBYTy9XSlFUdVc4SGtoT2Y4dW5neDhoSkxjVVVRS0RZUFhJQThV?=
 =?utf-8?B?V21nVlU2N25RRzByTkVsTTBmTGVTeVVNZDVCcmZZSWpqbkJpUmhGdzFscGRK?=
 =?utf-8?B?aFlXekpTWFZtYXlZSi9wbVhxc3RwM0RHM2N0VkswQ0lYUnJBaGllNXo2ajNR?=
 =?utf-8?B?eDRNYlpNZFNsM1g3bExnbkRtK21OWENGMW5ZOE1zdENJZE9sbGowVTIyQkU5?=
 =?utf-8?B?N0E1TUtqYmNvLzVKZCtzMURYL0ZYQlFHdGgwV1MrZnlseW9iMDhvNG95bmh4?=
 =?utf-8?B?U2Q1REVFcktQYVp5aWh5QlNxdXRwaThlc0c4aTc0V2pxdU11OXBBd3ZZb21E?=
 =?utf-8?B?Q0xYSXQwUGxxblBwWDl4SDErTGZiZFErZzEvVy95djY0RVZCZExMd2pMMDZz?=
 =?utf-8?B?ZWNGNG9scFppOTczNjlmbFdRbHZtNzhacXYxOTdOMUN6S0hKV0JLbGU1UFNk?=
 =?utf-8?B?TWJkZmZWODF4dnp1VnJiTjIzdUs2eE1sZk1KQ1c5SUlpemMvVFhJWHhkMUJG?=
 =?utf-8?B?di9BVkVNMDgxOE9qRndsQjQvV2k2bklLL0hjRXBvLzNTWmZQMHRSTkhadGtD?=
 =?utf-8?Q?niYjWly2KMdij8pY=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2f233435-7b15-470b-63f3-08d9f5f98a99
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9378.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 11:50:37.6242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 CS6M1kCShBBRz9MJBxpohVVdOIi7pqR5C0cR9RVkQwQGBgkrWizpTh6cDI/hLr8kZWzwFvTFmhPVi94vDwX5Q3QF8XfOdyumd5km05ouhkp4JGNMvKuistlUfIZkcJcE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5415
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 22 Feb 2022 11:50:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13398

Hi Richard,

On 2/22/22 12:38, Richard Purdie wrote:
>    File "scripts/lib/checklayer/__init__.py", line 49, in _get_layer_collections
>      ldata.expandVarref('LAYERDIR')
>    File "build/bitbake/lib/bb/data_smart.py", line 1007, in expandVarref
>      if referrervalue and ref in referrervalue:
> TypeError: argument of type 'bool' is not iterable
> 
> We inject True values as an internal sentinel to the datastore, fix
> this codepath to handle it.
> 
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   lib/bb/data_smart.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
> index e7047d79ca..8d3825f398 100644
> --- a/lib/bb/data_smart.py
> +++ b/lib/bb/data_smart.py
> @@ -1004,7 +1004,7 @@ class DataSmart(MutableMapping):
>           value = self.getVar(variable, False)
>           for key in keys:
>               referrervalue = self.getVar(key, False)
> -            if referrervalue and ref in referrervalue:
> +            if referrervalue and isinstance(referrervalue, str) and ref in referrervalue:

I assume we can remove the referrervalue check? If it was about 
protecting from None value, isinstance() will return False. If it was 
about '' string.. it was never needed in the first place since it's ref 
in '' which would always return false (provided ref is never '' too, but 
that was not covered by the current condition anyways).

Otherwise... can't we just have referrervalue = self.getVar(key, False) 
or '' ? so that it's always a string?

Cheers,
Quentin

