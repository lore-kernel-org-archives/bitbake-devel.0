Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D497C4706C
	for <webhook@archiver.kernel.org>; Tue,  9 Jan 2024 21:49:23 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.30080.1704836959794492665
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jan 2024 13:49:20 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=b8eblZjr;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=1738806c2f=randy.macleod@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409Euvlp005724
	for <bitbake-devel@lists.openembedded.org>; Tue, 9 Jan 2024 21:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-type:message-id:date:subject:to:cc:references:from
	:in-reply-to:mime-version; s=PPS06212021; bh=1SUbJ3eyb78sUUDYuLs
	kJC4RnSLWX1NQe9YRa8WO9hk=; b=b8eblZjrJKjd0AmjHMTb6LazJykhf/91l+c
	LdLrc0NRaHe7l4gX/NO3EjWz3kZks5llZzsWxLdapvyw69S6Obx8cx28fr4c1g4E
	cRHFmY7/YypDQpQ5a4+S+S3JDdhQLwH2YRvkBLFqITrTv1EU5ikJhZyS70aTr3EO
	X6bKtLDgt/6vZ1R24l6PfQY3r2qEbG87zbBN2BLZ4jS+3+X8OG959z7m50bxyBf5
	z5JYRgWUm0K7Eu0xBj+c4Yq7zx1myphZ2vURhYoHtr2Sc/KskVebGIOxSmP+nxqA
	5OZbcbVSp5p65PVecCyPBXmSrfdXFctrXvQx9dxHqJRTAC9PLfQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vewekbt16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 09 Jan 2024 21:49:18 +0000 (GMT)
Received: from m0250811.ppops.net (m0250811.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 409LnHqn017263;
	Tue, 9 Jan 2024 21:49:17 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vewekbt15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 21:49:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGwO48ursTGQXEJUPISjT3NdbtTKRpe8wmsPgAlJtjODqAUgxtqgjnY5yj9h5vP804zJv4llZWJ3IVU4QeL8ArSqf94YZj/+nuBCYkFOO74TRem1LJyAB7soYu+rRovGhil9mGWQi3GPxh4c3WV5dDzvdG8fSH50M3jP3jQlGRKw8OnIl3kfcrygqL/cWv6h+Mie0x+aQ3Wa3YUV6IVCIi11Bkp5Qc6Qr74/PpZz8Q4+tih0bWF1ZR7CrA79ZGf0u7UwezUhiA/bSjJaA1IrbhNgYFG0oVjs4sX2QEVJUrS/pQCSRq4pbrVT0y4Oepf+nKeBagvXiMwsUc+DE/nrHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SUbJ3eyb78sUUDYuLskJC4RnSLWX1NQe9YRa8WO9hk=;
 b=A8ZRYOQwOWcgZtkb5GvDTURBRa+2aGFZS/v772f+/Z6kOuyvXWOda1BnavNYJrwB6/H0GzLPcQLPDI7v/Ah4TIZRZTZgzq2VYf/OnSSazoOQy3rthx7dfrLgxksfX/nN0TXIEUl3gzTXJQ7zM7fQBoyXNOH9xHVi96CWazwBgHI/7Cy7VcNgzW+yA04fn3B45Nhf1EM1lkSBVlT4yF/QkG9NVOhYR8j9KgcxFy9XbXj74GEgD6ytEGx/qoM15i7P4EC34AF8E3fpKPZFveQPquWrQgE7cO0wNeUtlEopxovm3JLKzkEItBcKoY5opn1Z8sX/GJMR6aDmROFMoK27MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5920.namprd11.prod.outlook.com (2603:10b6:a03:42e::9)
 by CH0PR11MB8087.namprd11.prod.outlook.com (2603:10b6:610:187::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Tue, 9 Jan
 2024 21:49:14 +0000
Received: from SJ0PR11MB5920.namprd11.prod.outlook.com
 ([fe80::f3ba:ff33:12be:cff7]) by SJ0PR11MB5920.namprd11.prod.outlook.com
 ([fe80::f3ba:ff33:12be:cff7%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 21:49:14 +0000
Content-Type: multipart/alternative;
 boundary="------------mb6DA95dyRHTB5bFFx52Dkpj"
Message-ID: <c0a11023-9bc7-40de-9240-0006c98f1607@windriver.com>
Date: Tue, 9 Jan 2024 16:49:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] runqueue: Add pressure change logging
Content-Language: en-CA
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        Etienne Cordonnier <ecordonnier@snap.com>
Cc: bitbake-devel@lists.openembedded.org
References: <20230713105303.4105584-1-richard.purdie@linuxfoundation.org>
 <CAHUKmYZvYbs236DUrUna_SGRm-9R1SPkDAvZJn+XkrwJri2xNg@mail.gmail.com>
 <15224f4fe986ab3508c1d0dc3d9b33b0b3e2e9c0.camel@linuxfoundation.org>
From: Randy MacLeod <randy.macleod@windriver.com>
In-Reply-To: <15224f4fe986ab3508c1d0dc3d9b33b0b3e2e9c0.camel@linuxfoundation.org>
X-ClientProxiedBy: BYAPR02CA0051.namprd02.prod.outlook.com
 (2603:10b6:a03:54::28) To SJ0PR11MB5920.namprd11.prod.outlook.com
 (2603:10b6:a03:42e::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5920:EE_|CH0PR11MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: 688b5f2f-3760-4e37-3119-08dc115cd247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	z5ht2jMLZSSuIbxMCd2xOKvLgua3X/VMy6u+wW+ohwHbM+Z7GSj8fF8D16XEYHErcVLdFwOj9f3iQe3H/mq5mGp57oMf4rt5oXBzUKMMcnRdEkUOGDtkoFr7bCzQ3oNJs4vqlCPRgfBYxT4yAsWcrt7Mc0ogQWIeG8iBEzKEYQDSY5QiWHMcpjpshwUBaztvY4+Tcq/xxqDG/ZsYTWtC214aKRhr3sO8yiN7kYaz5Zjo4prErAO5keoMZ+fcr4dSGlsF4DT1+pQLWdYDsifKkd8l/3BuxxmUSQOr7EZif9MUhi+yPkk/66HKtTKRggouoDk9hsrdIWduTiihb9h+GXqOH3B7Qg/dxIhuF6Wj9NFLc0kI1XuWETRobZUebdUoouDTIIoZ8NyrJBv5MXULe4R1rqG2HyzC7pqWvqva40PMFgKhJTnMW/WD/v4bLqaOKKoF5UD0tT9qazPt4OMo+IcVmaqWKjYNffuXBm+Sxc3dRMgmqgxowBJQVKrcBU2JsbvKq1IQLsSjBO2rXLHRngmkypqVt2jK3ZL1rJQmVjs0CTMc5hYSCr8gM9G4pDGiDaXjnsULuoEAfWx9Q+PuSECf6pR9NqcUzvlJaPfHZmkZ+I2e1I7n9x3vagFDOIbNqDun7hCbrgmd6ndDfn+mFg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5920.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39850400004)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(83380400001)(6512007)(26005)(86362001)(31696002)(36756003)(38100700002)(5660300002)(4326008)(30864003)(33964004)(6506007)(53546011)(2616005)(110136005)(316002)(66476007)(8936002)(8676002)(66946007)(66556008)(2906002)(41300700001)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MEhUWW91Tmc0czE1QmpiaW9KWjcrbUY1SUlxQUhXNVdsWGc5NEFOZHNpYzRV?=
 =?utf-8?B?WThYVitqOW1EQksrVHZTNkFUVXA3MCtKaC9SbXVYelhrMlpuM3g1NVBwejYy?=
 =?utf-8?B?cXQwVFRLY29kVnhabndKYlpEeXQ5cW9BRzhUU2U1cXhWMlBBZnRWa2xPc2c1?=
 =?utf-8?B?THNmVHBieENaMThJSHNLQXc5VHpNOFFHaTFDNU9MYlU1Y2MrRjQvQW41K0Rs?=
 =?utf-8?B?dk45bjN4SVZadlVyY2dqc2wzcHBUamJXQmdmR2JXaG84ekUvK00wZWltT0h5?=
 =?utf-8?B?TWNlTnlTUENoY2FmODBBVXJUT2Znc1dILzhqenVuTXNPdFdxckJRTTlwYjEz?=
 =?utf-8?B?QkxaT0NRU1ZrRmdJWWEyZzc4OU9rMTcxTldPUGxWaGdRbDY5SGtoajhudUhN?=
 =?utf-8?B?bjVVbmdKS09QRStBWmgzZ3kvVVp5Wkk4aHJLK21xRE1qd05LNzErY0ZRRUY3?=
 =?utf-8?B?WHpFUnZkdEs5NXh1WkEvQnY0TU04ZlN2N0FGUFVGMjR0ckN2TTJ5bE5QR3NW?=
 =?utf-8?B?MXoxN0JWbFVIeEZJZ0puUmJuVXJRcXhwT09SV1hJeVZOQThPWFNjMHNiVzFx?=
 =?utf-8?B?Q0dQc2tBckVaYmtDQVQyajhzWXZsRE5WRm1KY1FYZitUS1VRQTFzSU8zbXJK?=
 =?utf-8?B?aUtUdFRJZU1TVGxKbkhFMk1ya2h6UTdBRUI0YzU1S0pPbjQwU29aU3lOd0F0?=
 =?utf-8?B?ZmdMN1dMa1ZLYWd1RXUwcm8xOERXMkxTRGtzMjZQMjBKcWFhNjBTSXNJVGtP?=
 =?utf-8?B?cTUyK0packFVT1hVY252OTkwemxTOFVlaVd2MFFqNG9QWmEyQTFrRHl5Y05K?=
 =?utf-8?B?QUJrMFNrQTJaRmtHTVVqcDY4UmduV05GNUthQnA2OHdqMGhUTGtNbjdwRC8x?=
 =?utf-8?B?OTlmaDZTTlYwUnlhcmdNNC9WNlpzcnBpclN3YkM4bHY3bzZXUkxGSGZuU3hq?=
 =?utf-8?B?QWQxT1pGUVFLdGVvak1lM2h1M2V5Wm95MTIyQzJNTkI5ZjZRY3VlVkd0bU5a?=
 =?utf-8?B?Y1ErWmw3cm1aK2FoYUhCRG5PcDNuMjByYjJvaHh1dVp4N0p3bUpRa05QZXNr?=
 =?utf-8?B?QXFQNmhLYzg5cW9hREE0Vkxmb0NCWTlCbitMT05lRFd4SGpBTmUwWjNBMHl6?=
 =?utf-8?B?TC9ZRXZKVXp6VExLWWk0NXNuRDVJU2tPSWl2SG52UlpxMFJUbzBTQW1Bck9V?=
 =?utf-8?B?WC95cFNYcGZPMDJzSUlTNnQzbG1wRWNlQlBNVVdaVCtmTlNQQVVSd1hVeWFD?=
 =?utf-8?B?VUYrUjNVK3dEY05tcmJVMzlmTUlob3d6eDlralZzNGQ3Uk5OeVpxZnVnVWdo?=
 =?utf-8?B?Ky8xOUFoNEluUVBMZlFVMlY2aitRUCt2S1NNQ1YyTDZnSm0wejI3THFIbXhs?=
 =?utf-8?B?VEljaTBjU29LQnJpMlNGdmhQNGNvS3VmeGk0djVrWkJXSjdWTVdlODhVbFBa?=
 =?utf-8?B?V3Zzb0d3R3pQSjRrMUY5c3kxbElTVUhCUkhjRmFiMVhXSHB5OTBHOG5TQWZQ?=
 =?utf-8?B?Vk1zaWkrMjIxSzlNazQ2WVNTUlVIamp4eXM4NUZRdEZGbzVDVmRoWDhqS09y?=
 =?utf-8?B?NTVRZDQwb0JMbHU0MHFvdC9kNCs5R0E1RW5jVWdrSkdrUERRSDRDVnVWWHlO?=
 =?utf-8?B?SHRwREt5a1JnWmhJSmNUS3hFcE5laGtGcmRoRjdmT1BoQ0lzRG5qM1dPVnhC?=
 =?utf-8?B?Smd2NCtmOTR2dmpHZTBCU2lFVzUrT3JaYTBNUVdOOWwxOGQwcHQ1YlYvMUhh?=
 =?utf-8?B?cDdrTzZ0VDV0L0FtRXVEcW82SE80RXJtMDd2aTV1ZCtXSGltYkU3WElzcGtk?=
 =?utf-8?B?VW9tNUwwV29OYVlaUWN4dXhoSjhTeWs0MjNxZk91WnJBZmU2cDVIUmNwM0Ux?=
 =?utf-8?B?THh2Yll1WTg1VDY3T01QODM3bi9xWlEyTXc1WSt3RGMzbWs5bmcvNEx3cTBt?=
 =?utf-8?B?anF2Y21TSlBhTUcvNG9SNnY4OHY1dmt4Y0hrWVhWS2pNeWIwWWsyN0NTZ3No?=
 =?utf-8?B?UlJaR05Wei9NNHFlb1FFRUZWUzRCNGl0OG81NnNOemcwRCtPVWczSENieXF1?=
 =?utf-8?B?cUR1WmVFZVIxS3NsbzBjODR4OTdmYjFXT0VNUGo1WUl5ZXZTMHdpNDJKZ1BB?=
 =?utf-8?B?bGoxdThPeTk1MmtYbTVTaER2QTJDK2NRUkdzOXU4VG03eWRQQVVVamlKTEJS?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 688b5f2f-3760-4e37-3119-08dc115cd247
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5920.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 21:49:14.3502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PRx/NKtgkS/PT7zzjzn2qIayU8ooqWzgMyrW3q4xNSCXWt3RTfMRSbFHSchGnrnZph4PqInqCyCe7wvU7PXweyavw0emu82iNJzw3MZNjWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8087
X-Proofpoint-GUID: f5unCMpXd3VmWyvOA8YR1psVA2T8sLBx
X-Proofpoint-ORIG-GUID: Lx17OtGYNGDxkxvDxnBnO7WhKC_ez5-c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1011 mlxscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090174
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Jan 2024 21:49:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15774

--------------mb6DA95dyRHTB5bFFx52Dkpj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 409Euvlp005724

On 2024-01-09 9:12 a.m., Richard Purdie wrote:
> On Tue, 2024-01-09 at 15:09 +0100, Etienne Cordonnier wrote:
>> how much logging is this generating for your=C2=A0local builds? I'm
>> using=C2=A0BB_PRESSURE_MAX_CPU=3D"500", and this patch generates hundr=
eds of
>> lines of logs during a typical build (on kirkstone 4.0.15). Is that
>> the expected behavior? It makes it hard to read other logs.
>>
>> E.g. this incremental build with 300 tasks printed 280 lines of
>> Pressure status change:
>>
>> ...
>> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:=
 495.3/500.0, IO: 1723.0/None, Mem: 0.0/None) - using 1/48 bitbake thread=
s
>> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU: =
985.3/500.0, IO: 2201.8/None, Mem: 176.8/None) - using 1/48 bitbake threa=
ds
>> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:=
 420.8/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/48 bitbake threads
>> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU: =
4049.8/500.0, IO: 14719.7/None, Mem: 0.0/None) - using 1/48 bitbake threa=
ds
>> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:=
 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/48 bitbake threads
>> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU: =
21922.9/500.0, IO: 10137.8/None, Mem: 194.8/None) - using 1/48 bitbake th=
reads

In this case, you have up to 48 threads permitted yet the CPU is already=20
overloaded
based on the pressure logs.

How many physical/virtual cores are actually available?

Is some other activity doing CPU intensive work on the system?
Is the one task running > 48 compile jobs and causing CPU contention in=20
the system?


I'd expect that for a modest update on a mostly 48 vCPU system, you=20
would rarely see any pressure logs but
I tested on my 24 vCPU system with CPU=3D500 and early in the builds as=20
configure runs for various packags there are waves of
tasks launched and then the system becomes congested:

NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:=20
8797.1/500.0, IO: 49.8/None, Mem: 0.0/None) - using 23/24 bitbake threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:=20
0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 2/24 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:=20
3720.5/500.0, IO: 0.0/None, Mem: 0.0/None) - using 3/24 bitbake threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:=20
0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:=20
533.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 22/24 bitbake threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:=20
0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 19/24 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:=20
693451.9/500.0, IO: 0.0/None, Mem: 32401.3/None) - using 20/24 bitbake=20
threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:=20
0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:=20
39409.4/500.0, IO: 662.6/None, Mem: 155.6/None) - using 23/24 bitbake=20
threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:=20
0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 13/24 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:=20
411246.5/500.0, IO: 0.0/None, Mem: 0.0/None) - using 14/24 bitbake thread=
s
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:=20
0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:=20
531.9/500.0, IO: 0.0/None, Mem: 0.0/None) - using 7/24 bitbake threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:=20
494.9/500.0, IO: 0.0/None, Mem: 0.0/None) - using 7/24 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:=20
514.3/500.0, IO: 0.0/None, Mem: 0.0/None) - using 15/24 bitbake threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:=20
497.2/500.0, IO: 0.0/None, Mem: 0.0/None) - using 15/24 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:=20
501.9/500.0, IO: 0.0/None, Mem: 0.0/None) - using 16/24 bitbake threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:=20
497.3/500.0, IO: 0.0/None, Mem: 0.0/None) - using 16/24 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:=20
501.6/500.0, IO: 0.0/None, Mem: 0.0/None) - using 17/24 bitbake threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:=20
0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 14/24 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:=20
36473.5/500.0, IO: 0.0/None, Mem: 0.0/None) - using 15/24 bitbake threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:=20
0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:=20
526.7/500.0, IO: 0.0/None, Mem: 0.0/None) - using 2/24 bitbake threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:=20
472.1/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:=20
502.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 22/24 bitbake threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:=20
0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:=20
522.2/500.0, IO: 137.1/None, Mem: 0.0/None) - using 22/24 bitbake threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:=20
0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 2/24 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:=20
2192.1/500.0, IO: 0.0/None, Mem: 0.0/None) - using 3/24 bitbake threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:=20
0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:=20
529.0/500.0, IO: 64.8/None, Mem: 0.0/None) - using 21/24 bitbake threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:=20
0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 4/24 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:=20
2420.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 5/24 bitbake threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:=20
395.1/500.0, IO: 0.0/None, Mem: 0.0/None) - using 2/24 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:=20
523.4/500.0, IO: 0.0/None, Mem: 0.0/None) - using 6/24 bitbake threads

I've been trying to make time to improve the pressure regulation since=20
we neglected
the kernel devs advice that we should not sample the pressure info more
than once every 50 ms or so.

I'll try another build with the CPU pressure limit set higher, and I=20
suggest you do the same.


I still think your logs look 'interesting' so I look forward to hearing=20
what your system is
and what it's doing.

Thanks,

../Randy


>> NOTE: Tasks Summary: Attempted 928 tasks of which 635 didn't need to b=
e rerun and all succeeded.
>> ...
> It does add a lot of logging. I was torn on adding it but we have
> struggled to get the log levels right and this information is useful as
> you often need it to get the pressure values right. I'm torn on it.
>
> Cheers,
>
> Richard
>
>

--=20
# Randy MacLeod
# Wind River Linux

--------------mb6DA95dyRHTB5bFFx52Dkpj
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2024-01-09 9:12 a.m., Richard Purdie
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:15224f4fe986ab3508c1d0dc3d9b33b0b3e2e9c0.camel@linuxfoundation.org">
      <pre class="moz-quote-pre" wrap="">On Tue, 2024-01-09 at 15:09 +0100, Etienne Cordonnier wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">how much logging is this generating for your&nbsp;local builds? I'm
using&nbsp;BB_PRESSURE_MAX_CPU=&quot;500&quot;, and this patch generates hundreds of
lines of logs during a typical build (on kirkstone 4.0.15). Is that
the expected behavior? It makes it hard to read other logs.

E.g. this incremental build with 300 tasks printed 280 lines of
Pressure status change:

...
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU: 495.3/500.0, IO: 1723.0/None, Mem: 0.0/None) - using 1/48 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU: 985.3/500.0, IO: 2201.8/None, Mem: 176.8/None) - using 1/48 bitbake threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU: 420.8/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/48 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU: 4049.8/500.0, IO: 14719.7/None, Mem: 0.0/None) - using 1/48 bitbake threads
NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/48 bitbake threads
NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU: 21922.9/500.0, IO: 10137.8/None, Mem: 194.8/None) - using 1/48 bitbake threads</pre>
      </blockquote>
    </blockquote>
    <p>In this case, you have up to 48 threads permitted yet the CPU is
      already overloaded<br>
      based on the pressure logs.</p>
    <p>How many physical/virtual cores are actually available?<br>
    </p>
    <p>Is some other activity doing CPU intensive work on the system?<br>
      Is the one task running &gt; 48 compile jobs and causing CPU
      contention in the system?<br>
      <br>
      <br>
    </p>
    <p>I'd expect that for a modest update on a mostly 48 vCPU system,
      you would rarely see any pressure logs but<br>
      I tested on my 24 vCPU system with CPU=500 and early in the builds
      as configure runs for various packags there are waves of<br>
      tasks launched and then the system becomes congested:</p>
    <p>NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
      (CPU: 8797.1/500.0, IO: 49.8/None, Mem: 0.0/None) - using 23/24
      bitbake threads<br>
      NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
      (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 2/24 bitbake
      threads<br>
      NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
      (CPU: 3720.5/500.0, IO: 0.0/None, Mem: 0.0/None) - using 3/24
      bitbake threads<br>
      NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
      (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24 bitbake
      threads<br>
      NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
      (CPU: 533.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 22/24
      bitbake threads<br>
      NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
      (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 19/24
      bitbake threads<br>
      NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
      (CPU: 693451.9/500.0, IO: 0.0/None, Mem: 32401.3/None) - using
      20/24 bitbake threads<br>
      NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
      (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24 bitbake
      threads<br>
      NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
      (CPU: 39409.4/500.0, IO: 662.6/None, Mem: 155.6/None) - using
      23/24 bitbake threads<br>
      NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
      (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 13/24
      bitbake threads<br>
      NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
      (CPU: 411246.5/500.0, IO: 0.0/None, Mem: 0.0/None) - using 14/24
      bitbake threads<br>
      NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
      (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24 bitbake
      threads<br>
      NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
      (CPU: 531.9/500.0, IO: 0.0/None, Mem: 0.0/None) - using 7/24
      bitbake threads<br>
      NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
      (CPU: 494.9/500.0, IO: 0.0/None, Mem: 0.0/None) - using 7/24
      bitbake threads<br>
      NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
      (CPU: 514.3/500.0, IO: 0.0/None, Mem: 0.0/None) - using 15/24
      bitbake threads<br>
      NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
      (CPU: 497.2/500.0, IO: 0.0/None, Mem: 0.0/None) - using 15/24
      bitbake threads<br>
      NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
      (CPU: 501.9/500.0, IO: 0.0/None, Mem: 0.0/None) - using 16/24
      bitbake threads<br>
      NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
      (CPU: 497.3/500.0, IO: 0.0/None, Mem: 0.0/None) - using 16/24
      bitbake threads<br>
      NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
      (CPU: 501.6/500.0, IO: 0.0/None, Mem: 0.0/None) - using 17/24
      bitbake threads<br>
      NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
      (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 14/24
      bitbake threads<br>
      NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
      (CPU: 36473.5/500.0, IO: 0.0/None, Mem: 0.0/None) - using 15/24
      bitbake threads<br>
      NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
      (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24 bitbake
      threads<br>
      NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
      (CPU: 526.7/500.0, IO: 0.0/None, Mem: 0.0/None) - using 2/24
      bitbake threads<br>
      NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
      (CPU: 472.1/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24
      bitbake threads<br>
      NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
      (CPU: 502.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 22/24
      bitbake threads<br>
      NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
      (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24 bitbake
      threads<br>
      NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
      (CPU: 522.2/500.0, IO: 137.1/None, Mem: 0.0/None) - using 22/24
      bitbake threads<br>
      NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
      (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 2/24 bitbake
      threads<br>
      NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
      (CPU: 2192.1/500.0, IO: 0.0/None, Mem: 0.0/None) - using 3/24
      bitbake threads<br>
      NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
      (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 1/24 bitbake
      threads<br>
      NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
      (CPU: 529.0/500.0, IO: 64.8/None, Mem: 0.0/None) - using 21/24
      bitbake threads<br>
      NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
      (CPU: 0.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 4/24 bitbake
      threads<br>
      NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
      (CPU: 2420.0/500.0, IO: 0.0/None, Mem: 0.0/None) - using 5/24
      bitbake threads<br>
      NOTE: Pressure status changed to CPU: False, IO: None, Mem: None
      (CPU: 395.1/500.0, IO: 0.0/None, Mem: 0.0/None) - using 2/24
      bitbake threads<br>
      NOTE: Pressure status changed to CPU: True, IO: None, Mem: None
      (CPU: 523.4/500.0, IO: 0.0/None, Mem: 0.0/None) - using 6/24
      bitbake threads<br>
      <br>
    </p>
    <p>I've been trying to make time to improve the pressure regulation
      since we neglected<br>
      the kernel devs advice that we should not sample the pressure info
      more<br>
      than once every 50 ms or so. <br>
    </p>
    <p>I'll try another build with the CPU pressure limit set higher,
      and I suggest you do the same.<br>
    </p>
    <p><br>
    </p>
    <p>I still think your logs look 'interesting' so I look forward to
      hearing what your system is<br>
      and what it's doing.<br>
    </p>
    <p>Thanks,<br>
    </p>
    <p>../Randy</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:15224f4fe986ab3508c1d0dc3d9b33b0b3e2e9c0.camel@linuxfoundation.org">
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
NOTE: Tasks Summary: Attempted 928 tasks of which 635 didn't need to be rerun and all succeeded.
...
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">It does add a lot of logging. I was torn on adding it but we have
struggled to get the log levels right and this information is useful as
you often need it to get the pressure values right. I'm torn on it.

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

--------------mb6DA95dyRHTB5bFFx52Dkpj--

