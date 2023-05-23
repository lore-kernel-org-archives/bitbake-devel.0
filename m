Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92ADC7EE29
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 23:24:23 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.18199.1684884259158758230
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 23 May 2023 16:24:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriver.com header.s=pps06212021 header.b=pstHppq1;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=450754b2d1=randy.macleod@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NLr6Og019021
	for <bitbake-devel@lists.openembedded.org>; Tue, 23 May 2023 16:24:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=PPS06212021;
 bh=P+H9RsQM2rICKObOobpCs1sLKHs+RzE73gbQ7+r78wg=;
 b=pstHppq1SmmBefFHFSnhjwtL9OHENMU6xGPd8W/CGJA0surmqHBMmw+FIDGLewKfaLMg
 AqZ/WcPn8MPB5bkOSMHaJ6zZPUodDpMXv+nKxDydDpGnd7ciiATkQSf0Z4uGdIjGj8eQ
 u1tqmyearVGYns8xiI6wZUXojFizDUA0p2EUQWgehJ821q0t0nPmnxEAbc2TJe8a/tts
 tWK0dQU/WGcsIOZ5f8iHnm7On8LO2ExPgGge/WgIv7AqnBwqxXdvg6R45kXbLrQ8kOdY
 gsXTSQBz9JVk6NjCfqv3m3qX0/SET4Ptsav/0eFUaAQ6LvAw/XHHDR5JaIpEzWPgMFNl 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qpsg1k8wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 23 May 2023 16:24:18 -0700
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34NNKR5R025435
	for <bitbake-devel@lists.openembedded.org>; Tue, 23 May 2023 16:24:18 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qpsg1k8w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 May 2023 16:24:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hO9RuSbopshJAZKlUBcRXna23XF8ZchOcNrfYxXU3Xh/nOzqePPRZ7KEPrfIXxQeDTux0CKubazGSVS2ikqOFUAXT1TqMazav3ZnUqO3Nntn8INW1Dh00a1pvaU5fcuubx0Y+EklCcsbpyaHUBqifcK0zL2DqQLD5TEBF3CAhjmNE8mKI+TMYr2cdQlOxJ6dI7xBoLXHjDGMLIktNqELcsYkmfxzTzD26sjeoM1Fz/0pXiBLD11M5sXRorodGPPDreOePPY9MIM2XsfN59cn+chOtuYgIBBUAbrwJD+n7JDVd9ymVUQemBTb/jtqABSMR7EQz+wlzpxRR3/o+1CBoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+H9RsQM2rICKObOobpCs1sLKHs+RzE73gbQ7+r78wg=;
 b=cE5OXA6kxlt0v0M5QZtEiKmyukm6FEM7Jg5EftNteiCz9oK+v9LVxc6c0Kmpsy6ovCqzozSSVOUseuXcxY114PO7Eke0qkpgjDKlL42HRDCIj+hmMsIJccCAZlHrDlnP7G2DplehvPvXr4YrlS9y+ZdhyamEx7/KCp1OUmstspciKQlAmYig/o/h7YdCKfZ28R7FlBZJm9jQe1NGiSTfu9XkTEBOG8+jGeas7KtBmzU/ZZr1ZTNObFRbe+RuDtILtdrsDutOUZ93tA7MzUjTLEE6zWV8p2He3UhDShGlEXBcSaXnpHBtT8OUt5lTN85IcmtD4KNDR1lUHvpA/E/V7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB3994.namprd11.prod.outlook.com (2603:10b6:5:193::19)
 by SA2PR11MB5209.namprd11.prod.outlook.com (2603:10b6:806:110::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 23:24:14 +0000
Received: from DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::a2e6:a5d4:b628:fa7f]) by DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::a2e6:a5d4:b628:fa7f%6]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 23:24:14 +0000
Content-Type: multipart/alternative;
 boundary="------------Uv6ZRb0wShUUrFjSIHWuWzcX"
Message-ID: <a963a98b-0420-5785-b393-306ebbf6f230@windriver.com>
Date: Tue, 23 May 2023 19:24:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [bitbake-devel][PATCH V2] runqueue.py: fix PSI check logic
Content-Language: en-CA
To: Qi.Chen@windriver.com, bitbake-devel@lists.openembedded.org
Cc: ola.x.nilsson@axis.com
References: <20230523020905.2911543-1-Qi.Chen@windriver.com>
From: Randy MacLeod <randy.macleod@windriver.com>
In-Reply-To: <20230523020905.2911543-1-Qi.Chen@windriver.com>
X-ClientProxiedBy: SJ2PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:a03:505::6) To DM6PR11MB3994.namprd11.prod.outlook.com
 (2603:10b6:5:193::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3994:EE_|SA2PR11MB5209:EE_
X-MS-Office365-Filtering-Correlation-Id: 77aee9e2-9960-4c3b-153e-08db5be4d258
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VZVerUUuGC/FyE+GTRJDrwwyuoD0Aj2S53TfhLn8XzXQf90kP8LSYp4ZANP4BHMjf1V4YQsJSqz+x0diuqLlncVyN0AGz2l8S37/ejDQGkSzPoaKpjerl6fPHNYgeLidVUmfG8S2PU4d1bIaZVIExgmaco9xARanlJz3XTyk0KiQbCtGggJSWarEkvt8YA+mh8RmEfoLEEPvT7acFG36KUJOpkoFSn4RLskf8WzJPXFlclpcfcsUYe28iZcHWqAazBlI5KUUz6F6ki5QVN1DW1ly+3SY00uMXfymSg5G5/lY6RfZFTcq4yaRBAsR4yvYCcE4eeTXiGmG13FRGiwec1LQ1O08O91LJXyyq30cp5UgmHvOKFIz/fvFIPBOBieALtqoeQUj2Z9mBotigkQaijksvy+oxPvLHDuu6VLf3zXfAJOUoHy5QDCLwib1G05vLVpsYHaxVzmybdhG3SQhApvHeqEbvEzuAcf1TsGNzTBZ+p1sk3LA95rvDULb2E3rsRJaRpeJs7IXNkpcObdTpirHJ6x7EbHDiGhRTeE+B0UeC+txDGD59YuFZ3NctkXR/dv2/S6vTPrfX67vYDhN7Zao/WhgbooOpl7NoSGdHxXRk9GteLu1WgQezNRkxxBWpR3F7sdAjr+l5kNhgYyUMw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3994.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39850400004)(366004)(346002)(376002)(451199021)(31686004)(66946007)(66556008)(66476007)(478600001)(41300700001)(6486002)(33964004)(6666004)(316002)(31696002)(5660300002)(86362001)(8936002)(4326008)(8676002)(38100700002)(53546011)(186003)(6506007)(26005)(2906002)(6512007)(83380400001)(2616005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YjdDWFIyZXcxbWNTcWhXS2hkVVhkWWlDQ0Rma0pBdXdadDFmc1VzcENtTThG?=
 =?utf-8?B?dHVCalBDYi9oTVIyUHdJUi9jSzZPZm5uVlZaT1ZOZHcxay9uc2IvaU1GMmFW?=
 =?utf-8?B?Q3h3UFVwNHFKY3ZQMmc0cWg1YStkMnZHdmZibkZKQm9TUyszcjJneFRXajg1?=
 =?utf-8?B?UEZrdGlDMEVUUTNYV1drZXMwYjJxTjdTUXd5VlVKUlhWUk5FUjluQS81dVhi?=
 =?utf-8?B?dkdmcFhtSkdKNitqZHV3OHI1V1RsdmF3eFJtT3Jrb3JZeDZsV2lDMzdueXBY?=
 =?utf-8?B?ZDk3bFNmUGlXM3NHSzJ3bVUxM0FPUTg5bTN4WTdndVNzV3lybkJQelRpN3hj?=
 =?utf-8?B?YnNod0p0SHVCRGY1SmUva0dSOWtUbndrSmJLcTFTZ0dENUJNb0EvQkZLUkVW?=
 =?utf-8?B?a0JvbzNOaTkxVVVWbVRlcmMvR3ZaTUhYeGJGUytvemNtYVNjOEk2NGJQSG5Z?=
 =?utf-8?B?OEhwU3dSaC9MV0VtWW5VYitqWTNJUkQyYmE0cGhnUURtUU14bkN1ZGpsemE5?=
 =?utf-8?B?bmM0dVdBNGlmeExNZ01JVGVycWdZZ3I3OWhhMlpaeVlPMkJWRnVzOGhkQVQ0?=
 =?utf-8?B?bEhVYk5oKzdNU05GY0pKNEwvWVMwQWJ3d3ljekNZV2k2NWEvdXJ3R3hvbEo0?=
 =?utf-8?B?RW44SmJ4UjNZam4xYmlSekhRV2JPSTZacHNaOHJZOW5OcWJrWVVoRi8rbHVJ?=
 =?utf-8?B?UEtzaHdaUWJxUnhHU2ZwUFplVFhXRVJmZ3FTbWpIWVNJUWljM3NxRWM4cVlD?=
 =?utf-8?B?OWtoYlZNYy85VnZSdVpTb2J2MDNEWG5kQnZyTlJ4bXpBS1hMN1d1dWJtN29H?=
 =?utf-8?B?RGNrOHA5aUtvRytqbjYxRUlqMHp6dGNJY1Vac0F4bGhPNi9ma21UdDJlTVkz?=
 =?utf-8?B?dlJrTm1FTGVlSEdFeERXSFh4MXhIVkZxN1Z0RU1iVExSZDY5UHBqZmZIMFhs?=
 =?utf-8?B?WGE0TE1BU0NMNUdDdHI2SHQxRVFvd0phM2ZVeW9rTElzbk9STlRFbUhtSVcr?=
 =?utf-8?B?eGRBYisybXhXRG1nK2wvYytDVU9RVHdSZG1TZ2hFR3laSXdQUWRtSFNtdWdM?=
 =?utf-8?B?cEUwT3VwUmxkcGovZ0NPbVdWZTRrVWtJbTVwdUhvcnBVWnJsRHlpbVNacS9R?=
 =?utf-8?B?WEErK2dOQ1ZxdFNnV2liSTg5WUR0eTRoQ0VKQ2ZUd1A5RWNVK00yN2JtTHd1?=
 =?utf-8?B?aENaUzhuVmtlLzdyOHpaRk80VytmWmNOaGgzYnZvWFZIUkM5N1hYendEeEdG?=
 =?utf-8?B?S2RuUllvL01wVTN1V3ppS2NEa3JCWnE3Sy9XQW05RmJPNVVZNFpWOWZpWDA0?=
 =?utf-8?B?KzQ4WjdUQ3ZqTkxHdVM0VU9RZzRlbWF4Tlptc3BkUEpkcmF5VHRDR0lFV0lo?=
 =?utf-8?B?TTBjeXJaTmljVjRKRVFOcmJuUWN0VG81T25RZ1lqTVVKMkdyZ1gzclA4dnov?=
 =?utf-8?B?Z0JzcUEvaU5IbXU5SEZVaXJrSmhXeXBuQzhQa2FIUm1aWHdvdjVVSWJnczdr?=
 =?utf-8?B?djdCdFNwenFXNXdyTFlDL0t4RFE0ZkUxSFZVM2RDQ3dYanFJeXRwMTdKU3Nr?=
 =?utf-8?B?UTY4ZTRrQTVEU25rRmo1cjV1U2RnVVMrb2ZadDhJS29Ja0FYS2FyWUlxL3hU?=
 =?utf-8?B?cnp0Rk1LTmhaMUIvc09uVnRYS2VLMnZoV2VhQmNpQlJ2ZEFSajVBUk52dDZs?=
 =?utf-8?B?QzZOWDZGUlRWTEdWdDFRSmRrSmRxUE55ZG9sZlNlK2dSZi80TURGUEJNdUNV?=
 =?utf-8?B?cUV3U3had2FQN2srZzZqNEQyZ01lVEtCSWZCMUwxSE95T2d1T2FPeWwwNjZx?=
 =?utf-8?B?alA2SXNrbnlnLzJibFRJa3JRZGkwY1p1R0RPelRwYnRTR2kyd2dwOXNmRUZH?=
 =?utf-8?B?cEYwcVJNVFVKVzZBUU9ES3g4QmVFbXlaWXVBaStsVHVrcTQ5TjAxY0pyMElT?=
 =?utf-8?B?QzE3UDlGckRZNklnS1VCc3dhb1pHQUdNSzNBczVKc3JGc1hOTmg4cW9YNG01?=
 =?utf-8?B?cE12QWxva21aV012Mlp6UjljZEdNWGlmTWhDN3ozM3VnVjEvY283RlZqUUx5?=
 =?utf-8?B?M1BQWjczdHBiNi9XRUlvMjNUendRdTZUcTVQc0pFUTVvSHdPSEVrUG5FcjUw?=
 =?utf-8?B?WTd1MVA2Y29mb2VkSHJPZ2JHTVQ3SjQ3eThTM0traHdGU2N6NEpRbHVrT09w?=
 =?utf-8?B?d2c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77aee9e2-9960-4c3b-153e-08db5be4d258
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3994.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 23:24:14.4233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nbUX2xbVbfyUv1p6ylxKD1o/2JKoIR6+uwkMl9epQsUQf2LtiidrZ6zYKR5/tRb0wvTMGaJIfKWrcAWRMnf+cA3/Oj9byDO4l7gcE0+9nIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5209
X-Proofpoint-GUID: aQ1ryj9QNatXGopTkniZwfAGqUWcMNCc
X-Proofpoint-ORIG-GUID: ciWNRNrgJdd6GNF_R-JWSOYZVwEytSJQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_15,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230188
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 23 May 2023 23:24:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14801

--------------Uv6ZRb0wShUUrFjSIHWuWzcX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 34NLr6Og019021

On 2023-05-22 22:09, Qi.Chen@windriver.com wrote:
> From: Chen Qi<Qi.Chen@windriver.com>
>
> The current logic is not correct because if the time interval
> between the current check and the last check is very small, the PSI
> checker is not likely to block things even if the system is heavy
> loaded.
>
> It's not good to calculate the value too often. So we change to a 1s
> check. As a build will usually take at least minutes, using the 1s valu=
e
> seems reasonable.

I don't have time to check today but I'm not convinced that this is true.

I suspect that in the typical case, it would be okay but there will be
workloads (perhaps rare workloads) where you want to check more often.

The 1 second intervals where we no longer launch new work may
result in a significantly longer build. IIRC, our benchmark was building
core-image-minimal on a 24 core system without PSI regulation and then
with it set to 300. I'd look at the elapsed time and the=20
buildchart/bootchart:
 =C2=A0=C2=A0 scripts/pybootchartgui/README.pybootchart

Ola, have you been able to test this and if not, can you?

All for today.

../Randy


>
> Signed-off-by: Chen Qi<Qi.Chen@windriver.com>
> ---
>   bitbake/lib/bb/runqueue.py | 29 ++++++++++++++---------------
>   1 file changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 02f1474540..4d49d25153 100644
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
> @@ -191,6 +192,10 @@ class RunQueueScheduler(object):
>           BB_PRESSURE_MAX_{CPU|IO|MEMORY} are set, return True if above=
 threshold.
>           """
>           if self.check_pressure:
> +            now =3D time.time()
> +            tdiff =3D now - self.prev_pressure_time
> +            if tdiff < 1.0:
> +                return self.psi_exceeded
>               with open("/proc/pressure/cpu") as cpu_pressure_fds, \
>                   open("/proc/pressure/io") as io_pressure_fds, \
>                   open("/proc/pressure/memory") as memory_pressure_fds:
> @@ -198,21 +203,15 @@ class RunQueueScheduler(object):
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
> -            return (exceeds_cpu_pressure or exceeds_io_pressure or exc=
eeds_memory_pressure)
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
> +            return self.psi_exceeded
>           return False
>  =20
>       def next_buildable_task(self):


--=20
# Randy MacLeod
# Wind River Linux

--------------Uv6ZRb0wShUUrFjSIHWuWzcX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2023-05-22 22:09,
      <a class="moz-txt-link-abbreviated" href="mailto:Qi.Chen@windriver.com">Qi.Chen@windriver.com</a> wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20230523020905.2911543-1-Qi.Chen@windriver.com">
      <pre class="moz-quote-pre" wrap="">From: Chen Qi <a class="moz-txt-link-rfc2396E" href="mailto:Qi.Chen@windriver.com">&lt;Qi.Chen@windriver.com&gt;</a>

The current logic is not correct because if the time interval
between the current check and the last check is very small, the PSI
checker is not likely to block things even if the system is heavy
loaded.

It's not good to calculate the value too often. So we change to a 1s
check. As a build will usually take at least minutes, using the 1s value
seems reasonable.</pre>
    </blockquote>
    <p>I don't have time to check today but I'm not convinced that this
      is true.</p>
    <p>I suspect that in the typical case, it would be okay but there
      will be<br>
      workloads (perhaps rare workloads) where you want to check more
      often.</p>
    <p>The 1 second intervals where we no longer launch new work may<br>
      result in a significantly longer build. IIRC, our benchmark was
      building<br>
      core-image-minimal on a 24 core system without PSI regulation and
      then<br>
      with it set to 300. I'd look at the elapsed time and the
      buildchart/bootchart:&nbsp; <br>
      &nbsp;&nbsp; scripts/pybootchartgui/README.pybootchart</p>
    <p>Ola, have you been able to test this and if not, can you?<br>
    </p>
    <p>All for today.<br>
    </p>
    <p>../Randy<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20230523020905.2911543-1-Qi.Chen@windriver.com">
      <pre class="moz-quote-pre" wrap="">

Signed-off-by: Chen Qi <a class="moz-txt-link-rfc2396E" href="mailto:Qi.Chen@windriver.com">&lt;Qi.Chen@windriver.com&gt;</a>
---
 bitbake/lib/bb/runqueue.py | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 02f1474540..4d49d25153 100644
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
@@ -191,6 +192,10 @@ class RunQueueScheduler(object):
         BB_PRESSURE_MAX_{CPU|IO|MEMORY} are set, return True if above threshold.
         &quot;&quot;&quot;
         if self.check_pressure:
+            now = time.time()
+            tdiff = now - self.prev_pressure_time
+            if tdiff &lt; 1.0:
+                return self.psi_exceeded
             with open(&quot;/proc/pressure/cpu&quot;) as cpu_pressure_fds, \
                 open(&quot;/proc/pressure/io&quot;) as io_pressure_fds, \
                 open(&quot;/proc/pressure/memory&quot;) as memory_pressure_fds:
@@ -198,21 +203,15 @@ class RunQueueScheduler(object):
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
-            return (exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure)
+                exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff &gt; self.rq.max_cpu_pressure
+                exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff &gt; self.rq.max_io_pressure
+                exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) / tdiff &gt; self.rq.max_memory_pressure
+                self.prev_cpu_pressure = curr_cpu_pressure
+                self.prev_io_pressure = curr_io_pressure
+                self.prev_memory_pressure = curr_memory_pressure
+                self.prev_pressure_time = now
+                self.psi_exceeded = exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure
+            return self.psi_exceeded
         return False
 
     def next_buildable_task(self):
</pre>
    </blockquote>
    <p><br>
    </p>
    <pre class="moz-signature" cols="72">-- 
# Randy MacLeod
# Wind River Linux</pre>
  </body>
</html>

--------------Uv6ZRb0wShUUrFjSIHWuWzcX--

