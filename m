Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E0CC07545
	for <webhook@archiver.kernel.org>; Tue, 24 Oct 2023 14:20:20 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (NAM11-CO1-obe.outbound.protection.outlook.com [40.107.220.77])
 by mx.groups.io with SMTP id smtpd.web10.148988.1698157212373260807
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 24 Oct 2023 07:20:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=Q6JNXAkX;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.220.77, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3z4UxjJjluDb3um+iazZKLhn2WqmXTKG/X+m4RZV4lHPZZvkGrdb8TvOP1WZLQbCSq7HAuxJZ3cxOv39luHX2gGzXZxEtxd4+j/XJlqRjczkC8qktVUiJTSQejhnkmt301/VZGFkj2WMJXvs5BvkNHtQypZWlTml78MhYOhNzCxTfd5en8SekQ+e+FjVYhuQlbcr1Gd78n3jaBF6azwW3Ny65rfvGu1E3N3/3Y93iw8DLNLiqd4e3vCuM56TDf12K90/koS/zWWoeyYwn/NFCjeazTRzEIn8V3FGARNU8iOnkyxvB1HA4aZySA6s+mlvJGfIB9COsxzo1Mkm7gYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=539Qn/4lB/CN9TP/mauyn/EHdiXlOMSlvPAudcbwRyc=;
 b=Kd4afiEFDpqJUBuu11V/RVeBi5rG1mrwE+tqigKI+JGXc+QCjkwuNNkJcbxvPqnak18j9LWECH1+F4lQ8UaxG+MmpV6Av+vrlWGOrYJf9ZHpjFvj6N+DedDaGTMTIWNtTeQfjSKV73c/LVZnrmFBy9SAaX3Xz6oAQczad1sBEg8XEzASBwXff1j1nsNzKGSs7veI/0NzOcIWYaTZKsbOrQTl1kH8iqAXDYFxScbxqEMZXR9Axsy2Sp7XKH+ZY+wM5J5UxBpc5BVhmENfnumUyLDC+Q8t5cTt3cMTHqFhyO/ipjm1ECGa6p/g4KBiVGLUId+ZNj0nC9LUtstNMIR6KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=539Qn/4lB/CN9TP/mauyn/EHdiXlOMSlvPAudcbwRyc=;
 b=Q6JNXAkX36NxAkenBUPCchrc7cIasULCWRVw7vP4pJquN9PQgwnBwwuVKlQ7jJlQ+lmmWLu+FGMSNs1/x5rE0/GS2W1XyFmJwQuq53t5YEF1b1o76tjMouj9vdSvGX9vAYg8q2N7njpeSVLcq7XfvNKI2wQcI6RR2wJVGPoJHB+M98kksmfuYGPPB99SriDPcKYi42IrALo67vaIArJMfW9SPFWVoILJInCRtf+v5bg+zfm/gH6+Hm+TeaCsol5xQ/TkJuoVqe87vkE2mvBwoaQ1Y+NNMNLjX7S72rq0jxOySDAVJpUN3FCRkz21yE/a+kVI5rBgLQH2O4JSj1aYnA==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 SJ1PR12MB6098.namprd12.prod.outlook.com (2603:10b6:a03:45f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Tue, 24 Oct
 2023 14:20:09 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::1e30:3574:8cbc:7278]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::1e30:3574:8cbc:7278%3]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 14:20:09 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH v2 1/2] codeparser/utils: clean up more
 deprecated AST usages
Thread-Topic: [bitbake-devel] [PATCH v2 1/2] codeparser/utils: clean up more
 deprecated AST usages
Thread-Index: AQHaBdB7tmQIsRZPe0qCy5A1kyhHTbBYwogAgAA0OoA=
Date: Tue, 24 Oct 2023 14:20:09 +0000
Message-ID: 
 <DM8PR12MB5430A7B05AF2D5880F3954598BDFA@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <20231023164613.1441846-1-chris.laplante@agilent.com>
 <928101e5e266ca3ffc86bc8fb07a4a67ba51e938.camel@linuxfoundation.org>
In-Reply-To: 
 <928101e5e266ca3ffc86bc8fb07a4a67ba51e938.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=efe3ca3f-ebe8-45dd-a26d-c10d8ebdcde3;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2023-10-24T13:51:31Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|SJ1PR12MB6098:EE_
x-ms-office365-filtering-correlation-id: 6e80671b-fc50-4be1-80a5-08dbd49c5425
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ctEd3p0GFTRAP843Be5zb+5DHmRHkKnmcQMjyzrz66yjgPPsHPlrjZkCUZv1AkjygAUe48xZzUWOi0pIBP0R+h/U5wxxglkty/Lr5/Nz0Ib6IuN9v1oMGmlLOfxVUPmJEotZLx35aMYCaRclrwQ2QpiEgGUIAD0nhj9Q1wXzBSS9FU90lttb9WvZBYo+470Jo+syTGUTpghQ6CvUK6eLvNt9TSN4ja184pucd9qCWPSmTyHg42l9wOOl5g5npLufV02JJ6UbTVXiq/LzPdX6+kb80UyHfMclj+SrbPpnMcIunafFT8xKwqFbWLAYR8Q7mcG+T7OBGli48ejV+AUY/+OWHFVSv9x8oh498FKPGdVdtWDhDa2LKcOD/+hSrS2D1uPXpi39yCZKzPz/xKT0guaFl9fxpZyPDoc+4dhZUaCQFhtB91MHLHi+VytgNJy9Vl0qU9PDqqzTkm1HkjtKhZ8JLFYs9O/bE83WHhdDMcOBzn+xdOg0zlA1xJvUCGxaI11eEUe5c/J6VMyh6gYI0MN1qEo0vJL+RFSknoH1UumLzbLK3ds6fyBQBUhtE0a2lChQ7dp/CU5DnV6hScrk/jDzstinOuRfRc07v17xar2CGbdbl00k5noG4cWlAHRz
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(366004)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(38070700009)(26005)(38100700002)(41300700001)(2906002)(55016003)(86362001)(52536014)(5660300002)(8936002)(8676002)(33656002)(6506007)(478600001)(7696005)(71200400001)(110136005)(122000001)(66946007)(316002)(66476007)(76116006)(66446008)(64756008)(66556008)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RWtJNVlZclBqa0g5bkVWT0gwNmRZVm4wRVR1Rm5pMFRzcE5PYnRLdUJjSWdz?=
 =?utf-8?B?RDQyTjBURUMrcTVVRmExUkszdlRnc053RW1LYVUwTDVCNjI4SGRETEd4T21K?=
 =?utf-8?B?Y1A4N2M4a2lSdlVoemp5MFVvWXIvZklzdldtWmpYZ1pMeHF3NmVSNUdlWkl4?=
 =?utf-8?B?SE12VXR5NUpjUEpmOUhGcnY4bUJTQlN5MzA3MitKTi9iSjlmODV0bDZwOFNU?=
 =?utf-8?B?K3RCUXQ4MVk0YVZDZ09razRxT3NpaWppS1FiRit6SUJCMklNaVZjMks5ZHdQ?=
 =?utf-8?B?b3RScE43Q3d6WWE0U0x5M251MFRrWHA5WjFZdjNzWmJGNzAzb2tCTU53SGs4?=
 =?utf-8?B?Zms2Z1BGTWZWWkJwMkJuRi9ONVk3Y2prK0FWd240UmVXZ0NacGdMMVRIc3Bi?=
 =?utf-8?B?VUtjMlZoV21tYWpLT3VvY2hJMnZLeFZud1VYSFRLTnI1OUNLQWIzZWQ0ckxi?=
 =?utf-8?B?bDRiM202RkJST1BHakdqWFN2UXZsTjVqWmVPdDVHN3hIQmNpaFVvdklWU1F5?=
 =?utf-8?B?OUQrbzFDMCt3UitRUkJwLzVoR2JjRHZyZjhMMDkwTDM1KytINVNzUG40OEt0?=
 =?utf-8?B?dmJFb0dkbmthOWttZEF3NEg4UWpad2lTY2dWQXpMRTZRUE52WmZRSU1xVVJa?=
 =?utf-8?B?N1dVM2pUMU90YU1KWjVqTExFWVMrL0Nvc2lMZzN4Z1JVditnbmNvWEtnSXZX?=
 =?utf-8?B?dTMyTFd1Z2I5b01yQlo0bk1weE5DZzVEbEhsK1VXMlI2eVIvRTU3ZTRwQUh2?=
 =?utf-8?B?b1F1VU9nUUMycG9IZkczZnVWNFQ4a0NFbnN3YWtydkVlNVQ4RDA3SGJvUmpT?=
 =?utf-8?B?RzY1UDBMWXh6NW9tN1RaS08yNTBsQUR5VjhBSmRCYkR2ZHVaS1dsVi9jaXla?=
 =?utf-8?B?Yk9zS0tyNm5FZHYxMExvL252NDlJSGFhU0tqdmFibTByWUpoZ3prQm95VnY0?=
 =?utf-8?B?bXlPQ29xUGc2UHdlWkxOYXJodkUybjJkR3E1aGxGa21pZXFaeVBKdEZ3WDl4?=
 =?utf-8?B?VmJscExWc3preXRGelNHUlUyaDRrWXFuT1JMU0YrMDlwWDBkb01BdG1RTjYy?=
 =?utf-8?B?RW8za3FGcC91eUxSRitjWGFkN256U1ZOTnU4MXFFSDJLaGxuMTVublRWZnNq?=
 =?utf-8?B?N1J0am5VaGZIeEFHM2pSLzlSMEk0RnFhcEc2SFNGUXlzbTF4V3Z0Q3RnSW5T?=
 =?utf-8?B?czdtMVcxMkVjUkw5STJLWlIrRDY1QzhSOElRaXQybU9kWG1HdW41NTlzRHpU?=
 =?utf-8?B?Tm5YS1AwY2ZNWVZYK21sUElqbVBkckZIUnhFczl4MW90U2VPREpKM0JlbnRx?=
 =?utf-8?B?QmJRTEdjWHNCV2M5aStyWXZiVHlBbjY3OTRMSmZwTnRBWG5nbTNXd09ZekZT?=
 =?utf-8?B?eVZXY1lleXRnUHVxOXRQL0NaeFVoVzFEa2JLbFZ0aU1TcUJPTEtaaG5lSHVx?=
 =?utf-8?B?cVZwRjA1aXRoSzhOVmZBRjJsTUdiWEptSEE1ZDFNc28zTk0zbk5aS1daK1Uy?=
 =?utf-8?B?dk1Tay9ObDZyV2ZDV3VVTVFVaTVYZWdQWHdyS291ZTdUd1BKT3RXWmpkZFRK?=
 =?utf-8?B?LzJHNWY5dDdtNi8xWVZycVV5bWpvVG1QQmtOZHJLL2ZMQmVKODBaRWJza2pH?=
 =?utf-8?B?VXFRY1B6TGFUT2huOWRyL0xGQSt4SFVGOU5nNVRBc1ZkT1R3YUsvMkt6eW5I?=
 =?utf-8?B?NEY5Qm5DYVg5cW9TT1ZuMUtKTjFlUE93Rnd0cEN3MGdlUnp4R3JGV1B4RUMy?=
 =?utf-8?B?clFnMGZNc255aUZBU002UWYzd05TbkxzYmVmM1hVTFBOcTV6NWw4Um5pZkFu?=
 =?utf-8?B?bXBXMHFEM1EwVXFEbHJ5Rld0UG1PWG94eDJ2ak1Tb1hQK3oxNzUzNkEwbVBh?=
 =?utf-8?B?Z0NJVDd2TmlaVHhyZU9FK3d2ZmdndWNDQWhUV2E5WUN4VzN1MTFMYlJFSzNn?=
 =?utf-8?B?S0FIV05WRFVXSjN0cWxnUlFCSkQrbWk5NDdLUXBTNG5VZzlrU3hvTTdlU2M4?=
 =?utf-8?B?NndsODBLdlE3M1FJQTRYOExad2szZkttT1hUUDNPOXJ0WmhpZzJhbUtQU3A4?=
 =?utf-8?B?VlVoQXRmQTMzSC91L1BRVEh5U0tJanBXa202MFB1OEREQkpJWlV2SjJLSUs3?=
 =?utf-8?Q?lg1F1yOHOKtf66f1Hj0MDh3S8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e80671b-fc50-4be1-80a5-08dbd49c5425
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 14:20:09.4719
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trIjRiFJaMT6wAtzKyNbFj5NPWX15KkR48x3yTL3LTcdWP1+74aYfebero0u++rV7kN5M8zWsqiK04OEBw1oozMgqflMXCOEurT6pvK+RpM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6098
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 24 Oct 2023 14:20:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15280

SGkgUmljaGFyZCwNCg0KPiA+ICAgICAgZGVmIHZpc2l0X0NhbGwoc2VsZiwgbm9kZSk6DQo+ID4g
ICAgICAgICAgbmFtZSA9IHNlbGYuY2FsbGVkX25vZGVfbmFtZShub2RlLmZ1bmMpDQo+ID4gICAg
ICAgICAgaWYgbmFtZSBhbmQgKG5hbWUuZW5kc3dpdGgoc2VsZi5nZXR2YXJzKSBvcg0KPiBuYW1l
LmVuZHN3aXRoKHNlbGYuZ2V0dmFyZmxhZ3MpIG9yIG5hbWUgaW4gc2VsZi5jb250YWluc2Z1bmNz
IG9yIG5hbWUgaW4NCj4gc2VsZi5jb250YWluc2FueWZ1bmNzKToNCj4gPiAtICAgICAgICAgICAg
aWYgaXNpbnN0YW5jZShub2RlLmFyZ3NbMF0sIGFzdC5Db25zdGFudCkgYW5kDQo+IGlzaW5zdGFu
Y2Uobm9kZS5hcmdzWzBdLnZhbHVlLCBzdHIpOg0KPiA+IC0gICAgICAgICAgICAgICAgdmFybmFt
ZSA9IG5vZGUuYXJnc1swXS52YWx1ZQ0KPiA+IC0gICAgICAgICAgICAgICAgaWYgbmFtZSBpbiBz
ZWxmLmNvbnRhaW5zZnVuY3MgYW5kIGlzaW5zdGFuY2Uobm9kZS5hcmdzWzFdLCBhc3QuU3RyKToN
Cj4gPiArICAgICAgICAgICAgaWYgKHZhcm5hbWUgOj0gYmIudXRpbHMuYXN0X25vZGVfc3RyX3Zh
bHVlKG5vZGUuYXJnc1swXSkpIGlzIG5vdA0KPiBOb25lOg0KPiA+ICsgICAgICAgICAgICAgICAg
aWYgbmFtZSBpbiBzZWxmLmNvbnRhaW5zZnVuY3MgYW5kDQo+IGJiLnV0aWxzLmFzdF9ub2RlX3N0
cl92YWx1ZShub2RlLmFyZ3NbMV0pIGlzIG5vdCBOb25lOg0KPiANCj4gUGVyc29uYWxseSwgSSBy
ZWFsbHkgZG9uJ3QgbGlrZSBjb25kaXRpb24gdGVzdHMgbW9kaWZ5aW5nIHZhcmlhYmxlcyBhcyBp
dCBjYW4gYmUNCj4gZWFzeSB0byBtaXNzIHdoZW4gcmVhZGluZyB0aGUgY29kZS4gSSB0aGVyZWZv
cmUgaGF2ZSBhIGJpdCBvZiBhIHByZWZlcmVuY2UgZm9yDQo+IG5vdCBkb2luZyB0aGF0Lg0KPiAN
Cj4gUGVyaGFwcyBpdCBqdXN0IHRha2VzIHRpbWUgdG8gZ2V0IHVzZWQgdG8gdGhlIG5ldyBzeW50
YXgsIHBlcmhhcHMgSSdtIGp1c3Qgb2xkDQo+IGZhc2hpb25lZC4NCg0KSSdtIGhhcHB5IHRvIHN1
Ym1pdCBhIHYzIHdpdGhvdXQgdGhlIHdhbHJ1cyBvcGVyYXRvciBpZiB5b3UgcHJlZmVyIDopLg0K
DQoNCj4gPiArDQo+ID4gK2RlZiBhc3Rfbm9kZV9zdHJfdmFsdWUobm9kZTogYXN0LkFTVCkgLT4g
T3B0aW9uYWxbc3RyXToNCj4gPiArICAgICIiIg0KPiA+ICsgICAgUmV0dXJucyBub2RlIHZhbHVl
IGlmIGl0IGlzIGFuIGBhc3QuQ29uc3RhbnRgIHN0cjsgTm9uZSBvdGhlcndpc2UNCj4gPiArICAg
ICIiIg0KPiA+ICsgICAgaWYgaXNpbnN0YW5jZShub2RlLCBhc3QuQ29uc3RhbnQpIGFuZCBpc2lu
c3RhbmNlKG5vZGUudmFsdWUsIHN0cik6DQo+ID4gKyAgICAgICAgcmV0dXJuIG5vZGUudmFsdWUN
Cj4gPiArICAgIHJldHVybiBOb25lDQo+IA0KPiBXZSB3ZXJlIHByZXZpb3VzbHkgYXNrZWQgYWJv
dXQgYWRkaW5nIHR5cGluZyBhbmQgYWdhaW4gSSdtIGEgbGl0dGxlIHVuc3VyZSB3ZQ0KPiB3YW50
IHRvIGRvIHRoYXQuIFBlcnNvbmFsbHksIEkgdGhpbmsgaXQgbG9va3MgaG9ycmlibHkgdWdseSBh
bmQgSSdtIG5vdCBjb252aW5jZWQgaXQNCj4gYnV5cyB1cyB0aGF0IG11Y2guIEkga25vdyBvdGhl
cnMgaGF2ZSBvdGhlciBvcGluaW9ucy4NCj4gDQo+IFdoaWxzdCBJIGFtIGluIHRoZW9yeSBiaXRi
YWtlJ3MgbWFpbnRhaW5lciBhbmQgaW4gdGhlb3J5IEkgY2FuIHNheSBubywgSSBrbm93IEknbGwN
Cj4gZ2V0IGFza2VkIHdoZW4gd2UncmUgY29udmVydGluZyBldmVyeXRoaW5nIHRpbWUgYW5kIHRp
bWUgYWdhaW4gc28gYWdhaW4gSSdtDQo+IHJlYWxseSB0b3JuIG9uIHRoaXMgOi8uDQoNCklNSE8g
Qml0QmFrZSBpcyBzbyBsYXJnZSBhbmQgY29tcGxpY2F0ZWQgdGhhdCBpdCB3b3VsZCBiZW5lZml0
IGZyb20gaXQuIEknbSBhIGJpdCBiaWFzZWQsIGJlaW5nIGEgaGVhdnkgdXNlciBvZiBzdGF0aWNh
bGx5LXR5cGVkIGxhbmd1YWdlcyBhbmQgYW4gSURFIChJbnRlbGxpSikgdGhhdCBtb2FucyBsb3Vk
bHkgYWJvdXQgcGVyY2VpdmVkIHR5cGUgbWlzbWF0Y2hlcy4gU28gYXMgd2l0aCB0aGUgd2FscnVz
LCBJIGNhbiByZXN1Ym1pdCBpZiB0aGUgYW5zd2VyIGlzICdubycgOikuDQoNCg0KVGhhbmtzLA0K
Q2hyaXMNCg==

