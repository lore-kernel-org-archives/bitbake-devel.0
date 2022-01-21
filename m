Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B177AC433F5
	for <webhook@archiver.kernel.org>; Fri, 21 Jan 2022 03:15:22 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.6967.1642734921182334803
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 20 Jan 2022 19:15:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=pLhkqSDE;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=8020d4495e=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id
 20L3B8sF010532
	for <bitbake-devel@lists.openembedded.org>; Thu, 20 Jan 2022 19:15:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=oMHMoJtDKQFVpZhjJuGum7uFZ46d/56mUXZTK2nemEU=;
 b=pLhkqSDEhTkX28cc1Enf086Im5ZCysFkKgec+jZ7ZAVqyJDU0zEUEBolNkE/uBgahYtK
 neoEJUSrRLZGEt8E816j909upfdG53F98rbp8cWgpKFUpDfTBqx8vjgIJquDVuILgTgE
 DTOfo38Kk2XkOs7+z38nIrTtjQByG+8C2VVtoHE7OCZ9Ihj7OYBFAXHR0Q1wlfaK3aDk
 HsWauQwxN4itNjpDVZCFqvPNiUax/H4w0ncayGAuLjdUnAE6PUfUa3ZnYsnUlvb3nIAH
 jHszDEtcH/RuGl+YZlg0vvMiGr1DMd5GTbOndmzA6aBT3BRyLl1S6ZCm0VUdWHXGpOiF XQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3dqhx182yn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 20 Jan 2022 19:15:20 -0800
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 20L3FKdY018811
	for <bitbake-devel@lists.openembedded.org>; Thu, 20 Jan 2022 19:15:20 -0800
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam08lp2040.outbound.protection.outlook.com [104.47.74.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3dqhx182ym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Jan 2022 19:15:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJJfp4XNaeks2kmmlw3AYQnkK7pX62R58drPd9OTVn+z5aR+skmR4qNic4mb4aQ1R0rZsDKkS0d0Bmv1XF6cnFvGBJEycGWtdeQDC/1+BlelW3wCSCa5U43qXcFKUAKAtRMJxxP6cA26jfKqAcD0yYI18poIY4tTAxpGiZVAPKaVhd63vUeYfBJFRgFfT4yBIu9VFgH3FNHfARe6jGM3DgfU1YkrwCM0PpUy/mU4UXNbXYef8vfzDEGJqKh+i8ssQTBn9z9ulqHdMsIrl5b14lAokqN187HtfEpdAxBSZcy2fvwb0LVAQSeUkMqfqyWcbORbZiPEDbdKZDKbwgmJpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMHMoJtDKQFVpZhjJuGum7uFZ46d/56mUXZTK2nemEU=;
 b=do8uHVSG8zzYrTt1WxKpxRXX5jfBanQEJTDsGXCLb5KTuHJ3nnPcOcJ1i0RckMLLRqEhnErNWJkH3kW/cd8JdNX9GZfeQp38kksJ80xHj747dzlwoRBgclajWKYlMuBcua29nrFPxCQmgdW2y8igNUoufpFCOZMidB5BMta8UxUBJ0z+Rp3+BX2L6xrVGetswQzuFO8J4PEqfQ/mjVfKphwHzIkeuln8Oj4JTZqknM9LiM0irhdbL4cIqyM3xt/TdxqbfFrRBORGit3t12ggnThzDZ3dc7wtj1dUKoidXhKLqUFVJX+NlJsKb+7FrR4iLh2qkVMWJnxL6dVtvau8+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR11MB2789.namprd11.prod.outlook.com (2603:10b6:a02:cc::11)
 by BL0PR11MB3090.namprd11.prod.outlook.com (2603:10b6:208:74::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Fri, 21 Jan
 2022 03:15:17 +0000
Received: from BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::5cb5:e426:2e48:17ed]) by BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::5cb5:e426:2e48:17ed%5]) with mapi id 15.20.4909.010; Fri, 21 Jan 2022
 03:15:17 +0000
Subject: Re: [bitbake-devel] [PATCH 1/1] bitbake-worker: Check BB_TASK_NETWORK
 before disable network for task
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
        "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
Cc: "quaresma.jose@gmail.com" <quaresma.jose@gmail.com>
References: <cover.1642663574.git.liezhi.yang@windriver.com>
 <75af98ed9992aad08e6fadc64d1985a165529828.1642663574.git.liezhi.yang@windriver.com>
 <db841326fc6647919a2ee07a82693e30@axis.com>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <1ee69861-28f1-dbd6-b26c-5f72894b01e4@windriver.com>
Date: Fri, 21 Jan 2022 11:15:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <db841326fc6647919a2ee07a82693e30@axis.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:202:2e::14) To BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2969e74-c2ab-4efe-3c25-08d9dc8c3f8d
X-MS-TrafficTypeDiagnostic: BL0PR11MB3090:EE_
X-Microsoft-Antispam-PRVS: 
	<BL0PR11MB3090A80E2FC3DD72A3564E6FFF5B9@BL0PR11MB3090.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	V9F8wMS2+/4SKXhCXOUJ7wHRY2XSl/4Gw0Iw/CcDYE32sarGp848XAg/3JFrK3SjvU2bxK07seAWy0kEYryNKGd7Jhn+PCti74SEPrStxXr6wMcYN+9pmK7hXLjQemrp4J1/vvqPMXcdwsqI7fF/Zbm5cUy2tL36UnppgRq8AVScoqo0yX5MbN86faWCb9S+5iwsgXnCou3+MdxJJVeq3k6kA/v0F5PLsXdCil5oR/G04/UP2TSJsnaR7YlJKN+WTRzqivpMxP+2CiPKB1taZYh4GrKyAZ9fONBbcsKgO2Q2ktCZnlVhYgXJrYRVj4HkpwT2r+hg/s3CT08jkDGrcX84KqBAF+NPOitdB4GFqUom1xv3uM83iDHJCxa9gVm4kmWvxXjJy5iDOhpxUoQdhhyVZC4EaVfkTt+jzpyX/iVEC6mlv0T/u+Wjpb8k5D/of4CDdKToJuddS+iBxoXQ4ICf/zlsTUgTp3SC25teU9P3FEC1fmgHaM2bsiBMwjWE9Y9s2JEY+QGxGZEPJLbc8uS4y7SnvDrvRkr41/ce6zO9YdV0oRbyI8FXprWSChL8TMsXyHljrB227NyDys5DnLMd+eRbpUPgC2irgXPs9wEEEdVkeICAr9YA8qKUZZ8egnr6q/2Ao87UQ5FybCoiKbt3LufOKKxddn7KxtMOGEi1ENcHdxFaEj0svLQ53qNFDlrmeZwnqwLcxPD9LQYGs+jPkBqgN/4dxnqHYBiDSHv7R/JOY62vXak4FQU6yXI8ND6V0MzdCTvh/z6WfKTAAw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2789.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(52116002)(110136005)(53546011)(31686004)(6506007)(38100700002)(508600001)(6666004)(4326008)(2906002)(186003)(8936002)(8676002)(6512007)(26005)(36756003)(66476007)(38350700002)(66946007)(6486002)(86362001)(83380400001)(66556008)(31696002)(5660300002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V1FYMXUrU0cyQUE3Y2xiZFdFSFh4QWFtS2lLYkdKcVBJNk9oMkcyYXdPbHV0?=
 =?utf-8?B?WFFYZXhha1FLNXRMMCtxTDB3bVdUK2dwQzR4bnhMMHRuS0dZdTBRRzZBWlY5?=
 =?utf-8?B?cEtlZEFhU0JZdHZncFhuUWo1ODNzQUpqOUpCRTBHZlFURDVHQ2lDT2NOQmt5?=
 =?utf-8?B?NmNIMGVyTkY1d3hsd1FxV3BNU2VHRXZRY3FOMEFTZTYzOFQxMS9mN1R2eEhK?=
 =?utf-8?B?OFBOR2U1WlgvRDd1MHoxbHcwTUVDMFpybnp0YmJOOHRLVWowM1JzNDBkUGJN?=
 =?utf-8?B?ZDY0MEtRNTFGNnUyZy9WVTNkV3ZiU2J1Sko5ejRkeDN6aUwrSlFnRnYwOE5S?=
 =?utf-8?B?aElhUTNDR1RxQ1lVMXhwdk9pZkZaejFrM2Y1bHgvUVJKeXF1OFUzU2xLVnc5?=
 =?utf-8?B?RTNZWGlBSkdTSjM1bVg5cHdOK0RSdEdXenREQlR2UXI3ekxhQStTZFVOS05t?=
 =?utf-8?B?WHZ0d0pVNkRGRnpIU2VMUFlqOXo3OUIzNUJsUGFYemgyM3lxazl4L2FwcDNB?=
 =?utf-8?B?Q0YxNDBLd0YxK1ZOMmRsekFySFlSSHBCYWRIWWpSQ3FGU3BjOEw3NkNrei9M?=
 =?utf-8?B?dGh4cVVqdk1TbHNiUDB0WXE0KzNjS2ljWnVWbkRWamdRTnJvT1Rkejd4TW0w?=
 =?utf-8?B?RnpRUXNpMDNGU3A4RzJRQ3NQcVE1V0l6alVvMUJSNEdLeGo0cUVIY3ZOVUNy?=
 =?utf-8?B?VDl5eGM2cDBrV3VhUUtBNlJQcVFPQTlxbHJmdVpPbFVCOTRhaCt5aTBiUjg4?=
 =?utf-8?B?YmU3Z2ZPaEhxNndkWjBRR2VkNWVud25pRElxcm9QTDV3bEM5dUJxb1BqUGox?=
 =?utf-8?B?K3hDTzZsc1d1UHdOZUJaTmIrTGVYR1JkNjBJbzdGcFpOdTlPcElMR3hoalE0?=
 =?utf-8?B?QmdnRE01L3pNLzBGeS94dTNxZTFSdUo1elhFL1BtcjJYR2ROdmcvZkY4Ungx?=
 =?utf-8?B?TTYzOHZoQTNnWEtiZ1dIRlZrYlpZakR4eDNsZHllamxveUQ3WmYzdnVzdStF?=
 =?utf-8?B?cnUyMkxNZllvaFFaQ1hIVXhPcUFoWlNYR08vSUZNUmZSWjRPQjhIK1BubXpB?=
 =?utf-8?B?YzB0MjJHeS9uc0RwQlBjS2g3MUVZS2cvdVRQR2I2c1ZlRVBVZTE1czlGWFpq?=
 =?utf-8?B?K29IeWRObUp2QVBDVDU1RWN4a1dGUEx1WVhJY3d4dUV6b1pBUmpvZnV4NWVH?=
 =?utf-8?B?cWVhbjEvSDBmcTVKUWV6TjEzbFozSFJXMCsyQTVnMktpNUV4WlljUDhqNGlS?=
 =?utf-8?B?RjF3dktiUUxod0JCSEhOWXlwZXFMTE9wTnpkeG5qbWtqV1d5N2p6dWhSa2RX?=
 =?utf-8?B?M1MxSmxOMTN6ejJLR2VrbVFGSFdRU3VxL2p6c3BzTytaWFR4UnpWYXU2Uzh3?=
 =?utf-8?B?NGZ3MUVlQXdYcUs1Q2l4NFgrUmRMNncwVDNkU0ZDczFiLzhKSGc1M1JCTjh6?=
 =?utf-8?B?Yk9BN05OOFFyUUtlT1RhUkU2cng0aDRjcWZsU1Fyck80RU1lVGErQXNnWEN4?=
 =?utf-8?B?bGFPWGNhSHp0N2Z4Rjg2YmlQMzhSU1ZUa3JqUFJNN0d3OEdGRndZRmpuUVVa?=
 =?utf-8?B?UnlKV0hHeXY5NTllclJmQ2hEVXQrZXNWNDVTc0oxb3hreGtWalRQUnY5RUFW?=
 =?utf-8?B?cDNtZWJWNWtlQTFYRGZCNlBLMGNLeGJjSW9tSXRuYnNJbE9kaThtL3czc0tZ?=
 =?utf-8?B?aVAvU2pUZDIwalN3Nld1YVh3ZFErMHh2b1c0N1Y5VVZxL3pXTFdCOXp3a3Va?=
 =?utf-8?B?MnJIMGk3b1doaUw2NEl6dndJTjh4aUkzaitTeERQWHIzYzlNVTVuN0ppTGN1?=
 =?utf-8?B?R3phQk9SMm5tU2RjcW9VakNYdGxEWW5tK1VnaWNiZnIzQ0ErckVWWjNUZ2Q4?=
 =?utf-8?B?SDloMzUyTlFxdXppeDJKMXRoNVhRc3hhWEdxckprM2g3dkIxSlIwT2kvNHN2?=
 =?utf-8?B?RjludW1WakF0L1EvM3VMdWo2d3lDU3h3cDhrdnVTa01uTDRvaUdEQ2UzSzNa?=
 =?utf-8?B?QXViOVk0bE1FdlF4bWpBQVZVbnM5YU9tZGpYeXlHZ0J6dEplTUdscmJVWllz?=
 =?utf-8?B?QnBvOFpjZjhqeHc2Q2Jock1NRUlmMzBjZEhVQ0NmaGx0MDJuNzhFcWdCdG8v?=
 =?utf-8?B?OVV3Mi81a2lNcytFbUpnZFY1ZDJ2NDIvclVIZGRYbW5ZaHZKQ1IvNmFRT3J1?=
 =?utf-8?B?dTNUbi9CWFhtK3l4QVlZblQzNUJ3U2laejNoUTVINmx5dHFDckdNY05pbDdr?=
 =?utf-8?B?TFNsM1BkQ3lXSGtRSDgxWHpzVkpRPT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b2969e74-c2ab-4efe-3c25-08d9dc8c3f8d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2789.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 03:15:17.2357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 mlWpvKjSb5xNX4sgv5PF1/4iHW2cyQmhiHaTfmsCf+hpRJrvH9AqYMpilXMUu/nr7FQrgkYb+uNW3SBqFv4kWMTiewfZnAmt10TVRI/CNP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3090
X-Proofpoint-GUID: mGtCj8u5XNPE_5LfEPs4jUi_0erlNBWs
X-Proofpoint-ORIG-GUID: zY98CBrB4QUrO_woJLcB8KCBp41SQ06B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_10,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 malwarescore=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201210020
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Jan 2022 03:15:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13265

Hi Peter,

On 1/20/22 9:50 PM, Peter Kjellerstedt wrote:
>> -----Original Message-----
>> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedded.org> On Behalf Of Robert Yang
>> Sent: den 20 januari 2022 08:27
>> To: bitbake-devel@lists.openembedded.org
>> Cc: quaresma.jose@gmail.com
>> Subject: [bitbake-devel] [PATCH 1/1] bitbake-worker: Check BB_TASK_NETWORK before disable network for task
>>
>> The NIS user can't work when task's network is disabled, so check
>> BB_TASK_NETWORK before disable it, the conf files can set BB_TASK_NETWORK.
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>   bitbake/bin/bitbake-worker | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/bitbake/bin/bitbake-worker b/bitbake/bin/bitbake-worker
>> index 3aaf3c2444b..3d7a781d35c 100755
>> --- a/bitbake/bin/bitbake-worker
>> +++ b/bitbake/bin/bitbake-worker
>> @@ -261,7 +261,8 @@ def fork_off_task(cfg, data, databuilder, workerdata,
>> fn, task, taskname, taskha
>>
>>                   bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN"), taskname.replace("do_", "")))
>>
>> -                if not the_data.getVarFlag(taskname, 'network', False):
>> +                bb_task_network = bb.utils.to_boolean(the_data.getVar('BB_TASK_NETWORK'), False)
> 
> Why use False to getVar() above?

The False is for bb.utils.to_boolean(), not getVar(), the getVar has only one 
argument:

the_data.getVar('BB_TASK_NETWORK')

> 
>> +                if not (bb_task_network or the_data.getVarFlag(taskname, 'network', False)):
> 
> I can't speak for others, but I find "not (foo or bar)" a lot harder to
> parse than "not foo and not bar".

Technically, the "not (foo or bar)" is slightly faster than "not foo and not
bar" since the latter one requires more logical evaluates.

// Robert

> 
>>                       logger.debug("Attempting to disable network")
>>                       bb.utils.disable_network(uid, gid)
>>
>> --
>> 2.31.1
> 
> //Peter
> 

