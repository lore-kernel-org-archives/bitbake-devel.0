Return-Path: <trevor.gamblin@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4D4C433EF
	for <webhook@archiver.kernel.org>; Tue,  9 Nov 2021 19:21:29 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web09.1451.1636485688196544853
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Nov 2021 11:21:28 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriver.com
 header.s=pps06212021 header.b=V8pp2uug;
 spf=pass (domain: windriver.com, ip: 205.220.178.238,
 mailfrom: prvs=6947a0e95d=trevor.gamblin@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id
 1A9DSHpH021366
	for <bitbake-devel@lists.openembedded.org>; Tue, 9 Nov 2021 19:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=PPS06212021;
 bh=4Tom4wcpyKxLe8uroTLDES3QHEIW5Z11KvvasaoORag=;
 b=V8pp2uugDjzTl0l64Vki8B3KWsGomKpaf3GOXwJg0nAjUJqlAsiXOdBQwAKaCjNepGng
 tbwrYHSLembPbhvbvpAFrvQowNceL+as4/OO266Oc1KmfEVKWptR9y7nvxZDqdr8q18a
 nKnxcdiyY5hToh+U/5r4dEjUn1+DmigTpaIPR8aFB5GhiGOpYBljhc7hGFgV7lBNwBJI
 95cJgWKsXfFTftdr92JVHzCOBU5Y4qvbkLlQy6TS1LKtv3ukUXrRfHFsDApvvX8Gnwzk
 r/SocLdh2uednKcQzfhdS1xCdJ78YdaNwiDYpCbmfMLhyp45LPzewkHt200rt8RguINp bw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3c7sf1rdxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 19:21:26 +0000
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.16.1.2/8.16.1.2) with ESMTP id 1A9JLP0u025948
	for <bitbake-devel@lists.openembedded.org>; Tue, 9 Nov 2021 19:21:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3c7sf1rdxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Nov 2021 19:21:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vq8qHc+X2YjI2vp3Y244duIUcT7KSCdqH0Xc2uo6lwdAFKeoIt3g5HF2yhQhY56/N4CbZuzkR2QA7/HlpWNGyNwy3Xj/qYs3RjVJEjLTQfoZ66ji3iWzgMOa59X3ayX8sFgBoqa7G3HP88XxT2FJVuEyOh13qLXIhZyNnSB45Nqez1JuNTFJUG4STqRVy/CkwWVgeS+FCU/HofRBewQirtsrKvUSbFcNa7xbfW3rhYW4iSWLf5fHvhVuDwageJBFZ9ZZMYKfFoyKOmm/GLyA9bi34SGGicMB36zPBIqNTF679yG5GwYMWjR6sISPXD11fzEV6XM3ZWruUTuzSPI7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Tom4wcpyKxLe8uroTLDES3QHEIW5Z11KvvasaoORag=;
 b=GUWO/5DZGOlJeOigUL0bf7E0qlzXPWQjYLIR88h5xpDAwWaiUXMT4a60oKpHscbAHtk/LdPjZNSnOc8BS83sv6CuDrnExGgAafE1tnOltIOcFGRIK4HLCaF0wr+BkoqbEISL4/v6DNjNpIme4eneOlgzKDlFKwRicF4Np0x/vm/d6BtfoKkBC40BqeLPOVQTn+bbAl5LCFMvvTRzaM8RMbHxzMdTLO513/r1rMTojQ7jmRXxkDTYfLGIaLLCrMt/lc80W//L5r32FwXMQsMvo0J+2IINxLDhgV9dDF9Rp+slV7kmMOQezcnMjoLtLi4rLLPYGuOY2bQ9ufhTUO5HbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB3909.namprd11.prod.outlook.com (2603:10b6:a03:191::13)
 by SJ0PR11MB4830.namprd11.prod.outlook.com (2603:10b6:a03:2d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Tue, 9 Nov
 2021 19:21:22 +0000
Received: from BY5PR11MB3909.namprd11.prod.outlook.com
 ([fe80::ccb2:28ab:f000:8440]) by BY5PR11MB3909.namprd11.prod.outlook.com
 ([fe80::ccb2:28ab:f000:8440%3]) with mapi id 15.20.4669.016; Tue, 9 Nov 2021
 19:21:21 +0000
Content-Type: multipart/alternative;
 boundary="------------M00X6vJBY7q4BXhDLZR66MTs"
Message-ID: <f034fb4d-9dea-f24a-b5ae-af9b305ef8f3@windriver.com>
Date: Tue, 9 Nov 2021 14:21:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [bitbake-devel] bitbake style/workflow
Content-Language: en-US
To: Marius Kriegerowski <marius.kriegerowski@gmail.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>, Mikko.Rapeli@bmw.de,
        Alexander Kanavin <alex.kanavin@gmail.com>,
        bitbake-devel <bitbake-devel@lists.openembedded.org>
References: 
 <CAMaS9hNh8iztUquiPddua-6Lu0nLzU832YwHG+rw284zqUzEZQ@mail.gmail.com>
 <d5683f0ad0dd0185309d5d8feea6c7e7141fa343.camel@linuxfoundation.org>
 <CAMaS9hNpp9QsUqkpXvNj_F5R4aQoe+qHg+_mtxnZRL0PoAYaGw@mail.gmail.com>
 <589e9863e78ed9f8234a3756b37ffb979daa770c.camel@linuxfoundation.org>
 <CANNYZj8_zPhh_XCZrxaPvXd_Oz5kzbzHNLvT6qzvtztquKA0ew@mail.gmail.com>
 <CAMaS9hO8yU+T3tKb-dQj-DFx-vqGsUTLc7Jkta1sAM+eDr45BA@mail.gmail.com>
 <CANNYZj9G7YaHpQgCzVZaCjTTAmNXgEiGnkf-GyrXzbxckqp4oA@mail.gmail.com>
 <CAMaS9hNwT5iK8X3NKAq6cJq1qk4mHS99a36kTogc6_=fDHALFA@mail.gmail.com>
 <YYo2KsoUeMTZ6y5C@korppu> <16B5D5AA827DA237.27841@lists.openembedded.org>
 <16B5D6BAD1F7C3E6.27841@lists.openembedded.org>
 <CAMaS9hNRUsmWdXNaJV9E8rKCw6g2OzdZd4U8s6k+0c7VYo8P9g@mail.gmail.com>
 <e5b2f8439e5aab93a2841728e00650185ff60573.camel@linuxfoundation.org>
 <16B5E0648E5826A2.410@lists.openembedded.org>
 <CAMaS9hPn5k2w+MXzPE6jLfkYJmQi8CMTNbhtUu64Vn6avs-e0w@mail.gmail.com>
From: Trevor Gamblin <trevor.gamblin@windriver.com>
In-Reply-To: 
 <CAMaS9hPn5k2w+MXzPE6jLfkYJmQi8CMTNbhtUu64Vn6avs-e0w@mail.gmail.com>
X-ClientProxiedBy: YT3PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::16) To BY5PR11MB3909.namprd11.prod.outlook.com
 (2603:10b6:a03:191::13)
MIME-Version: 1.0
Received: from [IPV6:2607:fea8:c29d:d7c0::e120] (2607:fea8:c29d:d7c0::e120) by
 YT3PR01CA0085.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:84::16) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Tue, 9 Nov 2021 19:21:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7991077f-46be-4e40-a3ff-08d9a3b61d0a
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4830:
X-Microsoft-Antispam-PRVS: 
	<SJ0PR11MB4830A5E46CDBCD5B5CBC62469F929@SJ0PR11MB4830.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	doc6uV+0SZoInlm++vUG4z0jKhUv+q5eAL37G549cLFsTAnGDGkhc5jWLaVtgr92Vx7Qf9v8cyIG3huTdlIagGiU0tULaDsRF+RPYD4TmXyUgOqJfEYQNd2KNxIEKuqhPxuFAiw0REpfyIA3J7j7ySxVIUDWliBmRRDd9d3q9bTjROGOjGcXUDg33OuK6tkWk2ZUBTMPQwU9B9vWfwNhUIWdo4rl05MPw72Ct3HQshqZIJUUC2NU2rZqZRHI5kk1QxibTjxuk9uha05yzzsPk5rz6vNfoUQkNm9ZJOCKmHslQU8TeODaPhUqZMw3JINY1oWVWlGJZQFzQsUO+oWMqz8BR4idsaLDqeQgnsg6EY6jehMG8k8nU5+lVSyLZhn9ezxgyqTlysDJa1ArsVlsENYzMwRJOQQHE2kO+x60BGfK6rYiU2a/E+5bh2nMEcPJxuVEJYpWdZn1mQv/qeJrYJK1CfKXz0uNTjcLyzgZ4yqDFz29S0AFRbIgEfymIbD4OHjQD8BYNdXY7j+s2w+wAUzujING3f2FaJGYjMxRcxR6wl/DPsJo8FzUu5k6MWrKfIEQ2BFneHdNL2rblyXmCU+6f88sfXq7vjYe3y98mEhpC2jEqY3Ug8CiUkyz/KKHYnpXNWck9j7s0BKx7S1KKlelOgycjS56TKiOHN0YUexrfK2duOaU+r+sIENvh2ZXk9iWHAFH3U/OqRkhMCxjWvOS1NrOS8AcwLg+jT/mo3qWnfAtSS6hdHRngQH58BAehp3HCd/Osr9RCRXFIDu8xzMUQqujibrZfyGUoWQ24t06kmVKjSsDsaEuOuIsMskJxLXRtu4IcnC5umCvRjtaY4AczQQtGyhwyizxRPtfmJI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3909.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66476007)(66556008)(6916009)(86362001)(38100700002)(31686004)(6486002)(508600001)(54906003)(2906002)(83380400001)(966005)(5660300002)(36756003)(53546011)(186003)(166002)(44832011)(4326008)(8936002)(8676002)(316002)(2616005)(33964004)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MGZKNWpWRllRUzAva3FuNWUzdFdmSVFQRExuTlhZQWVFUjlZa3Rhc3dUSzlx?=
 =?utf-8?B?KzB5REgwUnIraXRPSDFTTjBBa2lJTDdGZnZINXdmbE1oa0ovWHIySXR5MlRT?=
 =?utf-8?B?NFpDcHk4UlpyZVdXVDJPcmE3cXdCVCtIcmZzY0s2RzFOcHc4Q2k2YTg3anVK?=
 =?utf-8?B?a0xJdCtCYjlhZnp1QnpraTFmMFFJSkVrcjd1ZTJMc1p5di9qc3BEamVCVmZP?=
 =?utf-8?B?ZGtySU9hWkVOQWhROWxkVU1FUnYyNE1XT1BMOVNXR1pyWUUwZ254V0s2elNO?=
 =?utf-8?B?T1hwUHozZXJlTGpVa1ZqQ3NHdlJVRi8wZnVWamNpaEI0TG5kYW0vdVZSN1Vq?=
 =?utf-8?B?TTcvclZzZ3FnV0RLU0NXdWZJUXpzQlI1WWJCOUpTMjgrTDUyOVNmYjAzd0F0?=
 =?utf-8?B?MUZtRDdWMDByM0JnekxVUnFlL2c3dTM3NzdROGJGM0ZqYWdEdlhmMVpsUFRT?=
 =?utf-8?B?YVFHbWlvVy9YTzFWREgycFVsVEM0OWtOcjZpK1VaY3dkUXJsUlZZSmprazBV?=
 =?utf-8?B?VU9LOW9sTUF4dlkzbDdIUWZ2aVdMOG1PZEtxV21aWWU5QTUvNWQwMWwybU9D?=
 =?utf-8?B?YjBJR09wcEpRcjUwS1UvVkJadmZheVNEelpHSGQrcGFselpBbWZpUkNqNFJZ?=
 =?utf-8?B?U0hGQ25IREVDVmJPcWNEcVRJQ3k3ZDhHc1VNZlhOK09ROVYySTNoN3hEOWtp?=
 =?utf-8?B?MDlJcGVocUFsQ1dLdnBtUjZ4ZHE2Q0YwRmZobmp5RGZpR3d5L2NGYllxSWph?=
 =?utf-8?B?eVBPK25wcXhIWnV1TWp3ZE5QMHUyU2lyRnp6YXlSeTFDYUZMaE90cDBNSFNs?=
 =?utf-8?B?UnVHM2JlYVRzTHFUbTJjcWpnTmMrSEcvWURjVUx2QVlUVDZLeFBjWGs5MU1T?=
 =?utf-8?B?Z203NDJ3TDFyYjR2cTBRVWVoYVluQzZ1amorK1I5OE5xSUtTZi9PL0RHdERU?=
 =?utf-8?B?bnNRVDc2TzQvTE1sT0hva0dTdy9ZT3dvSS82NnZ4dE9JSnhsOUUvYnJ6V255?=
 =?utf-8?B?QVJ4TkJRdEpiejMzM1FVeXBGZFRPUEJuaWtXMkFTZDJZV3NsZzdjWEdSbUJk?=
 =?utf-8?B?N3NFWCtCVFN3Wll0SjlkVlJhYkhTZFNMTU1zNmwzWk5uSXhlNkg4M21lU2lZ?=
 =?utf-8?B?YTBkOHB4RDRmQms2eVFSU2preHJFMnJ5OWVBajFSRkNUSWo3cXlHRnZkKys1?=
 =?utf-8?B?Rk5JejJkODFYazgwSzVjZHNNSEpMcE9uV3JYa2lXVERuZFBLRlhVN3hINUxy?=
 =?utf-8?B?aTdDdVVvZy92aWVDTmtHb1g1aWlFQVk4ZXEyM0g0OXE4T290TXhIbHlENnJv?=
 =?utf-8?B?dk8wY2xUUnk2OEIwSm91QXVVVXVpZmtFTUExTUo2R0JNOVNUNHdZZXRYLzdI?=
 =?utf-8?B?RWhzLzRKNkhIanI4djNyOU94anVYSHZMR3YvQWF5Ulc4YWltNTFKTzVmSjlT?=
 =?utf-8?B?S0t1UGlqR2F6SW0zTDZSR2lqQTJLaitCSHgrWUMyVi9XQWVoUGZHbjVEdmQv?=
 =?utf-8?B?WGZpcEFEYlgyczFtakVSQmJ3NDNSVlpTbXE3alNnZ1BRU3NBVUw4UnluWi9O?=
 =?utf-8?B?dFppMzFGOEt0UnlGcEVoQWxKMWtGUTcxMXhVa0czZ3VFS0l1MUtDalRmNmZX?=
 =?utf-8?B?MzZ4eGpVZmNVVGZlTE1vbm93ZnVNNTlHckZTclB1aFdyQTdiLzZnb3VkTnVZ?=
 =?utf-8?B?cndZVFprQzI0MjFKem1uK0RJRUowZUtPZlRlQmx3N2NyLy80Z2pIcEQ2MTd1?=
 =?utf-8?B?cTZRSFFxWVEvOFVxbTZpSjYvVWQyNzU5Z09qOHlIRDkxRUhTdkdoVU83OG1w?=
 =?utf-8?B?MmN3N2xxaFNuT09Fb1NGVnFMVHVma0FvR2Y4dElrOWN2dkYvVit6N05Nb3o5?=
 =?utf-8?B?aUtaSW9GVHRzY0Urd3RyOXZ6QmRpVUEzTEVTQ3VPUUFJbGFxZHR1ZE1QbHZq?=
 =?utf-8?B?bjlqK3JxWWozZFlGRllOWkRmeGp5SXRxcTlPbWRwRHJKOHFKbXdoRVRqVFNp?=
 =?utf-8?B?RmpJS0R5MHVLdzJnTmxUem9aRVhPTFV4RFZqaE9WQnBxc2Vsd2pHVUxQbkho?=
 =?utf-8?B?Q29MRkpMS1BQZ0s1eSttWFdwbHR3SldhdE1KY0VxVXdtMGZRMnE0TXN6K3l4?=
 =?utf-8?B?YW1ReHBsbGhKZXJSYjNrTGl3UmQ3U2V4UzEvUU9hTnBHd0Y1Y3htbVRvQ055?=
 =?utf-8?B?WEdDY0h6OFlQcTNQb0hSeGJkWW5GTlhLd05jK1pzWFpIZnVGYjN6a2xwS1Jp?=
 =?utf-8?B?ajQ2UmJ6R1JUNFhKaktTQ3NvREFJSE1RRlJPcWQwSWpFZE1DenpoaGhtVDZI?=
 =?utf-8?Q?92BBUB+6nVoAotAcPJ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7991077f-46be-4e40-a3ff-08d9a3b61d0a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3909.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 19:21:21.7816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 ZIQMf+GBgLM0hgL7CFrqTyolfT5rcP5NtFrFIUW3UrzWwPjn+perItRPhDyzVgi252jFgyENt03FbPDj2boerPzYXlSzdE9IRn6XDynLubo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4830
X-Proofpoint-GUID: 8jH6rgXx9JM-XXROvXVUGETTTzwZT47P
X-Proofpoint-ORIG-GUID: 8ADzKAr_Qzla_fAFSTzKWBlrL9C9TUsE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-09_05,2021-11-08_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0
 clxscore=1011 mlxscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090109
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 09 Nov 2021 19:21:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12985

--------------M00X6vJBY7q4BXhDLZR66MTs
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-0064b401.pphosted.com id 1A9DSHpH021366


On 2021-11-09 07:31, Marius Kriegerowski wrote:
>
> **[Please note: This e-mail is from an EXTERNAL e-mail address]
>
> Sorry for double-posting BTW. Hit the resend button after I had an=20
> issue with the local vpn here.
>
> Funny thing is: I only get feedback from people who contributed for=20
> 10+ years or they of themselves that they are old. Can the early=20
> contributors that are <35 yrs old and recently started contributing=20
> speak up and share their thoughts? That would be very appreciated.

33 year-old here with about 2.5 years time working on YP/OE, including=20
maintaining meta-python (which I send PRs for via GitHub). The process=20
used for patches was foreign and seemed a bit excessive to me at first,=20
but that changed quickly. I have to echo Mikko's response - the mailing=20
lists are convenient for me because they consist of mostly text records=20
that I can search and filter as needed, and that I can also keep local=20
backups of for longer-term referencing. There is situational appeal to=20
using newer CI tools and interfaces where possible, but when it comes to=20
discussion and code review I really don't want more than basic text to=20
have to deal with for a combination of reasons, including but not=20
limited to load times/site status/resource usage/over-stimulation/etc.=20
that would come with relying on a web UI and cloud services for tracking=20
multiple discussions and repositories at once.

For the record, I use Thunderbird as my client. My workflow to create=20
PRs for meta-openembedded is also automated using Tekton and a few Bash=20
scripts.

- Trevor

>
> Anyways, time for lunch. I'll leave it at that I think.
>
> Am Di., 9. Nov. 2021 um 13:26=C2=A0Uhr schrieb Marius Kriegerowski via=20
> lists.openembedded.org=20
> <https://urldefense.com/v3/__http://lists.openembedded.org__;!!AjveYdw8=
EvQ!IvcyputSb5rOHUrgBdxvE6sfTciN5PFoyCoiylG5E91rcO8XIWZdicYKmRKm-wT1GASef=
w$>=20
> <marius.kriegerowski=3Dgmail.com@lists.openembedded.org>:
>
>     Point is: I actually don't care if you merge or use the MR to
>     create a patch for peer review as long as I don't have to use email=
...
>
>     If the process that kraj is doing manually can be automated then
>     this would combine the best of both worlds :thumbsup:
>
>     Marius
>
>
>     Am Di., 9. Nov. 2021 um 13:21=C2=A0Uhr schrieb Richard Purdie
>     <richard.purdie@linuxfoundation.org>:
>
>         On Tue, 2021-11-09 at 12:56 +0100, Marius Kriegerowski wrote:
>         > I'm sure there is a readon not to hit the merge button but
>         instead doing that
>         > manually which I don't understand.
>
>         No, you don't understand and it is actually a *really*
>         important difference.
>
>         We are a community project with wide peer review. *Nobody*
>         gets to merge changes
>         without that peer review. I may be the maintainer for some of
>         it but even my own
>         patches get peer review. This means there is no single "this
>         patch can merge"
>         point without it having been on the mailing list for potential
>         discussion.
>
>         If a patch gets sent via the github MR, someone needs to take
>         that, put it on
>         the mailing list and ensure the community gets to review it.
>         Khem has kindly
>         taken on that role for some patches which is his choice. If
>         there is review
>         feedback, it puts him in a tricky position since he then has
>         to merge that back
>         to the github discussion somehow. We do not encourage this and
>         in the case of
>         the repositories I maintain, I simply do not have the
>         bandwidth to try and do
>         this for multiple github MRs.
>
>         I understand it is easier for people to submit but our
>         processes simply don't
>         scale to that and people would get *very* upset if changes
>         through github MRs
>         were bypassing normal peer review. This is why Khem cannot
>         simply hit the merge
>         button and why our other repos don't support that workflow.
>
>         Cheers,
>
>         Richard
>
>
>
>
>
>
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12969):https://lists.openembedded.org/g/bitbake-dev=
el/message/12969
> Mute This Topic:https://lists.openembedded.org/mt/86911583/3616776
> Group Owner:bitbake-devel+owner@lists.openembedded.org
> Unsubscribe:https://lists.openembedded.org/g/bitbake-devel/unsub  [trev=
or.gamblin@windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
--------------M00X6vJBY7q4BXhDLZR66MTs
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 2021-11-09 07:31, Marius
      Kriegerowski wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CAMaS9hPn5k2w+MXzPE6jLfkYJmQi8CMTNbhtUu64Vn6avs-e0w@mail.gmail.com">
      
      <div style="border:solid #9C6500 1.0pt;padding:2.0pt 2.0pt 2.0pt
        2.0pt">
        <p class="MsoNormal" style="line-height:12.0pt;background:#FFEB9C"><b><span style="font-size:10.0pt;color:#9C6500"></span></b><span style="font-size:10.0pt;color:red">[Please note: This e-mail
            is from an EXTERNAL e-mail address]<o:p></o:p></span></p>
      </div>
      <div>
        <div dir="ltr">
          <div>Sorry for double-posting BTW. Hit the resend button after
            I had an issue with the local vpn here.</div>
          <div><br>
          </div>
          <div>Funny thing is: I only get feedback from people who
            contributed for 10+ years or they of themselves that they
            are old. Can the early contributors that are &lt;35 yrs old
            and recently started contributing speak up and share their
            thoughts? That would be very appreciated.</div>
        </div>
      </div>
    </blockquote>
    <p>33 year-old here with about 2.5 years time working on YP/OE,
      including maintaining meta-python (which I send PRs for via
      GitHub). The process used for patches was foreign and seemed a bit
      excessive to me at first, but that changed quickly. I have to echo
      Mikko's response - the mailing lists are convenient for me because
      they consist of mostly text records that I can search and filter
      as needed, and that I can also keep local backups of for
      longer-term referencing. There is situational appeal to using
      newer CI tools and interfaces where possible, but when it comes to
      discussion and code review I really don't want more than basic
      text to have to deal with for a combination of reasons, including
      but not limited to load times/site status/resource
      usage/over-stimulation/etc. that would come with relying on a web
      UI and cloud services for tracking multiple discussions and
      repositories at once. <br>
    </p>
    <p>For the record, I use Thunderbird as my client. My workflow to
      create PRs for meta-openembedded is also automated using Tekton
      and a few Bash scripts.</p>
    <p>- Trevor<br>
    </p>
    <blockquote type="cite" cite="mid:CAMaS9hPn5k2w+MXzPE6jLfkYJmQi8CMTNbhtUu64Vn6avs-e0w@mail.gmail.com">
      <div>
        <div dir="ltr">
          <div><br>
          </div>
          <div>Anyways, time for lunch. I'll leave it at that I think.<br>
          </div>
        </div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">Am Di., 9. Nov. 2021 um
            13:26&nbsp;Uhr schrieb Marius Kriegerowski via
            <a href="https://urldefense.com/v3/__http://lists.openembedded.org__;!!AjveYdw8EvQ!IvcyputSb5rOHUrgBdxvE6sfTciN5PFoyCoiylG5E91rcO8XIWZdicYKmRKm-wT1GASefw$" moz-do-not-send="true">
              lists.openembedded.org</a> &lt;marius.kriegerowski=<a href="mailto:gmail.com@lists.openembedded.org" moz-do-not-send="true" class="moz-txt-link-freetext">gmail.com@lists.openembedded.org</a>&gt;:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <div dir="ltr">
              <div>Point is: I actually don't care if you merge or use
                the MR to create a patch for peer review as long as I
                don't have to use email...</div>
              <div><br>
              </div>
              <div>If the process that kraj is doing manually can be
                automated then this would combine the best of both
                worlds :thumbsup:</div>
              <div><br>
              </div>
              <div>Marius</div>
              <div><br>
              </div>
            </div>
            <br>
            <div class="gmail_quote">
              <div dir="ltr" class="gmail_attr">Am Di., 9. Nov. 2021 um
                13:21&nbsp;Uhr schrieb Richard Purdie &lt;<a href="mailto:richard.purdie@linuxfoundation.org" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">richard.purdie@linuxfoundation.org</a>&gt;:<br>
              </div>
              <blockquote class="gmail_quote" style="margin:0px 0px 0px
                0.8ex;border-left:1px solid
                rgb(204,204,204);padding-left:1ex">
                On Tue, 2021-11-09 at 12:56 +0100, Marius Kriegerowski
                wrote:<br>
                &gt; I'm sure there is a readon not to hit the merge
                button but instead doing that<br>
                &gt; manually which I don't understand.<br>
                <br>
                No, you don't understand and it is actually a *really*
                important difference.<br>
                <br>
                We are a community project with wide peer review.
                *Nobody* gets to merge changes<br>
                without that peer review. I may be the maintainer for
                some of it but even my own<br>
                patches get peer review. This means there is no single
                &quot;this patch can merge&quot;<br>
                point without it having been on the mailing list for
                potential discussion.<br>
                <br>
                If a patch gets sent via the github MR, someone needs to
                take that, put it on<br>
                the mailing list and ensure the community gets to review
                it. Khem has kindly<br>
                taken on that role for some patches which is his choice.
                If there is review<br>
                feedback, it puts him in a tricky position since he then
                has to merge that back<br>
                to the github discussion somehow. We do not encourage
                this and in the case of<br>
                the repositories I maintain, I simply do not have the
                bandwidth to try and do<br>
                this for multiple github MRs.<br>
                <br>
                I understand it is easier for people to submit but our
                processes simply don't<br>
                scale to that and people would get *very* upset if
                changes through github MRs<br>
                were bypassing normal peer review. This is why Khem
                cannot simply hit the merge<br>
                button and why our other repos don't support that
                workflow.<br>
                <br>
                Cheers,<br>
                <br>
                Richard<br>
                <br>
                <br>
                <br>
                <br>
                <br>
              </blockquote>
            </div>
            <br>
            <br>
            <br>
          </blockquote>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">
-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.
View/Reply Online (#12969): <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/message/12969">https://lists.openembedded.org/g/bitbake-devel/message/12969</a>
Mute This Topic: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/mt/86911583/3616776">https://lists.openembedded.org/mt/86911583/3616776</a>
Group Owner: <a class="moz-txt-link-abbreviated" href="mailto:bitbake-devel+owner@lists.openembedded.org">bitbake-devel+owner@lists.openembedded.org</a>
Unsubscribe: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/unsub">https://lists.openembedded.org/g/bitbake-devel/unsub</a> [<a class="moz-txt-link-abbreviated" href="mailto:trevor.gamblin@windriver.com">trevor.gamblin@windriver.com</a>]
-=-=-=-=-=-=-=-=-=-=-=-

</pre>
    </blockquote>
  </body>
</html>
--------------M00X6vJBY7q4BXhDLZR66MTs--

