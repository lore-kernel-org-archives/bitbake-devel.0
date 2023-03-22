Return-Path: <thilo.cestonaro@thalesgroup.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FEFC7619A
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 08:37:22 +0000 (UTC)
Received: from thsbbfxrt02p.thalesgroup.com (thsbbfxrt02p.thalesgroup.com [192.93.158.29])
 by mx.groups.io with SMTP id smtpd.web11.37675.1679474240805521304
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Mar 2023 01:37:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@thalesgroup.com header.s=xrt20181201 header.b=RrMxW1Yh;
 spf=pass (domain: thalesgroup.com, ip: 192.93.158.29, mailfrom: thilo.cestonaro@thalesgroup.com)
Received: from thsbbfxrt02p.thalesgroup.com (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP id 4PhMKV2s8rzJpw3
	for <bitbake-devel@lists.openembedded.org>; Wed, 22 Mar 2023 09:37:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thalesgroup.com;
	s=xrt20181201; t=1679474238;
	bh=gOAN3G8N0AzvAeGa1I/VMpbL3kKjZHAtzEErnWODwic=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:From;
	b=RrMxW1YhgAmyw5kudjs5vdccMTkqhLWWMnD0LeOpACk3ePJqrstSVVU80PQf9axv3
	 du7qLOlA4OorooxkpcBtym9cUBnif2E4WGiV6xpYDvno9CSKTakh/Mxm5RXnPQXhZF
	 dkfrywqmii8qC8Aj2Nps93mlkoQFimdY8nQOyRiZUpYC9uvjcgR9i9ccmGwH+1h4aN
	 svngOflXjTDJWcWBejVPZlUwtGNYQkGngQZPwthL88j+5PVG5/U7nzxr+H9WudE6bS
	 Bob8TIr9r02sXBP/Qa6SiBZXulxgEktHwyMLATUYno/pys/6hzJT1RgBmFueGRZXWB
	 dPJY79kXcfjTA==
Authentication-Results: thsbbfxss02p.thalesgroup.com;
	dkim=pass (1024-bit key; unprotected) header.d=thalesgroup.onmicrosoft.com header.i=@thalesgroup.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-thalesgroup-onmicrosoft-com header.b=Hr0lO9b3;
	dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ty/t8ByiMNpVs8duyXFxC/c7Gm/zH5+fqZGr48sctVCSMJVu5H+8+LtORXNbj3z837ejnAsKVlAxbprJRlZYtGS4OU9ioQUcXUd5lQXuP1LNzxrZdQqA9gJwCLePS1g1C4X6jXAKhc/ECVgELQJ3DYJ6Km3TDTbmpqlYQ0hIClQaXhdYlMKasRFHbDrD+qJK1vmyNo3GZam3q1flB3PqLLfqPbAv7OWMYaae7RgFt48Wfy2c90zgXWi0Re77O2H4q07cibV2C/Ea9RcFNcq/SZt4QvDb7gGi2LM41OtjeyTh4NU8q1Cn+ciUmrfqHseP2W6ntwe9W6zLRrt+YfSiug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOAN3G8N0AzvAeGa1I/VMpbL3kKjZHAtzEErnWODwic=;
 b=n4bu+qFwBHHMTd56cmhzl+aNLXr/DFVARaVe+o1E4v2Udayn4yH32WjHQaMQFgAkBV2ckAoL1qiIjNUzbC/ai3z2+ySoSRkt9JsxGcISr2AI87Dqav1EIFBH0wmmP/oaQevX/wbDv6uAaUHl5G3wkGVXYTr6ZU3kLXGCVRX62zaJ3f8rsmJbwEPzvLY2F7zWA06QSZua29IMUsjQFFAyCMRLkulxfsLwNR/neTA7ijI0uW7Dxe5u7KLSRVJVfeZkvVkckW03Mv39jS+jZ9p+NSBwl9y/DAUuzE83D6AQK8jpf8NHq+4nqKnWH+AAUMhxadrrQxYey5jYggx24WjPqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=thalesgroup.com; dmarc=pass action=none
 header.from=thalesgroup.com; dkim=pass header.d=thalesgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thalesgroup.onmicrosoft.com; s=selector2-thalesgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOAN3G8N0AzvAeGa1I/VMpbL3kKjZHAtzEErnWODwic=;
 b=Hr0lO9b3CgrPOd4ReayRLK+LeEFh7USrWfQRSa3ty2kfjjggj6fNIoSmNHlGVtjfYQYzNJQViqdF7o2auv7E1yPrnKa79IO/Q1Ux5AHZmTdBg9wEoAd5ktxVfh8q2yvhaeEiFIobSnQL81x11H4gMdpTRo3N0yU0DylRo+w0upc=
From: CESTONARO Thilo <thilo.cestonaro@thalesgroup.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
CC: CESTONARO Thilo <thilo.cestonaro@thalesgroup.com>
Subject: [PATCH] bitbake: git fetcher: use urllib quote ...
Thread-Topic: [PATCH] bitbake: git fetcher: use urllib quote ...
Thread-Index: AQHZXJldf+QDsiopm0ivvHOyUnSaEg==
Date: Wed, 22 Mar 2023 08:37:15 +0000
Message-ID: 
 <PR0P264MB1882D9E54AD24DF72B9E65E5E9869@PR0P264MB1882.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: de-CH, en-US
Content-Language: de-CH
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=thalesgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR0P264MB1882:EE_|MRZP264MB3098:EE_
x-ms-office365-filtering-correlation-id: 208bc9cf-6335-485d-7963-08db2ab0a3c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 sLBjsoBQx3vH6G5joVEEpA0xYURGDrt6tfgzzyau38EYOMk6Ru2m3jNvzP1lsXpJt5VYSN8ZuQ7nCkRwLexU9QiFOsg9mbaccz1EM4QYxMe+77LbxZs5AKsvK6eYzYlQHShPKriaqQXZ108RdesDioY6bG2T0xd52kVKh2DLHi2ylAyNQ+TG732AjxJPbbFW1/ZzerfTKB0SMd4tFmMoZcClbz33QY15BcF82czjJt6tlaqj4mpb3mPt9m1/BVxGCSQMbD0v5DBnAjvCufY91Sy69+vtL4jQADA1EOuQ3zPqGS05X7tUpxHVcJGa6XHvmLhSS/7D7FgHZ+ZDQPKeyvSytOtYJDQuEVbBAS/hkfwNAF3OsQtEMr1iVsdkk9nKSv3K03ptyZU6284QCIsTWMbtpatwTesDb5auOFJGwu6dFO0B3gEKUVw9+CMNwNej7OS4OvfxxusLE8KYwRRGRCjD+V/f7jqsehscSIHEGtjnb2ZvBaZBRk8EH738XKxD56rMzOIqNrYX4Ifl987Zy7abGmlkAr0XkRrvt/auvVNAeNmhBj27AfSgKwJUjyFlDro/YPVVnOKZQ3JBl1yPd+Gi31i+Rri9srJX71IV8dPCCZw29v9qP2mwYSbFhHnEeIrAa726fzJBKvCu0aa4U0uXGBP4Zadi42DHqdFG72Fz+tjGGt27LOqzcOltIUs0TGXGqb+DduWc2DsrDTeHhw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR0P264MB1882.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199018)(52536014)(8936002)(5660300002)(41300700001)(55016003)(82960400001)(33656002)(38070700005)(86362001)(38100700002)(122000001)(2906002)(4326008)(186003)(83380400001)(478600001)(107886003)(7696005)(9686003)(71200400001)(6506007)(26005)(19627405001)(316002)(8676002)(91956017)(76116006)(66446008)(6916009)(66946007)(66476007)(64756008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?CKezBTx0WJx9xtouH5Rg9+pVjlqBcERfOZ1Lar09FQDCd9OZpAzfK3rM/M?=
 =?iso-8859-1?Q?Qw5xqnIQMUhOy5AWj/8QURcaMdlCDoffZNMVDbNSNltwPDnxr4Cs3J3R6z?=
 =?iso-8859-1?Q?2LtY7MJtLBUvGKV//NXR+pj7g28Ee5V59M2FsYF8wtQtyMe1hbUe5Qv52S?=
 =?iso-8859-1?Q?D8ipyqftAcnr6D/JMPOQ8OpJNH0wa0H2fafVrfsGZ3ush7lAE8Fviq7Ks9?=
 =?iso-8859-1?Q?laSqE0knsKSFP88B5GJKheJIxJKM/UL6SK69tXH0RYLPqGMP/poYC9M4sW?=
 =?iso-8859-1?Q?IBgXUXyDdlG6trrR9jVUIVKdRvqndTgyvnJyDw7hkH0HSKE2VjIsWb1Tfc?=
 =?iso-8859-1?Q?8pBTNH82FzCWkmnXWSM7IYJmWaSFQ7moSHS4zqCCGgFH6ARd4A/NpvJGYd?=
 =?iso-8859-1?Q?LedQsLds4XxJ6ux3phFJuDG0a59t/Tql4myzbSUtI8/MtRlXwrve4He7Ok?=
 =?iso-8859-1?Q?S4+EpSfA6ZEx2mBmLPmnpxtDGKTb4rfEvnEBFU1dtLFg3UshhtD9m7ag5x?=
 =?iso-8859-1?Q?K98aUGlb+C28pBn0bbmt+Zy6UF+AsViSqbT6trP5zbvD0aI3XiH6E5MHm2?=
 =?iso-8859-1?Q?Z4AyuPs7SzVXoO3GgEBgN7o1tiDoaXd4pUQjQPgLq8h/Adaa9zU45yUzD/?=
 =?iso-8859-1?Q?n73jJ3r5sNVJdE345aBOuNGu+PZiI98ewGgwOSAmOUBjTX01HXGQZfR5w+?=
 =?iso-8859-1?Q?UGvSLDPsUSqXTggT3gCoajNko4H05sk/ek6XbxHnb6i3+1ZK7G+yKe/8M+?=
 =?iso-8859-1?Q?NrrKRTlANPf8ehijFVOWotVC62LwicIwKJbVfRT4tPmzOQXqkvof4StzGZ?=
 =?iso-8859-1?Q?0CzkiLksKauafy4qFEYpJw82RF8WG+Urr1ttaRAPAZKPxq079ysJh+2MdX?=
 =?iso-8859-1?Q?R2PtvSbBv+9n2OZQ9tsrCWfmDwr8uPfqeAU0yBzdo5PsD3k5DSOx3c1uWn?=
 =?iso-8859-1?Q?Vt99oy2dkULVM3vboHywUbm+N6wcazOOlTfjlV9/secOIiI3He2j3GsFAv?=
 =?iso-8859-1?Q?2zUO7h5i0s+XydRgiDC/RdQX7HH1u/cbP3BbmR7eT96BjxjYzMgoRYdWz+?=
 =?iso-8859-1?Q?QZhqWKAw93YKUFptOxoMuzEsmCDCn8QeP2s8UVa73uehxIPQVt93xp/e7M?=
 =?iso-8859-1?Q?V0xy5XTwei2ZwV5+KyQ/vCT4c0Y/Yrtl3V0YBSYIU4HcybxAQHF89yMs5J?=
 =?iso-8859-1?Q?Ej0Vra8KzXJCXGAQo5jZYbK9F2/vqS0SSJw9k2gfyTL/7kxDX+bRottl5a?=
 =?iso-8859-1?Q?82ePUzDzN43Kdc+liXiO6hD8cizJlqECs4bZxyshNv6TVFgf9owQyuH84y?=
 =?iso-8859-1?Q?mK4MxPYB/IYkLK3RV4EXUS7YRQouMQfDUHiNhybg6NVdk1xdHXgDes8T9t?=
 =?iso-8859-1?Q?IGF275QK+sIrWbikm5E+fMpLNksjiHYPnL4JSCx1rGNIaB5K420ek9h88P?=
 =?iso-8859-1?Q?+ekdLEaWiNT9847sv0dcWJGCjyKntLrszmCX+wdxPzDhNt4ckh18IdOdpG?=
 =?iso-8859-1?Q?qyc9+ZnDFBB6F03D1DwD0bdHiaFU6mMw6BLjXKm0ikjJMz3hsTYo2+rdrx?=
 =?iso-8859-1?Q?hW8saWB7HpXPvsNc4NXKfaWOPWIzpw/+fsvuiE/sGDbbs0hH4QJMXgn/m3?=
 =?iso-8859-1?Q?VZFZM8w07it6tUuMPrtZty+BqQiPf62jIo3t1l4SfI6o+rO08tBc29+w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_PR0P264MB1882D9E54AD24DF72B9E65E5E9869PR0P264MB1882FRAP_"
MIME-Version: 1.0
X-OriginatorOrg: Thalesgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB1882.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 208bc9cf-6335-485d-7963-08db2ab0a3c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 08:37:15.2655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6e603289-5e46-4e26-ac7c-03a85420a9a5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aShlKuk1jPURqjOpuM4FVpsDGKUlSyF/Gb0gIS/BS+tGovPxazLIoxmsMJgxq0o6fx1cpNjAvQgip8Blv2Pv9Lz7oTJeqFt35hTpvGHEENM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3098
X-PMX-Version: 6.4.8.2820816, Antispam-Engine: 2.7.2.2107409, Antispam-Data: 2023.3.22.83017, AntiVirus-Engine: 5.98.0, AntiVirus-Data: 2023.3.21.5980001
X-Sophos-SenderHistory: ip=104.47.24.105,fs=27340,da=128188768,mc=800,sc=1,hc=799,sp=0,fso=127156493,re=155,sd=0,hd=30
X-PMX-Spam: Gauge=X, Probability=10%, Report='
 OBFU_SHORT_10CHARS 0.5, HTML_50_70 0.1, HTML_NO_HTTP 0.1, BODYTEXTH_SIZE_10000_LESS 0, BODYTEXTH_SIZE_3000_MORE 0, BODYTEXTP_SIZE_3000_LESS 0, BODY_SIZE_5000_5999 0, BODY_SIZE_7000_LESS 0, DKIM_SIGNATURE 0, DQ_S_H 0, KNOWN_MTA_TFX 0, NO_CTA_URI_FOUND 0, NO_URI_HTTPS 0, OBFUSCATION 0, SPF_SOFTFAIL 0, SXL_IP_TFX_WM 0, TEXT_DIRECTION 0, TEXT_DIR_LTR_ONLY 0, TO_NAME_IS_ADDY 0, WEBMAIL_SOURCE 0, __ANY_URI 0, __ARCAUTH_DKIM_PASSED 0, __ARCAUTH_DMARC_PASSED 0, __ARCAUTH_PASSED 0, __ARC_SEAL_MICROSOFT 0, __ARC_SIGNATURE_MICROSOFT 0, __AUTH_RES_DKIM_PASS 0, __BODY_NO_MAILTO 0, __BODY_TEXT_X4 0, __CC_NAME 0, __CC_NAME_DIFF_FROM_ACC 0, __CC_REAL_NAMES 0, __CT 0, __CTYPE_HAS_BOUNDARY 0, __CTYPE_MULTIPART 0, __CTYPE_MULTIPART_ALT 0, __DC_PHRASE 0, __DQ_IP_FSO_LARGE 0, __DQ_NEG_DOMAIN 0, __DQ_NEG_HEUR 0, __DQ_NEG_IP 0, __DQ_S_HIST_1 0, __DQ_S_IP_100K 0, __DQ_S_IP_1MO 0, __DQ_S_IP_2D 0,
 __DQ_S_IP_HD_10_P 0, __DQ_S_IP_MC_100_P 0, __DQ_S_IP_MC_10_P 0, __DQ_S_IP_MC_1_P 0, __DQ_S_IP_MC_5_P 0, __DQ_S_IP_RE_100_P 0, __DQ_S_IP_SC_1_P 0, __DQ_S_IP_SP_0_P 0, __FROM_DOMAIN_IN_ANY_CC1 0, __FROM_DOMAIN_IN_RCPT 0, __FROM_NAME_NOT_IN_BODY 0, __FUR_HEADER 0, __FUR_RDNS_OUTLOOK 0, __HAS_CC_HDR 0, __HAS_FROM 0, __HAS_HTML 0, __HAS_MSGID 0, __HAS_X_FF_ASR 0, __HAS_X_FF_ASR_CAT 0, __HAS_X_FF_ASR_SFV 0, __HIDDEN_HTML_CONTENT 0, __HTML_ATTR_DIR 0, __HTML_DIR_LTR 0, __HTML_ENTITIES_X4 0, __HTML_TAG_DIV 0, __INVOICE_MULTILINGUAL 0, __MIME_HTML 0, __MIME_TEXT_H 0, __MIME_TEXT_H1 0, __MIME_TEXT_H2 0, __MIME_TEXT_P 0, __MIME_TEXT_P1 0, __MIME_TEXT_P2 0, __MIME_VERSION 0, __RDNS_WEBMAIL 0, __SANE_MSGID 0, __STOCK_PHRASE_7 0, __STYLE_RATWARE_NEG 0, __STYLE_TAG 0, __SUBJ_ALPHA_NEGATE 0, __SUBJ_STARTS_S_BRACKETS 0, __TAG_EXISTS_HTML 0, __TEXT_DIR_LTR 0, __TO_MALFORMED_2 0, __TO_NAME 0,
 __TO_NO_NAME 0, __URI_MAILTO 0, __URI_NO_WWW 0, __URI_NS , __X_FF_ASR_SCL_NSP 0, __X_FF_ASR_SFV_NSPM 0'
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Mar 2023 08:37:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14612

--_000_PR0P264MB1882D9E54AD24DF72B9E65E5E9869PR0P264MB1882FRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

to use the path url-compatible. This needs to happen before the shell quota=
tion happens.

Without this commit, spaces in the clone URL will be used as " " and not as=
 "%20" which will fail.
This commit changes the " " in the URL to "%20" when it is a http or https =
url.

Signed-off-by: Thilo Cestonaro <thilo.cestonaro@thalesgroup.com>
---
 lib/bb/fetch2/git.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 578edc59..dc7f848d 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -66,6 +66,7 @@ import re
 import shlex
 import subprocess
 import tempfile
+import urllib
 import bb
 import bb.progress
 from contextlib import contextmanager
@@ -697,7 +698,12 @@ class Git(FetchMethod):
             username =3D ud.user + '@'
         else:
             username =3D ""
-        return "%s://%s%s%s" % (ud.proto, username, ud.host, ud.path)
+
+        path =3D ud.path
+        if ud.proto in [ 'http', 'https' ]:
+            path =3D urllib.parse.quote(ud.path)
+
+        return "%s://%s%s%s" % (ud.proto, username, ud.host, path)

     def _revision_key(self, ud, d, name):
         """
--
2.37.2


--_000_PR0P264MB1882D9E54AD24DF72B9E65E5E9869PR0P264MB1882FRAP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);" class=
=3D"elementToProof">
<div class=3D"ContentPasted0">to use the path url-compatible. This needs to=
 happen before the shell quotation happens.</div>
<div class=3D"ContentPasted0"><br>
</div>
<div><span class=3D"x_ContentPasted0 x_elementToProof ContentPasted1" style=
=3D"margin: 0px; color: rgb(0, 0, 0); text-align: left;">Without this commi=
t, spaces in the clone URL will be used as &quot; &quot; and not as &quot;%=
20&quot; which will fail.</span><br class=3D"ContentPasted1">
<span class=3D"x_ContentPasted0 x_elementToProof ContentPasted1" style=3D"m=
argin: 0px; color: rgb(0, 0, 0); text-align: left;">This commit changes the=
 &quot; &quot; in the URL to &quot;%20&quot; when it is a http or https url=
.</span><br class=3D"ContentPasted0">
</div>
<div><br>
</div>
<div class=3D"ContentPasted0">Signed-off-by: Thilo Cestonaro &lt;thilo.cest=
onaro@thalesgroup.com&gt;</div>
<div class=3D"ContentPasted0">---</div>
<div class=3D"ContentPasted0">&nbsp;lib/bb/fetch2/git.py | 3 ++-</div>
<div class=3D"ContentPasted0">&nbsp;1 file changed, 2 insertions(+), 1 dele=
tion(-)</div>
<div><br class=3D"ContentPasted0">
</div>
<div class=3D"ContentPasted0">diff --git a/lib/bb/fetch2/git.py b/lib/bb/fe=
tch2/git.py</div>
<div class=3D"ContentPasted0">index 578edc59..dc7f848d 100644</div>
<div class=3D"ContentPasted0">--- a/lib/bb/fetch2/git.py</div>
<div class=3D"ContentPasted0">+++ b/lib/bb/fetch2/git.py</div>
<div class=3D"ContentPasted0">@@ -66,6 +66,7 @@ import re</div>
<div class=3D"ContentPasted0">&nbsp;import shlex</div>
<div class=3D"ContentPasted0">&nbsp;import subprocess</div>
<div class=3D"ContentPasted0">&nbsp;import tempfile</div>
<div class=3D"ContentPasted0">+import urllib</div>
<div class=3D"ContentPasted0">&nbsp;import bb</div>
<div class=3D"ContentPasted0">&nbsp;import bb.progress</div>
<div class=3D"ContentPasted0">&nbsp;from contextlib import contextmanager</=
div>
<div class=3D"ContentPasted0">@@ -697,7 +698,12 @@ class Git(FetchMethod):<=
/div>
<div class=3D"ContentPasted0">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;username =3D ud.user + '@'</div>
<div class=3D"ContentPasted0">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;else:</div>
<div class=3D"ContentPasted0">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;username =3D &quot;&quot;</div>
<div class=3D"ContentPasted0">- &nbsp; &nbsp; &nbsp; &nbsp;return &quot;%s:=
//%s%s%s&quot; % (ud.proto, username, ud.host, ud.path)</div>
<div class=3D"ContentPasted0">+</div>
<div class=3D"ContentPasted0">+ &nbsp; &nbsp; &nbsp; &nbsp;path =3D ud.path=
</div>
<div class=3D"ContentPasted0">+ &nbsp; &nbsp; &nbsp; &nbsp;if ud.proto in [=
 'http', 'https' ]:</div>
<div class=3D"ContentPasted0">+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;pa=
th =3D urllib.parse.quote(ud.path)</div>
<div class=3D"ContentPasted0">+</div>
<div class=3D"ContentPasted0">+ &nbsp; &nbsp; &nbsp; &nbsp;return &quot;%s:=
//%s%s%s&quot; % (ud.proto, username, ud.host, path)</div>
<div class=3D"ContentPasted0">&nbsp;</div>
<div class=3D"ContentPasted0">&nbsp; &nbsp; &nbsp;def _revision_key(self, u=
d, d, name):</div>
<div class=3D"ContentPasted0">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;&quot=
;&quot;</div>
<div class=3D"ContentPasted0">-- </div>
<div class=3D"ContentPasted0">2.37.2</div>
<div><br>
</div>
</div>
</body>
</html>

--_000_PR0P264MB1882D9E54AD24DF72B9E65E5E9869PR0P264MB1882FRAP_--

