Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C49C47258
	for <webhook@archiver.kernel.org>; Wed, 31 Jan 2024 03:41:54 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.6799.1706672507500071973
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Jan 2024 19:41:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=nApzLecP;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=27603b1cdb=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V2xQG5026454
	for <bitbake-devel@lists.openembedded.org>; Tue, 30 Jan 2024 19:41:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=5tGfrAjW8uvi/xv7pyD1eDp30BKzHsGJ8I18Ce9NtM8=; b=
	nApzLecPmSgn7OduI+YNVHMDXCA9KOmefWsHBl0HULej6I9id9RhapDHXR01LRkx
	QHKxSIanETMK3aI1MK1ZcJNi+WNXcPLhnnahOmTV/hTt7azF89s+f0Xu0kf1bjBm
	G3CLNF9um7nVULLXa9SVPUOQnpzwpAd50FbTpxveqz5wybCgKyTn1+bB+nMY7ESU
	nbpyf01GOlsY+3G1q3FIIT3BYNOj8LX6SQH+qi2nefFh5RrwrfksNOXK21FqlTR5
	ozH1Mxe9ir5xszOpYAhG/4UIApvKgueR1gSwJKaBXjSv8lOE8tQtzUsNT+t4r2VR
	RK1Hln/1ljiIWFo8ii8EUg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vyatw04ny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 30 Jan 2024 19:41:46 -0800 (PST)
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 40V3fkNn010690;
	Tue, 30 Jan 2024 19:41:46 -0800
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vyatw04nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 19:41:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ce6oFp9QULI/syRQIoGr/BwSilSCVRkJDit5AlIlfianPutaBkeCRil5kZoKYiqleVGhUH4heAs9oCkBkZEtyxld/M5zWG84vNO9R4taj9E0gmAxRDiAHTYc17UR/cAePQE9Akm4AKn2tZMomlHl67KKmPXdwyGczPeakWool2mT23iTa4l83gXFdnrrfEKPtVXwAqv1dicCmKgF55PHSZQNFmsvyyVzNSGq0j6EYuhPR3nber8jccciirmXk1lqmle1t79rMlH3hnoCB6hSz0A6lQ3g3PC9U9HpJgx+hQaJmNAAsmaj5uz7hhAAeB8F7cX4kop3XcaAI+QVIdE7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5tGfrAjW8uvi/xv7pyD1eDp30BKzHsGJ8I18Ce9NtM8=;
 b=JBaQD0eH9Qw1Khf9dYxJhwmBEwqr1zL2IlDnEAXcMt8nNhcIl2X4+iF11aF5xbbW6GeIQRehe8vr2xI9Y+pNt5WRuD2si521gik2lebEPs4i1KJat+QaalTmKvdzzJKAVNX+VrVv+EDKcPGTWfngFjo1IgzR54UsSqh2dIeDs7p7ttfjzgvlt8yAJLHlic0uZZV7LAujJveuVz1Uz4ukUrjXj3FX1RykQAvDF6Bqhp86ikZJH/aCsMKvnoe+z66YMryMOte9xCdAsG7gJ3Mftqj3wBMHxZV1JMPJwOwcaB0/mlhKlvd47EqtbqliALsACJDC6ueqDt/6wui1GY57Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SA1PR11MB7037.namprd11.prod.outlook.com (2603:10b6:806:2ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 03:41:42 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5d84:2b01:5029:9315]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5d84:2b01:5029:9315%7]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 03:41:42 +0000
Message-ID: <ce3c2fd0-50d1-87de-8981-6817aaad5abc@windriver.com>
Date: Wed, 31 Jan 2024 11:41:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [bitbake-devel][PATCH] fetch2/git.py: fix the try_premirror logic
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org
References: <20240130111158.1077626-1-Qi.Chen@windriver.com>
 <915d6f72d58debc70a36fd82a03c2ccdf5be7239.camel@linuxfoundation.org>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <915d6f72d58debc70a36fd82a03c2ccdf5be7239.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYBP286CA0031.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::19) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|SA1PR11MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: 29d268e1-a8f2-4616-3080-08dc220e8a1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3yEdtY/TolrvlT86f3c22Ih7MdwsIwKqFBl2m01fCXwTP3zB7tjkGq5Mh4FNDAB3S6l+emC2/trpiQfSXhwsXSL8tNF7p3ZY5BvIrcVb5FVSqENvs4uQxxhZHea9McTqUy7Fu4P4dBqGtfNzARRVbSkby2zVqg0YuCA+RtMKGEbn2vPPH08tlvHU26Ll0IvdcD6+8mHVvksx9+8z7ThtshTCv5c1voYxhBptV6pZ8okzmViiTLlQ6iwyj/mV9HTyYOh07Yv7NGsAQMQKc/UBQUx4YnPZQ0QMlxPOVK8MSx4EO8hVaslf1g8GfnLxbbji18oNmkD/eOag8D9M0s1Su/x4MSPjtyKcTD8k8VIH4Dus4P3bYeO6b/bGHyzzXcNpffs9yv8DO2VOQT139tod1h13T291ZVXojbNGvpG3Au5yDFqyYND6uDc9anDIiBpaJ4x5sQ/uHtzzXxEr0UU5sUhQMhfRd+4g+QTQipiQh3KKBdMj6hwYtd9cSoDuB9aQZaTYTghyPV+NCnxlTtfrnCeqvrhljhQre/puz77CwUvR80KSVTofBurc9TaO6duFr3UagNeNmVNy67zwSg932wT3oMYjA/F4RH+PG7fY/lkbnb/I0JJV9/VLQJCWHNpbs/uROxUAqf5C8sAiYTZAlQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39850400004)(136003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(2906002)(36756003)(41300700001)(6512007)(26005)(6666004)(2616005)(83380400001)(53546011)(31696002)(6506007)(66556008)(66476007)(316002)(66946007)(86362001)(6486002)(478600001)(966005)(38100700002)(31686004)(8936002)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dFFaNjh2RDJKRi9hRlh6cEk1V2NmOHZ3Zm9xMFEzQ1FkU3JUV3dOUzZENTV1?=
 =?utf-8?B?RlBoWFZFRU01R0FBTmhESWEzQ3oyeVJlOVBCREZPb0kzWVZIcVZTNVJ5NlNh?=
 =?utf-8?B?NkVCdU5yalpHditTeWFwNENyVWh2ZkJ1bndiNGlpTjd4Sk52K003dDF0b2h1?=
 =?utf-8?B?b0R6OGZ4anYwK3ZxcEwvT1lKMkZEWGcxS054Sm5sN1FadTlQWUl0ajlmNmhp?=
 =?utf-8?B?cWYvQXY1VmdUcVhjWHRNWGRHMVJMY2l0Y21COFhqU0VQZTBVZitZQUxEVTB1?=
 =?utf-8?B?MjREL3ordjFoRW40TVFpMUF3aWxPSUo3d2NjTHExNUNCRXlJWC8vNFkyZnBs?=
 =?utf-8?B?ZEZvR0tqWXNwNVhGcHV2NmRRN2NWNkZMU2x3NjVmOW5wdHUrMldxQlF6b0VQ?=
 =?utf-8?B?bkRoY05ENkowT0FmVFBKaWZFRlMwWlcvaWNER1htNmRjc3RoY2pmNkVIRTZy?=
 =?utf-8?B?ZUNjQ3NpdHo0NmxneTArdmtFRE5manJ0MG51eHRJY0ltSStnMS9tUGFod2VG?=
 =?utf-8?B?MmhYazFtTkZPdDJLeS8zRWlIUll3MHQ3WDZQTUUrakhORU4zUXhWU3J4K3lL?=
 =?utf-8?B?YkQ5SnZVRXora0k2ZG0yV29lMFhNSStOS0V2NXFoWWJlVE44VnYzdHNtTzdP?=
 =?utf-8?B?RUJvS25RSzl0R0I2T1c2cW84T1Nxb204OTNZRmhtdlFrOFBQUUg3Ynd1dkdz?=
 =?utf-8?B?Wkp6T25wRG5SekxsU29Fd2tLR1dKcElNUy94MG9wKy9XNVgvcElidzFZSlpw?=
 =?utf-8?B?aHVwTTdQdEdLdVd5RE9MckNtL2MwNHFzdURPRUtkUUp4cmpzWUFlaER6cFpS?=
 =?utf-8?B?bzJCOENKWFpEci9rUHJ5OEdKSDJkaTNtZFl2Z2M3Ky9yejh0ZVVDSFV6RmRp?=
 =?utf-8?B?MDF5VGw0UXBnRVprb2k0c0NMaTQ2UDF4VUk5Unc4RW1mQnpZbjIzZ3BpMjZI?=
 =?utf-8?B?TUZYZGhRMi9wM2UvZ0tLUE9KbTNDNVJJTW9ESjVqWTV3NkhSSlpKeU52RXZw?=
 =?utf-8?B?ZXdGSDdpQ3RtbWgxU21sbUUrYkN5MU83UW50YnRHQUVwRzZQcGtLUHZwVXRW?=
 =?utf-8?B?QTZWT2lweFNXNGh6ZjFBenNmbHZOVWtLcHpDOGRUMWF2RUx5YzRnYXo5OEUx?=
 =?utf-8?B?SDROZjY1RGk3ZHhkMVpJOXBQQnNqZk9rbGxUaW1CYWpGYkZJdnhVOU1nemV6?=
 =?utf-8?B?R21iNzVvaWI3QzJrOGVCeTgvRjZpaVlQbWJkbVV3SzJYNE5KbkVXZEN6UFpC?=
 =?utf-8?B?YjY1VTArTVBIT2FJV3g0TzArb2NJVkpSNzB5OW1SWVZBWkhjZURWaVdra1JH?=
 =?utf-8?B?UW44OU1jb3pIYmw5dFl4YVpWWm8xM3cxdGx4NzY0WEhESTFoZ2MvOEkwZlFG?=
 =?utf-8?B?RmtBYjBDaTlleHEvSTVxSktUZlJnN1JYL2JHTnI3WG44UUZpUjl2TmxLOGJp?=
 =?utf-8?B?VHJ3cmJUMmp1MVV0eDB0WXRLdm5BRmJsZ2QrZmtNVWNHVTFnS0lBNnpwMkVK?=
 =?utf-8?B?YnRXc0FCTXVTR2NYcW1tY3V0SVBYZmduYU5PWG1vMS9BVDlKZnpQTUZ0cTZv?=
 =?utf-8?B?bDBGemRzeC83a2l2a1N6RjBPcHhRaXo0V2lKUUlVbTcvTHJ2bnNDZjQ1MHlH?=
 =?utf-8?B?Z1RFWmZZZFVvNll0dDFCYlN2M24wMXZBeEJqZGhmOEFidXZENU1FQTZqaGVG?=
 =?utf-8?B?enRCVDB2S1lIYUpZYU5ZWkJsWlBwLzBRRE9PWGFKYU5jMCtsSi9CamZzSzRR?=
 =?utf-8?B?MzA2eWhMb24wVmJSRXhWK0hlbVJ1MWFYTk5LclBYbFlSVHFqRExOSlU3KzEv?=
 =?utf-8?B?NnBJdkk3a3ZHMVlaZUtVbzlHTkNMaklZQ2dzTExjRXlsaHUzY3VyYitXNEpv?=
 =?utf-8?B?Si9nQ0JOalVuK0E0NlhDRWVUNTdHYXZaVjlBWVA0YWhsdnIvakNXZUl1cFNj?=
 =?utf-8?B?RnA4dTUrRVhFaVk4cUN5aUV5ekZ5TDFyS1VDSUZoeWNCR25WVjRlUG5idmpD?=
 =?utf-8?B?NHNRZ1B2eFdQQThyQ3lwTExqNWpjWUFFMm00ZXhVaDBrNC9LblZMZ013eWtz?=
 =?utf-8?B?eXZ2NVBlZ2JyelNnS1hCeXV0clN6bEFqUFBISEx4dmtlV3RwRE5aV21CeWVq?=
 =?utf-8?Q?Bg5gCuLLp0hh5kjPEr2YdLvv+?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29d268e1-a8f2-4616-3080-08dc220e8a1e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 03:41:42.2875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFbb4mkt1Sv/G8vL7ngw0FUbI8Bfrj+ulaYDij7jjkf37kqYHALWHWRWC4hiv0B1ajReh+hIec5/ai4J9mwqxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7037
X-Proofpoint-ORIG-GUID: TPPl796hyzWgpNu8H55QwDxmeEn_X_Ja
X-Proofpoint-GUID: mJYIDnAVvqDuCO5fdzLrC6o_cVGnKHWD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_14,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 mlxlogscore=999 suspectscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310028
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 31 Jan 2024 03:41:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15812

On 1/30/24 22:56, Richard Purdie wrote:
> On Tue, 2024-01-30 at 19:11 +0800, Chen Qi via lists.openembedded.org
> wrote:
>> From: Chen Qi <Qi.Chen@windriver.com>
>>
>> For gitsm recipes, it's possible that some URL is used more than once.
>> e.g.,
>> A -> B:rev1 (B is a submodule of A)
>> A -> C (C is a submodule of A)
>> C -> B:rev2 (B is a submodule of C)
>> A anc C are both using B as submodules, but on different revs.
>> Now if we have:
>> B:rev1 -> D
>> B:rev2 -> E
>> Then, the mirror will not be fully used.
>> Say we have all repo mirrors for A, B, C, D, E, then in theory it's not
>> necessary to reach out to any network for downloading. But it's not the
>> case. After downloading B(rev1) and its submodule D from mirrors, the fetch
>> process continues to download C, thus B(rev2) and E. Now it finds that B
>> needs an update because its submodule E needs an update. Of course this is
>> true because E is not downloaded yet. Now the problem comes to whether to
>> use mirror or not. The git.py defines try_premirror to return 'False' when
>> the ud.clonedir exists. As B has been cloned, the ud.clonedir exists and
>> try_mirror returns False, resulting in not using mirror and going to upstream
>> directly.
>>
>> We can see that the mirrors are not fully used. This is usually not problem,
>> as the cost is only some network download. But in case the following two
>> settings are there, we get errors.
>> BB_NO_NETWORK = "0"
>> BB_ALLOWED_NETWORKS = "*.some.allowed.domain"
>> In such case, the gitsm recipe A will fail to fetch. Note that all contents
>> that A needs are in mirrors and now it's failing to fetch. This is unexpected.
>>
>> Note that the different revs of the same repo in gitsm recipe is not the only
>> way to reveal this problem. For example, there might be a recipe call B that
>> uses B:rev3. Check the protobuf and grpc recipes as an example.
>>
>> For now, we can use the following steps to reproduce this issue. To be clear,
>> the grpc recipe in meta-oe is now 1.60.0.
>> 1. Add in local.conf:
>>     DL_DIR = "${TOPDIR}/downloads-premirror"
>>     bitbake grpc -c fetch
>> 2. Comment out the DL_DIR setting in local.conf and add the following lines:
>>     PREMIRRORS:append = " \
>>       git://.*/.* git://${TOPDIR}/downloads-premirror/git2/MIRRORNAME;protocol=file \n \
>>       gitsm://.*/.* gitsm://${TOPDIR}/downloads-premirror/git2/MIRRORNAME;protocol=file \n \
>>     "
>> 3. Set BB_NO_NETWORK = "1" and then 'bitbake grpc -c fetch'.
>>     This command succeeds and this shows that the premirror holds everything we need.
>> 4. Add the following lines and then 'bitbake grpc -c fetch'.
>>     BB_NO_NETWORK = "0"
>>     BB_ALLOWED_NETWORKS = "*.some.domain"
>>
>> After step 4, the error message is as below:
>> ERROR: grpc-1.60.0-r0 do_fetch: The URL: 'gitsm://github.com/protocolbuffers/protobuf.git;protocol=https;name=third_party/protobuf;subpath=third_party/protobuf;nobranch=1;lfs=True;bareclone=1;nobranch=1' is not trusted and cannot be used
>>
>> I guess that the try_premirror codes in git fetcher (fetch2/git.py) are assuming
>> that the clonedir syncs with the mirror repo. That's only reason I can think of
>> for why it returns 'False' if the clonedir exists. The assumption is wrong. The
>> mirror could well be updated via automation tools or some project-level setup
>> tools. Yet, it's returning True when BB_FETCH_PREMIRRORONLY is set, regardless
>> of whether the clonedir exists. This means it does know that the mirror could be
>> updated. It seems that it treats using mirror as some kind of 'best effort'. Anyway,
>> the codes' logic is just contradicting with itself.
>>
>> If the mirror can be possibly updated, then it should be tried regardless of whether
>> the clonedir exists. So we should remove the try_premirror codes here and use the
>> default one (in __init__.py), which always returns True.
>>
>> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
>> ---
>>   lib/bb/fetch2/git.py | 9 ---------
>>   1 file changed, 9 deletions(-)
>>
>> diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
>> index 7aa3fd9e5..62618012b 100644
>> --- a/lib/bb/fetch2/git.py
>> +++ b/lib/bb/fetch2/git.py
>> @@ -353,15 +353,6 @@ class Git(FetchMethod):
>>       def tarball_need_update(self, ud):
>>           return ud.write_tarballs and not os.path.exists(ud.fullmirror)
>>   
>> -    def try_premirror(self, ud, d):
>> -        # If we don't do this, updating an existing checkout with only premirrors
>> -        # is not possible
>> -        if bb.utils.to_boolean(d.getVar("BB_FETCH_PREMIRRORONLY")):
>> -            return True
>> -        if os.path.exists(ud.clonedir):
>> -            return False
>> -        return True
>> -
>>       def download(self, ud, d):
>>           """Fetch url"""
> I'm not sure this is a good idea. The problem is that the default
> fetcher would not try and incrementally fetch into an existing clone
> without this code and that is a common workflow.

'Incremental fetch'. That's the reason! Thanks.

I'll come up with another solution which will not break this workflow.

> Did the existing test cases pass after this change?

Is the following command all I need to ensure no regression in bitbake 
fetcher?

bitbake-selftest bb.tests.fetch


>
> We probably should have a test case for this issue too.
Yes. I'll add one.
>   Things have
> changes now mirrors/premirrors are non-destructive to existing git
> repos so we may be able to improve the core logic to fix this corner
> case but it can't be at the expense of some of the other workflows.

Got it.

I just found a related bug here: 
https://bugzilla.yoctoproject.org/show_bug.cgi?id=15369

Though it's not the same problem, it's also related to try_premirror logic.

I'll add some comments in the try_premirror function to avoid confusion 
in the future. I'll also check to see if I can add a test case to cover 
this 'incremental fetch' workflow.

Regards,

Qi


>
> Cheers,
>
> Richard



