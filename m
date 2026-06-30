Return-Path: <jaipaul.cheernam@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08ACFC43458
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 12:02:39 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19326.1782820954655120789
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Jun 2026 05:02:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=ITiRzcAP;
 spf=pass (domain: est.tech, ip: 52.101.72.54, mailfrom: jaipaul.cheernam@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQLBTDdriyPVdxDTOXoV1lRWFBDyQ4MCe5jhC/PNzj5P0PnwTPEXLF87Ae3YlXoBPHoDgg1X9ltaXRCBzaABwmDsDzunEQgq0Ntfn/EGA98XYS9BzQN3yjOKSLOj9DpKj5wL0Bbe2lxZQsW6s0RdG5xkCL9c0l5ka7nA214XfB+rOyKaKRghrQ7TfiF+OvVQAjbboIV9eW2keDVzp2IkXuOyp0mgwuxqeTALW6R9zoTekDfLkP7R8tP6yBmku+FEEid+ZCjHZYX+saqHou4dZqJdm2pP42GQFUxH/rBoY5NS+EFs/+xOnHIqnaUBTuWhOCiOJD4YJQtFnKNzuQq5cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u44pYk4e2NMntgAZhoSYtMvcOEouwh4glC4q2Vk2w9g=;
 b=MF7YgUh/ZDkvhGQQ3T4/OQRh6WhglUTUuGW07FHx4m+ibpH8DPHqreSax6UuqB32zChGmpZl5ni270Ael8WiNhWgrV03VrBnyARpEzkn9qez0TO6xvfkzB/IRmTw9p5k8D3XLMaQE8idKxz7zJaUeQtLgTEf4zcSeCosh3MV/pXS3TPEzBRa9PYy7FJIMCOQg2ac3VD30zT3o9vmi+GqBXiI04UW7d3D5yKt8WUM9QEcgSFUjhkLEEvwtQup6vg6kfbOr37nOw0hOtXVI4+JH8hlk4Uq1sC9MuRpfCmXA0S0MqlLNh4jV+9XlHnCqUMqWgUVdgVp+aq1GKVgLH98Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u44pYk4e2NMntgAZhoSYtMvcOEouwh4glC4q2Vk2w9g=;
 b=ITiRzcAPTCZH0v9zKYZTKyTCM7/Dvgtwp7q13/c19BNAsKx3Tow21nwllTqBdZr/zKteR50yFUUbTMJ1sIkwFaWRr9Dk1F5JT7sWvcd1j3VvhK2vP/gALrvfvuFvuXyY31s0/ss7gFI6EI8dccezjBX7LoQI4AVVanVKBVdXvusnO6WYsf4Jzfo1Zb+S0S6OTWphSld7BEdt92LoiHBuXO7oJ1be4QicSPRr0WDYUEGbLDn+FoEzZh7M8/tGm7oLCH4sKsGlPCw/qeTRE/Qk0amZ4wEa1aYckUxh6Dh0zGhUcEJKddYUe9Zso2IELo82T2AyZ6z/e9IdHEDY5pseCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from GV1P189MB2954.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:263::18)
 by AS4P189MB1941.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:4b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 12:02:28 +0000
Received: from GV1P189MB2954.EURP189.PROD.OUTLOOK.COM
 ([fe80::a7e4:7d5b:ab4a:4b96]) by GV1P189MB2954.EURP189.PROD.OUTLOOK.COM
 ([fe80::a7e4:7d5b:ab4a:4b96%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 12:02:27 +0000
From: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Subject: [PATCH v5] bitbake-setup: use bb.fetch for buildtools installer download
Date: Tue, 30 Jun 2026 14:02:21 +0200
Message-ID: <20260630120221.1560-1-jaipaul.cheernam@est.tech>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260615121856.96250-1-jaipaul.cheernam@est.tech>
References: <20260615121856.96250-1-jaipaul.cheernam@est.tech>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DU2PR04CA0200.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::25) To GV1P189MB2954.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:150:263::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1P189MB2954:EE_|AS4P189MB1941:EE_
X-MS-Office365-Filtering-Correlation-Id: 99615584-9ca9-482f-8faf-08ded69f7493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|3023799007|6133799003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: 
	5sns9856CpMIxWOsC7b+j7PpBc1ypReVzpupmOQ1iWBNqTuESpY8kInibaLV4DPe01n9f6MBod1T6bJpBNGVWxaE5rSaorh75flOEr/t12Ef9Twi8uhVaFDDEbL4QXZnUBdeNmVaD/NGT0QksTJQL/9CFvpA9mWIbHoLjKBk0vJx7N8lN84/ziF0RsKCbaTmn10WwnZMMa/A6sM5EdEPrbR6qn4QB1hcFqnubmoLd2/o74sV5bBxcAJX0zHjZ5Nhfa4fBDHBzd4Gq0pEI2X1q/nOyYatqBPp0hKR6UAy71DDmOdVPAeqWRyqJgwIdQ3oXMEBlD77DnIwlBHrsBXZ+QXeFVhqSKwlMUQLoN6aOLRfcU8a3utmepQovdvREOoAUsgBqrAHDaIBbHgIFjVPbD4XtXt96eLj3gAzPDZ/YOvlNeAJL3X6hv0ZvpaxrOjvZB9rnbMaSbcaQCtYFHNQAAn3YHC76JPiaWFYr7TgJcmTaQmqcCMkrkoJG4AokuTN1OT9J1IGeTPFvkF7bTM4ajXaII/aIizHec70lYViC800YKn8cViyIaYrryufpgitqE7pCnLX4uJ5Ei6jRg1Eb5+4o5LFpZnx8DKljmAqHdEiOrwLcINUILl8nv1Ke85RlHvSqXlP8La22GCbtrFf5B+yCQltRh9F6OeKXuJFD4g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB2954.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(3023799007)(6133799003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3upmbCtRiuFKAnVddfljIi3XUGSwhm+Hlno42Y8lOiXKBCVbunhoEWIx9Ge9?=
 =?us-ascii?Q?4+u9w8GrEbUvBO6t5b1Y3Y0lnahwNtsoH4eLVr0ZiEAggHRNjsJYRAAd+6yC?=
 =?us-ascii?Q?lVpDUevIWbTSL/DKomm/TZUSgcbK1NG7UXyahADMzagmbycv2cKZmaZSl4FF?=
 =?us-ascii?Q?zi3o/af6yVR+pmt3Sw3H3m+OvxdvCzZwlu3vQ1w80gNe6UiqesFlIYNqHJOq?=
 =?us-ascii?Q?PqCQPH2oW8DWjR4gDKZzGw7yWRO+JqFyLrIFLJLFdKyzmJKa7qdyAXPb5Q3E?=
 =?us-ascii?Q?oFLEtJrd6riC1bWh/pWskw+YY+V8LSbojuT83GKxbAqofeMgH0yEoUn81+Ud?=
 =?us-ascii?Q?OblIfO1rsQVH8rGntCk3shp8LKYmFHv377CJSJgnl/Jx/RESdjhcxpIx6eAH?=
 =?us-ascii?Q?Qsivda/q2CgWBwbh+6bTt1FETNe5gW5z5id6jayjuFxirmx/jg+rx1tAw8l2?=
 =?us-ascii?Q?McuxqUcIDZKDttGvDEFrvWhHxK/hH2gXWftNPNqNsEAg3iuPeCdR1TW2Dmlo?=
 =?us-ascii?Q?PZAS4CJ8YSnQxOVvA5ST8msaL7Ak8aIYUMyAW1wO8/4FrJRY94b1ruIHRl65?=
 =?us-ascii?Q?paq93YJ0y/jxX2kW1M8eZd1ShQ63HvCQzInDGF3v+tVVt/kisOnyEFag1C9F?=
 =?us-ascii?Q?uthi52XrxMOQ93If8Lt6BkrCd2B/0BW1+BqrePDRM74ixpE8RH+/rJ5o+gbL?=
 =?us-ascii?Q?frw27uHqukuW2+ji5dMJmz2PHShYt7qEKa0argKnhtQsPIicngXPx2pv8Ehk?=
 =?us-ascii?Q?c+zL7AoIaPRUMAEI9bLsG/zDq399QRG/Q5EEIq/wgGQrR1DKGDbutc7GN2Gh?=
 =?us-ascii?Q?lo7/xbXsgYuRqHIGm4EdxZvCBuNQ9kU8PFTzxrR32yeL1KNEpbM2cR6ID8cs?=
 =?us-ascii?Q?0VYAlw9i0QsuRegQEEIv7rPecmaU0aIi1jSwXAAKbp2AkbY0//IJVD2SPkWn?=
 =?us-ascii?Q?FIBUnp0uBrkoIsoXDlkLvGmopAQxevowuWUoqkvc3tCC+HnlqxppK/qu+cxp?=
 =?us-ascii?Q?Mwc4875JSnvIdr/8afYw5MAHIbWJkBAZRv7KhoMJ6Tfm0+GJKiDTsAz7aYQb?=
 =?us-ascii?Q?FqbE4tuv4hEqQFWIX2gqAimIIx6cj/8WU8KoIzo8PK/nDk1fpvSbjbM1YohS?=
 =?us-ascii?Q?5Wdzb0lfZ8bZhvkBITjO1823gDQIMqia4ULyMop+yfziiIce1SvWoKLuHG6H?=
 =?us-ascii?Q?xcSYbQqsk1O5zuWSQ0xcU7cTa9n+K3UJiDA970KSN2hK/A/YdTEiLg1w+qrs?=
 =?us-ascii?Q?NRlMjOcUpCgzTVaApiiKi8fMSdav0d0xeRjza2DKuopaTFZ3S9a/uyIl8DWd?=
 =?us-ascii?Q?orZXdLIoHccbI0oemE0aQSQpkcXSlJzabXVGEMTogiStKSz1tnKJ2DJ/Z4rO?=
 =?us-ascii?Q?SnlbDqKM4jmcINelvHumrxs2idfHrVnV6w373q8y0sCaPiHVGGZr3dFAi3QX?=
 =?us-ascii?Q?K4aUilsRWtSjb4S++uB08/FbJCWH1qVGq8FIjN9CwQGOPK8ZNqF3UPJVxfpN?=
 =?us-ascii?Q?h/oOlxEiwiKPeRDIVcO18vkCtHt3WdzHtAUenL9Po8SU3ByqL8d8nfiGO40e?=
 =?us-ascii?Q?I/XZ0HI7Eek0/QG/ZbMJD2Xy9ZOJ2+Lks6lXKKfLQXqi+AjNQN+40A38LKWs?=
 =?us-ascii?Q?hXEasJTBfZCDc25bIXj0nlGtET4LYgvVQxNlD/5CJhtRc+/qTixApJ5KxVNo?=
 =?us-ascii?Q?WnjeSIsGSGkAwO94xliuSemzQVtTD9BwqKMvnwjMyxZInJDQrZ5LS1Xi1451?=
 =?us-ascii?Q?vXIXiyk9Ww=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 99615584-9ca9-482f-8faf-08ded69f7493
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB2954.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 12:02:27.8636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WeXNbzdYWKRPMJhiPpKWoqGk6OlttQIcO6zGDmhsrAer4yRxshK1+ItHqUyhUzmNK94yiYk4esc9ynHhOnKmVROmOKJF9X2lYosy19m8r2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P189MB1941
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Jun 2026 12:02:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19810

When url and sha256sum are configured in the selected configuration,
download the buildtools installer via bb.fetch with checksum
enforcement. The file is unpacked to the standard buildtools download
location and passed to install-buildtools via --local-file.

If no config is present or --default is passed, fall back to
calling install-buildtools directly with its built-in defaults.

CLI overrides available via --url and --sha256.

Depends: [oe-core] install-buildtools: add --local-file option
AI-Generated: Kiro with Claude Opus 4.6
Signed-off-by: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
---

Changes since v4:
- Rebased on latest master
- Deduplicate buildtools_download_dir definition

Changes since v3:
- install-buildtools config is per-configuration only (no top-level)
- Use buildtools_download_dir for unpack (consistent with default path)
- Updated schema, docs, and tests to match

Changes since v2:
- Added --default to bypass config and use script defaults
- Use fetcher.unpack() instead of reading from DL_DIR directly
- Removed explicit sha256 verification (fetcher handles it for https)

Changes since v1:
- Use bb.fetch with mandatory sha256sum when configured
- Fall back to install-buildtools defaults when no config present
- Combined url+filename into single url field
- Removed --sdk-name, --filename, --no-check/--check
- Added --url and --sha256 CLI overrides
- Updated schema, docs, and tests
 bin/bitbake-setup                             | 88 ++++++++++++++++++-
 .../bitbake-user-manual-environment-setup.rst | 24 +++++
 lib/bb/tests/setup.py                         | 77 +++++++++++++++-
 setup-schema/bitbake-setup.schema.json        | 23 ++++-
 4 files changed, 203 insertions(+), 9 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 97ea08d11..2a0967b19 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -1053,10 +1053,87 @@ def install_buildtools(top_dir, settings, args, d):
             return
         shutil.rmtree(buildtools_install_dir)
=20
-    install_buildtools =3D os.path.join(args.setup_dir, 'layers/oe-scripts=
/install-buildtools')
-    buildtools_download_dir =3D add_unique_timestamp_to_path(os.path.join(=
args.setup_dir, 'buildtools-downloads/buildtools'))
-    logger.plain("Buildtools archive is downloaded into {} and its content=
 installed into {}".format(buildtools_download_dir, buildtools_install_dir)=
)
-    subprocess.check_call("{} -d {} --downloads-directory {}".format(insta=
ll_buildtools, buildtools_install_dir, buildtools_download_dir), shell=3DTr=
ue)
+    install_buildtools_script =3D os.path.join(args.setup_dir, 'layers/oe-=
scripts/install-buildtools')
+
+    buildtools_config =3D {}
+    upstream_config_path =3D os.path.join(args.setup_dir, 'config', 'confi=
g-upstream.json')
+    try:
+        with open(upstream_config_path) as f:
+            upstream_config =3D json.load(f)
+        buildtools_config =3D upstream_config.get('bitbake-config', {}).ge=
t('install-buildtools', {})
+    except FileNotFoundError:
+        pass
+    except json.JSONDecodeError as e:
+        logger.error("Failed to parse %s: %s" % (upstream_config_path, e))
+        sys.exit(1)
+
+    url =3D args.url if args.url is not None else buildtools_config.get('u=
rl')
+    sha256 =3D args.sha256 if args.sha256 is not None else buildtools_conf=
ig.get('sha256sum')
+
+    buildtools_download_dir =3D add_unique_timestamp_to_path(
+        os.path.join(args.setup_dir, 'buildtools-downloads/buildtools'))
+
+    if args.default or (not url and not sha256):
+        # No config or --default: fall back to install-buildtools defaults
+        logger.plain("Using install-buildtools script defaults")
+        subprocess.check_call([install_buildtools_script,
+                               '-d', buildtools_install_dir,
+                               '--downloads-directory', buildtools_downloa=
d_dir])
+        return
+
+    if not url:
+        logger.error("No buildtools URL configured. "
+                     "Set 'url' in the install-buildtools config section o=
r pass --url.")
+        sys.exit(1)
+
+    if not sha256:
+        logger.error("No sha256sum configured for buildtools installer. "
+                     "Add 'sha256sum' to the install-buildtools config sec=
tion or pass --sha256.\n"
+                     "You can obtain it with: sha256sum <installer-file>")
+        sys.exit(1)
+
+    # Download using bb.fetch with sha256 validation
+    src_uri =3D "{};sha256sum=3D{}".format(url, sha256)
+
+    logger.plain("Fetching buildtools installer using bitbake fetcher")
+    logger.plain("    {}".format(url))
+
+    fetcher =3D bb.fetch.Fetch([src_uri], d)
+    try:
+        fetcher.download()
+    except bb.fetch2.ChecksumError as e:
+        logger.error("Checksum mismatch for buildtools installer. "
+                     "Verify the URL and downloaded file.\n%s" % str(e))
+        sys.exit(1)
+    except bb.fetch2.FetchError as e:
+        logger.error("Failed to download buildtools installer: %s" % str(e=
))
+        sys.exit(1)
+
+    # Unpack into the standard buildtools download location
+    os.makedirs(buildtools_download_dir, exist_ok=3DTrue)
+    fetcher.unpack(buildtools_download_dir)
+
+    filename =3D os.path.basename(url.rstrip('/'))
+    matches =3D glob.glob(os.path.join(buildtools_download_dir, '**', file=
name), recursive=3DTrue)
+    if not matches:
+        logger.error("Unpacked file not found: %s" % filename)
+        sys.exit(1)
+    local_path =3D matches[0]
+
+    logger.plain("Buildtools installer will be installed into {}".format(
+        buildtools_install_dir))
+
+    cmd =3D [
+        install_buildtools_script,
+        '--local-file', local_path,
+        '-d', buildtools_install_dir,
+    ]
+
+    try:
+        subprocess.check_call(cmd)
+    except subprocess.CalledProcessError as e:
+        logger.error("install-buildtools failed with exit code %d" % e.ret=
urncode)
+        sys.exit(1)
=20
 def create_siteconf(top_dir, non_interactive, settings):
     siteconfpath =3D os.path.join(top_dir, 'site.conf')
@@ -1286,6 +1363,9 @@ def main():
     parser_install_buildtools =3D subparsers.add_parser('install-buildtool=
s', help=3D'Install buildtools which can help fulfil missing or incorrect d=
ependencies on the host machine')
     add_setup_dir_arg(parser_install_buildtools)
     parser_install_buildtools.add_argument('--force', action=3D'store_true=
', help=3D'Force a reinstall of buildtools over the previous installation.'=
)
+    parser_install_buildtools.add_argument('--default', action=3D'store_tr=
ue', help=3D'Use install-buildtools script defaults, ignoring any config.')
+    parser_install_buildtools.add_argument('--url', help=3D'Full URL to th=
e buildtools SDK installer. Overrides config value.')
+    parser_install_buildtools.add_argument('--sha256', help=3D'SHA256 chec=
ksum of the buildtools installer. Overrides config value.')
     parser_install_buildtools.set_defaults(func=3Dinstall_buildtools)
=20
     parser_settings_arg_global =3D argparse.ArgumentParser(add_help=3DFals=
e)
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.=
rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index aa546c30b..e1701555e 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -660,6 +660,30 @@ In addition, the command can take the following argume=
nts:
 -  ``--setup-dir``: path to the :term:`Setup` to check to status for. Not
    required if :term:`BBPATH` is already configured.
=20
+-  ``--url``: full URL to the buildtools SDK installer. Overrides the valu=
e
+   from the configuration file.
+
+-  ``--sha256``: SHA256 checksum of the buildtools installer. Overrides th=
e
+   value from the configuration file.
+
+When ``url`` and ``sha256sum`` are set in the :term:`Configuration File`,
+the installer is downloaded via ``bb.fetch`` (cached in ``DL_DIR``) and it=
s
+checksum is enforced. If no configuration is present, the script falls bac=
k
+to its built-in defaults::
+
+   "bitbake-setup": {
+       "configurations": [
+           {
+               "name": "my-config",
+               "install-buildtools": {
+                   "url": "https://example.com/buildtools/x86_64-buildtool=
s-extended-nativesdk-standalone-5.0.sh",
+                   "sha256sum": "af76648b..."
+               },
+               ...
+           }
+       ]
+   }
+
 .. _ref-bbsetup-command-settings:
=20
 ``bitbake-setup settings``
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 5592e8196..8ca64cb50 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -61,16 +61,31 @@ import getopt
 import sys
 import os
=20
-opts, args =3D getopt.getopt(sys.argv[1:], "d:", ["downloads-directory=3D"=
])
+opts, args =3D getopt.getopt(sys.argv[1:], "d:", ["downloads-directory=3D"=
, "local-file=3D"])
+installdir =3D None
+local_file =3D None
 for option, value in opts:
     if option =3D=3D '-d':
         installdir =3D value
+    elif option =3D=3D '--local-file':
+        local_file =3D value
+        print("install-buildtools local-file=3D{}".format(value))
=20
 print("Buildtools installed into {}".format(installdir))
-os.makedirs(installdir)
+os.makedirs(installdir, exist_ok=3DTrue)
 """
         self.add_file_to_testrepo('scripts/install-buildtools', installbui=
ldtools, script=3DTrue)
=20
+        # Dummy buildtools installer for bb.fetch testing
+        self.buildtools_dir =3D os.path.join(self.tempdir, "buildtools-dl"=
)
+        os.makedirs(self.buildtools_dir)
+        self.buildtools_filename =3D "x86_64-buildtools-nativesdk-standalo=
ne-test.sh"
+        buildtools_filepath =3D os.path.join(self.buildtools_dir, self.bui=
ldtools_filename)
+        with open(buildtools_filepath, 'w') as f:
+            f.write("#!/bin/sh\necho dummy\n")
+        with open(buildtools_filepath, 'rb') as f:
+            self.buildtools_sha256 =3D hashlib.sha256(f.read()).hexdigest(=
)
+
         bitbakeconfigbuild =3D """#!/usr/bin/env python3
 import os
 import sys
@@ -108,7 +123,11 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 "name": "gadget",
                 "description": "Gadget configuration",
                 "oe-template": "test-configuration-gadget",
-                "oe-fragments": ["test-fragment-1"]
+                "oe-fragments": ["test-fragment-1"],
+                "install-buildtools": {
+                    "url": "file://%s/%s",
+                    "sha256sum": "%s"
+                }
             },
             {
                 "name": "gizmo",
@@ -176,7 +195,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
     },
     "version": "1.0"
 }
-""" % (sources)
+""" % (sources, self.buildtools_dir, self.buildtools_filename, self.buildt=
ools_sha256)
         os.makedirs(os.path.join(self.registrypath, os.path.dirname(name))=
, exist_ok=3DTrue)
         with open(os.path.join(self.registrypath, name), 'w') as f:
             f.write(config)
@@ -644,6 +663,56 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
     def _count_layer_backups(self, layers_path):
         return len([f for f in os.listdir(layers_path) if 'backup' in f])
=20
+    def test_install_buildtools_fetch(self):
+        """Test that install-buildtools uses bb.fetch with sha256 and pass=
es --local-file"""
+        import shutil
+
+        if 'BBPATH' in os.environ:
+            del os.environ['BBPATH']
+        os.chdir(self.tempdir)
+
+        registry_uri =3D "git://{};protocol=3Dfile;branch=3Dmaster;rev=3Dm=
aster".format(
+            self.registrypath)
+        self.runbbsetup(["settings", "set", "default", "registry", registr=
y_uri])
+        self.add_file_to_testrepo('test-file', 'initial\n')
+        self.add_json_config_to_registry('test-config-bt.conf.json', 'mast=
er', 'master')
+        self.runbbsetup(["init", "--non-interactive", "test-config-bt", "g=
adget"])
+        setuppath =3D self.get_setup_path('test-config-bt', 'gadget')
+
+        # test config-driven install (url + sha256sum from config)
+        out =3D self.runbbsetup(["install-buildtools", "--setup-dir", setu=
ppath])
+        self.assertIn("Buildtools installed into", out[0])
+        self.assertIn("install-buildtools local-file=3D", out[0])
+        self.assertTrue(os.path.exists(os.path.join(setuppath, 'buildtools=
')))
+
+        # test CLI overrides (use a different file to prove precedence)
+        shutil.rmtree(os.path.join(setuppath, 'buildtools'))
+        alt_filename =3D "alt-buildtools-test.sh"
+        alt_filepath =3D os.path.join(self.buildtools_dir, alt_filename)
+        with open(alt_filepath, 'w') as f:
+            f.write("#!/bin/sh\necho alt\n")
+        with open(alt_filepath, 'rb') as f:
+            alt_sha256 =3D hashlib.sha256(f.read()).hexdigest()
+        alt_url =3D "file://{}/{}".format(self.buildtools_dir, alt_filenam=
e)
+        out =3D self.runbbsetup(["install-buildtools", "--setup-dir", setu=
ppath,
+                               "--url", alt_url,
+                               "--sha256", alt_sha256])
+        self.assertIn("Buildtools installed into", out[0])
+        self.assertIn("install-buildtools local-file=3D", out[0])
+        self.assertIn(alt_filename, out[0])
+
+        # test missing sha256sum is a hard error
+        shutil.rmtree(os.path.join(setuppath, 'buildtools'), ignore_errors=
=3DTrue)
+        with open(os.path.join(setuppath, 'config', 'config-upstream.json'=
)) as f:
+            config_upstream =3D json.load(f)
+        config_upstream['bitbake-config']['install-buildtools'] =3D {
+            'url': 'file://{}/{}'.format(self.buildtools_dir, self.buildto=
ols_filename)
+        }
+        with open(os.path.join(setuppath, 'config', 'config-upstream.json'=
), 'w') as f:
+            json.dump(config_upstream, f)
+        with self.assertRaises(bb.process.ExecutionError):
+            self.runbbsetup(["install-buildtools", "--setup-dir", setuppat=
h, "--force"])
+
     def test_update_rebase_conflicts_strategy(self):
         """Test the --rebase-conflicts-strategy option for the update comm=
and.
=20
diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-=
setup.schema.json
index 177a8dc8c..bb10a9255 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -170,7 +170,28 @@
                             },
                             "setup-dir-name": {
                                 "type": "string",
-                                "description": "A suggestion for the setup=
 directory name, $-prefixed keys from oe-fragments-one-of will be substitut=
ed with user selections"
+                                "description": "A suggestion for the setup=
 directory name, $-prefixed keys from oe-fragments-one-of will be substitut=
ed with user selections."
+                            },
+                            "install-buildtools": {
+                                "type": "object",
+                                "description": "Settings for downloading b=
uildtools via bb.fetch",
+                                "properties": {
+                                    "url": {
+                                        "type": "string",
+                                        "minLength": 1,
+                                        "description": "Full URL to the bu=
ildtools SDK installer."
+                                    },
+                                    "sha256sum": {
+                                        "type": "string",
+                                        "minLength": 1,
+                                        "description": "SHA256 checksum of=
 the buildtools installer."
+                                    }
+                                },
+                                "required": [
+                                    "url",
+                                    "sha256sum"
+                                ],
+                                "additionalProperties": false
                             }
                         },
                         "additionalProperties": false
--=20
2.34.1


