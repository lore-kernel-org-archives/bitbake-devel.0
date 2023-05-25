Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4EFC77B7A
	for <webhook@archiver.kernel.org>; Thu, 25 May 2023 02:10:05 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.3162.1684980601153425239
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 24 May 2023 19:10:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriver.com header.s=pps06212021 header.b=jor+fQ0y;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=45093f2a94=randy.macleod@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34P1fqEp009275
	for <bitbake-devel@lists.openembedded.org>; Wed, 24 May 2023 19:10:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=PPS06212021;
 bh=utBL89gjTvmQP6jDM83F6JMaF86RmNV6Cx0tbWRE2HI=;
 b=jor+fQ0ydsANIBkAXXv38gn9uEAXmDk3DDMGkMNrViJKQximI3rGGSj6sH6sGH735p0d
 gyAcehNhldufUXsoEMTU7VbKitybbF5Gx/Ye0czx51dORYhSQzpf8tRcrmczlXanHK3F
 Nc+OQk5qHpXqGYUSdRfA1KyC3inCC1DuVzAA9rKNdz0Aa8bRmlh+wdAPglr9f5uNJ1oe
 6g9QolHBWH/IcKfuYKSW/GnLAREwbJ5D+7utsRhJp9vLB74O1nJGNHB00UAIN9ZzCD+e
 dpzZr64WbqFrmik05d2MKHzqLFdA7RPtUKNV5RKCxZoveGjGpGvz3QkCXFnRBzbNCzKu Uw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qpwqhcbnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 24 May 2023 19:10:00 -0700
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34P26Wkf017036
	for <bitbake-devel@lists.openembedded.org>; Wed, 24 May 2023 19:09:59 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qpwqhcbnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 May 2023 19:09:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqmQmh2mq4/9hDN1HB+7+T6mhDKMteCOyDTpXYAClFcmnMPD7UteqM/ZWTaWOg5wyYtt41UkcIakdFRncGRUnkHbwTYzs9IUiKTXHy/68r0ITK9s/zlXvFsP7Dx+5fG9eAYDyijDqq4E/elV5kPdh5Cb7Fuf2EgnyAyJsSzrgK4KDIYA/7OcYTD4QmgUHicX8dsIUMqclNwJFnrsG+GGTMmo9fzDR9WkftuG22UYMMjFkCK17m2CbjPMprSPhZm4iLAIotwO2ZqlLf550l0Cro7DwtSjsaKd1hzH1VbV4StwF0/oy/uvQra1XSnTBJb4BsqRh61Qfr2w8AYHttaUHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utBL89gjTvmQP6jDM83F6JMaF86RmNV6Cx0tbWRE2HI=;
 b=Uk2QNGbeJps47iXFr4HvqiyUyNKpC7tuqG6JnfD49mmMtCbekY7dMSyJDfFDibmEWwCNGucyZvmyxsrk9FJRSOWHQqFVfKdhN9tR4ZgVrEC9Af1bzBosIZ6SU3d1z8wb6RAIeZW2eXNxTN8xnms5MC8ZOlfQr1T3510y2ER6XoZd4sBTDHqDYrT5ugbFinsPWcTamaFtFtDmhDPA0ZPzJlghSJPWJYjfZKIwo4ZOThaEtQ9dt3Cfu6PtyjPP5QyWSh8bl/xUXzoOGvtJZFa/ISjtQrZSRZIObjYj/sFcx9K4EY5tf8Gd+SF1tWURJGIi8bZti6w+Kwn/UO8trbL2/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB3994.namprd11.prod.outlook.com (2603:10b6:5:193::19)
 by SN7PR11MB6923.namprd11.prod.outlook.com (2603:10b6:806:2aa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Thu, 25 May
 2023 02:09:54 +0000
Received: from DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::a2e6:a5d4:b628:fa7f]) by DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::a2e6:a5d4:b628:fa7f%6]) with mapi id 15.20.6411.028; Thu, 25 May 2023
 02:09:54 +0000
Content-Type: multipart/mixed; boundary="------------Kekl0xUzrheFm0br2t5ZfpOr"
Message-ID: <0f590642-c164-c2bc-a2b1-962d1cb5c23e@windriver.com>
Date: Wed, 24 May 2023 22:09:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [bitbake-devel][PATCH V2] runqueue.py: fix PSI check logic
Content-Language: en-CA
To: ChenQi <Qi.Chen@windriver.com>, bitbake-devel@lists.openembedded.org
Cc: ola.x.nilsson@axis.com
References: <20230523020905.2911543-1-Qi.Chen@windriver.com>
 <a963a98b-0420-5785-b393-306ebbf6f230@windriver.com>
 <f3098958-331a-f56b-e449-da2ac2a546ce@windriver.com>
From: Randy MacLeod <randy.macleod@windriver.com>
In-Reply-To: <f3098958-331a-f56b-e449-da2ac2a546ce@windriver.com>
X-ClientProxiedBy: SJ0PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::29) To DM6PR11MB3994.namprd11.prod.outlook.com
 (2603:10b6:5:193::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3994:EE_|SN7PR11MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a5938b-d1f8-474d-4c87-08db5cc52155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6GYjaEm/GSGz4T/lnCKrf3PRr0XvCBdBdiJPY3snUXjpsmuSL09KQRR46/cQgDiwcSwWvM+9CDf0wXyR8N1HhMg4Mh7eBl9WkyUTKAwuw5P7IVeI4al0/nwNkSTPRkDh/9hNjdbKumuwOUTigN9In5QRpIJIjx1geoEoc/IzpCSY+wmaz1JDE1hkfstEsFkNN3dKoCByCrBX9jhr1Zklwu9+d4Ce9yKPjHiF8lbfGFVz7mqCMIWivLu0/pLvKoLUoVUuNdBwB+Q3s6NfMZB4I9dFE7AO78J94Qacwp5DbXBNfAV/BR1Dqrz6I/kSjbd87J9VlDyfhYkTFIi17zJScPmhkM68Sd2fVQ2Y4QOJlbUxA07k/P52obS0YbcFD6JA36+uUhGBWaWkmt77nsMzf6x9EZVVa3z3OlOIZNRsH5rubI2GvZY5CZ1NXAJ8Tv0P3SoTotO3EJbnZHE8bWnvXVyRgZuZpDpcSRnxCNXHDIEAX9Ga7Ddj8RpaP7UFPpDpqBomRtUOqEN0Z1/Af5Ft0O59/AJJ5WbXfEKY5E3/c4z2c/ZWPJ+8jKSqgDfUcBxzkRj0N0myV6SvxQUAQC4jJK3K0y7/TeEoSRvb83m5ZOufTyk5xeGTLzWE42hodAZd7o5jGv3mQhxIKoLZ+CsIqg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3994.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(136003)(376002)(39850400004)(346002)(451199021)(53546011)(186003)(6512007)(26005)(38100700002)(6506007)(66574015)(2616005)(36756003)(21480400003)(2906002)(30864003)(33964004)(31696002)(316002)(41300700001)(6666004)(6486002)(166002)(966005)(478600001)(86362001)(31686004)(4326008)(66946007)(66476007)(66556008)(8936002)(8676002)(5660300002)(83380400001)(235185007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MFVQN24xTGJ2dURzQTdad1NHL2RSQyt2dXQzUmZGeTl5dEFqNk5oREJjSWVy?=
 =?utf-8?B?ZHYzbm9IbXhwTjY1aXBOSzNZTFU5dURmNmh6cEdXUVhJRzV2eGlEOFB0a0tq?=
 =?utf-8?B?RFlxbXNib0duOGZwWGhUa3VRbVBjME95SFYwNFo2a0hEK3dRTkVFZzNLcFI1?=
 =?utf-8?B?VlFDU1ZzOVlESXdwVHowYVZRbW5lMDBwQ0pBbG9XSjd5WEtCakJzMXBiNEdC?=
 =?utf-8?B?SmRiS2RxQkF2SFRjYjRtQXNvbi9UcDNacFY5UnBBcW0xamVESXF4MjROaVNw?=
 =?utf-8?B?M3p1UzVmUGp2THkzdDJXdmRGbkRFandRVUM1UytRVDBIemhZcFVRMU1vcEhM?=
 =?utf-8?B?Nlphc2dEeEdPOHk4cU40ekQzczV0Y0hJbEd0dmx3Z3BWLzZwNmdSMHhWV2x3?=
 =?utf-8?B?UWJMdVVKRTlYOEJoSDA4TW1ORXU1ZmtlQjQyZDVwMXUwNzdhME1YSi9LSER2?=
 =?utf-8?B?b0JtMjZUSXh5dVF1c2hxVTJURnQycThkQWJ1YUFZaE5Yc3JjOGRSSXlsMHFC?=
 =?utf-8?B?OHdWWE9zTWlQeFM0c0JROGEvTjllQzNtOHloNHNnN3VRUDkrdGJua1c5RVQy?=
 =?utf-8?B?a2NvaVJudlpkL1hKRHBuVHk5cW9uRFhXdzJlWHZDZWFYeTNiL01laC9OVTFN?=
 =?utf-8?B?WE5WeGhEUXNOVGZscFJLVHFJeTk3ZHBZVGNXUVlNUFl5NCt3emIza3JzaE9Y?=
 =?utf-8?B?WmdLbDd3dXlGRWlpM2JweXJZOEh6N1k3MlloUHNjQkhkQTZtUmZCWEhkWUtD?=
 =?utf-8?B?N1BNSFdVenA5dldka3g5ajNPRnhRK2UrUTZrQ3ZZWmZLa3kwZkFweHlSc2xJ?=
 =?utf-8?B?VU9GRm0rNFNGblNib3hySWs1TzRCNGgwQkFqUi9yaGlXVktpaUhxczJZRmR2?=
 =?utf-8?B?dFJ3OEJCZCttVS9KRTdtK1FLQUVZUlROWFBXQjRUWlhIOURYTzJYNEZwQzM1?=
 =?utf-8?B?ZEdldWNqNmpGZjZVR1FkYW1Ta1ZtZGR2T1JPUWhFeGhGaFJWRGl5c3ord0Yx?=
 =?utf-8?B?Q1NSU0FBS1RNRG1oZEZUbXIxWU1SdWlsRnVTdWZwVVF4RUl6VE1OUnk3cFd2?=
 =?utf-8?B?M2xkRGtOVi9pVjZQQk9VK3JLck5BbFAvYVI4OUJYcVV2bkdqZnhxeU1CRGJY?=
 =?utf-8?B?NGVqN3NjYjZ5MndGVEx1V1Ezc2JNOGhIQ1U1L3NoU3RwRDIzK1JnRG9BSE1Z?=
 =?utf-8?B?bGRBS1RTOEx3OWMwTDByWmFwd2xITk5WdGNwTUs1ZElvK0E2RTJncTFkblZ0?=
 =?utf-8?B?RG5wSEJJL3cxMDRzeDhxaGVMYlY0SFQyVGg1NDU1c08ySW5KSWNmbEMwVFBI?=
 =?utf-8?B?RlpTb1FjMEpTOFlESzJsNjRqY0FjandxaDJ5eUtXemVVSzNZREpHQjhCTi9E?=
 =?utf-8?B?Rm1YbzBDUU1iUWhqdGMrVFloVk81Wmdad01jRVAyaSt4UC90dzNBV3l6aXp3?=
 =?utf-8?B?RUJScm0wM3dneFdFWTFlUFAwZ0cwY3RyK2VyU21DR1BnbnZvWEVyRm8xaDZ1?=
 =?utf-8?B?M3JobmE2ZFNBTW51clhHa3pudDBDVjc4b29BWGFsOGZjUytZVmRaWUg0VFB4?=
 =?utf-8?B?cUtjTytjeVVmd1Y5b29LQWkxcWxucGhvTDAxbU1WeEMxMlo3NDVvV0lHSG1k?=
 =?utf-8?B?VjRCaWU3a2paWVBXZU50Q0djVC9xVE9LMVE3N0VSNk5ySG8zT2Jwa3RuUytv?=
 =?utf-8?B?OWR2bGZtSXlhMHZTSGQ0aGZxQ0Z3SDlCWC94cGU4S1lLbFFwS3hQVW0vaG0r?=
 =?utf-8?B?eTBZQ3JaMHNIZlVrMDl4MTN5WTBXZHEwOWRkazJPenM1UncwSi9wUlNHVmQr?=
 =?utf-8?B?ODZwbTNwMDUvM0NOMktRcXk1SGRPWFZIeGxaSS90Tlhob3Q3YmZLMkxtMWhr?=
 =?utf-8?B?c2hXVU1TdkxraGdqUSt6NnIzMXpSNUxqRy82TGU5aWRDSUZaYmlqKy9zQkIr?=
 =?utf-8?B?QjlLUDBYS3Iydm9UUERQSU40UW5sNGoxMVNBN1JBazVJR1d4UHZHaTNSTStR?=
 =?utf-8?B?djk4K05FNnZwT2ZPTU5kSkhHMDJrU0lCYXg5aHA2OFNySVd2WXBQMlNnblFG?=
 =?utf-8?B?ZGxQQnFzT1RSNTNkUzBKMnVUYlA5Z3lGVGZtYUMvTXlCeWlIbE5xRVA0NEJZ?=
 =?utf-8?B?NFU5cDc0UTQyWnIzZTR1Mm05ZTNkRHM1eGFoODlNZkEvRTE5RUFLTEM0bXda?=
 =?utf-8?B?a1E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a5938b-d1f8-474d-4c87-08db5cc52155
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3994.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 02:09:54.5843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fw9lmCGB9wx+zR8QBCkBAOGVyOsLH3jObTkhVK+Zr9qwP35/S/XUizLxP6oLClSXsPWnw5QZb1+Y8i6VCRLKY/JUWr0KtMjvRIF5ZHTUHH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6923
X-Proofpoint-GUID: q_G8Y1eIH00MpbfODtAcuCvEiSdXHc0C
X-Proofpoint-ORIG-GUID: pJPR99ZAcYmvftXkHHMRIvH1rEwXReOe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_17,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305250016
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 May 2023 02:10:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14804

--------------Kekl0xUzrheFm0br2t5ZfpOr
Content-Type: multipart/alternative;
 boundary="------------0fDXAmSZi8kzcFvUyTafro0N"

--------------0fDXAmSZi8kzcFvUyTafro0N
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-MIME-Autoconverted: from 8bit to base64 by mx0a-0064b401.pphosted.com id 34P1fqEp009275

T24gMjAyMy0wNS0yMyAyMjoxOCwgQ2hlblFpIHdyb3RlOg0KPiBPbiA1LzI0LzIzIDA3OjI0
LCBSYW5keSBNYWNMZW9kIHdyb3RlOg0KPj4gT24gMjAyMy0wNS0yMiAyMjowOSwgUWkuQ2hl
bkB3aW5kcml2ZXIuY29tIHdyb3RlOg0KPj4+IEZyb206IENoZW4gUWk8UWkuQ2hlbkB3aW5k
cml2ZXIuY29tPg0KPj4+DQo+Pj4gVGhlIGN1cnJlbnQgbG9naWMgaXMgbm90IGNvcnJlY3Qg
YmVjYXVzZSBpZiB0aGUgdGltZSBpbnRlcnZhbA0KPj4+IGJldHdlZW4gdGhlIGN1cnJlbnQg
Y2hlY2sgYW5kIHRoZSBsYXN0IGNoZWNrIGlzIHZlcnkgc21hbGwsIHRoZSBQU0kNCj4+PiBj
aGVja2VyIGlzIG5vdCBsaWtlbHkgdG8gYmxvY2sgdGhpbmdzIGV2ZW4gaWYgdGhlIHN5c3Rl
bSBpcyBoZWF2eQ0KPj4+IGxvYWRlZC4NCj4+Pg0KPj4+IEl0J3Mgbm90IGdvb2QgdG8gY2Fs
Y3VsYXRlIHRoZSB2YWx1ZSB0b28gb2Z0ZW4uIFNvIHdlIGNoYW5nZSB0byBhIDFzDQo+Pj4g
Y2hlY2suIEFzIGEgYnVpbGQgd2lsbCB1c3VhbGx5IHRha2UgYXQgbGVhc3QgbWludXRlcywg
dXNpbmcgdGhlIDFzIA0KPj4+IHZhbHVlDQo+Pj4gc2VlbXMgcmVhc29uYWJsZS4NCj4+DQo+
PiBJIGRvbid0IGhhdmUgdGltZSB0byBjaGVjayB0b2RheSBidXQgSSdtIG5vdCBjb252aW5j
ZWQgdGhhdCB0aGlzIGlzIA0KPj4gdHJ1ZS4NCj4+DQo+IEknZCBsaWtlIHRvIGdpdmUgb3V0
IHR3byByZWFzb25zIHRvIHRyeSB0byBjb252aW5jZSB5b3UgOikNCj4NCj4gMS4gVGhpbmsg
b2YgdGhpcyBhcyBzb21lIGtpbmQgb2Ygc2FtcGxpbmcgcmF0ZSBvbiB0aGUgUFNJIGRhdGEu
IA0KPiBQaWN0dXJlIGluIG91ciBtaW5kIHRoZSB3YXZlIG9mIHRoZSBQU0kgZGF0YSwgYW5k
IHdlIHNhbXBsZSBpdC4gT25seSANCj4gaW4gYSBzaXR1YXRpb24gd2hlcmUgUFNJIGRhdGEg
Y2hhbmdlcyB2ZXJ5IHJhcGlkbHkgKGhpZ2ggLT4gbG93ICYgbG93IA0KPiAtPiBoaWdoKSBv
biBhIHRpbWUgYmFzaXMgbGVzcyB0aGFuIDFzIChlLmcuLCAwLjFzKSwgd2lsbCB3ZSB3YW50
IHRvIA0KPiBjaGVjayBtb3JlLiBJIGRvbid0IHRoaW5rIHRoZXJlIHdvdWxkIGJlIGFueSBz
aXR1YXRpb24gbGlrZSB0aGlzIGluIA0KPiBvdXIgcmVhbCBsaWZlLg0KSG1tLCByZWFsbHk6
DQoNCmh0dHBzOi8vcGhvdG9zLmFwcC5nb28uZ2wvUERUUmtHUTRMTW56OFF3MjYNCg0KWW91
IGNhbiBzZWUgdGhhdCB0aGUgcHJlc3N1cmUgZG9lcyBjaGFuZ2UgcXVpY2tseS4NClJlbWVt
YmVyLCBzb21lIHBlb3BsZSBkZXNjcmliZSBiaXRiYWtlIGFzIGEgc29tZXdoYXQgY29udHJv
bGxlZCBmb3JrLWJvbWIhDQoNCj4NCj4gMi4gVGhlIGJ1aWxkIHRpbWUgaXMgdHlwaWNhbGx5
IHJlbGF0ZWQgdG8gdGFzayBudW1iZXJzLiBGcm9tIGV4YW1wbGUsIA0KPiBhIGNvcmUtaW1h
Z2UtbWluaW1hbCBpbnZvbHZlcyBhYm91dCAyMDAwKyB0YXNrcyBhbmQgdGFrZXMgYWJvdXQg
MjAgDQo+IG1pbnV0ZXMgKDEyMDBzKSB0byBmaW5pc2guIEluIHN1Y2ggY2FzZSwgd2UgaGF2
ZSBhYm91dCAxMDAwKyBjaGVja3MgDQo+IGR1cmluZyB0aGUgd2hvbGUgYnVpbGQgZm9yIDIw
MDArIHRhc2tzLiBUaGlzIHNlZW1zIHByZXR0eSBlbm91Z2guDQoNClN1cmUgYnV0IHRhc2sg
Y3JlYXRpb24gaXMgbm90IGF0IGFsbCB1bmlmb3JtbHkgZGlzdHJpYnV0ZWQgb3ZlciB0aGF0
IHRpbWUuDQoNCuKdryBwd2QNCi9ob21lL3JtYWNsZW9kL3dycy95b2N0by9zdW1taXQvMjIu
MTEvYnVpbGQtdGltZS9idWlsZHN0YXRzDQoNCjIyLjExL2J1aWxkLXRpbWUvYnVpbGRzdGF0
cw0K4p2vIGZpbmQgMjAyMjExMjUyMzE3MDUgLXR5cGUgZiB8IHdjIC1sDQo0Mzc5DQoNCmFu
ZCBzZWUgdGhlIGdyYXBoIG9mIGF0dGFjaGVkIGRhdGEgYmVsb3cuDQoNCj4NCj4NCj4+IEkg
c3VzcGVjdCB0aGF0IGluIHRoZSB0eXBpY2FsIGNhc2UsIGl0IHdvdWxkIGJlIG9rYXkgYnV0
IHRoZXJlIHdpbGwgYmUNCj4+IHdvcmtsb2FkcyAocGVyaGFwcyByYXJlIHdvcmtsb2Fkcykg
d2hlcmUgeW91IHdhbnQgdG8gY2hlY2sgbW9yZSBvZnRlbi4NCj4+DQo+PiBUaGUgMSBzZWNv
bmQgaW50ZXJ2YWxzIHdoZXJlIHdlIG5vIGxvbmdlciBsYXVuY2ggbmV3IHdvcmsgbWF5DQo+
PiByZXN1bHQgaW4gYSBzaWduaWZpY2FudGx5IGxvbmdlciBidWlsZC4gSUlSQywgb3VyIGJl
bmNobWFyayB3YXMgYnVpbGRpbmcNCj4+IGNvcmUtaW1hZ2UtbWluaW1hbCBvbiBhIDI0IGNv
cmUgc3lzdGVtIHdpdGhvdXQgUFNJIHJlZ3VsYXRpb24gYW5kIHRoZW4NCj4+IHdpdGggaXQg
c2V0IHRvIDMwMC4NCj4+DQo+IFRoZSByZWFzb24gd2UgY3VycmVudGx5IGhhdmUgdG8gdXNl
IHZlcnkgbG93IG51bWJlciAoZS5nLiwgMzAwLCANCj4gMzAwLzEwMDAwMDA9MC4wMyUpIHRv
IGFjaGlldmUgdGhlIGVmZmVjdCBvZiByZXN0cmljdGluZyB0YXNrIHNwYXduaW5nIA0KPiBp
cyBkdWUgdG8gdGhlIHByb2JsZW0gT2xhIHBvaW50ZWQgb3V0LCB0aGF0IGlzLCBldmVuIGlm
IGEgdGFzayBpcyANCj4gYmxvY2tlZCBpbiB0aGlzIGNoZWNrLCBpZiB0aGUgbmV4dCBjaGVj
ayBoYXBwZW5zIHNob3J0bHkgZW5vdWdoLCB0aGUgDQo+IHRhc2sgZG9lcyBub3QgZ2V0IGJs
b2NrZWQuIFdlIG5lZWQgdG8gYXBwbHkgdGhpcyBwYXRjaCBvciBzaW1pbGFyIHRvIA0KPiBz
dGFydCBjb21wYXJlIHRoZSBkYXRhLg0KTWF5YmUuIFJlbWVtYmVyIHRoYXQgdGhlIHByZXNz
dXJlIGlzIGEgbGFnZ2luZyBpbmRpY2F0b3Igb3IgcmVzb3VyY2UgDQpjb250ZW50aW9uLg0K
VGhlwqAgZ29hbCBpcyB0byBoYXZlIHRoZSBzeXN0ZW0gY29tZSB1cCAxMDAlIHV0aWxpemF0
aW9uIGJ1dCBub3QgZW50ZXIgDQp0aGUgY29udGVudGlvbiBzdGF0ZS4NClRoZSBtYWluIHJl
YXNvbiB3ZSBuZWVkIGxvdyBsaW1pdHMgaXMgdGhhdCB0aGUgdGFza3MgY2FuIGludHJvZHVj
ZSBsb3RzIA0Kb2YgbG9hZCB0byBhbiBhbHJlYWR5DQpidXN5IHN5c3RlbSBhbmQgdGhlIHJl
Y2lwZSBidWlsZCBwcm9ncmFtcyAobWFrZSwgbmluamEsIC4uLikgZG8gbm90IA0KY2hlY2sg
L3Byb2MvcHJlc3N1cmUuDQpaaGVuZyBhbmQgSSBzdGFydGVkIG9uIHRoYXQgYnV0IGhpcyB0
ZXJtIGZpbmlzaGVkLiBQYXVsIFNtaXRoLCB3aG8gDQptYWludGFpbnMgZ21ha2UsIHN1Z2dl
c3RlZA0KDQp0aGF0IEkgdGFrZSBhIGNsb3NlciBsb29rIGF0IHRoZSAibWFrZSAtbCIgYWxn
b3JpdGhtLCB3aGljaCBoYXMgYmVlbiANCmltcHJvdmVkIHJlY2VudGx5DQpidXQgSSBoYXZl
bid0IGJlZW4gYWJsZSB0byB0YWtlIHRpbWUgdG8gd29yayBvbiB0aGF0Lg0KDQoNCj4NCj4g
TWF5YmUgNSUgKDUwLDAwMCkgb3IgMTAlICgxMDAsMDAwKSB3b3VsZCBzZXJ2ZSBhcyBhIHN0
YXJ0Pw0KDQpUaGVzZSBhcmUgZ29vZCBpZGVhcyBhbmQgbWF5IGV2ZW4gYmUgd2hhdCB3ZSBn
byB3aXRoIGJ1dA0Kd2hhdCB0aGV5IGxhY2sgaXMgZGF0YSB0byBiYWNrIHRoZW0gdXAuDQoN
CkkgaGF2ZSBhIGNvcmUtaW1hZ2UtbWluaW1hbCBidWlsZCBzdGFydGluZyBub3cgb24gYSAy
NCBjb3JlIG1hY2hpbmUgDQpzaW1pbGFyIHRvIHdoYXQgSSB1c2VkDQpmb3IgdGhlIGRhdGEg
YWJvdmUuIEknbGwgZG8gc29tZSBidWlsZHMgd2l0aCBhbmQgd2l0aG91dCB5b3VyIHBhdGNo
IGFuZCANCmdldCBiYWNrIHRvIHlvdQ0KaG9wZWZ1bGx5IHRvbW9ycm93IGJ1dCBpZiBub3Qg
bmV4dCB3ZWVrIHNpbmNlIEknbSB0YWtpbmcgRnJpZGF5IGFzIGEgDQpob2xpZGF5Lg0KDQou
Li9SYW5keQ0KDQoNCj4NCj4gUmVnYXJkcywNCj4NCj4gUWkNCj4NCj4+IEknZCBsb29rIGF0
IHRoZSBlbGFwc2VkIHRpbWUgYW5kIHRoZSBidWlsZGNoYXJ0L2Jvb3RjaGFydDoNCj4+IMKg
wqAgc2NyaXB0cy9weWJvb3RjaGFydGd1aS9SRUFETUUucHlib290Y2hhcnQNCj4+DQo+PiBP
bGEsIGhhdmUgeW91IGJlZW4gYWJsZSB0byB0ZXN0IHRoaXMgYW5kIGlmIG5vdCwgY2FuIHlv
dT8NCj4+DQo+PiBBbGwgZm9yIHRvZGF5Lg0KPj4NCj4+IC4uL1JhbmR5DQo+Pg0KPj4NCj4+
PiBTaWduZWQtb2ZmLWJ5OiBDaGVuIFFpPFFpLkNoZW5Ad2luZHJpdmVyLmNvbT4NCj4+PiAt
LS0NCj4+PiDCoCBiaXRiYWtlL2xpYi9iYi9ydW5xdWV1ZS5weSB8IDI5ICsrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tDQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlv
bnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2JpdGJha2Uv
bGliL2JiL3J1bnF1ZXVlLnB5IGIvYml0YmFrZS9saWIvYmIvcnVucXVldWUucHkNCj4+PiBp
bmRleCAwMmYxNDc0NTQwLi40ZDQ5ZDI1MTUzIDEwMDY0NA0KPj4+IC0tLSBhL2JpdGJha2Uv
bGliL2JiL3J1bnF1ZXVlLnB5DQo+Pj4gKysrIGIvYml0YmFrZS9saWIvYmIvcnVucXVldWUu
cHkNCj4+PiBAQCAtMTc5LDYgKzE3OSw3IEBAIGNsYXNzIFJ1blF1ZXVlU2NoZWR1bGVyKG9i
amVjdCk6DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHNlbGYucHJldl9tZW1vcnlfcHJlc3N1cmUgPSANCj4+PiBtZW1vcnlfcHJlc3N1cmVfZmRz
LnJlYWRsaW5lKCkuc3BsaXQoKVs0XS5zcGxpdCgiPSIpWzFdDQo+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYucHJldl9wcmVzc3VyZV90aW1l
ID0gdGltZS50aW1lKCkNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHNlbGYuY2hlY2tfcHJlc3N1cmUgPSBUcnVlDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzZWxmLnBzaV9leGNlZWRlZCA9IEZhbHNlDQo+Pj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgZXhjZXB0Og0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgYmIubm90ZSgiVGhlIC9wcm9jL3ByZXNzdXJlIGZpbGVzIGNhbid0IGJlIHJl
YWQuIA0KPj4+IENvbnRpbnVpbmcgYnVpbGQgd2l0aG91dCBtb25pdG9yaW5nIHByZXNzdXJl
IikNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYuY2hlY2tf
cHJlc3N1cmUgPSBGYWxzZQ0KPj4+IEBAIC0xOTEsNiArMTkyLDEwIEBAIGNsYXNzIFJ1blF1
ZXVlU2NoZWR1bGVyKG9iamVjdCk6DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIEJCX1BSRVNT
VVJFX01BWF97Q1BVfElPfE1FTU9SWX0gYXJlIHNldCwgcmV0dXJuIFRydWUgaWYgDQo+Pj4g
YWJvdmUgdGhyZXNob2xkLg0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCAiIiINCj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgaWYgc2VsZi5jaGVja19wcmVzc3VyZToNCj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBub3cgPSB0aW1lLnRpbWUoKQ0KPj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHRkaWZmID0gbm93IC0gc2VsZi5wcmV2X3ByZXNzdXJlX3RpbWUNCj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiB0ZGlmZiA8IDEuMDoNCj4+PiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBzZWxmLnBzaV9leGNlZWRlZA0KPj4+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHdpdGggb3BlbigiL3Byb2MvcHJlc3N1cmUvY3B1Iikg
YXMgY3B1X3ByZXNzdXJlX2ZkcywgXA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgb3BlbigiL3Byb2MvcHJlc3N1cmUvaW8iKSBhcyBpb19wcmVzc3VyZV9mZHMs
IFwNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG9wZW4oIi9wcm9j
L3ByZXNzdXJlL21lbW9yeSIpIGFzIG1lbW9yeV9wcmVzc3VyZV9mZHM6DQo+Pj4gQEAgLTE5
OCwyMSArMjAzLDE1IEBAIGNsYXNzIFJ1blF1ZXVlU2NoZWR1bGVyKG9iamVjdCk6DQo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjdXJyX2NwdV9wcmVzc3VyZSA9
IA0KPj4+IGNwdV9wcmVzc3VyZV9mZHMucmVhZGxpbmUoKS5zcGxpdCgpWzRdLnNwbGl0KCI9
IilbMV0NCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN1cnJfaW9f
cHJlc3N1cmUgPSANCj4+PiBpb19wcmVzc3VyZV9mZHMucmVhZGxpbmUoKS5zcGxpdCgpWzRd
LnNwbGl0KCI9IilbMV0NCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGN1cnJfbWVtb3J5X3ByZXNzdXJlID0gDQo+Pj4gbWVtb3J5X3ByZXNzdXJlX2Zkcy5yZWFk
bGluZSgpLnNwbGl0KClbNF0uc3BsaXQoIj0iKVsxXQ0KPj4+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgbm93ID0gdGltZS50aW1lKCkNCj4+PiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHRkaWZmID0gbm93IC0gc2VsZi5wcmV2X3ByZXNzdXJlX3RpbWUN
Cj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIHRkaWZmID4gMS4wOg0K
Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBleGNlZWRzX2Nw
dV9wcmVzc3VyZSA9IHNlbGYucnEubWF4X2NwdV9wcmVzc3VyZSANCj4+PiBhbmQgKGZsb2F0
KGN1cnJfY3B1X3ByZXNzdXJlKSAtIGZsb2F0KHNlbGYucHJldl9jcHVfcHJlc3N1cmUpKSAv
IA0KPj4+IHRkaWZmID4gc2VsZi5ycS5tYXhfY3B1X3ByZXNzdXJlDQo+Pj4gLcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGV4Y2VlZHNfaW9fcHJlc3N1cmUgPSBz
ZWxmLnJxLm1heF9pb19wcmVzc3VyZSANCj4+PiBhbmQgKGZsb2F0KGN1cnJfaW9fcHJlc3N1
cmUpIC0gZmxvYXQoc2VsZi5wcmV2X2lvX3ByZXNzdXJlKSkgLyB0ZGlmZiANCj4+PiA+IHNl
bGYucnEubWF4X2lvX3ByZXNzdXJlDQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGV4Y2VlZHNfbWVtb3J5X3ByZXNzdXJlID0gDQo+Pj4gc2VsZi5ycS5t
YXhfbWVtb3J5X3ByZXNzdXJlIGFuZCAoZmxvYXQoY3Vycl9tZW1vcnlfcHJlc3N1cmUpIC0g
DQo+Pj4gZmxvYXQoc2VsZi5wcmV2X21lbW9yeV9wcmVzc3VyZSkpIC8gdGRpZmYgPiBzZWxm
LnJxLm1heF9tZW1vcnlfcHJlc3N1cmUNCj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc2VsZi5wcmV2X2NwdV9wcmVzc3VyZSA9IGN1cnJfY3B1X3ByZXNz
dXJlDQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNlbGYu
cHJldl9pb19wcmVzc3VyZSA9IGN1cnJfaW9fcHJlc3N1cmUNCj4+PiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5wcmV2X21lbW9yeV9wcmVzc3VyZSA9
IGN1cnJfbWVtb3J5X3ByZXNzdXJlDQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHNlbGYucHJldl9wcmVzc3VyZV90aW1lID0gbm93DQo+Pj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbHNlOg0KPj4+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBleGNlZWRzX2NwdV9wcmVzc3VyZSA9IHNlbGYucnEu
bWF4X2NwdV9wcmVzc3VyZSANCj4+PiBhbmQgKGZsb2F0KGN1cnJfY3B1X3ByZXNzdXJlKSAt
IGZsb2F0KHNlbGYucHJldl9jcHVfcHJlc3N1cmUpKSA+IA0KPj4+IHNlbGYucnEubWF4X2Nw
dV9wcmVzc3VyZQ0KPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBleGNlZWRzX2lvX3ByZXNzdXJlID0gc2VsZi5ycS5tYXhfaW9fcHJlc3N1cmUgDQo+Pj4g
YW5kIChmbG9hdChjdXJyX2lvX3ByZXNzdXJlKSAtIGZsb2F0KHNlbGYucHJldl9pb19wcmVz
c3VyZSkpID4gDQo+Pj4gc2VsZi5ycS5tYXhfaW9fcHJlc3N1cmUNCj4+PiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXhjZWVkc19tZW1vcnlfcHJlc3N1cmUg
PSANCj4+PiBzZWxmLnJxLm1heF9tZW1vcnlfcHJlc3N1cmUgYW5kIChmbG9hdChjdXJyX21l
bW9yeV9wcmVzc3VyZSkgLSANCj4+PiBmbG9hdChzZWxmLnByZXZfbWVtb3J5X3ByZXNzdXJl
KSkgPiBzZWxmLnJxLm1heF9tZW1vcnlfcHJlc3N1cmUNCj4+PiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm4gKGV4Y2VlZHNfY3B1X3ByZXNzdXJlIG9yIGV4Y2VlZHNfaW9fcHJl
c3N1cmUgb3IgDQo+Pj4gZXhjZWVkc19tZW1vcnlfcHJlc3N1cmUpDQo+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBleGNlZWRzX2NwdV9wcmVzc3VyZSA9IHNlbGYucnEu
bWF4X2NwdV9wcmVzc3VyZSBhbmQgDQo+Pj4gKGZsb2F0KGN1cnJfY3B1X3ByZXNzdXJlKSAt
IGZsb2F0KHNlbGYucHJldl9jcHVfcHJlc3N1cmUpKSAvIHRkaWZmID4gDQo+Pj4gc2VsZi5y
cS5tYXhfY3B1X3ByZXNzdXJlDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBleGNlZWRzX2lvX3ByZXNzdXJlID0gc2VsZi5ycS5tYXhfaW9fcHJlc3N1cmUgYW5kIA0K
Pj4+IChmbG9hdChjdXJyX2lvX3ByZXNzdXJlKSAtIGZsb2F0KHNlbGYucHJldl9pb19wcmVz
c3VyZSkpIC8gdGRpZmYgPiANCj4+PiBzZWxmLnJxLm1heF9pb19wcmVzc3VyZQ0KPj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXhjZWVkc19tZW1vcnlfcHJlc3N1cmUg
PSANCj4+PiBzZWxmLnJxLm1heF9tZW1vcnlfcHJlc3N1cmUgYW5kIChmbG9hdChjdXJyX21l
bW9yeV9wcmVzc3VyZSkgLSANCj4+PiBmbG9hdChzZWxmLnByZXZfbWVtb3J5X3ByZXNzdXJl
KSkgLyB0ZGlmZiA+IHNlbGYucnEubWF4X21lbW9yeV9wcmVzc3VyZQ0KPj4+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2VsZi5wcmV2X2NwdV9wcmVzc3VyZSA9IGN1cnJf
Y3B1X3ByZXNzdXJlDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZWxm
LnByZXZfaW9fcHJlc3N1cmUgPSBjdXJyX2lvX3ByZXNzdXJlDQo+Pj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzZWxmLnByZXZfbWVtb3J5X3ByZXNzdXJlID0gY3Vycl9t
ZW1vcnlfcHJlc3N1cmUNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNl
bGYucHJldl9wcmVzc3VyZV90aW1lID0gbm93DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzZWxmLnBzaV9leGNlZWRlZCA9IGV4Y2VlZHNfY3B1X3ByZXNzdXJlIG9y
IA0KPj4+IGV4Y2VlZHNfaW9fcHJlc3N1cmUgb3IgZXhjZWVkc19tZW1vcnlfcHJlc3N1cmUN
Cj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gc2VsZi5wc2lfZXhjZWVkZWQN
Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIEZhbHNlDQo+Pj4gwqAgwqDCoMKgwqDC
oCBkZWYgbmV4dF9idWlsZGFibGVfdGFzayhzZWxmKToNCj4+DQo+Pg0KPj4gLS0gDQo+PiAj
IFJhbmR5IE1hY0xlb2QNCj4+ICMgV2luZCBSaXZlciBMaW51eA0KPg0KPg0KLS0gDQojIFJh
bmR5IE1hY0xlb2QNCiMgV2luZCBSaXZlciBMaW51eA0K
--------------0fDXAmSZi8kzcFvUyTafro0N
Content-Type: multipart/related;
 boundary="------------zbA1ylRxMJp50Oyelyb95FS0"

--------------zbA1ylRxMJp50Oyelyb95FS0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 34P1fqEp009275

<html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">On 2023-05-23 22:18, ChenQi wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:f3098958-331a-f56b-e449-da2ac2a=
546ce@windriver.com">On
      5/24/23 07:24, Randy MacLeod wrote:
      <br>
      <blockquote type=3D"cite">On 2023-05-22 22:09, <a class=3D"moz-txt-=
link-abbreviated" href=3D"mailto:Qi.Chen@windriver.com">Qi.Chen@windriver=
.com</a>
        wrote:
        <br>
        <blockquote type=3D"cite">From: Chen
          Qi<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:Qi.Chen@win=
driver.com">&lt;Qi.Chen@windriver.com&gt;</a>
          <br>
          <br>
          The current logic is not correct because if the time interval
          <br>
          between the current check and the last check is very small,
          the PSI
          <br>
          checker is not likely to block things even if the system is
          heavy
          <br>
          loaded.
          <br>
          <br>
          It's not good to calculate the value too often. So we change
          to a 1s
          <br>
          check. As a build will usually take at least minutes, using
          the 1s value
          <br>
          seems reasonable.
          <br>
        </blockquote>
        <br>
        I don't have time to check today but I'm not convinced that this
        is true.
        <br>
        <br>
      </blockquote>
      I'd like to give out two reasons to try to convince you :)
      <br>
      <br>
      1. Think of this as some kind of sampling rate on the PSI data.
      Picture in our mind the wave of the PSI data, and we sample it.
      Only in a situation where PSI data changes very rapidly (high
      -&gt; low &amp; low -&gt; high) on a time basis less than 1s
      (e.g., 0.1s), will we want to check more. I don't think there
      would be any situation like this in our real life.
      <br>
    </blockquote>
    Hmm, really:<br>
    <p>&nbsp;&nbsp; <a class=3D"moz-txt-link-freetext" href=3D"https://ph=
otos.app.goo.gl/PDTRkGQ4LMnz8Qw26">https://photos.app.goo.gl/PDTRkGQ4LMnz=
8Qw26</a></p>
    <p>You can see that the pressure does change quickly.<br>
      Remember, some people describe bitbake as a somewhat controlled
      fork-bomb! <br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:f3098958-331a-f56b-e449-da2ac2a=
546ce@windriver.com">
      <br>
      2. The build time is typically related to task numbers. From
      example, a core-image-minimal involves about 2000+ tasks and takes
      about 20 minutes (1200s) to finish. In such case, we have about
      1000+ checks during the whole build for 2000+ tasks. This seems
      pretty enough.
      <br>
    </blockquote>
    <p>Sure but task creation is not at all uniformly distributed over
      that time. <br>
    </p>
    <p>=E2=9D=AF pwd<br>
      /home/rmacleod/wrs/yocto/summit/22.11/build-time/buildstats<br>
      <br>
      22.11/build-time/buildstats <br>
      =E2=9D=AF find 20221125231705 -type f | wc -l<br>
      4379<br>
    </p>
    <p>and see the graph of attached data below.<br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:f3098958-331a-f56b-e449-da2ac2a=
546ce@windriver.com">
      <br>
      <br>
      <blockquote type=3D"cite">I suspect that in the typical case, it
        would be okay but there will be
        <br>
        workloads (perhaps rare workloads) where you want to check more
        often.
        <br>
        <br>
        The 1 second intervals where we no longer launch new work may
        <br>
        result in a significantly longer build. IIRC, our benchmark was
        building
        <br>
        core-image-minimal on a 24 core system without PSI regulation
        and then
        <br>
        with it set to 300.
        <br>
        <br>
      </blockquote>
      The reason we currently have to use very low number (e.g., 300,
      300/1000000=3D0.03%) to achieve the effect of restricting task
      spawning is due to the problem Ola pointed out, that is, even if a
      task is blocked in this check, if the next check happens shortly
      enough, the task does not get blocked. We need to apply this patch
      or similar to start compare the data.
      <br>
    </blockquote>
    Maybe. Remember that the pressure is a lagging indicator or resource
    contention.<br>
    The&nbsp; goal is to have the system come up 100% utilization but not
    enter the contention state.<br>
    The main reason we need low limits is that the tasks can introduce
    lots of load to an already<br>
    busy system and the recipe build programs (make, ninja, ...) do not
    check /proc/pressure.<br>
    Zheng and I started on that but his term finished. Paul Smith, who
    maintains gmake, suggested<br>
    <p>that I take a closer look at the &quot;make -l&quot; algorithm, wh=
ich has
      been improved recently<br>
      but I haven't been able to take time to work on that. <br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:f3098958-331a-f56b-e449-da2ac2a=
546ce@windriver.com">
      <br>
      Maybe 5% (50,000) or 10% (100,000) would serve as a start?
      <br>
    </blockquote>
    <p>These are good ideas and may even be what we go with but <br>
      what they lack is data to back them up.</p>
    <p>I have a core-image-minimal build starting now on a 24 core
      machine similar to what I used<br>
      for the data above. I'll do some builds with and without your
      patch and get back to you<br>
      hopefully tomorrow but if not next week since I'm taking Friday as
      a holiday.</p>
    <p>../Randy</p>
    <p><br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:f3098958-331a-f56b-e449-da2ac2a=
546ce@windriver.com">
      <br>
      Regards,
      <br>
      <br>
      Qi
      <br>
      <br>
      <blockquote type=3D"cite">I'd look at the elapsed time and the
        buildchart/bootchart:
        <br>
        &nbsp;&nbsp; scripts/pybootchartgui/README.pybootchart
        <br>
        <br>
        Ola, have you been able to test this and if not, can you?
        <br>
        <br>
        All for today.
        <br>
        <br>
        ../Randy
        <br>
        <br>
        <br>
        <blockquote type=3D"cite">Signed-off-by: Chen
          Qi<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:Qi.Chen@win=
driver.com">&lt;Qi.Chen@windriver.com&gt;</a>
          <br>
          ---
          <br>
          &nbsp; bitbake/lib/bb/runqueue.py | 29
          ++++++++++++++---------------
          <br>
          &nbsp; 1 file changed, 14 insertions(+), 15 deletions(-)
          <br>
          <br>
          diff --git a/bitbake/lib/bb/runqueue.py
          b/bitbake/lib/bb/runqueue.py
          <br>
          index 02f1474540..4d49d25153 100644
          <br>
          --- a/bitbake/lib/bb/runqueue.py
          <br>
          +++ b/bitbake/lib/bb/runqueue.py
          <br>
          @@ -179,6 +179,7 @@ class RunQueueScheduler(object):
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.prev=
_memory_pressure =3D
          memory_pressure_fds.readline().split()[4].split(&quot;=3D&quot;=
)[1]
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.prev=
_pressure_time =3D time.time()
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.check_pressure =3D True
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; self.psi_exceeded =3D False
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; except:
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bb.note(&quot;The /proc/pressure =
files can't be
          read. Continuing build without monitoring pressure&quot;)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.check_pressure =3D False
          <br>
          @@ -191,6 +192,10 @@ class RunQueueScheduler(object):
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BB_PRESS=
URE_MAX_{CPU|IO|MEMORY} are set, return True
          if above threshold.
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&q=
uot;&quot;
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if self.=
check_pressure:
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; now =3D time.time()
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; tdiff =3D now - self.prev_pressure_time
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; if tdiff &lt; 1.0:
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; return self.psi_exceeded
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; with open(&quot;/proc/pressure/cpu&quot;) as
          cpu_pressure_fds, \
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; open(&quot;/proc/pressure/io&quot=
;) as
          io_pressure_fds, \
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; open(&quot;/proc/pressure/memory&=
quot;) as
          memory_pressure_fds:
          <br>
          @@ -198,21 +203,15 @@ class RunQueueScheduler(object):
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; curr_cpu_pressure =3D
          cpu_pressure_fds.readline().split()[4].split(&quot;=3D&quot;)[1=
]
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; curr_io_pressure =3D
          io_pressure_fds.readline().split()[4].split(&quot;=3D&quot;)[1]
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; curr_memory_pressure =3D
          memory_pressure_fds.readline().split()[4].split(&quot;=3D&quot;=
)[1]
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; now =3D time.time()
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; tdiff =3D now - self.prev_pressure_time
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; if tdiff &gt; 1.0:
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exceeds_cpu_pressure=
 =3D&nbsp;
          self.rq.max_cpu_pressure and (float(curr_cpu_pressure) -
          float(self.prev_cpu_pressure)) / tdiff &gt;
          self.rq.max_cpu_pressure
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exceeds_io_pressure =
=3D&nbsp;
          self.rq.max_io_pressure and (float(curr_io_pressure) -
          float(self.prev_io_pressure)) / tdiff &gt;
          self.rq.max_io_pressure
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exceeds_memory_press=
ure =3D
          self.rq.max_memory_pressure and (float(curr_memory_pressure) -
          float(self.prev_memory_pressure)) / tdiff &gt;
          self.rq.max_memory_pressure
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.prev_cpu_pressu=
re =3D
          curr_cpu_pressure
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.prev_io_pressur=
e =3D curr_io_pressure
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.prev_memory_pre=
ssure =3D
          curr_memory_pressure
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.prev_pressure_t=
ime =3D now
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; else:
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exceeds_cpu_pressure=
 =3D&nbsp;
          self.rq.max_cpu_pressure and (float(curr_cpu_pressure) -
          float(self.prev_cpu_pressure)) &gt; self.rq.max_cpu_pressure
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exceeds_io_pressure =
=3D&nbsp;
          self.rq.max_io_pressure and (float(curr_io_pressure) -
          float(self.prev_io_pressure)) &gt; self.rq.max_io_pressure
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; exceeds_memory_press=
ure =3D
          self.rq.max_memory_pressure and (float(curr_memory_pressure) -
          float(self.prev_memory_pressure)) &gt;
          self.rq.max_memory_pressure
          <br>
          -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return (exceeds_cpu_pressure or
          exceeds_io_pressure or exceeds_memory_pressure)
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; exceeds_cpu_pressure =3D&nbsp;
          self.rq.max_cpu_pressure and (float(curr_cpu_pressure) -
          float(self.prev_cpu_pressure)) / tdiff &gt;
          self.rq.max_cpu_pressure
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; exceeds_io_pressure =3D&nbsp;
          self.rq.max_io_pressure and (float(curr_io_pressure) -
          float(self.prev_io_pressure)) / tdiff &gt;
          self.rq.max_io_pressure
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; exceeds_memory_pressure =3D
          self.rq.max_memory_pressure and (float(curr_memory_pressure) -
          float(self.prev_memory_pressure)) / tdiff &gt;
          self.rq.max_memory_pressure
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; self.prev_cpu_pressure =3D curr_cpu_pressure
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; self.prev_io_pressure =3D curr_io_pressure
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; self.prev_memory_pressure =3D
          curr_memory_pressure
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; self.prev_pressure_time =3D now
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; self.psi_exceeded =3D exceeds_cpu_pressure o=
r
          exceeds_io_pressure or exceeds_memory_pressure
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; return self.psi_exceeded
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return F=
alse
          <br>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; def next_buildable_task(s=
elf):
          <br>
        </blockquote>
        <br>
        <br>
        --&nbsp;<br>
        # Randy MacLeod
        <br>
        # Wind River Linux
        <br>
      </blockquote>
      <br>
      <br>
    </blockquote>
    <p><img src=3D"cid:part1.Z9iiGXmU.ypKqTWuZ@windriver.com" alt=3D""></=
p>
    <pre class=3D"moz-signature" cols=3D"72">--=20
# Randy MacLeod
# Wind River Linux</pre>
  </body>
</html>
--------------zbA1ylRxMJp50Oyelyb95FS0
Content-Type: image/png; name="FAWgcytZh7S3w6Xn.png"
Content-Disposition: inline; filename="FAWgcytZh7S3w6Xn.png"
Content-Id: <part1.Z9iiGXmU.ypKqTWuZ@windriver.com>
Content-Transfer-Encoding: base64

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
oAx0Xtxjb7xTpY+jzvEr9dg2z+k0c9Qu70F64zS0HeKNXPxM87N7kIaItHzvrOdS5jju3l2vsUE7
7fynrSxD6xHPAUvUgO7xOJxqL9tya2lnViG8XgO6ZiCb6/ib+zq5tq5t/u5winBkgjIcTPNmPHYQ
0tS8aA7VkkytHWm2V373xmhoHs0buKGb1OY2apv3q9vyVW1jIDfXIw5LEqeN4/PGXlHTm56xj8Kn
N49zrEvXPNJ91Fyvd9ZzSe8ed++uV9uwLmntUNoBUNuy06c7ur7j8bhY6rHPrY7DOe1lW26pbSzw
rvNs3/5OHzVew5zH37vXya5x7tMyvHPN6buujfmR4GjHLLztAezC/X5/hBB+/eV5/rjf7y99tizL
5/8334/vRel0XfNtK0c6z7b30zJ0TTMkz/M/ZW/OZ8pymts3zr9tnV/Zlml58zwfXL9m2eO/y7Ls
LdPYY6X52XS6+/3+axs0/6ZorkezPEPH0rvrOXW7D5nzuHtnvcZ+vu+YT9clPa7S9/q22ZhtOzTN
Wsdhczljt8vYY2bObdn8/JRyjZnP1PWJyyvL8s9f23R92vZ3/L7Efd92nu2bx9jvx1Lnwa75D53b
hs7x715z0rLFdWte19Jt3zTmuIVvJSjDxpoX0a6/oZuhtvmkn+m7qY8XyfSGJv13M/B0lTneVMXp
2m484vynbJ94AR/aVmMu9G03fEMBaMy27CpbXN8pIaht+3Rtz7E3yl37oln2dB9O0ZxH3/L6TF3P
V7f7mPWZ87h7d//1fZ/GrGPfOnQtf8x3eGq5ljoO4/RD56W+bTH2mHllW3Z9J9Ll9X1v5jyvjr3m
vPud6vrxN2rbBvFzffsy3V5jpku9c/zFadNt0XWdHNoOzXm/c/1uW69meZrHVnPbvfNjCxzZ6fHY
+UjxwCRdj+yG8L9HsYYeS+6bx9raevFte1R6SlnT9px9j5rNsS3HmrLN47RD5R/72Wbb1ldUVfV8
tK8sy+d6vHMsvbOe71riuIveXa93v597+H4vdRyubQ/bcu+6ttGW+3uO42/qvh8z/TvXnLHXtanT
wjcTlAF4W1dQBgD4RDrzAgAAgISgDAAAAAlBGQAAABKCMgCz2tsYuAAAU+nMC4C3pB15RXmeP3tU
1asqAPBp/tu6AAB8rjicSVmWG5cEAGA+apQBAAAgoY0yAAAAJARlAAAASAjKAAAAkBCUAQAAICEo
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
HBdTyrBUR2Ppe3Nvkz1s41d8arkBmJegDHykPTw6y3f75GPwk8s+1bvr+k3bCoD/0UaZUcbeKHxq
e9Cly63N23L6Hr93g7tfa7RDnmO6Vz87pf1x22fHtLtvdvL4bt8RU9bLuWw9tvk+t8Gn3u9wDHv8
ThyRGmVa6WUb4Hic1wFgHEGZRXzqL1yfWu5vZp99ri37QXhn2e88wZB+NtYcNz/3Stnm2Jba/bNn
ez3u9lou4H2CMqMc/QZq6XJ/6nb5dLb793g8Hqvs71eXMWfZ9tYpGcuyj/fJfmFLjr91CMqMMmYY
plfa7cEYhgFjK85Z79vDNtScCICpdOb1IdLOVrYKDGveZKzVSUFbhzvpDdWUHwcEuXW42f18a5zP
phwnY38IfOeR63Satunb3p9y/ml+pnlu6irjmNeb5Rgq/9h9OlTmOUzpqGzsvNY617/TIdyS9lKO
pr2WC/hcapThYL4tSH7b+vK+qbWLe7jpHgraSy0LAL6VoPxhtrxhm2vZY29S11rXNTrBceO5jClt
5+2D/dnLd/zd4ZpefW8OQ+2V313+1M/PMf2WnbytNZ93lrmHH25C2E85mtYul2sLHJeg/CH2ekE6
ildvRNoeGQT67SUgzznNFO8G99S7556uZU0N/2v2ur31PKOlz/vN68ue7gP2+OOj6zEwN0H5g+zx
wtTlU8o55CjrAXv0Ld+veAM/5hz+Cef5vZdvSd+87gDfRmdeH+TTLtBdbeqmdrITwvTOYdLPjOng
o2s8U94zpXOVoX3d14HQXvZbXwdKfR0i7ammqM1aZR06T4xZ9ru977eVYejR67Hnt6FOsOaafkzn
W2PemzJN27TNMaPbyvaud4/NV8q19flmjzXMr3il07ox4rl3ze1zlH3C59j6PPQt1CgzSVuYnPro
4iuhd6q12r0Ztmictm3Utu32MEbtHKas197K3ucIfSS8sqwpyx6zr+e+qR57fh16b67erLvmt+S5
f87jYy83oH3l+KTzxlq2vh7HYz7+AZ9PUP4gn3hh3HtHMq9quwF0Yfxrzv3xeDz+BIJXfoDpMsf+
O2pAXktzn8bX3p3H1PdfXfYr1ugkbM3z8JIdT/U9ZfDq9/eV8n3zdzcNo2td917dR1tck+P5pRma
v+X+4FvWk+8hKH+YTwtkW/3C++qjgulr6cUOpugb/7TvNbptsb321Dv/WEuWeegR7i3Ol1vXIrKe
vZ0zx/SG3xWcgc+gjfKHabbJnNKec4mbozHvv/O5KW1QP+Hi8w03da88qtm1797Zp6+0NU2nbWtf
2Xx9aZ/UjnmK5r7p2tZt00ZT2iv3LW9seV89lvvaL7fN95X+HMb8MJO+PvV79Uo5xv44NMd5e+oP
o11NQUJYrg31Uo/dz6zy1RQAABMjSURBVFGmrtfWKMOr74+xRVvlPnu4phzdN27XPR3jR6RGmVnM
/SX1pT+WV2/4+U5bP/K8xufHznvscqZO1zX9p55713wMeKvz1Nbnxy1vyD/1uOzy7Y9or8E2ZQ6C
8pdY+iLzaqct75izLdwc5R1zA3W0i32fpdZ1jbaZ/7+9O811FdcCMLqR3ryIYF4gmFeQGRnvR5VT
jo97evItKbr3BGOMjQ2bLlcLIp683YSu7h21vD3msed15RG6Iyj32dvcdGvv4thjvN26v+amvcKY
daYrPgu8xTPoVw+UuEV7e6E6DX3u6C7jy10RKN9M7GpAbrqtyrRnYMEgcC9XaK+1J1G2OvHzhFui
9lqH0JhxpRMVpVd0zfVwjce+bdRe/5Tlh+pM5Pu2WvOTsh4py069bbfkSvmWXEHTXQ+On27LE+F3
Q9BcLrZfiX3uFlD/Ur84C88o39jVnr/JccRZaNezj2vOmN+xns9Enf2Hbeg/dmCV+/zv2itMqUrG
qDtcvTqLWTeuNt+i7o7sZ2e29Rbr6Ttp8MQx6s7jr30M4/oe28nZF22ZH66LQPkCSl40FHshyVZl
sr/zHaT6budLKWfpDsxe5pp112WIHczFlhMK0M0zkWvW9+iB9+idc8l6xrZHe3sz+Q5EUpaTmzb1
O/sg1m6D1DoqabvYPKHpoXLl9Nc9AxCzP8bSmelD00PLySlXTvlc88amhcqUO56mbsup88f+ThmL
U68Wp5azdB3tfrC2rlKXkzNPynabekJrbSCaMqb4yn2FfelRJ01C+yoCsmNtFVCv7TN3PQF0JwTK
ieZ5lnmeRUSk67rN8i0NQszb9HwdJSXoy1FyK1TKPLGd7xFyyqWdNUAdudyS+i850A9JyctOk7r8
1AM/+4DRtZyt1jnUtqW3rpbcWRFLs+buDPv/pVLL4Du5sEU9+NKU9tGSNja319iJvND8JdNS0+bm
HVpOjpx1c/UN1/xrt/2tlewTfGNZyX4+V8r2ZG/PsfqL1YHvJLa93L1svd/2nVBwTfslRx0fle5H
Q8cppeMK9sUzyhHzPEvbtiLyT4DcdZ20bSvjOK7KV19d1Fcxcw6IjugY5nJSlulKE9tpbbUua/Mp
OcBYY80Bk15X8+r0kdaUO3YAb25vpctIyd/8e836bDEt1A9cAVNuedfseFODo9x8UwLBrQLY0PJK
xjTX9K2CZNc2GitLaH1yAx57vE9Z/5Syu+aL7S9Kx/Tc7aak/4eWYe7XY/O76itWJ6E8c09QbJHP
Gkfus33zr90PXInZr/R2+IT1eprQMUBuuxEkH4MryhHjOEpd11LX9ee79/stVVX9+T7FHmcw7bOu
5nL2clYHtddvy4OH2HK3uFJaWm/2wVdOPaxVuu4ldbV2npSAvHS6Pa20PmJ91Kxrc+fp+n+s3XPS
uuZJSbdWTj0+4cDgiAPznHrKTbtn2X19zLWt+bbT1H6WOm6krq9rjLavVseWXTrOuvJMnfeofp5a
lpQTT3b7lqyvq62eML6IhE8GPWUd78zX72i3a6oWat9rHEfp+965gYam2Y64JSZlh+/rhK4DCtcB
i28+Xzlc3/vm86VNscXJgdj65d7OmJI+9RaclLpLLV/O4LvlAXHKAVlumlC7hw6gc5a3lZIdY2k+
obxyTgTswXWCJzbO+PKI2fqKeO4yU/pq7gkv37wpY4or/1g72Hnacsc+V9lLpq/JMzdfX14pY2nq
2LRWbH9bOkbGluNapi8Y3avOcwOKUB8N5ZWzXfuWe4XD7b3HxbPW8+jAcs16lsQEZ+zP9HKvsN2e
iVuvA/q+j6axb8HWZ7/Nz7IsXzvxow7ObWaZXN/vbU1nu3NHzT2Zov822yWWh7mNufL2tbFre3Wl
3eMK1V5XvdbmtWe59jxRFmpnM13JtLWu0H+PKkPKcvYsy97jbEn+V13fLea/ujMCCPP/sTHJV54z
thl7P5pS/rvR6+g6SbDFZ8u8cpf7ZHa77dE/fPHLr9W1jUA5YhgG5/e5L/Q6OxA1O5mZzvddLN/Y
slxyzkzZg4EvYNxiJ7tm/VLSmevtW5avTVx55PC1u2taKK1r+b6/7bQp6VKuAuTWu++7WF2m1HXq
uoaWvVWQHWs7O13KtLVjgD09Z/sJ5bUmSDvqzHjKclLqI6Rk+00ZK0Nlj43FISnbfWkb5/RX13e5
gWRJX8hJl5J/zljo2pfGluFqi9Sym/OGji9iY2jsqtuadkjdZmJjqrnMI8aWvcSOBXI+W+eXu1zz
36tbU06u9B6HZ5Q9Ul/W1ff9pm/BLlWyQ4t9t2ZHtGa+2KCXcsCXu8zcvGP5pxxolK5XSMlBXiht
atDr+jt12tptd02bmX/nBOP29JT5YmlS26a0f6dMz2nrvZZTuqzQco46oNhq7C3NP3cM3GK7jZUh
p3yxv0uDYl+aNWPumjRbjHMl9ZzTp3P7Tk6fdv0/d1uMpU0pZ06anPq+i7uW2+VOQfLaMt5hHZ+E
K8oAAAAAABgIlAEAAAAAMHDr9UFct5A91ZPXzcR6Ps+vrCvr+Sy/sp4iv7OurOfz/Mq6sp73xC3d
bgTKB3B1JjZIAAAAAGd7WuC/FW699kh9QZfvrdgAAAAAgHsiUI7w/Zayfit2XddHFgcAAAAAsDMC
5YDQ1eJ5nqVpGgJlAAAAAHiYauFh2aCqqqRpGnm/35/v5nmW1+slSikCZQAAAAB4GK4oRyilRESk
bVuZ51nGcSRIBgAAAIAH44pyhnEcpa5rAmQAAAAAeDAC5Z3N8yzzPItI+pu0cSz9YjaR8jaa59l5
AoX2vw5fG4l8v5wvdiKMNr0n+ui5Qv3PtGdfzMkbYSntabZPaZ1vNW4jLrWP5sxLHz3PmvbcajmP
aM8Fu1BKLU3TLEqpz3dN0yzDMJxYKpiUUouI/PmYbWZrmsY5jytv2v8cvnZ11f0wDEvTNF/z2u0W
mkab7mcYBmc7xvoqffRadB+LHW7s2Rdz8kZYanu6+qHZBra9xm3Epbbpsuw3vtKm20lpz9i+1dVX
f7WPckV5J23bSl3Xf86gVVXF880XoJ8377pO6rr+/D1Nk4iIuLqFTmO3netMGe1/Hl33Nrst9Ev5
7LYex1Hmef56gZ+ZL216jLZtRcT9E3zzPMs0TX/ajj56HeaVJP0zi77DjT37Ym7ecMtpT7t9xnH8
zDMMg/PK4l7jNvxy2lSn32N8pU23kdqeur59v+zT972zn/5sHz0jOn86fSUkdxqO4zuzLYEzZKln
w2j/8+izlil87eyaRpseSykVvLJLH70XPa6Gpu/VF3PyRppQe/r6rnmHiGuePcZtpIv10WXZb3yl
TbcXas9QX/O13S/3Ud56vQN9JifEfC4Wx/NdLfKdYdNXsFLQ/udJrdeUdGY70qbH8z3PZj7zaH9P
H72fPftibt5Yb55nZ98NPZ+617iN7ew1vtKmxwv1xXmepWmaP9//ch8lUN6JL+DiZTHXkNsOuvO/
Xi+pqupzC4kP7X88vSOfpkmqqpK2baODtq89XO1Hmx4ndNuzL1Cmj97bnn0xJ2+sk9t/9h63sY29
x1fa9Dih/es0Td6T0L/aRwmUN5Z61uVuZ1R+jd3J67r+OsvW9728Xq8/Owra/1zmIDxNk/R9/3nW
1ZRa/+M40qYXo5+fstFH72nPvpiTN44RO/Gx1biNbe01vtKm16Hr2BXk/nIfJVAGDH3fO2876bpO
3u+3LMsiSqlPGteOAufQLw5ZlkWWZfkM7NM0OQd03I/varIIfRS4MvNnYkyM2/fA+Pp8vtuuf72P
EigD/0r9rb+6ruX9fn/tKHA9XdeJUkpE/hnQ73QGE26hQNlEHwWuRR+Ex/ou4/b1Mb4+k+u2a5df
66MEysC/xnHM+lkY8xX3Tx8o7qqu68/ZT26lvT/fbdc+9FHgfPoEV+rPwjBu3wPj63OEbrt2+aU+
SqAMiP+2sJg7vpjg1/BypmdIvZpso48C53q9XtnjMOP2PTC+PoPvtuuQX+mjBMobS91wGFyuQ/9I
+xY/gk7730Nq/XddR5teRGmgbKM9r2XPvpiTN/bRtm3WnVohtOf10UfvKfW265gntieB8k58tyKU
XrnEPuZ5lnEcVwfJdnvS/teT89uArpe60abnyr3t2kYfvbY9+2JO3thO27bSdd2qvrR23MYx1o6v
tOl5cm+7tj2+jy7Y3DAMi69qm6ZZmqY5uERwUUoF22IYhmgeIvInD9r/WnR7KKW+vhcRZxsrpf6k
p03P5WqTVPTR84mIt7719L36Yk7eSBNrz2X5py18dZuyb91i3Ea6lDb1zbd2fKVNt5fTnqX7vF/p
owTKO3ENHnfdSJ5It8UwDM6P2XZ6MLA7fmhwof2Pp+vcrN9QnfsGeV+70qbnCR14mdPpo9cUO2jb
sy/m5o24WHvquvXtX81+uve4jTShNt17fKVNt5cTKPsCW3P6L/dRAuWd6KuVeuPybTg4nu7goY8r
UNYf307DXgbtfyy7/cz69zHb0mwzF9r0PLH+Rh+9Hl2nTdN89Utfm+zZF3Pyhltqe5rTfR+znfYe
t+GX2qZHjK+06Xq5Y+6yxE9CLwt9tFqWZRHsahxHqeuaZ95urvQ5Dtr/OPrFbLn1redLbVva9Jro
o/e3Z1/MzRvHOGrcxjpHjK+06TX9ch8lUAYAAAAAwMBbrwEAAAAAMBAoAwAAAABgIFAGAAAAAMBA
oAwAAAAAgIFAGQAAAAAAA4EyAAAAAAAGAmUAAAAAAAwEygCAR5vnWaqqkrZtzy5Ksnmezy7CKcZx
zJ7nV+sKALAvAmUAwOWN4yhVVWV9dNClA6lpms5chWR3Cui3MM+ztG0rVVVJ3/fZ84/jSLAMANgc
gTIA4BaaphGllCzLIsuyyDAMn2n6u2VZRCn1NV/XdTIMw5/vr6htW+m6Tuq6Prsoh6nrWt7vd/H8
7/ebYBkAsDkCZQDALaQGkHVdfwXROfOeqW1bqev68uW8IoJlAMDWCJQBALeQE0B2XbdjSbY3z7NM
03S7cl9JXddFzzgDAOBCoAwAuLySANKex/fs7zzPnwBLPytbVdXX1Unf9ybzOeq2bbOubr5erz9X
wc3ytW0r4zh+Pq68zWd9zWe0fWUdx1HatvWWVddLaLlmGl2/+uVpoboy1ylWVzqNWQ6XrutkmiaC
ZQDANhYAAG5oGIZFRJbQrkwptTRN40xnzj8MwzIMw2ceEVmapvnMb37vWp5Oa/6duovV5dDLt+my
mHnbac1ymmV15Wmm0/mLyFf5lVLOee2ymHWo89D5+OpKl81VB77vdZ6ueV3rAgDAWlxRBgA8VuhF
UfolXyL/XOHUV6D1M87TNMk8z5/5zWefzSug4zj+ebZY/z/nDdauq+b66qiZtyvd6/X6Wk+dvu/7
P1fG7VvY7XWa51ler5fzVnezXnRZlmX5SqPn0/naV3hdV899dwzot2DrPOu6lqZpnGnNZQIAsBaB
MgDg5+W+QMsMPl0/aaQDv5SfpEr5SSRzeXZZfbca2wHwOI7O56B18Knz1elddaK/8y0zVo96vtxb
6UPrH1oOAACl/nd2AQAAuCv7yrJpi6ubOiicpknatv1cNTYDzXmepWkaZ3A4DMOfANi1DPNqdChw
N8tTIvet1E3TyDRN8nq9RCkldV3zwjMAwCEIlAEAKGQGfnsEcHVdi1JKXq+XTNMkVVXJMAxfy9JB
a+y3iEuD2y3lluH9fkvbtp9guWmaW/zUFwDg/rj1GgCAC9PBsn42t+/7rGefS13lN4nf7/fn6rwO
mK9SNgDAcxEoAwCwUihwiwV1oZdTmc8Lv99vUUqJiDh/Bin0U0wm3/O7Op0uT6jcoTKnSA107ZeG
6eW+Xq9VywcAIIZAGQCAQuZLu1zBX8qV39AzxPM8/3mRlf3ss+/t0np+/b1O53oG2VyOXif7jdnm
MkpvMw+V1cVOF7u9XOM5ZgDAWgTKAACsoIO/1+sl4zh+PvqnmGLP08ZetuW71VjPZwbrbdt+lcH8
2SgzeKyq6ivdOI5fP4+lr9zagWrf919vyM5ll1WzX4qm/7bTab4r2rp8AACsdvYPOQMAkEMptQzD
sIjI59M0zTIMw6KU+pO2aZo/6ZZl+crD972IRNO75hGRP2UJaZpmaZrmz/c6X708/XdsPfU8rrpL
SedbJ3OdffWrlFqUUt75XGXQ6e16NecfhsFbT2b6nHoHAMCnWpZl2S8MBwAAKaqq+vwEEvLpK9Gp
t2cDABDCrdcAAFyAUir52V18089YEyQDALZCoAwAwAXUdS1d1x3y009Pol9YRpAMANgSgTIAABdB
sJyHIBkAsBeeUQYAAAAAwMAVZQAAAAAADATKAAAAAAAYCJQBAAAAADAQKAMAAAAAYCBQBgAAAADA
QKAMAAAAAICBQBkAAAAAAAOBMgAAAAAABgJlAAAAAAAMBMoAAAAAABgIlAEAAAAAMBAoAwAAAABg
IFAGAAAAAMBAoAwAAAAAgIFAGQAAAAAAA4EyAAAAAAAGAmUAAAAAAAwEygAAAAAAGAiUAQAAAAAw
ECgDAAAAAGAgUAYAAAAAwPB/Y/vYzBLyRwYAAAAASUVORK5CYII=

--------------zbA1ylRxMJp50Oyelyb95FS0--

--------------0fDXAmSZi8kzcFvUyTafro0N--

--------------Kekl0xUzrheFm0br2t5ZfpOr
Content-Type: text/plain; charset=UTF-8;
 name="20221125231705-task-started.dat"
Content-Disposition: attachment; filename="20221125231705-task-started.dat"
Content-Transfer-Encoding: base64

MCwgMQoxOCwgMgoxOSwgMTIwCjIwLCAxMDYKMjEsIDc4CjIyLCA3NAoyMywgNDAKMjQsIDU3CjI1
LCA1NwoyNiwgNzEKMjcsIDUzCjI4LCA2OAoyOSwgNTkKMzAsIDc1CjMxLCA2NQozMiwgODAKMzMs
IDIyCjM0LCAyNQozNSwgMTEKMzYsIDEwCjM3LCA1CjM4LCA1CjM5LCA0CjQxLCAzCjQyLCAyCjQ1
LCAzCjU0LCAxCjU4LCAyCjU5LCAyCjYxLCAxCjYyLCAxCjYzLCAzCjY2LCAxCjY3LCAxCjY4LCAz
CjY5LCAxCjgwLCAxCjgxLCAxCjgyLCAxCjkwLCAxCjkxLCAxCjkyLCAyMAo5MywgMTgKOTgsIDIK
OTksIDcKMTAwLCAxCjEwMSwgMQoxMDIsIDMKMTAzLCAyCjEwNCwgMgoxMDUsIDUKMTA2LCA2CjEw
NywgMTAKMTA4LCA4CjEwOSwgNwoxMTAsIDEKMTExLCAxCjExMiwgMgoxMTMsIDIKMTE0LCAyCjEx
NSwgMTIKMTE2LCA1NAoxMTcsIDYwCjExOCwgNjcKMTE5LCAxNQoxMjAsIDUKMTIxLCAzCjEyMiwg
OQoxMjMsIDIKMTI3LCAxCjEyOCwgNgoxMjksIDMKMTMxLCA0CjEzMiwgNAoxMzMsIDIKMTM2LCA0
CjEzNywgMTcKMTM4LCAxOAoxNDEsIDEKMTQyLCAzCjE0MywgNAoxNDQsIDcKMTQ4LCAzCjE0OSwg
MgoxNTAsIDMKMTUxLCAyCjE1MiwgNjQKMTUzLCA2MQoxNTUsIDM0CjE1NiwgODEKMTU3LCA3OAox
NTgsIDQxCjE1OSwgMTMKMTYwLCA4NAoxNjEsIDEwMQoxNjIsIDE1CjE2MywgMQoxNjUsIDUKMTY4
LCAxCjE3MCwgNAoxNzEsIDMKMTcyLCAzCjE3MywgMQoxNzQsIDIKMTc1LCAzCjE3NiwgMQoxNzcs
IDIKMTc4LCAyCjE3OSwgMwoxODAsIDIKMTgxLCAxCjE4MiwgMwoxODQsIDEKMTg2LCAyCjE4Nywg
MTIKMTg4LCAxNQoxODksIDEzCjE5MCwgMgoxOTEsIDMKMTkzLCAxCjE5NCwgMQoxOTUsIDMKMTk2
LCAxCjE5NywgNAoyMDIsIDEKMjA1LCAxCjIwNiwgNAoyMDcsIDEKMjA4LCA0CjIxMCwgMQoyMTMs
IDEKMjE1LCAxCjIxNiwgMQoyMTcsIDEKMjE4LCAxCjIxOSwgMQoyMjAsIDEKMjIxLCA1CjIyMiwg
MgoyMjMsIDIKMjI2LCA1CjIyNywgNgoyMzEsIDEKMjMyLCAxCjIzMywgMgoyMzQsIDUKMjQzLCAx
CjI0NSwgMQoyNDcsIDEKMjQ5LCAyCjI1MiwgMQoyNTMsIDEKMjU2LCA1CjI2OCwgMQoyNzQsIDEK
Mjc3LCA2CjI3OCwgMwoyNzksIDEKMjgwLCAyCjI4OSwgMQoyOTcsIDEKMjk4LCAxCjMxMCwgMQoz
MTMsIDIKMzM0LCAxCjMzNSwgOQozMzYsIDEKMzM4LCAxCjM1MCwgMQozNTIsIDEKMzUzLCAxCjM3
MywgMQozNzgsIDIKMzc5LCAxCjM4MCwgMgozODUsIDEKMzg3LCAxCjM5NCwgMQozOTcsIDEKNDAy
LCAxCjQwNSwgMwo0MDksIDEKNDEwLCAxCjQxMSwgNAo0MTIsIDIKNDE3LCAxCjQyNCwgMQo0Mjgs
IDEzCjQyOSwgMQo0MzAsIDMKNDMxLCAyCjQzMiwgMgo0MzMsIDQKNDM0LCAyCjQzNywgMQo0Mzgs
IDIKNDM5LCAxCjQ0MCwgMQo0NDEsIDEKNDQyLCAxCjQ0MywgMQo0NDQsIDIKNDQ1LCAzCjQ0Nywg
MQo0NDgsIDQKNDQ5LCA3CjQ1MCwgMTMKNDUyLCA0CjQ1MywgNAo0NTQsIDUKNDU1LCAxCjQ1Niwg
MTgKNDU3LCA5CjQ1OCwgNAo0NTksIDUKNDYwLCA3CjQ2MSwgNgo0NjIsIDQKNDYzLCAyCjQ2NSwg
MQo0NjYsIDEKNDY3LCAxCjQ2OCwgMgo0NjksIDQKNDcwLCAxCjQ3MSwgMgo0NzIsIDIKNDczLCAx
Mwo0NzQsIDMKNDc1LCAzCjQ3NiwgMQo0NzcsIDIKNDc4LCAxCjQ3OSwgMQo0ODAsIDYKNDgxLCA2
CjQ4MiwgNwo0ODMsIDMKNDg0LCAyCjQ4NSwgMwo0ODYsIDIKNDg3LCAyCjQ4OCwgMQo0ODksIDIK
NDkxLCAyCjQ5MiwgMgo0OTYsIDEKNDk4LCAxCjUwMCwgMQo1MDEsIDEKNTAyLCAyCjUwMywgMgo1
MDQsIDIKNTA1LCAxCjUwNiwgMwo1MTIsIDEKNTE0LCAxCjUxNiwgMQo1MTgsIDMKNTE5LCAyCjUy
MCwgMQo1MjIsIDEKNTIzLCAyCjUyNSwgMgo1MjcsIDIKNTI5LCAxCjUzMywgMgo1MzQsIDEKNTM2
LCAxCjUzOSwgMgo1NDAsIDQKNTQxLCAzCjU0MiwgMQo1NDMsIDIKNTQ0LCAxCjU0NSwgMQo1NDcs
IDEKNTQ4LCA0CjU0OSwgNAo1NTUsIDEKNTU3LCAyCjU1OSwgMgo1NjAsIDEKNTYxLCAyCjU2Miwg
Mwo1NjMsIDQKNTY0LCAyCjU2NSwgMgo1NjYsIDIKNTY3LCAyCjU2OCwgMgo1NzEsIDEKNTcyLCAy
CjU3MywgMQo1NzQsIDEKNTc1LCAxCjU3NywgMQo1NzgsIDEKNTc5LCAxCjU4MCwgMgo1ODEsIDIK
NTgyLCAzCjU4MywgMQo1ODQsIDEKNTg1LCAxCjU4NywgMgo1OTIsIDEKNTk0LCAyCjU5NSwgMQo1
OTcsIDEKNjEyLCAxCjYxNCwgMQo2MTUsIDEKNjE3LCAyCjYxOSwgMQo2MzAsIDEKNjM0LCAxCjY0
MSwgMQo2NDIsIDEKNjQ0LCAyCjY0NSwgMgo2NDgsIDEKNjUxLCAxCjY1MiwgMQo2NTQsIDQKNjU1
LCA0CjY1NiwgMQo2NjAsIDEKNjYxLCAxCjY2MiwgMgo2NjMsIDEKNjY3LCAxCjY3MCwgMQo2NzEs
IDEKNjcyLCAxCjY3NiwgMgo2NzcsIDEKNjc4LCAxCjY3OSwgMQo2ODAsIDEKNjg0LCAxCjY4OCwg
MQo2OTAsIDE5CjY5MSwgMgo2OTIsIDgKNjkzLCAxMgo2OTQsIDExCjY5NSwgMwo2OTYsIDIKNjk3
LCAxCjY5OCwgNQo2OTksIDYKNzAwLCAzCjcwMiwgMgo3MDQsIDEKNzA2LCAxCjcwOCwgMTQKNzA5
LCAyNgo3MTAsIDE1CjcxMSwgNAo3MTIsIDgKNzEzLCAzCjcxNCwgNwo3MTUsIDEKNzE2LCAyCjcx
NywgNAo3MTgsIDEKNzE5LCAzCjcyMCwgMQo3MjEsIDEKNzIyLCA0CjcyMywgMwo3MjUsIDEKNzI4
LCAzCjczNCwgMgo3MzUsIDE4CjczNiwgMjEKNzM3LCAxOAo3MzgsIDIwCjczOSwgMjgKNzQwLCAx
NAo3NDEsIDEzCjc0MiwgNgo3NDMsIDYKNzQ0LCA2Cjc0NSwgMTUKNzQ2LCAxNAo3NDcsIDEyCjc0
OCwgNAo3NDksIDUKNzUwLCA1Cjc1MSwgMQo3NTIsIDEKNzUzLCAzCjc1NCwgNQo3NTUsIDIKNzU2
LCAzCjc1OCwgMQo3NTksIDUKNzYwLCAyCjc2MSwgMwo3NjIsIDcKNzYzLCA0Cjc2NCwgOAo3NjUs
IDYKNzY2LCA0Cjc2NywgNAo3NjgsIDIKNzY5LCA3Cjc3MCwgNQo3NzEsIDUKNzcyLCAxMAo3NzMs
IDEyCjc3NCwgOAo3NzUsIDExCjc3NiwgMTUKNzc3LCA4Cjc3OCwgMTEKNzc5LCAxNAo3ODAsIDE1
Cjc4MSwgNAo3ODIsIDIwCjc4MywgMTQKNzg0LCAxMAo3ODUsIDMKNzg2LCAyCjc4NywgMwo3ODgs
IDQKNzg5LCAzCjc5MCwgOAo3OTEsIDUKNzkyLCAxMQo3OTMsIDEwCjc5NCwgOAo3OTUsIDExCjc5
NiwgOAo3OTcsIDE2Cjc5OCwgNgo3OTksIDgKODAwLCA4CjgwMSwgMTAKODAyLCA0CjgwMywgMgo4
MDQsIDUKODA1LCA4CjgwNiwgNQo4MDcsIDIKODA4LCA0CjgwOSwgMwo4MTAsIDgKODExLCA0Cjgx
MiwgMwo4MTMsIDQKODE0LCAxCjgxNSwgMwo4MTYsIDIKODE3LCA4CjgxOCwgMwo4MTksIDYKODIw
LCAzCjgyMSwgOAo4MjIsIDUKODIzLCA4CjgyNCwgNgo4MjYsIDMKODI3LCA1CjgyOCwgNAo4Mjks
IDYKODMxLCAzCjgzMiwgMgo4MzMsIDEKODM0LCAzCjgzNSwgNQo4MzYsIDMKODM5LCA3Cjg0MCwg
OAo4NDEsIDQKODQyLCA0Cjg0MywgMQo4NDQsIDQKODQ1LCA1Cjg0NiwgMgo4NDcsIDcKODQ4LCA3
Cjg0OSwgNgo4NTAsIDMKODUyLCA1Cjg1MywgNAo4NTQsIDIKODU2LCA0Cjg1NywgMwo4NTksIDQK
ODYwLCAyCjg2MSwgMgo4NjIsIDMKODYzLCA3Cjg2NCwgMQo4NjUsIDEKODY2LCA0Cjg2NywgMQo4
NjgsIDQKODY5LCA2Cjg3MCwgNAo4NzEsIDQKODcyLCA1Cjg3MywgMgo4NzQsIDIKODc1LCAzCjg3
NiwgNgo4NzcsIDUKODc4LCAzCjg3OSwgNQo4ODAsIDIKODgxLCA0Cjg4MiwgMwo4ODMsIDEKODg0
LCAyCjg4NSwgMgo4ODYsIDMKODg3LCAyCjg4OCwgNAo4ODksIDUKODkwLCAxCjg5MSwgMgo4OTIs
IDEKODkzLCAxCjg5NSwgNAo4OTYsIDIKODk3LCA3Cjg5OCwgNQo5MDAsIDMKOTAxLCA5CjkwMiwg
OAo5MDMsIDQKOTA0LCAzCjkwNSwgNQo5MDYsIDgKOTA3LCAxCjkwOCwgMgo5MDksIDQKOTEwLCAy
CjkxMSwgNQo5MTIsIDcKOTEzLCA2CjkxNCwgMgo5MTUsIDEKOTE2LCA3CjkxNywgMwo5MTgsIDgK
OTE5LCAyCjkyMywgMgo5MjQsIDUKOTI1LCAzCjkyNywgMQo5MjgsIDMKOTI5LCAxCjkzMCwgNAo5
MzEsIDMKOTMyLCAyCjkzMywgMgo5MzQsIDEKOTM1LCA2CjkzNiwgMwo5MzcsIDEKOTM4LCA1Cjkz
OSwgNQo5NDAsIDIKOTQxLCAxMwo5NDIsIDMKOTQ3LCAyCjk0OCwgMgo5NDksIDUKOTUwLCA0Cjk1
MSwgMwo5NTIsIDEKOTUzLCA0Cjk1NCwgMgo5NTUsIDMKOTU2LCAxCjk1OCwgMQo5NTksIDcKOTYx
LCA0Cjk2MiwgMQo5NjMsIDMKOTY0LCA0Cjk2NSwgNAo5NjcsIDEKOTY5LCAzCjk3MCwgMgo5NzEs
IDIKOTcyLCAyCjk3NCwgMgo5NzUsIDMKOTc2LCA1Cjk3NywgMQo5NzksIDEKOTgwLCAyCjk4MSwg
Mwo5ODQsIDIKOTg1LCAxCjk4NiwgNQo5ODcsIDMKOTg4LCAyCjk5MSwgMgo5OTIsIDIKOTk0LCAx
Cjk5NSwgMgo5OTYsIDEKMTAwMCwgMQoxMDAxLCAxCjEwMDMsIDEKMTAwNiwgMQoxMDA4LCAxCjEw
MTAsIDIKMTAxMSwgMQoxMDEyLCAzCjEwMTMsIDQKMTAxOSwgMgoxMDIyLCAxCjEwMjYsIDEKMTAy
NywgMgoxMDI4LCAxCjEwMjksIDEKMTAzMCwgMQoxMDMxLCA1CjEwMzIsIDgKMTAzNiwgMwoxMDM5
LCAyCjEwNDAsIDEKMTA0MSwgMgoxMDQ2LCAxCjEwNDcsIDQKMTA0OCwgMgoxMDQ5LCAxCjEwNTAs
IDEKMTA1MSwgMwoxMDUzLCAxCjEwNTcsIDEKMTA1OCwgNwoxMDU5LCAxCjEwNjAsIDEKMTA2MSwg
MgoxMDYzLCAxCjEwNjUsIDEKMTA2NiwgNAoxMDY3LCA5CjEwNjgsIDEKMTA2OSwgMQoxMDcwLCA1
CjEwNzEsIDQKMTA3MywgMgoxMDc1LCA0CjEwNzcsIDEKMTA3OCwgMQoxMDc5LCA4CjEwODAsIDEK
MTA5MiwgMgoxMDk2LCAxCjEwOTcsIDEKMTA5OCwgMwoxMDk5LCAxCjExMDAsIDIKMTEwMSwgMQox
MTAyLCAxCjExMDUsIDIKMTEwNywgMwoxMTA4LCAyCjExMDksIDEKMTExMSwgMQoxMTEyLCAyCjEx
MTMsIDEKMTExNCwgMgoxMTE1LCAyCjExMTYsIDEKMTExOCwgMgoxMTE5LCAxCjExMjEsIDEKMTEy
MywgMgoxMTI2LCAxCjExMjcsIDEKMTEyOCwgMgoxMTI5LCAyCjExMzAsIDMKMTEzMSwgNQoxMTMy
LCAxCjExMzMsIDEKMTEzNCwgMwoxMTM1LCA2CjExMzYsIDIKMTEzNywgMgoxMTM4LCAxCjExMzks
IDEKMTE0MCwgNQoxMTQxLCAxCjExNDIsIDQKMTE0NSwgMQoxMTQ2LCAyCjExNDcsIDEKMTE0OCwg
MgoxMTYxLCAxCjExNjksIDEKMTE3NCwgMQoxMTc1LCAyCjExNzcsIDIKMTE3OCwgMwoxMTgyLCAx
CjExODMsIDEKMTE4NCwgMTEKMTE4NSwgMTkKMTE4NiwgMQoxMTg3LCAzCjExODgsIDMKMTE5MCwg
MgoxMTkzLCAxCjExOTcsIDEKMTE5OSwgMgoxMjAxLCAxCjEyMDMsIDEKMTIxMywgNQoxMjIzLCAx
CjEyMjksIDEKMTI0MCwgMQoxMjQyLCAxCjEyNDYsIDEKMTI0OCwgMwoxMjQ5LCAyCjEyNTAsIDMK
MTI1MSwgNAoxMjUyLCAxCjEyNTYsIDIKMTI1OCwgMQoxMjU5LCAxCjEyNjQsIDEKMTI2NSwgMQox
MjY3LCAzCjEyNjgsIDEKMTI2OSwgMQoxMjcxLCAyCjEyNzIsIDQKMTI3MywgMwoxMjc0LCA2CjEy
NzYsIDEKMTI3NywgMQoxMjc4LCAyCjEyNzksIDEKMTI4MSwgMgoxMjgyLCAyCjEyODcsIDEKMTI4
OSwgMQoxMjkwLCAxCjEyOTQsIDUKMTMxNCwgMQoxMzE1LCAyCjEzMzIsIDEKMTM0NCwgMQoxMzQ3
LCAxCjEzNTAsIDEKMTM1MywgMQoxMzU0LCA2CjEzNTgsIDEKMTM1OSwgNAoxNDU3LCAxCjE1NjYs
IDEKMTU3MCwgMQoxNTcxLCAzCjE2NTcsIDIKMTY1OCwgMQoxNjU5LCAxCjE2NjAsIDIKMTY5Mywg
MQoxNjk0LCAyCjE2OTYsIDIKMTY5NywgNgoxNjk4LCAzCg==

--------------Kekl0xUzrheFm0br2t5ZfpOr--

