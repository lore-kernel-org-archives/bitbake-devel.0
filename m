Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F19C7EE29
	for <webhook@archiver.kernel.org>; Wed, 24 May 2023 02:18:32 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.64.1684894711652280206
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 May 2023 19:18:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriver.com header.s=pps06212021 header.b=qC5KWGCl;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=450882475c=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O1ra5G015906
	for <bitbake-devel@lists.openembedded.org>; Tue, 23 May 2023 19:18:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=message-id : date
 : subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=0jrmFYzfd4GBRWFrICYexp2byI7WFcwVl7AzfwX2CbA=;
 b=qC5KWGClBl9RbGf5uvhnCu91k+JRZ3YR4KCTf2Xralgo6Oqht0vbtveksh7rUJkLkCpL
 +08OpUxEKH5+IT5vaJUrJuUkFyGqmdTgiqrxGO+TxpRmMo/8xnzMbV6pbYoGc+26veJd
 eXMC/oc9Vt2WCUTeCMNZ1BizOd8DaUgY9Nmb5KcrpgoSNK8bQb3gP33gqFVlIVPRxTe1
 EmpZXo+8126b3H6hfpUiGECZdNjKWCZ/6B5oo7FFTU6npXwC8njdcDQHz/yaGCm6Wk5V
 JdKiJlWrbqR3rZNFi17uoAiuB7Qc2JRWQGRkMswGSFf82OK+Iwt4PvdvxoitWFYdkgdT RA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qpsg1kcfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 23 May 2023 19:18:30 -0700
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34O2IUn5027501
	for <bitbake-devel@lists.openembedded.org>; Tue, 23 May 2023 19:18:30 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qpsg1kcfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 May 2023 19:18:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmvkqY3qHryoHiAQ5J1yFjb31DF+wUsqXtu+Kl5cybjSWfwHpr5CLnCrhXmXVfOtvmfdm5h/VpzSfC7sTIyfBaa573Ko0UhRjjkBAQj8u2KrHzYL+VD67G7SLwLiEpMkp+H//KuBbq4+b0Hw9yrPRah5pKdQQKiZrfpYp6iRtTY6Uxozqvi4JIo0o6roe+uPShG1+0UfRExdUWw0v3Ou78TML+Nz9pZGWpSYqB17wTIPQXFrhBPHbZ1q82Z2MB0FUJf0WrTMKBBzQncFzGKVyDsso35SoHxE3tcyeGd7FnFxwmbgdlueo/S7XPJcmBcEhjR6Yr/rwhLLsMQ84uMeng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jrmFYzfd4GBRWFrICYexp2byI7WFcwVl7AzfwX2CbA=;
 b=gdYdODeNUInecRvZLnF8SHuG74rbiaNweekte3s5S0bZu+Nf4xHRb1SEEIw4KO+d0MHSkmkc7K02n+yd+7+8Z3fqO6NC83Z6ov+LryQ7Z49MkhcpHXSPKUB0P/+F+Okl7jyMpeSpbAVYwUyiBXNPoSK77R9migl6RJjnSCqMRd3Ghl2jGEfMIXJ/BgSRoTbH16m+s6mjMYs87rUj25nnG3X0y7dqCEJgu8V98iY0P7jIGUeOFHCsAWY62v4jApvsy8bCe+XX0SSkSmzL7H1KwABHn4WYug0SUJLnKACmYCRfh17U02TQPWrvJG/E1VdL6LgJwejAiHTNaBDq3TTbtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SA2PR11MB4939.namprd11.prod.outlook.com (2603:10b6:806:115::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 02:18:27 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::b504:c7a0:9ce8:6f17]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::b504:c7a0:9ce8:6f17%3]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 02:18:27 +0000
Message-ID: <f3098958-331a-f56b-e449-da2ac2a546ce@windriver.com>
Date: Wed, 24 May 2023 10:18:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [bitbake-devel][PATCH V2] runqueue.py: fix PSI check logic
To: Randy MacLeod <randy.macleod@windriver.com>,
        bitbake-devel@lists.openembedded.org
Cc: ola.x.nilsson@axis.com
References: <20230523020905.2911543-1-Qi.Chen@windriver.com>
 <a963a98b-0420-5785-b393-306ebbf6f230@windriver.com>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <a963a98b-0420-5785-b393-306ebbf6f230@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: TYCP286CA0269.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::20) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|SA2PR11MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: 0163edd6-5edf-47a0-68e4-08db5bfd286a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ew5yn7mG3+APZ4O9TXPWlt8aI4ZgGzzdff2cEfo+Rgv/N8PDW+Zbw07tJ74OK0UaZZXcpsh926dys91f9dTz4FRlPEOYL/rai1pObBqsIJdb80CRY9llowZxompUrbznb8qpi2IdtYYaVnMICoFnbB+NCdr7+a9cPan3QG3FTH/dS3qDHQmU8XFPBsr2lOMYF+IzgWhk1CpmC4Z8cGAXRShUwlveHRahowL6u9wBoLnSD94eg/Xnj2zj70SzcYSNhU8nfxWdjDGU9kcrzYL6D7VSZpsjqKWc8e4Lv3NbRmG/QVeaDWTa6U4NU/ThHZiTpyE2C60EwnGII+qdzGZxC4pJvrmeD+anOTSZ9CgrCgoCXFoa53u9S3/N44uTY2Kn4kE+xokAobIv/2CUCkCgTqG2+V87vD2Wbe9HDNxy3vEOVFBxn5mBlozDHfzKbPtf+95LOf40EH4mBJtyh3AIdhpO8XFeKV57ODp7CQ1We66f780sYb2spf75Kt7FcdEVzFuMUDFRREAcGpN7R5pNod/5PdPKXytrhHMIcwgNKPatKVIA3Hs/ar8Jb+0KWaqF7vfUTAaSN5twi1B6YyZWS3jmzRUyor7mOR5b5zDI8J1Ga/F+u3V5+FhWrkGzuwcP+Eq34hCpdRnZlUqfzjAgKg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(376002)(39850400004)(451199021)(31696002)(38100700002)(41300700001)(6486002)(316002)(66476007)(4326008)(66556008)(6666004)(66946007)(5660300002)(8676002)(8936002)(86362001)(478600001)(31686004)(83380400001)(6506007)(26005)(6512007)(2906002)(53546011)(186003)(36756003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QTNWMnA4N1JuSjRscHZaaFVEZnRVaVUwbkRLbCs3S0R1VncwTjZ1ZUJqRkcx?=
 =?utf-8?B?QSsvYnFXNmU3RTlRWWFmZm5jUFUrY3VCUUJyekdxak8rUnZOQ1BTNW9GcGs2?=
 =?utf-8?B?NjRaZmNhUUdYZ0p3U1ZMQWxzMkVjTWVad2hqUWtQYVRtZ3BYL01qc2pUNnRE?=
 =?utf-8?B?Zkx1QXUwUlFvVHdTWFFXRFZJdFZSTEtPcFBINFNGSjFwZ0VsR3o1b3pzZlpz?=
 =?utf-8?B?aWUvM24yOG5MZVY1eXdRUCt5T0Z1MkZxVzl0aS9IcDh3Mks4dysvVjJlWVA4?=
 =?utf-8?B?a0Y1VU1OK0pURThHbHlRRElNTEU2R0RWemdYUHkzOVE5YndSL2hPZnEvRWk3?=
 =?utf-8?B?V0FEQVVDUEN0Y2RYVC9QbDRIeTB0aEkrbnBrd3psam54cHJFNGYvak5lMFAr?=
 =?utf-8?B?cWZhUmwyVjdEU1ZRUW8rOENoTlNZdFFVUTlZSXE2NjFyUFlWVFNRNXEyNy9n?=
 =?utf-8?B?UE40QmZnVHNOWWR0OE5ENXdmNXc5N1ZZMEQvUHJudWs0ZUFSOEJQZHJDclZv?=
 =?utf-8?B?V0h4VFd6RVRWdEFlYXJCY1VvUXlzb2dzeW84K0pkRXZDbTVwTnlKTGRtQ0tr?=
 =?utf-8?B?WmtEUUZpbktKakVJb2xaUGdjVkFiOG45S1NxUzJZZ1R5NzRzbHZHS2dhaGhr?=
 =?utf-8?B?UGdwU3hwVFhqZWd3M1NEZVJlVFQ4N3hDcUdRNmVlNUp2NVlxVUN4Wi9Fa2Iw?=
 =?utf-8?B?YUxwUlcyOExaaXpnYm9JZlVlSnBSY2MxUmh6cEdTOFd2Nkk5U0xKNXV3U214?=
 =?utf-8?B?RHh4cWh0MzFWVytvRVpHK2Faa2Y3eitxS1lkQmc1NnlWRWVIOVpuYXIyWVV6?=
 =?utf-8?B?bU9jTmhkVUpoNWJKTVl6cHUwVEVmMlVFdTJ2LzZUU3pRSFBPay9kbEExVnJj?=
 =?utf-8?B?bkR3Q1J4K0JKcndqZi9UOXRtNUNWNUlBdUQ5VFJrTTBVSm1HMkgrcTl2NHVm?=
 =?utf-8?B?OHBDU01JYWJ3MXFZeGFiM2tVdTFHUmh2YVM1RVFvVU12Q3ovNWNLbkVtYVd6?=
 =?utf-8?B?NGtPMTZrN0N3dzlUc05DTlFNbklTSmJia3ZkQy92Vzlvcyt4elpxRmxLMGlz?=
 =?utf-8?B?WklCaUNMaE9kZkx6bjh2RldhUGdoU2ZaYVFaQXVZaWNHODhuZWJ5T3VjK0RN?=
 =?utf-8?B?WmFXTUZleTJuZFB2OE5SZWp3WnJ4ZkVmc1NCMUtKT0c3bExBbUNUYkN0Z1NS?=
 =?utf-8?B?djhWVGxZa2ZDc2xWQzZmV2pxS3Boc0RQb1ROUEtzVVF4Nkd1bGRnN0xUT0l1?=
 =?utf-8?B?YUpnaXJDNk5nSTZMSk44L0RBRGYrbEF5ZkJGVUVOd1Y3T0p5cm1qVXNYOXgx?=
 =?utf-8?B?T00xYUx6aDhrU2llTGZNTmdQY21wOUR4aVVjY3owMFdwL0V0U0ttYW5KbERT?=
 =?utf-8?B?TjllWGNweGFVUlNwd09QeUZCOHZicG16N1JnSE5hbnd2cWR1NmhlUUcxamhz?=
 =?utf-8?B?TXc1clZwVnZDMFJKOXlvdjBzaTNVVmRMVWFORVNkeWdaSEFyLzcyV1FyZVNu?=
 =?utf-8?B?YUVHeUcrTE1uOUN0REp1bklQSXdQSytpVS9OQmVqTHN2eHBQWWRtYjRTRlJx?=
 =?utf-8?B?QlNIVDZJODFMRHRHMDlKMk5sOS9nbWRocmNpTmtYMjN2L0JJRGRVcmtkeWFS?=
 =?utf-8?B?WjFybjdzU3doTU85UEhjZ1BlZHJld1lNaEdBVnlDUW83TmhZY1JjbDdINUFp?=
 =?utf-8?B?ZnNFQzlRK0djdTRkYkYwbG0xdXptcG1IbHpBS290WkJEL1lVZGlzRTgweXk2?=
 =?utf-8?B?R2l6aVREbFgrY3AyRHFpU0N1VFJUTXVKVDg5cmkxMlVBNjVZbUNuUkgrb0VJ?=
 =?utf-8?B?QWUxQVltQnBRdDBwN1FiUmlpUzRjNHZ0d1pNanhxMGh3elRvVExKSldGYktK?=
 =?utf-8?B?ODhZNUdaTnNjWnVOT3A3RHkxOVZHYkNCcEtrMXltWWpybXNNUkhTQW4xOXNz?=
 =?utf-8?B?b3Rtb2NIZzI3UUsyUUlNd2JMUzhxUmdNYjNYWi9hWit1MlJaYXRrVGtORFhv?=
 =?utf-8?B?bnA5MFZWY2FYak5JRGFSMDkyQUVOeG1RaDdZNnRuQnNrYTQ4b2dGYi9sU0Na?=
 =?utf-8?B?Njc1WkQxaWlsS2NqSjA1U1NvdE5wUHBmaEF3MU85TkhpM1pMUDVMWlpMZHJz?=
 =?utf-8?Q?PcT+byarTbBt+MVBI1/Hd+sF6?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0163edd6-5edf-47a0-68e4-08db5bfd286a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 02:18:26.9017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAnrD/sKvDCtIBfXIMNGrQ+6m1wS2KMPAQCWo7KH1ziCreYEpj+m1hEjQl8n82Trt6cclG4sNu+lX9DBHicxyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4939
X-Proofpoint-GUID: sakYmogzLfSnUAIKRAJAndNfRUPFSMBY
X-Proofpoint-ORIG-GUID: GgS5yurpNJru4RUl0mNxERMmJ-wY7-mm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_16,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 suspectscore=0 mlxlogscore=908 mlxscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240017
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 34O1ra5G015906
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 24 May 2023 02:18:32 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14802

On 5/24/23 07:24, Randy MacLeod wrote:
> On 2023-05-22 22:09, Qi.Chen@windriver.com wrote:
>> From: Chen Qi<Qi.Chen@windriver.com>
>>
>> The current logic is not correct because if the time interval
>> between the current check and the last check is very small, the PSI
>> checker is not likely to block things even if the system is heavy
>> loaded.
>>
>> It's not good to calculate the value too often. So we change to a 1s
>> check. As a build will usually take at least minutes, using the 1s val=
ue
>> seems reasonable.
>
> I don't have time to check today but I'm not convinced that this is tru=
e.
>
I'd like to give out two reasons to try to convince you :)

1. Think of this as some kind of sampling rate on the PSI data. Picture=20
in our mind the wave of the PSI data, and we sample it. Only in a=20
situation where PSI data changes very rapidly (high -> low & low ->=20
high) on a time basis less than 1s (e.g., 0.1s), will we want to check=20
more. I don't think there would be any situation like this in our real li=
fe.

2. The build time is typically related to task numbers. From example, a=20
core-image-minimal involves about 2000+ tasks and takes about 20 minutes=20
(1200s) to finish. In such case, we have about 1000+ checks during the=20
whole build for 2000+ tasks. This seems pretty enough.


> I suspect that in the typical case, it would be okay but there will be
> workloads (perhaps rare workloads) where you want to check more often.
>
> The 1 second intervals where we no longer launch new work may
> result in a significantly longer build. IIRC, our benchmark was buildin=
g
> core-image-minimal on a 24 core system without PSI regulation and then
> with it set to 300.
>
The reason we currently have to use very low number (e.g., 300,=20
300/1000000=3D0.03%) to achieve the effect of restricting task spawning i=
s=20
due to the problem Ola pointed out, that is, even if a task is blocked=20
in this check, if the next check happens shortly enough, the task does=20
not get blocked. We need to apply this patch or similar to start compare=20
the data.

Maybe 5% (50,000) or 10% (100,000) would serve as a start?

Regards,

Qi

> I'd look at the elapsed time and the buildchart/bootchart:
> =C2=A0=C2=A0 scripts/pybootchartgui/README.pybootchart
>
> Ola, have you been able to test this and if not, can you?
>
> All for today.
>
> ../Randy
>
>
>> Signed-off-by: Chen Qi<Qi.Chen@windriver.com>
>> ---
>>   bitbake/lib/bb/runqueue.py | 29 ++++++++++++++---------------
>>   1 file changed, 14 insertions(+), 15 deletions(-)
>>
>> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
>> index 02f1474540..4d49d25153 100644
>> --- a/bitbake/lib/bb/runqueue.py
>> +++ b/bitbake/lib/bb/runqueue.py
>> @@ -179,6 +179,7 @@ class RunQueueScheduler(object):
>>                       self.prev_memory_pressure =3D memory_pressure_fd=
s.readline().split()[4].split("=3D")[1]
>>                       self.prev_pressure_time =3D time.time()
>>                   self.check_pressure =3D True
>> +                self.psi_exceeded =3D False
>>               except:
>>                   bb.note("The /proc/pressure files can't be read. Con=
tinuing build without monitoring pressure")
>>                   self.check_pressure =3D False
>> @@ -191,6 +192,10 @@ class RunQueueScheduler(object):
>>           BB_PRESSURE_MAX_{CPU|IO|MEMORY} are set, return True if abov=
e threshold.
>>           """
>>           if self.check_pressure:
>> +            now =3D time.time()
>> +            tdiff =3D now - self.prev_pressure_time
>> +            if tdiff < 1.0:
>> +                return self.psi_exceeded
>>               with open("/proc/pressure/cpu") as cpu_pressure_fds, \
>>                   open("/proc/pressure/io") as io_pressure_fds, \
>>                   open("/proc/pressure/memory") as memory_pressure_fds=
:
>> @@ -198,21 +203,15 @@ class RunQueueScheduler(object):
>>                   curr_cpu_pressure =3D cpu_pressure_fds.readline().sp=
lit()[4].split("=3D")[1]
>>                   curr_io_pressure =3D io_pressure_fds.readline().spli=
t()[4].split("=3D")[1]
>>                   curr_memory_pressure =3D memory_pressure_fds.readlin=
e().split()[4].split("=3D")[1]
>> -                now =3D time.time()
>> -                tdiff =3D now - self.prev_pressure_time
>> -                if tdiff > 1.0:
>> -                    exceeds_cpu_pressure =3D  self.rq.max_cpu_pressur=
e and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff =
> self.rq.max_cpu_pressure
>> -                    exceeds_io_pressure =3D  self.rq.max_io_pressure =
and (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff > se=
lf.rq.max_io_pressure
>> -                    exceeds_memory_pressure =3D self.rq.max_memory_pr=
essure and (float(curr_memory_pressure) - float(self.prev_memory_pressure=
)) / tdiff > self.rq.max_memory_pressure
>> -                    self.prev_cpu_pressure =3D curr_cpu_pressure
>> -                    self.prev_io_pressure =3D curr_io_pressure
>> -                    self.prev_memory_pressure =3D curr_memory_pressur=
e
>> -                    self.prev_pressure_time =3D now
>> -                else:
>> -                    exceeds_cpu_pressure =3D  self.rq.max_cpu_pressur=
e and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) > self.r=
q.max_cpu_pressure
>> -                    exceeds_io_pressure =3D  self.rq.max_io_pressure =
and (float(curr_io_pressure) - float(self.prev_io_pressure)) > self.rq.ma=
x_io_pressure
>> -                    exceeds_memory_pressure =3D self.rq.max_memory_pr=
essure and (float(curr_memory_pressure) - float(self.prev_memory_pressure=
)) > self.rq.max_memory_pressure
>> -            return (exceeds_cpu_pressure or exceeds_io_pressure or ex=
ceeds_memory_pressure)
>> +                exceeds_cpu_pressure =3D  self.rq.max_cpu_pressure an=
d (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff > se=
lf.rq.max_cpu_pressure
>> +                exceeds_io_pressure =3D  self.rq.max_io_pressure and =
(float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff > self.r=
q.max_io_pressure
>> +                exceeds_memory_pressure =3D self.rq.max_memory_pressu=
re and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) /=
 tdiff > self.rq.max_memory_pressure
>> +                self.prev_cpu_pressure =3D curr_cpu_pressure
>> +                self.prev_io_pressure =3D curr_io_pressure
>> +                self.prev_memory_pressure =3D curr_memory_pressure
>> +                self.prev_pressure_time =3D now
>> +                self.psi_exceeded =3D exceeds_cpu_pressure or exceeds=
_io_pressure or exceeds_memory_pressure
>> +            return self.psi_exceeded
>>           return False
>>  =20
>>       def next_buildable_task(self):
>
>
> --=20
> # Randy MacLeod
> # Wind River Linux



