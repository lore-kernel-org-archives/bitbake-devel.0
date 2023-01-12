Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95198C46467
	for <webhook@archiver.kernel.org>; Thu, 12 Jan 2023 02:41:44 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.45313.1673491298933413766
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 11 Jan 2023 18:41:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=hdm1oDYy;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=037638941c=randy.macleod@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30C2VV4j023276
	for <bitbake-devel@lists.openembedded.org>; Thu, 12 Jan 2023 02:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=content-type :
 message-id : date : subject : to : references : from : in-reply-to :
 mime-version; s=PPS06212021;
 bh=9vrAnGDLgrjUoA+v5QX3nbwy/nlzPPx3pAPZ/Ul37Fw=;
 b=hdm1oDYyxz/KvD2TOG68kUJuVRDHAifRctdHNFfiMGYJ4Hvo/E5duqeURw+InEq/SIRA
 WFVvgf+ZqCSw7E/7+zS1vM7dkA82Hqbsl896PkuquabmeoWuj+9ghCXZuu7muZi2bpHJ
 Uwa5Evzp+EkennivbopLSy/shYYRNOhko394pxNKIqB+DlwoFk4j8q5WOXqy9OnTfuqY
 Do4jaG4j8Sky2l4U+dxtdrNSwv9kbHJoTdXce0algWdtMmfoxTd9O4XmYGz1QC+pl0q9
 0jd/3Y4RjF/i3W8adQOFMAHY5BvsTVoJVyhphFVxAHktmYVn4xVcltogfilSjaWepHyz Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3n1k60gyed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 12 Jan 2023 02:41:38 +0000
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30C2fbl9013719
	for <bitbake-devel@lists.openembedded.org>; Thu, 12 Jan 2023 02:41:37 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3n1k60gyea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jan 2023 02:41:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c560Jy+50a0L1QRu4oFN/zRo1MNe7w/QDRyW8dq7QRVG/MqCuuqgXixaIfSb2LE7snDtuzHjOaAqXggiXrRsSXGLJx/ioyqYJrn53O0GlbTAhU4UAEtvhqk2AqvAZhAnA3tNlm1zACs03oJNIF0vQrfXzqeXyPlZ1kHTdaZl2zIAfhwKO9KTEMewGygHQtn0rYQwjMgVmz0L1cRSbkv/C5q3IpHwQLdkNf0rD3xcMOpJNvnPDmjOQnkD+cuteyBFit/QcFk/qzp1C+beoWN0dWD9PyNV+oE2LqQ+pFGJ1BJzMWU9JdZb6nKxtyYLpmyiektQ3vMizNpJk5nojUgfpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9vrAnGDLgrjUoA+v5QX3nbwy/nlzPPx3pAPZ/Ul37Fw=;
 b=VN/NQPF5vuB+bLZ26RfkoExKYhlhYmi4ajHtRduLWb2LpX+OAlQL4d7R27PaF+wBvAmgrG3eQkl68r5WhQGi61p2muDAQVXOAUtwgaIpcHSxpfO2/JdfoYrqs7ZanWNyimXW+aqrX0/Ok2QrUyJQ8fUbxhNJeT04VR/qIpxLZwpSIKQAO+4si7JgKfFKr4Xk+414VDUAiOaO/Lx44usbSw2xZR8qbN+gg55s72cFk4pF3+pZhWmuE9/EaUHw+vXa3GfBtllYF8Tp/i6l7p0N595jvUCM+IKEpgNTVGbjqVhDyEg6rrRVSXIB5iO0sjezPR65ypVYBsCAJ4QKUFa4nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB3994.namprd11.prod.outlook.com (2603:10b6:5:193::19)
 by CH0PR11MB5427.namprd11.prod.outlook.com (2603:10b6:610:d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 02:41:36 +0000
Received: from DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::e794:335f:5e0f:8d36]) by DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::e794:335f:5e0f:8d36%6]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 02:41:36 +0000
Content-Type: multipart/alternative;
 boundary="------------S0s5oKp8jZbJiKFQ05seavng"
Message-ID: <c957c661-c904-62f0-66ea-1bfab679ba25@windriver.com>
Date: Wed, 11 Jan 2023 21:41:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [bitbake-devel] [PATCH] persist_data: Handle sqlite error when
 cachefile path is too long
Content-Language: en-CA
To: yoann.congal@smile.fr, bitbake-devel@lists.openembedded.org
References: <20230111223729.3472181-1-yoann.congal@smile.fr>
From: Randy MacLeod <randy.macleod@windriver.com>
In-Reply-To: <20230111223729.3472181-1-yoann.congal@smile.fr>
X-ClientProxiedBy: SJ0PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::31) To DM6PR11MB3994.namprd11.prod.outlook.com
 (2603:10b6:5:193::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3994:EE_|CH0PR11MB5427:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c45a60b-0aae-4769-c484-08daf44685f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	n+N8+3WJ1f2xvqbxi0fdUJne69Ozq+Lwe20j1qwwLrC36bBsnhhPDTlqeSqI74Dugznc0lndqnxbtY9S+N1DYe3XixAQA6lNUEf5Wuvz/WlThcZLj93YB/AA1ZREglt06/ROmwuCLf4bpGrANxzewVTBLQYv+l9BrNYpIaB+grN1aO5tyaFQBv5K6J8IIKG0E896A0d9oYMH/5YmgaqUnReuvgTEd8qtWoVMRY6iNRhSloTHCWJRHhldtpLT9XelQoFyWuZ2zNauEKb5+FTjGor4BWPWtD8aFRoybKjcSSa9JYQHVySpHJdW/qPdB9rjNcOCixKVi0xjHfdSeD0a9RbgiPiZoKmaBumzd8gpTyDHFSD4e0XZFahW4vyOmDgmdBXdyzY5XQmOaCNeN/sS/wtB7/oD3ODCfRtm1WoY4QpyHiFvQDDEgv3jfIrneeap7gFZwbDhh82If2Nnz7EOigNN2tm38tY6DvYNVjrQBL8+tZC2cyZWBm5TVGs+m4Co5bThyHUkHR7sgUO63waIaRA2XtJdMF2uG2mKfOV+2bjwJ2YKEAjydnfOJJCYzOFG90ix2RlvB33WBnW9YW3f2X4fdEyb747dKttUQx7McLfCwvWSEijmNvt+mjNcniq8qnXhSL0mPLC+aJ8UQIs1+ouht4w8m3JMWlAMCba3SWz7/hXwsJ2yarO/v+LUjzkcgKt0yDSJsqjYBYnY35VyY/aWYr2WIl/UBSmjdQuyXP2y9qHpF4A82zwvYy+NbEWU796Ecdvo6+ZKtiY/QLYk83HC6CcmWMnWvbrrXZ4NATNTeOtG06rxJ1Y3BESHTUzW
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3994.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39850400004)(366004)(451199015)(83380400001)(31696002)(2906002)(5660300002)(8936002)(41300700001)(316002)(478600001)(53546011)(6506007)(8676002)(38100700002)(966005)(33964004)(186003)(6486002)(2616005)(66476007)(6512007)(26005)(86362001)(66946007)(6666004)(66556008)(66899015)(31686004)(166002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a0FrRmlRSnExUmxEU1JiUGFJUndDeHJhLzZEK0dUVlN6ZGJwT3Z5T3l0OE5m?=
 =?utf-8?B?R1paSUZ3R0huZElHVjRFY2V1YmNtUDB2UjJNQ0x4aXlWVk9PQ0ZzeW1KMVFu?=
 =?utf-8?B?UUo5bzBuOGVjYXFSamxQbkkzd2JKTlVLMnZZeVhMY2NXWWpkU3hPRDc1Mk9x?=
 =?utf-8?B?ZGkzMjgxS2JOUmZWZHJJaUlHUmo1U3VtUEQ1ZThQNTdESENWVnJaZmJRQ3pH?=
 =?utf-8?B?THd4d09ENG41UTB2V2RXYXJ6MmxqQVFvNEsreUZxcGV5M2FmNHEvMHByZ0FT?=
 =?utf-8?B?ZEs3d1FEQUFVTkV1YjF4WS8rUHkrM05DWk9hN2xkWTNVZXNpeUhzMDVtajZM?=
 =?utf-8?B?cllCSmRRV1hlK25TUUlaTzBOZS82Q05LUjdoM2pXcitPYUFHRHNNWjBiRjNF?=
 =?utf-8?B?WDNuUnp5UW54eGdSbWFnbXVaOTd0NnVvMEdjWURsSzA1S2NWOXpSdDFzWWJo?=
 =?utf-8?B?OFlteHhHOC93b0w3Um13YXZEcVpBeml5OFBaWDZLZUszenI2aStxUnFjRWNU?=
 =?utf-8?B?Vk1lNTQyNS9mVVhuV25yVDV6SUFValRjZnUxSzlRVm00aUk5ZFJMMXVLNVdG?=
 =?utf-8?B?aExoTTZEbUlhVVN0Z0ZZT1ZlYUZqTjJqVzYvVWwyVU9mbTJPZTJZYWpLS1Zj?=
 =?utf-8?B?eVIwQTlJbXBMZ2hYUnhQcTlWNFkvbEx2UDZxM1Z5TmVIamRKbDNhYytFT2t2?=
 =?utf-8?B?T0k0MVpPczJ3TjNqK0ptMjlvazRwY212bUNrdHdtbXc1WTFKbUczaGJUSVVG?=
 =?utf-8?B?VnBlNmdXRHNvMmlqVzNsVGQrRkM2aUQ0bWIreDRla3Nac2ZHTkZGbXNGSkRl?=
 =?utf-8?B?MjhFZlN4ZGptRDhkMTNQZGZkMnB2UElHNWU1UWw2TkZ1RTJuT01hV0JXSkVU?=
 =?utf-8?B?UDBIUWhVdlVDWFo5cjgwb1M3SWxaRys0cUZYVURiRHJTR1pZNllPT0hFQWFs?=
 =?utf-8?B?ZnlJQ3Y0cnFUUG0zM2sxRnFEZE1UQUtyYjVjbmh5N1FQZmF5T3diZGM4cG1Y?=
 =?utf-8?B?UW1IcTBRUHQrcGZJUWJTSGRvZHpVQ3R2N0Iwam1rNnErSEFERVQzRkk5VzFv?=
 =?utf-8?B?Tzl3a2RUU0QzdHFWckZ5YXF1eUNOUUxzSWlsaHVGVGgvSFJwWmlRcm9SUlN1?=
 =?utf-8?B?VHRDWVRrb3YvdkFOS2NTM2ZqeVFiejdRRVR2bjRueGFvQVpYcTdlZ3M5UFBD?=
 =?utf-8?B?RWEvcXZlK1Arc0pLUS9SL2lyOTRxUjJjQ3V4Tk04RHo4NjJXcFl0YmVhN2RZ?=
 =?utf-8?B?dTU0a01MWWJoNG9kUDIyaFg0L2lGL0lDeXY3SXlGbGZQbVptNDBMdUJKYmgy?=
 =?utf-8?B?SG1NVzdjbjdRNFJEY3BBdmtPdFYvMjViOEJkUXVlbFowTDlld1g4YVRlMzFQ?=
 =?utf-8?B?bTUzTG1qeEJFbmJGWldNUVN1TlVjMkd4bXE5Q2lpc2xsWXV3SHlBUDN4RG1Y?=
 =?utf-8?B?NVI2ZnZnWTdLMTh1UGw2dkd5elZFdmZkTmMxRGI1WGxzUmtXNGxjdm5YVmgr?=
 =?utf-8?B?YlJSMm5nZVkwTzVoZW1VcEJ2Ynk3b2tqWHdMM1M1M2xvYWZqSUZMRVpmT1Fx?=
 =?utf-8?B?ZlRseXIrWU5WcVgxWmxtRllVVmlkcHQxcnlSR3RERU5iQmwzS3IrOHhCOFFO?=
 =?utf-8?B?OEdYNWp2R0dCbTMxeU5rS3ViQVZyeXZlWm9mRmx0YXpTYWl3UjdFTnNWS0Vr?=
 =?utf-8?B?dU5aRU5ESHZUZm1vcS9oa09HUGpRRko0QURJQ3AzajY2bmdLcThqZUNKVkxC?=
 =?utf-8?B?YWNCaEVFb1puSGNERk9YZmY1RkEwbTZTa25JdDhCanNMTmJmOXpqWkdPQm5T?=
 =?utf-8?B?UUFrQVUvaVF0TXVSaTdRZVFaa0hoUHorOGdMdWIrZXJZUXlzdXdpdkNaWXJH?=
 =?utf-8?B?MytXL1plcVp3ZUEvQWdpb3pQRTFHbjBEMHhQczVMRXBtRXFZZ2k1eWlBYXRK?=
 =?utf-8?B?OWZoWHM1cEowU1lNRjQ2eEw0QkVTOHp0M294TjlPbVpNbHdpNldyZEFMay9I?=
 =?utf-8?B?WHoyZ3BEbzJsdlE5Vkg2eHIwSHJ3Y29vZDdXSlZHeUVOMytGWmF2RzVGMGxS?=
 =?utf-8?B?Nkhpa2wrQlB4eVJxNjlOUktsUURvZzdDLzljZ1VDenplSUpuRGN0M25xcDVM?=
 =?utf-8?B?VzA5dGtiT1dMYWpLcm5XSkw5SVFXNnNKN2tXM2RTNWp3TWtHLzlDWW9QN215?=
 =?utf-8?B?L1E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c45a60b-0aae-4769-c484-08daf44685f8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3994.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 02:41:36.0001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5EvQTzF5+dER3N9Krn5qD5g6RHBCKbwwO+TjZAinBIT+9DJfXiKFtfROj02dnkimiZtnR2DO1tPrHXOEb50MuaZZo4HQjaUS81IAMhJY/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5427
X-Proofpoint-ORIG-GUID: vmfXKUREcFu4osYH5BzM0Fo1BI15fQar
X-Proofpoint-GUID: aIP6938lNiH9wAQ8vMB9PlNHzqyl52td
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_10,2023-01-11_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 clxscore=1011 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120016
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 12 Jan 2023 02:41:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14306

--------------S0s5oKp8jZbJiKFQ05seavng
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-01-11 17:37, Yoann Congal via lists.openembedded.org wrote:
> Sqlite can't open the cachefile when its path is too long (>= 505 char by
> my tests).
>
> We do have a path length check in sanity.bbclass but this code is called
> before sanity checks.
>
> Treat the error in the exception instead of checking before hand in case
> sqlite eventually fixes this.

Nice.

Did you re-open the bug upstream to see if a
longer max path is acceptable this decade
&&
got a link to that?

../Randy

>
> Fixes [YOCTO #12374]
>
> Signed-off-by: Yoann Congal<yoann.congal@smile.fr>
> ---
>   lib/bb/persist_data.py | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
> index ce84a158..a027f912 100644
> --- a/lib/bb/persist_data.py
> +++ b/lib/bb/persist_data.py
> @@ -249,4 +249,20 @@ def persist(domain, d):
>   
>       bb.utils.mkdirhier(cachedir)
>       cachefile = os.path.join(cachedir, "bb_persist_data.sqlite3")
> -    return SQLTable(cachefile, domain)
> +
> +    try:
> +        return SQLTable(cachefile, domain)
> +    except sqlite3.OperationalError:
> +        # Sqlite fails to open database when its path is too long.
> +        # After testing, 504 is the biggest path length that can be opened by
> +        # sqlite.
> +        # Note: This code is called before sanity.bbclass and its path length
> +        # check
> +        max_len = 504
> +        if len(cachefile) > max_len:
> +            logger.critical("The path of the cache file is too long "
> +                    f"({len(cachefile)} chars > {max_len}) to be opened by sqlite! "
> +                    f"Your cache file is \"{cachefile}\"")
> +            sys.exit(1)
> +        else:
> +            raise
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14305):https://lists.openembedded.org/g/bitbake-devel/message/14305
> Mute This Topic:https://lists.openembedded.org/mt/96211174/3616765
> Group Owner:bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:https://lists.openembedded.org/g/bitbake-devel/unsub  [randy.macleod@windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

-- 
# Randy MacLeod
# Wind River Linux

--------------S0s5oKp8jZbJiKFQ05seavng
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2023-01-11 17:37, Yoann Congal via
      lists.openembedded.org wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20230111223729.3472181-1-yoann.congal@smile.fr">
      <pre class="moz-quote-pre" wrap="">Sqlite can't open the cachefile when its path is too long (&gt;= 505 char by
my tests).

We do have a path length check in sanity.bbclass but this code is called
before sanity checks.

Treat the error in the exception instead of checking before hand in case
sqlite eventually fixes this.</pre>
    </blockquote>
    <p>Nice. <br>
    </p>
    <p>Did you re-open the bug upstream to see if a<br>
      longer max path is acceptable this decade <br>
      &amp;&amp; <br>
      got a link to that?<br>
    </p>
    <p>../Randy<br>
    </p>
    <blockquote type="cite" cite="mid:20230111223729.3472181-1-yoann.congal@smile.fr">
      <pre class="moz-quote-pre" wrap="">

Fixes [YOCTO #12374]

Signed-off-by: Yoann Congal <a class="moz-txt-link-rfc2396E" href="mailto:yoann.congal@smile.fr">&lt;yoann.congal@smile.fr&gt;</a>
---
 lib/bb/persist_data.py | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/lib/bb/persist_data.py b/lib/bb/persist_data.py
index ce84a158..a027f912 100644
--- a/lib/bb/persist_data.py
+++ b/lib/bb/persist_data.py
@@ -249,4 +249,20 @@ def persist(domain, d):
 
     bb.utils.mkdirhier(cachedir)
     cachefile = os.path.join(cachedir, &quot;bb_persist_data.sqlite3&quot;)
-    return SQLTable(cachefile, domain)
+
+    try:
+        return SQLTable(cachefile, domain)
+    except sqlite3.OperationalError:
+        # Sqlite fails to open database when its path is too long.
+        # After testing, 504 is the biggest path length that can be opened by
+        # sqlite.
+        # Note: This code is called before sanity.bbclass and its path length
+        # check
+        max_len = 504
+        if len(cachefile) &gt; max_len:
+            logger.critical(&quot;The path of the cache file is too long &quot;
+                    f&quot;({len(cachefile)} chars &gt; {max_len}) to be opened by sqlite! &quot;
+                    f&quot;Your cache file is \&quot;{cachefile}\&quot;&quot;)
+            sys.exit(1)
+        else:
+            raise
</pre>
      <br>
      <fieldset class="moz-mime-attachment-header"></fieldset>
      <pre class="moz-quote-pre" wrap="">-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.
View/Reply Online (#14305): <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/message/14305">https://lists.openembedded.org/g/bitbake-devel/message/14305</a>
Mute This Topic: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/mt/96211174/3616765">https://lists.openembedded.org/mt/96211174/3616765</a>
Group Owner: <a class="moz-txt-link-abbreviated" href="mailto:bitbake-devel+owner@lists.openembedded.org">bitbake-devel+owner@lists.openembedded.org</a>
Unsubscribe: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/unsub">https://lists.openembedded.org/g/bitbake-devel/unsub</a> [<a class="moz-txt-link-abbreviated" href="mailto:randy.macleod@windriver.com">randy.macleod@windriver.com</a>]
-=-=-=-=-=-=-=-=-=-=-=-

</pre>
    </blockquote>
    <p><br>
    </p>
    <pre class="moz-signature" cols="72">-- 
# Randy MacLeod
# Wind River Linux</pre>
  </body>
</html>

--------------S0s5oKp8jZbJiKFQ05seavng--

