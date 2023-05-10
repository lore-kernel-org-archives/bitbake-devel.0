Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1134C7EE22
	for <webhook@archiver.kernel.org>; Wed, 10 May 2023 09:43:08 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.12248.1683711787181275690
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 May 2023 02:43:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=LBfNeMEz;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=4494f80ab0=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34A8MTUC029178
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 May 2023 02:43:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=IzeJMZZejM7qqpakErzAlGMHJR1d1hLczHDpeDFj8oI=;
 b=LBfNeMEzp031R2WLlAzysGZo3Lq9ejcWM5tVeu8f1dnfEgyElUF+p5xZrDzYQW7LuTMQ
 RKnsGGGePR5vNO4EwnddZvGtQG1IqHIlv4O7LeBvqFPAZGIt/p3T7OpWsADlwCLQzqQY
 0fabExP1+Nw8eqYJTXRR1ld3QgXDd+GKEYXW169DghM9LCoj4FCt4aU1h0pKh+u4jUDE
 g/QPu5d1BpyR4Y7+RsoPkSssYe/7zEgRWzZKXkd9ZQrhVIIjIzt2yItcf8nOYOHX6ohi
 r9v2I6+d1V5ZIunfUwAmXWHIAjT5+SkVw/HCdQarbKQc1HA+c0WBankfQMOFvjUTm4md Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qf7ucshph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 May 2023 02:43:06 -0700
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34A9h5DL021042
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 May 2023 02:43:06 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3qf7ucshpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 May 2023 02:43:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MATIf73Z4GDSPPRyauqQ8Rt5q4XE3h0iwnDT5doKD5oYtLGnXT1ULLhGWRGu+usu7w5rql98TfTamn1blrIZFUMVNPsFCcxwLAR0oSBaAKSmivmXXBzvFtF5URtQ49AvENhHTat49OEWMZ7nvUzN3N9lWqmNTgW0114Qxar95UNyy+3i+joK79nxSA/Zq27DUMUsALd/ISoABuD/DZPa3QFgmHsuoFiwWxpUsmZy3Jc2pYXxqb/MFhpYzqU+LuuuWFQ+UlokpdDun1gy3EzHKQvA4agy4qTg5/fEtYQdMVXmCWrC+977XBlJNm4hWZSD2X9Y+szfcCGvDjROPjm3jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzeJMZZejM7qqpakErzAlGMHJR1d1hLczHDpeDFj8oI=;
 b=D1eObKCO0/0Z6rpp65RxirxDYN8b+6ezCii+OZIWyvEsN1Bful/26rxNDK0kYKUNM+XI/VsUsvTUOsSn757SbjYPmUmm5HcZxaYplmXb6mExYsELe0xQGGStIY1633/P+5q07ROB0/g9FTSJbNgKhQOx+Sor9PnGnYxrzilUKWdEgMinV0M4IZXngcqF355gfepadTia1OcKcvj4ZpRgbKcZ6+1p3ZAFv2LhCcqcW4ZBZQkKEwVZstnFNU2xwOb83js/gyjiJynfMVakUixKaQ02IUNpGfP7+e+VSEzDrkm499wYs5KE/XSTWtybKke7X+NdI7MfNUGYFkuASh4WqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by MW4PR11MB6785.namprd11.prod.outlook.com (2603:10b6:303:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 09:43:02 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::fa8:8cc5:a5da:7e07]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::fa8:8cc5:a5da:7e07%5]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 09:43:02 +0000
From: "Chen, Qi" <Qi.Chen@windriver.com>
To: "richard.purdie@linuxfoundation.org" <richard.purdie@linuxfoundation.org>,
        "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel][PATCH] bitbake: add --noreply-timeout option
Thread-Topic: [bitbake-devel][PATCH] bitbake: add --noreply-timeout option
Thread-Index: AQHZgu3bSz9m6E31EE269Fy78ZjP3K9TIsMAgAAWdMA=
Date: Wed, 10 May 2023 09:43:02 +0000
Message-ID: 
 <CO6PR11MB56021F72AD89D4BC727C33CAED779@CO6PR11MB5602.namprd11.prod.outlook.com>
References: <20230510031631.1813338-1-Qi.Chen@windriver.com>
 <25b122740ed8d9d0c62068542da4fa99c53e2dd9.camel@linuxfoundation.org>
In-Reply-To: 
 <25b122740ed8d9d0c62068542da4fa99c53e2dd9.camel@linuxfoundation.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5602:EE_|MW4PR11MB6785:EE_
x-ms-office365-filtering-correlation-id: fa3e9c54-e291-4e1b-4e3b-08db513af2a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 W6B+K4Z6NuEdb6APPjN/ncGRj4pV6ylc9CHNb5p0bFk9SlqFVAYa8vxDRN0nZveFFS5Nk9tLxa+AISaLnu5jJAhUwB5H6/0pqp/F/0QtdvlRVAn0oqBSeoWjkT+zHJDq8tBzUouqJloK/Bv8iGDZlNmMfz7s47Sj2Rkwp45PKysTf9gQpZuVDKlM0Ezqa2U5t+gWs6EhJ3I1MoHgKY3cKW4mMZ3Vr3rexMTO62w60rAmthkNsLuK8gcdrN9nQCxEEMFVSMl8oum/F6Uor/mynI0XTWpygLzB/z0PXGgMeimH7EdXTq84DX5+hShWz9XYHLNBIQfhueuVh0Y5LS6yBNENrgElDQ2+BFmhlt2HIQvCR31L6k/gI7/IYiLxy2me4IMRw3zTpTHbcbjnewIK5iCgQ9+yERJeGLAEohbkXZO3VzFnS64UNt5dCIiPrdWQnWdcVrj8jvG41xi5qLaNaMzuDsfdOPKhP9MTqHoU148TTtKL4JN/umfqA1GZkyEtudENPCDqgbcGQ7cBXUUqO9yARCp2S2LRH0YDgRNM/KwPLJqhNRM/lG2X2k+N0zw54PSg/qZpm9kydwFiXi+7urqmvRnxy7XXamKbFnY9kF6kkaIKzGCdPqfva3yGmx7A
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(366004)(396003)(376002)(346002)(136003)(451199021)(86362001)(66446008)(33656002)(64756008)(316002)(76116006)(66556008)(7696005)(478600001)(66476007)(66946007)(110136005)(55016003)(5660300002)(8676002)(52536014)(8936002)(41300700001)(2906002)(71200400001)(186003)(38070700005)(122000001)(38100700002)(26005)(9686003)(6506007)(83380400001)(66574015)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?ais5TVZPR3VnOUZRL2FVWUtZZ1pVTzhoc2NCRHlKS1c2VXNobktvcXRMejNZ?=
 =?utf-8?B?ckZ5MGdjUEwycnlTU1NsaWZwTVJlNHlXaVlGMEdmT0duMFdYYVQ5cHZWbWMy?=
 =?utf-8?B?L1lQQmFlWlhCKzArTUJtYTRiV2p5ZHRnUXZGZTJqSitxVS9oZkh2Wm9MYlFL?=
 =?utf-8?B?K1RQMDJXMmdxdDZYSkJlOFlvYlpXSjBiNGM5T1FnU0lUMTFtOUloR0QyR25G?=
 =?utf-8?B?YVZDbEFlSG5QMzUrNkM3WVlqVkVKNkdUay9QNWpudkU1ZDdPdE9jVnBYTnNE?=
 =?utf-8?B?a3dSdmljdkFuUmZnVGNrRExZck01UGhHSUVMblNxVXR6Q00xMTJsK1RJdk1m?=
 =?utf-8?B?Mm9EazM1UHkySHdpSEJ3ZGE5SkhnMGpNTWJ1UEZaWG1MU3V3dFNzU28xM1Qx?=
 =?utf-8?B?Nm9rZm5EdmF6SHR1aFNOQnplTC9ZV09vMmhxbHBNWGo3b0VVUS9mQkNlOU1U?=
 =?utf-8?B?REc0SGpmU1F3MWMrSHB1bW9UVEwzb3V0akc2ZmV1dTRxOWtyZlFHYVBxSm9s?=
 =?utf-8?B?cy9Fb1k1QkxEdHZqbWh0SitxZjNBSGY5cXFMc0d5cm4wMy9jNE1ndWVEckpp?=
 =?utf-8?B?dWtPUkNpRWhCTDZPYS8vd2JXaXlIcjllUk5yNk9hMms2WE9iQUpnT0xWcGxP?=
 =?utf-8?B?UFNkdU9Vc281RGRNaXBxTWlvNTNaNFhRT2RPU1BHQStwdHpnQ0lxd1B3dlhl?=
 =?utf-8?B?aTlhMXBMOTZaSXMweHhoKytWVjlNTG5HbEsrZWR1Y3pWMDBNSVpwajh6WHZV?=
 =?utf-8?B?VWg2OElmaVVvcmw4TmV2eVZmSnZPd0VvcC9VaVMrUUgyRDV3YzI2R1EyRFZv?=
 =?utf-8?B?L01TbWUzbW1jU2t0SHJrL2t1ZmdtTDkrZHhUUVozTkxIRWVWK1p4bjEvNW9k?=
 =?utf-8?B?ME5aZ09NOTRHbm9wWTdHRVRBb1dlYUppZ3FwYnpwYmdoUEd1V3kyN2thcmta?=
 =?utf-8?B?dmhrTnI3UzI0dGw4YkVpdkl0L1RBZTRqN2hLYlFUQURzK3BFSXBCYWFKQlNP?=
 =?utf-8?B?dnBIQ1FSV0xpQmczd0VySVlIbVNGUjZnY3pOdVhOSVI3UjFaYW9YaUdKUDg4?=
 =?utf-8?B?TEJpcUQ0SGJIWHFBNkZSQS9ySS9TQ1RNVlVvcjl3SnlpV1BDS3VtNllsTGk3?=
 =?utf-8?B?TURnbmtEcjNOaENwbFhrakllZmhTaTZnUlJRcjR2NzNwL2xhd3IwenVFR2o0?=
 =?utf-8?B?ZCtaNTBNYUUrZmpOOWY0Y21SdEg3U2RDNlA1a1JWUVEyR2Y3SURsVXhjVUw1?=
 =?utf-8?B?Tll6N3g0a3QyRC9wWTUxS2dWdmZNcWQzVC9UbXQ4TkVVMVRTOWMrOUNPZUtR?=
 =?utf-8?B?RG4waXJGS2NISEJtZlpId0Uwb2hpV2ZPcHVRZUtCdlF3QWJiRHRQN3VmNEIy?=
 =?utf-8?B?ajF5SnBXREVwSUkxMjFwNHhtSk1wMkxCR2kyUGNTcXFGUCsxb1lnaGRiV0tR?=
 =?utf-8?B?eFBIZHgxRmFBMkN4V1UvUXlJcDI5cUVCbmd3VDhzNnMyWWE1UHp1K3FKZGMw?=
 =?utf-8?B?Y1pkQW13VjAyVUNmUmZyY3RGSExUYnhIR29xdEx2QTZMaG1VaFMyTktUb0xN?=
 =?utf-8?B?QzMzekJsZGozTFVHTUM1Q1NsbmlvaEt4cGsxVm1JOTIzVGx6VVdwclFMaXkr?=
 =?utf-8?B?cFhWcU9NMWtRSFIrdDZNWWQ0V3o1RWRNTE5aeGpvQWQzcGNvZ240RFg3bW1x?=
 =?utf-8?B?ajVWUEhiN25sNDZKS2lMT0tWQkxKemVRbGgzaFZHNWhsdk1WeFl1QU5ISHVC?=
 =?utf-8?B?YmdJMWtUbmlLamgxaUg4S1JFblRCSjRTRXI1bUFGanRBUmxOcGdXVTlLUHk3?=
 =?utf-8?B?YnprY3J1MGxGSHFlL0lTYmJtazhTZnViSHNWVEV5eTlCZTFCaDBtTFYvTVF4?=
 =?utf-8?B?dmwwNlduc3p3OEhuR1JYeG5TeXV3NGhITk1rM2t1djhDZ0JHN3FJOVplSWZM?=
 =?utf-8?B?Mkc0YVlEZktlcVNZSGJlM1ZEOHdDVFA2TmhPWlZ4K1JiLzAzRXhadkVoV0dL?=
 =?utf-8?B?aW9IbUFKejRCOWVURHhLTFBUaXRGUEgwR1VYYS9kRkw4SmF2NHlwc3krT1VN?=
 =?utf-8?B?NVpMdUthTzAycUYxb3MrWVdvb0dUVWU3cjBUOGJPL2puZm92eXBmYnBXN3Bt?=
 =?utf-8?Q?o9IEu1WBmE5Se0DyJBJX6CEED?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3e9c54-e291-4e1b-4e3b-08db513af2a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 09:43:02.3830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lBE/8kDZVngYz8ooadryhmE/rqiTd29HW7SvlKBYaT3Gns4yyWIvB9B83OYQQO6q6ntlG7IkA8oheQqji/YiqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6785
X-Proofpoint-GUID: gMDx-X_PhWRwqkcWn9uVc83SAL2tUuxJ
X-Proofpoint-ORIG-GUID: W3jTKCCFfk0zoXzSvWAU_UIGFtmbMyXw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305100075
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 May 2023 09:43:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14774

SGkgUmljaGFyZCwNCg0KSXQncyBub3QgdGhlIGJpdGJha2Ugc2VydmVyIHRoYXQgdGFrZXMgbW9y
ZSB0aGFuIDEgbWludXRlIHRvIHN0YXJ0LCBpdCdzIHRoYXQgdGhlICd1cGRhdGVDb25maWcnIGNv
bW1hbmQgdGhhdCB0YWtlcyBtb3JlIHRoYW4gMSBtaW51dGUuIEZyb20gd2hhdCBJIHNlZSwgb3Ro
ZXIgY29tbWFuZHMgZmluaXNoIHF1aXRlIGZhc3QgZXhjZXB0IHRoZSBhY3R1YWwgYnVpbGRpbmcg
b25lLg0KVGhlIHNlcnZlciB3YXMgc3RpbGwgdXNhYmxlLCBldmVuIGFmdGVyIHRoZSBzZWNvbmQg
d29ybGQgYnVpbGQgbWFuYWdlZCB0byBzdGFydC4NCg0KSSdtIG5vdCB1c2luZyBhbnkgc3BlY2lh
bCBjb25maWd1cmF0aW9uLiBBbGwgZGVmYXVsdCB2YWx1ZXMuIEkgZG8gaGF2ZSBleHRyYSBsYXll
cnMgYWRkZWQsIHN1Y2ggYXMgbWV0YS1vcGVuZW1iZWRkZWQvKiwgbWV0YS12aXJ0dWFsaXphdGlv
biwgbWV0YS1icm93c2VyLCBtZXRhLXNlY3VyaXR5LCBtZXRhLXNlbGludXgsIGV0Yy4gQW55d2F5
LCB0aGUgdGFzayBudW1iZXIgb2YgYSB3b3JsZCBidWlsZCBpcyBhYm91dCA0MDAwMCsuDQoNCklu
IGZhY3QsIHdoYXQgSSByZWFsbHkgd2FudCB0byBkbyBpcyB0byBzZXQgdGhlIHRpbWVvdXQgdG8g
YmUgc29tZSBsYXJnZSB2YWx1ZSBvbiBvdXIgYXV0b2J1aWxkZXJzIHNvIHRoYXQgd2UgY2FuIGF2
b2lkIHRoaXMgc3RhcnQtdXAgdGltZW91dCBmYWlsdXJlLiBJZiBzdWNoIHBhdGNoIGlzIG5vdCBz
dWl0YWJsZSBmb3IgdGhlIG9mZmljaWFsIGJpdGJha2UsIEknbGwgbWFrZSBpdCBhIGxvY2FsIHBh
dGNoIHVudGlsIG91ciBhdXRvYnVpbGRlcnMgYXJlIGNvbmZpZ3VyZWQgbW9yZSBwcm9wZXJseS4g
RG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb24/DQoNClRoYXQncyBhbGwgdGhlIGluZm9ybWF0aW9u
IGFuZCB0aGUgYmFja2dyb3VuZC4NCg0KUmVnYXJkcywNClFpDQoNCi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQpGcm9tOiBiaXRiYWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcgPGJp
dGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4gT24gQmVoYWxmIE9mIFJpY2hhcmQg
UHVyZGllIHZpYSBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQpTZW50OiBXZWRuZXNkYXksIE1heSAx
MCwgMjAyMyAzOjUyIFBNDQpUbzogQ2hlbiwgUWkgPFFpLkNoZW5Ad2luZHJpdmVyLmNvbT47IGJp
dGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZw0KU3ViamVjdDogUmU6IFtiaXRiYWtl
LWRldmVsXVtQQVRDSF0gYml0YmFrZTogYWRkIC0tbm9yZXBseS10aW1lb3V0IG9wdGlvbg0KDQpP
biBXZWQsIDIwMjMtMDUtMTAgYXQgMTE6MTYgKzA4MDAsIENoZW4gUWkgdmlhIGxpc3RzLm9wZW5l
bWJlZGRlZC5vcmcNCndyb3RlOg0KPiBGcm9tOiBDaGVuIFFpIDxRaS5DaGVuQHdpbmRyaXZlci5j
b20+DQo+IA0KPiBGb3Igbm93LCBpZiB0aGUgY2xpZW50IGdldHMgbm8gcmVwbHkgZnJvbSBzZXJ2
ZXIgd2hlbiBydW5uaW5nIGEgDQo+IGNvbW1hbmQsIGl0IGV4aXRzIGFmdGVyIGEgcGVyaW9kIG9m
IHRpbWUuIFRoZSB2YWx1ZSBpcyBjdXJyZW50bHkgNjBzLiANCj4gTG9va2luZyBhdCB0aGUgaGlz
dG9yeSwgdGhpcyB2YWx1ZSB3YXMgaW5jcmVhc2VkIGZyb20gOHMgdG8gMzBzLCBhbmQgDQo+IHRo
ZW4gaXQgd2FzIGluY3JlYXNlZCBhZ2FpbiB0byA2MHMuDQo+IA0KPiBGb3Igbm93LCB3aGF0IEkg
Y2FuIHNlZSBpcyB0aGF0IHdoZW4gcnVubmluZyBvbmUgd29ybGQgYnVpbGQgb24gYQ0KPiAxMjgg
Y29yZSwgNTEyRyBzZXJ2ZXIsIHN0YXJ0aW5nIGEgc2Vjb25kIGJ1aWxkIGhhcyBhIGNoYW5jZSB0
byBmYWlsIGF0IA0KPiB1cGRhdGVDb25maWcuDQo+IA0KPiBJbnN0ZWFkIG9mIGluY3JlYXNpbmcg
dGhpcyB2YWx1ZSBhZ2FpbiBhbmQgYWdhaW4sIGxldCdzIGFkZCBhbiBvcHRpb24gDQo+IGZvciBl
YXNpZXIgY3VzdG9taXphdGlvbiBvZiB0aGlzIHZhbHVlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
Q2hlbiBRaSA8UWkuQ2hlbkB3aW5kcml2ZXIuY29tPg0KPiAtLS0NCj4gIGJpdGJha2UvbGliL2Ji
L21haW4ucHkgICAgICAgICAgIHwgIDcgKysrKysrLQ0KPiAgYml0YmFrZS9saWIvYmIvc2VydmVy
L3Byb2Nlc3MucHkgfCAxOSArKysrKysrKysrLS0tLS0tLS0tDQo+ICAyIGZpbGVzIGNoYW5nZWQs
IDE2IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KDQpZb3UncmUgc2F5aW5nIHRoYXQg
dGhlIHNlcnZlciBjYW4gdGFrZSBvdmVyIGEgbWludXRlIHRvIHN0YXJ0IHVwIGFuZCB0aGlzIGlz
IGNvbnNpZGVyZWQgYWNjZXB0YWJsZT8NCg0KV2hhdCBjb25maWd1cmF0aW9uIGlzIHRoZSBvdGhl
ciB3b3JsZCBidWlsZCBydW5uaW5nIHdpdGg/IEknZCBzdWdnZXN0IHRoZSBzeXN0ZW0gaXMgc28g
b3ZlcmxvYWRlZCBpdCBpc24ndCB1c2VmdWwgYW55IG1vcmUgYW5kIHlvdSBzaG91bGQgaGF2ZSBw
cmVzc3VyZSBjb250cm9sIGVuYWJsZWQgb3Igb3RoZXIgbWVjaGFuaXNtcyB0byBhbGxvdyB0aGUg
c3lzdGVtIHRvIGZ1bmN0aW9uLg0KDQpJJ20gbm90IGtlZW4gdG8gbWFrZSB0aGlzIGFueSBtb3Jl
IGNvbmZpZ3VyYWJsZSBhcyA2MHMgc2hvdWxkIGJlIGVub3VnaCBhbmQgaWYgaXQgaXNuJ3QsIHRo
ZXJlIGFyZSBkaWZmZXJlbnQgaXNzdWVzIGF0IHBsYXkuDQoNCkhhdmluZyBiaXRiYWtlIHNpbGVu
dGx5IGhhbmcgZm9yIG1pbnV0ZXMgYXQgYSB0aW1lIGlzbid0IGdvb2QgZm9yIHVzZXJzIGFuZCBp
c24ndCBnb29kIGZvciBDSSBlaXRoZXIuDQoNCkNoZWVycywNCg0KUmljaGFyZA0K

