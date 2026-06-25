Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D0FCDE007
	for <webhook@archiver.kernel.org>; Thu, 25 Jun 2026 07:08:15 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.24])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5833.1782371286374348394
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Jun 2026 00:08:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=ajXWxEsf;
 spf=pass (domain: est.tech, ip: 52.101.69.24, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BWLG5ZxTQG7u1b6Suzl9zMdaJbNg7Kvd9JNogtlpJMc48lpAKKB9Bcv+0PqOAZxWt6SC+9WHDTMe1lF8tsrVkp05g55oNfHqUwWb2btPWQV6fF2H08NkM7FpIFrTtrZNwPtvDsRO/GLMTnVF+Ql54UZerZaLb4sLQ69KTSih2H7MGBMpLVqMEY/SkWM+0g+EJsy6SRCU3j86B8Z7nehdpRByEE5WoX2Pbd4mBRMgosrf9kpjSArRkFsOJapEJQUZb9U33tNdP8atZ94TR8xI+xZX9u6Ely46ZPkEhl4oDDTk46wQ1us2+mcCUqjO/HDOmLLFaWTB+0CmesCLukwwmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAHwf9+WM8RAujiv2kJV3tNDJ0IjPjuWsE2Er0JLcUw=;
 b=cvcY47JtkxLHGtSQTc6Dylsll9aCK9Owc20xM61doPRN+7aY3qflFicrAT6fKpnQTpOISC5Aq31eygs3hKVD+qs0Co9Ilpv8AJuHkg9s6HxGeFOC1bOWefrn3vPsVX39As6FplsfjlHZg20HsB4ciNTK9Sm2LgXwkyeTCpqrIeR0FDAy5bFkV6gBXN37ElNXd7mve8+Tnw1Bg1a3y2qOyKiNS1gP18F+Utg/do7/nxRKObcqr+E3WWntfZNs9YJAlGlaRrEBSZtMHSqk7on8CAie6ew0SG2gZIaxKYWvrun4Bb/idniiPSLQeF/d4CwquUHRjEMUoanoH8Ww/fG7/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAHwf9+WM8RAujiv2kJV3tNDJ0IjPjuWsE2Er0JLcUw=;
 b=ajXWxEsfAGp0qlclNTrXozMGejcThjDoBZjTg4aTXn8uQyiD+3o7Uv3n0wSUKi4FfeUfsO3uH8nvmzNaAOzaaFQ8md1ySZQ7rwv6jKNegAfUhN2FL9POP4ggvZEzLaOROf5TxB0VWMsf7nxGRvtFM5eH+wMY9+Shj9uRsHYNasEvzCV76/zzZECexREeZ3uwJ3Z4KakwkbfGXEwgMjSoMb/NThsvi6tKB3WoqesIGIBwoUxhXNEQLOE6U+E0dNMtEIC6RDi6jT+0+aU6tnwcCSrXMQJEVEGg83MWFYPCMwpESevPwAPIfSQtaaaYsiBXmVoJ+/Us2y/phEqDmM/gpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 BESP189MB3178.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f4::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.14; Thu, 25 Jun 2026 07:08:01 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 07:08:01 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Anders Heimer <anders.heimer@est.tech>
Subject: [PATCH 3/9] fetch2/git: do not shell-quote the shallow clone remote
Date: Thu, 25 Jun 2026 09:07:44 +0200
Message-ID: <20260625070750.2757558-4-anders.heimer@est.tech>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260625070750.2757558-1-anders.heimer@est.tech>
References: <20260625070750.2757558-1-anders.heimer@est.tech>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::13) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|BESP189MB3178:EE_
X-MS-Office365-Filtering-Correlation-Id: 28835a3f-0a46-44a3-d8af-08ded2887e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	ANUbvHkRF7TRYtLnFbSQR9L6s6ghvOl+7QprjIHh4hAfc1KuqA2AWjXkf+eJa5kEq08GGM+ZHaOAbMoVFEP1p4yyMMuJkRZ8KkHHUnVbWAu9u7fo7vWcBm7JMG/EYEJa5vvgN6Uxt3CI9EJAhlpxP4PwIHEwo8Tr3ummVLglIMd+sB8L0QElOi2hubHF5V5i1Bxex34r+mmpwNUBIkHk4N/hmMsgr1a75tKyKEDKck/8cA3CqDCqMGXPUtVzq7lijEy9MGS2l+9H46Rk6D1DYpMWmjji2DFUMRfj7kieM7KMjI+jfzlt1B6QO3cIumUz9Le+zsYLxsTUsgyVPMnCWF7XlFZ39ZqUhQBEWKEdnbVfzBTcnqLfqUk5nBsMsHUnEwY3OshbhNJefwRBCrdioBKEDVnQpZ1fDQAqv2/e+plDwaXSb9tFJCkZjmg0V41SUQyI3qwimZSCE6BtT+UvJyiVj3PazHCo8OHnBpep3ByMCYS7ix/0tbww95LbaNs15o7NWGAiUi7q76m4xjwuxBKehqkZde+nb4y/kxo1936itP6HFBRrDJ9Fp0YsDWrEiD1W2r0WBksx9wtp7sesyeTvgszPmfHrKdtA9gltEr/7+SxEMXOAI+eT+9Tfn3XG51zGXtT5uwqlBzzLsRufUAzHbCLhRygt7kE8w6Rls9U=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TCNcgcSmswSEN9zQgPbWNNzT8UyG0jozfD3/s5NJgctTzEe15IfZ7OepzO1X?=
 =?us-ascii?Q?qkKgqHa4OXPl+hNOHLoMwrLCR528X6+h64/pAkvSmoWRlUN9AppEZUDhQ7Sw?=
 =?us-ascii?Q?m8CBOmV+6qew6Xfjjh7nvQjS9vu/+dsPkXrxbXAzmCPeSunSxUIn6DxolmfT?=
 =?us-ascii?Q?MyPDLfLTHLWmi55MhPBtV9ZTLCSU9sqrDINd0Cjd/64YeY+qhhjq24ZPZRKb?=
 =?us-ascii?Q?tGXlPszOlTP++tfn3gmccOhnYTvmR3xNK9jj3//yT9GyJiDNxOYQQ3T3TCpJ?=
 =?us-ascii?Q?zCrKBi0gkAW9zoQUdETtibH3PdXgFJ0mS2sSslASZDr2y35zbdLqRJTosS84?=
 =?us-ascii?Q?mqmDJXVkdJjjKf9CU767v+WQrHzux2ERkm+1v0QdYGjgfJNbCkB8IwCKHppc?=
 =?us-ascii?Q?yS86Qi5TYnox1uk+Md8UNyxiZM4CrYy3TsWFIDLmKpz4AexdNkKt8Ee65g8m?=
 =?us-ascii?Q?KNl2p/GA41HZ/xU5r8ve4b0K+QO8bTssbC+scGEe9uPMq34ViCvnQJj0y4ME?=
 =?us-ascii?Q?yEpIjwX52Ym/5l37NkP3Hc2ycArK3W2JJlXokgeDtpgZheWTssCvSxcTLy/W?=
 =?us-ascii?Q?nzf1cNMdFanegwOOpw7mxLL+9oaoN6GoUDGZfxcYNi/knThgBvW6o25/BpaR?=
 =?us-ascii?Q?TWfXrIsl7nxwnL27/nkAd3RAvdDSVbclnCxl+g+XO5D8EzXowaUWa+oupmSD?=
 =?us-ascii?Q?p847yKcIAa7ImzQpD0ClRX9xEXBVHjxd76l+jugJ6dvTK22MOyH8zgcxk8sa?=
 =?us-ascii?Q?l4ui09Ome+eH/RLoUtZxFbh9c2zn0RtQHKzzuznJlJ0oAunkHIdu3V+wv2FQ?=
 =?us-ascii?Q?Ozij8mspdfCF4kyoXVMm6jlanGqGC4DlKUwYKhTJgFq2LKjEvUyEa8L1XSy3?=
 =?us-ascii?Q?oSwtua5XNCeanIibe+SF5hT2GhUtKMIN7n0buC+MGjGQ7BCcltGu3BXHQ2FL?=
 =?us-ascii?Q?kJTEvT5rNOL2NGofqSaeRiXy0DIoAgsYV8o6p8QCT0uYhBisk6JULd/Emm8g?=
 =?us-ascii?Q?Um9oKW4E7TheOphzrfV7FCfEpbZppugrMhPJoEpiA7+91JSAUFjov7OGO4Rs?=
 =?us-ascii?Q?htTRgi8b1NvjCw1h3qJpdq/TWbDzK49SHrigoTacQuDpmMXavXVyFjtJmLqT?=
 =?us-ascii?Q?etbFsyvYf60eou5bYMrVSlAZHrGj1Mp1IsV9gQn8XJ3TUx73K4lF4jha/XC3?=
 =?us-ascii?Q?Gt2mQw0Ej8EHVbGc4rHEBsQ5TVdivZ2iK8CjKKroSFMEbQnqnZPCx9vY602Z?=
 =?us-ascii?Q?yDiMLsOOfU66BzmW9jjIexZt8m3E775+zmrwsrhwZ8MzZO9Tc7nFd8XBX/1D?=
 =?us-ascii?Q?tHNznXT6QWA/9iO8HZxUnQdrgsRnb1LQL4ScoQEmCLr9uNVCgXpkh9dTlSrg?=
 =?us-ascii?Q?JTFOqj0q1Y8ueNt+Rxt7J9KqOOdvswICyoW6Y+kF4Juy8/FeN07MDeiEhlQc?=
 =?us-ascii?Q?Is6Xx3CwSjSVqXb8xbeYrUbY8uKLRmZNfOI+peRg4WF0dzmxeJSlwidt2uIL?=
 =?us-ascii?Q?bOzoFeMSzZBUaFBtkVRAxBhgm7ISghWSi2h/mDXBt1Vz2sEGlm5h6cD+1sAA?=
 =?us-ascii?Q?Cdgy4ld7huLvC7KVlIQH8/1bArFQEAnzEOZhHC1Rz0iUoqdf7YlIoo3TE7BK?=
 =?us-ascii?Q?KrSIUYT/mjgvkbpGkDRDc0sXZLJAjbHcmok2+UjvHndcpDS9FaUCrB8DNhuh?=
 =?us-ascii?Q?RFGnDw7c4dHbA7tW1cCFcoi2o3FCP+pGFEms7AJiqS/iSerDI9PvxEnaMP4y?=
 =?us-ascii?Q?kTB/Cf4jLg=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 28835a3f-0a46-44a3-d8af-08ded2887e8e
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 07:08:01.4620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fU7WedNxxeJw7YvoBVNuVRH01jo47x8JcBNlWGeHzoDyT1c0xjtPWoqhBkKouATJk9aWyRHpnkfRjzA5w5MLBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESP189MB3178
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Jun 2026 07:08:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19782

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index a456465e6..00983b744 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -580,7 +580,7 @@ class Git(FetchMethod):
         # Use repourl when creating a fast initial shallow clone
         # Prefer already existing full bare clones if available
         if not ud.shallow_skip_fast and not os.path.exists(ud.clonedir):
-            remote =3D shlex.quote(repourl)
+            remote =3D repourl
         else:
             remote =3D ud.clonedir
         runfetchcmd(ud.basecmd + ['remote', 'add', 'origin', remote], d, w=
orkdir=3Ddest)

