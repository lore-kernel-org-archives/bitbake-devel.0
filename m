Return-Path: <thilo.cestonaro@thalesgroup.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A50C7EE22
	for <webhook@archiver.kernel.org>; Wed, 10 May 2023 13:10:59 +0000 (UTC)
Received: from thsbbfxrt01p.thalesgroup.com (thsbbfxrt01p.thalesgroup.com [192.54.144.131])
 by mx.groups.io with SMTP id smtpd.web11.16041.1683724256247861652
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 May 2023 06:10:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thalesgroup.com header.s=xrt20181201 header.b=JlMDDxDX;
 spf=pass (domain: thalesgroup.com, ip: 192.54.144.131, mailfrom: thilo.cestonaro@thalesgroup.com)
Received: from thsbbfxrt01p.thalesgroup.com (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 4QGb4Z49nmz45fp;
	Wed, 10 May 2023 15:10:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thalesgroup.com;
	s=xrt20181201; t=1683724254;
	bh=ncm19NG++TROcjCi2rl31fdpGdcBGRYcLVRMc6w2meI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:From;
	b=JlMDDxDX4UL87SzcnJSt9l7+2Gf2EVslwiyTSHAsdQASzliC0aujgzX40XkWt/uFQ
	 tI3Q5R8eBfMC6JOF2AlTW+itP7YHKerk0ckXnsXFZZ6q/z0f6iSVy8PP56M7VBNOri
	 c8Gwb5YzFyk0shAFp4YBuCB3s3dpBtHAnBwT8xxJIOIOJS/z1tYcrrgDfJjyvUlI57
	 PIU+Uwgc77dztDeUVk79kZo/maNTe9EMqpG7Eg4TL67fZidrROfRHblBMIEdGupmBj
	 CMb+JSjeQ8llxq5Q7VNIa847wH3NjxwZUEEhGcTOTyEKZPeBl33UPZJwnKAKk46xZl
	 lWwY5sH/kgP0g==
Authentication-Results: thsbbfxss01p.thalesgroup.com;
	dkim=pass (1024-bit key; unprotected) header.d=thalesgroup.onmicrosoft.com header.i=@thalesgroup.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-thalesgroup-onmicrosoft-com header.b=CiY9rhzk;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rb9hl7IVqjbR1xM8JPEXNHOuXzJlrgx2PfypNoIgcc+ZcxleabkxO75hj3HuwWjlxvpLoPhdPvSBNUQ6Dgm+CNYFZhI6bWIW0Bx7ZDFosO3g3TQfXrvQJ/B9DrQX3N/MSWQILPsO8gvvEUunZpITIi2aDgDM1npq92DhPeNG/KRrxXJxrv4VXfL3zWhL/8IelEB+0BUYW4Qdz4daW99ciwLCHzEfytjmQ0Vik0Am2cm/OD/FKB9vnsGBgzk6UL/fj1w7v1rNKOOK0Dk3CsqEl1UaIM9mOT5ScacyvgpBTD53hgXkpV1bki/ZLF3pGRXPwAYjgYM0sNuSUnJKoFH49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncm19NG++TROcjCi2rl31fdpGdcBGRYcLVRMc6w2meI=;
 b=jiYBPo4qRvpMMnvrBQ0TrWujkEZRkJc7JiTsLnNGsRtFBCGC98GYNNxPc65F3AeGDgy3OCh3eqyBqCpk2yLiDK7DHsTo/mB+GBJfyNPdwIz6vKjS9o1xx5YuL3yfxfxv8QVZj8XEYX4HAD1LYuPmgVw6k7ztAcxbeFVPFgq18n0VJzrm3lqP/AkgN41jTVW8w4ltU4UQAA0OVXwY1Mh6gPoVKiMLdB57p8rzrJN358nce8COkPj99pQRzNmmVpphSw3pNpXCGH6i3RA0vMEhG8gu/RenPeATL567krZx0sfuxN0yfJCaVj6F51t56UJTSPbW10+3xkQpFM0Ft/kU3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=thalesgroup.com; dmarc=pass action=none
 header.from=thalesgroup.com; dkim=pass header.d=thalesgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thalesgroup.onmicrosoft.com; s=selector2-thalesgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncm19NG++TROcjCi2rl31fdpGdcBGRYcLVRMc6w2meI=;
 b=CiY9rhzkmbE7Bf0JvW3Akjg52Bpe3RzO2rOHA3ZANd1hekU94YdYxpcEXyS7baXROc0+jHn/AznOKoJ6/jW1Cbs3OhXTjFoM5MlmNzg1qb2bMth0buA4q47xzQcivPJXgwZR3/HFHfYpPfG6AH86L4F9K5R4BvBro/Kpd55KV3w=
From: CESTONARO Thilo <thilo.cestonaro@thalesgroup.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2] bitbake: git fetcher: use urllib quote ...
Thread-Topic: [PATCH v2] bitbake: git fetcher: use urllib quote ...
Thread-Index: AQHZg0DYRC4+lIjd80eTaxXXaWTz/w==
Date: Wed, 10 May 2023 13:10:51 +0000
Message-ID: 
 <PR0P264MB1882562678B304BEBDDFC68AE9779@PR0P264MB1882.FRAP264.PROD.OUTLOOK.COM>
References: 
 <PR0P264MB1882D9E54AD24DF72B9E65E5E9869@PR0P264MB1882.FRAP264.PROD.OUTLOOK.COM>
 <b4f209d135c1dcf47253ba561ccbde128b0123e9.camel@linuxfoundation.org>
In-Reply-To: 
 <b4f209d135c1dcf47253ba561ccbde128b0123e9.camel@linuxfoundation.org>
Accept-Language: de-CH, en-US
Content-Language: de-CH
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=thalesgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR0P264MB1882:EE_|PR0P264MB2028:EE_
x-ms-office365-filtering-correlation-id: ae24cfbb-1fa1-4cce-a053-08db5157faf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 86CzKxLuY79L/Wvn47ZPDSwWIHgl9rQQE9CWiHTWGCqLnCB/6sZWW/rPsKlIMQ79JwlTymc1xzSMMgyPEyG2fkLGSte9yYNgPufibLe81paPh+YDRtHc5lF9ZnxX9jb3jR71b6mnNlI2pWKh0E5z2cWsYgedlTO/CqzctaQkny4GCkfrA1+eBz6I+7oWzzZ8epyY5E4dI+vNZFf6GdPWNGCoMI6xYVTPsRVZGa0jDaVYIvwSdUtrPjq8xA/W3p0stcnQ9EcpsCWH439+ploohKC3EXxndpIxDbOvwMx/+vQIFsHmmW4114YwaLZzl5Pwygpb+PWibw3D1x3eu6tDSP2kB2GiJlTt+YJckZ1tY5OWSk9IvkvKmA5hIm+zfMy84+fY0Dd3rqIOtR/jgAPxeOisXhDtbuOlhAGNjHrBlU32EbG3GNyP/HJG+jO91vFXn9oYFxopGPVoCdVngazmbmltPoML1qOHzZPQBjVUyuzlq/vAiT3VvEhUVKts9d6ERb9dFuEy7imWkSTJc2TZ9fZVUx59JNyeO+aISB50t8qutMCby+Ja89+YyruSPPaz3atOSheP2T3f6ekn9ZvTc0KAD2nrJFUYdu87Cnb6fzixGfbIhbj89fGdoiKxFBkF
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB1882.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(451199021)(4744005)(66446008)(8936002)(8676002)(5660300002)(52536014)(41300700001)(316002)(64756008)(91956017)(76116006)(66476007)(66556008)(33656002)(66946007)(26005)(71200400001)(186003)(478600001)(6506007)(9686003)(7696005)(2906002)(82960400001)(38070700005)(38100700002)(122000001)(86362001)(55016003)(110136005)(99936003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?//bAjXgPRGPHvcTSiRi6d8AY9OkqsYvWTJcXAQiyS3viiC/+pEjpTwsceP?=
 =?iso-8859-1?Q?qdpOD/YqXMmxdhPAPoysZpaMQpaNGoTFd6Yw7tJCGZX6FZZwsUutRCYUCM?=
 =?iso-8859-1?Q?Zg2/7ZDG9ZH+tCryU+o+hAh3BPwujSAFPEmrvgPzG2n5WS3Xy6L7U+9ikU?=
 =?iso-8859-1?Q?Dn4rpI5sSV9KSOehsHsq3F84ffxFMpZ4L6TUvd+koC4H+ggCRogux3gKQD?=
 =?iso-8859-1?Q?y5eK9fTDX5uSe67yI5WaTojWIIC3qSn7isT4cExtAoH9O73Nulk9BEcqw1?=
 =?iso-8859-1?Q?tVwlseO6Jx+xVG7YHucftmkGRy+x2PsYC137D+IQavcEUZdQZ0IZQ5PgBh?=
 =?iso-8859-1?Q?Re38I+eYbpplwur43G5nbZvYRVCBj5sDf0dXNZntMug7+hyv7Ihc8LGz5Q?=
 =?iso-8859-1?Q?PtUlc6pc4TYkIoTNxhHmFzC1RTbTGS7cjkYGDdP0i3Uiv8FFt1r9T+lcPM?=
 =?iso-8859-1?Q?iOqtlGE71UbB6mCMDGeIjvrpVdJoF0P56mFxUqCxXiSg0Xl8P/JMqu8+ou?=
 =?iso-8859-1?Q?5bBwNm2O6Vi19GYIdqFNQ7r/QdTwHOzv2/5OszjyeM8yoxqfsDg/IyMekr?=
 =?iso-8859-1?Q?UyZO9rlcuY9Zb1Lb/VrKqL2NzlrMwDZODm1Isn9AQJyIWo2GmpRYuMnID0?=
 =?iso-8859-1?Q?Ntjx69W+Q774S5Yg6AMs1ld1Js9Iqdv7CEWh52cChF7D+pdf4WOVdqdcyC?=
 =?iso-8859-1?Q?vQXepF78LO9TPtmrF7D+QVX9uGq1u7VEQjo+WiHlHGikMVQbLr6rm53FF4?=
 =?iso-8859-1?Q?Nx9c6bKB5PwdtJj2ClpgZtuiMth2wM7bTPBBuVInv3XOeKxHEB6lf+w9tm?=
 =?iso-8859-1?Q?aLuWsGL2FwRflPf44Fi++ez0KVIxvBasdxP4THCxMP6q7NcJ4msKb0ke0R?=
 =?iso-8859-1?Q?YjIwJ8+zioJXeH7qxZpUOXdwBsZmIVYyulviDJVWnvdxfBwQ3VhkLBUS4M?=
 =?iso-8859-1?Q?5M29lygzSmIelk5Exjg2ZRAoFB0Kk7D3bAnzLc8q640G/9n2jJkijkWc/X?=
 =?iso-8859-1?Q?FtQ6jIxD39PqTINC5T9zXhC/kK1U3u6Ja4fFLLDUXkLaTTN8sQRzcIe9aS?=
 =?iso-8859-1?Q?JX8Hn4CKpm4D5dINTzfxhVutf4ulDkNZqDpLwwrMYvI6XZd3oyMI+UUWcF?=
 =?iso-8859-1?Q?WEhV8oEwsanZvktAnSDyawnOF2me67QSwN7ZP4/uLII9Y9HOUa12PpLkjU?=
 =?iso-8859-1?Q?9omcVsCrQMCIULXGR/W9tnHpUCd6tQRMmT6iBDHRMCVeVXbfHBmqHTDTQl?=
 =?iso-8859-1?Q?Sd6Q4ZXbk9aP9flAB2agrzGgbqrSw7G87sbHOIeDT1N4pjrX1FfQ8OLFGz?=
 =?iso-8859-1?Q?/hvGW7w0rTPrm541GCkeXVcLXmNlW3GD5lzVzf9/ITm2qcAQXmVNHFfaMn?=
 =?iso-8859-1?Q?21zCGQ/DeM2M5tG8CXyAmlO5o+ku2jGN6q6shwIUjhf8TMGm785y9F/OWK?=
 =?iso-8859-1?Q?Nn21/z+1iXLL6+8emPdHs3KbWEOrxyeFCwuW/3XzSqotISHDgWOUmAIqPy?=
 =?iso-8859-1?Q?JLHdRUou/nFlQePsJF/NQ55RhCipW2bq6QSas0zOQdbX44I4GOPXJaJJrp?=
 =?iso-8859-1?Q?aqFlcUlVVUFbyeboQ+V52Eczxwg9BX8DKTFJwu2FV82aaPyw1MKPkB1zMc?=
 =?iso-8859-1?Q?UhmraslP6PL8vC6sgL7/JmsoCygqoF7jwRhzGwQ3GSAjAza5Oftz/kmQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_002_PR0P264MB1882562678B304BEBDDFC68AE9779PR0P264MB1882FRAP_"
MIME-Version: 1.0
X-OriginatorOrg: Thalesgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB1882.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ae24cfbb-1fa1-4cce-a053-08db5157faf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 13:10:51.7160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6e603289-5e46-4e26-ac7c-03a85420a9a5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v86hLWZ9OWRYcB2YWBiSTRe1eJtQmG3/eHFJqSJcJtJgIK6p7Q0OORdWI3HC/6jyalTYY6oUmIYq3+2epYlYWiwUZFl+lP2PvpJiyLus+Ro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2028
X-PMX-Version: 6.4.8.2820816, Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2023.5.10.130316, AntiVirus-Engine: 6.0.0, AntiVirus-Data: 2023.5.10.600000
X-Sophos-SenderHistory: ip=104.47.25.109,fs=392995,da=132438784,mc=9881,sc=3,hc=9878,sp=0,fso=131687209,re=222,sd=0,hd=30
X-PMX-Spam: Gauge=IIIIIIIII, Probability=9%, Report='
 INVOICE_ATTACHMENT 0.1, HTML_00_01 0.05, HTML_00_10 0.05, MIME_TEXT_ONLY_MP_MIXED 0.05, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_4000_4999 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, DKIM_SIGNATURE 0, DQ_S_H 0, IN_REP_TO 0, KNOWN_MTA_TFX 0, LEGITIMATE_SIGNS 0, MSG_THREAD 0, NO_CTA_URI_FOUND 0, NO_URI_FOUND 0, NO_URI_HTTPS 0, REFERENCES 0, SPF_SOFTFAIL 0, SUSP_DH_NEG 0, SXL_IP_TFX_WM 0, WEBMAIL_SOURCE 0, __ARCAUTH_DKIM_PASSED 0, __ARCAUTH_DMARC_PASSED 0, __ARCAUTH_PASSED 0, __ARC_SEAL_MICROSOFT 0, __ARC_SIGNATURE_MICROSOFT 0, __ATTACHMENT_NOT_IMG 0, __ATTACH_CTE_BASE64 0, __AUTH_RES_DKIM_PASS 0, __BODY_NO_MAILTO 0, __CT 0, __CTYPE_HAS_BOUNDARY 0, __CTYPE_MULTIPART 0, __CTYPE_MULTIPART_MIXED 0, __DQ_IP_FSO_LARGE 0, __DQ_NEG_DOMAIN 0, __DQ_NEG_HEUR 0, __DQ_NEG_IP 0, __DQ_S_HIST_1 0, __DQ_S_IP_1MO 0, __DQ_S_IP_HD_10_P 0, __DQ_S_IP_MC_100_P 0, __DQ_S_IP_MC_10_P 0, __DQ_S_IP_MC_1K_P 0,
 __DQ_S_IP_MC_1_P 0, __DQ_S_IP_MC_5_P 0, __DQ_S_IP_RE_100_P 0, __DQ_S_IP_SC_1_P 0, __DQ_S_IP_SP_0_P 0, __FORWARDED_MSG 0, __FROM_DOMAIN_NOT_IN_BODY 0, __FROM_NAME_NOT_IN_BODY 0, __FUR_HEADER 0, __FUR_RDNS_OUTLOOK 0, __HAS_ATTACHMENT 0, __HAS_ATTACHMENT1 0, __HAS_FROM 0, __HAS_MSGID 0, __HAS_REFERENCES 0, __HAS_X_FF_ASR 0, __HAS_X_FF_ASR_CAT 0, __HAS_X_FF_ASR_SFV 0, __INVOICE_MULTILINGUAL 0, __IN_REP_TO 0, __MIME_TEXT_ONLY 0, __MIME_TEXT_P 0, __MIME_TEXT_P1 0, __MIME_TEXT_P2 0, __MIME_VERSION 0, __MSGID_32_64_CAPS 0, __MULTIPLE_RCPTS_TO_X2 0, __NO_HTML_TAG_RAW 0, __RDNS_WEBMAIL 0, __REFERENCES 0, __SANE_MSGID 0, __SCAN_D_NEG 0, __SCAN_D_NEG_HEUR 0, __SUBJ_ALPHA_NEGATE 0, __SUBJ_STARTS_S_BRACKETS 0, __TO_MALFORMED_2 0, __TO_NAME 0, __TO_NAME_DIFF_FROM_ACC 0, __TO_REAL_NAMES 0, __URI_NO_MAILTO 0, __X_FF_ASR_SCL_NSP 0, __X_FF_ASR_SFV_NSPM 0'
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 May 2023 13:10:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14777

--_002_PR0P264MB1882562678B304BEBDDFC68AE9779PR0P264MB1882FRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Richard!=0A=
=0A=
> I'd like to ensure that we add test coverage to "bitbake-selftest" to=0A=
> cover this situation (see lib/bb/tests/fetch.py).=0A=
> =0A=
> We tend not to accept fixes like this unless we have test coverage to=0A=
> prevent future regressions.=0A=
=0A=
Next version of my patch. I tried to have a as simple as possible test whic=
h exactly does show what goes wrong without my patch.=0A=
=0A=
Thank you!=0A=
=0A=
Cheers,=0A=
Thilo=0A=
=0A=
=0A=
=0A=

--_002_PR0P264MB1882562678B304BEBDDFC68AE9779PR0P264MB1882FRAP_
Content-Type: text/x-patch;
	name="0001-bitbake-git-fetcher-use-urllib-quote.patch"
Content-Description: 0001-bitbake-git-fetcher-use-urllib-quote.patch
Content-Disposition: attachment;
	filename="0001-bitbake-git-fetcher-use-urllib-quote.patch"; size=2286;
	creation-date="Wed, 10 May 2023 13:09:48 GMT";
	modification-date="Wed, 10 May 2023 13:09:48 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxYmM4OThiNWUxYWJkOThkMjkzMmRjZTA1M2RjODJiM2YzZDZiM2Y4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBUaGlsbyBDZXN0b25hcm8gPHRoaWxvLmNlc3RvbmFyb0B0aGFs
ZXNncm91cC5jb20+CkRhdGU6IFR1ZSwgNyBGZWIgMjAyMyAxMzo0NDowMiArMDEwMApTdWJqZWN0
OiBbUEFUQ0hdIGJpdGJha2U6IGdpdCBmZXRjaGVyOiB1c2UgdXJsbGliIHF1b3RlIC4uLgoKdG8g
dXNlIHRoZSBwYXRoIHVybC1jb21wYXRpYmxlLiBUaGlzIG5lZWRzIHRvIGhhcHBlbiBiZWZvcmUg
dGhlIHNoZWxsIHF1b3RhdGlvbiBoYXBwZW5zLgoKV2l0aG91dCB0aGlzIGNvbW1pdCwgc3BhY2Vz
IGluIHRoZSBjbG9uZSBVUkwgd2lsbCBiZSB1c2VkIGFzICIgIiBhbmQgbm90IGFzICIlMjAiIHdo
aWNoIHdpbGwgZmFpbC4KVGhpcyBjb21taXQgY2hhbmdlcyB0aGUgIiAiIGluIHRoZSBVUkwgdG8g
IiUyMCIgd2hlbiBpdCBpcyBhIGh0dHAgb3IgaHR0cHMgdXJsLgoKU2lnbmVkLW9mZi1ieTogVGhp
bG8gQ2VzdG9uYXJvIDx0aGlsby5jZXN0b25hcm9AdGhhbGVzZ3JvdXAuY29tPgotLS0KIGxpYi9i
Yi9mZXRjaDIvZ2l0LnB5ICB8ICA4ICsrKysrKystCiBsaWIvYmIvdGVzdHMvZmV0Y2gucHkgfCAx
MyArKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9saWIvYmIvZmV0Y2gyL2dpdC5weSBiL2xpYi9iYi9mZXRj
aDIvZ2l0LnB5CmluZGV4IDJhM2MwNmZlLi4yODcyOTI0MSAxMDA2NDQKLS0tIGEvbGliL2JiL2Zl
dGNoMi9naXQucHkKKysrIGIvbGliL2JiL2ZldGNoMi9naXQucHkKQEAgLTY3LDYgKzY3LDcgQEAg
aW1wb3J0IHJlCiBpbXBvcnQgc2hsZXgKIGltcG9ydCBzdWJwcm9jZXNzCiBpbXBvcnQgdGVtcGZp
bGUKK2ltcG9ydCB1cmxsaWIKIGltcG9ydCBiYgogaW1wb3J0IGJiLnByb2dyZXNzCiBmcm9tIGNv
bnRleHRsaWIgaW1wb3J0IGNvbnRleHRtYW5hZ2VyCkBAIC02OTgsNyArNjk5LDEyIEBAIGNsYXNz
IEdpdChGZXRjaE1ldGhvZCk6CiAgICAgICAgICAgICB1c2VybmFtZSA9IHVkLnVzZXIgKyAnQCcK
ICAgICAgICAgZWxzZToKICAgICAgICAgICAgIHVzZXJuYW1lID0gIiIKLSAgICAgICAgcmV0dXJu
ICIlczovLyVzJXMlcyIgJSAodWQucHJvdG8sIHVzZXJuYW1lLCB1ZC5ob3N0LCB1ZC5wYXRoKQor
CisgICAgICAgIHBhdGggPSB1ZC5wYXRoCisgICAgICAgIGlmIHVkLnByb3RvIGluIFsgJ2h0dHAn
LCAnaHR0cHMnIF06CisgICAgICAgICAgICBwYXRoID0gdXJsbGliLnBhcnNlLnF1b3RlKHVkLnBh
dGgpCisKKyAgICAgICAgcmV0dXJuICIlczovLyVzJXMlcyIgJSAodWQucHJvdG8sIHVzZXJuYW1l
LCB1ZC5ob3N0LCBwYXRoKQogCiAgICAgZGVmIF9yZXZpc2lvbl9rZXkoc2VsZiwgdWQsIGQsIG5h
bWUpOgogICAgICAgICAiIiIKZGlmZiAtLWdpdCBhL2xpYi9iYi90ZXN0cy9mZXRjaC5weSBiL2xp
Yi9iYi90ZXN0cy9mZXRjaC5weQppbmRleCA2ZWYwODM2Zi4uZGI3OThmMGQgMTAwNjQ0Ci0tLSBh
L2xpYi9iYi90ZXN0cy9mZXRjaC5weQorKysgYi9saWIvYmIvdGVzdHMvZmV0Y2gucHkKQEAgLTE2
OTcsNiArMTY5NywxOSBAQCBjbGFzcyBHaXRTaGFsbG93VGVzdChGZXRjaGVyVGVzdCk6CiAgICAg
ICAgIHVkID0gZmV0Y2hlci51ZFt1cmldCiAgICAgICAgIHJldHVybiBmZXRjaGVyLCB1ZAogCisg
ICAgZGVmIGFzc2VydF91cmlfd2l0aF9zcGFjZXMoc2VsZik6CisgICAgICAgIGNsYXNzIEZldGNo
RGF0YUZha2UoKToKKyAgICAgICAgICAgIHByb3RvID0gImh0dHBzIgorICAgICAgICAgICAgdXNl
ciA9ICIiCisgICAgICAgICAgICBob3N0ID0gImV4YW1wbGUub3JnIgorICAgICAgICAgICAgcGF0
aCA9ICIvZ2l0L3VybCB3aXRoIHNwYWNlcy9pbWFnaW5hcnkuZ2l0IgorCisgICAgICAgIG0gPSBi
Yi5mZXRjaDIuZ2l0LkdpdChzZWxmLmQpCisgICAgICAgIHVkID0gRmV0Y2hEYXRhRmFrZSgpCisg
ICAgICAgIHVybGdlbmVyYXRlZCA9IG0uX2dldF9yZXBvX3VybCh1ZCkKKworICAgICAgICBzZWxm
LmFzc2VydEVxdWFsKCJodHRwczovL2V4YW1wbGUub3JnL2dpdC91cmwlMjB3aXRoJTIwc3BhY2Vz
L2ltYWdpbmFyeS5naXQiLCB1cmxnZW5lcmF0ZWQpCisKICAgICBkZWYgZmV0Y2hfYW5kX3VucGFj
ayhzZWxmLCB1cmk9Tm9uZSk6CiAgICAgICAgIGZldGNoZXIsIHVkID0gc2VsZi5mZXRjaCh1cmkp
CiAgICAgICAgIGZldGNoZXIudW5wYWNrKHNlbGYuZC5nZXRWYXIoJ1dPUktESVInKSkKLS0gCjIu
MzkuMgoK

--_002_PR0P264MB1882562678B304BEBDDFC68AE9779PR0P264MB1882FRAP_--

