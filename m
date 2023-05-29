Return-Path: <kenth.eriksson@infinera.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53031C77B7E
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 09:53:13 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (NAM10-BN7-obe.outbound.protection.outlook.com [40.107.92.58])
 by mx.groups.io with SMTP id smtpd.web10.46139.1685353986229892591
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 May 2023 02:53:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@infinera.com header.s=selector1 header.b=ZAPbqtD2;
 spf=pass (domain: infinera.com, ip: 40.107.92.58, mailfrom: kenth.eriksson@infinera.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZ7WuAIX2Cp+obyjK1zfQgG6+0uWZ/iyGTAz5WhE5RmpWem/J0kUl+lWAGTQSABKjECoMlYn0dW2mFyXRXVjLdx2E1IOglhPgq8c815CCyRnz6JXVmWm85CNRndHG32+IUSrJY0XsGPV8Slp1bh6V+KN9G8horfTdTnbixVJBa3FYAsuMnmGZ9GS7lqc7sSzWqBWItC9Zw8Q6+SRfzt94yNLdwOHRTLXajzORkumDkGI5hFS4P7LX94sUBaQw3FN8ES38SPUYDIEwnJ2a3FIAlRCPrJa3uhSUPvidwrVKjjvcxyi1lW2LNpAvsoX3oyt1TD3gRBbg5/Y1CAa03d4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIYkFyZIi0toBnX7X9uj5ltfwEzpjTnecO3P5gCtJf0=;
 b=K7Rp9OMgaGyVv3+ocGyu6qFS0KQ3W7m7JZNXNEBCi4CAu3LsPUi/ucNcApcObA0PwudFM2cYVeqqVFn3U0WcjnRAcH5HOCLmr+0cBwvXKRf/iqE5mxc+L0VbkJacvXURnqNNcfRPTQhNxjva7ToraIZrP4VCEd2+092a24sj1mxNQGQcIVOeflGW/Qj9Q8QdjotzdepYMAbN0GOBZRPp3d1j4QDQ+fYiF/lag/0CQ5J97RdEpap5Pfq8wBAAX7+5EQO9qaLgce+3fOzfdD4Rw2XuCsx/NoKXnIO9qqimunmTpIPYjuYZCS+u98lGF4K7yJ8Wksc0Dl5U7FRhlLiOlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIYkFyZIi0toBnX7X9uj5ltfwEzpjTnecO3P5gCtJf0=;
 b=ZAPbqtD27DpbWxNNWCSE6NOoKqgltcxIBjfNB5ljhnlfKgx61z7a51oTUCJ3Wail9piLW+F7URVhZMh3qIC9Pye9LQ8Srt34N5vN1inMG1lpkGglhAVrjK6Rex/WFmxZqeb9eIQE/TWwfqt7c1wRBJNxNedom5/la1O2uArWcQbDRYEvr92ufjXHiWRsAq2VCs1Ipka0BI5YmyS991pYfHNtvhQOB4Aqoy6fEqnEZW7v8G40HlJaPAiN2uSwfXSsr1yrOwTqsBLJNJR7a9i+EnVGQcxg2A9Z4Pnx4lIWYw+sSxg9fiUC75zdM0IzV9XhYqMfF3NZgVtswsiz+XLxuw==
Received: from MW5PR10MB5713.namprd10.prod.outlook.com (2603:10b6:303:19a::12)
 by SA2PR10MB4665.namprd10.prod.outlook.com (2603:10b6:806:fb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 09:53:02 +0000
Received: from MW5PR10MB5713.namprd10.prod.outlook.com
 ([fe80::da16:b353:3d2b:8cdd]) by MW5PR10MB5713.namprd10.prod.outlook.com
 ([fe80::da16:b353:3d2b:8cdd%3]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 09:53:02 +0000
From: Kenth Eriksson <Kenth.Eriksson@infinera.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: reproducible build and yocto sdk
Thread-Topic: reproducible build and yocto sdk
Thread-Index: AQHZkhHmkXaiKnfZlUaQL42b5/ua7g==
Date: Mon, 29 May 2023 09:53:02 +0000
Message-ID: 
 <MW5PR10MB5713792CCE8B2C1E5E89AF8AE34A9@MW5PR10MB5713.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR10MB5713:EE_|SA2PR10MB4665:EE_
x-ms-office365-filtering-correlation-id: 7eb97750-23f0-4d8c-425b-08db602a7e12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 IxQIzQexFKLpGSfA06MIGHNn+CZbyery5luZiry1876AznawQn684R2RSqMAx8ISHYrHWq2ILxiqRux+4frx4m8jgqETn6PEfqtQwNlscjZf+BlcTjep8HRSG9nImiSOFBLgD6MWfs4lhjpZ2OTv+dBHMYluNezJ3BsoOZ6wAq+NwGr7A80O8jLWXhq/wPTRYhFKupQo3kLOQrgaOlRVX+5oAAxQDjNopAUlc05SlgtNBCU+rlhJYQbNRuZXPHpBQPS5OpCn1eMb7ZBZI00hfWCRLM/VSNIoGsvVcvAbLBN2+0sRbQvF6xJDpTTV0HtzFHQyNYnv2U9cS9/aB+Jv1OrFGieqDt2hVT/pgT3+RQEMxi+JCuzjQnqannG8QKGZqYloN1MRugw2nzgFeaxO9mmxTAyo9ugJkyH8vYWeTXoaFXN+VlPE/2ZooCcfBnWYv7Bu1aPqxgK40p7s24SSmPaxoqS7QFvAsFRB48T3G2lEgLl02jxilv0arRdcwgmNikNSRbbHrvo/QG1r1UMgwvS/VrSMBIhk7xNHXz2z7zkG5cV51kptbHOK7tjoBYN6+qYhe2Bs7NbE9KLyLFtCwDGfzA2uc/C9ISfNNW8YtoX4CAHGIr0TTz32qPV5QkCM
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5713.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39850400004)(366004)(396003)(376002)(451199021)(478600001)(55016003)(5660300002)(186003)(71200400001)(33656002)(6916009)(52536014)(86362001)(7696005)(8936002)(8676002)(2906002)(41300700001)(38100700002)(122000001)(316002)(38070700005)(19627405001)(6506007)(26005)(66946007)(76116006)(91956017)(9686003)(64756008)(66446008)(66476007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?QUpVR2hKZ1UrSmdwNDU0Qi93NmRxK0ZNQlRPc3BSZmVTN2JhVFo2cTJ6R2dY?=
 =?gb2312?B?RlNVSURMcGNkaW1CbnFvNkhXbWZFc2djZ1l4VjhmaDhNbk5wM2dzZ0VrLzZC?=
 =?gb2312?B?QlVyZm9GamhlT0ZPUmhWR1NFY2Q5UTdaYmFSVk1ZeCtvUE8zbUdOMTBYUVlR?=
 =?gb2312?B?dW12QWlsanBZVWdUSStOaVFVUUVNb3BxYjNqU01LMnFRZEpVQndGWlZWZlBy?=
 =?gb2312?B?dklpaUF0eTRXc3l4VjYxcDM3SVRTSll6R1ZxdVZDczVTZ2pxeXVvcCtkdkZB?=
 =?gb2312?B?ZGtQMDdERHA5K2hFTUd2MnR0aklIM2FnUTNNa0xKTVFEa3h6aFo3WGRpL1kr?=
 =?gb2312?B?WDdVcFQ4Q3V4Y1RlU3QwaEhEOFhTMXM4R1lYOVFoT2VmNGExK0p1Mk1TU3hH?=
 =?gb2312?B?RUVwWHI4eUladHlrVG1VTUpIV0NoNnJ2OWpCbk9IbDhCdldJTjFyQWFQTU5U?=
 =?gb2312?B?Y2UrYmNOZTdQTm5FanpSNU02dlFyajdrRDlKN29yYmR5WEFYNldZZ2xZemgx?=
 =?gb2312?B?bnNqNVIyVXVzcmI3OHl3R2lQMGgwY2x6Qm9DNzJEUTdoMkx5Y3lGa1BvZExp?=
 =?gb2312?B?MThmRjhhVFRTOVpTYVVmaE9rWm1NazhjTnJTeURVZU1HNDFmT3MvYk5YQXA5?=
 =?gb2312?B?NE41UG9oYXBQOENDdzRkOFhiZWMrQ1FCdWpFRUJWYmFnK0xWZnpnZ2VLQ2kr?=
 =?gb2312?B?cHQxRFFjTEc3VFk5VTJ3RFV3aUxSWE9kWE44QlhtOWd6Qk40ZnlEc2h4S1kw?=
 =?gb2312?B?RVgyYy9Uam0xVXoyYUdxZmM0MlZ4RFFRalAyTG4wUDdMMUU2VGlMNkp1eFly?=
 =?gb2312?B?SEFHc2orRUlZTnNkYWo3N1d0ZUtsYWd2bTJrMDAvdXgrbHd0a0NRRFJmNFQ0?=
 =?gb2312?B?eE91bG5NeTVWZHJvTTVWSm1PZTVoamU0aHBIaWliS2hpT0hMa1JnZEIzZEJm?=
 =?gb2312?B?dFRabHVzajh6aExzTEZub3R4dVRLd1Y3WEVaT2lxMnppa2YvdXlwaDJMQXZH?=
 =?gb2312?B?K1FlcXRWUkltaTM2TFRsNFd2T3h4TzBwNCtnRUhHbnRJcy9QQnlxZFYvcHVQ?=
 =?gb2312?B?MEdDSk1ObjUzTFVsaGQ0STNpZ2U2SjBMcTVLQXpwcm9hR2NQSHJsYURKMnAr?=
 =?gb2312?B?UytxK25BRFo5V0hSVEUyRXA5blR0VmtFVHF2QlYva0RTSm1TM3dqdWxxRGtS?=
 =?gb2312?B?d2oyb1dvUTlqUDNxUE5laEJrYjJGUzRrN2pWRTA0aWtGb2VseExhR01NY3pC?=
 =?gb2312?B?WVByZnBTSTcxMzg4SVdDOVNHc3crdExqY0RVK2czMDhXRHlvY1YrcEYybHdn?=
 =?gb2312?B?UGZVdGpSNHdqdkRaVUZuWlVkWTJTZXh5NnVqN1JMbk1ZTENxRndScmpsUmo0?=
 =?gb2312?B?L0k2QnhWTjNiZDRzcGhiNEVKSW96c21PNFl4T1JnbUlySlpRYUFwL3VxSURh?=
 =?gb2312?B?VnZzM1hVcXhXOElwaEdqdXpvS0FldisrWVd3ZWNTb3lXVFUvR1RxbFBBeDlL?=
 =?gb2312?B?eWJHcnVkR25Yc3lBK05GdUd5ZllOSExPM1F0NnFhc0NzeEY4U0wxWEFZSjcy?=
 =?gb2312?B?dHZxaFVVWDJjQ3BEZEVVdzdkZ0VFL2pKN1psWjMvS1lYZC9rM2pZYmtFbHhB?=
 =?gb2312?B?M2dheVU0cit3NHU5VFJ6VVFOUkVMdCtkZFlEWGFxZkxNRkFVbFdsdmdSck1k?=
 =?gb2312?B?Z0VvS2lzYmNGUWF3a1pLYmxCcFJ0U3dTcjVFbzUyZ3BFYlpReGd1ZllJeDNR?=
 =?gb2312?B?K05LQkZaQ2QrNzZFYUFXNWZoSEZpam0wRGluSXBWUmp0M29BUjBUTlJ3TUYr?=
 =?gb2312?B?Mjd6S2U0UTJIeEFUTW9oWDM4c3lRK01tTENTUDNML1pnN2JESXNIRDhLYjdz?=
 =?gb2312?B?S0VwVnRsNi8rMGUvS1ZjZW0xU3FmT2M1K2EvVnVVRDlnb29LZFhxd2MweWc5?=
 =?gb2312?B?SWNSZWpScmRQNUNVWXBhc2ExQW5TVzNQaVRkeFNpZUdtQTg3QVhyNjN4NnFx?=
 =?gb2312?B?ZzJLc2FQZFlnMmQ0RlVrSk1BMHM2OENjUXFZS0ljVThCbmdzdE1Vdnpjbitu?=
 =?gb2312?B?Z0VZQlhIS3V4bWs0ZHNId2xCa2RqaHIvcCtHbUptaENVMFl2MWZQTExhanhw?=
 =?gb2312?Q?oM4o=3D?=
Content-Type: multipart/alternative;
	boundary="_000_MW5PR10MB5713792CCE8B2C1E5E89AF8AE34A9MW5PR10MB5713namp_"
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5713.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb97750-23f0-4d8c-425b-08db602a7e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2023 09:53:02.3049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3YDaZ+2H9cUHq10cfXWeDHPYhIkQ3oSgh6ZI0DlheA1eYfg8t6Xy8C9RgD4As9KD4AZTox+btGeHUH24Cia8dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4665
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 May 2023 09:53:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14816

--_000_MW5PR10MB5713792CCE8B2C1E5E89AF8AE34A9MW5PR10MB5713namp_
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64

SSdtIGhhdmluZyBpc3N1ZXMgd2l0aCByZXByb2R1Y2libGUgYnVpbGRzIG9uIGtpcmtzdG9uZSB3
aGVuIGNvbXBhcmluZyBhIGJ1aWxkIGRyaXZlbiBieSBiaXRiYWtlIGNvbXBhcmVkIHRvIGEgYnVp
bGQgZHJpdmVuIGZyb20gYSB5b2N0byBzZGsuIENhbiBJIGV4cGVjdCByZXByb2R1Y2libGUgYnVp
bGQgYmV0d2VlbiBiaXRiYWtlIGJ1aWxkcyBhbmQgc2RrIGJ1aWxkcz8gU29tZSBwcm9kdWNlZCBi
aW5hcmllcyBoYXZlIG1pbm9yIGRpZmZlcmVuY2VzLCBidXQgbGFyZ2VyIGMrKyBiaW5hcmllcyBz
aG93IHF1aXRlIGh1Z2UgZGlmZi4gT25lIGNvbW1vbiBkaWZmZXJlbmNlIGlzIHRoYXQgdGhlIEVM
RiBoZWFkZXIgc2VlbXMgdG8gaGF2ZSBkaWZmZXJlbnQgT1MvQUJJIGJldHdlZW4gdGhlIHR3byBi
dWlsZHMuIENhbiBiaW51dGlscyBvbiBkaWZmZXJlbnQgaG9zdCBnaXZlIHN1Y2ggYSByZXN1bHQ/
DQoNCmRpZmZvc2NvcGUNCg0KqaapqCBGaWxlIGhhcyBiZWVuIG1vZGlmaWVkIGFmdGVyIE5UX0dO
VV9CVUlMRF9JRCBoYXMgYmVlbiBhcHBsaWVkLg0KqcCppKmkIHJlYWRlbGYgLS13aWRlIC0tZmls
ZS1oZWFkZXIge30NCqmmIEBAIC0xLDIwICsxLDIwIEBADQqppiAgRUxGIEhlYWRlcjoNCqmmIC0g
IE1hZ2ljOiAgIDdmIDQ1IDRjIDQ2IDAxIDAxIDAxIDAzIDAwIDAwIDAwIDAwIDAwIDAwIDAwIDAw
DQqppiArICBNYWdpYzogICA3ZiA0NSA0YyA0NiAwMSAwMSAwMSAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMA0KqaYgICAgQ2xhc3M6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFTEYzMg0K
qaYgICAgRGF0YTogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAyJ3MgY29tcGxlbWVudCwg
bGl0dGxlIGVuZGlhbg0KqaYgICAgVmVyc2lvbjogICAgICAgICAgICAgICAgICAgICAgICAgICAx
IChjdXJyZW50KQ0KqaYgLSAgT1MvQUJJOiAgICAgICAgICAgICAgICAgICAgICAgICAgICBVTklY
IC0gR05VDQqppiArICBPUy9BQkk6ICAgICAgICAgICAgICAgICAgICAgICAgICAgIFVOSVggLSBT
eXN0ZW0gVg0KqaYgICAgQUJJIFZlcnNpb246ICAgICAgICAgICAgICAgICAgICAgICAwDQqppiAg
ICBUeXBlOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERZTiAoUG9zaXRpb24tSW5kZXBl
bmRlbnQgRXhlY3V0YWJsZSBmaWxlKQ0KqaYgICAgTWFjaGluZTogICAgICAgICAgICAgICAgICAg
ICAgICAgICBBUk0NCqmmICAgIFZlcnNpb246ICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgx
DQqppiAgICBFbnRyeSBwb2ludCBhZGRyZXNzOiAgICAgICAgICAgICAgIDB4MWYwNA0KqaYgICAg
U3RhcnQgb2YgcHJvZ3JhbSBoZWFkZXJzOiAgICAgICAgICA1MiAoYnl0ZXMgaW50byBmaWxlKQ0K
qaYgLSAgU3RhcnQgb2Ygc2VjdGlvbiBoZWFkZXJzOiAgICAgICAgICA0MTMxNiAoYnl0ZXMgaW50
byBmaWxlKQ0KqaYgKyAgU3RhcnQgb2Ygc2VjdGlvbiBoZWFkZXJzOiAgICAgICAgICA0MTMyOCAo
Ynl0ZXMgaW50byBmaWxlKQ0KDQoNClRoYW5rcywNCktlbnRoDQo=

--_000_MW5PR10MB5713792CCE8B2C1E5E89AF8AE34A9MW5PR10MB5713namp_
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dgb2312">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
I'm having issues with reproducible builds on kirkstone when comparing a bu=
ild driven by bitbake compared to a build driven from a yocto sdk. Can I ex=
pect reproducible build between bitbake builds and sdk builds? Some produce=
d binaries have minor differences,
 but larger c++ binaries show quite huge diff. One common difference is tha=
t the ELF header seems to have different OS/ABI between the two builds. Can=
 binutils on different host give such a result?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
diffoscope <br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
</div>
=A9=A6=A9=A8 File has been modified after NT_GNU_BUILD_ID has been applied.
<div class=3D"ContentPasted1">=A9=C0=A9=A4=A9=A4 readelf --wide --file-head=
er {}</div>
<div class=3D"ContentPasted1">=A9=A6 @@ -1,20 +1,20 @@</div>
<div class=3D"ContentPasted1">=A9=A6 &nbsp;ELF Header:</div>
<div class=3D"ContentPasted1">=A9=A6 - &nbsp;Magic: &nbsp; 7f 45 4c 46 01 0=
1 01 03 00 00 00 00 00 00 00 00
</div>
<div class=3D"ContentPasted1">=A9=A6 + &nbsp;Magic: &nbsp; 7f 45 4c 46 01 0=
1 01 00 00 00 00 00 00 00 00 00
</div>
<div class=3D"ContentPasted1">=A9=A6 &nbsp; &nbsp;Class: &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; ELF32</div>
<div class=3D"ContentPasted1">=A9=A6 &nbsp; &nbsp;Data: &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp;2's complement, little endian</div>
<div class=3D"ContentPasted1">=A9=A6 &nbsp; &nbsp;Version: &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
1 (current)</div>
<div class=3D"ContentPasted1">=A9=A6 - &nbsp;OS/ABI: &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
UNIX - GNU</div>
<div class=3D"ContentPasted1">=A9=A6 + &nbsp;OS/ABI: &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
UNIX - System V</div>
<div class=3D"ContentPasted1">=A9=A6 &nbsp; &nbsp;ABI Version: &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0</div>
<div class=3D"ContentPasted1">=A9=A6 &nbsp; &nbsp;Type: &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp;DYN (Position-Independent Executable file)</div>
<div class=3D"ContentPasted1">=A9=A6 &nbsp; &nbsp;Machine: &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
ARM</div>
<div class=3D"ContentPasted1">=A9=A6 &nbsp; &nbsp;Version: &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
0x1</div>
<div class=3D"ContentPasted1">=A9=A6 &nbsp; &nbsp;Entry point address: &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0x1f04</div>
<div class=3D"ContentPasted1">=A9=A6 &nbsp; &nbsp;Start of program headers:=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;52 (bytes into file)</div>
<div class=3D"ContentPasted1">=A9=A6 - &nbsp;Start of section headers: &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp;41316 (bytes into file)</div>
<div class=3D"ContentPasted1">=A9=A6 + &nbsp;Start of section headers: &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp;41328 (bytes into file)</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
<div class=3D"ContentPasted0"></div>
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Thanks,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Kenth<br>
</div>
</body>
</html>

--_000_MW5PR10MB5713792CCE8B2C1E5E89AF8AE34A9MW5PR10MB5713namp_--

