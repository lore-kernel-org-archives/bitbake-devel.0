Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web09.7594.1622600361589292362
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 01 Jun 2021 19:19:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=M5R8CxMB;
 spf=pass (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=17878cf8cb=mingli.yu@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1522Ixep010402;
	Wed, 2 Jun 2021 02:19:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by mx0a-0064b401.pphosted.com with ESMTP id 38wptu0dnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Jun 2021 02:19:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOE9nWTjIWJ3GQRGdZEwun5OQ30fBzRGZVuJGF52dRojgQFaRpHGsbwEc4zznzOqdr8VzOzeqauGCwVQ5QJOQaMBt9EocO7gOhWxIEbiWxTlAudNJHGB0gexY4SBFLY0ZQbHsZ/FmCj/kDun1dNGdJd1FG6gxk4vqnD4UEVPX/0hC5OOdw7bU5zyHTopYpELHDzdpSpxnWkK6IhEcUGIZ1fTLsu0ML+XCrepVNZh5nhXyD2j/nU6fRbtmgY4/SAIAtLDEaqlw6xqwOj12vWGBCCBybpKyhSySukkM4KrZiejqC5snSdsllDbtYbQtdLy1aCi/mvj7Np5RW96zUDZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyVSHrNLpoxOGw/yh9CW6H7mNm4coztQSAJzPSm0LH8=;
 b=RnwOjjH5cws7C3r/JJ6gvRDdH5BQ2EkhWXv+kz2du6kwW3C0L5MmSFFVP6BDiXWfdumkrFEz7pD8ZUOdvz8w9slA8N0nxPk2F9fqJrtIW9Vf2V7L/uhI1xL+tuw7NZgmXkyZ4njzOfKQi/WFTxjTOI8+s8lEv46O5VcQlFVqZl9pAcXi1m3TElWM4cLCObSaGXhBytrWHpqvRWRsqOSRorOCjL30NtFa/vKtN2rjIr+3Y0Zo+cp6JQfAHCoJef5YxmSALM6zaNmSvg2xl3b9cRlJOYmGvS5oJnpFf9h12IhE935dk/3F64dnv3pYH5Ybrvu8jrdBIGTsX0qWCZRP6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyVSHrNLpoxOGw/yh9CW6H7mNm4coztQSAJzPSm0LH8=;
 b=M5R8CxMBifLDdSIgi2Ar2VlGQY2N5JnePqW/zQ2+AO733QCLpVdmPHrvZ8KUpxhYzA/Mw8nH+7MiJ8IQh6BNwkvgzg8l+lisnRmgnrBRuol2PM8tsZBYt9wXVr69UeYK5d0/pCGxNf3SpvXeYBqd5dLmBXEBopbO5pmti3TFvFY=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CO1PR11MB5009.namprd11.prod.outlook.com (2603:10b6:303:9e::11)
 by MWHPR1101MB2238.namprd11.prod.outlook.com (2603:10b6:301:55::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Wed, 2 Jun
 2021 02:19:18 +0000
Received: from CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::c129:2a53:5093:81e8]) by CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::c129:2a53:5093:81e8%3]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 02:19:18 +0000
Subject: Re: [bitbake-devel] [PATCH v2] fetch2: make sure the uri added as expected
From: "Yu, Mingli" <mingli.yu@windriver.com>
To: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
References: <16806B6C2D8F7DAB.5504@lists.openembedded.org>
 <1682DA98929F43DA.30286@lists.openembedded.org>
Message-ID: <9f0083d6-27c1-6a93-35da-0a80d399f33d@windriver.com>
Date: Wed, 2 Jun 2021 10:24:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1682DA98929F43DA.30286@lists.openembedded.org>
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR03CA0023.apcprd03.prod.outlook.com
 (2603:1096:203:c9::10) To CO1PR11MB5009.namprd11.prod.outlook.com
 (2603:10b6:303:9e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.140] (60.247.85.82) by HKAPR03CA0023.apcprd03.prod.outlook.com (2603:1096:203:c9::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend Transport; Wed, 2 Jun 2021 02:19:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 045a8a42-cf95-4cb7-a1db-08d9256cd32a
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2238:
X-Microsoft-Antispam-PRVS: 
	<MWHPR1101MB223869DF0C629692F567F358F13D9@MWHPR1101MB2238.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JNtlH2Z9WEe98eT2avmkfl2IjxT6YEo9VCYHb4uGXaLWf1th6enlts6VGJ0r6iyah8sg2AryjRPpcF3/MqjRcEEYHwyhnbylAKOWN540Sv3u8xrNYCL9uUNvSG/7gJC9whG6VuFMoOBmaujkkOTa/7cgZuwLwdvuIkkMXor73gOYbLyxaCYEVvzAUytROh/DNTy4FazYNheToqwFxK3NwiPF6dXgFv3W18YE1tB/k/Tzhv4cBP2K+35wvQgKJfNMbMKzAgXJEBSLc0OsbaZkXKY+vFC4KVRo8ePwuxvbDP6iRunCRb1YpHnS+0kV/uAwuhWhCf+8RDmcdXynn/Qb2/svVnIhNdJwU1fEUEj4UR51rR9AX8L45wDjiziKNiQGE8yWUfGGazZKsKRjD5Vu/lOv0D8bMraylz4ie/oW0+W2+EgFNv1gWZKvobz7fZMxvN9zSReZpy4TXd4jJRG10tkQUNDPxdFQ7efBY6evG8BKDL3hxxzDWKIlEM3Agaha06/Rgb/NnlCKFiBHEHOPPv0ONhx9y9/cO1Kd2qq69RmfPiQz1XqUqj/izUyhqpwyvJIgRCnd+2vpn/1UTWkfntWutskLlU39Gbceb1P9UE4uGGyj272o3Y0AXVePf+UrfiAgDcmLSOKeH5WIykVBBpzFDoE+7BiwUj/qQhIBCex7EsJvkO9J8YQUPsZRpS6ucH2CojxJO00ijDnFH5J55/cWDZA5jx7K3uVlFQQuEmHTBHxR+1z9r6TLY4acy4vFwVjBFkym76FqTxsNB2TUwmxIFFLA9Q/a4hs7heaFiK2Qcck2fj04lkp0nnf0RVxnMO60vQI7gklX35q7o03ViUm6W3vJd5DpM784JPccLrRBLL9fcpgCUCkEPXNOwNHs1AMXJ+arZYoFeCRINsXYWnpZC7QJIDHj7DaYQ3kDnQk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5009.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(39850400004)(376002)(396003)(8936002)(66476007)(66556008)(66946007)(31686004)(5660300002)(52116002)(6666004)(16526019)(2616005)(956004)(83380400001)(38350700002)(26005)(36756003)(16576012)(186003)(6486002)(2906002)(38100700002)(478600001)(316002)(966005)(6706004)(8676002)(31696002)(86362001)(53546011)(78286007)(45980500001)(43740500002)(4084875004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?dHA3YjJOUUhKMTFCTkpBdGhhcUxwZU8vdWxlTEFGd1BFQ2l2WFdnY0dDWnls?=
 =?utf-8?B?cGxkRjJOK2hBWWk4UmQ5WlBFc3BkOGc4WGI0UkJuR0pVems1MVpRSzJISlhm?=
 =?utf-8?B?VTVyR0lsWCtIVGFDQ3JIZ3dBbTI0YWZMS2JLMFQ0VVl1MUNKRUEwNkQraEJT?=
 =?utf-8?B?aHFHbWFLVkorTlJhMUVNUVB2UE54Z3VwaEtlSHFwMUZjWkpLSjdNbCtnZ1N4?=
 =?utf-8?B?Q0M1TkZleFFISDFraUl3YnhvbUlMUWZjckN6M1gzY3NFOTExWHBlQ3B1RmEz?=
 =?utf-8?B?YS9xdzZEVUJQQ1VpV29UUXRndmZHYWZxb3FxbWVKZG5WeDJOSnQ2SUNzY3l2?=
 =?utf-8?B?c2ZVY0piR1QyQUIxYm8rckhaaDZud1pXa3lvQTBQVVg0NE9oQk51T3FkNjVn?=
 =?utf-8?B?NjJmZlhWVEV3YUV1N0dMcWFRMEJ0VzY5Ujczb1ZOMit6cndsUzFuWkw2Y2JF?=
 =?utf-8?B?ZzNnT0RRbW15dm5ncmxOQVEzU3Y2dDRoSUNlYUpBdHk1ajl0RjN1SENRYW9U?=
 =?utf-8?B?bGQ5SXo0aUx6d1M1ekZiOTdsR1FhUWtXMlgxUkJ0aENHS1ZMSXJrN0w3d1A4?=
 =?utf-8?B?dkV5Ym9Eb0EwV05MTlNSNnp5Vk9EUVlaS0dNazVQaldGcjBqQUVLNUlGNVJ3?=
 =?utf-8?B?WEM4R01MTk1NaVlMMmZaU3l4MTgwQi9EdFFUbTRFSjE3L2ZlTitDN2hiMHN5?=
 =?utf-8?B?U3Zrd3l3T3U0Zy9ITk9kV2M4ZkYxTXFkandVS0RvQ0dqcW5LYi9qTkpTMk9F?=
 =?utf-8?B?emVLYzVhMWYzekpCY3F3MldmZjlxdUthcGNaekpLSHMrRGFta0djSUlYUHdP?=
 =?utf-8?B?VlRVam5YYUxEUVJQbmtkZW9ZalUzaE9EVlM5bzd2SEdnN1QxTlVjSEIyTnBJ?=
 =?utf-8?B?NE9HM1hnb203UlkraWN0R0VRclArUXQvZ01mUnNyZzNvU2o0Qys5c3V1Z0E3?=
 =?utf-8?B?YUM1VFhDVm9KLzNhVEVOTWI3RVFWdWlHamlRWEZkYy9ObmhCY09BNDc4NUVO?=
 =?utf-8?B?K28yeGl5TVJBeGpYbDg5YmluTW1KdHJTcWN0UFE3dnNlTVJVUjJ3SjNpeXRq?=
 =?utf-8?B?T3dEakg5dUpqZWRmRzVZT1dYU3F6UEQ1QjhLcGZSY1VCZ3ZxV1FBWFhNbFFT?=
 =?utf-8?B?dE5Mb2Mxb25UVk54d2tPeXVYTHd4RXFSZG1qaUx5akJuL3dkaTdGaDRZMWpo?=
 =?utf-8?B?Zmo2UEZhRzB6ZmZNSGpWUE1POTJiTXBXYTVVR1J5cWZZVzF3RU1kcUFnR2s3?=
 =?utf-8?B?YlFTbEhMeXFncjBCZ1dKUm1YMUhqUmovNEhlWUtPQzJKNFd3ak9PUVB5Q29O?=
 =?utf-8?B?bUdsdEZzMWZHN1BzQkZDdjlmbGFSZXNsOWJBeFhKQkF5c0w4YUwzVnNXTlZC?=
 =?utf-8?B?ZjJJbWdwend1cGJyOG50R2VTaUhJcU4xYnRXTEp4bXA1WE5iK29aMmFxYkZt?=
 =?utf-8?B?SXhlU3RyY3hlZVNPanJ0TmZ4RlRTME5UdmE1VzZueHlONUx4QnY4VHlIL0Jw?=
 =?utf-8?B?QzJ3U1NXWjJLb1F5TStYNjAzcytId2xYN3FNaENtdVpkT1hFVmt3TmU4c0pS?=
 =?utf-8?B?cys3RGo4WlMwaC9scStVNUpacHhWQStRUGd1M3lydGt6TUIxWkFNRmY1Mkww?=
 =?utf-8?B?am00WG9ZWjhEeG9TbkpJWEd5UDV2MUlxT2c2NERnaFF3ZjcwRndsRnBqVGVQ?=
 =?utf-8?B?OFNmR3FjdE9HY2xiZUJLU3ZOcGdCbzZjZ1QxZ1lmTi8wSUtZbXp1Wmlmc1Bp?=
 =?utf-8?Q?9uEjF2c4BZbKF6DCP9WaF50bKUu/aiN2PtpyY31?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 045a8a42-cf95-4cb7-a1db-08d9256cd32a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 02:19:18.1009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2lk/Avs6EI2bGEK0p+raVRkp9hc1qKLtdydZTwaSbUNH3Sgwt/hLEvjtwZsbAhGqldXl4NZpwHyvOqJq9p3mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2238
X-Proofpoint-ORIG-GUID: 0oc-dhVoFTH9NEHjXMz3YxsUeN9qTEAg
X-Proofpoint-GUID: 0oc-dhVoFTH9NEHjXMz3YxsUeN9qTEAg
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-02_01:2021-06-01,2021-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106020013
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Any comments?

Thanks,

On 5/27/21 3:04 PM, Yu, Mingli wrote:
> From: Mingli Yu <mingli.yu@windriver.com>
> 
> When call uri_replace to get the new uris, we should guarantee the
> new uri is added when the replace uri begins with file if the find
> uri begin with wildcard which mapped as below.
> PREMIRRORS_append = " \
>       .*://.*/.*  git://somewhere.org/somedir/MIRRORNAME;protocol=http \n \
> "      |         |
>         |         |
>         |         |
>         find      replace
> 
> Before the patch:
> the original uri
> gitsm://github.com/tianocore/edk2.git;branch=master;protocol=https
> 
> PREMIRRORS_append = " \
>       .*://.*/.*  git://somewhere.org/somedir/MIRRORNAME;protocol=http \n \
> "
> The new uri is git://somewhere.org/somedir/github.com.tianocore.edk2.git/git2_github.com.tianocore.edk2.git.tar.gz;protocol=http
> 
> After the patch:
> the original uri
> gitsm://github.com/tianocore/edk2.git;branch=master;protocol=https
> 
> PREMIRRORS_append = " \
>       .*://.*/.*  git://somewhere.org/somedir/MIRRORNAME;protocol=http \n \
> "
> The new uri is None as the find begins with wildcard but the replace
> doesn't begin with file.
> 
> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
> ---
>   lib/bb/fetch2/__init__.py | 2 ++
>   lib/bb/tests/fetch.py     | 8 +++++++-
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
> index cf0201c4..6701654b 100644
> --- a/lib/bb/fetch2/__init__.py
> +++ b/lib/bb/fetch2/__init__.py
> @@ -430,6 +430,8 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
>       uri_replace_decoded = list(decodeurl(uri_replace))
>       logger.debug2("For url %s comparing %s to %s" % (uri_decoded, uri_find_decoded, uri_replace_decoded))
>       result_decoded = ['', '', '', '', '', {}]
> +    if uri_find_decoded[0] == '.*' and uri_replace_decoded[0] != 'file':
> +        uri_find_decoded[0] = uri_replace_decoded[0]
>       for loc, i in enumerate(uri_find_decoded):
>           result_decoded[loc] = uri_decoded[loc]
>           regexp = i
> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
> index 9291ce4a..85a14301 100644
> --- a/lib/bb/tests/fetch.py
> +++ b/lib/bb/tests/fetch.py
> @@ -406,6 +406,8 @@ class MirrorUriTest(FetcherTest):
>               : "git://somewhere.org/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http",
>           ("git://someserver.org/bitbake;tag=1234567890123456789012345678901234567890", "git://someserver.org/bitbake", "git://git.openembedded.org/bitbake")
>               : "git://git.openembedded.org/bitbake;tag=1234567890123456789012345678901234567890",
> +        ("gitsm://github.com/tianocore/edk2.git;branch=master;protocol=https", ".*://.*/.*", "git://somewhere.org/somedir/MIRRORNAME;protocol=http")
> +            : None,
>           ("file://sstate-xyz.tgz", "file://.*", "file:///somewhere/1234/sstate-cache")
>               : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
>           ("file://sstate-xyz.tgz", "file://.*", "file:///somewhere/1234/sstate-cache/")
> @@ -447,7 +449,11 @@ class MirrorUriTest(FetcherTest):
>               ud.setup_localpath(self.d)
>               mirrors = bb.fetch2.mirror_from_string("%s %s" % (k[1], k[2]))
>               newuris, uds = bb.fetch2.build_mirroruris(ud, mirrors, self.d)
> -            self.assertEqual([v], newuris)
> +            if not v:
> +                 self.assertEqual([v], newuris)
> +            else:
> +                 self.assertEqual([], newuris)
> +
>   
>       def test_urilist1(self):
>           fetcher = bb.fetch.FetchData("http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", self.d)
> 
> 
> 
> 
> 
