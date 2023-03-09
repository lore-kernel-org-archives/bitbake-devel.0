Return-Path: <xiangyu.chen@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E654C64EC4
	for <webhook@archiver.kernel.org>; Thu,  9 Mar 2023 00:47:17 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.2217.1678322831384760054
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Mar 2023 16:47:11 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=243279499e=xiangyu.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3290fFTk023054
	for <bitbake-devel@lists.openembedded.org>; Wed, 8 Mar 2023 16:47:11 -0800
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3p6fff941d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 08 Mar 2023 16:47:10 -0800
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3290lAud004346
	for <bitbake-devel@lists.openembedded.org>; Wed, 8 Mar 2023 16:47:10 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3p6fff941c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Mar 2023 16:47:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cL477no1HSfzD6j1H8lggaaWfVCjSFVaqy6md7lrtMa4EfDKbAiNVvswe/Nuinx6QASEbOUDtRO8GPrlJZ9K9fsJUnRWxRAAJsM0GQYOMYDLC66hwPYEJK5j1Z46ZLHscILOlhxAvR1loIYGA953LBtJTqMQbIRrEARJ9s6pWTTmOke+sy6CwS5bjcIzhETrb0Wc+W7nyYL42s6Z7PUPHSW+wyGXAnilTI3Mof75m/H+8zH/h8MO4VP8Aiey8PJnAMaDuvV/dNkWzIqLyUpf7QaaQalfGdnO/sywiiEL0eiNz/xXxEfJqy7sCDA1BM319DUG1nvZR6UiwFnt6Qia+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9WHhVZYLJQxj2jdhxcKoakfwIPoJGZAvjt0POvGQEA=;
 b=GzArfAJR3+SRTMQ013aFQlqrR8KKLIsvCHn66ACcUSUn1xIUfi9sTF27cYg2C6XHPR7UOtNm2YfVads4rLQMuab658OmoaYmFwQGVXaUYlKhbxOZI2HQi8Hed5RI49GaLpwYQkRwpHnna7Ijpq0/nQIqvxnlvfWqC6/prg/2s6F2LzRbMAbnAjYpbHbl2eI5st57zVvWs0dGQjygwd6CcMEygNJg+iQ7/Fwo/g+28gEAsVWIoSJCTbXD9pFbfo03fWNGY7LLlQF/eafK6EAiacmxAgEA45bIGtRAWpkiaerVYVoQ0V3bGF6egAqUGgoF4mRDSfIyicT6/NGmYOUP7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=eng.windriver.com; dkim=pass header.d=eng.windriver.com; arc=none
Received: from MW4PR11MB5824.namprd11.prod.outlook.com (2603:10b6:303:187::19)
 by CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Thu, 9 Mar
 2023 00:47:07 +0000
Received: from MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f952:3d02:d71:cc68]) by MW4PR11MB5824.namprd11.prod.outlook.com
 ([fe80::f952:3d02:d71:cc68%4]) with mapi id 15.20.6156.028; Thu, 9 Mar 2023
 00:47:07 +0000
Message-ID: <e6214745-8bb1-b504-0823-0aa2dc0b6c69@windriver.com>
Date: Thu, 9 Mar 2023 08:46:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [bitbake-devel][PATCH] data_smart: fix library name contains
 special word cause do_package failed
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org
References: <20230308095539.651015-1-xiangyu.chen@eng.windriver.com>
 <9492b64c0e41f32dfe9afb8bf8e06f4e9e331c48.camel@linuxfoundation.org>
Content-Language: en-US
From: Xiangyu Chen <xiangyu.chen@eng.windriver.com>
In-Reply-To: <9492b64c0e41f32dfe9afb8bf8e06f4e9e331c48.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To MW4PR11MB5824.namprd11.prod.outlook.com
 (2603:10b6:303:187::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5824:EE_|CO1PR11MB4835:EE_
X-MS-Office365-Filtering-Correlation-Id: 814b62f0-712d-4bc5-64bb-08db2037cecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jdeKf33RXm1dMt27yBnqqLUqcFxPUxiG0FDRmX9tqj19wPlgEXpbqkI6l52P+elK8pMhPozf930J5JTouLd/yiQd25O4k4rnVxmjn/K8r+jh7vdfynZQfgxka9NKncqyUpdAtOSzfK+IF2KsAf0lzpOYCB/TF/gMdAa5sqJ7x6IW5RaZxFFSagTBPdAFJzd+qEag6418jIlGGeEZ0oKaGhWV1f3B5UOj/gwd1IJz1f6/JUGAnClhBIZLBiCAVu80i7o1rWSN+UyqhiZklPhxhC+VvFEplIekRQUR8m/fjn/V9DEEatEaJIB8KPR9jRr0qyNTnXSiEbT1JBU/4UiVClzP+qNW9AOVZ5eN9PYSAEsCSwIx49JJxM5tlELEmMBuYYDCI89+2cRijyApCk9YaO/wZU5/PQF7k8cU5VvlKsrr0FketQYFVJS+eWHRP/QbJFaFTpd4ve8ElwwfrvpQK9zdy6YDe0vGx7/pGPoRs0J+OE11OmnxkEl0XFoW2R0+fILIecN7u6tqDsVQl80anTIr/HzD7xkWs9NVFMrE3gkn/q5h1Dp1iHiaRCjYA2Z7k3yur0HeSonDi22hxSdqEHMBuxJ6nBYLuROF0egButGyjL07lHLwVxGnw5ekbPFyN8auXNQvIeNRkBipoHhIdQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5824.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39850400004)(376002)(396003)(366004)(451199018)(2906002)(31686004)(44832011)(5660300002)(83170400001)(36756003)(31696002)(26005)(8936002)(66946007)(66556008)(66476007)(41300700001)(316002)(8676002)(478600001)(6486002)(966005)(6666004)(6512007)(6506007)(9686003)(38100700002)(53546011)(186003)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Vnlud2VhRlI4TkxJRTFZSFVtSjhDdThRekx2bVBwZk41Nnd4T3FGb1V0R3hO?=
 =?utf-8?B?ckxKekxiNXE3VGRmNDdjcXk4RU5OQkk0UHVNMmczZHVqTlM0OGsvblphZlhD?=
 =?utf-8?B?Qkg5TTIwVTQ4Qmpzb0xuRzhQbmRNVWNvTEFybE9qK0YxY3M2MXc4WXQ1VDNN?=
 =?utf-8?B?Z2lSajhFOEI1WlR3NXQ2ZEV6b21QTTFYb1JHbk9pellackZzWXRnRHVsdkFS?=
 =?utf-8?B?WDNCOGorbUpNZ0oxN1ZOMFJTelVabVcxYWFjVEZqWWJURGNiRVR4UlhxTGNv?=
 =?utf-8?B?cmtLRGNYQUN0SHpOWmoxWWg3RHNTY1NxOGJYU09qeFp4ZVA2YlZyck1pOEpY?=
 =?utf-8?B?Wm8zbnl0QnFVM0NibU55Tk51cTZKcWZSOU5EbmwyUk1KTHhVampvMlpiK25h?=
 =?utf-8?B?am4reWYwNkdUcWVxeDBCbXRlR1VwbHVSMDNoNDFXUkNid2hvTllFVTM0Ujd0?=
 =?utf-8?B?VkR3Z0k1SCtObjVLZENZNUpybjJzdk4vYnIrSUErQkJWUUpiQkI1Ym1ZZUtn?=
 =?utf-8?B?OXlzYXc5NGFSVXFGWHc0YWpab3daOElWNXdZK2RpUjNjMUQrZ2pwak9FeWdD?=
 =?utf-8?B?cEV3eGtwMFRDTDgzOTdSTVRrWkU3dnVhNWUvOGxuNkVNcFNkbzczNytCNXFP?=
 =?utf-8?B?b1F4R2JiYmY3VzR5RzVkL1hVd0xYc2hWOExLeWZ0WG9FN1hMMnUvQk5GR012?=
 =?utf-8?B?Z2lXck9jV0pYTlNPNElCOXZJMEFpL01CUXI0RzFUQmJCUHJFVXNUNGdPTFZC?=
 =?utf-8?B?YXAzTVpHTWNDMXJFdkgvREZlRVQ0NEF0RmVLRmh0b3hwbHRHOFJVU0tIYXd5?=
 =?utf-8?B?NWNrbXpySGZ6blJrS2hHMEhYYXA2ekhSSXRYNW5BbzRhR2pXRUJ6bUFKSERP?=
 =?utf-8?B?WHRSOVpKVWw1TVJNaitFYjhSTWEwK082Skt4cTh5VmRTYjhSSVpiSFc0Kyta?=
 =?utf-8?B?WVpFeXdVWi9ybkF4M0ZpL3NzZ01JNnVweGtqdUIxQldWU0lEaWZFaVBTZlQ4?=
 =?utf-8?B?UGVITHZQQ2pjeVN4dUdvUE95VnZ1T1l3dkkzQVl0L2hIV2ZDMEJHQkFxUHp5?=
 =?utf-8?B?Yy8wYm1PT1owMXhYTjVVc2lPMXlPNjJYN2RLdTNHSWRaVFQ5WjBHM0dORmNB?=
 =?utf-8?B?a0pMeEhPMWRFcHZIUGxWZHM5NnRCTE9tYlhCUkNNMndyWXRKTmJnQTBtRWIw?=
 =?utf-8?B?Uk1zQTBjR3ZVQ3lYWU9MeGtaby9NWGhJVXRzWlliK3JqWEpZRE5HTXZZL0tT?=
 =?utf-8?B?UlZXUW5OeVRKamYzRHdqcnJBcFhRNVZuZk5NWFFWQ0V2S2ZFZzN0Qnc5d2RU?=
 =?utf-8?B?Nnc0ZUE4SHAvU0lhRUJQZWdPVmJkV0tYTWg4U1hPZldUNDB1SkNQSXhKZTFW?=
 =?utf-8?B?ejVuRVpsQzdmbVdVWm5JZmZtYlJGVW0yNUM1U0twRHNkRyt1VU83RGMvK1Vp?=
 =?utf-8?B?UW0wdEY3QnFLR2x0WERtbGJDTnNFR1BsbFhGVWxxbmhsV1BOeUdrd1EycE13?=
 =?utf-8?B?d0lZN3d5QUpFQjVSMXlwMDhQdnh4VUFpUEQ4bG5mMjU1VEY0cTR5bXVIQmFK?=
 =?utf-8?B?RUdnMFNzYVFzR2NmZkpTelVkQlp1NWJxS09tUExYYVNuYldEcGhBNDBqVmtR?=
 =?utf-8?B?Y1Z1d1UvSDBsWlpOMjVaMkgxcUV3UWxnK3ljWTFWK2lMRkYrbmZlVFpYc3cy?=
 =?utf-8?B?RTdkRWx6djdSL2N3YzZMM1hlbGxmNUQ4cTVWQ0hicXBWTE5PTFUweEFLWE9L?=
 =?utf-8?B?MTduaWNwQ2svaEV3dDVFbW1YbUdEWUZtSzU4blVQWmwwZDI3U0Z6NUxBRXpo?=
 =?utf-8?B?OTRWVXF0MHdmcm8rQjdocjFsK09wbXlKaFNKUVZlWmlHMjdWL25DUFNwd1JO?=
 =?utf-8?B?eE9hZnJQYTYycWx1S0dFb0JoMVZ0UElzTHpWaGNVSW1LNmhndXZCQXhMa1ZB?=
 =?utf-8?B?ZXkyc2hQRUdzUFdhQnRZUHlINWgwdjhKZWcxQTY4UE9UQnE0SWZLR3Vna2t6?=
 =?utf-8?B?dFdPSll5alR5elozaStPVUNFYXkyMmlGVXgzQTlubVhqQnRrUHo0WDFhQlZG?=
 =?utf-8?B?U0V1TVRndS9RNCtMTzR2TlM3ZEJnQVAySmxqMHpWaUM2NkxrVEJ0b3FhNHll?=
 =?utf-8?B?bFVxMW02N2xNL0VDaVh2S3ZkU20zdm9qdkN0NE9RbDg5eDdQZFRxdkk5OWtH?=
 =?utf-8?B?enc9PQ==?=
X-OriginatorOrg: eng.windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814b62f0-712d-4bc5-64bb-08db2037cecb
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5824.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 00:47:07.0907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXpM/fJKHwjXvfkYxLV1enUoZtPIjAgXnUaTPUoGlXAxeo1eHiDCBtSMcwd6IwzdHKiJETHl0qaoSVUwjQgXxRMO/AmA1meHWLv+t2YD43Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4835
X-Proofpoint-GUID: 0RPLG7BJksldoy8iuKPtGcMy5mji9GKB
X-Proofpoint-ORIG-GUID: HwPwIhTBBjbSwxVP6ZeibumJMzQegYXV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303090005
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Mar 2023 00:47:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14529

Hi Richard,

Thank you for your prompt response.


On 3/8/23 18:49, Richard Purdie wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> On Wed, 2023-03-08 at 17:55 +0800, Xiangyu Chen wrote:
>> From: Xiangyu Chen <xiangyu.chen@windriver.com>
>>
>> When the package library name contains like _append/_prepend words
>> and the pkg-config added those libraries to requires, the do_package
>> would report an error message:
>>
>> "Variable xxxx contains an operation using the old override syntax.
>> Please convert this layer/metadata before attempting to use with a
>> newer bitbake"
>>
>> This was found on latest version abseil-cpp package due to there is
>> a library name called "absl_log_internal_append_truncated"
>>
>> So discard to check a variable with "Requires" header in setVar()
>>
>> Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
>> ---
>>   lib/bb/data_smart.py | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
>> index c597dbad..fc33d34c 100644
>> --- a/lib/bb/data_smart.py
>> +++ b/lib/bb/data_smart.py
>> @@ -539,7 +539,7 @@ class DataSmart(MutableMapping):
>>       def setVar(self, var, value, **loginfo):
>>           #print("var=" + str(var) + "  val=" + str(value))
>>
>> -        if not var.startswith("__anon_") and ("_append" in var or "_prepend" in var or "_remove" in var):
>> +        if not var.startswith("Requires") and not var.startswith("__anon_") and ("_append" in var or "_prepend" in var or "_remove" in var):
>>               info = "%s" % var
>>               if "file" in loginfo:
>>                   info += " file: %s" % loginfo["file"]
> "Requires" seems like a really strange name for a variable to start
> with, where is that coming from? I don't think we should be hardcoding
> OE-Core specific datastore usage inside bitbake. We're definitely not
> merging that as is.
>
> Is this from the pkgconfig code in do_package? If so we should probably
> take a closer look at what that is doing as it doesn't sound good.

Yes, indeed, the word of "Requires" is coming from pkg-config .pc file[1].

When do_package read the .pc file, it would pass the "Requires" 
parameters to setVar in data_smart.py.

The setVar has a variable checking, when the variable contains 
"_append/_prepend/_remove", it would report an error and exit.

Coincidentally,the abseil-cpp has a library named 
"absl_log_internal_append_truncated" and declared at "Requires" section 
in a .pc file, it would hit the variables checking in setVar and this 
cause the latest version abseil-cpp cannot compile successfully. The 
packages(e.g. latest version protobuf) which depends latest version 
abseil-cpp also cannot update.

[1] https://people.freedesktop.org/~dbn/pkg-config-guide.html


Br,

Xiangyu

> Cheers,
>
> Richard
>

