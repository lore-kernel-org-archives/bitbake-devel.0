Return-Path: <chris.laplante@agilent.com>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
	(mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
	by mail.openembedded.org (Postfix) with ESMTP id 2F72F7FA2E;
	Wed, 11 Dec 2019 15:16:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=WnJNq/EKkLi+N+1fZVISs6F6rGuYSYfavUuOMT+rmlMRJJGEt6Zzqs4JJOLYuXMwj6Zp/Z9/94himy1l4rkzEvWQvoxoZCvvct4Bu69HNmjUZK00KpHg0bQA9HDG+bflJ+Yp8j/CmG608/8eV42xErU1sBCM/1emikksLsDDX9r64bwrPy7xCIHBcIReE6jHpAxZHKwHATbqqxpH/yViQ2mPE8xeNslHeYZrF7cJ92eJVwRgFqbRXr1FwlMpnmyJnHpErYsy0G1FvKcuKaSf1KrGy6MM/WHEdtSUz1cUk2+1rzf82agLTmTEY8uIo0FZmcGPvq2Oep51Jp74NFcYHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=PTMfvSpbJJY7K7VNxs4XSFoQZJ1emUB1Lzc/qYdLEw8=;
	b=Y33iQi5214SGFaV2T0jxdXdpuHqEESOu2XLc6sfUDFu4VfDlvZqOg3a5PbxUzAXP3EJE0F05M2GO2w/M6N2JNgRCffq35s9yBEsnYTR69+QKhxdI5hO+UuM4fe1NHGIxim9aM3WKjN1loFtfNHtGyIiPb4qkw3SC0T9aMFF9eULGlhZcqeNO8cK8Ca5xQmW944gmgZcxuRszga7u37pdUu7PLft/NY8Cm4YYWw6DMwDef3yvR5aSsyPvtchdhSg3JKw4VuOk3at1NBMt3qC3BUobklVlXNp97qb4i9M+cgdhpvnR5JRzxDlqKHxDO9RlbfEyZPsvQWJ/DB+9IpWkgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=agilent.com;
	dmarc=pass action=none header.from=agilent.com; 
	dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=PTMfvSpbJJY7K7VNxs4XSFoQZJ1emUB1Lzc/qYdLEw8=;
	b=RTZZD3Nn9rDw1YTSpvQIaRLkvjtQGCBOMX30aUsehQ48uzAYB2JGiN5ApVUcp/ZAQpjBVJ6uMWUb5rDZgVUzk57xKssXRV55o5G9daAlMGoLVjQsoDL7+KYD/FiQJCJLl+fbOLFk9o51MxDPAo3A9sDYTrwk0fXZK2FF1emMxTs=
Received: from CY4PR12MB1653.namprd12.prod.outlook.com (10.172.71.137) by
	CY4PR12MB1590.namprd12.prod.outlook.com (10.172.69.8) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2516.17; Wed, 11 Dec 2019 15:16:35 +0000
Received: from CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::8048:9c4a:16a1:f584]) by
	CY4PR12MB1653.namprd12.prod.outlook.com
	([fe80::8048:9c4a:16a1:f584%4]) with mapi id 15.20.2516.018;
	Wed, 11 Dec 2019 15:16:35 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: Joshua Watt <jpewhacker@gmail.com>
Thread-Topic: [bitbake-devel] hashequiv, pseudo, and GIDs
Thread-Index: AdWvxXGeOYsqYFTMSCmAlM1iHqCZyQAEnsAAABdChhA=
Date: Wed, 11 Dec 2019 15:16:35 +0000
Message-ID: <CY4PR12MB16536C79902AB2538F4206508B5A0@CY4PR12MB1653.namprd12.prod.outlook.com>
References: <CY4PR12MB16537AC33CB9D19F94A126458B5A0@CY4PR12MB1653.namprd12.prod.outlook.com>
	<CAJdd5GZ0LTrTtU=gYMp0ZqTwQA9UQyU7WMx6mNG2scv--7wNVw@mail.gmail.com>
In-Reply-To: <CAJdd5GZ0LTrTtU=gYMp0ZqTwQA9UQyU7WMx6mNG2scv--7wNVw@mail.gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=chris.laplante@agilent.com; 
x-originating-ip: [4.16.127.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9cb0fb8-c793-4fd0-79e4-08d77e4d1c95
x-ms-traffictypediagnostic: CY4PR12MB1590:
x-microsoft-antispam-prvs: <CY4PR12MB15902BA15B9FD3CFFB93519C8B5A0@CY4PR12MB1590.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(39860400002)(366004)(136003)(396003)(346002)(376002)(29502001)(199004)(189003)(5660300002)(55016002)(81166006)(81156014)(2906002)(26005)(6506007)(9686003)(4326008)(76116006)(52536014)(66556008)(71200400001)(66946007)(316002)(8676002)(66476007)(7696005)(64756008)(66446008)(54906003)(6916009)(33656002)(186003)(86362001)(478600001)(8936002)(966005);
	DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1590;
	H:CY4PR12MB1653.namprd12.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: agilent.com does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P6qkss8XJEy2aNl4R1XqHYxFvxcV5eU+0kmc2Lx+hoIQSCKZNRVs7rsfrQBJ8VzIWLxMdXJ/kWeSSKx15ZI+muJEClSr1gK/im0mQNUcGdPKUTSuBrliIjok+w2DQb7pO6ZJ+UqX87vnrDlqEtNZz/lxYO9JxXCF+lUpv8bH8wRl70QeMB11zjXECvAbLxf6TR/wgtkiHCh2uenn3enOSYYGOzHOZ4Ap3yPvEhkfuujpmbU2gBgUlvA7/WZygfx39Qkd2TJuQhkTA9K3x3YRd//mecd2mUgvifuAvHd4NycrDqS1wHE2nbGTRAqIe614vCMq1zNzG9fxE29PjTLXqUyKDhkLdCSTWQUEAkxo9bzWqKsRXH5DJ2ZwzZ4IZW2lVd1dYhi0YeGwC/r5mgU+0Ivq/yD0EHn86QGAObc0PntET/CQyN7fUyjDYAnV0P/w4gTD8ZRQRD5Smo+YUH9WqCo7k8Z1cxCZPY/QjHwlBiH+D+pgJwmRl/evjEhuvMpv2ETpVyNtaMW2Fhn2RQunb2ZpR/DnU9MLX0Mmm8Ycmmw=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cb0fb8-c793-4fd0-79e4-08d77e4d1c95
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 15:16:35.1515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P2OUsQpkWt6J75j4UFm3w2hC8W1Z1tEIcXNB84tu0VoouV66MedYbOFb39VhCBkjFzlupgOjh8BecXVnNhl0bgT2u71VbFiXQY0lO1+E+W8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1590
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	"Openembedded-core@lists.openembedded.org"
	<Openembedded-core@lists.openembedded.org>
Subject: Re: hashequiv, pseudo, and GIDs
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 11 Dec 2019 15:16:35 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

PiA+IFNvIHdoeSBpcyB0aGUgZ3JvdXAgbmFtZSB1c2VkIGluIHRoZSBoYXNoLCBhcyBvcHBvc2Vk
IHRvIHRoZSBHSUQ/IChJIGFsc28gaGF2ZSB0aGUgc2FtZSBxdWVzdGlvbiByZWdhcmRpbmcgdXNl
ciBuYW1lIHZzIFVJRCkuIElmDQo+IHRoZSBHSUQgd2FzIHVzZWQgd2Ugd291bGRuJ3QgaGF2ZSB0
aGlzIGlzc3VlLg0KPiANCj4gVGhhdCB3YXMgZG9uZSBpbiByZXNwb25zZSB0byB0aGlzIG1haWxp
bmcgbGlzdCB0aHJlYWQ6DQo+IGh0dHA6Ly9saXN0cy5vcGVuZW1iZWRkZWQub3JnL3BpcGVybWFp
bC9vcGVuZW1iZWRkZWQtY29yZS8yMDE5LUphbnVhcnkvMjc3NzU1Lmh0bWwNCj4gDQo+IEJhc2lj
YWxseSwgdGhlIEdJRCBhbmQgVUlEIGFyZW4ndCBzdGFibGUgdmFsdWVzIGFjcm9zcyBidWlsZHMg
c28gdGhlDQo+IHN1Z2dlc3Rpb24gd2FzIHRvIHVzZSB0aGUgbmFtZXMuIE15IHVuZGVyc3RhbmRp
bmcgd2FzIHRoYXQgdGhpcw0KPiBjb3JyZXNwb25kZWQgdG8gaG93IHRoZSB1c2VyIGFuZCBncm91
cHMgYXJlIGRlYWx0IHdpdGggaW4gZ2VuZXJhbC4NCg0KVGhhdCBkb2Vzbid0IG1ha2Ugc2Vuc2Ug
KGludHVpdGl2ZWx5KSB0byBtZS4gSWYgSSBoYXZlIGEgZmlsZSB3aXRoIG93bmVyIEdJRCAxMDAw
LCBhbmQgY29weSBpdCB0byBzb21lIHN5c3RlbSwgdGhlbiB0aGUgZ3JvdXAgbmFtZSBpcyBkZWZp
bmVkIGJ5IHdoYXRldmVyIGdyb3VwcyBoYXBwZW4gdG8gZXhpc3Qgb24gdGhlIHN5c3RlbS4gSWYg
SSBjb3B5IGl0IHRvIGEgZGlmZmVyZW50IHN5c3RlbSwgdGhlIG93bmVyIGdyb3VwIG5hbWUgbWln
aHQgYmUgZGlmZmVyZW50LCBkZXBlbmRpbmcgb24gL2V0Yy9ncm91cC4gSW4gYm90aCBjYXNlcywg
aXQgaXMgdGhlIEdJRCBvZiAxMDAwIHRoYXQgaXMgc3RhYmxlLiANCg0KRnJvbSBhIGNhY2hpbmcg
cG9pbnQgb2YgdmlldywgaXQgc2VlbXMgaW5jb3JyZWN0IHRvIGNhcmUgYWJvdXQgd2hhdCB0aGUg
Y29ycmVzcG9uZGluZyBncm91cCBuYW1lIGhhcHBlbmVkIHRvIGJlIGF0IHRoZSB0aW1lIHdoZW4g
dGhlIGNhY2hlIHdhcyBjcmVhdGVkLiANCg0KQ2hyaXMgDQo=

