Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
 by mx.groups.io with SMTP id smtpd.web08.12112.1611334639547804037
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 22 Jan 2021 08:57:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@garmin.com header.s=pps1 header.b=eoeEtCl/;
 spf=permerror, err=parse error for token &{10 18 _spf4.garmin.com}: limit exceeded (domain: garmin.com, ip: 205.220.177.212, mailfrom: matt.hoosier@garmin.com)
Received: from pps.filterd (m0220297.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MGnx6a000587;
	Fri, 22 Jan 2021 10:57:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=pps1;
 bh=4SYuE1F+07/O7q28/hsUx/CK0BGHrPeYXH1sICj61FA=;
 b=eoeEtCl/jH2pPGEut/dpZEUOmh5L4NhjRsFXLqiLWB35b+W0OYLgOPn5yBOkPaZ84kOP
 ZGd/ZGP87VXRjGzwJmzFF4b/yuBSGOWKFLoZkkhUYsFvlIsbrkmFQYfMpYcJ3kONgR0z
 I53VFOUsM8o/PW8XYIIfWfq4rjt7NpmpIHg6eIooKmgIUvirmh4CHmRs3rVm6Mi6VROT
 sTQaMMf2PPkOoAZOAvLC65SRJSBkHk6jhxBgcVFieFhBCjZnuhSbOwP/V/aaSNUxx5Hs
 LkpF2unY/AKNakinxd7WxwqZNLaJCzSq90yltSnzbYgoiozzmqqpP84ykUGkeX5+RGUe dQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-000eb902.pphosted.com with ESMTP id 3668q4md1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Jan 2021 10:57:18 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d/lPe0Bw5zzBs6uYrj5LgEJSnfLqWksnKhRFd3J/kKjtUHzjxCRSyx9lXOeW7kIZNbMd213CgiuBIEs4FLN8GEMDt1PtRcntCAt6T1XmeafwrXCmGTCfR8B2ijF30c7d/n3r2hstEJLoA/gjFDQHJSgYvD+m2f7Lqk9BsYiyGm+DPjL6QBY5+8OvIhqJLmr/tUzXaQmTNhsYmOq5DD6h110oOjgqohlNGr5NA3XP6gWtL6T+QhtX13OlN8kufLJCHlIKWZ3xJ8hOfFVsGDoUBBVqCkau322fq+rKhiRECt6Od6ioFx4Q+XBOjjJ8QM2xEHI68B83O3+xNXqTFnhQcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SYuE1F+07/O7q28/hsUx/CK0BGHrPeYXH1sICj61FA=;
 b=E4HCTPAc+UXFNVO5tWfRuiujHRAYHh+75aePKA9c0om8/qcZpE787e0aQZixrfO+h7H/BegsBD/OgBGvmHoL3aDYMu50oMZ6wBy343zd1N116XaH36N/1/JQ+7gU3mcRpqFLCuuogTN58kfzSHyYOIZcYFttsWyKMeGBMCWmoQopc64lparWjiJfU8ClTPzEjNA/gIJPgBYhdancGvaSPWvy9bnax9HkWwfKd4OY+DaPzGyeD3/9thKudhVGshHfIihAQFT6ScypyvpDMf6+gtu2dnN7PiOD9TE8nUndA/OruSuE7JKzrSlvcT0lQGdVnhVVyV54/AVobuXh1WcicQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=garmin.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=garmin.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=garmin.onmicrosoft.com; s=selector1-garmin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SYuE1F+07/O7q28/hsUx/CK0BGHrPeYXH1sICj61FA=;
 b=TmHcczFEuee/0lskMsi5qOZ/BJYJki64afspMxyuaezFgtTRMfa5zqCJE8+CoU+5hZ0/qH3CT1d/OSBcnDQyBeOHPDNUH3NEmW/AZBcWwjorsWKZ10zFBH+qLGyVKTfKh+zNNNSyPmMT4ecPUnTyR/HN/1llQU5+E+6Mr7m56zlApJjSgvIQBdUe/vORNX96z52nSr3qgjqZ4mnEk7l10BQasnSiM2G+Huyv897eeQqfHP5QjyEgqRyLTKzC7Ji7QWayO9qfCXbSVHvwuCw7SnFTdX7bt1EF8GA9eC8GgGc+xfFwf1aiqfTiTs24dBd+Sa8Zk/l3jysBzLosKWtpLw==
Received: from BN6PR03CA0097.namprd03.prod.outlook.com (2603:10b6:404:10::11)
 by BN6PR04MB3747.namprd04.prod.outlook.com (2603:10b6:404:d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Fri, 22 Jan
 2021 16:57:17 +0000
Received: from BN7NAM10FT046.eop-nam10.prod.protection.outlook.com
 (2603:10b6:404:10:cafe::96) by BN6PR03CA0097.outlook.office365.com
 (2603:10b6:404:10::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend
 Transport; Fri, 22 Jan 2021 16:57:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=pass action=none
 header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com;
Received: from edgetransport.garmin.com (204.77.163.244) by
 BN7NAM10FT046.mail.protection.outlook.com (10.13.156.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Fri, 22 Jan 2021 16:57:16 +0000
Received: from OLAWPA-EXMB3.ad.garmin.com (10.5.144.15) by
 olawpa-edge1.garmin.com (10.60.4.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Fri, 22 Jan 2021 10:56:22 -0600
Received: from OLAWPA-EXMB8.ad.garmin.com (10.5.144.18) by
 OLAWPA-EXMB3.ad.garmin.com (10.5.144.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 22 Jan 2021 10:57:13 -0600
Received: from OLAWPA-EXMB8.ad.garmin.com ([fe80::acc8:480a:b46f:6ce3]) by
 OLAWPA-EXMB8.ad.garmin.com ([fe80::acc8:480a:b46f:6ce3%23]) with mapi id
 15.01.2106.006; Fri, 22 Jan 2021 10:57:13 -0600
From: "Matt Hoosier" <matt.hoosier@garmin.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
        "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] fetch/git: download LFS content too during do_fetch
Thread-Topic: [bitbake-devel] [PATCH] fetch/git: download LFS content too
 during do_fetch
Thread-Index: AQHW7qYCwI+1UorB3kaIhuyqslJGbKoz5ciAgABgwAA=
Date: Fri, 22 Jan 2021 16:57:13 +0000
Message-ID: <019a6c2d41416151db2fa101eb54b419d92e745e.camel@garmin.com>
References: <20210119205934.24174-1-matt.hoosier@garmin.com>
	 <da743b4ce7426b6e44641c83ccc689babf82091f.camel@linuxfoundation.org>
In-Reply-To: <da743b4ce7426b6e44641c83ccc689babf82091f.camel@linuxfoundation.org>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
x-originating-ip: [10.50.4.7]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c24e2734-13a8-493d-1996-08d8bef6c62b
X-MS-TrafficTypeDiagnostic: BN6PR04MB3747:
X-Microsoft-Antispam-PRVS: 
	<BN6PR04MB3747F350C3FFC7BA651D4093ECA09@BN6PR04MB3747.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	zoHtVj7ngOF6DyTmyhnwnX5gFIF59u36UNC3zWrf9L51zrc4um0YalYj7OXvzUms+FRCj+nFqY9luu7lh/ZPMchDiIzXvo3XCPft5oQNuL20hk69wWaQYq6fH1oUC+/FoaSMRMV1VkE70GR5MJBXzZbB6+/Lti5uUO9dxKhosBpctBRAgKSMJFXvlppbrqKHSI+gobtTBdkucWSsoVj9nMMsivXkgaLMgnSZWAXCyAWIfClkTmDd8aG4TWNvLZZMxdQn6BalE+kO5lMlwL3pZdNIvK5fM5HEcqIBihh9fpabFoecjEPHKiYR1REEPIFZR9ziI7ydAWM8SAni/dAhpjsdneg9St/6gJ6wQTAgMagAHWs9HFbwCJuSDkGpPMWgWdmE6nT4FyUtNPVDgEj6pg1YoTToOA23EqJ5xxPN9QKnzUVvLPAmk1PUDChx0KyYYB/9QUSUDyrdDLOSClvKOiK+unfikG7ZDedQ0cn8wEnYJQRycIgrlluRx/r1C6D6zPbyTAkITHgSrgzTBhdRg/jbgVS/F58EdB4uyOVfH5GVdDaPQp0OMKFQJ00YIgVoCaE5xXWbGBiUmorjFcb4CKnVscg0NJg77fUUWXboHpI=
X-Forefront-Antispam-Report: 
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(396003)(136003)(346002)(39860400002)(376002)(46966006)(70586007)(5660300002)(7636003)(34070700002)(83380400001)(70206006)(966005)(47076005)(356005)(26005)(426003)(336012)(7696005)(186003)(316002)(2616005)(36756003)(8676002)(82740400003)(2906002)(110136005)(478600001)(86362001)(8936002)(82310400003)(99106002);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2021 16:57:16.7581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c24e2734-13a8-493d-1996-08d8bef6c62b
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	BN7NAM10FT046.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB3747
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-22_13:2021-01-22,2021-01-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220090
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <A62308D5AC9ACB42A08B080E0984DEA2@garmin.com>
Content-Transfer-Encoding: base64

T24gRnJpLCAyMDIxLTAxLTIyIGF0IDExOjEwICswMDAwLCBSaWNoYXJkIFB1cmRpZSB3cm90ZToN
Cj4gQ0FVVElPTiAtIEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgYW55IGxpbmtzIG9yIG9w
ZW4gYW55IGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgdHJ1c3QgdGhlIHNlbmRlciBhbmQga25vdyB0
aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4gDQo+IE9uIFR1ZSwgMjAyMS0wMS0xOSBhdCAxNDo1
OSAtMDYwMCwgTWF0dCBIb29zaWVyIHZpYQ0KPiBsaXN0cy5vcGVuZW1iZWRkZWQub3JnIHdyb3Rl
Og0KPiANCj4gSW5zZXJ0IGFuIGV4cGxpY2l0IGNhbGwtb3V0IHRvIGdpdC1sZnMgdG8gZmV0Y2gg
YWxsIGJsb2JzIG5lZWRlZCBieQ0KPiBlYWNoIHJlZiBuYW1lZCBpbiBTUkNfVVJJLCBkdXJpbmcg
dGhlIGZldGNoKCkgZnVuY3Rpb24uIFRoaXMgYXZvaWRzDQo+IHRoZSBkZWZhdWx0IGJlaGF2aW9y
IG9mIEdpdCBMRlMgdG8gd2FpdCB1bnRpbCAnZ2l0IGNoZWNrb3V0JyB0bw0KPiBiZWdpbiBkb3du
bG9hZGluZyB0aGUgYmxvYnMgcG9pbnRlZCB0byBieSBMRlMgcmVjb3Jkcy4gTmV0d29yaw0KPiBh
Y2Nlc3MgaXMgbm90IGFsbG93ZWQgYXQgdGhhdCBwb2ludCBpbiB0aGUgcmVjaXBlJ3MgbGlmZWN5
Y2xlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF0dCBIb29zaWVyIDxtYXR0Lmhvb3NpZXJAZ2Fy
bWluLmNvbT4NCj4gLS0tDQo+ICBiaXRiYWtlL2xpYi9iYi9mZXRjaDIvZ2l0LnB5IHwgMTkgKysr
KysrKysrKysrKysrKy0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+IA0KPiBUaGlzIGRpZCBjYXVzZSBzb21lIGZhbGxvdXQgb24gdGhlIGF1
dG9tYXRlZCB0ZXN0aW5nIGluZnJhc3RydWN0dXJlOg0KPiANCj4gaHR0cHM6Ly91cmxkZWZlbnNl
LmNvbS92My9fX2h0dHBzOi8vYXV0b2J1aWxkZXIueW9jdG9wcm9qZWN0Lm9yZy90eXBob29uLyov
YnVpbGRlcnMvMjMvYnVpbGRzLzMxOTJfXztJdyEhRUpjNFlDM2lGbVEhRjVWSTIyN3hhaHBEOVc4
cXZGQVFOa3EtV0ZDdFNqN1pKb0ZlRDA3OWFtOHdUWGNhWU9PbEV4ODFKRXRPYnozeW9BJA0KPiAN
Cj4gKHRoZSB2dWxrYW4tc2FtcGxlcyByZWNpcGUgc2VlbXMgdG8gZmluZCBsZnMgY29udGVudHMg
c29tZXdoZXJlIHdlDQo+IGRpZG4ndCBrbm93IGFib3V0KQ0KDQpJIGhhZCBhIGxvb2ssIGFuZCB0
aGlzIG9uZSBlbmRlZCB1cCBiZWluZyBjYXVzZWQgYnkgc29tZSByZWxpYW5jZSBJDQptYWRlIG9u
IGEgZmVhdHVyZSBvZiBHaXQgTEZTIHRvIG9wZXJhdGUgd2l0aG91dCBhIHdvcmtpbmcgY29weS4g
VGhhdA0KdHVybnMgb3V0IG5vdCB0byBiZSBzdXBwb3J0ZWQgYWNyb3NzIGFsbCByZWxlYXNlcyBv
ZiBHaXQgTEZTLCBzbyBJDQpyZXRvb2xlZCB0aGUgbWVjaGFuaXNtIHRvIG1ha2UgYSB0ZW1wb3Jh
cnkgY2hlY2tvdXQsIGZldGNoIHdoYXQncw0KbmVlZGVkLCBhbmQgdGhlbiBtYW51YWxseSBtZXJn
ZSB0aGUgZmV0Y2hlZCBibG9icyBiYWNrIGludG8gdGhlIG1haW4NCihiYXJlKSBjbG9uZWRpci4N
Cg0KPiANCj4gYml0YmFrZS1zZWxmdGVzdCBmYWlsaW5nOg0KPiANCj4gaHR0cHM6Ly91cmxkZWZl
bnNlLmNvbS92My9fX2h0dHBzOi8vYXV0b2J1aWxkZXIueW9jdG9wcm9qZWN0Lm9yZy90eXBob29u
LyovYnVpbGRlcnMvNzkvYnVpbGRzLzE3NDVfXztJdyEhRUpjNFlDM2lGbVEhRjVWSTIyN3hhaHBE
OVc4cXZGQVFOa3EtV0ZDdFNqN1pKb0ZlRDA3OWFtOHdUWGNhWU9PbEV4ODFKRXM2QXZFSUZ3JA0K
PiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9hdXRvYnVpbGRlci55b2N0b3By
b2plY3Qub3JnL3R5cGhvb24vKi9idWlsZGVycy83OS9idWlsZHMvMTc0NV9fO0l3ISFFSmM0WUMz
aUZtUSFGNVZJMjI3eGFocEQ5VzhxdkZBUU5rcS1XRkN0U2o3WkpvRmVEMDc5YW04d1RYY2FZT09s
RXg4MUpFczZBdkVJRnckDQo+IA0KPiBzaW5jZSB3ZSBkb24ndCB1c2UvaW5zdGFsbCBnaXQtbGZz
IG9uIHRoZSBpbmZyYXN0cnVjdHVyZS4NCj4gDQo+IFdlIHNob3VsZCBwZXJoYXBzIHNraXAgdGhl
IHRlc3QgaWYgZ2l0LWxmcyBpc24ndCBpbnN0YWxsZWQ/DQoNClllcywgSSBhZ3JlZS4gSSd2ZSBy
ZXRvb2xlZCB0aGUgc2VsZi10ZXN0IGNhc2UgdG8gYXZvaWQgZXhlcmNpc2luZyB0aGUNCiJTUkNf
VVJJPS4uLi47bGZzPTEiIGNhc2UgaWYgdGhlIGhlbHBlciBiaW5hcnkgaXNuJ3QgaW5zdGFsbGVk
Lg0KDQpJJ3ZlIHVwZGF0ZWQgdGhlIHBhdGNoIHdpdGggYWxsIG9mIHRoaXMsIGF2YWlsYWJsZSBu
b3cgYXQgDQpodHRwczovL2xpc3RzLm9wZW5lbWJlZGRlZC5vcmcvZy9iaXRiYWtlLWRldmVsL21l
c3NhZ2UvMTE5MTguDQoNCi1NYXR0DQo=
