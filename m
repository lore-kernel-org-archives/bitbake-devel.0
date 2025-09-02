Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BCDCA1005
	for <webhook@archiver.kernel.org>; Tue,  2 Sep 2025 06:45:56 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.112])
 by mx.groups.io with SMTP id smtpd.web10.71238.1756795540688708917
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Sep 2025 23:45:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=AOAajoFF;
 spf=pass (domain: weidmueller.com, ip: 40.107.162.112, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1XtzgihZq+k+7O2c4hbv03puKWG6YTkA7FC0H+8kHBujSgUfRmR6HzC02YchwLqbVT1HpYjCvCsjgXzOmsKQlrxXAHXc+BfugeDXHuAIY1VlinXj+TDpXoBglwqKzdk9ysZvXRpilMjyx6p3RL9MuCUl+1I18qyAcy9rMNuHOjgepYGCQN2YIo4ribvbN4YRQUZFryELPUGC3MB3d5JDaQ5YCCRa2JbmgNiSGt4/jsSv3+Y+3S5lim+XFr6PkkUvlYCG3akwOltdVf5SZj6TEBa8klDAm6xESalONAXm+ePLX7yBw5R7rmRb5oVifqXL028QfWkmlIoTeoMEdnjiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hfMbCnDV8j2qBWWYwIPunXHgPizqJDxK9MX4d+8uj5A=;
 b=aPu0/nJeXU79GCT+t9w8t6CnfFQztRbxIDEDvxnfkAPUbYs2xj7Of11PhpbzY6oXqvLx+3FSgB7/71fYce81I80mYuxFwHmASI6Jua/Mc5AKu6TWUtE+13OPMeTo6FDNq1w2wJ+u3TGeXy5pukbNmfYPuj1hCpJvsDjlamolPPyrdK0XYKJwJ8x4tp4/CyAemMNzXAChBBlOLUTuxxTWMh5zd+GLm2VP49dkzZN+UQO6MxoTWxqubmnsYzvVmKxK4oEyuy7AFUMqrJchZdrDTT5BUYQsi62cAqV9N4LNJs0Vp+E2y2OAtEiW7Rlo/vX/XSGzYBa+9HfEJ8e07AtbHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hfMbCnDV8j2qBWWYwIPunXHgPizqJDxK9MX4d+8uj5A=;
 b=AOAajoFFe6R1FU0njeg7G/1yPwVd+dT96VBX7sEinZAcwAksW8nin5ddFqaqgNoStCoJVcPlIrv3QtHA3/eXnIKsuElie2h+G7EA0v0P0hbqNvY/L11WSMFT7ehztlD1h5tzPLS9sWbAxFtxWrNomkdEhbKm1eBEIKfZEe4P6vrs8avnutyCGFPIJ2ZK1Vob8eJT68RFROvzmmAK4v8z4g1nun06/L49hAVCQQJs71RIqptyE0DxeJUr9P0f44EQQ7SeYcOvBeOpSHUo+iflXXNIdomUllafO9vbiWESmirsDLEeQwuQIqmGn11B9WPctxr18MOcHlOxcfI6FLsReg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com (2603:10a6:150:8a::17)
 by DBAPR08MB5591.eurprd08.prod.outlook.com (2603:10a6:10:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 06:45:39 +0000
Received: from GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013]) by GV1PR08MB8426.eurprd08.prod.outlook.com
 ([fe80::f9f5:b4bd:9e01:9013%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:45:39 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 05/15] fetch2: gitsm: remove redundant set value
Date: Tue,  2 Sep 2025 08:45:04 +0200
Message-ID: <20250902064515.30879-6-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
References: <20250902064515.30879-1-stefan.herbrechtsmeier-oss@weidmueller.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To GV1PR08MB8426.eurprd08.prod.outlook.com
 (2603:10a6:150:8a::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8426:EE_|DBAPR08MB5591:EE_
X-MS-Office365-Filtering-Correlation-Id: 121ac950-f7a2-4e95-404a-08dde9ec534c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?viFTZuX3DTkYMj5RTvq5J1ThnGmP9u/h743t9+6Bkh+Hs4Q570mjXB6pBbqe?=
 =?us-ascii?Q?G5AnEoqPhLTD1dlU0bW63Zyi/flTv4S/VqpbhKE8sfF7HIEXjAftnAIgZ2kk?=
 =?us-ascii?Q?uUhMQAt+iVD1r7wLTOtChB9mYoKBM/1sU8f8aOSsE5lQpUWOm6ZUfX7QBD2+?=
 =?us-ascii?Q?OopaTcRL4J822NVUdParVn/iJVoS/ykIq85Am2xX1egBqZ9e3mAqVc9XJzMq?=
 =?us-ascii?Q?nHAZwSq9ICc0HyV0fGrU7wf6lbKV1ADuS4sLU0sv6gsU3Hw9XhHJDFdu68Qu?=
 =?us-ascii?Q?wkYvQOy2I0OzsAfp7xbEuGt01ooK1DN9cfFUH3jW2b0igh+MPAhDaRSu7Iul?=
 =?us-ascii?Q?+B29fmO/HA+eSI3+bbVyk2bZnkKsVSzSQfSu1t/R+5UnXrIPayHX8p+Xj8/o?=
 =?us-ascii?Q?mOnuX1s4fCBUVaIV5I4dhwJLTXBLHLN2q+j9vXwFIEDYIh2zoe2k0Hjb84fi?=
 =?us-ascii?Q?3iUqrszqFtYTTIelE1rcgA5pUi7JKKIGvPXfgsLNgY1YT4oDEWGkYJx+MTwQ?=
 =?us-ascii?Q?tsD1xvvWQ1ZQdfZgve73ceM0QW9PAGUbSiJs030JuK4EZAYlfv2aiLiKG9RD?=
 =?us-ascii?Q?6wZsBg7lkqdbMhwLMHYsTVOpdCGw6yQ6FW+4qN9Dt5jweKPhbN+2f9A0WG7G?=
 =?us-ascii?Q?xoKCJvI5v6ODlwjXkDxQWVEksm8Lb0kwtcftYidbjrIa7YIzizlFB9LIxnV/?=
 =?us-ascii?Q?U9YtPQZYTQ0K8ed7ZqvYHsERBMCf5jmHitLTMNLL05fzb8lv+CKu1kkREqea?=
 =?us-ascii?Q?aZm+14kD+qLqDe/8ZhXbfwrU+o53pSt1STqzjJh0kp5uqrWwLCltJQ4kb2iX?=
 =?us-ascii?Q?Xg8P9zOJFT/pKem7bVWBo/2WZQ2kJEw0opaFePBLC0DbZr3mwIqUWymtS1yB?=
 =?us-ascii?Q?DHeawdOi9muqZcH1Ts8JF9nqPR6v1+H0BL3H1LKyjIAaQGzTwpgh4fpcj70a?=
 =?us-ascii?Q?+Yi47VWjo9gQ4u0HN0YrsVyo6OaJBnFd8/ofzOgz9qRN995vF1BI5ZQoDoav?=
 =?us-ascii?Q?LPCIXZHNFPwhDs95dLg1VbTlehUUY9mXCH6w1yC13XxJAOYhWqhBRumEClk5?=
 =?us-ascii?Q?aSp0+MvxqujNQcSkxlR6NkjosenrZytC1vtSJP8znTQxfPc1SUp+T4RCRHa+?=
 =?us-ascii?Q?qGYFmdTVXHoALK2yxTjh16UCEh/Af6NGck9eMcEmgobP1bZJl4ICUxfvotIb?=
 =?us-ascii?Q?YM49JxbEfVFVdC7spkleOnL47GQ/kmRYdbLlUS2pdO+/PBMRJjZp22QrSzij?=
 =?us-ascii?Q?DXte4KQrkz3sMymBlE59KV83s56OtITn+Ls82A29Pj28boAOsdGSKrxgPLtl?=
 =?us-ascii?Q?sxEAU800kK4LzX/Ze0vPHigVaWwlEpBJsry+WclJmjjrFVmQkNQeumrT4ori?=
 =?us-ascii?Q?LvhlcdVJlsR4eimiDGT3xHRmIKQZaoLsUPZaaxmMxwMXxfjzyW9wuWhPtH1j?=
 =?us-ascii?Q?VUEkLDf/h2nmLIW0LsMnNDtJKBZCRlOKl3Coc2kkWQPMM7WyNZ7rfg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bVE/oQfYPtk3kv68UxT7GRV7d77EkdZnmliycm7uHF5lAOdKNenIA9jBaIsQ?=
 =?us-ascii?Q?5G9Z6Q3v5JTtwMG1X1qIzV97/Db066Cr4ldCvnwUVxj0h5oVf9dFoBAZi+Rt?=
 =?us-ascii?Q?jrY1zVmV6oLQhA86q6Xr7NJHMgKhWrAfJhOcGLvtvHDedSniQiDsrwUJo1M7?=
 =?us-ascii?Q?eE6SKeD1OqQOBht94P3/8f5MODtuP30f3vM+YcWF1DSFYtWiLpcW3cnItWAt?=
 =?us-ascii?Q?kOlqMjOLhsvkzxJ+u+zMhb2ZJAtEkPUwCgocvaWjIhQkfG3nsY/IEnQaxp/U?=
 =?us-ascii?Q?3Ovg8lTMp2WqpXrla1Q2UolP0Orb4KMGgWiOI+o1QKd++QHcZzR7B12CPuMz?=
 =?us-ascii?Q?/mOzRn5oFTOQLEQS21VFv3eazglJakL9gpPlOvHGa3SRtJ9hUQL0ollG2bAa?=
 =?us-ascii?Q?PgZz29VpMqMAjVGitEVIOVc/eecXbTJoPpy8+kXQbm9c0Smd5dUj8X/wgm2Y?=
 =?us-ascii?Q?8h8kk3NPde8mgjmiGHcFAQEzwXD3DEKMqBMDJxXEwS1FzAajZ21N816TonVI?=
 =?us-ascii?Q?cXe88JIZrOJvUHywDhDNm4tdFIdxs/guM1dd28KaOXBOOCu+MVt0GiZTwcvY?=
 =?us-ascii?Q?D2vPyNYzjmPvtst+aTzVGNu5e/NlistyaW2RlHl+YkmfXQyUuTk8DQrAq+bR?=
 =?us-ascii?Q?QxrBYplzcKcF4/07S1DSkUkPXkc3bPfYylmytaNTeuhlsJwkPk3R0fxBpubz?=
 =?us-ascii?Q?YPPMKvD5geks4E5+t6QXyg3m9iUIjDuczBLkOCwlpmfr9rP9SGiK/KIgkEUG?=
 =?us-ascii?Q?0S87rMXD3e5isG9ZYIg6CK8iIhf/9Lvsu6kIhYLAvsm64KxHNmU89b/OBMP6?=
 =?us-ascii?Q?m1o6yMa+buAIRcxWGlPw0c1S7Q/QSZi7sEuBD94H9k5dmM0//VlTK4f22p0O?=
 =?us-ascii?Q?THyjqTMuaDgizX/WMbrfz42LY4buR/eiMYvuuvxaoXodzGvUsRfwiwKW7L72?=
 =?us-ascii?Q?Ze3NOq27ICqymbZNWlnUajyffNxlvyFbtT7p2WU8uFWElQ3AWYIwu15RrhYK?=
 =?us-ascii?Q?NPF+OOBoO67vYNlNzIU/+hw55EAe9lickcAgFRhgUWlz5yRhsrNMbSLx5Ovg?=
 =?us-ascii?Q?bsDM8ARH9BhIQUkecSrJZZ+AGG5CKLKKkyt+SiWgHiXKsZOnsjgx1LvNwsVz?=
 =?us-ascii?Q?9NYg42bB8sEJRjanmuIrsNiJcpmEpKtc9P8qmHVSLhm899dJSVnYol4vcSSH?=
 =?us-ascii?Q?TnLhRNENKZj/TfRXs2iIaAQdpXHwZIz85fN2ZsSYTYx1n+VgisvHbUW5mV1Q?=
 =?us-ascii?Q?cwTTQHH1Gey9KvK8HAU8EtHK3vzKvMiZTymWdvgg1y4uaPUcl+3At0cbNuoI?=
 =?us-ascii?Q?nbONacNdGlUYSmJ06soikkuBuVUB0aruQfB3IXaDcTaASA2ySQRiwrTTup7i?=
 =?us-ascii?Q?SneL/fAnHTuQIYngaA6jEcvIQMZYAmTQWTY/9TQ7tOK2hD0MLaHArjwLCTog?=
 =?us-ascii?Q?56sWkWJrVmxgQtUCiB8cfEpUGP6SZzXKY7Ir/rJ6g4kMXkMbK0OmGC+CdFPg?=
 =?us-ascii?Q?TEOdGy2x9/URKdUuH4cs0C5pSUIUNK0lU8vUssuSb4nu7GWJ6hBKNwgAVKui?=
 =?us-ascii?Q?ioZgMkzmfLcvGftFwZO2hshYM+F9WLlRMq+UtVpggn5/GW4dEu0bJ07kmU/i?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121ac950-f7a2-4e95-404a-08dde9ec534c
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:45:37.7567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7FIh2oxBZ9sGwIuKVnTg/463xFftvSbUx7RtZkNjno8pQw/WPU6aTojY+L6oR37zLmt5Ks51Xr7RoCPwy9Dng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5591
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Sep 2025 06:45:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17924

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

Signed-off-by: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.c=
om>
---

 lib/bb/fetch2/gitsm.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 9baefb3e6..15b9c3740 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -139,7 +139,6 @@ class GitSM(Git):
             # Workaround for issues with SRCPV/SRCREV_FORMAT errors
             # error refer to 'multiple' repositories.  Only the repository
             # in the original SRC_URI actually matters...
-            ld.setVar('SRCPV', d.getVar('SRCPV'))
             ld.setVar('SRCREV_FORMAT', module)
=20
             function(ud, url, module, paths[module], workdir, ld)
--=20
2.39.5


