Return-Path: <kai.kang@eng.windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46A0C7619A
	for <webhook@archiver.kernel.org>; Tue, 11 Apr 2023 09:00:30 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.9165.1681203628809694646
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Apr 2023 02:00:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=aClF7Q7B;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=3465c4dfd5=kai.kang@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33B8Rp5s011160
	for <bitbake-devel@lists.openembedded.org>; Tue, 11 Apr 2023 09:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=message-id : date
 : subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=ps9ICjVePpFN5/wK3TL1e6r+KEkMKQZngUnex7E6Ll4=;
 b=aClF7Q7Be5beuAgGRBy6mNOTzpvXaULVc9IdKHe81AFIv4v0cY+4JKWoWGJBhdsV/dwX
 cuTYmx5C+kdzO0WHqXvgbMN7VV7H6hBJ8dVgS7pGXOBnlwF5vTxoIg0nRNdQcGicfZjh
 YDC5MLDIUwF/nlghKgHfH9pAWYH3/tdR8IK7gUSE5OQb2R1h6hTUqEMqJEL9YejJC90/
 2Wmv0X+DOgIt2yzT71e1zEzTIiyWhDGSacvqE0imAvSDraPwKUvXoyeXKgnOsfySCq1s
 DR6vQGJkZ0sONlYhdZ+y2C4ueRpO9EsnON2RygqN97xITy1MY+5dxltzEIs6dXWgli9x nw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3pty8b2u6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 11 Apr 2023 09:00:27 +0000
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33B90RBK016224
	for <bitbake-devel@lists.openembedded.org>; Tue, 11 Apr 2023 09:00:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3pty8b2u6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Apr 2023 09:00:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIJaAGz6psU+dXnAgp5bQZVyGMei0lke+erkdX0cUS4FT40sdsIw//thtDb2G3uejnqVHj6AezGm+eYZlfZKn9d1DbujEiDtNkL0+PwAlIFK2r1K+qRUyuQTkLI2RtAPwQUiM5Oxu1iGVgnL3KVl6IdJy6ShCqAAjhpo8ODVQ7cIAjO0xgfRApeuDog9sN5DYazJrnhKJ3iopO71ZT9+/WsFo3Px8vp7MGVbbPluxvNU4atwWYiVn4n/jg8WrqiZFoLpHaxX0upgKisD5Fx9fZnGqnclTU6iniIc1R7lli1zAyYIWr3VxLO8p+oZoCvJ3Y1YBtht/ip2ZeKyZVh9QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ps9ICjVePpFN5/wK3TL1e6r+KEkMKQZngUnex7E6Ll4=;
 b=IclyJXFQTKPLD+sBpRWXJ6HgS7xa/VJxDltomTSesTMuTDcZOBZh4wuLb6klt/qC6PTWsu8BPWue4GqYn9PGVAIpwLxMKL48Bpu8RwVcsSgBUh5/0DzLIm5xq2Rg7+kmVVnAIhZ/b1HFdNhGWeMptsla8BXWvHi0NtCpkDOJHSuVkfUTRuapVos5bcUHCsi7uLBFAOvtaxP1xW3XdHiFGdOOPWKllQFPcpsNcFAiGPpGDlEmMJsq3RBLVyAEIYiuAOL7+Ok8xwlN0GKwnuTu2cf59bbUEnc4NgRIW2GbiQkwN59qtRBskYAYwoTpYMusIbvTR0e1xWtNavxDy4B/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS7PR11MB6064.namprd11.prod.outlook.com (2603:10b6:8:77::14) by
 PH0PR11MB5831.namprd11.prod.outlook.com (2603:10b6:510:14b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 09:00:25 +0000
Received: from DS7PR11MB6064.namprd11.prod.outlook.com
 ([fe80::b701:6f31:1d4:98c4]) by DS7PR11MB6064.namprd11.prod.outlook.com
 ([fe80::b701:6f31:1d4:98c4%3]) with mapi id 15.20.6277.036; Tue, 11 Apr 2023
 09:00:24 +0000
Message-ID: <63f751c9-c72d-a2f2-9c06-cf953e50c79f@windriver.com>
Date: Tue, 11 Apr 2023 17:00:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [bitbake-devel] [PATCH] bitbake: ConfHandler: Allow variable flag
 name with a single character
Content-Language: en-US
To: Ola x Nilsson <ola.x.nilsson@axis.com>,
        bitbake-devel@lists.openembedded.org
References: <20230411060654.19442-1-kai.kang@windriver.com>
 <jwqile2q00y.fsf@axis.com>
From: Kai <kai.kang@windriver.com>
In-Reply-To: <jwqile2q00y.fsf@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::8) To DS7PR11MB6064.namprd11.prod.outlook.com
 (2603:10b6:8:77::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6064:EE_|PH0PR11MB5831:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d64ccec-35a5-4bf8-baf2-08db3a6b2fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+miukJeP0okv+EoBpOh6pOCNSp7A9QkJBA4pJU0hQT393iRYZmV7X276L3Ij2m27wv7FgidqKoGTMLgvocU8hH3zrvnzkhW/aqj6bwIr6lTR9+E5RoE7/ydIR66KniPIvXH0t8jg/s1voiPgaMuhqoP+Nnv6DknL4/e9pnG23h+4Zsf3dOsERB9c7BKQnropqIs6zZVs/NVcEgqHo1IZi0GVUZ8OtXbjL3Y3Yt55TQ4Xkb7b6XtckDz9RajxNWxfuGUeHHCLEUUB2CpVoouR4alRhYb9UHdJwPC/bWItxE8BL89mT3SFPEL2JLUBzWQEMC2g5xaWnGlm2p3bVug1BHBIYTH4CP/nIfO+AtXxmwm4VLaxXM/7Vx9himZAkQGAf2uAv0j8d4RQVXnPyu2NA8CvWU1QSh6b0DUNhtyoBI75XP1qCaUewnBHEovtnlKO4kGk0Bn5t2bJlgoHvtEYBpDu83pJjUCFXyX18JyJbb+7zLCSb59cG0ZOEqw6aBbQv75CECuXboi/L+R8k7sFBtFwfhAH5mwfYM/EwcXmRjN43XwrfqZ4lDd48IVVbg1PeeEHVYi/RvtZb8naph2IouaE3M4+5vwCg9F3viHZ5CByXBqaIG2rdJJF90hCgVs98gu9tDSgA07V0HyFB+ruStn59hdBiN9YqTk12q53MFc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6064.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(346002)(366004)(376002)(136003)(451199021)(6666004)(478600001)(6512007)(6506007)(316002)(26005)(186003)(53546011)(6486002)(966005)(2906002)(5660300002)(66476007)(66946007)(66556008)(41300700001)(8676002)(8936002)(38100700002)(86362001)(31696002)(36756003)(83380400001)(2616005)(31686004)(66899021)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T2QzeWVkV3ZwZGRONnNtckszNGlsbWNHM3hWTGxZWEtNT0loVmVmVTVSNSs3?=
 =?utf-8?B?QlVZV25NMFhldTB4OGJJYWVRSjFpdDZNY1EyQ1VCL2cwSnZhSHZIbUE1VE5y?=
 =?utf-8?B?a0lGc2Q0SjBoaTNSSzAvMXZYU3l5aVVPV1hUWmx1Z1VDbTI4US9XMDRNa0hz?=
 =?utf-8?B?MVpyUjNiRmJCcUw2bGwyVXBNbmF4STdSWjNWaUcydklkSnNzZXhMRHdnMmRK?=
 =?utf-8?B?WEV2TFppSWFGVjRBTmhnOFRoVG1vMVVBRml6bmRQY281ZDVsanNyZFpmbjZi?=
 =?utf-8?B?a2RIOWJqTlAyQ05nK3hUZHdIY3RqZldvRVJsaDY4V1dPeHRoTnBBVThRdEpy?=
 =?utf-8?B?RXNRQVZBNFMwSFFTMDh0TEdpeiswRktDTkhWaGI5NGV4OXdVV2R3VWhLZ29G?=
 =?utf-8?B?YlhBWEdLeS9ZNkVQQnBjdTZNVmRXdDJBenBjOHRRNGY5NUlxbjQ2ZS9ZYXNX?=
 =?utf-8?B?YlBZTVVtTHZ0SnhrRFpwdEthbndLOCsyaThmTFZxK0VnYlNicTVtaTgrbEhI?=
 =?utf-8?B?OGZVZ0ZRNzZCMVpyTVFwWFhYRGpxNUE4ZVJCT3dtR0ZxbWEzbDRJanRXanZx?=
 =?utf-8?B?dFluYlVFVW5TOE1RUmNkcEQwazA5Z25LZng3MzlQbzk2VFNkZlkxZVNYelFF?=
 =?utf-8?B?SHRPQVVZencyMU03cHRkU2I5VVN2eWFNL3RzNmxFbUFOUUM1Yy9EeEQvRXlU?=
 =?utf-8?B?a2VRTE5BUzJZdnF2YmxWQkdhLzJZMXlNeG5vWkE4S3d0ZFU1aE4waFlQVVFh?=
 =?utf-8?B?UzJ4WDlyUWNyeFdnYWw0ZC9tcWJWT0VxZ2VvWWVmVGpUeGFTcmJHendSOE5U?=
 =?utf-8?B?ckVsemdXa2ZOUHh5azJmam1NMFRMYVpma3RHWjlMV1hpdWhmMjNoS3VkY1M5?=
 =?utf-8?B?ZzJoU3hNeWRPVlowQUEwc3oxbG1Salh4MGUzOWJzUEtYWDZlbi9OcDA5cXFW?=
 =?utf-8?B?NUd3Y1VPN0FNMHk0TjZRcWpMZWNrWElGbkdwWmhuaEJBTGsvc0dtQ1UwYm5K?=
 =?utf-8?B?NE45NmNpc2YzZzBZbFU0SXNZY2paNjlVZkdNTS9kSWp5S09yWnd5cE94N2c3?=
 =?utf-8?B?ek1NbmVhckt5SHlWMUdCd3BkNXNvclFEL1Fjb2R0bHpPZjdhS2lKMXlLQ00y?=
 =?utf-8?B?WmRzU01xM1JEWExZanc0ZU1waUprQjZGRnBsYjhOanRBN1hMMkFhM1FOYTQr?=
 =?utf-8?B?MlFRU3JjK3h1SzZLdEF0c3R1OEQ0VzdCbVBZRWNDVUJBS0pqL2dXL0ttVExG?=
 =?utf-8?B?citrUlFENzd1amZrdk4xU2IzTjFrSXZJOG9SenNXRGZpM25rNU1QN1Q1K2xo?=
 =?utf-8?B?aGdremhwdnZKWi9BTE05S2ZkWWJYTHFkL3hLT2xhNzhjQWxYeDRveC9aMXVv?=
 =?utf-8?B?eDVsSTBFNThXNzM4Y0dncHoydGVlOUQ4K3VHLys3bXN0VUNabzk1QnpsZXF3?=
 =?utf-8?B?UkcwVzFHb2NMWW5ONnVMMS9pdG4yQWJabzNqMkkzbHh1UDV4OEk0MitjWFdt?=
 =?utf-8?B?eHY0eFVzRWJaSHVXY0ZLZmgxZzNEUGJmRXdZdkF4c3JSYnU3bERxNXBQRnRI?=
 =?utf-8?B?NXovZlEzaFpGYThISVk4OTJXYytrb0d2U2xpbGg1akNhL0pRK2NNeXpBMGJB?=
 =?utf-8?B?Z2JqK3ovLytxbHRFallTeGx6THBJTnZjUVRyalRZYStjLzRGNzBpVkNPMGNS?=
 =?utf-8?B?UlVWZWRzbkZpeGZmZTNIeWRFejB4V2J2UEpNV3Irdnd2Y2R6OWJ2ODJ2Ynhl?=
 =?utf-8?B?V3dzTXRVUitEQmw2anlOdDl3Nm1iakszZmlndExuZFhiVmlWaG5MUzExbTAv?=
 =?utf-8?B?MUY5ZFdzdC96TFMrOExrOUN4QlFHRWdsY25DQ0xnRW1QL0dpdnlsN2lXMlZS?=
 =?utf-8?B?cEVTc3RFVUUvaWpFSXRvU1loVGVkcDFqcHRuMzVyTmJjV3JTdmNQN3FPdDRs?=
 =?utf-8?B?TWhRek5TZWJjQytOV3VGSGszQnhTSkp4VHBrNnYvM3B0VDFScVpYaXNXZ3pw?=
 =?utf-8?B?QktCbTIyYmUzL3JMK2hNZ3RLNEFWZEJDbmhzeWJhZ08wRUN3dklxK21nRXpN?=
 =?utf-8?B?dTY3UUhxcnExUFAzeHVJNW5mTy9MOUpOQVVvR01Qa2w1R1ZWV01RWktrWTI0?=
 =?utf-8?Q?B1LV8TtaY901h3+PqDy2BRGBV?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d64ccec-35a5-4bf8-baf2-08db3a6b2fdb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6064.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 09:00:24.5065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Li/FZQcWt1IMKPl492rx5jjcz4MWAvSdbwfkUIM7n5Pdxw15tt7TCgcfswrphb8eAgxL54tox/f6MoHnOg9NDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5831
X-Proofpoint-ORIG-GUID: 4YA4urrBEPmTj2mrYTWYl1OLusr4aZE7
X-Proofpoint-GUID: PIS0qDFbQPTataG3NFwxGjx6HfoUzw8i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_05,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxlogscore=950
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110084
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Apr 2023 09:00:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14691

On 4/11/23 16:44, Ola x Nilsson wrote:
> On Tue, Apr 11 2023, Kai Kang wrote:
>
>> From: Kai Kang <kai.kang@windriver.com>
>>
>> Update regex pattern to allow variable flag name with a single character.
>>
>> Regression tests have also been updated in `bb.parse` and
>> `bin/bitbake-selftest -k ParseTest` has been successfully executed.
>>
>> Signed-off-by: Kai Kang <kai.kang@windriver.com>
>> ---
>>   bitbake/lib/bb/parse/parse_py/ConfHandler.py | 2 +-
>>   bitbake/lib/bb/tests/parse.py                | 2 ++
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
>> index 05c627ec8b..0bfe357012 100644
>> --- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
>> +++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
>> @@ -21,7 +21,7 @@ __config_regexp__  = re.compile( r"""
>>       ^
>>       (?P<exp>export\s+)?
>>       (?P<var>[a-zA-Z0-9\-_+.${}/~:]+?)
>> -    (\[(?P<flag>[a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@]+)\])?
>> +    (\[(?P<flag>[a-zA-Z0-9\-_+.]([a-zA-Z0-9\-_+.@]+)?)\])?
> It would be better to use the simpler expression
> (\[(?P<flag>[a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@]*)\])?

Oh, yes, it is better. Thanks and v2 will be sent.

Kai

>
>
> /Ola
>
>
>>       \s* (
>>           (?P<colon>:=) |
>> diff --git a/bitbake/lib/bb/tests/parse.py b/bitbake/lib/bb/tests/parse.py
>> index d27c7c6f15..a3165d95bd 100644
>> --- a/bitbake/lib/bb/tests/parse.py
>> +++ b/bitbake/lib/bb/tests/parse.py
>> @@ -222,6 +222,7 @@ VAR = " \\
>>       at_sign_in_var_flag = """
>>   A[flag@.service] = "nonet"
>>   B[flag@.target] = "ntb"
>> +C[f] = "flag"
>>   
>>   unset A[flag@.service]
>>   """
>> @@ -232,6 +233,7 @@ unset A[flag@.service]
>>           self.assertEqual(d.getVar("B"), None)
>>           self.assertEqual(d.getVarFlag("A","flag@.service"), None)
>>           self.assertEqual(d.getVarFlag("B","flag@.target"), "ntb")
>> +        self.assertEqual(d.getVarFlag("C","f"), "flag")
>>   
>>       def test_parse_invalid_at_sign_in_var_flag(self):
>>           invalid_at_sign = self.at_sign_in_var_flag.replace("B[f", "B[@f")
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14690): https://lists.openembedded.org/g/bitbake-devel/message/14690
> Mute This Topic: https://lists.openembedded.org/mt/98192343/3616933
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [kai.kang@eng.windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

-- 
Kai Kang
Wind River Linux


