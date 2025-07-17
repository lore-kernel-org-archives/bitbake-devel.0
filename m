Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8EFC83F1A
	for <webhook@archiver.kernel.org>; Thu, 17 Jul 2025 12:43:04 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.42])
 by mx.groups.io with SMTP id smtpd.web11.48182.1752756182205166920
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 17 Jul 2025 05:43:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=bdd/Ul6c;
 spf=pass (domain: cherry.de, ip: 52.101.84.42, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=srWzVIlh+YucHWpbRerkN5raXpl/2ARW4cfd2Hh7gfqm29wFJJ4NvUE2QWcNqAgBThSsBweHE1YMyMGpIQ9p5g3h6blLnYfckUmvckGpHk1WgsPD/A+zrleqFoaQYf/QSyXEp3SthT1c01oC6IQ3RJFqqGG86f+QD6uD5NlcntYHuLS1WmqYO9AEvU4wBGPInUgFng9xE0R90wUll7yHFHinUNKv8ltw435TECx0JzrfcjakOfGCt9WgDkinBt0PYOKWvMQh0XYtBZSttR3F+fBmXp0ZupTEErmIzFNna342bUB7gJcP1ZAMFMo5o/wuwOzDZIWY7GrANedYOwMEKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ENpbowSuME6QLi/twqjn5WdAa6a4EyLxI3qcwBmJFf8=;
 b=ihzPH0CnRRp0xHIiax0wtIi9vEuEmiloh/HEek8Oh7g68lVxQ0S/kNXITCHKbBz65YC48ZCfV33OlzsM5008H4MCcfZtk+eiWcbJBqQVmDU1pD8Aou+9bEYw4ruJy8LtjHVHlU4CSHggEcINR8nw1QCuDBdyvp5whrRgL/QUhxgMZJCqFNKMMpTvskFqHVgtDvNMPsM4kWFXhqxvWxJ44WJRVumxkKtxFw3r/PiAso6P1ZWCYK5HQl9eYBrH91hm9irtEFHKb+HE1Q3ZTpXqz2OUCGFaCVaD14gGOu2jwf2xiWN55WU455jFjQ48e1ueLuVzOg3Z9Pu35vcoeG0uOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ENpbowSuME6QLi/twqjn5WdAa6a4EyLxI3qcwBmJFf8=;
 b=bdd/Ul6cE48QPZnKi4EjcVqJZYvLklUGHuWoQIKHe80/cV82kXQJCHQ4wGwuTD23/CUfAkAfUB8jDSCwQvk0+cI8UEKXKYAg/jWNWYyKllNnDECScm8zXd0P5gf/LHAsvEd56mpN1tVRj49PYtz47W/qSycDx8CpGy9LE773E+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10659.eurprd04.prod.outlook.com (2603:10a6:150:214::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 12:42:56 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 12:42:56 +0000
Message-ID: <d278b11b-6ca6-4841-8a29-659632648678@cherry.de>
Date: Thu, 17 Jul 2025 14:42:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] doc/bitbake-user-manual-fetching: update
 the Git fetcher tag description
To: antonin.godard@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20250717-new-tag-git-fetcher-v1-1-77e46929103b@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250717-new-tag-git-fetcher-v1-1-77e46929103b@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0028.eurprd05.prod.outlook.com
 (2603:10a6:803:1::41) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10659:EE_
X-MS-Office365-Filtering-Correlation-Id: 599a0742-0756-4e2d-5b25-08ddc52f743d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SHdWb3ZzeVVMWFM2OVZBdFMreDB0MVhyNUNjL0Fra1pOd2RiWHBhTGxLeFJu?=
 =?utf-8?B?b2x0TElmRVB2dmFIWkM2YWM4MlBUK2xqWlYrWGhjcUFvSkxCNVJCTmJPelAw?=
 =?utf-8?B?VDlsbkxvcHhET1hRUExLdFdtSnR1YTBCTlF6M0x1bVRoUUI3eGJBVWhncC9t?=
 =?utf-8?B?QTdXeWx0eFRlWDVYRjVabURoYzJjQnJnUjV5L1FQMGJ4UEJIcXdKWk54OE1J?=
 =?utf-8?B?NEVIT3RLd1htWTBPRUhUQ2VHVWtJbWEwWW9KbjQya1dqaVVRTVFSY1RNa1dn?=
 =?utf-8?B?VnRYQmVmTzk1Q2tETnIvczlFKzNDd0s2YXNTNDVpY3ZVQ2VWemRvVkg3SnRj?=
 =?utf-8?B?c3IvVWJBS2xqekFyeWhzVER4ZnlqZmZPVU9vTEpSd1RNeG1tSGtjU0ZEY1c2?=
 =?utf-8?B?d1ZkK1JnTmJmTWcyWnNBVFdBTXYzRDl4UXQ5Q3NNZWhvM3hJV1AxYWphRDRz?=
 =?utf-8?B?akxXU052bERURHUxcEZFUFR2ZkdnaDlTUHNTNlQ0UjJhWEFwUlFkNXlMVGdj?=
 =?utf-8?B?MWZYY1NTZUVZa1hWTmVZSWdocVp1NUVJT25SYmRzZDN3ZnJ4WlR5NERGK3VG?=
 =?utf-8?B?bmVtZWtRaDNoODJ6M2hiTjFaYnYvaSsrWGRVZDhlSTdwRjdwYWFnTmFwYkN3?=
 =?utf-8?B?Y3ZvUjJTTlFrUG5SYUVpUG1TSEN6SHljcENHODA4NHJFS2tsdkhlaitrNTZT?=
 =?utf-8?B?elpqVTlURDM1M2lsbkhlelZYV05OQW92OTRHMnNPUFRHRVdZci9BMENQejlR?=
 =?utf-8?B?bEZibDNlVkVya3VnUmwyUzMxQkFNRDAycEtUa0FpRWwxSE9pbVFlVXRGb3lT?=
 =?utf-8?B?V0V4WGdrOHc0UytlN3plUWtXUEUwdlkycXJIMDlqbmRNbmUzZGRlVzIvTmFs?=
 =?utf-8?B?ckFVMUo4R0VZZXBjelVHV0RCNm9QdUxSZjR2S1FtdmJ5WnhOeWp4VmU2cE51?=
 =?utf-8?B?VlNtSkczVVM2bGdqZEZ0R25heWRCNDlrTFRoN3ZmUGxKSGUvNU1SbE0zd09o?=
 =?utf-8?B?aEY0eVUvc1AvVmVUdDRYeWJkUHZ5ZUczTFVFK0FUbFBPRmcrVlJjMFB2N1RX?=
 =?utf-8?B?VTUxSXV6ZWVjcEl2SWlEaXViVnlvTUlUWlgzWUExbkdEdS9RdTEzTEVJZ2ZS?=
 =?utf-8?B?b1h1TkVFVFdMOWRkcWhWOUdLSE9ISThpRTJScXh0b1J4THFnK0MyMmliOTlF?=
 =?utf-8?B?UDFBMk1nZU9DZENjdTZZRnFqZ3NHejFMOTZyTVM5Qk1VdmZRUzZuTHJsN3NC?=
 =?utf-8?B?OEJiSHF4WG5aa2QwSHdwcDFicVg4K2xxUC9SZVV3aWZ2VUE2S3VnYk1RQ1B0?=
 =?utf-8?B?MVpOR0I3T1YyRGF0Y3NFTWFSZHdJVUxNVTFrVWUyS1BPZzZXdFVHY2RlTTht?=
 =?utf-8?B?YVBBK0FsVVBqREpKWk8xd09NYklLMWd3akR5NmRvUWpnQ3ViUG9TcGcxMW92?=
 =?utf-8?B?dUN4UVU3VVlLZFROd0QyK2FUbjhTaFQ1QWthL1V2aGFGcHhGR2lRb3JGZHFG?=
 =?utf-8?B?eXp3WVZYZ3FSRENHR0RjRzFPWGVoYTdOWG9zSFRWL0RFM2VVOE0rL202czBP?=
 =?utf-8?B?aGpVNXpGRjFoYmFVUkN5cEErVCtWMkVDQmplOXlISktTMWFNTnMxeWVSTXQ3?=
 =?utf-8?B?aldNTVV3Nm9iUmtOZGFFYzlPd1g2aXpjTlpqOENzTUc0b29RSGV5aHcrN04w?=
 =?utf-8?B?Nlh1YWZnOVhtYXQvaGMwREdFM0d6M0NDYUROL3RVUVlZK1lJb2xBQW4vRmQv?=
 =?utf-8?B?UXNGRTRaM1Y1WkZ3THlmcmJCSkF1bmpob0xVTWdQM28wbXk0YWVPaFhBbU5G?=
 =?utf-8?B?QUV3aWtvT3ZmcGswOG51UjhHb20rNFloa1RITjdLblNvcllOWUxaZGlqeWVM?=
 =?utf-8?B?NUM5YmRKUzYrWE1pSHIvcXhWUjJPZ01OSFRDSTRFYTZtVTVvOFJ4cjFJOGFU?=
 =?utf-8?Q?jNY4ujgQ0Mc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c2wweU1NYzBZNzZIMEU2RFBBTHR1T3hNbllYa1grNnRVVHBuYWR5WWtzVXFk?=
 =?utf-8?B?QlFjMjZjRUFBeVRQWDF2Mzg1Z0w5M2p6WGJ6Z1gvcm1tcHJmd1BsY1lQTjdn?=
 =?utf-8?B?OWlKZlJibVNsc25CeGV5K2hLVm0zZGxWRGlleUdBTlRTV3UxZDBhd1liMTF5?=
 =?utf-8?B?VDZ0VUh6OUNteGpVcWZkR1FTVW44c3phQUZsM1J4SmtOY1VrczQvekx0ZUs5?=
 =?utf-8?B?S2RQM2k4cjZQTFhIV0U2emVHUjIvSUdHTVR4djQrK1dzbkRhMzU5eTBocVp1?=
 =?utf-8?B?TFNlMERaOHV4c0hKNjVWSnFFVVJjUmpFUkxnNUxDWWdrRUFSa3lGTFNKeDB2?=
 =?utf-8?B?enVwVXh5N1ZURXBjZ1NBYzZ1TjFwR3BHL2FIZS8zTWZqQk4xMnN2YjhxWDJP?=
 =?utf-8?B?K0VvL1Q3aEE1akwzRmhrRGpuQTBmcjMwa0dWUlFCTXBiNmgzY0I1SkxnclJN?=
 =?utf-8?B?aStEZWx5TzV4K2FlQU5laHh2RFpXeHBzU3d0ZzlJNU93bzg3aHhNYnVWeXZs?=
 =?utf-8?B?akRrWmtHbWNOejNIVUtYWnU5dUhuYUFzckk5QlNsL3poMzVlSlZjeERBcXY3?=
 =?utf-8?B?QXNvdDJCRFFKcVY0OG8wdjBFcC84SmZnQmx6QWRRazBHWEFCUWVjT251SVpZ?=
 =?utf-8?B?MXIrajlaMENDSGxRVm9VK1hEcFVLaFRzWWswalFIK09sNjI4bTVOTElLdEJ5?=
 =?utf-8?B?Z1U4SjJySzh1SW0zc1BxUFJFamltQnRYZTJUQ0VPU3hEKzZZZjZhUHZNNXNL?=
 =?utf-8?B?ZERJbUFHQ09OTWdSNFhUY1VVdDVuaHhzN2QwYW9mT0hnWGFUL2lFZWxBeDVu?=
 =?utf-8?B?TVFGMmtCb3M4eXFaajVxOFEwUkM4ZFJERzR4MEZHZm1qUWpRWk5iWlpNUkJi?=
 =?utf-8?B?Zmo1eWtwcExzWFR6aWlZM2NreVhaSkRKR3JFbkg5Ly9TYWZHbnlVOFdjVTAx?=
 =?utf-8?B?RHRkZVlkVUU5TFVXd1YzNHpKQnB6enFqMUdxRGxLZUpyTWZmc0M1MzVRVUsx?=
 =?utf-8?B?NmE2eFp2NHRCU0ZkVUJLNkY0ZUR0bHBvQS96YjJhTkdHOEtFWlQ2Rlg3M05E?=
 =?utf-8?B?Ry90eXBoQ2xNNDgyTExxVGhPblhTMW5sc2VveGZ5bnA3OHZUVTZrRzVVdEpw?=
 =?utf-8?B?SnMwNy9UWWYzWXF3NUJqZm5rNzBIK29rYTA4cUhWNzdOWnljcmpNYytFOXM4?=
 =?utf-8?B?M1JvZ1Z2ZUdxclEwVHRjUk1MVldaUm0yVEhvY240R3NaK0JLSUR3U3Uva1B2?=
 =?utf-8?B?QWdzRmJ5K1lwZzZKdjNpRG54OXRwTHE1MnUvcUhvS0kwRGt2ODRnNlJ1WFg2?=
 =?utf-8?B?V2llWHJJMmFlL1pQSGpiTFBxVXdxajFZUzA2cThnallzV2xiMzBIbGJpcXIr?=
 =?utf-8?B?VGFvdmNvenVUNHZlWnhKK3ozU0NnQTBndEt6Y1NvcmQwcUJFaXQ2TG1CbVMv?=
 =?utf-8?B?OHZGcVl0ZHlSWno0Vm1Ma0tNNFFjdGJ6SVRqazNscW1kRDVDUVdLdW80ZXJt?=
 =?utf-8?B?bjNYdHQ4NUVJUXRTNlB0V2QySWxyYWU2NXVEMHlXODhJU0J1eVBTRWFGbXp6?=
 =?utf-8?B?d0J1Qld4bmJtRlc2b283dzZEbFRzSUlHWGVQb2NqVmduUUQyMlkrS0pHVFl6?=
 =?utf-8?B?N0taOWNFMkdiNWNUMlZGNzlPSWhTTHJQLy96THFiRkRLMTR1YTNlTHVERUNW?=
 =?utf-8?B?VGI3QmpHeEZIRWVXeUhUMXhERHFOYlRuWGhoRzJCQllQZTVVRGxCT0tQN0ZS?=
 =?utf-8?B?ZDQ3YzBLL2JvSkFyWnVvZDNkblJEcTBrQW5RLzNGakY0QkpoQ0ZqQ2NGMGo3?=
 =?utf-8?B?NitPV0ZwUGtuU3g4eTgrc29vQkdYVHY4ck54bHI2dFFvRkRVOWJRcFdaSDVu?=
 =?utf-8?B?aTcrTzhYekIwVDFaeTc1Z3lscDJjRVI0TGtyNzlibkRzL1Nobi9WVDFyay8z?=
 =?utf-8?B?cE9NRVVESnlFWVJlTitYR005aVpPZ0Y3N3prZFRPTkJjOE16NTFSaWRwUjNJ?=
 =?utf-8?B?OE1HZk5SdTlGT0dXMHBjejAra2Y4eHNMQmJVb2NvNzBHN3JIeU5Lb1J6Y2dq?=
 =?utf-8?B?VkNEZW5FMDJGbm1WZzRwWU1qcm4yUkc2VnVNMlp6OWh6N0lZMnAycDM0a0d0?=
 =?utf-8?B?bi82eWkwMFpxZUJBZno1OC9hUHQxYkFUSGlrbWRValNlbzhkM3VkTlZwa2Zh?=
 =?utf-8?B?aHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 599a0742-0756-4e2d-5b25-08ddc52f743d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 12:42:56.2476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6fD4yJp0vxPDY9slnZx0gBoQdN/DrI8IcdkAjvw0wlpDVY4myTyWidwBEomD89eF3kfXtJAJlV4lz2YDapClfTaMuonRgITtCImnaMvKXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10659
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 17 Jul 2025 12:43:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17784

Hi Antonin,

On 7/17/25 2:23 PM, Antonin Godard via lists.openembedded.org wrote:
> After commit d591d7633fe8 ("fetch/git: Rework tag parameter handling"),
> update the description of the tag= parameter for the Git fetcher.
> 
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>   doc/bitbake-user-manual/bitbake-user-manual-fetching.rst | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> index a2c2432db1..b3fc3ce72c 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-fetching.rst
> @@ -439,10 +439,11 @@ This fetcher supports the following parameters:
>   -  *"rev":* The revision to use for the checkout. The default is
>      "master".
>   

This seems... odd? I thought rev was supposed to be a full hash (though 
that probably is me remembering SRCREV instead?). There seems to be 
tests using it in bitbake/lib/bb/tests/fetch.py so I guess it is valid? 
Not a clue what this is supposed to do though or if master really is the 
default value?

> --  *"tag":* Specifies a tag to use for the checkout. To correctly
> -   resolve tags, BitBake must access the network. For that reason, tags
> -   are often not used. As far as Git is concerned, the "tag" parameter
> -   behaves effectively the same as the "rev" parameter.
> +-  *"tag":* Specifies a tag to match against the supplied revision (``rev=``).
> +   This does not replace the ``rev`` parameter: the ``tag`` parameter should
> +   only be specified if you want to verify that the tag commit SHA matches the
> +   supplied ``rev`` SHA. The ``tag`` parameter is not mandatory to use, but

s/not mandatory to use/optional/ ?

> +   strongly recommended.
>   

ok so I was clearly not aware of that change and got surprised by a few 
of the latest patches on the ML adding that parameter.

1) I've read on the ML that it is possible there may be a difference in 
behavior (or even an issue?) with annotated vs lightweight tags? Would 
be worth checking and specifying this limitation if it does exist.
2) Since this is a change in behavior, we should probably document that 
in the appropriate migration manual?

>   -  *"subpath":* Limits the checkout to a specific subpath of the tree.
>      By default, the whole tree is checked out.
> 

Finally, this is not alphabetically ordered so we could take this as an 
opportunity to fix that oversight :) mmmm but reading more than the git 
context shows that most aren't ordered in that fetcher so... maybe for 
another patch :)

Cheers,
Quentin

