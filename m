Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14933CA1015
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 06:09:18 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.116])
 by mx.groups.io with SMTP id smtpd.web10.32973.1756966153074076290
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 03 Sep 2025 23:09:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=bdPvcjqr;
 spf=pass (domain: weidmueller.com, ip: 52.101.66.116, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWEle8/jg6jNl0ZiOdzJHxzlwd4jtY0HuTLXzuXyMImPx44l7mlEA6YbbJhkHEPUiquHSnDk3wrdH01MV/uLkaOxqdJkLitTQF2O8wYQ7QRib4D7llzN6zfwdvLDFZgRB4MTI6UApFY9TDAV/Do6R8qJQky+rG2s3RAwuGpha3tGAuia31Egrg/0fMb5Q8MuNxdhVF6rKdTr45M0fRlhkrqALs2wu6mBpB3v2MrXW3gM4BxnUf9KKLe5JQuhvbMvB0DsbrshsgUKzq5SwwkpFSY/TkhHDJu8s2BnJtFpY9KmRZ9N3jEXUyywNLez4EyIk9jIDrvi5WWU96BWIFP0yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWeY4nJLRQT+YSZ59DlcGSmu7owi99HOK7dQf5vT9Zs=;
 b=AO9QWyJafkevL/Y7oHxRZWmMrILGZ7vmnhaqX1EQG5Hx/mPSoF+B2vDIUknw45pHT2y/fcUutozn0P30fXqNR7yx6j6g9U/c+kflmeoBii3wlprTdWg/Vumfc8p1TYW6l3MJnVW5R8Xl/hMsS7HeUR6ahZ96o10BQIKrLexpsAyTZnCMZUYyeGK2sDeEgZnd4EYMpUXQbaXUbWLp9K4HVd4kEWTRwqzxwvW4w+gKhSmPqnrK2F8PucDDEFqswp9rs8zQI+7+n6LHvAtSEiAHmKd7oWURAP095scT5Tz8r/z1xwap3kTN1epCKE+3uupJk+2PzQ4vd02a0DbaySNL9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWeY4nJLRQT+YSZ59DlcGSmu7owi99HOK7dQf5vT9Zs=;
 b=bdPvcjqr6twapPOGkvt9Q2az25FEXP4dP4kKMT6XfO6wk3gGu5fvbK1DieeuapXSUNdoMgt7GPIm22XfUmQv/CVMRvKVfsMSQwu9Ko1+OP5wZa1m8t1nMwTp06h895rVdZbLPVgs8EwZnxQIovrHD21uoRXr2mpx89Y3ROgVvUMzk+sABDMgVGdRaEJ7FWHMJxSdT2bQgtrYirF7ZGrh0hp8QqAYgxhxIExdPGz17tFQgSlN22+w2MZuvBzsnTJkNirUSHjvr4I88BuitZnxkw1YiO1/SuzGU3JNurLlaw7iCThB8tuW66GYpfwUi+ztZ5czCSdFkBj5P8fP5vDsxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DBBPR08MB6282.eurprd08.prod.outlook.com (2603:10a6:10:20c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 06:09:09 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 06:09:09 +0000
Message-ID: <c73a8736-8e75-40cd-9dfb-475d530239b5@weidmueller.com>
Date: Thu, 4 Sep 2025 08:09:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [RFC PATCH 0/6] fetch2: add support for implicit
 urls
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
References: <20250902065507.35737-1-stefan.herbrechtsmeier-oss@weidmueller.com>
 <DCJSCC879XGB.27MF8X0RDL3@bootlin.com>
Content-Language: en-US
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
In-Reply-To: <DCJSCC879XGB.27MF8X0RDL3@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::13) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DBBPR08MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 413e62de-4d5d-4b90-0c54-08ddeb798fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rA0cLXTRq51JuXtoI1nvV3qZRACbhskUSpaYwbD/D0viOBbD+KB1mzeV/7ju?=
 =?us-ascii?Q?M4JWqmEY7EBpeuJgRensg8KIgDZBgbW83jJWmD3uy53iMWeWniaVgcFSY6JG?=
 =?us-ascii?Q?wpWhJxrkcsc54dTnS8nHMxZZSK+VHB4MINyZ1j0UkgQ8heb+sGGvQ4vtBe17?=
 =?us-ascii?Q?rdN1KUxy7KADdmbW5ysFSMtcrV0LtADjvo2JpGiNTbglc00p/T7mNlLVMcaB?=
 =?us-ascii?Q?zspW0+PmvfCs7JmL1sM0BYyJbjEnC9nQSaBhj84LFa162zG1va6bJqqLEi8J?=
 =?us-ascii?Q?GEA4h6p9dJSq1gY/cvfF/vw4zKjwUUjpwa/gepzOOystV81YRZoN8MkUC0cu?=
 =?us-ascii?Q?QCnriIodGIxqJ5SO3QdxBa0sIfDbIkPqQmNVV3GyFq/QpWLWuclIYKvyQt6h?=
 =?us-ascii?Q?ZE5488WkvDqx0hpIS6dEcn4p5dzVn4PfRF7F1Kk4kKeLi1prq5OhUStOrFNN?=
 =?us-ascii?Q?9Nyip6YYwbK5EV8n80a8OS7XymHJqbScwyhP8o9uTs5GjbQpXZ533kIowKIX?=
 =?us-ascii?Q?a7BezexGFZcMNm6OeTv1yj0PX+Ox0vLblvtD2B36gNAQnMWqSGW60f+SWB6s?=
 =?us-ascii?Q?AEhCLsHiG1hGfTao6k48jcUiF29ZatJeYMvyK7v1+4t47/LKufkHqZs8lUi8?=
 =?us-ascii?Q?BQ/PbmsGqputDnmJy7Lc7fGuuL3P8W5Rid0mXvPXqaMhsyHGl+ZEft9/0CuZ?=
 =?us-ascii?Q?BKGomIinBwnrwH2vIsDeCp2lh8yk0ditxz2n8FufsDNe/2bOE/FourNjWop6?=
 =?us-ascii?Q?Uzn90nCmKxLrnLHtQ4yDPeipCT64QrHMem9Qa+/RORyfJZB1f5kzKfTMq2V0?=
 =?us-ascii?Q?0D6soyrtuZFxv51SXbgEpP0IhnIu/Zg+M5ZE7VGUGfVXQjGitPC1Nzq6AYdU?=
 =?us-ascii?Q?y5m8pZEaiiFTZVUPjeESP6T9O04SVoCP+MSFQ/OQZhKbP9+GSOpPMfDuGKVr?=
 =?us-ascii?Q?vf1I9NY+vUgrwppO8nqVE6gxdmLNIyWonZQRT3bxR9DkHn7cdioRg6wt3EXO?=
 =?us-ascii?Q?7bqPI/MxsKG38cq72StPJ/sOGCaQnTfuq3A4wqJYcVwbUxE1itKpPlewiF2F?=
 =?us-ascii?Q?ziplwFVr56vY/4WrUrSt/HIhfy6ufPWi7h81mchTaG+P72lxT3ixD74fTsUz?=
 =?us-ascii?Q?RYA0m4BvaClqRnrZWB2GrPOxawr6uJ2wDyNmjM4bI+1MprrpThUv8nCUnNC+?=
 =?us-ascii?Q?neG6HoyrTAg0hhri/bn1waa12B47X7c5LYJcajtNB0ngXURUqSFbWGil+aGc?=
 =?us-ascii?Q?9Qwo3JRJMiJx1AggrwZuysFGQuojT+RjI0SdK8YWwpVW+2Pm7k2y4olPzQTc?=
 =?us-ascii?Q?xEixa9DLNqCbisxSvhOC+JvcHFFpsPLvOUmAr9GeK3Hl++Xg0mfRwehQgEGv?=
 =?us-ascii?Q?mgl1epUCPk+25WC9fQm1l6N4jH4ymMcJRW0m6UjRSd4T0eIC7jWBXT3CBhWI?=
 =?us-ascii?Q?ZdTcBcVOVbc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wMAXJTlIPUbZvH2QUMvMsBO1TuxErL7DnvNNSLbEHIKKFGvc0qp0r24EA+nV?=
 =?us-ascii?Q?l1RFdKl7//ODi55WAtUg7VMEzraJE9O6gD8xhIQKYzzkvG8YvYnOBOTZhdja?=
 =?us-ascii?Q?Fc1GRe0jbM5Vx2tvAN7j7lydbGLkVuRzRUInSfzWVzdd89NsjXc+YqWoDQcJ?=
 =?us-ascii?Q?wVnIx8yfcTM4uIgGB3ECEYuRqSLzTx/No0hePllJzJKzCnziRrktO2MhYE4X?=
 =?us-ascii?Q?TvojCoiuMTjBVZ6nFAi3prHVnSb4P/DdYUTfOvOifjjHYY7nvZxGs3w3UPuI?=
 =?us-ascii?Q?cd1kOGqrQD/lfGzwhxjqnT+zjXizq9QHwOmnPlJxNDXPlaC/EY/8KPrqbQXA?=
 =?us-ascii?Q?DCn2XwqBdI6EaQtNRkUXXpTJAt+MpIT3lWE8BxwAzzJ7zUbyXSgvD4n0h9kU?=
 =?us-ascii?Q?vpXuKLNnNju4zY/KPQddPWnIsYASpOgsvhikg0HFYe2o10KTFP1HTnjU+vnC?=
 =?us-ascii?Q?gFUOKR6y7XevAESA66y6Jh/hDr6hHRvb5DJdX/FUA7pkx/iCnijeiqgne4KY?=
 =?us-ascii?Q?zv9CP9s5MndILnXTacJix01/UGWLx4/+WNVWgNukc6F44o9+uMwskcftMB40?=
 =?us-ascii?Q?E+zW5RjvikCQxzl7Q+hFZfMeZiwDYTgDCkeFqn06SvvXbsHsdaUVfQdDyRhU?=
 =?us-ascii?Q?nIGyjeLYe3ghnLzHR98pXX2h6sPYm9J+QPjTl8xlZTjT1yVkpr5mBEmuiEWS?=
 =?us-ascii?Q?AzhLY2xfSbX3Y5sn0j3FIP/8BUJssGizGIjvsNpoTcukJDWkEU9ghENZJEut?=
 =?us-ascii?Q?7q56Ivf5p+eHj3dSAuvxVW7O8o4nmmukMWnG26BYzaJzWEn+/Dk54QLJlWNI?=
 =?us-ascii?Q?Q+J9/hpRVeT4nqNZYZ4Cac+tXLqRXJ6Ycfd4YvXxZ7WApGvL4Xd+8Yj79/ji?=
 =?us-ascii?Q?j+8IAt4WUtIymIrtHn3qJLFZc9L/VoYzthUL+8/SKVP7Wh/Ktp2laJjVEM01?=
 =?us-ascii?Q?1abAUFnSSC+89Mvih9gQz9HAwTWBHh+AMA6cZWyHnqBSVW4EEWUYODC2+BDY?=
 =?us-ascii?Q?UNlkM27+B5JCAbfdkiqpYoOrDewE8sN8mMcwIxFgbUxqtmazFuI5rjq1hTz9?=
 =?us-ascii?Q?VIs+/zmI1OtlErfIjNbnJwyS452v+ycCs8GsLOMxFmbuWX9de1Te0XuC+N6g?=
 =?us-ascii?Q?r41hBQywNPjINtjV4Tty9F70c1SrI19vnHeQXig9htrsr4Qj0MKmjLQfxkET?=
 =?us-ascii?Q?p65YgKoF/nnrsxARLXDtWwjskCmgdwMLB4CdpFvjYAiYbZzahT2Zm42I8jbx?=
 =?us-ascii?Q?JTN7mPt7exndZMNtNyFHa16ytE6s7jSF149a3MMAO4HDMgDyf0UobEW9bg8Y?=
 =?us-ascii?Q?SdgpNO2Td15dVpFQG95xlY2xlLrhuho2StkQ8dyHsF2KdjNqbtTg6FQnjSsg?=
 =?us-ascii?Q?kTivrGBQQW0Zz9Kp/LySRfmp3ZG6UEz62GI878abA0qnrfFx46JEpbG1Ygk4?=
 =?us-ascii?Q?MSFz9+pH+WfCva8HfxUyyLEpaiQqShHMfcrg7tu+Dk+iYT1uN26ERvUG14sr?=
 =?us-ascii?Q?EtujobJVlRG4ngJLcUe4Tbz712/ZG6IBtAXd/6JcbnZXs3dBAuViulEsCwoK?=
 =?us-ascii?Q?mnJpVFfiw+X7xo6qXnrU3LFBDSAXla9vTWpx5P7t13a75kjJqWLKgX1jmCFR?=
 =?us-ascii?Q?Cw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 413e62de-4d5d-4b90-0c54-08ddeb798fc3
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 06:09:09.3982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qiy33FML2U6o5NXQBHWzpihkMR9wdfioRjO6ooXq72c+K5QS2TXkb4FP+gjgOqtcLz2a97mm8HiTkB4NGi5+3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6282
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Sep 2025 06:09:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17954

Hi Mathieu,

Thank you for testing. Until now I only run the bitbake tests. I will=20
look into the error and will add a test case to bitbake to catch the=20
problem early.

Thanks
 =C2=A0 Stefan

Am 04.09.2025 um 08:00 schrieb Mathieu Dubois-Briand:
> On Tue Sep 2, 2025 at 8:55 AM CEST, Stefan Herbrechtsmeier via lists.open=
embedded.org wrote:
>> From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
>>
>> The patch series add support for implicit URLs inside the fetcher. The
>> implicit URLs could be defined inside a source like a version control
>> system (git submodule) or a lock file (package-lock.json, cargo.lock or
>> go.sum). The integration of implicit URLs beside explicit URLs
>> simplifies the fetcher classes and avoid bugs because of iterations
>> between the Fetch and FetchMethod classes.
>>
>> The series remove most methods inside the gitsm fetcher and only leaves
>> the parsing of the git submodules and the unpack functionality. It
>> allows the gitsm fetcher to use the premirror only feature. The current
>> implementation leads to problems because the download of the git
>> submodules is triggered via the download method which is called deeply
>> inside the fetcher code.
>>
>>
>> Stefan Herbrechtsmeier (6):
>>    fetch2: rename u to url in Fetch class
>>    fetch2: call functions within loops of Fetch class
>>    fetch2: add helper to get urldata in Fetch class
>>    fetch2: add support for implicit urls
>>    fetch2: gitsm: use implicit urls feature
>>    tests: fetch: add test case for gitsm implicit local paths
>>
>>   lib/bb/fetch2/__init__.py | 128 +++++++++++++++++++++++++++-----------
>>   lib/bb/fetch2/gitsm.py    |  46 ++------------
>>   lib/bb/tests/fetch.py     |  12 ++++
>>   3 files changed, 109 insertions(+), 77 deletions(-)
> Hi Stefan,
>
> I know it is just an RFC so far, but I did launch a build on the
> autobuilder. It was mostly correct but fails a selftest:
>
> ERROR: git-submodule-test-1.0-r0 do_ar_mirror: Error executing a python f=
unction in exec_func_python() autogenerated:
> ...
> File: '/srv/pokybuild/yocto-worker/oe-selftest-debian/build/bitbake/lib/b=
b/fetch2/__init__.py', lineno: 2102, function: expand_urldata
> ...
> Exception: UnboundLocalError: cannot access local variable 'urldata' wher=
e it is not associated with a value
> ...
> 2025-09-03 06:21:46,098 - oe-selftest - INFO - archiver.Archiver.test_arc=
hiver_mode_mirror_gitsm (subunit.RemotedTestCase)
> 2025-09-03 06:21:46,099 - oe-selftest - INFO -  ... FAIL
>
> And a similar error with
> archiver.Archiver.test_archiver_mode_mirror_gitsm_shallow.
>
> Thanks,
> Mathieu
>

