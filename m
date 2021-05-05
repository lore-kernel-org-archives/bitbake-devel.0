Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.81])
 by mx.groups.io with SMTP id smtpd.web08.4792.1620201564550677644
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 May 2021 00:59:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@detectomat.com header.s=selector2 header.b=qWL9Sc4f;
 spf=pass (domain: detectomat.com, ip: 40.107.21.81, mailfrom: harald.brinkmann@detectomat.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z31Ow5nCMr38cnxux6Cw05UKd6ZQvu+WNpSn7TAy0C6YzirOIdrP9qlj8PfVaCzEABOxhw3thGvNJ11wfPSq7ng7mn9NH7vSuBvegldp042gXE79EojQIyl7Ayg6r6f1AeSSvGW7oJaM98V9rMsw61R8ZirZh7LP5nLa7b/AAhIA1JKTAqK4OZYW3BDTEnVO/YBzwzaKqmcArHCea3kmpMxE7L6Y6FiSuuw6iEa/7QlbGXuVEhGfXQawQGpWgtuXPMuxFrDi6dKot72JAp3sm9qZxT3I51ra8KT+wO8NL949dt+ZPGzC1B6nnQZrDP2n4SItbPF0J88GtVGD4YIUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGLVcPGVqQU7jRMmBOrW5meltkHOWy0uP7gbw7eDBYM=;
 b=UknRQQYxkB2tadx70aXDIGWCj0kGhrNS2m0JfTr5T/ILj6VT8Nzsy5aS7hCzh8HmAfkBLDd3AX46k+uY/GsRV1cXgBJ6PdoLEaBAAOXYEQ9FYJ/kqAq14mtEH4E0C4FCxF0kI5gqtYwAsLzJ7X8So/7yVSwl3vg+AI6hzOYFOcsKQM+LXjCORmJmLYcm0CvSnI14JWxDao/f7dfy3RcnHYB768inB1x7Z6dlxyD7b3oM46S7sbxDy8/j1HOSHy6K5BJX3UvHiNeoX2h2JMArRdywdT7iHwZGcDwSUq5uybJusvgzvpiCFbTbP0O5XQFiI/8IPexyErtzfJeScNnF6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=detectomat.com; dmarc=pass action=none
 header.from=detectomat.com; dkim=pass header.d=detectomat.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=detectomat.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGLVcPGVqQU7jRMmBOrW5meltkHOWy0uP7gbw7eDBYM=;
 b=qWL9Sc4fDPVKhLg1fGLir3BUSUM/ANrn4c/OIs2snShBrwqnKUjjsHvPZfu09gjKqlvV/xoBRn9BEXgT3zngtbF+mnkYLNjBYuaa/rwQ0nv/qL+yl09xgPE8WJ9Ge33P6XtYoqufX3+dzud46udscO8V/ZZTHkD/G34K6SxHpOQ=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=detectomat.com;
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com (2603:10a6:10:7a::24)
 by DB6PR0801MB1655.eurprd08.prod.outlook.com (2603:10a6:4:38::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Wed, 5 May
 2021 07:59:22 +0000
Received: from DB7PR08MB3851.eurprd08.prod.outlook.com
 ([fe80::1de1:8ed2:1159:e1f1]) by DB7PR08MB3851.eurprd08.prod.outlook.com
 ([fe80::1de1:8ed2:1159:e1f1%5]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 07:59:22 +0000
From: "Harald Brinkmann" <harald.brinkmann@detectomat.com>
Subject: [PATCH] Fix parsing revision of SVN repos with redirects
To: bitbake-devel@lists.openembedded.org
Message-ID: <7d4eff19-2117-8a8f-e9d3-1f44d7466791@detectomat.com>
Date: Wed, 5 May 2021 09:59:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
X-Originating-IP: [193.32.127.214]
X-ClientProxiedBy: AM0PR03CA0096.eurprd03.prod.outlook.com
 (2603:10a6:208:69::37) To DB7PR08MB3851.eurprd08.prod.outlook.com
 (2603:10a6:10:7a::24)
Return-Path: Harald.Brinkmann@detectomat.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.50] (193.32.127.214) by AM0PR03CA0096.eurprd03.prod.outlook.com (2603:10a6:208:69::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 07:59:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c415bdd7-aff4-409e-3794-08d90f9bb157
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1655:
X-Microsoft-Antispam-PRVS: 
	<DB6PR0801MB165542E5A6B6271AC347F83BE9599@DB6PR0801MB1655.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:153;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CcYI6tbBkzTdJ/Ved8uGVSxWS0dY3CxbL5sLJmdRILz/9tYOuSAHOcR7S3YhsNR8PNtRHltVcyb1SqDliM7IqHl/rYKbAIVTlPSCqz0o18YtFo5RIpLg2mxmvabDV8TQ++V5Png3WEy4ZcA4TIvZbAjlQjxsKyqEq8en6dfs5jztIjZuG58DWJvaHJzCKMwrA/tWaGtkCe1Q9uIufux/FqArxh8MErj+6E52GFS7vzduzXvzdfhm9L2Sfu0tDIOH8ulJgdNDwSu/HYTeFhLExZl0MCb1cYgAUqqY7ALKVpNKv6fVQdg0S2HMqLlRu9udeCWV3sENaqwgqQVJErROqPwAjdKvF1FTek6HvekS3p+e8vnewR3H++FvjvwxCwKdcwOfR5W5FBDfd/84dmCcDnHfqkEF8GsCyJAFQ6Y7Dyg6qfmEF4CfC5mLEn3rLQLuAym5RfjUe8IF6qyRTTTFS2jhJ7WPxlkCziDATw19kmmRhisqxFakGljWZ3Uv5tyLWOa3f/rl53kcPpBBQ5diQfyZ3wuhDTQjBjPeD8i+TsrIxHH8HKh5YW3Rry0gfJdDKTRpnmt7eSaVy5dXkL6IMkMc9WFNW2fZdtWQMY2xo76Adk3fEi9jgVTsjUq6vpauQTS+subGkNw30HUqSeBLuY28kUXB69rovbjfimfeVxt0LvVzMsFCuOJ2FoTGYSAHNAE/An8MC8oyfp5x5rFwDQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR08MB3851.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39850400004)(376002)(136003)(396003)(5660300002)(8676002)(316002)(33964004)(86362001)(38100700002)(66556008)(6486002)(38350700002)(478600001)(26005)(31696002)(2906002)(83380400001)(235185007)(6916009)(21480400003)(16576012)(8936002)(186003)(36756003)(2616005)(956004)(66946007)(31686004)(52116002)(66476007)(16526019)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?UUlEK0F2bDB5VXpSTXFuczFBWWVPWjl1YmlzY3hiWWhtclRyUi95MzFvbGpZ?=
 =?utf-8?B?QlpJb0lMRXJMSnBtOGpSbGpoMUI3MjBmZFBTK1U3amhadWFwVG9EK0dPckZq?=
 =?utf-8?B?eEE3b1R0SmNFcWN3VS9ZaE45QkhtaXNoK1JSMDQyS0llZUd5OWJ2ZkUyeUhz?=
 =?utf-8?B?bUFMV3ZSL2l0WFZGZkNTZXh4d3dFcENmZ2dONUkwazRGc1VqdVk5Uk1NVWlF?=
 =?utf-8?B?QmVXS0x5Y2dvS0l5RHAweWxYWm1jdkUvakh1Y0cvV3VDbXdjY0x4aEloK0JG?=
 =?utf-8?B?djBDRElYZVBQVDVsRWFRMlljd2JMVUdoREVoTk5tbmwraEVFSEVIZkZNa2pR?=
 =?utf-8?B?ZGU3VFA5ZEQwSDVQNERIWmg5USsveWVVYUE5dDg5Z01KUlFUWWtiaUVzUlFC?=
 =?utf-8?B?U29lWWJUSjZlQXh4WnZBaEN3R1lMYWZHd3FTdlhIRjg1NjZQdlMyVDM1d0dR?=
 =?utf-8?B?Mjg4STI4a25MWlFaOHphTjUzVXBFZHUwMjBFUW1QNUhBSFJPeFdGVmxHSDQ2?=
 =?utf-8?B?WVhmZ2MxNmxCSDQxRHBOemZXbVBuSHBKRUNFYWtHYjM1eklUTGZhMVF4bjVs?=
 =?utf-8?B?eGcxdnJNZWdadGErQlQzalczZlRrZ3FTeWlpWkt4ZGNlclFjRTJrU2J5ZzBp?=
 =?utf-8?B?Ry9tdVdzZFVjc3hRbUFKWHRaSGtmNHVkN3dhNmIzeXJhbjRiVnY1Q3ZiWkJU?=
 =?utf-8?B?dzdCUGdGUG81QnV6a3pvZ3Y0SlQ3TlI3dTAzM3ZMT2NQcWNxNFlSWUNPVkRw?=
 =?utf-8?B?a3hpeVhwSmFiRW5oSWZJM0xGUHRxV3hPZktSRTYxbWQzTSt6Tnc0VzBiZjd6?=
 =?utf-8?B?dGdzSWRsNm1kQVBtWGh6RTVzSEtrbDY3MEdyenFzUG9qSFlpVXArZEFuUk1N?=
 =?utf-8?B?Y0tMekZ2anBwT2E3WTBPekM2dnVyUytpMmtKdWFCVUk4SkNobUdSZnBXV1oz?=
 =?utf-8?B?NmV0bUovMTRVUmxCeFo2M0kwOCtqZURaMVJsaWp4WmdFdTkrRVUzWnlhUmhE?=
 =?utf-8?B?MHdHYWNHK2tYcDkzQzNsZlM0d3ZmYy82cnBKZVlpNDlZM2x4bVdHc0ZYOVNt?=
 =?utf-8?B?WWxReUlObmZtTjVPaTV4V1MzU0JBNkZMaW1BQmFycFFJNVpSbFdsZmRPTmxp?=
 =?utf-8?B?RlpvMkdyK3g4RHpCRnlvOGtoK0VYQW80OU1wWjU4bFZzT0lCUVNiTkczWWxu?=
 =?utf-8?B?YWxQZW11NDFvWUkyTnJ5VnZLTFpYZGpDenVwcUZDQVB4ZkpUQmM2R1ZJWG85?=
 =?utf-8?B?clR4ckFUblMzNkpqT0ptNWNHMjZsbEx0ZUtxakZiZEI2T0VJWU9jaXlWWS9Z?=
 =?utf-8?B?NVNPK0JXNjIxQUNFK2R1REsvYU85ZjVqQnl4OUZ4YVBVbzh3d3FXWWVJNE9P?=
 =?utf-8?B?SHM5ODd6eHFEMlFxL0pXVkZkaHpIcDNoOVlodi9OL0JOR2ZVRXNRYXRXUWRG?=
 =?utf-8?B?OWNiV2ZjbytUTmx2V3l1Z052eE5sVW1JTUxOQStQcDB5a09rUFBPc1RIQlJt?=
 =?utf-8?B?Vi91L1prSHR4SWlLUVp4UFp5ZkY2em5pcTBSQUFibVRzZmFxZFlNV1dUejd3?=
 =?utf-8?B?UUFKVTg1SDJTQ3NjRW8za0hveXV0L2dHb1d5L2xGcE9rcVMzRDhpWmgxRmRv?=
 =?utf-8?B?cThpUTBXcTNKenZsekJIRkIvSmNONkpoci9RdENkeWFXYXl5c05BY0QzblZr?=
 =?utf-8?B?Q1RTaGZjQllEZmgxNVNlcDlsMU1HdHVQRmxFTVBvdzhEQ1N5QnBFT05OdTE2?=
 =?utf-8?Q?LGmuIPrqgqgurRA1a3xQClEskDiYxpTpVsB8yuK?=
X-OriginatorOrg: detectomat.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c415bdd7-aff4-409e-3794-08d90f9bb157
X-MS-Exchange-CrossTenant-AuthSource: DB7PR08MB3851.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 07:59:22.0245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 07587bd1-3a09-4971-a5a0-370e32888812
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5yc4wecVmXCDi0G0aDpuU8lrBDfXB32u2tCWuECsYV7CbkGJ8HczdVVVRZUQrv/I91CN0gxsalono8UUaXPmvKDCh4hriXCQ3UhVq2EWIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1655
X-Groupsio-MsgNum: 12287
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FgZV5sVoaOXuTJ14hnuChjH4CHwgbbw8q"

--FgZV5sVoaOXuTJ14hnuChjH4CHwgbbw8q
Content-Type: multipart/mixed; boundary="Z7PYpluo3vbceJuP4KyfYQxx9O3dzOqmK";
 protected-headers="v1"
From: Harald Brinkmann <Harald.Brinkmann@detectomat.com>
To: bitbake-devel@lists.openembedded.org
Message-ID: <7d4eff19-2117-8a8f-e9d3-1f44d7466791@detectomat.com>
Subject: [PATCH] Fix parsing revision of SVN repos with redirects

--Z7PYpluo3vbceJuP4KyfYQxx9O3dzOqmK
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

svn was printing a message when encountering HTTP redirects.
This confused the revision parser.

Signed-off-by: Harald Brinkmann <Harald.Brinkmann@detectomat.com>
---
  bitbake/lib/bb/fetch2/svn.py | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/svn.py b/bitbake/lib/bb/fetch2/svn.py
index 971a5add4a..5c305c4a75 100644
--- a/bitbake/lib/bb/fetch2/svn.py
+++ b/bitbake/lib/bb/fetch2/svn.py
@@ -86,7 +86,7 @@ class Svn(FetchMethod):
          if command =3D=3D "info":
              svncmd =3D "%s info %s %s://%s/%s/" % (ud.basecmd, " ".join=
(options), proto, svnroot, ud.module)
          elif command =3D=3D "log1":
-            svncmd =3D "%s log --limit 1 %s %s://%s/%s/" % (ud.basecmd, =
" ".join(options), proto, svnroot, ud.module)
+            svncmd =3D "%s log --limit 1 --quiet %s %s://%s/%s/" % (ud.b=
asecmd, " ".join(options), proto, svnroot, ud.module)
          else:
              suffix =3D ""

--=20
2.26.2


--Z7PYpluo3vbceJuP4KyfYQxx9O3dzOqmK--

--FgZV5sVoaOXuTJ14hnuChjH4CHwgbbw8q
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcaAt/ZGi4+X2TRF1KpJ3/1sXU2wFAmCSUFgFAwAAAAAACgkQKpJ3/1sXU2yQ
Xg//SK/n2hoRLqf4SweM57O2LfzRziobpHmSQOyjYqmayKC0I0TIDCBBkPwsotAnvVW7jiaqdb/7
9sT5gQiv3rL4xfJTgdHqAgStApC0KFiDD83oeI5zIyU8aKQK3RxcDSqnjT1ytxHMHDC2LZYuLK8l
eisWb2f48lY84a6PhekcO9l6ivgv2UewuVEBptmQoLdcnS2IZ/ndNTvN3+S5mDRSlKX3bvXwt/99
gR65imY1RWAa8y/Y5ii/xdHsQkGWf+R4r3cg+XWOppK097pkl7BGwpW9EcVgphNZU+CZMsJAxaQW
VDuVbxyQVMC2YJ+vgbWWXnNK5vAHlcLw+kuKBZDU1C+38SFKDb+JhPn/NTMoHVDA2GPFYmBcJdpx
/iVdDf4hg4YTlFvldO1CfxW+/STbc6NroS6OxZarCU6sZVtnFuZl+DGlgnu2VsvR5BE1mbqz+AVX
k1qZo6qVQBIL7D4vhh+hbtiXMFeltnlp19yd5VHTaTO0x3CKW+jB2cK4frNKP/TmBpqJk1ryXBWD
LWxgz0GYugZbjh2ulJr1KaO/nrZrhzyTdzRvFVjNaXtt5BWV2g0eeaiL4ibtqHptXuhKGR0QEenW
Do525lPds0DCkqb/XwvpcLliwwZVRUWGT/L7uwwbwQ/cIK5f44y5LAKO6p3ihuK7WDgyto3/bZTQ
I7M=
=h63X
-----END PGP SIGNATURE-----

--FgZV5sVoaOXuTJ14hnuChjH4CHwgbbw8q--
