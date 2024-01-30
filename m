Return-Path: <joe.slater@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138BEC46CD2
	for <webhook@archiver.kernel.org>; Tue, 30 Jan 2024 21:54:29 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.9434.1706651661168903843
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Jan 2024 13:54:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=KsHbY1Qo;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=27595d2623=joe.slater@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40UBcB64025113
	for <bitbake-devel@lists.openembedded.org>; Tue, 30 Jan 2024 21:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=DdwD5y9AcrlLxgy0x6XNsuAk5Ut4U8ms8k6d0dovCII=; b=
	KsHbY1QoWljnbS5732QsYP6oKC5NMDf9kQNNdDGcoEQJbzjDAMoFB2J6r1IOnZzk
	otgmZo+qiZZOjMPtu2sGtlW0d3NeewW7VHhW6BuBVGh5DeN7i3uLluWRY/EvWtwI
	DLsNlmL3qiG29uI6blKGCv/1r36y36uc8QbP4UA+9Jym8+Hdr5Prh9WkEbvFkprn
	2UaGi0kevuJtyUwNwDnuAmQq5HMYTjt9aAxofxgjn9Q/JcgyN9WX2+hoC+zm/7oU
	f5jevcyDCoUtfjkOQSMLybO7QOMjtdWmuWx8j2eclsIiamJGzUfEW2LV16gVhN9w
	Gzp822wYrPdO190iqEG5Cg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vvrt63cfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 30 Jan 2024 21:54:20 +0000 (GMT)
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 40ULsJmG007205;
	Tue, 30 Jan 2024 21:54:19 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vvrt63cfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jan 2024 21:54:19 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BG0+I9jRsVI6jrK8YmweagDKHEE7ymc9aZ1opj8lYXpjLci3NQRWOA3GI+9eYCeoYj0pVQyejG7JyDNi3+rwf6Zhgh5HFy5bJrUvjkMrRxJ85dnZH6BvrJRtucBRxIqt2iOrMVHdtJ5GMk0LO8dReUjoQftA/bGioV3Ngjyn9QMhHY6YlnYTHhLv1yX4zgxHNP5c2ZgExxppbhObxJ/8QFYWFC7fq1LlsP/kh7p07bfM0nBCY4cPlqpPdGzuFDsbpPQcBGIAduW7HtLd7YgstS7tl5Gx08rDfqLjpHTngLxJ0N0oXRBXOXHSsONHpK1Xa0EFAfQ87QldsSJHYuU/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdwD5y9AcrlLxgy0x6XNsuAk5Ut4U8ms8k6d0dovCII=;
 b=hr1637ZFRi4ck6xVIPq0HZkEpStTiToqw2dNbjpjUUpYrBiat1ETZcFQn7AmreoXriHT+l5WHoZHnN1E1IHJwAm+k2VCxo7yuiYNrZD1APhhPrlrHfCHm3QFduEk04eyYs/yL3D4ncyz52PGSX5FC6Id6aWL/NsaokiuZ/SmmkszUV02qGDPMqpcN9Q7zas8s9q+VRLK67VjZP8ZKy2g522mUFwPFTcRdyYwi2mmmZKEXx4F1eAc7AWKzlZGG+DH2SxTta7pUCVaD4uDjDVpvlhLXiY2fGtEkKFloegW6lOSID7pcgRhG2AzdmwxbjxLy2groSYK0y3zYbSQTylcfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BY5PR11MB3992.namprd11.prod.outlook.com (2603:10b6:a03:188::10)
 by DM6PR11MB4515.namprd11.prod.outlook.com (2603:10b6:5:2a9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Tue, 30 Jan
 2024 21:54:16 +0000
Received: from BY5PR11MB3992.namprd11.prod.outlook.com
 ([fe80::36e7:fda7:1bfb:b7cf]) by BY5PR11MB3992.namprd11.prod.outlook.com
 ([fe80::36e7:fda7:1bfb:b7cf%7]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 21:54:16 +0000
From: "Slater, Joseph" <joe.slater@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "MacLeod, Randy" <Randy.MacLeod@windriver.com>
Subject: RE: [bitbake-devel] [bitbake][PATCH 1/1] utils.py: add ifVarInRange()
Thread-Topic: [bitbake-devel] [bitbake][PATCH 1/1] utils.py: add
 ifVarInRange()
Thread-Index: AQHaSjUkH3MEC6LcM0CXSgsaV9FZALDg4fwAgBITk9A=
Date: Tue, 30 Jan 2024 21:54:15 +0000
Message-ID: 
 <BY5PR11MB3992B692980E6CD491DA2BF2887D2@BY5PR11MB3992.namprd11.prod.outlook.com>
References: <20240118173821.1579936-1-joe.slater@windriver.com>
 <9f13c76e74d43cf0da4e9ee5815fbdc6038d84ae.camel@linuxfoundation.org>
In-Reply-To: 
 <9f13c76e74d43cf0da4e9ee5815fbdc6038d84ae.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB3992:EE_|DM6PR11MB4515:EE_
x-ms-office365-filtering-correlation-id: b2ded100-30dc-48fb-ab2a-08dc21de00d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Ibdn09DK+Rb//1FqhV1nbd8BZ3XJllqcLrIQaHPHgqOkfQHnvbSuDgfLJ49Oot8uiHqSVg5SP5FduoTOO/WBS8pSKOGVMCSchtWcBxGeu/c7hwdDnpE+SXd12JngDuDm6vtn0yhEbXmlP+RhvpPJOLHMZkKxasMPt2zEteHtpJIY8x1vMIgtvsRGKxMTnxBDX0DFpakwRaQxQi8CNyJBb6C5BYg9NaUs7mRzAs4YfLHAOvPXJ2aGRutl7ardYEO/AWU69p9Az41foGJbz85NF0VCiEw+BvphNAnEdggYYZ7/QFazjg9sQRRyXpfWMp06+RbFjKnO1N7Wf67nKcgNN/ajLrcZrKAjJuv/5gs7TP3JMtl3S4sC7pkv1w7lpqthdRnb6Xf+Od6DhCv0EIZq6V53WmdRhumjoBjzIFdYWzFzBIrLwgRNqTMQEuRUgGB9iXA/W23thQBFJJbnM0WlwZo3+zvxWnVrrAyXNTz8XxBXmajvJfdi0I96RhfgBcegvFOUOEcdzqrZLzFRBktZhhwVGeHRX9GlT+ctpLGSnQZPjo4eX4xhQGWYHs6JyTgBsWnrziRqJdVpHMmU/LRv/p16GFZvh9mI+9x15ROuUFfVesJnm58ZUt/e/QUXIfLB
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB3992.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(6029001)(346002)(39850400004)(136003)(376002)(366004)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(316002)(8936002)(8676002)(52536014)(4326008)(5660300002)(2906002)(110136005)(86362001)(66446008)(33656002)(66556008)(66476007)(66946007)(64756008)(38070700009)(83380400001)(38100700002)(122000001)(76116006)(53546011)(6506007)(7696005)(9686003)(478600001)(71200400001)(107886003)(41300700001)(26005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RjFodTcwNGpmSit1SlB1NWNTalVXeXFVTGU3TmM0K2JBSDNmcXc4ZzBRRUFH?=
 =?utf-8?B?NnE5eDFiUk4vQ01rTElxZU9vZzloZGUzaVk3MTVqVXV2bVh6SzJhNEs2TjBC?=
 =?utf-8?B?QWpXeGN5Wi9oRmdGMHZMYUVacHY1RFhkSUtQUll6M0JSUkRHUEZnOE5yT0JI?=
 =?utf-8?B?OFJnUHVmdDlrT0xKaHZMdEhYUkF6UU5OWTJPT1UwQ3lNMHVTdEhlbi8venFy?=
 =?utf-8?B?VGZSZUxJcHdLT0N5ZWdqUCtXUlUwZ3JCMGd1M2pyb0kxK3VHcmtJNDlMOGJi?=
 =?utf-8?B?Y0dkbEZwU3BnQkJuVmM1SmtrelYwNGZUUkxqOXhIUUJRRytYNjE4Uzh3aHlp?=
 =?utf-8?B?T1VYRlI1bmowLzV5RkNWVll4NDI0a3p0K21aYU51WGR1WVMydnlYKyt2TGZv?=
 =?utf-8?B?SGM2R0RQdVlvOEltTUZxVTNYWXhVN2pHM00vTUtuTWRlZDFxVVdWOVdFMC9y?=
 =?utf-8?B?a0RLNnRJQnhUTit0Yjh4anZLc1MzVUpVcm51UXpBbnVtRncwQTVXZTVWdWEv?=
 =?utf-8?B?ZC8xRzlISmlWSXdIR3ZrQ2VGNm5SZ3daNEJyMFFiMmFLVEM2bTM1OTN4U2xj?=
 =?utf-8?B?c1FUclVXaGxjMnJxakRETStGUml3MnI1cnh3Z2pRenhHWkN2dW45WldhK1gw?=
 =?utf-8?B?TzVqclpqRG5OYXpzSmFRTCt4Nk9OaHEyTWljNzRQZDgzc2tjckw0dHl3b01G?=
 =?utf-8?B?NzBreHprbmxFUUJvZDF4eWlDZ1lFaFZZd3htelNlVEJ1aEhuMFhBd3d0bGZX?=
 =?utf-8?B?bGVuS0VCK2F6NkhBM0t5WDJBNFlRZmZvNDhVbTZSTlplTUo1Y3NoUVZkUW5C?=
 =?utf-8?B?QWR1SW81bUpCcG9GVjlCU2s0dWIya240MStWZ0xtODZ3Q0F5UXVjb0lQVkFB?=
 =?utf-8?B?WndOS2dkc012RWN6N0JobGw4eTg1N3I0dXV6KzV2MU5DTEg0YVpFdTBVTFE2?=
 =?utf-8?B?Q3dDTmpXNHZZdFcySmtiUWU3MGViNUlxZ3RTbmI2VTY4TWExTmRYS0c4RU9s?=
 =?utf-8?B?d0JvU2ZJVG5VRWIrMzB5OUVIWHJ2eGpHdkVrczZVa1k2Qkc2NXdZaXNsQ0U3?=
 =?utf-8?B?ZWt2VlVCSDhsMlZOeDcwNWphN1pkbVNtQmtVL1RCQm1udGJmU2NySVpxdVkw?=
 =?utf-8?B?L3hmZ0RVYW52eGoydUtndUlqWnl3VmxuMVU5emdYSWxvdkExbEJyRm92RHlS?=
 =?utf-8?B?Zk5FbDJIdHZNWWhuNzUwZUNEOURQTWQvSjNsTm11RTlCQkMybFRMZEk1Z1Z1?=
 =?utf-8?B?aFBlSk1LUlV0M3hwU1hXcjJsMWdRWkdJY1dCdW1RU0ZIa2pKMFZLRzlrMVdq?=
 =?utf-8?B?Uzh1UmRwWERjNE5SY2w1Zm5URTBIQ1N3YUpscGNyTTRGbm5rZE41aWxpbGxW?=
 =?utf-8?B?QlRwbkdJQkNxNjdicDBhdy9GMlhVMitWNUhhVlNrcTBLV3NwbStHdVR0ZUln?=
 =?utf-8?B?cklSZU44UkJrOXh5WnpWSzkxSWczZ0JtVy8wM0NLcjJGd0p5VlZRMTBkTU1L?=
 =?utf-8?B?cnZaR3lXWUc5bUtmNzVnc016NGlpdG5TYWlKTXZ4Vy9zZHZrT2dkUFNCUFE3?=
 =?utf-8?B?OUgwTUNpTU9OZGJRejNtWFNCbGZ2ekJsMVVrNG1CM0pPRk42aGNlN29scXBz?=
 =?utf-8?B?R01jcDhBcUozQWRiNXYxTlR5L29hSGZYWmVqaEFnWUdBNUNlaGVtUi9DRHBz?=
 =?utf-8?B?dkhjRWNhcUhEY1JUcHBWSnFTRnZoZ0ZLRERUV0hpeTZWcDEzdGJRU1hETGVk?=
 =?utf-8?B?ZngzeEF4cytYZ1ZZVDVtVVIydmcwaFJoQ3hTUVBCQTROVnorNEp2d21RN0FY?=
 =?utf-8?B?bTlHSy9MY2NvaVgxVEpDVHUwYzhNN3h5VllvdW9RU05tSDNSb1NYbnBLcy9V?=
 =?utf-8?B?aVcvYXFWTVFOb0tLWmRXZE9mSHpIejRBQVgrVWI5WEY0NnlZQjVDazJhYXNj?=
 =?utf-8?B?eG1qQzlYa1laRWpjc0tMODRQSHE1QXNrb3JCK3loOGdqdkV5SkxkZEp4N2F4?=
 =?utf-8?B?TVp1ODNFZ0k0bTZKVVc5Tmt6Zk1iS3pTZXo4Unp4UDN6NmVrZXB3MEZTUjda?=
 =?utf-8?B?bDN2VUxSNHJrNjI1TUM0Mjg1U0JGQVpwNnIrWmlmY0RFR1hiL2RJTklrcUhh?=
 =?utf-8?Q?5CPuXMFwExofA0PQ8pCGEyWmH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3992.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2ded100-30dc-48fb-ab2a-08dc21de00d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 21:54:15.9722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OwzypNqBN+dcIeTeq4LQypwIXK9FR3GIFkgdNc5xhy0vDXBsilkmjkUK1Zp6Dcfx+7Yva+7lYEFmSBXoXNpPHbHrrm8PrW+xzRdN35BgW4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4515
X-Proofpoint-ORIG-GUID: jQ3pQHcLoXaCmi6wu4OOM6_Qb4CcadST
X-Proofpoint-GUID: BPVr7DQSHC-3dDFa1MpQ_cxdRuyae4Cs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_12,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401300164
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Jan 2024 21:54:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15808

SGkgUmljaGFyZCwNCg0KSSdtIHNlbmRpbmcgYSBwYXRjaCB0aGF0IGNoYW5nZXMgdGhlIGZ1bmN0
aW9uIGJlbG93IGZyb20gaWZWYXJJblJhbmdlKCkgdG8gdmFyX2luX251bWVyaWNfcmFuZ2UoKS4g
IFRoZSBhcmd1bWVudHMgYXJlIHNpbWlsYXIgdG8gdGhlIGNvbnRhaW5zX2FueSgpIGZ1bmN0aW9u
Lg0KDQpTaW5jZSB0aGUgZnVuY3Rpb24gaXMgbm90IGxpa2VseSB0byBiZSB1c2VkIHRoYXQgb2Z0
ZW4sIEkgd2FzIHdvbmRlcmluZyBpZiBpdCB3b3VsZCBiZSBiZXR0ZXIgcGxhY2VkIHNvbWVwbGFj
ZSB0aGF0IHdhc24ndCBhbHdheXMgcGFyc2VkLCBsaWtlIGEgYmJjbGFzcy4gIEluIGNhc2UgeW91
J3JlIHdvbmRlcmluZywgdGhlIGludGVuZGVkIHVzZSBpcyBmb3Igc29tZXRoaW5nIGxpa2UNCg0K
U1JDX1VSSSA9ICIke1NPVVJDRUZPUkdFX01JUlJPUn0vbGlicG5nLyR7QlBOfS8ke1BWfS8ke0JQ
Tn0tJHtQVn0udGFyLnh6IFwNCiAgICAgICAgICAgZmlsZTovL2xkZmxhZ3MtdGVzdHMucGF0Y2gg
XA0KICAgICAgICAgICBmaWxlOi8vMDAwMS1jb25maWd1cmUtUGFzcy1MREZMQUdTLXRvLWxpbmst
dGVzdHMucGF0Y2ggXA0KICAgICAgICAgICBmaWxlOi8vQ1ZFLTIwMTgtMjUwMzIucGF0Y2ggXA0K
ICAgICAgICAgICBmaWxlOi8vcnVuLXB0ZXN0IFwNCiAgICAgICAgICAgJHtAYmIudXRpbHMudmFy
X2luX251bWVyaWNfcmFuZ2UoZCwnT1VSX01JTk9SX1ZFUlNJT04nLHRydWV2YWx1ZT0nZmlsZTov
L0NWRS0yMDIyLTM3NDM0LnBhdGNoJyxsYXN0PTE0KX0gXA0KICAgICAgICAgICAke0BiYi51dGls
cy52YXJfaW5fbnVtZXJpY19yYW5nZShkLCdPVVJfTUlOT1JfVkVSU0lPTicsMTAsMCwnZmlsZTov
L0NWRS0yMDIzLTQ1ODUzLnBhdGNoJyl9IFwNCiAgICAgICAgICAgIg0KV2hpY2ggaXMgbGlmdGVk
IGZyb20gdGhlIHpsaWIgcmVjaXBlIGZvciB0ZXN0aW5nLg0KDQpKb2UNCg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIFB1cmRpZSA8cmljaGFyZC5wdXJkaWVA
bGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogRnJpZGF5LCBKYW51YXJ5IDE5LCAyMDI0IDE6
MzggQU0NCj4gVG86IFNsYXRlciwgSm9zZXBoIDxqb2Uuc2xhdGVyQHdpbmRyaXZlci5jb20+OyBi
aXRiYWtlLQ0KPiBkZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+IENjOiBNYWNMZW9kLCBS
YW5keSA8UmFuZHkuTWFjTGVvZEB3aW5kcml2ZXIuY29tPg0KPiBTdWJqZWN0OiBSZTogW2JpdGJh
a2UtZGV2ZWxdIFtiaXRiYWtlXVtQQVRDSCAxLzFdIHV0aWxzLnB5OiBhZGQgaWZWYXJJblJhbmdl
KCkNCj4gDQo+IEhpIEpvZSwNCj4gDQo+IE9uIFRodSwgMjAyNC0wMS0xOCBhdCAwOTozOCAtMDgw
MCwgSm9lIFNsYXRlciB2aWEgbGlzdHMub3BlbmVtYmVkZGVkLm9yZyB3cm90ZToNCj4gPiBGcm9t
OiBKb2UgU2xhdGVyIDxqb2Uuc2xhdGVyQHdpbmRyaXZlci5jb20+DQo+ID4NCj4gPiBBZGQgYSBm
dW5jdGlvbiByZXR1cm5pbmcgYSB2YWx1ZSBiYXNlZCBvbiB3aGV0aGVyIGEgYml0YmFrZSB2YXJp
YWJsZQ0KPiA+IGlzIGluIGEgbnVtZXJpYyByYW5nZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEpvZSBTbGF0ZXIgPGpvZS5zbGF0ZXJAd2luZHJpdmVyLmNvbT4NCj4gPiAtLS0NCj4gPiAgbGli
L2JiL3V0aWxzLnB5IHwgMTEgKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDExIGlu
c2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9saWIvYmIvdXRpbHMucHkgYi9saWIv
YmIvdXRpbHMucHkgaW5kZXgNCj4gPiAwNjhiNjMxYy4uNzZmMDg2MjMgMTAwNjQ0DQo+ID4gLS0t
IGEvbGliL2JiL3V0aWxzLnB5DQo+ID4gKysrIGIvbGliL2JiL3V0aWxzLnB5DQo+ID4gQEAgLTE4
MTAsNiArMTgxMCwxNyBAQCBkZWYgaXNfbG9jYWxfdWlkKHVpZD0nJyk6DQo+ID4gICAgICAgICAg
ICAgICAgICByZXR1cm4gVHJ1ZQ0KPiA+ICAgICAgcmV0dXJuIEZhbHNlDQo+ID4NCj4gPiArZGVm
IGlmVmFySW5SYW5nZShkLCB2YXIsIGZpcnN0PTEsIGxhc3Q9MCwgdHZhbD0iIiwgZnZhbD0iIik6
DQo+ID4gKyAgICAiIiINCj4gPiArICAgIFJldHVybiBhIHZhbHVlIGRlcGVuZGluZyBvbiB3aGV0
aGVyIGEgYml0YmFrZSB2YXJpYWJsZSBpcyBpbiBhIG51bWVyaWMNCj4gPiArICAgIHJhbmdlLiAg
Q29udmVudGlvbmFsbHksIDAgYXMgdGhlIGVtZCBwZiB0aGUgcmFuZ2UgbWF0Y2hlcyBhbGwgdmFs
dWVzLg0KPiANCj4gInRoZSBlbWQgcGYiPw0KPiANCj4gdGhlIGVuZCBvZj8NCj4gDQo+IA0KPiA+
ICsgICAgIiIiDQo+ID4gKyAgICB0cnk6DQo+ID4gKyAgICAgICAgdiA9IGludChkLmdldFZhcih2
YXIpKQ0KPiA+ICsgICAgZXhjZXB0Og0KPiA+ICsgICAgICAgIHJldHVybiBmdmFsDQo+ID4gKyAg
ICByZXR1cm4gdHZhbCBpZiB2ID49IGZpcnN0IGFuZCAodiA8PSBsYXN0IG9yIGxhc3QgPT0gMCkg
ZWxzZSBmdmFsDQo+ID4gKw0KPiA+ICBkZWYgbWtzdGVtcChzdWZmaXg9Tm9uZSwgcHJlZml4PU5v
bmUsIGRpcj1Ob25lLCB0ZXh0PUZhbHNlKToNCj4gPiAgICAgICIiIg0KPiA+ICAgICAgR2VuZXJh
dGVzIGEgdW5pcXVlIGZpbGVuYW1lLCBpbmRlcGVuZGVudCBvZiB0aW1lLg0KPiANCj4gDQo+IElm
IHdlJ3JlIGdvaW5nIHRvIGFkZCBzb21ldGhpbmcgbGlrZSB0aGlzLCBJIHRoaW5rIHRoZSBhcGkg
bmVlZHMgYSBiaXQgb2Ygd29yay4gSSdkDQo+IHByb2JhYmx5IGV4cGVjdCBhbiBpZlhYWCBmdW5j
dGlvbiB0byByZXR1cm4gYSBUcnVlL0ZhbHNlLg0KPiBJJ2QgZ3Vlc3MgdGhhdCBpcyB3aGF0IHR2
YWwgYW5kIGZ2YWwgcmVwcmVzZW50IGJ1dCBpdCB0b29rIG1lIGEgbWludXRlIHRvIHJlYWxpc2UN
Cj4gdGhhdC4gV291bGRuJ3QgdGhleSBhY3R1YWxseSBkZWZhdWx0IHRvIFRydWUgYW5kIEZhbHNl
Pw0KPiANCj4gVGhlcmUgaXMgbm8gbWVudGlvbiBvZiBJbnQgb3IgbnVtZXJpYyBpbiB0aGUgZnVu
Y3Rpb24gbmFtZSBhbmQgcHl0aG9uIGNvdWxkDQo+IGVhc2lseSB1c2UgZmxvYXRzIGluIHNpdHVh
dGlvbnMgbGlrZSB0aGlzLg0KPiANCj4gU28ganVzdCB0byBiZSBjbGVhciBJJ20gbm90IHJlYWxs
eSBzb2xkIG9uIHRoZSBmdW5jdGlvbiBuYW1lLCB0aGUgZGVmYXVsdCB2YWx1ZXMgb3INCj4gdGhl
IG5hbWVzIG9mIHRoZSBwYXJhbWV0ZXJzLiBUaGUgdHlwb3MgYWxzbyBuZWVkIGZpeGluZy4gSXQg
YWxsIGZlZWxzIGEgYml0IHJ1c2hlZC4NCj4gDQo+IENoZWVycywNCj4gDQo+IFJpY2hhcmQNCj4g
DQo+IA0KPiANCg0K

