Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web12.8785.1621413977650290917
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 May 2021 01:46:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=koPOMh2X;
 spf=pass (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=0773b53858=mingli.yu@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14J8jKxv011395;
	Wed, 19 May 2021 08:46:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0a-0064b401.pphosted.com with ESMTP id 38m8uh8djj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 May 2021 08:46:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOtrDOJ4mpUkVwA+T1xmM7hlUtWWEImJAo/AcVpSyhlKJKan27FWWEvtXdoY6CrKtrga5gjorSQ13IQL7MCaSEBavyYQnuursPHU9QLrdHg5jHInjmF/8/V07Hzgwks8hKyH4gOV1XrsM8VLBdIDm0D78FqyENBO7+1gqTLv5qkQLQ7IAunb+tdsSk1N78wgSzCkSLrerYMWj1pmcHlcqPEW/YDLYCt21pwM2pydWOCFMEr91y1kQAOt0yjW5XPEDAm2YlFp2wbwMADbclw3xahtFuPpmhZfC8YWiI7qDTavGv2siF/yETCL+/q58ROZ1lqs7/8iU+jWHEw4Q28HJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLIGpDnmmgwtQ1tM0sa2AkAm4N13lmbsp4PNsfHnLYY=;
 b=EmZAzj7HGLIBaHLe6ftnYUObkDo84Kotu9jAg2KEHs3ngJCHDft2K5sW1VF4aoKX3S590HYlKwHoA4Bn+1PTA4kl1te1Igu/55tFeezIrqkV2S/7tqVvcjPr7EAAez2p2430tNmisToBrk9Gu3R5nhNYY284IKeUkteusiR1C/qCToLz04ezgxbB6y3wSUd17F4BHlEyNBe+M3+jyFpeH+J1fVWc7o/iqMkRnlEPjVsLDlO/qNhDjWrHNYSRK20Da85/qUIrpseH/3Im2GZtSEhT7afoWaRwJsLTUvkI/II8wUUqGkTlFhUBXzhdMJWFTkqkJNHBAhT5gFwiWXVd3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLIGpDnmmgwtQ1tM0sa2AkAm4N13lmbsp4PNsfHnLYY=;
 b=koPOMh2X2fKe8XxJtge603iOYB4piYvy7r5h88kXjFbzqmzacIPUBeK7/slnKslrKxuxnxZZDegPSAbo3YyCqWoQXKwbi0+zIEzvXyPL7eMxqe1OrmeYQ4l7WGzG2Hskhe4+K9G/qNQotjxb3TkIQXiX281VCSZewaZbW3IXZBM=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CO1PR11MB5009.namprd11.prod.outlook.com (2603:10b6:303:9e::11)
 by MWHPR11MB1904.namprd11.prod.outlook.com (2603:10b6:300:111::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 08:46:14 +0000
Received: from CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::c129:2a53:5093:81e8]) by CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::c129:2a53:5093:81e8%3]) with mapi id 15.20.4129.034; Wed, 19 May 2021
 08:46:13 +0000
Subject: Re: [bitbake-devel] [PATCH] fetch2: make sure the uri added as expected
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org
References: <20210514060443.33335-1-mingli.yu@windriver.com>
 <6517f5c83f3902eb26367fa59b7d07ad1c24f106.camel@linuxfoundation.org>
 <167EDE5E75B22E11.24280@lists.openembedded.org>
 <d8977b6c-c8bc-ab08-5279-42daa223b31c@windriver.com>
 <a5a55a51fbbd6615949f8a463e04346da4bdc029.camel@linuxfoundation.org>
From: "Yu, Mingli" <mingli.yu@windriver.com>
Message-ID: <a0848382-2b3e-1e50-0b9e-f078df0cf1a3@windriver.com>
Date: Wed, 19 May 2021 16:52:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <a5a55a51fbbd6615949f8a463e04346da4bdc029.camel@linuxfoundation.org>
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2P15301CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::29) To CO1PR11MB5009.namprd11.prod.outlook.com
 (2603:10b6:303:9e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.140] (60.247.85.82) by HK2P15301CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.9 via Frontend Transport; Wed, 19 May 2021 08:46:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 42e62e32-5b4a-4a81-a9c3-08d91aa28eb1
X-MS-TrafficTypeDiagnostic: MWHPR11MB1904:
X-Microsoft-Antispam-PRVS: 
	<MWHPR11MB190445F931487534BA27AF4BF12B9@MWHPR11MB1904.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	7qk/zS1jQFLdqDjs60H5t1HIoDdDP7gZAJ1bXkUZO1f2k9uYZ6aVlSGURTp07CFpEhwaPXzNj6z+syPAKlfQSCK3QLUN8uzGnvMIAcda02DmEdGCS/M+nYG7kvjj7qHQPN1ULuYj+plWu3Gp9SbR9iqilnZ3E8PIr2ORzLWnLtKHFVD6PmDva82Lg5HcCh+UoRA7Rz4s63pnH495+C4OTzDLNoDQsK9AKMUTnGV+UjmQoe1kldD8cAusnmhIzrUD9LVi0mkdBDtmlY5aHtkFo8H3EzomjVkEjndK7wbNYdOZ/MKPMo6lqZRsk0yKEP3E4SYy4c1F8pHv7OxEUMKY6qtClG+dFuH22A01LXvfUpNsZ5U7kkcDUmrP9501gJDAtIRYQ1/lIcAG3YtDdeCO20yB5DpNiQdJoOsiNFs0aGu9QrqubsGurBtb31pEArQ1UdS7ywf2geTBzb/lhkGFFu4H3RCekGlJ+90bT6TBT2OXQ7XY+MfLn1V1X+quPy36huNDz96/RShfgtohK3AtjK2D1s44k0Kw6Co5IsKQbVrVK5aGcMZZfSGfrohUwHN0o3A++uu31OK2FVQahW9omxJIV1V4fnQJEYCkw0Om+xHJh7NAUTf9H5cA4DmHlK4cTGCEtzNwZkBXt6e8UKVELyhAuTc1X4mDlud6laE+tvk2INndxgkjXTFMS2vkXnMD/N63VeCN1qPQRmeVRBc4Oud9a+ZcswtbLJC9Eevpvp2LiF3EaP5XNOwJxd5Hods2HdKOFBgeEfnmz/iMx1G2d/4Wy987eDi816whJtgrvFym2NKgJe19THP+cxk9A+bg
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5009.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39850400004)(8936002)(38350700002)(16526019)(5660300002)(186003)(31696002)(38100700002)(478600001)(8676002)(52116002)(966005)(86362001)(66556008)(66476007)(4744005)(316002)(6486002)(16576012)(36756003)(6666004)(66946007)(83380400001)(26005)(6706004)(31686004)(2906002)(2616005)(956004)(53546011)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?TmFkRFRWRXBOZWxUanlMNmE2Z1JsNTErTDhPMk85aElRelo2eDU1a2x0MGJK?=
 =?utf-8?B?YVBQYVc0ZHBUc0tTTjAxSkc3Y3I3OHM0YmZEL08yMHFJanhtYWJiYVVXT0VG?=
 =?utf-8?B?TytoZTlxVTVUOXlSMEtjbVZRSEV3THRxOTB5WE1sNVBxT3RVK3lvY2hkQ3VB?=
 =?utf-8?B?Ym5YR1U3eUk1ZVpWcUdQK1NVd004Ui9JWklCdm5HRGhQRlNHR0oxbTRPZC9U?=
 =?utf-8?B?OEFvUEZURmFtS3ZTU3lvZUE0VW9BWk1TLytPeG1BOTNOOHFZbWdYU2YxQlVy?=
 =?utf-8?B?bWc5TDJ4cDNCQnVkSWlZa0lFdW1pTlZ2bGxOVFFBQTNka0ROTWtBdThhNmho?=
 =?utf-8?B?MGRaNUpPdjgvRWZQbnhnTTRRcTdXL2F0a29yVUxtVU4rMHdPdlBES21TK0x3?=
 =?utf-8?B?eVBoaGFVZnlqM0J2TE90UVdjMXhndEhIRThvYjNVRnJudVFDYnlxZEdXK2hl?=
 =?utf-8?B?RzR2MVc3ak5SN3ZtU2IwU0VMVjhKMGNiTGZLR3FGdEZHZnpKNUtmdzhib1Zn?=
 =?utf-8?B?Yk9maXJJTGp3WmNrek1aWlpURS9iK0ZvaGQxeGxadUhEM3hGdkVpWm9WWFM3?=
 =?utf-8?B?YVNUbmgzR1dpZVMzNmx3N01hVEFFYXErZU85SW83UTJRRTdDZldudmtsZXAz?=
 =?utf-8?B?NnVsSXpmaWhySU4yd3h0d3NtZjl3V2swSlZiMzFGM3JDYTRZL0MvZjhESmh6?=
 =?utf-8?B?akFubTNUaUh5L09yK1R0b0ZNSkxQTVdNcnhkM1VGdUFXbWljTVpIbW1ZNHJk?=
 =?utf-8?B?Q3BCUVpuZGNOcHpNaHBwaHVFVUhCTG85aEhseXN3NUxYNnY2TkZJeTN5aXpw?=
 =?utf-8?B?WDBSeExMY0hXNEEva0IwTFNVU0pZb0U2VEF6V3J6Y3hza2Q0OERNVUVhOHh1?=
 =?utf-8?B?RGx6T0NVNnZDU3FGeFM1enJxb3hyNDNkdXBVMVJBcWVscVRHL0FUalBka1Bo?=
 =?utf-8?B?THZGU0NxRkdTSWtSaHZleGtKQVgwVXU0MnRQRGVRajNJbVcxcUZ1bE9TMzZy?=
 =?utf-8?B?M3FiakJaRkgvZCtnaGd4SmNJTTAzT0dOcGJZbkJNckMxWDJhRkJJN3VJb082?=
 =?utf-8?B?STdKSUtGYXh3WGNkM2pQak56MS9HLzVVUG9tR29sL2tBUDVhYnBIVUhNb1Ru?=
 =?utf-8?B?K1VPMjNaSlNzajJCU1NSM1BMVXl1VWUxR05lcTFZUlVLbkdoZEp6eUY3Mkt3?=
 =?utf-8?B?UlZCTmhIRFVmL09ZdWViRW5sR2R4LzdKWkdnVGc4Qk56OUVjRnhPeFUzWW9l?=
 =?utf-8?B?VC8vZ1V1VkpWZkZkQ1hwdlJiRDVRbTgyc1pobHF5am5udXNMY3lEMVhielg4?=
 =?utf-8?B?d0lzY0RvZi9kd0xGaCtkMG9KdnJiMzNKOGpXSzhHZUxGTkx5c0U3OUNBeHZw?=
 =?utf-8?B?dEV6NmN6QkRwelFVUnJLMXRoZXdUb0Fnc1RoNU9HSTV3S2lJWEZoaGlvQlBp?=
 =?utf-8?B?OHN4bTFoQllUOVJwcmdDSWRobTZFZ1pvZE1vTEhjTmJueHUwNXVqK3ZvREl1?=
 =?utf-8?B?NlhxbTYwVUd6UnVKMEpXZVdnbHhZS1lqRi9lbUpmZ1NrdmtqNkVLRzVsMkZK?=
 =?utf-8?B?MXNLWmg0aDRhWWsrTDI1amUvSzJPb2NVaTIvRnFFem5Ebk5sZUdvcUwwTC8x?=
 =?utf-8?B?TzdrdDVVcWJ1eU54R252V0RSVXUwRGI3V3JRUmhIc2phOGowN2VUY3MxV1Vr?=
 =?utf-8?B?b2NkYUZJam9HeXFEU0d1UjlRTld4QTlMK0E5M2FSRytldjlOWTNnakxQZGNQ?=
 =?utf-8?Q?FY1lqOhH/AAqPULQo+/+HLlWr+0WiRSmWkBftpw?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e62e32-5b4a-4a81-a9c3-08d91aa28eb1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 08:46:13.5327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mzi0+KCy8H1sGyuKyw/D9Gq/EPip9JVOA3NyrRs6n0w1WBnfM9ttCZmYiCX7ZCsReOLIGI6iQUzf2Q33Y1ZEEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1904
X-Proofpoint-GUID: fERaHEWFEJL0xhsiJMhQMZtxyKfsIbOD
X-Proofpoint-ORIG-GUID: fERaHEWFEJL0xhsiJMhQMZtxyKfsIbOD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-19_04:2021-05-18,2021-05-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105190066
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 5/19/21 4:03 PM, Richard Purdie wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> On Wed, 2021-05-19 at 10:05 +0800, Yu, Mingli wrote:
>> Ping.
> 
> I replied yesterday:
> 
> https://urldefense.com/v3/__https://lists.openembedded.org/g/bitbake-devel/message/12322__;!!AjveYdw8EvQ!Mn-KtCO9cVXaGpBP5QLknAHnTBlqZKyJx-DrSU4Cw_PaCNJWAGStDcj3SIZA3PkcTdw$
> 
> Daily pings are not going to go down too well with me FWIW particularly
> when you've not looked at the reply I took time to write and basically
> ignored my previous feedback too.

Sorry for the noise, seems my email client has some problems here.

I'm working on how to add the test case appropriately.

Thanks,

> 
> Cheers,
> 
> Richard
> 
