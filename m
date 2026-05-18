Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748B8CD4F49
	for <webhook@archiver.kernel.org>; Mon, 18 May 2026 14:59:22 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.2])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10319.1779116360836601888
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 May 2026 07:59:21 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=QJrYQ0MY;
 spf=pass (domain: est.tech, ip: 52.101.70.2, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDQXxoAVwdCnLXU6pUVDEeFLXIN3uOFI45HNurdtf0ko4U0DAAUX5YOyj5z2tao+vV8HSNjJ2bweuAEdWdtN6QKjaDonNmHipyCjklyoPpr3XHVtOqmQbXB0Xx0JSMYEiX6JumDo8xGZnmK0JoBvLCxHeB96ijCa1QEp3ozhaEruKu5LBgW7uooFZNPS+eUFEECM3vzgO08FR9V0Fw92JRq7Xf2bzKv8gDs7Va+0Txjtlj49Y1LcYOPAf+sONMKGpermTBtA+HHKPIaFNxvUPGBf+MZHMZuSPWoeHmJLi3sV+RKyGo+LL10CROPIEp2ghg34maeqfh2GEV+x5Cmghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiBez47QIRB/uNLu7eMg5dslz3LxOArhDy+a5jIJszo=;
 b=geZWnudYlB/aiDQbrSLj7zG3s3lRu6s+tsVMKXa85HtN/UfT7glJwPyFZqiiA1V/KAyL2zv1Tei7zg3IwOlaxPCnI/69+FOnSUl+Bq+qBi8hBnQKMD332HFi6Gr3n5uLljpFWCVgoLXpMzdyZZqvevuBTekt4ZgtNN2pUdvEsYgrafL4D5TY+vJRV/XrJNKqv8kKxsWzVezAWMV64zw5mC0mXgtz+uWTgbbp61cmy5iyWBwcdTHAl8n/idrvT/dPN7BJ1Tzzpjd2ww+fBAPFG/eh9udvIGmcPx4xXkM911YYH3NC5nKLjg15HTYyHt2DNjcyH+q+UkCbzi1yRmVguQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiBez47QIRB/uNLu7eMg5dslz3LxOArhDy+a5jIJszo=;
 b=QJrYQ0MYZeWhqcNkgUGhXAcbHF6UEwmFmzLdAd0cuaiVNAuTvICuP24J4sdPeRWeZUK58TGWAsdEacax3n2O6Q5Sy2kz1LriQEhMK8g2gKazkY+baYfqtZBszmDl0IrWGoMTxeo1/WZnaMR/vUZduCqpner3+kArhRUL/pPnb7+I1pZoH4Yzg8pPw2ce1fldH7kSMPYa7O2FMafX4Pl9y4ZxfHbbUUOra2ya8LlYKGth3Jki3mw0/3SYmPFlCURedgLln3qVEscRP7TGT0XazM/O2y93gNvzmh2Kvf538+gj7NjuhZs85iEB0MInL5uTxbnaAhIb+qqV6i9NacQBjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 DU0P189MB3274.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:59f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.23; Mon, 18 May 2026 14:59:18 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 14:59:18 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Anders Heimer <anders.heimer@est.tech>
Subject: [PATCH 2/2] fetch2: validate striplevel parameter
Date: Mon, 18 May 2026 16:59:09 +0200
Message-ID: <20260518145909.1132755-3-anders.heimer@est.tech>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518145909.1132755-1-anders.heimer@est.tech>
References: <20260518145909.1132755-1-anders.heimer@est.tech>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0033.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::8) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|DU0P189MB3274:EE_
X-MS-Office365-Filtering-Correlation-Id: bf4cf05d-c03c-447f-8f4d-08deb4ee095b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	39AIuSuuyBO1GreNCDSoukmo1TpYKwpYupQJO2qehQzpaGYVXO/N9U60G264uS014AUQOnv/82mZXtUmD8K0Ykg651lbKSS2O0Ym2rnMkQ/euPuAYDAEr9UVYfeWrH8oZr4vv64l+zNgohxX5hyF6cNqRR5l3NmudOQxDcmrd4bZShFULN4LAIjetYFQUtLpRcFhB73fMT7pZiEIZr47PlbwE6lYKEIBdjAiQsuN+hTjNtT3uKrT6h6KpVpMcCmpQAY1Xs+nEl6Ar1Ne0FRbXSy8d62a+g+5b4xnF+udWrwv4rAicT3eyAnx8EydfN53yKS8w5u7XLNFmhogbS7Y7LIHSfmMPmGwf40HWVFV5UfdTSBcDAm3JNt9hj37U3FjUXX4T+ariJ/cnk2UZeQaox5qyNyRPmpNMmFDp7Zc4OvRdnEaxlcu9ItaPIxdbjDeoBOkPcbzp2NV8LOnxxS7K7B3+rTLMpmBB4zJJAICY8BDSPEhDPrzx2a3DDj15B6clQfLnVco43hsJAT/4iTJg9gldVvi2agXb0L3FK/ErnzOs5wF1JrKZu6EFRGoXrOp7TjrIAiVNRs4fMRNMhbcwUnjclz97Hlu10XmWpCGchg1O3Ur9py9J4KaByLHPudGQ5bkdmoPG+T9giRRviA8IHCD1gxaKSiBKxhNBJYTdS6MfsDos3CJM1rVR5kxMSDhZt4OFTdx0fOFV1qHHFM+Hw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5jDYmp0NLQ53kjav1Nl8y6MA499sgg+eG+msn4Y3PTc5bwf44nczFMpkoxmD?=
 =?us-ascii?Q?48sfooMfnAYCqZ0av7Ca8ysP+ESg/O1SROGQjOJ5zR9heaeIYwyO4kJfG3HK?=
 =?us-ascii?Q?Gl+93Fezp+xQs5xDMAKDpBBUX3YjUd2bNFqY//fi25tDZbQp/F7seyF1FQS+?=
 =?us-ascii?Q?G7/H00dbvHDkGNGml5Z0eH8RwVg9ynRk43ZCfPqBw7nRGTu0kZhXBLA/XSF1?=
 =?us-ascii?Q?LLEaoCq6iSJvLYKah9ugE5KQ0e7DNE+WveS/6DffXdiye2vmc8T6X4pMvT6d?=
 =?us-ascii?Q?5QW7GPwNPutC9k1cbY1x5wDMN4ZhZ+PNqRNqIHhOH8YRj9gOO520rscxobX7?=
 =?us-ascii?Q?0UwuEMM7Mo2aqgLEIVVebXoFpOQ2X+7eJORrMgbvwXtZ/rDsbQ+WPoaoIpo6?=
 =?us-ascii?Q?lsL77Nx3IcNyMehMrQlyZa6JqKdXEah9mUAgFjjZ/S56JmmCNP8S4nx6fTJh?=
 =?us-ascii?Q?AVGkYgeDDfvqpph96iO1xgRhFoydZt063/+G/q44Sm2gi/jxluEp/MJk2O4J?=
 =?us-ascii?Q?FJuTJBz1vR6NIDDh//e9Oy1aknkw9Dkz0TkZWdv+84uawYA7QgJ1t+sQ0Tfj?=
 =?us-ascii?Q?4jspxCFEa/LY9KeqgompKIa4Ckw/WfSPODE9M8lTfttU76QP/jcyiPzCkHkH?=
 =?us-ascii?Q?hQ8xLV8gaj5U6Oj9yboFgtdmW8RHIIyjmFl59ninCTMSsv/OUU7W4uFd+xae?=
 =?us-ascii?Q?1VYE2gmhoOQWC9yTPYC+btn6cJdI2aS/tJZNjyQER04Bs964R2z2ZH45XegP?=
 =?us-ascii?Q?nIx9/b5VMtiANPbwwnPcfaWCTw11yWm3h8TgT2ZvB1Ey5+iS6CoE3QTk0wZp?=
 =?us-ascii?Q?KZFY7Wu7HhR1LcelGUSZaJ3N4iuaMPJE3a+amPBjHoMiSdVcVXg0kdSoiOgy?=
 =?us-ascii?Q?0WicoLz/D5CzZELq6tLFDBMZ9MnIBH5XoC+veggiatVzL9LTjisoX4fjsBeA?=
 =?us-ascii?Q?JBltYvI4FAuxJ1LzWfP/HyYvmHwBpmae5ulteuMut+5ffxtBYjBGlrd3mF1F?=
 =?us-ascii?Q?pd6w3ZFEj1UtxXmUFBqiHP7RfJEwz3A5IDPGHe4iwrO9AF4vpJunNbpKlGCz?=
 =?us-ascii?Q?m7H+F3Mw+XNxWSuav+TCtNCWPOl3GXeLk9voFJskhDyCWEoWArubzsVH2gI3?=
 =?us-ascii?Q?B30p0freJS43cuPR7vhbWaeAs5FT0/GfRStqzMBaP8zQblcDocRM1zq/hL99?=
 =?us-ascii?Q?TKaJJDWcOqx+8JpMykt8UTTw+e+bub8f1yPuR7oV04IaBFwRZZlmA/k4lHcD?=
 =?us-ascii?Q?g7RKSE83JR8o9DY40Yt2TtXZkxn4Ee8kkhS/Nv23SJhr5j0auEtsgs/swNwh?=
 =?us-ascii?Q?FHZonQokjaWMAa6ShPklt1fJ+GFmAAW0RTydIrNOs4mF54GfoOfN8esFtSvw?=
 =?us-ascii?Q?wYlYXNLdo7uEPOeznK8avLpO3u1NInm309nWkyEulA2/wzdTo0vC+cWUhw/L?=
 =?us-ascii?Q?Q3xkraKmHzMo6UU+gTZo9VKNFSsWzoc5eTFk48Z485VV1Ysyw+0+QKpaa5fb?=
 =?us-ascii?Q?zZukJdia1PZzXEEoSwMgi9bS6fF4QYBQauoghzZBJ/aU8n1OMp0PtH5OCRZ6?=
 =?us-ascii?Q?SIT/EnEswYOc6Hcpj5/mDPpUC/6w46anmuUnwzhrDHWBQFAQxKY5Y6YSlwzB?=
 =?us-ascii?Q?KI98396wYN7wQotc9Wq9am/vTk56q35nEF+6x6Ea0vxKF8Inx+3RW4rJXQM+?=
 =?us-ascii?Q?YXBxKHPz7N/OMHehzSLdRWNf8f5+1NhdsWcqMoOtkdBj1bs07i7xY9rlFFtE?=
 =?us-ascii?Q?6KIPlxRDgg=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4cf05d-c03c-447f-8f4d-08deb4ee095b
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:59:18.6322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IBFWkXbYwxHIk/bljIv85FyNQ7XmmhUbAi6mQ5l9+fm54b/FbySxCGqtA2SZLufYk8dGVLooJfDBGLWMboQlHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P189MB3274
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 May 2026 14:59:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19541

The striplevel URL parameter is appended to tar_cmd, which is later run
through the shell. Validate it as a decimal count before using it in the
tar arguments.

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
---
 lib/bb/fetch2/__init__.py |  5 ++++-
 lib/bb/tests/fetch.py     | 10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index dc93e64a9..77fc1b15b 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1545,7 +1545,10 @@ class FetchMethod(object):
         if unpack:
             tar_cmd =3D 'tar --extract --no-same-owner'
             if 'striplevel' in urldata.parm:
-                tar_cmd +=3D ' --strip-components=3D%s' %  urldata.parm['s=
triplevel']
+                striplevel =3D urldata.parm['striplevel']
+                if not striplevel.isdigit():
+                    raise UnpackError("Invalid striplevel parameter: %s" %=
 striplevel, urldata.url)
+                tar_cmd +=3D ' --strip-components=3D%s' % striplevel
             if file.endswith('.tar'):
                 cmd =3D '%s -f %s' % (tar_cmd, file)
             elif file.endswith('.tgz') or file.endswith('.tar.gz') or file=
.endswith('.tar.Z'):
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index bece59e62..5850589e0 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -866,6 +866,16 @@ class FetcherLocalTest(FetcherTest):
=20
         self.assertIn("does not contain supported data.tar* file", str(con=
text.exception))
=20
+    def assertInvalidStriplevel(self, value):
+        with self.assertRaises(bb.fetch2.UnpackError) as context:
+            self.fetchUnpack(['file://archive.tar;subdir=3Dbar;striplevel=
=3D%s' % value])
+        self.assertIn("Invalid striplevel parameter", str(context.exceptio=
n))
+
+    def test_local_striplevel_rejects_invalid_values(self):
+        for value in ("abc", "", "-1", "1\n", "1 2"):
+            with self.subTest(striplevel=3Drepr(value)):
+                self.assertInvalidStriplevel(value)
+
     def dummyGitTest(self, suffix):
         # Create dummy local Git repo
         src_dir =3D tempfile.mkdtemp(dir=3Dself.tempdir,
--=20
2.34.1


