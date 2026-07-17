Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6D5C44515
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 18:29:49 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2676.1784311885073612244
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Jul 2026 11:11:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@est.tech header.s=selector1 header.b=UOveiYZS;
 spf=pass (domain: est.tech, ip: 52.101.65.9, mailfrom: david.nystrom@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyRtS1IdjWhXSlCb7R2eN3tvQMdCrhJN4YAhv5oo8EqypSyQ1yCOIAjVJBt7mQ6+/lNBFv1uzZr5/hWVWtApr8bmB25e1VtbshI918+QTjZJVeKSmvcx0N1i2e+tFNPv3VjoudmRB/lBM2iNbJH1iTHLfKGjOViE9yJm94NFUyTezcUjwavXdvr9qxk48rl/nhhyMQ9axex1PwHhJDK4IAmKmBRwjnFBEzlkVJDUkhKca/sxIiHbnLxHVWDrN6gO/+0+z6tisOIlCjv7QwLKLGB+Zakf5qLUAVfVuI7DQQTn1+MR6TBm3HJ6fcZrv1lHEscowFapA10qKJvGKdadRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUnSAv6bH9/rHI8c15p0+gaBpA+onf7JcXNDqrAyUvE=;
 b=hc6yM3cYg5r6CaeFKsAuOMyfmOPv6dWk4ahrq8ReRLlWcdm/xATFylW2WiXOQQ1hnlMpVSXhvVrBAXb+P3MTry4w3cv3zwwNWBMnpVQb4kEQhvjftGNU+otY8L9BgkIgo7yDFjuajL12PE8snyiFYd/79cggvUZpn9t9Lhz0hhu9rxLrEV4cJAF0Wfhfk4ZBXu0zsmkDm3UFtJAiyJVOoT0H2JuZeXL0IxTjsx5FfG+3bFD4zIaggEkv+FDPucDZOx7BRcmNMjxZyaLALXAh/6eVLFKunUh+uBPyICh/2en0CktQNbS8e7kJRnSXpMbDs6uijbYGdMGtCJWDMLIccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUnSAv6bH9/rHI8c15p0+gaBpA+onf7JcXNDqrAyUvE=;
 b=UOveiYZSrVAA9s8eS/yIEz46xNIAvok6V+Qan/yDfvH35ftZv2LJTcV0C8POEhFPI7h9zTH46iN5NTKE0VzA5vLe4GQUsjti1veNCdfcPecK0sT3hL11Fx2/+axO8kTVCHGSTLpgz/h4eSSPdtJ1wvj61KzX9ZzaWX4NpFcaD8YDoQE2u+ac801T4qH6/uBg8d313fbHKIPfquwgPS9A6P9dtvYr98iejtdFpjWcqnlwaY/WFYdK9ddrf/AQkZxegi7wpEyf+USfWV/9OHQxeMBo4lim0xyuAZ3lUcyqlA5EhKolxgU3vZl7mf3i+2EZg1ZHffo/5dP/kcz5ecirUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f3::19)
 by DU0P189MB2426.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:416::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.5; Fri, 17 Jul
 2026 18:11:21 +0000
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::49f:4bc1:672f:45c8]) by BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::49f:4bc1:672f:45c8%4]) with mapi id 15.21.0202.014; Fri, 17 Jul 2026
 18:11:21 +0000
Date: Fri, 17 Jul 2026 20:11:11 +0200 (CEST)
From: =?UTF-8?B?RGF2aWQgTnlzdHLDtm0=?= <david.nystrom@est.tech>
To: Paul Barker <paul@pbarker.dev>
cc: =?ISO-8859-15?Q?David_Nystr=F6m?= <david.nystrom@est.tech>, 
    bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH [RFC] 1/2] utils: Add landlock_restrict_network function
In-Reply-To: <8d50983b587b19901608279ee8fd946a6503ff97.camel@pbarker.dev>
Message-ID: <a28ba50f-8e5f-039b-4e85-f8e5121954c6@est.tech>
References: <20260612-landlock-v1-0-77891f63ed7f@est.tech>  <20260612-landlock-v1-1-77891f63ed7f@est.tech> <8d50983b587b19901608279ee8fd946a6503ff97.camel@pbarker.dev>
X-ClientProxiedBy: GVX0EPF00073CEF.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::1d8) To BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:b10:f3::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP189MB3241:EE_|DU0P189MB2426:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b4cb19-9ad8-40b0-08f8-08dee42ece0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	c2LnccrMf6vwCDu3WEdHv98maYaNz8BbSb/1hdMhmrFRrZrNxDnS/UOkkeuhgoh8+ieWU371O0BpQwN9NcrnAStJBQ5C+xyh540pENUXCCIrDk3UFRlZaPzC9Yxy/s9rSOxMNRmChu2QsLkumknEhN7HiB1OPQZsVcmXMuqKIeoeVAZm2xl9DpFRLnEhVQ06NWoaoN+jR7ZL/mmEzk7p6EnZEqXWQfeLvvGdOAGs09qINR4psHsNifSk4pc7+suN0pNsjivZIhq+FTBW58R0Vgj0Yipx8nG8eUvqyC82lo6I/PE5epfwDJpBt+c53J2wW5ADXrZa/lDvzvokUQKB9eG/ZyTMap4z3rpmQl5JIPKPGYPFLCFIXrsuLo9sGeWGgd8/inwiy3H+qhujRAtCgh6OWeoGudc5tAXBWjZ4X16PRpcOM0fa2/2lybutqTCVVWqrW0i/6QIuPBVGUtZUK7Y1dE2IiZu0o7/kyWgYmocO8ws2GDFXFN9zX3DyVYewN4BnNYaK11vyer+AJUed9E8cc3ag/Y394OcTV/XljcIE2mHARC8UJFTywS0IKePozRIpdG3skU+Ka/DEaATLWfaUkJpGmKSN1fm+Fqqtb/LUdTDzYfUqDvvCvtmua9mBoWik6ZOSngJEqYNmky7bctYVqNYesXjeNK9YXeQI37o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP189MB3241.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YkpjaUFMU09GUmJyclVTcGNzWDZ4R293Z205UmpXOUphQ1g3TytWb3ZGOG01?=
 =?utf-8?B?TVlUMHY0NHZTbytSM3JDYlZ3VlhFeE5YMUFDVjYvYXF4eWxWOURmaW1pRE9n?=
 =?utf-8?B?cndjNlFTMnZ0NTY3eGZQT3lQWDdlUUJTc2p3Qmc0a250ZktiUnBwRi93TWNT?=
 =?utf-8?B?TEhER1l3eUQrQnhjNGxpMDhYdkVaaitaTjRRN2VTMGd6VmtJL2w3VzVJdytq?=
 =?utf-8?B?VDdNK2czQklzQXhySW4rK2l5R0xqclpzMFNpZWFBd3B5RDRkbjZ2S2NLWEJU?=
 =?utf-8?B?Q29CcVlEMkVYR1UrRTBMSEE4d09XbkszUnZlanpEb1loczRycEVPcm5kWjRw?=
 =?utf-8?B?TVZXQWF6YUcvZzI4VjUveDRiQUdFczNWYW1SeVRxWFJ6VEMwNkl0N3F2Mk5o?=
 =?utf-8?B?ZlVpaUNFK2UwNlZ1YkJRbGVhS1BvaDlNSGExUXcyaVJwT085T1JSclJGMTdH?=
 =?utf-8?B?SWcwVzRtUkZYLzh4T3A3ZS96RHF3QzBqK3VLUG90SWVnZzZtZ0hzUFF1VFd6?=
 =?utf-8?B?UU5RUU9TbGxnL3RjbjdpbE84cHFBdG9jOEpNT1dUa1pXM2Nkb2tNZXh2eDFK?=
 =?utf-8?B?YXp5L3h4S3l1bjNPK3FXbllMU2lBb1Q3bnJSTC9tOWNaeWRjNzJ4K08wRDRZ?=
 =?utf-8?B?SHRZYWNtdXAxS1lOT09qTDFNSHFYWU0rOVlld3psOEVOZWtsbkttd2E5OXNl?=
 =?utf-8?B?c3d2a3phT0lldzZGR0FkZEJtY1d4NlRHUms5WjIvZjNQMHBxd2NhdkdXK3Fn?=
 =?utf-8?B?WHFuWFBwN2FmY2w3VUZHMGlaOTFEQ1pNUU9vSWVLUnZDaG4wbXFIODVXQjRv?=
 =?utf-8?B?ZWN0dGc5am93T25uNmo1SVFaanhXLzhMdnYyTlMrcUdWbjF2RkdGVGNJTTlJ?=
 =?utf-8?B?Y2V5by80UjJZRElIdGIwRFZuSGVqVEtmYzRTUFJkb2RqYlN5Wk5sWGFQa3NT?=
 =?utf-8?B?YWlseWt4YlNubG5oTXppUjVFbWx0Rlk0NGtCMUIxbWZqOGVmNFUrWHRkcHR5?=
 =?utf-8?B?WWs0WGlqcm9NVm5XWHBxcmR4bHQ2aGVxYUJMK2FaZEFqUXVaVHBscDhxZHBK?=
 =?utf-8?B?WGM5S1pIdjdDeGxrV3FwcFNnZlNtZVBVZ2Zzb0s4Q3ZGVmdvWGNrRlZsaVVU?=
 =?utf-8?B?bXZJbFVKd0gvbVJ1OHBiN3VGUFlLci9aSmR3Z0RUaGNjTW9xZFNXUkMyM3Vk?=
 =?utf-8?B?MGhyVm9zMEsyYW0wQkk2ZytJS2diQWNqaWYwSk5qdEM3emNNOW5VTjVMeDdW?=
 =?utf-8?B?MWhWM2lQSmxuMlFiVnp1K0tFR1FxTjhTUUl2YmplTFNOc2tuSVFzNDRLVlM5?=
 =?utf-8?B?YWFlT2hpZm41c2IwZXJSbXhUQVZMdWdZTW4rM0FvcUhzWWIyK0JRaThuSkU0?=
 =?utf-8?B?anJ4eldoNHdRUnJVS0toQStaSkdwVWcrVUZjTFRSNy9xSlNkcHppTW9CUit1?=
 =?utf-8?B?RnVzUDhabjNDTXVSOENxdnVycWJRdmtGY2tsa29KTC9wVmtZczlBRnRtNEhl?=
 =?utf-8?B?a1djSTZkWWpDUDhRMWd4S1VQVXU0ellsbVJCS1hhMGdFYy9Ub1NXKzhBcHc3?=
 =?utf-8?B?b2RWclJDT2dRZDNmUk5hWjdwb1VCUWRrMHJpMk5MRldQb09TUWFLbjBjRVZ3?=
 =?utf-8?B?Z0lsRmxqLzVvc0NBcUl6Ty8zd2dkWi9qOXVoR20zM01WNGZBSVNYcUZ6d1BN?=
 =?utf-8?B?aUVTbnNNNDhJTFlUdWRLMXNCSFFpa2xoYUdwL21YSUdyeUl4TG1GeUJ0Rmh0?=
 =?utf-8?B?REtNTG9PZDdHRnd3WndWVVE1d0prSiszK2N3b0lXb2p1akNwQUM1a0FGbFpa?=
 =?utf-8?B?VkRva3JJbnYwN1BKRlF5bWlaMXZkc3pkNXVoMzdaVDRvc0J1U0UvVElLZ2wz?=
 =?utf-8?B?M2tlaHFwbkZiK3hMVVg0bzQ5MnRZNW83M2R1eEFtdVZLVzFxZTNyTVRpdWYw?=
 =?utf-8?B?aUZ4eHAzK1gxVWdDajZxMnRoa0FScG5xOXZlUm1VQWhTN2JvTWtLL2FRdHFZ?=
 =?utf-8?B?UjBXMW1XM0lWQmhJTEsxb0ZTOGM2OVZjWWEzYVY4TUcxSWJOaVBvODVNK2tk?=
 =?utf-8?B?RlU1Q2swTzMzN3RyYm1OY0ZmNm1GQjZWczVFend3dXg1S1oxM0FaN0hPbU9E?=
 =?utf-8?B?MHlWVEV6V1orQ2RZbmtPU0VwMlZKSk9COVdoV1IrWmMzdzNOMDBJeHlaekxP?=
 =?utf-8?B?OVd3QmJPelFpYVRzQUpnV3RQSElWVFQzb2wvYmQzd2hSNXRhZjdsa2lrS3l2?=
 =?utf-8?B?NzFPUDN4Rys4eSswNVZpUTJ4eUZtT0lmQ0JINjE3SVFsbkhUVGd4eWxieG5V?=
 =?utf-8?B?V0Y1dVVleTAzWndNU0dFRkhoU1VXRG5OSVBnWkMwWGxLZlhpQ29FZz09?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b4cb19-9ad8-40b0-08f8-08dee42ece0b
X-MS-Exchange-CrossTenant-AuthSource: BESP189MB3241.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 18:11:21.0458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVbGgvkC0E/hFXd/MBdif73L58p9yTVAaFlENQxkVtzbBmf2a/w4fg2Z7zWOXmRD3uHjaOc83CI1vVV4DHkVRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P189MB2426
Content-Type: multipart/mixed; boundary=83233296248056541784311871881947
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Jul 2026 18:29:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19844

--83233296248056541784311871881947
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Mon, 15 Jun 2026, Paul Barker wrote:

> On Fri, 2026-06-12 at 13:38 +0200, David Nystr=C3=B6m wrote:
>> Add landlock_restrict_network() which blocks TCP bind/connect using
>> Landlock LSM (ABI v4+, kernel 6.7+). Designed to stack with the
>> existing disable_network() namespace isolation, covering the case
>> where disable_network() is skipped for non-local UIDs.
>>
>> Gracefully returns False on older kernels (ABI < 4).
>>
>> Signed-off-by: David Nystr=C3=B6m <david.nystrom@est.tech>
>
> Hi David,
>
> I think adding this is a good idea, but the code needs a few changes to
> ensure it is maintainable.

Thanks for the review, and good comments.
My comments below.

>> ---
>>  lib/bb/utils.py | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>>
>> diff --git a/lib/bb/utils.py b/lib/bb/utils.py
>> index 181082c95..1347c29d0 100644
>> --- a/lib/bb/utils.py
>> +++ b/lib/bb/utils.py
>> @@ -2054,6 +2054,32 @@ def disable_network(uid=3DNone, gid=3DNone):
>>      with open("/proc/self/gid_map", "w") as f:
>>          f.write("%s %s 1" % (gid, gid))
>>
>> +def landlock_restrict_network():
>> +    """Block TCP bind/connect using Landlock LSM (ABI v4+, kernel 6.7+)=
.
>> +    Gracefully skipped on older kernels. Stacks with disable_network().=
"""
>> +
>> +    NR_CREATE =3D 444  # landlock_create_ruleset
>> +    NR_SELF   =3D 446  # landlock_restrict_self
>> +    NET_TCP   =3D 0x3  # BIND_TCP | CONNECT_TCP
>
> We should base these on the names used in the Linux kernel so it's easy
> to search for things and compare with example C code in the docs. So,
>
>    NR_landlock_create_ruleset =3D 444
>    NR_landlock_add_rule =3D 445
>
>    LANDLOCK_ACCESS_NET_BIND_TCP =3D 0x1
>    LANDLOCK_ACCESS_NET_CONNECT_TCP =3D 0x2
>
>    LANDLOCK_CREATE_RULESET_VERSION =3D 1

+1.

>> +
>> +    libc =3D ctypes.CDLL('libc.so.6')
>> +
>> +    abi =3D libc.syscall(NR_CREATE, 0, 0, 1)
>> +    if abi < 4:
>> +        return False
>
>    # Check that landlock is enabled and supports network access
>    # restriction (added in ABI version 4)
>    abi =3D libc.syscall(NR_landlock_create_ruleset,
>                       0, 0,
>                       LANDLOCK_CREATE_RULESET_VERSION)
>    if abi < 4:
>        logger.debug("System doesn't support disabling network via landloc=
k")
>        return False
>
> That's a litte more verbose, but much clearer.

Good point.

>> +
>> +    attr =3D struct.pack("QQ", 0, NET_TCP)
>> +    buf =3D ctypes.create_string_buffer(attr)
>> +    fd =3D libc.syscall(NR_CREATE, buf, len(attr), 0)
>> +    if fd < 0:
>> +        return False
>
> We probably also want a logger.debug() call to log the failure here as
> well.
>
>> +
>> +    libc.prctl(38, 1, 0, 0, 0)  # PR_SET_NO_NEW_PRIVS
>
> The commit message only describes use of landlock, not no_new_privs. We
> need constants for this call as well.

Also a very good point, setuid/gid and setcap:ed binaries will=20
silently run without privs, which should be documented also in the commit m=
essage.
This is a landlock requirement for unpriv use, and the main source of=20
potential sideeffects I would expect from this approach.
Since there is no way do disable it, without setting the=20
"network" flag on a failing task, I'd really want to gain more=20
confidence about the potential sideeffects of no_new_privs on=20
various edge cases before I send a non-RFC patch.
Testing is ongoing with your comments addressed, but I will not be able to=
=20
finish before my vacation starts(tomorrow). If considered urgent,
feel free to use idea only.

>> +    r =3D libc.syscall(NR_SELF, fd, 0)
>> +    os.close(fd)
>> +    return r =3D=3D 0
>> +
>> +
>>  def export_proxies(d):
>>      from bb.fetch2 import get_fetcher_environment
>>      """ export common proxies variables from datastore to environment "=
""
>
> Thanks,
>
> --=20
> Paul Barker
>
>
>=

--83233296248056541784311871881947--

