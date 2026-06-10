Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A226CD8CB9
	for <webhook@archiver.kernel.org>; Wed, 10 Jun 2026 07:40:26 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.23])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15043.1781077222723920171
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jun 2026 00:40:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=Y9wKJPv+;
 spf=pass (domain: est.tech, ip: 52.101.84.23, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N8QiycF11iJZ/jgY+cyKAY7bV3VEOHPG+/F7CpTj+SaBdN9OtOVcWJlS4M4vh+OvLOsl4KmC+DbTuwCPHaAr0HK2dWxS/XLoTfBugbCZZGjhz7AYZbKp6e16erhfEpPzaQvioeuH2ScKSnTX4Le4ZW6m3OARlB0GkhwqJpWttiS+DvPFDMxxPnPajiNE0M23fQot5H5vAvsSBggXolXpRE9FDfxSLuw4sSHDwBmBPR+OdJClA8MXcmfqqEmVHazfcQuNTFAP7cCobPAcpSHfOvQdiBKJIn9IZZk4wBkdSNeO5cMOokGdsE0aZRludnGjXTnPAhVjpBZPoCU+zOPXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6FTlApnLILAsfVnAg0uq2NnJIgMekyWmuIQeD1zpgk=;
 b=ktezLi6iQzVis2mKVAIQiWVi8qG+wCUm4tU91BrZM6wluGFB1vY8ZeuDiIU0Rgon8dkiy9kcfxZ1X9V2yko41m6OtjQP5XQBFnaj5s5s0vBJ9uhdjZgEHwO5a/7Zl38Pi9MZa8gBSBDO0YXsQLhqOxbcXBe9doUT6ziE/sBV/kZBrym5NwfL9j3sgbBOu8dYxyGE72TCxCyYzWw52SjjQs+ygUUY+zP+U1sn9Zsdi7uBcP9+kBZWbtwGsNjTMwb2hCB4oLvsYNnuToWfbwgsP/ejgF7qQNtPYCsLn6N1NoTNPx7DYXl8EKlaNahm3KVkzXBoOvOYufsX9Sr/wczcvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6FTlApnLILAsfVnAg0uq2NnJIgMekyWmuIQeD1zpgk=;
 b=Y9wKJPv+XXL0y3nQiyOf5XIU07I+k+VLvkqJ+Sek0reXFkWfqRMW/Oudaag8AvQA0DilKGJVrdxmgkDKkRiBZcJfzLE1iSDRPPkNjXVeP2I8Yc96VtKEf8e0UCLDIOL/9U1i2tYldYHmaZpBW9In/o+g/gTUxjiE9cRM6sfWpUVwBrgqGxAYsIdFfpzLju1+x+hJVEA2e197bPp05HfqO8itWUk+RWqKDmPiR4jUYAJOLxfEKneu+/LDFNzbxVAp6WsEvj+n+aaSvnLHz8D8JqhaUNmv2CMGfgh97ee9Ykzpx/htpir5b+pXqGsRDlLVBsDqFc8QWi8WlnyjJOhBBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 DBBP189MB1290.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:1e2::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.14; Wed, 10 Jun 2026 07:40:21 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 07:40:21 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Anders Heimer <anders.heimer@est.tech>
Subject: [PATCH 1/2] fetch2/wget: limit auth on checkstatus redirects
Date: Wed, 10 Jun 2026 09:40:12 +0200
Message-ID: <20260610074013.558709-2-anders.heimer@est.tech>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610074013.558709-1-anders.heimer@est.tech>
References: <20260610074013.558709-1-anders.heimer@est.tech>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DB9PR02CA0013.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::18) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|DBBP189MB1290:EE_
X-MS-Office365-Filtering-Correlation-Id: e7503e43-6953-4339-c557-08dec6c38687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	30inOtIjmhinNuPySFgLkBP8ar/PWVvLhXssbHxf3+sd0u5pFk/9VWr6Yq3dk9dT9uDKYc3NvKA6XMpErVOWHDcUTg5LXRKu+arQmsbYKyTFvcA0nuDbXvZnsCwARV1oAJ/hK1QzDg0B+OmKF0pocKLdM3oHw+JJfTj/VIRD2JARwewzRABySqrwkDBTMArZ1l1DduG/SXgWXAFSntIKY6zZmNLKRSCC9nLft4NTlKPBOfhzo9zKNJuZTMIGyXXFBGT8rUnyf87vL4I/YrByNgzhbpdowe7h4x3TlGmOszx7wzqUUrgAtL2ODrDuZgzTHIATAlHTO2E2/vWWZE8w6if2kbbuiQKkg8Ev7+bG7nav9RgGePFOGPMn45uOWZLFni3e2LmcojU1l17EvOD32M3LPII3UkhbuNzi4rDcO0djQsTpCSO7FswA7FLqbhxAdmvVbgxqtp4PBYqJA1ss7Ipf29nqi6Y+ySiVPaHDRPjAv/14NCzlE5p9AuHMVDEcQDoL8u+jR/EqPCi+JTjiWWXX3YxdY5aggB9IqmlYGRR5c8tKQUX+DLkE9KhFJ9HulAMI1wv+Qll+9yIN5GOQDDSG/xo21n+YoWuc2TLu6qa/PW03eum0GLYj8EXMZ14KUYhcqwLDNe4lXJwcy6FyAYxNBVXxiPwqpD+2duSCXH2UmagczW0AlfuKzN/YSaDy
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Gf+uJ0x7urQfuLWdqKanFFScWv89gQVSIE0Lb63dhPJ5yy5LHNl90+ZqaNz3?=
 =?us-ascii?Q?zYxg1CiNQ2JXXcEhI4LoK1RmlkQJP+H5DQ5gimSaQh7+KSwmxYTnUizhm8sZ?=
 =?us-ascii?Q?edilFjMZd3V/9NB46rw7y2mbAKIpDHFeW0LZAPfKr2lr/Q5uauQo1AngFTHh?=
 =?us-ascii?Q?1omMkphPEq6ZXEdYavUDDCgaA2cHavvuuZd+ghnCaT1iq2EanvD9/zFVOjdb?=
 =?us-ascii?Q?C0DO9BkCxi75YMbGWOY2kXIdCE/fKSI6uqjKn0njCj6GH4qMbJxxmiqwVcn9?=
 =?us-ascii?Q?YZ3FD3rHjkIm1F0pFEhkRCYx0y3pxSvaaPlqAYVIhmKcwPgECGuFVEOSuvA5?=
 =?us-ascii?Q?u+s4xZh38PUUDKqWiG4YUP+f6PDs1j7fKaRqMT73NTGODR5fu4oUH0LFDRsM?=
 =?us-ascii?Q?NKWEwP9xIAw4NrDimJJstfBsG1KG4DgG7zgz1Tc/WixUQlSryZEMcnWD1+iL?=
 =?us-ascii?Q?Gh8Fb7DjQdXZR2c7dBYPLm/2Rtp7t6MOlt2qffUvD18whNx9Vdv+qh4JP3Zt?=
 =?us-ascii?Q?6OMlXQcidy0+RTf0Lg3mYzEDJMAKVAVtYZsCwKU7NhEpJQ61XiYxW27bzaUX?=
 =?us-ascii?Q?DVxPBYwG5w9zhReTHLwS21o+sbkCp3OYyReWzWjrOdc9mTV6yRovjexaD6mo?=
 =?us-ascii?Q?QgR2fmH4t1iKS5cqcdvaf4iSLeijlT31RK8+Z20/LksheTbCr/s04gpP5ii/?=
 =?us-ascii?Q?lGfAydMr7JJOGs0HwID5fsoOXd2F0ZGiJgCmoNthVBWSZVsPpvJMU4lwMW6I?=
 =?us-ascii?Q?29BHF7ppAnzxwWwQR1H/nk/THq9bdVwnXaZcyhPEdqAXj+qoc5Fee4YND629?=
 =?us-ascii?Q?hcYdVqyV7FUqUT7cXMf46UZ68l/VXsq2bNyGQTq51J8gWJDU1zydkIXAWCkq?=
 =?us-ascii?Q?ZNBy4Zt6wudnuhSGpp13uIiBtl/uh1Ia9hfVDo16bRPasZu2ijw55bPzseJs?=
 =?us-ascii?Q?zx7+1cB4Ad0mQkVJwgxJ0QtVdghsDdQ3n8ehuRaamdOWrMrSg7dV9r+coEo7?=
 =?us-ascii?Q?hxFggBlbzE4HBqEcpSv7M2npc8dTFPhCfNQq8Bt7ZahSw5Zm+V0+u1zPXokP?=
 =?us-ascii?Q?mwUzdFDSkWBZpaq43D74dRMWVhpDdNEbleToUD9rj8UulP5SRDdquiVvBhGn?=
 =?us-ascii?Q?78IUJPZ3DE7Z65CjrzXknBgIp3KE5R3WwpL4KvxYp1ouVNYkW8iRMISMf6ct?=
 =?us-ascii?Q?aqRPM2FZXs/26Z777YLznED5F9uK31EB+z+4UzOP7/H6jX2wBqej3sAqhRBZ?=
 =?us-ascii?Q?BMpMvu684EUSHHUp+r8LdpKO/XMIu9oSdna7hyxMjpiroZdk23xdP606B8Ug?=
 =?us-ascii?Q?A5ELBRy69fJsEZbcSPo53ZRl/BDs9JI84EwnbCW8QyqApAanRRF7njcrdowb?=
 =?us-ascii?Q?8QrQf2t8CLNS8RAT9XWt9/ByM/jJAXa+VweDlHUQGVcy+UKFQlyCLMtyM8m7?=
 =?us-ascii?Q?N/d4hMiI8BI2p3JfF1lKoFFv5ahulj2/NEnRHV248/0g3sq2Y814rq1oK98/?=
 =?us-ascii?Q?xbq7p6dFfvxlzuRSHm/6risxH8lI+AYOJ/tcqTg4mtOBq9+eb7UL95t1lXui?=
 =?us-ascii?Q?IFllAwfvu4KddCC5LLb35I6mlcibM0cWb4ae8wjSFiWfLc6M1dpOXKnu8DzM?=
 =?us-ascii?Q?lP9RAzVwwaAY1WdwpwSgIloOpXnRIxjNK5WewUvwFxe6cqVSTbeF6dG8kesL?=
 =?us-ascii?Q?qPb8Kt8wXBXdMeEZzTV0WKwsK1RkvJTVC6y1aB4bqA2mtUzuoPtjC+VXDpZN?=
 =?us-ascii?Q?YpmEsoGV6g=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: e7503e43-6953-4339-c557-08dec6c38687
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 07:40:21.1977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ov4Y37fyyK9PRmNQJ27T+X/fwttZno4tkw2y4Rvm5Y9jH1nul2xVm1Dn1iYu/Y8xOLa8fhkLDY2HxWktEhE0gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBP189MB1290
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Jun 2026 07:40:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19637

FixedHTTPRedirectHandler copies request headers when checkstatus()
follows a redirect, including Authorization from SRC_URI or .netrc.

Keep same-origin redirects unchanged, but drop Authorization and Cookie
for different-origin targets (scheme, host and effective port), following
RFC 9110 redirect guidance for resource-specific headers. This only
affects the Python checkstatus() path; normal wget downloads are
unchanged.

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
---
 lib/bb/fetch2/wget.py | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/wget.py b/lib/bb/fetch2/wget.py
index 475f042dd..11b57f2f7 100644
--- a/lib/bb/fetch2/wget.py
+++ b/lib/bb/fetch2/wget.py
@@ -292,6 +292,18 @@ class Wget(FetchMethod):
             http_error_403 =3D http_error_405
=20
=20
+        def _url_origin(url):
+            parsed =3D urllib.parse.urlsplit(url)
+            scheme =3D parsed.scheme.lower()
+            host =3D parsed.hostname.lower() if parsed.hostname else ""
+            port =3D parsed.port
+            if port is None:
+                port =3D {"http": 80, "https": 443}.get(scheme)
+            return (scheme, host, port)
+
+        def _same_origin(url_a, url_b):
+            return _url_origin(url_a) =3D=3D _url_origin(url_b)
+
         class FixedHTTPRedirectHandler(urllib.request.HTTPRedirectHandler)=
:
             """
             urllib2.HTTPRedirectHandler before 3.13 has two flaws:
@@ -305,6 +317,9 @@ class Wget(FetchMethod):
=20
             Until we depend on Python 3.13 onwards, copy the redirect_requ=
est
             method to fix these issues.
+
+            Additionally, strip sensitive headers (Authorization, Cookie) =
when
+            redirecting to a different origin to avoid credential leaks.
             """
             def redirect_request(self, req, fp, code, msg, headers, newurl=
):
                 m =3D req.get_method()
@@ -324,8 +339,16 @@ class Wget(FetchMethod):
                 newurl =3D newurl.replace(' ', '%20')
=20
                 CONTENT_HEADERS =3D ("content-length", "content-type")
-                newheaders =3D {k: v for k, v in req.headers.items()
-                            if k.lower() not in CONTENT_HEADERS}
+                SENSITIVE_REDIRECT_HEADERS =3D ("authorization", "cookie")
+                same_origin =3D _same_origin(req.get_full_url(), newurl)
+                newheaders =3D {}
+                for k, v in req.headers.items():
+                    header =3D k.lower()
+                    if header in CONTENT_HEADERS:
+                        continue
+                    if not same_origin and header in SENSITIVE_REDIRECT_HE=
ADERS:
+                        continue
+                    newheaders[k] =3D v
                 return urllib.request.Request(newurl,
                             method=3D"HEAD" if m =3D=3D "HEAD" else "GET",
                             headers=3Dnewheaders,

