Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD9AC46CD4
	for <webhook@archiver.kernel.org>; Tue, 26 Dec 2023 12:45:51 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.80839.1703594742066513639
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Dec 2023 04:45:42 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=lulP0fHO;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=072481253f=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BQCVm6n020766
	for <bitbake-devel@lists.openembedded.org>; Tue, 26 Dec 2023 12:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=b79cV+XYr4W4yH52QF2uMAPbNgevQrMHDaqGlp+li/I=; b=
	lulP0fHO0ErgVJSKEQGwet8FHNq0O8B+/+9EkasWnhfrF2UJHmLjrAKahfk9eBWt
	yP7W7QESzYxeYd6yiCTqfCnm4CKAgA/Y2pX+b9uKiMS85oVl7SqiaZ42LCMHLePq
	MJ5XTmK+MAIzpyD4c6Dle7Mo4Gf7+HmMfRH0nlo10tIPae6E4ZH68hqYIhMOxJIH
	VFljdpxVrbc/vuUgi/DqeZzDIQyp2sYdfZutFjdPuo7WDk2e7yMh8zwnhktUkG4e
	cMLQmgc/TU9LrGeY2t3GpekaPCR8CGtRirtSff3c9rMP8Z68rcmHEcB5NRGx2FIh
	+2qNC/xhwqBeJFCgG2yJXw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v5mrxtc2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 26 Dec 2023 12:45:41 +0000 (GMT)
Received: from m0250811.ppops.net (m0250811.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 3BQCjeeK004001;
	Tue, 26 Dec 2023 12:45:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v5mrxtc2m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Dec 2023 12:45:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmeednwwK1w4sOOTWHS12f5OMaMy3rZTRwGSFf8+UaETglC8bwrwTWu0rKdW4usesNJ7PRAhsqFThViIdlOii1KOU2mt1HHOD/UnSABVtMmXC+FzzOcqEJVtKfnIwQ4KuIOe7ux6/WsjSdTbig/c0EE2mHaxJIJ9ferqi+MWAhQ9iThV/gHPzfCJDsw49xpgStGsSOx83lUq+9Ubif7R5XLfCmNEzXzxp6A88xaWyw51FU57A/5bkyAA830Xeciutj2Q2k8fzyH4NsVYj0A9xIgNF/JYovhwor0G/+LTPfyE2w8LV7o37nyQ/tI0qo5UUcf4p2TQ2QFtUDXz4Py5mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b79cV+XYr4W4yH52QF2uMAPbNgevQrMHDaqGlp+li/I=;
 b=KiejBbA0yfySOW03MC2pcLKYB6QvogyQD/mvF3GLPB2cR3bm6Xoqyq/Ik2mknqOX2BdZSz9d6hdgRzJO/pWusQwHiIfSZiOl+covnXJ8DtRNVthoYEQ4nJWeejOolYGpZ9lRAikawZf5EzZTs3mbUdPBLR2qigsvMy49SbHbCSgY3rL5GCdtCvOvGjtyBUlB0C3rbunUOU1xmP+BH5az6VkoOmISZPce8cVCE6lNMBgij5TZgKWU8nk5QOMoWm17ZhI1PTGIlhHubOHTPkrlBltdDtFPybeKs2y9kgxAtUShuJ1egAzkBuq0gd5a/0hJ7FF62/zSy14Q21j9Dh3s1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BYAPR11MB2789.namprd11.prod.outlook.com (2603:10b6:a02:cc::11)
 by DS7PR11MB6245.namprd11.prod.outlook.com (2603:10b6:8:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 12:45:35 +0000
Received: from BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::5d43:ce18:14be:b2f7]) by BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::5d43:ce18:14be:b2f7%7]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 12:45:35 +0000
Message-ID: <4252fb37-5f44-406c-9131-80e72a1f42fc@windriver.com>
Date: Tue, 26 Dec 2023 20:45:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 1/1] bitbake: event: Improve error message
 for eventhandler
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org
References: <cover.1703133461.git.liezhi.yang@windriver.com>
 <2fd4acbc082469c6c665dc5499ea471d9223b42c.1703133461.git.liezhi.yang@windriver.com>
 <634a0dfe7e95fb8c33f0557b4f6ea3eca19f65e7.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <634a0dfe7e95fb8c33f0557b4f6ea3eca19f65e7.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: TYAPR01CA0079.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::19) To BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_|DS7PR11MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b20fb3b-99f9-48d6-6786-08dc06108dd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VkrF3ekYWMg//Y2HcBjqUyOkJQAtr/f1/PhXkQ/MfHr8BrpaxbmnC35AJEvLs8TdhDgeaNk+1kaW5tMtqj5LSrWBA/bXA83mURb3QK116lcFqDYyjQLsjSHAvxrkVirPnVFgH/YmIUI3u2yZoO8hkb5Q3eeeK7HAmL+xZq7D5TZFuDa0V2jVYYAHClxIb7OUSc+JGpfCIW9iMtt0p6ShzK667U+FQfxwPUTsVzX1Z2H+dwM3eyTS0HlafhmAYi7VsJPcixU/L1E+PJO9mL8B1PHLqcIbffztKabqX71x3nORcrg1dSy5FLkpp9RbPphufERPYTMq3aXsBcWXzkoakDsCCrfll9E/P4Ahgz6GPfEuivPs1dR+iWCyZUmbx4Ao7Dqmc38Sq4s8K+ffesNN2k2tD1u6WOntNeW+YRaRQn+Z0tvF5aU1wQTG76WVYQWwFamN/v//vXiyK3zTQVZgbcR3kemft7UWsRp7qni2AxMOBM/7Cdjqu6+t953n4GIq6sDZjtioYr6LtgDq1FFj4zbJv8PHb2Cp59wfSOW16g/LCJh0YLPVjCRoxa4DuJWMCsSM7R9RMkwJYU7caDkKj4tfEGoavsqYRUchwupFo+227QQ3WBjBoVLMy3kNfT+rxzAedKE8fvEbUgVGPFmi3g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2789.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(376002)(366004)(396003)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(36756003)(5660300002)(2906002)(15650500001)(4001150100001)(53546011)(6506007)(31686004)(83380400001)(6512007)(6486002)(478600001)(6666004)(26005)(8676002)(86362001)(8936002)(38100700002)(66556008)(66946007)(66476007)(31696002)(2616005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y1VubGpmZk90WlFyUng1L01tTmFvd2ExU0VQWjlYMEZPbEs0YUdXZ0o1NVhM?=
 =?utf-8?B?engvRlZYcEdLdzhtZlJSMW9Xd1d0RHRwSTIyWVE2dityZWVkY001bjk4TkF6?=
 =?utf-8?B?MnJEYTBDTHMwQXdFNGQvUUlRSzJodlBHUEhIWnJ6QlVmY3BlL21CNXpTSmFH?=
 =?utf-8?B?eEJJMllBQ3AvdTY1eEFSV3ZDb2t3Y0FNM1dIK041bHVwYTlZUmIyVTB3RDlz?=
 =?utf-8?B?bi9UTERTbmhQSUVqelpYajRvbzNiQTg4WlcxWEpTeDJNTEZsVDV5ekpqRFIr?=
 =?utf-8?B?enlkbVpXSFY1aFRyMnFLUWwxN2pFNmlhaExTcGkzbjNvMnBaaUNnSWhaK0ky?=
 =?utf-8?B?MFJDNUs1aUdJY1VKVmViUXpCTnpqY3NXMW9EUzlyMVFnZXRPOVdNTDhJQWZS?=
 =?utf-8?B?TTNERU1TcnViQ1VpYkRRemNQYXFCYkFsNVdBZGtqaWVVSmlqN2FlZ1ZPamUx?=
 =?utf-8?B?bHkxdTQ4RnJVMGl0L2tRcG5VUkNoNFJ0Q21kMDlIdDJrWUF3eHpUQy8wTGlp?=
 =?utf-8?B?ZTFmVGV5alF0OWNpZ015Nzd1QlViemNXNm5IbXdjOGN4dzNLVGw5dWMrWm9m?=
 =?utf-8?B?RWFXcTBadDR1M0sxZ08xd3NoRHhqQzY5Z05LZE9yTGVnNzZjeTN3RFVuaW1k?=
 =?utf-8?B?bVZ2cThUbndkaWpDUGVtWk9SNUg4V2pheXFYUmQzeG9mZW0weW1yaytIWDFJ?=
 =?utf-8?B?VEdVTDBuYzJhU2ZlaU5QekZNalpaTkh5Rzg2Yno3NmJyeDhzVGRLRHgwd2R6?=
 =?utf-8?B?TFgyaURiQlFSOUhRYm16aGhtUW1ZVkZreFRIb05WK01JUWJXUTB6T0hlTkxz?=
 =?utf-8?B?MzlaUGo3eDZya1prQ0s4UEUrN09oaEFXaFZ5ZHhHWmRPVHA0ZnQyUkNjQVFT?=
 =?utf-8?B?b0ZSUUZoS0ZRM0cvZm9Qa3BmcWhkd25OcDQrUk5zTHlGRXJNYTBkemxvVitS?=
 =?utf-8?B?emdLaWpEd1VzUnI4RHArd25abXE5TVY2ZXVNUGtMMllQTTJDQU8ralliNWRU?=
 =?utf-8?B?elBMV0V6QVFUa20rUWNNSkVacEhra0hYZmsvejRjVkpLUmNIRHVYRXlMNVg5?=
 =?utf-8?B?T1BYMndDQW9LdG1KTHJkaGlLQjZnUndCYXIzdWo4Vi83Si9MejlRY3liSGQx?=
 =?utf-8?B?dkk3NWRxcVdPeTJjRkVsbit1a25HRitFbm5TWWtuak9tSWJhSW1ZUHJjeTRE?=
 =?utf-8?B?SUV5TGxVS0Y2UnZMZFYrYVpPUUJJZnh4dU5UNlpxd1F4b29HQnJwMDQxdjFG?=
 =?utf-8?B?ZVR5dmFydy9tS0JWMC85cjhYMjVzYVZFaHY5WjZiczFjVWxqU0lWbUlHaDJM?=
 =?utf-8?B?Zk5kQTZZczhFZkVMS2JmbXpEOVZBTHhlTGo2bDloZUx4VklETEFTaFB0UTVv?=
 =?utf-8?B?NE0vSkJZeUR1STBpcis4TVkreDlIa3cxbUx5MUZJRVVQL0o5Qnp0VEtnY1E2?=
 =?utf-8?B?SG5HT1YwOWFvZHk1bDVxdjYrYWdEZGMrcHJuOGZJbkU2VjBWT0FYUGNNaGt3?=
 =?utf-8?B?TEJMUE9YM1ZXQ05LU1NFeWZMZm9MSlc3WU1EVTVHSTNZMXY5a1UwVFlvWVcw?=
 =?utf-8?B?dVZYQlJ3MytkdWxtUnNDN2hWRDRFa2NkVVkvaCtWUnJFY2lKZmo2OTJod2pi?=
 =?utf-8?B?Z3pzTVhmNVZhbUtrR2o3TVFvOTRpL1MrUjBXQXZmWmZZUnFwZDg4ZzM4UzMy?=
 =?utf-8?B?em9IQ3dac3Qxd2NiWWZVcUhLeXJDcjg5K3JWekc5UkNqYm1uSFFRVHFsMDAw?=
 =?utf-8?B?ZTNMNWl5QTEyaXhyelh2MkE2SnFiSjJWNnRNTzlkZkxHc2RpaEJrdURjb0Z1?=
 =?utf-8?B?Si9tMS96ZTZub0JzVUdmTVI0cUQwdWRXMmc5OERtalhvQTdXUkZEeWxQcE5Y?=
 =?utf-8?B?RHN3ZTR4MnlMRDBXYTdvV0s2VVpmdU1UbFhFSEZIdDRIVE5rblZLM1Y3MW40?=
 =?utf-8?B?bzU4K1pQMHA1KzR1SzNYNithcFhJVXp4OUxmekgzb0d3eUJvaE1wN0ZsTGxv?=
 =?utf-8?B?RGwzejV1UHJMbEtBOXZVL0FSY0xSdHppVk5WcEtEZVY4TmRFcHNZdW1QQlB5?=
 =?utf-8?B?T2ZOVFF6MlFQOTVxblFUelRWVk5rM0NkUWRNNlpUYkNCSi91V1A2ZGg4Y0tu?=
 =?utf-8?B?TllrckRvaXFhM0ZPQmE5TnV5QkpVY3lhdWlrYm9yNm55UGlkMHA0dGJBenRy?=
 =?utf-8?B?Y1E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b20fb3b-99f9-48d6-6786-08dc06108dd1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2789.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 12:45:34.9921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: moUYCJoX0yqmR33+g8So/0th8epksGcQIihUisrWcN9tjRHqI3efKQY8k1szM+uEhXAMCBOENR3ZIp/O2uMAFUtsbJDCSeegnPTINBFfokk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6245
X-Proofpoint-ORIG-GUID: njP_5vMNWfd7tvfFLvpctZYwau8WjaDQ
X-Proofpoint-GUID: MtkbbThnQqiu6X2ikjAf7urW1ovDR4hU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 mlxlogscore=820
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312260097
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 3BQCVm6n020766
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Dec 2023 12:45:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15701

Hi RP,

On 12/21/23 17:56, Richard Purdie wrote:
> On Wed, 2023-12-20 at 20:40 -0800, Robert Yang via lists.openembedded.o=
rg wrote:
>> From: Robert Yang <liezhi.yang@windriver.com>
>>
>> * Before the erorr message was:
>> ERROR: Unable to register event handler 'defaultbase_eventhandler':
>>    File "/path/to/poky/meta/classes-global/base.bbclass", line 4
>>      # SPDX-License-Identifier: MIT
>>             ^^^^^
>> SyntaxError: invalid syntax
>>
>> This is hard to debug since the error line number 4 is incorrect, and =
nothing
>> is wrong with the code in line 4.
>>
>> * Now the error message is:
>> ERROR: Unable to register event handler '/path/to/poky/meta/classes-gl=
obal/base.bbclass':
>>    File "defaultbase_eventhandler", line 4
>>      an error line
>>         ^^^^^
>> SyntaxError: invalid syntax
>>
>> This is much easier to debug.
>>
>> The filename and code doesn't match since the file usually contains mo=
re code
>> than eventhandler, don't pass filename to compile() can fix the proble=
m.
>>
>=20
> Sorry, but I really don't like this change. It is now giving a filename
> as an event handler and an event handler name=C2=A0as a file. To some, =
that
> is going to be even more confusing.
>=20
> What really needs to happen here is that the line number needs to be
> fixed with the offset in the file. You'll see the code already does:
>=20
> ast.increment_lineno(code, lineno-1)
>=20
> so before printing the traceback, the code probably needs to account
> for that offset in the in the exception handling too.

After more investigations, the compile() or ast.parse() can't accept a li=
neno
argument as offset, and the ast.increment_lineno(code, lineno-1) can't wo=
rk
since 'code' is None when there is an exception. And we can't fix=20
traceback.tb_lineno since the tb_lineno is for event.py, not for 'code'
in compile(), it seems that we have to fix the error message in traceback.

And python 3.10.9 is worse than 3.8.10:

* In python 3.8.10, the error message is:
ERROR: Unable to register event handler 'defaultbase_eventhandler':
   File "/path/to/poky/meta/classes-global/base.bbclass", line 4
     an error line
        ^
SyntaxError: invalid syntax

We can see the error code line (an error line)

* But in python3 3.10.9, we can't see the error code:
ERROR: Unable to register event handler 'defaultbase_eventhandler':
   File "/buildarea1/lyang1/poky/meta/classes-global/base.bbclass", line =
4
     # SPDX-License-Identifier: MIT
            ^^^^^
SyntaxError: invalid syntax


I think that we can fix it in the following ways:
1) Don't pass file name to compile() to make it can report error code cor=
rectly=20
in both python 3.8.10 and 3.10.9.

2) Fix the lineno offset and filename in traceback message.

Then the lineno and filename will be correct for both python versions:

ERROR: Unable to register event handler 'defaultbase_eventhandler':
File "/path/to/poky/meta/classes-global/base.bbclass", line 256
     an error line
        ^^^^^
SyntaxError: invalid syntax

I will send a V2 for it.

// Robert

>=20
> Cheers,
>=20
> Richard
>=20

