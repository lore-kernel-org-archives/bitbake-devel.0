Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEACC4829E
	for <webhook@archiver.kernel.org>; Fri, 16 Feb 2024 01:48:36 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.9516.1708048109429593696
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Feb 2024 17:48:29 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=VEYlOeeS;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=2776b1bbfe=randy.macleod@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G1P2Wq004889
	for <bitbake-devel@lists.openembedded.org>; Fri, 16 Feb 2024 01:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-type:message-id:date:subject:to:cc:references:from
	:in-reply-to:mime-version; s=PPS06212021; bh=RksnmpOqKvuvrc2lujX
	nbd8/Vk8LTAWbZ3k+tLxfz7M=; b=VEYlOeeSXxbSP7XMAmuNWYKdotvw2qiq8Xn
	x/1huZd7M4Ro85pUuccZ4HlwHP67LtrVVtaWIs9GcLN0rTRSnTJbAU7vc/0rVslN
	bwKQVMcfuhGBXhyBwIKUhECHZ/xPy71XmSJnPXA6ZMhk7o2Jnll3x5tBheqfq1Iz
	OcE+6AH4ydn4JmVoQEXQeSS4how2S5+lgx4n057I1GNSzLBryiWK5iA4G9pegpTU
	/sYi10PIX28ZdJOS7gqKJuPgdzgc0wg0/CnRQLkcDuE1zb6vhDzrDUDix6jJwXrF
	IzLNV5JUp5A04rW/YROJH/EuIcbUyxkvVM4TMAo6dRFC0hNyhAg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3w5xbxwk6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 16 Feb 2024 01:48:28 +0000 (GMT)
Received: from m0250811.ppops.net (m0250811.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 41G1mRjt004715;
	Fri, 16 Feb 2024 01:48:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3w5xbxwk6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 01:48:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foiKhsJWXzWJRzhO2876X1/0PdcD2yOpprP/hdUj5yGO4j8NGJqW4NkXH0RB7m3zZTGkcNeHL2ER47NWOZStobfeG5WgLESFSAKngQDvYNsY5eeu8zKKR5jaAFCymT34angmG46QhgwHN9GroCKkCbLZ2QGsD/1rDuzoAPLvL/0Sz+tCGo+UNBqYvGtwukSGtf15Mre+AnOySGM0DgxsZsGA5fXHPDpZwGgE2FeDMeTAX6NfiXkJBa+7XgRbE15KRa9KGDDQ9cctw1lx5F20Z6NP69uaDPseUPUWUJ5XH+1GFbrFYwjEiWhC3W6r8Ca1i/Gs9p5B4kqVWxN/jH7Sag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RksnmpOqKvuvrc2lujXnbd8/Vk8LTAWbZ3k+tLxfz7M=;
 b=lAAdskSsqkkvTxl/kmqVwiwEZJKrJ2CoaU71OV3NrEK612BB4VGGWkKY2tmD13yCv0NLDJ4B1DzB1uVWRuFjVIniubacW1ZTI8XgjDxxlfn1GPjUVVIqpdsOwJ5qi0w8t/QTam/y20C0bBJHeW+FRJOvU0AoDxV9lWYJoCgT+lasQ7yNGZr3+1b0dL5jnj6GBQeZyOLJDwYbNiAQSjGSHnwMVOcqkAGvGJCOjWsHdYj4eb1GBaqSQvMY/qgShrT9ByfP1nTQUeTE4Wxl4tEiFiNzjQLhRl5Cl5zovnhDFOHOABUYsJbtEJqFsRGStkwKTfMWTE2Ayau3ACJwagNFrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5920.namprd11.prod.outlook.com (2603:10b6:a03:42e::9)
 by CO1PR11MB5187.namprd11.prod.outlook.com (2603:10b6:303:94::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Fri, 16 Feb
 2024 01:48:24 +0000
Received: from SJ0PR11MB5920.namprd11.prod.outlook.com
 ([fe80::f3ba:ff33:12be:cff7]) by SJ0PR11MB5920.namprd11.prod.outlook.com
 ([fe80::f3ba:ff33:12be:cff7%7]) with mapi id 15.20.7270.036; Fri, 16 Feb 2024
 01:48:24 +0000
Content-Type: multipart/alternative;
 boundary="------------lO7aKjOLVambyZeMmDtY8okx"
Message-ID: <38b07d03-a044-4cf5-b9a2-b993ef7ec320@windriver.com>
Date: Thu, 15 Feb 2024 20:48:20 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [2.0][PATCH 1/5] runqueue: fix PSI check
 calculation
Content-Language: en-CA
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        Martin Jansa <martin.jansa@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, steve@sakoman.com,
        Chen Qi <Qi.Chen@windriver.com>
References: <17964777D58C012A.3202@lists.openembedded.org>
 <CA+chaQc3jWaE0Bto1MQFf45bUVdY_8UvAb9N1vFM=A1-Q_RnGA@mail.gmail.com>
 <018990a0-3db0-41e6-b0f9-61e4c03407c8@windriver.com>
 <47f538c24ddb16cd2301ee95de59459d32c05cbe.camel@linuxfoundation.org>
From: Randy MacLeod <randy.macleod@windriver.com>
In-Reply-To: <47f538c24ddb16cd2301ee95de59459d32c05cbe.camel@linuxfoundation.org>
X-ClientProxiedBy: SJ0PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::28) To SJ0PR11MB5920.namprd11.prod.outlook.com
 (2603:10b6:a03:42e::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5920:EE_|CO1PR11MB5187:EE_
X-MS-Office365-Filtering-Correlation-Id: d717adc8-87f8-4f4d-53ab-08dc2e915c8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	vqSaB4DFvGmsfPexbGckgNkRQUFUxXOGVT4UxxXcRK1SqZfCEPw6D9rUtyuihGWJdosfaTUOQG9FQTK2/DnYOcSntFRCRMLZKSsXm9sQOHDE7KEAn9D78HD9N9lVfdmny1MzyuurpzdvkToEMThiv8nP7+gPSWoMdQAOAqCpwkgLHb2snTUU4yA4nkuOLXCt0ZZvq0CvL7mcduz1FhoEUK/eoS/DwdFxncmg/scGUUWxX0vp5U8H+/+LYt16Qbjb2fvrLSnzcmvxb69A0lOf0u8ILtkpzQxAvCILWClrED/GH6ZfFmXCAPKUrkvY1G807EgmW2FVWqRU5sJ4Sx3Yz5ySFZ3YWkDO1RDu3Ziq2pjQfWv8UoGoduJuG/4+bGrKJS5XnvFCzGIySFMgO7aZjvukTHFDzbgRybkB5vWTEIqH5Xi4y2uMwym7gZFG0Y492jVnLd361AhHQD69eXcduabSmgzc/zDNgRjVWV5A0EwwASBtDO79NQNgQXvowaJkNB8Qyps4sQEkmgJl7QeAVTc5zWLegwyQmyMKvJxQ6T0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5920.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39850400004)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(2906002)(38100700002)(4001150100001)(6506007)(31696002)(53546011)(478600001)(6512007)(6486002)(83380400001)(41300700001)(33964004)(86362001)(166002)(36756003)(107886003)(66476007)(26005)(316002)(110136005)(4326008)(2616005)(66946007)(8936002)(8676002)(66556008)(6666004)(966005)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VHFQQ3grUjZFb2txRTFSWlV3U0krV2lVRlEyQ0RETWVybkYyWDZEWGVzQlBD?=
 =?utf-8?B?d1dDV2YyRHl1MEVMRVZHeFduL2l6akxGb0VlYi9EdjIzQ0c1ekZMY2JtWHhC?=
 =?utf-8?B?NzVMRFJjYnR3QUw4dGJnRVpGTkpabDc3NnFOcWNrMzZZT3ZLcklqYXhVOEVj?=
 =?utf-8?B?MjNNTnNSMUVqMm1INTVVVVhpYTMrREpOUzFqVlhocFg5ZUNVTlNpbElTLzBn?=
 =?utf-8?B?NlI5cGExeWdVS0MxMU5vSHBUd2cwR1Nncm9NTGlZc0Mwa05JYWpEc1VyWERP?=
 =?utf-8?B?aGNLbS9XeENLQ1l4N2pqRDlhT3VvOHAyK2pCY0lNVks5cDJObk5UbXVBZkcx?=
 =?utf-8?B?dUtUaU1tL0dlL0VHc0xIY0pnWEdleWF1eHJvOC9reFp5UDJsVW5FVFVHQzZD?=
 =?utf-8?B?Vk5HU3ZlNUlkUzVETHJJYUVYc2FQdHg4OFF2ZnhOdXJkRnY3cVFTd3pvWlM1?=
 =?utf-8?B?SXpkR1BmQmg4Z0s2NmYvLy94UTRtZU9RV3ZLRkhNQmFMN0E0UmVJbkFrbkNl?=
 =?utf-8?B?d2Q1bWt4NTlOeU94eUFLR00xKzdxaGNxSzJLMXA5U2tiVGdFODFxaEJuYzd5?=
 =?utf-8?B?eERubm84NXp4S0QwNHhiblhqWkhlTmpTbGtjWGdjaTArNWx1alpnM1ozSzBZ?=
 =?utf-8?B?SUZJaEQxSjBPdnNPQnFocVNsNC9qSTZ2TGxFSFNsNkNjMlN1RXN0RkFRa3Z6?=
 =?utf-8?B?M2U2UHI1TXB5QlNNZDlXQ0twcDAxWjFNbmpUaGprNGhmYVRhNlAxTW9OMmxK?=
 =?utf-8?B?UFQ2WDBnOXFQVmY0WlMzVkRTZW8wWHhYdUlMREMxejgzdUtxTVhhMlMrUHdB?=
 =?utf-8?B?UzZVWkxyRzkvSkdvR3NsdXFIVnhkR1VwbVZDazR6WG5XUi8xckZ2QXRaRThC?=
 =?utf-8?B?SFFaOWFJNDNMR01QQjNwTWkzcjEyNjhTWTVrSytXTTVwcDQvOUIrOVhqT2Vs?=
 =?utf-8?B?M1JXUWtPTUpxN1htZkVkbS9mazdBQysvc1p1WWxYcjJNMUhWSU5iaW5XM2JZ?=
 =?utf-8?B?N25vZ3lkS0VSa3ZRL2llUGJpS2plK3hxb3ZxSXZwWUc0YkpObjhTNE5RQUVu?=
 =?utf-8?B?T1VWQ2hUdnp3S2FyOWZHOUxidE5YOHh3dTROcGltU2Z0N0NveUVUaDE2d3BI?=
 =?utf-8?B?Q01lMnJZUGhsZmNFWTNGUjBQa0pPaVd5SENUMEVEM2JVUERNT1dSOVgwTU4x?=
 =?utf-8?B?SEhCRERTaEtQMzJKQ0pyL1pDQlNnQzMyWFlUUWhrckRXLzBoSGJ5QUFkQUdV?=
 =?utf-8?B?VlZ6YzdUSC9MUW5sWGR1ZVV4eEY2cjdhQVIrREhyeGRJRHhpWVcvUFVUM1dv?=
 =?utf-8?B?TGNNeFdScUxWaVBvdzEvSUpGNzFkbXhaR3JUWXl1V1Iwa0Q2b2F4cWh4eThQ?=
 =?utf-8?B?SDlEcTJoZVBLSDNEY0t3SE9ua0o5MDBZbm84amFvZU4zYWc0Tk1DbVFNVEVO?=
 =?utf-8?B?ZXZJMmc5R0o0SC9vUmVVWDhWbDdVc01CdHRYRkQ1T1FZUDhLMy9NVk15YmFV?=
 =?utf-8?B?d2xwN0hMcm52S3I0ZmpoRFJ5d1NzeUVJWTRXRk5XWjhXVGFuRFVPZnJDRC9p?=
 =?utf-8?B?QXpoSWFrOTZDUlRjQ3Y1dE4rL2VJUnhLYS9kbG5ZR2IxbkpIUmlGOEhlMFJB?=
 =?utf-8?B?TFZabGJjb2FJbU0rdlUzVXVmQjhpVXVJMC9mMm5jcDJ0cXg4VG8yVXkxUDl1?=
 =?utf-8?B?bFFUMWNxQWRjTFVXS2huc1FQSk9GSzEyOU9NSE5JaVROWlc3djZLcnVqSEpD?=
 =?utf-8?B?bzZPNWJVU3Nzd3NqMHk4Y1BTWkNHcHRCSzBYQ0ZaNW4wVk4yM2VoNlI5di9H?=
 =?utf-8?B?ZEVYdVZIeEJVc2E2QUw1ZDc0dG9PcTVkSWxBVjB2YVdtMGswNmJNdUlENnJC?=
 =?utf-8?B?SnY4MElWRXJTN1NHb2l4ZDF3ZnhZczJrblNlKy9DUzhtUnZpSlFvaGZJY2NZ?=
 =?utf-8?B?MGhRY3dDTG5Ib01OMHpmZHZWdFp4eWx6cURZVkJyQ29uUnNmWnIxRTR5OC9r?=
 =?utf-8?B?eW9QSzZ1MUlJTVBpUkNvZ0VGVTFQaUtWbWd2cnhXMlR4YitHS2NmSnRYK1hK?=
 =?utf-8?B?eXJkMmEzYVcvZW5FMnFJRWZBVHowellUTXVzeDY1a1oycVJSTkdqTUQxUUNH?=
 =?utf-8?B?UWFOdkx1dzBqRERiN0dKVkI5azhZUnM5RkVKbnRjMzF0R2JlU0U1bHJYZVA1?=
 =?utf-8?B?R0E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d717adc8-87f8-4f4d-53ab-08dc2e915c8f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5920.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 01:48:24.1309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ud/wJtKJQ8LWZJYaUlS/6UcrFlPpyE72wxMe9ngxnZt9aoiqPvPRmaUNSC6gLv0tBNWyHNItfXP02HhQoQL17aPkai6wrIDSwDSaaBYhHbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5187
X-Proofpoint-ORIG-GUID: Lbibyam5zdG-ulqxja2PdU2Kkn69gkY9
X-Proofpoint-GUID: tk9zdfq2OOYCbLvC7L1sGrvki_bb-ED3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_24,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160012
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 16 Feb 2024 01:48:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15906

--------------lO7aKjOLVambyZeMmDtY8okx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 41G1P2Wq004889

On 2024-02-15 6:14 p.m., Richard Purdie wrote:
> On Thu, 2024-02-15 at 18:06 -0500, Randy MacLeod wrote:
>> On 2023-11-10 9:06 a.m., Martin Jansa wrote:
>>
>>> I forgot to include [RFC] tag in the subject, because these changes=20
>>> might be a bit controversial.
>>>
>>> From my testing:
>>> https://github.com/shr-project/test-oe-build-time/commit/d5111f4472ac=
397c0f1197eb6366ac7d2e56453f=20
>>> <https://urldefense.com/v3/__https://github.com/shr-project/test-oe-b=
uild-time/commit/d5111f4472ac397c0f1197eb6366ac7d2e56453f__;!!AjveYdw8EvQ=
!f35PVorsjRHzPeCdLVCittHJcXcQTibeF0q5nqa0CcWnxVr6Zdu3-DT7IpTT6Q1miq7Pyxk8=
DDBJq1Nij5jI1m3znH8$>
>>> the reasonable pressure values for 2.0 (in kirkstone) and 2.6 (in=20
>>> nanbield) are significantly different due to these changes in PSI=20
>>> calculation and logic so while 1000 was reasonable value for my=20
>>> system in 2.0, I need 100000 with 2.6.
>>>
>>> I've backported these changes long time ago for my local builds to=20
>>> use the same PSI values for all builds.
>>>
>>> And the controversy is that backporting these will change the=20
>>> expected values (so kind of change in behavior which might not be=20
>>> suitable for stable release). But the commits make it sound as a bug=20
>>> in the logic, so we can also consider them as bug fixes.
>>>
>>> The change in expected pressure values was reported in:
>>> https://lists.openembedded.org/g/bitbake-devel/message/14942=20
>>> <https://urldefense.com/v3/__https://lists.openembedded.org/g/bitbake=
-devel/message/14942__;!!AjveYdw8EvQ!f35PVorsjRHzPeCdLVCittHJcXcQTibeF0q5=
nqa0CcWnxVr6Zdu3-DT7IpTT6Q1miq7Pyxk8DDBJq1Nij5jICLP93rQ$>
>>>
>>> If it's not a bug to be fixed in 2.0 then maybe we should mention=20
>>> different PSI values in release notes for nanbield (I know I'm too=20
>>> late for that).
>>>
>>> Regards,
>>
>> So people were suggesting that the slow YP AB times might be due to=20
>> PSI regulation.
>>
>> On a 24 core system, I built core-image-minimal with the original code
>> from before Chen's commit in August 2023
>>
>> poky.git
>> $ git log --oneline -2 653ff4d85cbaf53627f7978b06c1f025ac4694e2
>> 653ff4d85c bitbake: runqueue.py=20
>> <https://urldefense.com/v3/__http://runqueue.py__;!!AjveYdw8EvQ!f5JS42=
7vmCgvFjpobXMoKkWemtw0ZHFuTZhawQuPUzSeHjv22YOn5jDF9_QASdCRR2hDP4SptFSb1WF=
57ZYDLSQ-pN48msQ19wpneHc$>:=20
>> fix PSI check logic
>> ac5512b0ac bitbake: fetch2: add Google Cloud Platform (GCP)=20
>> fetcher=C2=A0=C2=A0=C2=A0 <---- Old
>>
>>
>> and with current master ~ Feb 2024 :
>>
>> $ git log --oneline -2
>> 9382d731bd bash: nativesdk-bash does not provide /bin/bash so don't=20
>> claim to <----- New
>> 0fe85ce0c6 busybox: Explicitly specify tty device for serial consoles
>>
>> Note that the source being build is different and it would have been=20
>> better to just change the
>> pressure regulaiton code but this was a weekend 'fun' project. Also,=20
>> yes I fetched the code before
>> building with the set of BB_PRESSURE_MAX_CPU values.
>>
>> There wasn't much of a difference as shown in the graph and data below.
>>
>> I could try the same thing for world builds but I'm not sure that's=20
>> worthwhile.
>> I still plan to construct a test of PSI regulation using some -native=20
>> recipes that invoke stress-ng
>> enough to cause sustained (CPU or IO) pressure and then test if a new=20
>> task will ALWAYS be prevented
>> from running until the pressure subsides.
>>
>
> Thanks for checking that, it is helpful to rule things out. I think=20
> the bigger question was whether we needed to adjust the pressure=20
> values and whether the autobuilder is under-utilising.

Right. Did you want me to send a patch to disable pressure regulation=20
completely or
increase the limit in the y-ab-helper config.json for master-next?


> I'm surprised and slightly suspicious when the graphs have correlation=20
> that good btw :)

Yeah, it's particularily odd when even the avg10 (seconds) data is so=20
variable.
For fun, after dinner today, I took the cpu pressure data from=20
BB_PRESSURE_MAX_CPU =3D 1K, 10K
and played with it.

The 10K limited run finishes in 4945 seconds and the more regulated 1K=20
run takes 7193 seconds.
I just munged the logged pressure data using emacs macros because I know=20
how to do that and
I didn't bother to figure out how to merge 3 lines using awk, python,=20
and then filtered it with awk (1)
to stretch out the 10K time values to get:


You see that the avg10 pressure is generally much higher for the 10K=20
run, thereby allowing the full build
to complete in less time. to 1K run, has lower avg10 pressure but=20
occasionally jobs escape regulation and
the system is overloaded for a while. Once or twice in the middle of the=20
build, a large job escapes regulation.

At least that's what I see! ;-)

With a job server pool and improvements to our regulation algorithm, the=20
CPU pressure should smooth out=C2=A0 quite a bit... some day...

../Randy


1)

yocto/psi/feb-2024
=E2=9C=A6 =E2=9D=AF cat yp-ab-build-cpu-feb-9-2024/feb11/reduced-psi-1000=
0/cpu.dat | awk=20
'{ if (NR =3D=3D 1) { for (i =3D 1; i <=3D NF; i++) { first_row[i] =3D $i=
} };=20
print (($1 - first_row[1])*7193.0/4945.0) ", " $2}' >=20
yp-ab-build-cpu-feb-9-2024/feb11/reduced-psi-10000/cpu-time-avg10-scaled-=
1000-elapsed.dat


>
> Cheers,
>
> Richard
>
>

--=20
# Randy MacLeod
# Wind River Linux

--------------lO7aKjOLVambyZeMmDtY8okx
Content-Type: multipart/related;
 boundary="------------pBaxjYGMCNx8eIgWb3zwNSCF"

--------------pBaxjYGMCNx8eIgWb3zwNSCF
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 41G1P2Wq004889

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">On 2024-02-15 6:14 p.m., Richard Purdi=
e
      wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:47f538c24ddb16cd2301ee95de59459=
d32c05cbe.camel@linuxfoundation.org">
     =20
      <style>pre,code,address {
  margin: 0px;
}h1,h2,h3,h4,h5,h6 {
  margin-top: 0.2em;
  margin-bottom: 0.2em;
}ol,ul {
  margin-top: 0em;
  margin-bottom: 0em;
}blockquote {
  margin-top: 0em;
  margin-bottom: 0em;
}</style>
      <div>On Thu, 2024-02-15 at 18:06 -0500, Randy MacLeod wrote:</div>
      <blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2=
px #729fcf solid;padding-left:1ex">
        <div> </div>
        <div class=3D"moz-cite-prefix">On 2023-11-10 9:06 a.m., Martin
          Jansa wrote:<br>
        </div>
        <div> <br>
        </div>
        <blockquote type=3D"cite" cite=3D"mid:CA+chaQc3jWaE0Bto1MQFf45bUV=
dY_8UvAb9N1vFM=3DA1-Q_RnGA@mail.gmail.com" style=3D"margin:0 0 0 .8ex; bo=
rder-left:2px #729fcf solid;padding-left:1ex">
          <div> </div>
          <div dir=3D"ltr">I forgot to include [RFC] tag in the subject,
            because these changes might be a bit controversial.
            <div><br>
            </div>
            <div>From my testing:</div>
            <div><a href=3D"https://urldefense.com/v3/__https://github.co=
m/shr-project/test-oe-build-time/commit/d5111f4472ac397c0f1197eb6366ac7d2=
e56453f__;!!AjveYdw8EvQ!f35PVorsjRHzPeCdLVCittHJcXcQTibeF0q5nqa0CcWnxVr6Z=
du3-DT7IpTT6Q1miq7Pyxk8DDBJq1Nij5jI1m3znH8$" moz-do-not-send=3D"true">htt=
ps://github.com/shr-project/test-oe-build-time/commit/d5111f4472ac397c0f1=
197eb6366ac7d2e56453f</a></div>
            <div>the reasonable pressure values for 2.0 (in kirkstone)
              and 2.6 (in nanbield) are significantly different due to
              these changes in PSI calculation and logic so while 1000
              was reasonable value for my system in 2.0, I need 100000
              with 2.6.</div>
            <div><br>
            </div>
            <div>I've backported these changes long time ago for my
              local builds to use the same PSI values for all builds.</di=
v>
            <div><br>
            </div>
            <div>And the controversy is that backporting these will
              change the expected values (so kind of change in behavior
              which might not be suitable for stable release). But the
              commits make it sound as a bug in the logic, so we can
              also consider them as bug fixes.</div>
            <div><br>
            </div>
            <div>The change in expected pressure values was reported in:<=
/div>
            <div><a href=3D"https://urldefense.com/v3/__https://lists.ope=
nembedded.org/g/bitbake-devel/message/14942__;!!AjveYdw8EvQ!f35PVorsjRHzP=
eCdLVCittHJcXcQTibeF0q5nqa0CcWnxVr6Zdu3-DT7IpTT6Q1miq7Pyxk8DDBJq1Nij5jICL=
P93rQ$" moz-do-not-send=3D"true">https://lists.openembedded.org/g/bitbake=
-devel/message/14942</a><br>
            </div>
            <div><br>
            </div>
            <div>If it's not a bug to be fixed in 2.0 then maybe we
              should mention different PSI values in release notes for
              nanbield (I know I'm too late for that).</div>
            <div><br>
            </div>
            <div>Regards,</div>
          </div>
          <div> </div>
        </blockquote>
        <div> </div>
        <p>So people were suggesting that the slow YP AB times might be
          due to PSI regulation.<br>
          <br>
          On a 24 core system, I built core-image-minimal with the
          original code <br>
          from before Chen's commit in August 2023 <br>
        </p>
        <div> </div>
        <p>poky.git<br>
          $ git log --oneline -2
          653ff4d85cbaf53627f7978b06c1f025ac4694e2<br>
          653ff4d85c bitbake: <a href=3D"https://urldefense.com/v3/__http=
://runqueue.py__;!!AjveYdw8EvQ!f5JS427vmCgvFjpobXMoKkWemtw0ZHFuTZhawQuPUz=
SeHjv22YOn5jDF9_QASdCRR2hDP4SptFSb1WF57ZYDLSQ-pN48msQ19wpneHc$" moz-do-no=
t-send=3D"true">runqueue.py</a>: fix PSI check logic
          <br>
          ac5512b0ac bitbake: fetch2: add Google Cloud Platform (GCP)
          fetcher&nbsp;&nbsp;&nbsp; &lt;---- Old<br>
        </p>
        <div> </div>
        <p><br>
        </p>
        <div> </div>
        <p>and with current master ~ Feb 2024 :</p>
        <div> </div>
        <p>$ git log --oneline -2 <br>
          9382d731bd bash: nativesdk-bash does not provide /bin/bash so
          don't claim to &lt;----- New<br>
          0fe85ce0c6 busybox: Explicitly specify tty device for serial
          consoles <br>
        </p>
        <div> </div>
        <p>Note that the source being build is different and it would
          have been better to just change the<br>
          pressure regulaiton code but this was a weekend 'fun' project.
          Also, yes I fetched the code before<br>
          building with the set of BB_PRESSURE_MAX_CPU values.<br>
        </p>
        <div> </div>
        <p>There wasn't much of a difference as shown in the graph and
          data below.</p>
        <div> </div>
        <p>I could try the same thing for world builds but I'm not sure
          that's worthwhile.<br>
          I still plan to construct a test of PSI regulation using some
          -native recipes that invoke stress-ng<br>
          enough to cause sustained (CPU or IO) pressure and then test
          if a new task will ALWAYS be prevented<br>
          from running until the pressure subsides. <br>
        </p>
      </blockquote>
      <div><br>
      </div>
      <div>Thanks for checking that, it is helpful to rule things out. I
        think the bigger question was whether we needed to adjust the
        pressure values and whether the autobuilder is under-utilising.
      </div>
    </blockquote>
    <p>Right. Did you want me to send a patch to disable pressure
      regulation completely or <br>
      increase the limit in the y-ab-helper config.json for master-next?<=
br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:47f538c24ddb16cd2301ee95de59459=
d32c05cbe.camel@linuxfoundation.org">
      <div>I'm surprised and slightly suspicious when the graphs have
        correlation that good btw :)</div>
    </blockquote>
    <p>Yeah, it's particularily odd when even the avg10 (seconds) data
      is so variable.<br>
      For fun, after dinner today, I took the cpu pressure data from
      BB_PRESSURE_MAX_CPU =3D 1K, 10K<br>
      and played with it. <br>
      <br>
      The 10K limited run finishes in 4945 seconds and the more
      regulated 1K run takes 7193 seconds.<br>
      I just munged the logged pressure data using emacs macros because
      I know how to do that and <br>
      I didn't bother to figure out how to merge 3 lines using awk,
      python, and then filtered it with awk (1)<br>
      to stretch out the 10K time values to get:<br>
    </p>
    <p><br>
    </p>
    <p><img src=3D"cid:part1.msLTdh0W.zLopZvNE@windriver.com" alt=3D""></=
p>
    <p>You see that the avg10 pressure is generally much higher for the
      10K run, thereby allowing the full build<br>
      to complete in less time. to 1K run, has lower avg10 pressure but
      occasionally jobs escape regulation and<br>
      the system is overloaded for a while. Once or twice in the middle
      of the build, a large job escapes regulation.</p>
    <p>At least that's what I see! ;-)<br>
    </p>
    <p>With a job server pool and improvements to our regulation
      algorithm, the CPU pressure should smooth out&nbsp; quite a bit... =
some
      day...<br>
    </p>
    <p>../Randy<br>
    </p>
    <p><br>
    </p>
    <p>1)<br>
    </p>
    <p>yocto/psi/feb-2024 <br>
      =E2=9C=A6 =E2=9D=AF cat yp-ab-build-cpu-feb-9-2024/feb11/reduced-ps=
i-10000/cpu.dat
      | awk '{ if (NR =3D=3D 1) { for (i =3D 1; i &lt;=3D NF; i++) {
      first_row[i] =3D $i} }; print (($1 - first_row[1])*7193.0/4945.0) &=
quot;,
      &quot; $2}' &gt;
yp-ab-build-cpu-feb-9-2024/feb11/reduced-psi-10000/cpu-time-avg10-scaled-=
1000-elapsed.dat<br>
      <br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:47f538c24ddb16cd2301ee95de59459=
d32c05cbe.camel@linuxfoundation.org">
      <div><br>
      </div>
      <div>Cheers,</div>
      <div><br>
      </div>
      <div>Richard</div>
      <div><br>
      </div>
      <blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; border-left:2=
px #729fcf solid;padding-left:1ex">
        <div> </div>
      </blockquote>
      <div><br>
      </div>
      <div><span></span></div>
    </blockquote>
    <p><br>
    </p>
    <pre class=3D"moz-signature" cols=3D"72">--=20
# Randy MacLeod
# Wind River Linux</pre>
  </body>
</html>
--------------pBaxjYGMCNx8eIgWb3zwNSCF
Content-Type: image/png; name="veAFub9nsCKTt0Oa.png"
Content-Disposition: inline; filename="veAFub9nsCKTt0Oa.png"
Content-Id: <part1.msLTdh0W.zLopZvNE@windriver.com>
Content-Transfer-Encoding: base64

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

--------------pBaxjYGMCNx8eIgWb3zwNSCF--

--------------lO7aKjOLVambyZeMmDtY8okx--

