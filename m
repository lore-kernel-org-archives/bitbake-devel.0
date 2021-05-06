Received: from mx0b-000eb902.pphosted.com (mx0b-000eb902.pphosted.com [205.220.177.212])
 by mx.groups.io with SMTP id smtpd.web11.239.1620311892987518473
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 May 2021 07:38:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@garmin.com header.s=pps1 header.b=ckxrZnwi;
 spf=permerror, err=parse error for token &{10 18 _spf4.garmin.com}: limit exceeded (domain: garmin.com, ip: 205.220.177.212, mailfrom: matt.hoosier@garmin.com)
Received: from pps.filterd (m0220299.ppops.net [127.0.0.1])
	by mx0a-000eb902.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 146EPQue030568
	for <bitbake-devel@lists.openembedded.org>; Thu, 6 May 2021 09:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garmin.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=pps1;
 bh=CZa7Y2FRW1IBU1GUlUIw7bm//50p9J/AIHepgLvcZiA=;
 b=ckxrZnwiMJXJ5LPgsrYxpfv5RpuXHO0qn4lIxJkfAfzF2ye24WsW7KIbXly4+TlLj4yO
 T9LRbLA00t3Il5zSY1Twe22/S7f8hzdSgiYaPYl+OxuBxmx5L1KLtcz72tfXV9Ni7sPk
 aI+/ZdcZhTm8wiaoe0nC8VDTnJl7rNKh13c1seBqNTSHWQdN/HxmM5Sciz2fA2cOvHGF
 mA8JgGtl0AcUdYVdUdn9I6mJDR1UHVrzVq7Fz52/BWe1Sk5Xo7E4ifeAWdJBAjm3phtR
 eEMu+ytPFVVMH0UjZtyVyXC+nWQSHO1rH99JR+cwrEkurNLnTHmBas5Y+t4esfin9PmE Ow== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by mx0a-000eb902.pphosted.com with ESMTP id 38bjjejx51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 06 May 2021 09:38:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eq74HNGCt2xpZ+XW6yBYAkz05IOQQjlG/z/noDFOBAeo66IjyM5bmF+yFz1a6UwUwiBY6ALM94+G27KWzioJSoiuuMH7Wf3MSIQjyT2SUixBvFgKZAkVcEpnio57SlMY5X4IIdi5DlSXnVscY77+A/o1/Lys2jHuPMONnPB1q5BIRcqIOLFG3A7yfViXAiKjGJmsFUDnK+83aVkKLUMTYV2yhzg+31JNRDZlLnjzLutCsfEZpXt2iUEvIJR9IQbWOyKEHU0UYJREs7i88Vr6LnKVdznyVeJ3tcm7OhSvlutELqnzb6tGJlJBumJ0DD07LcC9Q6jxEdIEYsWGcHQcYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZa7Y2FRW1IBU1GUlUIw7bm//50p9J/AIHepgLvcZiA=;
 b=nhlooJYGlpOpZQ0V6sC7xERKEv77q4gBZnPM1tjHF0EA84OG8xqnI4FGgz6jfOX1mvVGq9b8vD+ASu6JGwEahQbabnxCRMXjRRYomMn5mIoPwtaKeZhwXEsEe4PRJbPRpH/OTEOEEDDBXaCHvRplAcX25xUo6mSvYcNro7kd5ISn5N5auL4jBaE0HESil7eh6MnCLAskyfofXWYrorsG2fzAZr6r+HrEJn2gWlZGRa/CDbjwrrycsUw9hLuQDwuuG2q4ZtqtJPBZJUcounqCTGFS2EhfuBi3kmVhLHOgXM6P0G/Fvf8AqC+fJsHdv4AA4IBKEsmR4dXAitX6LL5sNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 204.77.163.244) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=garmin.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=garmin.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=garmin.onmicrosoft.com; s=selector1-garmin-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZa7Y2FRW1IBU1GUlUIw7bm//50p9J/AIHepgLvcZiA=;
 b=o+u0B5t1uZV+K59rL99O0x2h2bZFta2+p7tVj5o6iVnZih+VeJdxuBDDM9mXs740BWJEkOzpOLjGj/pfGzWoA3k2IcGEZ6Ad9r+4UA2NxzZet42ZOExwxgjlsTChCadkzmt26Ufx7jQ/qRaNhM4rsHbP8+uunPrX/oOGijMZ1/vKYJa2XW239GbC8fg+Bf+i8qkrmDtjNenetbgOVRIsbekQsvHJ+b1k0/7LNAE1xQSUoKlm5g4ayUGpFBWpg2tL7YwP8AP9eJIfGS2osDQ8oRvck3IMBqKRcVs1obdAY6nVq6bIV8PXHGD4p2qtGvip3Wo55sXk0Ezc38pzBgiXzA==
Received: from DM5PR2001CA0005.namprd20.prod.outlook.com (2603:10b6:4:16::15)
 by MW4PR04MB7219.namprd04.prod.outlook.com (2603:10b6:303:7f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 14:38:09 +0000
Received: from DM6NAM10FT031.eop-nam10.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::b3) by DM5PR2001CA0005.outlook.office365.com
 (2603:10b6:4:16::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Thu, 6 May 2021 14:38:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 204.77.163.244)
 smtp.mailfrom=garmin.com; lists.openembedded.org; dkim=none (message not
 signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
 header.from=garmin.com;
Received-SPF: Pass (protection.outlook.com: domain of garmin.com designates
 204.77.163.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=204.77.163.244; helo=edgetransport.garmin.com;
Received: from edgetransport.garmin.com (204.77.163.244) by
 DM6NAM10FT031.mail.protection.outlook.com (10.13.152.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Thu, 6 May 2021 14:38:09 +0000
Received: from OLAWPA-EXMB4.ad.garmin.com (10.5.144.25) by
 olawpa-edge4.garmin.com (10.60.4.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2106.2; Thu, 6 May 2021 09:38:05 -0500
Received: from OLAWPA-EXMB8.ad.garmin.com (10.5.144.18) by
 OLAWPA-EXMB4.ad.garmin.com (10.5.144.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.4; Thu, 6 May 2021 09:38:08 -0500
Received: from OLAWPA-EXMB8.ad.garmin.com ([fe80::acc8:480a:b46f:6ce3]) by
 OLAWPA-EXMB8.ad.garmin.com ([fe80::acc8:480a:b46f:6ce3%23]) with mapi id
 15.01.2242.008; Thu, 6 May 2021 09:38:08 -0500
From: "Matt Hoosier" <matt.hoosier@garmin.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Options for allowing Git mirror tarballs to avoid stomping each other
Thread-Topic: Options for allowing Git mirror tarballs to avoid stomping each
 other
Thread-Index: AQHXQoVu/2jIXtGdhEq9B4nRUwo5tA==
Date: Thu, 6 May 2021 14:38:08 +0000
Message-ID: <36D6A83D-004A-4E91-9092-F50686966F0E@garmin.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.48.21041102
msip_labels: MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_Enabled=true;MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_SiteId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_SetDate=2021-05-06T14:20:59Z;MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_ContentBits=0;MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_ActionId=46ff6b13-0496-4c9f-9cef-5cb09862abc8;MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_Enabled=true;MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_Name=Confidential;MSIP_Label_f3ff6d80-3782-4df6-bf6c-659f84558040_Method=Standard;
x-originating-ip: [10.50.4.6]
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac607045-2e7d-4217-6aba-08d9109c917a
X-MS-TrafficTypeDiagnostic: MW4PR04MB7219:
X-Microsoft-Antispam-PRVS: 
	<MW4PR04MB7219FF566E120ACCE4F01F7CEC589@MW4PR04MB7219.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mggeuw1QCYniyWhfhZII6H1bJjaYH4BzT2zQ3nxW0s5TAcHjW6lC8YQKlo2oq10yTDB2Eu4pH7ExRiHf5Rk4+LCtZ5KZjKFMDnCEmtIGlXEw4bTs+1HGxaH2bZOfKs8WWYxdrXimihg/n9nllTUQv4YAyTpEnMWkFJII2rxBmsSgJWoX9FcQdMug01pRvgua5awyXhsNMWGOI33LjPyaYCyqaCHobWi1PylzAkirCFxfc/OEbyEcnY+Sn5hJIYuxQI0HQcXnwEqF+Mm2vcv/DOEx0LEVfyLT0MlW1shM9ixbgUo4P1Sza6RL9AFZ2Gqi4/JPcHyafhj9BACxmKEVYLtNJBNNcPkWuzZ6naIal5V/EtoSv8MsI3LtBCl4EhDG8evvLnSJZgvMxCYcf8Z7Ul5vZuz94XkpTWmsL0QH8Ts+cUSD5wWGInqCnoNo8/H+jcuA4h0i4b5qY0KwriXfPxI6jb1b1NVsuZFrazbSIgErsYvf9pS+dN94oZR/V4c9ZvzXzMJE0EBSlDeDoohryKwTNUofX/CqxbJ2RxJym2HYAS9Q4nuG/DWITrfWFOWFBSQ2xkZHohbz3qF9UN/TEDGl8cLhsny59CfhWCsKBFBa+zA1lrZZxQru3a4QJ325z34yiyaXWCXUUabrvDECgG9b7Xh0BGgfpAhDxuxAFcI=
X-Forefront-Antispam-Report: 
	CIP:204.77.163.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:edgetransport.garmin.com;PTR:extedge.garmin.com;CAT:NONE;SFS:(376002)(396003)(39850400004)(136003)(346002)(46966006)(36840700001)(426003)(6916009)(8676002)(33656002)(86362001)(36756003)(356005)(83380400001)(186003)(82310400003)(2616005)(36860700001)(7636003)(336012)(5660300002)(47076005)(82740400003)(2906002)(316002)(478600001)(8936002)(33964004)(70206006)(7696005)(70586007)(9326002)(26005);DIR:OUT;SFP:1102;
X-OriginatorOrg: garmin.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 14:38:09.0128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac607045-2e7d-4217-6aba-08d9109c917a
X-MS-Exchange-CrossTenant-Id: 38d0d425-ba52-4c0a-a03e-2a65c8e82e2d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38d0d425-ba52-4c0a-a03e-2a65c8e82e2d;Ip=[204.77.163.244];Helo=[edgetransport.garmin.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DM6NAM10FT031.eop-nam10.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7219
X-Proofpoint-ORIG-GUID: 4TN2RiVksh5mNkXR0sQhpcSBiMuuPxDK
X-Proofpoint-GUID: 4TN2RiVksh5mNkXR0sQhpcSBiMuuPxDK
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_10:2021-05-06,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060106
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_36D6A83D004A4E919092F50686966F0Egarmincom_"

--_000_36D6A83D004A4E919092F50686966F0Egarmincom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNClRoZSBHaXQgZmV0Y2hlciBnZW5lcmFsbHkgYXNzdW1lcyB0aGF0IHJlcG9zaXRvcmll
cyBpdCBmZXRjaGVzIGFyZSB3ZWxsLWJlaGF2ZWQsIGluIHRoZSBzZW5zZSB0aGF0IGNvbnRlbnQg
ZmV0Y2hhYmxlIGZyb20gYSBoZWFkIHRvZGF5IHdpbGwgY29udGludWUgdG8gYmUgcmVhY2hhYmxl
IG9uIHRoYXQgaGVhZCB0b21vcnJvdy4gVGhlcmUncyB0aGUgJ3JlYmFzZWFibGUnIFNSQ19VUkkg
cGFyYW1ldGVyIHRoYXQgY2FuIGJlIHVzZWQgdG8gb3ZlcnJpZGUgdGhhdCBhc3N1bXB0aW9uIG9u
IGEgcmVwb3NpdG9yeS1ieS1yZXBvc2l0b3J5IGJhc2lzIChpdCdzIHNldCB0byAwIGJ5IGRlZmF1
bHQpLg0KDQpJJ20gY29uY2VybmVkIHRoYXQgd2hlbiBtb3JlIHRoYW4gb25lIHByb2plY3Qgb2Yg
ZGlmZmVyZW50IHZpbnRhZ2VzIGFyZSBwdWJsaXNoaW5nIG1pcnJvciB0YXJiYWxscyBpbnRvLCBz
YXksIGEgY29tbW9uIEhUVFAtc2VydmVkIGRpcmVjdG9yeSwgdGhpcyBhc3N1bXB0aW9uIGlzIGdv
aW5nIHRvIGNhdXNlIHRyb3VibGUuDQoNClRoZSBtaXJyb3IgdGFyYmFsbHMgb2YgYSBHaXQgcmVw
b3NpdG9yeSBhcmUgbmFtZWQgYmFzZWQgb25seSBvbiB0aGUgVVJMIChub3QgdGhlIHJldmlzaW9u
KS4gU28sIGZvciBleGFtcGxlLCBnaXQ6Ly9zb3VyY2V3YXJlLm9yZy9naXQvZ2xpYmMuZ2l0O2Jy
YW5jaD1yZWxlYXNlLzIuMjQvbWFzdGVyO25hbWU9Z2xpYmMgbWFwcyB0byBhIG1pcnJvciB0YXJi
YWxsIG5hbWVkIGdpdDJfc291cmNld2FyZS5vcmcuZ2l0LmdsaWJjLmdpdC50YXIuZ3ouDQoNClN1
cHBvc2UgZm9yIHRoZSBzYWtlIG9mIGFyZ3VtZW50IHRoYXQgSSBoYXZlIHByb2R1Y3QgQSBvbiBh
IHZlcnNpb24gb2YgT0Ugd2hvc2UgZ2xpYmMgaXMgZmV0Y2hpbmcgcmVsZWFzZSAyLjI1IGFuZCBw
cm9kdWN0IEIgYnVpbHQgdXNpbmcgYSB2ZXJzaW9uIG9mIE9FIHdob3NlIGdsaWJjIHJlY2lwZSBp
cyBmZXRjaGluZyByZWxlYXNlIDIuMjQuDQoNClByb2R1Y3QgQSBnb2VzIHRocm91Z2ggaXRzIHJl
bGVhc2UgY3ljbGUsIHdoaWNoIGluY2x1ZGVzIGFuIGV4aGF1c3RpdmUgcGFzcyBvZiBmZXRjaGlu
ZyBhbmQgZ2VuZXJhdGluZyBtaXJyb3IgdGFyYmFsbHMuIFRoZXNlIGFyZSBjb3BpZWQgb3ZlciB0
byBhbiBpbnRlcm5hbCBwcmVtaXJyb3Igc2l0ZSBmb3Igc2FmZS1rZWVwaW5nIGluIGNhc2UgdXBz
dHJlYW0gR2l0IG9mIGdsaWJjIGRpc2FwcGVhcnMgb3IgaGFzIGFuIG91dGFnZS4gU28gdGhlIHBy
ZS1taXJyb3JlZCB0YXJiYWxsIGluY2x1ZGVzIHJldmlzaW9uIGhpc3RvcnkgZm9yIHN0dWZmIHVw
IHRocm91Z2ggMi4yNS4NCg0KTm93IFByb2R1Y3QgQiBkb2VzIGFsbCB0aGUgc2FtZSBzdGVwcy4g
VGhpcyB3aWxsIG1lYW4gdGhhdCBpdHMgbWlycm9yIHRhcmJhbGwgb2YgZ2xpYmMgZ2V0cyBzZW50
IHRvIHRoZSBwcmVtaXJyb3Igc2VydmVyLCBhbmQgbm93IHRoZSBwcmVtaXJyb3IgdGFyYmFsbCBp
bmNsdWRlcyByZXZpc2lvbiBoaXN0b3J5IG9ubHkgdXAgdGhyb3VnaCAyLjI0Lg0KDQpJZiBQcm9k
dWN0IEEgbmVlZHMgdG8gcmVjb25zdHJ1Y3QgaXRzIHNvdXJjZXMgdXNpbmcgdGhlIHByZW1pcnJv
ciBzaXRlLCB3ZSdyZSBpbiB0cm91YmxlLiBUaGUgaGlzdG9yeSBmb3IgMi4yNSBpc24ndCB0aGVy
ZSBhbnltb3JlIGluIHRoZSB0YXJiYWxsIGZpbGVuYW1lIHRoYXQgaXQgZXhwZWN0cy4NCg0KQWxs
IHRoaXMgaGFzIGhhcHBlbmVkIGV2ZW4gdGhvdWdoIGdsaWJjIGl0c2VsZiBpcyBhIHdlbGwtYmVo
YXZlZCByZXBvc2l0b3J5LiBObyBtYWludGFpbmVyIHRoZXJlIGhhcyByZW1vdmVkIGhpc3Rvcnkg
ZnJvbSBhIGJyYW5jaCBvciBhbnl0aGluZyBsaWtlIHRoYXQuIFRoZSBsb3NzIGlzIGp1c3QgYSBz
aWRlLWVmZmVjdCBvZiBsb2NhbCBvcGVyYXRpb25zIGRvbmUgd2l0aCB0d28gZGlmZmVyZW50IHJl
bGVhc2VzIG9mIFlvY3RvLWJhc2VkIHByb2R1Y3RzLg0KDQpTaG9ydCBvZiBkb2N0b3JpbmcgYWxs
IHRoZSByZWNpcGVzIHRvIHNldCAncmViYXNlYWJsZT0xJyBvciByZXNpZ25pbmcgbXlzZWxmIHRv
IGhhdmUgYSBjb21wbGV0ZWx5IHNlcGFyYXRlIHByZW1pcnJvciBkaXJlY3RvcnkgZm9yIGVhY2gg
cmVsZWFzZSBvZiBlYWNoIHByb2R1Y3QsIEkgY2FuJ3Qgc2VlIGFuIG9idmlvdXMgd2F5IHRvIGF2
b2lkIHRoZXNlIGhpc3RvcnktbG9zaW5nIGNvbGxpc2lvbnMuDQoNCldvdWxkIGl0IG1ha2Ugc2Vu
c2UgdG8gdW5jb25kaXRpb25hbGx5IGJ1aWxkIHRoZSByZXZpc2lvbiBudW1iZXIgaW50byB0aGUg
R2l0IG1pcnJvciB0YXJiYWxscyBzbyB0aGVyZSdzIG5vIHRlbnNpb24gYmV0d2VlbiBjb21wZXRp
bmcgY29waWVzIG9mIHByb2R1Y3RzJyBHaXQgbWlycm9yIHRhcmJhbGxzPw0KDQotTWF0dA0KDQo=

--_000_36D6A83D004A4E919092F50686966F0Egarmincom_
Content-Type: text/html; charset="utf-8"
Content-ID: <EA6746AFB2819943B56D104C6E17AF42@garmin.com>
Content-Transfer-Encoding: base64

PGh0bWwgeG1sbnM6dj0idXJuOnNjaGVtYXMtbWljcm9zb2Z0LWNvbTp2bWwiIHhtbG5zOm89InVy
bjpzY2hlbWFzLW1pY3Jvc29mdC1jb206b2ZmaWNlOm9mZmljZSIgeG1sbnM6dz0idXJuOnNjaGVt
YXMtbWljcm9zb2Z0LWNvbTpvZmZpY2U6d29yZCIgeG1sbnM6bT0iaHR0cDovL3NjaGVtYXMubWlj
cm9zb2Z0LmNvbS9vZmZpY2UvMjAwNC8xMi9vbW1sIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcv
VFIvUkVDLWh0bWw0MCI+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIg
Y29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjxtZXRhIG5hbWU9IkdlbmVyYXRv
ciIgY29udGVudD0iTWljcm9zb2Z0IFdvcmQgMTUgKGZpbHRlcmVkIG1lZGl1bSkiPg0KPHN0eWxl
PjwhLS0NCi8qIEZvbnQgRGVmaW5pdGlvbnMgKi8NCkBmb250LWZhY2UNCgl7Zm9udC1mYW1pbHk6
IkNhbWJyaWEgTWF0aCI7DQoJcGFub3NlLTE6MiA0IDUgMyA1IDQgNiAzIDIgNDt9DQpAZm9udC1m
YWNlDQoJe2ZvbnQtZmFtaWx5OkNhbGlicmk7DQoJcGFub3NlLTE6MiAxNSA1IDIgMiAyIDQgMyAy
IDQ7fQ0KLyogU3R5bGUgRGVmaW5pdGlvbnMgKi8NCnAuTXNvTm9ybWFsLCBsaS5Nc29Ob3JtYWws
IGRpdi5Nc29Ob3JtYWwNCgl7bWFyZ2luOjBpbjsNCglmb250LXNpemU6MTEuMHB0Ow0KCWZvbnQt
ZmFtaWx5OiJDYWxpYnJpIixzYW5zLXNlcmlmO30NCnNwYW4uRW1haWxTdHlsZTE3DQoJe21zby1z
dHlsZS10eXBlOnBlcnNvbmFsLWNvbXBvc2U7DQoJZm9udC1mYW1pbHk6IkNhbGlicmkiLHNhbnMt
c2VyaWY7DQoJY29sb3I6d2luZG93dGV4dDt9DQouTXNvQ2hwRGVmYXVsdA0KCXttc28tc3R5bGUt
dHlwZTpleHBvcnQtb25seTsNCglmb250LWZhbWlseToiQ2FsaWJyaSIsc2Fucy1zZXJpZjt9DQpA
cGFnZSBXb3JkU2VjdGlvbjENCgl7c2l6ZTo4LjVpbiAxMS4waW47DQoJbWFyZ2luOjEuMGluIDEu
MGluIDEuMGluIDEuMGluO30NCmRpdi5Xb3JkU2VjdGlvbjENCgl7cGFnZTpXb3JkU2VjdGlvbjE7
fQ0KLS0+PC9zdHlsZT4NCjwvaGVhZD4NCjxib2R5IGxhbmc9IkVOLVVTIiBsaW5rPSIjMDU2M0Mx
IiB2bGluaz0iIzk1NEY3MiIgc3R5bGU9IndvcmQtd3JhcDpicmVhay13b3JkIj4NCjxkaXYgY2xh
c3M9IldvcmRTZWN0aW9uMSI+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj5IaSw8bzpwPjwvbzpwPjwv
cD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+VGhlIEdpdCBmZXRjaGVyIGdlbmVyYWxseSBhc3N1bWVzIHRoYXQgcmVwb3Np
dG9yaWVzIGl0IGZldGNoZXMgYXJlIHdlbGwtYmVoYXZlZCwgaW4gdGhlIHNlbnNlIHRoYXQgY29u
dGVudCBmZXRjaGFibGUgZnJvbSBhIGhlYWQgdG9kYXkgd2lsbCBjb250aW51ZSB0byBiZSByZWFj
aGFibGUgb24gdGhhdCBoZWFkIHRvbW9ycm93LiBUaGVyZSdzIHRoZSAncmViYXNlYWJsZScgU1JD
X1VSSSBwYXJhbWV0ZXIgdGhhdA0KIGNhbiBiZSB1c2VkIHRvIG92ZXJyaWRlIHRoYXQgYXNzdW1w
dGlvbiBvbiBhIHJlcG9zaXRvcnktYnktcmVwb3NpdG9yeSBiYXNpcyAoaXQncyBzZXQgdG8gMCBi
eSBkZWZhdWx0KS48bzpwPjwvbzpwPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5i
c3A7PC9vOnA+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+SSdtIGNvbmNlcm5lZCB0aGF0IHdo
ZW4gbW9yZSB0aGFuIG9uZSBwcm9qZWN0IG9mIGRpZmZlcmVudCB2aW50YWdlcyBhcmUgcHVibGlz
aGluZyBtaXJyb3IgdGFyYmFsbHMgaW50bywgc2F5LCBhIGNvbW1vbiBIVFRQLXNlcnZlZCBkaXJl
Y3RvcnksIHRoaXMgYXNzdW1wdGlvbiBpcyBnb2luZyB0byBjYXVzZSB0cm91YmxlLjxvOnA+PC9v
OnA+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286cD48L3A+DQo8cCBj
bGFzcz0iTXNvTm9ybWFsIj5UaGUgbWlycm9yIHRhcmJhbGxzIG9mIGEgR2l0IHJlcG9zaXRvcnkg
YXJlIG5hbWVkIGJhc2VkIG9ubHkgb24gdGhlIFVSTCAobm90IHRoZSByZXZpc2lvbikuIFNvLCBm
b3IgZXhhbXBsZSwgZ2l0Oi8vc291cmNld2FyZS5vcmcvZ2l0L2dsaWJjLmdpdDticmFuY2g9cmVs
ZWFzZS8yLjI0L21hc3RlcjtuYW1lPWdsaWJjIG1hcHMgdG8gYSBtaXJyb3IgdGFyYmFsbCBuYW1l
ZCBnaXQyX3NvdXJjZXdhcmUub3JnLmdpdC5nbGliYy5naXQudGFyLmd6LjxvOnA+PC9vOnA+PC9w
Pg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286cD48L3A+DQo8cCBjbGFzcz0i
TXNvTm9ybWFsIj5TdXBwb3NlIGZvciB0aGUgc2FrZSBvZiBhcmd1bWVudCB0aGF0IEkgaGF2ZSBw
cm9kdWN0IEEgb24gYSB2ZXJzaW9uIG9mIE9FIHdob3NlIGdsaWJjIGlzIGZldGNoaW5nIHJlbGVh
c2UgMi4yNSBhbmQgcHJvZHVjdCBCIGJ1aWx0IHVzaW5nIGEgdmVyc2lvbiBvZiBPRSB3aG9zZSBn
bGliYyByZWNpcGUgaXMgZmV0Y2hpbmcgcmVsZWFzZSAyLjI0LjxvOnA+PC9vOnA+PC9wPg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9y
bWFsIj5Qcm9kdWN0IEEgZ29lcyB0aHJvdWdoIGl0cyByZWxlYXNlIGN5Y2xlLCB3aGljaCBpbmNs
dWRlcyBhbiBleGhhdXN0aXZlIHBhc3Mgb2YgZmV0Y2hpbmcgYW5kIGdlbmVyYXRpbmcgbWlycm9y
IHRhcmJhbGxzLiBUaGVzZSBhcmUgY29waWVkIG92ZXIgdG8gYW4gaW50ZXJuYWwgcHJlbWlycm9y
IHNpdGUgZm9yIHNhZmUta2VlcGluZyBpbiBjYXNlIHVwc3RyZWFtIEdpdCBvZiBnbGliYyBkaXNh
cHBlYXJzIG9yIGhhcw0KIGFuIG91dGFnZS4gU28gdGhlIHByZS1taXJyb3JlZCB0YXJiYWxsIGlu
Y2x1ZGVzIHJldmlzaW9uIGhpc3RvcnkgZm9yIHN0dWZmIHVwIHRocm91Z2ggMi4yNS48bzpwPjwv
bzpwPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0KPHAg
Y2xhc3M9Ik1zb05vcm1hbCI+Tm93IFByb2R1Y3QgQiBkb2VzIGFsbCB0aGUgc2FtZSBzdGVwcy4g
VGhpcyB3aWxsIG1lYW4gdGhhdCBpdHMgbWlycm9yIHRhcmJhbGwgb2YgZ2xpYmMgZ2V0cyBzZW50
IHRvIHRoZSBwcmVtaXJyb3Igc2VydmVyLCBhbmQgbm93IHRoZSBwcmVtaXJyb3IgdGFyYmFsbCBp
bmNsdWRlcyByZXZpc2lvbiBoaXN0b3J5IG9ubHkgdXAgdGhyb3VnaCAyLjI0LjxvOnA+PC9vOnA+
PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+PG86cD4mbmJzcDs8L286cD48L3A+DQo8cCBjbGFz
cz0iTXNvTm9ybWFsIj5JZiBQcm9kdWN0IEEgbmVlZHMgdG8gcmVjb25zdHJ1Y3QgaXRzIHNvdXJj
ZXMgdXNpbmcgdGhlIHByZW1pcnJvciBzaXRlLCB3ZSdyZSBpbiB0cm91YmxlLiBUaGUgaGlzdG9y
eSBmb3IgMi4yNSBpc24ndCB0aGVyZSBhbnltb3JlIGluIHRoZSB0YXJiYWxsIGZpbGVuYW1lIHRo
YXQgaXQgZXhwZWN0cy48bzpwPjwvbzpwPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+
Jm5ic3A7PC9vOnA+PC9wPg0KPHAgY2xhc3M9Ik1zb05vcm1hbCI+QWxsIHRoaXMgaGFzIGhhcHBl
bmVkIGV2ZW4gdGhvdWdoIGdsaWJjIGl0c2VsZiBpcyBhIHdlbGwtYmVoYXZlZCByZXBvc2l0b3J5
LiBObyBtYWludGFpbmVyIHRoZXJlIGhhcyByZW1vdmVkIGhpc3RvcnkgZnJvbSBhIGJyYW5jaCBv
ciBhbnl0aGluZyBsaWtlIHRoYXQuIFRoZSBsb3NzIGlzIGp1c3QgYSBzaWRlLWVmZmVjdCBvZiBs
b2NhbCBvcGVyYXRpb25zIGRvbmUgd2l0aCB0d28gZGlmZmVyZW50IHJlbGVhc2VzDQogb2YgWW9j
dG8tYmFzZWQgcHJvZHVjdHMuPG86cD48L286cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48
bzpwPiZuYnNwOzwvbzpwPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPlNob3J0IG9mIGRvY3Rv
cmluZyBhbGwgdGhlIHJlY2lwZXMgdG8gc2V0ICdyZWJhc2VhYmxlPTEnIG9yIHJlc2lnbmluZyBt
eXNlbGYgdG8gaGF2ZSBhIGNvbXBsZXRlbHkgc2VwYXJhdGUgcHJlbWlycm9yIGRpcmVjdG9yeSBm
b3IgZWFjaCByZWxlYXNlIG9mIGVhY2ggcHJvZHVjdCwgSSBjYW4ndCBzZWUgYW4gb2J2aW91cyB3
YXkgdG8gYXZvaWQgdGhlc2UgaGlzdG9yeS1sb3NpbmcgY29sbGlzaW9ucy48bzpwPjwvbzpwPjwv
cD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9vOnA+PC9wPg0KPHAgY2xhc3M9
Ik1zb05vcm1hbCI+V291bGQgaXQgbWFrZSBzZW5zZSB0byB1bmNvbmRpdGlvbmFsbHkgYnVpbGQg
dGhlIHJldmlzaW9uIG51bWJlciBpbnRvIHRoZSBHaXQgbWlycm9yIHRhcmJhbGxzIHNvIHRoZXJl
J3Mgbm8gdGVuc2lvbiBiZXR3ZWVuIGNvbXBldGluZyBjb3BpZXMgb2YgcHJvZHVjdHMnIEdpdCBt
aXJyb3IgdGFyYmFsbHM/PG86cD48L286cD48L3A+DQo8cCBjbGFzcz0iTXNvTm9ybWFsIj48bzpw
PiZuYnNwOzwvbzpwPjwvcD4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPi1NYXR0PG86cD48L286cD48
L3A+DQo8ZGl2Pg0KPGRpdj4NCjxwIGNsYXNzPSJNc29Ob3JtYWwiPjxvOnA+Jm5ic3A7PC9vOnA+
PC9wPg0KPC9kaXY+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9ib2R5Pg0KPC9odG1sPg0K

--_000_36D6A83D004A4E919092F50686966F0Egarmincom_--
