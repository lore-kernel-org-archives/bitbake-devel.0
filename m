Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F39C02183
	for <webhook@archiver.kernel.org>; Fri, 17 Jan 2025 12:39:28 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.63])
 by mx.groups.io with SMTP id smtpd.web11.9771.1737117565198535979
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Jan 2025 04:39:25 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=Un4dmLgQ;
 spf=pass (domain: cherry.de, ip: 40.107.162.63, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xs07sB35cDvO4DFyf+XgwuRthWhflYZFXWx5uCW8YiNmnofh0Si/LqLYmWJztN7Mc51DjcgRJuqEYmLSF8/+ke8iel0hdNbsH0rlFQ3bzWYNR8gNmH9ylj8J5IIaPy88h9IErtu+E4+0WDj9eQTgnIDYhX6R4qIK/1HrEkIc/pSLW0I1Loru2Wjm/1bFBrMeVxwgZEribzj+69ZVL7mg95kVMSQ+28eqsoYKmrML9MFDzqWzNIA9USFRTK18i5QXI1/JmUwFuhYzBvnGmKx08Vgp66T+wIo8kZNghh/nH+194ICConCkdLw0Pi36RYKJ3SWNN8iUm6M9rWlx59rUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3uuTVcle6me1l9pI7nPpzQ7q0rOKNegxP545BJ1NxVA=;
 b=Q2p0qINRja9IUSwCAoopPDwCoEKx/MrZv8X9MoTUy9YCRyqdNeYlNpT5960uFDz38RkqwfMFDAqBoLByJ6qS3I8enk8BTqhwuiXcPxUBv7NjTaObluPakmdl4v3dKRi5t6SVYg6DRIRouPwyRpywmsrsb08xI4+V8oBw0v03DtEiXGHmRfQp3lQbw0L2NsQ0kfBi8SapnT83J6NKe7vDc5qkafuCeg6225PX9UIHW7ktPrEiIrL30KSHGGhCxhyuAyxf9dfmTKMPdYWSno6Ybxs08ZFJXNuKFSPVAJBWHg7Aq6Dhs4tGVAcOyg1z3sZ5ivcdjS4U98WJsBbr5fLxJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3uuTVcle6me1l9pI7nPpzQ7q0rOKNegxP545BJ1NxVA=;
 b=Un4dmLgQxJQIZHi3l9fYD3Nz6m7SXhoRyr0Ut01fD6GHQbae1YUthcII1DKUU++7nOk9D6ZkrH5PZnNVV6L906vk3qzlh2yUUs9/HYIRoFxJQz2xoXXVDoqdc79P3Ynz3QgsmXDdTXcBYNG5cGYCDyjWLrrTR1A1U5iBO5luYr0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB10782.eurprd04.prod.outlook.com (2603:10a6:800:25d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 12:39:20 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Fri, 17 Jan 2025
 12:39:20 +0000
Message-ID: <dfb89130-58d7-4385-aa57-ec67795b8a3d@cherry.de>
Date: Fri, 17 Jan 2025 13:39:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] add basic support for b4 contribution workflow
To: Quentin Schulz <foss+yocto@0leil.net>,
 bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org
References: <20250117-b4-support-v2-1-7178f61d49e4@cherry.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250117-b4-support-v2-1-7178f61d49e4@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::21) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB10782:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a17a249-d70f-4d47-c2b6-08dd36f3f6d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U1hlclNXcXJLSkJyZzJRdVZvT1g5YnV2Y2xzd0ZrbEMvbVdvRGZmNlAzR2Qw?=
 =?utf-8?B?ZTJpY0h3WWpvbTVIdEN3aTBzTHFiSVZTdm5NWFg3Ty8wdE5MR1E3YjB6aVRS?=
 =?utf-8?B?TFZWT2M0d0paZnhzQ3cxVjlZNVhTRlR5c0p1ZmxHVWh0VGNRdlpnUngxcnM5?=
 =?utf-8?B?VytoYjhZMDd6MDNnUzdXa3NydU1VZ0FEa05wTUNLeWVKR3RBQVdiNzl3SFJ1?=
 =?utf-8?B?NXlheFZsOGsyd1NVaURZUVVycWVLeHRSNHJYOFExZm93N1lRSWl3ZTllSlBH?=
 =?utf-8?B?anpYMFg3U3RjcXlHVnVWYzAzd2FORlhhMmY2M3pnRERWcmtzQ1VscVlFTWx0?=
 =?utf-8?B?S3JBYTgwcnI1bzVFcFNmUkFYVlF1UmlDUWlEbUxJcWZtYS9HdVVIZi9ORjN4?=
 =?utf-8?B?aFgzdE1FUGZaVzBwN1BzZk5SQ0tMNWlsVkVqeFFhR2FGdkNEWFVPQ1UwRzZM?=
 =?utf-8?B?TWh3ZU9KdW1HZG9FNEJiVVdGM3JRUXRtTEdyN1M5KzlDMDdQQ3VRdEdjNVVI?=
 =?utf-8?B?MWMwZStmWTZTNENMd090MFBqZUNCWnZZeDk1WCtWaUhpRkRZOVI4QVFyakdF?=
 =?utf-8?B?Z1BIa2NLS2ZkM3I4d1pwY1JXdXdCdUpvWGNiQ2UyQnp0eEc4RkdRTVIxSUtr?=
 =?utf-8?B?M0llanJ6ajFJZUJ3ZlpwQTFUZ1dYdkk0MCtza3lWN0NsT2hyWlJBTDNkbm5S?=
 =?utf-8?B?U3B0Njl3ZWl6ZVluUG9OTEM2OEZtNWhwUGJlenJIbzU0ZVZIOHpOL1IxaGVq?=
 =?utf-8?B?K3JROU42Q3RwWUlvdFhGREtrMTBDTG5vaU1nQ0VGcDF4TnE2SzR2M29HQmlV?=
 =?utf-8?B?a3IxeGxKRUdaRDk0a0VXSXQvVkdSUlFlemUzUHdlM2wzRkkxaFdQdDVlcEdt?=
 =?utf-8?B?Wm5QVW1pcXhlbFIveXptUmlSSlo1dWlRTWFjdFpnZWxtVjNyRU5wekhXRGwy?=
 =?utf-8?B?Yk1KbXI1NHN0RitlY0h1K01zclp3R2dKbldQWmdEWURDQWtIT1RHcjJaNk1W?=
 =?utf-8?B?SjBxSFppNkg4T2VPNGZnRlRZcnJCakhXbFFrVVkwaGg5SXJaRnAyRmlNVitQ?=
 =?utf-8?B?OUdBUDVncmNnMHBha2ZOT1JzdWJkVlJRQmsrOE9nM1BLR29GMkRjQzFPNW9X?=
 =?utf-8?B?SkI3L2ZBelVWSStyLzdxNktUOFk5TGFUY2NPblAzZllVaDBGOHY0QlRGK3Bi?=
 =?utf-8?B?MzhEaEthWlBYalNMcS9ZSDg1aitKMGpQRHBkOU1xWTRNdlpmU3VHRWtIU0ZM?=
 =?utf-8?B?a0UySzM4TDJPcThYelNUWko4NjJJcG90Ym5PdEhNV0RYOGZMek1ZaFJIUjc1?=
 =?utf-8?B?YUJoVGZsSU5ta2lyRWI3d24xUlk1am5XN1JBOGhRVTExaEhCaEEvTXh1STcw?=
 =?utf-8?B?UVE3bmZLOEU0VmxZZXBjODNGWmFraDRZRWx0QjZxNmRIN2E0MFlNQk5NdWdQ?=
 =?utf-8?B?bUFkSzNlSUVPQkZkNW41c2Q4M0VyYkE2MXhJQzdEQUFEdzF4R21rSDV3SDhU?=
 =?utf-8?B?UnBDY3NKUXRqdXZXLzRQTXFyVDNia1k1c2xaNjlnNi83Y2lIWVVLcDZ5T3lZ?=
 =?utf-8?B?SDZ3NE5HR1dtWUxJdkFkSE12a3UyM2RIVFNSTFhzc2Z6SkY3MEgyRGZvRktj?=
 =?utf-8?B?a2NyYUdDekY3YVNVUWt0RCtkYVNvallTVUw5MGsrbnJGTTVVMU52Smk2Q0hG?=
 =?utf-8?B?a2VZb2N5b2RLWWdZQkNCbDdsUFJOMGsrd2cyQXRBTS9tc08rQSsvRVkxbUVy?=
 =?utf-8?B?N2tta1JvcmZYVnArYitrOEFCVWNrLzhDRG4zdnU1VmhzUmdvaDJnZHJpM3B6?=
 =?utf-8?B?R0tSWDQybWZUeGtOaGFkdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cWMvU0hiSFZwMDMraXhOTmtIeWNVK0lwRW5nTmxWMjNnd3BiWFI0VitSdHZI?=
 =?utf-8?B?SzFPYXQ0VHAyUEZvUnAzdlRXVHA1djN0b09vQndEcVo2NW9hTFlvNnJXUFlH?=
 =?utf-8?B?Y3cxdDR4a0kzL1dPRWo0ZC96eXVHblcrL1h0QkNmQkxIbVZITFN5TjhDM3dB?=
 =?utf-8?B?UjhYU3VTa1FQSk4xYWVDL2dEcUFXd3krbFFNdnE4NmlQVFRKRWxReEpKTy82?=
 =?utf-8?B?MnBFa1Qxa2ZTLzE4bFF1NkpHNmYwTGxiOWxlK2FwNjBkdjlERmlzL1J0ZHpF?=
 =?utf-8?B?eHZDaVlmL010eG8wU1lsb1ozZGRWRDd1MzVncUgwUU5qcGRQeG5qNUp3cUVI?=
 =?utf-8?B?Z1lhT1ZrRDNUTnFXMGt6M2NRZm1udHFhN1c0bkRJQTZZM0Iwa3JvbTZKd1ZK?=
 =?utf-8?B?clBMelc0RStJNitHWWZNYjNhSWtva09tV2dDOFF6SGwvSHQ0TnJSdzJyME5X?=
 =?utf-8?B?RVNIdFJJK1lDMVFTV0FWZ0JSNjJOZGtYc1JoK0dZaEtQeXJiT1kwdXJLOGo3?=
 =?utf-8?B?dVVoWXNMbC9YcU1vWVZ3Z0lzZDhSMUNKUXhIY0h6TEhOZStKaEhlWGk2UFFs?=
 =?utf-8?B?UnNFNVA0Ykc5Um44dHZGaVdhTFg3MmtuTUd0ZWJiWkNBY0JCb2lBWVBJMTBD?=
 =?utf-8?B?eFQ1dGo5RWtIcTQxSWlINVlHSUc1bVNOUWV4emhoRU1WbUJVOEFWNWZZU096?=
 =?utf-8?B?dmhVblVkV1JaUm05VFpZRVpZbmJSckphZEdxbzA2a2ZuUEF5WFVQelJNZTNl?=
 =?utf-8?B?YzhaTDVRSEk2bHdZT1BYZzgzODl0a21nQW1aVENQamUvdjZhTTdsMmdyL2gx?=
 =?utf-8?B?S1MwQk1uVFNMQjRheTZ6QXU1L2FsYVk5Qml2WkE1LzAyYWc2c0JGWk96NUFN?=
 =?utf-8?B?eVgxQ01vNkFGVmo4M3RKK0lDWHd3enpiUG0wVXFXM2FGalNmQ1RWZHRkSHhn?=
 =?utf-8?B?UHh4RkpDVDdJSGFFQzhaRlBhZUNDczBlTE52eVVXQzdVYTJlWGQzS1NFMEhB?=
 =?utf-8?B?RmNiU1R0MFhsaVQwQ1FIOUJETml6eTZJT3pTVkh1cXNEL3FEaCt6bytZWkhD?=
 =?utf-8?B?MnVTa3dzWFRBSHA3WGtRamtoeXM1cjJ6NzkraGtLdDc2ZHJJRHFDQ09WbU5j?=
 =?utf-8?B?ejF5QkcweGhYWXExS2lyNDRKYW50L1lwRXlnRVkzL0F0VUhwTHpwZ1MvRGhI?=
 =?utf-8?B?T1RGN2EweGY2MDM1ZS9RR2NTZTZndWlDRG5ySjJtaDFJSGloNVBiVTBaZjhJ?=
 =?utf-8?B?dFZ5WU03Vk1aSHVIcEtSbENXdkdOUlZ6bDVsZ3lveVBuc2ZDTVpEcTJXNDZD?=
 =?utf-8?B?Q0FkRTVhY2RjbHpNajNjdmhjMkRPWWc3akpicHR1eFFUc1R5cDhubmErNUNx?=
 =?utf-8?B?czJ4Y2ZSUkpBWVZlRUJMMkxZamU4OWdsNTVZSnZ0ay9KUkI5NFpVdkNjYzho?=
 =?utf-8?B?eEZrNElCZzlCU2ZISzhIZFk3M3lLazd1OUd5bWViRDNHS0ZRQ1M5WU8vQXdI?=
 =?utf-8?B?NEhSY3F3dVhVSStxdkhzSDViTVhDR3FGdVhqS0diR1VHMWpaTmJNMVd1TG9a?=
 =?utf-8?B?WjNjamMyRVIvejBua3Y1QkUwWnpoeE1MbEF4dTZsQlUwWXErUCswRndKS0xQ?=
 =?utf-8?B?WjRnUGpwVVdHMUlTMlR3WmxiNkdjWFV5QkJjSTJmN3gzSEVLRG53SWlzVnBx?=
 =?utf-8?B?YmpwREREVWo2dEF3K09vVGpOQWJLTVdOVDV1K01kc0JGcE9aYjVYMHJ2d1or?=
 =?utf-8?B?bHZpTHBOVUtkTHdGVzNpalpXVklXakpScnRRMU5sT3E1OW9kNVI5M0VRNC9I?=
 =?utf-8?B?K3VqdzBNVlZBak1OOXRWejJKN3lyV2tkSHNwcC9zV2tnMnVRdkpWNnBQY2Vk?=
 =?utf-8?B?aFhZSyt6d1BobWZBUE5ZWEptbzRzVDRpcjhhcEIyS1QvZjVxYVViNnNzZDRq?=
 =?utf-8?B?ZWZaM05JYjRMeGFoUTJyRjNFS1lsRXFmbWZ1UjZhNUVTVzl1bG9BSmNKU1I4?=
 =?utf-8?B?UzR2bmswaFNtZXdXczVwaFNxRjAvMk1rWFdCMTNXU0xMUkxQaVF5cGk0ajZh?=
 =?utf-8?B?Y3puU2NTTlJBRTBtdXBxTEtZbXZaRU53SWRuSHpIcWhTYmg3OGl2WGIzRExT?=
 =?utf-8?B?alQxQ3o0TGw3Nk12c29ZaEJiVU5XaDBXeEwzYWZlMnRPM0ViaUIzVThpRTE4?=
 =?utf-8?B?RkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a17a249-d70f-4d47-c2b6-08dd36f3f6d8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 12:39:20.4619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKOZuV/FqFQb+VFwh06+tXZ4O7T0B2wYKoeX9YSKVno+vhaC5qfP/IAorguiIOaY7hwGJBXwrkwOeBS9Smq803nu4TkpNGnHJnQM9EE8LEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10782
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Jan 2025 12:39:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17028

On 1/17/25 11:44 AM, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> b4[1] is a very nice tool for mail-based contribution. A config[2] file
> exists to set up a few defaults. We can use it to set the Cc recipients
> to always add, in our case the mailing list.
> 
> This also adds a wrapper script that is called by b4 to figure out which
> addresses to put as Cc recipients. Considering that patches to the doc/
> directory also need to be sent to the yocto-docs mailing list, this
> wrapper handles that. A limitation of the script (lsdiff actually) is
> that it doesn't know how to handle empty files, but those should be
> of rather rare occurrences.
> 
> While the wrapper script should be enough by itself to add the bitbake
> mailing list to the Cc recipients, one still needs to manually run b4
> prep --auto-to-cc for that to happen. Therefore, let's add an explicit
> send-series-cc so that at least that mailing list is always there.
> 
> Because we currently do not have anything to check for patch validity,
> remove requirement for b4 prep --check to be run before sending a patch
> series, via disable-needs-checking in prep-pre-flight-checks.
> 
> [1] https://pypi.org/project/b4/
> [2] https://b4.docs.kernel.org/en/latest/config.html
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
> This adds a basic config file for b4 to avoid to have to add the mailing
> list by hand.
> For documentation patches, the additional mailing list will be added
> when running b4 prep --check, as is required for each new series managed
> by b4.
> 
> Note that b4 supports patchwork, c.f.
> https://b4.docs.kernel.org/en/latest/config.html#patchwork-integration-settings
> though I have no clue what it does with it as I am no maintainer, but
> maybe something worth having a look at if some maintainer of this repo
> wants to use b4 to merge stuff?
> ---
> Changes in v2:
> - add b4-wrapper for auto-detecting patches that are to be sent to the
>    docs mailing list as well,
> - disable forced b4 prep --check for each b4-managed series,
> - Link to v1: https://lore.kernel.org/r/20240524-b4-support-v1-1-0c4334c36cc7@cherry.de
> ---
>   .b4-config    |  4 ++++
>   b4-wrapper.py | 38 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 42 insertions(+)
> 
> diff --git a/.b4-config b/.b4-config
> new file mode 100644
> index 0000000000000000000000000000000000000000..0b699f204c414099f2118ffdbc9f7b24454e4a4e
> --- /dev/null
> +++ b/.b4-config
> @@ -0,0 +1,4 @@
> +[b4]
> +  send-series-cc = bitbake-devel@lists.openembedded.org
> +  send-auto-cc-cmd = ./b4-wrapper.py send-auto-cc-cmd
> +  prep-pre-flight-checks = disable-needs-checking
> diff --git a/b4-wrapper.py b/b4-wrapper.py
> new file mode 100755
> index 0000000000000000000000000000000000000000..ddc2597bc0374fa5124a83be94eeab52df6f38d3
> --- /dev/null
> +++ b/b4-wrapper.py
> @@ -0,0 +1,38 @@
> +#!/usr/bin/env python3
> +#

Forgot to add an SPDX-License-Identifier here, I can send a v3 for that 
or simply pick between MIT and GPL-2.0-only and GPL-2.0-or-later which 
seem to be the most common licenses for python scripts in our projects, 
I don't have a personal preference :)
For now, will wait for feedback first!

Cheers,
Quentin

> +# This script is to be called by b4:
> +# - through b4.send-auto-cc-cmd with "send-auto-cc-cmd" as first argument,
> +#
> +# When send-auto-cc-cmd is passed:
> +#
> +#  This returns the list of Cc recipients for a patch.
> +#
> +# This script takes as stdin a patch.
> +
> +import subprocess
> +import sys
> +
> +cmd = sys.argv[1]
> +if cmd != "send-auto-cc-cmd":
> +    sys.exit(-1)
> +
> +patch = sys.stdin.read()
> +
> +if subprocess.call(["which", "lsdiff"], stdout=subprocess.DEVNULL) != 0:
> +    print("lsdiff missing from host, please install patchutils")
> +    sys.exit(-1)
> +
> +print("bitbake-devel@lists.openembedded.org")
> +
> +files = subprocess.check_output(["lsdiff", "--strip-match=1", "--strip=1", "--include=doc/*"],
> +                                input=patch, text=True)
> +if len(files):
> +    print("docs@lists.yoctoproject.org")
> +else:
> +# Handle patches made with --no-prefix
> +    files = subprocess.check_output(["lsdiff", "--include=doc/*"],
> +                                    input=patch, text=True)
> +    if len(files):
> +        print("docs@lists.yoctoproject.org")
> +
> +sys.exit(0)
> 
> ---
> base-commit: 0329a7e3ac694737f2d2c1861f65492551360663
> change-id: 20240524-b4-support-e9855fc54d40
> 
> Best regards,


