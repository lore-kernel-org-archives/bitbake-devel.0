Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F002CCD8CA8
	for <webhook@archiver.kernel.org>; Fri, 12 Jun 2026 12:01:49 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.13])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.68479.1781264355057812423
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 12 Jun 2026 04:39:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=zGF0xyhh;
 spf=pass (domain: est.tech, ip: 40.107.159.13, mailfrom: david.nystrom@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZy3yUZikff8tecXYwm8LV9+8jrOORA/+OUFJlfiqWTPfs0uM2clQ953BR41oNjTRwJ4JRlHJJyec8yJeu1H/OWV9GG4TF/68qtDOcpOuunIF+C9UQRO84VkRe+d/EHu3SJsFt8s1nLkkR0xgc59SbL7cxkh+0pG6Tt5dxb4eq68ZDL3F650ZlRIkVbZuHlmIZzBhuRU3RGEVOt6MYybexrgdMIS4BjA+u+uJ8qZvCOSxgzNqkVMEN8iEkfcg9YvCw+sU02wtcCytOS4NFADH5uGHLkCNnQo8Tm6lvgmKmjUohqLM7Mc/U4CasJdnv9XliBTIQj+hjGxVsTrWuw3bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azR29WMWg93KNiV1ZrO0/9PZM5pmnsuhFJyfiuxlEeo=;
 b=WE8PQnSIklYOBh8S1pviVBRNNUojkNe13TnsaDKQh5RaE/rl96udnrBEuL6CTzSzoyENOncP8yXoPPZLLRQPX7a++ImkCZ5WWapd9dSdBBOnmp8BN8nPD48U+YhFKnKlM7Gg7pPR/m7yp78b4aKEgZDWjhJbhv7mTmmf1uZ7xg40HVoRCe9psIsP7vW3VCpKERsTVmZ1TNkoT91C1//PtJZyk2vCk25XiAsgMVdx9nylcupOY0dKH5dAiGuweBr5BMNu9ihgrJhOx5Ioz7DTo3r9Zur5mZgzcZrtaKIOhqFCWMMU6zenbp6A4x3tPNTwnlWssh9yToi8/dKC1uq1ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azR29WMWg93KNiV1ZrO0/9PZM5pmnsuhFJyfiuxlEeo=;
 b=zGF0xyhhBYyylzUsuxR2p75BRyzxPlzlqsxsc0zNMyll1U93eFJsEt3ujk+uNzqSDfLX2VmfcFg2mB0obHZa6W6qjqFby1uwgHtynlzJz4SVJMGMpDB+TbIVlGMf3axCNOwoSj0VLrXC6Okk+V3pqyXyeDbbYLnfhjlMJxxcJr2V+EPnE+bK/MiLu5BnHyk4QvJ6xZDirRzxsyQWSyvqpTizTWQ5U387uJRaJWQplP61d049+8ySNalYXTIKOwrdF154iQEahnUq8FzXMYYmkkCUE2eXPVVQHM9fbdC2wrvsRoAzg9xr2dfgL3GB1xsJB1/lKWZaMTuLXWhYrpCS+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f3::19)
 by AM7P189MB0693.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:121::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 11:39:11 +0000
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::49f:4bc1:672f:45c8]) by BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::49f:4bc1:672f:45c8%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 11:39:11 +0000
From: =?UTF-8?B?RGF2aWQgTnlzdHLDtm0=?= <david.nystrom@est.tech>
Date: Fri, 12 Jun 2026 13:38:31 +0200
Subject: [PATCH [RFC] 1/2] utils: Add landlock_restrict_network function
Message-ID: <20260612-landlock-v1-1-77891f63ed7f@est.tech>
References: <20260612-landlock-v1-0-77891f63ed7f@est.tech>
In-Reply-To: <20260612-landlock-v1-0-77891f63ed7f@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: =?utf-8?q?David_Nystr=C3=B6m?= <david.nystrom@est.tech>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781264338; l=1713;
 i=david.nystrom@est.tech; s=20251215; h=from:subject:message-id;
 bh=QtrHuTIhhcfz+u9fBk4B37Ffg8BB5J9djxW480L8++Q=;
 b=/Xx72oreKnno3qUhw+sUnan+PLrL4PP47R8U0sgdVqwt12Ag+gZTmDPaxup3WXTu0hLF48tvw
 m7CwjRuIqrjBt6Mzp7cjlUIfozXT1jM18r+7q1DqHmf8fFBhzUugAXj
X-Developer-Key: i=david.nystrom@est.tech; a=ed25519;
 pk=4E3iRjA+3w+a4ykfCHDoL5z4ONs9OcY4IN3pTwIG7Bs=
X-ClientProxiedBy: GV3P280CA0048.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::29) To BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:b10:f3::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP189MB3241:EE_|AM7P189MB0693:EE_
X-MS-Office365-Filtering-Correlation-Id: 59addd31-e7c9-4fba-3639-08dec87738a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	yylJsBQ05dkbjyWTtqr713J3EM7NXIiX+gCBkZoee7agMpQincmrYjqHFu1UvKPlYdsFZEAQmwKw0BZee+qPIBqU/8AqKHjwpiV54zimn+ul2LMxPYEYfEhofM5DmaIg9Dom/brB13TDkTWEzbiluJEere0K/L/ngX8UsNLNgmLZC85AGpbwTrrpsml1ce4ydxquQy5THPTLSxJPfTu2pEB1i10aLUcxODnEB90q0dUKQuV0ko2aH/6AjJbQ4g5RUlZjjQX4a6lBeukhfkY9Ci8DmsbWmBUr9ReaVyj119eN8LBScMcW+X9U0sPgPW8PkNBmfEGMHRRYJLghJLvzzxvua9wl15dMg2JPlJskODx+qADCspzQVcgiMeLbbTA2M3hMzQhhTd8MR/igx55o1q1fOIdUQj6o5LPLW+M8/3GrasJeTisvCcAd/94cDW0nrwb3+XofvOYxFQzW3dMYZqoEnv0J0oxWpLWFZaBGCwzN+yRmNQzeC+3I8MxIqtxunTBt4qtI++TaVnjp95Hp7k8BgZj6Q9VtZdrBU0w/iUCBywVKkYj5yYYXE5A6lx3qDHIzQsCQdZN2IysOqtEpXZriMaLpOdUffQT+u6A+h99nASVJqc76BlEBsjwCEasJGP3QeLW9YepNVfd02Wf7dGj0NJrsLGZ0d9TkXghycSCaV4hjeHKeHQ4U8wl7hhXH
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP189MB3241.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BhcSdDso1tieIfNLBVfs5VptobLh8Uluv45CULpcct5PCU3oGZLeVTe+o/e4?=
 =?us-ascii?Q?gEZ4FZY607cd7Zgg0AL3q15nlJFR/BxKuf1YXQS1FVWUqn+LjTQvhZxvBvek?=
 =?us-ascii?Q?3Qo/YTwv9zJnccbAl4gt4icji/Dk6UFN2BgGPjw+PFeGBFswdVBqQJQDcWw4?=
 =?us-ascii?Q?ufgziiWiWVl3lbjBwiqnKPK1BmPUOYYqWpmSzhnKrNjbPYXxhYeDdJkkKfC4?=
 =?us-ascii?Q?UjgyFW6OYYdUCUtpguFB1me3dkEy9QquBNn9tEH8icFg3Xfi1S+BBv4KcYdm?=
 =?us-ascii?Q?v30gbz+wJxdG8K4YtQrWnxbxjnD410CxyzheakHNif0d1F9KRx6hSkiQ4BOb?=
 =?us-ascii?Q?qN5Zspp2UsD/+SSdNUvRL6tJZpfrvJBD/CN8SFj6HhYzg9UBmmIv+tGkwKlo?=
 =?us-ascii?Q?GDM0nKz+Dec/jGyqGqrp4QDyYniW6t1LvTOnu2w/2/hTdDyG9enrsiyM+1lX?=
 =?us-ascii?Q?+ifcWmuRvzpbrHpX+Qmecim4vh4q3SMqDSrQSxuxxGWNmLo8OZZfUY1j3RjY?=
 =?us-ascii?Q?sL1ZhrYsU6vgrvaE6Sdkns+d7DTtjrPEL6UPXuSo7c+5f0GxzMI8mvIggHvx?=
 =?us-ascii?Q?TEPUSVEM7c/6HNC2RDQneR28BelWnnApgdKQMUWFY4oORys2ixALLkJdtREo?=
 =?us-ascii?Q?RoKJg3V64hqe2l8nVy4bnCuj9Vmc8JKE4iqG1KRD7r/5HviGkDgMedIILjSa?=
 =?us-ascii?Q?+Oi+8LMyp6Q2/5y3uTkLOm0zwpCh4QT9aYQSyh6kpVmtfw4CTTy6BA2arBio?=
 =?us-ascii?Q?zkRCe6LgOcQZAC4CeL0aR8QrzK7o0u3Nln2qWdhmwYQwaOaP3Epn5oXmFZI8?=
 =?us-ascii?Q?L8GiwuE2Ra5Km6X2swcSNplCJUPc8TO6c602pQwIsKdyh3nvBS8uDiFWZCqN?=
 =?us-ascii?Q?zEEbogmHMgn8tCgxb5HWihR73SkZpKgCshQOOEHGEYVJiImyQkiluX1+KbW/?=
 =?us-ascii?Q?SVkbOdXM3OHuK18mOD4czBYBh7bOFT1lkxv4DYjyQC5xb3xQLa3dy0MjirSm?=
 =?us-ascii?Q?NdCQK2S9G0DXYBfrMdGQou/Tdp8xUZ0H/oqahzny5VC1aagiNGsJTB/WTa91?=
 =?us-ascii?Q?G45WX8Okz6i9xcpLxNmba54sMkqNXUw4ps7DiM1eBX9T1gi6Akz+17sJ1VWM?=
 =?us-ascii?Q?+a8whD+qchChWHLmUunwS6sfssJ3PtDUnY7+aIlJSIHTGUY5UPw+vdqFdN2F?=
 =?us-ascii?Q?xFNJkWp638hx9TYkCJ3MOPKRJRYhC3qgwUZ+IemU9ygEg/0saJ1MbNhyltTA?=
 =?us-ascii?Q?vFvlKI41pAxkB/YwsV00MxhTo8L9BQk0VFK/L2c16BXmliuwwZnoBwvKNrL9?=
 =?us-ascii?Q?+Yl1MMeZZzoM3fg8WMayQk2sRRQPHl+hPFb4zJ+iKimy655KcpRgj9nd8vov?=
 =?us-ascii?Q?dWOREE6lht1/C9tjZdxZkRlPyiCMQALIPh1sBpW2Y4Dnc+EcWrLW7WiaKTI7?=
 =?us-ascii?Q?rjpLoS9gzaJsSDdmImw8FQmp/wuE9Llxgaqye8sL0fABUfBaFtNso/EI7/QA?=
 =?us-ascii?Q?Z43TuVkTzcoNHYrQkNbk/+uiej7lS0lC17GvysrWqyCDEPric3NDOb+grQCq?=
 =?us-ascii?Q?vLg2i6rUw89KQsNy06d0e0/kHxq40qGtdMqvUXc1atn2pZSKKOvipazldkny?=
 =?us-ascii?Q?usaXH/STCc64eSX1ykscQ+v8DXYi7vZ4igVrxbM/sWnsrEqOG/kiJJu+khAd?=
 =?us-ascii?Q?Qnl7sNDJVYanU8V6Fl/hw5j+Tn8hdhd7z/y//ZNKuNYYeh8DPBToHQhCk1SO?=
 =?us-ascii?Q?1aKnJMaDTQ=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 59addd31-e7c9-4fba-3639-08dec87738a7
X-MS-Exchange-CrossTenant-AuthSource: BESP189MB3241.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 11:39:11.0894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TY5gUsv94HlE5knPEmYzvj4Ajy9IrUrVwwU6f8qvJ9maLIlcLThiIUDH2a6xsItGTlummD3uuZCRv7Zj7sbpLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P189MB0693
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 12 Jun 2026 12:01:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19673

Add landlock_restrict_network() which blocks TCP bind/connect using
Landlock LSM (ABI v4+, kernel 6.7+). Designed to stack with the
existing disable_network() namespace isolation, covering the case
where disable_network() is skipped for non-local UIDs.

Gracefully returns False on older kernels (ABI < 4).

Signed-off-by: David Nystr=C3=B6m <david.nystrom@est.tech>
---
 lib/bb/utils.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 181082c95..1347c29d0 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -2054,6 +2054,32 @@ def disable_network(uid=3DNone, gid=3DNone):
     with open("/proc/self/gid_map", "w") as f:
         f.write("%s %s 1" % (gid, gid))
=20
+def landlock_restrict_network():
+    """Block TCP bind/connect using Landlock LSM (ABI v4+, kernel 6.7+).
+    Gracefully skipped on older kernels. Stacks with disable_network()."""
+
+    NR_CREATE =3D 444  # landlock_create_ruleset
+    NR_SELF   =3D 446  # landlock_restrict_self
+    NET_TCP   =3D 0x3  # BIND_TCP | CONNECT_TCP
+
+    libc =3D ctypes.CDLL('libc.so.6')
+
+    abi =3D libc.syscall(NR_CREATE, 0, 0, 1)
+    if abi < 4:
+        return False
+
+    attr =3D struct.pack("QQ", 0, NET_TCP)
+    buf =3D ctypes.create_string_buffer(attr)
+    fd =3D libc.syscall(NR_CREATE, buf, len(attr), 0)
+    if fd < 0:
+        return False
+
+    libc.prctl(38, 1, 0, 0, 0)  # PR_SET_NO_NEW_PRIVS
+    r =3D libc.syscall(NR_SELF, fd, 0)
+    os.close(fd)
+    return r =3D=3D 0
+
+
 def export_proxies(d):
     from bb.fetch2 import get_fetcher_environment
     """ export common proxies variables from datastore to environment """

--=20
2.53.0


