Return-Path: <anders.heimer@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A73CDB466
	for <webhook@archiver.kernel.org>; Thu, 25 Jun 2026 07:08:05 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.5])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6004.1782371281365926738
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 25 Jun 2026 00:08:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=dgL2Q0LZ;
 spf=pass (domain: est.tech, ip: 52.101.84.5, mailfrom: anders.heimer@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufGnl55WGvvM/njA+PcTbO5U46OXblwCsYeMcBRZ0VJsFT7ET9rJLrw84Q/59gPCsGjiTbWNdlGiRyy2JHek4eBPOjxN+ZZu8RvxdKIPt2dATadT7nNgU7X1mbGvrQOv28uDZeGuSOO4NRogmdwGlLppvIG1/0AxTHRdyQQtiZJvacR7upYjS2tJiA8GTNf4fMQ+0BaT9l9kxRvcDxgiQP0U1GbLjzliTFiZOmvvz8lNZdUU+Ghu7Rf9G0icM/u6l6Q5v7mib90ejLNKasj1mcUh8Cp8r2+gP94JZC6D0pcYZqDJZmw65EHbnq3q80Z88x7GQr6DS0h+AWMjiRNhRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UAqMZMLb45uAMQBj599NHBzCnAZFe5SB3Un0VPULUmA=;
 b=LGaZ0BYnTvl3MjF4ZRpL2XaM7HW0J9ScnDEETfZELI81TxWw+uLRt2bQtm0dp2M9zKDr/k0nCYyTcma5ZACNp5fyLuGLV+4YEGHkj6nBlyewXxAQJDZXxZtTgC3gOwnfKxH45l/EYsOhswMSvnbfBOKB/HW6ebDR3boU0TtEc7X+I9x1KvePluqqtjM/KMEMIcyzmLNxMfyULO3AZHJlFkKQopbPCax0bYKK2z4SDnWLkVit/EEk7RFO3d5Oc5CKVn4nLFNdAska2+kECiKmyBKNZyvKL9TrqHF7bqyRYHxgDWRR3tjJqISUAIWKjOlHXDX21k6aRFHwnLnZwVaHUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UAqMZMLb45uAMQBj599NHBzCnAZFe5SB3Un0VPULUmA=;
 b=dgL2Q0LZJV8Li5fdUOYGSjJaA9AkTGMn6iHh7KcKKfKhYhYSMUx3+iedhpnku/H+5pVwykCVoFQsiqpxAFd2ouGh/vHcqd7bnehPR+2yVJ15Zz81gVQ00Ed62wgG0U89vpTxwx+WkDeHzYp69Kl2H7u6lMnBOQ/wmD1n+E8CJsz0BTQzy/FRKb9OWxsJA+5UTxf9C2LBv/CggGdDgYsovONT6NN6hsI61QgCSHh18swaep94CnuyPlCz58ldFOCSrslgMiqJ+TTNPflf71NmB13b+LiRlU5Pb+01MKtLSMxrrrQpRtNt7R+mq4BySAHN7JbWzwt/Os6ncZ4Uz9LPDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:2ac::9) by
 AM8P189MB1316.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:246::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.16; Thu, 25 Jun 2026 07:07:58 +0000
Received: from DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82]) by DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 ([fe80::90da:b700:f102:5c82%6]) with mapi id 15.21.0159.015; Thu, 25 Jun 2026
 07:07:58 +0000
From: Anders Heimer <anders.heimer@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Anders Heimer <anders.heimer@est.tech>
Subject: [PATCH 1/9] fetch2/az: fix wget command argument construction
Date: Thu, 25 Jun 2026 09:07:42 +0200
Message-ID: <20260625070750.2757558-2-anders.heimer@est.tech>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260625070750.2757558-1-anders.heimer@est.tech>
References: <20260625070750.2757558-1-anders.heimer@est.tech>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0134.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::13) To DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:2ac::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P189MB1641:EE_|AM8P189MB1316:EE_
X-MS-Office365-Filtering-Correlation-Id: f29724cb-25a1-4aef-2f61-08ded2887ce2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	9VbtWTq2QV6F/lzkxih8czXFJxy09phfVCCJjDDQU8iQNycxpE0y1LrR+2/sYbAsd+zbfE7T46Zt0ikTQICIuXz+3xtgFBHc07BLy9wwnTc5HdBELzX0wq3Cp4A81nFYBkq3XFNBIBzzeqQHGfEuyy/kS7D8DDi/ePLorfOWpyeT0tM7kQHH/YIHUulnm1nzuplXNlD8jjcHFGqhYW58GwiMyJBzU89gq6/U6v2RnYpyN96SVXxAOlVhaLWlPKMkRbVLt1tOdrAWcaSq6dEsiOIZw9x/3brQ3xjs/TLBy7vMhAOpqVB4kOcvpgfTKudtwljGzMCoYcK+B3aU6wtWEBI27669cI+yRHFcagKFJexI7pMpf8zYbamCct59IC7rLyddiea1zYy3nbTBs8UvEFeviC+xhQwXJcaraM7qur3YzbzNOzKCwBvL0rbJt2/ClBSVWAKcNH89vEFvblUtvm/LFZ6J7FLP7r5+CCYUtsCoGSVLy6+f7BDB5F1Zm5WS8zvQ2ISJyuF4zyq0GEr6o/mxSvBAuk0FUnlDaQvNKjHGDLEvhEjTi62qKNZ9GQSAppnjhjR6QzaU7m8yc4SXwLk7WLgMcgR0GGizvLJndDEt77moX4/SrVmo2FPlfvFeUlGUkzGbHQQTjRrsxaxWqaWNxa9QJqcnNWuTquJSgI8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1641.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nViZVmk9HLXicnAojzsbCWl+jq0qAhYBD5dA1AMUrUK4eSDXEppRVVVua59g?=
 =?us-ascii?Q?NUoqmfO1Qv8INax9gVq5UFjc8P6nVQzaS8Zx4wRB+uS4S52lflUDT61dt/Jy?=
 =?us-ascii?Q?vBDQGSlFLLXX9OSwCkDXH7yEzOishHXB1+gpdx5Nhn/D0d26EAqja9lIxdVy?=
 =?us-ascii?Q?+6Mch1hjUoS7DJdAVXw6CaqGT03IFkOvEiELHMmzz3ON/Pb8w9V4eCQH0VYf?=
 =?us-ascii?Q?2AtLuUl1PtKylU64u9/sTZjJjuEUf33YIBxqS5mREziBPDW1+HWgOtOaxIgo?=
 =?us-ascii?Q?wPzgTIGxzt0ZPpEP2YgeqeR9yNMwnxJr66IwMQF+XotGgwkiePJodbRVaSpH?=
 =?us-ascii?Q?O0sTkSUi2EU5XaWBc7DpTxGOgUUzoAyjs1V37CZiepKetKzVN4aTmZb6//NX?=
 =?us-ascii?Q?FnF1kHvsBwUZchJGKSDTqxLtJbsfMkTjrBRh85mFqQY6eYfwvqMJBoIPrAqt?=
 =?us-ascii?Q?FPjnZwhmgMP7Cepn2rOmBXm4QryasXDvvpfnzi8gyX5CmFVtWhMRAo7Uv4hC?=
 =?us-ascii?Q?kgJFTiEA9c4wA+AfhABvBmYQbyUx8tEEafz6zKDpJ4xh4WYjWz1hi1L2Y4DI?=
 =?us-ascii?Q?6rLha0SYw5kw3d2s7KfkLQhbYLlW5GuqoEYfPhR+8iZtHAdpOnjqA/isBwj1?=
 =?us-ascii?Q?Xkzlbth6Uhq1wZxcX1Fe8icFOndqKrZTlx85aZf5i8ZGJKfWSKU34mdGJKNU?=
 =?us-ascii?Q?InfaPs9VH5gmsTsdaocTaod8RfVzMqgO7mc9k5QikS4P8PuyjDeKuFvmMJLH?=
 =?us-ascii?Q?I3Y6b/uhmWk4WEEkiwtG6qJ3Q+COMHmfxDBgjXDInB8EjdquypOScdX2yIjf?=
 =?us-ascii?Q?jEcnSj0Yezc3lVCpr3G54y4rUyVqtz5YVEkeKywWbqXE717cxMHU3DD41kre?=
 =?us-ascii?Q?T1CxrfrdIJJctXAT3GG8wZJYlAOtX2TauJH8fVfsBz07BmM6JvZ3taYR1pci?=
 =?us-ascii?Q?p5sADqKbiXFxxNIoFLefx1QjGSovWbwX40dBcIL55EWAW4flyYx89Yh+kSHA?=
 =?us-ascii?Q?n3izuY2AZpY0T7p5IMinTWKvyLXyeuWskt6imATMhmGJCAO8FgKKMiJXjO3T?=
 =?us-ascii?Q?MDxhK/LwrLLwZ0ii1MXSbml/JabtwgVVtJPXPFkRdlmlJvbkcUt7+JWRvCaQ?=
 =?us-ascii?Q?NoXKLqne5gTCrnzs2PgfES+vS35VPyZkaEu5GaiK2xvinuw/s8MxZsIWa1Rj?=
 =?us-ascii?Q?dw26/ZMATNWBsb16Uw+HrsGGZnE+UBJAX37730uQk2m7t6gYH29L0ZsFdy9B?=
 =?us-ascii?Q?MZ60RkGU37LyOvwiWrf7Dy2/J6scMDdfrwK0svV3yusrYcLuKRcJXzT4d+li?=
 =?us-ascii?Q?j/T/1oNHf8GZKGShvQJoSbOU9HGRwW+J96FM3Nds+uoZzX9Nx4oDoDifpfkW?=
 =?us-ascii?Q?CRVO1u/o3MSrRA4Wwa9DZ93QIVtBcZGADbVQciPXP4tYPRw9XfdSNqIgCzzv?=
 =?us-ascii?Q?6KeiM3klvIQn+Czvz3UEIPd+gTophAfBdNmx+9bhHfPaFngz1jgrnG8fetAL?=
 =?us-ascii?Q?csQopP+rzgMB4202uPupfwHnjbMy+YloMpTw6uVKHbvRqS3HipZkz8lA9jq5?=
 =?us-ascii?Q?o4MizA+YxYPgsWb8HXmqiwA9LJa4H/BmI8GDjzF4i2BP9kZdjSq1inrExe+I?=
 =?us-ascii?Q?1/bQU7XoOeusmuEw0HOV4bLkKAZvjBhW3Doz0z0JwmPIuMU5HgkyTVHpl3gw?=
 =?us-ascii?Q?A1dORfBNnvDZ8NeUrq5r4aChCaF82snBsccLIPAFbY52f60813II6b+kKd21?=
 =?us-ascii?Q?LkpHPPL4QA=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: f29724cb-25a1-4aef-2f61-08ded2887ce2
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1641.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 07:07:58.6505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uUBoeFRMJCPT+9wu2Hi33jHayQFaWr8vwTiclT3FHL48mG4DiCQHOkrtReg941br+SuWijfXJ20q9eTvF48cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P189MB1316
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 25 Jun 2026 07:08:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19780

Signed-off-by: Anders Heimer <anders.heimer@est.tech>
---
 lib/bb/fetch2/az.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/bb/fetch2/az.py b/lib/bb/fetch2/az.py
index 1d3664f21..81fd14468 100644
--- a/lib/bb/fetch2/az.py
+++ b/lib/bb/fetch2/az.py
@@ -48,17 +48,17 @@ class Az(Wget):
=20
         # If were reaching the account transaction limit we might be refus=
ed a connection,
         # retrying allows us to avoid false negatives since the limit chan=
ges over time
-        fetchcmd =3D self.basecmd + ' --retry-connrefused --waitretry=3D5'
+        fetchcmd =3D self.basecmd + ['--retry-connrefused', '--waitretry=
=3D5']
=20
         # We need to provide a localpath to avoid wget using the SAS
         # ud.localfile either has the downloadfilename or ud.path
         localpath =3D os.path.join(d.getVar("DL_DIR"), ud.localfile)
         bb.utils.mkdirhier(os.path.dirname(localpath))
-        fetchcmd +=3D " -O %s" % shlex.quote(localpath)
+        fetchcmd +=3D ["-O", localpath]
=20
=20
         if ud.user and ud.pswd:
-            fetchcmd +=3D " --user=3D%s --password=3D%s --auth-no-challeng=
e" % (ud.user, ud.pswd)
+            fetchcmd +=3D ["--user=3D%s" % ud.user, "--password=3D%s" % ud=
.pswd, "--auth-no-challenge"]
=20
         # Check if a Shared Access Signature was given and use it
         az_sas =3D d.getVar('AZ_SAS')
@@ -73,9 +73,9 @@ class Az(Wget):
         dldir =3D d.getVar("DL_DIR")
         if os.path.exists(ud.localpath):
             # file exists, but we didnt complete it.. trying again.
-            fetchcmd +=3D " -c -P %s '%s'" % (dldir, azuri)
+            fetchcmd +=3D ["-c", "-P", dldir, azuri]
         else:
-            fetchcmd +=3D " -P %s '%s'" % (dldir, azuri)
+            fetchcmd +=3D ["-P", dldir, azuri]
=20
         try:
             self._runwget(ud, d, fetchcmd, False)

