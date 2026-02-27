Return-Path: <florian.schmaus@codasip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0009CFEFB4B
	for <webhook@archiver.kernel.org>; Fri, 27 Feb 2026 12:43:51 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.130])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.94822.1772196222873693750
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Feb 2026 04:43:43 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@codasip.com header.s=selector1 header.b=fEOd8f3S;
 spf=pass (domain: codasip.com, ip: 52.101.66.130, mailfrom: florian.schmaus@codasip.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BsqO29SwSPYK4a9KDHvAv3armgDAZvO3aVAOAkRWeyX2c3oMFpCUnAyJOCpaJFnjD4mo0R26tTfor5EHSPbVkQKS9fGo3NuVQoXjPq+hNUQLaxKXLry9fWz4kIGFBbDyQBOdpG7myWIkHrWkQYKNc53vdotcCj9djJ53kRVCCrVG09aPoEzHKjfyju8NFw7R80hvSTEUX9BpYn8Z+B1vf5k8HjJgrGqteLcZcHP8BsvXFxW0Y/F1NXM1pW+wXK4JZIcvozwOiUydmDRwWDoYzyCUx6ZoLinPVWVvocJKoEH16GG8/g9JUNklmtWOK2enBgJD2Me/AT5pgspjaRrxtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FDi/6swMJEATSrIbJwTCSseq8hSXc5IHOD0nj9IpI3Q=;
 b=OFITtkBhus9QPwAogNzKJn/BzQziI0LVEcQ+BLf3OhR5VZWiZPT40L+uWx1jQzlXsTQ3KVcKK4t/uDyJl9ACmkySGDFTUYipNdu5NKfh9XmQO4S6aSDPolzUu51pJJZzty6YvZNjj04A61Keyt+o+Ao16oCQvFWWKEWdPdC5n88loOELL5h+lcbKyhVYDfYnBJrV2t27MpQsuYB1oIy25cC2AGHQ/DH/AAjTUDN26chAWN39bJGkq7QYbbd9Anay+VZxlo5r4mWZyYB2rmUThWOAHaH2u9lCep+aXLDyUfxj2AjKd2q9rZlrBaW7UfIxfyzJNWYTj++ZZk64B7ovCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=codasip.com; dmarc=pass action=none header.from=codasip.com;
 dkim=pass header.d=codasip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codasip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FDi/6swMJEATSrIbJwTCSseq8hSXc5IHOD0nj9IpI3Q=;
 b=fEOd8f3SEAD6A355/0Cao5x/p5TmqRNQWE44NP0qPaG60d4GvSdgg9t14T5BbmGf4UsI+59ia2q1R0kWC465r4LGVllvdyJ6c9yhS+4l2Ng2Q/qBLmo6oBGcKmGPoMBseLlYM69e9zm7PjiK7KXz8algP/h1PY2sqIfRSUzBGW0WiyPIe24F/EyoLiLuQ6fbgqhKp7oYt+eIVmIFi23lHwPa3YqG42NXJyvBj0t48DShaLeencQQ4A6mA2Yii6q3wPNJfhqyYi3quPi7HGdNSxqFBoEdEEnMdO9Pk/ttXoMF4Q0jcXZkyy+Fbs8pkAWEcdSaxnb18azPF/09dZjWBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codasip.com;
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1f4::5)
 by AM8P192MB0897.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 12:43:39 +0000
Received: from AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::f0e5:8465:302:9a9c]) by AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 ([fe80::f0e5:8465:302:9a9c%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 12:43:39 +0000
From: Florian Schmaus <florian.schmaus@codasip.com>
To: bitbake-devel@lists.openembedded.org
CC: Florian Schmaus <florian.schmaus@codasip.com>
Subject: [PATCH] fetch: Add GIT_CONFIG_GLOBAL to FETCH_EXPORT_VARS
Date: Fri, 27 Feb 2026 13:43:36 +0100
Message-ID: <20260227124336.294694-1-florian.schmaus@codasip.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0285.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::19) To AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f4::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9P192MB0983:EE_|AM8P192MB0897:EE_
X-MS-Office365-Filtering-Correlation-Id: a08ad65e-9fb1-40a6-1b52-08de75fdd4df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|7142099003;
X-Microsoft-Antispam-Message-Info: 
	bdht9otKl1X6OjGt0Ka+QJz3gDaiYNvDrJwb8bBpbGBL78IZ5yED8l3c/J3OlNMAKdUe6DCQPjOHTKVtcIBol43q0kj5LwSh4sETLj9i+4ypiJZIey1fTjzws1xZWZ6kx3UyaYtpYDptZHPhkaeFwA9fC5LxkK2qZhGKHmz17rkPUWvDovnvkUHqLj02vZLtD2hHfMevRmSVMvmHCpUINI86LeC6s4YOshjcls53FBIa6QZY0SLTqaJwpJy+fJKolO2ZS8DMFOz8JXxx0AYv/ByuLwWTShtegYX9YV5gNpiPEvrq9s2QZ6rFjH0l3RRq1DxraMQg2uR1gXxLw2Tf1Uwg0DJJ1UwhxOFUCEnf1FjPE0sMQS2mDxMBbkSl1ikm6KHqO/8pUYCzfKjgLTI6bT45oolhFxnDCpi3/rHHWa47XQDYcyaQA2cAw5K0DlWP9dYg7ZtNw4MWExz84GuQspyKTSxGYE8SDs9kV2ery3lYoEVPHMk5ncL2oW353e+6Jtp8oCuAgc5MIYmJyIHv/p9Mp4LmjQhLRRwk9vr9l/MazwPz3bRpnCAGvQDZliAp8td/uyeolD62Os5O0FLfDISuGOFYLO7M8TiHcEDJrajPcKl4BrOl1nd1jLQcn7ZMTBevCKfl65t7RFetgsDt48sBqL2/bnI1x36cVccbYZ+c5bW7Y9Wd91ZlzsBU9NdErKR19lEfM3BFgQrJCH0q1EVu/GDSSwpqbkwh2T4aRg4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9P192MB0983.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(7142099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0N9aNuPrN7qiphxITzGp+cfszGgVWlNOYUVOCb5+4s1CbWMO9fWZWDuZZMs4?=
 =?us-ascii?Q?b1sHRXurm42AdVLb9ae7z67CctgZtqwAL7mfpi7RMn/sU7PcYl1v/tzzQWJ1?=
 =?us-ascii?Q?x5RLH5C3igyXlar/6QHm00Knv+9xOYSKFRKsP+qRaJNmFz3RIPFASYV6H0HR?=
 =?us-ascii?Q?Fx7HkPUnP3WcFodiGDMMUKzT0AiylLHoQ1QWmEzXSnUwVEncgBiQeHMxmyQ5?=
 =?us-ascii?Q?cTO8eHGwNHIL2xzTI9rzAypkoDp6SU2PDiMwKxwpRrFO0UmAu8eXydptWCiR?=
 =?us-ascii?Q?7UUaKTWkNmu0jkwoifrQNEiPWDvxoliiW8zokxCmSwNJEWlrdPWMYrgHk28r?=
 =?us-ascii?Q?bdD+AEV3wyjOzZlCo7cEAP4pCMSszgZyOYuR9EYMB72H9xpY+Tb1SIC9YOUc?=
 =?us-ascii?Q?05tAx3xGiLwJHUOjLL9LLxngFBU9ajuno5Aw0foDcuBnES5BNKRG4nwJWVy7?=
 =?us-ascii?Q?odTj+It1oVyG9CrE54xtfUvG/SC8eHCWu6ZUuCHFwW/l+6XRYvlBwnDCJA//?=
 =?us-ascii?Q?Odciq9mxBAQGNEgswbsbSLxFUtRcvn+Qc9RkUQhlSduKHIvC+vEpJNFEQTH0?=
 =?us-ascii?Q?6MQ56m1XRQfB/cd8KrK43UfZ4wkk44Kv7AVedDKsh+vS0nVu+GbmZKq5WJi2?=
 =?us-ascii?Q?iG/GM/jlISx6mwcn/OpGYR9uqDRbT0hFOLitefNMiXD+h/nxLa3/Jstz3KjH?=
 =?us-ascii?Q?JgesN88p8HlqS7YPfXk6MTwoV3RVuBnyppsQduIj0CjDbCrdo7O/k8yfWdk4?=
 =?us-ascii?Q?Z9+Wpkz4MPQsuA5JvvU5MhsdMtejfhIuogMa+6CtSe6u/QXaJMWEMnvbrV2+?=
 =?us-ascii?Q?obmd7BmQ/QFhUaKUplv1hTAcpzJQRPqel1MBfgp2TRq90VqN1URdnKJe+zAa?=
 =?us-ascii?Q?2XU6/JdF/0e8Zp+SVzRfqk/BglRt61BvrKEL7k94pMWDpfbj7el95rF0HXlx?=
 =?us-ascii?Q?FxGEYg+SwN4iXoA4uozgIgmRT2TW5Cd0rEzhkEWjL5EtLY3OyHcd46c8J9Et?=
 =?us-ascii?Q?zLuS7mABq/UKq87EEju29IV52QO3qZg1fSjs7ZbkaZucr2gTwSC5IZJ08UMS?=
 =?us-ascii?Q?hg0Qh1ZftD1nucBts4yb9dZJtimSUhqu/Mth1f96kqGHsgfdRnecQSszm/MU?=
 =?us-ascii?Q?3Gw6AtjYpM47PQleYVnW5T++uzvC1MBEKRvf0tncMJ/qePdC3lXI+BUVkN/P?=
 =?us-ascii?Q?XrrvLC44YYsUu+0/IXgDrIMyC9sPzAMKroz56tOK8T66VPnVlAZAp+9BhnUw?=
 =?us-ascii?Q?mgYmqhUQt67XcrRj/+JfQfBdJYOAzDL/H4yx4hS6CRYpNhwNyJbJs/lWYKbQ?=
 =?us-ascii?Q?j0WqENbObCfV4BGR04cjt6G7nuf1mJQtYMjrvXh1Wtb2QkeEITeoYv5OPHQr?=
 =?us-ascii?Q?82jmZovjmRdfbGVdAZGO4uRSlOpziaCq3oPyWml8mNpFF6xhlwumq+W1XUTK?=
 =?us-ascii?Q?AYVs3wMHljwd6iTJDMokI/QwM+0u5cazMYAZqeB3k0omRtOuv4IHZ4gwjCt8?=
 =?us-ascii?Q?vCo/nQ9pu0PtpIUFMy6aA4gYHna5iPsXK/wHTV4GZuGbhEZHHtkItDvLST1Y?=
 =?us-ascii?Q?wZpfhdEGjj6q453ISBBcH1ZCK0sRjWcdNLGAQc+Xwmz+M+6K+c9+rS7teXJ+?=
 =?us-ascii?Q?3eCdYfi1I4etd88Tu8OmEjj0g5rCz/pKs7/pCjE+p+ftXD/upjPHZc5Mhuri?=
 =?us-ascii?Q?kid3VyL8b0i2lrPJ8CdnKcBYPvYBMTw87HEWVDYbLLxoKexSrp9yRLmqV2kT?=
 =?us-ascii?Q?50M9DIV6oO/584fZjb/0UcJGEV5jP0w1iHlpBUW9p0ZFZuGbNwxGBHM8l6UJ?=
X-MS-Exchange-AntiSpam-MessageData-1: xwf2k8FrOfg09gNQozRteYb2RNFKhR+J+gM=
X-OriginatorOrg: codasip.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a08ad65e-9fb1-40a6-1b52-08de75fdd4df
X-MS-Exchange-CrossTenant-AuthSource: AM9P192MB0983.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 12:43:39.2813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d91ffef-bb81-4cbd-b9b8-552583685f20
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7GNAwS/icyC/TVu+hUF24llydUmr8IFgfnShVUv2PHHKk5Sd0jwR1EMdR/AUOdislYms3svDP/cU9BgmOGnroEacARFBJywvI5iin2r5bQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P192MB0897
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 27 Feb 2026 12:43:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19092

Many CI setups rely on the GIT_CONFIG_GLOBAL environment variable to
define project-specific gitconfigs, often to inject credentials using
git's url.<base>.insteadOf configuration.

However, BitBake restricts the environment variables passed to the
fetch task to a fixed list (FETCH_EXPORT_VARS). Because
GIT_CONFIG_GLOBAL is missing from this default list, the variable is
stripped from the environment.

Add GIT_CONFIG_GLOBAL to FETCH_EXPORT_VARS to natively support this
credential injection method (and GIT_CONFIG_GLOBAL in general). This
also eliminates confusion for users who expect the variable to
propagate after adding it to `BB_ENV_PASSTHROUGH_ADDITIONS`, only to
find it has no effect during the fetch task.

Signed-off-by: Florian Schmaus <florian.schmaus@codasip.com>
---
 lib/bb/fetch2/__init__.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index dcf7adc26abe..aaefd860204a 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -877,6 +877,7 @@ FETCH_EXPORT_VARS =3D ['HOME', 'PATH',
                      'FTPS_PROXY', 'ftps_proxy',
                      'NO_PROXY', 'no_proxy',
                      'ALL_PROXY', 'all_proxy',
+                     'GIT_CONFIG_GLOBAL',
                      'GIT_PROXY_COMMAND',
                      'GIT_SSH',
                      'GIT_SSH_COMMAND',
--=20
2.52.0


