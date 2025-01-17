Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73E2C02183
	for <webhook@archiver.kernel.org>; Fri, 17 Jan 2025 12:12:28 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.28])
 by mx.groups.io with SMTP id smtpd.web10.9436.1737115947682497213
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Jan 2025 04:12:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=ibH3dxba;
 spf=pass (domain: cherry.de, ip: 52.101.67.28, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9DiZkFhssT0K9pniBuGnOT8VMdS7PiKpNlYvIMzo/LTXiEBjBh0pG8HxXMEnjEu1Mb5YWXmUWWz3SBHkhS2/SoFHQMxi70CmW8blGKL/u292mykoWGe9B4rMaVtRvrJwdu9p9vkRHIHS0gpU7z0py910VqKJ4fsms77qq4zKpQT+aVkkyluI2BgRyicTVPVE6AUcCh+DaUJXwMMYmwbzfc8Rp/gvBabMOs7iPcwR7qLeRI62Fxui57rn9/kY3DSsuolsVyUJuUvZ5Pqdqd2X7cDQsZSYFiLkPocNpgrFKwjngmcSF5gURKM899bE5UKMqvNQbyztCGkXYCuFPO+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2+Op+R7aLe3D6uTxTd41FAt7AQ+KVTmMshZmFi84Ak=;
 b=KKWoNPS72YE1BW1M70VxSWu82taaUo5n3IZKAx9YFlIO/qIHHj9oj3GWm6PMEIlwvoYjUGolvzJJby5mMFHYWvucLjtLr5z56eohpJUs92gA3/MvHr+yIlvWtPXUm5DrU+8nHZRhLTcz/JVmp7NYPWL39+eLLHJGYMaVwYSu1F0VaPc0OnmcVvy0lrKaMyYoCHhJBrQI6PW2Wamav4bv8UKmrarLEJ19ROuEK91K+WHPFDtoy7VtEmYbNjIOWvFmi/ZPyIQDPgzE9uZSTCrkDh461MjDjtHo9tkISMc2k9ZiAkncISW4dCgTYBeZ7aMjbb8QUIKNaWGoWko+fI6xtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2+Op+R7aLe3D6uTxTd41FAt7AQ+KVTmMshZmFi84Ak=;
 b=ibH3dxbadBqMZwSUOFgQdppLH6faguuDgO1OB/3ld5DjcYgCswSV5tuvVGx9TyBBUCPq/OrW8AquE86LxTkJK6nYuEnNxZr4l9BwZh++7zgJeqSqJmLJTiAj/XVDuQ9DDJ4CKl4W/W5UrgRdhn0wbRWrxHgY20OyepnXf1hudEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB6845.eurprd04.prod.outlook.com (2603:10a6:803:138::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 12:12:23 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Fri, 17 Jan 2025
 12:12:23 +0000
Message-ID: <42691b8d-f2d4-4219-9b96-800f8e34d201@cherry.de>
Date: Fri, 17 Jan 2025 13:12:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v2] add basic support for b4 contribution
 workflow
To: Antonin Godard <antonin.godard@bootlin.com>,
 Quentin Schulz <foss@0leil.net>, bitbake-devel@lists.openembedded.org,
 docs@lists.yoctoproject.org
References: <20250117-b4-support-v2-1-7178f61d49e4@cherry.de>
 <D74APENZ2FY4.2W3AXB39KKQ1D@bootlin.com>
 <48f94226-eb4b-4d7d-b007-d7b57975a59a@cherry.de>
 <D74C4BKUYJJM.3ACL3B4JKCQP0@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <D74C4BKUYJJM.3ACL3B4JKCQP0@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e42179-50ff-43fb-ebf9-08dd36f032cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cVB1eFcxOGM2SGRtS2JLaDdMbTdKTTdYYTJvZkY5UDlJSUI0SDFQa0UrSTBO?=
 =?utf-8?B?MjRacytyYjFNK2pQS2hGd1VtUlkwek5sUTZxSFd5ekt3Zlc0TFRzcUdHMTV3?=
 =?utf-8?B?TEpRbjF4WnQ4S3J0dGFxWHJDWXFnUmdTM3ZmVEc5blVINm12bm5BQWVEVjFG?=
 =?utf-8?B?Y0t5OFNjRmhuRnVSZFh4QlNFcVJVSitrVDZHQ1RMNG9MeExGaVo5T2lNTExM?=
 =?utf-8?B?NlYzbCtmelBzVW9rcUd2RVhSWnZ6cGFwK1BOMXFVcTY1RUVudVdDSC9hckRN?=
 =?utf-8?B?SlpSbk15WWZycm9aZ1hoK2NUQXV2dFh5dm1sK01WUzJ5NWZwVW5PaDkwdlBJ?=
 =?utf-8?B?aUROOWVOOCtYL1p1cWNQc0l4eGhlKzhjSkNlMVBjeEo1dWVTL1ZNd2xFOHN4?=
 =?utf-8?B?Tk90c1F4Znl1b2k1NnpCWXRHbkF1dGw2cC9NWlo2cEVSN1YwZEJCNStPOEhx?=
 =?utf-8?B?S2dWQXpBSmd4YnJEMnNGbE5nWEJXTk8wSi9KcnlqQk1wRU9FLzl6U2lZbjMv?=
 =?utf-8?B?ZWRtUFQ1ZzAwaFk1dkc4cFROK3FOd0pVT1Q5RXIwMU1HTS9KN0tDU0xRZEtR?=
 =?utf-8?B?cUJaMU1IMWNab2cxMFdSL1FNczFqRTd5OFBnS3N3cUUvREZjNFRqaEltay9F?=
 =?utf-8?B?T0N2NmlGV0lIdERxb2NZQU5iMzJiUXYzOHFEa1FjSXhtSTR6MnRRQTFpaTQv?=
 =?utf-8?B?ck03dm01RjE0TmFkcHdEOHc5Vm1wVzhjTTJzVncyVnp5SjVMLytCRDMrenBx?=
 =?utf-8?B?V0xXM3RYeG1kODBqWE1GSU5uSVRObHFqNEtBdFNpcXA0SkFFOTFVRXl6Qlky?=
 =?utf-8?B?L1hpNHFJZEQrVTJxdXprMFFOVmIxQkc3dHFsakdNc3lNYWF3VDlsRWNPTnNm?=
 =?utf-8?B?MkpBdnh1UWlPTFdYRWxsa3BTaXhVTFV3YlA0V0ZyU1FxVDhoYm5zZHE3NUcw?=
 =?utf-8?B?bHpGM2t3MmZvZXo0TVJoZlp4RjVPa0U1NnJ2TW5ld2RhSnYxOUQ1OC9rYXJ6?=
 =?utf-8?B?eTY3NzV3UnVpQktocE9VQWVMWStGcmNJVGg3dzkzekFRQkk0ZUpvUE92Zktx?=
 =?utf-8?B?R2VFczBOaGVFUDVtQ1NUK0NqTmlnM0Y2eWxyaXgzajJ4TXFzK3pLSmVObFhu?=
 =?utf-8?B?UGswakJkMTdDRll3NWRFZWhTRmxyUm5xdjRZUGZWSVVHejlIU01peG55SUpq?=
 =?utf-8?B?TWFHNmg1TlhKcmtHZzN1MGZtWTlValpidEN1ZFA3NHZYWjZZZEhzb0x1NXRh?=
 =?utf-8?B?VzNOYmVBZ0l1T2tYM1dYUHcxcmFtNDlodmxlZjJXSXJkbWxhRzlpK0pvdE5O?=
 =?utf-8?B?YnQ4VzZ3Y1h5ZWxOb2J6Q3Zud2NFTU5CRktwcG5pL2NzUjUyZ3lkTGw1N2lk?=
 =?utf-8?B?bkhVeFdidzQ5NWd3ZHV4T05LSWdCNzB3Tm1TWXh5cCtiL0pxV2V1OENYdkZs?=
 =?utf-8?B?SWtxbTFRdGs2RjBqTEtyOEdIZ1lsVzJQVGNPc05ZSGF2a2pvb09ENmhWcGdw?=
 =?utf-8?B?NEJHTmZsTzZGVXlvZWVsVURvL2Q1eXBVSWNML0tJWmFWWlJBV294NE41RHp1?=
 =?utf-8?B?QjJvZmZxaUQ5VmFLUCtMdlVkYm9wVnpwVG52V0FDL2IwSjczdHpTL3NWazVK?=
 =?utf-8?B?bDA3dWlGcEw4Y0xlOVdOekFWTGZJdEJNU2RPUStKSEhaLzlMSWNZbHFhU2FB?=
 =?utf-8?B?UnNMNk9mUWdkaGtudXBkK0dQMTU1WEFPSW10TVcvQTVOMFdwMlJFcGVsSm9B?=
 =?utf-8?Q?M5ec/J+0RRZeWVt/EFph/9wTAPm6idTScycChcF?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c21KczhjYnFJL3NpZEFWOUx4OTRibVF5VFk0SXo5V0huWkl2YnlkTWY0aUtr?=
 =?utf-8?B?K1kyRUIwK2x2cjdTenBXYSsweWE1b01TK2ZYc2FkTWI5MDNwNXQ2Z3RMaUlN?=
 =?utf-8?B?K25VcmsyRmhMZllseFBidXRtZzA2RHl3VW5uZkpUZGdmSXB3NjkyUjBpNUNw?=
 =?utf-8?B?RW1nY0FuWWJFdW1WRmZUdDFUNEE1aXBFYXpYQ1U1V1dxUEhVQUYybWxBSzhP?=
 =?utf-8?B?MnE3UlIvMExTdDRSaHdFWW90dmtIdnQrbjBFbmhidS9DM2cyUStJVVdmSXlG?=
 =?utf-8?B?NnBUV0xqMXcxWHdDL25YcVc1ckNvbU02bkRmenBDNGJ1eHEzTUR1ZTdjS0lF?=
 =?utf-8?B?VXcyd24yMnltaHVaNnJpNTRDWE41QzRVSGVGc3ExVm5IdXhMQ3M0aTJLZldm?=
 =?utf-8?B?cy9GN1FJWjZpWjJ2b3RnY0wrcjNKVmY5QjNYVXJMQmV5bkozRVBBbUI2R3Iy?=
 =?utf-8?B?YVA2VDlmV0ZwVk83VHplU2JEYnJQRE9oNnRYRkpUYzM5ZTJBZmFpM29oVkVn?=
 =?utf-8?B?aDl5OEorN093VjFlYW0wWE54dDRuYTNwTFBjYVNpVTVpMm9XSHBEZE1MN1U1?=
 =?utf-8?B?M1VpY0JCaDUvZ0JaSldrZUdqK2pnb0hWczJwZEVJdFkvZGRnNUd6azFISXJS?=
 =?utf-8?B?Ni9LQ2VJazBYQ2lMK3dkeWVZV255RTFEc1NSS1M5VURBSzRsWkVlZFRaRExw?=
 =?utf-8?B?Q2ozakJwVlpDcmc0QlIrMS9KWmlyVzN6WjlOd21ObUhVVmwrUTVDWDBWWXRJ?=
 =?utf-8?B?RGdndVFLcThKeFNod2xaSFdOMVdwTlFhVjJqRk1nU1BYWmVpR3hlN3ZhTXkr?=
 =?utf-8?B?VE8vdUlBa0hoU2VFc2EzMjJrTkxJQnRhWjNpTk9OR21CcjFtbG5TcWlWUmZQ?=
 =?utf-8?B?MnI4N2dYSWJmelZLa3JLdDlYQkVkZS9kU1IrR0oxR1M1WktqOVZ5QlFraUdk?=
 =?utf-8?B?dUpaWjVLWDJ1YS9zdFJoQUdBZE5qZUFMNWVCa09BMEZPajZIeEo4VUFGVTFJ?=
 =?utf-8?B?VGI3TGRxMndRU0Q2dUZNWm9DQVcrMWJBLzlidllvUGptUnRzME1RTEpvS1dr?=
 =?utf-8?B?MExXREhhK2w1WnlqZ0Y4MGNzY3pVT0xQSlF6TnhoT202eGlTTDQ5cWplaTBh?=
 =?utf-8?B?QlJoUTNFTmFHU0ZzRmVFcklKQjU2RGd6YnlCai9uZlZOMExOZDNGODVsdlhp?=
 =?utf-8?B?MENrUWErRXkyWDB5bzJIOHRzbnEraG1rU2FReXZyMWxuQURCNS80WEZ4aStn?=
 =?utf-8?B?YkQzTW1WUnpkYS90RkVZbHZZcmViVURPNGMyc21wcXNDUVRBeUJyRDBETk8z?=
 =?utf-8?B?UXhkWVRaODJ1TllNNE9ZNHY2eEJnRnRyUXpFWUFkbFNPVEJNQ2dsNGRabmJt?=
 =?utf-8?B?OFA5MXl3Zk9Sa2p5Y1I2N3Jub3NlRjA1Q241MDVZTWg3enlWTlZyUWZ5M2oy?=
 =?utf-8?B?c1hBWFAwQnpqSHZiQXVZajB1UTBjUHQ3TllxL2xHUFROY2xIQjIzcW04bWs0?=
 =?utf-8?B?MlhsMjdCY002UHRKUXVBb29FU0xzU1NRL1VuVVNkK2R3RDZkQ0FCaWU1QTRp?=
 =?utf-8?B?dks3L2VtQ2tkc2VpMGZiVTlsMkdmVzFpNmxNbzJReElOSGppRllDVjhhNXo1?=
 =?utf-8?B?R0xYRHZuRVk3MDNiK1l2SGlHWlpGTHhjcWx6dFVkNUtvZlZuK1lMaEhDMmhJ?=
 =?utf-8?B?dEJyOWNCd3V3MWhpMFdWeW9uODl0ME1ZbzJRdm5FZS9BZGtabURHcjdQT0Z1?=
 =?utf-8?B?RlNFdDY0RnVWNzBUMm1DV0NuRmhtMXRqMktqYnRXNHJkQXlxYTlSeThnM0VX?=
 =?utf-8?B?WUFJLys0TE5DLzYxL3E1ZWo5VUV2OXpqb241eWpxaFZkYnhkVWdodTdIanFR?=
 =?utf-8?B?M3YzeWZmbU01SzRuUFhDQXJqQkRqcGd4T1VjY3ZrS2JqRE84WlZZMmt6NlRB?=
 =?utf-8?B?S29CSTM4UUJUc2tQcDI0c1lteWltNjdLcWxQMFByckY4U0hsQlo5SG1mNm10?=
 =?utf-8?B?TEk1Y3ErNCtFRXo4WFpmWkVRSHJ4amh6R3ZGU0xSYUhPeEl6M20vMU5uYm4v?=
 =?utf-8?B?bUkvUWJXYVBSTUNJeVNTaC9zMWplMXZTejVaNW5yZnRldzRDTllXb1dEbDF0?=
 =?utf-8?B?R2xVYVVaT1Frak1GQTFMTHJGQW9QM25HcXIwa2JvMnlKaUkrVjRPU1NIVnVK?=
 =?utf-8?B?L3c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e42179-50ff-43fb-ebf9-08dd36f032cd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 12:12:22.9655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DHl/4R+3VncyvaUvrcbYhK947kWVPRL299zDqqMntzRDJWLJa1AwucZHEEENv/hhqp7051i0so7wcxTWAqqgyCEj4ke25CPRe2AEO1Sg4TY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6845
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Jan 2025 12:12:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17027

Hi Antonin,

On 1/17/25 1:08 PM, Antonin Godard wrote:
> Hi Quentin,
> 
> On Fri Jan 17, 2025 at 12:43 PM CET, Quentin Schulz wrote:
> [...]
>>>> Note that b4 supports patchwork, c.f.
>>>> https://b4.docs.kernel.org/en/latest/config.html#patchwork-integration-settings
>>>> though I have no clue what it does with it as I am no maintainer, but
>>>> maybe something worth having a look at if some maintainer of this repo
>>>> wants to use b4 to merge stuff?
>>>
>>> I'll add my configuration here, maybe someone or myself can add some doc for it
>>> later, here or elsewhere.
>>>
>>> configuration I use:
>>>
>>> [b4]
>>>     pw-url = https://patchwork.yoctoproject.org/
>>>     pw-key = <redacted>
>>>     pw-project = docs
>>>     pw-review-state = under-review
>>>     pw-accept-state = accepted
>>>     pw-discard-state = rejected
>>>
>>> For `pw-project`, it comes from the project name on patchwork, e.g.:
>>>
>>>     https://patchwork.yoctoproject.org/project/docs/list
>>>                                                ^^^^
>>>
>>> The pw-key can be obtained from the user's personal settings.
>>>
>>> Then `b4 {am,shazam}` will automatically set the state to under-review.
>>>
>>> `b4 ty -d` will reject the patch. Sometimes I use `b4 ty --pw-set-state
>>> superseded -d ...` when I know another version of the patch/series was sent.
>>>
>>> Finally `b4 ty -a` will also set the accepted state along the generation of
>>> thank-you file.
>>>
>>> And overall it's much easier than clicking buttons on patchwork :)
>>>
>>
>> Thanks!
>>
>> How does this work if I don't have pw-key (which will be the case for
>> most/all contributors)? Does b4 fail or goes on like it would if we had
>> no pw-* settings?
> 
> I just checked and if a pw-key is not set, b4 just does nothing related to
> patchwork (tested for shazam only).
> 

Thanks for testing!

>> Additionally, I'm pretty sure we do not want maintainers to mistakenly
>> push their pw-key to the mailing list. So I guess this should be stored
>> outside of the git repo and rather in .gitconfig, c.f.
>> https://b4.docs.kernel.org/en/latest/config.html#configuration-options
>> Should we add some documentation on how to do that for maintainers?
> 
> True, in fact all of this was configured from .git/config on a per-repo basis.
> 
>> Considering I cannot test this right now (i don't have patchwork set up,
>> nor do I know if it makes sense to set it up if I'm not maintainer :) ),
>> I think it'd make more sense to have someone able to test it to send a
>> patch later to add support for that? What do you think?
> 
> I'm not sure where would be a good place for such documentation, as this is
> personal tooling and personal taste in the end.
> 

I believe those settings (except pw-key) would be identical for 
everybody, so having them in .b4-config within the repo makes sense to 
me. What do you think?

In a README/CONTRIBUTION file and/or as a comment in .b4-config we can 
explain how to finish the maintainer setup for example.

Cheers,
Quentin

