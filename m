Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDABFF5105
	for <webhook@archiver.kernel.org>; Tue,  7 Apr 2026 15:05:04 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.83510.1775574296068034221
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 07 Apr 2026 08:04:56 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=d2HIK7AS;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=8557d86685=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637670ua2961512
	for <bitbake-devel@lists.openembedded.org>; Tue, 7 Apr 2026 15:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=AZQ7jG7hb5WrwPboZopsFV6hJoP3jGzmuAOmiK19U1U=; b=d2HIK7ASNXDS
	laLuoVTOjzGRZcaM31fXY+5je3JxzIJta1ly4Idx3lkGg8+BbVHEpdJcj4lyv4XX
	5Lre8HLhvp1iFwmg4CoC2IOrt5vL8MoJ2qUpQBGn6WtDIipEyBWQXVEX2zNK/L3E
	Fu7LfFEcgw92mNiH1htks9zylmUA2iqceuIeaPKj7aqQTYDelzyrK/zuLGKd7Tt3
	okLho3Xs8Ee83vMs4jDGIhRwMFS5MrZ9UlDdyI0v8d+0vZKqpgy6xhCDzlhqZqke
	T0WjdoG02SSJV6S1h09CcafokevrwXEQaxv3rDfJZ33Vhj4J8e9/XpSma3su/3wF
	5tUhm8Cp6Q==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012069.outbound.protection.outlook.com [52.101.53.69])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dcmrqgx9y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 15:04:54 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2IfReD6ZM37+dxGmiZqGpz+php+MeIKtEgowDeDk0JzkWOd/6KDmUCBKJYnWbF5/CXLZHjT9m5en3uuZXZOJ3FzqKNHvxGlMpZXL/Ur/APR7I5KqDCBJDRljSOu0e2VLxtBsE93uXjRCnFLmEM3MRlX61zjt8pJbQUhLqkkiyewE7UR/+EogI2aDHuUKQ1CdI1nStrZTG3N5ZL/DJmakquMo2h4wQlgAR7RfLx07zjH6TiRzDLU+PSWKR8RHHcRQMJgR9mQbihMxIjRKZDvZAarJ0iB9t7lGnWBC51kYH4TLMTwQxPqu/QUg8qz0gQPdghCOMb2uzE8jvilhTWV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZQ7jG7hb5WrwPboZopsFV6hJoP3jGzmuAOmiK19U1U=;
 b=jhaEUyTVAkLxYebv4h54t8SU9imqHxQjUS3ZSisNWNm+uj5vaph3AFnRZbndzuPJTSWcRf8yQ3McjcAeblvCzNdc1o6P/SF3Fu4yGP8jjlw34rQgqqzJ+xw3a8r+A4568CZ6Dtwqr4uYE61BTFOlUC8qInEJ1jnu14TXAaphxlBBGqflE9e7oVtzSnTMLZ6g5uVX4OjanJFQVIWQax5clQoXpSPBAj+IGW0d6lXZF8lEP6vw6jY8Q6gh0KA8Z9DkfsB2rP5Cmg8CT5Od3Km+Fl2rPRKvQTqwlPuEmrFTKVpL2x50PlV77iST4KNCL+6/qo2mt+XFkVlfKNe4FF4IFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM8PR11MB5655.namprd11.prod.outlook.com (2603:10b6:8:28::10) by
 MW4PR11MB6886.namprd11.prod.outlook.com (2603:10b6:303:224::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Tue, 7 Apr
 2026 15:04:51 +0000
Received: from DM8PR11MB5655.namprd11.prod.outlook.com
 ([fe80::ce1b:9c1d:d571:9eb8]) by DM8PR11MB5655.namprd11.prod.outlook.com
 ([fe80::ce1b:9c1d:d571:9eb8%7]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 15:04:45 +0000
From: "Woolley, Rob" <Rob.Woolley@windriver.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
        "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH 0/8] bitbake-setup JSON Schema: Fix
 linting errors
Thread-Topic: [bitbake-devel] [PATCH 0/8] bitbake-setup JSON Schema: Fix
 linting errors
Thread-Index: AQHcxnjXZcNtgrzKzES9s2JtliiS87XToeOQ
Date: Tue, 7 Apr 2026 15:04:45 +0000
Message-ID: 
 <DM8PR11MB56556CF8AD10DF98CF51FD66E15AA@DM8PR11MB5655.namprd11.prod.outlook.com>
References: <20260406172110.2050236-1-rob.woolley@windriver.com>
 <DHMULR3D49P4.10EX6OE4BC2CZ@bootlin.com>
In-Reply-To: <DHMULR3D49P4.10EX6OE4BC2CZ@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=True;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2026-04-07T15:04:45.332Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=1;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5655:EE_|MW4PR11MB6886:EE_
x-ms-office365-filtering-correlation-id: b95b2be8-4b7e-459d-03a2-08de94b70176
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|13003099007|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: 
 +YTSc93PlyaY2Z849r4G2ADdOIDQYzx+xos/ZDqrBnSkc5KRaWbnClKIQedqeB8cJpjWvJYp/up5YAPXkQB8Z7wmW3LbVmDC+YPaSdhRyP2nG8nlO/mDpJJ/E6gqIDqsu4PZIbWXaQG7fU841Ke/btX8jCYRlnDMYiNhEK/Ui3pfx8tH/1CAcabAJhfgs4IFajCBDhf485uXA9VDjKctNfOqLHg/oKrqF2h+sXYml/81JeslSdzvdyk4zqs/MNtlHyKYjHRnToQ+Xv0t5kPX7amXtfRxDYE4reXYBC5ILmCu4TX8LFPREKz4UAapD5d5gKwXWrPuNM+EEtYoTfD8dnayHPsbsoVtUND15zZfNyYO5YLcA9bQDdt9LUHtNznV9Ay3MHUFMXSpwrx5uY/vZPgilBF562RMr6nZaIBbW5bJjIUEAfHoQvv14uTTXsO55E2xHb5ef4AYtMOdGLLMRLBGzI7XA/xQRWpQTv4CLuX9KHJrtw6yyqQ1Mz66LRH+MaBNXVg8zyRlW0aMn/yffqMRbSrlmLu7qpaQdT+bxvb/ZEO3ZMh++IEqaH7uNhYheuerWi2KY+4WNSoJyTlPAFwzU+/3RCQ0N5jthr68W9EpByb19dUsD2Pm3NVMIdCjTN8qV6DRtr0LQSndEiouESPKTS3ajMPu3dZAuBhqS1Wm2GMpXwfr7E/goUsM8gVkr8dsttWS+FzXjc60p1kS7yJcLaRsf0vEuOpOmx5kFWDl3/fvwGQSaTgd8XV/2OGh
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5655.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?emme4nVWAl3jkutME/QKsI6POD9BYPPwFDU3aNjMR+iJgMTzsMmxS1lZA8?=
 =?iso-8859-1?Q?bv7OLHSTjP6xzgI+wX6FngeYuIb2lfzSVHn8Zbsr7ndPSaavw/A8UqMzSB?=
 =?iso-8859-1?Q?vyQSKFUuQkc2DGWPjwkm8t8n2xA8nI/K0xhmdphASWNBD7qh7zDuTfELWH?=
 =?iso-8859-1?Q?vgYw7EyfUCRevvMMud1rLRy3yoBA6J0bEWsqKS40HG3pjXMpBkKNDsjr3j?=
 =?iso-8859-1?Q?dpbKDT2C6/3uocyUNL//JY5N1IsVJHltybr5Cry6AZywR/KYxS4aF7yLjy?=
 =?iso-8859-1?Q?ISEpGnX2m1GZUYIEf3uEtgQmV8yb5i4DX+6M4dLtu9DKVQZSiwjsdUtcnF?=
 =?iso-8859-1?Q?uKOLdNc8l1B27sXMqr1zF5byBKV7dCUssczjJdfnVSqOY54dHjCdpeRyrX?=
 =?iso-8859-1?Q?AFrL3gSwm6o3mSYQ/ZQBLQNGUFIEckSSe2ku0+UDCEs4UOjmyC/SnvrXWM?=
 =?iso-8859-1?Q?5o53bRNZLytcalT5PTf7a9rHKoQYyS2J3g57QIah75+ZpzfO+v+EyWMGoO?=
 =?iso-8859-1?Q?1hmUSscPnlH5KBEnKfsRtbP9p1GHDZ2OQHT14v2ghnkEH94hWBYo25Sc/P?=
 =?iso-8859-1?Q?BxDmkUNc+aSf9jtp7AQFjvrXs2EmkeS/icDIenmcJlXKy/Lh07SaJSMi2J?=
 =?iso-8859-1?Q?UhDizZhkHYh0HrV0MWSFLwdYfXBCZqUlVVw25dSSjv6oBSg4yCeALvr91p?=
 =?iso-8859-1?Q?dOTwdSxF2ikjLQLq/vr8Vf2jE3+Bq6PLcddHnOHoTRbKiyTITSA5rc6HS5?=
 =?iso-8859-1?Q?gKQ/zEOQvx4jfudVXHwEsdCFVLn5hbnH5MxGSZtOF9pHP24Gpl6gPiaOCP?=
 =?iso-8859-1?Q?Wvn4PHyxU41ccpMlnKzBp7BKFobY7kJKEcVZk57oWPEwExr6HDvVNTqTCx?=
 =?iso-8859-1?Q?ChSFHwbkieLK7r5D/ToEHV221OlLogAGvgTG2+/hQmk2Rc9ezMEOyZu/cy?=
 =?iso-8859-1?Q?m/VGuI2B0l60RUOafSVMG1t4InyXUwOqtSjpde7JLkS3BJMMwb8qyb7LRd?=
 =?iso-8859-1?Q?KwtEGgGi3VwKUNAFtrEXpEq/nPeYpqt4ZlBHDDHbjNtUqrwLrkskw25f+F?=
 =?iso-8859-1?Q?IVL8a6zCvsYig2LRlN58jiWa8SP+lJR4ZYPhwsvihfcM1i0HadbcpnDVRv?=
 =?iso-8859-1?Q?q0/9uLArXaYxn8sr6U4Ur0Wh5V5RK+T1+2qCj6Sk9LFPPI+NnFJdVUoQG2?=
 =?iso-8859-1?Q?gh7/HXbCFY3KNfcO29pMwlLYS7jN6/YBqum2IRoq+HHJCfWhQnELr63LkK?=
 =?iso-8859-1?Q?2WmOanNKHbFtgbI2EqSFzLhRTLCs7weomXYg0tWNYtRcFeWSEa8OntcS8G?=
 =?iso-8859-1?Q?lNouAiYiLEMuhhk1KgBNxEPJZ0JrV0gz8hrdkJrIqjeL0Da+TUawCSQq/E?=
 =?iso-8859-1?Q?jl9d9nbcwCr1ffPfuCEAveCaRKl/RM9v/Uh7g98/jKr8T1M2rFYyEgVibO?=
 =?iso-8859-1?Q?lm/1Yd6goB1MQURs8nN1GIPwpLOVsoIxAa26UuEJS0JXrySMe71w4Fyw28?=
 =?iso-8859-1?Q?fjw0umiz2m2AB6WiXSoFs4Wc1pAASD1gi1Qdf1PW9zmJTsyTajMzm3lNsX?=
 =?iso-8859-1?Q?NCV0OGhbmwL7BMeGmJDYdPbjfsUI1zJbwn1iUGFu7chIks1Ch4hGmbqKab?=
 =?iso-8859-1?Q?kD5L6XXtaEge/aXVxZLq7/DuqFvFAPRteQg8Ye81JENq3ZlrD7HalwyMwH?=
 =?iso-8859-1?Q?EhLzkizWZ67R0X1nVVfPJBTKoXgl2tfD0FDWkJUcfLVx2tlcXWwWHLbg3h?=
 =?iso-8859-1?Q?EnmgTSuErAOoAnoQwpydnmh15weoMcZeP1VvYC4ZZxHLil1HOPuAgJmMTU?=
 =?iso-8859-1?Q?Zzp5waN9+g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 
	ffdEHxwYSTlhURpJ/ZK7nanJdWeyK/kQnpoH7ZnALJsseMwLc88vDx3g3PtUmMU38Gqk/PnpCDQamOHhxL4c71HOxlq+b33l3Bp1Wy4BsCE420hJv7eI1FTz7haq+uFBvb6wtC9/HpJn4SWSmGMV/3bx64g08rtPRh8M+ZpjP40U+4WnFW+s9oIz1ITf8CjEoaYlt0IOs3n2GYuN7r/14UKQWqU3CSlcvARl0xhzhk03wj2k3hve9JysQCTldBdFlcUI6CUiRAOhlmyTwg+muhGAm1ESoJ0FtjJgl2NjViqGeKr+6WuQ+D0sMzPq1DMvR58FeUAnrjbf8Jv3c8wcNA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5655.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b95b2be8-4b7e-459d-03a2-08de94b70176
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 15:04:45.7345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eC5IMC/IlqGy6WEvn9673JWxNQyP45EwqyBnFGoFUyK9EM0wusMAsTfpoKk3uS9sKK/03rDWEEN8M1nApUseaExBf6mXu86LGa7BPGVPBkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6886
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RPCD2Yi+ c=1 sm=1 tr=0 ts=69d51d16 cx=c_pps
 a=XnoXs6g8SJkBXVwgXvPJGw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=CckQENj0AAAA:8 a=Q4-j1AaZAAAA:8 a=iGHA9ds3AAAA:8
 a=P-IC7800AAAA:8 a=cLHGIikeo6POazGCi-cA:9 a=wPNLvfGTeEIA:10
 a=9H3Qd4_ONW2Ztcrla5EB:22 a=nM-MV4yxpKKO9kiQg6Ot:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: C8mZMDu0Vr5AwLQ0KQUMV1A2eOdUP1Ft
X-Proofpoint-GUID: l-QJlfS2aSXWpL2ePrjq6nIZOnRjXlWb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEzNyBTYWx0ZWRfX4FSJHUbs013o
 V/Ipq22eXeDI7jJ8QcoAKt5HBSRPixUABw094vvUCONketoSIhBp2v1/DzDVDv/rluwkg2p4TBW
 eXEKbPPHwlDTa9eIF1Maz770zJCyg4STJDP6BQ6/GUvrZkC7qdu31lmBPzr723p7eE45MkyAx76
 V+r8h1M4Y6rIP+cj52uFkdiohOGB1po2ttpGRxSc10T/AxXDuSkZbx9Z6ndjgKxm70OkFchof99
 SY0f3ea81qb4H7o15Ojybu3fFt2OH5ALeIkNL/qkL19H9AtrWa/qeEmqScO9PGN6c0UFfFhH35G
 ZSxq0DBxMctiaKdLos4ONvumzXdKn7RhS0odL/cP7o3oCjSFYEHw1olWJJO4nwGE7yqocFkumRa
 OFBE6LHjl8/UX3ADPYuofNdDYhBpFKQz+N0Jeqlj+aWTgbZuSIRWY2INpgEU4L1nGKVRuJugR9k
 GhjZ4/DTct4adKxCUGg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070137
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 07 Apr 2026 15:05:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19349

Mathieu Dubois-Briand said:=0A=
> Hi Rob,=0A=
>=0A=
> Thanks for you series.=0A=
>=0A=
> It looks like some selftests are now failing:=0A=
>=0A=
> 2026-04-07 08:44:43,890 - oe-selftest - INFO - bblayers.BitbakeLayers.tes=
t\_bitbakelayers\_setup (subunit.RemotedTestCase)  =0A=
> 2026-04-07 08:44:43,891 - oe-selftest - INFO - ... FAIL  =0A=
> ...  =0A=
> /srv/pokybuild/yocto-worker/oe-selftest-debian/build/build-st-1874443/tmp=
/work/x86\_64-linux/python3-jsonschema-native/4.26.0/recipe-sysroot-native/=
usr/bin/jsonschema:5: DeprecationWarning: The jsonschema CLI is deprecated =
and will be removed in a future version. Please use check-jsonschema instea=
d, which can be installed from <https://pypi.org/project/check-jsonschema/>=
  =0A=
> from jsonschema.cli import main  =0A=
> {'version': '1.0', 'sources': {'bitbake': {'git-remote': {'remotes': {'or=
igin': {'uri': '<https://git.openembedded.org/bitbake'}}>, 'branch': 'maste=
r', 'rev': 'master'}, 'path': 'bitbake'}}}: {'version': '1.0', 'sources': {=
'bitbake': {'git-remote': {'remotes': {'origin': {'uri': '<https://git.open=
embedded.org/bitbake'}}>, 'branch': 'master', 'rev': 'master'}, 'path': 'bi=
tbake'}}} is not of type 'array'  =0A=
> ...  =0A=
> 2026-04-07 08:45:39,329 - oe-selftest - INFO - bblayers.BitbakeLayers.tes=
t\_bitbakelayers\_updatelayer (subunit.RemotedTestCase)  =0A=
> 2026-04-07 08:45:39,331 - oe-selftest - INFO - ... FAIL  =0A=
> ...  =0A=
> 2026-04-07 08:45:39,594 - oe-selftest - INFO - bblayers.BitbakeLayers.tes=
t\_validate\_bitbake\_setup\_default\_registry (subunit.RemotedTestCase)  =
=0A=
> 2026-04-07 08:45:39,594 - oe-selftest - INFO - ... FAIL  =0A=
> ...  =0A=
> 2026-04-07 08:45:39,819 - oe-selftest - INFO - bblayers.BitbakeLayers.tes=
t\_validate\_examplelayersjson (subunit.RemotedTestCase)  =0A=
> 2026-04-07 08:45:39,820 - oe-selftest - INFO - ... FAIL=0A=
>=0A=
> <https://autobuilder.yoctoproject.org/valkyrie/#/builders/35/builds/3617>=
  =0A=
> <https://autobuilder.yoctoproject.org/valkyrie/#/builders/48/builds/3499>=
=0A=
>=0A=
> Can you have a look at the issue?=0A=
>=0A=
> Thanks,  =0A=
> Mathieu=0A=
>=0A=
> \--  =0A=
> Mathieu Dubois-Briand, Bootlin  =0A=
> Embedded Linux and Kernel engineering  =0A=
> <https://bootlin.com>=0A=
=0A=
Hi Mathieu,=0A=
=0A=
Thanks for pointing this out.  The fix is simply to use brackets to enclose=
 the object in the examples property inside an array.=0A=
=0A=
I expanded my testing to include oe-selftest.  I just sent out a v2 of the =
patch series.=0A=
=0A=
Cheers,=0A=
Rob=

