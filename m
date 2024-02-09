Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD990C48297
	for <webhook@archiver.kernel.org>; Fri,  9 Feb 2024 21:13:58 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.24472.1707513235160125679
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 09 Feb 2024 13:13:55 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=eAmXyg2z;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=276984c5ba=randy.macleod@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419Ff7Zu018855
	for <bitbake-devel@lists.openembedded.org>; Fri, 9 Feb 2024 13:13:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-type:message-id:date:subject:to:references:from
	:in-reply-to:mime-version; s=PPS06212021; bh=9RQT5rLKq4JlEN0JQ9p
	L18JR8VOQC8qfcu0Z/Rz86zs=; b=eAmXyg2ze3CsrvYQw9slk5QGt2BElWT2bUU
	aPuHd6QK77bqkykqc9GHrHBMRtoF/iBLS6oxfA/Y+zwTrJSvmo0mOzk+a3t62JBE
	1B7GTB65nJFMIMOwicuHBe1W62R/dO6PRtYdQNfRrqOZSbPPXifa22YkdRgraqIz
	B9CIRnON1z8vV5IoEv7a3DEtSS1scw4wTOrYXd5RiPTxcVNFIF+O9LpnEoL1F+cC
	UhnkD7+KPVT44wbExBtblgT1x97MC0BLcjMwgmLQwhEyMssKDe3J75jzv2MW9LVU
	6Op2XZWu5boo5+cflRWC/ioCb7eAzwTSuAlx7g+7KNgknwX1iHA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3w1hn3xe0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 13:13:54 -0800 (PST)
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 419LDsdh015264;
	Fri, 9 Feb 2024 13:13:54 -0800
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3w1hn3xe0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 13:13:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdQIl+Fi5zpDARphWefo3zekR08m5eYnl6N498UJgnAGoSCX66aWn/T+KLJLHFdYossgDCFkhgQE/Y4wBQbBKEzMz8cpuvwVNFaiVS18+8WENzRVABXXNQu1YkKrSv6vu9cQto+pK+laj9WOyXVZqRU/vYOGdMZ3+f3lzpSC0jHWusky1j60bMGXeKJhFMVkx2k8knMVwuG9XQRgI0LDcul7rw+XkwuKcjqbf/q6x8SE/1zDjlUnd4pWa1XpSigZjzJ2D2kafYygW7OX/MrpTz60fT49We1cK5fXIBL9jXEQXUWqimF697qg4F3mvimgJJiG2WQyxI85gwuBFBFfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9RQT5rLKq4JlEN0JQ9pL18JR8VOQC8qfcu0Z/Rz86zs=;
 b=JVv/tDgvOYX/BjzL38QUdR10qZppXZgw4DOm8aq5Lqe8TyARy+ITzUnn+APTbdt3TDn5U0KUPFv7ZMs/BY3pkCRPHG+BU5BTWLf6N6Uissyqwigxa0RjJ45jRhv4BUz9IRn+QbuM8kPSi8QZWthEoUBd9rwBkkTgufQU0l0iFBGsM4srHTNd+q/6flUFGhvQ01Kt9hzpI4RY0k47v2nypHPW2GWKexWh0xraecNiLdA2hZToruUphiPs8zh8p1DiM5Th9enXvr7aEeqJgYZLKzcN1WWY2NJWvEskvP1La03ri4BXYzc/Do6VJNdq8yRX4d8SVHEdBjHgBKRHHv+xCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5920.namprd11.prod.outlook.com (2603:10b6:a03:42e::9)
 by PH0PR11MB7613.namprd11.prod.outlook.com (2603:10b6:510:285::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Fri, 9 Feb
 2024 21:13:49 +0000
Received: from SJ0PR11MB5920.namprd11.prod.outlook.com
 ([fe80::f3ba:ff33:12be:cff7]) by SJ0PR11MB5920.namprd11.prod.outlook.com
 ([fe80::f3ba:ff33:12be:cff7%7]) with mapi id 15.20.7270.024; Fri, 9 Feb 2024
 21:13:49 +0000
Content-Type: multipart/alternative;
 boundary="------------QmjClTwRXSYO9o0wLihH2yBR"
Message-ID: <49602c0f-5033-468b-b034-5535e581a0d2@windriver.com>
Date: Fri, 9 Feb 2024 16:13:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Underscore vs Dash in bbclass filenames
Content-Language: en-CA
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        Saul Wold <sgw@bigsur.com>, bitbake-devel@lists.openembedded.org
References: <f8f81126-3fec-4dbd-8088-64d615879167@bigsur.com>
 <93a90192cda3bb300f0e53348648d1b0c1ecc5f9.camel@linuxfoundation.org>
From: Randy MacLeod <randy.macleod@windriver.com>
In-Reply-To: <93a90192cda3bb300f0e53348648d1b0c1ecc5f9.camel@linuxfoundation.org>
X-ClientProxiedBy: SA1P222CA0079.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::16) To SJ0PR11MB5920.namprd11.prod.outlook.com
 (2603:10b6:a03:42e::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5920:EE_|PH0PR11MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 08886df9-5cf7-4c65-1221-08dc29b4026d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	syPO2xS/EUerbveIYU93M19gO/PeMN5pHacE01Q4Ekr0bWnYp0vL5r40QAYS7ifKk+q3ksNxrkdiyukCSgw83LFgcShNSet0kMbSPoId9ribe5vvnrJhLwtM5+EqKrU2dZEra2e8XSp8bPX89iYAui29aHg9SnnTLPGG/Z5Rxjv2Chlaiml8AsKo4eOU/jSEiyOjve73qnttLOIaFbiZ2K6DAil4xWpCLT0y+WVJXhi+g9VKaAos5hD4pZQjbH0KdHMPaYRn8dbH6/nmg+doIa+D4SonDaKocZTOAq/OpPtBBt24zIKXiHfoiv8GGQ6Pg4JCIkL8uuX/3WXfQKEzPWT3kh2T6litcq5faFH0IzDveWkOHYxMBeUoOzUkRr7Ojl29SyaycagmCpCzcn4YQn5XXgShBU5kWPLZvUOoVLAqQn+q0dktl/yui3yI084b7iSSqRuIHbwMqJU/mUwJXNVomRJ95IKB1KdUWvtpmzmnPI0siwVTizAtX7h6TtK8uH3De9fr1qm7JvmiuhFLPrZLR+RNVKZHwx25i4y6EIxHQW6vjpAgdyG+rLxXGUun
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5920.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(136003)(366004)(396003)(346002)(230922051799003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(6486002)(36756003)(66476007)(966005)(83380400001)(6666004)(6512007)(6506007)(478600001)(5660300002)(26005)(2616005)(2906002)(110136005)(66556008)(66946007)(8676002)(316002)(8936002)(86362001)(53546011)(31696002)(166002)(38100700002)(33964004)(41300700001)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Nm9wL1pqS1lQRmhyQ1h0WTQ5R2hsUW9ISGNId21KR2h4ZnlFTXB0M1owdVlZ?=
 =?utf-8?B?R1hOcnRhbHVnREszeTBtMVArcVFqS29YTE1pek54N2J5ZVpsbE9JVmgxaDF0?=
 =?utf-8?B?U2lackhMZjhwdmhtcnhKY2IyMlRia1oyTVNramdZbkF3SmllQjBINEJKUUo1?=
 =?utf-8?B?WDZtMUVGTjJ1Rm1NN1duY2J3T01YdmltaGM5RzFNajdDUTd1eEFvL3JOUnBQ?=
 =?utf-8?B?dVlCdk5BVGkydmE1aWZMbjdMVDQ0dkw1ckV4SDc5SzY4M0h0dWFENzhrSEpU?=
 =?utf-8?B?c1RKWWZNK2RSNSt4ZTNaQ29WMXJyY3k5bEYvYXFWTUVFZ2czTjlUYmhxL1Av?=
 =?utf-8?B?SmtwcjZFTXlpYjhTWk9aWGVma1p3dDJub2h2TkZ0OVdrcER0dURNWm1wWDFI?=
 =?utf-8?B?dHZDT016VSsrVndpQ212Y0x2U2dTSXpJNVJlL2tnbXBzMGpyckphaTU5NTNX?=
 =?utf-8?B?d04xUHBlNS92VnZVZ1ZCSE1HWVJDbm13Y3VBckRDRSt1TEtzTGhNRmp5d1dV?=
 =?utf-8?B?TGxNYjh5dUMxUzJwRkp0WUswZVZkZ0JucEQ0bWIzSmtCWmxxUlBOaXR3aUYy?=
 =?utf-8?B?NUNGM3VYNGpld3g5TTFyL0lMTzNYRTB1MjBEUE8rTzFrNjMvc0pDWEZSR0lW?=
 =?utf-8?B?MENUZEFDYnc1Q21lSjZEL2RocERVdThEeTZGV2RWdUsxMWpWOXR5Z2ZGWVgz?=
 =?utf-8?B?UG1oaEJhTitsSmxCMmxabVB5UjFEVTZIQ0dabVBPTm1ndnBOWCtnNDJzTjhE?=
 =?utf-8?B?bXQ2djkyTmxoamtCMEwweXNEbyswZS82N0NRVEw4ZWd6NERodGFqbzU2Q3JL?=
 =?utf-8?B?cG9YRUZqTW1OTWlkMGZMY1dHSXFLYjFxdUJmQ0pYbnA5TGJRbUQ4anN5ekw0?=
 =?utf-8?B?dC85ZXNsNzYzekVFbXNUN3Q0d0wxd0IvZlBWSi9wUWVLMW1DVTJFd2RhaEx3?=
 =?utf-8?B?bm5nOVA3RENVaVZteDcwUE5SUk1BOWNZUG5Majg0bmJYM1E5NXJCblFnMHhl?=
 =?utf-8?B?bThGV1NlYmh4VVhJcGZQWVBzSXR0QUlwaU9IV053R2V1WEExaEU4a2hUVUJh?=
 =?utf-8?B?Zm1qeGptb0wrMVRjZ1UxeEpkTUdkRzJBQjE5SS92ODcxamgzZ3lnU2x5TUl2?=
 =?utf-8?B?NTZSVmhxaFNIeFpwUmdkb3lhWWdjK0tKelVXZUNnUi9IZWRoRUE3WFpzam5q?=
 =?utf-8?B?Y1hTUGZNK0dkbFlSYU96L3dqRUVhKzJxZ21lT0FIaE5BSTk0NmxQZ3orSDBS?=
 =?utf-8?B?Vkx5d21lSGd0SjZhcXV3ZUEvcWhnNzRlTWRuRlRGRGtFQUJsYXQ1RllMazZO?=
 =?utf-8?B?Z2haSDRXSEFOVVd3cy9NZkM2T0Z5ZmVwSlhhWHY1aDJNamlmT09mRVFMSlVT?=
 =?utf-8?B?R0JOMXlDYkh0dGYrK3I4YklnaGdhZnlJZHhtSURUTUZIQlFzNG1ONXJ6NGhp?=
 =?utf-8?B?RG43ZFZsNTVmMU40WE1BTWN0di9zQ000RENTaVVBR0dLNFgxYUpNaGR3dE8w?=
 =?utf-8?B?bjNJQStsc1g2MXd0dU1rYmQ0ZzJqNjFtLzg4bis2WEhKSkhpYnpYV05VbDJV?=
 =?utf-8?B?Z0hkM3ZjbVlkdkJIZUtqdnhBbC9aTmVHTkhJSUpScjFPZHRJaHd3aUhWTlJ3?=
 =?utf-8?B?ZWpJZVlRWUFnczQxQ2l4MHNhTFZJczh2MmZWTG1UOXFPa1d0WjJCUWhjVG1y?=
 =?utf-8?B?cWNiN3RDS0t0YWxuWTIzbHdzbVBlcE42Y1VvSkUxRGllN2o2MngreVNjZ0Nr?=
 =?utf-8?B?Sm9WNEwrMTFrVGk1MnlsNGJ6eDZwWnlpR3ZIU0Z0RVE0Ui9WY1UyKy9hOWdN?=
 =?utf-8?B?OGhmSUYxdWM5bzV4YXdQWDBtL1pJandjOHhwZmJON00ra2lHVTBHMW52Yk4y?=
 =?utf-8?B?WkwyZlBRaHExejNMTXhEbURpSXhDT0FUUzZtNEJyeVpMMi9zY0R2Mk9MVFdt?=
 =?utf-8?B?UlZuRzgvVGRnc3JjSHYrdGhtdVhMSU9lemlKVkRLd1lsV25NTkRHS3pRSjhV?=
 =?utf-8?B?elRCNGY4WS9wUTdkSGovR3NjYW9za0xwWGRUZ0pJck9SNWpMbWpQWTBFVlVN?=
 =?utf-8?B?K0kyT3RWanEwNVl6UG4xOENNN1ZuUmZQUUxHbzRWTFI5VlhoKzVobGhuK2Uz?=
 =?utf-8?B?QzlMeWxBNmt3dGVBWDZ3SUkyazdKcWlKTnJiK2dLMVQ3cmxoTnR6NTB3NEVB?=
 =?utf-8?B?Y3c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08886df9-5cf7-4c65-1221-08dc29b4026d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5920.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 21:13:49.2723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCdDvYqoFKnMS+2Zy4rSLG+vsl1N+dqrxLxHE2TsS/uZcQT/WWURGkmmxm+hWVczZlScjZaUKStfrOu5FT02fb4kPbm6t+/k3jWXlKQwTB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7613
X-Proofpoint-GUID: A0vVx53lGbqjzL63CZr04mbVrBbw6pXk
X-Proofpoint-ORIG-GUID: vnZGIY0R9SKgPRoVh07-ehFRzdjdCe83
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_18,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1011 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090154
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 09 Feb 2024 21:13:58 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15865

--------------QmjClTwRXSYO9o0wLihH2yBR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 419Ff7Zu018855

On 2024-02-09 1:05 p.m., Richard Purdie wrote:
> Hi Saul,
>
> Thanks for looking at this.
>
> On Wed, 2024-02-07 at 14:21 -0800, Saul Wold wrote:
>> I was looking into Bug 14235 [0] and had initial patch based on Randy'=
s
>> original recommendation of using dash (-) which was a basic
>> python/tinfoil script to check existing bbclasses in the BBPATH.
>>
>> It was pointed out that the bbclass name is prepended to exported
>> function and that would cause problems for SHELL functions as dash is
>> not allowed in the shell function name.
>>
>> On further investigation this of course becomes a more nuanced problem=
,
>> so I considered an alternative approach for setting up a warning in
>> bitbake itself.  There is currently an error check in bitbake's ast.py
>> ExportFuncsNode() code. The code below would warnonce() for other
>> bbclasses that have a dash and are not in a NO_WARN_BBCLASSES list.
>>
>> At some point in the future this warning can be changed to an error.
>> I also noticed that the Regular Expressions defined in ast.py could be
>> tightened up slightly, there are a couple that use \s (general string)
>> vs \w which limits some special symbols, in order to limit dashes from
>> appearing in function names in bbclasses.
> Was this for python or shell functions or both? We should probably
> tighten the shell case at the very least.
>
>> This is not for the current Scarthgap release.
>>
>> diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py
>> b/bitbake/lib/bb/parse/parse_py/BBHandler.py
>> index cd1c998f8f8..faf6e9ede63 100644
>> --- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
>> +++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
>> @@ -116,6 +116,9 @@ def handle(fn, d, include, baseconfig=3DFalse):
>>        init(d)
>>
>>        if ext =3D=3D ".bbclass":
>> +        nowarn_bbclass_list =3D d.getVar('NOWARN_DASH_BBCLASSES')
>> +        if '-' in root and root not in nowarn_bbclass_list:
>> +            bb.warnonce("%s contains dash ('-') in name which is not
>> safe" % base_name)
>>            __classname__ =3D root
>>            __inherit_cache =3D d.getVar('__inherit_cache', False) or [=
]
>>            if not fn in __inherit_cache:
>>
>>
>> Thoughts from the bitbake team on this approach?
I reported the bug just because I noticed the inconsistency and
thought it could be annoying to people.
>>
>>
>> [0]https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14235
> If we are going to warn about something, it would have to be the dash.
> This kind of patch would seem to be roughly the right way to handle it.
Fine with me.
>
> My main question is whether we do want to force users through this
> transition or just stop new classes? Does the inconsistency really
> matter? Do we need to do anything, is there a problem we need to solve
> here?


It was just something=C2=A0 I noticed as being inconsistent.

I'm fine with trying to make only new bbclass files more consistent as a=20
starting point
given that having all of one or the other separator is problematic.

Thanks for checking it out Saul!

../Randy


>
> If we do, do we support a set of "remapped" classes, where for example
> "inherit create-spdx" would translate into "inherit create_spdx" ? That
> does still have potential function name issues but they probably don't
> work today with dashes in and any class using those did already
> probably switch to an underscore.






>
> Cheers,
>
> Richard
>
>

--=20
# Randy MacLeod
# Wind River Linux

--------------QmjClTwRXSYO9o0wLihH2yBR
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2024-02-09 1:05 p.m., Richard Purdie
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:93a90192cda3bb300f0e53348648d1b0c1ecc5f9.camel@linuxfoundation.org">
      <pre class="moz-quote-pre" wrap="">Hi Saul,

Thanks for looking at this.

On Wed, 2024-02-07 at 14:21 -0800, Saul Wold wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">I was looking into Bug 14235 [0] and had initial patch based on Randy's 
original recommendation of using dash (-) which was a basic 
python/tinfoil script to check existing bbclasses in the BBPATH.

It was pointed out that the bbclass name is prepended to exported 
function and that would cause problems for SHELL functions as dash is 
not allowed in the shell function name.

On further investigation this of course becomes a more nuanced problem, 
so I considered an alternative approach for setting up a warning in 
bitbake itself.  There is currently an error check in bitbake's ast.py 
ExportFuncsNode() code. The code below would warnonce() for other 
bbclasses that have a dash and are not in a NO_WARN_BBCLASSES list.

At some point in the future this warning can be changed to an error.
I also noticed that the Regular Expressions defined in ast.py could be 
tightened up slightly, there are a couple that use \s (general string) 
vs \w which limits some special symbols, in order to limit dashes from 
appearing in function names in bbclasses.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Was this for python or shell functions or both? We should probably
tighten the shell case at the very least.

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">This is not for the current Scarthgap release.

diff --git a/bitbake/lib/bb/parse/parse_py/BBHandler.py 
b/bitbake/lib/bb/parse/parse_py/BBHandler.py
index cd1c998f8f8..faf6e9ede63 100644
--- a/bitbake/lib/bb/parse/parse_py/BBHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/BBHandler.py
@@ -116,6 +116,9 @@ def handle(fn, d, include, baseconfig=False):
      init(d)

      if ext == &quot;.bbclass&quot;:
+        nowarn_bbclass_list = d.getVar('NOWARN_DASH_BBCLASSES')
+        if '-' in root and root not in nowarn_bbclass_list:
+            bb.warnonce(&quot;%s contains dash ('-') in name which is not 
safe&quot; % base_name)
          __classname__ = root
          __inherit_cache = d.getVar('__inherit_cache', False) or []
          if not fn in __inherit_cache:


Thoughts from the bitbake team on this approach?</pre>
      </blockquote>
    </blockquote>
    I reported the bug just because I noticed the inconsistency and<br>
    thought it could be annoying to people.
    <blockquote type="cite" cite="mid:93a90192cda3bb300f0e53348648d1b0c1ecc5f9.camel@linuxfoundation.org">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">


[0] <a class="moz-txt-link-freetext" href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=14235">https://bugzilla.yoctoproject.org/show_bug.cgi?id=14235</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">If we are going to warn about something, it would have to be the dash.
This kind of patch would seem to be roughly the right way to handle it.</pre>
    </blockquote>
    Fine with me.<br>
    <blockquote type="cite" cite="mid:93a90192cda3bb300f0e53348648d1b0c1ecc5f9.camel@linuxfoundation.org">
      <pre class="moz-quote-pre" wrap="">

My main question is whether we do want to force users through this
transition or just stop new classes? Does the inconsistency really
matter? Do we need to do anything, is there a problem we need to solve
here?</pre>
    </blockquote>
    <p><br>
    </p>
    <p>It was just something&nbsp; I noticed as being inconsistent.</p>
    <p>I'm fine with trying to make only new bbclass files more
      consistent as a starting point <br>
      given that having all of one or the other separator is
      problematic.</p>
    <p>Thanks for checking it out Saul!<br>
    </p>
    <p>../Randy</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:93a90192cda3bb300f0e53348648d1b0c1ecc5f9.camel@linuxfoundation.org">
      <pre class="moz-quote-pre" wrap="">

If we do, do we support a set of &quot;remapped&quot; classes, where for example
&quot;inherit create-spdx&quot; would translate into &quot;inherit create_spdx&quot; ? That
does still have potential function name issues but they probably don't
work today with dashes in and any class using those did already
probably switch to an underscore.</pre>
    </blockquote>
    <p><br>
    </p>
    <p><br>
    </p>
    <p><br>
    </p>
    <p><br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:93a90192cda3bb300f0e53348648d1b0c1ecc5f9.camel@linuxfoundation.org">
      <pre class="moz-quote-pre" wrap="">

Cheers,

Richard


</pre>
    </blockquote>
    <p><br>
    </p>
    <pre class="moz-signature" cols="72">-- 
# Randy MacLeod
# Wind River Linux</pre>
  </body>
</html>

--------------QmjClTwRXSYO9o0wLihH2yBR--

