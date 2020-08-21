Received: from NAM12-DM6-obe.outbound.protection.outlook.com (NAM12-DM6-obe.outbound.protection.outlook.com [40.107.243.77])
 by mx.groups.io with SMTP id smtpd.web11.136722.1598024883511435914
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Aug 2020 08:48:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=NrNQqXeo;
 spf=pass (domain: windriver.com, ip: 40.107.243.77, mailfrom: hongxu.jia@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0b0vmoMVQ46FId726G17sIVO7M2xYBWxar3AvZBYX2/vpqs/+mloWpwehPwsOQxmjM0lEyIubsohOOLsOuFtuxsETzn1bdVtIblki9uxGzpLDOtnNKHkx6Lyr9BTNCEuGBoSZ33Ua+31X/hgxkfT9KfgJ4RnTYvO4I7J8HeFr9csYUgFp50sTrlV1nYAh9sROSjoSrwcPIjod5M6RNrmsI+49iYAYs7F0NPPtauX9RkBJaQPULKYFqsqoZvi3f/T11SMEmeo9nHUVPRGt5tPRi36RGL9DrccQ+k3uORFilnK6ePaT/cRevIovNhgpgzdyqG/HR6BFoPEx0VOTaWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHzCEwgfC78xvgM0nEhsLptg3ENOI+GBjBhjpitFQUw=;
 b=DkTOXrlozhfmxntzh3njr1hl+4MjXP+mV7atF06IM3yRcr0iWzjjKONZ9/7UWcMWV9zxQrICjrbWKxfup1JV3jwyqW05uf+cIQ5Aubvs2vWdgrlEM3qHnxvrd2D1lA4h6MpmYfwtG9yu0POkcCWHQwhmIipoeild2Ki7l8NjRWqDzczozfBDCQGnpRj3mZsjux4BwCucRyYEbpus7lCItNHkqH0CmfkLCnmQrpz1YiDTVoozwKECQnUQM6gD+wmmKfwpsDMujfVQQPPGH1/WoMnyOTK24gwFKbOwf5oqEqKSaIw3Tf/g4/Zy8687lbf9LAfnwmaP6CF84a+OaXo11g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHzCEwgfC78xvgM0nEhsLptg3ENOI+GBjBhjpitFQUw=;
 b=NrNQqXeoN8eU3eChG9P2n6gm04/cvom+9D8o5wwYmA4NcergP5hgwbJ9/0hDoIDLiTmaFVFNfpdOJRkM/ZjS6/+AjBDz0iumnn9CxFAwLJ3twUEZ7OWYK2LZx9qGoZBfa3yZcTlqMBj6NzMMD5PXDOhVj/mK2tiCmpmJof16qgs=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4380.namprd11.prod.outlook.com (2603:10b6:5:14e::20)
 by DM5PR11MB1708.namprd11.prod.outlook.com (2603:10b6:3:d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Fri, 21 Aug 2020 15:48:02 +0000
Received: from DM6PR11MB4380.namprd11.prod.outlook.com
 ([fe80::213c:2f71:aad:4494]) by DM6PR11MB4380.namprd11.prod.outlook.com
 ([fe80::213c:2f71:aad:4494%3]) with mapi id 15.20.3305.026; Fri, 21 Aug 2020
 15:48:02 +0000
Subject: Re: [bitbake-devel] [PATCH] server/process: fix exit racing between process and thread
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <162D282190DD8FB5.7353@lists.openembedded.org>
 <9b28fe30-a475-2949-118e-1fe70aef4fe4@windriver.com>
 <0e45aff7dadff33243ae2590e2f813395b71f35e.camel@linuxfoundation.org>
From: "hongxu" <hongxu.jia@windriver.com>
Message-ID: <d9f5d95c-1796-de85-bfa3-889c1ce31c2f@windriver.com>
Date: Fri, 21 Aug 2020 23:47:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <0e45aff7dadff33243ae2590e2f813395b71f35e.camel@linuxfoundation.org>
X-ClientProxiedBy: BY3PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:a03:255::31) To DM6PR11MB4380.namprd11.prod.outlook.com
 (2603:10b6:5:14e::20)
Return-Path: hongxu.jia@windriver.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BY3PR10CA0026.namprd10.prod.outlook.com (2603:10b6:a03:255::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Fri, 21 Aug 2020 15:48:00 +0000
X-Originating-IP: [60.247.85.82]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03b7301c-635b-4507-ab97-08d845e995c9
X-MS-TrafficTypeDiagnostic: DM5PR11MB1708:
X-Microsoft-Antispam-PRVS: 
	<DM5PR11MB1708A85F9566F2B0B6A30014945B0@DM5PR11MB1708.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Ba/HSZ10vUFfnP0Z5dtnO4iPFgsDIEesBbY/8DzKGynokBKvFEOlQfAONqWKUkKwf/qG/RjLEf5Kz23aoeBlJ1vCOIQuX3nAT0eOkD3DaYjIrssO/aCSDyNeTmHAsets980/oaqcixC4/oTtxi+5CBR8l7RhrxGb/PKy0zQrvdrTeoeejvhyDgOLqVEE60p9CqfSMvTRiO5tg1PCtBVvYm0W3JFm9MbjsKvrQqk59LlGZXqTshwM6OWi9DEU2n9qIbOF4JY7ZrRl99OdRHivek+VYWZwgGPhN84aZtyKLqcX4H8ChG+MCQaWrSffL/EOCp+dBBwwmeJmowHKpKwaUHT0n9jhLVRgPi6p0c+o3mk+cO2iqPerGhatHu0dMoPyUpP5a05on7+y/5xaVRQ892J8r44zlb0T2Ieip2ctyWVZn5AROXlr2zdNsdhH/VtSVXQobVTM6ZZZqFzizlBMV/lcZmzcZ5bENBHPOKKiYA0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39850400004)(366004)(376002)(396003)(44832011)(8936002)(6666004)(16576012)(956004)(8676002)(83380400001)(6486002)(2616005)(2906002)(53546011)(52116002)(66476007)(966005)(110011004)(31686004)(316002)(31696002)(66556008)(86362001)(478600001)(36756003)(186003)(66946007)(26005)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	pPJ6dEfWJ/SOfSjHV6VQCruR71tazjjQ+oUo/2WheQm7n3DsUF0z3NaadT3OuhdObBd20JMGytfiypnVYgBSVPw3wchvLJO5Sf8Anqxok9VHMssFwt7oWUpfgghKGVxE6KklwwiPar6rymEV9tO1EF012JxICq+mdkMnFqkv9FaR1QlfGaLctSPihpm4zMnqtA6cv/s3/TaVHcVY6jm+0ZmmTbqYSXQxn6PQHt3rciXDJMIiCuDrLkR4CFsefQKQMBXF9Q9t+oswEej3M8qSUrrIl/bJb9gXF87bFfn06ltLMMU3jZBNxlPItzPra9X/Fw70vZmc3xs7EStpxBHksEisG2405xMXdNdLz3TobsqbQ4Hqt+RyGCu3+S8Tuf2mgavH0lIffCWqN2ToRiYwS+pXKfm5nOl3GtCrpBXrkpUDVQloHL6z/58gZjS1vyH0rzZqmFGGRyRAxk6+T3/Rnr8CB7g0W+H3hioV5o0nvkgoSaGnV9/1EHfMcQ5a6NhMngBrMQKoB5ery/ONy9HLQnve006H9DSy7lwk52Byfs0aQNa67s38b1uqSwmBhY94VA4BDY08p8xy0q+m4hvwls7AegjHImUbLDOMHULTWoZeAPAjhAqbmVSrOVyfSQCmWahGwt/Vo5GtOrI575xvOw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b7301c-635b-4507-ab97-08d845e995c9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 15:48:02.0280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JpFsehjepoJQhhA5bHZTI/zTn8o/Jav9rB1KjsZmH75ND/7nvFvIZAUSyNQQ5fW5wIUtALQOQhDd3M3/bGrSVzFe5sgtTTyTXtczbuDPGvc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1708
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US

On 8/21/20 6:03 PM, Richard Purdie wrote:
> On Fri, 2020-08-21 at 10:56 +0800, Hongxu Jia wrote:
>> Hi RP,
>>
>> I have another solution to fix this issue, how about drop
>> thread invoking, directly call sync_caches in shutdown?
>> But there are some else multiprocessing.util.Finalize calling
>> in bitbake/lib/bb/cooker.py, I am not sure about the side effect
>>
>> --- a/bitbake/lib/bb/cooker.py
>> +++ b/bitbake/lib/bb/cooker.py
>> @@ -2130,10 +2130,7 @@ class CookerParser(object):
>>               for c in self.bb_caches.values():
>>                   c.sync()
>>  =20
>> -        sync =3D threading.Thread(target=3Dsync_caches)
>> -        sync.start()
>> -        # While multiprocess exit, it should wait thread terminates
>> -        multiprocessing.util.Finalize(None, sync.join,
>> exitpriority=3D-100)
>> +        sync_caches()
>>           bb.codeparser.parser_cache_savemerge()
>>           bb.fetch.fetcher_parse_done()
>>           if self.cooker.configuration.profile:
> Well spotted!
>
> We use a thread here to try and avoid delays whilst the cache is
> written out so its a performance optimisation.
>
> I wonder if we could use atexit here to register the call to
> sync.join() ?
Yes, the original commit [1] called atexit, but commit [2] changed

it to multiprocessing.util.Finalize, I've tried [1], but it did not work fo=
r

above case any more, it seems the thread join not work in atexit

while fork daemon used.

--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -28,6 +28,7 @@ import json
 =C2=A0import pickle
 =C2=A0import codecs
 =C2=A0import hashserv
+import atexit

 =C2=A0logger=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D logging.getLogger("BitBake"=
)
 =C2=A0collectlog=C2=A0 =3D logging.getLogger("BitBake.Collection")
@@ -2132,8 +2133,7 @@ class CookerParser(object):

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sync =3D threading.Thread=
(target=3Dsync_caches)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sync.start()
-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 multiprocessing.util.Finalize(N=
one, sync.join, exitpriority=3D-100)
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 atexit.register(lambda: sync.jo=
in())
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.codeparser.parser_cach=
e_savemerge()
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.fetch.fetcher_parse_do=
ne()
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if self.cooker.configurat=
ion.profile:

[1]=20
http://git.openembedded.org/bitbake/commit/?id=3D97ce57e6f860d3e6f34cc7a603=
ed1eeac4f423d3
[2]=20
http://git.openembedded.org/bitbake/commit/?id=3D588d339f2bde8ab6547bc0c1c4=
e7b83310b1318f
>
> We just need to be careful this is only called in the cooker process
> and not any others we may fork() off. We therefore may need a wrapper
> to ensure that getpid() is the correct (saved) value?

Yes, after applying solution 1 fix, I check the content of bitbake.lock,

the saved getpid is the same with cooker process. But it differs

with the log message in bitbake-cookerdaemon.log (the log message

is before multiprocessing.start)

So I think the fix of get multiprocessing.Process back is the best choice

we have which reduces unknown risk

//Hongxu

> Cheers,
>
> Richard
>

