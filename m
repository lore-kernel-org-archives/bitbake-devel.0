Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D977CCA1005
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 06:45:45 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.112])
 by mx.groups.io with SMTP id smtpd.web10.71238.1756795540688708917
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Sep 2025 23:45:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=x8Bhj3nA;
 spf=pass (domain: weidmueller.com, ip: 40.107.162.112, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OdgesXUL5BcpYH9zLMTtyHpSLVc3EH53koM9C19dNaVXFhL2A//NoNy47xAfQOZSs3SGQArkZxZicD3oGZeWQ4b6cYwiIP3ZbcMvYISs5QF6xOwRHdC3mSLiVuN911yA08Uc8ff1i5VJQKnLcBmkO9xT8oswRBz3J5hSK/HeRcbOTic7J2OxkWL6NA1yenFLvQsNWNLSkoxDQDJmSIzFrFzsL6PvvtcBnOWw55TfEa49ATYDFmznObbXYFVBz57Rg6XEHTy394QobpSXmOkWhiOQRiXAkQLW37lRfHQ0paPko4hEavHud0LsbDp72EcgQEObYjPzfWAWf+jkd8+ZTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AnZlwG1oWx2jU7jzpXEQzsgFXzpKypteHPJV2+WNi18=;
 b=yp65CZtzXJFkn59bZM65NC8+HtnQTjFGkmqBb9BFylvJwaVQd9XnvIoFk6OAxdTeUO4OR3UWiVf1HTKx8IxmFLYBGpHStUhKzTHu4p+TtKVe3SppQxwWKyVOVuec2zosixp7aERamzmCbf31cMT7eje0IpUbcSWn3RZ74qzf46YAWa2JHw0B1zqsJjfk/t95cUk+QAf6u0HKp2rdn2akVs1zeGeVnlb7vzaE+96Tta6yl7Hs0XyvmbM1tXU5FCqapsl9q6mhWy9VAeVndRIcVroN1o6pN6He8sGhcO/pZ51a1Ws98IPlBvS4TcJPKrQwGMFbFgD0395z8mKieSQ+ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AnZlwG1oWx2jU7jzpXEQzsgFXzpKypteHPJV2+WNi18=;
 b=x8Bhj3nAgG5K8JBUR3l6NkdbLmBtIJ/mhJwfhaXqTf10HwtWmGvW7QdHdX4zbggvGozZ5cvZR/eE9lqlPTkQHaMqjwd1tyrJULuTzevQpHbufje822XdyYGG7wnVZJgYej2Rg32VLHrDyUa7Kn8+zKn0DXR59+oyTxBp7zf1JMl7i5VfoxgSgcMyBPs4hKBUiViT6Csh1QT+vvbJdSzRXps3GWarRzy0JkvNxTiPbqSmQXbDgbInbRPSkbKKGTr7zDJpFtFfJXbRkiFNepafvj9wYC/Ou4Ob+S/yyPB94ldfRpSdLpGd2UYzyXyL6HIfAiwdqQQ7C7uCBHfyjIWY0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DBAPR08MB5591.eurprd08.prod.outlook.com (2603:10a6:10:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:45:38 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:45:38 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 04/15] fetch2: gitsm: remove dead code
Date: Tue,  2 Sep 2025 08:45:03 +0200
Message-ID: <20250902064515.30879-5-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DBAPR08MB5591:EE_
X-MS-Office365-Filtering-Correlation-Id: ad205bec-f8fe-4269-5d10-08dde9ec5304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1tQyC3GUhuVo8izrNXpvqmngRD90fCiLnY51C13VZm+eMuoHS+TaD3mK5rvg?=
 =?us-ascii?Q?MkxyOkUKgcMG2Kd7JNpgeUGGir2RC8ftfWDBRuQxsUYpB7U6F8DqmXtfWGDO?=
 =?us-ascii?Q?CmVfI7S9/932upJhJTsfOA/+BoRcD4ZYj4ndkgIKDfIHvYM96hovqOOudDw6?=
 =?us-ascii?Q?BNRat4T89wPwASqkjT0ZWdZSurIGZG7gdCp9WiwNiMRh2xRItWQ5Dkviyc28?=
 =?us-ascii?Q?uSsE7D2AHma0K3AnI+ErElxC8ISopxEGQe6pLw5NA9CzbDPCpXrWtKFnvllS?=
 =?us-ascii?Q?PuqllC63ylaG/dZnP3C9Ww+y+YO3rh/0j6rfXNvI/vtnHZDy/WwYzz9Ns7uK?=
 =?us-ascii?Q?myFMjaX1XE0NfU3qf6CW+Sz/pF3tfNOYrYlcXSumm/+Ls6CMtlKkfUqqpPZ4?=
 =?us-ascii?Q?hpPB2KV5Y41yysIP6DAOsFKCe59MUME7vrdzmnfRPbjk50MD3V+gFawyBkxk?=
 =?us-ascii?Q?bn2Dc+VQRofG0AtEY0TxEzJKJ+oi/eyPZlmlmuYyFS36A5/v9pPnBOLI7Z4S?=
 =?us-ascii?Q?aJAdzNSdHideLtoxjefNrx3tRYye4o6H35PdWYIboHpX1obwLlSXBjZdqBPR?=
 =?us-ascii?Q?KABdue1B/vBAc7OqBlGDtckA+aWURNlF2bE0Cz738KOQTrOpcocUw/1GQ1LF?=
 =?us-ascii?Q?YbWf7iVHjikMhQLpy/RDAFX+V+8ZlvNElQLlN54YCkh+UfmUIUizxSNDlCVP?=
 =?us-ascii?Q?IGkVTOBg3n6MNXHBk+amzds4ybopDAECR0vHcHIABbIyIkq7jlITzoLvmMkW?=
 =?us-ascii?Q?ijwdedrEJnHr+BhkL0QWpWADx31XWMpz5Yn38zFMbpOmBWHiKSn5qAAxSWjS?=
 =?us-ascii?Q?U47mI8kSx5NNRepdOXiR9SA72iqqqLaIbE1AulbATCi9KC0MpuTU6H4Sp4y8?=
 =?us-ascii?Q?AI6dOgbcCbGt02OQnXW5E7n0TchVxvQEMvbccfVxptKWYh0AVT/u7t8OOJ3q?=
 =?us-ascii?Q?1/3Y/JfV89Py64pTd8bH6i4gzTuEXWbQj5v4rhxKEfpowV2wFY6mslB7lZyy?=
 =?us-ascii?Q?ka8x61WY0NSZsPU1z71Z0iNcdpvV6/1vbF8bXt+4wVpt8JBdmdmGctlAPZIP?=
 =?us-ascii?Q?3FaB7Yc0QIXL9LIxoC1DYGzwyylXO2gS0RgDkfjLlGAFvQnz5/iBwPF3UCJh?=
 =?us-ascii?Q?mxzxkZx2fqjhaIYQsUtAiGcKugcK/qiipewWrvS4wcTECN4jiPsaKUSxZ9sW?=
 =?us-ascii?Q?a/+nddtmHJr9ae0i+/+HcvTaevaPs1CiVEN/46KRXF4phWMLkK2VQqi4HxIo?=
 =?us-ascii?Q?5VcHi/9fwMKKtgnLMAdR8Vc3/5jb0uKF5u5k0dzY2K++8219q+CO8DsVP79h?=
 =?us-ascii?Q?Qc6hewoz1j0Qzrzg2o6ZRmvXqq58zsCslvIpYDcnOAMDA8O+BnmjZSqZoljP?=
 =?us-ascii?Q?sd2wSOq+0yRtEUXjEd2LNYlew4M1SpOign2rFLXV7uZZXzzaXsdX3MJPF2YP?=
 =?us-ascii?Q?CPSf/nNSlncWarlO5H6xyN3I++bic17eZBtVftypvu8fJHK4VObTgA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NgUeGvXyldm+uiqXJs3I0Na5pZyuHkPp2S0rOcWahX92i8ptiI9lIv50YVn6?=
 =?us-ascii?Q?kReDOD85Xx8PZ02ASU3AREwpaO7zzP4OT62UJw2/8eF/t7JQv9LZ/zuho6zu?=
 =?us-ascii?Q?tEV24oZuBB0GRn7yTMSIH3X694BgGZX9olTgwYtEgP7SubtwGoCiE8CFN0xk?=
 =?us-ascii?Q?UGWJ09mOHylWNAOsWFfwxc1EKkOe+LrFTz9X0M1aX/+g+BTSLW0fznKpX314?=
 =?us-ascii?Q?LILOzJyuqcdxkozkyNIy8nZz3g1itzIAfqmk51bz1o0jDdccQ6M5+upXNPHh?=
 =?us-ascii?Q?yHe5E0pDv8GA4IQBInsdgLhrMPA1CKyeBc1qC3dT5LQiwi3K4PlJ53/3086t?=
 =?us-ascii?Q?pFhiAvCnDNyAV7mo/iYEhsKweIGXgQZQ5t3SbTklB5mo+8zeAv0TS379B9bA?=
 =?us-ascii?Q?LE3/o9TcM9q8dF1zxx0bdYk6aoo4dhZCqTCEzXEqMIQS+Rtx+IKju4ajkBpV?=
 =?us-ascii?Q?AikPgm6EOZVYYyeqT7MNFaKCvYJS0wTnZWc9af/kHgGEbBtD7nLESvRWw/XO?=
 =?us-ascii?Q?lOqTAFKrgAAaVbs1r+tYl8Fw9+pXI4nyi+hfjSR2fGoqpyI7UsAp+qhXXadA?=
 =?us-ascii?Q?O+xAAM0p4qzrhg1c/TrElJpIP2YRGzEHlc4LBEZ9uagP0Q8r3ubugAusP9N5?=
 =?us-ascii?Q?qYjXRf2OM3dYMlCQPENR5NMYU8cWg+aS6WReAb7cb/WMwS+pbfatxYh4s3ZA?=
 =?us-ascii?Q?5yezINAOrq24GvLQy6ikdL4cPMUqPxaPviR+P/Rf8Aa5mxYBD/AoRwIesL30?=
 =?us-ascii?Q?ccY7nVskdFPoZIq44Iv94cmnGW+wkORF6WH5O5bmomvKPEJk7NmwdIJJB+Ty?=
 =?us-ascii?Q?1NF0BOi7GT+SiVMZBt6+Kc8qyrhp88A7q/97v65dfZeKBKpY+0QrS4e250W0?=
 =?us-ascii?Q?aA9JtnFLEHq7nga7FXKhp5ELS1A2k+qoeSMgmZ0mlWixznLpYvlLInZarvE9?=
 =?us-ascii?Q?4RbCMGRpSxFUD6y6SRxktxoEc/krlHSR6yzPoyW9rWeJZN4nKX9NizkhYjC6?=
 =?us-ascii?Q?pDuVaVkLP+hBQGuQ1MfYurAPbHaCfuSpwDqMxUpGX9Jw3OJbb96xBdp9Nu1o?=
 =?us-ascii?Q?TzYLmeLPjionLdUm3Dsx2JB3/bsml0zO8lAJixFcyi8OCnJ0z3fS25d0PBu+?=
 =?us-ascii?Q?pc0uHxWLvGVSlwKPJswm4obHpeLhlXriCyHIvtr+v4Vl6IeIID/omoM2uadq?=
 =?us-ascii?Q?a/RURmA8UlGWlni8LctoA3FdXUyZ7Aj1JuxuK9Q+Ei53p3KhO4UlrwAvzrDn?=
 =?us-ascii?Q?RxXOVAHllXynPcHPzFPJ6aCIJzpe9k0c+bopv3PVrrks8angNbYIeZ/mHutc?=
 =?us-ascii?Q?4YuE5PHepzl3eSMd171Vdtx7ooSfeGl3dBxN19WrWPJjWPPYBWHoei+jNsTw?=
 =?us-ascii?Q?30x/P33EU1lp3n0R8XtGnpkICUZ6i8s21GhujD/Wy/c+HWUOPtBt+6mvVFFB?=
 =?us-ascii?Q?scn8n9KsS9Og/Sxq8P/jPgrxIErIjgMjinpnJw1Otm1VVSWZcUG5edvsBBbL?=
 =?us-ascii?Q?lRMbYXxjH6BSdlqmHk+TUwuyFKtY/cX2nxz7ke4afdlgNkiTzxW2l3XnrYDZ?=
 =?us-ascii?Q?FerNw8bI2BLbHezMa+3bbGLbsLRVTe/CP2Gc2uH+rK+OZyXpURVdI7/Pw54S?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad205bec-f8fe-4269-5d10-08dde9ec5304
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:45:37.2780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4sBQBbqPu3bhDtOV7BUQlXhCk94YyjcgT78kgeb6O8TZzBypNAbcqWvtVIzuLtCQmKHiVUA9DJ5+ZSFx4o03jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5591
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 06:45:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17923

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Remove code which isn=E2=80=99t used inside the project or the tests.

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/gitsm.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index d9ebe8d18..9baefb3e6 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -218,10 +218,6 @@ class GitSM(Git):
=20
             try:
                 newfetch =3D Fetch([url], d, cache=3DFalse)
-                # modpath is needed by unpack tracer to calculate submodul=
e
-                # checkout dir
-                new_ud =3D newfetch.ud[url]
-                new_ud.modpath =3D modpath
                 newfetch.unpack(root=3Dos.path.dirname(os.path.join(subdes=
tdir, repo_conf, 'modules', module)))
             except Exception as e:
                 logger.error('gitsm: submodule unpack failed: %s %s' % (ty=
pe(e).__name__, str(e)))
--=20
2.39.5


