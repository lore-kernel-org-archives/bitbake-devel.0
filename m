Return-Path: <jaipaul.cheernam@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44378C43458
	for <webhook@archiver.kernel.org>; Fri, 26 Jun 2026 13:43:37 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.38])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35375.1782481408749700814
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Jun 2026 06:43:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=ADdnebr/;
 spf=pass (domain: est.tech, ip: 52.101.84.38, mailfrom: jaipaul.cheernam@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bB8gyZBHT+Q0+RVPdUCoZaHabuBKhhAAWXIBkCC0C9XtSCb1phfq3ajhW/C1JEczONqHWtzBduRNFjWKBMEPYHlsZsf+0NJoj/EQG8kyIe/wN09sS5YsU7qvKF+zduTCttFUu9+FioqrnMT6xOvLprWAIv9ziOEN4W/ltbtO99quZvcLeM6VcSHCpw3q+lnhD5vYBjZMTZoiqrMkzCBQQpSo4NyCkvWChrhQQJ9uz5V9qvmZz2pU0xCCbaxY1ILhaKUDkzoJczPLMIOISRoPkCUDIFiHSdb7Vane2REpXfwLow8t9Cn184sTNl8FtCJTvsWxs6jVllLwFLSqkd2dTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XylolE61W8Q0cln8KSs6sEbsft0pBdEZE2RuNfeOAn0=;
 b=G8Ik9xI0yvJ+jBYmtYh92Hs48hwRVQK1lUz7lO3ii0doo8hg/HV0nKHFvcp2oPVLHVa7zQzMzlD0fS4A06Z+rVWulOOGDFAUSDcW6MMRAKgu19cPfh8G+S+6h7K9htTJWRhaecrOIm7ta9zzsQxpynm5Qm5sRf7b3AFMK0uMCjUc5DSblLTCL6JnQ8g1gFdKWRrVUoot+PGC/Xb2cnKJFW3IpZNWeAXSLJI04SUmNJRnLVb8cKeJM/7twzD4SKDWno8eeBPqA+HSRqEquMezzsydL3dT92GYkGYDH3pN7OAkxdVhO/3qk4yYqp4DqirIT8zAAocyL+mNlGIsNQE8zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XylolE61W8Q0cln8KSs6sEbsft0pBdEZE2RuNfeOAn0=;
 b=ADdnebr/PWKcvaZzmyrasI8/a/IvVDyRRXsxfwQXZTOReAiV0a0BOOhD4qLYDcuU0VcBFjYSwjaBziZG3rw6mWleSTuoCrZruPo2HlfrnUG8FJSt8JiPuk4Ni9Tm7/Pybmn6aPUchY7R+S7P2wN8bGfQpiLdUgDhi1Hx9zsUmC4TP5c1wFtamsDuZx2cM5+jB3L2lTX0u2ZocGKz7PDqyajnRlZRthRAjThJtWBi7cGolvBb/SAv6xm/XY+Z65gpvTgBmgMX0z/7mr/hQnvgI3+UNxKDfvwyC73dfrL/V7JOVVFrrmcSq3VPzpZp2fiol5o0d7VebjAcMqJ5wLvi7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM (2603:10a6:18:3::ad4)
 by DU0P189MB1916.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:34c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 13:43:24 +0000
Received: from DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 ([fe80::18b0:e114:b839:ca49]) by DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 ([fe80::18b0:e114:b839:ca49%8]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 13:43:24 +0000
From: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
To: bitbake-devel@lists.openembedded.org
CC: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
Subject: [PATCH v2] bitbake-setup: use bb.fetch for buildtools installer download
Date: Fri, 26 Jun 2026 15:43:20 +0200
Message-ID: <20260626134320.36433-1-jaipaul.cheernam@est.tech>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260615121856.96250-1-jaipaul.cheernam@est.tech>
References: <20260615121856.96250-1-jaipaul.cheernam@est.tech>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0456.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::11) To DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:18:3::ad4)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PPF66507B2D7:EE_|DU0P189MB1916:EE_
X-MS-Office365-Filtering-Correlation-Id: 709e7e97-d8a8-4b08-2b7f-08ded388e4ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|3023799007|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	udDuB4nJXlhnpPyX0gHnTpxN5xcaQOb25mYF2abaGBfCYLSyxnN9SV8G0sl+ECADrzZiuYmsZsirOK/Xhsuyt8+yOegfeO2jYRPEsRDjezOjqoM2P0jbHx2R0b8OHi5pkDhgzyE6ABdm2T0csmTsFem3sVs5hjUfDBKsWe5YIK16CuvnpXbJmvIKxHeKYQkwD1Z9s9EZVcQgUGiuEwKvqJlhvma7NIUxjXR1JCD43poh4cPhyR+AnfIfpRGeO+8y/XCxPN5fnygDqTyf8DSS4QPdZk9OGG4YYd/WwSlcWrccqvCJMiyBUf/asuRDYbIEbteGjChwTyVTu9ZpzBUtIp5StHTIRPCUKRsdnLyohGO9HAEvCdfJYAfl5g6aI9icD1QqMNIpMgISFovHAbx+s4qVzY4r5IY/WpQ6HD6ZIoY4S0lG00ouu0ZVcqAkUxCiDasxiE1mWIlQia/CyNb6TA5K0LixwrS/0o5HAeKoytymU07F0/gGdOONHKxMU1VYl4cLPBHEyNaI1/sXgOdd9VG+2fVw1qvhEqZnOsyaVH0M1dKRfvxF+rLWqHKGO3BXH+8+bG9tuIIlc7BUqbn17s119wuk6LBIfk7XrErzLzWMYVlbac8uiimX6eJ0LiJM4yTARKDitAIWIRf1tGD3E1Nzsxu31Psrwizr1zJekqs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(3023799007)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YZJ8oL7SAdIXLRfZs9OsrvqhPDfg0CV82kAEpLkBCdPY5CT+GcZHu8YNOq19?=
 =?us-ascii?Q?Q803K2I0iduwVqoTEGSalerc/p3gbjavR86Fb8n3bjEB4d4YbNF3vXavWh3b?=
 =?us-ascii?Q?S/6Uh2x5rC7yiSB6rLXEhjBv3Sd/r6t8KyEHFGo0uq8CgQka6cS0buWlcOeU?=
 =?us-ascii?Q?lCEQfeoPqm0lkJLGX6r/pwAc2WjmlMDTEcxl5r25zNerGzd7w/LMa/IaBRoF?=
 =?us-ascii?Q?aJLhK1isA3Ncrm/yMu5sZDQQ2BSnUwoVVdmnDskcxLeTgaD3M3xdKEGDwiEw?=
 =?us-ascii?Q?f5CbkbM8nulZZv5ZZllbRIqyS7gvexICbfwgqiofeC0DZfNoNlewZPrqfuB9?=
 =?us-ascii?Q?THTbc9qU979BUnYs1mwXoRRjLqWjpuqMc1be5E34TX0vzoDNnZpUxhrPcMBy?=
 =?us-ascii?Q?BDGF62G3cQaOBNI4qoyyuJqvFQapD31ajAaJYusofMD1dy04wtj9s3XHfrTL?=
 =?us-ascii?Q?aVsEWghZMkvefwzESwGdD1fXv4t1oKkhlinofPAJ/3MHrXhZS+B2u9nRxY0y?=
 =?us-ascii?Q?S0cpBqRZjl6GQp7rdNtwWafwajMPxUExJvrxTQMsIQi7LAiBIB6zsqEIwXHD?=
 =?us-ascii?Q?RI+S3XMPdmQYz9Nx/sWW6WYXx7AlGsficEKMIwqYs+/7yeFvav3gIlSLTvA/?=
 =?us-ascii?Q?0F1j7OTQLpNYxv2tURQhRUPnciL5P5Kw+P3qRbMk54NtpoGa+aBmUNUj3fLE?=
 =?us-ascii?Q?Co+KPvj5zqb73/T/nhcSU0EcIcgY8Kw/Cqu259CXcMrgsPODZMj3aPQieq2X?=
 =?us-ascii?Q?w3SsHGZSlMDdl+C/Q7KCCEhd3bkGlG39nswVeCVmRFZtiYhZxQ8vhsaUvPLq?=
 =?us-ascii?Q?S+YdoddRt4g3KFLBMMF3MzepRLMM/uAL5kKI/lZ2yMivHFr/R4OZee0Afbro?=
 =?us-ascii?Q?or1YA+gCjmwqMdZ0BZxoA81Za/hwwri+bHpX9pz0FTt87a+zlxjLr69Nj/Cm?=
 =?us-ascii?Q?cJS3JI9LGqgNaGhk75A/jtJhdhcj+innymg0f8fDqoku+TpguOYIagqAmsFZ?=
 =?us-ascii?Q?34tgp0OHI/r2JvlPbnPm7W2UtCjfdixyYna4hKH94Ur9oa8YjevmttH1N9kn?=
 =?us-ascii?Q?RGnYdl+LznypvS4c/UTeyn5yuFy7Wq+QL4fHUS2LrFMdmip39k4reG13oi4N?=
 =?us-ascii?Q?F1ergv9/Pic+dbsS7GKEGoRUEJxyIUE5tiugZc4A5ORLxltQdzg9j5o4rqyo?=
 =?us-ascii?Q?RSMODbbT5Qx7t/TiA+1E2w6t7iNWJkKilDf1FZ1gJrd2I0R4Tmfj8h0i82Wp?=
 =?us-ascii?Q?AvBGafQpNvgwHpypJ63WkOuhFDPEvBLwqTQtqh3sAOMQ9Kz72lAJxQwTY/DO?=
 =?us-ascii?Q?kFxna5Vb+Nv53LPSKG0WVgWmgB3k7RpX+AfLjaA5DCfJ3QkbF88dd68vgGJE?=
 =?us-ascii?Q?+HtNyz0hii9P9XlE8CH+vuemGclJS2KyATvnOOOfzCNTpprzjmC1eKi6UYuy?=
 =?us-ascii?Q?EiFsJxkQ87EpaA+je8LSl/eMwLsdngnoDC9Q3p1tbESSNFmzoGvSqG2jwMo0?=
 =?us-ascii?Q?OfdZ6zeSdYesCjP90eqLYBMWM40Nflr+3jP6Z+S8C36nTylnCS4U2ob0RLXQ?=
 =?us-ascii?Q?j+guHfNNAiuSf9NxqQ3KAvCgtUWjy0qvzNDJgE2olZj4DrW21LtOFjugzLba?=
 =?us-ascii?Q?zaypZN3EbGOQJu8amxkXt/Aq/WU7GL+I3koGcvRkfiF3PCR+8cSy0HqmFM3/?=
 =?us-ascii?Q?R5z8Y4u8fmjj4dPhugxF7junDc0XWytonmLywmiizs1NsecYY2vCbe8gJ1As?=
 =?us-ascii?Q?hkDsj+2rr1oE9U3m947IGteQKvsuP34=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 709e7e97-d8a8-4b08-2b7f-08ded388e4ae
X-MS-Exchange-CrossTenant-AuthSource: DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 13:43:24.0252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcevFcajI7VubvWLUUwBCRO7fQirG0ig9gCZhi12gnLhIgOjHlMK9ktI86yHpKLI6G9I6KfWUR1rCzUUS8o/jyd/GRMsdGluQ57OLs96t4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P189MB1916
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Jun 2026 13:43:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19790

When url and sha256sum are configured, download the buildtools
installer via bb.fetch with checksum enforcement. The file is
cached in DL_DIR and passed to install-buildtools via --local-file.

If no install-buildtools config is present, fall back to calling
install-buildtools directly (preserving existing default behaviour).

CLI overrides available via --url and --sha256.

Depends: [oe-core] install-buildtools: add --local-file option
AI-Generated: Kiro with Claude Opus 4.6
Signed-off-by: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
---

Changes since v1:
- Use bb.fetch with mandatory sha256sum when configured
- Fall back to install-buildtools defaults when no config present
- Explicit sha256 verification after download (covers file:// and all fetch=
ers)
- Combined url+filename into single url field
- Removed --sdk-name, --filename, --no-check/--check
- Added --url and --sha256 CLI overrides
- Updated schema, docs, and tests
 bin/bitbake-setup                             | 91 ++++++++++++++++++-
 .../bitbake-user-manual-environment-setup.rst | 19 ++++
 lib/bb/tests/setup.py                         | 85 ++++++++++++++++-
 setup-schema/bitbake-setup.schema.json        | 21 +++++
 4 files changed, 208 insertions(+), 8 deletions(-)

diff --git a/bin/bitbake-setup b/bin/bitbake-setup
index 97ea08d11..461932b26 100755
--- a/bin/bitbake-setup
+++ b/bin/bitbake-setup
@@ -1053,10 +1053,91 @@ def install_buildtools(top_dir, settings, args, d):
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
+        buildtools_config =3D upstream_config.get('data', {}).get(
+            'bitbake-setup', {}).get('install-buildtools', {})
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
+    if not url and not sha256:
+        # No config provided -- fall back to install-buildtools defaults
+        logger.plain("No install-buildtools config found, using script def=
aults")
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
+    # Locate the downloaded file
+    local_path =3D fetcher.localpath(src_uri)
+
+    if not os.path.exists(local_path):
+        logger.error("Downloaded file not found at expected location")
+        sys.exit(1)
+
+    # Verify checksum explicitly (file:// fetcher does not enforce checksu=
ms)
+    actual_sha256 =3D bb.utils.sha256_file(local_path)
+    if actual_sha256 !=3D sha256:
+        logger.error("Checksum mismatch for buildtools installer:\n"
+                     "  expected: %s\n"
+                     "  actual:   %s" % (sha256, actual_sha256))
+        sys.exit(1)
+
+    logger.plain("Buildtools installer cached in {} and will be installed =
into {}".format(
+        os.path.dirname(local_path), buildtools_install_dir))
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
@@ -1286,6 +1367,8 @@ def main():
     parser_install_buildtools =3D subparsers.add_parser('install-buildtool=
s', help=3D'Install buildtools which can help fulfil missing or incorrect d=
ependencies on the host machine')
     add_setup_dir_arg(parser_install_buildtools)
     parser_install_buildtools.add_argument('--force', action=3D'store_true=
', help=3D'Force a reinstall of buildtools over the previous installation.'=
)
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
index 5592e8196..2c073aefd 100644
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
@@ -644,6 +663,64 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
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
+        # test wrong sha256 is a hard error
+        with self.assertRaises(bb.process.ExecutionError):
+            self.runbbsetup(["install-buildtools", "--setup-dir", setuppat=
h,
+                             "--force",
+                             "--url", "file://{}/{}".format(
+                                 self.buildtools_dir, self.buildtools_file=
name),
+                             "--sha256", "bad" * 21 + "b"])
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


