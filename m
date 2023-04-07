Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F00C77B61
	for <webhook@archiver.kernel.org>; Fri,  7 Apr 2023 15:02:15 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.10466.1680879734320356065
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 07 Apr 2023 08:02:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriver.com header.s=pps06212021 header.b=jDznOXNj;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=3461f0aec2=randy.macleod@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337EmDsW013179
	for <bitbake-devel@lists.openembedded.org>; Fri, 7 Apr 2023 15:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=content-type :
 message-id : date : subject : to : references : from : in-reply-to :
 mime-version; s=PPS06212021;
 bh=1DGT4EnUdbT8bsgY7PiZHSbga8B04e9kAEyDHn+92hs=;
 b=jDznOXNjA9X66SLuJ0LIYX9F298LPwArali0mn215uQYIFKExGcQo7R57BkrTDOU7Thc
 8hJPI3ozA87dlteqojxUZZsEgm1qEfyGki52/oe+inBcOJGLv+PUWdGz4u/ufMpoqUBH
 jRwkaFwIqkZpUFjcHO1y/zo+A00XynirvrmAvSDaEZ5hNRSTa+Ow1L0lUxu7FXCog6cy
 vdnOmhQdGCyaEx/WIIEnxhb6cy25psRvbtbwPs2A1NhTM79uYIz0FI8OAwypPU4GvWD4
 TiIJTtIxGbD0n53IPOwZsAQ7GNJ2OAUqKzx3jUzDvjV8x2oS5uHkJOW+3VYMg7qrbBzh wA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3pp9u4q3yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 07 Apr 2023 15:02:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAzf9Vawut0BN6a70AQpvpxfH31gWQa4FSpV+eCYhGBReaPrjTPrSLRfMKso4rsEBoDqubxtY0ybYWwcI0fmgKp07Xj9d5bdHN6K8gVmMG4J81qgh/C2MLP41VsN5KcBMIzmJxkkn6VQuPzr12Jr+xBiHG6mPKgZBB9p9ZcFAc9ph0133JKsUNkKwJCpDbL4JkpQv7MKN7eBG3VPP5IDQijy1V9K/nWLJTUTRzwoMMQr980N07+rMFnN28c0B91bbeY0fOngBELY7NmOmfufxc8HOjxZKKXDTzVdQ8mpH2CpfGiGkqFJe9L8onBld5XTka27Tpm6D0JVVMg0JW+D4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DGT4EnUdbT8bsgY7PiZHSbga8B04e9kAEyDHn+92hs=;
 b=R3TY6HZJ89urTZ61bjXalj1bbvOG13umyPwhkDjGHCFLQlRin7ADzZI7on9UW4FUU91jJ0h49Jp5iJ2zmVrYP//E76zJClWmAFGWv47w4t6JOap4fKRCP+u1mgRhCRjEzpzVr8iCRxHEEWvHZ1JbTlUgRkw30Kk2iYCMXbk2aO+DSXONccdt2IR8bwvpgHaiB4GgL3O7GiHQ6CD0qQpJfA1+FS+KbSBOkSiz4o/gWGX6+WoXLVb1j03V/DvRWUd8T3f3za6fQZOFkeOAyGVYRz6cPfGN/dQm8p987pT1CwF23Diee2hToBGzFGrFGNUObkmqGvqiyBURElUokHfuwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB3994.namprd11.prod.outlook.com (2603:10b6:5:193::19)
 by BL3PR11MB6338.namprd11.prod.outlook.com (2603:10b6:208:3b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.30; Fri, 7 Apr
 2023 15:02:09 +0000
Received: from DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::6e26:7321:99ab:72ab]) by DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::6e26:7321:99ab:72ab%3]) with mapi id 15.20.6277.031; Fri, 7 Apr 2023
 15:02:09 +0000
Content-Type: multipart/alternative;
 boundary="------------0UaVbVAog7GjKDKaJrV66APx"
Message-ID: <d5f4e8e3-53c2-ab85-be64-78252a4e356d@windriver.com>
Date: Fri, 7 Apr 2023 11:02:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [bitbake-devel][PATCH 1/2] runqueue: fix PSI check calculation
Content-Language: en-CA
To: Qi.Chen@windriver.com, bitbake-devel@lists.openembedded.org
References: <20230407030715.4394-1-Qi.Chen@windriver.com>
From: Randy MacLeod <randy.macleod@windriver.com>
In-Reply-To: <20230407030715.4394-1-Qi.Chen@windriver.com>
X-ClientProxiedBy: BYAPR07CA0080.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::21) To DM6PR11MB3994.namprd11.prod.outlook.com
 (2603:10b6:5:193::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3994:EE_|BL3PR11MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: 86019593-04f7-4f6b-b77b-08db37790f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7HSpPoysZIH6dALyDF4P3FyagFOyEiQrt6T7aMYe3avCBijsYbCyKwG1cIV/YF2INmPQvIsp+DRNBayVRkN+WOPOqWgLpKAPSEqC8suZh/hvwDsT24QRSyu1Ae3OfiKIjD33sA+6dFZMxuNSCbpeCXLSa6Ar1Gu/CB03UHhPydyG7rJwDbkgpvGDgzgwV89FVbMb3hj7smnj57rZE9tCjgUXoC9Xo/jLcjgPVXaNEHfSFMFM9chVcjwNCqKFfpPW7jXcHd4sxs/pMCEs7SiwrGZEObSjRroXC3e0FAmVBOMf7Vb1Nfgp5NUsZurp1Oeg9mnyDTBnSsU/4Di9bWu54Z2xuKRtkU/fKwi3+LUF7sB3tTBewy7A3XwR46ZoREWXgqZqDjRhDQK5DXV8CiXoC1lbljjMo9qeWEqFMAB/Wp/TXUZqNYrepp/ybQgg1q87mWKJth2yFu+drHEVEL2LB1YK3VkQzphuJyGGsMkh50NLeg7TCY1XWygipGHfcyzg0yWtGy1UH9KbAwALwXEqHwDkvC2fZeIGCmmUFamsRlrfSZmokokWWfxLBLYcokEcRrzcM+1bE+RLenYeTWdv/ds843jrntOHd8tO7pyQkn4X1lmWWPXjljNx+jnFgPZzmH7GvFwmFatFayAMTFlRM4+pwUYD5F0BSfkWbMyyUUhyMgJ8ahpGQGmAvzT1WKVi
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3994.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39850400004)(366004)(396003)(451199021)(2616005)(966005)(83380400001)(316002)(33964004)(26005)(6486002)(478600001)(53546011)(186003)(6666004)(6506007)(6512007)(5660300002)(66476007)(2906002)(38100700002)(66556008)(41300700001)(31696002)(66946007)(86362001)(166002)(8936002)(8676002)(36756003)(31686004)(66899021)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dFpYYzN0Yk5UYlEwM052N1p4cHZ2QklOd0RDN0dOaEw1VGdSUmttTjlldGlu?=
 =?utf-8?B?eUErbWRIQmdpdzZUYVBVYkdUaW9hQzhYbGJVbUN3SFNRNHJYVGp1OFBJOCtp?=
 =?utf-8?B?L3BzMDlmL3Z1K3JFNWdGZHZnUlBTa3JBMVQrVkRwSmR3ejNISGt2SWxJVEZF?=
 =?utf-8?B?NEFBS00zT2VYclozMHFkNm5WbHN6TzVmamhwQWVIZzNGN2tsQmt5MUZNMTB2?=
 =?utf-8?B?dkpJOWNramIrZGhkc3hlLzJTaTYzZTVIdUlnT0U0dldCTXFJOG4rc1VCbVk4?=
 =?utf-8?B?ZzQvRllQR3o0bWJUNTQ3dzhrU2RuYW5oTEtZcG1udlQvR21OQXVFMWlrRjU5?=
 =?utf-8?B?YU02VnFxUGZjVjgzc1prUWpSQytZcUxVL2hmbTRpbHlOK0VmOUJTQmtlemdm?=
 =?utf-8?B?OHRyV2JBQ0RUeDVaajZDY3YzU0EySi9CbFl1bWcydW9tYUJ6VnVrdTdEU0JP?=
 =?utf-8?B?SWxIdllDc0U1ZzNhRDFtUkNvNGpjNTdoMTRhVTZJbU04M2ZpcTFqY25GSUVE?=
 =?utf-8?B?MThTV1BJYzI5RHVsZlAwY016UXVvcXFVMUdIeUhSTHlsNUl1VFB6ZmltSkJR?=
 =?utf-8?B?WDhqbXhsTGVGR1pjUXRLaTkvdXVWNzI1Zi9VeHhkQmIwK0RsajFEME5QRGJW?=
 =?utf-8?B?RVRTTVFmOHZPY3hXRnJMdzh6Y0JvTTNtRk1RS3EycVNicnNXaDhNTEExb0Nz?=
 =?utf-8?B?b2RSMUxEY0h3MXR3ckZYakxqYXhFTEM0T01SVlRRTkpWd3ErNDBGMlRwd0lQ?=
 =?utf-8?B?TDhFR0hIa1pxUW9naGZZSGY2QURqV3FVMmsyakc4L3pPU3lTTEhTUDB1L294?=
 =?utf-8?B?WUwxYkVlMXAybTd0dG5FOHZrK3RnL0NOUk90bzJzUFJOTEMzKzFTYmc0YkFI?=
 =?utf-8?B?cEhYYTZ0V29TanA5ZUwveVVKYlFzdWhsRDBUQVFQazNTZ254UVRCb1ZPWklk?=
 =?utf-8?B?Yld4YlVJNUVaSnN1QWJwN25QMElJUUdMUG5oRk1ZUy9tK3hxRDE4bmp5Sllv?=
 =?utf-8?B?R1lVVzNzdHJVOW1EcHdGalRtNVR4VU02cmFDOWtkZUIwV3dRWlVEdm10U1N0?=
 =?utf-8?B?Wk43WDA5OXVQZHE5a0ZaeFQxQjJISDBWS3BjNjdmaDB0RE9qYVB6d0FGWlc5?=
 =?utf-8?B?WU5PeGtoeGZhdHJWWGt2NkVjdm9GRm9OcVdaMUFCWi9nYVUyN3RYTW03UWFl?=
 =?utf-8?B?V2k4N04vaDc3T1QzalZQSTdiWUszWDJ3aDI3ckdsVk5YdFJMOXFRUXpWdkhG?=
 =?utf-8?B?VU04Y3ZqdlZ3MzhjaWtWaG5PWC9pSytVeGpoQm9ZenpHVTE1a3gxT3FoWG14?=
 =?utf-8?B?SDJKWlV4eVZCZ0pSY3VNaC8rM0FkbEs5b2pFUVVyY3dLMm44Z1haT2VwaFBS?=
 =?utf-8?B?YUZjK3FYeTAyd3d5YkVNVFhpd2hIMmcrd1FPbGNnQVFiQTBTbkZMNi9aM2hW?=
 =?utf-8?B?WDdranhkZkViandBY3VCYk93dHBsRXlOVmZScTU3K1U4MEt0R09DUzI3Sysy?=
 =?utf-8?B?ek5FaVdlcllndzQrVWJybXBsbGt0RzhHR2ZCWXJSU1BiV3RrUDVjcG5EeElT?=
 =?utf-8?B?OFp1Mys1eVYzSkQ4MThoRzJaYkhuTmNCbHJRTkV0d3JhY0FUNjkwZFhhZXg3?=
 =?utf-8?B?ODZrUy9Nb2lmRk15NDFRbEkxcjhMcm1hWFVYejhjdHU2ZGFhWjRLS0hDWUVj?=
 =?utf-8?B?Vm9qZzFBTDVFN2NWaHFaNVd4ZTBjVHVsWFFTTkx2MjUrNkY0RUJua0REeXQy?=
 =?utf-8?B?TG1TZXo0Und1SUQ5SmxjTFB4NnRzQ1VRR0dHTmw3VWFHMkNIM2NRVUwzcDd4?=
 =?utf-8?B?L1FkWnE0dVlKTkpPSjZlemRNNU1Sa0ZLQUREdTBzSEpsaWpWU1FCSUp6S3JU?=
 =?utf-8?B?M0N6Mng1bnM4MHRSeVlsMUNjelliQVRXaE5VdFh1bjhYWW9taHVNUmxUTDhh?=
 =?utf-8?B?K3ZUeVFHMUJhQ0M3VVpVckU1QjFvZmMyb25ROFNKUkY4dmw2WFE2cVZuV3JW?=
 =?utf-8?B?a25OYUR5ZVNKMktGM243bjFwSGQ3d0FuYmtCSHQ2RWpYYTQ0MXd4OGtVZTZY?=
 =?utf-8?B?Y0d6T2dtWFBSd2JPUnM4bWtjRmhLbm5VQUhqSWN6WS9PbkZPNllQclp0R1Bx?=
 =?utf-8?B?MjgxWW41ZkNhcnhWa1hpRjRlMTlrbUsxeW9XY05seHNkblpheCt3dHFDYkl4?=
 =?utf-8?B?dlE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86019593-04f7-4f6b-b77b-08db37790f64
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3994.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 15:02:09.3776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NT5kJTp3jeZC4odxtGMORAVDU+rywFrc2Sz57s1uS61PNvhlwXrbB3P5J355KOgcuXxRtF6TI+9eJUnNhY7fPYORrywOqtEbBfsLjkTsoqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6338
X-Proofpoint-ORIG-GUID: whyu4Yo8AcVl2oQETqYKn1eOM0ZPENF_
X-Proofpoint-GUID: whyu4Yo8AcVl2oQETqYKn1eOM0ZPENF_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_09,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070137
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 07 Apr 2023 15:02:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14684

--------------0UaVbVAog7GjKDKaJrV66APx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 337EmDsW013179

On 2023-04-06 23:07, Chen Qi via lists.openembedded.org wrote:
> The current PSI check calculation does not take into consideration
> the possibility of the time interval between last check and current
> check being much larger than 1s. In fact, the current behavior does
> not match what the manual says about BB_PRESSURE_MAX_XXX, even if
> the value is set to upper limit, 1000000, we still get many blocks
> on new task launch. The difference between 'total' should be divided
> by the time interval if it's larger than 1s.


Yes!
I had a patch=C2=A0 to do this but wanted to write a test case using stre=
ss .

Anyway, it's clearly better and won't allow the occasional new job to
slip in when the time diff is small and the pressure hasn't been=20
recalculated
by the kernel. It will mean that pressure regulated builds may be a bit=20
slower
but I doubt we'll even be able to measure that.

Thanks Qi,

../Randy


>
> Signed-off-by: Chen Qi<Qi.Chen@windriver.com>
> ---
>   bitbake/lib/bb/runqueue.py | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index e629ab7e7b..02f1474540 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -198,15 +198,20 @@ class RunQueueScheduler(object):
>                   curr_cpu_pressure =3D cpu_pressure_fds.readline().spl=
it()[4].split("=3D")[1]
>                   curr_io_pressure =3D io_pressure_fds.readline().split=
()[4].split("=3D")[1]
>                   curr_memory_pressure =3D memory_pressure_fds.readline=
().split()[4].split("=3D")[1]
> -                exceeds_cpu_pressure =3D  self.rq.max_cpu_pressure and=
 (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) > self.rq.max=
_cpu_pressure
> -                exceeds_io_pressure =3D  self.rq.max_io_pressure and (=
float(curr_io_pressure) - float(self.prev_io_pressure)) > self.rq.max_io_=
pressure
> -                exceeds_memory_pressure =3D self.rq.max_memory_pressur=
e and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) > =
self.rq.max_memory_pressure
>                   now =3D time.time()
> -                if now - self.prev_pressure_time > 1.0:
> +                tdiff =3D now - self.prev_pressure_time
> +                if tdiff > 1.0:
> +                    exceeds_cpu_pressure =3D  self.rq.max_cpu_pressure=
 and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff >=
 self.rq.max_cpu_pressure
> +                    exceeds_io_pressure =3D  self.rq.max_io_pressure a=
nd (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff > sel=
f.rq.max_io_pressure
> +                    exceeds_memory_pressure =3D self.rq.max_memory_pre=
ssure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)=
) / tdiff > self.rq.max_memory_pressure
>                       self.prev_cpu_pressure =3D curr_cpu_pressure
>                       self.prev_io_pressure =3D curr_io_pressure
>                       self.prev_memory_pressure =3D curr_memory_pressur=
e
>                       self.prev_pressure_time =3D now
> +                else:
> +                    exceeds_cpu_pressure =3D  self.rq.max_cpu_pressure=
 and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) > self.rq=
.max_cpu_pressure
> +                    exceeds_io_pressure =3D  self.rq.max_io_pressure a=
nd (float(curr_io_pressure) - float(self.prev_io_pressure)) > self.rq.max=
_io_pressure
> +                    exceeds_memory_pressure =3D self.rq.max_memory_pre=
ssure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)=
) > self.rq.max_memory_pressure
>               return (exceeds_cpu_pressure or exceeds_io_pressure or ex=
ceeds_memory_pressure)
>           return False
>  =20
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14682):https://lists.openembedded.org/g/bitbake-dev=
el/message/14682
> Mute This Topic:https://lists.openembedded.org/mt/98118922/3616765
> Group Owner:bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:https://lists.openembedded.org/g/bitbake-devel/unsub  [rand=
y.macleod@windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

--=20
# Randy MacLeod
# Wind River Linux

--------------0UaVbVAog7GjKDKaJrV66APx
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2023-04-06 23:07, Chen Qi via
      lists.openembedded.org wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20230407030715.4394-1-Qi.Chen@windriver.com">
      <pre class="moz-quote-pre" wrap="">The current PSI check calculation does not take into consideration
the possibility of the time interval between last check and current
check being much larger than 1s. In fact, the current behavior does
not match what the manual says about BB_PRESSURE_MAX_XXX, even if
the value is set to upper limit, 1000000, we still get many blocks
on new task launch. The difference between 'total' should be divided
by the time interval if it's larger than 1s.</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Yes!<br>
      I had a patch&nbsp; to do this but wanted to write a test case using
      stress .<br>
    </p>
    <p>Anyway, it's clearly better and won't allow the occasional new
      job to<br>
      slip in when the time diff is small and the pressure hasn't been
      recalculated<br>
      by the kernel. It will mean that pressure regulated builds may be
      a bit slower<br>
      but I doubt we'll even be able to measure that.</p>
    <p>Thanks Qi,<br>
    </p>
    <p>../Randy</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20230407030715.4394-1-Qi.Chen@windriver.com">
      <pre class="moz-quote-pre" wrap="">

Signed-off-by: Chen Qi <a class="moz-txt-link-rfc2396E" href="mailto:Qi.Chen@windriver.com">&lt;Qi.Chen@windriver.com&gt;</a>
---
 bitbake/lib/bb/runqueue.py | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index e629ab7e7b..02f1474540 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -198,15 +198,20 @@ class RunQueueScheduler(object):
                 curr_cpu_pressure = cpu_pressure_fds.readline().split()[4].split(&quot;=&quot;)[1]
                 curr_io_pressure = io_pressure_fds.readline().split()[4].split(&quot;=&quot;)[1]
                 curr_memory_pressure = memory_pressure_fds.readline().split()[4].split(&quot;=&quot;)[1]
-                exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) &gt; self.rq.max_cpu_pressure
-                exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) &gt; self.rq.max_io_pressure
-                exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) &gt; self.rq.max_memory_pressure
                 now = time.time()
-                if now - self.prev_pressure_time &gt; 1.0:
+                tdiff = now - self.prev_pressure_time
+                if tdiff &gt; 1.0:
+                    exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff &gt; self.rq.max_cpu_pressure
+                    exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff &gt; self.rq.max_io_pressure
+                    exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) / tdiff &gt; self.rq.max_memory_pressure
                     self.prev_cpu_pressure = curr_cpu_pressure
                     self.prev_io_pressure = curr_io_pressure
                     self.prev_memory_pressure = curr_memory_pressure
                     self.prev_pressure_time = now
+                else:
+                    exceeds_cpu_pressure =  self.rq.max_cpu_pressure and (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) &gt; self.rq.max_cpu_pressure
+                    exceeds_io_pressure =  self.rq.max_io_pressure and (float(curr_io_pressure) - float(self.prev_io_pressure)) &gt; self.rq.max_io_pressure
+                    exceeds_memory_pressure = self.rq.max_memory_pressure and (float(curr_memory_pressure) - float(self.prev_memory_pressure)) &gt; self.rq.max_memory_pressure
             return (exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure)
         return False
 
</pre>
      <br>
      <fieldset class="moz-mime-attachment-header"></fieldset>
      <pre class="moz-quote-pre" wrap="">-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.
View/Reply Online (#14682): <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/message/14682">https://lists.openembedded.org/g/bitbake-devel/message/14682</a>
Mute This Topic: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/mt/98118922/3616765">https://lists.openembedded.org/mt/98118922/3616765</a>
Group Owner: <a class="moz-txt-link-abbreviated" href="mailto:bitbake-devel+owner@lists.openembedded.org">bitbake-devel+owner@lists.openembedded.org</a>
Unsubscribe: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/unsub">https://lists.openembedded.org/g/bitbake-devel/unsub</a> [<a class="moz-txt-link-abbreviated" href="mailto:randy.macleod@windriver.com">randy.macleod@windriver.com</a>]
-=-=-=-=-=-=-=-=-=-=-=-

</pre>
    </blockquote>
    <p><br>
    </p>
    <pre class="moz-signature" cols="72">-- 
# Randy MacLeod
# Wind River Linux</pre>
  </body>
</html>

--------------0UaVbVAog7GjKDKaJrV66APx--

