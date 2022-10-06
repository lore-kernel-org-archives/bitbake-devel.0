Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23740C433FE
	for <webhook@archiver.kernel.org>; Thu,  6 Oct 2022 11:07:28 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.50])
 by mx.groups.io with SMTP id smtpd.web09.4477.1665054442026111001
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 06 Oct 2022 04:07:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@armh.onmicrosoft.com
 header.s=selector2-armh-onmicrosoft-com header.b=A45hLBLd;
 spf=pass (domain: arm.com, ip: 40.107.104.50, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=VJmZzNvFs05mLrWjF8Qsg46p3/dtcTcJaF2XIuV3yyM3Jiyvrl6CufEY4tdhgP4m3gZa93YQ+9O94/eH5PXOhzwsrNtaO80I3OMEk+/lAUdPyIweXVmXQSo6M8GqdbeVqPTEufeZaRZPpIFwhFc5Enrecz/Pe8o5SZb+b2kK2+0UsQqbRKimTGq2XOKVxC48Ua+m/Ns+SKIJCu7UjWKKW6MXzFbqNwDMQjUslQonX/WD55P/MzIkQtZjN37cdd9E8yMRMt66WwMicPmUiIZi7kAg3dbO2gisoj+gzxd9dICCifo3gw4+FhSYHAYHINsK6476taXqFB+EByek6v2Mmg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FY0N/t8ey931wc7MAL31ok//l+AIJyomE47ch5c1e4s=;
 b=P4Oq6SN9agJZBY00qDbhNMQy2ZhGTSvvsK4N9BOGfqnu3lHKDVHIbw/IH9q2DJNn4+2x1SMJjoSSINSY8ue2Jw5bSPOAuVuO4amrBfMQ2FkC5aoCRCqsUrhQrPoUp0cuOwciTKnAxfsCjYcaHQJPldWoBqt6NKZmyPOXewlY25s0OIj0Uym9ok1nYji1NNmgZI5RB41B+Ny2R+8qU9XHhxYt4a9UYOMoH/EpQGTOvvMilPLOpJPrx+NbJWxwg31y1rYW7lis9kzLZavLxDzkYMBf5vS3Z4AbZl3efpjyLYoRk6DrS3jN1ZJdlUJ1e2pYsV6qgk5W1j/QPox74OxOiw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.openembedded.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FY0N/t8ey931wc7MAL31ok//l+AIJyomE47ch5c1e4s=;
 b=A45hLBLdGntY17Jr0/9uHgSqTXlliGd3tY6Yhw9GqsqealX4ycJ6mGPs7IcdwVyeQilBWnIM45VFGlbgHq64mij2qS4rIwMKCcfSs6XyG8Gy+3Y/03klV7ll+CWZrDtqwx/ZHHoDSoDCMzyCEl9BSGdl2zteAVY0YQ5i15+kqbo=
Received: from DU2PR04CA0332.eurprd04.prod.outlook.com (2603:10a6:10:2b4::20)
 by DB9PR08MB9851.eurprd08.prod.outlook.com (2603:10a6:10:460::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 6 Oct
 2022 11:07:17 +0000
Received: from DBAEUR03FT053.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2b4:cafe::29) by DU2PR04CA0332.outlook.office365.com
 (2603:10a6:10:2b4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.33 via Frontend
 Transport; Thu, 6 Oct 2022 11:07:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT053.mail.protection.outlook.com (100.127.142.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 11:07:17 +0000
Received: ("Tessian outbound d354c7aef2bc:v128");
 Thu, 06 Oct 2022 11:07:17 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0bf6f42e1c501828
X-CR-MTA-TID: 64aa7808
Received: from fa9a6cb6f335.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 F834DD06-3D29-4F8F-94FB-35858CCE787A.1;
	Thu, 06 Oct 2022 11:07:11 +0000
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id
 fa9a6cb6f335.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 06 Oct 2022 11:07:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGOmTrlOQjG/gCE6WJe4UKuhE5akjAc8fwpcu40YZvKgW7ZNohOcFEFm/iBS3l6MV4zcRbFWtL45LB7C96YPobtUvzSTI45clFoisIusMOQgaStapWuBuKh8u2OUFN1o4wUYGaUwdM85D3+AYQtPD8AkYe4xzkOU0JiaIL605epGO/hOCzeH5FcJXLs2UCWFH+2bs7f26wI2CrF5FSWUldv8gvUzD3myy3mSu5NdmqVPBnBgxaPTF751MfjsQQk+DtCioyb953IIeIaRdIWCqrvxK9Y4FbUIWIWmAw2SRcOsquEd6Wdg331Qhhzsz6HaGXiyAI1YZ8A125CNphwu/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FY0N/t8ey931wc7MAL31ok//l+AIJyomE47ch5c1e4s=;
 b=IpLSZ9WVQHI+UQHyCslC7TKqmKoMPIz7XFH2hinuEV1Jfdm3p3er5TFANjjab0iJ97D3v5fpgCOURtUYUZwRfoNdfvSUO7j9gpMEnepv/421j2zoYlT8UhDx1krGq/zfZUusvm5R1OxYBQpJaMK+yDPvQdtZEW0URUNz7sUb1+NfMpAGm3y8XT88HrqxfTWBzr7zK0cZodqiNqEsQinYei+wd+LMH7brs4lPHrS44v6xpAeC6GxdzYuyFEqHpe+UHmk1Se5LhXBzqDbucfir3fqvIZU5W3ToOwL8A84uqtBDS33I/d6/tXwi4ag1S4D2zv3es6y14aoGtPNgrAz+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FY0N/t8ey931wc7MAL31ok//l+AIJyomE47ch5c1e4s=;
 b=A45hLBLdGntY17Jr0/9uHgSqTXlliGd3tY6Yhw9GqsqealX4ycJ6mGPs7IcdwVyeQilBWnIM45VFGlbgHq64mij2qS4rIwMKCcfSs6XyG8Gy+3Y/03klV7ll+CWZrDtqwx/ZHHoDSoDCMzyCEl9BSGdl2zteAVY0YQ5i15+kqbo=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by GV1PR08MB8743.eurprd08.prod.outlook.com (2603:10a6:150:87::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Thu, 6 Oct
 2022 11:07:09 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7d2b:2570:9a99:a3d2]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7d2b:2570:9a99:a3d2%5]) with mapi id 15.20.5676.028; Thu, 6 Oct 2022
 11:07:09 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: Richard Greer <rg@braneaudio.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel][PATCH v2] Change git lfs support to allow for
 destsuffix being set.
Thread-Topic: [bitbake-devel][PATCH v2] Change git lfs support to allow for
 destsuffix being set.
Thread-Index: AQHY2D929FeiUBfxuk++t3cxbllQe64ARjyAgADw04A=
Date: Thu, 6 Oct 2022 11:07:09 +0000
Message-ID: <200F5AED-5DF2-48B0-8272-B208657E2ED1@arm.com>
References: <ad8a8eb0-48b7-3d06-f8d3-ddab5747c4f9@braneaudio.com>
 <20221005224513.43b868c5@booty>
In-Reply-To: <20221005224513.43b868c5@booty>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|GV1PR08MB8743:EE_|DBAEUR03FT053:EE_|DB9PR08MB9851:EE_
X-MS-Office365-Filtering-Correlation-Id: 881eb6cc-c8ec-46a8-71ca-08daa78aee9d
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 IqVRxY+Kky+nfUaoP1EUTJ4afmkNZV4EOVZrMXIo1oQwnyBF7LgGi4AngiObPYS7KF1nXaH98DuWDtfKEvKRC6fH+sNBxRo80xzP8njkdC8cOPtQJvn4QrkT8qUg4QXf6gJnrlHBSPseMXca2tkelgS2lCpyptZEF8iG7krnS/0TJY0YGQRWpeXmOQt8MEqN2ytnpiHKTCZAe6rTotYg1RxyO4SAQk0+cQFJUm8OueU+pbLd3FM/roKi2bsdobakkk5SZ7tmYWllR0GvREKCLA11/dDnKPhzx6xJLwVDAJQ/XTivX5uX5esY8I2IyAexVT9siURN9KvK10864i/6ufvgMNMPmHfKXzyWfGQOb3dzo7FfabAZn1dab779t1IjK2Uq338f2uVivTGGflYy7DrUU1Z1Sy3Kj293c+RRkG3PxKtBHfgms7P7URSwkxNHGmDBlZMLMKi57RIsRT61zqq90kKaqHtCtFFrGEQFM3yIU0UjvzNj81/M8jzMiB9HDyjbc5qzHxB2q4x+Di9+b9w+Udhb16gSBIbkomF0NkXRlsm7OldZSD/nlXoxSk/1FNfTIOy9XW8pztklrPArpYj7kWuOwX73ERWhrYS9BK8hSDA3l1qOidUaMqBZINGb/e1CdvrK0WCj8N/tPeZgXx8kwFKjrk4Y7jnLT1p5jIpSQCyG7zR0uv8eOyzM9s7gIoKtFM0dhJ4zkIDKcmC0WrKUZkg/XaJhW7xbbV4cRKz1x3k6YfkBeTCK9wh8JSqU+OC4+EVCEKeybYehDR4Rcsyo9olk6aUs+1LVBeLHmpc=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199015)(4326008)(122000001)(71200400001)(38100700002)(38070700005)(6486002)(26005)(8936002)(478600001)(33656002)(2616005)(53546011)(186003)(41300700001)(66476007)(6916009)(66556008)(2906002)(316002)(36756003)(64756008)(66446008)(86362001)(83380400001)(6506007)(8676002)(5660300002)(6512007)(91956017)(66946007)(76116006)(45980500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEC4E21D566F46408E373830EECBE35C@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8743
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DBAEUR03FT053.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	213d599f-f4e5-431a-864f-08daa78ae9ce
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	g9rQDosVT7NIq8ZFemNndUto4xYotZIYxqYQMF2xDSaGk8dCeTmTiClyiTc9XlqblfUB4zdl3kPYCQ+G8GVpk/o4lOB9H+4WVnCiLdHcLQw0GDirN4Sjrf+jXnw2mv7R/0xREcJgQc3aK5B9E6AH4ZqQRYRCMwwetad7lGp+694s9K7EUcFUJzJrsaaPSMprWaJrORBORmhh6HJWOZ8xVFTTKgyHJgBGi8E9+kdDKLvG6/LheCFwbdx0XdTl9Lzonq9IfRuibkni8nZjFau1jmmqA9/6TbznieZ+nRs2AhEe9nOV0ioA7pvgA8N4yqG5Tj5i2DeFmTKLk0zJJ7P8lNsBMH9Q+vKHPoZVeJ7vPY3cPUuIsV9UWKfj2fVZhgxKc7rWwN+ucwbPr7+3+NThUJoNbGeMWxNpf8Y39j8IyK2AQ2yWWqXZnjMlHTJ1vWV4IT3FwSVzWCTx0yU+mnvpwYpeCVDTNPvNw/w17+t1OYpeTLeUUcLVG1SWAjUjyePu/Lah1cCysohVeHJ5Gds7grDiLqStPwgIwAUqJiecPM9h2Dxs/Iw+AvUx0wgh+8m1bBZ2LSFbiPyRBTg97TsvhBVVx7Gi9JNmoSgafqWkj0TCF/fX7tnaoOWfu52Z3xhrxn62g1cC6oKjrgiDZPcVutN6j6I8c00CqR08/6oq9y2xXLn9jVl+FsiuOBs3sYcoo1tFNjxI/SMGi6/w/t8sj9qwCLq2rzLa7GHsWUMrR1bfFJ27aRwnWsK8OS4J/InpZI5PgGijGpIlIoUIXufTTQ==
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199015)(46966006)(40470700004)(36840700001)(81166007)(82310400005)(356005)(316002)(6486002)(82740400003)(478600001)(8936002)(6862004)(70206006)(47076005)(86362001)(8676002)(70586007)(40460700003)(83380400001)(41300700001)(36860700001)(36756003)(53546011)(33656002)(40480700001)(4326008)(6512007)(26005)(2906002)(336012)(5660300002)(6506007)(186003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 11:07:17.6967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 881eb6cc-c8ec-46a8-71ca-08daa78aee9d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DBAEUR03FT053.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9851
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 06 Oct 2022 11:07:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14026

T24gNSBPY3QgMjAyMiwgYXQgMjE6NDUsIEx1Y2EgQ2VyZXNvbGkgdmlhIGxpc3RzLm9wZW5lbWJl
ZGRlZC5vcmcgPGx1Y2EuY2VyZXNvbGk9Ym9vdGxpbi5jb21AbGlzdHMub3BlbmVtYmVkZGVkLm9y
Zz4gd3JvdGU6DQo+IEFzIHlvdSBhcmUgbW9kaWZ5aW5nIGJpdGJha2UsIHlvdSBzaG91bGQgZG8g
c28gYSBjbG9uZSBvZiB0aGUgYml0YmFrZQ0KPiBnaXQgcmVwb3NpdG9yeS4gRnJvbSB0aGUgcGF0
aCBhYm92ZSwgd2hpY2ggaGF2ZSBhICJiaXRiYWtlIiBkaXJlY3RvcnkNCj4gY29tcG9uZW50LCBJ
IHN1c3BlY3QgeW91IGRpZCB5b3VyIHdvcmsgaW4gYSBjbG9uZSBpZiB0aGUgcG9reQ0KPiByZXBv
c2l0b3J5LCB3aGljaCBpcyBub3QgbWVhbnQgZm9yIGRldmVsb3BtZW50LiBIYXZlIGEgbG9vayBh
dCB0aGUNCj4gUkVBRE1FLm1kIGluIHRoZSBwb2t5IHJlcG9zaXRvcnkgZm9yIG1vcmUgaW5mbywg
YW5kIHNob3VsZCBpdCBzdGlsbCBiZQ0KPiBub3QgY2xlYXIgd2UgY2FuIGhlbHAgeW91IGhlcmUu
DQoNCkZvciB3aGF0IGl04oCZcyB3b3J0aCwgZ2l0IHVzdWFsbHkgaGFuZGxlcyB0aGlzIGFic29s
dXRlbHkgZmluZS4gIEnigJl2ZSBuZXZlciB3b3JrZWQgaW4gYSBzZXBhcmF0ZSBjbG9uZSBvZiBi
aXRiYWtlLCBqdXN0IGFsd2F5cyBmcm9tIHBva3kuDQoNCj4gSSBhbHNvIHRyaWVkIHRvIGFwcGx5
IHlvdXIgcGF0Y2ggbWFudWFsbHkgdG8gY2lyY3VtdmVudCB0aGlzIGlzc3VlIGJ1dA0KPiBpdCBk
aWRuJ3QgYXBwbHkuIEknbSBub3Qgc3VyZSBhYm91dCB3aHkgdGhpcyBpcyBoYXBwZW5pbmcsIGJ1
dCBpdCBtaWdodA0KPiBkdWUgdG8gc29tZSBvdGhlciByZWFzb24gcmVsYXRlZCB0byB5b3VyIG1h
aWxlci4gSSdkIHN1Z2dlc3QgdG8gZ2l2ZQ0KPiAnZ2l0IHNlbmQtZW1haWwnIGFub3RoZXIgdHJ5
OiBpdCBpcyBtZWFudCBleGFjdGx5IHRvIHNlbmQgcGF0Y2hlcyBhbmQNCj4gYW55IG90aGVyIHRv
b2wgaXMgbGlrZWx5IHRvIGNyZWF0ZSBwcm9ibGVtcy4gVGhlIFJFQURNRS5tZCBJIG1lbnRpb25l
ZA0KPiBhYm92ZSBoYXMgYSBsaW5rIHRvIGluZm8gYWJvdXQgc2V0dGluZyB1cCB5b3VyIHdvcmtz
dGF0aW9uIHRvIHNlbmQNCj4gcGF0Y2hlcyBpbiBhIHByb3BlciB3YXkuDQoNCkkgYWxzbyB0cmll
ZCBhbmQgY2FuIGNvbmZpcm06IHdoaXRlc3BhY2UgaXMgYmVpbmcgbWFuZ2xlZCBieSB5b3VyIG1h
aWxlciAoVGh1bmRlcmJpcmQpLiAgUGxlYXNlIHVzZSBnaXQtc2VuZC1lbWFpbCBhcyBtYWlsZXJz
IGRvIGxpa2UgdG8gZ2V0IGluIHRoZSB3YXkuDQoNClJvc3M=

