Return-Path: <thilo.cestonaro@thalesgroup.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B32D2C6FD18
	for <webhook@archiver.kernel.org>; Wed, 19 Apr 2023 12:22:59 +0000 (UTC)
Received: from thsbbfxrt02p.thalesgroup.com (thsbbfxrt02p.thalesgroup.com [192.93.158.29])
 by mx.groups.io with SMTP id smtpd.web10.35988.1681906969372975723
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Apr 2023 05:22:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thalesgroup.com header.s=xrt20181201 header.b=MEVPSN+9;
 spf=pass (domain: thalesgroup.com, ip: 192.93.158.29, mailfrom: thilo.cestonaro@thalesgroup.com)
Received: from thsbbfxrt02p.thalesgroup.com (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 4Q1g0l3RtVzJpbM;
	Wed, 19 Apr 2023 14:22:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thalesgroup.com;
	s=xrt20181201; t=1681906967;
	bh=iuky3WJzvwzi+Q9pHhwLgIRgUJlKdIdy0Nx5eLrIo+Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:From;
	b=MEVPSN+9oTh4rR3aA9hHjOpSdQcnSlZRYpBP/E59VH7VgWABEFkvkiYjjesdZaG3G
	 9VzVuHsPJPWcJ+fwm6MgGKpCBvEoDCpo7UTO3YFR3StZZQ+anVbN60UpzvoZZZ9Kc/
	 hdc6S3A2H/zSM6U6OUZrHR3KSleFihVpU6pV6zP8KJmKsuZnxFsWMkBvX0aOFLuNSY
	 +bE6KTw6b2RaBqRberaPB58qfB+Dl/QBitS0SFhpDbOOeGRkzhvoi/KahMzsa8x0ue
	 AHBZj4I1p36sC+5CCd6u5ayO4u+xAPsfxkxcq8irsN2eh3gbbQ56d5nEJ6fWsR4lp+
	 WF+KuWoZmq1fQ==
Authentication-Results: thsbbfxss01p.thalesgroup.com;
	dkim=pass (1024-bit key; unprotected) header.d=thalesgroup.onmicrosoft.com header.i=@thalesgroup.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-thalesgroup-onmicrosoft-com header.b=GvVwPMWJ;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3VYe6LaTgh8HUeHkBVWJr45BdoAh+3NhgtjHZgZ2E9MaBtVJaAWFyXOsMy5ocKlIzhzGSdDY7sPKl/gpmeezIas8xzRvc1iLzyQMDR/wJGOKRj0hW6kF8/AspA5nFO4E31pfHABTAZpp8irZPH7gy0iwsiCjD7jbiFP+PPmjAhKIl/i5bG9l2os8cfjcWkHLYDC6ZpJLXUELlS7qGZkuPLx1YAKx9XmdQS+5cO8mAqpyK8AW/eI8oksbiDwH6ZiK6eidJgu9WdShanh45jOlmYhEI17QlAMrN8rHT68RnfqZwkt9Mtw2F85mA8vvu0Z0IbNT0lBKT4JiMEct8oJiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iuky3WJzvwzi+Q9pHhwLgIRgUJlKdIdy0Nx5eLrIo+Y=;
 b=P6a/Oq4u3Xmo/FNfd62d4XlZzd8RUWAfzCJvIBT06h5Vnf+x1N2DCfpWS9v3VID9FXXaFZPUSW2eRcRbbc5lTcPmtb9KdUC3gnyciUnyDsO4GByIIe50K1unTfLeoArF+E1HqbAy55lT1JkNz6t0ZULFbJmIwfzsR5hgB/jretBzK51kMwR30l0XCJQ9bAtAWlObsmNpZsOMUUvYhxlz5V/AswjGprZP6aROh3s2Su8G3vtF8YH7S7UTUnESxj0CMvvh5/eG/oeCOnhP7GKH5yw/uL8il1HB8yOQgmW5MpfG625+mnljj8GbRqPMTFcioQ9LGejp2lDf7Gkx+bEcfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=thalesgroup.com; dmarc=pass action=none
 header.from=thalesgroup.com; dkim=pass header.d=thalesgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thalesgroup.onmicrosoft.com; s=selector2-thalesgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iuky3WJzvwzi+Q9pHhwLgIRgUJlKdIdy0Nx5eLrIo+Y=;
 b=GvVwPMWJB6w/MWSiskQJLsYhFZOqi5sa7h04/+txqgU+pT1qS3mi4W/Wlk3opqPUWj/9HXrBseF0bpuBU1CwKzIfhfeNw0mU6Aofy39D7/hTZx/RVoCRIHR6D5gqmHAq1Vfwa09mLeU8we1CGafrfpWjMjXbkneN+eFoNhALxAo=
From: CESTONARO Thilo <thilo.cestonaro@thalesgroup.com>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: AW: [bitbake-devel] [PATCH] bitbake: git fetcher: use urllib quote
 ...
Thread-Topic: [bitbake-devel] [PATCH] bitbake: git fetcher: use urllib quote
 ...
Thread-Index: AQHZXJldf+QDsiopm0ivvHOyUnSaEq8GnCIAgCwdJSo=
Date: Wed, 19 Apr 2023 12:22:44 +0000
Message-ID: 
 <PR0P264MB188270D04F76005A7793A012E9629@PR0P264MB1882.FRAP264.PROD.OUTLOOK.COM>
References: 
 <PR0P264MB1882D9E54AD24DF72B9E65E5E9869@PR0P264MB1882.FRAP264.PROD.OUTLOOK.COM>
 <29be3de3-8f66-6773-91c6-f0463d180d52@bootlin.com>
In-Reply-To: <29be3de3-8f66-6773-91c6-f0463d180d52@bootlin.com>
Accept-Language: de-CH, en-US
Content-Language: de-CH
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=thalesgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR0P264MB1882:EE_|PAZP264MB3023:EE_
x-ms-office365-filtering-correlation-id: f7e4918b-0a93-42b9-6ab5-08db40d0c756
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 SsktDeAxSc+OjoNf0fwxFjwqxrBaLZs4pHRKpuxa+cSPzi2FQvltXugPqqG1kb4knlrtr2qbbnlMLou3QikhYhtUT+9KGkwKred7FmG1YmL6EgVLgEHMtaCTzIVVIVAUBf2lVoRuhE6Dlqb1oNsQrODufjCPQ2nbPI2IVpe7JX9mAgsVLG9eXRizjNPEHnueC0OAadMAbhtqfwLkSSR3dYJPTwzgM6DIEhW7WZHOMpw2gtw1AVaftkG2kXyVZ6PRNIoGsFmfmaKTS0SiFtRJhLlHU20zxgImnN2sBz1AA1VBdix3CMV/9s8DRA+BNDw3KzDBq+eaJJPGUcMOkk/UQc6KWbtZBmM6Jm6fuOsMLcfX/w7IxZ7tk/wZfzglOuujIANpwvkCm42NgIiJXi0YIsvIgsE3qUABlQJK50kLIN9MbYSRi8oF5tCgJd3Ha5dY3xu3h6aEuE/s0TfnKGq8gCxmLjZ5Hkq2Gr/RXjLCCOpJvILzvQUC6AvW4L2cB2xSpf7MGXptvXxot1P/r/6fDxl1CCyjwP0CT2TzNQMlib0=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB1882.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(71200400001)(53546011)(9686003)(186003)(26005)(6506007)(7696005)(2906002)(66574015)(966005)(5660300002)(41300700001)(64756008)(4326008)(316002)(6916009)(66446008)(66476007)(66556008)(91956017)(76116006)(66946007)(8676002)(8936002)(52536014)(478600001)(45080400002)(82960400001)(38070700005)(38100700002)(86362001)(33656002)(83380400001)(122000001)(99936003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?gxL6ojPvS4BkyADDmgnuE0ytLMqSWgeh0UkXi0r3ad9xlGTrfiRhYE3RjR?=
 =?iso-8859-1?Q?Utwzc4yk5d4U9bqlLLsL+61dCTaWLb4T15LVTNNYCVrB4VBCmFZaKxiP8M?=
 =?iso-8859-1?Q?u8waf09K/LS4wWXgGMoUDHJrittwhudY5V2u5ps8Ztv0QcvFnQWz+BVupW?=
 =?iso-8859-1?Q?m1L49bdx1TQOXVf6agrYc2WVyRtdG6NGde9rNJx9EGv0gmV2oJ3F5v98dY?=
 =?iso-8859-1?Q?S1XItSSe/lNeSYW3Z9xJ3h/k4wWMqpbA/JQsXnWn3o27I/buhlaMTDWaLv?=
 =?iso-8859-1?Q?9TjJEHkjAdXvF9esLfr0f1TKZrxkvaQzyYJUuBfgM07TSt0r+RD6m0u9Lc?=
 =?iso-8859-1?Q?+l3aqLRr8KyIIVx1CKTVDemSQ15cvgTaUN2YbLk36aYoN6gwyUSkaXLVUs?=
 =?iso-8859-1?Q?Em7Ckns0nDRmlbHfMX035NkGcUR5qoa25vSgyyq7ZdpoGby7YFOOPCKAMy?=
 =?iso-8859-1?Q?WSNFUqloFX/sbFxzI+OVJE6KqTHoqnSKYKwKCt29sn3vbmgTFv/Ulgo1cm?=
 =?iso-8859-1?Q?inkF0S+As56HtlERvi8jlFx81etRg4eIuuxeNDDJm4aQdZiBsygf4SFjkP?=
 =?iso-8859-1?Q?RS3996MbwYlwTtMqkzhDahBl/h91Hn3XEBRwZegoRTDMhaeo4lYi4rDKAn?=
 =?iso-8859-1?Q?NbGnUqXjz/o3J/ohmPCjAVeITZFCliDaOxMd42/d7LIqOZ0c1j4izdAfnm?=
 =?iso-8859-1?Q?kj0BOc1XHAGIw0oKrfw+ncHcq2CpSU/snssbM15FD2iDG1nmn4I/xbSCr4?=
 =?iso-8859-1?Q?BXdDl400uQJ8B7fu3XCQiJGtcmHaiGpiYedyhHce0eVdUzsq/WJZIJ9Yfw?=
 =?iso-8859-1?Q?E4EE+iZN3pFHDEna+72Q9QX1nkpSuYwuvNc/3RzJkmroEg6IQgxTDIbo//?=
 =?iso-8859-1?Q?o7Td7ZEkE9vD7xPuC99Kr1yVE8Nj3LpDXFRYdy/MS9FaOvcT+yFIvwndhC?=
 =?iso-8859-1?Q?ud25I7+DDtCg4FdvN5nOAydSXzzQWFS/Hc/hPcY5c+NFwkj+Q/1PfQJcwp?=
 =?iso-8859-1?Q?S+QHbidZ5sFlVLNTUnfqineWVaV1ySNqmrDgS9+m/gJ9I+WKSvLwfeThdL?=
 =?iso-8859-1?Q?wS316rBgRv7FjFWNE3w9i0k1DopavYBLcIax0L7XJP41ok1wz5fbJap2OF?=
 =?iso-8859-1?Q?AdSEJQZOXuboBW0Nn9vialz9E+8uG9KlTaPTmprlivDzGuOAESIUHX761+?=
 =?iso-8859-1?Q?jDHlAZtziobtbVBIkZOslAdlloRexYHRPed8Gd9ek5i7ym7dqwnDwWWYfE?=
 =?iso-8859-1?Q?gKyiFCLS9StcAIB2/HsADApHDSbfYA8gBPVtQApWUg2SA0uXSOEBdit6Gz?=
 =?iso-8859-1?Q?Fsfx9cu4b2ailXP1+TUpWuRiwtiKkzF8HDjTItFPyEswm0s6wkBUugWrp5?=
 =?iso-8859-1?Q?js6/v4L1raqt7YPiP3JdfYRUD9tGMcrDW3NSGjnL6THJg6jF7O0coeDmar?=
 =?iso-8859-1?Q?c19sbgvAmgtbvx0qbu1ymrdOkL9HVJ1Wf887o2QNbTO2XqXeNdkYlpz+/F?=
 =?iso-8859-1?Q?rkFcfeSg1MGoqfdQlVfYFRJUANLiF9REP0KkLe0cPOuACrr2OKte2JMlaq?=
 =?iso-8859-1?Q?dXFoNKgxS8XDTsD/b3sIz4MyAtlr3lvSFXPpmqk5c/G5lJjLMFYZ3WGozj?=
 =?iso-8859-1?Q?5kD/Jg7lCpGaG0aMuvpkRqUjc4W2ORSpMhdL/K/v5GyOQOGtCjti7FvQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/mixed;
	boundary="_002_PR0P264MB188270D04F76005A7793A012E9629PR0P264MB1882FRAP_"
MIME-Version: 1.0
X-OriginatorOrg: Thalesgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB1882.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e4918b-0a93-42b9-6ab5-08db40d0c756
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 12:22:44.4277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6e603289-5e46-4e26-ac7c-03a85420a9a5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A2EwxBTj8f2KLMUmYKbkHmi55XkhXo+lR/b5SWZLNu8mg4qhGEGR9r9tDJsNpEABk4Bxk4GMc8fWKH0gMQ6LUfK1ImOTWAJNaieFD2mxldg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB3023
X-PMX-Version: 6.4.8.2820816, Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2023.4.19.120917, AntiVirus-Engine: 6.0.0, AntiVirus-Data: 2023.4.19.600000
X-Sophos-SenderHistory: ip=104.47.24.108,fs=562944,da=130621497,mc=19478,sc=5,hc=19473,sp=0,fso=130119437,re=158,sd=0,hd=30
X-PMX-Spam: Gauge=IIIIIIII, Probability=8%, Report='
 INVOICE_ATTACHMENT 0.1, HTML_00_01 0.05, HTML_00_10 0.05, ARCHIVE_ATTACHED 0, BODYTEXTP_SIZE_3000_LESS 0, BODY_ENDS_IN_URL 0, BODY_SIZE_3000_3999 0, BODY_SIZE_5000_LESS 0, BODY_SIZE_7000_LESS 0, DKIM_SIGNATURE 0, DQ_S_H 0, GZ_ATTACHED 0, IN_REP_TO 0, KNOWN_MTA_TFX 0, LEGITIMATE_SIGNS 0, MSG_THREAD 0, REFERENCES 0, SPF_SOFTFAIL 0, SUSP_DH_NEG 0, SXL_IP_TFX_WM 0, WEBMAIL_SOURCE 0, __ANY_URI 0, __ARCAUTH_DKIM_PASSED 0, __ARCAUTH_DMARC_PASSED 0, __ARCAUTH_PASSED 0, __ARC_SEAL_MICROSOFT 0, __ARC_SIGNATURE_MICROSOFT 0, __ATTACHMENT_NOT_IMG 0, __ATTACHMENT_SIZE_0_10K 0, __ATTACH_CTE_BASE64 0, __AUTH_RES_DKIM_PASS 0, __BODY_NO_MAILTO 0, __BOUNCE_CHALLENGE_SUBJ 0, __CC_NAME 0, __CP_URI_IN_BODY 0, __CT 0, __CTYPE_HAS_BOUNDARY 0, __CTYPE_MULTIPART 0, __CTYPE_MULTIPART_MIXED 0, __DQ_IP_FSO_LARGE 0, __DQ_NEG_DOMAIN 0, __DQ_NEG_HEUR 0, __DQ_NEG_IP 0, __DQ_S_HIST_1 0, __DQ_S_IP_1MO 0,
 __DQ_S_IP_HD_10_P 0, __DQ_S_IP_MC_100_P 0, __DQ_S_IP_MC_10_P 0, __DQ_S_IP_MC_1K_P 0, __DQ_S_IP_MC_1_P 0, __DQ_S_IP_MC_5_P 0, __DQ_S_IP_RE_100_P 0, __DQ_S_IP_SC_1_P 0, __DQ_S_IP_SC_5_P 0, __DQ_S_IP_SP_0_P 0, __FORWARDED_MSG 0, __FRAUD_REFNUM 0, __FUR_HEADER 0, __FUR_RDNS_OUTLOOK 0, __GZ_ATTACHED1 0, __GZ_ATTACHED2 0, __HAS_ATTACHMENT 0, __HAS_ATTACHMENT1 0, __HAS_ATTACHMENT2 0, __HAS_CC_HDR 0, __HAS_FROM 0, __HAS_MSGID 0, __HAS_REFERENCES 0, __HAS_X_FF_ASR 0, __HAS_X_FF_ASR_CAT 0, __HAS_X_FF_ASR_SFV 0, __HTTPS_URI 0, __INVOICE_MULTILINGUAL 0, __IN_REP_TO 0, __MAIL_CHAIN 0, __MIME_TEXT_P 0, __MIME_TEXT_P1 0, __MIME_TEXT_P2 0, __MIME_VERSION 0, __MULTIPLE_URI_TEXT 0, __NO_HTML_TAG_RAW 0, __RDNS_WEBMAIL 0, __REFERENCES 0, __SANE_MSGID 0, __SCAN_D_NEG 0, __SCAN_D_NEG_HEUR 0, __STOCK_PHRASE_7 0, __SUBJ_ALPHA_NEGATE 0, __SUBJ_REPLY 0, __TO_MALFORMED_2 0, __TO_NAME 0,
 __TO_NAME_DIFF_FROM_ACC 0, __TO_REAL_NAMES 0, __URI_IN_BODY 0, __URI_MAILTO 0, __URI_NOT_IMG 0, __URI_NS , __URI_WITHOUT_PATH 0, __URI_WITH_PATH 0, __X_FF_ASR_SCL_NSP 0, __X_FF_ASR_SFV_NSPM 0'
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Apr 2023 12:22:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14720

--_002_PR0P264MB188270D04F76005A7793A012E9629PR0P264MB1882FRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Michael

Sorry for the late answer.
I'm currently trying to be able to directly send the patches via Git but ou=
r IT does not allow it.

So here is another try with Outlook. And hopefully it does not change anyth=
ing, like last time. As I think it was Outlooks fault that the patch did no=
t apply.

This time I gzipped it. Hopefully this is ok for you!

Cheers
Thilo

________________________________________
Von: Michael Opdenacker <michael.opdenacker@bootlin.com>
Gesendet: Mittwoch, 22. M=E4rz 2023 11:40
An: CESTONARO Thilo
Cc: bitbake-devel@lists.openembedded.org
Betreff: Re: [bitbake-devel] [PATCH] bitbake: git fetcher: use urllib quote=
 ...

Hi Thilo,


Thanks for the patch!


On 22.03.23 at 09:37, Thilo C. via lists.openembedded.org wrote:
> to use the path url-compatible. This needs to happen before the shell
> quotation happens.
>
> Without this commit, spaces in the clone URL will be used as " " and
> not as "%20" which will fail.
> This commit changes the " " in the URL to "%20" when it is a http or
> https url.
>
> Signed-off-by: Thilo Cestonaro <thilo.cestonaro@thalesgroup.com>


Oops, are you sure it applies to the latest "master" branch? I tried and
it didn't, though I don't see why...


Another issue with your patch is the commit author name, which will be
"Thilo C. via lists.openembedded.org
<thilo.cestonaro=3Dthalesgroup.com@lists.openembedded.org>" instead of
"Thilo Cestonaro <thilo.cestonaro@thalesgroup.com>".


See
https://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded#Fix=
ing_your_From_identity
for details and a solution.


Don't hesitate to try to send the patch again to me privately before
resending to the mailing list...


Thanks again
Cheers
Michael.

--
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


--_002_PR0P264MB188270D04F76005A7793A012E9629PR0P264MB1882FRAP_
Content-Type: application/gzip;
	name="0001-bitbake-git-fetcher-use-urllib-quote.patch.gz"
Content-Description: 0001-bitbake-git-fetcher-use-urllib-quote.patch.gz
Content-Disposition: attachment;
	filename="0001-bitbake-git-fetcher-use-urllib-quote.patch.gz"; size=778;
	creation-date="Wed, 19 Apr 2023 12:22:38 GMT";
	modification-date="Wed, 19 Apr 2023 12:22:38 GMT"
Content-Transfer-Encoding: base64

H4sICH7aP2QAAzAwMDEtYml0YmFrZS1naXQtZmV0Y2hlci11c2UtdXJsbGliLXF1b3RlLnBhdGNo
AJ1UXW+bMBR996+4ilQlER8BkpIErVOnTtkeVmlaO+2hqiobLsErwcw2ayvtx+8akqYP7UsBgX19
zvHx9TUbrXYQYcHzZMXT1Wmez9fxIk14Eq9Fma95mgqBBZbL9LSAS9XAFbYQLyGKsv6BJIpitiGZ
DK4rWSu4QGNVw7WCD9YFwvwQOLcVr9FsteraMFe7j+wzt0i8Dn1YwgYFqSVziOfZYpFFCXhRHEXs
qhO/MbcZ3Hz/dH3x9RaEtILfE3ErLZRo8wp1Bp1B6HRdSwF/OmURwjBkzKp+wFYILbeVQwQ0NbWl
qDF0ng00iIUBgla8bbEBgaXSA8lUWNe9IDFo+QPCkPIvaSvVWUKRAknupPXBtJyWC7LpyXmtGoSf
P77BgyQVgc5LAdzAiG7eFNAo23dPkmgED5XMqwFaclmH7PooDXnFmy1JO13H3k/hxMn4QYDME5ZY
HCprW1C6/xq3bvJ8JbcNFoEqy0A8vWfDgiBgQCmeCTHrM5/MaBPC9gn+wQq84SJIDKWscW+6cLsr
G4PapdBMvKlPgAJrdP1JMGWskGUJQeA2lM9e1RevhplsCnyEhM/zKC0xDJPVMlknixioctLFwhl+
Q5GR07dUz88hSJd+Ch69l0BduWuVtqCRHZqmqvHx2OtEqxVlzjyHLO5alwXm7QNDdT6Pi5fNkNhb
3dNLdyZz1Vh8tK6a95h9ZMcbvkU9WFyvyJ2Xrtd+nDiXec2NgS/STjZuPZdIJVpMMwYvL6pB3fAd
whl0Reh64MH4fHxEYW3wbdJoxIJDWKPtdEPlZ7LZ7MS4ewQnMCFhWpBV/jPRd5NVyti+4c7ilHnM
Owj1h/PsMHSMyxIOWq7kb2Ds6nnsD18zhtvsCH4p1OeaxLTBsP8fTF6b9l3+BxUYEkT/RrjT+Fca
quW7e3yaGKxLh/aBHkd9uQEjl70AWBLOl2HC2H/WYiRSgQUAAA==

--_002_PR0P264MB188270D04F76005A7793A012E9629PR0P264MB1882FRAP_--

