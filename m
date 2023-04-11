Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AE9C77B6F
	for <webhook@archiver.kernel.org>; Tue, 11 Apr 2023 18:04:03 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.21939.1681236242035630182
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 11 Apr 2023 11:04:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriver.com header.s=pps06212021 header.b=avAxNxcW;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=346527d0b4=randy.macleod@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BHaZm0018860
	for <bitbake-devel@lists.openembedded.org>; Tue, 11 Apr 2023 18:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=PPS06212021;
 bh=UvRfwB+UMA7EkEsAoNfFpiEbsLQeU5gi9lD++QJHfIo=;
 b=avAxNxcWL/UoFfMdZUj689LlARf9ylVZE/bbn9xjX7O9U6V1+ud35CpfmtLNat5QjxYE
 ymji1Scg5SmBjV8kKBnzXc+xSXaLaNd65DC7A6q4eN6+QmmZaU+SMQSxT0OUfG28dhl9
 1DQf8CMZ9mtV+ii3KtRctz/f9Mr8Y0qellYAtECYXqBIK43DnZn9WopyhXPHQ/AfZlZG
 AlMeJ0UHtOnvSclDAzzDXy2PYagWK+TbZc4gkx9rp1H26NCuzPSNq+NyVAQfDEoLGYQU
 ko5laJ7OCZ9BTj9rqIQCH3l+fqGl/TMgwz5BOuZnZWGoCm90zz+5yzYrjywwg8hWj2La YQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3pty8b3cya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 11 Apr 2023 18:04:00 +0000
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33BI40cc009377
	for <bitbake-devel@lists.openembedded.org>; Tue, 11 Apr 2023 18:04:00 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3pty8b3cy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Apr 2023 18:04:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApK9dpkCK6Fr1puSUDPKAbwHgOPCUnlH4+hkpR3HkMgrQzTchAW+Ye0DpeQ+JgG7g1VhPGBvh0NdF11SFLPZxp/5MaJ4WTmP2hcoUVpRzfO+AYLrLf9iUXJ7VRQ3OLEEBr9s2w3M+ygUytzWHswy9X2VMMlkTiWRCcCJXLYtCbvMztBMlmrIqBp1Zi7FPeuvwwQqbCrFEA1CAmSU4r98lCb5cGT/yrVz/Z16v3aupr/9iNkge4POaVq9aRgl0whi0ujhoim87P50sX5CKFs7HYsWEdxunCLBFb7aQf8dMd04DZz4FScfpcw7nygbipn7v/5Ha1StFJlFUbk6l/Kh1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvRfwB+UMA7EkEsAoNfFpiEbsLQeU5gi9lD++QJHfIo=;
 b=LiKeE/qg7tahqII8g7I2jlKI5EBfnFEnLbaLnpf4cGkmYHrE47DAfYqbmo3DDReNWb1vkLkVfGonpATJFic368Yys7HKUQYLBQ8MuIXrlnsfDnecnQzT4xYFzVezvPsHORwOVSfMGerWPWNj55hT+MQA/RxyEF71xqfHFFgqxv+riH04p4TJwlKdzl5izM+R54VhpwK4bTfLCG9IIJKTxpxl1vOiLNMrANu8Ey1een48QcYfQ6fz2MwDkrSHUcMk79fDEchJpOCJ8vCy/oddT2HuuzZDjfBlVwpmRVhIehgVlSaDVHaX7wAPEdutMTgjlMzcIRFQPpzr/qk3MUCy1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB3994.namprd11.prod.outlook.com (2603:10b6:5:193::19)
 by SA1PR11MB6989.namprd11.prod.outlook.com (2603:10b6:806:2be::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Tue, 11 Apr
 2023 18:03:56 +0000
Received: from DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::6e26:7321:99ab:72ab]) by DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::6e26:7321:99ab:72ab%3]) with mapi id 15.20.6277.035; Tue, 11 Apr 2023
 18:03:56 +0000
Content-Type: multipart/alternative;
 boundary="------------QhbWJ7SeSIUuPl6GV6thHfvw"
Message-ID: <4c9b8990-3e7b-baff-5f8e-c338f0e2ca41@windriver.com>
Date: Tue, 11 Apr 2023 14:03:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [bitbake-devel] [PATCH] ensure locale en_US.UTF-8 is available on
 the system
Content-Language: en-CA
To: Steve Sakoman <steve@sakoman.com>
Cc: debrabander@gmail.com, bitbake-devel@lists.openembedded.org,
        Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20221206181805.3022-1-debrabander@gmail.com>
 <6d2196a8-f618-872d-2f51-93afdc99933a@windriver.com>
 <CAOSpxdbx8o8qYLUR4Mm+0PgjQoO9kA5Kp+edpy--NZKbdzAmww@mail.gmail.com>
From: Randy MacLeod <randy.macleod@windriver.com>
In-Reply-To: <CAOSpxdbx8o8qYLUR4Mm+0PgjQoO9kA5Kp+edpy--NZKbdzAmww@mail.gmail.com>
X-ClientProxiedBy: SJ0PR05CA0043.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::18) To DM6PR11MB3994.namprd11.prod.outlook.com
 (2603:10b6:5:193::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3994:EE_|SA1PR11MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d3782a4-4a0e-477c-ac28-08db3ab71e60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0IK6UlNTUF/95KUp+DUq+myYmGjv+vzDgtr3zeNxEbq+K2/fm4dPC5aNdRCBZl1s8XJOIUIT1KLu8gvyrAmIpFPqLrFkF3YeOweLJiRMcj80bsNlqQBJFv9CJRwG5WyOhiuK4cqTrsOjaZGP5RemOL/sX/4osKbr5NFMJuI1qAoKpMtFV7Ho5R06YL9KxmIa8jlSmGx5KtrYYAsh/aREzMuz1QgZ0Yu7A/09ewX2hdtWlcG39f4uev0mnA1f+YBF4guxIkNT+O6VEzEeXQ0xFKPQpN23+ObbOIvWNt5Y7pq7L0wfGKi7zwhz6WGRmxlfO8e9JfTl5JZmpLKihHLz43Z+tgSANYzynE47U+nEDz6O/fQRYG0En0ZxupKEJYQCBxfQHlZ5LeM3ug94W4V3F5A+RIEILeH4OL2QnPxIpvxMvrYEcSvrRkG2hYO6ywrlUA0Z27NOU1b6b3v9euL7JL5EDi7ZjKoOMk/RiPxeKy4eSiNCU81l3bsETe9ZXiRZngtmfqqX86ZkCKk9HUuNqpOy8XhaJxkLuEr/zT/uzQsYz4i6hI3UsxAKTCV3Q0jrDKP5YMB5dUKgiVpRKWhiNGp2F+F6Q1PsLAX8rExJmqXjwDZj6TPsLKi1+BmFMuFbkJ8nd/j04YjkYsf3IllghDwJ+pCIgESifMvMEzavSBjivPErJ6//bQ0gJG9xYOm3T3k6ef6aMcBzQ6p72B/6/w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3994.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(396003)(39850400004)(451199021)(6666004)(478600001)(86362001)(26005)(6512007)(33964004)(6506007)(316002)(186003)(53546011)(6486002)(966005)(2906002)(5660300002)(66476007)(66556008)(66946007)(8676002)(4326008)(41300700001)(6916009)(8936002)(166002)(38100700002)(31696002)(36756003)(83380400001)(2616005)(31686004)(66899021)(131093003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?blorb1VVY1hmbVVWdysyS1RZYlA0aDdtV2JHQjNiMDYwNXdCY01UVXlqdXJ4?=
 =?utf-8?B?SjRLQ0RPdEpXNXk0MDUyUFUxQ29WUU5SaVMzSjhHS3JMYUlrR1B6V1N0TnVQ?=
 =?utf-8?B?L0NaVTVTWit4b3ozQUNPTXlQSkJXSWtXM2hydlhmc1diODIwZW1ta04zTFpo?=
 =?utf-8?B?VWpONC9pZTBkRVNrak5uSUtnZDVsYVNjSTI5cFFKVjFFSjd4UmVPRzI2cHNO?=
 =?utf-8?B?SmRLVXBKdldadmg1QW9vcTNzZU5GOG1TL3hqRVMxTnVGd3FhZ05lUFdMWmxE?=
 =?utf-8?B?OWN3aktrTkk5UEsyTVhVMnJmSUczSk4vd2UrTHJaVUZ1RHJUOUN1ZncrRXZK?=
 =?utf-8?B?Ny92alJzLy9nUHlDR1RIWUhxSWxXSmNtZjB6Q2Ryd2M4cndVVWhaS1gxd3Rz?=
 =?utf-8?B?TFNGWENvMU1mblVyaEI5N3R3OWVvUW93eWpkZzE5YmZpcGlmekNITUo3MVJC?=
 =?utf-8?B?Y2hlU3RDNzRIQTYzdFZKei96YTRQL1EyNkF3b0xpb01CNThXVC9JdVpuQWxL?=
 =?utf-8?B?ak5OcWdpcndhV0NabzFXcmQ4KzlVQ1lRUUxxZEZFelFOMGtjNVpsYit6ZlVD?=
 =?utf-8?B?cVIzYWRNczlJeTlGSlBORUE2SWlkMFd3eDNCeWY3cVBPMWwxU1M0cmtuNWs2?=
 =?utf-8?B?bUtETEtBbUZ6WmJpajJiWEgxbGw5RDBXSlc3a0FQZjRBUGxodVZMOTZ3aXBp?=
 =?utf-8?B?Rzd5ejBlSStaeG1sQ3BrSUpMMnhvWEw2YXM3a0NqRVhOdlVoWk1tdHc2Q1li?=
 =?utf-8?B?dHRtVGI1RGl1a1U2bFRnLzZnRkNsVm42dC9ESU9yRlZZRCsrbEpmMmtZeVk3?=
 =?utf-8?B?Snc1TjZ0NndmTFJYenJHMVp6VDlPcjlnWmtDYkp1RVUzMnBWMnE3VUxzSnRs?=
 =?utf-8?B?VHNGU0QyNzMxeHRPREJJblRtZUg3dytIdVV2c2dhSDNlcEUrdUdia2I3bDRa?=
 =?utf-8?B?VXh2OGp1Z0ZVak5ibHJRMmsvWFJYQk9SQWViR0JaREhFUTVCSUlmMUpTOTZ2?=
 =?utf-8?B?bWNkVWowUUZtcmVFZGJTemo1ZVFuQmt0dWdwNEJoT1BmK2g1dGpIbk1IQ1VN?=
 =?utf-8?B?SzNYeFZRSENBaGErdlBLK0VHcWNwYmlsTWJVWEo5a2E1YlFsejJGdkNZUi94?=
 =?utf-8?B?MXlEMEdIOEVta3RCSkx6ZFMyTm14b0VpWVIrK01tYnkzQVZLQ1pZZW01ZFpm?=
 =?utf-8?B?d0JQeXRic3BjclJOZUdJNDg0ajgvRHZZcnhEdnZzdEV5UitzMUI0RHEvTEZZ?=
 =?utf-8?B?MitvQTdrWkhnZ1poUlRWQnhsZ1F3ZzAwMEwvbVh2bDlGaVRVdlp1bG9LY0V5?=
 =?utf-8?B?QTIwNnVlb1ZqM3BSQjFpUSt6eVpTWVdiUjZaWXY2V0RrR1RUTGp0cm9DM0cz?=
 =?utf-8?B?QTdVWmVvVzNSaktkbFlUK1ZuZXp5RGwvNDBkazgyR3ZsSlNSWXBNS3pqb3FQ?=
 =?utf-8?B?U2R5Z0hkdXlPbjNMNC8vNXJ2eUwwY2dBQVh5bDhqTDhhcnBuVFFsU08wUTdE?=
 =?utf-8?B?TEZ3cWtNbWdRMUx3UUQ0cXVlYXYvb2JRZkJDNERteUZlK0Jka2x0YUkwWU5H?=
 =?utf-8?B?LzlrdEY4dVdMOURGamRCNzNxaUEyV1ZlczJKdWZwb2JPaGFOR1QzVWlmdUNo?=
 =?utf-8?B?dXdvUk1vaG1TZ2tyK2NLSTdwWlQvU0Jaejg3cGlxcGZGeWhHTmRnL2NvNGdw?=
 =?utf-8?B?WkVrSVhLUVlaZDMzbWx5SzVHaUpmdHF2UnJIS3VsZWYzdHJGVytPUHpWY05v?=
 =?utf-8?B?MDFzc09seU5ETXFpZFNRZTFkTW01RGp3RFVpNjRJSDN0OGxwdDhSRlRZM2R6?=
 =?utf-8?B?MUxjamhlZnlZQ3lYYmM5VnAwMklndE9OY3BrMjN6VGhTRmNBR3A0dmpwNzRP?=
 =?utf-8?B?SElqYmFXeXdDQ3VqZjRId2UyN0pDcWJrMlA3ZWFlQ0tpRnZQSTl0Y1VLRi9u?=
 =?utf-8?B?S1B0NDJVVmw1YVJsN3VyWmJWR1NTcHFuWmFGYkNiWWF4SWU1cEk2SFpaTFdt?=
 =?utf-8?B?VGI5dy9UcmZ0R3B5U2RKcVAvT3pOSVVoVk42bTNCQXVmc0NxQkxWTDUwNExn?=
 =?utf-8?B?dmhNVCtrK2NPOFJ2TzRudUV2QXh2TGx1bjVHWkpDWSthclkrNkhtZTFqaS9L?=
 =?utf-8?B?WXN6NFVwemNxNndCRDBmb1g4UUFDb1JoWGhHcWMwRm5ubHhpdzlTSldiSTlH?=
 =?utf-8?B?eXc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3782a4-4a0e-477c-ac28-08db3ab71e60
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3994.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 18:03:56.7186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pohAdT2g0sUCkm3AtSs3p3H2dNrN4NQVMPZt2zoR9xxASRJO+7ohjdMf+Xcng+iDT4Nr4rXyNTKm3nCY2OOnZzm/EUN50k2t5sCIZDhRGwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6989
X-Proofpoint-ORIG-GUID: _CyTahhsxyv9TkeqAa3bPtJHPgUlP97q
X-Proofpoint-GUID: pGtF-Ng7Df8FVbidSF_U0ZtG6VAhGjIO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_11,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304110165
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 11 Apr 2023 18:04:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14694

--------------QhbWJ7SeSIUuPl6GV6thHfvw
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 33BHaZm0018860

On 2023-03-08 16:41, Steve Sakoman wrote:
> On Wed, Mar 8, 2023 at 11:08=E2=80=AFAM Randy MacLeod
> <randy.macleod@windriver.com>  wrote:
>> On 2022-12-06 13:18, Frank de Brabander via lists.openembedded.org wro=
te:
>>
>> Get rid of the duplicate code and add extra check that the
>> locale en_US.UTF-8 is available on the system. This new helper
>> method is now located right above the method filter_environment()
>> which sets LC_ALL environment variable to 'en_US.UTF-8'.
>>
>> Nice:
>>
>> foo@2b7837225ffb:~/b/test$ bitbake -p coreutils
>> Please make sure locale 'en_US.UTF-8' is available on your system
>>
>>
>> Steve,
>>
>> It would be nice if you cherry-pick this back to langdale and kirkston=
e, it's a clean c-p.
> OK, will do!


Steve,

Did this cherry-pick slip through the cracks?

The master commit:

https://git.yoctoproject.org/poky/log/?qt=3Dgrep&q=3DEnsure+locale+en_US.=
UTF-8+is+available+on+the+system

and langdale

https://git.yoctoproject.org/poky/log/?h=3Dlangdale&qt=3Dgrep&q=3DEnsure+=
locale+en_US.UTF-8+is+available+on+the+system

but not on kirkstone

https://git.yoctoproject.org/poky/log/?h=3Dkirkstone&qt=3Dgrep&q=3DEnsure=
+locale+en_US.UTF-8+is+available+on+the+system

Thanks,

../Randy


>
> Steve
>
>> [YOCTO #10165]
>>
>> Signed-off-by: Frank de Brabander<debrabander@gmail.com>
>> ---
>>   bin/bitbake        |  3 +--
>>   bin/bitbake-server |  5 +++--
>>   bin/bitbake-worker |  3 +--
>>   lib/bb/utils.py    | 16 ++++++++++++++++
>>   4 files changed, 21 insertions(+), 6 deletions(-)
>>
>> diff --git a/bin/bitbake b/bin/bitbake
>> index 7cbf88f4..f869eb48 100755
>> --- a/bin/bitbake
>> +++ b/bin/bitbake
>> @@ -25,8 +25,7 @@ except RuntimeError as exc:
>>   from bb import cookerdata
>>   from bb.main import bitbake_main, BitBakeConfigParameters, BBMainExc=
eption
>>
>> -if sys.getfilesystemencoding() !=3D "utf-8":
>> -    sys.exit("Please use a locale setting which supports UTF-8 (such =
as LANG=3Den_US.UTF-8).\nPython can't change the filesystem locale after =
loading so we need a UTF-8 when Python starts or things won't work.")
>> +bb.utils.check_system_locale()
>>
>>   __version__ =3D "2.2.0" diff --git a/bin/bitbake-server b/bin/bitbak=
e-server index=20
>> 825e9d56..454a3919 100755 --- a/bin/bitbake-server +++=20
>> b/bin/bitbake-server @@ -12,8 +12,9 @@ warnings.simplefilter("default"=
)
>>   import logging
>>   sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.=
argv[0])), 'lib'))
>>
>> -if sys.getfilesystemencoding() !=3D "utf-8":
>> -    sys.exit("Please use a locale setting which supports UTF-8 (such =
as LANG=3Den_US.UTF-8).\nPython can't change the filesystem locale after =
loading so we need a UTF-8 when Python starts or things won't work.")
>> +import bb
>> +
>> +bb.utils.check_system_locale()
>>
>>   # Users shouldn't be running this code directly
>>   if len(sys.argv) !=3D 11 or not sys.argv[1].startswith("decafbad"): =
diff --git a/bin/bitbake-worker b/bin/bitbake-worker index=20
>> 3799b170..3cacdb0c 100755 --- a/bin/bitbake-worker +++=20
>> b/bin/bitbake-worker @@ -24,8 +24,7 @@ import subprocess from=20
>> multiprocessing import Lock from threading import Thread -if=20
>> sys.getfilesystemencoding() !=3D "utf-8":
>> -    sys.exit("Please use a locale setting which supports UTF-8 (such =
as LANG=3Den_US.UTF-8).\nPython can't change the filesystem locale after =
loading so we need a UTF-8 when Python starts or things won't work.")
>> +bb.utils.check_system_locale()
>>
>>   # Users shouldn't be running this code directly
>>   if len(sys.argv) !=3D 2 or not sys.argv[1].startswith("decafbad"): d=
iff --git a/lib/bb/utils.py b/lib/bb/utils.py index=20
>> f4da3563..0df522b3 100644 --- a/lib/bb/utils.py +++ b/lib/bb/utils.py=20
>> @@ -13,6 +13,7 @@ import errno import logging import bb import bb.msg=20
>> +import locale import multiprocessing import fcntl import importlib=20
>> @@ -608,6 +609,21 @@ def preserved_envvars(): ] return v +=20
>> preserved_envvars_exported() +def check_system_locale(): + """Make sur=
e the required system locale are available and configured"""
>> +    default_locale =3D locale.getlocale(locale.LC_CTYPE)
>> +
>> +    try:
>> +        locale.setlocale(locale.LC_CTYPE, ("en_US", "UTF-8"))
>> +    except:
>> +        sys.exit("Please make sure locale 'en_US.UTF-8' is available =
on your system")
>> +    else:
>> +        locale.setlocale(locale.LC_CTYPE, default_locale)
>> +
>> +    if sys.getfilesystemencoding() !=3D "utf-8":
>> +        sys.exit("Please use a locale setting which supports UTF-8 (s=
uch as LANG=3Den_US.UTF-8).\n"
>> +                 "Python can't change the filesystem locale after loa=
ding so we need a UTF-8 when Python starts or things won't work.")
>> +
>>   def filter_environment(good_vars):
>>       """
>>       Create a pristine environment for bitbake. This will remove vari=
ables that
>>
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#14139):https://lists.openembedded.org/g/bitbake-de=
vel/message/14139
>> Mute This Topic:https://lists.openembedded.org/mt/95499228/3616765
>> Group Owner:bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe:https://lists.openembedded.org/g/bitbake-devel/unsub  [ran=
dy.macleod@windriver.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>
>>
>> --
>> # Randy MacLeod
>> # Wind River Linux


--=20
# Randy MacLeod
# Wind River Linux

--------------QhbWJ7SeSIUuPl6GV6thHfvw
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 33BHaZm0018860

<html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">On 2023-03-08 16:41, Steve Sakoman
      wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:CAOSpxdbx8o8qYLUR4Mm+0PgjQoO9kA=
5Kp+edpy--NZKbdzAmww@mail.gmail.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">On Wed, Mar 8, 2023 at 11:08=
=E2=80=AFAM Randy MacLeod
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:randy.macleod@windriver=
.com">&lt;randy.macleod@windriver.com&gt;</a> wrote:
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">On 2022-12-06 13:18, Frank=
 de Brabander via lists.openembedded.org wrote:

Get rid of the duplicate code and add extra check that the
locale en_US.UTF-8 is available on the system. This new helper
method is now located right above the method filter_environment()
which sets LC_ALL environment variable to 'en_US.UTF-8'.

Nice:

foo@2b7837225ffb:~/b/test$ bitbake -p coreutils
Please make sure locale 'en_US.UTF-8' is available on your system


Steve,

It would be nice if you cherry-pick this back to langdale and kirkstone, =
it's a clean c-p.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">OK, will do!</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Steve, <br>
      <br>
      Did this cherry-pick slip through the cracks?<br>
      <br>
    </p>
    <p>The master commit:<br>
    </p>
    <p><a class=3D"moz-txt-link-freetext" href=3D"https://git.yoctoprojec=
t.org/poky/log/?qt=3Dgrep&amp;q=3DEnsure+locale+en_US.UTF-8+is+available+=
on+the+system">https://git.yoctoproject.org/poky/log/?qt=3Dgrep&amp;q=3DE=
nsure+locale+en_US.UTF-8+is+available+on+the+system</a></p>
    <p>and langdale</p>
    <p><a class=3D"moz-txt-link-freetext" href=3D"https://git.yoctoprojec=
t.org/poky/log/?h=3Dlangdale&amp;qt=3Dgrep&amp;q=3DEnsure+locale+en_US.UT=
F-8+is+available+on+the+system">https://git.yoctoproject.org/poky/log/?h=3D=
langdale&amp;qt=3Dgrep&amp;q=3DEnsure+locale+en_US.UTF-8+is+available+on+=
the+system</a><br>
    </p>
    <p></p>
    <p>but not on kirkstone</p>
    <p><a class=3D"moz-txt-link-freetext" href=3D"https://git.yoctoprojec=
t.org/poky/log/?h=3Dkirkstone&amp;qt=3Dgrep&amp;q=3DEnsure+locale+en_US.U=
TF-8+is+available+on+the+system">https://git.yoctoproject.org/poky/log/?h=
=3Dkirkstone&amp;qt=3Dgrep&amp;q=3DEnsure+locale+en_US.UTF-8+is+available=
+on+the+system</a><br>
    </p>
    Thanks,<br>
    <p>../Randy</p>
    <p><br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:CAOSpxdbx8o8qYLUR4Mm+0PgjQoO9kA=
5Kp+edpy--NZKbdzAmww@mail.gmail.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">

Steve

</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">[YOCTO #10165]

Signed-off-by: Frank de Brabander <a class=3D"moz-txt-link-rfc2396E" href=
=3D"mailto:debrabander@gmail.com">&lt;debrabander@gmail.com&gt;</a>
---
 bin/bitbake        |  3 +--
 bin/bitbake-server |  5 +++--
 bin/bitbake-worker |  3 +--
 lib/bb/utils.py    | 16 ++++++++++++++++
 4 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/bin/bitbake b/bin/bitbake
index 7cbf88f4..f869eb48 100755
--- a/bin/bitbake
+++ b/bin/bitbake
@@ -25,8 +25,7 @@ except RuntimeError as exc:
 from bb import cookerdata
 from bb.main import bitbake_main, BitBakeConfigParameters, BBMainExcepti=
on

-if sys.getfilesystemencoding() !=3D &quot;utf-8&quot;:
-    sys.exit(&quot;Please use a locale setting which supports UTF-8 (suc=
h as LANG=3Den_US.UTF-8).\nPython can't change the filesystem locale afte=
r loading so we need a UTF-8 when Python starts or things won't work.&quo=
t;)
+bb.utils.check_system_locale()

 __version__ =3D &quot;2.2.0<a class=3D"moz-txt-link-rfc2396E" href=3D"ma=
ilto:diff--gita/bin/bitbake-serverb/bin/bitbake-serverindex825e9d56..454a=
3919100755---a/bin/bitbake-server+++b/bin/bitbake-server@@-12,8+12,9@@war=
nings.simplefilter(">&quot;

diff --git a/bin/bitbake-server b/bin/bitbake-server
index 825e9d56..454a3919 100755
--- a/bin/bitbake-server
+++ b/bin/bitbake-server
@@ -12,8 +12,9 @@ warnings.simplefilter(&quot;</a>default&quot;)
 import logging
 sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv=
[0])), 'lib'))

-if sys.getfilesystemencoding() !=3D &quot;utf-8&quot;:
-    sys.exit(&quot;Please use a locale setting which supports UTF-8 (suc=
h as LANG=3Den_US.UTF-8).\nPython can't change the filesystem locale afte=
r loading so we need a UTF-8 when Python starts or things won't work.&quo=
t;)
+import bb
+
+bb.utils.check_system_locale()

 # Users shouldn't be running this code directly
 if len(sys.argv) !=3D 11 or not sys.argv[1].startswith(&quot;decafbad<a =
class=3D"moz-txt-link-rfc2396E" href=3D"mailto:):diff--gita/bin/bitbake-w=
orkerb/bin/bitbake-workerindex3799b170..3cacdb0c100755---a/bin/bitbake-wo=
rker+++b/bin/bitbake-worker@@-24,8+24,7@@importsubprocessfrommultiprocess=
ingimportLockfromthreadingimportThread-ifsys.getfilesystemencoding()!=3D"=
>&quot;):
diff --git a/bin/bitbake-worker b/bin/bitbake-worker
index 3799b170..3cacdb0c 100755
--- a/bin/bitbake-worker
+++ b/bin/bitbake-worker
@@ -24,8 +24,7 @@ import subprocess
 from multiprocessing import Lock
 from threading import Thread

-if sys.getfilesystemencoding() !=3D &quot;</a>utf-8&quot;:
-    sys.exit(&quot;Please use a locale setting which supports UTF-8 (suc=
h as LANG=3Den_US.UTF-8).\nPython can't change the filesystem locale afte=
r loading so we need a UTF-8 when Python starts or things won't work.&quo=
t;)
+bb.utils.check_system_locale()

 # Users shouldn't be running this code directly
 if len(sys.argv) !=3D 2 or not sys.argv[1].startswith(&quot;decafbad<a c=
lass=3D"moz-txt-link-rfc2396E" href=3D"mailto:):diff--gita/lib/bb/utils.p=
yb/lib/bb/utils.pyindexf4da3563..0df522b3100644---a/lib/bb/utils.py+++b/l=
ib/bb/utils.py@@-13,6+13,7@@importerrnoimportloggingimportbbimportbb.msg+=
importlocaleimportmultiprocessingimportfcntlimportimportlib@@-608,6+609,2=
1@@defpreserved_envvars():]returnv+preserved_envvars_exported()+defcheck_=
system_locale():+">&quot;):
diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index f4da3563..0df522b3 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -13,6 +13,7 @@ import errno
 import logging
 import bb
 import bb.msg
+import locale
 import multiprocessing
 import fcntl
 import importlib
@@ -608,6 +609,21 @@ def preserved_envvars():
     ]
     return v + preserved_envvars_exported()

+def check_system_locale():
+    &quot;</a>&quot;&quot;Make sure the required system locale are avail=
able and configured&quot;&quot;&quot;
+    default_locale =3D locale.getlocale(locale.LC_CTYPE)
+
+    try:
+        locale.setlocale(locale.LC_CTYPE, (&quot;en_US&quot;, &quot;UTF-=
8&quot;))
+    except:
+        sys.exit(&quot;Please make sure locale 'en_US.UTF-8' is availabl=
e on your system&quot;)
+    else:
+        locale.setlocale(locale.LC_CTYPE, default_locale)
+
+    if sys.getfilesystemencoding() !=3D &quot;utf-8&quot;:
+        sys.exit(&quot;Please use a locale setting which supports UTF-8 =
(such as LANG=3Den_US.UTF-8).\n&quot;
+                 &quot;Python can't change the filesystem locale after l=
oading so we need a UTF-8 when Python starts or things won't work.&quot;)
+
 def filter_environment(good_vars):
     &quot;&quot;&quot;
     Create a pristine environment for bitbake. This will remove variable=
s that


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#14139): <a class=3D"moz-txt-link-freetext" href=3D"ht=
tps://lists.openembedded.org/g/bitbake-devel/message/14139">https://lists=
.openembedded.org/g/bitbake-devel/message/14139</a>
Mute This Topic: <a class=3D"moz-txt-link-freetext" href=3D"https://lists=
.openembedded.org/mt/95499228/3616765">https://lists.openembedded.org/mt/=
95499228/3616765</a>
Group Owner: <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:bitbake=
-devel+owner@lists.openembedded.org">bitbake-devel+owner@lists.openembedd=
ed.org</a>
Unsubscribe: <a class=3D"moz-txt-link-freetext" href=3D"https://lists.ope=
nembedded.org/g/bitbake-devel/unsub">https://lists.openembedded.org/g/bit=
bake-devel/unsub</a> [<a class=3D"moz-txt-link-abbreviated" href=3D"mailt=
o:randy.macleod@windriver.com">randy.macleod@windriver.com</a>]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--
# Randy MacLeod
# Wind River Linux
</pre>
      </blockquote>
    </blockquote>
    <p><br>
    </p>
    <pre class=3D"moz-signature" cols=3D"72">--=20
# Randy MacLeod
# Wind River Linux</pre>
  </body>
</html>

--------------QhbWJ7SeSIUuPl6GV6thHfvw--

