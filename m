Return-Path: <mingli.yu@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7537C7619A
	for <webhook@archiver.kernel.org>; Wed, 12 Apr 2023 02:42:45 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.34123.1681267364555755409
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Apr 2023 19:42:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=rLKC7Lx9;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3466d2cce5=mingli.yu@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C2SJGu004841
	for <bitbake-devel@lists.openembedded.org>; Tue, 11 Apr 2023 19:42:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=message-id : date
 : subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=90BmOVddIL6TPMeCxlT6mLJ5JeH8kCffc2R5SzcAR0Q=;
 b=rLKC7Lx9DTxNnyn2okUwlzyUey3fe2WERuZihxfn6SXzybirU2apRNSev9a8+rRacA5l
 qUyOgDEAtpK1zGk6cz7Aniur1dFVaGkBhOulxNUl4/RxROcjMoU+f3GRPaIeLu5VAw9k
 BUOhH1RvRf+5rFk/2L5JYnGXSIA51cXCL+z0K+XxVHzglzv1ZnUv7sY6WzZM7l8MxCAN
 5iqsjwA7CX51xA9sQrDuaNhWyMxqPkuO5q/2CkJTg2j2V/4RbTC6fIdhg5B+xAP/2Jc1
 +5rXNv0tLxEMTcS319A5eZfSJyB2bp/WQnXgjLxf9kS0yvuGwDr6KF0NVraOsZk8viCl sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3pu3j5kqd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 11 Apr 2023 19:42:43 -0700
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33C2gLOT002596
	for <bitbake-devel@lists.openembedded.org>; Tue, 11 Apr 2023 19:42:43 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3pu3j5kqcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Apr 2023 19:42:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCMIClyCh7fCl9qqOT6oh4UGvpyNquYvU0ak3OJNh42HdSIFLR1lRNto+mxu2FV56q0NbOL8Wc3Bizg6FjLO+qhhUS7GlE6PZnQ9z0D1MTh+92vmF6fL0FSzEur+kklS/wCn/ZE7SJQOdj0X6EPQbEkAhSp5YAua9AfQ5pdQOPFNusyEaFunuBbOHpgfc6RPUnvXKLFF4aLPMpXUXb42OUN5H/GIQ+TIbHLihE/zJ3w5DffOkFCKmnRjkqn0c1fDnTUKerLDYGqaGevf7ZhhTZO+fkrw6TGJ18C0IlufU+Qjlr+CudiNa4a5QafRQdpLFZ95DX8Lur2o2P2YNkNbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90BmOVddIL6TPMeCxlT6mLJ5JeH8kCffc2R5SzcAR0Q=;
 b=kBf/goatvwr2B4H50/E5XiCP0W5Yc8zz74FZbYgt9tSqeqMu4CP1LjVLWgsgKL3GuQbRffe1vwUs/hO0lDGAA+6GgfE1CB/k6dZb4Njjz7X5yBRPnkH0//rsOsO+wUPXmplJJRJKbO08x3bEfUz/JErJAv5ucJadI7fDEzbzOS2TzvNyqqqL5sZ+NjgG94IxKyiKyr9/Ld8pz/TY46kczSE8hTN380PeOS9AoSOZq9fEm3ft8wOLsmR1D+ClekbLOLqCVigJKtgAdyUkOJavQsQhQ0dPty/348JfxAEN3iBVQt9d2/D3sImqEWEOyE+Z1FZ7Z9ztlxE15zqChlErHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB5009.namprd11.prod.outlook.com (2603:10b6:303:9e::11)
 by CH3PR11MB8316.namprd11.prod.outlook.com (2603:10b6:610:17b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 02:42:40 +0000
Received: from CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::27b:6677:587b:a4ab]) by CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::27b:6677:587b:a4ab%3]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 02:42:40 +0000
Message-ID: <08ac7a35-db3d-430f-5d10-f96a90862f1e@windriver.com>
Date: Wed, 12 Apr 2023 10:42:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [bitbake-devel] [PATCH] event: add bb.event.ParseError
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        "Yu, Mingli" <mingli.yu@eng.windriver.com>,
        bitbake-devel@lists.openembedded.org
References: <20230410091900.2897894-1-mingli.yu@eng.windriver.com>
 <bed59afa659823a6656aa978168330642648811a.camel@linuxfoundation.org>
From: "Yu, Mingli" <mingli.yu@windriver.com>
In-Reply-To: <bed59afa659823a6656aa978168330642648811a.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To CO1PR11MB5009.namprd11.prod.outlook.com
 (2603:10b6:303:9e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5009:EE_|CH3PR11MB8316:EE_
X-MS-Office365-Filtering-Correlation-Id: 8231c450-07fe-4038-5084-08db3aff955f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	J9JRFenzune6nnc6nXllFNV4HJA8w4nFdp85oD2urToj/n1lohI5SpGrtxRigUha6GN0kcegGXPMHbg9F+R73x40x/9QWxK/NbfCYcOFyklP3tBpYfoysu/HEy9zKsKtB6ap0yb6E4AucqU+AjD29pKnb6aqacechzliIK0czLOE9EoxEWwtHQQN/Vq+AP+smNB5Rel/pUonY4Bt8k/bXeOUz0nZtzZDmP0aPkhSkPc6pwMInUeWzWOHYr5+uUgGETvEBZ9lkw9wZQggCu/x3BArsIebkbRldI2j+Dj+d/SxHTnNJkL9a3LGeSn+EmBnNI8KvLpulTloGrmYId/rFEc1R6kv2/5y60k/kwaJLqQEAxxGIrlE+sf1mTlymyIBx+2WVwWVetf7vrz1EulUVV2k+eVfaA/IhYyS5pbwoO3Qyoen5TVUM0XqFFogwlIiWKf5JM2V+M4dyIt32Y98NHPMvvXIHns/IpIe7laN3tA4Xafcrz2QxdDL101Y2ggBzaL4D/zEpgw5XqnnaK1D5BxkC5ko9yDSPC2DsMRVFIXj96id7ohIJ9vQ6d5y3VJo3o/r76AETVjJHLpsccOoms2cANUZF98mQmJyHb1Od4T/LA56U7Ia6tjFb5QdPkrjNR2FTHgSJ1/W6UyoY8aVEQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5009.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(136003)(39850400004)(376002)(396003)(451199021)(2906002)(36756003)(478600001)(26005)(8936002)(53546011)(38100700002)(2616005)(6486002)(31696002)(6506007)(6512007)(83380400001)(86362001)(186003)(5660300002)(66476007)(66556008)(8676002)(66946007)(110136005)(316002)(31686004)(6666004)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MUFjait6Qy95WXRyWTBlU3RNOHozZTZjeHJVbG5iOFRtcGhrS081SjA5OExi?=
 =?utf-8?B?VE44NGZwZjFVK1Z6cFREMFhrMU1EZDVPYms0V3lGUGl1MGh6bFRxZnpyU0VH?=
 =?utf-8?B?MW5vcThrL0lwQk0rdll1UnZVRzdleTBRM2tyMk5wVlR4aHFhWUgxUDVMYmp6?=
 =?utf-8?B?c2V6a1B3VEs4VFlOc1d4VUJldEw4a2xreFVGclN0UWhPM1ZlSEdTR1FoSWln?=
 =?utf-8?B?ZlFrdnRXbTI5di95TzFtNVdkVUl1NTdHSmNWUDVIcHpzNlVwelpuR3pVcFI5?=
 =?utf-8?B?SW95YjhUVjJodmR3bHdxbmlkeU9WM1FWMVhOS1NFNjB3K1o1dzNsdXBiVW15?=
 =?utf-8?B?WGFaN3pvejNldWJTc1RMOXAyNjhKY0l2K2FOSjZqQWhhd2d6N1VaMEh1bWdV?=
 =?utf-8?B?UXRBSWFKOWF5dFg3UDFpbEdadldVOXJXY1BoZE9hZEFqWHZyQkViSU9LVmxS?=
 =?utf-8?B?UnJNYUt6bWp2RlRhbEo3Sy95cytXb3VOMlg4WlR1Z2V2NjBTU2Z0a0tlczNz?=
 =?utf-8?B?c1VQbE9oQ1lsQUZmbGZwWGg1ZWdoTm1kamtwd0M2ZGdHOS9uUVZGQ1FjSnJV?=
 =?utf-8?B?VjJENTZtRll3RExxb0ZPNjF5S0VHNTd6aDc4WGZlUm5VVFh1enZkSnpMU0Ux?=
 =?utf-8?B?b1ZUZGNwaHBpYk5tSCtDL2RSL2xZb0tScjJodVdjT2xoN1RSKzNJSEt6b0xr?=
 =?utf-8?B?UTVtTmlYRE9XUWpVTUV2VDNVeXZ3dVFhWFp2RXE0c1YxeEI1UlJEMUR6VEdM?=
 =?utf-8?B?YnZhSjFaVjQxWTJPdXprVzFVNGxxQ1BwL1JGbHpVem5xbVRLY3QxSzNCcUxs?=
 =?utf-8?B?elI3R21qYzdhZWJHYXNWRWc1SHYzanVpcnlYaU1zL3lyZUI3bmNIci9CdXV0?=
 =?utf-8?B?WGJKTTBjQUVNS3VjZ3g4bWJKVHovUEtRb1VDRkM3bGJqNXhOaytlb0xDc05x?=
 =?utf-8?B?NytpMzErSGVrSmpZNUlIK1pDQlNqS2dBdDVGNTVFWjRaRWhVTVcyM1MrL01s?=
 =?utf-8?B?K0E4T0Y1ZjdRYWdzZGhPL2thUFFMLzM4djhKRDV2cFJHTi9hMTZNREt0cktB?=
 =?utf-8?B?bjU4S05tNlhadXF1YlgxUjhOR3VBMDRoZEFucWp3bkJjM2g2clo0Q01UKzc2?=
 =?utf-8?B?MlNNekpIQjc2MndjVWtSR3BCS3RKUmM3YWRTSW5lSmg4aU1lQzI4dGthL0d2?=
 =?utf-8?B?aXljTlpQbWJBMTRBK0hMb3RzRjRpVTBrR2Z4Y3BZMjk3TG5la3ZLbDhOaVVM?=
 =?utf-8?B?WjBQaE85d214MWpReHR0T3R3K05VT3FCZjlHakExczBUaXJEODI1Uko2V1Vs?=
 =?utf-8?B?a2s3UWp2alJjZ2R2R2NMcGZVMHBrdXA2NU9EV1Z3VHk0Y3dvOXlqcEoyQnM0?=
 =?utf-8?B?MzVZcEp1Z1BNNlluaWhGRVBwZ0JiVXl0YXdFdWROUHdVLzVwR3U0My9jUGU4?=
 =?utf-8?B?YmU0MU9WS3NhanhUaHNRcTR1Z0xrdWtwRmd2c05SaGtrMEt4WTNvTUNUaXN2?=
 =?utf-8?B?cmJMaGFHcWhBcW9MSE9SVnhnT1NncThHMVd2UUdmRDlLQ0gzK3hySVJFTTUz?=
 =?utf-8?B?T0d3cmJKbFd2c2lXVFphOHNodUpZQk01MkdzVEYvN0o5YllDWlZCWEZSdVVt?=
 =?utf-8?B?dnYreDNZZlJSTHQxVExHOWVZY0JoSHpmaGFiNVlKMGh5d3FSTGQ1MHVFR0h1?=
 =?utf-8?B?cmFCbi9xQ0VDcVdIaDdsd2JnRmUyNlVpaE9sRU8yOHFqaXVVenVtaGc4QWll?=
 =?utf-8?B?dy84V0doWElEK3ZhSlJsaXNCM0t4cWxCbGlSOTB4T3lBakhER2dReTJGK3dr?=
 =?utf-8?B?VU1WTS82Tjk1cERYMkdScC84L3ZHc2JpQXJNN1FUOHRHazhoaEIwVXU1UUdX?=
 =?utf-8?B?YUMzTUZxU1FwVFFVWEVscFBLK2c3ZHA5RTBZRTJRdTJCTlNuczlXUUVCMWVM?=
 =?utf-8?B?eE5tVGZ4eHE0VURBM3VJNHlRVGhpckFFMHBDbmpHd2d1c1JpQmtZMnNNcVFT?=
 =?utf-8?B?VTE0ZTZEb3JabU1FbXdUTEgvcTZUYnFVcDNIYldtZG52RHdBM3J2L3JhcVhR?=
 =?utf-8?B?QkZTVzJ1SVkxQ2x5NGhoYnF1bjR2bkN0R0N5MG9FeW11NWVZdnhTNE0vNTYz?=
 =?utf-8?Q?S1woNmvJVZQQDuJmVGqjuvSnv?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8231c450-07fe-4038-5084-08db3aff955f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 02:42:40.3136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IzfXZ65AMT5FjVcM+0XPSnGAs0fQ2eefoV09cxuXkyQKu/h470/s6B8u+BeB7qIgoBBUQ416ZbKENYzWqed7Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8316
X-Proofpoint-GUID: QoZAr0GmwEN13B13Fxixf1VdtL0m_7Nj
X-Proofpoint-ORIG-GUID: eixTw93KJih2ORQl_8nPSLAT7OJyl-UA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_16,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 spamscore=0 malwarescore=0 impostorscore=0 mlxscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120022
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 12 Apr 2023 02:42:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14695

Hi Richard,

On 4/12/23 00:50, Richard Purdie wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
> 
> On Mon, 2023-04-10 at 17:19 +0800, Yu, Mingli wrote:
>> From: Mingli Yu <mingli.yu@windriver.com>
>>
>> Add bb.event.ParseError to let error-report can catch this kind of error.
>>
>> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
>> ---
>>   lib/bb/cooker.py | 6 ++++--
>>   lib/bb/event.py  | 8 ++++++++
>>   2 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
>> index 1797a1d4..206f8ffb 100644
>> --- a/lib/bb/cooker.py
>> +++ b/lib/bb/cooker.py
>> @@ -2223,7 +2223,7 @@ class CookerParser(object):
>>
>>               self.results = itertools.chain(self.results, self.parse_generator())
>>
>> -    def shutdown(self, clean=True):
>> +    def shutdown(self, clean=True, eventmsg=""):
>>           if not self.toparse:
>>               return
>>           if self.haveshutdown:
>> @@ -2238,6 +2238,8 @@ class CookerParser(object):
>>
>>               bb.event.fire(event, self.cfgdata)
>>           else:
>> +            if eventmsg:
>> +                bb.event.fire(bb.event.ParseError(eventmsg), self.cfgdata)
>>               bb.error("Parsing halted due to errors, see error messages above")
> 
> Shouldn't this always fire the event even if there is no specific error
> message?

There are many kinds of exception here and each exception will call 
shudown function, but we only catch bb.parse.ParseError exception and 
pass eventmsg to shudown function when it is bb.parse.ParseError. So 
checking eventmsg in shutdown function should be okay.

except bb.parse.ParseError as exc:
             self.error += 1
             logger.error(str(exc))
             self.shutdown(clean=False, eventmsg=str(exc))
             return False

Thanks,

> 
> Cheers,
> 
> Richard
> 

