Return-Path: <m.schwan@phytec.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C456CCCFA04
	for <webhook@archiver.kernel.org>; Wed,  5 Nov 2025 08:05:34 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.73])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4625.1762329933000710399
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 Nov 2025 00:05:33 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@phytec.de header.s=selector2 header.b=GPYv7qNi;
 spf=pass (domain: phytec.de, ip: 52.101.69.73, mailfrom: m.schwan@phytec.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8fmovdhA5qOs6SV36EK3cFpM7a+3VA0Lsmou7S0hkOFynjSV6Djl7UmMG2OGBC93e3nQAUv+fcU/klWfwNgsO9NzMzQtONchCJU8joakvx4N4SV7+nvwVkHHyQWBHskcCzbrIGr8sK/9AeQFOKYjfgXnCUa81Ajn4Tu5sF3U9pJttNiydmx2fCRyyWkkyfXa3KL8oxuSgPR735ddIbhAuf3Fr5hNhqV8cFhStNybtEajZeb3Zfysnh2nJu/tcaui0T4ZNbBmrD2IqbW7YEg9Ih2/MwqnRIXqvs/IXA/sIdbBsJ/UhZUvJXWvCD0qzZLDl8yHX1RDpU8Id0G4PJ9IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAbl8HcZ1tuueMMJRQjdxFnxkybdcB+R89rRCYMdqOQ=;
 b=u1O2PavAHFhYkSjSwqvnC2Gku3mn6E93A4J8A+Fa47CfzKDyC8zi0I0D1r4QGaoxXjISRtBk6/Gqzsrdf0pdD+mKzoMqfRbXEtL8fBJMlDcWeMwmlZddQ8pupqAGMfjV91GnmqgCHFzfi/KCCIXwxgvXq0gA9oV6FyuL5ifn0v+QEW/pjK+APd2daT4RHGh9zGMEtd6Z8AJ6ESz2yfgW2VydproHpXM3J+cYot6fOSFQDrsC9pAVsD32JG4OJIYU+DhdkKh2X4QjNgLH2WESCDj501wEob55zZqtPlM455Z3snY0cVrmVro5Tb5Kd1B501NlW7As7+o1+n/W9QXBaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=phytec.de; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=phytec.de; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAbl8HcZ1tuueMMJRQjdxFnxkybdcB+R89rRCYMdqOQ=;
 b=GPYv7qNinawlBC9dcSG4+GHozo6DaLdAv2tqbEVCvQZhBEdTMaiFeLl2UxLlYv5uNcj1MtpBaP9Amcm56S7ucYKGc8bFJNhXxNQQJ3gNUJyD8YLLPzGOQ28wd7ZTyzESr2SScKbfugQs1AZyb4a+TTUzByWlveCR1s09sHambv/01223XUBukY7qq6P1F5TMuyAoCtQJEgQDtTJ54TzwKZDvT75N+JLHfUSijw0xuzDvX28PnL9iRRAHbE+Zswh8eEFXBgiJYovztVty4Kp/JhE/fvrg8T8q9Q6ZiGHcPkSNsIFLAZgSASQBIEU8aQaKoB0z2vK9HitsxEILNfjcFg==
Received: from DUZPR01CA0266.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::29) by AM7PPF7989BB6ED.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20f:fff1::754) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 08:05:27 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:4b9:cafe::69) by DUZPR01CA0266.outlook.office365.com
 (2603:10a6:10:4b9::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.9 via Frontend Transport; Wed, 5
 Nov 2025 08:05:59 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 08:05:27 +0000
Received: from augenblix2.phytec.de (172.25.0.51) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 5 Nov
 2025 09:05:26 +0100
From: Martin Schwan <m.schwan@phytec.de>
To: <bitbake-devel@lists.openembedded.org>
CC: <docs@lists.yoctoproject.org>
Subject: [PATCH] doc: bitbake-user-manual-ref-variables: document BB_GIT_SHALLOW_EXTRA_REFS
Date: Wed, 5 Nov 2025 09:05:16 +0100
Message-ID: <20251105080516.647480-2-m.schwan@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251105080516.647480-1-m.schwan@phytec.de>
References: <20251105080516.647480-1-m.schwan@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|AM7PPF7989BB6ED:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab87c66-c579-40f3-71b4-08de1c4214df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?t9HTcswcCCuz/G0yZP8qfe6qTUXkcXpf1yM4aZxeB+al8LqjaOZpvO7Q2dbq?=
 =?us-ascii?Q?cwVlvvFZ67wvqUzUJ/04BEQMg51cyngcXm7NngdPPs0eH4BgDENuOwB4f2n4?=
 =?us-ascii?Q?CLQJY3jVIsfElDhjywkI3ZH4vEhF8OzNTmgXIXDvZmjIVuF3esWf5phkVknt?=
 =?us-ascii?Q?bVPTfp0eWi/KWG3Ju0oJFh3jfh0LlhAEV0T8ckkvqQKnpQaj+l/Gf7Vl8D2L?=
 =?us-ascii?Q?4f/eKw0lrcxwo5vMZS4wWOXJH+hyS8QRvL2vlPy+JsfLVFN8tIWfnJKAPkTJ?=
 =?us-ascii?Q?V5AlWn5mhifUebfG92z23ZCqTwU2A8QGZ9QKaliYnvwtwrQTy8OsOsTmjJW1?=
 =?us-ascii?Q?UOnYQzpfuBLMrEz+ltf9f0YyNLx61F7KJTNVEEDVtAeEurz1tZdN4dSIIhGt?=
 =?us-ascii?Q?kyB6Jvso69nwkZ21V9kHJDdn6tEySuD2WiEcnykr7b20pNfruj3P+8Xu8zkD?=
 =?us-ascii?Q?sRVoapSr4Y1FPQWBfkQyEtb1V4/Yxz2gxTmjugwcmvFHGCPd8E1dI6aAk09T?=
 =?us-ascii?Q?4IWBBBLRgzseP3P9SEHJLHOmqBfF/kjSRnl866OJvXhlMMZuZy4gr98EhZzP?=
 =?us-ascii?Q?4061NjQLa+5Ji6bVrTPMS61sS/F5TcFKKhug2dq4lNjPAIEVVuKtRku8os3a?=
 =?us-ascii?Q?X8Ojx/VBr2xYAEcC42glQq0bJljcmXIq0g7sg5SWU0V+0MrG7c2OedQIFMFX?=
 =?us-ascii?Q?6BLOnsazibO8igvr4WIU63g1J2ezoLTb2RFI1vMH8oNh90SnxY6yqVbp35jS?=
 =?us-ascii?Q?x/BQAqzUezbgrFRx4wNA80umd/G5iVwsmbs6dOIzUdLhG/HYk/Xiq+oZMcvn?=
 =?us-ascii?Q?AoUFN5juyV8mNUcauyFFtjx/fJhVX97lZA3l93QWiN0V+ynLkgWtIW/EuhLP?=
 =?us-ascii?Q?/lo0keRtrYqdL6a9wGrG0qniyZ8P0Rs7kXhhp0H2OhZtAcXYKJbw5aDjUkWR?=
 =?us-ascii?Q?y4QdPPpcrunNCSJk4EA+4jBjwTWaledTFUwJ5RJfZHh00Yj/jN4q/GDxUdjW?=
 =?us-ascii?Q?10ohzLi0/hf7FYJqwIsFIpWgMqpeGkFyD1RNIBMlhfJjx3P5ozdayGW8PZYj?=
 =?us-ascii?Q?vbjo5nYAwUmL1D0ACn4iwtRcRfyJcK9Fo3Fo/aNc5/mlq1uSCi7/1MWZ0DLS?=
 =?us-ascii?Q?BC1OZvptmAKiOR118PPvuJklMQVzHWEJBRzNVtEfBHmLC6ecfC8taynvusSu?=
 =?us-ascii?Q?C9ezt8BT24u5//SMGBjP0sWG0D6Be3sJ0FBh8gdoJOcmPTY6LRX7F8q0qNAf?=
 =?us-ascii?Q?YZZzMycqyDekcpxvxb/1pvDjIHnOoDloxKRkZBxp9OYskHR/QCLvIv9ulxLJ?=
 =?us-ascii?Q?Ez5+WGpBXxY0+J70kXRehLM3uuXyAyLbv6ut8kUNMxrO4kgcOb3f5XaUs898?=
 =?us-ascii?Q?EeqxVfWWyVCGKSB9RHqzs5SCuPeEC7ZWOnAy2o3GLGtwj6HaJOAPadxTsQd2?=
 =?us-ascii?Q?qTIXfaL8db+FcWv9+tzbuhRbKHa6lR/ndtWiHATrpIMazATVB3m3QUB4KDzV?=
 =?us-ascii?Q?ysJKXP+fkfJbVxn7KYJdp53N4HWYlFSzKCmI4dsBxzW26Wy+l0SyATk70ppE?=
 =?us-ascii?Q?l953t9xelkEUznpd6/M=3D?=
X-Forefront-Antispam-Report: 
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 08:05:27.6064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab87c66-c579-40f3-71b4-08de1c4214df
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PPF7989BB6ED
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 05 Nov 2025 08:05:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18256

Describe BB_GIT_SHALLOW_EXTRA_REFS which allows keeping additional refs
for shallow clones.

Signed-off-by: Martin Schwan <m.schwan@phytec.de>
---
 .../bitbake-user-manual-ref-variables.rst       | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst =
b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
index 734c7858a..309477071 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-ref-variables.rst
@@ -399,6 +399,23 @@ overview of their function and contents.
=20
       For example usage, see :term:`BB_GIT_SHALLOW`.
=20
+   :term:`BB_GIT_SHALLOW_EXTRA_REFS`
+      With :term:`BB_GIT_SHALLOW` enabled, by default, all unused refs (br=
anches
+      and tags) are removed from the repository, as shallow processing sca=
les
+      with the number of refs it has to process.
+
+      :term:`BB_GIT_SHALLOW_EXTRA_REFS` allows to explicitly specify addit=
ional
+      refs to keep. This is particularly useful for recipes with custom ch=
eckout
+      processes, or whose Git-based versioning requires a tag be available=
 (i.e.
+      for ``git describe --tags``). The :term:`BB_GIT_SHALLOW_EXTRA_REFS`
+      variable is a space-separated list of refs, fully specified, and sup=
ports
+      wildcards.
+
+      Example usage::
+
+         BB_GIT_SHALLOW_EXTRA_REFS =3D "refs/tags/v1.0"
+         BB_GIT_SHALLOW_EXTRA_REFS +=3D "refs/heads/*"
+
    :term:`BB_GLOBAL_PYMODULES`
       Specifies the list of Python modules to place in the global namespac=
e.
       It is intended that only the core layer should set this and it is me=
ant
--=20
2.25.1


