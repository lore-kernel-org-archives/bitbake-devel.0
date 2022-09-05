Return-Path: <mingli.yu@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42971C54EE9
	for <webhook@archiver.kernel.org>; Mon,  5 Sep 2022 06:00:41 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.21862.1662357631537432363
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 04 Sep 2022 23:00:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=oUaXL9PF;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.178.238,
 mailfrom: prvs=624756f917=mingli.yu@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id
 2855pn8G027451
	for <bitbake-devel@lists.openembedded.org>; Mon, 5 Sep 2022 06:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=message-id : date
 : subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=g7MUvnXFc/mHu3VF6bNQSLAcY7BDssaZP5I8fbA34FA=;
 b=oUaXL9PFOP7O4EjxmCcffBOpjUro4l7nghgZ4QVllzPAYznGTSoCgZNXjqHGbEytNOXk
 WAvHOtiPMuAudHFBkpWoqNE+fGji9BV21N655kxnccdDfqhgCY/e/FmsHaKzzwcszIMv
 EdumtJUCD8jYmM7M6+erYn/eg+QzFXXa6twf3YC5o5uLnJRMVQ/uum6VIEsQwFR9vKE2
 7LkrBeNaiJcCv65K21SteO403Ip3RN5JxumXMIxnlx0giQtZcxfle9EJSmnK0Vv1Ez1s
 EvNVzYeV71n1wUTBPj4PhBItTa38FKupZopeIO++zvXVgv/rI+xzkAe/VBPp0b9LPySY 8A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3jbww79djd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 05 Sep 2022 06:00:30 +0000
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28560UYx012623
	for <bitbake-devel@lists.openembedded.org>; Mon, 5 Sep 2022 06:00:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3jbww79djc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Sep 2022 06:00:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpF4NS/+7q7XEQ+ZSy5XgBibBsxQftD+BwfPBCFky0EFo44TnfGpGGj9PVbLYrwgIkP6jo+SbN4WvrYJ5dfq+MxJjdm4v4RgsUnMDCqLP/jQAxvYpWD3KDIskPYE+P8ODx8CgyDF9q+mDFBcSLsdUpqyZAMMpcE8B170q3GikVTOafC+DZM1+Om8Mxz6aWdFx38aVTyfWx7AOmf0K40rMNGYyMVKut6wXJD8RAN1Rg04iDaDf5lkg74049/HYDTP8otFK6G011z1VIKkBT5en1upDScm3Q5HGIgRA0r3fUTB5se/PARDnbgxaaQeVVzQQWcXyyrVKvPCZmBfzeJ7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7MUvnXFc/mHu3VF6bNQSLAcY7BDssaZP5I8fbA34FA=;
 b=hFA1EWJS9vp4n11sx5G0jGFyBKn6KYnsEcNTOmq2ukO/bE7kSUFB7rgBnEPclJ3uZLxVxUpPh+HTdsThOnqhnIFMt28oOcErbucxuymSrAieGFQlUBa8TrIOLu2l8dRr1iGgskJOwaEZHTLfuW6M85BYLisNOKifqN162sk24QKE7QHkofOU5sGAp0x4n/G1W6yFybRi8eMoahIfh5BxRKNXbz2+1yqMMJWT00SuMqh7ylmP5S2OZvNDIHM7RGatMXJZsLVy2rFaPhAJLaqW3r6cwzcxgWe7W0SVckdMC7cXrtCL3g5RRy5f654l1fJxsMq8RUs1se1vOBZvRQDttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO1PR11MB5009.namprd11.prod.outlook.com (2603:10b6:303:9e::11)
 by BN7PR11MB2644.namprd11.prod.outlook.com (2603:10b6:406:ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 06:00:28 +0000
Received: from CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::889e:9ec4:d444:e687]) by CO1PR11MB5009.namprd11.prod.outlook.com
 ([fe80::889e:9ec4:d444:e687%3]) with mapi id 15.20.5588.018; Mon, 5 Sep 2022
 06:00:28 +0000
Message-ID: <db88f024-1ccc-19fa-9f92-e0addce3b2cc@windriver.com>
Date: Mon, 5 Sep 2022 14:00:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [bitbake-devel] [PATCH] fetch: use BPN instead
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        Christopher Larson <kergoth@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
References: <170B7854B4242295.1911@lists.openembedded.org>
 <0abf1f86-d023-a445-0758-436f4767e7ef@windriver.com>
 <CABcZAN=rSxhgebWTScxW6tL6+f7k-natKstYWyBVSb11rz1=wA@mail.gmail.com>
 <7bec4de4e5c8ae8db193bfc6fb3f15e9388c0512.camel@linuxfoundation.org>
From: "Yu, Mingli" <mingli.yu@windriver.com>
In-Reply-To: 
 <7bec4de4e5c8ae8db193bfc6fb3f15e9388c0512.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-ClientProxiedBy: SL2PR03CA0023.apcprd03.prod.outlook.com
 (2603:1096:100:55::35) To CO1PR11MB5009.namprd11.prod.outlook.com
 (2603:10b6:303:9e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c2252d6-c3d9-4179-8c98-08da8f03eec1
X-MS-TrafficTypeDiagnostic: BN7PR11MB2644:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/Fq61vVGlWMsxRZ1aFVPjTXGwB/sKsoDbV82rNkaT96dR37BNLia4/BjlC3M3gRKJCXpYgHi4KV5h/1QUojUuQlEL/kc/2++fXnvwDWysMLPPWxL9k/Ty/SWUrFJQCI81rmxKHOsMzdgb1kQTuvoT1S/c9nH4Qm16OOd/ifEi9tu8kcCNgFbJ7yoMLwpG70uVatR0i/3VSwtOqr49RENJFuoYAnXvUc+wHOR/IzWorxcTd7tU6/fKS+wTXtrrrw/iXMBMPOzO87FArgPyqD5m/MSinzHCJ5YqxWmQ7vDyJybv6R6Fu48IDL/kgsj2m5V8LONnYW6XEeEMW7FMJM77tB19SRBqLApvyKQOzKtBVax88syrT+C0oSogZb2L1+2TzyVR+pCgMmyE8sv7uyZLgg7/E9uSSnVWHC7mdKpagUuX5Lj3oDuY8T7w9jONHNW3IpteMnf8Ky/f/ZDitNPAY3iTAPCU9Uji5+DFmW4cnr+RcHL/G2V2Q5OXvSWIjl2beIlruXCxXrMv6crOnAJItmikkgJ0Y9B0nvC+gtwMOAgHawNpEmYi3gldKIZWs4hdJwHeW7knf8q1Yduw2zjOMBcpQboND5BsBfWaSdVtSkMmfj5xeuJlrWEz/W44axqMYhpPvMXqYS/4xlai2DR1BwvPY2ek0nQ4sRKv7hVs1HNXMtk+f8iCA/DJWGUbJr923IJS08CH6Fj9cr3FA0dcyfY+abQSNY243x/kFQ17mlDbNlVCOliuQ6uGno/zLE8ZgM1XC3L/pIH1fGhn+0XMOYO9JsjQkGl1e+NSNWIKfY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5009.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(346002)(376002)(366004)(39830400003)(2906002)(8936002)(5660300002)(478600001)(38100700002)(6486002)(6506007)(53546011)(6666004)(316002)(41300700001)(110136005)(83380400001)(66476007)(66946007)(66556008)(8676002)(4326008)(6512007)(186003)(26005)(2616005)(31696002)(36756003)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bEorVjhsd3ZkQkpwNk8yVitkTmUveU1rRjJMdGlDZDVzSDg2MG5nNVpGTm45?=
 =?utf-8?B?UTR1M2NyKzBOR3VKTkUvckovRXI5TThlbFFkeW5MQ1F1ZkFwMXVjTTdXam9R?=
 =?utf-8?B?bkVSc3lZRDF3dWZnVnRPSUIzYzZlSVJQSGNjYUFVWlNRVytRWUhBUGF1dGVx?=
 =?utf-8?B?SUNwMzNDMWtmdkMxcTZxeUlWOU1PQ095QzBGcTRBUTRDN210YU9LSzRKcHNn?=
 =?utf-8?B?VTl2LzNiclZxRERwMUovTUFNajRvc0l5RlZVRE9qbjJPZ1hjeTNxbk52aFFP?=
 =?utf-8?B?eGtiK2tMYmVaMXU0Sk52eDJ3N25mVUxBckhrR0Yva2RhcW5MbytLVW1ZS21R?=
 =?utf-8?B?clJoZ0txQWh1RENaSFVHVThBYy9LMU9QUUttdm1nVnc4c0xGRUVIaU1MRWpS?=
 =?utf-8?B?WHRxNTEydXd2Qi93bUp6TUZ6aFQ5b3dxU3ZxREV2YW0wUTBLbnJ5VlJ3cFh2?=
 =?utf-8?B?WkN2aTMzbk5DZHlFWjhzVm1CbWM1SFBNRGRlUkROOXRZNzlQN2lzMWVLbnFE?=
 =?utf-8?B?RHFoWndBZDhvb054SitzMUpLd0lLakFXbGF6aEl3TDZITEdXQ0huaXF3MFI1?=
 =?utf-8?B?NTNkQ1RoRUd5TzR3bU1tWGg3eTNnV2xPZEJ6dkN2dFV1cVlHTGFQU3lVUm5F?=
 =?utf-8?B?V1kzVjJSbXREd0JPSVRxTW9tNGVNRnlITE11UU02Q2hEd2FVVUtUZFZJWjJj?=
 =?utf-8?B?YnA3RWNVVG5PaW9GWStac1JIK1VJbjdoU0NFSmlSM2JxckxBcjNXbDN6eGxz?=
 =?utf-8?B?QkUxRVN4MTcwTjhURklTYnh4OUl1MUVJR1lXbzhEM1hLSzdBRGkwK0Zadjdt?=
 =?utf-8?B?Uy9UNFFzRDlvRnRhR3pwTjRQNVZBSVJZaUN0UVk1RlZXano4TE5HNXIyclNY?=
 =?utf-8?B?cHhwSVVtQmF2VEUyUmxkYVVpT3lpVjF3TzRxNzdRS0NlMjkybXFUSjVYb1pI?=
 =?utf-8?B?SS8vUHdEY2lvdW1tQWxLRVVRQVhEc0d0Ylp1ZkZTYnZMZ2twWTZ2YlhWRTZy?=
 =?utf-8?B?NGdLbHlvYTllZXpjN0xub2xpejNxQS9oanVuVmwrWTUzK2xoRGpjWXVPNmRL?=
 =?utf-8?B?VHdzNXNSOXJiR25EU2c1ZzNRTzF5Y1NRQ1NwUXI1S2txV3BhcWtBT2JybFU5?=
 =?utf-8?B?WHFZcW8yeFk5RDdZMkpHZlZURGE0ZnhuYnErdGZBUStQNU1HbDdwYWpTRUJn?=
 =?utf-8?B?b05QV3NuK1hwQjBYQ2h6Zit3eEkvc1B1SkJSa0hwOFdFMHFQclcrSWozdStD?=
 =?utf-8?B?TG5pODRSdWtoeEs3SXRqVnN3T3NUNzJ6NzBnMXh0N3puM3dTd2FIS2dOWGpa?=
 =?utf-8?B?NFZ2azZoRkFxdEVUejg3VFplZ3RLQ1pVZVlIUXQ3QXF6U2NtQUo0Z0g2aXpy?=
 =?utf-8?B?OWdISXRjUnZja2hhWHB1SDdiMzRwME5FUjNsWUJPTHl0RE4wcUl2eWN4ZVVP?=
 =?utf-8?B?dENFL0VoUWR0aGNqbWE3a2NmWm1td3hnUkF0TDFweUIzdXpjMWxKU2wxZGRT?=
 =?utf-8?B?aGJFeFlPMFMrbGZEa09UdDlIVWIrcWcveW12SURtQ0FKQk1VamYxb3pJbmNB?=
 =?utf-8?B?YnArUnpWMWVkZFQ5dmkwdFBOMGlIYkVlS2JxVkZpcjBIaEhaRjM1Z3FmcVd1?=
 =?utf-8?B?bFdLQVFwa1ppMml0UDFueXV1TnhteE9qQU5uNGh2Ym9mS3pEcGNlWGJ4aUlr?=
 =?utf-8?B?NFZ3cXpWaTU1SEQ5ZTlwUTRDdEMxV2lzUmI2M1dvOEJNTFU4a245UHYrZE9t?=
 =?utf-8?B?aURHSDMrc2hlaGh2YitSemZxK3g1cStObDVBSlZyUjlDS1pCRW1vZW5xZlBu?=
 =?utf-8?B?bk5nUi9VSlZ3V282bURkdUp6dkh2bHRYbllWVjBsdEgzZnlxTFkzcERNV2gr?=
 =?utf-8?B?d1ZYekF1OGxtVVlTWTJ1MndEY1VTSmFQcFJ5eHZob1JyRUZOUnp2S2cxajBC?=
 =?utf-8?B?RmlqdC83V0sycmZBL3VIQkR6YkFvUWp6NzAwNjJIaitFWUVZRDd0bDZQd2c2?=
 =?utf-8?B?K1QwUTRHV0Z6WEJsZU05TVlHdjcvRHV0Q1F1ekRuT1p5eTRxWFZRUG1rcVFK?=
 =?utf-8?B?eDZiSWdzSU5KQWRTdW9lTGYwNGhSbHNLVzFhVGQ4ZWlvRUZtZTBVSGdVenJr?=
 =?utf-8?Q?SydNez4v7YHJFCu1xSG/pkS5+?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 9c2252d6-c3d9-4179-8c98-08da8f03eec1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5009.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 06:00:28.2181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 esZU3cCA532gYUWYgT9KnQnIgtkWp7ObeWr2h2nlC1mA9jzns1NSQbRhTiTX+pJd3wCudjsvLMI4zThmRPbeiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2644
X-Proofpoint-GUID: Sow9YbIu8dWD6oRZZluui7_tILbEHTzP
X-Proofpoint-ORIG-GUID: k2THDr2sZzONilfUFaj0JvrqgOvPncAh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-05_04,2022-09-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209050028
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 05 Sep 2022 06:00:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13957

DQoNCk9uIDkvMS8yMiAxOToxOSwgUmljaGFyZCBQdXJkaWUgd3JvdGU6DQo+IFtQbGVhc2Ugbm90
ZTogVGhpcyBlLW1haWwgaXMgZnJvbSBhbiBFWFRFUk5BTCBlLW1haWwgYWRkcmVzc10NCj4gDQo+
IE9uIFdlZCwgMjAyMi0wOC0zMSBhdCAxMzo1NSAtMDcwMCwgQ2hyaXN0b3BoZXIgTGFyc29uIHdy
b3RlOg0KPj4gQlBOIGlzIG5vdCBkZWZpbmVkIGJ5IGJpdGJha2UsIHlvdSdyZSBoYXJkY29kaW5n
IE9FLXNwZWNpZmljcyBpbnRvDQo+PiBiaXRiYWtlIHdpdGggdGhpcyBwYXRjaC4NCj4gDQo+IFRo
aXMgd2FzIGFjY2lkZW50YWxseSBhcHBsaWVkIGZyb20gdGhlIHBhdGNoIHF1ZXVlIGJ1dCBJJ3Zl
IHJldmVydGVkDQo+IGl0LCBDaHJpcyBpcyBjb3JyZWN0Lg0KPiANCj4gSWYgeW91IHN0aWxsIHRo
aW5rIHRoaXMgaXNuJ3QgcmlnaHQsIHBsZWFzZSBzaG93IHRoZSBlcnJvciB5b3UncmUNCj4gc2Vl
aW5nIHdpdGggdGhlIHNlbGZ0ZXN0IGFzIHdlIG5lZWQgbW9yZSBpbmZvcm1hdGlvbiB0byBoZWxw
IGZ1cnRoZXIuDQoNClRoYW5rcyBSaWNoYXJkIQ0KDQpJJ20gaW52ZXN0aWdhdGluZyB0aGUgaXNz
dWUgYW5kIHRoZSBzZWxmdGVzdCBlcnJvciBhcyBiZWxvdyBhdCBteSBzaWRlLg0KDQpbMTY6Mjg6
MDktMDcwMF0gMjAyMi0wOS0wNCAyMzoyODowOSw5MzkgLSBvZS1zZWxmdGVzdCAtIElORk8gLSAN
CnRlc3RfaW52YWxpZF9yZWNpcGVfc3JjX3VyaSAoYmJ0ZXN0cy5CaXRiYWtlVGVzdHMpDQpbMTY6
Mjg6MzAtMDcwMF0gMjAyMi0wOS0wNCAyMzoyODozMCw5OTUgLSBvZS1zZWxmdGVzdCAtIElORk8g
LSAgLi4uIEZBSUwNClsxNjoyODozMS0wNzAwXSAyMDIyLTA5LTA0IDIzOjI4OjMwLDk5NiAtIG9l
LXNlbGZ0ZXN0IC0gSU5GTyAtIFRyYWNlYmFjayANCihtb3N0IHJlY2VudCBjYWxsIGxhc3QpOg0K
WzE2OjI4OjMxLTA3MDBdICAgRmlsZSANCiIvaG9tZS93cmxidWlsZC9idWlsZHMvYnVpbGRzLWE4
MGVhYWY3LTNmOTgtNGI4MC1hYTQ4LTVkMzI2NWU3MDc1YS9sYXllcnMvb2UtY29yZS9tZXRhL2xp
Yi9vZXFhL3NlbGZ0ZXN0L2Nhc2VzL2JidGVzdHMucHkiLCANCmxpbmUgMTUzLCBpbiB0ZXN0X2lu
dmFsaWRfcmVjaXBlX3NyY191cmkNClsxNjoyODozMS0wNzAwXSAgICAgc2VsZi5hc3NlcnRJbign
VW5hYmxlIHRvIGdldCBjaGVja3N1bSBmb3IgbWFuLWRiIA0KU1JDX1VSSSBlbnRyeSBpbnZhbGlk
OiBmaWxlIGNvdWxkIG5vdCBiZSBmb3VuZCcsIHJlc3VsdC5vdXRwdXQpDQpbMTY6Mjg6MzEtMDcw
MF0gQXNzZXJ0aW9uRXJyb3I6ICdVbmFibGUgdG8gZ2V0IGNoZWNrc3VtIGZvciBtYW4tZGIgDQpT
UkNfVVJJIGVudHJ5IGludmFsaWQ6IGZpbGUgY291bGQgbm90IGJlIGZvdW5kJyBub3QgZm91bmQg
aW4gIkxvYWRpbmcgDQpjYWNoZS4uLmRvbmUuXG5Mb2FkZWQgODE4MSBlbnRyaWVzIGZyb20gZGVw
ZW5kZW5jeSBjYWNoZS5cblBhcnNpbmcgDQpyZWNpcGVzLi4uRVJST1I6IA0KL2hvbWUvd3JsYnVp
bGQvYnVpbGRzL2J1aWxkcy1hODBlYWFmNy0zZjk4LTRiODAtYWE0OC01ZDMyNjVlNzA3NWEvbGF5
ZXJzL29lLWNvcmUvbWV0YS9yZWNpcGVzLWV4dGVuZGVkL21hbi1kYi9tYW4tZGJfMi4xMC4yLmJi
OiANClVuYWJsZSB0byBnZXQgY2hlY2tzdW0gZm9yIGxpYjMyLW1hbi1kYiBTUkNfVVJJIGVudHJ5
IGludmFsaWQ6IGZpbGUgDQpjb3VsZCBub3QgYmUgZm91bmRcblRoZSBmb2xsb3dpbmcgcGF0aHMg
d2VyZSANCnNlYXJjaGVkOlxuL2hvbWUvd3JsYnVpbGQvYnVpbGRzL2J1aWxkcy1hODBlYWFmNy0z
Zjk4LTRiODAtYWE0OC01ZDMyNjVlNzA3NWEvbGF5ZXJzL29lLWNvcmUvbWV0YS9yZWNpcGVzLWV4
dGVuZGVkL21hbi1kYi9tYW4tZGItMi4xMC4yL29zdi13cmxpbnV4L2ludmFsaWRcbi9ob21lL3dy
bGJ1aWxkL2J1aWxkcy9idWlsZHMtYTgwZWFhZjctM2Y5OC00YjgwLWFhNDgtNWQzMjY1ZTcwNzVh
L2xheWVycy9vZS1jb3JlL21ldGEvcmVjaXBlcy1leHRlbmRlZC9tYW4tZGIvbWFuLWRiL29zdi13
cmxpbnV4L2ludmFsaWRcbi9ob21lL3dybGJ1aWxkL2J1aWxkcy9idWlsZHMtYTgwZWFhZjctM2Y5
OC00YjgwLWFhNDgtNWQzMjY1ZTcwNzVhL2xheWVycy9vZS1jb3JlL21ldGEvcmVjaXBlcy1leHRl
bmRlZC9tYW4tZGIvZmlsZXMvb3N2LXdybGludXgvaW52YWxpZFxuL2hvbWUvd3JsYnVpbGQvYnVp
bGRzL2J1aWxkcy1hODBlYWFmNy0zZjk4LTRiODAtYWE0OC01ZDMyNjVlNzA3NWEvbGF5ZXJzL29l
LWNvcmUvbWV0YS9yZWNpcGVzLWV4dGVuZGVkL21hbi1kYi9tYW4tZGItMi4xMC4yL3dybGludXgt
Z3JhcGhpY3MvaW52YWxpZFxuL2hvbWUvd3JsYnVpbGQvYnVpbGRzL2J1aWxkcy1hODBlYWFmNy0z
Zjk4LTRiODAtYWE0OC01ZDMyNjVlNzA3NWEvbGF5ZXJzL29lLWNvcmUvbWV0YS9yZWNpcGVzLWV4
dGVuZGVkL21hbi1kYi9tYW4tZGIvd3JsaW51eC1ncmFwaGljcy9pbnZhbGlkXG4vaG9tZS93cmxi
dWlsZC9idWlsZHMvYnVpbGRzLWE4MGVhYWY3LTNmOTgtNGI4MC1hYTQ4LTVkMzI2NWU3MDc1YS9s
YXllcnMvb2UtY29yZS9tZXRhL3JlY2lwZXMtZXh0ZW5kZWQvbWFuLWRiL2ZpbGVzL3dybGludXgt
Z3JhcGhpY3MvaW52YWxpZFxuL2hvbWUvd3JsYnVpbGQvYnVpbGRzL2J1aWxkcy1hODBlYWFmNy0z
Zjk4LTRiODAtYWE0OC01ZDMyNjVlNzA3NWEvbGF5ZXJzL29lLWNvcmUvbWV0YS9yZWNpcGVzLWV4
dGVuZGVkL21hbi1kYi9tYW4tZGItMi4xMC4yL3FlbXV4ODYtNjQvaW52YWxpZFxuL2hvbWUvd3Js
YnVpbGQvYnVpbGRzL2J1aWxkcy1hODBlYWFmNy0zZjk4LTRiODAtYWE0OC01ZDMyNjVlNzA3NWEv
bGF5ZXJzL29lLWNvcmUvbWV0YS9yZWNpcGVzLWV4dGVuZGVkL21hbi1kYi9tYW4tZGIvcWVtdXg4
Ni02NC9pbnZhbGlkXG4vaG9tZS93cmxidWlsZC9idWlsZHMvYnVpbGRzLWE4MGVhYWY3LTNmOTgt
NGI4MC1hYTQ4LTVkMzI2NWU3MDc1YS9sYXllcnMvb2UtY29yZS9tZXRhL3JlY2lwZXMtZXh0ZW5k
ZWQvbWFuLWRiL2ZpbGVzL3FlbXV4ODYtNjQvaW52YWxpZFxuL2hvbWUvd3JsYnVpbGQvYnVpbGRz
L2J1aWxkcy1hODBlYWFmNy0zZjk4LTRiODAtYWE0OC01ZDMyNjVlNzA3NWEvbGF5ZXJzL29lLWNv
cmUvbWV0YS9yZWNpcGVzLWV4dGVuZGVkL21hbi1kYi9tYW4tZGItMi4xMC4yL3FlbXVhbGwvaW52
YWxpZFxuL2hvbWUvd3JsYnVpbGQvYnVpbGRzL2J1aWxkcy1hODBlYWFmNy0zZjk4LTRiODAtYWE0
OC01ZDMyNjVlNzA3NWEvbGF5ZXJzL29lLWNvcmUvbWV0YS9yZWNpcGVzLWV4dGVuZGVkL21hbi1k
Yi9tYW4tZGIvcWVtdWFsbC9pbnZhbGlkXG4vaG9tZS93cmxidWlsZC9idWlsZHMvYnVpbGRzLWE4
MGVhYWY3LTNmOTgtNGI4MC1hYTQ4LTVkMzI2NWU3MDc1YS9sYXllcnMvb2UtY29yZS9tZXRhL3Jl
Y2lwZXMtZXh0ZW5kZWQvbWFuLWRiL2ZpbGVzL3FlbXVhbGwvaW52YWxpZFxuL2hvbWUvd3JsYnVp
bGQvYnVpbGRzL2J1aWxkcy1hODBlYWFmNy0zZjk4LTRiODAtYWE0OC01ZDMyNjVlNzA3NWEvbGF5
ZXJzL29lLWNvcmUvbWV0YS9yZWNpcGVzLWV4dGVuZGVkL21hbi1kYi9tYW4tZGItMi4xMC4yL3g4
Ni9pbnZhbGlkXG4vaG9tZS93cmxidWlsZC9idWlsZHMvYnVpbGRzLWE4MGVhYWY3LTNmOTgtNGI4
MC1hYTQ4LTVkMzI2NWU3MDc1YS9sYXllcnMvb2UtY29yZS9tZXRhL3JlY2lwZXMtZXh0ZW5kZWQv
bWFuLWRiL21hbi1kYi94ODYvaW52YWxpZFxuL2hvbWUvd3JsYnVpbGQvYnVpbGRzL2J1aWxkcy1h
ODBlYWFmNy0zZjk4LTRiODAtYWE0OC01ZDMyNjVlNzA3NWEvbGF5ZXJzL29lLWNvcmUvbWV0YS9y
ZWNpcGVzLWV4dGVuZGVkL21hbi1kYi9maWxlcy94ODYvaW52YWxpZFxuL2hvbWUvd3JsYnVpbGQv
YnVpbGRzL2J1aWxkcy1hODBlYWFmNy0zZjk4LTRiODAtYWE0OC01ZDMyNjVlNzA3NWEvbGF5ZXJz
L29lLWNvcmUvbWV0YS9yZWNpcGVzLWV4dGVuZGVkL21hbi1kYi9tYW4tZGItMi4xMC4yL2k2ODYv
aW52YWxpZFxuL2hvbWUvd3JsYnVpbGQvYnVpbGRzL2J1aWxkcy1hODBlYWFmNy0zZjk4LTRiODAt
YWE0OC01ZDMyNjVlNzA3NWEvbGF5ZXJzL29lLWNvcmUvbWV0YS9yZWNpcGVzLWV4dGVuZGVkL21h
bi1kYi9tYW4tZGIvaTY4Ni9pbnZhbGlkXG4vaG9tZS93cmxidWlsZC9idWlsZHMvYnVpbGRzLWE4
MGVhYWY3LTNmOTgtNGI4MC1hYTQ4LTVkMzI2NWU3MDc1YS9sYXllcnMvb2UtY29yZS9tZXRhL3Jl
Y2lwZXMtZXh0ZW5kZWQvbWFuLWRiL2ZpbGVzL2k2ODYvaW52YWxpZFxuL2hvbWUvd3JsYnVpbGQv
YnVpbGRzL2J1aWxkcy1hODBlYWFmNy0zZjk4LTRiODAtYWE0OC01ZDMyNjVlNzA3NWEvbGF5ZXJz
L29lLWNvcmUvbWV0YS9yZWNpcGVzLWV4dGVuZGVkL21hbi1kYi9tYW4tZGItMi4xMC4yL2ludmFs
aWRcbi9ob21lL3dybGJ1aWxkL2J1aWxkcy9idWlsZHMtYTgwZWFhZjctM2Y5OC00YjgwLWFhNDgt
NWQzMjY1ZTcwNzVhL2xheWVycy9vZS1jb3JlL21ldGEvcmVjaXBlcy1leHRlbmRlZC9tYW4tZGIv
bWFuLWRiL2ludmFsaWRcbi9ob21lL3dybGJ1aWxkL2J1aWxkcy9idWlsZHMtYTgwZWFhZjctM2Y5
OC00YjgwLWFhNDgtNWQzMjY1ZTcwNzVhL2xheWVycy9vZS1jb3JlL21ldGEvcmVjaXBlcy1leHRl
bmRlZC9tYW4tZGIvZmlsZXMvaW52YWxpZFxuRVJST1I6IA0KUGFyc2luZyBoYWx0ZWQgZHVlIHRv
IGVycm9ycywgc2VlIGVycm9yIG1lc3NhZ2VzIGFib3ZlXG5cblN1bW1hcnk6IFRoZXJlIA0Kd2Fz
IDEgV0FSTklORyBtZXNzYWdlLlxuU3VtbWFyeTogVGhlcmUgd2VyZSAyIEVSUk9SIG1lc3NhZ2Vz
LCByZXR1cm5pbmcgDQphIG5vbi16ZXJvIGV4aXQgY29kZS4iDQoNClRoYW5rcywNCg0KPiANCj4g
Q2hlZXJzLA0KPiANCj4gUmljaGFyZA0K

