Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F51C00528
	for <webhook@archiver.kernel.org>; Sat,  5 Aug 2023 17:30:22 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.10147.1691256613219495400
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 05 Aug 2023 10:30:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=jj2mOpgm;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75815f92e7=randy.macleod@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 375HLCfP027168
	for <bitbake-devel@lists.openembedded.org>; Sat, 5 Aug 2023 17:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-type:message-id:date:subject:to:references:from
	:in-reply-to:mime-version; s=PPS06212021; bh=/HIjoL7Y/HeEhF5I0Cy
	KsS0XIjk7igTKp5RrvnLYW6Q=; b=jj2mOpgmO/WGIQXLfeSqcLWrnX6ZS8nzqcV
	vIjUUvLF21QfOn0/truPienylJxoCkpMnUfdgMjC8TN2IfuqnuVAUdEtd6zhPcfs
	OooJn/gX6+qCHvP5kRI6AFG9/Y2ZS7YA1qCstd5htoAQLkd/mi/FY+N8S2adZVVm
	BR4ojhrSja+0dAdMojtqbIY97nHqvfpOcxEZX6zzeFPjT1Q1zxvcMW54hFhITHsO
	hVxt4UlbpSJ/WsCb2hVybC0/NnUBT2gH+J/AaqguP1RQ0gbIXm3j/hhX9dfaRyFl
	qWpt5HEXlz+UJ4Z4W3jZW8/lR2a5jsqVOXKs+0rF+3um0ccJyAQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s9dd60e2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sat, 05 Aug 2023 17:30:10 +0000 (GMT)
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.22/8.17.1.22) with ESMTP id 375HUArw006545
	for <bitbake-devel@lists.openembedded.org>; Sat, 5 Aug 2023 17:30:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s9dd60e2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Aug 2023 17:30:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwfN58/FkQZWoHuic40W89ZKqZQ1OZNTIaKSDevGN9QyxD25CmtKdK2xnMk09dyOwOV7r/Faun6Rofdj7tCgL/87HQXTV6F4VK/2VBpHmPpc80mK6ryA/kLgG9jji4VrtgPuDVYNbt23zdrb8i2qc7OTtqSd8Sj+j25/upFJLMeo3E38DfPhrOlmbWTz74qQtA4y1t9jqOGUr4xxPsvVhQWaQw1hOt3EcZAhHXTh4pxGWk1PModafbbB7b2trdmsVwTLhMloz9qBlxkXKlk7OCBSuqYvVBuEDh5/AabjgzspXyk88pDJt1WKqQ1qd+EXnVOt3ztHBgeosTFlM2NNbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HIjoL7Y/HeEhF5I0CyKsS0XIjk7igTKp5RrvnLYW6Q=;
 b=Swe1X5gpbWH/q1iUsz1QmTD+KqeNS8n1G/UHgBuw/stV1li0VkrW84msv3FyKaCzMFoFO5UO3g4XkLnaMqA8OKDaA+1VMw89g5t72ZIkRSHBhM5RjN/B3CecDryPOT5jsLsdDsEoFnG6+jkH+ZGiEJBrevFvoJ519AjCt3I/IF82me5ACLSxVhBI9YM/nSLasAIbTIpkDt1xwId/c6LHSQDpxOr+Zh9DNfB+xHziUIKocGHPRythUzNIZIBaPcO4DVgu/qH+SEYqxQKTV9aKtNNuV1f14e2lLClqqAFsidqyTeEKGN3fAbQrQUdesXhAC76L7NQi6rFTRqgGC0V7jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB3994.namprd11.prod.outlook.com (2603:10b6:5:193::19)
 by PH8PR11MB7045.namprd11.prod.outlook.com (2603:10b6:510:217::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Sat, 5 Aug
 2023 17:30:03 +0000
Received: from DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::144:140c:a640:f799]) by DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::144:140c:a640:f799%7]) with mapi id 15.20.6652.025; Sat, 5 Aug 2023
 17:30:02 +0000
Content-Type: multipart/alternative;
 boundary="------------kT0z2k0lDpWSVs7Qh2LTBFdI"
Message-ID: <ac05a465-6da7-3441-b45d-ab65c73f244d@windriver.com>
Date: Sat, 5 Aug 2023 13:29:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [bitbake-devel][PATCH V4] runqueue.py: fix PSI check logic
Content-Language: en-CA
To: Qi.Chen@windriver.com, bitbake-devel@lists.openembedded.org,
        Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20230803075638.2355913-1-Qi.Chen@windriver.com>
From: Randy MacLeod <randy.macleod@windriver.com>
In-Reply-To: <20230803075638.2355913-1-Qi.Chen@windriver.com>
X-ClientProxiedBy: SJ0PR05CA0154.namprd05.prod.outlook.com
 (2603:10b6:a03:339::9) To DM6PR11MB3994.namprd11.prod.outlook.com
 (2603:10b6:5:193::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3994:EE_|PH8PR11MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f43a369-31c2-48cb-b35c-08db95d99994
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	i6Fn738QfMg7aI8DzB7R2lSQ0cwd/kjp1foBPsUiOHBzqO6b4H+ehCPOOJxZB9kigp7WQ6IZP9JWk//0Hq7P6HGToWD8XBK8n/cudufyzzo7x/XL71zOY0N0hTlTlDwpeCl7xHLEzl0U8ZZkMhiA6clyJSQu83U5uWaBF34b4usm5SytD6vPbu+CMXZfrjSBpgCO75tO1F1CKT5Mz4Jn51HQvjxNQiVV1289YB3tLU3NoprISX7DMfo1QojHdHLcqCqCTHpR5SKzbOJZmjoWeZ9ydZe4PTlRV5OyKgjIvwFMy6CEfQjhBApdiUPqZ9u53J6OwSv74tcJsWCES8NRx86jDaDsMhEwAVpbQeQ6CiKcAx6CuAqi5A1svuF3YLBZWhYYpYG4FSTYGGD4/YmiyLL9G+eN+kUBzUGJSulkgbDjOss4rvDF9y+Drdgd8Xo44fp1eJ4pOxYzgXjl70Nxet5wPHuL9r1DSXpHI8mpdxnuXg3Io4OUh0LlLdfCne6AnWcoe5UFreGDTY2txRH6sutd85CRwsm1q37dbgfljpVXOHtI+JcEz1ytIT6Kke4A2/ygGuFhhDP+TOWDJKArSeCloSU9cQjPnpFLlixWwoYzHxyWPyZ+vTdsDLOrtYKhF2mp6Nbg5T8qL1cINmcrefNCKi+aLzIZtKA2+UpKd+0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3994.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(39840400004)(136003)(376002)(1800799003)(186006)(451199021)(8676002)(30864003)(8936002)(478600001)(36756003)(45080400002)(26005)(31696002)(6512007)(86362001)(6486002)(33964004)(6666004)(31686004)(316002)(41300700001)(5660300002)(66476007)(66556008)(66946007)(6916009)(83380400001)(2906002)(2616005)(38100700002)(6506007)(53546011)(21314003)(45980500001)(43740500002)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WDgrZkRUVEw4N3E1U3VkdkxFQ1RxWlR1ektKL2NUa0p3eGxqSUJPdDVDbXJq?=
 =?utf-8?B?VDV4a0VLRkxDcnZPSHRpSnNSU0RMOGE1Nmo4K3FpdFprbVN3Z3J2VU1oQmVH?=
 =?utf-8?B?NDd5WTM1YVRmbHlYR0hGVFBhblRKbmw0VXBTd29PQkM2elk4cjF1ZjZTd2w0?=
 =?utf-8?B?QmdTMTh0Q0U3MHoxQmErWDJic20vVlFxWGZ4YWdXR1pkaUpmM3lOSllYM0xz?=
 =?utf-8?B?SnZSZ2dMK29wZGtlTFlwUk1mWHROcysvTjl6Ri9OWm9OazZ2azcwV0g3NDJt?=
 =?utf-8?B?ZnUvcHJZSnVPK2I5QUdGemFQUEJSVmIyeWxncFFBeEpDRm4vQ0JDeE8zVHpl?=
 =?utf-8?B?ZDczUytobEEvUjI0dWRHWkYwYkV1THo1aWN5enZ4K3JVM01pNTFTTFVCUmtZ?=
 =?utf-8?B?VlhlYXFSVDlzYkdmUFNOMk9GKzFEbS9VSTBxMHRFbExUS3ArWUlMU1BsUlFv?=
 =?utf-8?B?NVpnTnJDTStsSTN5WnBMV3JqSEZvVjRvdENjVEs2RW9mSUJIWFNJWU9xVXgv?=
 =?utf-8?B?NzJqL2l1NllqVDAyR001c3o5ZmwzeXA0YkZVSkRrTmo4eStYVUwySHFBYlQz?=
 =?utf-8?B?SzhML3k3cG5pUTVhc1Q0L1dZckhiUitycno0TisrTDJ6eTlPdG83eGlUencr?=
 =?utf-8?B?MzFzRXdZS1ZhVXJTSXlrLzk2NkgycmdQdWt2eUFaWmNoZ0FNc2ZGZjVFaEFT?=
 =?utf-8?B?Y0hUUG9Tb3JhSnYzdVA2Tmw4MmdQODVxQ1d0dnRMeUM2aFVMRW5JekVoYTNk?=
 =?utf-8?B?NTAwSHBCV1JKNFRzbVRsdFpDNEJJSzJUR1VEV0FxU01ySmdqSktMTXo3UlVB?=
 =?utf-8?B?b29Bb0Q4SHZLTXNLUjZoNi9kUHYrYkV2MG9jRDR2bnBFZ0lrZjVGV3I3L09P?=
 =?utf-8?B?RVk5Y3o3N29iUnV3YUEzNGh0OU5kODYxTlFtSGFndjNoN0NhNDJuaTd0QXV6?=
 =?utf-8?B?WUpCVm9uaWg1VW5yWVJUbWl1b1dwbWhKTlFXeTltQWF0RGx4M0FXclhlUjNY?=
 =?utf-8?B?ZkhvN25kQ09iT09QNmNBTDkxVVdUTzQ4RVhPeDFsQ2ovRm1oc1VmVDl1UkhR?=
 =?utf-8?B?aGd0enNFb3pxcEFsZ0wxcy9BUFVEYmhheXY0T2Y5V3VueHpEcDhydWt2cHor?=
 =?utf-8?B?bmJmeFZmOC90OFNxVHlnMXp4T3A1V0p6dUdzVys2QTVJODhXTWxXSjNGVlgx?=
 =?utf-8?B?NTl1bndha2YvSWsvWHZYZHMxQXNMc0F2RXExaDhhS3RhTzNDcmtaUmxuVmFk?=
 =?utf-8?B?NERNUDZ0dk42Z1NhZm9yZ3hHZmpib3RtQ0hNc2dQcnJvMDR6Rk4wKzh4elFj?=
 =?utf-8?B?ZDc0UXozdTlTK05xeE5QdEkzbWpoYU50TUhQV1hjWkVLa1ExV0VtU2haS1NJ?=
 =?utf-8?B?aTg0NnozdUFNYWEyTnR2TkcvQ0U0eG1uSmdhYjdoVXg2TGF1cFVJaHorVHI3?=
 =?utf-8?B?SzRjbURwOXlrVjVnT0NxSlcxVVdZZ1pueGVHM1hnOThYQWNqYUdpSWUwWG8x?=
 =?utf-8?B?S2VJVmhONmNmM2dYdnRRVWU0MFF1TlI2Z3pzTXVWODR6TzFncnV4RmxoYURR?=
 =?utf-8?B?Zytwc1NPWUwzKzB3dlRLcmhEQ3cvVlFSUTFRT00vVGFnQ21uajFMb1IvbG41?=
 =?utf-8?B?NVg3RmxsaGNrQ3V2VFF4OGQ0U0pCSVhncTlJRHZDYUthYklEamdwQ1AvNGVU?=
 =?utf-8?B?S3lEVkFQeHh3ZE1ORGhKRlUwNjNJaHZnTHg0OFZ0dDJaNFJGYmNsQWhPeHV6?=
 =?utf-8?B?cjVhMHVaZ3BtUlVFUGc2cHhpYlcwWnFxdDdXOEliM0YrQVZrS0lYVlhuSVRU?=
 =?utf-8?B?VzVWRGxLMVIydGJrZ2xBTWt5ZWlkQXhNcXhKcFlwV0Y2QW8wQ2h0cW5Lcno2?=
 =?utf-8?B?dm5kRm13Z0JmcUVLbHppenVZUVhlVTljM2gxRlcwL2FiYmYvNnFYK28yek9W?=
 =?utf-8?B?YjYrVUpoQ1NZZHMyK1FRa2kveDRFdmhyTHo3QmNTTU9xRENvb1lpVElSd3FQ?=
 =?utf-8?B?bXBxV1ExS3BRdklVUmZ1ME8vd2RYTUVaUHl1a0JkMHpJSW5VMTRtWnh2LzNT?=
 =?utf-8?B?SFJTZDg2SnZIaHR3VEJqVW56UUV0RHNOU29XZ2FiODduY0FJVTBQWWZZTVFV?=
 =?utf-8?B?VGkrV3d0WG5ZcDhvV0dscng5ZXRLdUV0cVZmdm92NTdaNjAwZTB2cFFKMXpX?=
 =?utf-8?B?dVE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f43a369-31c2-48cb-b35c-08db95d99994
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3994.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2023 17:30:02.6488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/p/hg8yb3On8wpYwLYV0E9e6StDc3F1/b9I+RKGME+/PAOfdwpiHZ9Qv3Hk5nfboPTNtcd3/iwkwoT7Of9eKmK8gFDz3fmOjt9z4gGVgUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7045
X-Proofpoint-GUID: KtA4oks1zCVqV-R9VxtNanBFl3d-Y2-K
X-Proofpoint-ORIG-GUID: kiv_Pj4RbWBzRNXHJMXHwEl7LlEwSx6f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-05_17,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 adultscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308050165
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 05 Aug 2023 17:30:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14918

--------------kT0z2k0lDpWSVs7Qh2LTBFdI
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 375HLCfP027168

On 2023-08-03 03:56, Qi.Chen@windriver.com wrote:
> From: Chen Qi<Qi.Chen@windriver.com>
>
> The current logic is not correct because if the time interval
> between the current check and the last check is very small, the PSI
> checker is not likely to block things even if the system is heavy
> loaded.
Agreed, there is a problem but we do have to be careful to not
a make things too slow since the goal is to have maximum throughput
without having too much congestion and cpu scheduling and IO latency.
> In fact, if the time interval is very small, the result
> might be 0, resulting in any small value not having any effect.
Yes, the PSI variable are implemented as per cpu vars and
you can get the same result several times in a row, even when

there is lots of CPU pressure. Eg:

$ stress -c 25 -t 100 &
[1] 3851144
stress: info: [3851144] dispatching hogs: 25 cpu, 0 io, 0 vm, 0 hdd
$ for i in `seq 200`; do date +"%Y-%m-%d %H:%M:%S.%N" >> /tmp/cpu; cat=20
/proc/pressure/cpu >> /tmp/cpu ; done
$ less /tmp/cpu

See (1) below.

I need to look at the PSI averaging algorithm again!


>
> To reproduce the current problem, set BB_PRESSURE_MAX_CPU/IO/MEMORY
> to "1", and start a build. We can see there's more than one tasks
> running throughout the whole build process.
>
> This patch improves things a little bit. It will block task spawning
> for at least 1s if the limits are exceeded, this is to overcome the
> 0 result issue. On the other hand, if the task spawning is not
> blocked, we check the pressure every time.
>
> However, even with this fix, we still have the task spawning peek issue.
> Because at some point, when the load is low enough, a few tasks will
> be spawned altogether.
>
> In summary, this patch improves the situation, but the peek task
> spawning peek issue is still there.
Richard and I were talking about this and he suggested
that we take a different approach of changing from a binary
approach to one where if we're close (say withing 10%) of the threshold,
we tell the bitbake scheduler:

 =C2=A0" Things don't look good, can you ask me again in a little while?"


Then if the congestion abates, we allow new task and if not, then
we've avoided introducing new load as we are ramping up.
Richard claims that this "ask again in a while" is something the

scheduler already has code for.


This is essentially a smoothing algorithm, which I have little
experience. I did, as a student decades ago, try to control the=20
temperator of
a beaker of water and bring it from room temperature to a predefined goal
with minimal overshoot and reverberation! There are people with expertise
in this sort of thing, so if you are such a person, it would be good to=20
have
you appear out of the Yocto woodwork!

I think we're doing something similar to the temperature controlled beake=
r
except it's a not a fixed thermal load but rather a continuously=20
changing one.


I'm not sure if I've written this down before but I think there would
be some benefit, at least for a self-test, to have a series of stress-ng
tasks that we put into a recipe. One would bring the system up to
just below CPU (IO) congestion and keep the system in that state for a ~5=
-10
minutes. Then we'd run another N (=3D 10?), short-lived (30 s?) stress-ng=
 -c
tests all at once. If the pressure regulation were working well,
the secondary stress-ng jobs would run serially and take N*Timeout to be=20
done.

Of course, on a loaded system such as the YP autobuilders, this would=20
take even longer
but should never take < N*Timeout seconds.

While this sounds like a good test to me (and kind of fun!), we should=20
remind ourselfs
that the larger task is to get make/ninja/cargo/etc to use a job pool=20
per bitbake instance
and/or patch them to read PSI info.

We'd still have the congestion onset/abatement problem with those tools=20
though
so the problem is worth figuring out.

For now, I'd need to see the before and after times an buildstats for a=20
build of say core-image-minimal
and/or poky world on a system that runs at 100% capacity for a good part=20
of the build without PSI
regulation.

Data below. Sorry, I don't have time to analyze or graph it.


../Randy

>
> Signed-off-by: Chen Qi<Qi.Chen@windriver.com>
> ---
>   bitbake/lib/bb/runqueue.py | 33 ++++++++++++++++++---------------
>   1 file changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 48788f4aa6..7c482a55f3 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -179,6 +179,7 @@ class RunQueueScheduler(object):
>                       self.prev_memory_pressure =3D memory_pressure_fds=
.readline().split()[4].split("=3D")[1]
>                       self.prev_pressure_time =3D time.time()
>                   self.check_pressure =3D True
> +                self.psi_exceeded =3D False
>               except:
>                   bb.note("The /proc/pressure files can't be read. Cont=
inuing build without monitoring pressure")
>                   self.check_pressure =3D False
> @@ -191,6 +192,14 @@ class RunQueueScheduler(object):
>           BB_PRESSURE_MAX_{CPU|IO|MEMORY} are set, return True if above=
 threshold.
>           """
>           if self.check_pressure:
> +            now =3D time.time()
> +            tdiff =3D now - self.prev_pressure_time
> +            # If task spawning has been blocked, block it for at least=
 1s;
> +            # otherwise, check the pressure ASAP. This is because if t=
diff is very small
> +            # the result of (curr_xxx_pressure - prev_xxx_pressure) mi=
ght be 0, resulting
> +            # in any small value not having effect.
> +            if self.psi_exceeded and tdiff < 1.0:
> +                return self.psi_exceeded
>               with open("/proc/pressure/cpu") as cpu_pressure_fds, \
>                   open("/proc/pressure/io") as io_pressure_fds, \
>                   open("/proc/pressure/memory") as memory_pressure_fds:
> @@ -198,25 +207,19 @@ class RunQueueScheduler(object):
>                   curr_cpu_pressure =3D cpu_pressure_fds.readline().spl=
it()[4].split("=3D")[1]
>                   curr_io_pressure =3D io_pressure_fds.readline().split=
()[4].split("=3D")[1]
>                   curr_memory_pressure =3D memory_pressure_fds.readline=
().split()[4].split("=3D")[1]
> -                now =3D time.time()
> -                tdiff =3D now - self.prev_pressure_time
> -                if tdiff > 1.0:
> -                    exceeds_cpu_pressure =3D  self.rq.max_cpu_pressure=
 and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff >=
 self.rq.max_cpu_pressure
> -                    exceeds_io_pressure =3D  self.rq.max_io_pressure a=
nd (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff > sel=
f.rq.max_io_pressure
> -                    exceeds_memory_pressure =3D self.rq.max_memory_pre=
ssure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)=
) / tdiff > self.rq.max_memory_pressure
> -                    self.prev_cpu_pressure =3D curr_cpu_pressure
> -                    self.prev_io_pressure =3D curr_io_pressure
> -                    self.prev_memory_pressure =3D curr_memory_pressure
> -                    self.prev_pressure_time =3D now
> -                else:
> -                    exceeds_cpu_pressure =3D  self.rq.max_cpu_pressure=
 and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) > self.rq=
.max_cpu_pressure
> -                    exceeds_io_pressure =3D  self.rq.max_io_pressure a=
nd (float(curr_io_pressure) - float(self.prev_io_pressure)) > self.rq.max=
_io_pressure
> -                    exceeds_memory_pressure =3D self.rq.max_memory_pre=
ssure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)=
) > self.rq.max_memory_pressure
> +                exceeds_cpu_pressure =3D  self.rq.max_cpu_pressure and=
 (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff > sel=
f.rq.max_cpu_pressure
> +                exceeds_io_pressure =3D  self.rq.max_io_pressure and (=
float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff > self.rq=
.max_io_pressure
> +                exceeds_memory_pressure =3D self.rq.max_memory_pressur=
e and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) / =
tdiff > self.rq.max_memory_pressure
> +                self.prev_cpu_pressure =3D curr_cpu_pressure
> +                self.prev_io_pressure =3D curr_io_pressure
> +                self.prev_memory_pressure =3D curr_memory_pressure
> +                self.prev_pressure_time =3D now
> +                self.psi_exceeded =3D exceeds_cpu_pressure or exceeds_=
io_pressure or exceeds_memory_pressure
>               pressure_state =3D (exceeds_cpu_pressure, exceeds_io_pres=
sure, exceeds_memory_pressure)
>               if hasattr(self, "pressure_state") and pressure_state !=3D=
 self.pressure_state:
>                   bb.note("Pressure status changed to CPU: %s, IO: %s, =
Mem: %s" % pressure_state)
>               self.pressure_state =3D pressure_state
> -            return (exceeds_cpu_pressure or exceeds_io_pressure or exc=
eeds_memory_pressure)
> +            return self.psi_exceeded
>           return False
>  =20
>       def next_buildable_task(self):


1)

 =C2=A0$ rg "2023|some" /tmp/cpu
1:2023-08-03 21:29:06.026561191
2:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
4:2023-08-03 21:29:06.031553426
5:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
7:2023-08-03 21:29:06.035901497
8:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
10:2023-08-03 21:29:06.040136284
11:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
13:2023-08-03 21:29:06.043794493
14:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
16:2023-08-03 21:29:06.047555871
17:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
19:2023-08-03 21:29:06.051353279
20:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
22:2023-08-03 21:29:06.055225669
23:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
25:2023-08-03 21:29:06.059436263
26:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
28:2023-08-03 21:29:06.063509822
29:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
31:2023-08-03 21:29:06.067917089
32:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
34:2023-08-03 21:29:06.071907717
35:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
37:2023-08-03 21:29:06.075865773
38:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
40:2023-08-03 21:29:06.079846668
41:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
43:2023-08-03 21:29:06.083961331
44:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
46:2023-08-03 21:29:06.087959027
47:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
49:2023-08-03 21:29:06.091544025
50:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
52:2023-08-03 21:29:06.095441172
53:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
55:2023-08-03 21:29:06.099397076
56:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
58:2023-08-03 21:29:06.103036659
59:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
61:2023-08-03 21:29:06.106987290
62:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
64:2023-08-03 21:29:06.110500839
65:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
67:2023-08-03 21:29:06.113993363
68:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
70:2023-08-03 21:29:06.117569797
71:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
73:2023-08-03 21:29:06.121977963
74:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
76:2023-08-03 21:29:06.125929934
77:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
79:2023-08-03 21:29:06.130064807
80:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
82:2023-08-03 21:29:06.134026786
83:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
85:2023-08-03 21:29:06.137735375
86:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
88:2023-08-03 21:29:06.141781398
89:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
91:2023-08-03 21:29:06.145287007
92:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
94:2023-08-03 21:29:06.149168307
95:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
97:2023-08-03 21:29:06.152818060
98:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
100:2023-08-03 21:29:06.156414605
101:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
103:2023-08-03 21:29:06.160560201
104:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
106:2023-08-03 21:29:06.164730602
107:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
109:2023-08-03 21:29:06.168689146
110:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
112:2023-08-03 21:29:06.172659034
113:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
115:2023-08-03 21:29:06.176217293
116:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
118:2023-08-03 21:29:06.179786393
119:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
121:2023-08-03 21:29:06.183386966
122:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
124:2023-08-03 21:29:06.186901117
125:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
127:2023-08-03 21:29:06.191092359
128:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
130:2023-08-03 21:29:06.194689321
131:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
133:2023-08-03 21:29:06.198680598
134:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
136:2023-08-03 21:29:06.202466314
137:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
139:2023-08-03 21:29:06.206159217
140:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
142:2023-08-03 21:29:06.210732253
143:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
145:2023-08-03 21:29:06.214495861
146:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
148:2023-08-03 21:29:06.218378986
149:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
151:2023-08-03 21:29:06.222715102
152:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
154:2023-08-03 21:29:06.226811631
155:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
157:2023-08-03 21:29:06.231578359
158:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
160:2023-08-03 21:29:06.235715687
161:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
163:2023-08-03 21:29:06.239569685
164:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
166:2023-08-03 21:29:06.243630675
167:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
169:2023-08-03 21:29:06.247567397
170:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
172:2023-08-03 21:29:06.251397908
173:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
175:2023-08-03 21:29:06.255011706
176:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
178:2023-08-03 21:29:06.258932029
179:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
181:2023-08-03 21:29:06.262697913
182:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
184:2023-08-03 21:29:06.266799173
185:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
187:2023-08-03 21:29:06.270925022
188:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
190:2023-08-03 21:29:06.275043244
191:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
193:2023-08-03 21:29:06.278632334
194:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
196:2023-08-03 21:29:06.282248451
197:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
199:2023-08-03 21:29:06.285993782
200:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
202:2023-08-03 21:29:06.290307906
203:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
205:2023-08-03 21:29:06.294324211
206:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
208:2023-08-03 21:29:06.298434915
209:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
211:2023-08-03 21:29:06.302588527
212:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
214:2023-08-03 21:29:06.306381068
215:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
217:2023-08-03 21:29:06.310380335
218:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
220:2023-08-03 21:29:06.315066360
221:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
223:2023-08-03 21:29:06.319399493
224:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
226:2023-08-03 21:29:06.323533769
227:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
229:2023-08-03 21:29:06.327623574
230:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
232:2023-08-03 21:29:06.331404094
233:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
235:2023-08-03 21:29:06.335282298
236:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
238:2023-08-03 21:29:06.339218007
239:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
241:2023-08-03 21:29:06.343022226
242:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
244:2023-08-03 21:29:06.346892658
245:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
247:2023-08-03 21:29:06.350737213
248:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
250:2023-08-03 21:29:06.354365299
251:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
253:2023-08-03 21:29:06.358504205
254:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
256:2023-08-03 21:29:06.362474648
257:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
259:2023-08-03 21:29:06.366500614
260:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
262:2023-08-03 21:29:06.370409578
263:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
265:2023-08-03 21:29:06.374728115
266:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
268:2023-08-03 21:29:06.379177687
269:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
271:2023-08-03 21:29:06.382958096
272:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
274:2023-08-03 21:29:06.386287192
275:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
277:2023-08-03 21:29:06.390148390
278:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
280:2023-08-03 21:29:06.393995408
281:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
283:2023-08-03 21:29:06.397538386
284:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
286:2023-08-03 21:29:06.401522567
287:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
289:2023-08-03 21:29:06.405142382
290:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
292:2023-08-03 21:29:06.408883272
293:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
295:2023-08-03 21:29:06.412675078
296:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
298:2023-08-03 21:29:06.416350916
299:some avg10=3D0.00 avg60=3D0.00 avg300=3D0.00 total=3D38696165984
301:2023-08-03 21:30:02.078140466
302:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696853256
304:2023-08-03 21:30:02.107326758
305:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696855634
307:2023-08-03 21:30:02.126028647
308:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696856111
310:2023-08-03 21:30:02.146028343
311:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696858681
313:2023-08-03 21:30:02.170021779
314:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696861693
316:2023-08-03 21:30:02.210054311
317:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696865034
319:2023-08-03 21:30:02.246006375
320:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696867390
322:2023-08-03 21:30:02.274025123
323:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696870090
325:2023-08-03 21:30:02.306023178
326:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696873121
328:2023-08-03 21:30:02.342042024
329:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696876150
331:2023-08-03 21:30:02.374045594
332:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696878182
334:2023-08-03 21:30:02.398024941
335:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696880542
337:2023-08-03 21:30:02.430025787
338:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696884229
340:2023-08-03 21:30:02.474025766
341:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696886618
343:2023-08-03 21:30:02.506036609
344:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696889650
346:2023-08-03 21:30:02.538005211
347:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696892350
349:2023-08-03 21:30:02.570002594
350:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696895386
352:2023-08-03 21:30:02.602024574
353:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696897412
355:2023-08-03 21:30:02.626006000
356:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696899777
358:2023-08-03 21:30:02.654031808
359:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696901808
361:2023-08-03 21:30:02.686002144
362:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696904511
364:2023-08-03 21:30:02.718074747
365:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696908199
367:2023-08-03 21:30:02.754015511
368:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696910921
370:2023-08-03 21:30:02.786022272
371:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696913625
373:2023-08-03 21:30:02.818041167
374:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696916321
376:2023-08-03 21:30:02.858023387
377:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696919750
379:2023-08-03 21:30:02.894034643
380:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696922454
382:2023-08-03 21:30:02.926147057
383:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696925319
385:2023-08-03 21:30:02.954068342
386:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696927350
388:2023-08-03 21:30:02.986088254
389:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696930380
391:2023-08-03 21:30:03.018103409
392:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696933078
394:2023-08-03 21:30:03.050077392
395:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696935445
397:2023-08-03 21:30:03.074114392
398:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696938795
400:2023-08-03 21:30:03.114035084
401:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696940845
403:2023-08-03 21:30:03.142015391
404:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696943542
406:2023-08-03 21:30:03.174031239
407:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696946247
409:2023-08-03 21:30:03.210113551
410:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696949897
412:2023-08-03 21:30:03.242035265
413:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696952261
415:2023-08-03 21:30:03.274046961
416:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696954940
418:2023-08-03 21:30:03.306028723
419:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696957656
421:2023-08-03 21:30:03.338077555
422:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696960686
424:2023-08-03 21:30:03.374073915
425:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696963050
427:2023-08-03 21:30:03.402047343
428:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696966086
430:2023-08-03 21:30:03.434032881
431:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696968788
433:2023-08-03 21:30:03.466032340
434:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696970813
436:2023-08-03 21:30:03.494068821
437:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696973176
439:2023-08-03 21:30:03.522161212
440:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696975872
442:2023-08-03 21:30:03.554050153
443:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696978574
445:2023-08-03 21:30:03.586065001
446:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696980938
448:2023-08-03 21:30:03.614119644
449:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696983300
451:2023-08-03 21:30:03.638144992
452:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696986016
454:2023-08-03 21:30:03.674118268
455:some avg10=3D3.10 avg60=3D0.88 avg300=3D0.20 total=3D38696988717
457:2023-08-03 21:30:03.710118733
458:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38696991745
460:2023-08-03 21:30:03.738066832
461:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38696994115
463:2023-08-03 21:30:03.770048303
464:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38696996451
466:2023-08-03 21:30:03.802092382
467:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38696999169
469:2023-08-03 21:30:03.826077226
470:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697001198
472:2023-08-03 21:30:03.858062788
473:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697003903
475:2023-08-03 21:30:03.890062930
476:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697006941
478:2023-08-03 21:30:03.922067512
479:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697009971
481:2023-08-03 21:30:03.958084669
482:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697013322
484:2023-08-03 21:30:03.994120043
485:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697015378
487:2023-08-03 21:30:04.018108794
488:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697017409
490:2023-08-03 21:30:04.042115598
491:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697019438
493:2023-08-03 21:30:04.066126937
494:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697021470
496:2023-08-03 21:30:04.090050277
497:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697023835
499:2023-08-03 21:30:04.122078760
500:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697026530
502:2023-08-03 21:30:04.158044418
503:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697029229
505:2023-08-03 21:30:04.186092879
506:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697032540
508:2023-08-03 21:30:04.233761652
509:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697035931
511:2023-08-03 21:30:04.262027484
512:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697038637
514:2023-08-03 21:30:04.294022638
515:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697041335
517:2023-08-03 21:30:04.322028009
518:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697044038
520:2023-08-03 21:30:04.354034481
521:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697046391
523:2023-08-03 21:30:04.386023486
524:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697048757
526:2023-08-03 21:30:04.414022848
527:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697051459
529:2023-08-03 21:30:04.442017832
530:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697053484
532:2023-08-03 21:30:04.466027364
533:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697056162
535:2023-08-03 21:30:04.502021088
536:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697058883
538:2023-08-03 21:30:04.534039153
539:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697061578
541:2023-08-03 21:30:04.566039103
542:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697063939
544:2023-08-03 21:30:04.598037462
545:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697066641
547:2023-08-03 21:30:04.629771191
548:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697070011
550:2023-08-03 21:30:04.666042007
551:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697072371
553:2023-08-03 21:30:04.698010368
554:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697075069
556:2023-08-03 21:30:04.722019998
557:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697077770
559:2023-08-03 21:30:04.762030636
560:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697080474
562:2023-08-03 21:30:04.786010720
563:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697083181
565:2023-08-03 21:30:04.818035029
566:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697085877
568:2023-08-03 21:30:04.854034446
569:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697088575
571:2023-08-03 21:30:04.882043053
572:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697091289
574:2023-08-03 21:30:04.922081980
575:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697093316
577:2023-08-03 21:30:04.927564632
578:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697094670
580:2023-08-03 21:30:04.962026471
581:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697097373
583:2023-08-03 21:30:04.990040191
584:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697099739
586:2023-08-03 21:30:05.014033886
587:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697101764
589:2023-08-03 21:30:05.039750750
590:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697104463
592:2023-08-03 21:30:05.074019117
593:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697106610
595:2023-08-03 21:30:05.110046072
596:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697109855
598:2023-08-03 21:30:05.138046014
599:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697112555
601:2023-08-03 21:30:05.166023497
602:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697115232
604:2023-08-03 21:30:05.206061564
605:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697118239
607:2023-08-03 21:30:05.238018646
608:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697120933
610:2023-08-03 21:30:05.270026372
611:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697123957
613:2023-08-03 21:30:05.302027288
614:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697126663
616:2023-08-03 21:30:05.334040250
617:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697129338
619:2023-08-03 21:30:05.360190632
620:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697131047
622:2023-08-03 21:30:05.390029162
623:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697133747
625:2023-08-03 21:30:05.414034794
626:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697135782
628:2023-08-03 21:30:05.427642722
629:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697137467
631:2023-08-03 21:30:05.458016115
632:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697139828
634:2023-08-03 21:30:05.486030455
635:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697142173
637:2023-08-03 21:30:05.514016836
638:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697144890
640:2023-08-03 21:30:05.546024372
641:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697147583
643:2023-08-03 21:30:05.584237211
644:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697150280
646:2023-08-03 21:30:05.614025918
647:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697152856
649:2023-08-03 21:30:05.646014419
650:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697155334
652:2023-08-03 21:30:05.670042958
653:some avg10=3D3.99 avg60=3D1.11 avg300=3D0.25 total=3D38697157696
655:2023-08-03 21:30:05.706027504
656:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697160413
658:2023-08-03 21:30:05.730024921
659:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697163116
661:2023-08-03 21:30:05.770026829
662:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697165892
664:2023-08-03 21:30:05.806011996
665:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697168589
667:2023-08-03 21:30:05.830011568
668:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697171305
670:2023-08-03 21:30:05.862039144
671:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697173671
673:2023-08-03 21:30:05.898008773
674:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697177020
676:2023-08-03 21:30:05.933796165
677:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697179742
679:2023-08-03 21:30:05.970058151
680:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697182438
682:2023-08-03 21:30:05.994037819
683:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697184468
685:2023-08-03 21:30:06.026022629
686:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697187165
688:2023-08-03 21:30:06.050024626
689:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697189526
691:2023-08-03 21:30:06.078013808
692:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697192230
694:2023-08-03 21:30:06.114030646
695:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697194603
697:2023-08-03 21:30:06.142038629
698:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697197296
700:2023-08-03 21:30:06.170044171
701:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697199658
703:2023-08-03 21:30:06.205670334
704:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697202692
706:2023-08-03 21:30:06.238037490
707:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697206060
709:2023-08-03 21:30:06.270024332
710:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697208087
712:2023-08-03 21:30:06.301784118
713:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697211461
715:2023-08-03 21:30:06.342039416
716:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697214160
718:2023-08-03 21:30:06.374013677
719:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697216861
721:2023-08-03 21:30:06.406040803
722:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697219559
724:2023-08-03 21:30:06.438006057
725:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697222256
727:2023-08-03 21:30:06.470026240
728:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697225629
730:2023-08-03 21:30:06.502024527
731:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697228305
733:2023-08-03 21:30:06.538033228
734:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697230686
736:2023-08-03 21:30:06.566028157
737:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697233689
739:2023-08-03 21:30:06.602025064
740:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697236080
742:2023-08-03 21:30:06.630027618
743:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697238780
745:2023-08-03 21:30:06.662010496
746:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697241478
748:2023-08-03 21:30:06.690014164
749:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697243510
751:2023-08-03 21:30:06.714031649
752:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697246207
754:2023-08-03 21:30:06.750026276
755:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697248907
757:2023-08-03 21:30:06.786014937
758:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697251609
760:2023-08-03 21:30:06.818017495
761:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697254643
763:2023-08-03 21:30:06.846013970
764:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697256667
766:2023-08-03 21:30:06.878168821
767:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697259367
769:2023-08-03 21:30:06.902022147
770:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697262083
772:2023-08-03 21:30:06.937999183
773:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697264777
775:2023-08-03 21:30:06.970022469
776:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697267479
778:2023-08-03 21:30:07.006018171
779:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697270171
781:2023-08-03 21:30:07.030035755
782:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697272873
784:2023-08-03 21:30:07.070024602
785:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697275913
787:2023-08-03 21:30:07.098024161
788:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697277932
790:2023-08-03 21:30:07.126038057
791:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697280293
793:2023-08-03 21:30:07.150014689
794:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697282324
796:2023-08-03 21:30:07.174011609
797:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697284688
799:2023-08-03 21:30:07.206006119
800:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697287664
802:2023-08-03 21:30:07.242013736
803:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697290389
805:2023-08-03 21:30:07.273763791
806:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697293757
808:2023-08-03 21:30:07.306027619
809:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697296435
811:2023-08-03 21:30:07.338033801
812:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697299155
814:2023-08-03 21:30:07.370014272
815:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697301335
817:2023-08-03 21:30:07.398049887
818:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697303375
820:2023-08-03 21:30:07.426030463
821:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306238
823:2023-08-03 21:30:07.446012112
824:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
826:2023-08-03 21:30:07.449074039
827:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
829:2023-08-03 21:30:07.452094902
830:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
832:2023-08-03 21:30:07.455132499
833:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
835:2023-08-03 21:30:07.458158709
836:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
838:2023-08-03 21:30:07.461160555
839:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
841:2023-08-03 21:30:07.464164844
842:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
844:2023-08-03 21:30:07.467191143
845:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
847:2023-08-03 21:30:07.470249391
848:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
850:2023-08-03 21:30:07.473268040
851:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
853:2023-08-03 21:30:07.476260894
854:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
856:2023-08-03 21:30:07.479273385
857:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
859:2023-08-03 21:30:07.482341558
860:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
862:2023-08-03 21:30:07.485402936
863:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
865:2023-08-03 21:30:07.488621116
866:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
868:2023-08-03 21:30:07.491648106
869:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
871:2023-08-03 21:30:07.494712160
872:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
874:2023-08-03 21:30:07.497741518
875:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
877:2023-08-03 21:30:07.500731815
878:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
880:2023-08-03 21:30:07.503757142
881:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
883:2023-08-03 21:30:07.506830439
884:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
886:2023-08-03 21:30:07.509933769
887:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
889:2023-08-03 21:30:07.512924245
890:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
892:2023-08-03 21:30:07.515952487
893:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
895:2023-08-03 21:30:07.519039796
896:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714
898:2023-08-03 21:30:07.522058287
899:some avg10=3D4.71 avg60=3D1.34 avg300=3D0.30 total=3D38697306714

--=20
# Randy MacLeod
# Wind River Linux

--------------kT0z2k0lDpWSVs7Qh2LTBFdI
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2023-08-03 03:56,
      <a class="moz-txt-link-abbreviated" href="mailto:Qi.Chen@windriver.com">Qi.Chen@windriver.com</a> wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20230803075638.2355913-1-Qi.Chen@windriver.com">
      <pre class="moz-quote-pre" wrap="">From: Chen Qi <a class="moz-txt-link-rfc2396E" href="mailto:Qi.Chen@windriver.com">&lt;Qi.Chen@windriver.com&gt;</a>

The current logic is not correct because if the time interval
between the current check and the last check is very small, the PSI
checker is not likely to block things even if the system is heavy
loaded. </pre>
    </blockquote>
    Agreed, there is a problem but we do have to be careful to not<br>
    a make things too slow since the goal is to have maximum throughput<br>
    without having too much congestion and cpu scheduling and IO
    latency.<br>
    <blockquote type="cite" cite="mid:20230803075638.2355913-1-Qi.Chen@windriver.com">
      <pre class="moz-quote-pre" wrap="">In fact, if the time interval is very small, the result
might be 0, resulting in any small value not having any effect.</pre>
    </blockquote>
    Yes, the PSI variable are implemented as per cpu vars and<br>
    you can get the same result several times in a row, even when<br>
    <p>there is lots of CPU pressure. Eg:<br>
    </p>
    <p>$ stress -c 25 -t 100 &amp;<br>
      [1] 3851144<br>
      stress: info: [3851144] dispatching hogs: 25 cpu, 0 io, 0 vm, 0
      hdd<br>
      $ for i in `seq 200`; do date +&quot;%Y-%m-%d %H:%M:%S.%N&quot; &gt;&gt;
      /tmp/cpu; cat /proc/pressure/cpu &gt;&gt; /tmp/cpu ; done<br>
      $ less /tmp/cpu <br>
    </p>
    <p>See (1) below.</p>
    <p>I need to look at the PSI averaging algorithm again!<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20230803075638.2355913-1-Qi.Chen@windriver.com">
      <pre class="moz-quote-pre" wrap="">

To reproduce the current problem, set BB_PRESSURE_MAX_CPU/IO/MEMORY
to &quot;1&quot;, and start a build. We can see there's more than one tasks
running throughout the whole build process.

This patch improves things a little bit. It will block task spawning
for at least 1s if the limits are exceeded, this is to overcome the
0 result issue. On the other hand, if the task spawning is not
blocked, we check the pressure every time.

However, even with this fix, we still have the task spawning peek issue.
Because at some point, when the load is low enough, a few tasks will
be spawned altogether.

In summary, this patch improves the situation, but the peek task
spawning peek issue is still there.</pre>
    </blockquote>
    Richard and I were talking about this and he suggested<br>
    that we take a different approach of changing from a binary<br>
    approach to one where if we're close (say withing 10%) of the
    threshold, <br>
    we tell the bitbake scheduler:<br>
    <p>&nbsp;&quot; Things don't look good, can you ask me again in a little
      while?&quot;</p>
    <p><br>
    </p>
    Then if the congestion abates, we allow new task and if not, then<br>
    we've avoided introducing new load as we are ramping up.<br>
    Richard claims that this &quot;ask again in a while&quot; is something the<br>
    <p>scheduler already has code for. <br>
    </p>
    <p><br>
    </p>
    This is essentially a smoothing algorithm, which I have little<br>
    experience. I did, as a student decades ago, try to control the
    temperator of <br>
    a beaker of water and bring it from room temperature to a predefined
    goal<br>
    with minimal overshoot and reverberation! There are people with
    expertise <br>
    in this sort of thing, so if you are such a person, it would be good
    to have <br>
    you appear out of the Yocto woodwork!<br>
    <p>I think we're doing something similar to the temperature
      controlled beaker <br>
      except it's a not a fixed thermal load but rather a continuously
      changing one.</p>
    <p><br>
    </p>
    <p>I'm not sure if I've written this down before but I think there
      would<br>
      be some benefit, at least for a self-test, to have a series of
      stress-ng<br>
      tasks that we put into a recipe. One would bring the system up to<br>
      just below CPU (IO) congestion and keep the system in that state
      for a ~5-10<br>
      minutes. Then we'd run another N (= 10?), short-lived (30 s?)
      stress-ng -c<br>
      tests all at once. If the pressure regulation were working well,<br>
      the secondary stress-ng jobs would run serially and take N*Timeout
      to be done.</p>
    <p>Of course, on a loaded system such as the YP autobuilders, this
      would take even longer<br>
      but should never take &lt; N*Timeout seconds.<br>
      <br>
      While this sounds like a good test to me (and kind of fun!), we
      should remind ourselfs<br>
      that the larger task is to get make/ninja/cargo/etc to use a job
      pool per bitbake instance <br>
      and/or patch them to read PSI info.<br>
      <br>
      We'd still have the congestion onset/abatement problem with those
      tools though<br>
      so the problem is worth figuring out.</p>
    <p>For now, I'd need to see the before and after times an buildstats
      for a build of say core-image-minimal<br>
      and/or poky world on a system that runs at 100% capacity for a
      good part of the build without PSI<br>
      regulation.<br>
    </p>
    <p>Data below. Sorry, I don't have time to analyze or graph it.<br>
    </p>
    <p><br>
    </p>
    <p>../Randy<br>
    </p>
    <blockquote type="cite" cite="mid:20230803075638.2355913-1-Qi.Chen@windriver.com">
      <pre class="moz-quote-pre" wrap="">

Signed-off-by: Chen Qi <a class="moz-txt-link-rfc2396E" href="mailto:Qi.Chen@windriver.com">&lt;Qi.Chen@windriver.com&gt;</a>
---
 bitbake/lib/bb/runqueue.py | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 48788f4aa6..7c482a55f3 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -179,6 +179,7 @@ class RunQueueScheduler(object):
                     self.prev_memory_pressure = memory_pressure_fds.readline().split()[4].split(&quot;=&quot;)[1]
                     self.prev_pressure_time = time.time()
                 self.check_pressure = True
+                self.psi_exceeded = False
             except:
                 bb.note(&quot;The /proc/pressure files can't be read. Continuing build without monitoring pressure&quot;)
                 self.check_pressure = False
@@ -191,6 +192,14 @@ class RunQueueScheduler(object):
         BB_PRESSURE_MAX_{CPU|IO|MEMORY} are set, return True if above threshold.
         &quot;&quot;&quot;
         if self.check_pressure:
+            now = time.time()
+            tdiff = now - self.prev_pressure_time
+            # If task spawning has been blocked, block it for at least 1s;
+            # otherwise, check the pressure ASAP. This is because if tdiff is very small
+            # the result of (curr_xxx_pressure - prev_xxx_pressure) might be 0, resulting
+            # in any small value not having effect.
+            if self.psi_exceeded and tdiff &lt; 1.0:
+                return self.psi_exceeded
             with open(&quot;/proc/pressure/cpu&quot;) as cpu_pressure_fds, \
                 open(&quot;/proc/pressure/io&quot;) as io_pressure_fds, \
                 open(&quot;/proc/pressure/memory&quot;) as memory_pressure_fds:
@@ -198,25 +207,19 @@ class RunQueueScheduler(object):
                 curr_cpu_pressure = cpu_pressure_fds.readline().split()[4].split(&quot;=&quot;)[1]
                 curr_io_pressure = io_pressure_fds.readline().split()[4].split(&quot;=&quot;)[1]
                 curr_memory_pressure = memory_pressure_fds.readline().split()[4].split(&quot;=&quot;)[1]
-                now = time.time()
-                tdiff = now - self.prev_pressure_time
-                if tdiff &gt; 1.0:
-                    exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff &gt; self.rq.max_cpu_pressure
-                    exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff &gt; self.rq.max_io_pressure
-                    exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) / tdiff &gt; self.rq.max_memory_pressure
-                    self.prev_cpu_pressure = curr_cpu_pressure
-                    self.prev_io_pressure = curr_io_pressure
-                    self.prev_memory_pressure = curr_memory_pressure
-                    self.prev_pressure_time = now
-                else:
-                    exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) &gt; self.rq.max_cpu_pressure
-                    exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) &gt; self.rq.max_io_pressure
-                    exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) &gt; self.rq.max_memory_pressure
+                exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff &gt; self.rq.max_cpu_pressure
+                exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff &gt; self.rq.max_io_pressure
+                exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) / tdiff &gt; self.rq.max_memory_pressure
+                self.prev_cpu_pressure = curr_cpu_pressure
+                self.prev_io_pressure = curr_io_pressure
+                self.prev_memory_pressure = curr_memory_pressure
+                self.prev_pressure_time = now
+                self.psi_exceeded = exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure
             pressure_state = (exceeds_cpu_pressure, exceeds_io_pressure, exceeds_memory_pressure)
             if hasattr(self, &quot;pressure_state&quot;) and pressure_state != self.pressure_state:
                 bb.note(&quot;Pressure status changed to CPU: %s, IO: %s, Mem: %s&quot; % pressure_state)
             self.pressure_state = pressure_state
-            return (exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure)
+            return self.psi_exceeded
         return False
 
     def next_buildable_task(self):
</pre>
    </blockquote>
    <p><br>
    </p>
    <p>1) <br>
    </p>
    <p>&nbsp;$ rg &quot;2023|some&quot; /tmp/cpu <br>
      1:2023-08-03 21:29:06.026561191<br>
      2:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      4:2023-08-03 21:29:06.031553426<br>
      5:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      7:2023-08-03 21:29:06.035901497<br>
      8:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      10:2023-08-03 21:29:06.040136284<br>
      11:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      13:2023-08-03 21:29:06.043794493<br>
      14:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      16:2023-08-03 21:29:06.047555871<br>
      17:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      19:2023-08-03 21:29:06.051353279<br>
      20:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      22:2023-08-03 21:29:06.055225669<br>
      23:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      25:2023-08-03 21:29:06.059436263<br>
      26:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      28:2023-08-03 21:29:06.063509822<br>
      29:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      31:2023-08-03 21:29:06.067917089<br>
      32:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      34:2023-08-03 21:29:06.071907717<br>
      35:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      37:2023-08-03 21:29:06.075865773<br>
      38:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      40:2023-08-03 21:29:06.079846668<br>
      41:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      43:2023-08-03 21:29:06.083961331<br>
      44:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      46:2023-08-03 21:29:06.087959027<br>
      47:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      49:2023-08-03 21:29:06.091544025<br>
      50:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      52:2023-08-03 21:29:06.095441172<br>
      53:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      55:2023-08-03 21:29:06.099397076<br>
      56:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      58:2023-08-03 21:29:06.103036659<br>
      59:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      61:2023-08-03 21:29:06.106987290<br>
      62:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      64:2023-08-03 21:29:06.110500839<br>
      65:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      67:2023-08-03 21:29:06.113993363<br>
      68:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      70:2023-08-03 21:29:06.117569797<br>
      71:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      73:2023-08-03 21:29:06.121977963<br>
      74:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      76:2023-08-03 21:29:06.125929934<br>
      77:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      79:2023-08-03 21:29:06.130064807<br>
      80:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      82:2023-08-03 21:29:06.134026786<br>
      83:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      85:2023-08-03 21:29:06.137735375<br>
      86:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      88:2023-08-03 21:29:06.141781398<br>
      89:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      91:2023-08-03 21:29:06.145287007<br>
      92:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      94:2023-08-03 21:29:06.149168307<br>
      95:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      97:2023-08-03 21:29:06.152818060<br>
      98:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      100:2023-08-03 21:29:06.156414605<br>
      101:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      103:2023-08-03 21:29:06.160560201<br>
      104:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      106:2023-08-03 21:29:06.164730602<br>
      107:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      109:2023-08-03 21:29:06.168689146<br>
      110:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      112:2023-08-03 21:29:06.172659034<br>
      113:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      115:2023-08-03 21:29:06.176217293<br>
      116:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      118:2023-08-03 21:29:06.179786393<br>
      119:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      121:2023-08-03 21:29:06.183386966<br>
      122:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      124:2023-08-03 21:29:06.186901117<br>
      125:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      127:2023-08-03 21:29:06.191092359<br>
      128:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      130:2023-08-03 21:29:06.194689321<br>
      131:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      133:2023-08-03 21:29:06.198680598<br>
      134:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      136:2023-08-03 21:29:06.202466314<br>
      137:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      139:2023-08-03 21:29:06.206159217<br>
      140:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      142:2023-08-03 21:29:06.210732253<br>
      143:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      145:2023-08-03 21:29:06.214495861<br>
      146:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      148:2023-08-03 21:29:06.218378986<br>
      149:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      151:2023-08-03 21:29:06.222715102<br>
      152:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      154:2023-08-03 21:29:06.226811631<br>
      155:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      157:2023-08-03 21:29:06.231578359<br>
      158:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      160:2023-08-03 21:29:06.235715687<br>
      161:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      163:2023-08-03 21:29:06.239569685<br>
      164:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      166:2023-08-03 21:29:06.243630675<br>
      167:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      169:2023-08-03 21:29:06.247567397<br>
      170:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      172:2023-08-03 21:29:06.251397908<br>
      173:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      175:2023-08-03 21:29:06.255011706<br>
      176:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      178:2023-08-03 21:29:06.258932029<br>
      179:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      181:2023-08-03 21:29:06.262697913<br>
      182:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      184:2023-08-03 21:29:06.266799173<br>
      185:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      187:2023-08-03 21:29:06.270925022<br>
      188:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      190:2023-08-03 21:29:06.275043244<br>
      191:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      193:2023-08-03 21:29:06.278632334<br>
      194:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      196:2023-08-03 21:29:06.282248451<br>
      197:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      199:2023-08-03 21:29:06.285993782<br>
      200:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      202:2023-08-03 21:29:06.290307906<br>
      203:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      205:2023-08-03 21:29:06.294324211<br>
      206:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      208:2023-08-03 21:29:06.298434915<br>
      209:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      211:2023-08-03 21:29:06.302588527<br>
      212:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      214:2023-08-03 21:29:06.306381068<br>
      215:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      217:2023-08-03 21:29:06.310380335<br>
      218:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      220:2023-08-03 21:29:06.315066360<br>
      221:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      223:2023-08-03 21:29:06.319399493<br>
      224:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      226:2023-08-03 21:29:06.323533769<br>
      227:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      229:2023-08-03 21:29:06.327623574<br>
      230:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      232:2023-08-03 21:29:06.331404094<br>
      233:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      235:2023-08-03 21:29:06.335282298<br>
      236:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      238:2023-08-03 21:29:06.339218007<br>
      239:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      241:2023-08-03 21:29:06.343022226<br>
      242:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      244:2023-08-03 21:29:06.346892658<br>
      245:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      247:2023-08-03 21:29:06.350737213<br>
      248:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      250:2023-08-03 21:29:06.354365299<br>
      251:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      253:2023-08-03 21:29:06.358504205<br>
      254:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      256:2023-08-03 21:29:06.362474648<br>
      257:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      259:2023-08-03 21:29:06.366500614<br>
      260:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      262:2023-08-03 21:29:06.370409578<br>
      263:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      265:2023-08-03 21:29:06.374728115<br>
      266:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      268:2023-08-03 21:29:06.379177687<br>
      269:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      271:2023-08-03 21:29:06.382958096<br>
      272:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      274:2023-08-03 21:29:06.386287192<br>
      275:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      277:2023-08-03 21:29:06.390148390<br>
      278:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      280:2023-08-03 21:29:06.393995408<br>
      281:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      283:2023-08-03 21:29:06.397538386<br>
      284:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      286:2023-08-03 21:29:06.401522567<br>
      287:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      289:2023-08-03 21:29:06.405142382<br>
      290:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      292:2023-08-03 21:29:06.408883272<br>
      293:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      295:2023-08-03 21:29:06.412675078<br>
      296:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      298:2023-08-03 21:29:06.416350916<br>
      299:some avg10=0.00 avg60=0.00 avg300=0.00 total=38696165984<br>
      301:2023-08-03 21:30:02.078140466<br>
      302:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696853256<br>
      304:2023-08-03 21:30:02.107326758<br>
      305:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696855634<br>
      307:2023-08-03 21:30:02.126028647<br>
      308:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696856111<br>
      310:2023-08-03 21:30:02.146028343<br>
      311:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696858681<br>
      313:2023-08-03 21:30:02.170021779<br>
      314:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696861693<br>
      316:2023-08-03 21:30:02.210054311<br>
      317:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696865034<br>
      319:2023-08-03 21:30:02.246006375<br>
      320:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696867390<br>
      322:2023-08-03 21:30:02.274025123<br>
      323:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696870090<br>
      325:2023-08-03 21:30:02.306023178<br>
      326:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696873121<br>
      328:2023-08-03 21:30:02.342042024<br>
      329:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696876150<br>
      331:2023-08-03 21:30:02.374045594<br>
      332:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696878182<br>
      334:2023-08-03 21:30:02.398024941<br>
      335:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696880542<br>
      337:2023-08-03 21:30:02.430025787<br>
      338:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696884229<br>
      340:2023-08-03 21:30:02.474025766<br>
      341:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696886618<br>
      343:2023-08-03 21:30:02.506036609<br>
      344:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696889650<br>
      346:2023-08-03 21:30:02.538005211<br>
      347:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696892350<br>
      349:2023-08-03 21:30:02.570002594<br>
      350:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696895386<br>
      352:2023-08-03 21:30:02.602024574<br>
      353:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696897412<br>
      355:2023-08-03 21:30:02.626006000<br>
      356:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696899777<br>
      358:2023-08-03 21:30:02.654031808<br>
      359:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696901808<br>
      361:2023-08-03 21:30:02.686002144<br>
      362:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696904511<br>
      364:2023-08-03 21:30:02.718074747<br>
      365:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696908199<br>
      367:2023-08-03 21:30:02.754015511<br>
      368:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696910921<br>
      370:2023-08-03 21:30:02.786022272<br>
      371:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696913625<br>
      373:2023-08-03 21:30:02.818041167<br>
      374:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696916321<br>
      376:2023-08-03 21:30:02.858023387<br>
      377:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696919750<br>
      379:2023-08-03 21:30:02.894034643<br>
      380:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696922454<br>
      382:2023-08-03 21:30:02.926147057<br>
      383:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696925319<br>
      385:2023-08-03 21:30:02.954068342<br>
      386:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696927350<br>
      388:2023-08-03 21:30:02.986088254<br>
      389:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696930380<br>
      391:2023-08-03 21:30:03.018103409<br>
      392:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696933078<br>
      394:2023-08-03 21:30:03.050077392<br>
      395:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696935445<br>
      397:2023-08-03 21:30:03.074114392<br>
      398:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696938795<br>
      400:2023-08-03 21:30:03.114035084<br>
      401:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696940845<br>
      403:2023-08-03 21:30:03.142015391<br>
      404:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696943542<br>
      406:2023-08-03 21:30:03.174031239<br>
      407:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696946247<br>
      409:2023-08-03 21:30:03.210113551<br>
      410:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696949897<br>
      412:2023-08-03 21:30:03.242035265<br>
      413:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696952261<br>
      415:2023-08-03 21:30:03.274046961<br>
      416:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696954940<br>
      418:2023-08-03 21:30:03.306028723<br>
      419:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696957656<br>
      421:2023-08-03 21:30:03.338077555<br>
      422:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696960686<br>
      424:2023-08-03 21:30:03.374073915<br>
      425:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696963050<br>
      427:2023-08-03 21:30:03.402047343<br>
      428:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696966086<br>
      430:2023-08-03 21:30:03.434032881<br>
      431:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696968788<br>
      433:2023-08-03 21:30:03.466032340<br>
      434:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696970813<br>
      436:2023-08-03 21:30:03.494068821<br>
      437:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696973176<br>
      439:2023-08-03 21:30:03.522161212<br>
      440:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696975872<br>
      442:2023-08-03 21:30:03.554050153<br>
      443:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696978574<br>
      445:2023-08-03 21:30:03.586065001<br>
      446:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696980938<br>
      448:2023-08-03 21:30:03.614119644<br>
      449:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696983300<br>
      451:2023-08-03 21:30:03.638144992<br>
      452:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696986016<br>
      454:2023-08-03 21:30:03.674118268<br>
      455:some avg10=3.10 avg60=0.88 avg300=0.20 total=38696988717<br>
      457:2023-08-03 21:30:03.710118733<br>
      458:some avg10=3.99 avg60=1.11 avg300=0.25 total=38696991745<br>
      460:2023-08-03 21:30:03.738066832<br>
      461:some avg10=3.99 avg60=1.11 avg300=0.25 total=38696994115<br>
      463:2023-08-03 21:30:03.770048303<br>
      464:some avg10=3.99 avg60=1.11 avg300=0.25 total=38696996451<br>
      466:2023-08-03 21:30:03.802092382<br>
      467:some avg10=3.99 avg60=1.11 avg300=0.25 total=38696999169<br>
      469:2023-08-03 21:30:03.826077226<br>
      470:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697001198<br>
      472:2023-08-03 21:30:03.858062788<br>
      473:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697003903<br>
      475:2023-08-03 21:30:03.890062930<br>
      476:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697006941<br>
      478:2023-08-03 21:30:03.922067512<br>
      479:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697009971<br>
      481:2023-08-03 21:30:03.958084669<br>
      482:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697013322<br>
      484:2023-08-03 21:30:03.994120043<br>
      485:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697015378<br>
      487:2023-08-03 21:30:04.018108794<br>
      488:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697017409<br>
      490:2023-08-03 21:30:04.042115598<br>
      491:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697019438<br>
      493:2023-08-03 21:30:04.066126937<br>
      494:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697021470<br>
      496:2023-08-03 21:30:04.090050277<br>
      497:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697023835<br>
      499:2023-08-03 21:30:04.122078760<br>
      500:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697026530<br>
      502:2023-08-03 21:30:04.158044418<br>
      503:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697029229<br>
      505:2023-08-03 21:30:04.186092879<br>
      506:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697032540<br>
      508:2023-08-03 21:30:04.233761652<br>
      509:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697035931<br>
      511:2023-08-03 21:30:04.262027484<br>
      512:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697038637<br>
      514:2023-08-03 21:30:04.294022638<br>
      515:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697041335<br>
      517:2023-08-03 21:30:04.322028009<br>
      518:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697044038<br>
      520:2023-08-03 21:30:04.354034481<br>
      521:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697046391<br>
      523:2023-08-03 21:30:04.386023486<br>
      524:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697048757<br>
      526:2023-08-03 21:30:04.414022848<br>
      527:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697051459<br>
      529:2023-08-03 21:30:04.442017832<br>
      530:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697053484<br>
      532:2023-08-03 21:30:04.466027364<br>
      533:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697056162<br>
      535:2023-08-03 21:30:04.502021088<br>
      536:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697058883<br>
      538:2023-08-03 21:30:04.534039153<br>
      539:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697061578<br>
      541:2023-08-03 21:30:04.566039103<br>
      542:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697063939<br>
      544:2023-08-03 21:30:04.598037462<br>
      545:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697066641<br>
      547:2023-08-03 21:30:04.629771191<br>
      548:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697070011<br>
      550:2023-08-03 21:30:04.666042007<br>
      551:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697072371<br>
      553:2023-08-03 21:30:04.698010368<br>
      554:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697075069<br>
      556:2023-08-03 21:30:04.722019998<br>
      557:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697077770<br>
      559:2023-08-03 21:30:04.762030636<br>
      560:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697080474<br>
      562:2023-08-03 21:30:04.786010720<br>
      563:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697083181<br>
      565:2023-08-03 21:30:04.818035029<br>
      566:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697085877<br>
      568:2023-08-03 21:30:04.854034446<br>
      569:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697088575<br>
      571:2023-08-03 21:30:04.882043053<br>
      572:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697091289<br>
      574:2023-08-03 21:30:04.922081980<br>
      575:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697093316<br>
      577:2023-08-03 21:30:04.927564632<br>
      578:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697094670<br>
      580:2023-08-03 21:30:04.962026471<br>
      581:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697097373<br>
      583:2023-08-03 21:30:04.990040191<br>
      584:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697099739<br>
      586:2023-08-03 21:30:05.014033886<br>
      587:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697101764<br>
      589:2023-08-03 21:30:05.039750750<br>
      590:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697104463<br>
      592:2023-08-03 21:30:05.074019117<br>
      593:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697106610<br>
      595:2023-08-03 21:30:05.110046072<br>
      596:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697109855<br>
      598:2023-08-03 21:30:05.138046014<br>
      599:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697112555<br>
      601:2023-08-03 21:30:05.166023497<br>
      602:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697115232<br>
      604:2023-08-03 21:30:05.206061564<br>
      605:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697118239<br>
      607:2023-08-03 21:30:05.238018646<br>
      608:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697120933<br>
      610:2023-08-03 21:30:05.270026372<br>
      611:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697123957<br>
      613:2023-08-03 21:30:05.302027288<br>
      614:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697126663<br>
      616:2023-08-03 21:30:05.334040250<br>
      617:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697129338<br>
      619:2023-08-03 21:30:05.360190632<br>
      620:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697131047<br>
      622:2023-08-03 21:30:05.390029162<br>
      623:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697133747<br>
      625:2023-08-03 21:30:05.414034794<br>
      626:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697135782<br>
      628:2023-08-03 21:30:05.427642722<br>
      629:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697137467<br>
      631:2023-08-03 21:30:05.458016115<br>
      632:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697139828<br>
      634:2023-08-03 21:30:05.486030455<br>
      635:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697142173<br>
      637:2023-08-03 21:30:05.514016836<br>
      638:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697144890<br>
      640:2023-08-03 21:30:05.546024372<br>
      641:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697147583<br>
      643:2023-08-03 21:30:05.584237211<br>
      644:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697150280<br>
      646:2023-08-03 21:30:05.614025918<br>
      647:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697152856<br>
      649:2023-08-03 21:30:05.646014419<br>
      650:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697155334<br>
      652:2023-08-03 21:30:05.670042958<br>
      653:some avg10=3.99 avg60=1.11 avg300=0.25 total=38697157696<br>
      655:2023-08-03 21:30:05.706027504<br>
      656:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697160413<br>
      658:2023-08-03 21:30:05.730024921<br>
      659:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697163116<br>
      661:2023-08-03 21:30:05.770026829<br>
      662:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697165892<br>
      664:2023-08-03 21:30:05.806011996<br>
      665:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697168589<br>
      667:2023-08-03 21:30:05.830011568<br>
      668:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697171305<br>
      670:2023-08-03 21:30:05.862039144<br>
      671:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697173671<br>
      673:2023-08-03 21:30:05.898008773<br>
      674:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697177020<br>
      676:2023-08-03 21:30:05.933796165<br>
      677:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697179742<br>
      679:2023-08-03 21:30:05.970058151<br>
      680:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697182438<br>
      682:2023-08-03 21:30:05.994037819<br>
      683:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697184468<br>
      685:2023-08-03 21:30:06.026022629<br>
      686:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697187165<br>
      688:2023-08-03 21:30:06.050024626<br>
      689:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697189526<br>
      691:2023-08-03 21:30:06.078013808<br>
      692:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697192230<br>
      694:2023-08-03 21:30:06.114030646<br>
      695:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697194603<br>
      697:2023-08-03 21:30:06.142038629<br>
      698:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697197296<br>
      700:2023-08-03 21:30:06.170044171<br>
      701:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697199658<br>
      703:2023-08-03 21:30:06.205670334<br>
      704:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697202692<br>
      706:2023-08-03 21:30:06.238037490<br>
      707:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697206060<br>
      709:2023-08-03 21:30:06.270024332<br>
      710:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697208087<br>
      712:2023-08-03 21:30:06.301784118<br>
      713:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697211461<br>
      715:2023-08-03 21:30:06.342039416<br>
      716:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697214160<br>
      718:2023-08-03 21:30:06.374013677<br>
      719:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697216861<br>
      721:2023-08-03 21:30:06.406040803<br>
      722:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697219559<br>
      724:2023-08-03 21:30:06.438006057<br>
      725:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697222256<br>
      727:2023-08-03 21:30:06.470026240<br>
      728:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697225629<br>
      730:2023-08-03 21:30:06.502024527<br>
      731:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697228305<br>
      733:2023-08-03 21:30:06.538033228<br>
      734:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697230686<br>
      736:2023-08-03 21:30:06.566028157<br>
      737:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697233689<br>
      739:2023-08-03 21:30:06.602025064<br>
      740:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697236080<br>
      742:2023-08-03 21:30:06.630027618<br>
      743:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697238780<br>
      745:2023-08-03 21:30:06.662010496<br>
      746:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697241478<br>
      748:2023-08-03 21:30:06.690014164<br>
      749:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697243510<br>
      751:2023-08-03 21:30:06.714031649<br>
      752:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697246207<br>
      754:2023-08-03 21:30:06.750026276<br>
      755:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697248907<br>
      757:2023-08-03 21:30:06.786014937<br>
      758:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697251609<br>
      760:2023-08-03 21:30:06.818017495<br>
      761:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697254643<br>
      763:2023-08-03 21:30:06.846013970<br>
      764:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697256667<br>
      766:2023-08-03 21:30:06.878168821<br>
      767:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697259367<br>
      769:2023-08-03 21:30:06.902022147<br>
      770:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697262083<br>
      772:2023-08-03 21:30:06.937999183<br>
      773:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697264777<br>
      775:2023-08-03 21:30:06.970022469<br>
      776:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697267479<br>
      778:2023-08-03 21:30:07.006018171<br>
      779:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697270171<br>
      781:2023-08-03 21:30:07.030035755<br>
      782:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697272873<br>
      784:2023-08-03 21:30:07.070024602<br>
      785:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697275913<br>
      787:2023-08-03 21:30:07.098024161<br>
      788:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697277932<br>
      790:2023-08-03 21:30:07.126038057<br>
      791:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697280293<br>
      793:2023-08-03 21:30:07.150014689<br>
      794:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697282324<br>
      796:2023-08-03 21:30:07.174011609<br>
      797:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697284688<br>
      799:2023-08-03 21:30:07.206006119<br>
      800:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697287664<br>
      802:2023-08-03 21:30:07.242013736<br>
      803:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697290389<br>
      805:2023-08-03 21:30:07.273763791<br>
      806:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697293757<br>
      808:2023-08-03 21:30:07.306027619<br>
      809:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697296435<br>
      811:2023-08-03 21:30:07.338033801<br>
      812:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697299155<br>
      814:2023-08-03 21:30:07.370014272<br>
      815:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697301335<br>
      817:2023-08-03 21:30:07.398049887<br>
      818:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697303375<br>
      820:2023-08-03 21:30:07.426030463<br>
      821:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306238<br>
      823:2023-08-03 21:30:07.446012112<br>
      824:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      826:2023-08-03 21:30:07.449074039<br>
      827:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      829:2023-08-03 21:30:07.452094902<br>
      830:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      832:2023-08-03 21:30:07.455132499<br>
      833:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      835:2023-08-03 21:30:07.458158709<br>
      836:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      838:2023-08-03 21:30:07.461160555<br>
      839:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      841:2023-08-03 21:30:07.464164844<br>
      842:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      844:2023-08-03 21:30:07.467191143<br>
      845:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      847:2023-08-03 21:30:07.470249391<br>
      848:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      850:2023-08-03 21:30:07.473268040<br>
      851:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      853:2023-08-03 21:30:07.476260894<br>
      854:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      856:2023-08-03 21:30:07.479273385<br>
      857:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      859:2023-08-03 21:30:07.482341558<br>
      860:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      862:2023-08-03 21:30:07.485402936<br>
      863:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      865:2023-08-03 21:30:07.488621116<br>
      866:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      868:2023-08-03 21:30:07.491648106<br>
      869:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      871:2023-08-03 21:30:07.494712160<br>
      872:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      874:2023-08-03 21:30:07.497741518<br>
      875:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      877:2023-08-03 21:30:07.500731815<br>
      878:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      880:2023-08-03 21:30:07.503757142<br>
      881:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      883:2023-08-03 21:30:07.506830439<br>
      884:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      886:2023-08-03 21:30:07.509933769<br>
      887:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      889:2023-08-03 21:30:07.512924245<br>
      890:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      892:2023-08-03 21:30:07.515952487<br>
      893:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      895:2023-08-03 21:30:07.519039796<br>
      896:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      898:2023-08-03 21:30:07.522058287<br>
      899:some avg10=4.71 avg60=1.34 avg300=0.30 total=38697306714<br>
      <br>
    </p>
    <pre class="moz-signature" cols="72">-- 
# Randy MacLeod
# Wind River Linux</pre>
  </body>
</html>

--------------kT0z2k0lDpWSVs7Qh2LTBFdI--

