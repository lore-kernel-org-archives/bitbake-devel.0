Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E985C4829E
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 23:07:06 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.6087.1708038422980806889
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Feb 2024 15:07:03 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=T6STQfFl;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=277593d998=randy.macleod@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FLC6bk007611
	for <bitbake-devel@lists.openembedded.org>; Thu, 15 Feb 2024 23:07:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-type:message-id:date:subject:to:cc:references:from
	:in-reply-to:mime-version; s=PPS06212021; bh=GzS44asi6hC3JHEIIyH
	WGwHr5mQqSq/92CCcTMDp25Q=; b=T6STQfFlF1OVTnwwTNwH1DYBM2vaC7gf4kH
	FdfRnYEzQikU02yUt71ilTs84+eXxrcbx2Z7ct0gMKVzQL6kst7Qf53ew6onD48T
	YqSflk3o6cpsScBqBZMA0Z8J+Oc7akjcivIIkDr5D2IsVNDL+c6StQewZrJdWHOs
	gU9mNk5Hct4ZI/iyUpulpoIuGSOw3S6bzRAy8Ma5b8rCbM4zLcD8p9iG6DeoQA2J
	ZbuISywNX19IsAO50U//A5BEOuRmqEzsPjsixwRcmhUbJELml7tY343mXCJd3eQK
	pP2OnmjpACWx/HA05alVzVEYnV+fgLCrQR6uR+qAoj30w0ucEgw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3w6046wehg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 15 Feb 2024 23:07:01 +0000 (GMT)
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 41FN713R005963;
	Thu, 15 Feb 2024 23:07:01 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3w6046wehf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 23:07:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8RCZtTrGuGQ5Nde7opHzW2OYmDeNtHB4raYmeIi0PtmJXfboSvYv2VkyQQ7gsVwIvlJGsX6cTWYgxN206XelAm3ujKmO0ejY+lsShWhgbfWgRvEtY5Sd5AE0K8L0+YbeUqK04yliw5NDSUVplRUKv+6C4+Usef141P8jejGt77oHAVqOt1pE4M28UVDknFbMO1gVYGbnJOcjNuFlB9H7cYg9rHVQNVvqCOw7wWBHkTx9zyePqjFm53Xuss2J+N8EcophJqE5twBAYFYNE5PFW4kPKxOO1JvK7FYdp9Ndti7HOX3T2JaN99Wc/Y5DZbhickDf9ic1eCbcXh5X0llRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzS44asi6hC3JHEIIyHWGwHr5mQqSq/92CCcTMDp25Q=;
 b=C2yc8RooTwNpd7g1/OUKjSwd2YtqNZ1ibH2/0UiVeRCJn6qlkoh9+BZ+oq9OV7azmkVuV647ee4ujx3arAonnsO8otLDQyQEU95gBTHIcgpYo/6D8kyeW87kZBQf9eEPdSK9Qec7N6tezLe6bKtXxxuZPSBxMAzCxF5U9eoJD6Zw6xfONAeHlz4b0k86rXRd25q9h0CEbahRMxX3oVzfSAZVz+WwSdWTQKTxz2lJ5ex11NPzoVWVvNSFCGbK9LLxJwA9G+RvH4fmC7UkcMkU1EbKyxuCRVycBmiopxGgafBjPCxKBaOSDDqBrQwOuYHAyRtoVBHkWHeEBMdDtESyfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5920.namprd11.prod.outlook.com (2603:10b6:a03:42e::9)
 by MW4PR11MB8268.namprd11.prod.outlook.com (2603:10b6:303:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Thu, 15 Feb
 2024 23:06:57 +0000
Received: from SJ0PR11MB5920.namprd11.prod.outlook.com
 ([fe80::f3ba:ff33:12be:cff7]) by SJ0PR11MB5920.namprd11.prod.outlook.com
 ([fe80::f3ba:ff33:12be:cff7%7]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 23:06:57 +0000
Content-Type: multipart/alternative;
 boundary="------------3kK1ZjFenlYydLqpTx6Gi0rU"
Message-ID: <018990a0-3db0-41e6-b0f9-61e4c03407c8@windriver.com>
Date: Thu, 15 Feb 2024 18:06:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [2.0][PATCH 1/5] runqueue: fix PSI check
 calculation
Content-Language: en-CA
To: Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, steve@sakoman.com,
        Chen Qi <Qi.Chen@windriver.com>,
        Richard Purdie <richard.purdie@linuxfoundation.org>
References: <17964777D58C012A.3202@lists.openembedded.org>
 <CA+chaQc3jWaE0Bto1MQFf45bUVdY_8UvAb9N1vFM=A1-Q_RnGA@mail.gmail.com>
From: Randy MacLeod <randy.macleod@windriver.com>
In-Reply-To: <CA+chaQc3jWaE0Bto1MQFf45bUVdY_8UvAb9N1vFM=A1-Q_RnGA@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::28) To SJ0PR11MB5920.namprd11.prod.outlook.com
 (2603:10b6:a03:42e::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5920:EE_|MW4PR11MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ce3e3ba-e0e0-45f9-aef2-08dc2e7aceae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3+OMUoDt4NIxEjE1s+9S+kAiNCche/2QSIv7kkYwjbZ5295oyGBahYs76a+3IFWddGoSToFm56SVqlnrtBUkhuqgf5CdMUBYSCHXRZRAOVmHjKEiQx04axWCQWkQnzLCwslPLV8/LT1BNYMgZzYh9u039AcjnTOpqBT/qgR1FMiBgdMFJoxfMTk5ns3CjUy6leIXpRYKjEvdNM98oun7hDrQ23hW6f1oZyZY2wtl2SeJACJBz8tcbwhKPaOWqXAaUkuvI80Z2QZVSP/ciKBFzYZBom5TKglQsIqXFNPrM1MfvgsBQtZz+qETHbWd6b404gCWH3gcZyyfAvC89coH8bEHKBJQMIq3cWt/B2ABYSL9zIMhtKXFEjMUF3die689LYypZznCuyNQtrEgA8760hUKFPO0W4nv6kJr8q2e7aNp/IakE9znJ87k4fgid2P++ploi96oziO+ds2u0H7fw1E1V6FYTieHaJqahjPOUbG9OpvScIoX9zVYOoguj7cP8UUYl+nRv0GguEEStOPq4mcJVoqOFWjzCmD3CKmCdl7kmXgt+NTIZE7c+4WoYS5/
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5920.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39850400004)(376002)(366004)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(53546011)(166002)(31696002)(86362001)(40140700001)(36756003)(966005)(38100700002)(33964004)(478600001)(6506007)(316002)(41300700001)(6666004)(6512007)(54906003)(83380400001)(2616005)(26005)(6486002)(6916009)(8936002)(8676002)(5660300002)(66556008)(66476007)(4001150100001)(66946007)(31686004)(4326008)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?elF1aU8va1lyQkJXZnlHdUNWQk8rMVhQb1BDbTFuZ25rV1JvY2lXSEhRMGwx?=
 =?utf-8?B?N3pRajF5aWpsTjVsdnVTenZNaUsvTUtlbFVPOU1LRE9OOU9iN2ljalY2dVdF?=
 =?utf-8?B?VHZEQmxMcklqTlhiblFxM3JIc1ZzOEw5eURUYnZMYWRPNFZSSmU4ZG03SEtK?=
 =?utf-8?B?SEhLVUQ3NEVud3lOV1UrTXZMNmdndDBEejlleGJ6NmxWUWkrVDNPNVZ6elpW?=
 =?utf-8?B?Z1ZJN2gzMzZVL0k3K00rbkp6ZDRuVXFNOThiRStGRXEzL05iYitSVUxCSlgv?=
 =?utf-8?B?RmE1eWRTd3hUeFVPTVBrT2lXQ21BVnYxZ2VyTks5bWN4VWw4SUVESDhEUFNN?=
 =?utf-8?B?RnlPb2NFQVM4RC92elNCNXFqbGxMSUFzUzF3YzVhRS85di80akRkWlQxQkgr?=
 =?utf-8?B?eFY5T01Yc2tuSWNWK1ppWE5vcTVYOWJYZmM5S2c5Q3FqMGNWKytOaXpDMzlM?=
 =?utf-8?B?aE9ieHBpNWwxN2hEcnZ6RkZiaGkzaFVEMXFJRU9ENS9TNlIrSUNYVEJXMnNG?=
 =?utf-8?B?SWgvWXIrVk1RcWtLNjRBNEdtdWNTbDdwMS9wUEpqaFJId2xvL3gybnNValVX?=
 =?utf-8?B?NlZyck11NEtydXdKejJPbjR1TjRjc0w1VW04TWdZU1N6bytqZGF2U3MvWTN6?=
 =?utf-8?B?eklCNWx0OHpIS0ZubEJ2Tlk2VUxyckQ5ZEFpSUZ0NXlyMnpiVUZqQTR3RFI5?=
 =?utf-8?B?UE8yNng1MXR0SFhJVVlqUWp0UlpFMXV5YUl5TDZxcUFOZFNOcVpkV21sYTJ0?=
 =?utf-8?B?VUh3TGlBZmJ3QkVMSjBZcHhCenJLMmlzajVjUVpXNDhPQWNDaTdUQjF5K1pt?=
 =?utf-8?B?OWZDelJyWlJkd21GUFgrRjBpTmdoOE5hQngra2xGelNycjQ5blJWdUVsd0NG?=
 =?utf-8?B?NnpQNTBta0hlcVJLTCtjOWVvNTF2cWtRMDFUWkNqVnJBOEFUaVIwT1BiakhE?=
 =?utf-8?B?NVhVUXRLT1RJMUdlcXZSZ00vdFVLdTFiQTlCRzdmS1hQeElhdzJDL0JlVUFX?=
 =?utf-8?B?VDNLcEI0bVVxWTdIMVNlRlhKenZ1NklmYmNCMzN5M0JMNks4V0ZNZkxxUkJv?=
 =?utf-8?B?Z2Q1MHJYT0I3enliOGxRa3VKOE5UNkYvS2tTSEJhRm9PSUpITzJSUElkSXNP?=
 =?utf-8?B?TGtJMWlTSjFFUXpuaG9IMUVVMGc3REpZRDZvQ2hmVVVCMTl5bk01NEZ1dXFW?=
 =?utf-8?B?eWs2ZVlHQ2F6OHM2TjUySUhOSU5DM1F4aG11QlArNUMybFpScnR0MHpQM2lq?=
 =?utf-8?B?eGFRZ2FhR0pHNkdKdjZ6QkZqMUVBSDRVUVl1dk5wTjl1T0NpR2ZBRjdUYXFE?=
 =?utf-8?B?Mk40RFlUR2U2bTd6MThKOWQrSHV0bHcvVFJVbUZ5QjBabG51NE5pa0VuNzJ0?=
 =?utf-8?B?WG00RDVPRytQa0pQaWlrV25RWG4vUFNGRDJMbS9kUnJMNFFod0dkVG1uYlZF?=
 =?utf-8?B?ZWlKeTVHazBWTDl6MVlhcUZNMjllV1pnbUZrMzhXcS8yN3c0RlpuazlCRzE4?=
 =?utf-8?B?Nkd0UkZrMkNXM2lGRSthbTRPa3JlbFVHMHhIejQraGhvRkRzU0gyWGFzYzhZ?=
 =?utf-8?B?K2tZNldSQ0dtcjBXREpVTEdsVGJhVEVDY1cyTTNRZ0JyWXk5aE5XbHgrSDBQ?=
 =?utf-8?B?d2lCd3FrNEliRithUElNQko4Rkhkb01wRGQ1OXhLVCtZTFZYVkJFRlJqRkR2?=
 =?utf-8?B?MTNGUVJLME1WVU1MQWk2MFNLVitYRDRpc044cHJvMFJIcmlpY01JZUtFWVZr?=
 =?utf-8?B?QTBSTis1bzlsdmk0U0ZFb21uUCtJYnVVL0p3dWdhTzYyOEptcjF6eDJ3aHRD?=
 =?utf-8?B?ZWZGMVJsckdPZGhzdWdpdndBU0wwaVpXSC9zd0l3REczSlc3eWtPaDVOc2ZW?=
 =?utf-8?B?MVBGVkhkdVIrUm1Ja2tRVVltalRySzhEdEJxK0srWWVPamJsbmtsT3JqREs4?=
 =?utf-8?B?bEQrR2VlbStySW1NZkx2MHVBQmwwWWRiakwycTVNOEpRSkZrZ0NGcjFWaWhn?=
 =?utf-8?B?eXRiWjBhU2FISkkyZkJ0TjZablZxblpnSm9vcEhHRzZNTk16RzJYblVtMHBN?=
 =?utf-8?B?SHA5YlV0ME9kYmZQd1JGMFVKdUY5Wi9zVUhBM0tsWGZ6ZTRYYWdralpmVSth?=
 =?utf-8?B?MTVhTUc1VTk3NElBRUJXcnZPR0lZWEVTeGEvRjRoSFIyZllOV0tobGFLK0FK?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce3e3ba-e0e0-45f9-aef2-08dc2e7aceae
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5920.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 23:06:57.1243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMJ1eplajLtz5mCBtgDq+lnxpCDSQPFMObDdRkjR7wY1XspGghalzbE0lDOlIUY3ly8i769CeXLnRwx1XhF8fLFQCejg7QtOPgoReb3gIjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8268
X-Proofpoint-ORIG-GUID: V5iaLS4JWbjh_i4dtU-DG6KaSTaVCy0Z
X-Proofpoint-GUID: J_wHFXGr8x3GnZQQMp9BhkTiIJUVHVGQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_22,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402150180
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Feb 2024 23:07:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15904

--------------3kK1ZjFenlYydLqpTx6Gi0rU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 41FLC6bk007611

On 2023-11-10 9:06 a.m., Martin Jansa wrote:
> I forgot to include [RFC] tag in the subject, because these changes=20
> might be a bit controversial.
>
> From my testing:
> https://github.com/shr-project/test-oe-build-time/commit/d5111f4472ac39=
7c0f1197eb6366ac7d2e56453f=20
> <https://urldefense.com/v3/__https://github.com/shr-project/test-oe-bui=
ld-time/commit/d5111f4472ac397c0f1197eb6366ac7d2e56453f__;!!AjveYdw8EvQ!f=
35PVorsjRHzPeCdLVCittHJcXcQTibeF0q5nqa0CcWnxVr6Zdu3-DT7IpTT6Q1miq7Pyxk8DD=
BJq1Nij5jI1m3znH8$>
> the reasonable pressure values for 2.0 (in kirkstone) and 2.6 (in=20
> nanbield) are significantly different due to these changes in PSI=20
> calculation and logic so while 1000 was reasonable value for my system=20
> in 2.0, I need 100000 with 2.6.
>
> I've backported these changes long time ago for my local builds to use=20
> the same PSI values for all builds.
>
> And the controversy is that backporting these will change the expected=20
> values (so kind of change in behavior which might not be suitable for=20
> stable release). But the commits make it sound as a bug in the logic,=20
> so we can also consider them as bug fixes.
>
> The change in expected pressure values was reported in:
> https://lists.openembedded.org/g/bitbake-devel/message/14942=20
> <https://urldefense.com/v3/__https://lists.openembedded.org/g/bitbake-d=
evel/message/14942__;!!AjveYdw8EvQ!f35PVorsjRHzPeCdLVCittHJcXcQTibeF0q5nq=
a0CcWnxVr6Zdu3-DT7IpTT6Q1miq7Pyxk8DDBJq1Nij5jICLP93rQ$>
>
> If it's not a bug to be fixed in 2.0 then maybe we should mention=20
> different PSI values in release notes for nanbield (I know I'm too=20
> late for that).
>
> Regards,

So people were suggesting that the slow YP AB times might be due to PSI=20
regulation.

On a 24 core system, I built core-image-minimal with the original code
from before Chen's commit in August 2023

poky.git
$ git log --oneline -2 653ff4d85cbaf53627f7978b06c1f025ac4694e2
653ff4d85c bitbake: runqueue.py: fix PSI check logic
ac5512b0ac bitbake: fetch2: add Google Cloud Platform (GCP) fetcher=C2=A0=
=C2=A0=C2=A0=20
<---- Old


and with current master ~ Feb 2024 :

$ git log --oneline -2
9382d731bd bash: nativesdk-bash does not provide /bin/bash so don't=20
claim to <----- New
0fe85ce0c6 busybox: Explicitly specify tty device for serial consoles

Note that the source being build is different and it would have been=20
better to just change the
pressure regulaiton code but this was a weekend 'fun' project. Also, yes=20
I fetched the code before
building with the set of BB_PRESSURE_MAX_CPU values.

There wasn't much of a difference as shown in the graph and data below.

I could try the same thing for world builds but I'm not sure that's=20
worthwhile.
I still plan to construct a test of PSI regulation using some -native=20
recipes that invoke stress-ng
enough to cause sustained (CPU or IO) pressure and then test if a new=20
task will ALWAYS be prevented
from running until the pressure subsides.

../Randy


yocto/psi/feb-2024
=E2=9C=A6 =E2=9D=AF cat old.dat
100000, 82.7167
10000, 83.1833
8000, 83.4333
4000, 84.9833
2500, 88.2833
2000, 91.4
1500, 99.3667
1250, 107.6167
1000, 117.9667
750, 149.2333

yocto/psi/feb-2024
=E2=9C=A6 =E2=9D=AF cat new.dat
100000, 81.6833
10000, 83.25
5000, 83.9167
4000, 84.1167
2500, 87.65
2000, 90.6833
1500, 97.5833
1000, 120.6833
500, 194.1333
250, 213.3333

Steps:

$ bitbake --runall fetch core-image-minimal; sync; sleep 10

$ for i in 100000 10000 5000 4000 2500 2000 1500 1000 500 250 ; do \
 =C2=A0=C2=A0=C2=A0 rm -rf sstate-cache/ cache tmp; sleep 2; \

 =C2=A0=C2=A0 echo BB_PRESSURE_MAX_CPU=3D\"$i\" >> conf/local.conf; \

 =C2=A0=C2=A0 /usr/bin/time time -o time-$i.log=C2=A0 bitbake core-image-=
minimal; \

done


--=20
# Randy MacLeod
# Wind River Linux

--------------3kK1ZjFenlYydLqpTx6Gi0rU
Content-Type: multipart/related;
 boundary="------------fi8m0Upo8KgihDZkpbQ4OD2y"

--------------fi8m0Upo8KgihDZkpbQ4OD2y
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 41FLC6bk007611

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">On 2023-11-10 9:06 a.m., Martin Jansa
      wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:CA+chaQc3jWaE0Bto1MQFf45bUVdY_8=
UvAb9N1vFM=3DA1-Q_RnGA@mail.gmail.com">
     =20
      <div dir=3D"ltr">I forgot to include [RFC] tag in the subject,
        because these changes might be a bit controversial.
        <div><br>
        </div>
        <div>From my testing:</div>
        <div><a href=3D"https://urldefense.com/v3/__https://github.com/sh=
r-project/test-oe-build-time/commit/d5111f4472ac397c0f1197eb6366ac7d2e564=
53f__;!!AjveYdw8EvQ!f35PVorsjRHzPeCdLVCittHJcXcQTibeF0q5nqa0CcWnxVr6Zdu3-=
DT7IpTT6Q1miq7Pyxk8DDBJq1Nij5jI1m3znH8$" moz-do-not-send=3D"true">https:/=
/github.com/shr-project/test-oe-build-time/commit/d5111f4472ac397c0f1197e=
b6366ac7d2e56453f</a></div>
        <div>the reasonable pressure values for 2.0 (in kirkstone) and
          2.6 (in nanbield) are significantly different due to these
          changes in PSI calculation and logic so while 1000 was
          reasonable value for my system in 2.0, I need 100000 with 2.6.<=
/div>
        <div><br>
        </div>
        <div>I've backported these changes long time ago for my local
          builds to use the same PSI values for all builds.</div>
        <div><br>
        </div>
        <div>And the controversy is that backporting these will change
          the expected values (so kind of change in behavior which might
          not be suitable for stable release). But the commits make it
          sound as a bug in the logic, so we can also consider them as
          bug fixes.</div>
        <div><br>
        </div>
        <div>The change in expected pressure values was reported in:</div=
>
        <div><a href=3D"https://urldefense.com/v3/__https://lists.openemb=
edded.org/g/bitbake-devel/message/14942__;!!AjveYdw8EvQ!f35PVorsjRHzPeCdL=
VCittHJcXcQTibeF0q5nqa0CcWnxVr6Zdu3-DT7IpTT6Q1miq7Pyxk8DDBJq1Nij5jICLP93r=
Q$" moz-do-not-send=3D"true">https://lists.openembedded.org/g/bitbake-dev=
el/message/14942</a><br>
        </div>
        <div><br>
        </div>
        <div>If it's not a bug to be fixed in 2.0 then maybe we should
          mention different PSI values in release notes for nanbield (I
          know I'm too late for that).</div>
        <div><br>
        </div>
        <div>Regards,</div>
      </div>
    </blockquote>
    <p>So people were suggesting that the slow YP AB times might be due
      to PSI regulation.<br>
      <br>
      On a 24 core system, I built core-image-minimal with the original
      code <br>
      from before Chen's commit in August 2023 <br>
    </p>
    <p>poky.git<br>
      $ git log --oneline -2 653ff4d85cbaf53627f7978b06c1f025ac4694e2<br>
      653ff4d85c bitbake: runqueue.py: fix PSI check logic <br>
      ac5512b0ac bitbake: fetch2: add Google Cloud Platform (GCP)
      fetcher&nbsp;&nbsp;&nbsp; &lt;---- Old<br>
    </p>
    <p><br>
    </p>
    <p>and with current master ~ Feb 2024 :</p>
    <p>$ git log --oneline -2 <br>
      9382d731bd bash: nativesdk-bash does not provide /bin/bash so
      don't claim to &lt;----- New<br>
      0fe85ce0c6 busybox: Explicitly specify tty device for serial
      consoles <br>
    </p>
    <p>Note that the source being build is different and it would have
      been better to just change the<br>
      pressure regulaiton code but this was a weekend 'fun' project.
      Also, yes I fetched the code before<br>
      building with the set of BB_PRESSURE_MAX_CPU values.<br>
    </p>
    <p>There wasn't much of a difference as shown in the graph and data
      below.</p>
    <p>I could try the same thing for world builds but I'm not sure
      that's worthwhile.<br>
      I still plan to construct a test of PSI regulation using some
      -native recipes that invoke stress-ng<br>
      enough to cause sustained (CPU or IO) pressure and then test if a
      new task will ALWAYS be prevented<br>
      from running until the pressure subsides. <br>
    </p>
    <p>../Randy<br>
    </p>
    <p><img src=3D"cid:part1.d2yjlijU.VeJKLihK@windriver.com" alt=3D""></=
p>
    <p><br>
    </p>
    <p>yocto/psi/feb-2024 <br>
      =E2=9C=A6 =E2=9D=AF cat old.dat <br>
      100000, 82.7167<br>
      10000, 83.1833<br>
      8000, 83.4333<br>
      4000, 84.9833<br>
      2500, 88.2833<br>
      2000, 91.4<br>
      1500, 99.3667<br>
      1250, 107.6167<br>
      1000, 117.9667<br>
      750, 149.2333<br>
      <br>
      yocto/psi/feb-2024 <br>
      =E2=9C=A6 =E2=9D=AF cat new.dat <br>
      100000, 81.6833<br>
      10000, 83.25<br>
      5000, 83.9167<br>
      4000, 84.1167<br>
      2500, 87.65<br>
      2000, 90.6833<br>
      1500, 97.5833<br>
      1000, 120.6833<br>
      500, 194.1333<br>
      250, 213.3333</p>
    <p>Steps:<br>
    </p>
    <p>$ bitbake --runall fetch core-image-minimal; sync; sleep 10<br>
    </p>
    <p>$ for i in 100000 10000 5000 4000 2500 2000 1500 1000 500 250 ;
      do \<br>
      &nbsp;&nbsp;&nbsp; rm -rf sstate-cache/ cache tmp; sleep 2; \</p>
    <p>&nbsp;&nbsp; echo BB_PRESSURE_MAX_CPU=3D\&quot;$i\&quot; &gt;&gt; =
conf/local.conf; \</p>
    <p>&nbsp;&nbsp; /usr/bin/time time -o time-$i.log&nbsp; bitbake&nbsp;
      core-image-minimal; \</p>
    <p>done</p>
    <p><br>
    </p>
    <pre class=3D"moz-signature" cols=3D"72">--=20
# Randy MacLeod
# Wind River Linux</pre>
  </body>
</html>
--------------fi8m0Upo8KgihDZkpbQ4OD2y
Content-Type: image/png; name="HFmTHJTOoDp5MXqn.png"
Content-Disposition: inline; filename="HFmTHJTOoDp5MXqn.png"
Content-Id: <part1.d2yjlijU.VeJKLihK@windriver.com>
Content-Transfer-Encoding: base64

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

--------------fi8m0Upo8KgihDZkpbQ4OD2y--

--------------3kK1ZjFenlYydLqpTx6Gi0rU--

