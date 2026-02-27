Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED65BFEFB43
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 12:14:11 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.40])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.94346.1772194449073202220
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Feb 2026 04:14:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=naX0uW2s;
 spf=pass (domain: cherry.de, ip: 52.101.70.40, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7moUqJzn3RBLUWrLvIZZUfGi9MzP8C/N8f0AFexpoQxWYIFlwrzejlZ0K871CjxaELZkpCUrm3F84BXwE8CbDdDAP+Lxpsr85ZU7RnIjuou2LQtIE5BGm4GlzTts7ahOKQTfwoC0cK0oM1x3GPOTi1luJdQfY3EWiY5HbZp/KbTLFxyCfjw71g7yIX1/Hej+YSQcMYaeUQxXdAKSpu+Dnk/9WBC4xl8W9vTShugYhQ0/FsuBlwXsnd8SQK/2JJzxklF5DRLthDTucmkC3GWzXToo1h6Y8qzBgUknk4m/heGsmq9q9jnLNEfEX2unXCPdqdqunwnGap7Fgidhu1Xjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zwfILl6ATuFoL+hS4WnmxLtLydqCfPGdp8cCPlOqzU=;
 b=TKQsIJJBz6HIwjbM6V9rs+nERoFiXOkIrTXJiEefFbi9K8MCisCy9JCqusAXqjWkePi5jROB0GhKhuafL7DyCpSZbKZcOgeOhQ838CrSSVbzKLGTYkEDlk34gEkmj15LUcD50JGDi4QAPaCrSE/fYIzt4FYJim1uq9JdXd5MqrYDr5hJxFmcF18QIKgOcRxgvOBYxVJC8EpBcanPVW+HMnn/iTqEs9HrTusUSWhxU4jc4JMLQl/OmMOu/heM2etKEg/jougGkUvthDKtyhvVZTScIShgTvFrRAokpVmgDT0w5hnBRMh4ffU8c3OrHefjJdeb8pIavDpJYRqOVf53Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zwfILl6ATuFoL+hS4WnmxLtLydqCfPGdp8cCPlOqzU=;
 b=naX0uW2s/Gwnu3UaYxWBFnlIu31IawYBqU3Hglx6udUsMcgTTX9Udsg4IbmsjEq2N26LQJHCsUYf8FYt+TzGoW6mppQN0nJY3rcqdjYiCqNCj30pQGESo2/8kjbqAVaZhOcKm71XJQdE0OlQh6ZGSDIbuMnlDaDysWYtq8it+8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GV1PR04MB10677.eurprd04.prod.outlook.com (2603:10a6:150:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 12:14:03 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 12:14:03 +0000
Message-ID: <f250f160-a76e-486a-934c-52f0496fee3a@cherry.de>
Date: Fri, 27 Feb 2026 13:12:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] correct small number of "Bitbake" to
 "BitBake"
To: rpjday@crashcourse.ca,
 BitBake developer list <bitbake-devel@lists.openembedded.org>
References: <10c820e1-5872-f256-d5ad-13316afa6d19@crashcourse.ca>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <10c820e1-5872-f256-d5ad-13316afa6d19@crashcourse.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::6) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GV1PR04MB10677:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e3ad30d-5249-48e9-2e59-08de75f9b258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	lNVJwTzZYCJdhJ2nyKAoPQdxLq9tpqO/LoXnIqLBonE+mbJlvJhbcdpxGLkyUZAjFuxb2bC8A0kESq+vfnfvnST+1AzX0WXsOJUZ227rvCe9HVhWXrq9FaZVILQtumEGekF3YQiIfoYnx750E+v22oNfZDQVU/KLJkKQXu12Apr7LM+kKuwIg7REHosVl/uPAC/xfkfPHYYiPhMGoL+dbqafRdGV3VhPyrFowd5k4WElFIdxzLbGsc5R4/1iXB7Tza63D5/6jPmQYOpH4SnRISGGGEtFCIdRn3ee2K4EEJN0dtG6p4xhUb8L2FAE5JxE7iDvpklagwi/U/5Pekkk80nrWho/lXZy81AEWlfTuveiq07PQXCfo+yjjypkg0L4Ubw4t/dDAgiq7cXz8n6wp6vFD6gmGVjp8Y5zSAz7YuwllO/UJbqVzbLXLZGDDjIPLx1XrzAALskhvdr1D/5hJrWe51p6zGVbpBDJXoaV2RMe8bQdw9JYaqCVeLSZb7w9KyVukbxjV+FoAtjFa+coMezycZcvVb4tnaoc6eCxJq6UvCOgZRIW4KT9KUo5yijy6P/Xy6YaZpCV/qBa8US30i36HVgMjRCl6PfcOcBOMQs+X98aBVpL9OhcN7cQWnRDbG1+N+wQGX+D3iYycpzcCozdEMGqyfnCWDy0biezP4LNONFQA+6e+mx0l0uoAqgh
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N1R3Y1VoS1VaK3dCc2NFZkxtUG9NNkxyU09VQzBiUmlpbzlTMk44dzAwUlFi?=
 =?utf-8?B?eWI5aWZicVZ1OVJXcEF6RDNNdE00alhtdVF4MlhKVmhiOWgwZGZNbytMOGNH?=
 =?utf-8?B?citWL3NyZnNOcitsdUZqOVRLbHBhbHB5OWplWmFlQlhMaWhkR3JyWG4yMmJQ?=
 =?utf-8?B?d05yNTgzTUYzMmFHMGZUQ00vbWtsZzg1eGNlQjFhVWhVN0Zxd2YrSHRmWldV?=
 =?utf-8?B?ZHFpMDZBZVFzeXVvUzF3cHQ4alBOTmhxeGlMOHJrUHVLS2xkcGltT0d0QTQw?=
 =?utf-8?B?bVhzMXU0Qnd0S2pKZGZseDcxRHpqb1BScVRYN0xEUW53NXpKMGtQZTRTWmF2?=
 =?utf-8?B?U1lndFhYYWhSWGUvVlVERjRXTE5CazVrRUV5R29FaGR4emJqLzVkVjVHenJY?=
 =?utf-8?B?Zmk4ck9RRnZTTjNnTFA2THhsTkVreVkrZUxpT1JzNS9DYWJJVThzRjJ4czJk?=
 =?utf-8?B?UzNickpEWGVOY01nUWNPV2VCOUhyVytFZnRqQVZiODJBUlhXTTk1ZTJqQjRu?=
 =?utf-8?B?Vk5yL2d2SkxUNFdEMTdrUVl0cURNQU5Ua1JRZkRjY1o5aHE3V09weVE1bVN3?=
 =?utf-8?B?eG9iNlNkcWl1Q1FvTXRFVW5sNVlHa0hEeGpJS2NWL2w2NFJwZlhnSDZPclFR?=
 =?utf-8?B?ck0vZWJ5K0ZBMTU1eHppbWdhYXN0NmIzMnlXZzFFVUo1MURKUExMMklTSEdG?=
 =?utf-8?B?OWlRV1FKa1U2Zkg5dUtMVnFjclFLSml6SUpUd1NMRURwL2lkZWVmVHphdDcv?=
 =?utf-8?B?alFXNHphK2dyMkFZejVRWWxQblpMTEc5YmVmRnVWdGd3VkJ5YVBqTWRQKzZJ?=
 =?utf-8?B?L0V3QkIwWGFIR2xZODY3djltVVVSaWVwUDYzUW9OUThWaVEyNlN3YzF5SE9O?=
 =?utf-8?B?c01vMGtxSlJVZjFQZERSMlk2UDl1UDlNY2FsK1UxRDJpOHNQaU9RSDVLNWNE?=
 =?utf-8?B?M2l4UVlaRXAvRGVNRHFLZW5yOEV5bENZakdqQlA1WUc5YXJNS3R1TjVJZ2tP?=
 =?utf-8?B?OW1pNWNHTkF4NHVMOHRBbFprbDA1NjJRL3dKMnZDTnpBbEREanhKdkxPWTZX?=
 =?utf-8?B?S085anVSYkZTUG16YUQ2Vm9RRk9ZeGlGL2lRY0c3UzVNaXArbTR0Yk0vZkRn?=
 =?utf-8?B?Um5iUUtKS3p0NnNqdmhIK2xOT2J3Z1JyNDJPOUJCcmpGR3BJRDlJWHFXRFVB?=
 =?utf-8?B?clErL0VCcTIzQ3FSSzF6TWIrcks5a0RDeDNPSlRqdStEWm5zSE1wUk1VbG50?=
 =?utf-8?B?aGZxMVlWY1VNanFHRDlYOTRRTHRSanNaN2pKU1ZXK3JQQUFJRDFRdHVVaTdI?=
 =?utf-8?B?WXUzTGg4U0MvU3BkQXAwamRQU24rTGordVVKS050ZkpKalAxa0Z6LzRacTlH?=
 =?utf-8?B?cGYyYlZLRkd4d2VMOTBrRm9QekhJRHBCQkpTNGRUcFZ2Yy9NdnVRUlViUExU?=
 =?utf-8?B?SXdHZ2xjcFQrcEh3aDQ3RnlqM0VVS0psenF4dUM3NEg4alJGL3FTMC9YRE5R?=
 =?utf-8?B?NyszclRkTytqMk5heUVtZ1dOWFo5eXlSN2dNYXExaVh5MEJFcXdsbFVtcTcv?=
 =?utf-8?B?N2MzZDMwRjdHWVA3VHNPSW1XRGdiUStVVm1IR3AzWHNVTlJKYzNOekcyUm5p?=
 =?utf-8?B?L1dhL3FZc1hmVHhRMVNnVEtlVkcrQ1JtNWd4TDYyaFhXQm1WL2tXZU56OHdV?=
 =?utf-8?B?dklmQzhodk05RzhCcWY0VEtLbThxVFByOTF4YnI2dGRLOGVaM2lHaFhDZHR3?=
 =?utf-8?B?SjBNdVJhMmZIc1ZVWTBxRE5JRWlsdVlnUjVXcUpnUENEcXk0MlQrSkI4VTBN?=
 =?utf-8?B?KzhRS1kvSXcvcDJIMEpTRzNzWENJUDZNUjlwWFJWeGVKalY5bExaOUk4Z0xE?=
 =?utf-8?B?aXExaEtNQklXWW52aVhGZ2oyOXlNTlRaQk9hNTgrb3pKUVZTTnU5UEFzeWhW?=
 =?utf-8?B?MUN1OFFYZlByVVNKUlNwNXlWakcrZ3dKejFlMFArc0ZJaUl4SzBRWlNtNk5P?=
 =?utf-8?B?eUt5bXJmam50OS9FcHg5STFJSlJpc25HNEdmUmhSai8raUJlWjRhLytsQmF0?=
 =?utf-8?B?WlBtYkI3STRtOVliUFJyM1NjdzhpWDRjWXpUMVJIRC9JQVpMdDNLMmxVUUVr?=
 =?utf-8?B?ZjBUVTN5c25qYmdUVVBBSWFHMG0zZzRkUFU2QnVzZXptaThhZHVTNkQxbWlN?=
 =?utf-8?B?S3RoRWYrZldNcjVGNnNHRUxTbElTZllxZGJCamZ4bkkwaWUrQWJpRitKaEEv?=
 =?utf-8?B?Y3pqanUxUHcvZllUbThicFhpUGFFby9xYVc1QmxDQnB5aVcxdXZUdjFlQ2lJ?=
 =?utf-8?B?TmFSSEdxeUc5NG9CTEdLSDBCZi83a05nT3U1Zm9mUEs5WHp2Vm1Ydz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e3ad30d-5249-48e9-2e59-08de75f9b258
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 12:14:03.4164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6vd8jMjUDz1Yj27JVaOGmWeJy6+cnbjABwd4sf9G/1zV2PH5coqRnpvjhSNspzNoGjpZNcMF6qqhEbI4sM6XpHWMSdqYo9ycWL3tDU1hnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10677
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Feb 2026 12:14:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19090

Hi Robert,

On 2/24/26 6:20 PM, Robert P. J. Day via lists.openembedded.org wrote:
> 
> Use correct spelling of "BitBake" in a few places.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

FWIW, we could "enforce" that by using a substitution, c.f. 
https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#substitutions

.. |bitbake| replace:: BitBake

(e.g. in rst_prolog variable in conf.py, c.f. 
https://www.sphinx-doc.org/en/master/usage/configuration.html#confval-rst_prolog)

And then throughout the docs, use |bitbake| instead of BitBake.

Cheersm
Quentin

