Return-Path: <david.reyna@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A04C433F5
	for <webhook@archiver.kernel.org>; Fri, 27 May 2022 20:34:21 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.8459.1653683652505596918
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 May 2022 13:34:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=qraMCOSw;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=214633996e=david.reyna@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id
 24RKUTuX012049
	for <bitbake-devel@lists.openembedded.org>; Fri, 27 May 2022 13:34:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=AHaOd/6jivdw82/dJKZcDqFXEaE+dCPIsOOsa00ZzyU=;
 b=qraMCOSw5jkf0F2H1I5zmAaqFyFibdYlaCl3JbDJHtFA3TFKgek0e/73HWd4/4RUWDSP
 jKAjO8JIzVUSOFk+76CzyJOa+FiJIKt+9czvn86dWWzCcBRqNOGdKcx+y1vf6v5rVADw
 hunGzEWL5UFlUAAZWisg3AhuhIjXTZd+YdGhzInzfX4vIZDqOdmBqyDruTXPCNMQ7Uhg
 WvPxRphB0mvSRsW5+BC2BBp3OMNS5OHwDy35W0tIo3NtBrcWTXsvsseUiQm8T05rbyKc
 t9x4RyBffyH8wMRMGhp8J46VDj3R/cE0qqd0omvFqhXWm/w8T15qzVXxoc135g5wJNME 4A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3g93u9jn35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 27 May 2022 13:34:11 -0700
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24RKYB7B017483
	for <bitbake-devel@lists.openembedded.org>; Fri, 27 May 2022 13:34:11 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3g93u9jn33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 May 2022 13:34:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfnFTQPNZ06HR2qscwJ54KcJoVA0jSP9PmvGit3UBcfbaQyT49DZo/7df4VvOrslyiZ+3S+HdFiXhOQSeZdmxpwAVf1kY0aIcYqNW13VGLg9AxpY5ha+oS3BTcvQtaAf2h14/NgUXsOVxZU9Zo7bf1LMLGnGuUOy3MoGbjuDF2GSV9yFcdIxVhV8GwgZ+sCEuog2Q1IkRoOGS/YwvtfSvJW8vGjE4HnccjJoU4h8+np9r/CmWvnmbC1LupYeUjnJSGPcXDqFz04UynKevwr7KyY3UYEJxq/MvHt6ZRaF67pPtCk9N9XJnF4abKPWDws+iMREgSFnqQfGgytrz2+Ajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHaOd/6jivdw82/dJKZcDqFXEaE+dCPIsOOsa00ZzyU=;
 b=Z6/r41qRMhFUT3OMg45bR2Hvt7zkgsraG4A8tTodlJrvQy+C1+dl+9yP41Tt9uGEcDg6l+IDHEwF48DA1yiSXrGu7nXnb1aO9yVUKdhozy7FmBOID1Ap8Ud8FOnoQ17/2tk9EOofVeP2bVIvonOdV+JZAjgVi09+/XdE0L1zAKcFkP87awRxmeNV9Pp1tybR3Kni4IcvN1iny/fb1o5qpr58dKC0uDfK9077OWrtOY2uim/HaKxqSmIsXUKlIia4mjsCnmoMyewXvQhZXLP8FC5f63ah9QKfrhRm1msmEmr6WpNWXUMJo8vQQlEK751RXG0Ii3xzBtz+wAMs97DM3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BY5PR11MB4167.namprd11.prod.outlook.com (2603:10b6:a03:185::28)
 by DM6PR11MB4315.namprd11.prod.outlook.com (2603:10b6:5:201::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Fri, 27 May
 2022 20:34:08 +0000
Received: from BY5PR11MB4167.namprd11.prod.outlook.com
 ([fe80::996b:4c93:a787:8ba9]) by BY5PR11MB4167.namprd11.prod.outlook.com
 ([fe80::996b:4c93:a787:8ba9%6]) with mapi id 15.20.5293.016; Fri, 27 May 2022
 20:34:08 +0000
From: "Reyna, David" <david.reyna@windriver.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
        Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
        "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 0/1] bitbake: ncurses version of
 taskexp.py
Thread-Topic: [bitbake-devel] [PATCH 0/1] bitbake: ncurses version of
 taskexp.py
Thread-Index: AQHYcAAg2hkgHn6p2kOfI9sjxM8Ye60v8V6AgAAKuACAAvKPgIAAIGHg
Date: Fri, 27 May 2022 20:34:08 +0000
Message-ID: 
 <BY5PR11MB4167DAB8764220B01375B73AEAD89@BY5PR11MB4167.namprd11.prod.outlook.com>
References: <cover.1653448549.git.David.Reyna@windriver.com>
	 <b17960eece2c4985b066539792242c23@axis.com>
	 <BY5PR11MB4167CBD5CFCAC739E65B50BFEAD69@BY5PR11MB4167.namprd11.prod.outlook.com>
 <bab9cb806dbb1d11b8e29db5e66f5d58ace98b53.camel@linuxfoundation.org>
In-Reply-To: 
 <bab9cb806dbb1d11b8e29db5e66f5d58ace98b53.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f1a770f-478c-41d4-02dc-08da4020401b
x-ms-traffictypediagnostic: DM6PR11MB4315:EE_
x-microsoft-antispam-prvs: 
 <DM6PR11MB43158A59C1AE054A202FEAFCEAD89@DM6PR11MB4315.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 O2R9uzZNVkJb1IEmoB+DbNmxCsepdRW9MoJXkR5NnzhbqdxPFe5N3TgbgF2JR2+aIS7nCNtHC274G52cSWQG2w7DPEFReWXXPtSKMz3NB2Jb1tJLAATtTdTWYousAKSP5UqaHbVGuYogcfRd5t5CPT/ZXZx5fwUsRr7FX7VG/W1OzqhXtIMWcqxbIDQMYJMhqZdJQzM6339fyRjy73pQPx/+L0JieePhouQGQym0R5Icb4/MSbMPo556z/Nj6mcRSu4L3QM0iZOavrRrtbHlntnfdo1Ie0VSBN6p1Wtrmr3DkFTC4+LQL8V7UsrpK0pIGL6pV4LEWDFBR1mudjnBvGrMxGOUDEv0cHer9R3YvcyYZntJivTsrtlH1h4oa6pQVMT0ImXQ3W3THYcjcUKLmRED1AJ0N5IlNwWwLmWV2vW9rDO+u6zVE2aufcEkIWonamF2g66zL73v4CVqI8ON3YAO5Hr/dm7AIJ1NNFHhMTTwAUBNkLOsT/0ixYyzsS0pUACjGPl22P8vQtw95prL7EizAGtX/14Ze7OPZh4CnHO8ZnvLQMcVDyZ3/ocdURI76F6xFxeRn0zCj99J4I/dnuvy0hfYZ0FwbHNa07+kLYkccuh+R7JxKuX7cEJ0JvxmScc2rYeuXcJd7d4qAY8alb77sGrxn+DsvINiZbhmKX2rYnzljPS7NRO8pFVViJAhMd/nMHzEKwXadYwJEBM3tQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4167.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(7696005)(6506007)(316002)(71200400001)(2906002)(55016003)(508600001)(186003)(110136005)(86362001)(53546011)(122000001)(5660300002)(76116006)(83380400001)(8936002)(8676002)(66446008)(64756008)(66476007)(66946007)(66556008)(52536014)(38070700005)(38100700002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?R3V5YzBLbENJVkhSaXdHNXJDSzRHZHhSNHZaM2Fla0ZoOXI5QXF0YXp1T1gw?=
 =?utf-8?B?bTJRT1lLUzhkNnpCcFpWMXI5U3luMG1lMG01a2FHeVBOSjQ2bU0wemV0d3Aw?=
 =?utf-8?B?eXk4c2VINytPMEthbFdjMlk3cW9hWVN3NURNY0kwNlNKK0R4YTREZzY2SWEv?=
 =?utf-8?B?NG9qNE8reU5OWHM5emlBQnFPRjBFcVZFeUFEcWVNT0pKbmQwS2FoOU9xYlcv?=
 =?utf-8?B?UHdKb3FxUTc5YU96Y2pWMFdMRVRsK3dYbnhrYldxYXJyakVlcWU4QTVnMStR?=
 =?utf-8?B?bm5pVTU0MWhxYjZGOUZFRHMxVFBRK1VaVU9RaUxqTWZ0WW1VZ2FUYVoxNDVE?=
 =?utf-8?B?MVg2SElRck0wTHhlRVRRdE1HWGVTbmRSYlYrTk5ndXpxWnFiN0o2Z3V5R2Vq?=
 =?utf-8?B?K09XNHZPbTRiQ25ybXZQTTlScXVDTHZWWFgxeUhVWEhZelpiYm9MUGlYcWFi?=
 =?utf-8?B?VXF5UTVLTVpwYktxbTlBUTl4QnRlYU1XUk5Qc3lERkl4bWorSXhzOXBVYlBQ?=
 =?utf-8?B?Ryt4Z1c3WFgxdmxWT2dFcDFvUy9iUlJ4MnEybzlta1ZGdHJwUVFuREZpb2JD?=
 =?utf-8?B?NzIzOWNBczdhem5ETDRtU0JoT2o3TXpxUDBObmU1d1pveHErZnduaVlTaDBC?=
 =?utf-8?B?LytveURUTmtYYWk1NmlPTWp6VVJVSWx1ZUZEU0VlU2UySmFodXBKMVV1MFkv?=
 =?utf-8?B?MW5HbTN1S0RPYzI1WlJBcDNQSnE4ODNveXNQRWFqOElDQmxDSk1haXF3SDQ2?=
 =?utf-8?B?UmZvQzBHNXhONWdVcjhqKzRaQkkrdm5WUTBkdHVmRzh1VWZyanAycjZSOXpB?=
 =?utf-8?B?VTc4aWFFSFV2MEdPY1RBNGFKZmxoR0RHVllSYlkyMGd2dDBDaUJLbC95Ymd0?=
 =?utf-8?B?NmlRdmFFLzRraklCbURGV1JwZ0RuUVhkd3BCQThmc2pOVS9manNLM2JIVGRp?=
 =?utf-8?B?eHgySmdldm92SXNaTG1iTWM0Q0pEOHpjMXN6VVd5aVFaNTNUNGNSWTFsY1hl?=
 =?utf-8?B?S2hBU1U4UlMvSWpDakhiQ3J5YkxJcHRnMC93UFU0bWd6ekc2UjBzOW1qTFR0?=
 =?utf-8?B?blEwL2V3amlNTUhhYUpLbE0vWGcxNHZsOGxENDZkVkhMT2Z3Yi96Qzl6M0N4?=
 =?utf-8?B?UmtENUczZnF4ZHdvcW5JRE51OFlxa1FNUnMrS1NXbG82V3B0Qi8rTDBsbXRu?=
 =?utf-8?B?blFZdWd5V1FOSEowb0NqVW5nWUM3akVHYUJlWkJySUlLemVOK1hpSEVraVMw?=
 =?utf-8?B?aHVxcWxhNzBFSkdXMjFPZDdrM0RlYkt1eFF3RXZGWHplV1RmamlMNUxkQlFY?=
 =?utf-8?B?c1dpbzlyUjYzazZLTHFiclBDOU5nZFFTeU02ODZCMkw5ampuUnZTNzhuZEZk?=
 =?utf-8?B?TldpWVRLUEM1aTJPVFRXdHdHZHdsc1JDVjJ2aFpzTy9MRjNhcGhvRDh5YVVK?=
 =?utf-8?B?QmFSQkRHQ0Q1Y3Zoc3dISkI1alR2TC9INS9tVlFDQlhIQ05wQkdraEh4eW54?=
 =?utf-8?B?Y3VjeXd6MmMyZDlDdEgzZ3hvTDdlbkN0Q0VnbjJGQU4xTGYvdGxGa3EwWHpn?=
 =?utf-8?B?c1JCTytrVXhyUHpGdS9QNm1NYkhpWXNOdDBobUJsWmp1V1FGV2lwMnJJRFZj?=
 =?utf-8?B?eDZXQStLSzh6SkNwTlZGK054V29nN3R4bUlLZ1hZbWpKY3BiUGdSMnBwKzJX?=
 =?utf-8?B?L256K21lRWp4Rm94ckhPUWVITGRXYTRsYjBTeDVSeW80VVRPNVdzS0lRQ2xN?=
 =?utf-8?B?Y1Y3T2tXbUI0WmJFellFSlVZODZTWjRkNzhCM2dYcEozZFFURURLbU1aemps?=
 =?utf-8?B?aTViQzFwbWtsQ2cveGV3VmhsVUlBbXpGRTNUWnQraGNGTE1mOXBQa0hGYVd2?=
 =?utf-8?B?U2Y2ZjliaUdUdjM2Vis4d0Mxd1U5MDl3R1EvMFE0VHVEKzJrLzFyNTV4OUlI?=
 =?utf-8?B?N2w3elhZbC9JaGdaSjRGUHRGcnZLUVVCM1p0eWdjblkxTEZLcG9xM0lvNlJr?=
 =?utf-8?B?N2Z3MXlYeTdCYjhFclVhaGJGakVaVzVhR2QrdjdjelpqemQwNkt6M1prS1RN?=
 =?utf-8?B?SGRnRFpnY2hnaGZjZmpGd24razdiNTdQc2xFUEdyY1RSZGNJZUxiZklUeGRD?=
 =?utf-8?B?WHpFZTBXNGRtMEk4eE1IMm1Eak1yWWpDaW5sRUNuL1g5bFMxVktBcnpGbmJx?=
 =?utf-8?B?SjZ1NWlHN2loWi9ObHdVWUZUZUVhYmIwYlNCZGF3ZHQzR0k4TGp1Qkhzc1ZW?=
 =?utf-8?B?WVFlcnl1L3NvS3RoeHB2RGtaY1FIL09PY1pRZ2gxWXArUlBUTUVaeDFIZ3lk?=
 =?utf-8?B?Yys1aUVZdGNEb2paQXJuWEVZakE4SWRjdHVXV1A0bU03ZnZzQ0Z3SlJnR3d3?=
 =?utf-8?Q?alKRDokbCth+PNcTkjx0mGaLS+EBHlA7M1aPB+9SVUjV4?=
x-ms-exchange-antispam-messagedata-1: Bb0dLNPAeTomNL5rQGlMotV10ReVGCzm9rs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4167.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 0f1a770f-478c-41d4-02dc-08da4020401b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 20:34:08.4520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 gP02XFP97a5b23OU4LKWa7BZh4IfhFYL7smaeaY8Qp6S6778P9hkyiMefCAr4rK/tn84M//j1tvJFZLhy4zhfSwhJCLnUCScQbboUyKrJEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4315
X-Proofpoint-GUID: RhlTrbnXizAKPwQ8b1cKVXg9w_ZuiXWU
X-Proofpoint-ORIG-GUID: 1Zcqfx69uUbAOre_ntXO_H3kuqYqVVUG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-27_06,2022-05-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxscore=0 adultscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205270098
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 May 2022 20:34:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13717

PiBNeSBiaWdnZXN0IHdvcnJ5IGlzIGFib3V0IG1haW50ZW5hbmNlIGFuZCB0ZXN0aW5nIGFzIHdl
IGRvbid0IGhhdmUgYW55IHRlc3RzIGNvdmVyaW5nIHRoaXMuDQoNCkkgd2lsbCBsb29rIGF0IGlu
Y2x1ZGluZyBhIHR5cGUgb2YgYW4gImV4cGVjdCIgc2VsZi10ZXN0LCB3aGVyZSB3ZSBjb3VsZCBw
YXNzIGEgdGV4dCBmaWxlICh2aWEgYW4gZW52aXJvbm1lbnQgdmFyaWFibGUpIG9mIGtleSBjb21t
YW5kcyBhbmQgcmVzdWx0aW5nIGRpc3BsYXkgY29uZmlybWF0aW9ucy4NCg0KRm9yIG1lLCB0aGUg
c2NvcGUgb2YgcG90ZW50aWFsIG1haW50ZW5hbmNlIGlzc3VlcyBhcHBlYXIgdG8gYmU6DQogICAo
YSkgYSBjaGFuZ2UgaW4gdGhlIGJpdGJha2UgbWV0YWRhdGEgZm9yIHRoZSBkZXBlbmRlbmNpZXMs
IA0KICAgKGIpIHVuZXhwZWN0ZWQgY29udGVudCBpbiB0aGF0IG1ldGFkYXRhIGZvciBhbiB1bnVz
dWFsIHJlY2lwZSwNCiAgIChjKSBob3N0cyB0aGF0IGRvIG5vdCByZW5kZXIgdGhlIG5jdXJzZXMg
YXMgZXhwZWN0ZWQNCg0KRGF2aWQNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206
IHJpY2hhcmQucHVyZGllQGxpbnV4Zm91bmRhdGlvbi5vcmcgPHJpY2hhcmQucHVyZGllQGxpbnV4
Zm91bmRhdGlvbi5vcmc+IA0KU2VudDogRnJpZGF5LCBNYXkgMjcsIDIwMjIgOTozMiBBTQ0KVG86
IFJleW5hLCBEYXZpZCA8ZGF2aWQucmV5bmFAd2luZHJpdmVyLmNvbT47IFBldGVyIEtqZWxsZXJz
dGVkdCA8cGV0ZXIua2plbGxlcnN0ZWR0QGF4aXMuY29tPjsgYml0YmFrZS1kZXZlbEBsaXN0cy5v
cGVuZW1iZWRkZWQub3JnDQpTdWJqZWN0OiBSZTogW2JpdGJha2UtZGV2ZWxdIFtQQVRDSCAwLzFd
IGJpdGJha2U6IG5jdXJzZXMgdmVyc2lvbiBvZiB0YXNrZXhwLnB5DQoNCk9uIFdlZCwgMjAyMi0w
NS0yNSBhdCAxOTozNyArMDAwMCwgUmV5bmEsIERhdmlkIHdyb3RlOg0KPiBIaSwNCj4gDQo+ID4g
Ik1heSBJIHN1Z2dlc3QgdXNpbmcgYSBuYW1lIHRoYXQgZG9lcyBub3QgaW5jbHVkZSAiY2xpIiwg
YmVjYXVzZSBhcyBJIHNlZSBpdCwgLi4uIG1heSBiZSBzb21ldGhpbmcgbGlrZSAndHR5JyBvciAn
bmN1cnNlcycuIg0KPiANCj4gSSBhbSBvcGVuIHRvIGEgbmFtZSBjaGFuZ2UuDQo+ICANCj4gTXkg
dGFrZToNCj4gICAgdGFza2V4cF90dHkgOiBteSBwcmVmZXJlbmNlDQoNCkZXSVcgdGhhdCBzZWVt
cyBmaW5lIHRvIG1lLg0KDQpJJ3ZlIGJlZW4gaG9waW5nIHRvIGZpbmQgc29tZSB0aW1lIHRvIGRv
IGEgbW9yZSBkZXRhaWxlZCByZXZpZXcgb2YgdGhlDQpjb2RlIGJ1dCBoYXZlbid0IGdvdCB0aGVy
ZSB5ZXQuIEl0IGlzIGdyZWF0IHRvIHNlZSB0aGlzIGRldmVsb3BtZW50DQp0aG91Z2guDQoNCk15
IGJpZ2dlc3Qgd29ycnkgaXMgYWJvdXQgbWFpbnRlbmFuY2UgYW5kIHRlc3RpbmcgYXMgd2UgZG9u
J3QgaGF2ZSBhbnkNCnRlc3RzIGNvdmVyaW5nIHRoaXMuDQoNCkNoZWVycywNCg0KUmljaGFyZA0K
DQo=

