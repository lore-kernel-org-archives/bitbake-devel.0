Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE12C3DA41
	for <webhook@archiver.kernel.org>; Thu, 11 Jul 2024 01:39:27 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.2440.1720661964809063174
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jul 2024 18:39:25 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=79224067da=changqing.li@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AMCsWT022062
	for <bitbake-devel@lists.openembedded.org>; Thu, 11 Jul 2024 01:39:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 406u4x4f1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 11 Jul 2024 01:39:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIhIzLwBAd3wc627uXWSP1KUyim3q3ugTKcwryNuis0+Z6Z44s3s3Ng/tjarlTxEwocYfmgjAg+6m/o3csa1hYmmIFEIV6k3eUVpQeWQdfSdcx4KcB0IjUHumFIzqU/B2oDGUO5lyG883Y8oUnLYolfKYgReYp9foF1ExdN7oeg7EbJLpA3g4ag53fwLGYJB0f2D1d3RpKSko/d7VOq8MCQ6IQS17iP5eqPGbbrlDz+kW+ICqSnTSSsTa1mICArargWbB8/Kp3Z8w7gUwMCqdCWZBD+jB0/l+kdnez+6dI7y6I3+Z16H246c/UhpJhxKCt53e4JaoZrW3f+9AzsLAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FO/1Dhm2jh9GG4KnVPwMkQ54r+NT5Gwhl+9q/2qSBA=;
 b=Ctbi9HJNG3tGZ5MDgVE1Ebixj2/WhMgZORj+6Qbq61D42jX39xqTCH5ofqrFCNhXdwmiiu90VCZf0/O4K9MWI1tFeLtA/Z0jxEcuXM/Ht8bZLF+iK+G0Kd5fKA5IXcrPsxrfvAFqek+tFkTBR++PsDLH3Dg9y9moBFwy91RIRkjIN0VaBX36fLdoQRrIYkuECRRamaj8rxfJmsgEMuwKxfCTeMQ8vE3u9JMOi61rCijMFG6qs8vp+NO4LbmZEBnYlAowkhfys2RkMP6GjtY45lfuPNJ059sqmeInLb0I9djNUlG3qa3GdEnIH3EpbvtqwEIwzsBYoyYSriMRlWt/tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by SA1PR11MB8544.namprd11.prod.outlook.com (2603:10b6:806:3a3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Thu, 11 Jul
 2024 01:39:20 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c%4]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 01:39:19 +0000
Content-Type: multipart/alternative;
 boundary="------------gRtLsQLcPbjjx9R0Az4V4mOq"
Message-ID: <f5f8592c-bd73-4869-a07d-67f2834dac8c@windriver.com>
Date: Thu, 11 Jul 2024 09:39:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] bitbake-worker: skipping disable network
 when unprivileged userns is restricted
To: bitbake-devel@lists.openembedded.org
References: <20240708081034.1474312-1-changqing.li@windriver.com>
 <CANNYZj9+c=BQ_zH5vXM35s2Sw=KTRiieprn4TNcWvOXY4xXV4Q@mail.gmail.com>
 <0032b64c-7e46-dc46-d6e1-143ae3fef03b@windriver.com>
 <CANNYZj-VrBHoqGK3fzTxZLwPB3CiuhQT4azQrt=Wcw=qRsnO-Q@mail.gmail.com>
 <5a5820df-602f-4e9c-a0f4-a7982cf76927@windriver.com>
 <ef64c37a7fa679d58d34dc3fa31020788bc308f2.camel@linuxfoundation.org>
 <17E0BC4E4EBC9777.21385@lists.openembedded.org>
Content-Language: en-US
From: Changqing Li <changqing.li@windriver.com>
In-Reply-To: <17E0BC4E4EBC9777.21385@lists.openembedded.org>
X-ClientProxiedBy: TYCPR01CA0185.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::11) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|SA1PR11MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: fb007ad0-5973-48db-0c7a-08dca14a488a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|4022899009|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YXV2TnlNY2J0SGl4Y3cwREE1Slpid3BxVmk3ai94WGxCRWozelpNUlFEeDZK?=
 =?utf-8?B?eGdZTjV0bWN2YTY5dE93ME02Q2Q2b3hjL2M0R1YwbzNaZVVBRjFjSTBhZG5j?=
 =?utf-8?B?VWp2aXdKbmhHM1pwRGZyYm5uSzVmZ1Q5OEdWbEdrQzg4Ni84RE1IY2syWXNi?=
 =?utf-8?B?N1R5YkFTOHRXNENUMkxWL1duUEFjODRWZG1RZ2FOb1BPQlRPTFZteEVxSVo2?=
 =?utf-8?B?T3ZLQUl2cUNJUThHN3M4bGdPU2Z3UEYyeDVVVGVMZmsxci9IT25Ba1pXZ0NO?=
 =?utf-8?B?b3BMRG9lUk9pTG5Wc0V2UFBtWERFd0J0OFFOZmF6LzJDVzlhQXc1UFZpV2xq?=
 =?utf-8?B?N3J3OENYQ3RrUGpGRFpCSlVlYkVsbWYyTlQ4L1VYbS9raUxWeXEzaitGNDdw?=
 =?utf-8?B?aExkM092bTBaczgvZ0lzSTV6N01XVUprN0dwUk8rMXZ3OFVVTExHMEsya1dZ?=
 =?utf-8?B?NUxySjRkNitQeXRGK1hwN3o4angyUnJkSEl0bEdvaEpmQkQxVnNMd0toVHM4?=
 =?utf-8?B?UVEvZy9BVnVnS2pkM2VpYm85aHJ6dEoxSml2RDJNMForZmo3Tit1Mzhvcndn?=
 =?utf-8?B?dUhUVjdBWGJWRTd0MXhwaHlVME1YMEd3UXJqeGZKc1JJRjMwQmkwdmFnVWpG?=
 =?utf-8?B?b0h1cWtrYnBwbGw0d3JPQXZ0M2RndDdqLzJhTjBzMDYwNjF1dnhPOCs5V212?=
 =?utf-8?B?TFpKdWRsbzRKdXpYQ1FHeEFkMWdtb2JPdm5qcTQzNTN6c3I2RXF4UVQ5Q3JE?=
 =?utf-8?B?dnpmTnhaWFQ3ZGM2NHg2THI2S1h2Rm1xREw2enROVmJUU0RFbnRRRmdaRkMr?=
 =?utf-8?B?Y0hsd2hjVFJGZ1JoajJ2Mk42NzJ0b204T2lqYVl4VmRKaTVPYWJJWHpjd2ZQ?=
 =?utf-8?B?dHFOdHdiN0E1VEhYUWUvelV6c25CN0IzU3I1T1ppVWV3UEt2ekxhZE1PQXUw?=
 =?utf-8?B?U3hOUmhlTUsvZ0xnYXA1aG5oVUN1cVZhYkhKNkhYWjJTWXVadEJtMVBJTWJE?=
 =?utf-8?B?Z1Y5VkRtdXdncjZtWkpQcnU1NmdpTmtlRXMydDhQNEVrL2pVcGkzM05tcTNw?=
 =?utf-8?B?RytzMFl2Tzh5V1Z0cENhL1dYWDNEdjQ0QldueWFjeHpoVVUxUHpaTDkxYWhj?=
 =?utf-8?B?Zld0OXM5S0JrZjdaZ0UxcjdUMFVLeHFBZS9tWTVpRU5WVnIrcDJJQjM0dHdO?=
 =?utf-8?B?Ykc5eFFMTkE5KzRNV3dXSkF2TE9pMGUxSDdWekVMUklNQW0zOVh5UVpaYi85?=
 =?utf-8?B?M2RjdG9IYXJrSVJLTld4SVozMjBuZVA4ZXptYUZuSXhRNDV6VEtMeFZGTThX?=
 =?utf-8?B?Tm9saVhPeUphL1lTdEpGNEtQcmlvZU41K3FtMXdRa05iWXdJUDEzd3JDN0Rx?=
 =?utf-8?B?U1QvMTIybGIwRVA2Mm9nLzkvdWpqdG54UTZoZFY0N3FlTGN0MjBnakM4K25q?=
 =?utf-8?B?UHBSQlVHcnhaR2srMGJZVmhyUmVxM3Z5WnZoOWR3ZU9rZjdhdEg3TjVkYmtv?=
 =?utf-8?B?Z2NXWjB3S3BDZ0FJU0ZkOC93ZlptN1lrT01hdUZibEQ2d3lIYVhTRGdFVCsx?=
 =?utf-8?B?R3duK0ZaVytOaUIwcmU4b21SZVZ1TXR6TEdrZGdtOXZmMUMzeGM4UE91Vmw4?=
 =?utf-8?B?bU13TWJFTTkxdWlEZzB6dmZFR0g4WkhUaUV6MTJiRUVIV3FXaDlHcGdKTmN6?=
 =?utf-8?B?SWpSL3hXSGQ4emVHbG5ZUWVuL3lFQThLZ1BmRmtzeFNFTWVtcVh4TWRMeURj?=
 =?utf-8?Q?Ox77wYvvlY14q4CiNs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(4022899009)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N0RsdlZsVzl1MGpjY0ZPRzYrSzBFRVlIZXhzRWFKN041QjdQTkNMWUtRQ3ZF?=
 =?utf-8?B?eFd6ck5QTzh1S1picWFzSGY5bHdBQlcwdDNkd0tZRDcrRldZNlQ1OWdaTk1Y?=
 =?utf-8?B?WWlKbUdHekFQRFJTK1RDc3VNbkZZUHhSNTVSYTlLQ2RCTFI4R0dlUUdUdndh?=
 =?utf-8?B?eUhDYlVvVjZPcTlmUUZhVGtTd3oyTTlpRFd6clZxem1WK2pFaFF3Q3Q4eHJH?=
 =?utf-8?B?dXRqMURxdWluYzErQ2RBcWtIUXpCLzNBVEx0MGQrdWVtaUtNdnRFWGNNNCtw?=
 =?utf-8?B?Q0s0RWxhYWhRRDNxK2MwamtTdGs1MWQ2NGNNdTgyQXF2RWNiek1wN1IrblYv?=
 =?utf-8?B?KzVxY2UyTFRaYjlvUjY0ZGN1akF1Y2tTVVhKaWZibUdXb3pTSkFDcjNJQkpP?=
 =?utf-8?B?cjB2aWRBQWswbERxb1dlcHVubWZaeklPUGlyRWZJcG5WN0M5Q1ZNUkxjeVZ2?=
 =?utf-8?B?RjVqR25MUFNHWWx2c3VWcllrd0tJcjJlRC9PQXhWR1ovaFhsamRWM2pIU0pO?=
 =?utf-8?B?VzRHNEYrLzE1NlUxMHlWYWRpRCs5SnRxMlFNdkpIeFc1bS9icWFoNDZqeGky?=
 =?utf-8?B?SWlMZTBwVzNLSzVoYllLY1pmekwrdFRhT1Q2dFdtaWpKS3hpYUlueUppbXFu?=
 =?utf-8?B?bHlBelkwRFlJaVJvNWhMcUYrU3dSNHhwdjNBK3FGck5Ub1hDVG1kNkFrTURT?=
 =?utf-8?B?dzEvcStTaVlzTTdkRXBZWjgvQW4zdHNzZDVHY0NkeTJiOFBtQ1hScVd5Rkk5?=
 =?utf-8?B?TVlBRjhpRzhqR2d3VlRERmZpcEQ3SUc5WlF3bXlUNitPVWtBQzRaejMxS2Yr?=
 =?utf-8?B?WWcxMkxqcmx2azdBVDMrR3dSWVJHWGI5cUhtRzBzZkFzOFowd2J6K3NvcUVh?=
 =?utf-8?B?QmdUcHAybURIUGNhV2hlRzNUTnhFcmFQWWRsaGN4RDZJc0dqeDhOUzRZdVFs?=
 =?utf-8?B?elpIajA5OW1mTWs2eDV3TDBzRkVxdE45RDl6RklKcExDVUpmOE0weGx0ZlMw?=
 =?utf-8?B?R2JZbTdqZURsTE1xK3BQVUZsdVoxQm16SmVYSnA5Uml6RVZKcGtscHJLR3lW?=
 =?utf-8?B?YVNFRzNmUGNFN2NuSjVVVnJRdmtEdjV6d0JIc1ZPTUthUFlkMTI1eHVKTEhI?=
 =?utf-8?B?OGFRL0Z1ejNKVG10d1V3dENuY1QzaVhodExoczk2a09Mbi9NNWw3Z1Z5T0E4?=
 =?utf-8?B?THQ0TDEzZTJ3eFJUQ1hQdHpmS2lvamVlVmpheVdMcTBUdm9XeGU1dWxLK045?=
 =?utf-8?B?MktDN3Q4VFFKa2dFNTQ5VFhXdDJ5NE5wZWRNY2p2NFRvTkd2cSs3dUhCOS9x?=
 =?utf-8?B?YmlrVTdBOUtaa2tVOWdzU1Q5S29HaVArYWVWeFNGNjltb21aM0ZYWUcwRjlp?=
 =?utf-8?B?OFIxVUcvR20wTFVqR2lOUmhtQ1JUa1ltR2p5RkhtdkRPbmROVU9OUXhlV28w?=
 =?utf-8?B?Wk5Da0MwQVFFcWhqdno2VVNOSDlrWGlDOXlxSTY3emNDMUUwbXU3NXM3TTda?=
 =?utf-8?B?MkF2cEY2YndzdGRydEJYeTNQdkpMcGtwazZuK1IwcUxEaVI5azY3M3NNR2hP?=
 =?utf-8?B?cis0WjJjZitPdDBrM1JQZGVmRzZuVE1yY1lyQWp0MGRNMHJwTFREelIzOEN6?=
 =?utf-8?B?MTlBcFZxa3grcDJaYVVzVHlIcHNEVHM2bGVKRTJTcmNieldyWGhwa25OVWRE?=
 =?utf-8?B?SkJtUVVGUU5zVHpzZWxHQVllb2hPMm5MdVJnY0V3RHBSWmNMUmNYazVNU3Mr?=
 =?utf-8?B?OERZZTdEdUlEWC90Qm12UzFGbDZZemlzNU1hWm8wWVUrQUlVUTZFZHBYbUQ0?=
 =?utf-8?B?bTk4a2tHMVZYUU5sSVFyR2Z6M09TVVA2bWJjU2ZjZjMzeVI2TVpWT1hnRkw5?=
 =?utf-8?B?amFtVEczZkxVWkpUckdtQ3UzUmNWbFUrenVBNGlkTWRxS3V5UUhtNVFDSVRD?=
 =?utf-8?B?c0dDb2JQQkxSb3lyT2xyNGJsRXl2MWZYVm1pRjhXRHZKWDBlVjJyaFJFeGZi?=
 =?utf-8?B?K0Q1K29vZVNZQzlKOG9lWTlEeHg2UFpUcTlObGN4QXNISmYrNElqV0FxK20z?=
 =?utf-8?B?S3owNFJsOGthc2hIN3J0aTFvQ3h6eGNkSEUrUXBwT3UxUmQxZ0R0blJOdDJv?=
 =?utf-8?B?ZmVVeEw2cHRyTzQzTUYyMDN1ZXlDeUVralJqNTZsSzd3Zm55bFE3OXN1Ky9Y?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb007ad0-5973-48db-0c7a-08dca14a488a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 01:39:19.7855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8EKD7wC1g1NUaV2gJlWmxXYlOkf9CJhsJPNLZApHezftURQkwPtK9HdX/N1DR5yVXG+Cwya1X/aqSO9UcsDc+4DctHvhCrc0xWZA6ynbwbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8544
X-Proofpoint-ORIG-GUID: Mp4xjnjc1FG3eFyAqmy91UwjGMJpXVyM
X-Proofpoint-GUID: Mp4xjnjc1FG3eFyAqmy91UwjGMJpXVyM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_20,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2406140001 definitions=main-2407110009
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 11 Jul 2024 01:39:27 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16415

--------------gRtLsQLcPbjjx9R0Az4V4mOq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 46AMCsWT022062


On 7/10/24 11:28, Changqing Li via lists.openembedded.org wrote:
>
>
> On 7/9/24 18:58, Richard Purdie wrote:
>> CAUTION: This email comes from a non Wind River email account!
>> Do not click links or open attachments unless you recognize the sender=
 and know the content is safe.
>>
>> On Tue, 2024-07-09 at 10:41 +0800, Changqing Li via lists.openembedded=
.org wrote:
>>> On 7/8/24 17:25, Alexander Kanavin wrote:
>>>> On Mon, 8 Jul 2024 at 11:12, ChenQi<Qi.Chen@windriver.com>  wrote:
>>>>> This problem has reported to Ubuntu for 4 months. It was discussed =
on
>>>>> the Yocto mailing list. People seem to be waiting for Ubuntu. I'm n=
ot
>>>>> very optimistic about getting a solution from Ubuntu.
>>>>>  =C2=A0I do not agree. The last comment  (#10, added two weeks ago)=
 in
>>>> https://bugs.launchpad.net/ubuntu/+source/apparmor/+bug/2056555  sho=
ws
>>>> how to create an apparmor profile specifically for bitbake, so once
>>>> this is added to apparmor upstream and makes its way into Ubuntu the
>>>> problem will be solved. At that point the forced network disabling
>>>> will become unnecessary and damaging. Ubuntu release notes imply
>>>> they've done it for things like Chrome and Discord, but they expect
>>>> more to be added:
>>>>
>>>> https://discourse.ubuntu.com/t/ubuntu-24-04-lts-noble-numbat-release=
-notes/39890#security-improvements
>>>>
>>> I think applications like Chrome, thunderbird etc are commonly used a=
pplications by user, so they are might in
>>> ubuntu's package repo,  so they will support it and add profile for i=
t by default.  But for bitbake,  it is mostly
>>> for developer and and not support by ubuntu.  And considering  there =
might be many other softwares meet this issue,
>>> so I am not optimistic that ubuntu will add default profile for all t=
hese softwares.  so maybe we are still on our own.
>>> One option is using this patch,  so users don't have to struggle on t=
his problem, don't need sudo, don't need an apparmor profile etc,
>>> but have the side effect that skip disable network,  we need to balan=
ce which to choose.
>>> One option is document or  notice message in oe-init-build-env,  sugg=
est user to disable unprivileged_userns or write a profile for bitbake.
>> I do not want to just stop disabling the network silently so the patch
>> as written isn't an option.
>>
>> I'm also not keen to make oe-init-build-env too complex, it is meant t=
o
>> be just enough to get us into bitbake, nothing more. Adding sanity
>> checks there is the wrong place. This could happen in the normal
>> sanity.bbclass code but we need to make sure it triggers when a user
>> upgrades their existing distro.
>>
>> I think we should open a new ticket with ubuntu specifically about
>> adding a profile for bitbake and see if we can get a definitive answer
>> on whether we can add a profile for it or not. I'd suggest a new ticke=
t
>> so we don't get confused with the comments in the one linked above.
>
> file a new ticket=20
> https://bugs.launchpad.net/ubuntu/+source/apparmor/+bug/2072615
>
> let's wait to see if the recommended profile can be acceptted.
>
Hi,

The request is rejected as following comments:

Unfortunately, as John has stated in this comment:
https://bugs.launchpad.net/ubuntu/+source/apparmor/+bug/2063976/comments/=
3=20
<https://bugs.launchpad.net/ubuntu/+source/apparmor/+bug/2063976/comments=
/3>
We are not able to ship a profile for bitbake running in a writable=20
location of an unprivileged user because it could be used to bypass the=20
restriction.

Regards

Changqing

> Regards
>
> Changqing
>
>> Cheers,
>>
>> Richard
>>
>>
>>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16414):https://lists.openembedded.org/g/bitbake-dev=
el/message/16414
> Mute This Topic:https://lists.openembedded.org/mt/107099079/3616873
> Group Owner:bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:https://lists.openembedded.org/g/bitbake-devel/unsub  [chan=
gqing.li@windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
--------------gRtLsQLcPbjjx9R0Az4V4mOq
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#cceed0">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 7/10/24 11:28, Changqing Li via
      lists.openembedded.org wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:17E0BC4E4EBC9777.21385@lists.openembedded.org">
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 7/9/24 18:58, Richard Purdie
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:ef64c37a7fa679d58d34dc3fa31020788bc308f2.camel@linuxfoundation.org">
        <pre class="moz-quote-pre" wrap="">CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and know the content is safe.

On Tue, 2024-07-09 at 10:41 +0800, Changqing Li via lists.openembedded.org wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On 7/8/24 17:25, Alexander Kanavin wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">On Mon, 8 Jul 2024 at 11:12, ChenQi <a class="moz-txt-link-rfc2396E" href="mailto:Qi.Chen@windriver.com" moz-do-not-send="true">&lt;Qi.Chen@windriver.com&gt;</a> wrote:
</pre>
            <blockquote type="cite">
              <pre class="moz-quote-pre" wrap="">This problem has reported to Ubuntu for 4 months. It was discussed on
the Yocto mailing list. People seem to be waiting for Ubuntu. I'm not
very optimistic about getting a solution from Ubuntu.
&nbsp;I do not agree. The last comment  (#10, added two weeks ago) in
</pre>
            </blockquote>
            <pre class="moz-quote-pre" wrap=""><a class="moz-txt-link-freetext" href="https://bugs.launchpad.net/ubuntu/+source/apparmor/+bug/2056555" moz-do-not-send="true">https://bugs.launchpad.net/ubuntu/+source/apparmor/+bug/2056555</a> shows
how to create an apparmor profile specifically for bitbake, so once
this is added to apparmor upstream and makes its way into Ubuntu the
problem will be solved. At that point the forced network disabling
will become unnecessary and damaging. Ubuntu release notes imply
they've done it for things like Chrome and Discord, but they expect
more to be added:

<a class="moz-txt-link-freetext" href="https://discourse.ubuntu.com/t/ubuntu-24-04-lts-noble-numbat-release-notes/39890#security-improvements" moz-do-not-send="true">https://discourse.ubuntu.com/t/ubuntu-24-04-lts-noble-numbat-release-notes/39890#security-improvements</a>

</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap="">I think applications like Chrome, thunderbird etc are commonly used applications by user, so they are might in
ubuntu's package repo,  so they will support it and add profile for it by default.  But for bitbake,  it is mostly
for developer and and not support by ubuntu.  And considering  there might be many other softwares meet this issue,
so I am not optimistic that ubuntu will add default profile for all these softwares.  so maybe we are still on our own.
One option is using this patch,  so users don't have to struggle on this problem, don't need sudo, don't need an apparmor profile etc,
but have the side effect that skip disable network,  we need to balance which to choose.
One option is document or  notice message in oe-init-build-env,  suggest user to disable unprivileged_userns or write a profile for bitbake.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">I do not want to just stop disabling the network silently so the patch
as written isn't an option.

I'm also not keen to make oe-init-build-env too complex, it is meant to
be just enough to get us into bitbake, nothing more. Adding sanity
checks there is the wrong place. This could happen in the normal
sanity.bbclass code but we need to make sure it triggers when a user
upgrades their existing distro.

I think we should open a new ticket with ubuntu specifically about
adding a profile for bitbake and see if we can get a definitive answer
on whether we can add a profile for it or not. I'd suggest a new ticket
so we don't get confused with the comments in the one linked above.</pre>
      </blockquote>
      <p>file a new ticket <a class="moz-txt-link-freetext" href="https://bugs.launchpad.net/ubuntu/+source/apparmor/+bug/2072615" moz-do-not-send="true">https://bugs.launchpad.net/ubuntu/+source/apparmor/+bug/2072615</a></p>
      <p>let's wait to see if the recommended profile can be acceptted.</p>
    </blockquote>
    <p>Hi,</p>
    <p>The request is rejected as following comments:</p>
    <p><span style="color: rgb(0, 0, 0); font-family: &quot;Ubuntu Mono variable&quot;, &quot;Ubuntu Mono&quot;, Consolas, Monaco, Courier, monospace; font-size: 12.8px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">Unfortunately,
        as John has stated in this comment:</span><br style="color: rgb(0, 0, 0); font-family: &quot;Ubuntu Mono variable&quot;, &quot;Ubuntu Mono&quot;, Consolas, Monaco, Courier, monospace; font-size: 12.8px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <a rel="nofollow" href="https://bugs.launchpad.net/ubuntu/+source/apparmor/+bug/2063976/comments/3" style="color: rgb(0, 51, 170); text-decoration: none; font-family: &quot;Ubuntu Mono variable&quot;, &quot;Ubuntu Mono&quot;, Consolas, Monaco, Courier, monospace; font-size: 12.8px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255);">https:/<wbr>/bugs.launchpad<wbr>.net/ubuntu/<wbr>+source/<wbr>apparmor/<wbr>+bug/2063976/<wbr>comments/<wbr>3</a><br style="color: rgb(0, 0, 0); font-family: &quot;Ubuntu Mono variable&quot;, &quot;Ubuntu Mono&quot;, Consolas, Monaco, Courier, monospace; font-size: 12.8px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;">
      <span style="color: rgb(0, 0, 0); font-family: &quot;Ubuntu Mono variable&quot;, &quot;Ubuntu Mono&quot;, Consolas, Monaco, Courier, monospace; font-size: 12.8px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;">We
        are not able to ship a profile for bitbake running in a writable
        location of an unprivileged user because it could be used to
        bypass the restriction.</span></p>
    <p>Regards<br>
    </p>
    <p>Changqing</p>
    <blockquote type="cite" cite="mid:17E0BC4E4EBC9777.21385@lists.openembedded.org">
      <p>Regards</p>
      <p>Changqing<br>
      </p>
      <blockquote type="cite" cite="mid:ef64c37a7fa679d58d34dc3fa31020788bc308f2.camel@linuxfoundation.org">
        <pre class="moz-quote-pre" wrap="">Cheers,

Richard



</pre>
      </blockquote>
      <br>
      <fieldset class="moz-mime-attachment-header"></fieldset>
      <pre class="moz-quote-pre" wrap="">
-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.
View/Reply Online (#16414): <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/message/16414">https://lists.openembedded.org/g/bitbake-devel/message/16414</a>
Mute This Topic: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/mt/107099079/3616873">https://lists.openembedded.org/mt/107099079/3616873</a>
Group Owner: <a class="moz-txt-link-abbreviated" href="mailto:bitbake-devel+owner@lists.openembedded.org">bitbake-devel+owner@lists.openembedded.org</a>
Unsubscribe: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/unsub">https://lists.openembedded.org/g/bitbake-devel/unsub</a> [<a class="moz-txt-link-abbreviated" href="mailto:changqing.li@windriver.com">changqing.li@windriver.com</a>]
-=-=-=-=-=-=-=-=-=-=-=-

</pre>
    </blockquote>
  </body>
</html>

--------------gRtLsQLcPbjjx9R0Az4V4mOq--

