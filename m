Received: from NAM10-BN7-obe.outbound.protection.outlook.com (NAM10-BN7-obe.outbound.protection.outlook.com [40.107.92.87])
 by mx.groups.io with SMTP id smtpd.web12.5804.1620977411824426720
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 May 2021 00:30:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=nkaZbBc6;
 spf=pass (domain: windriver.com, ip: 40.107.92.87, mailfrom: mingli.yu@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HmZ18cvSMzb2GtF1kI9JCJ0aNBJy3GeDEL2A0GAZeX8PC6JU4E0KAevYiWggnXfvGqZFXfPb20OXEJ10OYMZPHWsbRL3bFm53o+kIzDliS1a/LGGTYC3xvyxMgEfG+oF/wEdZIh6jBrlxo3vnYfc3TnK9BdVH9VWhOCfgP7iYuLzmgi3ayYj/gwS3SrN+UqjvP28g8aFdjsY7JqHXuj03unAnMu/p6VTQyZ1Dnol+gUA4N1sruuMj2saUqo4YJapH9Sd0FNIgAmuIvlFaMXCO+vx8hKoLHXxybwmMHiM3bCeLz0xjwzFdokYBQvGamVQCA9OyWRrZfEtD9GrfNPukw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgnLePrcLjdUShTwQksl77qBjjsLBptX7upz67DxUUg=;
 b=afv5eEHjcEwptxNK40dbCR+e+w27I/zdF8SDfMg9W2HXr1fgd6x5Y4QyruCpY6zL+VLlnSlXmpVTrcAf9+dsAN6ywmGMddGjkjldRcXimBFVFUU6dxqmKAKLbvJfuC3H7KbKsp5RhlRyShqxJNaOsyW9Lg5lUyDQ6Jz72iP3/gSdIp4CkJ8xNcQ+xaPQ18auSmS3BkclnBxMTL3SBZhXD/pz3k/sAVlAmqFKGvFwmtEK8xuzqm/R10TVL81BjqcevAi4vfZ/Lwy4s5XCzS2uYJV/Nvi/JSxdSmpAKllwbQKLcOD4RKq8IQyq9v5MIM99KYaOB9/jPaaYipwBXmdBmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgnLePrcLjdUShTwQksl77qBjjsLBptX7upz67DxUUg=;
 b=nkaZbBc6Bb8cEID7cK0UKOt7Bu0h59DdjhIWQRadZy82n5z5dYWaeRplwQBDuy67WnbBhYrMecP3cgdugUvRKflSkQo1PN0W4TN+7b28uSqVG0ESfM67jyJE15Zfa42oYzJDWFQmrBvOXxmBp/9vi4JNf1TLwqEsld0eerTKYdE=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CO1PR11MB5009.namprd11.prod.outlook.com (2603:10b6:303:9e::11)
 by MWHPR11MB1789.namprd11.prod.outlook.com (2603:10b6:300:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.27; Fri, 14 May
 2021 07:30:09 +0000
Received: from CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::c129:2a53:5093:81e8]) by CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::c129:2a53:5093:81e8%3]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 07:30:09 +0000
Subject: Re: [bitbake-devel] [PATCH] fetch2: make sure the uri added as expected
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20210514060443.33335-1-mingli.yu@windriver.com>
 <6517f5c83f3902eb26367fa59b7d07ad1c24f106.camel@linuxfoundation.org>
From: "Yu, Mingli" <mingli.yu@windriver.com>
Message-ID: <a1696027-fdc3-e705-b4be-871840d14940@windriver.com>
Date: Fri, 14 May 2021 15:36:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <6517f5c83f3902eb26367fa59b7d07ad1c24f106.camel@linuxfoundation.org>
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR03CA0062.apcprd03.prod.outlook.com
 (2603:1096:202:17::32) To CO1PR11MB5009.namprd11.prod.outlook.com
 (2603:10b6:303:9e::11)
Return-Path: mingli.yu@windriver.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.140] (60.247.85.82) by HK2PR03CA0062.apcprd03.prod.outlook.com (2603:1096:202:17::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Fri, 14 May 2021 07:30:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fc0a60d-8691-400e-2254-08d916aa1a97
X-MS-TrafficTypeDiagnostic: MWHPR11MB1789:
X-Microsoft-Antispam-PRVS: 
	<MWHPR11MB17893DE3EB555D5946A76D30F1509@MWHPR11MB1789.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QXBRF262qFKlgSaw4YtDZL9HrpO7Zkdkl9f/sFzQ+zxD6FlrxY8zEI8QeMbC8xDe6dCcTdLhwOzbjJo8MmoxOp7LBFRU2Uh0nLs9IIsuv93vjjWQZ5AFjTz3xz0dNov90wsH/KzWiyzQBmZh82OhOrGiRIWSSm/rOf2bq8H7dQM4Tt3ZvCLmdLlF5gD4mhPvhH71VryJKPC0JqEMdJWzmOnHG8Q/X5SWfAeiF1JT9Y9QU9v+ZpRs3YVlW0/yzQsVOr3WFj6uqJR8ZAcGV2pYkANqFB5MBBVRdK3TeMgDDrXhTWVMPDhB3evgOs8NR4q9n7al0QMgXvhx3z4jenN5XgjWBhanxYe3JLdxuVhDWDFkgQmPsU+ngYK4RxdTPPgUngamydee/IBPaxEnsEP20KdD1LfYIMV1qyvntFbsWoIIv3/cxEuWulzcj448WWLEOfwCb5+1Va+Ovyi5cg2foqnVgSn9X0FAJ+P4zAE0r8ESFhNQJEIKVEReU7D1ZaNtg7eEqNw1XcpuLyBA/joKu1PxxgMaMcFLz1qOAEYjRYaATDucRAxtT8/MfdBKbQWXuqWN/FPr3HYHe5T1uR3ZXVsSc/yU/u+khVPOouYEP6366HYZ6pp56jwIzcb5M9v4ddYJ3bzLm/ZctHGGh4q4nIkK5TOJk4aEfnZTzO5nm4Y6Mkqtfyn8FJvhN0eAOWdXiDYIvnCxGVZ/fFV6YIgzh6rb2yo8p/y0GfhoeSH5xUlDoD/yhigXTQ/WlRCTvlUiSuieMntPl01wXkW6QfjGtdp5Ss9U+Oz1NN1/ThNZ/Ka8/amysqPoiTbZpnMEnuzYunnis6b/CEzkE7vW/OUAaFGeGVM8lkghEBchLqt7yoU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5009.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(346002)(376002)(366004)(396003)(136003)(966005)(8936002)(6706004)(478600001)(8676002)(186003)(36756003)(16576012)(16526019)(5660300002)(2906002)(31686004)(316002)(26005)(83380400001)(66556008)(66946007)(66476007)(31696002)(38350700002)(38100700002)(2616005)(956004)(53546011)(6486002)(52116002)(6666004)(86362001)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?MURQSEF1RUFsMFVzL2J6Zjd3TndTWXlQL0RKUFlWQldESDNWRjlIQnd3OEpp?=
 =?utf-8?B?czg2RGJUL1BaVWRvRHVGN25aV0tnRTl5bVdEM205RFRhc0JrUm9jNDVwVWJQ?=
 =?utf-8?B?TVJkYTBUYi9wZkVadzJuY1hCK2ZPUytDM3VTNzZZVjZoMGxTMnAwc3EvdDdw?=
 =?utf-8?B?M3ZKYTdyOTdkTEo0eC9zZVU2TnRaY0ovTFhFQXkzWG4rU2VHRnhGRXdOSUYy?=
 =?utf-8?B?WkI5OWtNdjhmRlVxQTJCMHF4Ymx4NXRTRG8xYnN4U3NQRDlUVEFzTDFST0xt?=
 =?utf-8?B?dkZHbENzM0ZGdWtrWmVvYmdMZHRjNXdPdFl1TnJicEJpbllKRk5UMG5Td1JV?=
 =?utf-8?B?dGxreVFwUXpKNWljTHhza05mc21CSmFQZE80U1picjN2cDY2ZmRaV2pnc1Y5?=
 =?utf-8?B?MHd2VzdpL1JlWkZrdEM3YlZYVmhLSmZQdWdwK01EdTdKL3B1VjlUZ1F0MGZx?=
 =?utf-8?B?bFo5WTBYb0NyM3JISGEycUduYUhwd20wNVdkeEQxQlBHM3cvcmJ3WFZwVHY4?=
 =?utf-8?B?Qi9CNmNkQ2VIcGw1TWVMcmM1OHV6bmp6b1lWZEVwYVNjSjhBU1Y0S0RnWTlF?=
 =?utf-8?B?dFNwVjVGZzhyMGtNbVVRamVjRUFIS25DR1ZqZWRaZkphcldaQ1lYNFZyVitl?=
 =?utf-8?B?eE5ETnBtM2NFZHpiYVRYVjBHRjFZWWcyZGJXTkUwaWpqNE1QS3dWSko5NFlY?=
 =?utf-8?B?M1B1bVFUaHlEUy9kN1lYa1N3TU0ySkVHRlpoS1A5cFRYMTF2eWtaMUd3bW1P?=
 =?utf-8?B?NGJkdUxBcFJEbUtTS29zNk9iS1pVOFZLRTJWbmxXU2VWM2pVbGhyMmxnY2Fx?=
 =?utf-8?B?TzNvZzFDRTkyalg1RXVmMk5RcStTT1N6bDl1eEVFUm9JYW1RcDNoSHVjT1Ar?=
 =?utf-8?B?ekttclp5c2w2NngxVHFNWkxDZ2VDcDdnUGdHUEwzYTNscTFLVDE2Um84TnBq?=
 =?utf-8?B?UTZNZzR6ODZxZ2RmNjkwZnBFZGJrRU1LN2FaZnRicElRRWIrKzFPc0lLNDYv?=
 =?utf-8?B?SFR5VkZTWEFhZE9tUjc1MmgzWWVaUWRjaG42QzAvUC9JVTE1MGF6VUxGTHlj?=
 =?utf-8?B?MXJwZUFienFkNGowekNiQ1lZRE1hcTZkU2FFc2hpb1V1ZjJYZWxNVXEwSytj?=
 =?utf-8?B?UHJrYnhOR0dXQXRmekxBWUVoRUtUdXhHekVCeFVrVis4QnZEbkpXWWZNRksr?=
 =?utf-8?B?Z2hEK241TWRhcCtKbzA3a3c4a0JIVmNUenZiU3hiSXpacThaeGNZcVoxeUVH?=
 =?utf-8?B?Z0laK2UrRSthbGFhSEE2dkRuWndGcUFwMjdGS3cvazFGaFJrZG9NS01ObzJs?=
 =?utf-8?B?L0JNN3IvcG8wK0NPZHM0Z2ZibGtQc1hGaHZXcHR0aG1rOFV0YTQzVmlYYTBs?=
 =?utf-8?B?OWgvSE8xWWlWRlMrVHNJZUNuR1FvT2pGd2xxNlIvdmdtTUp2T3hLSERGNzdQ?=
 =?utf-8?B?YktDcXB1aXJkN0MxWjl6YzgvU0lveW5pWTg5UnppRG5nUWhiV3djaExLeWhT?=
 =?utf-8?B?emtWMEd6SE56MEd2NXhyYzBYRk05RmJYdlc0TnZiRklMZ0lQcWpPaUxFR29N?=
 =?utf-8?B?TDRoekdtSGhrSDg0MTVsZG9iM2l1NnJrOVZrTjl5WkZqSTdRVzNUM3AzbzJB?=
 =?utf-8?B?Q0VUM0NuUkpmcC9wQ3BrZk02NmJTZW5hTEpFZDAyc1Rqd0xXYlVKWk9HTUdh?=
 =?utf-8?B?R3BTbDZrNlYxTlhRbHd5MUhoL0VNVEpHZkE1aVJWTFJJUFhGY3Zab1FRVlFJ?=
 =?utf-8?Q?IBZa4ebwSM/v0tZdUFC9DdhJnZ0MWwMscnAF2k1?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc0a60d-8691-400e-2254-08d916aa1a97
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2021 07:30:09.7970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ct4mBAbHdrr/FZxKpa37jFp5hZI9FBSTO2zWT5YASFrO27NmK2e8Xs5Ehx1dGgJqnwz4rSoBsYqJxrrh0Ysehw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1789
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 5/14/21 2:16 PM, Richard Purdie wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Fri, 2021-05-14 at 14:04 +0800, Yu, Mingli wrote:
>> From: Mingli Yu <mingli.yu@windriver.com>
>>
>> Make sure the uri added as expected in some scenarioes such as
>> with below setting:
>>
>> PREMIRRORS_append = ".*://.*/.* git:///net/SharedImage/downloads/git2/MIRRORNAME;protocol=file"
>>
>> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
>> ---
>>   lib/bb/fetch2/__init__.py | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>> index cf0201c4..6701654b 100644
>> --- a/lib/bb/fetch2/__init__.py
>> +++ b/lib/bb/fetch2/__init__.py
>> @@ -430,6 +430,8 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
>>       uri_replace_decoded = list(decodeurl(uri_replace))
>>       logger.debug2("For url %s comparing %s to %s" % (uri_decoded, uri_find_decoded, uri_replace_decoded))
>>       result_decoded = ['', '', '', '', '', {}]
>> +    if uri_find_decoded[0] == '.*' and uri_replace_decoded[0] != 'file':
>> +        uri_find_decoded[0] = uri_replace_decoded[0]
>>       for loc, i in enumerate(uri_find_decoded):
>>           result_decoded[loc] = uri_decoded[loc]
>>           regexp = i
> 
> I've not thought too much about the fix itself but for these kinds of changes
> we do ask that the tests be updated too in lib/bb/tests/ (run with bitbake-selftest).

Hi RP,

I think the current testcase(lib/bb/tests/fetch.py) is enough if this 
patch doesn't introduce regression issue(run with bitbake-selftest).

BTW, the patch solves the problem which I stated in the comments.

Thanks,

> 
> Cheers,
> 
> Richard
> 
> 
> 
> 
> 
