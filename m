Return-Path: <kweihmann@phoenixcontact.com>
X-Greylist: delayed 17900 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 15 Jan 2019 21:48:04 UTC
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
	(mail-eopbgr60044.outbound.protection.outlook.com [40.107.6.44])
	by mail.openembedded.org (Postfix) with ESMTP id 628156C497
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Jan 2019 21:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=phoenixcontact.onmicrosoft.com; s=selector1-phoenixcontact-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=xdSGELCRJi+/0gkAnxjKljqFpYFrZBiPl9BiVPtGXbs=;
	b=LbneQ/1zSWCBl9G1mXtxt/B57hJl57mVRXtunAF9PC1Gcyr144xVVHGSLtAaF0DQQ9uf4wRqD/dMGk1dcA1dI6w78TuDFZD4rmlR55EmhGfP0OEPHGxVJMRk+JY8jsaLhRqE3wXMNJD2lSNvAC9wwvhonrc9d9azPrPt3Ovr6CA=
Received: from HE1PR05CA0138.eurprd05.prod.outlook.com (2603:10a6:7:28::25) by
	AM0PR05MB5762.eurprd05.prod.outlook.com (2603:10a6:208:11c::27) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1516.18;
	Mon, 14 Jan 2019 10:09:24 +0000
Received: from DB3EUR04FT022.eop-eur04.prod.protection.outlook.com
	(2a01:111:f400:7e0c::208) by HE1PR05CA0138.outlook.office365.com
	(2603:10a6:7:28::25) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1516.14 via
	Frontend Transport; Mon, 14 Jan 2019 10:09:23 +0000
Authentication-Results: spf=none (sender IP is 51.136.18.164)
	smtp.mailfrom=phoenixcontact.com; lists.openembedded.org;
	dkim=fail (body hash did not verify)
	header.d=phoenixcontact.onmicrosoft.com; lists.openembedded.org;
	dmarc=none action=none header.from=phoenixcontact.com;
Received-SPF: None (protection.outlook.com: phoenixcontact.com does not
	designate permitted sender hosts)
Received: from azr-iqsuite11 (51.136.18.164) by
	DB3EUR04FT022.mail.protection.outlook.com (10.152.25.29) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1471.13 via Frontend Transport; Mon, 14 Jan 2019 10:09:23 +0000
Received: from mail pickup service by azr-iqsuite11 with Microsoft SMTPSVC;
	Mon, 14 Jan 2019 11:09:23 +0100
Received: from EUR03-AM5-obe.outbound.protection.outlook.com ([104.47.8.54])
	by azr-iqsuite11 over TLS secured channel with Microsoft
	SMTPSVC(10.0.14393.0); Mon, 14 Jan 2019 11:09:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=phoenixcontact.onmicrosoft.com; s=selector1-phoenixcontact-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=eamqgvQdP6nmdpDV5TJFz229G5CuAA0uKiHEA2BYS+I=;
	b=jr60vK8opkRdB/LtnwK9gaWMmWk17F+zW65tCICsJiX1Gf8/e8OlNyjgeNna+NTC1dB2XFE6LkSKZuAfApQSdWEpX0zXXJIzG4mH0v2UYiQlCYW4V8MGU/Up/RQHL7wLseq8dVzqQEe0tFYDm5iwyBrQ27NhdpN0QyRCWv1Zbc8=
Received: from AM6PR05MB4295.eurprd05.prod.outlook.com (52.135.161.160) by
	AM6PR05MB4390.eurprd05.prod.outlook.com (52.135.162.31) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1516.13; Mon, 14 Jan 2019 10:09:21 +0000
Received: from AM6PR05MB4295.eurprd05.prod.outlook.com
	([fe80::d1ab:8900:3728:4598]) by
	AM6PR05MB4295.eurprd05.prod.outlook.com
	([fe80::d1ab:8900:3728:4598%4]) with mapi id 15.20.1516.019;
	Mon, 14 Jan 2019 10:09:21 +0000
From: Konrad Weihmann <kweihmann@phoenixcontact.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH] fetch2: probe for branches on version check
Thread-Index: AQHUq/DUevRtEtMNGkC+rGxT73PeUQ==
Date: Mon, 14 Jan 2019 10:09:21 +0000
Message-ID: <AM6PR05MB4295F10BC56816A25BB85150CC800@AM6PR05MB4295.eurprd05.prod.outlook.com>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: spf=none (sender IP is )
	smtp.mailfrom=kweihmann@phoenixcontact.com; 
x-originating-ip: [77.245.32.76]
x-ms-publictraffictype: Email
X-Microsoft-Exchange-Diagnostics-untrusted: 1; AM6PR05MB4390;
	6:F5uzj5TmND7eOuFefaQtRp6iaesUWc6EVc7KN2bvNIa6Fgggtak3a7qtvD4Lrw2As3YxZVPldkkYqTUghyopNLe434Jf9ly9+n6o807eosxmyo72YIR1kAaqLmtXo0XD/O2xjnsPOF8vyu3mq1GhhIBUwb8BpWP5a7+s/SwngW45waNpIh4r8MWrZzQzmsmc1CD6Ci9thcJmoZGZWgWDTWa4P7iD1moHjDwFJSCclPt7GYazG6nsMLrJZ9MxZoMzZRaIOgrHiGRbYeYVZpLl1IwB2vX9vnQFzzOFTFwBL4B3OFOp1lDD3SXjHvWi9lpCPBW4a345tCZMcGxiE6d/kNLnJq5zc2tKV2I2CnzBYB4csqYcTNON/0Qgw096brwTuw8H1ayy8sXVcuytOB82yPzdSj+l8URGy8/lcdOi8q7YTW25OCrAYudBwAkzVoPwxWmG3QTMGSG8jpvRmgiC6A==;
	5:6k08oyGGsLgmg+ssFM24NAGaiqkS9kXjI0PfnQzlP6Jus+f6HKSp2P4/YzPfTKZbR9kc3yCA7mUBe6P6lIq8tpU/6LGoTeXM7qKF1wB7ktWnzzer+ypwneDN7LS9HiGbTKcEd4TyhCxwbSBrRh3LTe49067RWk0fR/QuChH9KC2QAVvSkfp91Z2ZyFIpvurPeTgw5lcGTRK6tZ4gQbgHwA==;
	7:zYaTwgmoJIun/JfeKHS+LpzhYwhF+2gVyR1NTYej1PGEnYLAlyfFOUV2eWZxcvc1eWu1/Pq9m1Ns1yTz2U9odR7+mkG3hHMdBfLVLCJ/Q31T8rBjYbitLmVfvPGcQ+23jxaTELPj6/LkxaNjnQ+Cxw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
X-MS-Office365-Filtering-Correlation-Id: 7508e930-b267-400c-e1bb-08d67a085bb0
X-Microsoft-Antispam-Untrusted: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);
	SRVR:AM6PR05MB4390; 
X-MS-TrafficTypeDiagnostic: AM6PR05MB4390:|AM6PR05MB4390:|AM0PR05MB5762:
x-ld-processed: 6868843b-f012-4c95-a18e-bab826cca9ac,ExtAddr
X-Microsoft-Antispam-PRVS: <AM0PR05MB5762DC89259D88F512F52D17CC800@AM0PR05MB5762.eurprd05.prod.outlook.com>
x-forefront-prvs: 0917DFAC67
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;
	SFS:(10009020)(376002)(366004)(346002)(39850400004)(136003)(396003)(199004)(189003)(7696005)(71200400001)(19627405001)(71190400001)(6916009)(6606003)(99286004)(53546011)(6506007)(8676002)(8936002)(486006)(74316002)(66066001)(2351001)(105586002)(68736007)(106356001)(5660300001)(102836004)(7736002)(6116002)(3846002)(86362001)(2501003)(476003)(26005)(478600001)(97736004)(25786009)(2906002)(55016002)(6436002)(14454004)(53336002)(53936002)(186003)(256004)(81156014)(81166006)(316002)(9686003)(33656002)(5640700003)(54896002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM6PR05MB4390;
	H:AM6PR05MB4295.eurprd05.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: phoenixcontact.com does not
	designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info-Original: M+TweBUtGM8QAitpNDAHm4SYbvH2gMHwXWg1/ofALK4JKa8EULETXbx6FNE25GX1uEs21+aoO7WheZSvadd74wGgBRD4Ck5SJShHPuQR3Rbs0v6n+y6GjPt9/f58yRPdbw6+lDlDFs+3HyVNj/PfRJ3N7a9v8unzY3b20DzdmSkJtzO7P1JHDoeyUAZSAT4jl7q0vkWClScbk6U/Q4lGVMeKK+SKgFNR6c2kOYg363iAA+/yfAX5hnsmImSaFh5vJpzvRxamNESnf0X6TrO2SGtpJdtKl82j3oK+vkBItv7W3cdHdO9TAvMvG57miGDvfGGTElRhcZWXSQH5Jssoi22dR4BZInVSxOXrd4k2R6OfK4UzNx7ESL4b4PPfsuUfaCGpLzdhWi7Gq8HqXQkdqX6Mzg+nGtcAcdpulsbiyT4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB4390
X-OriginalArrivalTime: 14 Jan 2019 10:09:22.0881 (UTC)
	FILETIME=[38C9E310:01D4ABF1]
X-GBS-PROC: k7BRzbpU//IoBiUoohvGGFo+1yRb5w3Z8pJG8OiDZcDy3/8lTvvlLKaMN3mt3jmz
X-GRP-TAN: azr-iqsuite11@6AB6B20147614558B4236C9D66695AF4
X-iqsuite-process: processed
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3EUR04FT022.eop-eur04.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:51.136.18.164; IPV:NLI; CTRY:GB; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(376002)(136003)(39850400004)(396003)(346002)(2980300002)(428003)(199004)(189003)(126002)(81156014)(36906005)(16586007)(54896002)(9686003)(316002)(476003)(5640700003)(86362001)(33656002)(61614004)(81166006)(105586002)(53936002)(55016002)(19627405001)(14454004)(14444005)(2351001)(66574012)(478600001)(8676002)(106466001)(8936002)(84326002)(2906002)(2501003)(6916009)(5660300001)(486006)(186003)(26005)(71190400001)(68736007)(3846002)(74316002)(7736002)(336012)(99286004)(7696005)(6116002)(102836004)(356004)(97736004)(66066001)(6506007)(53546011)(25786009)(107986001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM0PR05MB5762; H:azr-iqsuite11;
	FPR:; SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-Microsoft-Exchange-Diagnostics: 1; DB3EUR04FT022;
	1:+flOrAG/2c9a0L18jSpQ7BH9Z0wW/XRrEfIcSVSpjWZ7IitFc96bt9KG25kkwqhoj2eKA46J1jfaver5ZI7Anz07zgFobjnKS/yr7k9Ta1iqGvSIk9I8YSYUJF2dbZH4
X-MS-Office365-Filtering-Correlation-Id-Prvs: da4834bf-064d-4b3b-bba1-08d67a085a95
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(710020)(711020)(2017052603328)(7153060)(7193020);
	SRVR:AM0PR05MB5762; 
X-Microsoft-Exchange-Diagnostics: 1; AM0PR05MB5762;
	3:j+8h5QDKVVaLEqOf83Vh5zt6ckfZoWlrC9cy6OD1ZDMUe76VhkRvcRqYGzKtcZ4E3vhyNiB5sUQQhfrkCIUu3PMKnJ/hU+L/3mAkvo8JttYTGmCgapc9UdRuW7r7d4ouAqmyk87C6Ss8SS4pQu1Dp0mwPCCZ6R+Oz6EdQwCPNb5IwScnpEgHDQGzrX8A0k2AY705+FbehUgj5sU8fyOxWmTuwsMfivgf9w3gIHbxRQJhyP/dcAgQ2N8ibtsgDqTuYPmBgawjgtt6FCaFvo+S9ER1Dd8y7YmB6wsvO8e95FP8PfBSZpGP1kgNW2owRWFqZJaY4IT609eWHUhciqcjWte4+j42jIl8IQtcbdfduzsiFTD8cctIx6bO4syBGdbn;
	25:Kp2XYYflJ4xNREAdSjXz5P4ErAWNTTY9RDfp7PAWFwLn57gaNGWh/omOyb66Q13S/cPoz0XkfeEXKUd1wB4ASfSV+MHsAiLJwdjnRni2xn/AkMDxZlocsIn1SXYc7TcUYiozYELqv5uJyFKuj6MwOzvz/WDFwjApAcCroTIMrb6+rRFvmCxOfECConhqogAU0AY+ts4HglzYYYNSVhD0lAPzk9XzH9raZiGfW6jMGBDMVktIEwx43CHwdjxYDnEICgLOduF5XTxhPjXEBLEhn81DpKj9Oa0jcltgXt12gAo3qe4BWrYkGY8XMwTQKtEAVtojdPdKtnBNBo6c4tFUCw==
X-Microsoft-Exchange-Diagnostics: 1; AM0PR05MB5762;
	31:I7BeUe4n/jfGCJzyQAwrivKO92WsGLh7jlEgw8C457AocAm1P5w96gXhp6J2g19JflZl2fU9qGM5Z+OfexytAf4UTd491Dv3LLL6UmuxnXx8uQD7uAHWf1lS9aaIz4twmpZqVoptsJ1vRMThOa8efcM3HAJPSyVSiLU2weAkWiBJr7M1fkWzO94iMWg8bob8K4oOHIOgXDxGmEYL77oVa6G+HrvP5z8CnfVYEHQYUGU=;
	20:PvKwdnkrvW29SRKze6t+kTFLET6ykx1jbD8xJRIyguSx+3DOLi6bMkXJ9t2BKbf0GEus69+3a+YRWNqCqmDvTN2oOT+g1KPZqaoCdyXQVAdXc5/2GjRCOS5SXdNnjLPOHp+qG45sKXv9+OnmmvDGjmcZ82NZ9zbsF+7/p0iHGep9qaN52V5+Bkc/AkWIxxjLQn3Umi0wyK6e7yPYuLMtsvpHVCtbGxDdbK/KBulo6lz92nE0sSQ5ond4SxgxxSBHixlulctITSZvDN67qyechFMleoLcGP0KHag0MJpatX6CcDebw41gWzhJRbQJQfqB/w3cnnPx+BzHcULGMgCuiHXc1hTxfzNwIhu7IniKMMbsyhWLlo5RaxEsux1SJxMZxE4Fvo0L85yIlgI2kgHKTYNRQtbmkBvcNCyOobPI/Oz1ivsT0iqvHjSLkEmyzC4c5Fjr8nhCY6C/rtbaD+IUN4A5sU3HFAY59GmMg2RUqeSgWjPVDnsmU9T+fNzQb5DO0kgVSY6wzaBHsw+VL91VPA==
X-Microsoft-Exchange-Diagnostics: 1; AM0PR05MB5762;
	4:VxBsWjify3rLx5oEIdM/zD/GfDlGZ2j3UGAU/7WHcFmN0d/Bd9FxTYO+0Y4MSun4Tt1GnX7Wq94fADK1Yn+0X/sr7GMdLuUF4xKbPIpWy/Ku05pNQAb7LVzUpJD96aXVRyYea3AGzAC/xPyRrFHLeFlTGAHWsMMcHx5s80vsEbqjGNtF79ziIHvSQf6u46aKlHto2entX/44WerUXiecVlIDNOO6DYp8cBNGzz6xKzq37rjiAm4VVjvhB3XZLnS+I27PaAv02jHLMpSO61DO635tg+QheWGONLEoiv7r27hcB4hNV8D4xrGxUmkHpWjO
X-Forefront-PRVS: 0917DFAC67
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; AM0PR05MB5762;
	23:RLRVvTfuKJAWgfc/NfsNRWdJqb9hBv6LTxbLKuj44?=
	=?us-ascii?Q?UV6hYqD8k98Elv1PbtjYIDgwaKJszAO913MdRH1QmThD7q8cVnNaGMuBLCL2?=
	=?us-ascii?Q?voqO5rmADoIL1PLXyzb1gbtofwfoFhZh+9NPu5LGU71S7XAq5MDBxpIeAH29?=
	=?us-ascii?Q?YE20ZPeEW5z60uIRasq/CK9V7HWF2OfoZhwJSR5LbIh8XZCmcm6GUiOtyp71?=
	=?us-ascii?Q?nGLxNn1zx0bQeB3Y+klSApaW9YieLZ8UIkdpao+U/U9FJiBBBO8WISMRBex5?=
	=?us-ascii?Q?CDijYV/coxQrQqBYwd0hyh1wcyKvykUUfBaQtS6GjZGojhlb2U/C7Tvs2f5a?=
	=?us-ascii?Q?k+EmFTkRPz/JlHUbYfOzuCQ47SLsWTH3prxwgtHBMUQCnbyEPSkjco5q/RWb?=
	=?us-ascii?Q?logesAelnGh4LCU8EHu16yrA9ILJTWDXwfhJzldBLDM0fgi/TJMz993Xu1oo?=
	=?us-ascii?Q?0YKQbX7imN4LzKIUGvFXq+uVryGaoTY74W55AlCobPfyRbkrzQDbG3EBythw?=
	=?us-ascii?Q?evY1p22EyAtfKYNt/zSr4vzoViiteblkDzteIzOCNe8la28q9lFwn1o6eHsl?=
	=?us-ascii?Q?mysyJGPJDRTqwi1DqTWIi3Fc25u4sqXQJPFzdmL4VEpm3McSe/zDHIfJKepY?=
	=?us-ascii?Q?wKkE/RHZAsZI69tnISI8urw4M0KO/QRNjgPc6gzDdLqGd1LfVdcoi28NlAS+?=
	=?us-ascii?Q?ZN65Ee+YN+BVPcOCEb8zKZPOtkC5NBxeFngytgc2rrKX0abpy/fLV/6mHzhJ?=
	=?us-ascii?Q?jyzU+tj2CoeXZxWZJuwINRip+x4WvKdxJJHCdsRtty7sSaWRpgQeYiLc1qKk?=
	=?us-ascii?Q?Eo3MTGaLRhkcXYS7zhvl52exdWeVdWQfUDvKgwG+pA54EVYlYfvJbpzdOEku?=
	=?us-ascii?Q?Vvaz87EuLjdjpxoPEHVna1SFGXvOKJwGEOzxlnbL9AVKajaAPKE91tbRSKuh?=
	=?us-ascii?Q?x0vvVF5guRRGE2+/9KBFmj5Tjy7IvrzLYRLpcGMAOuTLyBYjhdlRQU0NXKSJ?=
	=?us-ascii?Q?Tzeku27bet7pliHiEHGfmbD/K+p/GJixJ/rsLhXIJfYpkgd/HJTzSGdTbjse?=
	=?us-ascii?Q?X6tJ+xIR5t6xFGbBv5AL7WYSquceUNQSKEH/qkzmCXcI3RwQH+lHuHFlCMIh?=
	=?us-ascii?Q?iId7JDnNzCnlSqCEsyOTe0CghlTzVAb9rHpvkDfqkUwOn/rqsjNCLnOVIiQK?=
	=?us-ascii?Q?IlzYuuD3JtLysqFMYw4U15TA4soSVpe/NUio+Fw/2ZuI/B+kF9kF0nmaFtym?=
	=?us-ascii?Q?whFFWw2GVwOLEGIJEvKwte5zMDqLdaAE8BKoDn34FDOgW3XEYyVqihQChuUR?=
	=?us-ascii?Q?EEofBPwQvQ2bheGyivSPT4=3D?=
X-Microsoft-Antispam-Message-Info: VO1LtJM6Gk7UYnMcHn+l9FjIdO3aETU8wYE9eHgieY7smvXRfk8jZNXXtjwrqMkioKNgzoptB9Z03WbzIRO/GXFQ4mE3fhkoIoqvReQeThxyvhh9ym9BMKjuX8cTv9EF1Dc8AXeXYntH9dzW2Eg57gy0YRJs2RpoXkgpDt5mXD0dWRkkc1nlRnCIfrpg+XpEkcCfa7u9bLFdMqE1gO0YFuDpX6bWvo8wGqT6xhZZVvOUTlRF1kp7gFjJVLxZRyVtN5+rGjvodQgWLY1ZVBEARzHPpxW6XrMyiUWlC8Ge5KMRyRpTGbNfEAEVdte4sidI/lnIriMuypDhFJvSVuW8eiPsOiZVm4DA3l6UmqwFlZ89QWssUi7QlMKPKX4ng6FIk/k8W6ofBbTCVHI9bFIlr13OTydyxAyMeSaN/N5NO1w=
X-Microsoft-Exchange-Diagnostics: 1; AM0PR05MB5762;
	6:5fGhl8tdAlSn3v1KSOnp1tbyaVRIc8dmreaJOrHnzw6VL6r/ZwVCsfn7PTQtHbaLms0gOIvZCaL9iGld7e75VAPQ/5fjWe/gbDTXjOGd+1MNEtElnmm6EUIBsL9bh+yy9HqB2w1Uea9LX7MHl7T9YvmRujjWuMA4GKSmQAzXefsi8rIqxoMBfVGFMYqaEHNzoiKjU9i4Oo8eMuHeYKGi4tCdNxvsg7AV9w+NMwnzMFREtkZACFpXIC3NPisQsN7AW7gpU15YjM+Q8hXhZ0N2JXjNmpftN6xQnhFDV+snDga4Thsier0K3eZ2VIUNoffNsyjzv5PAEabTqgKay77OtsfDV5V5tiA01rDRrwD+8576lLKoX4T/R/GjlMeNtRegHVMKLDNYckDxyCcaNzhi7lWh72cKhzLxNQuQqSGJVkooGK/VGG1/CJV/QKBdiQJHSIyKhP51+MqwbqoCyUf4/Q==;
	5:hHuhtGwe8ofxjfpKUFa4XeW9yV/F4kRw5HafU+4GdVDLO40oTxE7xL2WTosklD2cZiNrEfoFFEc0pqFtbu07DFaPDqKBOWin+DEqniGj+nRnqpK18iyoTGsqYavM7hnDZpuqh7NyhsgrLbkS8j8l4VuBYfyBwHY4nB+uYatPuzoVuXtp3Mhs0BqekP9VkbgdjauChjo7t4hYC65i9qCYxQ==;
	7:tPEcI2klJZBjMmhmN/DRNQWrUVKfZ49sZ12MqnxwIaOkKfNC4BkNXgQw9l6xjk1ov8y6AZJavuVjNEMZDlymr+w3CtOweyrNQsjWRX32XAasePt/+usdgl+g/g+2TY/uTI/aWS0LTUsKfy0pyAyksg==
X-OriginatorOrg: phoenixcontact.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2019 10:09:23.5680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7508e930-b267-400c-e1bb-08d67a085bb0
X-MS-Exchange-CrossTenant-Id: 6868843b-f012-4c95-a18e-bab826cca9ac
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=6868843b-f012-4c95-a18e-bab826cca9ac;
	Ip=[51.136.18.164]; Helo=[azr-iqsuite11]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5762
Subject: [PATCH] fetch2: probe for branches on version check
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
X-List-Received-Date: Tue, 15 Jan 2019 21:48:05 -0000
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_AM6PR05MB4295F10BC56816A25BB85150CC800AM6PR05MB4295eurp_"

--_000_AM6PR05MB4295F10BC56816A25BB85150CC800AM6PR05MB4295eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

From 26811e557b963c87ffbcb3448401561ab87751d3 Mon Sep 17 00:00:00 2001
From: Konrad Weihmann <kweihmann@phoenixcontact.com>
Date: Mon, 14 Jan 2019 09:53:16 +0100
Subject: [PATCH] fetch2: probe for branches on version check

If a repository isn=27t using tags but versioned branches,
bb.fetch2.git.latest_version will fail.
To get at least some kind of information probe for git-tags first and
then for git-branches before giving up.
---
 bitbake/lib/bb/fetch2/git.py | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 15858a6241..5cc1fce531 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -611,11 +611,19 @@ class Git(FetchMethod):
         versions and returning the highest match.
         =22=22=22
         pupver =3D (=27=27, =27=27)
+        output =3D None

         tagregex =3D re.compile(d.getVar(=27UPSTREAM_CHECK_GITTAGREGEX=
=27) or =22(=3FP<pver>([0-9][=5C.|_]=3F)+)=22)
-        try:
-            output =3D self._lsremote(ud, d, =22refs/tags/*=22)
-        except (bb.fetch2.FetchError, bb.fetch2.NetworkAccess) as e:
+        for needle in [=22refs/tags/*=22, =22refs/*=22]:
+            try:
+                output =3D self._lsremote(ud, d, needle)
+                break
+            except (bb.fetch2.NetworkAccess) as e:
+                bb.note(=22Could not list remote: %s=22 % str(e))
+                return pupver
+            except (bb.fetch2.FetchError) as e:
+                pass
+        if not output:
             bb.note(=22Could not list remote: %s=22 % str(e))
             return pupver

--
2.14.2




..................................................................
Phoenix Contact GmbH & Co. KG

Sitz der Gesellschaft / registered office of the company: 32825 Blomberg
USt-Id-Nr.: DE124613250
Pers. haftende Gesellschafterin / personally liable partner: Phoenix Cont=
act Verwaltungs GmbH
Amtsgericht Lemgo HRB 5273 / district court Lemgo HRB 5273
Kom. Ges. Amtsgericht Lemgo HRA 3746 / limited commercial partnership dis=
trict court Lemgo HRA 3746 
Gesch=E4ftsf=FChrer / Executive Board: Frank St=FChrenberg (Vorsitzender =
/ Chief Executive Officer), Roland Bent, Prof. Dr. Gunther Olesch, Axel W=
achholz 
___________________________________________________________________
Diese E-Mail enth=E4lt vertrauliche und/oder rechtlich gesch=FCtzte Infor=
mationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irr=
t=FCmlich erhalten haben, informieren Sie bitte sofort den Absender und v=
ernichten Sie diese Mail. Das unerlaubte Kopieren, jegliche anderweitige =
Verwendung sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet=
.
-------------------------------------------------------------------------=
---------------------------
This e-mail may contain confidential and/or privileged information. If yo=
u are not the intended recipient (or have received this e-mail in error) =
please notify the sender immediately and destroy this e-mail. Any unautho=
rized copying, disclosure, distribution or other use of the material or p=
arts thereof is strictly forbidden.
___________________________________________________________________

--_000_AM6PR05MB4295F10BC56816A25BB85150CC800AM6PR05MB4295eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D=22Content-Type=22 content=3D=22text/html; charset=3Di=
so-8859-1=22>
<style type=3D=22text/css=22 style=3D=22display:none;=22><!-- P {margin-t=
op:0;margin-bottom:0;} --></style>
</head>
<body dir=3D=22ltr=22>
<div id=3D=22divtagdefaultwrapper=22 style=3D=22font-size:12pt;color:#000=
000;font-family:Calibri,Helvetica,sans-serif;=22 dir=3D=22ltr=22>
<p style=3D=22margin-top:0;margin-bottom:0=22></p>
<div>From 26811e557b963c87ffbcb3448401561ab87751d3 Mon Sep 17 00:00:00 20=
01<br>
From: Konrad Weihmann &lt;kweihmann@phoenixcontact.com&gt;<br>
Date: Mon, 14 Jan 2019 09:53:16 &#43;0100<br>
Subject: [PATCH] fetch2: probe for branches on version check<br>
<br>
If a repository isn=27t using tags but versioned branches,<br>
bb.fetch2.git.latest_version will fail.<br>
To get at least some kind of information probe for git-tags first and<br>
then for git-branches before giving up.<br>
---<br>
&nbsp;bitbake/lib/bb/fetch2/git.py | 14 &#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;---<br>
&nbsp;1 file changed, 11 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py<=
br>
index 15858a6241..5cc1fce531 100644<br>
--- a/bitbake/lib/bb/fetch2/git.py<br>
&#43;&#43;&#43; b/bitbake/lib/bb/fetch2/git.py<br>
@@ -611,11 &#43;611,19 @@ class Git(FetchMethod):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; versions and returning t=
he highest match.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&quot;&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pupver =3D (=27=27, =27=
=27)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; output =3D None<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tagregex =3D re.compile(=
d.getVar(=27UPSTREAM_CHECK_GITTAGREGEX=27) or &quot;(=3FP&lt;pver&gt;([0-=
9][=5C.|_]=3F)&#43;)&quot;)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; try:<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; outpu=
t =3D self._lsremote(ud, d, &quot;refs/tags/*&quot;)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; except (bb.fetch2.FetchError,=
 bb.fetch2.NetworkAccess) as e:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for needle in [&quot;refs=
/tags/*&quot;, &quot;refs/*&quot;]:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; t=
ry:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; output =3D self._lsremote(ud, d, needle)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; break<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e=
xcept (bb.fetch2.NetworkAccess) as e:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; bb.note(&quot;Could not list remote: %s&quot; % st=
r(e))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; return pupver<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; e=
xcept (bb.fetch2.FetchError) as e:<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; pass<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if not output:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
bb.note(&quot;Could not list remote: %s&quot; % str(e))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
return pupver<br>
&nbsp;<br>
-- <br>
2.14.2<br>
<br>
</div>
<br>
<p></p>
</div>
<FONT face=3D=22Arial=22 size=3D=221=22>
<P dir=3D=22ltr=22><BR>..................................................=
................<BR>Phoenix Contact GmbH &amp; Co. KG<BR><BR>Sitz der Ges=
ellschaft / registered office of the company: 32825 Blomberg<BR>USt-Id-Nr=
.: DE124613250<BR>Pers. haftende Gesellschafterin / personally liable par=
tner: Phoenix Contact Verwaltungs GmbH<BR>Amtsgericht Lemgo HRB 5273 / di=
strict court Lemgo HRB 5273<BR>Kom. Ges. Amtsgericht Lemgo HRA 3746 / lim=
ited commercial partnership district court Lemgo HRA 3746 </P>
<P>Gesch=E4ftsf=FChrer / Executive Board: Frank St=FChrenberg (Vorsitzend=
er / Chief Executive Officer), Roland Bent, Prof. Dr. Gunther Olesch, Axe=
l Wachholz <BR>__________________________________________________________=
_________<BR>Diese E-Mail enth=E4lt vertrauliche und/oder rechtlich gesch=
=FCtzte Informationen. Wenn Sie nicht der richtige Adressat sind oder die=
se E-Mail irrt=FCmlich erhalten haben, informieren Sie bitte sofort den A=
bsender und vernichten Sie diese Mail. Das unerlaubte Kopieren, jegliche =
anderweitige Verwendung sowie die unbefugte Weitergabe dieser Mail ist ni=
cht gestattet.<BR>-------------------------------------------------------=
---------------------------------------------<BR>This e-mail may contain =
confidential and/or privileged information. If you are not the intended r=
ecipient (or have received this e-mail in error) please notify the sender=
 immediately and destroy this e-mail. Any unauthorized copying, disclosur=
e, distribution or other use of the material or parts thereof is strictly=
 forbidden.<BR>__________________________________________________________=
_________</P></FONT></FONT></body>
</html>

--_000_AM6PR05MB4295F10BC56816A25BB85150CC800AM6PR05MB4295eurp_--
