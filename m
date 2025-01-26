Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79D1C0218F
	for <webhook@archiver.kernel.org>; Sun, 26 Jan 2025 10:28:02 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.133])
 by mx.groups.io with SMTP id smtpd.web10.27530.1737884853127332663
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 26 Jan 2025 01:47:33 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@navimatix.de header.s=selector1 header.b=GIYDtrfb;
 spf=pass (domain: navimatix.de, ip: 40.107.20.133, mailfrom: joerg.sommer@navimatix.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piNZc5DvngYJi1Fuu3PDGI2VTkAEpZD5eXT7Kz/0IFVE3OeSnBKtz30bIH+GgbRtuUhjTRGfx4bEO3wuTn4N77jJQyfNT2sgc2getyXIyCA5cZhR1c5CQndTMn5f31vUs964vYaR/YD5Kzsz4ZR9nVuXh+2GM/hUH5F+8BtCImIvVITXbtXs0FeEX+CJ5U1kBLG3xGwrQpoCaTiE8dktGEt6zKhsBzGLLM3/3KW0QNQELhLXuDFz5KYeDikefhJ2DjrGkj2M8r1qSN7R2smeoKtV1HoKXh2l7aEVRvhqdV6pYIujNFLhIUJGFqzfyVR70p56lGbmRlk3hEN4nolp2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngt2TmF/VSb+uFTHbkMsrBpDCUg+E7UMA+5fuHAaqhE=;
 b=AoMy97mmi+GtUcojmf/otlfibWcS1S89FRGRLy2OKYcMoNz1Zegikk6koObo3x95kESbh2HP0GuXaU+ZlDpMpVviGu79ih2t+TAqC8tej9ZkThC4bD6xGgL+ZCo2E9R8wsCvvjN7i7wErqqosVfLAWPkw9K6WG3bHrJghyxkYzFILIjD4b15W4MZjGxQ6jpDGsFHmuWunALmeEBOMvdLR7nPagiokRQa8D2vn9n8zdAeYP22T0FiEQS888A19cZNOHVsFBsR3InEgpy6SxyNpWho31hm5whMzBP57ZxUa7OX2n3/0CMrmceXoVh4LOdiokgu8FFvR8f/suPmtH5vlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=navimatix.de; dmarc=pass action=none header.from=navimatix.de;
 dkim=pass header.d=navimatix.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=navimatix.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngt2TmF/VSb+uFTHbkMsrBpDCUg+E7UMA+5fuHAaqhE=;
 b=GIYDtrfbAZufdQZMACJLvryhIICze0VXSOTaSEdLtaxPaEizihXOTxRe1n/lonCVJw2VtuDZVU+0scwHTnrUiP49zHYLLtWnkpnprC9RNIKVJWxLVtqOsTeXzD9nKSLKjbEwE8B6BOffyEiPk4aLVwbnl9hi8tC+Tyu9JZPmcn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=navimatix.de;
Received: from AM9PR01MB8297.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:434::5) by DB9PR01MB8158.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:2bd::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Sun, 26 Jan
 2025 09:47:29 +0000
Received: from AM9PR01MB8297.eurprd01.prod.exchangelabs.com
 ([fe80::ac1f:a3d4:7e5a:72a9]) by AM9PR01MB8297.eurprd01.prod.exchangelabs.com
 ([fe80::ac1f:a3d4:7e5a:72a9%6]) with mapi id 15.20.8377.021; Sun, 26 Jan 2025
 09:47:29 +0000
Date: Sun, 26 Jan 2025 10:47:28 +0100
From: =?UTF-8?B?SsO2cmcgU29tbWVy?= <joerg.sommer@navimatix.de>
To: bitbake-devel@lists.openembedded.org, docs@lists.yoctoproject.org, 
	joerg.sommer@navimatix.de
CC: docs@lists.yoctoproject.org, 
	=?utf-8?B?SsO2cmc=?= Sommer <joerg.sommer@navimatix.de>
Subject: [PATCH v2] doc/logging: small clean-up and name environment
Message-ID: <6ab2ca1d7d9cd7ebf98aaca7e19612b3de0f133b.1737884847.git.joerg.sommer@navimatix.de>
X-Mailer: git-send-email 2.47.1
References: <D6UW0L5UHG5P.1JGNQ7WKC2N6@bootlin.com>
In-Reply-To: <D6UW0L5UHG5P.1JGNQ7WKC2N6@bootlin.com>
X-ClientProxiedBy: BE1P281CA0418.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::21) To AM9PR01MB8297.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:434::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR01MB8297:EE_|DB9PR01MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: e286f304-c3b5-482e-cbea-08dd3dee72cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?osBquD9ELh76yfxKB8m0lBPHEn+bP6mll6O3QmsqtLprSOmgqZX+8Njf18Hd?=
 =?us-ascii?Q?6cMNTQ9ofj/i+bQpI/PETcjgjTdwteaRpwpiUSt0ZqSzIpc8IAJPVQjcPibg?=
 =?us-ascii?Q?hhHSKfLVYjjlRxdge4Ip/CDcLXqEan73ZDVkvYQoWDgEeuMnGN1xztR4jOVP?=
 =?us-ascii?Q?NXTI4guAAYvRjXA5FQtjPkbSK8uEAFUnSRkQtOGDGkViamJbxEFGQYcrQTan?=
 =?us-ascii?Q?pyG4yk8YiKpvpoq+Ti7p+TkUZcS4YAWBjRfEYCqAAle1ZlGaJbIQ1JezcE7K?=
 =?us-ascii?Q?hSGrV/GdsTjyuzEsXg2jrFhRSNPUnoNBC4f89K60FFJ19O8K9G5ZNI0IoOB0?=
 =?us-ascii?Q?PoRVbZtXvVN+VfDA2ax2gZrJCz95OU816yMWIJNlXd8NRDxEuOn+7gaGu9C6?=
 =?us-ascii?Q?irG52kVeiTd+XxyXby0oInbPVpU3g7LI2afiHBxTMek4WT5OFi/CPlYK+tc6?=
 =?us-ascii?Q?NqJJyuaQKkEBLOYluh3cpuB1DZ8/2ndRHaWUcFj8s0ZfxebFApy9gRAwH0tV?=
 =?us-ascii?Q?xSkXQPmcMbhympXanq8bz828c38yGJWzUykS7WGBYscVoa0HzipGLHGb4oFn?=
 =?us-ascii?Q?yjIQCk2fExBJnOfsJgj2WFtqtUT4Wy0sZTA7xC7Wape/Fem3EC29kEz/x48m?=
 =?us-ascii?Q?NGWL8gv1MthNex94xPOCnRqqVo6P0z7L5dfqSV0u7wDfXS8n0NXw1Atl12CQ?=
 =?us-ascii?Q?eOTULgJ+0cuanDi7l6TTRKfvH5znhRb33PM2mEipIN37tKJ48nejSNnB3/8e?=
 =?us-ascii?Q?YvlmT8a7fCSi24vq9I2qY9Nr8ekY0q6BNed9g7u6XcEdu730N7+z1i/fAlgJ?=
 =?us-ascii?Q?GQChUgdBIit4lXUiHpedIIqg9J5hsBl66NskaSlBImTfoLgvJuOXhfldzVDY?=
 =?us-ascii?Q?TZX51rqfxB1DN31bDVUtZCWJm27Nag0AH4ptgLiVtyLn7i/AopBtYc2ySfDw?=
 =?us-ascii?Q?Rp07mYdy5oWgv4hRix/OSBhjky8x7MB8t9lcl3/s2LnsrPFF/VRX+vTh2IZF?=
 =?us-ascii?Q?P3gS14FZ/584pR5/GLDGqKtrb6kLhxZvTHdGjeW1Xb9hYb6In/Bz8JH4fxCR?=
 =?us-ascii?Q?qhz0baTV63IIbipZjAUL/swn7Q2TvGhgym/sYmC74e733L+5wcI9ZghXkrhc?=
 =?us-ascii?Q?GSd1OeUq3ftszTukiOLNU18BBF9N8e0dpn9lta/yeOaT+BnWVpJC5zuzwNUU?=
 =?us-ascii?Q?AgYYGhYEE4Qsn4XzjtFuLRmUDd9NnQ8rqcjyW2j0IsO255nXD8ISCwGuJwWq?=
 =?us-ascii?Q?JSeTEXmvZ+h/Ym2jVHBlqaNdxPMJboRx/gPRVhIyat4aVavh+vBQBrkdtWbR?=
 =?us-ascii?Q?vZrfqBRhFF5BpSgsulAywiaXRXfCUEh3KoolkNok2Iy/Mq+YFfjIvT5JXgcs?=
 =?us-ascii?Q?fgnnc0OTW42zSIuT+3YiWXx2OVDg?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR01MB8297.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7RxOfulpbiOobPG+N98NvS4dll9gx5tsI0OFIsCnAcGVAFPIVWaPxnr98plc?=
 =?us-ascii?Q?o3GyHm+O6CvOO9WvfbT+TqBO52vPNYVCppyZq6QyIlZZia+IDWLB4Xblzm3Y?=
 =?us-ascii?Q?s359R30zvb0+e8l/U4Q1c3ybn/aGkoo7WiIdQ26EEjHneh92glF7DfGJjPP5?=
 =?us-ascii?Q?TW3HGZ2S+BIFE3vDtKJShP5MyfOmy9bT3sCCNNnV9fe83uIg1iUO15XKxuCv?=
 =?us-ascii?Q?Kjib/rl7oEHiWwDryrYfcGEW/iMCzfdagGTaw6sbbvuhD/pUhz4F2EzdeSbe?=
 =?us-ascii?Q?BgqN/9wWK106vjLN+zLY9cdnOu3HDTVUV/8vbehB6k7g9VZxBgaPMp8nhu5N?=
 =?us-ascii?Q?NyPDSo2EuhL9PODLPKnpoteB56qgOxkcC3eY4/DIr1Q7vOxbfNAAAhKySsA9?=
 =?us-ascii?Q?N5uQsivfqvtAyG4jeGvReJ/wHfaBkhfZQTOGqm6G9b+RDGp7G8MH3v2EsfNZ?=
 =?us-ascii?Q?s/kmWtfjCKwbb/f4LjVYetSkBMJBuBG9TLkchFLzws0uLYPLRauwjNKgDSrA?=
 =?us-ascii?Q?pAmTOZbuaiT0wZoxDXm99mLEuEDO5i9Y75JMbR3z0ftlv31VuRu8N6g3qKde?=
 =?us-ascii?Q?dT4boCWOWrJzhYJwYcwiD6DrBTAgf7aaTx/PV3TxFF4KWed0CdV/1OljRGgs?=
 =?us-ascii?Q?UL8d8J3HcLSBciz/ne4BbeGUlbGe7n6PElKXSh7bDnllCvS+dl/K9isGcpVS?=
 =?us-ascii?Q?Ckxf/OIN7xoR29poM6Mw/99UEnZIvIShobWbeaMgUYPl18qKLSBvvbGNnkXR?=
 =?us-ascii?Q?amFepvWBJvQeiOw82LRmgyie5/wFfoMpfmpDyESdIfBjkjxvzzmdw6Uq0cOC?=
 =?us-ascii?Q?CgGwDkreItQjLR02rgU4tEuf7v6vhjbgAuTevhSGRFlLad+h2hPRDpAXmx29?=
 =?us-ascii?Q?dar3ib6kLWnNmAUc1FfA6ewp6+g0tv9mOFW6MgBSbqUeArC/FDnebJHeQlYn?=
 =?us-ascii?Q?jaW8K7SDjDFvSdLh7zGWlqNaT/x8nerooje3S9FYwOnsvGKansDZcmWt8mib?=
 =?us-ascii?Q?5dHeMopWcwZ5qTZRDGtYZmQoUFgwAlU1yR4ag1+Tjssq8I3TYW7jer6klNfz?=
 =?us-ascii?Q?qf5rzB0IUXVNCpc+gb72nfCltdFqzcYw0yV4sgwcurUH7BXm8nK+wAFqDH6n?=
 =?us-ascii?Q?PyIPPnYPK6y5FSq+xwecbZfhtRz5wMkEHKMMv0XnsFl5LAyieCLG43Xqh7cE?=
 =?us-ascii?Q?8nX9vcO7U//JjM4mrdbdogdDp+kpykNwAI4Jcnea67IQffdqXLHNz48UiFnp?=
 =?us-ascii?Q?QshfnEYmcg/U8hq3Y15CJOhS0p1XuvgG81p9vrXBUX9NcDgKiIJlVyP1vAUk?=
 =?us-ascii?Q?0H7eq3cJZytds2yJgIID2gld9vSS3hJr6yxAn/wMkPgir+Z5x5ZPBOC+l88Y?=
 =?us-ascii?Q?fhP0L8zog9Ekg0CJRR4FgKs6P3BOEuwDwEN9vY7o2+NsNNMdloWWcoUaMOS/?=
 =?us-ascii?Q?tYYzcCD5/QQzQDyGlB1SmdKlU2Xb9kA9GS95JT46m/pVADd4cZYI3WKz/PHr?=
 =?us-ascii?Q?SQD99uGnMXVGU3YcKO6bC6piW5lKpBR5crWmOssuWvy0FqbLftT2471REsxs?=
 =?us-ascii?Q?X+n4cljtGcdonQEdUoVPv0c1X2QfgvzM9dqA+5ZeskDjYe5d1BXMK6hMXwIK?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: navimatix.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e286f304-c3b5-482e-cbea-08dd3dee72cb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR01MB8297.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2025 09:47:29.6011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: c87b4f54-b992-4813-8f3f-4a876324197f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: isk5JtTm8S+vxVVFP0h3Gk0Apio8lPSqGDuhBltqRt2Y4VpJt2qUKPk/6ZatgQhUDQ+PyIvIvQ6eDB0a8iPzr6mh77Laj7N3RRuOCMfDjiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR01MB8158
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 26 Jan 2025 10:28:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17089

From: J=F6rg Sommer <joerg.sommer@navimatix.de>

The variable *BB_LOGCONFIG* is part of *BB_ENV_PASSTHROUGH_ADDITIONS* in
/scripts/oe-buildenv-internal and can therefore be passed as environment
variable.

Signed-off-by: J=F6rg Sommer <joerg.sommer@navimatix.de>
---
 .../bitbake-user-manual-execution.rst                 | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst b/do=
c/bitbake-user-manual/bitbake-user-manual-execution.rst
index d58fbb32e..993dc3546 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.rst
@@ -671,7 +671,7 @@ logging configuration is merged using the following rul=
es:
=20
 -  Any keys defined in the ``handlers``, ``formatters``, or ``filters``,
    will be merged into the same section in the default configuration,
-   with the user specified keys taking replacing a default one if there
+   with the user specified keys replacing a default one if there
    is a conflict. In practice, this means that if both the default
    configuration and user configuration specify a handler named
    ``myhandler``, the user defined one will replace the default. To
@@ -707,9 +707,9 @@ or higher priority to a file called ``hashequiv.log``::
            }
        },
        "formatters": {
-               "logfileFormatter": {
-                   "format": "%(name)s: %(levelname)s: %(message)s"
-               }
+           "logfileFormatter": {
+               "format": "%(name)s: %(levelname)s: %(message)s"
+           }
        },
        "loggers": {
            "BitBake.SigGen.HashEquiv": {
@@ -723,7 +723,8 @@ or higher priority to a file called ``hashequiv.log``::
        }
    }
=20
-Then set the :term:`BB_LOGCONFIG` variable in ``conf/local.conf``::
+Then set :term:`BB_LOGCONFIG` as an environment variable when running
+BitBake, or set it in ``conf/local.conf``::
=20
    BB_LOGCONFIG =3D "hashequiv.json"
=20
--=20
2.47.1


