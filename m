Return-Path: <jaipaul.cheernam@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36C8C43458
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 20:34:20 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6551.1782765257289641978
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 29 Jun 2026 13:34:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=KhlLF89Q;
 spf=pass (domain: est.tech, ip: 40.107.130.50, mailfrom: jaipaul.cheernam@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOL/jW0gj4jvDYcv3IGpTDzkWWvLAEXe09kf6Mhcs8pfrOIFjw6RbmDSIBElsbBcbn/GjjEVWWvBqY47ipLttThVdEK/cRnPcBr5m1x55xjuAgFKS4VfcyCNgA1rtwrDQsx+4NoPiiuFE6/uw3VijZizEC+W6XexfdqECRf2/1+vP5SE09LAXniKEySjADfVOzZTYRMT6wBlRO4dslNPe/Cr2ZHyvFxPFiz83GfQkk0RifjUzFMuVKQfX2xSNnsa5ECxczSY9EX3Bt081TJ0zXI3iZTpyulm6MIL+FguMGgTrafKGLk9raqDzYiXLggxm+q/ty7zLE0vhoBQWkeqyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uuyNKvKsejWPaPcl0AKsIecWmPsN4viAOp/ChxD9sU=;
 b=Sj3PUygBJ7S2o6aLwceCN6DFAUtXSzSiMZvGWGl2x5DXoRWXWDyTb+BKGR4+d64F6AMT0q00wU2HoX+mgjYA/5IXgGffro7GKT63NsS1EYLDgcaXxZpOeHqUb/pzt18M/6ogRU+Zv+wFWb/qhUzmLIWQe41xmldosnV7yV65JKHpEDTgQ3t2jcj9Zk47U5qxKEOwtQx01p/w1mtJKykVVraqgRBW/WER8RgKaxemD3/Ne55FPQK+6ESxDKKBNhJ6stFv8cPhf1MO4DGHDiIn1yza/LFPuC1Kf0L3WQRW7LTfNEoC9cUGQCegL/Z45mmZr2zLxb4hmPRvdKr4lkolFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uuyNKvKsejWPaPcl0AKsIecWmPsN4viAOp/ChxD9sU=;
 b=KhlLF89QMNei6uSuf+mEOzDx0KbAtFwxjomeAsk9HuHqsIhHkisouZZ4J9NR0sdbfyxUvNmQV1F70jPkghzN5/qotFLHdhr6wElEr6u9YoYU44af68NbICwh0FfBUSXWupktJf80jfpZdjZ0MzrK5RWjwzj/JGmEbcSD4WM0uAGA3HyG9KlMFR/LdNcJ8zgyu3tVEbM+hCWFJMhE8lYIQ44nnqzei64qUOfo0DR70/xMcEMO1M827m01L3qtz0NXv30xOx7r1TtM3J3b1TIT3apjp+KnNwl1z7GgW9XqqRpQdzeIz8xedAv+ak2+s/LmoX/k61+6N1huvyH6dUqZIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM (2603:10a6:18:3::ad4)
 by PA4P189MB1264.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 20:34:12 +0000
Received: from DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 ([fe80::18b0:e114:b839:ca49]) by DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 ([fe80::18b0:e114:b839:ca49%8]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 20:34:12 +0000
From: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Subject: [PATCH v4] bitbake-setup: use bb.fetch for buildtools installer download
Date: Mon, 29 Jun 2026 22:34:08 +0200
Message-ID: <20260629203408.52210-1-jaipaul.cheernam@est.tech>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260615121856.96250-1-jaipaul.cheernam@est.tech>
References: <20260615121856.96250-1-jaipaul.cheernam@est.tech>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0191.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::19) To DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:18:3::ad4)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PPF66507B2D7:EE_|PA4P189MB1264:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ce1ab21-9aea-43ae-9b14-08ded61dc7bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|22082099003|11063799006|5023799004|18002099003|3023799007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	FXkjjNpv9SEpzO6CsiQR+fYhxQ8day4XawOWHv1+po9B4svAcNco12jUpJsCEwbAyA2nI52bgtZhoWQpKRu88zknCqh2SPvBo6GnyKDDnfMPeOwGX/bxs9f0dPfX3S8yU1/SYaKbxHmhW61T1Wq1VwznbN8RG4VcvLXY0k3V1In/Am1Pr0dS4q0HoicmofqROkrmcQYTofHJiaJjfCEZuy1uYA9ietn4vPDPndu4TpSRsVZBsDRX1IGW3/CemBJHWOzEWXXXzz6iBJ5UaDrflTB93VnrUkYdn6Ovu//ad8juhwPWesZWmXr47ko2DbXYzBkFcHwOZ7g9Rj2ilLmuqNSV/YZGmpMNmwOl79aKDu78/qXI/j/iuHuRH0I3ds2YM/H1uHpGsMYBtbyhDO4OodKxGp8ivwnIGKG2bxGq5DQqtrX8Y5xsL6CjulRW3WaEJq/D8v3LFSVeUupmDmvpQI5e2n8A2HdUGfyU7ocOzOclz8o3MKfoQs7NHOikGFkVfP+7uC4ZMJHW8e6PzM7r7Ey7wusWXCzmoM/kyMgh27L7o4FqV9VFFGAZrPBzBicRBZgnBI/63EntcnnIRFbQbqBM8Id0gSdZ/uc116zvf4DsqMyqOuTpI5L4Ic72ebenagpqowNME6S07arqt3nbmUWkcNlS6JN8it+7EzCsycA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(22082099003)(11063799006)(5023799004)(18002099003)(3023799007)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uXTENBuT0TI1EddOgplQ5XRl+HHs5x7F3SmlScffitu4UNbkYlWCLTEJF8Ks?=
 =?us-ascii?Q?XH8JXsPCCw23ZZK5s4h5pToFeOv1wvsjKpm94RpZ8NnbSepPkZuje2YGiIU5?=
 =?us-ascii?Q?6eTGBHPnOeuE2HZkaQV6zoCnEJ9fHCoJhb9u6nqqAH0crqR+VjYh0wdEuuDG?=
 =?us-ascii?Q?rRvvmbvmdiFjpYRNBwj3PzR8AxIc/7mXr6OdO1EJLc2KOskD/s/dtn8FDfpW?=
 =?us-ascii?Q?nJZ4H2IlgGVDkzOXvTnKEjO9KbsxQceouk61nAMvDXqaCMJejgU0NG+KPGnu?=
 =?us-ascii?Q?3oUqWbS64bKiRNMhPArowsOW/bhoanEw+OBpA+GlnwhV+sOC3eXCvXDHcxfq?=
 =?us-ascii?Q?VoqEmx/nHVxYYC0iRqfOduHivfUf5EwTKIXyikHeeWeXyl31zoGgBQTALuN7?=
 =?us-ascii?Q?29o7UdB9q8V5kjw94DJoHD53wSrnhkNLg1uZZCQd8VLiuUw+rpK8xeNkHoC0?=
 =?us-ascii?Q?S9EjKnFwsWqpI7yMI1wA+ekSCwQ/Zo7R9jtSxIFU6s6id9A/JmYiUiqcp2ZG?=
 =?us-ascii?Q?y8zycNWNBIhHl22QflAd6kObjQuv16h+Kk+OOYfS71HmMulGaTAifTPSVbic?=
 =?us-ascii?Q?DHuWp4H1xDEndy3MLKX4qGPTuTKaSTtozLyYdZ1pxMj8NnbRdhepylCTZcF9?=
 =?us-ascii?Q?dej4doC+tVVEIPOBxTQ+6yiuRm9eGrmx5xboLp8cLEH1vgcG+p/kQH+4paYH?=
 =?us-ascii?Q?Tys6WOrFu3pRhl/0APR/PbpjnfVolAEiLEG9bCHpE0kZPM0XhzmFH5/D2U1N?=
 =?us-ascii?Q?Uz3Crrv3N+/S3kWqIqW2n2MAlmWN/BBEM/QNHkBAHKkRLIkzEB/nuF6faKVe?=
 =?us-ascii?Q?n863SFTgdDwwqWJmxOb9IQL8pvjR0kkJKcNbsixq2012evaqBeDuPI72DIPt?=
 =?us-ascii?Q?q3sfsBd2jdv6CdwDFqGyCXjnNA5XRHS8XBCcmClDvXcXLLpGR3gguvbcGOP6?=
 =?us-ascii?Q?4GnGBuwyVH0gVvB933YW/XNfCscUFR57OglASTuGCIwYUfTl+yNbHeBiz8/O?=
 =?us-ascii?Q?xSfCgY7rqywgEKr4AbX8kDjFJvefKSuxj8lZyMG+DEEm547J9VZXHWHt9VeR?=
 =?us-ascii?Q?YvHI2S4LsFaBhKCzUexRw99dZaZebnok+PR5orBBBXFC8Q9Th6mlKvJpWg06?=
 =?us-ascii?Q?AzrJn/5TRLmfthSZE33xZEZG64UPZq6UjNO9P20r7QGyE/oJY2pnmeKJNTzN?=
 =?us-ascii?Q?XXRae8HAHlB13TMc0VJLZMF5S7Qkm0nW7TKI4KS/60/8s8YNLXyx9vwkSkUP?=
 =?us-ascii?Q?QrZ7rsjeyrRQuSl17qeymQEUMfjHwUDK+hGWrpKKRqklHubVlV2Pn02CFshC?=
 =?us-ascii?Q?zFsQHbF5ncVHwPsWIpyfID2WARws81vwFJvV+KT4eRPDji+JJIV3SG3q/a4P?=
 =?us-ascii?Q?R+O4J3x/pMeDdaDjfHCGetK2tI03E5ruD2Wk9PNp++4H/JKS5+Kb9BY3NEBB?=
 =?us-ascii?Q?DtWHFNarrPEI4qqRrDueokJM/J4Yb1dwJUAy/acL233OpyKMrNGgev5gRqoh?=
 =?us-ascii?Q?ZI3DUq+Ke2aqy8yRgrC+eRXpM2SRo40xgyr2DDoxk1k/KIxx1WGr1QAhK5b/?=
 =?us-ascii?Q?M/J01OOGDVXPDKcAlLqWv402q+QNtljHPqYNOomB1R0KBbs/aFTCiv5xwtmI?=
 =?us-ascii?Q?hPFXJUFdFryfzKHOX9TiTKONC0w0b741tL9Imjav1rDJE36yewNVrMq5M31B?=
 =?us-ascii?Q?itzg48SptNOKO27mThumhkWKiegQahFhlJWfT0vPpHkKxF0NVqQeclUnm/Ls?=
 =?us-ascii?Q?XUiaIH0TNWa+x2WfoGgOMg0OMVRgo5A=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ce1ab21-9aea-43ae-9b14-08ded61dc7bd
X-MS-Exchange-CrossTenant-AuthSource: DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 20:34:12.7932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLKDtsOnfq5WIPkWQsVvPt65ngD+siLuj30G2e6CPh0uMJAXtX1oz4n5hVNLeCNpmp6IyrQtuk3tpYOZEpNMp0c9lBKA+CZfr8Ij+FhUJak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P189MB1264
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 29 Jun 2026 20:34:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19808

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
 bin/bitbake-setup                             | 89 ++++++++++++++++++-
 .../bitbake-user-manual-environment-setup.rst | 24 +++++
 lib/bb/tests/setup.py                         | 77 +++++++++++++++-
 setup-schema/bitbake-setup.schema.json        | 21 +++++
 4 files changed, 203 insertions(+), 8 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 97ea08d11..9a3507c1e 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -1053,10 +1053,88 @@ def install_buildtools(top_dir, settings, args, d):
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
+    if args.default or (not url and not sha256):
+        # No config or --default: fall back to install-buildtools defaults
+        logger.plain("Using install-buildtools script defaults")
+        buildtools_download_dir =3D add_unique_timestamp_to_path(
+            os.path.join(args.setup_dir, 'buildtools-downloads/buildtools'=
))
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
+    buildtools_download_dir =3D add_unique_timestamp_to_path(
+        os.path.join(args.setup_dir, 'buildtools-downloads/buildtools'))
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
@@ -1286,6 +1364,9 @@ def main():
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
index 99f47f73d..797d45252 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -137,6 +137,27 @@
                             "setup-dir-name": {
                                 "type": "string",
                                 "description": "A suggestion for the setup=
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


