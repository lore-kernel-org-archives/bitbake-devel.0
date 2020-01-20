Return-Path: <rasmus.villemoes@prevas.dk>
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
	(mail-db8eur05on2090.outbound.protection.outlook.com [40.107.20.90])
	by mail.openembedded.org (Postfix) with ESMTP id 363197F7B1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2020 07:39:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=P+Zy3dvC0QybWY+pTF6oRFaQOSv5Gz44dOaZ+jqhmkOaqQrpDiiL/pkfIqhMGbqWNOJkOrKwNTY8g1vyOUv/BplwWIjtqq7BwUSE/9wnxkR6WWLSJPneXUpBa8Vf6GAoOyZ9/n+z33PsxxBGT3i39k+L2Uynekv0/v7iChMPSPKxve33nWfb40vygOuqH+ueSkbVXk0EOLFpme6GmVuRTXKYHuqekyUi5PIS5P+1Bo5wU//In1802Z/7d9d4g9F8EpQyJrVl+HEZvlP5WKhXUtatwhkt47L0Wu1gXM6ba1mg2a5SLm03vI6KTQWQese0IgFZ0ZdxAB26UCMn5ykOHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=7npeznZkCUI+ooumTGxl40Mm8Lvz5JwUV/Gawq6ftvQ=;
	b=fRTwuMERCxHldMpuzVKWblxprMSIGVm1jSLcm7BNwI1wRqo04TmQbKzg97ND66R69Ac6+VpNHlVYcoDrpAfdlZb0LZk+WeylcmaE7d2vzfnW82jArX7n2GntBY9Z6NOI+gdYnamyfl7BtAIBBibQkF+udGKIoUm4pNAQXLgytZtL22q6y7S//7Y7lUJOg3NZNqcEM5vhuucIc0kLw/FH207TVNFO05ydoApj5Ijn/uXeW166JGJrac3IXxJJDHPPF5SbePv7+/fEdYo/kENcGaMSBNmrQfIQfxgcpaOFyrYRcj4ayx+dsMrHxU9vU5Cca6zHxq3IieaIYLlpywe2UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk; 
	dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=7npeznZkCUI+ooumTGxl40Mm8Lvz5JwUV/Gawq6ftvQ=;
	b=IwmI3gmUuHbLTW3IildFipy67PQdwk4yljsx2J/ivz06SQXYg47mHeWnfN3SsJgWZWDOdqhxpWDNJNld/wVpGdAnSDfaUFsCm3Onbx/z3NTDhUd3Rg5lRkax7AJm7hKMuBxclFWz8vljQWsnsCHCwdoOAKsbVEOxzYfHhYYS58c=
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM (20.178.126.85) by
	VI1PR10MB2575.EURPRD10.PROD.OUTLOOK.COM (20.178.127.221) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2644.24; Mon, 20 Jan 2020 07:39:05 +0000
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
	([fe80::8175:5aa2:2870:766d]) by
	VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
	([fe80::8175:5aa2:2870:766d%6]) with mapi id 15.20.2644.026;
	Mon, 20 Jan 2020 07:39:05 +0000
Received: from [172.16.11.50] (81.216.59.226) by
	HE1PR0901CA0049.eurprd09.prod.outlook.com (2603:10a6:3:45::17)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20
	via Frontend Transport; Mon, 20 Jan 2020 07:39:05 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] build.py: record time spent executing each function
Thread-Index: AQHVzk/UviyzOepWnki5zcAR3u5NfKfxP3sAgAHtRIA=
Date: Mon, 20 Jan 2020 07:39:05 +0000
Message-ID: <7a8eddab-af95-21b2-6392-aab5c8ed7348@prevas.dk>
References: <20200118223705.17230-1-rasmus.villemoes@prevas.dk>
	<CY4PR12MB1653C176011A53D5E6A523568B330@CY4PR12MB1653.namprd12.prod.outlook.com>
In-Reply-To: <CY4PR12MB1653C176011A53D5E6A523568B330@CY4PR12MB1653.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0901CA0049.eurprd09.prod.outlook.com
	(2603:10a6:3:45::17) To VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
	(2603:10a6:803:e1::21)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=rasmus.villemoes@prevas.dk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6349b493-4c9e-4fcf-7904-08d79d7bd3d7
x-ms-traffictypediagnostic: VI1PR10MB2575:
x-microsoft-antispam-prvs: <VI1PR10MB25750BAB06AAB8B0B2C1C22C93320@VI1PR10MB2575.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(366004)(396003)(376002)(39840400004)(346002)(136003)(199004)(189003)(52116002)(26005)(2906002)(478600001)(16526019)(186003)(4744005)(5660300002)(4326008)(110136005)(8936002)(86362001)(2616005)(8676002)(31686004)(81166006)(16576012)(81156014)(71200400001)(66476007)(8976002)(31696002)(316002)(66946007)(36756003)(66556008)(64756008)(44832011)(66446008)(6486002)(956004);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR10MB2575;
	H:VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: prevas.dk does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M4eQEyB32dZ7QyOstRj4vO8p/QkAGmbUXbSXoePnUBZT591NDulIv5bcK8BN1vurqoIyigR577YYK8WtMYk7QZ00qO4cZ4SPntbXr0B/TYqpn8bIdL1mtFNemSfiC63DHvovNSYhVETyCw9yPliJtnarypXk6vz0ut4Qyy5yhToFkouFTrknT6wvZ4FgmEAiBlLAGbIAMqx/G3msJQbG7Vht4FLtk+rftGpxl593w19YI9gsRyGSWrftHkF5zydgHT/h1MSH0E93w8ozTYLBUlzfhRGNOcCPcZixM+bTnHzuiCKbJ81vAlKQJKNgwy8is20bNu1gyW89f86k4Nvyy0WLwp0wTKlPW5UGjRtcEc0fFX8PgTiX33O90LXZ5IYDJAgxC2Al6pJlgrnfA1KV5NhjFcD7Q3gS1XX2GEvGHAUPmAPDNblDvHHMyRWULA4u
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 6349b493-4c9e-4fcf-7904-08d79d7bd3d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 07:39:05.8195 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8fltl5UOcVQGSZLefd00Ecx0a1lTk+50R5ZvLxK2VdkO9xe/Y9N2hecHTV5uNeTJD3HPJBdNiIqCFUOsZocv6++KFu1a1llXrHn5wtoxAE0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2575
Subject: Re: [PATCH] build.py: record time spent executing each function
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
X-List-Received-Date: Mon, 20 Jan 2020 07:39:06 -0000
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <C2716AC08D689D4794AC9BCFD16BD690@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable

On 19/01/2020 03.14, chris.laplante@agilent.com wrote:

> Not sure why you sent this to me, to be honest.=20

Lacking something like scripts/get_maintainer, I resorted to cc'ing the
last few people to touch that file.

> But while I'm here... I don't think using variable names like "self" and =
"sys" is a good idea in Python. May lead to confusion.

Yeah, agreed. I'll find something better. Naming in CS and all that...

Thanks,
Rasmus

