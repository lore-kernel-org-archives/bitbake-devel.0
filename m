Received: from EUR06-VI1-obe.outbound.protection.outlook.com (EUR06-VI1-obe.outbound.protection.outlook.com [40.92.17.62])
 by mx.groups.io with SMTP id smtpd.web08.7055.1620826729756919243
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 12 May 2021 06:38:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@outlook.com header.s=selector1 header.b=RyZZxpl3;
 spf=pass (domain: outlook.com, ip: 40.92.17.62, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiaO/N2KK8G9migzdT4Ksmp96LMDTAcE3F8Jm3Q45Sf/Yq8LfqaU+pjtK92WLXoF+Ql+HjqKQU/9EvfsnD+BtcnjD0fvQQEFZg6go03emm292oDkfS56fx0FnJF739rpddBgc0dglOrklweBF61NtoHWcJ8axgryDyEZf0uU9MQ5VirbddQoWGcUhv++F0xZaG18bjif+zfFIEr0H8hqs6DFnhE0DlJtF2naCoG8V/UbwoPjKqnWM5hnw+iBVN3OAywC2/5IIgtS8K6Ja0zw1xCh2wDwUWbKmcGwK3HTVUHzIQo4yFTpLl8EpUFooJArZlqcKYVDgZHKMHfhZr/TIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E11o0vLUysRJ/d37t+CClc1xLXFz8LDCfbdefLJy3Ic=;
 b=PfF+IEcAToO7iNulVc/c1jfE7fDGF7bHLuosbU7wpltA15lw9ZFiUAzwtFlptQRVQ79tmAGteYkt24DAoPqvuO/FRG494r9wuphUtTNRMnc+poVoeiy5QAD92HSgRPrcxfJ9q4susxKnIRD/WCdQkYsS3J5fj4OIqqC6v5UUEMqG2EdLPx+Y1AumM6hazjQXSnG1Uvp7vZkNgZfaDeeD9fZw7/4cld2TL1WVe+xMy1apfrc++O1BJW/N3Gwx0AWU2Mxfith/6l188xPl4rAmq28Wlz1ln5WwigMr56tCbWZ3/DDNAViulWSzRlt4FvNJNJtq3odDlR2b0YeZ1JsQeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E11o0vLUysRJ/d37t+CClc1xLXFz8LDCfbdefLJy3Ic=;
 b=RyZZxpl3BEJ582dKxmPG2cmCl05kz0TSGks2PjfcLXszm3aA3muUYNOg0MslxYzZ5Kh8ybo3VAl2FfSrPvBWsnPCtal3XNWP3nyNsycrQjDdyMdrEme6F2MatuusX2f30mxkxlfhiSXofLGR5k4cl6MEp8xMfJfMZGSmhOfFly+kfm9zDjQD0tDxxe2I540WzLdeRxEDotIipeqeamwB25rpvltb0+pX74SmVt2/h4RAK8/lc086KL0bkYFlu21m8xrjfNR5LOVk2KzUS1yOSoBls98bC+ggXtCVuk8Kb42nsRd+zeNWHF+k2pExKa0P/4wglm2iahS9bJ9njfFaxQ==
Received: from VI1EUR06FT031.eop-eur06.prod.protection.outlook.com
 (2a01:111:e400:fc37::49) by
 VI1EUR06HT098.eop-eur06.prod.protection.outlook.com (2a01:111:e400:fc37::286)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 12 May
 2021 13:38:46 +0000
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com
 (2a01:111:e400:fc37::42) by VI1EUR06FT031.mail.protection.outlook.com
 (2a01:111:e400:fc37::198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend
 Transport; Wed, 12 May 2021 13:38:46 +0000
X-IncomingTopHeaderMarker: 
 OriginalChecksum:4FCFB3F248569DC803ACC0E353C3832DAA9C550ECADF9FD8603B5305F06F9919;UpperCasedChecksum:5968BD6ECDAB61BAD7ADB6BAB57FBE31FB6504BFF2BC0FAB32FCCC9FFC7AB3E9;SizeAsReceived:8619;Count:46
Received: from AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::9c9b:9858:17df:de84]) by AM9PR09MB4642.eurprd09.prod.outlook.com
 ([fe80::9c9b:9858:17df:de84%6]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 13:38:46 +0000
Date: Wed, 12 May 2021 15:38:37 +0200
Subject: Re: [bitbake-devel] Git Fetcher Branch Default
Message-ID: 
 <AM9PR09MB46424BF3FA7F32E36D5E3C91A8529@AM9PR09MB4642.eurprd09.prod.outlook.com>
X-Android-Message-ID: <ffdb3f13-13a1-4eb7-935e-260dd3e4646e@email.android.com>
In-Reply-To: <CAB=6tBSrVooUvS4G_NDPUHrHTLjxoHqJ269AVHA2K+4guYzerw@mail.gmail.com>
From: "Konrad Weihmann" <kweihmann@outlook.com>
To: Chuck Wolber <chuckwolber@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Yocto-mailing-list
 <yocto@yoctoproject.org>
X-TMN: [dONENyr/P8hQN/dg+ZghR9qdGr8vs2hY]
X-ClientProxiedBy: AM0PR10CA0092.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::45) To AM9PR09MB4642.eurprd09.prod.outlook.com
 (2603:10a6:20b:284::24)
Return-Path: kweihmann@outlook.com
X-Microsoft-Original-Message-ID: 
 <ffdb3f13-13a1-4eb7-935e-260dd3e4646e@email.android.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.162.148.82] (46.114.36.82) by AM0PR10CA0092.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 12 May 2021 13:38:45 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 46
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 776eae02-305e-4212-dd16-08d9154b4442
X-MS-TrafficTypeDiagnostic: VI1EUR06HT098:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	O0Br1W40XQB5Al2GrS7DV4X0GdSVTzSPb2swapxSfIyGJixphX/pXOkaUF3K6PMngs9lGjK/lnQbXVtuBtL7kunLlYDwXRBc1ILrcgdwCzigZtp3g+yFywjof8jZ1QaSYNdmx/zOvdvJoX5vt/e0y03ZEKkJfORp6tEl5nYBPJAq0UAnnApohvhzLI6NlfrRbnnEI8bTIccOxGf6CJNmHc1GaD5VJI5vxQlc2Ukp4hrJ5BeHbCHZyu49ELTraFYKvFTCU9vHigI9fle9rfTTLL3IreBXyLTSGcaXVTRA7pkhWrSr286lEkvaPv+ozEwTx/ER4RtkbNZbHXu7Kv+lKK08b/dDfHjKlkmvqRRRnWQKJNEG/W0PJos31CJNiMydh83HZCEH1rTKqprj/ZhZBmzppI1u9kLGsZYLVpVuv0/Z8j2R7hByr6ryvKWemFGKisIo08Uc3UTD7sKH5E0qFA==
X-MS-Exchange-AntiSpam-MessageData: 
	GGMgo65bcjC+XrvQb89mYgJg0yywDLoOrbUeWs5btXbLyc8eo9AWRfMBBTDBQfjAlFTCTilFK5JFkTm07hI7+wiJ2YtnTXbgqFU8ZsXJb9/9YE/sjJcpkR3dAL3r03Vfefcg6VKOBdJctKq6XbgR0Q==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 776eae02-305e-4212-dd16-08d9154b4442
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 13:38:46.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: 
	VI1EUR06FT031.eop-eur06.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR06HT098
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJz
ZXQ9dXRmLTgiPjxkaXYgZGlyPSJhdXRvIj48ZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9leHRy
YSI+PGJyPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiAxMiBNYXkgMjAyMSAxNDo1MSwgQ2h1
Y2sgV29sYmVyICZsdDtjaHVja3dvbGJlckBnbWFpbC5jb20mZ3Q7IHdyb3RlOjxiciB0eXBlPSJh
dHRyaWJ1dGlvbiI+PGJsb2NrcXVvdGUgY2xhc3M9InF1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAw
IC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PHAgZGly
PSJsdHIiPkkgZ290IGEgZmV0Y2hlciBmYWlsdXJlIG9uIGdvLXN5c3RlbWQgdG9kYXksIHdoaWNo
IHB1enpsZWQgbWUuIFRoYXQKPGJyPgpyZWNpcGUgaGFzIG5vdCBjaGFuZ2VkIGluIGFnZXMsIGFu
ZCB0aGUgU1JDUFYgaGFzaCBpcyBjbGVhcmx5IHZpc2libGUKPGJyPgppbiB0aGUgcmVwb3NpdG9y
eS4KPGJyPgoKPGJyPgpBZnRlciBsb29raW5nIGF0IGl0IGNsb3NlciwgaXQgc2VlbXMgdGhhdCBn
aXRodWIuY29tL2NvcmVvcy9nby1zeXN0ZW1kCjxicj4KaGFzIGNoYW5nZWQgaXRzIGRlZmF1bHQg
YnJhbmNoIGZyb20gbWFzdGVyIHRvIG1haW4gYWJvdXQgc2l4IGRheXMgYWdvLgo8YnI+ClRoaXMg
YXBwZWFycyB0byBicmVhayBhIGZ1bmRhbWVudGFsIGFzc3VtcHRpb24gb24gdGhlIHBhcnQgb2Yg
dGhlCjxicj4KZmV0Y2hlciB3aGVuIGxvb2tpbmcgZm9yIFNSQ1JFViBhbmQgU1JDUFYgaGFzaGVz
Lgo8YnI+Cgo8YnI+Ckxvb2tpbmcgYXQgbGliL2JiL2ZldGNoMi9naXQucHkgbWFrZXMgaXQgZXZp
ZGVudCB0aGF0IHRoaXMgaXMgdGhlCjxicj4KY2FzZS4gSSBjYW4gdHJpdmlhbGx5IGZpeCB0aGlz
IHdpdGggYSAuYmJhcHBlbmQsIGJ1dCBpdCBzZWVtcyB0byBtZQo8YnI+CnRoYXQgdGhlIGZ1bmRh
bWVudGFsIGRlZmF1bHQgYnJhbmNoIGFzc3VtcHRpb24gbmVlZHMgdG8gYmUgdXBkYXRlZC48L3A+
PC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2PjwvZGl2PjxkaXYgZGlyPSJhdXRvIj5JaXJjIHRoZXJl
IGhhcyBiZWVuIHRoZSBzYW1lIGRpc2N1c3Npb24gYWxyZWFkeSBsYXN0IHllYXIgb3IgdGhlIHll
YXIgYmVmb3JlLi4uIGFuZCB0aGUgYWdyZWVtZW50IHdhcyB0byBsZWF2ZSBpdCBhcyBpdCBpcy4g
SU1ITyBtb3N0IG9mIHRoZSB1c2VkIHByb2plY3RzIHN0aWxsIGdvIHdpdGggbWFzdGVyIGluc3Rl
YWQgb2YgbWFpbiwgc28gYSBwYXRjaCBvZiB5b3VycyB3b3VsZCBjcmVhdGUgYSBsb3Qgb2Ygd29y
ayBmb3IgdGhlIG1ham9yaXR5IG9mIHRoZSByZWNpcGVzLjwvZGl2PjxkaXYgZGlyPSJhdXRvIj5B
bmQgYXMgdGhlcmUgaXMgdGhlIGJyYW5jaCBhdHRyaWJ1dGUgZm9yIHRoZSBnaXQgZmV0Y2hlciBh
bHJlYWR5IGF2YWlsYWJsZSAoYW5kIHdpZGVseSB1c2VkIGZvciBlc3BlY2lhbGx5IHRoZXNlIGNh
c2VzKSBJIHBlcnNvbmFsbHkgZG9uJ3Qgc2VlIHRoZSBuZWVkIGZvciBzdWNoIGEgcGF0Y2gsIHVu
bGVzcyBpdCBwcm92aWRlcyBmdWxsIGJhY2t3YXJkIGNvbXBhdGliaWxpdHk8L2Rpdj48ZGl2IGRp
cj0iYXV0byI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxkaXYgY2xhc3M9ImdtYWlsX3F1b3Rl
Ij48YmxvY2txdW90ZSBjbGFzcz0icXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3Jk
ZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48cCBkaXI9Imx0ciI+Cjxi
cj4KCjxicj4KSGFzIGFueW9uZSBkaXNjdXNzZWQgYWRkaW5nIG1haW4gdG8gdGhlIGxpc3Qgb2Yg
ZGVmYXVsdCBicmFuY2hlcyB0bwo8YnI+CnRyeT8gSWYgbm90LCBJIG1heSBiZSBhYmxlIHRvIGNv
bWUgdXAgd2l0aCBhIHBhdGNoLCBidXQgdGhlIGNvZGUgZG9lcwo8YnI+CnByb2Nlc3MgZGVmYXVs
dCBicmFuY2hlcyBhcyBhIGxpc3QsIHNvIEkgd2lsbCBuZWVkIHRvIHRoaW5rIGEgYml0IG9uCjxi
cj4KdGhlIGJlc3Qgd2F5IHRvIGFwcHJvYWNoIHRoaXMuIEFueSBndWlkYW5jZSB3b3VsZCBiZSBh
cHByZWNpYXRlZC4KPGJyPgoKPGJyPgouLkNoOlcuLgo8YnI+Cgo8YnI+Cgo8YnI+Ci0tIAo8YnI+
CiZxdW90O1BlcmZlY3Rpb24gbXVzdCBiZSByZWFjaGVkIGJ5IGRlZ3JlZXM7IHNoZSByZXF1aXJl
cyB0aGUgc2xvdyBoYW5kIG9mCjxicj4KdGltZS4mcXVvdDsgLSBWb2x0YWlyZQo8L3A+CjxwIGRp
cj0ibHRyIj4KPGJyPgoKPGJyPgoKPGJyPgo8L3A+CjwvYmxvY2txdW90ZT48L2Rpdj48YnI+PC9k
aXY+PC9kaXY+PC9kaXY+
