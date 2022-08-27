Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3207CECAAD1
	for <webhook@archiver.kernel.org>; Sat, 27 Aug 2022 03:37:00 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web12.45580.1661571417461514523
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Aug 2022 20:36:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=TmJwmZeB;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.178.238,
 mailfrom: prvs=52384dc79f=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id
 27R3YRTb003750
	for <bitbake-devel@lists.openembedded.org>; Sat, 27 Aug 2022 03:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=message-id : date
 : subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=SryQcYmkBtq3nUCBYeY8dL/o7HN6uffweksI7ip34iM=;
 b=TmJwmZeBT+cIxbwmDcwywGSc1VLvdiBGG2SHXk6g1HUwMEE2t6mu23SIFFRWZDnpSsmi
 4HEqghcj7/bCJdhiO+e9C6NOHbNisnP5JS/sncM6R0ksbTWo6VKqxXM7HkvEhORSNABY
 CAEZ776cGnUdF/2UPnCm1TfvgTvk1YS+B4cfl7xrIMTPyAhRx6+8LLFff39KANoUlaYE
 rz0nA9maN1KqveHWOXhwpQza/JvwTNN1MC1xW9ya7DtWFF1AjZcDQNTOsryM9tuiQjf4
 W6pvebA0bASf/i2cmXRKcjAZ8FwKYbVUYbUUNjH/y9GlSV4rMBg6Kdyi+seBhZgn5jtJ +A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3j7a89g180-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sat, 27 Aug 2022 03:36:56 +0000
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27R3ataL009159
	for <bitbake-devel@lists.openembedded.org>; Sat, 27 Aug 2022 03:36:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3j7a89g17y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Aug 2022 03:36:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAN+QAkg72Gp65q5lxYCJLfkXAVIYG7lTuuttXvu3OERVqz49QLmt/nWfdFK7VSyn8MErJVW0mJh8dSBx3ly4vZJ95yfa8Dzs9Eog8zs6YjS8T02hGtggr0ucRQ7AdLEoDw33wX4xEzYf2xx4YqcluE6D1aPnRjtUi40HGnspZ0hs83CFOJEa0BQdf3Rj/S36Khc4D9yNrolcM1KxGWyePLeVG08WTygTrI5Ad1wSPVikj8TXGVoPvRFsweK1ORCkAN6QAZlDaLGQ6kZktEkihwi472yVmHQkN5ELu9Ta2Qe+eVZRFgbBijcIygY4bempMz2YISffrlxtG/Mq+WSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SryQcYmkBtq3nUCBYeY8dL/o7HN6uffweksI7ip34iM=;
 b=OraMYgKSSzZkkWor1A1HN/JOx7lqZje61XrXvqDhB0tBaz6vpCSdHS5UjAYsSBk/OhHcu/PmlnvQn63UA90fLBjfEjnuP5bftI2piDHbINjT6MVNJhTW7loECfkmuXjP+Kf4/Xm7tLAM570T+P+am51Z5JkfLuUB2lOzufK23BxSmMnHAQl9dMT+2tIVoQcr7fS4SRdwXJF/fEZOpgIMM8emQiQcNp4pmSz5lkems8pm02236mlP1REiH4YM0L8W95k9tPBSFYEYX3ilWRO+BodcEbrZfriK3SU+IaramvrILZitQ61a8Wk4ugM0mbyDIQSNT+VH3/vI69FUGAiwjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BYAPR11MB2789.namprd11.prod.outlook.com (2603:10b6:a02:cc::11)
 by MN2PR11MB3981.namprd11.prod.outlook.com (2603:10b6:208:13d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Sat, 27 Aug
 2022 03:36:52 +0000
Received: from BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::3cda:360d:94b:1b67]) by BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::3cda:360d:94b:1b67%4]) with mapi id 15.20.5546.025; Sat, 27 Aug 2022
 03:36:52 +0000
Message-ID: <7e6cdfb0-3022-69fb-f835-54bf7f042962@windriver.com>
Date: Sat, 27 Aug 2022 11:36:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [bitbake-devel] [RFC][PATCH V2] bitbake: fetch2/git: Use git
 fetch to shallow clone revisions
Content-Language: en-US
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
        "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
References: <20220826131047.51373-1-liezhi.yang@windriver.com>
 <94af8607626d42e58b05fb79a2d07e02@axis.com>
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <94af8607626d42e58b05fb79a2d07e02@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SL2P216CA0227.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::19) To BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 821a6f7e-17d6-48ac-c134-08da87dd6176
X-MS-TrafficTypeDiagnostic: MN2PR11MB3981:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zeF9/cRldzWt7lrcuyjqo0qUfR1ZgIt5YD2kNyx2HoP07dEHZKLzxiosfAzHELTuQ+VJ55t+Xy8QjaWdu5TioQs2z36fVhFGJUUqRfq/l+FeVbzpO2tHdO4z2+42qvc4XeVsIP0QEFz0y/56VoD/Pqp3PyWNf6xzHNX20GiWBvu5IxwL+b6XflClr68T8wU9Xzx+6FX3RVfe9FB1HkwUrLSC5ab4v+vSKhVFssDSJLScPwmCPPXWncsavPuKCMCUBhz3SRdRoVhIrc7WhYgixCJovPs430zAZbF4hQXRJ5clE7O23pmgF3R36O27aWh2F7E/ntD+b9wVQxoAFvUAp3f+N9sWoyfydsRkqx8O49NnyVL3sTceSGHfAfeorPxgoVGiHvssNaVMciX/vbXxIvUSclMyqwfT3Sm0Ty5+6jbKV1DRUxqFa/aabxUATWtLkR2NvU+AP7C/Hm6pkTDm9JEiu1wIFe0fzBvx3Xc3++011HADjI0Wq8wW2W6ZKWDQWguGPqJ0fOeucYrTICtqLUChArswGymjDmUq0V4/1NxE11sXPXhA6pFaaS2CFsMxMapcsP7QEe2ZbqnG1ifgTueYbca/QoUF6ldljqf695RgraPuUHtkDVGFBDl4+CUXBac/AfJiv5FyGiF+YuCZOA2fyG0+hXlYYnPvnCXO7MaUeaKUq7PmQG94GNdQn5OQ4Ob+h03mhXanIwTnWbDBbSeckz7BKOLG3oZFXxaZveo2fXuD3yEmi1l3pGarcwIyBTBHujK9wnPAssGyA1Njc9n1FXF3WhwXic79tvLjhFZs15JKXJCcDpAvsv/i1r4B
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2789.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(366004)(39850400004)(136003)(8676002)(31686004)(66476007)(2906002)(2616005)(186003)(8936002)(5660300002)(110136005)(316002)(36756003)(66556008)(66946007)(53546011)(31696002)(6666004)(6512007)(86362001)(6506007)(38100700002)(83380400001)(478600001)(41300700001)(6486002)(26005)(9126006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NUV6SkdMSHF2bUJkU213Vk9ZOFpldmExYkZVZVJrUVRTT3dWNnJ6R1E1QnVq?=
 =?utf-8?B?bjduYXBzMmVmamI2SzlxZzNGWlJCSW9YM1YrWjI0K29pakxWUTA2OFNvRHRo?=
 =?utf-8?B?d01yVU1QemdueGJFbWRwY3lmZGtjRHVTenMvMUE0QjRZbmZweVZ1SzYvVHZY?=
 =?utf-8?B?bTAwMlR2QVhOdlZlQTlCUWlpM1o3ekNYT1RRQjZzVEVqMGJ0WmdRK1RSK0dt?=
 =?utf-8?B?eUZKOUU1OHVndTBPZlVLQzFnZTcyeDdSZzdYTHYwU3pHc3RTMWxLS083U1lO?=
 =?utf-8?B?YVJhbXZxeHpjVjRBVXBRR3Jqb3BBTUg4bVRpYUZiVzRYL1o0STVETEZlQmh4?=
 =?utf-8?B?Rm9leER0bjhNR0p4ekRabE1BUXVOZUxNOU1CMkk4ZVpaTE12SU00QThLYWVn?=
 =?utf-8?B?WnZMamNlRUxHKzNLSkxsSk1HRHc4R1REaTB1R3hPWm0ybnRtVnFHZzRGaFpo?=
 =?utf-8?B?S20vVml3WUZjQlZSQ0h6ME1pdlVYekpvMGxvS0VWSFMzQU5DcnQyT2JQZFZT?=
 =?utf-8?B?dnBZV1JmaXVLVWh1M2ZTcGw1U1V2N3JjNzVUcHA4bndDeitpakp4SUNCWTRa?=
 =?utf-8?B?S1E1YytLRWV1ZldraVljVzRDbTJHNkFsUkpSV1RuU2VLVnhyN0d2Nk9wbE5o?=
 =?utf-8?B?V1JXeXozZEJjV01HNHlRMjQwN1d4bTU4N1NDZXJvbWhaK2NnNytBMkpkRklC?=
 =?utf-8?B?Z3ZwRUlIY0kxcG41WDUvMHpQaEhNT1BOSHFtNUowekVvZ3l6NURLdFhoZkdx?=
 =?utf-8?B?M1NNb0k0c2xqeFNzajVGbEU1amxHTXorZjFuZGR4U0htT0FZcXhIWTZVdVA1?=
 =?utf-8?B?YThkWTJ5d1I2QTFRR1JlK2pxaUdGRTVUa3R5NzFHakZRNXJFUkJDbXVkd0s0?=
 =?utf-8?B?dmIyZ200ZE5QYThzanhVOGpQREZFWDJoWVFEcTZEMlltV1VsSkFkeDh3NFlu?=
 =?utf-8?B?OGtVd0RjeUVnaWs4eTU5OElxaWRBRkJnRkQ1dHd2eVhCQnVyU3JLNzg3MHM3?=
 =?utf-8?B?b1BSclJLZ29nbFNYemoyWm9jVG5DZ3ZldnZQZVZmMEdNcWRJNFdBVnYyS0tR?=
 =?utf-8?B?Y0l6Y2l6d2F1YUxXVkJwZ1RucE01SmlSM3ZzcTB5Z3VpRnhhQ09QVXZXWEVn?=
 =?utf-8?B?ekpWYTRWVm1XNGp1cDVRK3BlWU9EdGZZTFN4UzZtWG9ab0tTdXJQSnNRVjcv?=
 =?utf-8?B?M3A4VU9ucm45cmdMMW13SUhzbTFSWGtWdUkvcHZCRVovNzE1V0NBRGgrRXlz?=
 =?utf-8?B?ek5sOElmcEVRVHdtUlFtMnFKQ2gzaUZ4eXNSbW1YRGsrUTRlZjU0N3F6WVVy?=
 =?utf-8?B?d20zVi9pa3dET1pDRStqRGhxMFYyVHZCVmtqTHRJY2VTcGhNQTVyR0N5MndM?=
 =?utf-8?B?QStUTkkvM3Y0VXpVRkdmTFdqKzYwNGFvazVKczJIMjAwWDhFbjB6MUxnV21p?=
 =?utf-8?B?d2x1NE1uV0NQWWtLUHoramt2dmY4RFlYVnFPQVd2cXBZTUVOVFlsa2FDQStG?=
 =?utf-8?B?UDY5NzlSYnIwb0I0V2RKbmVSTEZoTXJDNTNwSWowRmRoV1Z4dmFqV2hubmhU?=
 =?utf-8?B?Y0t6d1NmZThqd2FtOGxFNFdXMVQ1eHJPZ3pvbExmdUxZRm5FVEg4TlBuUU13?=
 =?utf-8?B?WSswQUxVV3ZHb2ZiSmxvUEZkSUo2TXFKdGVhVnlXQW82L3hKVjJRN2c0c0dZ?=
 =?utf-8?B?UGtsbXg0clhnK29UTXBzNnBpeGR3eTAyMDgrR1IwMjFONFNDYzVBMlAwNHho?=
 =?utf-8?B?OUxGdmd5cExuWFhLWWpIR3lLc3RaUWVBdzFETjhBSGI1N0xJYnRoMDg0aGM2?=
 =?utf-8?B?VVFjZHdDVXE0QjZtN2ZZZU53UVVEcEVIQ2FYUFdLTERsQWM2cmpSWXNRa25V?=
 =?utf-8?B?YXRiZ2hGZXhkL0xHMk9Lc2hkQnh0Z1BjK0R4Uk9CblZnV2MrNlNqMDc5bVE5?=
 =?utf-8?B?Y3FOM0NuRVNIMUdVclI4b0kzZ05DWUNQRW9LUVg0NUdnUnpMcmN0QUh3RTE3?=
 =?utf-8?B?VERzbGNFYkVKQW1vMC9FS1hHM2NVU0RWdTVYQkxBNzQ5dnVvaDJ4VGVPbW1h?=
 =?utf-8?B?Y255bEVxVm0rZDBiMDk4ckVVeUk2M2QwQW5GUjl4bGJjTm5TNXJ2S1Y3THB2?=
 =?utf-8?B?SlFFWUdWZkwxQnI1VmVCb3owb2l3bW9uWTFsa0lhZEVtdFluZFBmeVdyd01w?=
 =?utf-8?B?MWc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 821a6f7e-17d6-48ac-c134-08da87dd6176
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2789.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 03:36:52.1541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 9Ow5Ofe9QDnpf5HHU3Yx4r6sa2JJxLjNV6AgEMrjzfyCXP0DgrzxmEPdLti3daf4/rgxT5jsnBwwohSx9E8aYX0S3zV08QyAd/DekVa5yT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3981
X-Proofpoint-ORIG-GUID: QZIkmZ7JilJtJTi2Ehb_odOvBv8zk8yQ
X-Proofpoint-GUID: gRhTcSpbxEQhoxtpwB0YNHjZv-Sco7Pc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_14,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208270015
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 27 Aug 2022 03:37:00 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13941

Hi Peter,

On 8/26/22 22:21, Peter Kjellerstedt wrote:
>> -----Original Message-----
>> From: bitbake-devel@lists.openembedded.org <bitbake-
>> devel@lists.openembedded.org> On Behalf Of Robert Yang
>> Sent: den 26 augusti 2022 15:11
>> To: bitbake-devel@lists.openembedded.org
>> Subject: [bitbake-devel] [RFC][PATCH V2] bitbake: fetch2/git: Use git
>> fetch to shallow clone revisions
>>
>> * V2
>>    Fixed typos in commit message
> 
> Patch history should go after the --- below.
> 
>> The "git clone --depth" only works for refs, doesn't support revisions, but
>> "git fetch --depth" supports revisions, so use it to do the shallow clone, the
>> idea is from "git clone --recurse-submodules --shallow-submodules".
>>
>> The workflow is (Only enabled when BB_GIT_SHALLOW = "1"):
>> $ git init --bare <clonedir>
>> $ git remote add origin <url>
>> $ git fetch origin --depth <depth> revision
>> $ git branch <branchname> FETCH_HEAD
>> $ git tag v<branchname> FETCH_HEAD
>>
>> Here is the testing data based on poky, the testing server has a very good
>> network bandwidth:
>>
>> Add 'BB_GIT_SHALLOW = "1"' conf/local.conf
>> $ rm -fr tmp downloads # Fresh download for each build
>> $ time bitbake world --runall=fetch
>> $ du -sh downloads/git2/
>>
>>         Full        Shallow      Saved
>> --------------------------------------
>> Time:  15m59s       2m31s       84% (13m28s)
>> Size:  12G          1.2G        90% (10.8G)
>>
>> * The Size is for downloads/git2/, the tarballs are not counted.
>>
>> We can see that it saves a lot of download time and disk space, for
>> example:
>>
>> linux-yocto: 2.8G -> 228M
>> llvm: 2.5G -> 171M
>> cryptography: 1.5G -> 35M
>>
>> And "$ bitbake world" works well.
>>
>> This a RFC patch, please feel free to give you comments.
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>   bitbake/lib/bb/fetch2/git.py | 83 ++++++++++++++++++++++++++++--------
>>   1 file changed, 66 insertions(+), 17 deletions(-)
>>
>> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
>> index 4534bd75800..57bb61d5ee1 100644
>> --- a/bitbake/lib/bb/fetch2/git.py
>> +++ b/bitbake/lib/bb/fetch2/git.py
>> @@ -244,6 +244,7 @@ class Git(FetchMethod):
>>                   ud.unresolvedrev[name] = 'HEAD'
>>
>>           ud.basecmd = d.getVar("FETCHCMD_git") or "git -c core.fsyncobjectfiles=0 -c gc.autoDetach=false -c core.pager=cat"
>> +        ud.basecmd = "LANG=C %s" % ud.basecmd
>>
>>           write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0"
>>           ud.write_tarballs = write_tarballs != "0" or ud.rebaseable
>> @@ -344,6 +345,49 @@ class Git(FetchMethod):
>>               return False
>>           return True
>>
>> +    def shallow_clone_by_fetch(self, ud, repourl, d):
>> +        """
>> +        Use "git fetch --depth <depth> revision" to implement shallow clone
>> +        since git can't clone a revision, a better solution should be:
>> +        "git fetch --depth <depth> revision:<branchname>" but it doesn't work
>> +        when revision is a tag, e.g.:
>> +        error: cannot update ref 'refs/heads/master': trying to write
>> +                non-commit object <revision> to branch 'refs/heads/master'
>> +        """
>> +
>> +        import datetime
>> +
>> +        depth = ud.shallow_depths[ud.names[0]]
>> +        revision = ud.revisions[ud.names[0]]
>> +        branchname = ud.branches[ud.names[0]]
>> +        if not branchname:
>> +            branchname = "master"
>> +
>> +        # Rename branchname if it exists which can:
>> +        # - Avoid conflicts during update
>> +        # - Keep the revision on a branch so that "git submodule update --recursive"
>> +        #    can work since it requires the revision on a branch.
>> +        branch_path = os.path.join(ud.clonedir, 'refs/heads/%s' % branchname)
>> +        if os.path.exists(branch_path):
>> +            os.rename(branch_path, '%s.%s' % (branch_path, datetime.datetime.now().strftime("%Y%m%d%H%M%S")))
> 
> Any reason this is done using os.rename() rather than `git branch -m?

It is because this is simpler and to keep align with branch_path, otherwise, we 
need:
- git branch --list to get the branch list and split them by '\n', remove the star.
- Check branch in the list
- git branch -m to rename the branch

> 
>> +
>> +        init_cmd = "%s init --bare -q" % ud.basecmd
>> +        add_remote_cmd = "%s remote add origin %s" % (ud.basecmd, shlex.quote(repourl))
>> +        fetch_cmd = "%s fetch --progress origin --depth %s %s" % (ud.basecmd, depth, revision)
>> +        # Create both branch and tag for the revision
>> +        branch_cmd = "%s branch -f %s FETCH_HEAD" % (ud.basecmd, branchname)
>> +        tag_cmd = "%s tag -f v%s FETCH_HEAD" % (ud.basecmd, branchname)
> 
> Why not define these as a list instead:
> 
>          cmds = [
>              "%s init --bare -q" % ud.basecmd,
>              "%s remote add origin %s" % (ud.basecmd, shlex.quote(repourl))
>              "%s fetch --progress origin --depth %s %s" % (ud.basecmd, depth, revision),
>              # Create both branch and tag for the revision
>              "%s branch -f %s FETCH_HEAD" % (ud.basecmd, branchname),
>              "%s tag -f v%s FETCH_HEAD" % (ud.basecmd, branchname),
>          ]

Thanks, I will update it with others' comments in the following days (If there 
are any).

// Robert

> 
>> +
>> +        if ud.proto.lower() != 'file':
>> +            bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
>> +
>> +        if not os.path.exists(ud.clonedir):
>> +            bb.utils.mkdirhier(ud.clonedir)
>> +
>> +        progresshandler = GitProgressHandler(d)
>> +        for cmd in (init_cmd, add_remote_cmd, fetch_cmd, branch_cmd, tag_cmd):
>> +            runfetchcmd(cmd, d, log=progresshandler, workdir=ud.clonedir)
>> +
>>       def download(self, ud, d):
>>           """Fetch url"""
>>
>> @@ -360,7 +404,7 @@ class Git(FetchMethod):
>>               else:
>>                   tmpdir = tempfile.mkdtemp(dir=d.getVar('DL_DIR'))
>>                   runfetchcmd("tar -xzf %s" % ud.fullmirror, d, workdir=tmpdir)
>> -                fetch_cmd = "LANG=C %s fetch -f --progress %s " % (ud.basecmd, shlex.quote(tmpdir))
>> +                fetch_cmd = "%s fetch -f --progress %s " % (ud.basecmd, shlex.quote(tmpdir))
>>                   runfetchcmd(fetch_cmd, d, workdir=ud.clonedir)
>>           repourl = self._get_repo_url(ud)
>>
>> @@ -369,27 +413,32 @@ class Git(FetchMethod):
>>               # We do this since git will use a "-l" option automatically for local urls where possible
>>               if repourl.startswith("file://"):
>>                   repourl = repourl[7:]
>> -            clone_cmd = "LANG=C %s clone --bare --mirror %s %s --progress" % (ud.basecmd, shlex.quote(repourl), ud.clonedir)
>> -            if ud.proto.lower() != 'file':
>> -                bb.fetch2.check_network_access(d, clone_cmd, ud.url)
>> -            progresshandler = GitProgressHandler(d)
>> -            runfetchcmd(clone_cmd, d, log=progresshandler)
>> +            if ud.shallow:
>> +                self.shallow_clone_by_fetch(ud, repourl, d)
>> +            else:
>> +                clone_cmd = "%s clone --bare --mirror %s %s --progress" % (ud.basecmd, shlex.quote(repourl), ud.clonedir)
>> +                progresshandler = GitProgressHandler(d)
>> +                if ud.proto.lower() != 'file':
>> +                    bb.fetch2.check_network_access(d, clone_cmd, ud.url)
>> +                runfetchcmd(clone_cmd, d, log=progresshandler)
>>
>>           # Update the checkout if needed
>>           if self.clonedir_need_update(ud, d):
>>               output = runfetchcmd("%s remote" % ud.basecmd, d, quiet=True, workdir=ud.clonedir)
>>               if "origin" in output:
>> -              runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=ud.clonedir)
>> -
>> -            runfetchcmd("%s remote add --mirror=fetch origin %s" % (ud.basecmd, shlex.quote(repourl)), d, workdir=ud.clonedir)
>> -            fetch_cmd = "LANG=C %s fetch -f --progress %s refs/*:refs/*" % (ud.basecmd, shlex.quote(repourl))
>> -            if ud.proto.lower() != 'file':
>> -                bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
>> -            progresshandler = GitProgressHandler(d)
>> -            runfetchcmd(fetch_cmd, d, log=progresshandler, workdir=ud.clonedir)
>> -            runfetchcmd("%s prune-packed" % ud.basecmd, d, workdir=ud.clonedir)
>> -            runfetchcmd("%s pack-refs --all" % ud.basecmd, d, workdir=ud.clonedir)
>> -            runfetchcmd("%s pack-redundant --all | xargs -r rm" % ud.basecmd, d, workdir=ud.clonedir)
>> +                runfetchcmd("%s remote rm origin" % ud.basecmd, d, workdir=ud.clonedir)
>> +            if ud.shallow:
>> +                self.shallow_clone_by_fetch(ud, repourl, d)
>> +            else:
>> +                runfetchcmd("%s remote add --mirror=fetch origin %s" % (ud.basecmd, shlex.quote(repourl)), d, workdir=ud.clonedir)
>> +                fetch_cmd = "%s fetch -f --progress %s refs/*:refs/*" % (ud.basecmd, shlex.quote(repourl))
>> +                if ud.proto.lower() != 'file':
>> +                    bb.fetch2.check_network_access(d, fetch_cmd, ud.url)
>> +                progresshandler = GitProgressHandler(d)
>> +                runfetchcmd(fetch_cmd, d, log=progresshandler, workdir=ud.clonedir)
>> +                runfetchcmd("%s prune-packed" % ud.basecmd, d, workdir=ud.clonedir)
>> +                runfetchcmd("%s pack-refs --all" % ud.basecmd, d, workdir=ud.clonedir)
>> +                runfetchcmd("%s pack-redundant --all | xargs -r rm" % ud.basecmd, d, workdir=ud.clonedir)
>>               try:
>>                   os.unlink(ud.fullmirror)
>>               except OSError as exc:
>> --
>> 2.35.1
> 
> //Peter
> 

