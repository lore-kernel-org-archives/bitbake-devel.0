Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB61C6FD1C
	for <webhook@archiver.kernel.org>; Fri, 24 Mar 2023 07:23:05 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.95136.1679642575147321388
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 Mar 2023 00:22:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriver.com header.s=pps06212021 header.b=gpFqCRsN;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=244794046a=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32O6kFgQ005558
	for <bitbake-devel@lists.openembedded.org>; Fri, 24 Mar 2023 00:22:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=message-id : date
 : subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=daMko7TzoFidj6K33gHM7SLL0bF6Gdzq2H+G7jxGcIw=;
 b=gpFqCRsNaynSOdyh6AjUkMaiRkvAe5udsALAY/nuMhIlyRP+S5ZRpBddw8o6BDUtYJvp
 4CbuRhZOsSf4qzNUc47+7chatEJv1FG7ELg7w9esdoTXabXphZFhijhoMetR6xhNJD55
 jF+7+MSirqEt7ouCrh0gmWIuemY77OtjBYNeOXSDK5y5rJUM4Yj69c0ZptSRu9A/EAUb
 DjyA4Pry5JI9OxGctGZOVR0Y2O9MtuVTMZrYkSa7InGny5usIEPFpZK7auShinHQqniV
 tqILPG4b8pYe3C0HDx+FRUpi8u45+HnOXot+BAckroTDerVYwKTlvBJqdyheTpxunblX Kg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3pgxhs8e4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 24 Mar 2023 00:22:54 -0700
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32O7Msip019606
	for <bitbake-devel@lists.openembedded.org>; Fri, 24 Mar 2023 00:22:54 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3pgxhs8e4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Mar 2023 00:22:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REpdf7pLly1RBzcNQMLH5d03AmAqhS/IgIOF39VtsCYOkdOIdtj9QV9aKn1MsQ8DD4SsJg5LT+HH4aQOjrL+K2zSyhI3bAuObq3nGBkYE3RZjRcDC2rhvPI75pfOpEZEJ+fR8lDksR+/Ck9cQ3neQIP+FRFw5QdQmKzjM1a3BTNvpGzrkzucHg+WraWy2LkQ4+RU1mD/N0RGMwRRNCzCMIp2lUQ0N8q+3KfUrgoTeWslGpzdNt0HtV7+28b+X5Sd7iE4JDb6pEVE0VdgOGglQGvxwxNz2b4/zM/7eWpyO2UpbsWCgCv7MBHnv5DWxwkKg8As/u/7zcoQZCcBfnlMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daMko7TzoFidj6K33gHM7SLL0bF6Gdzq2H+G7jxGcIw=;
 b=MgOiEYNk5jZ+r7ERAMEHbFJZyt3lpORPo0ExfU4GlHBy6xEjpnWrHRqVmynP7F9qe947xmvgg5NLCe/a1C1BOob8VvFUrxWhaYjYzDRu04W8qsyNEzUu8U3z3DnE6nHimUnvBHnff1g2olQvXivOY/kveD3D1wCotNViT5nzxtdsVVWV1HA+dDwO2NL1wR4xLmol8s/cwJG1CRGAdg2k5FxWT+yOFM9zuAh4fTL5eT7ZtbtICw0E/d5xNRFYWnOYVS8j7Q+wa1P9GJ1GVW9I7Vn+jF2kGhIHMWnp5GkYkc1HNNmufQThzpdtN5F6SWeRxTRWiNFGIpYSqJKb7xBbLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BYAPR11MB2789.namprd11.prod.outlook.com (2603:10b6:a02:cc::11)
 by CY5PR11MB6187.namprd11.prod.outlook.com (2603:10b6:930:25::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Fri, 24 Mar
 2023 07:22:52 +0000
Received: from BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::f4a4:6efd:1e60:66c]) by BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::f4a4:6efd:1e60:66c%5]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 07:22:52 +0000
Message-ID: <4e22af8d-330e-ccca-5a9e-180e1234f9b6@windriver.com>
Date: Fri, 24 Mar 2023 15:22:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [bitbake-devel] discussion: git fetcher now needs either file://
 or -s
Content-Language: en-US
To: troth@openavr.org, Sam Liddicott <sam@liddicott.com>
Cc: bitbake-devel@lists.openembedded.org
References: <CAOj-5WB8oaXJ=rrXDNRYzhB92CgRrsutveMnWXhEpcEJKb60KA@mail.gmail.com>
 <CAFMvBt0jkfvDACAmWS6NNcUAv+DM=BMGHZS+MBnn0fYPohAJ5A@mail.gmail.com>
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <CAFMvBt0jkfvDACAmWS6NNcUAv+DM=BMGHZS+MBnn0fYPohAJ5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SG2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:3:18::31) To BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB2789:EE_|CY5PR11MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b07b3d1-4a9a-47cd-0070-08db2c3893b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HllAqcNp73ArxFr2L+UnI1TtjOkp6weog+ltaCWdne80eQmW3QeBhE8OJDoA9C1EaO/AxA2aLyI6Jvtoy7GVr/JGt2zu7+GFQxC/83lZFAnF0gI7i9dIZZy8h5Qn/Zk5nzGDTONHDO5IxOj0I3IbXCpXjWB5ru/nPboBcAZz2u0jY873GXpC6UFGoDVJIGQ7TjTVXfb7JP3lOtCyQ49PGquCV50Jtg9Iu0X9kIHNhHjZv7y9GsZgDPJKzFZSs4YC2Rf01kJMj4/nh+FFI7Aw4lZAxg9EvqSlUn0T37Qvu23M6cJe9pUV6+tfxy+QyZHOdbmK580jpuQ5va+qrlJl/t+RZrjKFc7o7t2QDtfdKa8hzeZLl3bXC9SYdG4J8w2U1ErGj8HIy2l6gLTgZDA8XDuWCdGSMuD7gSyYe54MOm5D0btZL80jloF5FqSGkOEF8y+CjZsPuFkNuqNVa+ltB4G/5CnaCt1alE7RaP7Qg3wcnStMz0a/zfM9rbhhDwVzqA4fKdbXYPbtjo+/Uh97TE8H2BKJo4QQml9IdCrs+52k5D24ya8zvSMGyeek5NlQLXyyDD10HQjVACZ1OjE0nOk6HkT2xe7p0uK2dXAPYarwZWyodprFcFgIef7ASelaw9/Zs34gz5mL86Ao85cO4MYIn1gvH9poMX4d4KbIHUL3sl5bWtuaXMzG22RUS8HuISnMa1sG4VE28QJgDQHwMDeIJZPBdQSTF44ttdgLsaWGtKCbcyGksfjwLi06MNwaOFkBgTB08Fpcjp8dgnlSfQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2789.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(376002)(396003)(39850400004)(136003)(451199018)(36756003)(31696002)(8676002)(86362001)(38100700002)(5660300002)(6916009)(66556008)(4326008)(2906002)(66476007)(41300700001)(8936002)(83380400001)(2616005)(186003)(53546011)(66946007)(6506007)(6512007)(316002)(478600001)(966005)(26005)(6666004)(6486002)(66899018)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OWx0MUw0WkFUZkRrU1Y5UCsvTUNaLzcrV1hXM0ZiSElFbUlUd2E0Q0lUdEJK?=
 =?utf-8?B?SFRlb1F4ZEwrckdsd0dJMVpyQXMva0dHcE92RGh4cThjeExDaVIwMVlUSnh6?=
 =?utf-8?B?WmJDL2VaRGJ5c1JkcmU3c0lYMm1LUnZOY2ZBaUlPOUdZa2d5NFlZbFFqMVM4?=
 =?utf-8?B?RDBTWXEzZlZtQzhjOG9YcmVXVUtXM0k4OWlmS1ZaazJkZmhGN3pZa2I0Qzkr?=
 =?utf-8?B?ZUdHUnZDVnVXOXlhSW0xcUMvem54RjhWMWJCWm15cHNTZVdZRkFwOXZiVE1q?=
 =?utf-8?B?c1lFWmxVa082NWJNUDJEa05oVWJteHlNMnl5TWdRVkNsTy8yc0taSVZ2MDUv?=
 =?utf-8?B?bSt0cmE2UTRyODVLOFVXbVBqTkxVSFV6ejZKdjJWL2JCa21XYm8xZmttOS92?=
 =?utf-8?B?QkxMUE1hOS9CVER1YllXaEJPQlVGVFZocXptY1pmYUozZVphdEpseW8rYWZX?=
 =?utf-8?B?TGo1dC9VU2pHdW9XN1JDODBXSEFHMGJoU3RGY2IrSmJ2UXVEd3NCaktZdzkr?=
 =?utf-8?B?azUvUmhvbmR6cDlSNHdvZitvbWlvNWlWK0FMTkduVXQ4cXdrYTVRckVvMk9X?=
 =?utf-8?B?R1Z6dE1GY3h2c0U4MllqdHFibGczYkpMWEpZUWxJRlIzeUhPTnAzbWQwcUxU?=
 =?utf-8?B?Rm5hNU9ReW1DOExYcEdveGV3L2xEckNtTy9yMTROWFhUZTluR2FOUHRwZXBk?=
 =?utf-8?B?SFNuVlBlY3BoYUdwbFlCNjUvZFk0bnRkYUxGWWF2ekl5N0VjVjJYblZVWkRi?=
 =?utf-8?B?Q0E1YnRPc29sMjEwTjl3OHpKK1BHOGp2YXNvNzQwTjhqUVlwWDgvMUg1dkRn?=
 =?utf-8?B?Mk9ZbHo4QkUxOFNacDQ0Q3FBd0s3czJBcDBrMlk4R1FVcFpIQ3UwWitLUzl3?=
 =?utf-8?B?Z1RTMUVCdzUwTngxVHZ1aXpNbHV4TkJ1WXVnNzczL0VjRy9qblNZLzRsQlJE?=
 =?utf-8?B?MEpqcFhGVmZhOU9kNENSenNNL1d1a0xMaTIzdjA2MTE4b2dPMm9SN0JNN0lZ?=
 =?utf-8?B?ZEtZWW5IRSs1LzBkRm1DWG5uL0tYUHVxaTQ0Z2FkTTE0SzRCZzlrblUxSUZm?=
 =?utf-8?B?OWVpNFpYcFc1c2ZNUDZCOU1kdVR4dVU1Skdya2JEd2JkT21BNUR6U1dVYUhk?=
 =?utf-8?B?bW5yQWdvbFRhWTJlNmpXcktBMEtySHVTbHJzTENYR052Wm85Rk54Q1J2cHVz?=
 =?utf-8?B?cndXaXd2WGhOZkc5UXczUnZHb1FoRklPNFdUL1hKalNDUnVNeEpPeUhLQWVF?=
 =?utf-8?B?MzRxamQ3THNhdVZYK0p1czdCQ0hkaGFjQWhzSWE1R1c5VWpNdVBLMGtXTEho?=
 =?utf-8?B?V2FBVHVWQm5LZEV3enJOQXM2V1FoWDlIZ2ppR2gwTThEZnJjUDJ5RVg4V2sw?=
 =?utf-8?B?bXhjWFRBWkNkbFBmOUtmZDAxcHBOckMzMHNvVVZDRHA1NG0rcXBhd3F2WFlt?=
 =?utf-8?B?WnhCZHNkSFhpV0wxWDhlWEFwU1VoOTVTQjZOd1pSOG9ValliQ3MrWnBqMnpU?=
 =?utf-8?B?dUZPNEFJTlpWZTltOE1SMXpJSkMwZDRrTXVMT0xHWUtQS2VBY3c1RUZWOTNs?=
 =?utf-8?B?QmNLcGRNS08vVUdSRE16QUVPWWIvR0kwV3FuT2E0N3I4OU1zRk8yVnF5S2Y0?=
 =?utf-8?B?dk83SDdrMDJIL0FpNDZHK0lJeDBtVzIwY0NOMzNyOEtuSXBONVJQT3FoK3dj?=
 =?utf-8?B?U1FpQzdab21Pc1Fob29YTWI5NzdYbzFaRTFhS05LMUgrV283SHZ5azA1Nmpl?=
 =?utf-8?B?SFVXaVJNbVhscWJxRzhNdHBMUTdRdXQ0TUFLTGpPem44K25odGRwSEp0RmFZ?=
 =?utf-8?B?NTFsWnB5dVhGRkc5L2JKYzk4Nkl0ZE1acVlTOUhVeTJoeldaQVZGbW5kbXJF?=
 =?utf-8?B?eFFBb3dhODAwNmNpVldaTk9IT3NlUitsUFZzVXE0OThveHpVeVJOMjZKVDNS?=
 =?utf-8?B?VWNFcnp1WkI0amZxTE9rOHZQWG92UVl1L21tV0FWMTNsdmd4S1krQnZic2l4?=
 =?utf-8?B?QnArb3FjYlpFSTlRZ1JqVEcreVNmZnFWeldiWXFmV0VLYVphZ2Z4ZDV0eDVu?=
 =?utf-8?B?L01kYmxZNDduUHYzTFZEUmQ2ZENEOHladWh1eUorK1hjb3FTb1Nsc0RyUlFW?=
 =?utf-8?B?Si9uSU1YWnhRUUpuNFF6dExKaHd4RGQwQUEyR0swbXRDUTM3UFdnUEptSzZ5?=
 =?utf-8?B?U0E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b07b3d1-4a9a-47cd-0070-08db2c3893b4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2789.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 07:22:51.5113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2WE0HtrKbyVZwjgGFYHYA8qUDfzaCzt/8tBuvAb7Ke8zFI3NsV6y/ElSDfoOYsoLHRDT7uOwXGl3o8Gb7mt/BMNwjsRrG6OpUfCjyaXc+Y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6187
X-Proofpoint-ORIG-GUID: o28YWc91CYLyNSCZWVZicTeOxIol-otr
X-Proofpoint-GUID: YMWJ76T6DlB5SebTQeAPcZBZDTr7jA_U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_04,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 suspectscore=0 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303240060
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 32O6kFgQ005558
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 Mar 2023 07:23:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14616

Hello,

I've sent a patch for it and added you to the CC list:

fetch/git: Fix local clone url to make it work with repo

// Robert


On 3/13/23 9:35 PM, Theodore A. Roth via lists.openembedded.org wrote:
> On Tue, Feb 28, 2023 at 6:36=E2=80=AFAM Sam Liddicott <sam@liddicott.co=
m> wrote:
>>
>> These recent security changes to git prevent git.py cloning of local
>> repos that contain symlinks in the .git directories (e.g. a repo-tool
>> manifest checkout)
>>
>> * https://github.com/git/git/commit/36596fd2dfa473cf1069d23776e62cc156=
e7b5c6
>>     clone: better handle symlinked files at .git/objects/
>> * https://github.com/git/git/commit/6f054f9fb3a501c35b55c65e547a244f14=
c38d56
>>     builtin/clone.c: disallow --local clones with symlinks
>> * https://github.com/git/git/commit/bffc762f87ae8d18c6001bf0044a760042=
45754c
>>     dir-iterator: prevent top-level symlinks without FOLLOW_SYMLINKS
>>
>> To prevent some local clones from failing, the bitbake git fetcher
>> could use the -s like this:
>>
>> -            clone_cmd =3D "LANG=3DC %s clone --bare --mirror \"%s\" %=
s
>> --progress" % (ud.basecmd, repourl, ud.clonedir)
>> +            clone_cmd =3D "LANG=3DC %s clone -s --bare --mirror \"%s\=
" %s
>> --progress" % (ud.basecmd, repourl, ud.clonedir)
>>
>> Instead of "-s", others may prefer to restore the url prefix file://
>> which also works,
>>
>> -            if repourl.startswith("file://"):
>> -                repourl =3D repourl[7:]
>>
>> I don't know which bests represents the original intention behind
>> removing file://, but "-s" gives a quicker clone of what for me is a
>> symlinked source repo anyway, and for the lifetime of a build I'm not
>> expecting the local original source repo to vanish in a way that will
>> affect the build.
>>
>> Sam
>=20
> My organisation is also experiencing this issue with recipes that
> contain SRC_URI values
> pointing to `file://` source that was checked out using the
> google-repo tool (which happens
> to create symlinks to `.git` living outside of the SRC_URI referenced
> git repository).
>=20
> Our work around for this, is to have each developer impacted by this
> append `--no-local`
> to the `clone_cmd` as such:
>=20
> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.p=
y
> index 5bb8393133..17c4b8ca18 100644
> --- a/bitbake/lib/bb/fetch2/git.py
> +++ b/bitbake/lib/bb/fetch2/git.py
> @@ -373,6 +373,8 @@ class Git(FetchMethod):
>               clone_cmd =3D "LANG=3DC %s clone --bare --mirror %s %s
> --progress" % (ud.basecmd, shlex.quote(repourl), ud.clonedir)
>               if ud.proto.lower() !=3D 'file':
>                   bb.fetch2.check_network_access(d, clone_cmd, ud.url)
> +            else:
> +                clone_cmd +=3D " --no-local"
>               progresshandler =3D GitProgressHandler(d)
>               runfetchcmd(clone_cmd, d, log=3Dprogresshandler)
>=20
> Digging into the git history for this functionality, it appears to
> have been introduced way back in 2012 to speed up cloning from local
> source repos (e.g. things like the kernel source). The work arounds
> provided above, would probably have a negative impact on that
> particular user case though.
>=20
> Would really love to see a fix for this included in bitbake upstream
> so we don't have to manually patch.
>=20
> Ted Roth
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14551): https://lists.openembedded.org/g/bitbake-de=
vel/message/14551
> Mute This Topic: https://lists.openembedded.org/mt/97289801/3616940
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [liez=
hi.yang@windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

