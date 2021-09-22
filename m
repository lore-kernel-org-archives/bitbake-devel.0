Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web09.1613.1632275905968818591
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Sep 2021 18:58:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=Be1TV8WK;
 spf=pass (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=4899e2dc02=kai.kang@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18M1tJqj024633
	for <bitbake-devel@lists.openembedded.org>; Wed, 22 Sep 2021 01:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 mime-version; s=PPS06212021;
 bh=n6M2ZeHifbCRItV5XdAv9US9RsM+r12lvkvMpNEUbrE=;
 b=Be1TV8WKh2gBuBOPMVqOKrU26bsGaYbRGxCp7SBrvn8LCfw8eWluiAdjJHyylrIoOMa7
 82dScqNlJHhn9zeTMNqYfEBU62MLovLRrx6p4MVktQaApIwjMfjqOVkcTjfU35BfRS+X
 i7XeaadiQtGtyn5Irp5vSDbJ7PAMicqrumH2FawCJq9BgDbj+/+OgED9lgKPxrKBpV4R
 uUuTT64j/+KB+Oe3DO87ae83bCD8HMD538ded5qpnoGoXVdKK1RxvpGNgjhgNcKIWi4J
 UGPnd/I+tRbJ0MFNqcqTKWXdhHxpGTOO4kstGQvqs/O+W/GHHUiw1hn5Jj/cJArULzOT Tg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com with ESMTP id 3b7q3jg4n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 22 Sep 2021 01:58:24 +0000
Received: from m0250811.ppops.net (m0250811.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18M1wNBL030099
	for <bitbake-devel@lists.openembedded.org>; Wed, 22 Sep 2021 01:58:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
	by mx0a-0064b401.pphosted.com with ESMTP id 3b7q3jg4n1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Sep 2021 01:58:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSWUCQ+yF8CTdxwg8isIsRg1tSRSmeQn8JogvcBOWRrUAs4vre3BaMZGDEiNm42Iz1yvR3ZyxZ2H5ga8w+wOAdMbyqlByCT+GUw0g4qlFlqoSebFp6Jz6OuRvSDZe0mj0yWVONLHywosuG45HvStnaxX7pvhtibgu+l0GZHGobPwCGz5kGTpIxksBMz27ExaYKAppXnGRach4TP46NfLP7PoNn5Ds7HBedN9jVTsmj+adiVWUz6wK26HM5u6cafD0Bldg46wHUfSHjYmKaNPPSFirnsW0vQkfMw02OiYcuTSZ1vZsZ+rcByVkjsJwgZX8TaI7jwex/pi4x54k3WsKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=n6M2ZeHifbCRItV5XdAv9US9RsM+r12lvkvMpNEUbrE=;
 b=fVyPLkrrL4LnjLX8ZALLbOGJsJjaH0f5m+k6Wx8nL5LgIVybcS3Q8dGhVEcG+5NbUMC1J2ZuOOTjcAeR3oxspD3RDrdaDi+zVPtu7rk5izFp8MzaEMF4ekVdawfF/JpHymYEkSGpjkfTWPcMbr6b/939xPLH/YaTX7QIw3YhCBYRWjWERxX8cvBz8Af1jrnmbwYzCt22/MsKS2zL3hACu/gYFe9aFytMamYh5Upd8DBZigaF9mML1ELVzf/FabHI6I4ieqwBsj8bbKxOvxqBngPAdEZrh/vxMSoBVE8VWirU/Arw5jtimGcu6BaQsfToileYr2OzrjjTBqk1ZmAQ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: windriver.com; dkim=none (message not signed)
 header.d=none;windriver.com; dmarc=none action=none
 header.from=windriver.com;
Received: from CO6PR11MB5651.namprd11.prod.outlook.com (2603:10b6:5:356::20)
 by CO6PR11MB5668.namprd11.prod.outlook.com (2603:10b6:5:355::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 01:58:20 +0000
Received: from CO6PR11MB5651.namprd11.prod.outlook.com
 ([fe80::d92:b64a:8b59:cf4a]) by CO6PR11MB5651.namprd11.prod.outlook.com
 ([fe80::d92:b64a:8b59:cf4a%8]) with mapi id 15.20.4544.013; Wed, 22 Sep 2021
 01:58:20 +0000
Subject: Re: [bitbake-devel][ 1/3] bitbake: fetch2: fix premirror URI when downloadfilename defined
To: Scott Weaver <weaverjs@gmail.com>, bitbake-devel@lists.openembedded.org
References: <20210905222738.1050768-1-weaverjs@gmail.com>
 <20210905222738.1050768-2-weaverjs@gmail.com>
From: "kai" <kai.kang@windriver.com>
Message-ID: <dd26626a-079e-86d8-34ce-ad5d2b71ac8b@windriver.com>
Date: Wed, 22 Sep 2021 09:58:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210905222738.1050768-2-weaverjs@gmail.com>
X-ClientProxiedBy: MN2PR19CA0001.namprd19.prod.outlook.com
 (2603:10b6:208:178::14) To CO6PR11MB5651.namprd11.prod.outlook.com
 (2603:10b6:5:356::20)
MIME-Version: 1.0
Received: from [128.224.163.141] (60.247.85.82) by MN2PR19CA0001.namprd19.prod.outlook.com (2603:10b6:208:178::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 22 Sep 2021 01:58:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdd0e769-644d-4de7-1b57-08d97d6c73d0
X-MS-TrafficTypeDiagnostic: CO6PR11MB5668:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<CO6PR11MB5668C19D6B7545955FC75E0595A29@CO6PR11MB5668.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EJ30gpLkFjdkycwZ5/3VOT1iIgH6U0NFVUjP5xqvd7YBcmReiu5gN+fryrgd1GpV08wdmAetxIG2QO3kboyPN2gxkMBnQjOOORjMOm/XFedN0KBHC9hrU4Lh10sW1BY8vpJzEP62nrJPOxb7my9MoShH9dnEOCdZGNzvR53KLQdN76WMUyMTOJRHvyvn3A9Sb03WDKxkJExYJIKM4qkbQWS30T00aGK3CNjAS5Uzxku1fsJtyUCi5aV2j9Y2orps/Ay8DPOg6re6EBwGUXEUGNv6jpt/duumIG7+/VBg8t+PmzQEJfMPZOnkwYg6qXOy8rSj6BLn7Q0HTpseHcgD7kq849k3dnKyk+elEzVC2f1aH5H25ZCh3zDzOBt5F3Gajlgbr34p8Mp0GDemblCHGEBF4SUEYldJKNgrViGT8Pi8lYeE7TQ5E79s6KLPrU//LGXvzuw/m6hq9taY5Q01KDfeuEvGgi2dF+UyUlNH/MOqBTsyk6c0YqRqzya8jcozgpraZVtvU/VlvS2B8vNtOPhY9mr3kFGIsgYJ7MdC9Z62XHSkciZU6ps5VjM/puG3XeEMgEzOst4aUvmBKmXCJAD1ZQz4bWeMmB0DJ/aA9qoQ8XgGeLC4V7xHl4Gh+CDCDe1DYoZpCueBwrO6JDYffhgMWNw+5vm0IFH/kgjKFjVPaH9jrv4BiZ5svAZifVXBpcifBXKY9jfsr+G9V3TyKstJmPkbPQKPp8PkXkk9EM8a+PpbKxi0G1Eu8d2rprCzb6Z7mH6rm37M99Ugm06pWAxAi3HyV7DucgToxHkIxF5rEyjPeEo2F8ma1CpqIZelXdUFfhDIMgSPslua0JOmomzOH19HswUtLMwA1H22ucAndoBR4T8MQYxtiYRYyDvK5CKCi18YHbiBL+zU5UoGgGkyaMlJiEctT6fj2ZstU2w=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5651.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(66946007)(66556008)(31696002)(186003)(956004)(52116002)(5660300002)(38100700002)(8676002)(86362001)(26005)(31686004)(6666004)(2906002)(33964004)(966005)(53546011)(166002)(16576012)(508600001)(6486002)(2616005)(6706004)(36756003)(316002)(66476007)(38350700002)(83380400001)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MmE3eDJiOUtDQUJ6VlhzNGJFTTVFUFZ6aFFuVmRsQTFwVlc5eG9keDZwLzMx?=
 =?utf-8?B?QmloaUFBcGJ5ZDlndnRaYmtzajZndzJYT0YwOGZKRlFMeDBKeHNoSEU1bTA1?=
 =?utf-8?B?SFZweS8zMCtLQ2JUM2tYNUljdzhVWEFKdEVwSlRTR2M1NGtIbENpdFJXT0Q5?=
 =?utf-8?B?TzBSYjVRbGl4Z3Izd2RKNnc1OWxwejJNRjAwUkgxWVdnT2YzdUFJdllyRDE0?=
 =?utf-8?B?cWdib0szWG1xTE14eEEyUXNxeDUwSXNSSDJLTkdWZXh5eWlzTkkyOTFYMFp0?=
 =?utf-8?B?NzFwY3lQbjBxSEZtNUJ4cVYvcitCSnB3VmhYd1JXODY4c01tWGF1dU1TZDAr?=
 =?utf-8?B?dURxTStMelg4Y3Z6d29ja2FlTWV2QmZ5QjJuOU5NNHVkalhiQzNXMzlvcTRJ?=
 =?utf-8?B?em1ZTlBvSW1rR2prUG10cXBkeWJvLzRGL3A1WHhlMWlKZDNZN2NhMzlqVXpt?=
 =?utf-8?B?WnVoNkc5dDVpLzF3bEZNMDNmcngyM3VPcVhtd3pEa0ZoQVNkTFpQODBzZlNT?=
 =?utf-8?B?aFl3YjdqYy9NZXk2YjBWZHAxVG9CbmJhRy9lUUZQZXRrRlBrVUsvRURIcDdM?=
 =?utf-8?B?eU1HQmhyZFhFUUFkbG9nbmY0VEJzdTFmLzI0QVVud2ZidGhRTWNsSkx3cFdV?=
 =?utf-8?B?UWNiazU1WTRkclg1aW5TM2ozeDRzcmQ3VG5VQm8yazd2NTdZNDkwZHBWSExQ?=
 =?utf-8?B?amNiWlRjYUJmS3prcnY2UVBiMmhHdHN0amplcjBPbXJlUTh2SWE1Zm52Mjdw?=
 =?utf-8?B?MkdZSE9uMHNPYVhMblZMTVgxVGtuaDU2RFg3ZmFhcVNrd0lGYXpqNXdoMWtk?=
 =?utf-8?B?d2hxL202YUkzcFZBSDE4OXBBZjhnS3ZBaG12TTlMeGlnUVlhVGlSelNmWFRm?=
 =?utf-8?B?ank0UzhvWitzWWNvcjFVWmRwQllFVDFKQ3VBeHdVR3RtUGRtRjFYbTF6WEcw?=
 =?utf-8?B?OGFJVUZQMVBMbU5iRmxWRmFUTHNZQUg0VnpaWjlNYXZVSWliQjlnc3BtcU02?=
 =?utf-8?B?SlhJM0FVOC9OelQ1aWdRR0RzNWI0N1BOblJ1WElJT1ZCUUdhWGhXTFhPa0dI?=
 =?utf-8?B?S2dHNkVqQXplbGlwUUlZWlloUnZXbW5weDI0UWNqOVRTOHpRYWN0MjUwYUQ5?=
 =?utf-8?B?L3huTEdzSCtLS2N2RDI2eXhiTDlUU0pCbEY0bFZJdUQrOG9CMVFnOTlDTklW?=
 =?utf-8?B?bGRQaytldytFSC84eGZUMHlydTR1N3FFbytabXdXRk13ZGZtbzA3d2xoWFl5?=
 =?utf-8?B?bEFxRk82Q0tvVmVHSEQwY0dhTmgxbnViVjNWQ1RkdThJcVZESnliYURJWkpq?=
 =?utf-8?B?UnMyc1dxZFlCbVV1d1pWdGxxbUhscitsanVEQVhCay8xRmdKTHJMTzM5b1dl?=
 =?utf-8?B?NUhScjBZcDN5bHpPSnlDeWV1RGw4TXZ3ODVBM0x5bTJwSFBMRnJ4SzA5bnZt?=
 =?utf-8?B?TzU0N1FYeVV3cHJPbUIzMmlSKzJuSEk2aU5mS2F1UEJqOUUwaldTczJIZGlq?=
 =?utf-8?B?dkQxdDdFc2gwTEE2MDVHeUVYeTk0VE5mRGtsTERKcUQ5eFA0eUdhSm1rbVQz?=
 =?utf-8?B?WWZWVGFMUDJTNnBRWnVRWWh3akt0bEwyalUwTGZSRlJPdytPcUpSd3hVc3lk?=
 =?utf-8?B?ekF5dzNycStOWUZNMnNvU0NlZjROeUR1SGVNYXM3UnNvb05GWldrYXhSS0t4?=
 =?utf-8?B?ZXV1YjcxVzRpSVAxTENqUXQ5VVRjK210a3V4Z1M5U2k2TjAvMzh0MnZ1VHc5?=
 =?utf-8?Q?GlXJrrr3hS1peq/JYFxeYipK/YuSLr5PjNq68Ch?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd0e769-644d-4de7-1b57-08d97d6c73d0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5651.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 01:58:20.3808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3nZ/WZvZC5T9NXy2iGz+nGgjpOKN/eKhjPX90ixh0NMgGKoeFGEEVwW3gQ8pU9OMLFNRQEr+SqRlyQqwpJOtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5668
X-Proofpoint-GUID: YVLmkdDnCX8OqhQJsldkrytJw1RVAVZD
X-Proofpoint-ORIG-GUID: Vt3yJaVn7zsiNTIoi2RayVkx8ca2LHWd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 clxscore=1011 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220011
Content-Type: multipart/alternative;
 boundary="------------7A12874A189664DB7E3B1B38"
Content-Language: en-US

--------------7A12874A189664DB7E3B1B38
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/6/21 6:27 AM, Scott Weaver wrote:
> When downloadfilename is defined in a recipe's SRC_URI and PREMIRRORS is also
> defined using the same URI, the downloadfilename is appended to the mirror
> URI and it should not be.
>
> [YOCTO #13039]

As I commented in the bugzilla, I suppose it is an invalid bug.

It save the tarball with the name of the value of downloadfilename 
rather than the basename of the url.
In this case, the name of tarball in the premirror downloads/ directory 
is uthash-2.0.2.tar.gz rather than
2.0.2.tar.gz if the premirror is created by run bitbake do_fetch. So 
when premirror is used, it checks
uthash-2.0.2.tar.gz in the premirrors but not the original value 
'2.0.2.tar.gz'.

With this patch, it fails to fetch the tarball from premirrors. It could 
be reproduced by config:

BB_NO_NETWORK = "1"
BB_FETCH_PREMIRRORONLY = "1"

Regards,
Kai
>
> Signed-off-by: Scott Weaver <weaverjs@gmail.com>
> ---
>   bitbake/lib/bb/fetch2/__init__.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> index 914fa5c024..47a4943369 100644
> --- a/bitbake/lib/bb/fetch2/__init__.py
> +++ b/bitbake/lib/bb/fetch2/__init__.py
> @@ -466,7 +466,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
>                       # Kill parameters, they make no sense for mirror tarballs
>                       uri_decoded[5] = {}
>                   elif ud.localpath and ud.method.supports_checksum(ud):
> -                    basename = os.path.basename(ud.localpath)
> +                    basename = os.path.basename(uri_decoded[loc])
>                   if basename and not result_decoded[loc].endswith(basename):
>                       result_decoded[loc] = os.path.join(result_decoded[loc], basename)
>           else:
>
> 
>

-- 
Kai Kang
Wind River Linux


--------------7A12874A189664DB7E3B1B38
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 9/6/21 6:27 AM, Scott Weaver wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20210905222738.1050768-2-weaverjs@gmail.com">
      <pre class="moz-quote-pre" wrap="">When downloadfilename is defined in a recipe's SRC_URI and PREMIRRORS is also
defined using the same URI, the downloadfilename is appended to the mirror
URI and it should not be.

[YOCTO #13039]</pre>
    </blockquote>
    <p>As I commented in the bugzilla, I suppose it is an invalid bug.</p>
    <p> It save the tarball with the name of the value of
      downloadfilename rather than the basename of the url.<br>
      In this case, the name of tarball in the premirror downloads/
      directory is uthash-2.0.2.tar.gz rather than<br>
      2.0.2.tar.gz if the premirror is created by run bitbake do_fetch.
      So when premirror is used, it checks<br>
      uthash-2.0.2.tar.gz in the premirrors but not the original value
      '2.0.2.tar.gz'.<br>
    </p>
    With this patch, it fails to fetch the tarball from premirrors. It
    could be reproduced by config:<br>
    <br>
    BB_NO_NETWORK = &quot;1&quot;<br>
    BB_FETCH_PREMIRRORONLY = &quot;1&quot;<br>
    <br>
    Regards,<br>
    Kai<br>
    <blockquote type="cite" cite="mid:20210905222738.1050768-2-weaverjs@gmail.com">
      <pre class="moz-quote-pre" wrap="">

Signed-off-by: Scott Weaver <a class="moz-txt-link-rfc2396E" href="mailto:weaverjs@gmail.com">&lt;weaverjs@gmail.com&gt;</a>
---
 bitbake/lib/bb/fetch2/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 914fa5c024..47a4943369 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -466,7 +466,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
                     # Kill parameters, they make no sense for mirror tarballs
                     uri_decoded[5] = {}
                 elif ud.localpath and ud.method.supports_checksum(ud):
-                    basename = os.path.basename(ud.localpath)
+                    basename = os.path.basename(uri_decoded[loc])
                 if basename and not result_decoded[loc].endswith(basename):
                     result_decoded[loc] = os.path.join(result_decoded[loc], basename)
         else:
</pre>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">


</pre>
    </blockquote>
    <p><br>
    </p>
    <pre class="moz-signature" cols="72">-- 
Kai Kang
Wind River Linux</pre>
  </body>
</html>

--------------7A12874A189664DB7E3B1B38--
