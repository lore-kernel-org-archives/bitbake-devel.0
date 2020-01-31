Return-Path: <rasmus.villemoes@prevas.dk>
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
	(mail-eopbgr60113.outbound.protection.outlook.com [40.107.6.113])
	by mail.openembedded.org (Postfix) with ESMTP id 9A93A60639
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jan 2020 09:43:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=PcLfJmJF5YcFx88W3y9D8soj50qFYvIC6H06mapg8/gFMMYKDLeDQUKy7QJZ1d6UHOASGjn8JiDB6CW63WFgMZTRc/LiKWy7/34k98dNxo1bLVMVCvCCyCE2udKI75AyFY2k3qNHtlxx1nlXCcR1s22GWVv92WFb0PLGIeRl9GIBXZpLxE3hHS41ysbWfeKRcasZj03dyxfQll4SlAaDqId2KU57s+szudYtJfUr7AWONFe10b1hkzejbb3xBCEc2TKG3pBAsCy0ZjA+WITPkIrat8gFBuMpk1qrZBYyRvdAxzgLRSYV88imLQ2VYT0F/8oR4gaz4q1ssM6ftd2NKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=9i+tjmijWwjvTiR1FpDCvSVVJTUiShp6WjzkKUtOgHc=;
	b=HbZEtDjky9FojDa/b9uVgXg/g+uVDWf5ZKD7tPzAwQOlHNog59hkzQMqUdoCwIsU3S4M+VtGr+suAaSmNFCTv5fbONsJwAtdcXqhUlhfzsYs54D/N+ZgNvmzTtcTn/YA7PN5euPcEJcZ6wnPju9GMSkys1hr4Gf7WKv93XoZRhN1LYnSDg5obAM1tIL/1MVluoSlV+AHuhbay9yuK4Oc2yy/kee/TJTX5+bTeuyozu3yuPEklqFiw4oYcJsGCO48Smbv8+qoTq1C4G5hNB25AsoFJXAJcrk5AXy05Itb9CkaUYbGrrbX3aIBaf8YfJJ/8JslORE7GSjJROFugkVvjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
	smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk; 
	dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=9i+tjmijWwjvTiR1FpDCvSVVJTUiShp6WjzkKUtOgHc=;
	b=JAEDlKzCxz3F0mB+3CvsyC2I+W3c6fT9RSS2uxioXQF47bAy6S4YaXjT+FbBtpHxxODcUhnDfsC7dU2RdrTFyvk0Z+n3iyMqPcmYa76H0iVx4Y68Y1Ab1dyCPDsO+kmYQywiUwbjw9qzfnZjVBD10rrv2Pn4+5tGv7DwmyLbZQY=
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM (20.178.126.85) by
	VI1PR10MB2381.EURPRD10.PROD.OUTLOOK.COM (20.177.62.97) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.2686.27; Fri, 31 Jan 2020 09:42:59 +0000
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
	([fe80::8175:5aa2:2870:766d]) by
	VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
	([fe80::8175:5aa2:2870:766d%6]) with mapi id 15.20.2665.027;
	Fri, 31 Jan 2020 09:42:59 +0000
Received: from [172.16.11.50] (81.216.59.226) by
	HE1PR0402CA0041.eurprd04.prod.outlook.com (2603:10a6:7:7c::30)
	with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29
	via Frontend Transport; Fri, 31 Jan 2020 09:42:58 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH v2] build.py: record time spent executing each function
Thread-Index: AQHV0DnspRRJEQaaikilhMpKPfiqoagElS0A
Date: Fri, 31 Jan 2020 09:42:59 +0000
Message-ID: <aa4d6ac4-279f-1baf-bb63-8a59d864d16f@prevas.dk>
References: <20200118223705.17230-1-rasmus.villemoes@prevas.dk>
	<20200121090519.24674-1-rasmus.villemoes@prevas.dk>
In-Reply-To: <20200121090519.24674-1-rasmus.villemoes@prevas.dk>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0402CA0041.eurprd04.prod.outlook.com
	(2603:10a6:7:7c::30) To VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
	(2603:10a6:803:e1::21)
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=rasmus.villemoes@prevas.dk; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.216.59.226]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b80b1a81-560b-4697-55d1-08d7a631f516
x-ms-traffictypediagnostic: VI1PR10MB2381:
x-microsoft-antispam-prvs: <VI1PR10MB2381962F3F8E870FBCAFC91193070@VI1PR10MB2381.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 029976C540
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(376002)(39840400004)(346002)(136003)(396003)(366004)(189003)(199004)(2616005)(956004)(52116002)(2906002)(36756003)(86362001)(8936002)(64756008)(6486002)(44832011)(16526019)(71200400001)(186003)(31696002)(4744005)(6916009)(54906003)(26005)(316002)(16576012)(478600001)(31686004)(5660300002)(4326008)(66946007)(66446008)(66476007)(66556008)(8676002)(81156014)(81166006)(8976002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR10MB2381;
	H:VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: prevas.dk does not designate
	permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LxD3OooFDWedTrpaL1Eomldpnp/3HuQK72HOJEQiTLfm4r5FxxYPOVSPkZYv5QO8jcVQC+kLUi9XJUOqpI9L+Nf9+aOpfJRMTI4yGaKiSHiZwwJNdhOFpOpIm1Tp6dMfJu8azqdyIv3W8QS9bHqfumZGduNa5fksYyFW97xp7O3Uu44TYWmQ3/S1cah2THOQz0dgm6XxhUI/A+UZvWVSE55kfGKt+yNqz3DATbtFF6ZRqKVdLRsavpobRzMS+IyoKNKEHVRHUGMaJns6N/Oa+18j2kMA6T2ylZhSjV+Nonijew3c86SvUSOnei22Of05PYlbQspPQdITE4TVuHpkX/MzoV9ZTPYNeEH3PaviJMnAk/BsblVuczKdvW5DvJGD7gD1e00KezKP/QnSwIx54r7ZoE/kU5k9VzICbW/jMJ0/bd6DOpVBebNVSyYJwKoP
x-ms-exchange-antispam-messagedata: p77JUIXojJngiOeNdSz38Xwk30nGYJ0ybtRpEEcn+gFLkVCZ3YhshCWiOvEO2Gwso7yAd8Px5V65YR4g4cF0JO8EU+rPRbiDgNQMAuFLUdtxjJ/1TvJ72XBNWPX3UnRB5tG/pTMaj8/PVjqN9JoFKg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: b80b1a81-560b-4697-55d1-08d7a631f516
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2020 09:42:59.3403 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jSAYBNssoGNZXo921Yx0K5gkblPRsIPWjz7Astbd6vlxllF7Q4yZ/frZJL5+aHFKgWlEY0984ecANkI890q2nRi6nXXWP/sbPhg78MISTIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2381
Subject: Re: [PATCH v2] build.py: record time spent executing each function
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
X-List-Received-Date: Fri, 31 Jan 2020 09:43:01 -0000
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <16070185283BEE4185B0C6B66776BD4E@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable

On 21/01/2020 10.05, Rasmus Villemoes wrote:
> In order to have a quick way to see if optimizing some task function
> actually has an effect, append a little information to each
> "Python/Shell function foo finished" line listing the wallclock,
> system and user time spent.=20

Can I ask for a ack/nak on this, and if nak, is there some way this
could happen on opt-in basis (bitbake cmdline or some setting in
local.conf)?

Rasmus

