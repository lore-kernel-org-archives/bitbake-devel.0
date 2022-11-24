Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFF4C433FE
	for <webhook@archiver.kernel.org>; Thu, 24 Nov 2022 12:17:50 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.22106.1669292266752326106
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Nov 2022 04:17:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=R5DfHsCi;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=8327d198c7=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AOAxrA3029978
	for <bitbake-devel@lists.openembedded.org>; Thu, 24 Nov 2022 04:17:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=qqGOOzWYwHcQ1K4akw3Mb5W9TkSrX7eteZYE8a7kIVk=;
 b=R5DfHsCiJUAusI4c5k4P/mqVlicCPOkTQ6LAI8jvM2CPJ+XYvu3hSgUGOSAKyBorFreY
 KKcsHYeHhm4w6dqCmMWRtAqvyF9kN4PZjxZh8JkZWVQ8kcU42/zyKznI93MfNx33DWe8
 obBApxPUN1WUk9X5hyU0if9gRJk1x5yMjsycRS89/R8Z4ANXDjNQBqUHkroVJ26DcLdn
 Yg3j8WydQZcyIqRcEayNkG6NFb9hyrBXKawtcdlj61kjKxgRp5hwxEgP/ot7hSMGJ6t8
 8zje+eXY2wkI5uiCV5TVNShmr2aOjgRibJdd4C9e7hdaQxfKFf/lsanQlWueJlt2rfgv cQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3kxyhqbyq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 24 Nov 2022 04:17:45 -0800
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AOCHjuU004746
	for <bitbake-devel@lists.openembedded.org>; Thu, 24 Nov 2022 04:17:45 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3kxyhqbyq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Nov 2022 04:17:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhrxD91QVC6/Wi+xQ1JBFYrjWKS0rku+giKutJSt2N6TBbpgpNWv9XeStvqajJf5RKIfzhJiJUsTb7I0KTlQARGXVaYDe9y7/dgu1HIE/tRT1Dnij7TeXrkGLHrBlDu/V/8/UzEF64sNU3HPbbtl+5iDf0yTVmyyQ4U2Ii0PkcxMSdPHeRIJEKw2v/DTNW4gY9iSRv+1i7s224VfeBu/q7HpsgCVJ9DZ97oQEwtxVU2GCdmcGLEhtPGDwN/Oaul478PukcuGQmgwAvr17A0oDxJtlkioSfJdMMFbFxiBNASvLHUCxl+NcfJgq6DobzbOGQ2lvw+EN9t3Aghb3KFEog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qqGOOzWYwHcQ1K4akw3Mb5W9TkSrX7eteZYE8a7kIVk=;
 b=M9JjwM63RWI+XjlsI6NihsL3OLhIMgINJ+jSddF71KTXAWj8SBumdTH6kwSmUJG+WZiwnpXqQHh/fJjJhB0/iD0D8g97U6o7uvQH0H3A+LmSte/RmFMX4k4vGDGJcd+0yaDKyNWYNvZXNK0Hy/o+b8fTB9AiiscZcSC44hZ9h4CXwi7NMczUzuYeNtasUiGc+hjShA81nuISJP37kEgXjnUCm3mgmzrTtONaH9PM3lH5GUF10qFGesajppMPbCCna/tI/TMPfbYCYZK0Q7qzpEEIYqCKBGmsit/WgaZYPgwuqhAZlZ1oZiyH6XuzRfXNZZ0kPbBY61QgUUykplBP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH7PR11MB5943.namprd11.prod.outlook.com (2603:10b6:510:13f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Thu, 24 Nov
 2022 12:17:41 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::d8ac:d3b0:6765:63f7]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::d8ac:d3b0:6765:63f7%9]) with mapi id 15.20.5857.019; Thu, 24 Nov 2022
 12:17:40 +0000
From: "Chen, Qi" <Qi.Chen@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "Yang, Liezhi" <Liezhi.Yang@windriver.com>
Subject: RE: [bitbake-devel] [PATCH] command.py: cleanup bb.cache.parse_recipe
Thread-Topic: [bitbake-devel] [PATCH] command.py: cleanup
 bb.cache.parse_recipe
Thread-Index: AQHY/+SrjV0lJ3aczEeN3Hbi3C7VVa5N+UgAgAADVbA=
Date: Thu, 24 Nov 2022 12:17:40 +0000
Message-ID: 
 <CO6PR11MB560282F9B2FC30CCCA5803D9ED0F9@CO6PR11MB5602.namprd11.prod.outlook.com>
References: <20221124091045.12018-1-Qi.Chen@windriver.com>
 <089c8b5944101a3ec48844fc744d7b6fd1558931.camel@linuxfoundation.org>
In-Reply-To: 
 <089c8b5944101a3ec48844fc744d7b6fd1558931.camel@linuxfoundation.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5602:EE_|PH7PR11MB5943:EE_
x-ms-office365-filtering-correlation-id: 55c8b277-1b7b-4595-ce63-08dace15e212
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 I0iQ2CDQA9ZND7izFgDuC4b84fNv0ABfod2/4B7VacgxW9CSTdRufpbQs5auKskeCF7p+qr+f0E1IerCG5ft+Piop5Sc8T0QiH8e4xWpfFVCCxTnEnMCNT4CAfdIyrn840b9656QzHB6ojQooAKp08SwNtb6z4zZuoXrOUcwD86XONXBV1jsxZrt6JUACwjzjlTAt3bBgBqsQuXf9YbWfOOHng3K0chqfp5QvNfkopBSr3PByjD7V9vL0cQEguju9q5JxxsFCfnKApsFIz+oeDyugvUkAPnSL+RlPoDaO4LHHMJvdPJBq9xktX4wmCS2nNyTbS/ezjmYsUdOYFdC2YJubHPL76dDLEKjmxN49jcEyfjHP/RaxeVY3bia4G109IkanvrTnNc3tSMQVjsH/gCqa5ENahrEBPRM+qx2yUuKk7jdQ+PavDc5GC7PfuRXOeojRG+xc1mAsLUeqgZkBJC6NBgD44/jczxX16/Plryfq1hTsZKWYq8eOZSFZA0iaa8eMj/5ryFfEZLoWbznM/RmMa5q1/Zn27mTgCooSin1YbbEIURvVhd+yG1AK/JJU4KAOtpVck5qCoNROy4Owxaks5EYa0PBqaJhNjsjOqUbeWHHAVNL6XOQRgkOI1lba786N3+7Em7uLsh9Vpu+UIcvgL3T/cRN98Z07YQxrwv4JgZjNR5DoUFuLZIfwKmVyW7ZiyNaN74deCBD/Sx1kDl/8LP71xvy8brTdk8kmg4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39850400004)(136003)(396003)(346002)(376002)(366004)(451199015)(86362001)(41300700001)(8936002)(33656002)(5660300002)(478600001)(55016003)(186003)(4001150100001)(107886003)(2906002)(316002)(66946007)(6506007)(66556008)(66476007)(76116006)(4326008)(7696005)(66446008)(55236004)(53546011)(64756008)(110136005)(8676002)(26005)(38070700005)(9686003)(38100700002)(52536014)(122000001)(71200400001)(83380400001)(9126006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UDRFeUo1VTU1eUE1RFNwak5uUTJOcFp5bmN4cER3Uk45R0FSd3ZQejNkbjVN?=
 =?utf-8?B?MmFmQXJVczFzNTJmVFY3WnJMdlZRamprVGppVzNuQU1FclNyNG5uRjhPUnl3?=
 =?utf-8?B?OFhGVnJFSHlCQWtyU2VDZ29acm5Nek51bUFUMnV3d3A0MFhmVEc3MmhOZ1RF?=
 =?utf-8?B?WGtmK0JVSHQ3YXJtSW1BYXJaaVE5NG5scDBuSXYybGttQkpqY2NUb0FCNlFB?=
 =?utf-8?B?TnpFV1Z1eGt2eGxuaXVHUE9MVXNSWlIvTU9nTE1qSitRczAvQSsyak13b0Vu?=
 =?utf-8?B?NzBMaXhMNTN6UGhjSHh2SDRGM1lQRXBNNGhZTVo0aWlyaFp0NmxsbitkZ2la?=
 =?utf-8?B?Y1c0VG5qTnU0OXU4NEMxdEUyNDFqckJqQ0ZRSWlCZkxrQitBMmYzdHJiTDNC?=
 =?utf-8?B?MVR6MjY1aTltQjdUOXlES2hLTmk4QjNsMkRoWW1QWVlOSlZmY2xuTzRsK3J2?=
 =?utf-8?B?NjNlRENsSEVJVGVIazVqVTJCZlNNWEFQTlRKKzZHSkVDN3ZPcmJVTk1PdjZY?=
 =?utf-8?B?QVY1YnpjMlBJdjFJWnZPb3kvcGwrZlN1THhoV09rMjRHSHQ1V2ZLRi9xTkI0?=
 =?utf-8?B?QU04aVRKQXJrR2U1Z2dkM2wxVnd4VCtHT3JoOHZFaTFYZGlNTE5GU2ErS01j?=
 =?utf-8?B?VUpHS0RRcCtlOEFKWGtnRXh4K2gyaTd6Ukg4TkwrVDh3eFVhQmY0aHN2eWY5?=
 =?utf-8?B?Z0pGSTRDYUlsMTN2RmZndDBIT1hJb09tVi9SOFd2UmlSWHh3NTg1R2lJSUxs?=
 =?utf-8?B?TjV0Q2Mzd0l4ZUluMndRL1VFNVJpZVdYOGExODRqTzdnRzVWMTBqSGg0YzFh?=
 =?utf-8?B?U1lGZlJmcjB3c0V6VVhwR3hnalpWb3RMR2luRERKNXZoYXZrRzJ5NWtRR3Z2?=
 =?utf-8?B?SndjUkpJOVJwVm05VVp6ZHNOQkJyTEUwU3ZRM25nQjlsOHdkTzNYNTMyZ1J0?=
 =?utf-8?B?M3R6emNXczBWdnVSSXNUQjZjSnMwUFh3SzcrcHQ2aUFlMXh5NGxQOVhnRHU5?=
 =?utf-8?B?ekh1MzE1ZXdDY1VDVTNVN0Zld3lSMkpwMDdGKzJ1WDFUWkgyM0xDNDBmRjYv?=
 =?utf-8?B?amNHWEEyaENOSFAxcUY3NnpNaWFYM282NkZ6cDRBMUNqSFBoVGxoZU53WTda?=
 =?utf-8?B?V3Q4cnFoUGFsSmVVaTQ3L0JXYjFTakd3SXZxa2hRLzZMT2cwVEliY04ySVRz?=
 =?utf-8?B?eEx5eSswWC9ZckRWNWVYWXVRR2N1ZUJWd0FrVGxtNHhKZjdGbWZacU1CaENR?=
 =?utf-8?B?WnkrQXVXczFlN0tGL3VDa1dBODVuTFlVczY5bytib1E5VHcxaXN3bUN5aXI3?=
 =?utf-8?B?Q1kzaTZVaDV5eUYrTXo1bEpnV1B1WDZRTjFKQ2VaTEdFS0o2NU5TYUtTWllo?=
 =?utf-8?B?Y2JGcDIyUkRHWDZyZ2IwRlg5S0NSQlA1WFgwQm9YT1JEQTg2WTJhUGI4c0Fh?=
 =?utf-8?B?cHFzelhtK1B1L3NpNEwzOEI1UkRYUDFoK2x6TGVKUC9zcXlzcm5RQmxVUVRi?=
 =?utf-8?B?WEQ5MTNDL2tNZE5SOUwxL01rRExxclR5MlBxRnNnQzZkZGdNd1BRZlljN2lr?=
 =?utf-8?B?cDJpckVZVnQ3YlJtL2RyY3B6bjJOMThYd0tFeldSNFBqelRCMS9GVytPaE9o?=
 =?utf-8?B?VnBvdTRwRVo3cG5GaEJBYlV5MG1RMEJzZzNOVml5bG12OElnVVlPSGFOdWsw?=
 =?utf-8?B?UDlVWmhVMW9TaGVkZkZFL0tmdGl4ZlhqVGlaS2ZTUUhTMUlxKzJFN3BSdUpQ?=
 =?utf-8?B?d2VPYkFOamozTG5XZkhCNFVnWXNOdXBOUmtKQUUzTEFvaEJIeGZSaFI3R2R4?=
 =?utf-8?B?TzVYQWFhNG04ak1nL0xzL3NNdGF6em9KVEFIa2JjTFVvcVhVOUNyQ3NydGRu?=
 =?utf-8?B?Y2plS0pFMUdDODlRTmsybHgyY3pObFVDcjc2RW9nNUdienRZU2tHNzR3bzhx?=
 =?utf-8?B?U0ZYU3hPRi8zUEdwMTRYUW1PM2FHUFd5YWdsRDRHVTFqRTVuODV0YjNuaDVO?=
 =?utf-8?B?SnZkdmdKYnlRdEFDeXVWaVVTdDROeG8vSkg4bjFsazYwMmRwU2dPU1o3Y1Vm?=
 =?utf-8?B?N3RTc09QSkh1RzlKcHgrKzYrUm93cFF2cU5KZmUyR3hZL3B6MUpwaWZZbFBZ?=
 =?utf-8?Q?Txa0FRntiy/23O8MYwxkH2OPh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c8b277-1b7b-4595-ce63-08dace15e212
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 12:17:40.8864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 60Z2Yfa8S/byorUIeohaJMWPwmWFBAshVOX2K6KV+Jp1fNyPT+b9E/4Ym/wbxHguOjF/MtQuHv3h9MfYfVS4tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5943
X-Proofpoint-ORIG-GUID: IVfUsg1mENYC8IXvolLFEVmRAfqTeCxE
X-Proofpoint-GUID: XdWslyI4LOkMVZr5zUI42l8WzdZZblZ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-24_09,2022-11-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211240096
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Nov 2022 12:17:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14107

SGkgUmljaGFyZCwNCg0KSSBtZXQgdGhlIGVycm9yIG9uIG91ciBsYXllcmluZGV4Lg0KDQpFcnJv
ciBtZXNzYWdlIGlzIGFzIGJlbG93Lg0KTk9URTogU3RhcnRpbmcgYml0YmFrZSBzZXJ2ZXIuLi4N
CkVSUk9SOiBVbmFibGUgdG8gcmVhZCAvaG9tZS9vZWxheWVyL2xheWVyaW5kZXgvZ2l0X19fbHhn
aXRfd3JzX2NvbV9sYXllcnNfbWV0YS1hcm0vbWV0YS1hcm0vcmVjaXBlcy1ic3AvdHJ1c3RlZA0K
LWZpcm13YXJlLW0vdHJ1c3RlZC1maXJtd2FyZS1tXzEuNi4wLmJiOiBUcmFjZWJhY2sgKG1vc3Qg
cmVjZW50IGNhbGwgbGFzdCk6DQogIEZpbGUgIi9ob21lL29lbGF5ZXIvbGF5ZXJpbmRleC9naXRf
X19seGdpdF93cnNfY29tX2JpdGJha2UvbGliL2JiL2NvbW1hbmQucHkiLCBsaW5lIDkwLCBpbiBy
dW5Db21tYW5kDQogICAgcmVzdWx0ID0gY29tbWFuZF9tZXRob2Qoc2VsZiwgY29tbWFuZGxpbmUp
DQogIEZpbGUgIi9ob21lL29lbGF5ZXIvbGF5ZXJpbmRleC9naXRfX19seGdpdF93cnNfY29tX2Jp
dGJha2UvbGliL2JiL2NvbW1hbmQucHkiLCBsaW5lIDU2NywgaW4gcGFyc2VSZWNpcGVGaWxlDQog
ICAgZW52ZGF0YSA9IGJiLmNhY2hlLnBhcnNlX3JlY2lwZShjb25maWdfZGF0YSwgZm4sIGFwcGVu
ZGZpbGVzLCBtYylbJyddDQpBdHRyaWJ1dGVFcnJvcjogbW9kdWxlICdiYi5jYWNoZScgaGFzIG5v
IGF0dHJpYnV0ZSAncGFyc2VfcmVjaXBlJw0KDQpSZWdhcmRzLA0KUWkNCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IFJpY2hhcmQgUHVyZGllIDxyaWNoYXJkLnB1cmRpZUBsaW51
eGZvdW5kYXRpb24ub3JnPiANClNlbnQ6IFRodXJzZGF5LCBOb3ZlbWJlciAyNCwgMjAyMiA4OjAy
IFBNDQpUbzogQ2hlbiwgUWkgPFFpLkNoZW5Ad2luZHJpdmVyLmNvbT47IGJpdGJha2UtZGV2ZWxA
bGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KU3ViamVjdDogUmU6IFtiaXRiYWtlLWRldmVsXSBbUEFU
Q0hdIGNvbW1hbmQucHk6IGNsZWFudXAgYmIuY2FjaGUucGFyc2VfcmVjaXBlDQoNCk9uIFRodSwg
MjAyMi0xMS0yNCBhdCAwMToxMCAtMDgwMCwgQ2hlbiBRaSB3cm90ZToNCj4gVGhlIHBhcnNlX3Jl
Y2lwZSBoYXMgYmVlbiByZW1vdmVkIGZyb20gYmIuY2FjaGUsIHJlcGxhY2UgaXQgd2l0aCB0aGUg
DQo+IGRhdGFidWlsZGVyLl9wYXJzZV9yZWNpcGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaGVu
IFFpIDxRaS5DaGVuQHdpbmRyaXZlci5jb20+DQo+IC0tLQ0KPiAgbGliL2JiL2NvbW1hbmQucHkg
fCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9saWIvYmIvY29tbWFuZC5weSBiL2xpYi9iYi9jb21tYW5kLnB5
IGluZGV4IA0KPiBmYTlmZDA1NGMuLmM5NTcxZjYzZCAxMDA2NDQNCj4gLS0tIGEvbGliL2JiL2Nv
bW1hbmQucHkNCj4gKysrIGIvbGliL2JiL2NvbW1hbmQucHkNCj4gQEAgLTU2NCw3ICs1NjQsNyBA
QCBjbGFzcyBDb21tYW5kc1N5bmM6DQo+ICAgICAgICAgIGlmIGNvbmZpZ19kYXRhOg0KPiAgICAg
ICAgICAgICAgIyBXZSBoYXZlIHRvIHVzZSBhIGRpZmZlcmVudCBmdW5jdGlvbiBoZXJlIGlmIHdl
J3JlIHBhc3NpbmcgaW4gYSBkYXRhc3RvcmUNCj4gICAgICAgICAgICAgICMgTk9URTogd2UgdG9v
ayBhIGNvcHkgYWJvdmUsIHNvIHdlIGRvbid0IGRvIGl0IGhlcmUgYWdhaW4NCj4gLSAgICAgICAg
ICAgIGVudmRhdGEgPSBiYi5jYWNoZS5wYXJzZV9yZWNpcGUoY29uZmlnX2RhdGEsIGZuLCBhcHBl
bmRmaWxlcywgbWMpWycnXQ0KPiArICAgICAgICAgICAgZW52ZGF0YSA9IA0KPiArIGNvbW1hbmQu
Y29va2VyLmRhdGFidWlsZGVyLl9wYXJzZV9yZWNpcGUoY29uZmlnX2RhdGEsIGZuLCANCj4gKyBh
cHBlbmRmaWxlcywgbWMpWycnXQ0KPiAgICAgICAgICBlbHNlOg0KPiAgICAgICAgICAgICAgIyBV
c2UgdGhlIHN0YW5kYXJkIHBhdGgNCj4gICAgICAgICAgICAgIGVudmRhdGEgPSBjb21tYW5kLmNv
b2tlci5kYXRhYnVpbGRlci5wYXJzZVJlY2lwZShmbiwgDQo+IGFwcGVuZGZpbGVzKQ0KDQpIb3cg
ZGlkIHlvdSBydW4gaW50byB0aGF0PyBJJ20gYSBiaXQgd29ycmllZCB3ZSdyZSBtaXNzaW5nIHNv
bWUgdGVzdCBjb3ZlcmFnZSBoZXJlPw0KDQpDaGVlcnMsDQoNClJpY2hhcmQNCg==

