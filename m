Return-Path: <david.reyna@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38893C48BC4
	for <webhook@archiver.kernel.org>; Sun, 18 Feb 2024 23:27:26 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.29753.1708298843019745268
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 18 Feb 2024 15:27:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=lYf1egFj;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=2778734a41=david.reyna@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41INLNX4017302
	for <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 15:27:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=from:to:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=K61NANgC9Kk0K5VmCYGdQvmldLdwFmnXIo5kmKtoUZ4=; b=
	lYf1egFjbSIKj/uL7M4NLiC9dCbCG9//VMuEfGia2BYyZWMlpaP1pPPm9FzgwMnx
	JnrbvAFh2fQCS8PI4DXiyP7fELg5wghEXWHkny9614NdTzb8Pt83gbmxfxKP3yjr
	rfNAjCacDx8hkkG9YgFV03/yq+fQRI3TA/J+UqsDaRRKflXeZwsu0Rl9f2hMt3xA
	iXOGLuXn/rmYpZkwvMUqL1Hvj3dJ+T+qNWoB6SrOznVDeylOwHT9/SGpNNqtKlAA
	4ZsvI1Y+kMljaqykFsukzF2BhIBqdd/YSs1T+Jk/DfwqC4p7R7M2x14UPC0f55cG
	4yXcC9vl4I3cHjXdumei7w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wary4924k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 15:27:22 -0800 (PST)
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 41INRMHE024538;
	Sun, 18 Feb 2024 15:27:22 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3wary4924j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Feb 2024 15:27:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDCdmxFIamdfptwBaY6kuEzjL3DT8mt9VU49Ck+wBaT7WMalcymdVvG7zJXXM9LqBqJZyjJPVyveTSoOgU9qUw+s41jvBRg85F5vgUUlf15Y/qNbL7QPVq0yVeOu495NXQnEp2VNHbvrBWZM+3fSGfVd3SmgrWaZ3/I4AjUXTW2Fi5ilnVDHD991di6Cuiwwo+3QB9qmKnQnZjpC8dhv4opzzppIDj0rPhOnBcpjYHXRbuNA+2JYwgULUGSosOe5ucAMaDQD3Xo08FHe4aA26JGCUUBWy3GzwnGRvUmDvQAyXbUqqcbuoHX3kCqUTjZQgkZXtBJYXrPHQh4OEV7NAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K61NANgC9Kk0K5VmCYGdQvmldLdwFmnXIo5kmKtoUZ4=;
 b=CcKuL0Lvf0jIIwMBo4oJR+JH9XHRKWhKL0KAvtwO9h41htJ3bKF7u90rS+LvWItNxXmvDORJUqv3brIJoZxXqz13m43V3IjzBdcWvgLkjRgNN8Xe+ZR1JlCxsOPCMjQXr5hlVxYRWZeKBhBL4dn1ixO5G5TiURTomxKKiOsOuLpn5FzsmDsEMhEJuNpW2vjRL+yRWaTPG+DdwymvqZffVexwxsizMFQlXO6k3p6gFliEIjMEIp9g8EfUth7LwPCfnhJf4jWJJldmjhPrPbxrF0NuklYuYvtnBp+4//yNNZoIiZfxARnnBeJHYDPkCyGTKwplnyNxJ6YkMQcs8+puug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BY5PR11MB4167.namprd11.prod.outlook.com (2603:10b6:a03:185::28)
 by CYXPR11MB8663.namprd11.prod.outlook.com (2603:10b6:930:da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.37; Sun, 18 Feb
 2024 23:27:19 +0000
Received: from BY5PR11MB4167.namprd11.prod.outlook.com
 ([fe80::ca49:987d:3f38:4e0e]) by BY5PR11MB4167.namprd11.prod.outlook.com
 ([fe80::ca49:987d:3f38:4e0e%4]) with mapi id 15.20.7292.036; Sun, 18 Feb 2024
 23:27:18 +0000
From: "Reyna, David" <david.reyna@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH 1/1] taskexp_ncurses: ncurses version of
 taskexp.py
Thread-Topic: [bitbake-devel] [PATCH 1/1] taskexp_ncurses: ncurses version of
 taskexp.py
Thread-Index: AQHaYpEGq1x1rSE4kEKyGNk+n4BWq7EQva4g
Date: Sun, 18 Feb 2024 23:27:18 +0000
Message-ID: 
 <BY5PR11MB4167FD60E4E3ED08CB124895EA522@BY5PR11MB4167.namprd11.prod.outlook.com>
References: <cover.1708252029.git.David.Reyna@windriver.com>
	 <c3864291243d501bcaae5ed79cb1fd4577ac324a.1708252029.git.David.Reyna@windriver.com>
	 <17B4F59E3ECA4807.31287@lists.openembedded.org>
 <7461170e0a5ee05698999ab57e53586ab95fd09b.camel@linuxfoundation.org>
In-Reply-To: 
 <7461170e0a5ee05698999ab57e53586ab95fd09b.camel@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB4167:EE_|CYXPR11MB8663:EE_
x-ms-office365-filtering-correlation-id: d50245ee-0e8b-499a-1cc3-08dc30d92609
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 dReKxB+Ke3U4pAbUvAfyus3VqqK0yzQX4zFyylYJd7rmDBrHDpVhC3amlBB/lZ3NWNgyyOnjDcvo2Py3DUoTuSVzoyS7traB/5NeU7zvKt9glMbPMePQQd01bbtx+olYRTBhPtXWOd32cq9ACOfAzP7ZkaSb/fcDUCzBaoQkvk6AyPCl2XtZZsXjKfeSRImzSh9bUxJD8OI0ErdZqRWiYPGphWqVdkLL5UV5OKTnHv0zLabPB8XgK21F2cQEevoYTaUk1O/mG4F0WMKx57bzIUG9ATCfSejTAtWXwtzVmVFXgImWJ923FzBDGtYN86e/ursdiexDCmIAnfRSH+xIcfRYQEfn5dejx+QKleE3RyWuB78RdfZ6LenMMz8DKDDn0vMEr0RpM0wmoL31hYutHKJsFDHXshoU7e4IevZlXJCJMc5oDM1JLOcJY+z6/zmFrET5E5yTmi63gZ5AtRlm73jzqPVgJZaI7/PmKMbA07iDG1wzY38NdRDQp5xy4rwICOzICme37k2e9U8xgGdau5nhktwA/R+BglKml1AfjGaTxQfrt1VMBuLFJe9LuLkEK1XyKQjS1s5jz8hFs8WtA84M20Jfe7GxbSYth+FCYf2PwEVdpJA9FGhv6rFbVXrK
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4167.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39840400004)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2906002)(55016003)(5660300002)(8936002)(66556008)(76116006)(316002)(66446008)(8676002)(52536014)(66476007)(64756008)(66946007)(41300700001)(83380400001)(38070700009)(38100700002)(86362001)(33656002)(71200400001)(7696005)(9686003)(478600001)(53546011)(110136005)(6506007)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?dUZJRXNCT2NIRlUzNUNWN05EbXhLZ0RSVjVOeVNMejdsbm1ocnNrZXpVOHFx?=
 =?utf-8?B?cHBzYVZyRWI0MkdCeURJQ2pCQnozMjVsQ3FHNEtiaDNrTWh6RXB4ZkUxM3RJ?=
 =?utf-8?B?YlBaZFZyWkx5SzFZNEIvaHhQK2ZONEtpZkk0alZGaEdoeXNpNE93TzR5VTR0?=
 =?utf-8?B?Wjd0V1VuWDVjSVVPMkN1bkZpa05CQnVvc2RmSUFySDU5aHZsS2l5cGFWQnA5?=
 =?utf-8?B?a2tJOUhLUVc0TlJma2hsdGtwWVZuejZlZHN0dHE0cjIvcGFKQ3dpb2w1bVdX?=
 =?utf-8?B?VmJTc1RaSDhGWXE3bFFwME1lbzVuN3NrRGxTbXBHSlh3Y3ZEeVFDTnR2Ui9U?=
 =?utf-8?B?WVhVWTBNS0FZS2dsMkI2TzRlcHFGU3J6S3lsS25lT1BiVFIwWHE0dkhMWWNq?=
 =?utf-8?B?MHRHVzFJVklMQUN4OWlNWmFtNlJ4WTQxd0dvdmlhVHBURks2SzhUUENCc29h?=
 =?utf-8?B?R0xsZ285aGMrRUZraGVzdFJIeTFzc1pHRFhqeWtoOFMzOW9ZMjhDL2ZuSENR?=
 =?utf-8?B?RHkzZ2F6Z0FZdVFHcllQQkZ3TkZVWTF1WVZMWVRhMFdYRzhJVFJQY2NNRjAz?=
 =?utf-8?B?cGpPZnpGMWR5eG4zbTNyYWRDYTB6QjdWN0JVZEJpdlZvenBBU1J5cUNSeWZN?=
 =?utf-8?B?S3ZYSW1aYnpjY0NFckloWStVYVlPR0x3dnZLSmZVVWRWTGRaUXJlSkFDcHRO?=
 =?utf-8?B?dTlVSFVPdnZBL3V4bG9lM0ZSK2hhZjRrY2liZWEyU2Y0T0VycEh5c0pnNXRB?=
 =?utf-8?B?U09hNHFXQWZJMU9id1c3Vk5taUxoSitiY3JuQkM2WTNMak12by9TampBYWs4?=
 =?utf-8?B?and2S1RaRHUyVmxUdWVYY3Fvb1hNbjVURVJWOUprSlNUSVFjdEd6dGhZQjkz?=
 =?utf-8?B?MWlqeTdEdDdXTkRxWG1ZUFhsaDZUdkpYRTZUTzUwOW9obmdob3dvYWkweGJw?=
 =?utf-8?B?M0RmdDY3MEI1QUY1OWpCMFRENkdReTdmSTJDeWlqaFI4cmFPMGdaT2lud0tz?=
 =?utf-8?B?Q1hRZWdoM3orQU9FeFRQNmt3aHBVUWljQ003UFgvNHhPTTIrdTFCaXM4cXRC?=
 =?utf-8?B?TVY1Yk93N2ROM21rQkZyNXhqWXRmUVJrbTlmQ3c4K3B4RUtINjd3aGZyZnlv?=
 =?utf-8?B?TXlCTDNPTnFOTEpJM1REU1RlUFpVSmZiUVpnYWpoYUxpSmdLcFoxMTl2ZmlN?=
 =?utf-8?B?QkJGUXNtc051YzZtN0Jsa2pockVtK0I3MFRoRGxBQU01Yjc1RUpETHk0Wi9Z?=
 =?utf-8?B?S2NDSmN0OTVyQkFIZ0hoYWFFSmdySTg2TnpOUDlvQjhabndGc3V6UG9XOEx1?=
 =?utf-8?B?aFBmc1pXNHA0dlhRQ0RsNTJ1TlpIQnByTlZWK3RoQlcrTUFhOTdLY3YybDBU?=
 =?utf-8?B?NmxKNk1JMVpyMk5TOVJUWUJKVUtnYnE5RHR4dFBPRjNYMXJaellsejBlQVk3?=
 =?utf-8?B?Z2YrQTZ5ZlExQkd5TFZHUVlBNElWNWo0Y3VQZTliL0djd0F2WTJ0TFFGd3Vo?=
 =?utf-8?B?TjNxTHJBSitvYXlUWGY5NUJpVXp1dUVGYlJGK3BlWUVNNkdVc3gvc1JGR3l2?=
 =?utf-8?B?djBxQk9NSlpoTXJOaE5OWlVwTW81QU10d01HS200cVJETUpTaU5VZ29LbjJa?=
 =?utf-8?B?RHh6UHQ0bE8xSjNNekVqVk93K0dSZmpZeVZQQm5qdG5sU3FFZWtYQy9Damg2?=
 =?utf-8?B?NVE2SGVrdGtzd3hIYWlxM1hyVWtGK0ZxRjJyRFhsRDQ5QmNlSitVdGN2Yi9x?=
 =?utf-8?B?SVc0WFZ2VmFQLzBDUUJYa3BlZTRrOGtpdWhlSWUrek5VYnF3Vm52eGFOWEVo?=
 =?utf-8?B?cUMrNmR5WEVIN1VnSW1FaGVYbkY3V2FRcUdNaG5UYlc4SElUK2NEbk1vbk1I?=
 =?utf-8?B?MHhsM0dlY1BWSXRTL3B4QXFRenRxWnQwQjhaSVNpMFBwRlZldTlWMnJwalpt?=
 =?utf-8?B?bDRpUzN2c0hSakgyWFVVS0MrdlduRVlOdkRaYVoxbldsMFVMTEZiNzF0SWhW?=
 =?utf-8?B?ZEJBTHdjdjVNZnhPWEMvLy8vd0dSS0NQc2NZcUJITE9iMUtXWG1sbTI3Q1hF?=
 =?utf-8?B?cTMzOFRIOFQ0elZvcWVRWGlCQnY5SWpwYjhobWc2KzFRUnJxbFB4Qm9IZUhV?=
 =?utf-8?B?UmU2V214MTVEajkwTFMvME12bTlaTWFOSnlyQVBJZE1pUVgwYy92REhlQ1FT?=
 =?utf-8?Q?6C2aJ3gIYtj3qqO8sam9foivmDssMSwIaM/Q+VRdTp7R?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4167.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50245ee-0e8b-499a-1cc3-08dc30d92609
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2024 23:27:18.3306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dPkD2qZ5eQ4alMnz8giozZZaXl/uYP5WfbGEIi4+PBshkrefM/XlUmiRqafdE9eJ16ju5GW4P7y+RgASVTh0nwdi7KWBYo9qaxiVPCzmcyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8663
X-Proofpoint-ORIG-GUID: ifmSmIrG8d6F1oGEVLAVBMnlHtI95pX2
X-Proofpoint-GUID: 9GsGnMw644aryJyyQoAqhn81nIcq0q88
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-18_21,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401310000
 definitions=main-2402180182
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 18 Feb 2024 23:27:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15931

SEkgUmljaGFyZCwNCg0KPiAiZHVlIHRvIHRoZSBsYWNrIG9mIGEgc3VpdGFibHkgY2FwYWJsZSB0
ZXJtaW5hbCBpbiB0aGUgdGVzdCBlbnZpcm9ubWVudCBvbiB0aGUgYXV0b2J1aWxkZXIuIg0KDQpQ
ZXIgbXkgY29tbWVudHMgaW4gIzE0ODE0LCB0aGUgb25seSB1bnVzdWFsIEkvTyB1c2VkIGZvciB0
aGUgbm8tbmN1cnNlcyBzZWxmLXRlc3QgaXMgYSBwcm9ncmVzcyBiYXIgdGhhdCB1c2VzOg0KICAg
IHByaW50KCIjIixlbmQ9JycsZmx1c2g9VHJ1ZSkNCg0KSWYgdGhhdCBpcyB0aGUgcHJvYmxlbSwg
aXQgaXMgdHJpdmlhbCB0byByZW1vdmUuIEkgY2FuIGFsc28gc2VlIHRoYXQgbG9naWNhbGx5IG5v
bi1odW1hbiB0ZXN0cyBkbyBub3QgaGF2ZSBhIG5lZWQgZm9yIHByb2dyZXNzIGJhcnMuDQoNClNv
cnJ5IGZvciB0aGUgZXh0cmEgZWZmb3J0LA0KRGF2aWQNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCkZyb206IFJpY2hhcmQgUHVyZGllIDxyaWNoYXJkLnB1cmRpZUBsaW51eGZvdW5kYXRp
b24ub3JnPiANClNlbnQ6IFN1bmRheSwgRmVicnVhcnkgMTgsIDIwMjQgOTozNiBBTQ0KVG86IFJl
eW5hLCBEYXZpZCA8ZGF2aWQucmV5bmFAd2luZHJpdmVyLmNvbT47IGJpdGJha2UtZGV2ZWxAbGlz
dHMub3BlbmVtYmVkZGVkLm9yZw0KU3ViamVjdDogUmU6IFtiaXRiYWtlLWRldmVsXSBbUEFUQ0gg
MS8xXSB0YXNrZXhwX25jdXJzZXM6IG5jdXJzZXMgdmVyc2lvbiBvZiB0YXNrZXhwLnB5DQoNCk9u
IFN1biwgMjAyNC0wMi0xOCBhdCAxMjo0MyArMDAwMCwgUmljaGFyZCBQdXJkaWUgdmlhDQpsaXN0
cy5vcGVuZW1iZWRkZWQub3JnIHdyb3RlOg0KPiBPbiBTdW4sIDIwMjQtMDItMTggYXQgMDI6NDEg
LTA4MDAsIFJleW5hLCBEYXZpZCB2aWENCj4gbGlzdHMub3BlbmVtYmVkZGVkLm9yZyB3cm90ZToN
Cj4gPiBGcm9tOiBEYXZpZCBSZXluYSA8RGF2aWQuUmV5bmFAd2luZHJpdmVyLmNvbT4NCj4gPiAN
Cj4gPiAqIENyZWF0ZSBhbiBuY3Vyc2VzIHZlcnNpb24gb2YgdGhlIEdUSyBhcHAgInRhc2tleHAu
cHkiLg0KPiA+ICogQWRkIHRoZXNlIGFkZGl0aW9uYWwgZmVhdHVyZXM6DQo+ID4gwqAgLSBTb3J0
IHRhc2tzIGluIHJlY2lwZXMgYnkgdGhlaXIgZGVwZW5kZW5jeSBvcmRlcg0KPiA+IMKgIC0gUHJp
bnQgaW5kaXZpZHVhbCBhbmQvb3IgcmVjaXBlLXdpZGUgZGVwZW5kZW5jaWVzIHRvIGEgZmlsZQ0K
PiA+IMKgIC0gQWRkIGEgd2lsZCBjYXJkIGZpbHRlcg0KPiA+IMKgIC0gU2hvdyB0aGUgdGFyZ2V0
IHJlY2lwZXMgb24gQk9MRA0KPiA+ICogUHJvdmlkZSBhIEdVSSBzZWxmIHRlc3QNCj4gPiAqIFBy
b3ZpZGUgYSBub24tbmN1cnNlcyBzZWxmIHRlc3QgZm9yIHB0ZXN0DQo+ID4gDQo+ID4gU2lnbmVk
LW9mZi1ieTogRGF2aWQgUmV5bmEgPERhdmlkLlJleW5hQHdpbmRyaXZlci5jb20+DQo+ID4gLS0t
DQo+ID4gwqBsaWIvYmIvdWkvdGFza2V4cF9uY3Vyc2VzLnB5IHwgMTUxMQ0KPiA+ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxNTExIGlu
c2VydGlvbnMoKykNCj4gPiDCoGNyZWF0ZSBtb2RlIDEwMDc1NSBiaXRiYWtlL2xpYi9iYi91aS90
YXNrZXhwX25jdXJzZXMucHkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbGliL2JiL3VpL3Rhc2tl
eHBfbmN1cnNlcy5weQ0KPiA+IGIvbGliL2JiL3VpL3Rhc2tleHBfbmN1cnNlcy5weQ0KPiA+IG5l
dyBmaWxlIG1vZGUgMTAwNzU1DQo+ID4gaW5kZXggMDAwMDAwMDAwMDAuLmZmYTkxZWExMDQ0DQo+
ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2xpYi9iYi91aS90YXNrZXhwX25jdXJzZXMucHkN
Cj4gPiBAQCAtMCwwICsxLDE1MTEgQEANCj4gPiArIw0KPiA+ICsjIEJpdEJha2UgR3JhcGhpY2Fs
IG5jdXJzZXMtYmFzZWQgRGVwZW5kZW5jeSBFeHBsb3Jlcg0KPiA+ICsjwqDCoCAqIEJhc2VkIG9u
IHRoZSBHVEsgaW1wbGVtZW50YXRpb24NCj4gPiArI8KgwqAgKiBJbnRlbmRlZCB0byBydW4gb24g
YW55IExpbnV4IGhvc3QNCj4gPiArIw0KPiA+ICsjIENvcHlyaWdodCAoQykgMjAwN8KgwqDCoMKg
wqDCoMKgIFJvc3MgQnVydG9uDQo+ID4gKyMgQ29weXJpZ2h0IChDKSAyMDA3IC0gMjAwOCBSaWNo
YXJkIFB1cmRpZQ0KPiA+ICsjIENvcHlyaWdodCAoQykgMjAyMiAtIDIwMjQgRGF2aWQgUmV5bmEN
Cj4gPiArIw0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4g
PiArIw0KPiA+ICsNCj4gPiArIw0KPiA+ICsjIEV4ZWN1dGlvbiBleGFtcGxlOg0KPiA+ICsjwqDC
oCAkIGJpdGJha2UgLWcgLXUgdGFza2V4cF9uY3Vyc2VzLnB5IGFjbCB6bGliDQo+ID4gKyMNCj4g
PiArIyBTZWxmLXRlc3QgZXhhbXBsZSAoZXhlY3V0ZXMgYSBzY3JpcHQgb2YgR1VJIGFjdGlvbnMp
Og0KPiA+ICsjwqDCoCAkIFRBU0tfRVhQX1VOSVRfVEVTVD0xIGJpdGJha2UgLWcgLXUgdGFza2V4
cF9uY3Vyc2VzLnB5IHpsaWINCj4gPiBhY2wNCj4gPiArI8KgwqAgLi4uDQo+ID4gKyPCoMKgICQg
ZWNobyAkPw0KPiA+ICsjwqDCoCAwDQo+ID4gKyPCoMKgICQgVEFTS19FWFBfVU5JVF9URVNUPTEg
Yml0YmFrZSAtZyAtdSB0YXNrZXhwX25jdXJzZXMucHkgemxpYg0KPiA+IGFjbA0KPiA+IGZvbw0K
PiA+ICsjwqDCoCBFUlJPUjogTm90aGluZyBQUk9WSURFUyAnZm9vJy4gQ2xvc2UgbWF0Y2hlczoN
Cj4gPiArI8KgwqAgb2Zvbm8NCj4gPiArI8KgwqAgJCBlY2hvICQ/DQo+ID4gKyPCoMKgIDENCj4g
PiArIw0KPiA+ICsjIFNlbGYtdGVzdCB3aXRoIG5vIHRlcm1pbmFsIGV4YW1wbGUgKG9ubHkgdGVz
dHMgZGVwZW5kZW5jeSBmZXRjaA0KPiA+IGZyb20gYml0YmFrZSk6DQo+ID4gKyPCoMKgICQgVEFT
S19FWFBfVU5JVF9URVNUX05PVEVSTT0xIGJpdGJha2UgLWcgLXUNCj4gPiB0YXNrZXhwX25jdXJz
ZXMucHlfMg0KPiA+IHF1aWx0DQo+ID4gKyPCoMKgICQgZWNobyAkPw0KPiA+ICsjwqDCoCAwDQo+
IA0KPiBUaGFua3MgZm9yIHRoaXMgRGF2aWQsIGl0IGlzIG5pY2UgdG8gc2VlIHRoaXMgcmVhZHkg
dG8gZ28gaW4gOikNCj4gDQo+IEkgZGlkIG1ha2Ugb25lIHNtYWxsIHR3ZWFrIHRvIHRoZSBwYXRj
aCB3aGVuIEkgcXVldWVkIGl0IHRvIGRyb3AgdGhlDQo+IC5weSBhbmQgLnB5XzIgZnJvbSB0aGUg
YWJvdmUgY29tbWFuZCBleGFtcGxlcyBzaW5jZSBpdCBjYXVzZWQgdGhlbQ0KPiBub3QNCj4gdG8g
d29yay4NCj4gDQo+IEkndmUgYWxzbyBxdWV1ZWQgYSBzY3JpcHQgdG8gYXV0b2J1aWxkZXItaGVs
cGVyIHRvIGFsbG93IHVzIHRvIHJ1bg0KPiB0aGVzZSB0ZXN0cy4NCg0KVGhhdCBoZWxwZXIgc2Ny
aXB0IGRpZG4ndCB3b3JrLiBJIGRvIG5vdyBoYXZlIHRoZSB0ZXN0cyB3b3JraW5nIGJ1dCBpdA0K
dG9vayBob3VycyB0byBnZXQgaXQgdG8gd29yayBjb3JyZWN0bHkgZHVlIHRvIHRoZSBsYWNrIG9m
IGEgc3VpdGFibHkNCmNhcGFibGUgdGVybWluYWwgaW4gdGhlIHRlc3QgZW52aXJvbm1lbnQgb24g
dGhlIGF1dG9idWlsZGVyLg0KDQpJIGRpZCB3YW50IHRvIHNlZSB1cyByZXNvbHZlIHRoaXMgdGhv
dWdoIQ0KDQpDaGVlcnMsDQoNClJpY2hhcmQNCg==

