Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7160C77B61
	for <webhook@archiver.kernel.org>; Fri,  7 Apr 2023 15:14:15 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.10722.1680880454851202449
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Apr 2023 08:14:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriver.com header.s=pps06212021 header.b=go/AVRVe;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=3461f0aec2=randy.macleod@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337EtgOo025145
	for <bitbake-devel@lists.openembedded.org>; Fri, 7 Apr 2023 08:14:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=content-type :
 message-id : date : subject : to : references : from : in-reply-to :
 mime-version; s=PPS06212021;
 bh=QBKhm3131k5bRDgBFU60sQlh9POMHG88yBHdtVw3+uY=;
 b=go/AVRVe2RKaKrv4xdaRFbnPvlontHSAsTq973c84ONa1W2rKOk1NNpvarFcRuYAHpYX
 mcYb8eeZhLQR/zaV+ChqrmT27kSvcg9+asC5nbag/360wcxAnPdkXgWuvchtEDI07LZG
 IBlYtdqDWuf3omcClHl1z8tzP2FV1yG5acp45w3za0EkU1/EzM2C649c4dyRL7NgBDrU
 IBNmjyT14pKFErq/PWhD6r6O7tW3jtG2GCxeKGlCI5aBvOXIxNQn5OsV9Px33+wYbDHX
 ruD2wT9Li3uh+c5wUhX5PYPFILuLueQXB7Ur6VmAztZ3VVFXQ0onBeSfEY9+CoqraNFZ 8Q== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ppfw6xy8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 07 Apr 2023 08:14:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wk61g4rNR2Lpcr+Rq3jBGwtNmhwKT0I+6tKyfzN5h8O9Up34yWvz45jR9pwZFmD2KpoIKwPp9U4uS/V4FA97mXT0479L+9y2kwc7XlsCpgf09Iip4/XnUltgEeF8gc5EPzI1o4NA1Y8cuFEyrgbUl7jZRZlWETRdYHsa2fdgjEQuXLv6nOcGjt9DDc2RfjPNrTSFSb/lPxnAlXkTo54NKgw3TxHl0ZUJbIIOJ8ID4dKtv2jNqYq1VBwZcd5clO4U0/B25RVFJJa4fiNclKY+8erCHU/Lor1xVFRb66VLPEesLtp2gENx+A8SToLk3ddMLBEqDXlj3RubF8PzaAoZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBKhm3131k5bRDgBFU60sQlh9POMHG88yBHdtVw3+uY=;
 b=Yzjo/xvkLTNYLYuV3quxfxta62Na905WPftrOshf5xm/R8wGpcMQPnD+feRwuwyLXm4zU13DiY71hUeh5B65Q8jwYE9eeCXQmMQXxMCI5TBKaKR//NuV66wpVA03ZOX3D9/Ib1wfQT6O3lvJQVDS7AOY/9sIoTusut2KSqHXIYlM3uJnB+YqZxcZp7SMURdGsIHe5kfr7bx4W6cn/vhZy11+6xzzzUXHOo9gyf7EWLUmk+Zi4QbtazcTWRO42XfeM0W6LWC7bW1zaYDRIVcUbvRYxHNwRKpBi+fK1lC6NFsLkmSb1WMmILJbUVIa8Djs2X1IDu98aAn6O5DvgpurWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB3994.namprd11.prod.outlook.com (2603:10b6:5:193::19)
 by BL1PR11MB5303.namprd11.prod.outlook.com (2603:10b6:208:31b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Fri, 7 Apr
 2023 15:14:08 +0000
Received: from DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::6e26:7321:99ab:72ab]) by DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::6e26:7321:99ab:72ab%3]) with mapi id 15.20.6277.031; Fri, 7 Apr 2023
 15:14:08 +0000
Content-Type: multipart/alternative;
 boundary="------------EMUFvWooMn21hiJY0UhMCNO5"
Message-ID: <1f95707f-9f5e-6ac2-8e8e-b905b9bcd400@windriver.com>
Date: Fri, 7 Apr 2023 11:14:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [bitbake-devel][PATCH 2/2] runqueue.py: use 'full' line for PSI
 check
Content-Language: en-CA
To: Qi.Chen@windriver.com, bitbake-devel@lists.openembedded.org
References: <20230407030715.4394-1-Qi.Chen@windriver.com>
 <20230407030715.4394-2-Qi.Chen@windriver.com>
From: Randy MacLeod <randy.macleod@windriver.com>
In-Reply-To: <20230407030715.4394-2-Qi.Chen@windriver.com>
X-ClientProxiedBy: BY3PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::30) To DM6PR11MB3994.namprd11.prod.outlook.com
 (2603:10b6:5:193::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3994:EE_|BL1PR11MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: a73bc231-6254-48f4-27a5-08db377abbfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vnurCjovAmnNo/dPOZPD+Z2PanxJy+r8u98+escuGUxgTebI8pwM5XNr+bjoSp+dysgUa/gWCSgMwpUY8ZeJS29V3RrfOKQcKtIyG4mePxQlEWFFdkMWAUVFFqIJ+r6pH8u+cnWc+MnNrNCv4GKap3ssS5UO6eBhke0a8gjpDdwRI34Ciyc9T8QIZTK6PhsS9KpUi5BapBTP+kfO/un3Njwh+S9wjB/pfeleLt+1dZMiTHWGlEKLeAK7eRTDwBOcatTIVXkok0IUzsLRN64BuBfElMy5FbkXUc7c+VYT1pFSiJxSqmIfZRuXFID/ioXKR+90ds0pzqd2DoHOaGiE1IVJ7arpRqEe7BVEh4nzfi4X8fNY4fobT4aRD+G7T5A2BMQ5I/njSb0idYvohY/kEDFukNvXlrnm3YTay5Khj6kbThyikYDTfeHL5hXgMKQdRXCK0uFGOjHlH2pdtI3vU2/hxw7vXQ1ASm0tWE7XSDP5r1ORUsDT8aoEs8BY7EwzobAqjXx4Wl2uAF+RbAJyphvESaffLdxcGrB/OgnnoHVzJ7RuXzsIISCgfB0GZVoR4tl2xfoTLSpub7+yf0TmDkxBo6b9YB2EXGBBQeMwZFi1Nx0yrGIu8CFY6H4V+G30cRuGr628YVki04gkoVSM4bih7PXdFc+XA0/iVcUdjMY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3994.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39850400004)(366004)(451199021)(66899021)(66946007)(31686004)(36756003)(38100700002)(21615005)(5660300002)(166002)(186003)(66556008)(31696002)(86362001)(8676002)(41300700001)(66476007)(8936002)(2616005)(83380400001)(966005)(53546011)(26005)(2906002)(6512007)(478600001)(6666004)(33964004)(6486002)(316002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZGhmRElOcEhpVVVtNU1Pb01rcE5aUFRYbllxSTJFU3ExS1NzVlZRN2dPK3lE?=
 =?utf-8?B?NVZMZ1E3YjlCT3N3NXZEYXhLdWluT1lCK3FJb2xJRWUzeUVKaEpmNUEwQWN1?=
 =?utf-8?B?NGF6U0tKMldjdlhhcy9DbHpveUFQaE9CbnJQR1htSzFwdUhHOVFVWnRRRUNN?=
 =?utf-8?B?cHlndmdLam5hL2lCK2kyK243bTNxREs0ZFJwMmhqMzFJS1lRWGh5cjBqUEFJ?=
 =?utf-8?B?YlJkMGxsTHJHRHl1YVF0RDVEMGxkWnZDaEh0QUZoSTlLOCs3YTBLd0kvQ1hj?=
 =?utf-8?B?M3VZZitTU2dFeFh4STd0N3BVcTdReklsOHZkU0w2NWFEVjFHeWFWd28yNjJB?=
 =?utf-8?B?NDhiT3pBUTRVRWFPeXZhTE1zWmlGdjRFN2grbVFRclRsMjhOT0JVbnVCdnJl?=
 =?utf-8?B?REY5Sk1MQnpPTkRGVm5vSis1dU5JbmRkN0Z3bVFvcGRqV2FLMVJsb3J6WGVG?=
 =?utf-8?B?UDRLbGdkb0RJNWJtdnI3Yjc0a2JrTXVFczFDenhxVk5DQlJRd3kyZFJyNWNs?=
 =?utf-8?B?NWtzOXhKRHcrWmx3TkRCUG5JSlJtTnJhYnlhWjRRUi9ETFRZRjRvZHl0S0cw?=
 =?utf-8?B?T3ljdUZqMXVIbXJkR0xxcTMvM1FGTTFva2xBMXEyMi9nR3Z5RDQ1MWZ1QTlj?=
 =?utf-8?B?cW9QNS90cDI4NmFON1Y1RFhNYW9ZbWUzMFlyZVpGcXJRVzZ3Z0RKYlBRQTQz?=
 =?utf-8?B?LzF5YjhVMFo2bjRGVkpmTTE5T2NkRnBKKzhENnZMSG9KMWxQWlJkUjJKOG0x?=
 =?utf-8?B?UXVId0krUmZIWU54TjZNWngyU1ExUkRoSU9vZm5mb3IxSThPcTUvZ3pQUFpq?=
 =?utf-8?B?bVdEbGx1ZCtRVDR1ZjN2N1pnK3owM1VGR0NtL0hOUXB3Vm1keGh0bThNejZt?=
 =?utf-8?B?di9xUFFYdDd1Z0hzWDVQMjcvellvR0tWWXZoVjUydGpOWXFFMkVIQ29LN0FN?=
 =?utf-8?B?eFJZTnFHNy9QYjJVSGp5Q3hFZTVqSTVxSUhKSVlmakdsK0MrOUJNRzlhU0lt?=
 =?utf-8?B?WmZEb1psQkgvSk5lMllhUERUZHhUYXoweE0zaXFXZ2VNOGI0cklyUm9QZWtn?=
 =?utf-8?B?NVRKdUR6RXk1UEhucDhwdGVvcTRqTVhHOVdtWmFna3FBRGlKUVErN0J4TW9H?=
 =?utf-8?B?b0tEU3ZOT3dBNDQ4Y21JTDVMSDRwOHlzTWxnc3NvODYwL3ZyOGJ2R0JLNi9P?=
 =?utf-8?B?d0VCVWFsWEEzaEVwNWFoRGhiNU9vU2s3TVhaODhYMW83YkYwOFltMVcyejFF?=
 =?utf-8?B?Si9Sc0x6QWFSQXFkdXpqRWl2TGdjMkJiaDdYdDJ1Y0Z0NmVkc0puaHFUVCtV?=
 =?utf-8?B?NmZUWGl0RVJTVHozSDVJVVVOWS9XMW5qdVowTDhnRkdscVFqTFdVbmdiUGIy?=
 =?utf-8?B?Qi9ZNElwaFlGa0RiWTgzVExzT3ZFUDdlYkxVZHVvOHJ0bXVUUUxJYjgvTGZZ?=
 =?utf-8?B?K3RxNGorSDFORmtpanVXQWl5RmVTVHhLSkVLeUhwaUFmd0dnUzVyYWovUVEw?=
 =?utf-8?B?NUxpNU5PSTBVTkdkZWpBT2h6YnFlU21abktrVThDQjEyUm11VFdGQ21PVVJv?=
 =?utf-8?B?U2NLOFh0U3RvZkUrZW1pSVBIZkVZdWZOUVUxV2xSZFVuc080bjd0N3dJaFJH?=
 =?utf-8?B?TkJ0TkVDMThpV0xLRTJOVjMxdFRVVTZyVEI2a0N2bkorUXoxMS9SNW9kUlFa?=
 =?utf-8?B?eG82K1ppMzNIOXZ5MjVTeVJiZW5iY05yWC9NYUZiSnMrQmVFMXRvWWVhRUs2?=
 =?utf-8?B?a0EzS1RiUCtFckpPaWU2dXBmZXNjQ01xKzZKZXdKdE9MS1VOM1ZPajVnaFlm?=
 =?utf-8?B?WlpNdmV6eHRxTkRsRFFuZCtmOTZlVSs3TWdsNDg2K0d3S1FJY2JwM0RJcEVE?=
 =?utf-8?B?endKa3NIUzFOSTMvOUc2MW1EMU5YR2FhMWc2SGZhTUY1bmZxSDJUcEFhVk93?=
 =?utf-8?B?VjBndWcwUEJGcnpWZlgvcW5qVDlrbmpYMUxPSnJyQUlmd3FGMGoxMW9adytq?=
 =?utf-8?B?cFM4ekF0YzhsNFFCUldRcmhUUzIrTlFXOU82MWhRWTZIQW1KVGJLcmtrTjZU?=
 =?utf-8?B?Y1UvdStFRmk5dU9PcHE5eDRBZC9ZdnVpSUhHWGowdGgzSWt1VE1vdEwvSXc5?=
 =?utf-8?B?UjFqUENKZkdMemt1enFHZUdrTEpMbWtiSTRrNS9uNGw3QUk1SHZ0aVE3Mms2?=
 =?utf-8?B?MlE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73bc231-6254-48f4-27a5-08db377abbfc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3994.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 15:14:08.3590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmm7wCZ1ssmtfnGLG5FK9NFqdA/Cm3U64EhCIKx3trYLQoMfJNU5MiG7jQxo41ozcy7INuVr3jxDivKQ8XqUKMY9y7VDU8pE4zyEVFppLiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5303
X-Proofpoint-ORIG-GUID: y7qeUAIgxluDKuiMUXknUad0IRD35P_D
X-Proofpoint-GUID: y7qeUAIgxluDKuiMUXknUad0IRD35P_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_10,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 mlxlogscore=808 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070139
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Apr 2023 15:14:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14685

--------------EMUFvWooMn21hiJY0UhMCNO5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 337EtgOo025145

On 2023-04-06 23:07, Chen Qi via lists.openembedded.org wrote:
> According to kernel PSI doc[1], for /proc/pressure/* interface files,
> the first line is the 'some' line and the second line is the 'full'
> line.
>
> Quoting from the doc:
> """
> The "some" line indicates the share of time in which at least some task=
s
> are stalled on a given resource.
>
> The "full" line indicates the share of time in which all non-idle tasks
> are stalled on a given resource simultaneously. In this state actual CP=
U
> cycles are going to waste, and a workload that spends extended time in =
this
> state is considered to be thrashing. This has severe impact on performa=
nce,
> and it=E2=80=99s useful to distinguish this situation from a state wher=
e some tasks
> are stalled but the CPU is still doing productive work.
> """
>
> We can see that the 'full' line is a better measurement to check if thi=
ngs are
> slowed down as a whole.
>
> Also, the /proc/pressure/cpu's 'full' line may not be available on some=
 systems,
> so fall back to the 'some' line.
>
> [1]https://www.kernel.org/doc/html/latest/accounting/psi.html

NACK...

I'd need to dig up or reproduce some test cases but I believe that
we should NOT use 'full' instead of 'some'. We want to have a *lower*=20
threshold

to defer work when the system resources are experiencing pressure.
We don't want to wait for the system to get to a state where all of the
resources are under pressure.


There may be use cases involving containers where the 'full' PSI info
is more useful or even essential but need a motivating example.


../Randy

>
> Signed-off-by: Chen Qi<Qi.Chen@windriver.com>
> ---
>   bitbake/lib/bb/runqueue.py | 23 +++++++++++++++--------
>   1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 02f1474540..e3198dcdeb 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -173,10 +173,13 @@ class RunQueueScheduler(object):
>                   with open("/proc/pressure/cpu") as cpu_pressure_fds, =
\
>                       open("/proc/pressure/io") as io_pressure_fds, \
>                       open("/proc/pressure/memory") as memory_pressure_=
fds:
> -
> -                    self.prev_cpu_pressure =3D cpu_pressure_fds.readli=
ne().split()[4].split("=3D")[1]
> -                    self.prev_io_pressure =3D io_pressure_fds.readline=
().split()[4].split("=3D")[1]
> -                    self.prev_memory_pressure =3D memory_pressure_fds.=
readline().split()[4].split("=3D")[1]
> +                    cpu_lines =3D cpu_pressure_fds.readlines()
> +                    if len(cpu_lines) =3D=3D 1:
> +                        self.prev_cpu_pressure =3D cpu_lines[0].split(=
)[4].split("=3D")[1]
> +                    else:
> +                        self.prev_cpu_pressure =3D cpu_lines[1].split(=
)[4].split("=3D")[1]
> +                    self.prev_io_pressure =3D io_pressure_fds.readline=
s()[1].split()[4].split("=3D")[1]
> +                    self.prev_memory_pressure =3D memory_pressure_fds.=
readlines()[1].split()[4].split("=3D")[1]
>                       self.prev_pressure_time =3D time.time()
>                   self.check_pressure =3D True
>               except:
> @@ -194,10 +197,14 @@ class RunQueueScheduler(object):
>               with open("/proc/pressure/cpu") as cpu_pressure_fds, \
>                   open("/proc/pressure/io") as io_pressure_fds, \
>                   open("/proc/pressure/memory") as memory_pressure_fds:
> -                # extract "total" from /proc/pressure/{cpu|io}
> -                curr_cpu_pressure =3D cpu_pressure_fds.readline().spli=
t()[4].split("=3D")[1]
> -                curr_io_pressure =3D io_pressure_fds.readline().split(=
)[4].split("=3D")[1]
> -                curr_memory_pressure =3D memory_pressure_fds.readline(=
).split()[4].split("=3D")[1]
> +                # extract "total" from /proc/pressure/{cpu|io|memory}
> +                cpu_lines =3D cpu_pressure_fds.readlines()
> +                if len(cpu_lines) =3D=3D 1:
> +                    curr_cpu_pressure =3D cpu_lines[0].split()[4].spli=
t("=3D")[1]
> +                else:
> +                    curr_cpu_pressure =3D cpu_lines[1].split()[4].spli=
t("=3D")[1]
> +                curr_io_pressure =3D io_pressure_fds.readlines()[1].sp=
lit()[4].split("=3D")[1]
> +                curr_memory_pressure =3D memory_pressure_fds.readlines=
()[1].split()[4].split("=3D")[1]
>                   now =3D time.time()
>                   tdiff =3D now - self.prev_pressure_time
>                   if tdiff > 1.0:
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14683):https://lists.openembedded.org/g/bitbake-dev=
el/message/14683
> Mute This Topic:https://lists.openembedded.org/mt/98118923/3616765
> Group Owner:bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:https://lists.openembedded.org/g/bitbake-devel/unsub  [rand=
y.macleod@windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

--=20
# Randy MacLeod
# Wind River Linux

--------------EMUFvWooMn21hiJY0UhMCNO5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 337EtgOo025145

<html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">On 2023-04-06 23:07, Chen Qi via
      lists.openembedded.org wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:20230407030715.4394-2-Qi.Chen@w=
indriver.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">According to kernel PSI doc[=
1], for /proc/pressure/* interface files,
the first line is the 'some' line and the second line is the 'full'
line.

Quoting from the doc:
&quot;&quot;&quot;
The &quot;some&quot; line indicates the share of time in which at least s=
ome tasks
are stalled on a given resource.

The &quot;full&quot; line indicates the share of time in which all non-id=
le tasks
are stalled on a given resource simultaneously. In this state actual CPU
cycles are going to waste, and a workload that spends extended time in th=
is
state is considered to be thrashing. This has severe impact on performanc=
e,
and it=E2=80=99s useful to distinguish this situation from a state where =
some tasks
are stalled but the CPU is still doing productive work.
&quot;&quot;&quot;

We can see that the 'full' line is a better measurement to check if thing=
s are
slowed down as a whole.

Also, the /proc/pressure/cpu's 'full' line may not be available on some s=
ystems,
so fall back to the 'some' line.

[1] <a class=3D"moz-txt-link-freetext" href=3D"https://www.kernel.org/doc=
/html/latest/accounting/psi.html">https://www.kernel.org/doc/html/latest/=
accounting/psi.html</a></pre>
    </blockquote>
    <p>NACK...<br>
    </p>
    <p>I'd need to dig up or reproduce some test cases but I believe
      that <br>
      we should NOT use 'full' instead of 'some'. We want to have a
      *lower* threshold&nbsp; <br>
    </p>
    <p>to defer work when the system resources are experiencing
      pressure.<br>
      We don't want to wait for the system to get to a state where all
      of the <br>
      resources are under pressure.</p>
    <p><br>
    </p>
    <p>There may be use cases involving containers where the 'full' PSI
      info <br>
      is more useful or even essential but need a motivating example.<br>
    </p>
    <p><br>
    </p>
    <p>../Randy<br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:20230407030715.4394-2-Qi.Chen@w=
indriver.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">

Signed-off-by: Chen Qi <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:=
Qi.Chen@windriver.com">&lt;Qi.Chen@windriver.com&gt;</a>
---
 bitbake/lib/bb/runqueue.py | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 02f1474540..e3198dcdeb 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -173,10 +173,13 @@ class RunQueueScheduler(object):
                 with open(&quot;/proc/pressure/cpu&quot;) as cpu_pressur=
e_fds, \
                     open(&quot;/proc/pressure/io&quot;) as io_pressure_f=
ds, \
                     open(&quot;/proc/pressure/memory&quot;) as memory_pr=
essure_fds:
-
-                    self.prev_cpu_pressure =3D cpu_pressure_fds.readline=
().split()[4].split(&quot;=3D&quot;)[1]
-                    self.prev_io_pressure =3D io_pressure_fds.readline()=
.split()[4].split(&quot;=3D&quot;)[1]
-                    self.prev_memory_pressure =3D memory_pressure_fds.re=
adline().split()[4].split(&quot;=3D&quot;)[1]
+                    cpu_lines =3D cpu_pressure_fds.readlines()
+                    if len(cpu_lines) =3D=3D 1:
+                        self.prev_cpu_pressure =3D cpu_lines[0].split()[=
4].split(&quot;=3D&quot;)[1]
+                    else:
+                        self.prev_cpu_pressure =3D cpu_lines[1].split()[=
4].split(&quot;=3D&quot;)[1]
+                    self.prev_io_pressure =3D io_pressure_fds.readlines(=
)[1].split()[4].split(&quot;=3D&quot;)[1]
+                    self.prev_memory_pressure =3D memory_pressure_fds.re=
adlines()[1].split()[4].split(&quot;=3D&quot;)[1]
                     self.prev_pressure_time =3D time.time()
                 self.check_pressure =3D True
             except:
@@ -194,10 +197,14 @@ class RunQueueScheduler(object):
             with open(&quot;/proc/pressure/cpu&quot;) as cpu_pressure_fd=
s, \
                 open(&quot;/proc/pressure/io&quot;) as io_pressure_fds, =
\
                 open(&quot;/proc/pressure/memory&quot;) as memory_pressu=
re_fds:
-                # extract &quot;total&quot; from /proc/pressure/{cpu|io}
-                curr_cpu_pressure =3D cpu_pressure_fds.readline().split(=
)[4].split(&quot;=3D&quot;)[1]
-                curr_io_pressure =3D io_pressure_fds.readline().split()[=
4].split(&quot;=3D&quot;)[1]
-                curr_memory_pressure =3D memory_pressure_fds.readline().=
split()[4].split(&quot;=3D&quot;)[1]
+                # extract &quot;total&quot; from /proc/pressure/{cpu|io|=
memory}
+                cpu_lines =3D cpu_pressure_fds.readlines()
+                if len(cpu_lines) =3D=3D 1:
+                    curr_cpu_pressure =3D cpu_lines[0].split()[4].split(=
&quot;=3D&quot;)[1]
+                else:
+                    curr_cpu_pressure =3D cpu_lines[1].split()[4].split(=
&quot;=3D&quot;)[1]
+                curr_io_pressure =3D io_pressure_fds.readlines()[1].spli=
t()[4].split(&quot;=3D&quot;)[1]
+                curr_memory_pressure =3D memory_pressure_fds.readlines()=
[1].split()[4].split(&quot;=3D&quot;)[1]
                 now =3D time.time()
                 tdiff =3D now - self.prev_pressure_time
                 if tdiff &gt; 1.0:
</pre>
      <br>
      <fieldset class=3D"moz-mime-attachment-header"></fieldset>
      <pre class=3D"moz-quote-pre" wrap=3D"">-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#14683): <a class=3D"moz-txt-link-freetext" href=3D"ht=
tps://lists.openembedded.org/g/bitbake-devel/message/14683">https://lists=
.openembedded.org/g/bitbake-devel/message/14683</a>
Mute This Topic: <a class=3D"moz-txt-link-freetext" href=3D"https://lists=
.openembedded.org/mt/98118923/3616765">https://lists.openembedded.org/mt/=
98118923/3616765</a>
Group Owner: <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:bitbake=
-devel+owner@lists.openembedded.org">bitbake-devel+owner@lists.openembedd=
ed.org</a>
Unsubscribe: <a class=3D"moz-txt-link-freetext" href=3D"https://lists.ope=
nembedded.org/g/bitbake-devel/unsub">https://lists.openembedded.org/g/bit=
bake-devel/unsub</a> [<a class=3D"moz-txt-link-abbreviated" href=3D"mailt=
o:randy.macleod@windriver.com">randy.macleod@windriver.com</a>]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

</pre>
    </blockquote>
    <p><br>
    </p>
    <pre class=3D"moz-signature" cols=3D"72">--=20
# Randy MacLeod
# Wind River Linux</pre>
  </body>
</html>

--------------EMUFvWooMn21hiJY0UhMCNO5--

