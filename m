Return-Path: <jaipaul.cheernam@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6607C43458
	for <webhook@archiver.kernel.org>; Fri, 26 Jun 2026 19:23:49 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.63])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.42453.1782501821684101710
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Jun 2026 12:23:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=iwLAMuQJ;
 spf=pass (domain: est.tech, ip: 52.101.72.63, mailfrom: jaipaul.cheernam@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p/F2f/7dzXkByNYdOvJ1FQP3Sxvmc/fCfk3r/iDUjriG2b2XtpuME2M5WMZsyAOAdwkFOivZH8yaJkgtFbWekBhnRUbpFyBJjfLTZTK6pMM1Vi83TtmfT24NTP3T10Ot9kOb/dSB4zfgM1rlgCxGt0mTAo03ugYOPQn+JSv6nhspyg9bJm5mI4LlngeR2VAr6pvnMeqGFNs3NEVMUyze7OitQz8V4nGZ6ATZjW3W28m2XwsRZQ7+zZgZYpuVitCjkHfGSZZ9+/XZB7vawj7zgGxhN7AZAmYgIJvPPJFOWE1MDpsf7wx722JBK41YErtuycg2yha8t4tUqiDHU7+vuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmHtLb7o4oT5TUWdajXCKB12E9dX82A1sPzhsM0rzyc=;
 b=mtyAhtAcjbX72RwfA5fItfEzDZ7cR9CkpTkPsJxvHvt23WNczZeK1KQAfJaiBUGGhbWYIhZzgkut+GjvT6p/1RJorA/0K3MQxw5FMuQufeojGGACMmVs3e5acB2T6wNZ51st9hfTBH1pOEJBAViSdh69hA4SmkYfzwy16UYxz++hygi1V8nKAwWiiEaArJzcIRlgsQNSu4VUENtE6cPujfffg1Y/PvyQqEXor8iSpWJwubMQW+32Yy0KOpFlEdYD+WNvr+ImCtVA/W3lQt8F94Rsax9Xpwg3tCglsgBzMsri4CcL3hWv+H/c8WXdRmTkD5y+qNL8X9P3IU5fp7wjPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmHtLb7o4oT5TUWdajXCKB12E9dX82A1sPzhsM0rzyc=;
 b=iwLAMuQJj9wlMqtymN6TfQScvBHeyrb5eUzVLTmsh2CFoKlvPxKpWiuK9qlP9EOxMXC1fgdU/LzJHjdb20tJhPco6pmEU2PBYG7fE7ORXG+0Pr2JQ4g8BRWa1qHzRqgFrO1AZnz8rilk/gx2AGNvupV64iQuzJFypKcZM/Lb194gk8dBv383MHxjbwhwF1l6pvqi1WX5Y7T6tvSQsujmb8XFnnfK3GZA+chgjUAzsR6AREAhTqbtOxLJ1rwhD52QN6stxlfs5ZaKYBGPjLW1tLqzK0f2gf/z8jCGDKxe+8jzZrz15kSDxTgHAA8SwrCR6RMkbAs6nz9cwayh6psUmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from GV1P189MB2954.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:263::18)
 by GVXP189MB1982.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:3e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 19:23:35 +0000
Received: from GV1P189MB2954.EURP189.PROD.OUTLOOK.COM
 ([fe80::a7e4:7d5b:ab4a:4b96]) by GV1P189MB2954.EURP189.PROD.OUTLOOK.COM
 ([fe80::a7e4:7d5b:ab4a:4b96%3]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 19:23:35 +0000
From: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Subject: [PATCH v3] bitbake-setup: use bb.fetch for buildtools installer download
Date: Fri, 26 Jun 2026 21:23:30 +0200
Message-ID: <20260626192330.50237-1-jaipaul.cheernam@est.tech>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260615121856.96250-1-jaipaul.cheernam@est.tech>
References: <20260615121856.96250-1-jaipaul.cheernam@est.tech>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0137.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::16) To GV1P189MB2954.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:150:263::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1P189MB2954:EE_|GVXP189MB1982:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b560b12-fde2-47e2-3055-08ded3b86a8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|11063799006|5023799004|56012099006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: 
	Q6Cx5TQF7zvIVR5IkMfCy4B/G9DjMhBCrLGL8nA2QTPrf35Fwce2UeIUmFyGrWLqZtarPkTwjHMdC9ZjFw0UthOFcicSySNFXPON8JAnfDc8CIVD5ErW0g1C9A46LulF0fy53Psh1S6JJHPsR9Ax8uuvs/poBuHTLQHvSZJMzdA3d4KlIILpyzRKhWo0hycZnW742XleaJ6bVUp1j4oteXEWZwHDf5jYch7E3PWITUXOt5ZxSP3cT+i+TUsZJNkdLX6Y8mu/VU4oDbfJM7iOaXvidxw7Fc7deRBiidxJUukQiqrwaVrY4ARINnqbK3IgDNy4qH81HXT1oPSa8oszFFczADR3ltCNbO/D+AVNj98g99l0SlU2V+hizeeA79lKjQBUWMOFfAYZiXIzAxCm7fkBt4Llovu3FsvtNwm6i0TCvixzUd+w7/QNIo3cX6ddhLdYXzZjB0OGEsnUWV3KLjgbgS/JJESmwI8ko0mgaPlD4x3G/oy0XER9UOxMl84LPOZIB03JH2MQ9wvzEoAMFAc9ngZzrPHnYHD2RMdJglFSPl3QG+UcnYYUOu2kbmI3V33GtrwvVSvs+zYqlKRyqcNwXmRAsd9PeFCjDq60KRC5pithKjmN4S1PisbOtVbUCLzvKlSuyqjQEgsL/853AYBkdQEKqL/pt5Kfz9+MiFM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P189MB2954.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OnNFrYxVifCp7ly2C+iQnZ8V97v2j6xhhnqPSL+V69MwJpDykPsmOS9Mh4HZ?=
 =?us-ascii?Q?fzAeOGZJ6wOtm/LslauYCkZZbK/1HdNMM+AYo6g3zdsLV3LxYBcjtOhdzk4V?=
 =?us-ascii?Q?+FJbNWcufCLsup4RA4EZr1B001ifom9k4rWooGggWMpKzUdZr3oNx3k90W91?=
 =?us-ascii?Q?eMo/parGv+qXRDv3ft3PatG8iTngyIOCSuPzTiBc1gcj4rmsjs6znsaLYPl9?=
 =?us-ascii?Q?SCpwMVUb2aQbEUVnLOSPQpunS2vM1aL9F9oz6FQ23d2Pewcv/uBIQ1yccfDh?=
 =?us-ascii?Q?QgHhRh4UGKJsGVRKe+RylCwcXjtyavewk/HCR+DwOrSSs7H2n3/7AobgbsQ4?=
 =?us-ascii?Q?nHzHGAKlXsKhqmpJK78kp0Bm1dujXNOB8ZmAw0ZkzccdQTevFUdVa/HgkVcl?=
 =?us-ascii?Q?uUIJqk6tYv94Pj2wFW14Z4uudTzIhJfuNNo0EK28Z2f48kDYAJBcqKH/00zo?=
 =?us-ascii?Q?IBYlxa1SnBLjaHpkUe4uKV1H4nNnwGLJCxHkqbFVRUjTJ3ugr49YribAHZEi?=
 =?us-ascii?Q?PbFVitfPUWxgu4085g0szD9+WACmsUaIqHei16WZ31o14rGol5l6QtqH9tHB?=
 =?us-ascii?Q?8tDBbhu05XIhYSF05eA3HWPVN8FXZsbJMGhZ3q9YRgeOBVzLxfBwLdJD5/6e?=
 =?us-ascii?Q?0Tji2S9n/wB9DjNucTKDD5R1fX6PN9NvmhMcJ5rpB9NhgLeP+mTbI8z2tuJS?=
 =?us-ascii?Q?t0Z2tgEeJ4rhnZfojILIDyCq9PysG/4NFW+krnSMeilETeLM4POsxsB5a+xt?=
 =?us-ascii?Q?PzLDu3D4NLpuLun2Rf4ugMf9zhMLplQoAwlrNJNp8N/1eJ48IQvGBI1HTntQ?=
 =?us-ascii?Q?s2Tmalqw3r436QcHBP1Mz8bNgGq6kffQf4e+3tyFqyDFptssPxXlIlGURfxR?=
 =?us-ascii?Q?uHs6jLOciRFjw32uWmUc+8jTse50K0zKQFtSP3nOT6gjeaEglLIcsagxpWts?=
 =?us-ascii?Q?lY7WtXQjcllKeSHK79ZIQnSOr1+rf/chSSB3TDZFPZvXIEIqbkDvVLVUfQdS?=
 =?us-ascii?Q?MNBbvRE485dOsobZwDJ6G+xCdI4yzg44B6qHFXIJmEMhmPywoNKUqQrz+IfP?=
 =?us-ascii?Q?wkgfArf3fF1iHjXZsqvhFw3BBaN7CD0jLc6CV3NgtKuBQ0x+rDnDKZZA64ZF?=
 =?us-ascii?Q?9gCuPkzEBgsktEsyKvLNTqByG3wb4njMiEtJQhy+n+JjJIVg5AiFQszewqIk?=
 =?us-ascii?Q?+h03l3T1ea2xFYlNSb0ZdqT4ZNpy9MWQ6ZJQlLDz1W+mZhdzVm2/yIhYuDl6?=
 =?us-ascii?Q?//v/KeicnHGIx+niD69T+K2uVicHzm4Tm6JSSOEBu9je4lRVRnA73fqoF6Ku?=
 =?us-ascii?Q?xT9KDjHxFYXJq8L/QtpyAWGJsFZ26+uGSOTpxhuT/8/hq0QpdMCwzvSDuwlS?=
 =?us-ascii?Q?D/NNlSX4O2W1k5/r10AEIg9/xHCJHDllMwYE6H5XeV2KQb7IyoitlMaGL9Pb?=
 =?us-ascii?Q?XlF1ZWe9/mg8GoGkeQkpUofC2d0JUeLkWPM4ealGuKihCcpVlJGd9NU3FWqI?=
 =?us-ascii?Q?NxmR9Uts2/lIjuopsDtRlJK2qpxLtIQgsWHPlvk2TsNis5TFCXxgh5TcTNei?=
 =?us-ascii?Q?6SUpAMxfac4vo3v1CiT+eLCBx471E5QaccqaxxUhujaLtBacVWkcE5HYTDTS?=
 =?us-ascii?Q?usGNrq1VxNY4VjpdXCBfIUWEHn/nzDbRmkdS4JLueIW1IBqVRCKl3+kxsrPS?=
 =?us-ascii?Q?4xUs0BtPOARRa1/6dfib22rsdJiekFLk9VkKx/QVhNlfZrB5NfNE1nEp3dEB?=
 =?us-ascii?Q?FbFqjNwAzPDL8rf8jcgBBoz56dTSC3c=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b560b12-fde2-47e2-3055-08ded3b86a8c
X-MS-Exchange-CrossTenant-AuthSource: GV1P189MB2954.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 19:23:34.9552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMKEkHMAVSd4nGFOmuU6TQkx6wLvnFmcj6M/BytQfngTf1OiiLohqVvUvcmVLreCrF1T3O9pjo/pK3aT5QcuxCcjwIjSyVtuI9agxj2/NVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP189MB1982
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Jun 2026 19:23:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19795

When url and sha256sum are configured, download the buildtools
installer via bb.fetch with checksum enforcement. The file is
unpacked to a working directory and passed to install-buildtools
via --local-file.

If no config is present or --default is passed, fall back to
calling install-buildtools directly with its built-in defaults.

CLI overrides available via --url and --sha256.

Depends: [oe-core] install-buildtools: add --local-file option
AI-Generated: Kiro with Claude Opus 4.6
Signed-off-by: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
---

Changes since v2:
- Added --default to bypass config and use script defaults
- Use fetcher.unpack() instead of reading from DL_DIR directly
- Removed explicit sha256 verification (fetcher handles it for https)
- Per-configuration install-buildtools config takes precedence over top-lev=
el

Changes since v1:
- Use bb.fetch with mandatory sha256sum when configured
- Fall back to install-buildtools defaults when no config present
- Combined url+filename into single url field
- Removed --sdk-name, --filename, --no-check/--check
- Added --url and --sha256 CLI overrides
- Updated schema, docs, and tests
 bin/bitbake-setup                             | 94 ++++++++++++++++++-
 .../bitbake-user-manual-environment-setup.rst | 19 ++++
 lib/bb/tests/setup.py                         | 77 ++++++++++++++-
 setup-schema/bitbake-setup.schema.json        | 21 +++++
 4 files changed, 203 insertions(+), 8 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 97ea08d11..aa084538d 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -1053,10 +1053,93 @@ def install_buildtools(top_dir, settings, args, d):
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
+        # Per-configuration takes precedence over top-level
+        buildtools_config =3D upstream_config.get('bitbake-config', {}).ge=
t('install-buildtools', {})
+        if not buildtools_config:
+            buildtools_config =3D upstream_config.get('data', {}).get(
+                'bitbake-setup', {}).get('install-buildtools', {})
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
+    # Unpack into a working directory (avoid touching DL_DIR directly)
+    import tempfile
+    unpack_base =3D os.path.join(args.setup_dir, 'buildtools-downloads')
+    os.makedirs(unpack_base, exist_ok=3DTrue)
+    unpackdir =3D tempfile.mkdtemp(dir=3Dunpack_base)
+    fetcher.unpack(unpackdir)
+
+    filename =3D os.path.basename(url.rstrip('/'))
+    matches =3D glob.glob(os.path.join(unpackdir, '**', filename), recursi=
ve=3DTrue)
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
@@ -1286,6 +1369,9 @@ def main():
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
index aa546c30b..e1bf0404d 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -660,6 +660,25 @@ In addition, the command can take the following argume=
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
+       "install-buildtools": {
+           "url": "https://example.com/buildtools/x86_64-buildtools-extend=
ed-nativesdk-standalone-5.0.sh",
+           "sha256sum": "af76648b..."
+       },
+       "configurations": [ ... ]
+   }
+
 .. _ref-bbsetup-command-settings:
=20
 ``bitbake-setup settings``
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 5592e8196..7f07369f6 100644
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
@@ -172,11 +187,15 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
                 "bb-layers-file-relative": ["layerE/meta-layer"],
                 "oe-fragments": ["test-fragment-2"]
             }
-        ]
+        ],
+        "install-buildtools": {
+            "url": "file://%s/%s",
+            "sha256sum": "%s"
+        }
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
+        config_upstream['data']['bitbake-setup']['install-buildtools'] =3D=
 {
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
index 99f47f73d..afd01d5de 100644
--- a/setup-schema/bitbake-setup.schema.json
+++ b/setup-schema/bitbake-setup.schema.json
@@ -141,6 +141,27 @@
                         },
                         "additionalProperties": false
                     }
+                },
+                "install-buildtools": {
+                    "type": "object",
+                    "description": "Settings for downloading buildtools vi=
a bb.fetch",
+                    "properties": {
+                        "url": {
+                            "type": "string",
+                            "minLength": 1,
+                            "description": "Full URL to the buildtools SDK=
 installer."
+                        },
+                        "sha256sum": {
+                            "type": "string",
+                            "minLength": 1,
+                            "description": "SHA256 checksum of the buildto=
ols installer."
+                        }
+                    },
+                    "required": [
+                        "url",
+                        "sha256sum"
+                    ],
+                    "additionalProperties": false
                 }
             },
             "additionalProperties": false
--=20
2.34.1


