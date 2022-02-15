Return-Path: <martin.leduc@luminator.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA2C1C433F5
	for <webhook@archiver.kernel.org>; Tue, 15 Feb 2022 10:23:17 +0000 (UTC)
Received: from mx1.luminator.com (mx1.luminator.com [178.15.153.4])
 by mx.groups.io with SMTP id smtpd.web10.7798.1644920595974660334
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Feb 2022 02:23:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@luminator.com header.s=luminator header.b=gu4PLc48;
 spf=pass (domain: luminator.com, ip: 178.15.153.4,
 mailfrom: prvs=00451b1d4d=martin.leduc@luminator.com)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luminator.com; s=luminator; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hfiZXqWM3Kx7uJBRiViM7YkOBnzrBCEPkqtFmD9YYk8=; b=gu4PLc48iSOivG32AHzk9VkJx9
	8nk9Q7MaYmBIMFvtRGor4vllMd5tDRshCP4HBeU0zlg5gfzBaIozLY77xT3sjHTdhif5HHGt1SUpm
	e+OjVVm7unDEEpIdInlR+eNiNWboPSNeyIz32zEFvzYq8DD4mKHcJFjXKwoivzBi1Av55oz9P+G5B
	6tSkw8PPp93pWP7ZOxB09bPJ1v7Akawgo0528gxgxEk3oP86qMRUG1jsJJvBbuR68jtRpU3L8ORe7
	x7aayIPgXb5a8bkg3ftqz2BaDcm5Cj56Hdao7V8sLVbeulYAq/QsQBErM+sU2HD6j85zZDLubyN1O
	AVU14jBQ==;
X-SASI-Hits: BODY_SIZE_4000_4999 0.000000, BODY_SIZE_5000_LESS 0.000000,
	BODY_SIZE_7000_LESS 0.000000, CTE_BASE64 0.000000, HTML_00_01 0.050000,
	HTML_00_10 0.050000, IN_REP_TO 0.000000, LEGITIMATE_SIGNS 0.000000,
	MSG_THREAD 0.000000, MULTIPLE_RCPTS 0.100000, MULTIPLE_REAL_RCPTS 0.000000,
	NO_FUR_HEADER 0.000000, NO_URI_HTTPS 0.000000, OUTBOUND 0.000000,
	OUTBOUND_SOPHOS 0.000000, REFERENCES 0.000000, SENDER_NO_AUTH 0.000000,
	SINGLE_URI_IN_BODY 0.000000, SUPERLONG_LINE 0.050000,
	URI_WITH_PATH_ONLY 0.000000, __ANY_URI 0.000000,
	__ARCAUTH_DKIM_NONE 0.000000, __ARCAUTH_DMARC_NONE 0.000000,
	__ARCAUTH_NONE 0.000000, __ARC_SEAL_MICROSOFT 0.000000,
	__ARC_SIGNATURE_MICROSOFT 0.000000, __BODY_NO_MAILTO 0.000000,
	__BOUNCE_CHALLENGE_SUBJ 0.000000, __BOUNCE_NDR_SUBJ_EXEMPT 0.000000,
	__CP_MEDIA_BODY 0.000000, __CP_URI_IN_BODY 0.000000, __CT 0.000000,
	__CTE 0.000000, __CT_TEXT_PLAIN 0.000000, __DQ_NEG_HEUR 0.000000,
	__DQ_NEG_IP 0.000000, __FORWARDED_MSG 0.000000,
	__FRAUD_BODY_WEBMAIL 0.000000, __FRAUD_WEBMAIL 0.000000,
	__FUR_RDNS_SOPHOS 0.000000, __HAS_FROM 0.000000, __HAS_MSGID 0.000000,
	__HAS_REFERENCES 0.000000, __IN_REP_TO 0.000000, __MAIL_CHAIN 0.000000,
	__MIME_TEXT_ONLY 0.000000, __MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000,
	__MIME_VERSION 0.000000, __MULTIPLE_RCPTS_TO_X2 0.000000,
	__MULTIPLE_RCPTS_TO_X5 0.000000, __NO_HTML_TAG_RAW 0.000000,
	__OUTBOUND_SOPHOS_FUR 0.000000, __OUTBOUND_SOPHOS_FUR_IP 0.000000,
	__OUTBOUND_SOPHOS_FUR_RDNS 0.000000, __PHISH_PHRASE10_D 0.000000,
	__REFERENCES 0.000000, __SANE_MSGID 0.000000, __SINGLE_URI_TEXT 0.000000,
	__SUBJ_ALPHA_NEGATE 0.000000, __SUBJ_REPLY 0.000000,
	__TO_MALFORMED_2 0.000000, __TO_NAME 0.000000,
	__TO_NAME_DIFF_FROM_ACC 0.000000, __TO_REAL_NAMES 0.000000,
	__URI_HAS_HYPHEN_USC 0.000000, __URI_IN_BODY 0.000000, __URI_MAILTO 0.000000,
	__URI_NOT_IMG 0.000000, __URI_NS 0.000000, __URI_WITH_PATH 0.000000
X-SASI-Probability: 8%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 4.1.4, AntispamData: 2022.2.15.95416
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNkUeXgceK5+zJccFS0+qQrKvubh443OxYtV5s6hWVXwjXu3eSV2wH2a9dfHhVxhm4xwoPxoLsECylElmEdU7rRn2KWgUb98FZVuLZSzTx39VXd48e/AolLyrd1juKT2wdWb5uLhlrUbAP3MSGdMuGbTyrsEwHnmJsaPK0a3gjV+TkLavyPiP05dcqCrIxikwEpinbbfYgv0ckWfTw6kXsjtrGA6NX3lZI3HIPzD//Hi8Z8cBI8tZx4uzSBctiSIbfWNdooQR34Vq/4QYB8dTeTyAO5P29VjKqr7rN9x4Qsosd/J5lyEYsm0zozv8V6AhGem8gPvYbghhYNanGILRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfiZXqWM3Kx7uJBRiViM7YkOBnzrBCEPkqtFmD9YYk8=;
 b=PvNZgW3MNDM/nha2ndB6CfD09JyG9ipyjH3oBbnInH3Vf28mvKkJet+JUQyYO/2xCHi6fIpm/zzfnncWxWWBQOTcxgmSEyR1gWg99lEITNzzTJzYD/gIRxznZFPWgqcBjijmxwphWS9LOMNdM5jAZtTbI/dkyhlBYauvt68HxpXK906xHwSnSgd+UhE5/0OI+/5i2jt+e0Lv6XuEE7fssWX/EVLnDslP20MpQRy4duHO7F7ukKJGwZsXgI2JwlWwwI8L0LW9a6rh8EUcElzNctgt3OQoY3Tm0ap2/FM0bLs8KZ6EgQAtjh+SFJ19Az6FRjrrAcAMowvnUfHwUW2seA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
From: Martin Leduc <martin.leduc@luminator.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, Quentin Schulz
	<foss@0leil.net>, Christopher Larson <kergoth@gmail.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [EXTERNAL] Re: [bitbake-devel] bitbake addtask bbclass
 dependancies
Thread-Topic: [EXTERNAL] Re: [bitbake-devel] bitbake addtask bbclass
 dependancies
Thread-Index: AQHYH5OnchobVPUS3U6QaI8sqzFeGayP78gAgAOTRICAAC3NgIAAu0DQ
Date: Tue, 15 Feb 2022 10:23:09 +0000
Message-ID: 
 <PA4P189MB11835BAF8E9D1D510B96788B96349@PA4P189MB1183.EURP189.PROD.OUTLOOK.COM>
References: <Me0Z.1644602104245206529.KOgD@lists.openembedded.org>
	 <5689f841-7090-4141-ae31-8d02596bdad1@Spark>
	 <PA4P189MB118329A70AFDEC8C87329B6996319@PA4P189MB1183.EURP189.PROD.OUTLOOK.COM>
	 <9B73F57B-D218-4D75-95EC-6B2B9304C3B7@0leil.net>
 <9f468cec364187d1c6ac66bc2c28848a6cb625b0.camel@linuxfoundation.org>
In-Reply-To: 
 <9f468cec364187d1c6ac66bc2c28848a6cb625b0.camel@linuxfoundation.org>
Accept-Language: fr-CA, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=luminator.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2face433-f45b-4f5c-a784-08d9f06d29da
x-ms-traffictypediagnostic: PAXP189MB1743:EE_
x-microsoft-antispam-prvs: 
 <PAXP189MB1743280E793CBDE836DE390696349@PAXP189MB1743.EURP189.PROD.OUTLOOK.COM>
x-onpremisesmanualforward: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 +IONSklFbhQj6h6G7tetIwCj69+qNlCMypDa6m+v7+K6DVTQKJwpqzdto4J5qLquzsee+oWY6lbf0ozfFt8oCVDWQiMm/CKAcqR6Dokni8UuTBaGAZi7cmmoIOhkibPQifjSlNntGqz4CZHIjOjCb6NQDo4lfWYPf/T7DXUZtVlDmSxB1dvg16gesl0gCssfUOl/8kWfnPHPJTqjj17g9urzfZ//lOrQL8VMh+IAIzjmp96KfimwirQRFJuIPJqbj+XZCfIUR3oKtfkGcBffUxvuLkd5CI21eyJesXU01KFiwzDi/gnbj7iQOg3ui3w+4Sc9gth7keFRVPw/EaqlUIRbrf1YlKTgBMvwD6r8uuc3GC5gus9xodvKcqUPQsA3kJ+DfUN+M2i5uhN9HfSPGZUSNoxqBGiOi7q4/MAeSfwDgQC00fNDr45+ZHg7LLcehqIuswc6qWY6WM02S35WdIGraRAtvNoZuNroEM0MDzSoY2Oe7sTQ3QJDIeY9MCqUsCGmpDA/I0RmIQqJz3dcEosnTIp3s/xu8/KIhiAoUlKZik2J7PHFnsptI433ZAXZAc7vSYu57hlnU9i0GVU2Iofs6DkpgI8PcS96bixDySlCAIlPjP+Qy8z3e4szqXGDQw5TbJ1iKzr5EckN1gQM6pR+4uaqWAIuHME5/VjO3gxZgTIJBduKykhQ+k7E6Ri72SunTCdv6i7Q3lPcqSe2UkvHhR6mEQ7G0Vg3Jb3TbkJnA+Cmbz0QuteSFXJnWNsIUTGl9XkJH59z0L/Bn/cC8iWwkw2+JZuJIL/OYv/ja6E=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4P189MB1183.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(122000001)(8676002)(26005)(7696005)(71200400001)(186003)(9686003)(8936002)(83380400001)(6506007)(66446008)(52536014)(76116006)(38100700002)(86362001)(110136005)(64756008)(508600001)(66946007)(66556008)(66476007)(33656002)(316002)(55016003)(66574015)(40140700001)(5660300002)(44832011)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RXhZOGIvSlAyWTRVcXh6aDljczZtMEQ1ak1HRElrbnNaYW1JZi94blEyaG1D?=
 =?utf-8?B?VForOEtrZE5weUNOYm92MXhhek16cm5CVWt5YVV4TDBsNkFjOXdaU2hjVVMv?=
 =?utf-8?B?Z2dMZWdKbU5oU2dpOE9ZMGtKR283Y0VTSUpaQTlzeEJkV0tpMDdxTDU5Z3cr?=
 =?utf-8?B?SVoyVGhub0grbldEUTdQcnlKNzBlOC9lSWVRYkZtUnRDaEJjU0ZaTDZKdSsz?=
 =?utf-8?B?bmF2cXJDVmlkRGY0NHdZajBWTFQvMHRIc0JPWmRVbUZFZlI3bXg3TlZxalVl?=
 =?utf-8?B?dUZBbTZWdlZMNDVBVjBneGxyeTBKY0lVVlpwWFhPSkdpVEQ3alYzK1YwU2dk?=
 =?utf-8?B?SjdZMWdUM1RUcG11MWhjMDlIUVc0Mm1ia3psclJnb0ZYcFdSNlRlOEtURkxS?=
 =?utf-8?B?WG50QjVGdUhhaU5uZG81WGMvUTFWWDIrLzlTdXk1cngrWUc3dWNZZVRaNE42?=
 =?utf-8?B?TnFTTHVPZVVQL3NMeklESm9OdG5ZSERuK1QyakpwdDRWSzRablN3cU5BcWF6?=
 =?utf-8?B?WHg0T01Lb3ZNY050SHZCa2JxV0ZtdVI2OXB3TzdMMGVZL3BBaDk5UzFsNUF4?=
 =?utf-8?B?dmVqejBaVVpSS0V1Um4wR0pVSm9CK0ZBRFJxVWIvRHROQno1YklsWXYwY2V3?=
 =?utf-8?B?bm0zNUwrSE91N25KSDRmRGhmYUVjZjF2ckZBWC9sWm5KVURtRk1XNWE0ckRj?=
 =?utf-8?B?ejNscm5wRS9KNVRndUVSVU8rUTFSQ3Ivckw4di9lVmZ2M1k0cXJENE9Paldo?=
 =?utf-8?B?SVkveUJSUlFkK3hkVDk3M280M1UyRmFYVUhZVzVBYm54WndSZzhSTXJGWFpK?=
 =?utf-8?B?UTdYMjR2cjdHaVp4TUFkeDd1dDJxZEx1bDdMNjNKbE95R0NVZmwrSDF6cS9E?=
 =?utf-8?B?dkRmdVhaSmtNdnZrNk11U0FsYUNVZjVXRzBVcWJUK1k4bnJwb3hka0dFblZr?=
 =?utf-8?B?c2FTeDh3VE1ySURUdG55NXJmdDhFUnIrV1ZDMlUzd2JGWkswRExNWEFRY211?=
 =?utf-8?B?WFVJWDRTWGNQczNPRlc4N2s4ODU1blhzU1EzeTh0SjJCcGwxSktZVDRzalhv?=
 =?utf-8?B?a1JLL3oxMFcrVzA5TVJDSUM5RXhoL3drcWpPU1JxSTlMV2RFZDFJbUNDbHE1?=
 =?utf-8?B?UE5IM2NEY1dXRDAxODdiSlVCanEwQXc3TFJveFI1NkM1REhYcGtkcElIYUxY?=
 =?utf-8?B?RXZxMS9uTnZrL25EenpiU0NaZEhxd2k3RnU1eUtmeWdWTFZHNlZsNHFkS2gz?=
 =?utf-8?B?Z0ZiTzE4Qy9qNEhHQmcvaGs1UGYxSlpONnlNejB0bmNiZ01FZEJNWTB6WmFO?=
 =?utf-8?B?eEh0TmtPclFxNnk0R2EwQmVmRmRqQ3VVam5td3RHdVhxSm1BT1dYeG8xSkwx?=
 =?utf-8?B?UXdxcmkwb0RYZUFJcTltajBRRVZXMmRlcmJwTkwxR254bHhzMVNlYUd5Ykxh?=
 =?utf-8?B?bDc1Y2wzS1BQbHJyZUxFNTFFMnJvSjNpb1ovWFBIZmNMRkZnV2xNNGFaOGlr?=
 =?utf-8?B?dkdVRlduQkg0RXd2M2ZFUkZzQnhySnJwNVNDenplcWVnMXRxRXhNR2l4SWhO?=
 =?utf-8?B?Wk91Nzk0TWlsczN2V3FmMkR2TmlTWERNRlZLUXMvK1Q4cG5MRGN4RURqTEwv?=
 =?utf-8?B?OWlneTVSYmNROVFQUGtYZmFXU2xON0NaQ0kyQzZ6aE95WURWcm43SDJvSWw4?=
 =?utf-8?B?bjhkS2Jnc1ZhV0xJOW96WURacTIvVUM3S2xHRUdycjB2ZEdndllneWlMRmRz?=
 =?utf-8?B?TUxzdnVpZENhQmZiVUVvUFUyZW1ad1dVK2FJSnpqTVpWNm9PcU5OeUs2WjVI?=
 =?utf-8?B?RUZ6L3p0VTRFdkdGeFZsa1RuaVdJUlg3ZWZrRHIvZ3FmODBaYnpFYXFweUcy?=
 =?utf-8?B?MU1SUi82WE5rMHJmVnloR3FhaXZaWHp5YTBqQW1Fbnl4VHNNbVNXNDA5WlVo?=
 =?utf-8?B?N1BEYy9wNm0vbFJQeEJPOUNDaHpNSzhTSzI4dUhJckVnM2d5S25QZnBYSkFa?=
 =?utf-8?B?UGxqaWxRalRaSmRUSlRPYnRZRjZCRGoxckx0TXpaMGkwTUR3TkphZVZIY1BF?=
 =?utf-8?B?VWk5K1dGTVp3M0JkWXFGNG5xd04vdDZtbkJ6Q3JPKzUvU1JMemdYaHlhQnpX?=
 =?utf-8?B?SHlNR3JqMGxGTzkybGlZU1NqK2tpcm1pYmZUNUFkQlEydDBYZmpDcTVhSUxB?=
 =?utf-8?B?L1JCYmdlYWYyRE1mVllyOEpNbmdFcnJ0QktBVS9RRkVSQ1BXZmxDY1FqbVZM?=
 =?utf-8?B?YytTSjM0NGpwSlltdXRCWWhCYTVBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4P189MB1183.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2face433-f45b-4f5c-a784-08d9f06d29da
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2022 10:23:09.3464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 41cde0b0-5383-4af5-89ba-5c7361af3a57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 a7E5E+oF9lFG3wdBKi5bdWe9uJw6uQHVoVqTlKyR9DB1OEXlJkUsiBwjeCnIF5MR+jzpuDuLnc2VWadlHHX3eZePYpyFAYaz46NeW++kCQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP189MB1743
X-C2ProcessedOrg: 0aa505bc-c280-44a3-bf0b-cfdbed55e239
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 15 Feb 2022 10:23:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13350

SEkgdG8gYWxsLA0KDQpUaGFuayB5b3Ugc28gbXVjaCBmb3IgeW91ciBleHBsYW5hdGlvbnMuICBI
aXMgbmFtZSwgYml0YmFrZSwgd2FzIHdlbGwgY2hvc2VuIChiaXQgYmFrZSkuICBJIHRoaW5rIEkn
dmUgdG8gd29yayBvbiB0aGUgZGlmZmVyZW50IGZ1bmN0aW9ucyBhbmQsIEkndmUgdG8gbGVhcm4g
aW4gZGVlcCBQeXRob24uDQoNCkFnYWluLCB0aGFuayB5b3UgZ3V5J3MsIHlvdSBzb2x2ZWQgbXkg
aXNzdWVzIGFuZCBmaXggbXkgY29tcHJlaGVuc2lvbiBvZiBhbGwgb2YgdGhpcy4NCg0KQ2hlZXJz
LA0KDQpNYXJ0aW4gTGVkdWMNClTCoDogKDQxOCkgODU2LTY4OTYNCm1hcnRpbi5sZWR1Y0BsdW1p
bmF0b3IuY29tDQoNCg0KLS0tLS1NZXNzYWdlIGQnb3JpZ2luZS0tLS0tDQpEZcKgOiBSaWNoYXJk
IFB1cmRpZSA8cmljaGFyZC5wdXJkaWVAbGludXhmb3VuZGF0aW9uLm9yZz4gDQpFbnZvecOpwqA6
IDE0IGbDqXZyaWVyIDIwMjIgMTg6MTANCsOAwqA6IFF1ZW50aW4gU2NodWx6IDxmb3NzQDBsZWls
Lm5ldD47IE1hcnRpbiBMZWR1YyA8bWFydGluLmxlZHVjQGx1bWluYXRvci5jb20+OyBDaHJpc3Rv
cGhlciBMYXJzb24gPGtlcmdvdGhAZ21haWwuY29tPjsgYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVu
ZW1iZWRkZWQub3JnDQpPYmpldMKgOiBbRVhURVJOQUxdIFJlOiBbYml0YmFrZS1kZXZlbF0gYml0
YmFrZSBhZGR0YXNrIGJiY2xhc3MgZGVwZW5kYW5jaWVzDQoNCkNBVVRJT046IFRoaXMgZW1haWwg
b3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgTHVtaW5hdG9yIFRlY2hub2xvZ3kgR3JvdXAuIERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXpl
IHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCg0KT24gTW9uLCAyMDIy
LTAyLTE0IGF0IDIxOjI2ICswMTAwLCBRdWVudGluIFNjaHVseiB3cm90ZToNCj4gT24gRmVicnVh
cnkgMTIsIDIwMjIgMzowNDo0NyBQTSBHTVQrMDE6MDAsIE1hcnRpbiBMZWR1YyANCj4gPG1hcnRp
bi5sZWR1Y0BsdW1pbmF0b3IuY29tPiB3cm90ZToNCj4NCj4NCj4gPiAjMjogZG9fYnVpbGQg4oCm
ICB3aHkgZG9fYnVpbGQ/DQo+ID4gTUVHQSBNQU5VQUw6IDI3LjEuMS4NCj4gPiBkb19idWlsZMK2
PGh0dHBzOi8vd3d3LnlvY3RvcHJvamVjdC5vcmcvZG9jcy8yLjcuNC9tZWdhLW1hbnVhbC9tZWdh
LW0NCj4gPiBhbnVhbC5odG1sI3JlZi10YXNrcy1idWlsZA0KPiA+ID4NCj4gPg0KPiA+IFRoZSBk
ZWZhdWx0IHRhc2sgZm9yIGFsbCByZWNpcGVzLiBUaGlzIHRhc2sgZGVwZW5kcyBvbiBhbGwgb3Ro
ZXIgDQo+ID4gbm9ybWFsIHRhc2tzIHJlcXVpcmVkIHRvIGJ1aWxkIGEgcmVjaXBlLg0KPiA+IEkg
ZG9u4oCZdCBpbnRlbmQgdG8gYnVpbGQgYSByZWNpcGUsIG15IGludGVudGlvbiBpcyB0byBydW4g
eCBmdW5jdGlvbnMgDQo+ID4gQUZURVIgdGhlIGRvX2ltYWdlX2NvbXBsZXRlIHNvIHdoeSB0aGUg
ZG9fYnVpbGQgaXMgaW52b2tlZCBpbiB0aGF0IHNjZW5hcmlvPw0KPiA+DQo+DQo+IEFuIGltYWdl
IHJlY2lwZSBpcyBhIHJlY2lwZS4gV2hlbiB5b3UgcnVuOg0KPiBiaXRiYWtlIG15aW1hZ2UtcmVj
aXBlDQo+IHlvdSdyZSBidWlsZGluZyBhIHJlY2lwZS4gQW4gaW1hZ2UgcmVjaXBlLiBZb3UncmUg
YWxzbyBhY3R1YWxseSANCj4gcnVubmluZyB0aGUgZG9fYnVpbGQgdGFzayBvZiBteWltYWdlLXJl
Y2lwZS4gV2hpY2ggaW4gdHVybnMgbWFrZSANCj4gQml0YmFrZSBydW4gYWxsIGRlcGVuZGVuY2ll
cyBvZiBkb19idWlsZCBvZiB0aGF0IGltYWdlIHJlY2lwZS4gU2luY2UgDQo+IGRvX2ltYWdlX2Nv
bXBsZXRlIGlzIGEgZGVwZW5kZW5jeSBvZiBkb19idWlsZCwgaXQnbGwgZ2V0IHJ1bi4gSG93ZXZl
ciwgDQo+IHlvdXIgY3VzdG9tIHRhc2ssIGlzIG5vdCBhIGRlcGVuZGVuY3kgb2YgZG9fYnVpbGQu
IEluc3RlYWQgaXQgaGFzIGEgZGVwZW5kZW5jeSBvZiBkb19pbWFnZV9jb21wbGV0ZS4NCj4gSWYg
eW91IHdhbnQgaXQgdG8gcnVuIHlvdSBuZWVkIHRvIGVpdGhlciBydW4gaXQgZGlyZWN0bHksIG9y
IGFkZCBpdCB0byANCj4gYSB0YXNrIHRoYXQgaXMgYSBkZXBlbmRlbmN5IG9mIHRoZSB0YXNrIHlv
dSdyZSBydW5uaW5nICh1c3VhbGx5IA0KPiBkb19idWlsZCBhdCB0aGUgdmVyeQ0KPiBsZWFzdCkg
b3IgeW91IG1ha2UgaXQgYSBkaXJlY3QgZGVwZW5kZW5jeSBvZiB0aGlzIHRhc2suDQo+DQo+IFRo
ZSBhZnRlciBhbmQgYmVmb3JlIHdvcmRzIGRvIG5vdCBjb252ZXkgdGhlIHNhbWUgbWVhbmluZyBp
biBFbmdsaXNoIA0KPiB0aGFuIGl0IGRvZXMgaW4gQml0YmFrZS4NCj4NCj4gUmVwbGFjZSAiYWZ0
ZXIiIGJ5ICJkZXBlbmRzIG9uIiBhbmQgImJlZm9yZSIgYnkgImlzIGRlcGVuZGVkIG9uIGJ5Iiwg
DQo+IHRoYXQgbWlnaHQgaGVscCB0byBkcmF3IHRoZSBwaWN0dXJlIGluIHlvdXIgbWluZCBvZiB0
aG9zZSBkZXBlbmRlbmNpZXMgDQo+IGFuZCBob3cgdGhleSBpbnRlcmFjdCB3aXRoIGVhY2ggb3Ro
ZXIuDQoNClB1dCBhbm90aGVyIHdheSwgeW91IHJlcXVlc3RlZCAiYWZ0ZXIgZG9faW1hZ2VfY29t
cGxldGUiIGJ1dCB5b3UgZGlkbid0IHNwZWNpZnkgaXQgaGFkIHRvIHJ1biBiZWZvcmUgYW55IG90
aGVyIHRhc2suIFRoaXMgbWVhbnMgaXQgZW5kcyB1cCBhcyBhbiBlbmRwb2ludCBvbiB0aGUgdGFz
ayBncmFwaCBhbmQgdGhlIG9ubHkgd2F5IHRvIHJ1biBpdCBpcyB0byBjYWxsIGl0IGRpcmVjdGx5
LiBTb21ldGltZXMgdGhpcyBpcyB3aGF0IHlvdSBuZWVkL3dhbnQuDQoNClRoZSBkZWZhdWx0IHRh
c2sgaXMgImRvX2J1aWxkIiBzbyAiYml0YmFrZSBzb21lLWltYWdlIiBpcyByZWFsbHkgImJpdGJh
a2UgLWMgYnVpbGQgc29tZS1pbWFnZSIuIElmIHlvdSB3YW50IHRoZSB0YXNrIHRvIHJ1biBhcyBw
YXJ0IG9mIHRoZSBkZWZhdWx0IGJ1aWxkLCB5b3UnZCBzcGVjaWZ5ICJiZWZvcmUgZG9fYnVpbGQi
IGFzIHdlbGwgYXMgdGhlIGFmdGVyIGNvbnN0cmFpbnQuDQoNCkNoZWVycywNCg0KUmljaGFyZA0K
DQoNCg0K

