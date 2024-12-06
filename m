Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E05E77179
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 16:25:22 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (NAM12-BN8-obe.outbound.protection.outlook.com [40.107.237.62])
 by mx.groups.io with SMTP id smtpd.web11.41019.1733502320754342553
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 06 Dec 2024 08:25:21 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@agilent.com header.s=selector1 header.b=inpckKe8;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.237.62, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyV0EL4xPY4gjOaXI2GRcssfi8mkkhn1PsC8V7CWxuQ3u/SW9L2zFv+Bc46FXltO31/gaWgbNes7po+cO50oLgj2IVHhX45NvVdSnAFEiHF4/uJR3E/IVg+knwLTtm3tnn29HuNbh4YpF6qymhYwEY8Bgl+tPX6FF8kS18Biv7nL8VWT7gVuzIsnSMzdzjxEVGtCn1YwfBdfrk/FPlRytm/vSO1avSA6IQbE+sQjfbT9bE6xNtYDjg13uDvjz2sARcCrcx0a1e/ziCbhwq0v5rfx4TU6o9Lxq1VdaK3aMGTkuaBmAqri5WG6hElVrCdNMcreY6BO/v7yXGAIPkITuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ly/qGX/XTmAOC9EhaYUq+le04AKAHVYjc9c06uOENnA=;
 b=i6x65AE5NUIdwkUtYJJ/3EdioSMCmRH9pqaDI7m8iFV1uEkNSGUydhKRhYV0HwdS0vQOJGp8KRq+zofMHJlfPm3Nwdsgqt5iZwJVyNpL6b4Y4/BJUu2TJ7jp4S4Uk9OCtBO0vOOx2CeEAbK21RHcews5cDGNUO3u9hj2cD9aRdnAk//4gA3EIM1Mo4hnJhsQ83koyYdOOAn60szTLvRQjDgxLyFt+vZWQdCOvBGhvZLmkkw5PwWDOOaMu0/KzJOvn0YlzgNMaXN4ULh/aCdri7ERJt6VdTyF37IXyreK1lAJtgZs+LMvZW84xMyo8WgViBnf414dGNhsbl4cVtFhAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
 smtp.mailfrom=agilent.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=agilent.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ly/qGX/XTmAOC9EhaYUq+le04AKAHVYjc9c06uOENnA=;
 b=inpckKe8kIfqY4fclYwXTBGFdOQbrQUmhYqT8q0jEHfFs6LTu1TZobh912U4pnvODOMU8Kptm0dkuKePnKC2A5Sg5GMSEWCZehYWEDGcURkRBegF+g2NIC5Pc2qzC6Qn1eB8ekKj01/OtyysiEfAKV94ynj/VnPJcyjVMNzLUSNCwnlYQDuL91kV0iDAr86NZQWq1jhKbk4jgeKAgv/nXre2Z+rqwKPSDfnaNvXhs1keShHPfNHaYqchv0GvPYEz+iyvd1ebbj2n53dL25ktbEJ4W7Z17nlz4AOj/8UPhkmwmjo6Tnd+5npC5CzX+Gau7EtUWHNNvxELpiqlsES4Mw==
Received: from DS7P220CA0048.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::6) by
 BL1PR12MB5945.namprd12.prod.outlook.com (2603:10b6:208:398::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Fri, 6 Dec
 2024 16:25:16 +0000
Received: from DS3PEPF0000C37A.namprd04.prod.outlook.com
 (2603:10b6:8:224:cafe::6d) by DS7P220CA0048.outlook.office365.com
 (2603:10b6:8:224::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Fri,
 6 Dec 2024 16:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.25.218.37)
 smtp.mailfrom=agilent.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
 192.25.218.37 as permitted sender) receiver=protection.outlook.com;
 client-ip=192.25.218.37; helo=edgeappmail.agilent.com; pr=C
Received: from edgeappmail.agilent.com (192.25.218.37) by
 DS3PEPF0000C37A.mail.protection.outlook.com (10.167.23.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 16:25:16 +0000
Received: from laplante-B650.lfs.agilent.com (192.25.126.4) by
 edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 09:24:40 -0700
From: <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Chris Laplante <chris.laplante@agilent.com>
Subject: [PATCH 1/2] knotty: print an error if MACHINE is not set
Date: Fri, 6 Dec 2024 11:24:40 -0500
Message-ID: <20241206162441.894274-1-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37A:EE_|BL1PR12MB5945:EE_
X-MS-Office365-Filtering-Correlation-Id: 5891568d-c207-4b67-e4c5-08dd161291ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?xLcwU/VMQUYbNhloAGvLFQ8/vg6WtUsjhQXJDzP9EEa7984JkXsnXG442HZI?=
 =?us-ascii?Q?GS7mS3hYNa6Pb8p19NIEBMpPHcrfE2ucEFfLkJRBrWs7mYx+0ZPmFlzFOhQ1?=
 =?us-ascii?Q?Vd2SwYpxgr0S8ADAoLxfe4zOSXiP1u8PgpI/ScOmvDIIIQKZxMxLEKz9Dh7+?=
 =?us-ascii?Q?wGRxhHRujN+7UZ9uvlaLuOnywFo9nZEzEPsKiG4pbm8wgmg6WIxvvbhdIZJE?=
 =?us-ascii?Q?0p5lZjSWU+Za38Qmjk/DcxhOnU40w7RU9y0cc3nP7d+9HcMyINmeOzMVaSfD?=
 =?us-ascii?Q?NlYf6UOVQ0xKoet38G2+/EuA+u0pAdF+3NlQg8+Tlmv7q2k4GCX+FTGDj2AL?=
 =?us-ascii?Q?TU73oqtKHKSSjdBZgBLjEPOROQo9YKagNtItmSF3HbyLjHJxMmV3Bs9tvTSo?=
 =?us-ascii?Q?sSO+LoBfPHs8Z4lwRMoB7cr7pEMY9Rhe5HCOODlo92MIye0Wna0BqXwDcUOL?=
 =?us-ascii?Q?MJ6+HoqRnQmITmW3klNnf/aaNIkVJ0QyKX6w1w19U7XgB23Dbuq8mRyWXxME?=
 =?us-ascii?Q?A2/Bx4X7dgaEJ1yvv6KzOs5KVpJ7NEbbUQ/tqbQtK+xlMAFmRni1FDppRGud?=
 =?us-ascii?Q?guwuA79WotaA8PCAAgkZrC9lXunxGpUasLcrTXiztAd5CmK1taody8JdCZYG?=
 =?us-ascii?Q?3XsF4cs8zUN4T2u6+XTi3Gq7OVn93ZPBwSLsRphA2fiB11EgifF+zocq4CJy?=
 =?us-ascii?Q?k5QcpMH0h8dZ/miuiYAHud3nmmjrWyByJbraVbZ6t0KouwVKJzk8jH9/+2II?=
 =?us-ascii?Q?M3Idig32rMLIrMgNCUEqJMlpdVEHhNhaeifRUX7VBz/SE97EtrVmPtsijNH9?=
 =?us-ascii?Q?d8WBbjKVtyFW9DAk+9k5vrrJiA4cmAoqzFC9IvIAtC/sOzd6kwzIy/v8WugY?=
 =?us-ascii?Q?DeLuE1NssysH0q5V9tiwCbfzO1H1TepsFQoz9LRoREyeEfShC0kVhDvTzxVr?=
 =?us-ascii?Q?GdqP+x/WmkChbQwd1iX/k8nl3Rg6tsq9SEfcJaefwpzK8sMS5TpZQP1fFp4m?=
 =?us-ascii?Q?ObqpvHmxMYByM2CEFfknJV4ehgyWASNkaKRygbbLHDIc2otXXm+PKB+Xrjl1?=
 =?us-ascii?Q?T3BiryZqAnDyHu3H+gpKWe/ecjDdPM2oqLubiLL228coI135PmAjqN2TPtE1?=
 =?us-ascii?Q?Fza8abQIQpocxFQ7Xy2C2RlXJNvGeUNAbd+ap79rcpb278W0PMRxjuMBGR1N?=
 =?us-ascii?Q?+PmGEUlcKNVaCAwbxLHTGxQ7kTYJcd2yH7/W29okb5T2PWcHPpGx/nKmVY9D?=
 =?us-ascii?Q?ST/K//QZgN7uAtJvXHiuzGMXGXwn8K+ED5+4CEswgMEHRQTVbDmm2pIV5xm8?=
 =?us-ascii?Q?8Ee4RJKHbppr/7BekocrfCG6G8tGkiUHgUJShraNDCVnyjT7u01deSzOJuN2?=
 =?us-ascii?Q?ZuwL70KOtvqXwFCY3Q1yK11q6F6lEEI73jW9drevrMXAWQx7hRQ6VrZWrxF5?=
 =?us-ascii?Q?kfm4oYD1PGPN4fhWY9hlLnADOZQ/DjR0?=
X-Forefront-Antispam-Report: 
	CIP:192.25.218.37;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edgeappmail.agilent.com;PTR:wpcosapexchedg1.windmz.agilent.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 16:25:16.5551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5891568d-c207-4b67-e4c5-08dd161291ba
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;Ip=[192.25.218.37];Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DS3PEPF0000C37A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5945
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 06 Dec 2024 16:25:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16891

From: Chris Laplante <chris.laplante@agilent.com>

When the user forgets to set MACHINE, bitbake just exits without
printing anything.

This is because BB_CONSOLELOG ends up with an unexpanded '${MACHINE}', whic=
h
bb.utils.mkdirhier tries to report using bb.fatal. But bb.fatal utilizes th=
e
very logging infrastructure that this code was trying to setup.

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 lib/bb/ui/knotty.py | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py
index 3784c93ad8..881df9e5fb 100644
--- a/lib/bb/ui/knotty.py
+++ b/lib/bb/ui/knotty.py
@@ -555,8 +555,18 @@ def main(server, eventHandler, params, tf =3D Terminal=
Filter):
                 }
             })

-        bb.utils.mkdirhier(os.path.dirname(consolelogfile))
-        loglink =3D os.path.join(os.path.dirname(consolelogfile), 'console=
-latest.log')
+        consolelogdirname =3D os.path.dirname(consolelogfile)
+        # `bb.utils.mkdirhier` has this check, but it reports failure usin=
g bb.fatal, which logs
+        # to the very logger we are trying to set up.
+        if '${' in str(consolelogdirname):
+            print(
+                "FATAL: Directory name {} contains unexpanded bitbake vari=
able. This may cause build failures and WORKDIR pollution.".format(
+                    consolelogdirname))
+            if '${MACHINE}' in consolelogdirname:
+                print("HINT: It looks like you forgot to set MACHINE in lo=
cal.conf.")
+
+        bb.utils.mkdirhier(consolelogdirname)
+        loglink =3D os.path.join(consolelogdirname, 'console-latest.log')
         bb.utils.remove(loglink)
         try:
            os.symlink(os.path.basename(consolelogfile), loglink)
--
2.43.0


