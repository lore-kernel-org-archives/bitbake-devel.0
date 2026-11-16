Received: from CO1PR03CU002.outbound.protection.outlook.com (CO1PR03CU002.outbound.protection.outlook.com [52.101.46.40])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.28220.1794838629567796550
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Nov 2026 06:17:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amd.com header.s=selector1 header.b=NR8peza+;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: amd.com, ip: 52.101.46.40, mailfrom: mark.hatle@amd.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lpZvii3V5gzsqRjtZSKsISA4RntT0DomMFKpFnKbmq8j4znNjdcM2+TjURnPPkP3FL9nbUvzdtRBwaAlCC8TZ2PT/jbMlzCxtDr6teJBAOGsaDX7k1aJnRMw5mIjspfCoWTSfwEtm5noJvFdmETbJrzP5cpY8K8cX7Ig/uWsLru1Cc504vUGt22R1rXlp9RMYfYmLi1HhDTMYGGDBLpCIyVcsbWJd1HD6fiqPHj5mC0ZdIz4w19QrvSQGZYFviHsx5JUJHYzD9K06Lxakgv2J6pQJ8iLZc8I4aE4c8cUTIxS/zngid0r6ddruwNSO4G/Cnoog2r36zM/vwcj1NMEgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgjHtalDW3b5OgBytk+9BcCXNdEMMaialZZ/KkOQV4c=;
 b=fGkBw6gX7nHMiKlw+7pbjbZGYEfnGxIR70n/ZeTlNKzGkqaYnv3wRCPMjnM3BlDsg3/o0z97A777L46rAWh3XuttXtRG1A5kao6Tee2njPVohJwu53+TM7eAoiEJLDRwhHiz5yKdAOmsANsA+wxr1RCLNFvA06BnHagA2ZQUUy9GCE4ktsl+hEIl2P2voawTR8fKwyM3OAzq1uuk/hHUtxQ7WesHg9Wt6QOYotc/zumikzD6FrJNAXtKMQfApnFM05nkgfMoaB28amutTj5G9eMvAWh2PscCr2raJbSY1s//8aDUnkxzmYq1yL0b7CziCk70VcA9YHIioGyD3UU6DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgjHtalDW3b5OgBytk+9BcCXNdEMMaialZZ/KkOQV4c=;
 b=NR8peza+DbuOx42/i5NHyZs0yDP4E2hvaByq0r6Hu77J7+q8ky18ByxWQSGsljmIfgn2Kg7P0hYRSDDXyXrl0Rcry0utPkROgKlPjmrHx92rut6OpwEcpH/EvyjgRTmL69c9AIWIPWAYhECpNsyfmp9LJWq+6NwEKN4gi1/ZiiI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14)
 by DS0PR12MB8441.namprd12.prod.outlook.com (2603:10b6:8:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 14:17:01 +0000
Received: from PH7PR12MB7018.namprd12.prod.outlook.com
 ([fe80::e2bd:c56f:ea1d:9a11]) by PH7PR12MB7018.namprd12.prod.outlook.com
 ([fe80::e2bd:c56f:ea1d:9a11%2]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 14:17:01 +0000
Message-ID: <dc348ddc-e7cd-4328-b764-6917b2c2030c@amd.com>
Date: Mon, 16 Nov 2026 08:16:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] runqueue: Don't defer setscene tasks
 behind already completed tasks
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20261115220956.758312-1-mark.hatle@amd.com>
 <c2030ad5623676d77adb9af2670235d134b6fede.camel@linuxfoundation.org>
Content-Language: en-US
From: Mark Hatle <mark.hatle@amd.com>
In-Reply-To: <c2030ad5623676d77adb9af2670235d134b6fede.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::29) To PH7PR12MB7018.namprd12.prod.outlook.com
 (2603:10b6:510:1b8::14)
Return-Path: mark.hatle@amd.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7018:EE_|DS0PR12MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2b8506-d4cd-44bc-1741-08df43ec4836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|11063799006|4143699003|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: lKy9yf8aWiYXumir5Z8UXhIB8/UGTreuIkg0bwCFZmJdP1Jxw03WU+TGQKxvdED0fwXw1NXlFra5e4xIKRuNY5w1zPXBijTaOoR/ewP3ULQMIgUgDO1GjwtXasGBBr3eTBTuHJKgSof5PqqSVn5ZN6F9RmLG2XKmh+MMdUbE5lDTTLTxSLiWhy3UoyB16d8gT7PSFT+OmsgEa5XM3HzIGtmAxQNvPD9aqh3bIqXHKAOxeggJQwlO8iSgZftrcEQ00WgrOWnJVKjip/kuIQhVNhIDjzu2kqb0iBFd3ddyPaoS4G2tPANeqPjnytINNdAMeL8JvPQcuUuMGdzlE5/iDwgpDTKhCMZgXsYWZRD9/7w5m1uLtx0dHOWU3D794aibf3Tnvsul50c5vvoCtChiuQVYK4e4+s6RlAJF9AmNsjn2AkoUsc+WFHQX4S9FsXVlwpZA7kXgm7inJiBunTeDlTvhgvtKx2PuMzN3xoaUYECyGOBjK6MMCvL04HEodCYONHFaLwq2D4NU4V39upo6+Sa/FU5H4k77ZEapVb5w81xsYVjzjnoL3V4HISxOiBZETfAGCjFjjdRl8WztNmnKSG27LHKiTBPRT7fHjJX01ylxsLY+T+n9kwVT3Br8Warxrf+Ncby91SggUTvEij8fMgZec1iR6U0/4M20wxvHkTs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7018.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVhVK1lWbitESFdudmhEaHNJT2Rob0dyZEdYMlY2cDcxbkI5MVh0bmVkSC9P?=
 =?utf-8?B?dDAzaUwzQjJyZFJRd0dHUTRuVWY4OU4rU3R4cFhibEszdzdwSWMwTFhDNmRr?=
 =?utf-8?B?UmNTdWpwNTBhM2NLcnJwMVlPSjJlL0hDSFQvYWpOaTk0Q0tod3phRXU5Rkli?=
 =?utf-8?B?ZXJXZWdwUGc5RVF2NElNOWFJWWp6TDdQdUlxQkx1TDlsZnVoUzRNQ0VqTWNV?=
 =?utf-8?B?WmcvWXZsN0FNRklRNVpxbGdERk9MOC8wZk1yclFwOEFMdlpOZkZ0b3Q3WEVs?=
 =?utf-8?B?Q0RqeXp0SzlycUJPWTBURk1iQ1B5cVU5RG4wNEpXWGpyU1R1bzFIa1BtaVR6?=
 =?utf-8?B?UFo0Rktha3FzWTdLZU5WZ3RPZVRpSGZvcGt0U2tYYTM4UHBNRUVBMzlJSXUx?=
 =?utf-8?B?Yi9rczdUbkE1UFd6ZHFCRmcvaHh0QWJtUkwwUFVGNzhMV1FPdG1qKzlycS81?=
 =?utf-8?B?QmN3eEFoOExjaE9xRlppOXVqbDF3dmJYYzEzSnVKejNJMmFFUzA4WWlOaldL?=
 =?utf-8?B?RmM4TUlHR3N1OUxMSWx1djFiVm4xOWZUMW4xdmFNeDZyN3Z1aytCRGhzRlFJ?=
 =?utf-8?B?ZVJ4eWYvK2RTalZ3Y3p0VkV4U2U2Z1ZNYmhpcWVKd3E4ak5iSk5wNC8ra3FY?=
 =?utf-8?B?aUl1NERzWmZpaTFnb0Ztam5WRjVyaUpJZjdhaGNrUEwxWE9pWmFKbEg1dnZJ?=
 =?utf-8?B?NXZKWnV1UnhiRitSVlBNVjI4VWZKSjNLeGFyaUY2RVQrY0V0dmlUc3NVS3Ur?=
 =?utf-8?B?cXNJckk3MVArS2NSQTdmd0NJelpMNEFzS0ZlMGkzeTdqWUxkOFdOMlowWEtu?=
 =?utf-8?B?VVZnblNrUml5Z0tSZWplN2UrVzNmN05Gb2hKUE0yQTZUK3poRjBDUWF5OExS?=
 =?utf-8?B?RGtPK1JZVGpCUHdoN0MvdFJQQnFKZWV6MUo0aTdoazFqRjBiL1FnYWpJeDhT?=
 =?utf-8?B?Z2h4NXFMSTNqbkZPLzBTem5QcjR1WXM2OStPVWxvcVdTN0tUQ0NLeGw5ajRy?=
 =?utf-8?B?cndNNjkzN25SanRHZzU0ZWhVSElJVi9peG9DNDM0dThxQzc0NFozT0d6dVpC?=
 =?utf-8?B?ZFlrcEJ3TTF2eDNoQlU4N0JlUGQ3RDhJM0pQd0hpSzFEdVVWVVlBb0pPNWpn?=
 =?utf-8?B?REx4UFlwMVc1SHNlWmZOaFp4bCtkRDF4YVE5aWluZGMyRnRGWHhhcXdDeDAy?=
 =?utf-8?B?dmVsVXNGRndVSk5taDVkSTVYOERhMmplTnhkQVFJK2t0bVdaYkhOblllR2VQ?=
 =?utf-8?B?M0g5MDBPV0dTeCtQb0xIaEUrM1paemx4S3I1a0prVVZiMXRoT1JFMXJyeGhZ?=
 =?utf-8?B?NWV2L2ZHYVZjaVdOUkt6WkUySG5qbEsxL0p3THhTS2xNQUkzelIwSHErYjJq?=
 =?utf-8?B?djhaZHdyU0VaMXcrNnp1ajZPdFBVV1BtV3k5NlRxVk9sV3lpYmZzQUU1dkc3?=
 =?utf-8?B?UzdRNjdwTE9uNzN5bElnWkNWTEg0ZUZlN2ZFR3FYaU83aWN4NzBLaFltMFd5?=
 =?utf-8?B?N00vQmtiUGFMUDk0U2Y4RGRtQnp3QXExYVhxVjVGbmtGVmswQXd3anJWOVlK?=
 =?utf-8?B?NmgyU3o2dzZINWwyU0R3VXNLdzI4eE5jTUE2VTIrMm1oQUNxWCtqZG11Y25j?=
 =?utf-8?B?ODJRZzdqYXBvRGEvK0pPRFQzLzlBNjJuNkdMOFdjc2pHRkZ5RFBDRDRrd0tL?=
 =?utf-8?B?ZzAvQXZpN1FIc3B2WWRNMDVBKzhwUXJyVTVtQzRybGYyYzJMRjQwQWtIYXlw?=
 =?utf-8?B?K3VlZUhDK3pmMGk3VWxCa0pjc0ZmRkcrYlRtZXFxd3ZyZ0xsa3ZRUjJvK2tN?=
 =?utf-8?B?bndxMkI1RHMrTzdKUUtETks2RjAwa0o5clhDeEd1KzhaR2hrbU9sdVF2cTFt?=
 =?utf-8?B?enFmT2ZaK2RVMzlUMEFObWlmOElTdCtwdUJZWE9DNmZrNmtTNmRnRDZNN05D?=
 =?utf-8?B?cVp1U2VkcG1tREV5cHBVNVR3WnRaZ1hSTWt4U1NMMVJPZXhXYnlKdURnemt6?=
 =?utf-8?B?WS9ON3FCRzl5WlVGVDdiclVvRGxDa25LMTJySmwwbjZLZ1JneWxUVXZPRUs3?=
 =?utf-8?B?ODRONzJCSGxhRWM1N1pSWVRDOFpLbkRQWFd3cnBPN3J5NHpNb3V4VFh2cGxo?=
 =?utf-8?B?WHpFM0t3bzZYOEc4VUFqMkVJYlErMDRtU3M4ZVo3YlhWWTVqbFdsSGVuODJH?=
 =?utf-8?B?anUxcTAreTF3RW4wMXhzRWUyRlFPTXdteldVZXF2OUhFbmZiSnFVc3MwVUow?=
 =?utf-8?B?ZXY2WWQ2aUNlcjJRdGFqTUxneGxDUHlkWlZGbU5iQXh2NnB6STh0R1JESjNz?=
 =?utf-8?Q?byrwtr92gdBi2B70vQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2b8506-d4cd-44bc-1741-08df43ec4836
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7018.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 14:17:01.4815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xecvq8wB2uAIXveoy/NXJvIDECuLpwIIlG9/pGrl1n1sB2nrJrDreck0E6XkS2G8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8441
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <bitbake-devel@lists.openembedded.org>; Mon, 16 Nov 2026 14:17:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20440



On 11/16/26 7:32 AM, Richard Purdie wrote:
...

> 
> This doesn't look quite right to me.
> 
> If you do that, you need to also then follow through and handle
> anything that has a dependency on t.
> 
> Also, the code above this is the only codepath where
> self.runq_complete.add(task) is called. For something to be in
> runq_complete, this function has to have been called for t, so that
> deferral should have already been handled too.
> 
> I have a different suspicion. I think the loop ordering is subtly
> wrong, which is leading to the deadlocking.
> 
> We need to process deferred tasks in multilib order. The main code
> already does this but this section just has a sorted() call. I think it
> may need to be:
> 
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
> index 63615ac6c..b098ac170 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -2109,7 +2109,10 @@ class RunQueueExecute:
>                   logger.debug("Marking task %s as buildable", revdep)
>   
>           found = None
> -        for t in sorted(self.sq_deferred.copy()):
> +        for mc in sorted(self.sqdata.multiconfigs):
> +          for t in sorted(self.sq_deferred.copy()):
> +            if mc_from_tid(t) != mc:
> +                continue
>               if self.sq_deferred[t] == task:
>                   # Allow the next deferred task to run. Any other deferred tasks should be deferred after that task.
>                   # We shouldn't allow all to run at once as it is prone to races.
> 
> which then matches the other code. We probably need a small helper
> function to give that sorting. (yes, I know the indentation needs
> fixing, I left it like this for clarity on what the change is).
> 
> Can you see if that helps please?

Assuming I applied this properly, I'm still getting the same results:

WARNING: Runqueue deadlocked on deferred tasks, forcing task mc:zynqmp-zcu102-sdt-full-microblaze-pmu:virtual:native:/scratch2/mhatle/git/external/experimental/release/meta/recipes-support/sqlite/sqlite3_3.54.1.bb:do_populate_lic blocked by mc:zynqmp-zcu102-sdt-full-cortexa53-fsbl:virtual:native:/scratch2/mhatle/git/external/experimental/release/meta/recipes-support/sqlite/sqlite3_3.54.1.bb:do_populate_lic
WARNING: Runqueue deadlocked on deferred tasks, forcing task mc:zynqmp-zcu102-sdt-full-microblaze-pmu:virtual:native:/scratch2/mhatle/git/external/experimental/release/meta/recipes-support/sqlite/sqlite3_3.54.1.bb:do_populate_sysroot blocked by mc:zynqmp-zcu102-sdt-full-cortexa53-fsbl:virtual:native:/scratch2/mhatle/git/external/experimental/release/meta/recipes-support/sqlite/sqlite3_3.54.1.bb:do_populate_sysroot
WARNING: Runqueue deadlocked on deferred tasks, forcing task mc:zynqmp-zcu102-sdt-full-microblaze-pmu:virtual:native:/scratch2/mhatle/git/external/experimental/release/meta/recipes-support/sqlite/sqlite3_3.54.1.bb:do_recipe_qa blocked by mc:zynqmp-zcu102-sdt-full-cortexa53-fsbl:virtual:native:/scratch2/mhatle/git/external/experimental/release/meta/recipes-support/sqlite/sqlite3_3.54.1.bb:do_recipe_qa

(and many more)

--Mark

  
> Thanks,
> 
> Richard
> 
> 

