Return-Path: <jaipaul.cheernam@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A2BCD98C5
	for <webhook@archiver.kernel.org>; Mon, 15 Jun 2026 12:19:08 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.128144.1781525947127820525
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 15 Jun 2026 05:19:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=u23mY9r2;
 spf=pass (domain: est.tech, ip: 40.107.162.1, mailfrom: jaipaul.cheernam@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E24XjK2SyEzFeWS2ZIgduLhYQgR61JjlT5C/1oh5cl1SGBNB9kaI2s3cEBKAoD44LnFl3YIOfcyGfZvKhT1+W6+Ldw/0k+nw1xFL6ZSoMPIoTKoSH7jl68u7ggqIL5i2QZ/EkudG6keFJ1c4q8UtoS8DyixogrfmGNoUcYtRY/DAbtNCn/NWo4w/ETwHIFKff9w2eLRM0X//aEYFeHHDYyXJSWGrrechRv1aqesbK67Pkmrp8UTJEJ2mSAtkVUCl3+jwOoQPRAQlQSloG1J77miTY8HHXq5qXz141Y8M29wtWIOlSLkrXTgdw0MLwzZPBlXLfshd9e9KdoEaIN+2dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pt/sUovfe3nayEpe7weAxHMcJ05oJTnFZ/Fqp4078Po=;
 b=ryZWnwMB5+IqM9n/N5b6aq63mcl3zBfKObN1tTNJ6s+gQfOFJCqETh6xXsdSh6LLRIddpLV6+x8XRE2MHSIhiem+NdOgO+Wxcb9kxPlYkBaPrIIk3PCrY2T5WRQDjoITuVaKFUGHCu4zTlfpyNDAcMOWaZIJjrK7jefla2bGFZdg6imFa5eeY9ah7SNk2pW2OJJcUfTOFJzq/ElH1USrTwNwN/07DKx8fkONL0CWZKlo8PkliP804XPJ1xXEuVBHhUlubCxPOAnX8zJz/MmDCouD4qwqrzPopdgXY5bdozHP8ohBencVnGhca5i4hiFbVJXijFfxZf1e4FTk0VQL7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pt/sUovfe3nayEpe7weAxHMcJ05oJTnFZ/Fqp4078Po=;
 b=u23mY9r2UoS9x+fgDl+1GdoqsFIb/R34gkrWwyhxmbmfPA5ynObQ4gPhWuumauIHzaN8+K4EPhz6vxHJ6fX2pjqWCyiAwTNZOWmzmJo6m5BE9ye7MZhxrfHZ3zrLT6uVz4MIbeEP3AqnS0CeHfrLQI4Ttfq4bej4UnxIFANlufb10CXUgvq7HcgYwgnWKELL/PoKlyIR0HMZXNKVvNcFm5h7VjzgPSjPStHbqLM5lPexYeD6os12tzxtzNFfs8UTjYXVHmw/fE0DfS36RDKB+BqF02DmX2CHTtU5WOK+q6XgMV13KphmRxjMT72gkdsR0nijD1jchH2k829PKo5f4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM (2603:10a6:18:3::ad4)
 by VE1P189MB1071.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:168::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Mon, 15 Jun
 2026 12:19:02 +0000
Received: from DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 ([fe80::566d:7425:a795:5560]) by DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 ([fe80::566d:7425:a795:5560%7]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 12:19:02 +0000
From: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Subject: [PATCH] bitbake-setup: pass install-buildtools options from config and CLI
Date: Mon, 15 Jun 2026 14:18:56 +0200
Message-ID: <20260615121856.96250-1-jaipaul.cheernam@est.tech>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DU7PR01CA0038.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::20) To DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:18:3::ad4)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PPF66507B2D7:EE_|VE1P189MB1071:EE_
X-MS-Office365-Filtering-Correlation-Id: 93032851-75ca-4aeb-6931-08decad848b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|56012099006|3023799007|6133799003|11063799006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	jfq4Y2YhcJyKS/yR82TgNx2iSNvgtSjJvAI/e5kPqIQ4dy+BkVz/mKM46Lz1/7/DGfkkj5H7milCoKWb8B+/LOnP9v3mozNcyd9qDe4lkeqUcX2Z25YkNVDom2U/6WdGHgw3x8EB3GzIevrabfLn/EjexEY26beqxkqxWMaQK8RdEI3PfVzSNlY8IoV5CD8C42TA7NJDPqQ+g00KgtKvsa/fpp5LLq7GVNZBAwVlni4M1enJWZP8+xcQrZYI6X1r1HzLDdTHvVWe2wlpdYG5ICMWQIRf1c/2vJaIxdtEIfXIkZGhx0vwL1ZhGabW3UtzLdbswIr0E0kxQrswgQPmyh0W9WnlciDrVQdC1HpJeWr4+LIstOBcZsY/WPvNWildUWYKbGok0NGtblAk5tKJvT3Oo01WzM/X7rxszUtUao1VLpRaISvHPseubgn+irJjt/g4Im85xrmV2Gh9rmSfQ+BvUAaGv0p1cpPSAwrgiD1dpqNYJko3RtWW74s+31PJJjssSyIo7qL5Y5hLc36hi80NSYXlsUg4W0Hf3R3BlnV2ICz3JDWtPUf1Ba9dvoUamtJahaXRwRsYgIFjHR5H6aYe2I+jmXLUVkm1JXdpZcQ/VEjlzA4pH6qMgSMfcV92KsWD3nqohZDLI0+TmIvVWg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(3023799007)(6133799003)(11063799006)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+1UVkBqqaT/hG3svWvqrBAcWsS9NnHhUzlIYN6bS6RYKx85WAYQSTMSb3OwN?=
 =?us-ascii?Q?T28hj0HcWwROK/eckkvInd3yBtyxZnVR5lyLEFY3e5oa8kLJj9L3HJ0HE920?=
 =?us-ascii?Q?lWK6xnXOx6qdG61qdEAJ3K7YK/ncNWldzgjvSYKCtJgarqW0SyyylJqmHzJp?=
 =?us-ascii?Q?PSXbUryY9vIx6cR78L2l1gfRMTHBwQyMw6PeJzc1RvmiSFCb1aA6G8C46IaK?=
 =?us-ascii?Q?zBlu6vbXiRSw3+hSYvoVjR6RxyZilcCc6g/iuKtrtxZlVm5yGmGtEPl+bQTU?=
 =?us-ascii?Q?dJZtl1+GoFS2Avav8LDTrSIZXrSxPSuGtjC2o5BsdliSwMZ/lDe0B5X3SWPX?=
 =?us-ascii?Q?3E18Wd8HHzGD+cFXPccxzFvX5RhIIT6mWBs5k0qRmMSvdYOyuOZIawPK2rUV?=
 =?us-ascii?Q?1ETbdJ1uJfS1+nNBgOWG4Lov9esC4aEwkX5cJqOS9blJyiWL6De1hNDmlysc?=
 =?us-ascii?Q?t9kBPTeCyElXqFgJQiOdscRZEm/JS45TVVaW2jEoxxw3R3oBAhz6QLno7JgZ?=
 =?us-ascii?Q?gz3e6x0UZqJpgaajaOxNviwjHll0nHpccmSPFq5gRnvBQ8BtkhbZEqs3w1Mc?=
 =?us-ascii?Q?i6RZi4uYlyLVwiGtUzDFOEHUyTBW7cV4WnztBIx7buyUSt4hgFE238YGNSzU?=
 =?us-ascii?Q?zequDUdS2lED318f51irR5XQvGOtBOpMyfbVRq0M0Gi3c+gJnUbzH18xKyDH?=
 =?us-ascii?Q?OiLtF66JZftSPyvDgMMcx05Td7GfYVp+uRp+Awmv4924twf6RinGAe/M2/Jp?=
 =?us-ascii?Q?LV1yr3TxtPKwL71lvXtJo2MxTvVsZGv2ItWQ0NznllkuyjyXCkx6x5r42A6B?=
 =?us-ascii?Q?r1QAtDaHv+pycwcPYT4EVcqwkaWo91tQWcEVyjsEoBLCcBTd8/ruEGwdVsMp?=
 =?us-ascii?Q?kznpjDGjEOJzbEcfB3BHs8qnCNumBl+pp/zsAc7JJkQlDj83PrdRM2a28GIT?=
 =?us-ascii?Q?HEL52YGK9WpcZhj+CAxw5RAiZCe27o59FB4kGM143Ba1Aq1N9oqkRwdvHxPt?=
 =?us-ascii?Q?WR7uN3GJvmYz9Y46y9Ofk9V4hvsrO1driTy+d2JbQAiZpuDHEK9lHPJPUNxF?=
 =?us-ascii?Q?lxvftqKz1LaGkJ18fZwiZ3lRRBcD4PAWdRMKdeX2wsw+xatzY8+7+yD/xYN/?=
 =?us-ascii?Q?+RpZkU/qgpTkc3uyWy/7Y06v9Nl+HxQomhvYC1b0pILngvvJYokQbDPwuYca?=
 =?us-ascii?Q?7Kwu0A9jF0qWOXkRZnZpGT+XOWavomx5MVSxSWprNpgVkuuNOv28Ps57LGnt?=
 =?us-ascii?Q?+pZt7wdtgVbjEvMvz0sJ34cB31YjdX7CFjoLVfDNkAKfyo+953MAgwzvpYqY?=
 =?us-ascii?Q?TXmYdEpU7WVwppBJ7fykwtPijsc4JFMtcc2w3SN9pmnvmHaeGlDtao64srKT?=
 =?us-ascii?Q?GHgp1Z43lC1dCn+mccIE/5TJi2kOFMTkdSi5NFYZ/AJTNO9E98P9UhW5QnbW?=
 =?us-ascii?Q?RsmY8kbvSNNxt3URfq/M9faPE/DLSn2N3ixVz6jYyk07yvNMZKfNIpdllR1i?=
 =?us-ascii?Q?pAeHvx7791OKvczI4Kc2/paLX9BxQBYNcnx0WWQRosGVN+AeBXWwNzlTUaLb?=
 =?us-ascii?Q?iMSCMM7tVJHOBOQhBC26qeXpNswG9nTgXRxhZlSr3JkhvVVY++mron2kWtTU?=
 =?us-ascii?Q?67nrLFWTtpk8B9NUB3QbxyaEwVbjrHo621a5q8KfcrTv44Sq4SoXe/QKjvGP?=
 =?us-ascii?Q?FhrUb3KRm7NXBgYVsUmJdeMWfDFeh+CSmNUrTIzLe4Rf3kl4WqGFOsLn/fLx?=
 =?us-ascii?Q?FHX1DcMtTg=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 93032851-75ca-4aeb-6931-08decad848b4
X-MS-Exchange-CrossTenant-AuthSource: DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 12:19:02.3186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8x7vYotDshMMqZxltLwGiLTK1mCxbgZz+/DtYKbYRWginKYSQYuVrf2K+uEJMkJs9PDYnOLaTZOJqu9RFGUmNlqk0o03iDDCZ1rlI/pGwvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P189MB1071
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 15 Jun 2026 12:19:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19685

Allow distro-specific buildtools to be configured with a custom URL,
filename, and SDK name via an install-buildtools section in
config-upstream.json. Expose the same options as CLI arguments: --url,
--filename, --sdk-name, --no-check. CLI arguments take precedence over
config values.

This requires the --sdk-name option to be available in
oe-scripts/install-buildtools from openembedded-core.

AI-Generated: Kiro with Claude Opus 4.6

Signed-off-by: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
---
 bin/bitbake-setup                             | 49 +++++++++++-
 .../bitbake-user-manual-environment-setup.rst | 33 ++++++++
 lib/bb/tests/setup.py                         | 80 ++++++++++++++++++-
 setup-schema/bitbake-setup.schema.json        | 30 +++++++
 4 files changed, 188 insertions(+), 4 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index fe3b6b0e6..343d428e8 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -1052,10 +1052,49 @@ def install_buildtools(top_dir, settings, args, d):
             return
         shutil.rmtree(buildtools_install_dir)
=20
-    install_buildtools =3D os.path.join(args.setup_dir, 'layers/oe-scripts=
/install-buildtools')
+    install_buildtools_script =3D os.path.join(args.setup_dir, 'layers/oe-=
scripts/install-buildtools')
     buildtools_download_dir =3D add_unique_timestamp_to_path(os.path.join(=
args.setup_dir, 'buildtools-downloads/buildtools'))
+
+    buildtools_config =3D {}
+    upstream_config_path =3D os.path.join(args.setup_dir, 'config', 'confi=
g-upstream.json')
+    try:
+        with open(upstream_config_path) as f:
+            upstream_config =3D json.load(f)
+        buildtools_config =3D upstream_config.get('data', {}).get('bitbake=
-setup', {}).get('install-buildtools', {})
+    except FileNotFoundError:
+        pass
+    except json.JSONDecodeError as e:
+        logger.error("Failed to parse %s: %s" % (upstream_config_path, e))
+        sys.exit(1)
+
+    url =3D args.url if args.url is not None else buildtools_config.get('u=
rl')
+    filename =3D args.filename if args.filename is not None else buildtool=
s_config.get('filename')
+    sdk_name =3D args.sdk_name if args.sdk_name is not None else buildtool=
s_config.get('sdk-name')
+
+    for name, value in (("url", url), ("filename", filename), ("sdk-name",=
 sdk_name)):
+        if value =3D=3D "":
+            logger.error("%s is empty" % name)
+            sys.exit(1)
+    no_check =3D args.no_check if args.no_check is not None else buildtool=
s_config.get('no-check', False)
+
+    if (url is None) !=3D (filename is None):
+        logger.error("url and filename must both be set (from CLI or confi=
g) or both omitted")
+        sys.exit(1)
+
+    cmd =3D [
+        install_buildtools_script,
+        '-d', buildtools_install_dir,
+        '--downloads-directory', buildtools_download_dir,
+    ]
+    if url and filename:
+        cmd +=3D ['--url', url, '--filename', filename]
+    if sdk_name:
+        cmd +=3D ['--sdk-name', sdk_name]
+    if no_check:
+        cmd.append('--no-check')
+
     logger.plain("Buildtools archive is downloaded into {} and its content=
 installed into {}".format(buildtools_download_dir, buildtools_install_dir)=
)
-    subprocess.check_call("{} -d {} --downloads-directory {}".format(insta=
ll_buildtools, buildtools_install_dir, buildtools_download_dir), shell=3DTr=
ue)
+    subprocess.check_call(cmd)
=20
 def create_siteconf(top_dir, non_interactive, settings):
     siteconfpath =3D os.path.join(top_dir, 'site.conf')
@@ -1285,6 +1324,12 @@ def main():
     parser_install_buildtools =3D subparsers.add_parser('install-buildtool=
s', help=3D'Install buildtools which can help fulfil missing or incorrect d=
ependencies on the host machine')
     add_setup_dir_arg(parser_install_buildtools)
     parser_install_buildtools.add_argument('--force', action=3D'store_true=
', help=3D'Force a reinstall of buildtools over the previous installation.'=
)
+    parser_install_buildtools.add_argument('--url', action=3D'store', help=
=3D'URL from where to fetch the buildtools SDK installer, not including fil=
ename. Requires --filename. Overrides config value.')
+    parser_install_buildtools.add_argument('--filename', action=3D'store',=
 help=3D'Filename for the buildtools SDK installer. Requires --url. Overrid=
es config value.')
+    parser_install_buildtools.add_argument('--sdk-name', action=3D'store',=
 default=3DNone, help=3D'SDK name used in the environment setup script (e.g=
. customsdk). Overrides config value.')
+    check_group =3D parser_install_buildtools.add_mutually_exclusive_group=
()
+    check_group.add_argument('--no-check', action=3D'store_const', const=
=3DTrue, default=3DNone, dest=3D'no_check', help=3D'Disable checksum valida=
tion. Overrides config value.')
+    check_group.add_argument('--check', action=3D'store_const', const=3DFa=
lse, dest=3D'no_check', help=3D'Enable checksum validation. Overrides confi=
g no-check: true.')
     parser_install_buildtools.set_defaults(func=3Dinstall_buildtools)
=20
     parser_settings_arg_global =3D argparse.ArgumentParser(add_help=3DFals=
e)
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.=
rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index aa546c30b..931fda798 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -660,6 +660,39 @@ In addition, the command can take the following argume=
nts:
 -  ``--setup-dir``: path to the :term:`Setup` to check to status for. Not
    required if :term:`BBPATH` is already configured.
=20
+-  ``--url``: URL from where to fetch the buildtools SDK installer, not
+   including filename. Requires ``--filename``. Overrides the value from t=
he
+   configuration file.
+
+-  ``--filename``: filename of the buildtools installer. Requires ``--url`=
`.
+   Overrides the value from the configuration file.
+
+-  ``--sdk-name``: SDK name used in the environment setup script installed
+   by the buildtools tarball (e.g. ``customsdk`` for
+   ``environment-setup-<arch>-customsdk-linux``). Defaults to ``pokysdk``.
+   Overrides the value from the configuration file.
+
+-  ``--no-check``: disable checksum validation when the server does not
+   provide a ``.sha256sum`` file alongside the installer. Checksum
+   validation is enabled by default.
+
+The ``url``, ``filename``, ``sdk-name`` and ``no-check`` options can also =
be
+set in the :term:`Configuration File` under the ``bitbake-setup`` section:=
:
+
+   "bitbake-setup": {
+       "install-buildtools": {
+           "url": "https://example.com/buildtools",
+           "filename": "x86_64-buildtools-extended-nativesdk-standalone-5.=
0.sh",
+           "sdk-name": "customsdk",
+           "no-check": true
+       },
+       "configurations": [ ... ]
+   }
+
+CLI arguments take precedence over values in the configuration file.
+Note that setting ``no-check`` to ``false`` in the configuration file has =
no
+effect; omit the key to use the default (enabled).
+
 .. _ref-bbsetup-command-settings:
=20
 ``bitbake-setup settings``
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 5592e8196..f14da5a60 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -11,6 +11,7 @@ import glob
 import hashlib
 import json
 import os
+import shutil
 import stat
 from bb.tests.support.httpserver import HTTPService
=20
@@ -61,13 +62,22 @@ import getopt
 import sys
 import os
=20
-opts, args =3D getopt.getopt(sys.argv[1:], "d:", ["downloads-directory=3D"=
])
+opts, args =3D getopt.getopt(sys.argv[1:], "d:", ["downloads-directory=3D"=
, "url=3D", "filename=3D", "sdk-name=3D", "no-check"])
+installdir =3D None
 for option, value in opts:
     if option =3D=3D '-d':
         installdir =3D value
+    elif option =3D=3D '--url':
+        print("install-buildtools url=3D{}".format(value))
+    elif option =3D=3D '--filename':
+        print("install-buildtools filename=3D{}".format(value))
+    elif option =3D=3D '--sdk-name':
+        print("install-buildtools sdk-name=3D{}".format(value))
+    elif option =3D=3D '--no-check':
+        print("install-buildtools no-check")
=20
 print("Buildtools installed into {}".format(installdir))
-os.makedirs(installdir)
+os.makedirs(installdir, exist_ok=3DTrue)
 """
         self.add_file_to_testrepo('scripts/install-buildtools', installbui=
ldtools, script=3DTrue)
=20
@@ -644,6 +654,72 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
     def _count_layer_backups(self, layers_path):
         return len([f for f in os.listdir(layers_path) if 'backup' in f])
=20
+    def test_install_buildtools_options(self):
+        """Test that url, filename, sdk-name and no-check are passed throu=
gh to install-buildtools"""
+        if 'BBPATH' in os.environ:
+            del os.environ['BBPATH']
+        os.chdir(self.tempdir)
+
+        self.runbbsetup("settings set default registry 'git://{};protocol=
=3Dfile;branch=3Dmaster;rev=3Dmaster'".format(self.registrypath))
+        self.add_file_to_testrepo('test-file', 'initial\n')
+        self.add_json_config_to_registry('test-config-bt.conf.json', 'mast=
er', 'master')
+        self.runbbsetup("init --non-interactive test-config-bt gadget")
+        setuppath =3D self.get_setup_path('test-config-bt', 'gadget')
+
+        # test CLI options are passed through
+        out =3D self.runbbsetup("install-buildtools --setup-dir {} "
+                              "--url https://example.com/buildtools "
+                              "--filename x86_64-buildtools.sh "
+                              "--sdk-name customsdk "
+                              "--no-check".format(setuppath))
+        self.assertIn("install-buildtools url=3Dhttps://example.com/buildt=
ools", out[0])
+        self.assertIn("install-buildtools filename=3Dx86_64-buildtools.sh"=
, out[0])
+        self.assertIn("install-buildtools sdk-name=3Dcustomsdk", out[0])
+        self.assertIn("install-buildtools no-check", out[0])
+
+        # test config options are passed through
+        shutil.rmtree(os.path.join(setuppath, 'buildtools'))
+        with open(os.path.join(setuppath, 'config', 'config-upstream.json'=
)) as f:
+            config_upstream =3D json.load(f)
+        config_upstream['data']['bitbake-setup']['install-buildtools'] =3D=
 {
+                'url': 'https://example.com/buildtools',
+                'filename': 'x86_64-buildtools-from-config.sh',
+                'sdk-name': 'customsdk',
+                'no-check': True
+            }
+        with open(os.path.join(setuppath, 'config', 'config-upstream.json'=
), 'w') as f:
+            json.dump(config_upstream, f)
+        out =3D self.runbbsetup("install-buildtools --setup-dir {}".format=
(setuppath))
+        self.assertIn("install-buildtools url=3Dhttps://example.com/buildt=
ools", out[0])
+        self.assertIn("install-buildtools filename=3Dx86_64-buildtools-fro=
m-config.sh", out[0])
+        self.assertIn("install-buildtools sdk-name=3Dcustomsdk", out[0])
+        self.assertIn("install-buildtools no-check", out[0])
+
+        # test CLI overrides config =E2=80=94 pass --url/--filename on CLI=
 to avoid implicit dependency on case 2 config state
+        shutil.rmtree(os.path.join(setuppath, 'buildtools'))
+        out =3D self.runbbsetup("install-buildtools --setup-dir {} "
+                              "--url https://example.com/buildtools "
+                              "--filename x86_64-buildtools.sh "
+                              "--sdk-name overridden".format(setuppath))
+        self.assertIn("install-buildtools sdk-name=3Doverridden", out[0])
+        self.assertIn("install-buildtools url=3Dhttps://example.com/buildt=
ools", out[0])
+        self.assertIn("install-buildtools filename=3Dx86_64-buildtools.sh"=
, out[0])
+
+        # test --check overrides config no-check: true
+        shutil.rmtree(os.path.join(setuppath, 'buildtools'))
+        out =3D self.runbbsetup("install-buildtools --setup-dir {} --check=
".format(setuppath))
+        self.assertNotIn("install-buildtools no-check", out[0])
+
+        # test --url without --filename is rejected
+        with open(os.path.join(setuppath, 'config', 'config-upstream.json'=
)) as f:
+            config_upstream =3D json.load(f)
+        config_upstream['data']['bitbake-setup'].pop('install-buildtools',=
 None)
+        with open(os.path.join(setuppath, 'config', 'config-upstream.json'=
), 'w') as f:
+            json.dump(config_upstream, f)
+        # --force used instead of shutil.rmtree since buildtools dir exist=
s from prior subcase
+        with self.assertRaises(bb.process.ExecutionError):
+            self.runbbsetup("install-buildtools --setup-dir {} --force --u=
rl https://example.com/buildtools".format(setuppath))
+
     def test_update_rebase_conflicts_strategy(self):
         """Test the --rebase-conflicts-strategy option for the update comm=
and.
=20
diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-=
setup.schema.json
index 99f47f73d..2a967c96e 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -141,6 +141,36 @@
                         },
                         "additionalProperties": false
                     }
+                },
+                "install-buildtools": {
+                    "type": "object",
+                    "description": "Optional settings passed through to oe=
-scripts/install-buildtools",
+                    "properties": {
+                        "url": {
+                            "type": "string",
+                            "minLength": 1,
+                            "description": "URL from where to fetch the bu=
ildtools SDK installer, not including filename. Requires 'filename'."
+                        },
+                        "filename": {
+                            "type": "string",
+                            "minLength": 1,
+                            "description": "Filename for the buildtools SD=
K installer. Requires 'url'."
+                        },
+                        "sdk-name": {
+                            "type": "string",
+                            "minLength": 1,
+                            "description": "SDK name in the environment se=
tup script (e.g. 'customsdk'). Defaults to 'pokysdk'."
+                        },
+                        "no-check": {
+                            "type": "boolean",
+                            "description": "Set to true to disable checksu=
m validation when the server does not provide a .sha256sum file. no-check: =
false is equivalent to omitting the key."
+                        }
+                    },
+                    "dependencies": {
+                        "url": ["filename"],
+                        "filename": ["url"]
+                    },
+                    "additionalProperties": false
                 }
             },
             "additionalProperties": false
--=20
2.34.1


