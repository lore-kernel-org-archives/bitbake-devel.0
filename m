Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC2EC001E0
	for <webhook@archiver.kernel.org>; Thu,  3 Aug 2023 06:38:16 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.8643.1691044691505641151
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Aug 2023 23:38:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=jP0oA4zI;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=7579963e98=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3735mIcp008506
	for <bitbake-devel@lists.openembedded.org>; Wed, 2 Aug 2023 23:38:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=gpiAg5GfOVTlwPDFCE/8xd1sYJWWsaU9ajr94qUds0k=; b=
	jP0oA4zIR5h1nWCC+VLAz2WSwWFQxOeoExJDDHuKJWogIaSyi7Dru1L5xBQrLrj9
	65g9HVIUWpUysrRUTgYm99RAdy1LIOgVlcHXmr6uZYbdapQKBp/F/jENX4WFuPk+
	izSYQTZV1plFBGTyFcygHu0sZr+cYBbxq05OBhDWUYstCfVyMXQXtJB/bDz32Ci9
	qoffY/faVfZpGWTvE2FKD7PwYkopIuYKVQIhkMZK658WHgJL+ee206t9iaVoW8w1
	PfY8PDvJbTNoSc6N9HhzhW1q9+qZUSQ4HGbpuL50fwufF11kQwn1f+EEGxNiSLF+
	vGw3s1qJWDMTp2CGDSN+WQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s78py9c28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 02 Aug 2023 23:38:10 -0700 (PDT)
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.22/8.17.1.22) with ESMTP id 3736bJfF000914
	for <bitbake-devel@lists.openembedded.org>; Wed, 2 Aug 2023 23:38:10 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3s78py9c27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Aug 2023 23:38:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwcnhoH2rwZx0oLeK+0iQqRj2bOPsf+LtG/0GdRuO7H4s2iQ4WuteoS0OVoVIKN0WCNUKw+WADb+RBwE8qmhvhouccbumY2oEK4Kt8fmmCaXoGsiASlfMtEk4/0l68271XPr7F4wO6IyiiVGXgmfoX60Hc83DgjPQibZWaiuwLQt12bgyR4bjQ83Y4rkRLZ0Tcu4grOm+nlk4fTKSm/qjq0q3kSjfOpbD/5YkeBgKv0XmGaI0AnFp4GT9X39ObZI3PkBbXhzTpJOT+GYjTpelHwcNbXm2e+agwyjbQhwXkd/VRa2Ud2NSwnLy7t6LfYnWDlgubAjb8CJ/JvIJjZZZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gpiAg5GfOVTlwPDFCE/8xd1sYJWWsaU9ajr94qUds0k=;
 b=mC9yRTPT4xvlNJZIRqJ87OH07ylB8PcOXEOKYaosOi954q4wPHHwDD4hJrDEYDaBAsAtnxxEZiXJZuKnR2J2fKK6n3UJ4putcbYkJ474MEsKxh5b8evtOcusG2j3lmQYaJCVO+SnQa18KBRR2OClYuo+D5GJt97nx09Y1usj16mCYxRXUTa+wRQnfFHmFkMGXDSYHtl19UcbHsvhloqpwg4KMOkysoBwolLS8fTprOpe7vpK/VLfqyOL+AqacBajVhI29hf4Zm6DtaQ/VligPFXgZ7xyy+6LYwydOi/ZB+ghXWK0l5DTa8lRi9tpOVfTXmVrn8zJCi20H5Xap4l6nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SN7PR11MB8111.namprd11.prod.outlook.com (2603:10b6:806:2e9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Thu, 3 Aug
 2023 06:38:08 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::86dd:2ee6:ac66:812d]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::86dd:2ee6:ac66:812d%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 06:38:07 +0000
From: "Chen, Qi" <Qi.Chen@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "MacLeod, Randy" <Randy.MacLeod@windriver.com>
Subject: RE: [bitbake-devel][PATCH V3] runqueue.py: fix PSI check logic
Thread-Topic: [bitbake-devel][PATCH V3] runqueue.py: fix PSI check logic
Thread-Index: AQHZxcoX3UcotR1GvU+sNQhDbQ/dga/YGVMAgAAEcSA=
Date: Thu, 3 Aug 2023 06:38:07 +0000
Message-ID: 
 <CO6PR11MB5602693BCAE0AE6CA7A659D4ED08A@CO6PR11MB5602.namprd11.prod.outlook.com>
References: <20230803051916.1640841-1-Qi.Chen@windriver.com>
 <24aea6c874b03d9993b0d84dddc207afcdbccb4e.camel@linuxfoundation.org>
In-Reply-To: 
 <24aea6c874b03d9993b0d84dddc207afcdbccb4e.camel@linuxfoundation.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5602:EE_|SN7PR11MB8111:EE_
x-ms-office365-filtering-correlation-id: 0bfbaa2c-291f-4201-522a-08db93ec32e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 rC0VRXEyD6Hl7/TjUCfv9Up2WL5KGfzSCO40yYx1iOrpK+97Te3zvLOPO6k5Rc3Q+pSQEBb/172BhxOOf77/Z0GR2kqgFXj+fyZhJu521k50vBHG/pJ6SSQngg6+Tv4W/0X1IOZUTt8Ahq4Lt9o/SVcttN+7IXI8hyLPAYJqYzQJh4h6Y9sJ6fhILbnxoxxNhK3GlvJkT34aGYWH8v+kaGinp9J+5LvWVBgR0zx6HG8PN7CctNxCwArBVaBM36vpit1HaJYcr8+aDOO/LLmqn85Vu06n1ghpDq9PALlgkA8xUt6l6dQ54PNF9yJnINXWc5MZ3B4t23Q7YUlgDVbqH5ReaoIft1XFVhQB0o0/SlGftWMSHgKI1C+k6PRu77qFOlEFk88vQqLG7jP8oCcf4sxY8m308RRiC5mys11PEQX5rlvk1lma8W99qCJdOfGtyUN3L6vrHv53bsdx1M5ORh12pmnroUig4e8Ws8JeK/MKJnnaZkhzsUOpHW7AG7H2z5Ramre5ZRr3J2drcoBea8yUjuQcBVRdNFG7ecXeVxV7jXfIL2ij0pPuHLPIBBu4/A+peEXplQ9xuYs5MxyMwBD7+jFwYbugvjHCJHPfBaVSX68zYguWkYdbVxZVk7S7
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39850400004)(346002)(136003)(451199021)(110136005)(9686003)(478600001)(71200400001)(7696005)(6506007)(76116006)(186003)(66476007)(64756008)(53546011)(2906002)(52536014)(8936002)(66946007)(8676002)(316002)(4326008)(38100700002)(5660300002)(66556008)(122000001)(41300700001)(66446008)(83380400001)(33656002)(38070700005)(86362001)(55016003)(26005)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?empyT1QvQXVLcml5RVlSMEYrRXk0YnJMa0o1ZnNuTFIwWmlQRWRpMnNUWFYw?=
 =?utf-8?B?Q2xnNTZsQjdrMnlrTE0vSzloU2RVbEdTRkVWK2Z1ZnduYndOK3ZjSjhyYUtV?=
 =?utf-8?B?SXhSSDh1RkxHWlR1YkdFT0FCaEo2MFc0RXZIMzFZMkRtNkgrVG55eGpDcVdL?=
 =?utf-8?B?RGRON0gxUFFzSUQvU2IwNkpDZ0JkWDREMFhWTXU2cUpNVkV4L3ptTE1DbEtX?=
 =?utf-8?B?dllucUJEeFF3MjdZUnp6NEk2K01qdUFMYS9qcjJZVzlEc2pZWVM3MkVhazhK?=
 =?utf-8?B?VCtGa3k5ZXZSNkM4RVdYbXNMTTAyeGhGZVh2bWIyc0FJVXM4NW5mbVhRdlRK?=
 =?utf-8?B?bXpjNkdHTDhDOHo0ZkVvb29OeTluRHZiS2c3WlJYQmZ1bkM3UVdpRmpyUG1t?=
 =?utf-8?B?UUJiMFBLVkJBcVFOSkdSdlFHUUpzRy9ta1ltdVZ1bG55SS9DZ0FsQzFQdFpn?=
 =?utf-8?B?enM3ajlxMUhmRldid09RcjZwMUJRWUNheGpyckkySjR1UlJVQTVjTHJZWE5N?=
 =?utf-8?B?OTRvVFVJb1plUGRxOWhTSE80d28zY2JNOEU2Y2g2c0haSXo0ODlvQStDOTJU?=
 =?utf-8?B?WStsb05aUVVXZDVOY3JUZ2QyVHNlR0VpWE9QcUVQcWtXTUd1QjFoejhtT1Ju?=
 =?utf-8?B?bzluSkNqTUF2Vm1aaXgwL1NJV3U5WGdweUR2OGhYRGlwWkdzalVXSCt6V2JM?=
 =?utf-8?B?Vi9JQWg3THJwOXNpblR4a3p0THUxVkxnV2dodUNrTmpNMFRRTzdIMXNIWlFl?=
 =?utf-8?B?TVdWb3IzQWpyZUd1SFMwK1ZnWjQ1ZUpiN3lWT2hZWXNCcmJ0MnNteG5aMHMv?=
 =?utf-8?B?cGFnYTRFWXZBeHdxdk51RlpsQmlJOFVpMTNtTzZ4ZERzd3RaODI4VmR3cjdT?=
 =?utf-8?B?SGk4ejg0QUhZZ0Y0QmZNZEdmRlpTbGlYVmNhN2pZYWxoRVhza1NCZ2h5SS9N?=
 =?utf-8?B?L2V0a2UvYkYxc3VDZDJmVGFKK0EzbmRnNW1hdVF0VmJ1eWlNYVNMMlNsZ2Fw?=
 =?utf-8?B?a2dHSkprSjlWZmRIRGMzdlova0dLQUs5SFVqZUhwaGREWU1NZmFhMEs3N3hN?=
 =?utf-8?B?cURSTFV2ZHV2eVJXNG0zSlh2VzJRcWlMMWRaS2ZrMG1SV3ByUlJYVk9jQVNQ?=
 =?utf-8?B?V28xZ0pra2JidFltM05XWGtYU1NrUHFEOXRNRFo5RENCaWNjMUE3dHJyaWpr?=
 =?utf-8?B?Vm9aN0xjVFEyUTY2dzR2U3IrYUsyV1BoZjNqKzBCc0xVVTdCNVJFQkg0MjFI?=
 =?utf-8?B?NnlpWmV4UjZPZDJ0WEp0aDZPZ0lucHhRMWRDZEMzdFBjS2ZOMGNpb0ZiU1dB?=
 =?utf-8?B?L1prbG9wVTFIWWFUKzE3ejdQb1BUdUdEOWVVT0o4cnBQalBMK0U5M3M3amFq?=
 =?utf-8?B?Qi9DQ0puelVHN1JDRUZKYmJOK1V4RlBPRzNTSEtyanR5UzlMd1Y3UWhWLzJO?=
 =?utf-8?B?a0g4ckVuU0FLY1VZSUUxbGhmbkFvaUpGT25WNVl1WHlZVktsbnVseG85K2xW?=
 =?utf-8?B?bElBaVFvNXJFUzJyOWU0RXk3aHEyV2x5OVdJL21kQlE2cExrRWR2ZUVWMUVQ?=
 =?utf-8?B?ckh1UUJXTFhDRU1jeVowM1pQWU5udG1JR3R6V0taUDM5ZzJSTjVVR3I2bG1N?=
 =?utf-8?B?MzQzUlhBU2s0TlJkTWJaQjZJbDhVMk4zRnhtcGdpbGZ5NnVnQytCT01VZkND?=
 =?utf-8?B?RVQ5N3RpVnFDVndjTm9nWFhOdW95MS9DM0pqalU0Sm5Ha25zcXNpOGFCR213?=
 =?utf-8?B?L1VtVk5xeXJlcDB1c1ZLSnlub2FMT3pKWGNwU0J4SGF3NkF5YitaT0NWeTdO?=
 =?utf-8?B?MGZKd0FKb3RNVzkvZ3FZNWkycGIvbUxXSmFSUCsvNk92QTZRWndUcWxjZHls?=
 =?utf-8?B?UHhTc3pKc3FNRTVlaVNuU3J3SGlsZ0dNRTk2eDFoTURLNkdCZDBza2RDd1BE?=
 =?utf-8?B?ck9wdmFCaytHNEZXTmtTTFk0djkwSDNwWi9TditEMHowWHRvZ0NEQmFQY3RT?=
 =?utf-8?B?NU5Da0N0YlpmWFlGVlFlSmFhdUphZW1hN01VZllVblN1TWVVVG1aZnZKMjM4?=
 =?utf-8?B?MVppTnlRb3JIRC8raG9WVkJuZWtMNHlnczlUTGVlWGNINC9CMVFWVUZvM1gx?=
 =?utf-8?Q?6bNpRjKTb3MrBa25yN+0lwBPL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfbaa2c-291f-4201-522a-08db93ec32e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 06:38:07.8149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +V8e16ijq4gnM0OkuLnNN/rYh8m2DNpFenfRVgqZaO6RLhavnQrEA1FQmGpmZqoIP3QgbcabXmCNTvEDe+C6yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8111
X-Proofpoint-ORIG-GUID: LgW1QgM3aVgvGRWLhNDRyYXeDTgs2x__
X-Proofpoint-GUID: TYxsNIXvlaLwSxzFl_IqCiwXU5uxJWH4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_04,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308030058
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Aug 2023 06:38:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14911

VGhhbmtzIFJpY2hhcmQuIFlvdSdyZSByaWdodC4gSSdsbCBzZW5kIG91dCBWNCB0byByZW1vdmUg
dGhlIDFzIHdpbmRvdywgdGhpcyB3aWxsIG1ha2UgYml0YmFrZSBkbyB0aGUgY2hlY2sgZXZlcnkg
dGltZSBpdCB0cmllcyB0byBzcGF3biBhIG5ldyB0YXNrLg0KDQpSZWdhcmRzLA0KUWkNCg0KLS0t
LS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFJpY2hhcmQgUHVyZGllIDxyaWNoYXJkLnB1
cmRpZUBsaW51eGZvdW5kYXRpb24ub3JnPiANClNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMywgMjAy
MyAyOjE5IFBNDQpUbzogQ2hlbiwgUWkgPFFpLkNoZW5Ad2luZHJpdmVyLmNvbT47IGJpdGJha2Ut
ZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KQ2M6IE1hY0xlb2QsIFJhbmR5IDxSYW5keS5N
YWNMZW9kQHdpbmRyaXZlci5jb20+DQpTdWJqZWN0OiBSZTogW2JpdGJha2UtZGV2ZWxdW1BBVENI
IFYzXSBydW5xdWV1ZS5weTogZml4IFBTSSBjaGVjayBsb2dpYw0KDQpPbiBUaHUsIDIwMjMtMDgt
MDMgYXQgMTM6MTkgKzA4MDAsIENoZW4gUWkgdmlhIGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcNCndy
b3RlOg0KPiBGcm9tOiBDaGVuIFFpIDxRaS5DaGVuQHdpbmRyaXZlci5jb20+DQo+IA0KPiBUaGUg
Y3VycmVudCBsb2dpYyBpcyBub3QgY29ycmVjdCBiZWNhdXNlIGlmIHRoZSB0aW1lIGludGVydmFs
IGJldHdlZW4gDQo+IHRoZSBjdXJyZW50IGNoZWNrIGFuZCB0aGUgbGFzdCBjaGVjayBpcyB2ZXJ5
IHNtYWxsLCB0aGUgUFNJIGNoZWNrZXIgaXMgDQo+IG5vdCBsaWtlbHkgdG8gYmxvY2sgdGhpbmdz
IGV2ZW4gaWYgdGhlIHN5c3RlbSBpcyBoZWF2eSBsb2FkZWQuDQo+IA0KPiBJdCdzIG5vdCBnb29k
IHRvIGNhbGN1bGF0ZSB0aGUgdmFsdWUgdG9vIG9mdGVuLiBTbyB3ZSBjaGFuZ2UgdG8gYSAxcyAN
Cj4gY2hlY2suIEFzIGEgYnVpbGQgd2lsbCB1c3VhbGx5IHRha2UgYXQgbGVhc3QgbWludXRlcywg
dXNpbmcgdGhlIDFzIA0KPiB2YWx1ZSBzZWVtcyByZWFzb25hYmxlLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQ2hlbiBRaSA8UWkuQ2hlbkB3aW5kcml2ZXIuY29tPg0KPiAtLS0NCj4gIGJpdGJha2Uv
bGliL2JiL3J1bnF1ZXVlLnB5IHwgMjkgKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCg0KSSB0
aGluayB0aGUgY2hhbGxlbmdlIHdpdGggdGhlIDFzIGRpZmZlcmVuY2UgaXMgdGhhdCBpdCB3aWxs
IGNhdXNlIHR3byBkaWZmZXJlbnQgYmVoYXZpb3Vycy4NCg0KVGhlIGZpcnN0IGlzIHRoYXQgd2hl
biBpdCBsaW1pdHMgcHJlc3N1cmUsIGl0IHdpbGwga2VlcCBsaW1pdGluZyBmb3IgYXQgbGVhc3Qg
b25lIHNlY29uZCBhZnRlcndhcmRzLiBUaGF0IG1pZ2h0IG5vdCBiZSB0b28gYmFkLCBpdCB3b3Vs
ZCBwb3RlbnRpYWxseSBqdXN0IGRlbGF5IGEgYnVpbGQgc2xpZ2h0bHkuDQoNClRoZSBzZWNvbmQg
aXNzdWUgaXMgdGhhdCB3aGVuIGJpdGJha2Ugc3RhcnRzIGV4ZWN1dGluZyB0YXNrcywgZXZlbiBp
ZiB0aGUgcHJlc3N1cmUgb2YgdGhlIHN5c3RlbSBzcGlrZXMsIGl0IHdvbid0IGJlIHNlZW4gZm9y
IG9uZSBzZWNvbmQgYW5kIGJpdGJha2Ugd2lsbCBsaWtlbHkgaGF2ZSBleGVjdXRlZCBCQl9OVU1C
RVJfVEhSRUFEIHByb2Nlc3NlcyBpbiB0aGF0IHRpbWUsIGxpa2VseSBwdXNoaW5nIHRoZSBwcmVz
c3VyZSBvbiB0aGUgc3lzdGVtIHdlbGwgYWJvdmUgdGhyZXNob2xkLg0KDQpJIHN1c3BlY3Qgd2Un
cmUgZ29pbmcgdG8gaGF2ZSB0byBjb21lIHVwIHdpdGggc29tZXRoaW5nIGRpZmZlcmVudCB0byBo
YW5kbGUgdGhlc2UgaXNzdWVzLi4uDQoNCkNoZWVycywNCg0KUmljaGFyZA0K

