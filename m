Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA23EB64DD
	for <webhook@archiver.kernel.org>; Mon,  7 Aug 2023 09:07:12 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.30063.1691399228620113513
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Aug 2023 02:07:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=aFOuySsp;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75832b7afd=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3777nkaR001000
	for <bitbake-devel@lists.openembedded.org>; Mon, 7 Aug 2023 09:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=ie1c9tSMvqEwQy4gKxkn8JOja2uWcN5l6PhYxIVdtLo=; b=
	aFOuySspL3ipRg9vLh1mBwv4Od8rMNLdFSay8Cx2AJgQ8SrIpMcdMrogZw75Plen
	NRNGs2qeSQ9Sc1S/BuQnbkNmAn/O7ZiDsRVbo2AoMqdxEORT/3/B7ks2TdG37n8+
	7PrTGOR18fwqT1Z2FchN8uRV/IBDf9kPORXKOUkqmcJOTPwWqsQJs4/LN35rmXtI
	hHm1ZDF85ffS/WVwxw1+vgahxALKt67D3QvJpib94ZPgk7L0K7/tjdxuydXJOCur
	1pa+uEJLzLZbLNCvUmFN4PgaUTr6JeEGVJ5ir/Z6Q4QAT87BpJE5tcV882xZrQum
	+MH/IimhqC27SJiunNQQtg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s9dd61et5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 07 Aug 2023 09:07:07 +0000 (GMT)
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.22/8.17.1.22) with ESMTP id 377976rb018344
	for <bitbake-devel@lists.openembedded.org>; Mon, 7 Aug 2023 09:07:06 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s9dd61et3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 07 Aug 2023 09:07:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=djG8sasjVp92FnVkN+qV2y3VnB2tkhpcnvve+ma4xsz2IEd6X4feSYhATSoHz0EumfLoKcEQn49/uDn2ADWOQLpJN1Pcghn9+okz41GpDsTrRqOpZ7dUsXgx8P8tQc0R52WpZ+DDUiwHwqynQLnOUW4sUB1zSBh4EZiydw9b8yf0bMuPxkAUdTkh29uyi0rCtttWhkXwO0+4AUVNZBzSSSiu1u/v9aw698DaRYUDqWEs1w6oPznEKjhUe42iebMk2iAyyPgLpNHe1Kfhri2NSNso1UYxL4VibuRQzXCS5hgpWdXM6zu560B38rik8nILJz3rYv6wB2UaVg7DR3tyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ie1c9tSMvqEwQy4gKxkn8JOja2uWcN5l6PhYxIVdtLo=;
 b=Jov8xQOinHR3xD89HjDXOaNoSwin6eRTisxn1PehIevI3c5i08Yvv4/92jDVxddrod9jFyYHdAHAsel6/XPuGtc2Y0mz2GatiN3SE7a52dv4uYpr5EFqBtp1JAMKC8wMl78jxrCZHOz8vkp6YJpxLhqbM2PLKdKG0Xs7LguLwGfC6bhDyI74qWd1tFIO/b5uuo+W2GIwrrcrt1XZ/rXNU3N5ww9ibGw8VI1shHhVRJqyuzH/1RaK5Lp/ykYUiv303yCDEsTZpLqwiCwV0LvLLhY84SG9zdd3oxEem1kxMZN7EQvmABOh/b1vItJpHrQgBcy44ybap391Wo6YdOcXZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by DS0PR11MB7684.namprd11.prod.outlook.com (2603:10b6:8:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 09:07:03 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::86dd:2ee6:ac66:812d]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::86dd:2ee6:ac66:812d%4]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 09:07:03 +0000
Message-ID: <1c7bfcd4-3880-55a0-61d0-06d934d3e98a@windriver.com>
Date: Mon, 7 Aug 2023 17:06:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [bitbake-devel][PATCH V4] runqueue.py: fix PSI check logic
Content-Language: en-US
To: Randy MacLeod <randy.macleod@windriver.com>,
        bitbake-devel@lists.openembedded.org,
        Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20230803075638.2355913-1-Qi.Chen@windriver.com>
 <ac05a465-6da7-3441-b45d-ab65c73f244d@windriver.com>
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <ac05a465-6da7-3441-b45d-ab65c73f244d@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SG2PR01CA0143.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::23) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|DS0PR11MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 74eb4068-797e-4954-0db8-08db9725aa4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RRoc/M3jkGXg9vSCf/Aht9B9PiJ9lVWafaeRw9q/UhgBPqu9ss6AidTZADFQw5NxW+POCMQugt/6K63kCRaqgfj8iNi9b9uhLAKILFQr+kWst2xnK03/msLCmGnyoIzl5T0qDFB2OFEEWIkVvU559Gh1l+M7mGWiHFOeUNP2PuSTPjZte6ufYE3gJFrz6RcMqnNAJCxR0ByPqXecvGQQ4c8hoyURW85L7TbcaHO0iFXZ9maExZN4uSkJBZ6OQ4CGlh9iijmoW9FVqDhpgULK1qO0/hI/MsRK6/m27HfrS3QaRDXORdjLC+/swAkTFeH1XrUlNaNwytkigQZ2NNSM/7iGnQgUXNzNRb4HbXLkAtCoBcHC4cfEJBwfKQaj7M46Cl4Th3jexp4S5YDfiZlZLBx8I1lnfrNZpGEYOCk6inR4FaxkAXPh22aLLeLBHT+QSiaPf7lZVPsZDTTnZ2varTs7CwXEnFMGRFFUwXO2ZjMVmsamQk7Jl3VJEcGODSmB6xhk1yUSf5VeJwKsBJKchoGa4Fa8sCfqDYoW+sy69DJQel5ROOEXCBJfvGDNlJsSxKHyMgdTliWwLG+l/wOi7dPSoA52FSImLgSgJY/1MyYVJdIucEkqQk69EAjp/MjLYl3/Uf+oiEKKG8mDrE/OzMd72KSU+dT4kaTqJJbMC8A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(346002)(39850400004)(396003)(186006)(1800799003)(451199021)(83380400001)(31686004)(2616005)(110136005)(2906002)(30864003)(316002)(5660300002)(8936002)(8676002)(66946007)(66476007)(66556008)(38100700002)(86362001)(6512007)(478600001)(31696002)(6666004)(6486002)(41300700001)(36756003)(6506007)(45080400002)(26005)(53546011)(21314003)(43740500002)(45980500001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UFY4c3ZHWnQ1eHVmbng1M21UMTNidTdsR0laYTNGNFZoT0lVSHNnekczc2hr?=
 =?utf-8?B?cWNqTnU4VnZuNWlpTDNHNGJUT1U4RUhlTWpBejkyc1grdjFmeWQzSHNyMUtN?=
 =?utf-8?B?bW9EdG5iK1FtR1BRelhXWGsvb2VEL1Izdy9rTzdkSFE4MWN3WWh4WXE0dE5v?=
 =?utf-8?B?M0FuVXNaaVRveHdnYzkySXk0K0hMWThTbnpmRUlXUE5QNkV4bTg4Q1VYeVE4?=
 =?utf-8?B?SU9rdW1WN1l5Qm9qb2s1V0oyNWN1bUcya1BLMXdjM1IzaFc1YmxtYVNjc0JS?=
 =?utf-8?B?SSthQUY0Vi9MNVRmNjZ2YVBDaE9hSzlSS2hLUHpZZGJwSittVGtoc0lTUXAz?=
 =?utf-8?B?SkFuY0craXpZV3pWbnBQQnZKYWRtVGV3VnpwYWR5aVpZajBWaWZ1RFFieHRq?=
 =?utf-8?B?Qi9Oc0FGUmFzQWt0QUZEN2sxZXp4elFONkZTeWVEMjBFYkZ2N1Nra214QTdX?=
 =?utf-8?B?Ry9EdUp0NkRreWJjMWw3VlgxVmlFQk5Bcm1ObVdraUI0b01oUnpKRFZDbnlk?=
 =?utf-8?B?dk1POXloenFRNmpyQkhlbDEvemRLcVF0TWVUUmZUVlU4eWU1S2JkU2tvYVVV?=
 =?utf-8?B?U3cxUVZXVzBtUDlDN042V201L25pdE5kVFNsczJaTXlRNFRLWEd2MlNDVWcw?=
 =?utf-8?B?aytHRTZFZm1TbU5rQnEzbjV3ZUxkcHBtSXBFemFJYXI2UmlQbTZ5L1RlV2pi?=
 =?utf-8?B?Z0FOUm1VVTRLdHdLeElHVzlOak4rQlZlQXZ0TFM2WHk4TERlWTN6cm5IbGRI?=
 =?utf-8?B?NENSTDZxdXVwRzRQR2ZmNjFEaEhOZ0tnYnBYVUJOWFk4NXhqeSt5T01yanBE?=
 =?utf-8?B?RDExNkM5eWJRQUJkNnlWcFdwWjhrL3l3V0FGRy9Ddm1uK0ZodC9hSHk0bExT?=
 =?utf-8?B?ZzdYUzNyT0lXTVdIR1J3YTI2S1Y3bGdtNFlNWlV3dGU4K09MVXpYVy9HaWRD?=
 =?utf-8?B?STNqTnZoWjlHbW5YWXNVU2lHUGtsZ0ZBbEh3VTh3TDdZQUFzempYODdZd2VV?=
 =?utf-8?B?WUpKYU5tT1M4dlh2dGpiRk1BNldiem90dktBUDFGRkYwT0VwTXZCQmY1UlRT?=
 =?utf-8?B?M2Z3TXhpdThiM2I2ZHNnQ1VmRU4vSTcyQkN5akpmVEd4b0llU0JtUVlrT1E3?=
 =?utf-8?B?SklZOWJxQ2FaU0RZdHJpeWdlTjZpNnlEMlV2QnVieFIycFVkclNXeGYwS3VX?=
 =?utf-8?B?Z0tIZnRzTk1mNlZXUFJzYVZDeHkzZFNJeHowQTdxWVBJVkJZTVlPbGVzeVJK?=
 =?utf-8?B?WXU5MzFRSmZqSFZtQWZqNjBPSTIwNTBFTEVZM05ueWRuNVEyUWRrVDQ5a0F5?=
 =?utf-8?B?dm10T2hheENVWEtRbkZwZGQ5RXpHbDFrMGpIZjRtcmEyQ09sRi9vVE15MEp2?=
 =?utf-8?B?ZkhySE9LTVp1OGNqWEV0WnZMNkFzVXFKZzF5Rm9GUGNpc3pIVUM5TUJKRlBt?=
 =?utf-8?B?UUhKOWJOa0ZqS041Q2o0cE1mWU9vQ2RkMHE3VGE4VUpsY0t0Nkg4TjVmbC9w?=
 =?utf-8?B?VUZhMExieExXWXl3cE81dmd6WnUzUXVwQldaZkdISVQ5MGI4K05rREk5Rnhp?=
 =?utf-8?B?WDJ2UEhaQjAwMFRES3d6eTBkdVZJT2VuSmVTZUVSMWtCN2VsbjRpc1NNSnVJ?=
 =?utf-8?B?Q0pZRjRZUDk0cU40MlVJZUk4QXZkU0dWZkVrL1R4MWVnNXE3SVJnejBNa3I4?=
 =?utf-8?B?Y3N6R20wLzRjb09YUEhvck95MzNDNCt3VVk3NmhLamM0ajN1aHhrTk03NDgy?=
 =?utf-8?B?ajBiaTA5YVZoWVVrWUorZWVIb1lMVDRQSXJwQUl3SjBGYXBsSndheTU3TEJY?=
 =?utf-8?B?ZEk4a3hrRUFDcW5GdjdCaVk5d2RIbEcvNXRqWEhCalRrQzFDNFhhR3VYVWZO?=
 =?utf-8?B?WDR0Z0hTcjM3S0IrSThDTHFVRlpDR0ZkWkNtOWdtQkVOUnpQdm85YnNUQWpz?=
 =?utf-8?B?Y05UVG1qSVU5TWlXelJndnloWnozdWdrZGxRRTRJdWRwb2dvelF3R0NPRUpS?=
 =?utf-8?B?MW1rTC9kd2RuSld4a2trdlhEZmVpVCtRNXFVaEVkVFc5aEpuVVJrQ1NZR25S?=
 =?utf-8?B?NWVIZWtndmk1Um1QcnVXUjluQjgyVXJKWC9lU3VDdnJGZUtnM3VqQmVBanJD?=
 =?utf-8?Q?2tO4n5vEy0WfYjIaZXn0kyP98?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74eb4068-797e-4954-0db8-08db9725aa4a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 09:07:03.4138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AjWln15A3iKQOE0H0mHXqdsazcGDHh5ZGx7i/naWSe25VZ7276lQQOKG4Ceu0Jk6x1cRSOoru2CSY/PJpxCQEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7684
X-Proofpoint-GUID: oyWDAzIag2z8zuA1bldGHDGLSc7dbXdz
X-Proofpoint-ORIG-GUID: _WrlXQcHadjsRMhwjSxnzvcYwebL9lx9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_08,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308070084
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 3777nkaR001000
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Aug 2023 09:07:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14920

On 8/6/23 01:29, Randy MacLeod wrote:
> On 2023-08-03 03:56, Qi.Chen@windriver.com wrote:
>> From: Chen Qi<Qi.Chen@windriver.com>
>>
>> The current logic is not correct because if the time interval
>> between the current check and the last check is very small, the PSI
>> checker is not likely to block things even if the system is heavy
>> loaded.
> Agreed, there is a problem but we do have to be careful to not
> a make things too slow since the goal is to have maximum throughput
> without having too much congestion and cpu scheduling and IO latency.

Hi Randy & Richard,

Is the concern about the 1s blocking window?

I'm thinking about making the blocking time calculated from the current=20
pressure data & max setting value.

The idea is (cur_pressure - max_value) / (cur_pressure + max_value). In=20
this way, the blocking time is in the range (0, 1.0), the bigger=20
cur_pressure exceeds the max setting, the longer tasks are blocked.

What do you think?

Regards,

Qi


>> In fact, if the time interval is very small, the result
>> might be 0, resulting in any small value not having any effect.
> Yes, the PSI variable are implemented as per cpu vars and
> you can get the same result several times in a row, even when
>
> there is lots of CPU pressure. Eg:
>
> $ stress -c 25 -t 100 &
> [1] 3851144
> stress: info: [3851144] dispatching hogs: 25 cpu, 0 io, 0 vm, 0 hdd
> $ for i in `seq 200`; do date +"%Y-%m-%d %H:%M:%S.%N" >> /tmp/cpu; cat=20
> /proc/pressure/cpu >> /tmp/cpu ; done
> $ less /tmp/cpu
>
> See (1) below.
>
> I need to look at the PSI averaging algorithm again!
>
>
>> To reproduce the current problem, set BB_PRESSURE_MAX_CPU/IO/MEMORY
>> to "1", and start a build. We can see there's more than one tasks
>> running throughout the whole build process.
>>
>> This patch improves things a little bit. It will block task spawning
>> for at least 1s if the limits are exceeded, this is to overcome the
>> 0 result issue. On the other hand, if the task spawning is not
>> blocked, we check the pressure every time.
>>
>> However, even with this fix, we still have the task spawning peek issu=
e.
>> Because at some point, when the load is low enough, a few tasks will
>> be spawned altogether.
>>
>> In summary, this patch improves the situation, but the peek task
>> spawning peek issue is still there.
> Richard and I were talking about this and he suggested
> that we take a different approach of changing from a binary
> approach to one where if we're close (say withing 10%) of the threshold=
,
> we tell the bitbake scheduler:
>
> =C2=A0" Things don't look good, can you ask me again in a little while?=
"
>
>
> Then if the congestion abates, we allow new task and if not, then
> we've avoided introducing new load as we are ramping up.
> Richard claims that this "ask again in a while" is something the
>
> scheduler already has code for.
>
>
> This is essentially a smoothing algorithm, which I have little
> experience. I did, as a student decades ago, try to control the=20
> temperator of
> a beaker of water and bring it from room temperature to a predefined go=
al
> with minimal overshoot and reverberation! There are people with experti=
se
> in this sort of thing, so if you are such a person, it would be good=20
> to have
> you appear out of the Yocto woodwork!
>
> I think we're doing something similar to the temperature controlled=20
> beaker
> except it's a not a fixed thermal load but rather a continuously=20
> changing one.
>
>
> I'm not sure if I've written this down before but I think there would
> be some benefit, at least for a self-test, to have a series of stress-n=
g
> tasks that we put into a recipe. One would bring the system up to
> just below CPU (IO) congestion and keep the system in that state for a=20
> ~5-10
> minutes. Then we'd run another N (=3D 10?), short-lived (30 s?) stress-=
ng -c
> tests all at once. If the pressure regulation were working well,
> the secondary stress-ng jobs would run serially and take N*Timeout to=20
> be done.
>
> Of course, on a loaded system such as the YP autobuilders, this would=20
> take even longer
> but should never take < N*Timeout seconds.
>
> While this sounds like a good test to me (and kind of fun!), we should=20
> remind ourselfs
> that the larger task is to get make/ninja/cargo/etc to use a job pool=20
> per bitbake instance
> and/or patch them to read PSI info.
>
> We'd still have the congestion onset/abatement problem with those=20
> tools though
> so the problem is worth figuring out.
>
> For now, I'd need to see the before and after times an buildstats for=20
> a build of say core-image-minimal
> and/or poky world on a system that runs at 100% capacity for a good=20
> part of the build without PSI
> regulation.
>
> Data below. Sorry, I don't have time to analyze or graph it.
>
>
> ../Randy
>
>> Signed-off-by: Chen Qi<Qi.Chen@windriver.com>
>> ---
>>   bitbake/lib/bb/runqueue.py | 33 ++++++++++++++++++---------------
>>   1 file changed, 18 insertions(+), 15 deletions(-)
>>
>> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
>> index 48788f4aa6..7c482a55f3 100644
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
>> @@ -191,6 +192,14 @@ class RunQueueScheduler(object):
>>           BB_PRESSURE_MAX_{CPU|IO|MEMORY} are set, return True if abov=
e threshold.
>>           """
>>           if self.check_pressure:
>> +            now =3D time.time()
>> +            tdiff =3D now - self.prev_pressure_time
>> +            # If task spawning has been blocked, block it for at leas=
t 1s;
>> +            # otherwise, check the pressure ASAP. This is because if =
tdiff is very small
>> +            # the result of (curr_xxx_pressure - prev_xxx_pressure) m=
ight be 0, resulting
>> +            # in any small value not having effect.
>> +            if self.psi_exceeded and tdiff < 1.0:
>> +                return self.psi_exceeded
>>               with open("/proc/pressure/cpu") as cpu_pressure_fds, \
>>                   open("/proc/pressure/io") as io_pressure_fds, \
>>                   open("/proc/pressure/memory") as memory_pressure_fds=
:
>> @@ -198,25 +207,19 @@ class RunQueueScheduler(object):
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
>>               pressure_state =3D (exceeds_cpu_pressure, exceeds_io_pre=
ssure, exceeds_memory_pressure)
>>               if hasattr(self, "pressure_state") and pressure_state !=3D=
 self.pressure_state:
>>                   bb.note("Pressure status changed to CPU: %s, IO: %s,=
 Mem: %s" % pressure_state)
>>               self.pressure_state =3D pressure_state
>> -            return (exceeds_cpu_pressure or exceeds_io_pressure or ex=
ceeds_memory_pressure)
>> +            return self.psi_exceeded
>>           return False
>>  =20
>>       def next_buildable_task(self):
>
>
> 1)
>
> =C2=A0$ rg "2023|some" /tmp/cpu
> 1:2023-08-03 21:29:06.026561191
> 2:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 4:2023-08-03 21:29:06.031553426
> 5:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 7:2023-08-03 21:29:06.035901497
> 8:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 10:2023-08-03 21:29:06.040136284
> 11:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 13:2023-08-03 21:29:06.043794493
> 14:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 16:2023-08-03 21:29:06.047555871
> 17:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 19:2023-08-03 21:29:06.051353279
> 20:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 22:2023-08-03 21:29:06.055225669
> 23:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 25:2023-08-03 21:29:06.059436263
> 26:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 28:2023-08-03 21:29:06.063509822
> 29:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 31:2023-08-03 21:29:06.067917089
> 32:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 34:2023-08-03 21:29:06.071907717
> 35:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 37:2023-08-03 21:29:06.075865773
> 38:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 40:2023-08-03 21:29:06.079846668
> 41:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 43:2023-08-03 21:29:06.083961331
> 44:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 46:2023-08-03 21:29:06.087959027
> 47:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 49:2023-08-03 21:29:06.091544025
> 50:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 52:2023-08-03 21:29:06.095441172
> 53:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 55:2023-08-03 21:29:06.099397076
> 56:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 58:2023-08-03 21:29:06.103036659
> 59:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 61:2023-08-03 21:29:06.106987290
> 62:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 64:2023-08-03 21:29:06.110500839
> 65:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 67:2023-08-03 21:29:06.113993363
> 68:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 70:2023-08-03 21:29:06.117569797
> 71:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 73:2023-08-03 21:29:06.121977963
> 74:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 76:2023-08-03 21:29:06.125929934
> 77:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 79:2023-08-03 21:29:06.130064807
> 80:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 82:2023-08-03 21:29:06.134026786
> 83:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 85:2023-08-03 21:29:06.137735375
> 86:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 88:2023-08-03 21:29:06.141781398
> 89:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 91:2023-08-03 21:29:06.145287007
> 92:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 94:2023-08-03 21:29:06.149168307
> 95:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 97:2023-08-03 21:29:06.152818060
> 98:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 100:2023-08-03 21:29:06.156414605
> 101:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 103:2023-08-03 21:29:06.160560201
> 104:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 106:2023-08-03 21:29:06.164730602
> 107:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 109:2023-08-03 21:29:06.168689146
> 110:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 112:2023-08-03 21:29:06.172659034
> 113:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 115:2023-08-03 21:29:06.176217293
> 116:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 118:2023-08-03 21:29:06.179786393
> 119:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 121:2023-08-03 21:29:06.183386966
> 122:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 124:2023-08-03 21:29:06.186901117
> 125:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 127:2023-08-03 21:29:06.191092359
> 128:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 130:2023-08-03 21:29:06.194689321
> 131:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 133:2023-08-03 21:29:06.198680598
> 134:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 136:2023-08-03 21:29:06.202466314
> 137:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 139:2023-08-03 21:29:06.206159217
> 140:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 142:2023-08-03 21:29:06.210732253
> 143:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 145:2023-08-03 21:29:06.214495861
> 146:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 148:2023-08-03 21:29:06.218378986
> 149:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 151:2023-08-03 21:29:06.222715102
> 152:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 154:2023-08-03 21:29:06.226811631
> 155:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 157:2023-08-03 21:29:06.231578359
> 158:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 160:2023-08-03 21:29:06.235715687
> 161:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 163:2023-08-03 21:29:06.239569685
> 164:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 166:2023-08-03 21:29:06.243630675
> 167:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 169:2023-08-03 21:29:06.247567397
> 170:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 172:2023-08-03 21:29:06.251397908
> 173:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 175:2023-08-03 21:29:06.255011706
> 176:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 178:2023-08-03 21:29:06.258932029
> 179:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 181:2023-08-03 21:29:06.262697913
> 182:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 184:2023-08-03 21:29:06.266799173
> 185:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 187:2023-08-03 21:29:06.270925022
> 188:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 190:2023-08-03 21:29:06.275043244
> 191:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 193:2023-08-03 21:29:06.278632334
> 194:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 196:2023-08-03 21:29:06.282248451
> 197:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 199:2023-08-03 21:29:06.285993782
> 200:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 202:2023-08-03 21:29:06.290307906
> 203:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 205:2023-08-03 21:29:06.294324211
> 206:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 208:2023-08-03 21:29:06.298434915
> 209:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 211:2023-08-03 21:29:06.302588527
> 212:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 214:2023-08-03 21:29:06.306381068
> 215:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 217:2023-08-03 21:29:06.310380335
> 218:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 220:2023-08-03 21:29:06.315066360
> 221:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 223:2023-08-03 21:29:06.319399493
> 224:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 226:2023-08-03 21:29:06.323533769
> 227:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 229:2023-08-03 21:29:06.327623574
> 230:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 232:2023-08-03 21:29:06.331404094
> 233:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 235:2023-08-03 21:29:06.335282298
> 236:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 238:2023-08-03 21:29:06.339218007
> 239:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 241:2023-08-03 21:29:06.343022226
> 242:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 244:2023-08-03 21:29:06.346892658
> 245:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 247:2023-08-03 21:29:06.350737213
> 248:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 250:2023-08-03 21:29:06.354365299
> 251:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 253:2023-08-03 21:29:06.358504205
> 254:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 256:2023-08-03 21:29:06.362474648
> 257:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 259:2023-08-03 21:29:06.366500614
> 260:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 262:2023-08-03 21:29:06.370409578
> 263:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 265:2023-08-03 21:29:06.374728115
> 266:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 268:2023-08-03 21:29:06.379177687
> 269:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 271:2023-08-03 21:29:06.382958096
> 272:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 274:2023-08-03 21:29:06.386287192
> 275:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 277:2023-08-03 21:29:06.390148390
> 278:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 280:2023-08-03 21:29:06.393995408
> 281:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 283:2023-08-03 21:29:06.397538386
> 284:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 286:2023-08-03 21:29:06.401522567
> 287:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 289:2023-08-03 21:29:06.405142382
> 290:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 292:2023-08-03 21:29:06.408883272
> 293:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 295:2023-08-03 21:29:06.412675078
> 296:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 298:2023-08-03 21:29:06.416350916
> 299:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
> 301:2023-08-03 21:30:02.078140466
> 302:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696853256
> 304:2023-08-03 21:30:02.107326758
> 305:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696855634
> 307:2023-08-03 21:30:02.126028647
> 308:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696856111
> 310:2023-08-03 21:30:02.146028343
> 311:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696858681
> 313:2023-08-03 21:30:02.170021779
> 314:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696861693
> 316:2023-08-03 21:30:02.210054311
> 317:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696865034
> 319:2023-08-03 21:30:02.246006375
> 320:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696867390
> 322:2023-08-03 21:30:02.274025123
> 323:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696870090
> 325:2023-08-03 21:30:02.306023178
> 326:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696873121
> 328:2023-08-03 21:30:02.342042024
> 329:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696876150
> 331:2023-08-03 21:30:02.374045594
> 332:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696878182
> 334:2023-08-03 21:30:02.398024941
> 335:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696880542
> 337:2023-08-03 21:30:02.430025787
> 338:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696884229
> 340:2023-08-03 21:30:02.474025766
> 341:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696886618
> 343:2023-08-03 21:30:02.506036609
> 344:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696889650
> 346:2023-08-03 21:30:02.538005211
> 347:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696892350
> 349:2023-08-03 21:30:02.570002594
> 350:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696895386
> 352:2023-08-03 21:30:02.602024574
> 353:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696897412
> 355:2023-08-03 21:30:02.626006000
> 356:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696899777
> 358:2023-08-03 21:30:02.654031808
> 359:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696901808
> 361:2023-08-03 21:30:02.686002144
> 362:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696904511
> 364:2023-08-03 21:30:02.718074747
> 365:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696908199
> 367:2023-08-03 21:30:02.754015511
> 368:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696910921
> 370:2023-08-03 21:30:02.786022272
> 371:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696913625
> 373:2023-08-03 21:30:02.818041167
> 374:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696916321
> 376:2023-08-03 21:30:02.858023387
> 377:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696919750
> 379:2023-08-03 21:30:02.894034643
> 380:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696922454
> 382:2023-08-03 21:30:02.926147057
> 383:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696925319
> 385:2023-08-03 21:30:02.954068342
> 386:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696927350
> 388:2023-08-03 21:30:02.986088254
> 389:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696930380
> 391:2023-08-03 21:30:03.018103409
> 392:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696933078
> 394:2023-08-03 21:30:03.050077392
> 395:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696935445
> 397:2023-08-03 21:30:03.074114392
> 398:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696938795
> 400:2023-08-03 21:30:03.114035084
> 401:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696940845
> 403:2023-08-03 21:30:03.142015391
> 404:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696943542
> 406:2023-08-03 21:30:03.174031239
> 407:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696946247
> 409:2023-08-03 21:30:03.210113551
> 410:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696949897
> 412:2023-08-03 21:30:03.242035265
> 413:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696952261
> 415:2023-08-03 21:30:03.274046961
> 416:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696954940
> 418:2023-08-03 21:30:03.306028723
> 419:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696957656
> 421:2023-08-03 21:30:03.338077555
> 422:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696960686
> 424:2023-08-03 21:30:03.374073915
> 425:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696963050
> 427:2023-08-03 21:30:03.402047343
> 428:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696966086
> 430:2023-08-03 21:30:03.434032881
> 431:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696968788
> 433:2023-08-03 21:30:03.466032340
> 434:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696970813
> 436:2023-08-03 21:30:03.494068821
> 437:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696973176
> 439:2023-08-03 21:30:03.522161212
> 440:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696975872
> 442:2023-08-03 21:30:03.554050153
> 443:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696978574
> 445:2023-08-03 21:30:03.586065001
> 446:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696980938
> 448:2023-08-03 21:30:03.614119644
> 449:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696983300
> 451:2023-08-03 21:30:03.638144992
> 452:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696986016
> 454:2023-08-03 21:30:03.674118268
> 455:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696988717
> 457:2023-08-03 21:30:03.710118733
> 458:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38696991745
> 460:2023-08-03 21:30:03.738066832
> 461:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38696994115
> 463:2023-08-03 21:30:03.770048303
> 464:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38696996451
> 466:2023-08-03 21:30:03.802092382
> 467:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38696999169
> 469:2023-08-03 21:30:03.826077226
> 470:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697001198
> 472:2023-08-03 21:30:03.858062788
> 473:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697003903
> 475:2023-08-03 21:30:03.890062930
> 476:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697006941
> 478:2023-08-03 21:30:03.922067512
> 479:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697009971
> 481:2023-08-03 21:30:03.958084669
> 482:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697013322
> 484:2023-08-03 21:30:03.994120043
> 485:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697015378
> 487:2023-08-03 21:30:04.018108794
> 488:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697017409
> 490:2023-08-03 21:30:04.042115598
> 491:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697019438
> 493:2023-08-03 21:30:04.066126937
> 494:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697021470
> 496:2023-08-03 21:30:04.090050277
> 497:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697023835
> 499:2023-08-03 21:30:04.122078760
> 500:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697026530
> 502:2023-08-03 21:30:04.158044418
> 503:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697029229
> 505:2023-08-03 21:30:04.186092879
> 506:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697032540
> 508:2023-08-03 21:30:04.233761652
> 509:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697035931
> 511:2023-08-03 21:30:04.262027484
> 512:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697038637
> 514:2023-08-03 21:30:04.294022638
> 515:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697041335
> 517:2023-08-03 21:30:04.322028009
> 518:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697044038
> 520:2023-08-03 21:30:04.354034481
> 521:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697046391
> 523:2023-08-03 21:30:04.386023486
> 524:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697048757
> 526:2023-08-03 21:30:04.414022848
> 527:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697051459
> 529:2023-08-03 21:30:04.442017832
> 530:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697053484
> 532:2023-08-03 21:30:04.466027364
> 533:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697056162
> 535:2023-08-03 21:30:04.502021088
> 536:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697058883
> 538:2023-08-03 21:30:04.534039153
> 539:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697061578
> 541:2023-08-03 21:30:04.566039103
> 542:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697063939
> 544:2023-08-03 21:30:04.598037462
> 545:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697066641
> 547:2023-08-03 21:30:04.629771191
> 548:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697070011
> 550:2023-08-03 21:30:04.666042007
> 551:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697072371
> 553:2023-08-03 21:30:04.698010368
> 554:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697075069
> 556:2023-08-03 21:30:04.722019998
> 557:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697077770
> 559:2023-08-03 21:30:04.762030636
> 560:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697080474
> 562:2023-08-03 21:30:04.786010720
> 563:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697083181
> 565:2023-08-03 21:30:04.818035029
> 566:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697085877
> 568:2023-08-03 21:30:04.854034446
> 569:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697088575
> 571:2023-08-03 21:30:04.882043053
> 572:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697091289
> 574:2023-08-03 21:30:04.922081980
> 575:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697093316
> 577:2023-08-03 21:30:04.927564632
> 578:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697094670
> 580:2023-08-03 21:30:04.962026471
> 581:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697097373
> 583:2023-08-03 21:30:04.990040191
> 584:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697099739
> 586:2023-08-03 21:30:05.014033886
> 587:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697101764
> 589:2023-08-03 21:30:05.039750750
> 590:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697104463
> 592:2023-08-03 21:30:05.074019117
> 593:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697106610
> 595:2023-08-03 21:30:05.110046072
> 596:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697109855
> 598:2023-08-03 21:30:05.138046014
> 599:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697112555
> 601:2023-08-03 21:30:05.166023497
> 602:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697115232
> 604:2023-08-03 21:30:05.206061564
> 605:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697118239
> 607:2023-08-03 21:30:05.238018646
> 608:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697120933
> 610:2023-08-03 21:30:05.270026372
> 611:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697123957
> 613:2023-08-03 21:30:05.302027288
> 614:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697126663
> 616:2023-08-03 21:30:05.334040250
> 617:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697129338
> 619:2023-08-03 21:30:05.360190632
> 620:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697131047
> 622:2023-08-03 21:30:05.390029162
> 623:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697133747
> 625:2023-08-03 21:30:05.414034794
> 626:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697135782
> 628:2023-08-03 21:30:05.427642722
> 629:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697137467
> 631:2023-08-03 21:30:05.458016115
> 632:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697139828
> 634:2023-08-03 21:30:05.486030455
> 635:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697142173
> 637:2023-08-03 21:30:05.514016836
> 638:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697144890
> 640:2023-08-03 21:30:05.546024372
> 641:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697147583
> 643:2023-08-03 21:30:05.584237211
> 644:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697150280
> 646:2023-08-03 21:30:05.614025918
> 647:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697152856
> 649:2023-08-03 21:30:05.646014419
> 650:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697155334
> 652:2023-08-03 21:30:05.670042958
> 653:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697157696
> 655:2023-08-03 21:30:05.706027504
> 656:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697160413
> 658:2023-08-03 21:30:05.730024921
> 659:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697163116
> 661:2023-08-03 21:30:05.770026829
> 662:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697165892
> 664:2023-08-03 21:30:05.806011996
> 665:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697168589
> 667:2023-08-03 21:30:05.830011568
> 668:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697171305
> 670:2023-08-03 21:30:05.862039144
> 671:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697173671
> 673:2023-08-03 21:30:05.898008773
> 674:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697177020
> 676:2023-08-03 21:30:05.933796165
> 677:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697179742
> 679:2023-08-03 21:30:05.970058151
> 680:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697182438
> 682:2023-08-03 21:30:05.994037819
> 683:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697184468
> 685:2023-08-03 21:30:06.026022629
> 686:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697187165
> 688:2023-08-03 21:30:06.050024626
> 689:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697189526
> 691:2023-08-03 21:30:06.078013808
> 692:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697192230
> 694:2023-08-03 21:30:06.114030646
> 695:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697194603
> 697:2023-08-03 21:30:06.142038629
> 698:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697197296
> 700:2023-08-03 21:30:06.170044171
> 701:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697199658
> 703:2023-08-03 21:30:06.205670334
> 704:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697202692
> 706:2023-08-03 21:30:06.238037490
> 707:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697206060
> 709:2023-08-03 21:30:06.270024332
> 710:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697208087
> 712:2023-08-03 21:30:06.301784118
> 713:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697211461
> 715:2023-08-03 21:30:06.342039416
> 716:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697214160
> 718:2023-08-03 21:30:06.374013677
> 719:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697216861
> 721:2023-08-03 21:30:06.406040803
> 722:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697219559
> 724:2023-08-03 21:30:06.438006057
> 725:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697222256
> 727:2023-08-03 21:30:06.470026240
> 728:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697225629
> 730:2023-08-03 21:30:06.502024527
> 731:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697228305
> 733:2023-08-03 21:30:06.538033228
> 734:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697230686
> 736:2023-08-03 21:30:06.566028157
> 737:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697233689
> 739:2023-08-03 21:30:06.602025064
> 740:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697236080
> 742:2023-08-03 21:30:06.630027618
> 743:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697238780
> 745:2023-08-03 21:30:06.662010496
> 746:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697241478
> 748:2023-08-03 21:30:06.690014164
> 749:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697243510
> 751:2023-08-03 21:30:06.714031649
> 752:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697246207
> 754:2023-08-03 21:30:06.750026276
> 755:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697248907
> 757:2023-08-03 21:30:06.786014937
> 758:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697251609
> 760:2023-08-03 21:30:06.818017495
> 761:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697254643
> 763:2023-08-03 21:30:06.846013970
> 764:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697256667
> 766:2023-08-03 21:30:06.878168821
> 767:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697259367
> 769:2023-08-03 21:30:06.902022147
> 770:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697262083
> 772:2023-08-03 21:30:06.937999183
> 773:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697264777
> 775:2023-08-03 21:30:06.970022469
> 776:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697267479
> 778:2023-08-03 21:30:07.006018171
> 779:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697270171
> 781:2023-08-03 21:30:07.030035755
> 782:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697272873
> 784:2023-08-03 21:30:07.070024602
> 785:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697275913
> 787:2023-08-03 21:30:07.098024161
> 788:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697277932
> 790:2023-08-03 21:30:07.126038057
> 791:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697280293
> 793:2023-08-03 21:30:07.150014689
> 794:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697282324
> 796:2023-08-03 21:30:07.174011609
> 797:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697284688
> 799:2023-08-03 21:30:07.206006119
> 800:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697287664
> 802:2023-08-03 21:30:07.242013736
> 803:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697290389
> 805:2023-08-03 21:30:07.273763791
> 806:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697293757
> 808:2023-08-03 21:30:07.306027619
> 809:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697296435
> 811:2023-08-03 21:30:07.338033801
> 812:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697299155
> 814:2023-08-03 21:30:07.370014272
> 815:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697301335
> 817:2023-08-03 21:30:07.398049887
> 818:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697303375
> 820:2023-08-03 21:30:07.426030463
> 821:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306238
> 823:2023-08-03 21:30:07.446012112
> 824:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 826:2023-08-03 21:30:07.449074039
> 827:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 829:2023-08-03 21:30:07.452094902
> 830:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 832:2023-08-03 21:30:07.455132499
> 833:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 835:2023-08-03 21:30:07.458158709
> 836:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 838:2023-08-03 21:30:07.461160555
> 839:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 841:2023-08-03 21:30:07.464164844
> 842:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 844:2023-08-03 21:30:07.467191143
> 845:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 847:2023-08-03 21:30:07.470249391
> 848:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 850:2023-08-03 21:30:07.473268040
> 851:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 853:2023-08-03 21:30:07.476260894
> 854:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 856:2023-08-03 21:30:07.479273385
> 857:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 859:2023-08-03 21:30:07.482341558
> 860:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 862:2023-08-03 21:30:07.485402936
> 863:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 865:2023-08-03 21:30:07.488621116
> 866:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 868:2023-08-03 21:30:07.491648106
> 869:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 871:2023-08-03 21:30:07.494712160
> 872:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 874:2023-08-03 21:30:07.497741518
> 875:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 877:2023-08-03 21:30:07.500731815
> 878:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 880:2023-08-03 21:30:07.503757142
> 881:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 883:2023-08-03 21:30:07.506830439
> 884:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 886:2023-08-03 21:30:07.509933769
> 887:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 889:2023-08-03 21:30:07.512924245
> 890:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 892:2023-08-03 21:30:07.515952487
> 893:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 895:2023-08-03 21:30:07.519039796
> 896:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
> 898:2023-08-03 21:30:07.522058287
> 899:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
>
> --=20
> # Randy MacLeod
> # Wind River Linux



