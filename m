Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A2EC3DA6E
	for <webhook@archiver.kernel.org>; Thu, 28 Dec 2023 07:16:17 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.119147.1703747768199900881
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Dec 2023 23:16:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=Zu5c1KhJ;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=07269ff83f=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BS5e2t6016354
	for <bitbake-devel@lists.openembedded.org>; Thu, 28 Dec 2023 07:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=ihTRj26EV2Qi+Mk3d4LN+yFMLMVXLOLNZHyQyC+FG3A=; b=
	Zu5c1KhJYu/mwEFoRIdXY1VD3fOQE0XwMost6TIiHbRqiGD9VQBCfFdz0niuVIyC
	SBgwi2E5xIUarAgCeO41vGeSxfrdeZ/9hi8WDzCtjK7Z8CgXVMif6GfNcDQl2Xqm
	8D58VaYIrrUbpuwPi+4+mhxQbbWMQkyJC7r9Mxl3gg0jz+TF3wF/CONyt/WItCA9
	fKLQrFR6wGVVhNEc8f1K640nSx8OTEobM+agN7pFkV50RpU2eGT/hN1iu3uSPBOy
	C0yqpJzV86QPftFaRTa3d4Jh5DVsuTd67Gba7Map5oTlZ6kfYWRmyerCjcIhq2l4
	Bi13zFSIL7WMIebUG93Jtw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v5ph63xwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 28 Dec 2023 07:16:07 +0000 (GMT)
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 3BS7G6Ag026620;
	Thu, 28 Dec 2023 07:16:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v5ph63xwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Dec 2023 07:16:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CR20u1N0dxsIjKJS2d6NoF8BZnj48szaDFCXg118OplydoFDDu41U2XySOyy83+N6fRlj3OQvE2ag9K6WQWOPMCFdF4GFGI7Fq8LOF8Q4bT5VagaAm960LGKiEBERkHZFURC2GP0VGpV5sHcVqm8mps80SJswgd9+5ynoTexiRPkFte9Kfndf4z9s6vmdsK6Ct9FTnYnRgN7XzIF1XSAPHQNIXudhsIZRT5CQRiQbHZZkvS4l6p9XMQ62sMFNiBvMAHD7HrgnO72JUfn97snFMXTxSM3Nfpwx5G8pTF7Nu6s1M75j/dxgAsDbp7dTonfAV4JMc3rWL4wQsqAXvqzhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihTRj26EV2Qi+Mk3d4LN+yFMLMVXLOLNZHyQyC+FG3A=;
 b=cQVkXJJBhxZzoB/lA3puA82T/8H9MWCWiOO1mWnkRi4YC+4oIcStvsJGhv6Q/biN1znfFCFfoBpa/UH31yzRnvrQEJc+Z+kSbI3+6ImrBsxi2wziZq+AHiigLUAQmEKmkvzjkElEb6xrTgZqZ9KSkqxi5PL2NGX0r12M2P/CGmwVihnkKF4mfeVSxkk3aztUFqFZHOrUr/FMhlrjfsssqgtaRm3DCUbEMYiT+qfviYLsd9fXArJztKjbhWdAHmsHRJSVES/5fXoRWHdWvJXnYubrezLLamNMwCIXWT0NmsW8cKGfrjCZzA/GDD3ASQJTSJQQSxVHJlFSG11VSTXQ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BYAPR11MB2789.namprd11.prod.outlook.com (2603:10b6:a02:cc::11)
 by SA2PR11MB4827.namprd11.prod.outlook.com (2603:10b6:806:11f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 07:16:03 +0000
Received: from BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::5d43:ce18:14be:b2f7]) by BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::5d43:ce18:14be:b2f7%7]) with mapi id 15.20.7113.027; Thu, 28 Dec 2023
 07:16:03 +0000
Message-ID: <666b301d-e444-4a20-a5a9-602e56e773b5@windriver.com>
Date: Thu, 28 Dec 2023 15:15:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v2 1/1] bitbake: event: Improve error
 message for eventhandler
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org
References: <cover.1703602054.git.liezhi.yang@windriver.com>
 <fc7836bc2ab8d8eded60098081d74d427091ad74.1703602054.git.liezhi.yang@windriver.com>
 <eaf8b03af08d979f90db0eca8ac46281ae29436d.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <eaf8b03af08d979f90db0eca8ac46281ae29436d.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0061.apcprd02.prod.outlook.com
 (2603:1096:4:54::25) To BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_|SA2PR11MB4827:EE_
X-MS-Office365-Filtering-Correlation-Id: ff378c2f-4650-4610-17d3-08dc0774d996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qZ3tBT/O218L7ZdtkpsJJc2MMezawfiY1Jl8ibd0dPQQrRfHHi8/9G1oJTgHpPRGFE/efnDd4PpLpKnmGzE9IQe4sqIiJTQnNswDxbhLcs5eSWF8KOP4C4bihRwBLdz2Gm1GVwozWXITgxmKR/6twsQffJ28Hjo5bxMXTx3jEVjKjTrMvMo3c1hFKE8BaQVDGDZSKJDPkLHMiExjbHSOkVn4sXaAcMivmcK7BUHSetDQikX1zEB/e68B1co2n+//BMlr64cL82q0dqEkhT5DkH+aSjHgah+cDNK7j+94+EWkJDtadrr+10n/D+pCdUJE6fDa5aBYtYmllSWhXUyaLcuQWr2Q6ELYiI1GhAi+jQf/Zxd83kSCv/5FW5MH7Wf54bia+uhylMoQEoSMQp0uR0GERF+fjLK2LHjTyhdGW7qHV+xLi5KQRzklhbnHKBmzMYL7aLowyw1Ox8/IWHit5cYhDi3ZBXnRju0jtrX1drUqLMAoDgXG+caDkb0Xrn2CQGv8/kxXxWvejw7ml0mGfo8QJ8/LbauguryTNHYVsiCk0ikWIee8Y5r3nxSMlz9VGhI7vWKSmw4FrdJ4aId/wIX9l5okXnGbEvo0pqMbBmVsfZ3439C1ciHiWa8nuF1uMvyWTf4OTm44wQ3SplvZwV6GETv8DnRNg49PPREJqxrkDsJlqS6lMRdb7W/52/RV
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2789.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39840400004)(376002)(346002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(83380400001)(38100700002)(66476007)(66946007)(316002)(8936002)(8676002)(66556008)(15650500001)(5660300002)(4001150100001)(2906002)(6506007)(6512007)(53546011)(2616005)(41300700001)(6486002)(6666004)(478600001)(86362001)(31686004)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RVZtOU9CY05mTWorVkRBVVBVenN1dENISldoa0VCYnpvWWN5a1RQU1NKNjU1?=
 =?utf-8?B?SHlhS2hkUEpieWlOM2QwUWcvc1V5eXRiZDhCRmJKaTZwcnEvck04T2RxcFVP?=
 =?utf-8?B?dm1oenlTRGR5aGFWYUgydjdNcEFXNnZ4VlZBbENBSnE0MGd5dG8rQkpBRzJn?=
 =?utf-8?B?Z0RsWkFYUUxrd2hpN3JJQnd6cFFvNnJkVUtoV0tJMTdtNG0zcVduUFBOaDZI?=
 =?utf-8?B?Rnh1c2RvNVg0UFpTcXhsck8vY21yekgrWThhbnRGbC8yeW5VQjBRUXZBOFpZ?=
 =?utf-8?B?K25IT2l3Q2IrM2ExeU96VmZxWUZUNDJXb3J2Zkc2WVdwWWwzMWZ3d3VDMmVE?=
 =?utf-8?B?STdJTU14SXIwNUJvR3RVdVlueEZNamNTV0RtaEt4MWFucS9yaWFGTFRlNFow?=
 =?utf-8?B?aUxoTnBETVJaNG44VDZIRWVVWnZLSVdlUEt2YlJ6bkljOHVIemVkTlBuM1pU?=
 =?utf-8?B?Qld0UEtSZlRSczN4QnVJWFJRcGV6VGpoK1ZGOHN1MFgycmk2MitBazhzMjcx?=
 =?utf-8?B?cTVKZFFMTUZ3WHBXZFduV3dWaUVSblQ1ajBnYmtKa2Q2ek4zMzdSUjBPTmE0?=
 =?utf-8?B?ZGJRc1V1VEdvZUl3MkdYUzF0UEUya1pvWnhzWE9hNGdaZFJsUEVIYzlGdTdn?=
 =?utf-8?B?akcwZ1RZSHBRL0FWcGZmYnpQelBMSUNDR0xKaE5ZaFduRThFQTNYelRvUlN6?=
 =?utf-8?B?MFJJT2c4Zjd4Y0M0WEYrVHNHNFNFUERuMi84ejFodnFzSnNpbUJkaU5UR2Js?=
 =?utf-8?B?THIrOVd3bFZYL3lrWlVmRXdzcVlBRlBrWVRONEtPOEg5b3V4cFU3a3JiK05u?=
 =?utf-8?B?UncyZzhtcytvT1RqcUdaTVBtRXZKbUtEZU5QaWpuVi92a0Q2eHA0TXltK1o2?=
 =?utf-8?B?SHFUbXJuOUVCdUM3bjdIUXo0OWk2Z1pTMGcwMjRKMW5ma1MzM05QUmliczZH?=
 =?utf-8?B?Tk9ra3d6c0VjbmJYOE9jQm9DcUJpbGlSUlY4WnBMNUtwdnNFR2JPNUtFRzBo?=
 =?utf-8?B?b0NBV0FLYzJDSjBiZzd0cUMyNTZha3VrMmJuUXlTOW1WZHlEZGwwcXpSK2hK?=
 =?utf-8?B?VDV6cEdkUStncE9MWHdyYkdWRHBXU2RJQzlCYzlEUWV6c3EvYmlMTU9JOW9X?=
 =?utf-8?B?dVRhM01WdnNTMHNEOExOcEhLS2pYOW80WGN4Mjg4bDR5MWxuNldZSHlTaVNW?=
 =?utf-8?B?TG5tTllpL3VoZS85eHRxbXJGVUkxbktTWWxLSkFXU3FJeGtvS3BZelRReXJP?=
 =?utf-8?B?Smo5cm14M3hVS3Y1ZHhuNzhCZGcvT3BocVRRdFY3d0RyOGFJU21TY0hieml4?=
 =?utf-8?B?bTJvNkRzUkNxY1hHU0ppQ1gzN1BrV0xaK0RPTzVWVnNIUEJLTGZ1N2JFM3RR?=
 =?utf-8?B?dmRGV3BaZHVWbkYwc0k5WUx2SmdnU3I1dUVGTk5CYTVhT0hrQ0lZZC8vL0VO?=
 =?utf-8?B?djJmNlMwa1RkYXZSSjBtanc2dEdhcTVOY2hZS2p0Z090L3FEM0ZSN0xSZ0N3?=
 =?utf-8?B?Z0dUaWFpRHlCKzVHZTBFdmdPbW1YUzVyN1BIbWJ2TlBTa3RMc0hxdjIyN1Fr?=
 =?utf-8?B?aW9qZFduZDNQNjcxZmlCL0VScm9CTm44SWNWMERoZVFQUEY4NWR3TjJaRlNu?=
 =?utf-8?B?ZWhFTTBtMTVWYmIra1p0M2IzbnhxN0VVampJT0ErYUEyMFpPSW1HV0RzeXJN?=
 =?utf-8?B?ZXQ4VElkRUZ3VWNMU0M2cnBDMXdYTHNLMXlFaGdHY2VJejdabzdma250dDc0?=
 =?utf-8?B?WnRYbGZhTGVrM2dBMmhjTktBZ2NOUTd3TWw3RmVpbnhqTkZtWWNRSml2UmZB?=
 =?utf-8?B?THRGNElIM3F5b3l2eE8vODA0bmlaMGs5OHMwVURYQVBDVjREK3pUd3RicTBx?=
 =?utf-8?B?Y2Y5Sk8yR3JkYis5SmszbmtqVGVTbTE3cWpaaVVvL2dwNmw3cWVjUWRuLzNC?=
 =?utf-8?B?bnMrMVNJUW9OZ1V6OFFvOG5sSSs2THVQamJxZS9OL1l4NzFiZTdvQzFUZkhv?=
 =?utf-8?B?ak8wY1hqTjVMTWNYS2JXc0dlU2lVYmk2WlhaM0FqOGI0dkdRT2srVXFlNE1H?=
 =?utf-8?B?M21TdHIvYkFPd1hTY3l4c0hVczJDS3dTUlM1M1BSYWQvdHhSb1B5QW5CM1RZ?=
 =?utf-8?B?S01iNWhXb0cxVGdwRW9OV2d6eFFBbEcwWkdGYXpMYUx0L1ZDQnlldk4vNDFx?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff378c2f-4650-4610-17d3-08dc0774d996
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2789.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2023 07:16:03.1742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dM+8M7bNSxGeEYlDwRUIkFsEoZ3y57iCu15l9GEtMbN5qWvRl85uNgOhJb7j8g2kEst1gR7Uh8lkshLw52iRTh6fn9boDZYvgsJjGTdy0BY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4827
X-Proofpoint-ORIG-GUID: GU8qxLLN1c1SG2Jy9XjeSNQhNu420q96
X-Proofpoint-GUID: LDa-GKBYzhbFpOSs0u_qM_jP3nHfcUmN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312280057
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 28 Dec 2023 07:16:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15711

Hi RP,

On 12/28/23 07:42, Richard Purdie wrote:
> On Tue, 2023-12-26 at 07:11 -0800, Robert Yang via
> lists.openembedded.org wrote:
>> From: Robert Yang <liezhi.yang@windriver.com>
>>
>> * In python 3.10.9, the error message was:
>>    ERROR: Unable to register event handler 'defaultbase_eventhandler':
>>      File "/path/to/poky/meta/classes-global/base.bbclass", line 4
>>        # SPDX-License-Identifier: MIT
>>               ^^^^^
>>    SyntaxError: invalid syntax
>>
>>    This is hard to debug since the error line number 4 is incorrect, but nothing
>>    is wrong with the code in line 4.
>>
>> * In python 3.8.10, the error message was:
>>    ERROR: Unable to register event handler 'defaultbase_eventhandler':
>>      File "/path/to/poky/meta/classes-global/base.bbclass", line 4
>>        an error line
>>           ^
>>    SyntaxError: invalid syntax
>>
>> * Now the error message and lineno is correct:
>>    ERROR: Unable to register event handler 'defaultbase_eventhandler':
>>    File "/path/to/poky/meta/classes-global/base.bbclass", line 256
>>        an error line
>>           ^^^^^
>>    SyntaxError: invalid syntax
>>
>> * Fixed it via:
>> - Don't pass filename to compile() to make it can report error code correctly
>>    in both python 3.8.10 and 3.10.9.
>>
>> - Fix the lineno offset and filename in traceback message.
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>   bitbake/lib/bb/event.py | 23 ++++++++++++++++++-----
>>   1 file changed, 18 insertions(+), 5 deletions(-)
>>
>> diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
>> index f8acacd80d1..9eecb141379 100644
>> --- a/bitbake/lib/bb/event.py
>> +++ b/bitbake/lib/bb/event.py
>> @@ -260,16 +260,29 @@ def register(name, handler, mask=None, filename=None, lineno=None, data=None):
>>               try:
>>                   code = bb.methodpool.compile_cache(tmp)
>>                   if not code:
>> -                    if filename is None:
>> -                        filename = "%s(e, d)" % name
>> -                    code = compile(tmp, filename, "exec", ast.PyCF_ONLY_AST)
>> +                    code = compile(tmp, name, "exec", ast.PyCF_ONLY_AST)
>>                       if lineno is not None:
>>                           ast.increment_lineno(code, lineno-1)
>> -                    code = compile(code, filename, "exec")
>> +                    code = compile(code, name, "exec")
>>                       bb.methodpool.compile_cache_add(tmp, code)
>>               except SyntaxError:
>> +                exc_lines = traceback.format_exc(limit=0).splitlines()
>> +                # Fix lineno offset manually since compile() cannot handle it correctly
>> +                if filename and lineno:
>> +                    line_first = exc_lines[0]
>> +                    if 'File ' in line_first and ' line ' in line_first:
>> +                        lineno_new = line_first.split(' line ')[-1]
>> +                        if lineno_new:
>> +                            lineno_new = int(lineno_new)
>> +                        lineno_new += lineno - 1
>> +                        line_first = 'File "%s", line %d' % (filename, lineno_new)
>> +                        # Fix filename
>> +                        exc_lines[0] = line_first.replace(name, filename)
>> +                    else:
>> +                        logger.warning('Failed to fix lineno for %s:%s' % (filename, name))
>> +
>>                   logger.error("Unable to register event handler '%s':\n%s", name,
>> -                             ''.join(traceback.format_exc(limit=0)))
>> +                             '\n'.join(exc_lines))
>>                   _handlers[name] = noop
>>                   return
> 
> 
> This is better but I'm still wondering if we can improve. The other
> trick we could use is to inject "\n" characters into the start of the
> string you're compiling so the line numbers really match up. Would that
> work better?

If you meant the following line:

if 'File ' in line_first and ' line ' in line_first:

I can use re.match() to improve it and send a V3.

// Robert



> 
> Cheers,
> 
> Richard
> 

