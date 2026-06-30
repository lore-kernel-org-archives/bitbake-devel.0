Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB7BC43602
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:47:36 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19400.1782820047861926736
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Jun 2026 04:47:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=UCdqT1IO;
 spf=pass (domain: gmail.com, ip: 209.85.222.172, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e5c9211d2so173449985a.1
        for <bitbake-devel@lists.openembedded.org>; Tue, 30 Jun 2026 04:47:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782820047; cv=none;
        d=google.com; s=arc-20260327;
        b=rK/8lReBWIZjrTC4FiR5ZxW4JdQGRnGDvIhf4rzaMdcUpMU/GCKjR9u+sbx4fsVkFb
         NccenqpiywD2KcCYPqh+lkROu9p5A8ip55BRhgDYs9EiCD+uCorA0QmLarJRdAu9cYnS
         iinph+Opej6rXjRMBTtg7eZmsP4vOnS0KDfkw0/bdyXsng7vr5dU9+yqo9zjopivZXlG
         j4zZL0FAD/pyZQo8cUWMCNUvOWE4pfwn3rSFM0h/rfZYz+ssz1rFk7uyo5uB8C9VT50m
         Jy0puBaYk+htI+Wn6nQeRdfkqmoMwDmn0EbibmRCOLLHQl1N2jHk2iU9OWgbC1iQtYTV
         Hzsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5Kr2FyPCKjtuWJnc7gop6xPE57NXSTgZtpXDtLvcBw0=;
        fh=1sPeGJstHoXKVbb5/jKcge0GMtYJBQA5lpzd8iKNszQ=;
        b=C7SxZkL+bL4fakjY6RXcoc4pdFreMCWETPS96y3h3dwSs56icgE23fAIn4Kuq6Xbnw
         h03aCu/lAsBGC1dDVaaYJCYZ8jicJVXBiGa+ZkEcTQveqmOfGVH3wLx9jWd/JAjBq/Kd
         pQSbuELvjklkYmTUvx6lGeuM6zzWjD4CcQ7veXbESAwJYG0SWZFBfwFjRbx7NdqRYaZV
         CF3pROqa8t8gMOrX/PZHVgkIMJT7Pqbb7TqRYzyaviNPvxcozlj9SrneqUBkL0jbCn0x
         pazLx6wJEZ76o3BSQbaJMDME3AWfN3iYkj12GA3ANLk+1skE8AWWLw1Qz5Oz2WnR4oFS
         NtWA==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820047; x=1783424847; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5Kr2FyPCKjtuWJnc7gop6xPE57NXSTgZtpXDtLvcBw0=;
        b=UCdqT1IOeyLtkdwxMF4zu1Yf67L30tE42t/u+c13HyQkpzEH8T/LV95QwqFyS2Nd6g
         qV6XxdkYCGX0TfNTAl89orV26lh1f9dbN77K4DkEDqvEx5Hnm6yZDw+Q8Pl+JiqZ5Kj9
         VZEw+ss59rnXPhs0urriSf/Mgl9OLGMBIVnwWzFyyJ5UKz7T8GAu9QC63UkOLUe9UX5d
         eXtf1k06wU3NfgcnMTkO91HJWEQYmAyIFvL5jrMj3hFLZ4WbAK3OLSQOJRR8Ou5NrT8Z
         D8sJ1vJbdCUtMq01yxSXiIImgGwdu3dMorn7JCkgW4jPsOpyj48uRj9eqLlAd9M1aADA
         ZwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820047; x=1783424847;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Kr2FyPCKjtuWJnc7gop6xPE57NXSTgZtpXDtLvcBw0=;
        b=szN4mTQW0L981PzjqAlrF6kZ66oczc0R6NFJmt6INPII8fvg4ce9tj3/+v5kgqKd/M
         bRORE4tBR+AS76MGdjTdEEvNOXDMLYl0g6hbBaTv352MjxX7f/2r4hTF/wDmQAZi5/A8
         7wTE2wHp0952j8k0oOnCUb0dy1xySzWjXtSm109HSy+h1sXPxx9oaMrhqBVMOb3DSvQa
         UNcYYVD/MtILOEM9JzU5LoJemYlyR2Z2yohuJ4yWd1HhotQHKOpuiUW52oBtFlNJEjoo
         KXWmFT3nYYSG0aPq7Ybg3Q2lUzjGbaaXnRmfZ6N9uDdq9U+TudUDwjrh+4WgwTpZ95vj
         hmQg==
X-Gm-Message-State: AOJu0Yy06FVktJWxIR3SI+ite5F4fxjwkav0PRbya1ELlY683WpaZZn8
	9oYhVpE0bcBqLMjC9CWU9B73o/TLMIrRlad7VWHXLMxDib1693GqpdjSsNknT8JBonDRQVk6xG4
	HflMVctqlqndY7b1ljqAdntFF+01MfkOc7sJ42lk=
X-Gm-Gg: AfdE7cluX4E1cOnP9hcNWFGa/7touZHVVpoX53lXuKqudaX16C8WCnBm/4XJED1fO6U
	sP659HojfEzTaAcShNxyL0vyS10kjEy55CE2tsFPq6H4v0+ZupkUtfzzdrv4lkV/GpTsWG3MxtS
	7HNGYFnmQnQ7qtsq67wGel1yB/KQhCr6vAdxdKrF3t4Y+AXc9TGDRPkGm8wKOY86P8zj6xq8bEA
	h4jRafBgQFopqocYa/qvlWuH+Bv3OR/fHQyfqfjmIJtsxD+aJv6d9WSKiwL54/4cOJUbTzRUg==
X-Received: by 2002:a05:620a:271b:b0:92b:6805:91c2 with SMTP id
 af79cd13be357-92e6d8e75c1mr45731585a.74.1782820046474; Tue, 30 Jun 2026
 04:47:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260615121856.96250-1-jaipaul.cheernam@est.tech> <20260629203408.52210-1-jaipaul.cheernam@est.tech>
In-Reply-To: <20260629203408.52210-1-jaipaul.cheernam@est.tech>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Tue, 30 Jun 2026 13:47:14 +0200
X-Gm-Features: AVVi8Cf826tnEh1pbx34aOW6-yfo5tXqBlfYOg9HdGhLNm83tAc66SKuh3bMDU4
Message-ID: <CANNYZj_+k-yvOjJJM_JKAnVPH6Rpy5n4WJyYvrzgph=yX8-8Og@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v4] bitbake-setup: use bb.fetch for
 buildtools installer download
To: jaipaul.cheernam@est.tech
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 30 Jun 2026 11:47:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19809

Thanks, I think this is good overall. Perhaps there's no need to set
buildtools_download_dir twice in the same way in two different code
paths, but that's a minor issue. The patch should go to general review
and CI now.

Alex

On Mon, 29 Jun 2026 at 22:34, Jaipaul Cheernam via
lists.openembedded.org
<jaipaul.cheernam=est.tech@lists.openembedded.org> wrote:
>
> When url and sha256sum are configured in the selected configuration,
> download the buildtools installer via bb.fetch with checksum
> enforcement. The file is unpacked to the standard buildtools download
> location and passed to install-buildtools via --local-file.
>
> If no config is present or --default is passed, fall back to
> calling install-buildtools directly with its built-in defaults.
>
> CLI overrides available via --url and --sha256.
>
> Depends: [oe-core] install-buildtools: add --local-file option
> AI-Generated: Kiro with Claude Opus 4.6
> Signed-off-by: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
> ---
>
> Changes since v3:
> - install-buildtools config is per-configuration only (no top-level)
> - Use buildtools_download_dir for unpack (consistent with default path)
> - Updated schema, docs, and tests to match
>
> Changes since v2:
> - Added --default to bypass config and use script defaults
> - Use fetcher.unpack() instead of reading from DL_DIR directly
> - Removed explicit sha256 verification (fetcher handles it for https)
>
> Changes since v1:
> - Use bb.fetch with mandatory sha256sum when configured
> - Fall back to install-buildtools defaults when no config present
> - Combined url+filename into single url field
> - Removed --sdk-name, --filename, --no-check/--check
> - Added --url and --sha256 CLI overrides
> - Updated schema, docs, and tests
>  bin/bitbake-setup                             | 89 ++++++++++++++++++-
>  .../bitbake-user-manual-environment-setup.rst | 24 +++++
>  lib/bb/tests/setup.py                         | 77 +++++++++++++++-
>  setup-schema/bitbake-setup.schema.json        | 21 +++++
>  4 files changed, 203 insertions(+), 8 deletions(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 97ea08d11..9a3507c1e 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -1053,10 +1053,88 @@ def install_buildtools(top_dir, settings, args, d):
>              return
>          shutil.rmtree(buildtools_install_dir)
>
> -    install_buildtools = os.path.join(args.setup_dir, 'layers/oe-scripts/install-buildtools')
> -    buildtools_download_dir = add_unique_timestamp_to_path(os.path.join(args.setup_dir, 'buildtools-downloads/buildtools'))
> -    logger.plain("Buildtools archive is downloaded into {} and its content installed into {}".format(buildtools_download_dir, buildtools_install_dir))
> -    subprocess.check_call("{} -d {} --downloads-directory {}".format(install_buildtools, buildtools_install_dir, buildtools_download_dir), shell=True)
> +    install_buildtools_script = os.path.join(args.setup_dir, 'layers/oe-scripts/install-buildtools')
> +
> +    buildtools_config = {}
> +    upstream_config_path = os.path.join(args.setup_dir, 'config', 'config-upstream.json')
> +    try:
> +        with open(upstream_config_path) as f:
> +            upstream_config = json.load(f)
> +        buildtools_config = upstream_config.get('bitbake-config', {}).get('install-buildtools', {})
> +    except FileNotFoundError:
> +        pass
> +    except json.JSONDecodeError as e:
> +        logger.error("Failed to parse %s: %s" % (upstream_config_path, e))
> +        sys.exit(1)
> +
> +    url = args.url if args.url is not None else buildtools_config.get('url')
> +    sha256 = args.sha256 if args.sha256 is not None else buildtools_config.get('sha256sum')
> +
> +    if args.default or (not url and not sha256):
> +        # No config or --default: fall back to install-buildtools defaults
> +        logger.plain("Using install-buildtools script defaults")
> +        buildtools_download_dir = add_unique_timestamp_to_path(
> +            os.path.join(args.setup_dir, 'buildtools-downloads/buildtools'))
> +        subprocess.check_call([install_buildtools_script,
> +                               '-d', buildtools_install_dir,
> +                               '--downloads-directory', buildtools_download_dir])
> +        return
> +
> +    if not url:
> +        logger.error("No buildtools URL configured. "
> +                     "Set 'url' in the install-buildtools config section or pass --url.")
> +        sys.exit(1)
> +
> +    if not sha256:
> +        logger.error("No sha256sum configured for buildtools installer. "
> +                     "Add 'sha256sum' to the install-buildtools config section or pass --sha256.\n"
> +                     "You can obtain it with: sha256sum <installer-file>")
> +        sys.exit(1)
> +
> +    # Download using bb.fetch with sha256 validation
> +    src_uri = "{};sha256sum={}".format(url, sha256)
> +
> +    logger.plain("Fetching buildtools installer using bitbake fetcher")
> +    logger.plain("    {}".format(url))
> +
> +    fetcher = bb.fetch.Fetch([src_uri], d)
> +    try:
> +        fetcher.download()
> +    except bb.fetch2.ChecksumError as e:
> +        logger.error("Checksum mismatch for buildtools installer. "
> +                     "Verify the URL and downloaded file.\n%s" % str(e))
> +        sys.exit(1)
> +    except bb.fetch2.FetchError as e:
> +        logger.error("Failed to download buildtools installer: %s" % str(e))
> +        sys.exit(1)
> +
> +    # Unpack into the standard buildtools download location
> +    buildtools_download_dir = add_unique_timestamp_to_path(
> +        os.path.join(args.setup_dir, 'buildtools-downloads/buildtools'))
> +    os.makedirs(buildtools_download_dir, exist_ok=True)
> +    fetcher.unpack(buildtools_download_dir)
> +
> +    filename = os.path.basename(url.rstrip('/'))
> +    matches = glob.glob(os.path.join(buildtools_download_dir, '**', filename), recursive=True)
> +    if not matches:
> +        logger.error("Unpacked file not found: %s" % filename)
> +        sys.exit(1)
> +    local_path = matches[0]
> +
> +    logger.plain("Buildtools installer will be installed into {}".format(
> +        buildtools_install_dir))
> +
> +    cmd = [
> +        install_buildtools_script,
> +        '--local-file', local_path,
> +        '-d', buildtools_install_dir,
> +    ]
> +
> +    try:
> +        subprocess.check_call(cmd)
> +    except subprocess.CalledProcessError as e:
> +        logger.error("install-buildtools failed with exit code %d" % e.returncode)
> +        sys.exit(1)
>
>  def create_siteconf(top_dir, non_interactive, settings):
>      siteconfpath = os.path.join(top_dir, 'site.conf')
> @@ -1286,6 +1364,9 @@ def main():
>      parser_install_buildtools = subparsers.add_parser('install-buildtools', help='Install buildtools which can help fulfil missing or incorrect dependencies on the host machine')
>      add_setup_dir_arg(parser_install_buildtools)
>      parser_install_buildtools.add_argument('--force', action='store_true', help='Force a reinstall of buildtools over the previous installation.')
> +    parser_install_buildtools.add_argument('--default', action='store_true', help='Use install-buildtools script defaults, ignoring any config.')
> +    parser_install_buildtools.add_argument('--url', help='Full URL to the buildtools SDK installer. Overrides config value.')
> +    parser_install_buildtools.add_argument('--sha256', help='SHA256 checksum of the buildtools installer. Overrides config value.')
>      parser_install_buildtools.set_defaults(func=install_buildtools)
>
>      parser_settings_arg_global = argparse.ArgumentParser(add_help=False)
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> index aa546c30b..e1701555e 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
> @@ -660,6 +660,30 @@ In addition, the command can take the following arguments:
>  -  ``--setup-dir``: path to the :term:`Setup` to check to status for. Not
>     required if :term:`BBPATH` is already configured.
>
> +-  ``--url``: full URL to the buildtools SDK installer. Overrides the value
> +   from the configuration file.
> +
> +-  ``--sha256``: SHA256 checksum of the buildtools installer. Overrides the
> +   value from the configuration file.
> +
> +When ``url`` and ``sha256sum`` are set in the :term:`Configuration File`,
> +the installer is downloaded via ``bb.fetch`` (cached in ``DL_DIR``) and its
> +checksum is enforced. If no configuration is present, the script falls back
> +to its built-in defaults::
> +
> +   "bitbake-setup": {
> +       "configurations": [
> +           {
> +               "name": "my-config",
> +               "install-buildtools": {
> +                   "url": "https://example.com/buildtools/x86_64-buildtools-extended-nativesdk-standalone-5.0.sh",
> +                   "sha256sum": "af76648b..."
> +               },
> +               ...
> +           }
> +       ]
> +   }
> +
>  .. _ref-bbsetup-command-settings:
>
>  ``bitbake-setup settings``
> diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
> index 5592e8196..8ca64cb50 100644
> --- a/lib/bb/tests/setup.py
> +++ b/lib/bb/tests/setup.py
> @@ -61,16 +61,31 @@ import getopt
>  import sys
>  import os
>
> -opts, args = getopt.getopt(sys.argv[1:], "d:", ["downloads-directory="])
> +opts, args = getopt.getopt(sys.argv[1:], "d:", ["downloads-directory=", "local-file="])
> +installdir = None
> +local_file = None
>  for option, value in opts:
>      if option == '-d':
>          installdir = value
> +    elif option == '--local-file':
> +        local_file = value
> +        print("install-buildtools local-file={}".format(value))
>
>  print("Buildtools installed into {}".format(installdir))
> -os.makedirs(installdir)
> +os.makedirs(installdir, exist_ok=True)
>  """
>          self.add_file_to_testrepo('scripts/install-buildtools', installbuildtools, script=True)
>
> +        # Dummy buildtools installer for bb.fetch testing
> +        self.buildtools_dir = os.path.join(self.tempdir, "buildtools-dl")
> +        os.makedirs(self.buildtools_dir)
> +        self.buildtools_filename = "x86_64-buildtools-nativesdk-standalone-test.sh"
> +        buildtools_filepath = os.path.join(self.buildtools_dir, self.buildtools_filename)
> +        with open(buildtools_filepath, 'w') as f:
> +            f.write("#!/bin/sh\necho dummy\n")
> +        with open(buildtools_filepath, 'rb') as f:
> +            self.buildtools_sha256 = hashlib.sha256(f.read()).hexdigest()
> +
>          bitbakeconfigbuild = """#!/usr/bin/env python3
>  import os
>  import sys
> @@ -108,7 +123,11 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>                  "name": "gadget",
>                  "description": "Gadget configuration",
>                  "oe-template": "test-configuration-gadget",
> -                "oe-fragments": ["test-fragment-1"]
> +                "oe-fragments": ["test-fragment-1"],
> +                "install-buildtools": {
> +                    "url": "file://%s/%s",
> +                    "sha256sum": "%s"
> +                }
>              },
>              {
>                  "name": "gizmo",
> @@ -176,7 +195,7 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>      },
>      "version": "1.0"
>  }
> -""" % (sources)
> +""" % (sources, self.buildtools_dir, self.buildtools_filename, self.buildtools_sha256)
>          os.makedirs(os.path.join(self.registrypath, os.path.dirname(name)), exist_ok=True)
>          with open(os.path.join(self.registrypath, name), 'w') as f:
>              f.write(config)
> @@ -644,6 +663,56 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>      def _count_layer_backups(self, layers_path):
>          return len([f for f in os.listdir(layers_path) if 'backup' in f])
>
> +    def test_install_buildtools_fetch(self):
> +        """Test that install-buildtools uses bb.fetch with sha256 and passes --local-file"""
> +        import shutil
> +
> +        if 'BBPATH' in os.environ:
> +            del os.environ['BBPATH']
> +        os.chdir(self.tempdir)
> +
> +        registry_uri = "git://{};protocol=file;branch=master;rev=master".format(
> +            self.registrypath)
> +        self.runbbsetup(["settings", "set", "default", "registry", registry_uri])
> +        self.add_file_to_testrepo('test-file', 'initial\n')
> +        self.add_json_config_to_registry('test-config-bt.conf.json', 'master', 'master')
> +        self.runbbsetup(["init", "--non-interactive", "test-config-bt", "gadget"])
> +        setuppath = self.get_setup_path('test-config-bt', 'gadget')
> +
> +        # test config-driven install (url + sha256sum from config)
> +        out = self.runbbsetup(["install-buildtools", "--setup-dir", setuppath])
> +        self.assertIn("Buildtools installed into", out[0])
> +        self.assertIn("install-buildtools local-file=", out[0])
> +        self.assertTrue(os.path.exists(os.path.join(setuppath, 'buildtools')))
> +
> +        # test CLI overrides (use a different file to prove precedence)
> +        shutil.rmtree(os.path.join(setuppath, 'buildtools'))
> +        alt_filename = "alt-buildtools-test.sh"
> +        alt_filepath = os.path.join(self.buildtools_dir, alt_filename)
> +        with open(alt_filepath, 'w') as f:
> +            f.write("#!/bin/sh\necho alt\n")
> +        with open(alt_filepath, 'rb') as f:
> +            alt_sha256 = hashlib.sha256(f.read()).hexdigest()
> +        alt_url = "file://{}/{}".format(self.buildtools_dir, alt_filename)
> +        out = self.runbbsetup(["install-buildtools", "--setup-dir", setuppath,
> +                               "--url", alt_url,
> +                               "--sha256", alt_sha256])
> +        self.assertIn("Buildtools installed into", out[0])
> +        self.assertIn("install-buildtools local-file=", out[0])
> +        self.assertIn(alt_filename, out[0])
> +
> +        # test missing sha256sum is a hard error
> +        shutil.rmtree(os.path.join(setuppath, 'buildtools'), ignore_errors=True)
> +        with open(os.path.join(setuppath, 'config', 'config-upstream.json')) as f:
> +            config_upstream = json.load(f)
> +        config_upstream['bitbake-config']['install-buildtools'] = {
> +            'url': 'file://{}/{}'.format(self.buildtools_dir, self.buildtools_filename)
> +        }
> +        with open(os.path.join(setuppath, 'config', 'config-upstream.json'), 'w') as f:
> +            json.dump(config_upstream, f)
> +        with self.assertRaises(bb.process.ExecutionError):
> +            self.runbbsetup(["install-buildtools", "--setup-dir", setuppath, "--force"])
> +
>      def test_update_rebase_conflicts_strategy(self):
>          """Test the --rebase-conflicts-strategy option for the update command.
>
> diff --git a/setup-schema/bitbake-setup.schema.json b/setup-schema/bitbake-setup.schema.json
> index 99f47f73d..797d45252 100644
> --- a/setup-schema/bitbake-setup.schema.json
> +++ b/setup-schema/bitbake-setup.schema.json
> @@ -137,6 +137,27 @@
>                              "setup-dir-name": {
>                                  "type": "string",
>                                  "description": "A suggestion for the setup directory name, $-prefixed keys from oe-fragments-one-of will be substituted with user selections."
> +                            },
> +                            "install-buildtools": {
> +                                "type": "object",
> +                                "description": "Settings for downloading buildtools via bb.fetch",
> +                                "properties": {
> +                                    "url": {
> +                                        "type": "string",
> +                                        "minLength": 1,
> +                                        "description": "Full URL to the buildtools SDK installer."
> +                                    },
> +                                    "sha256sum": {
> +                                        "type": "string",
> +                                        "minLength": 1,
> +                                        "description": "SHA256 checksum of the buildtools installer."
> +                                    }
> +                                },
> +                                "required": [
> +                                    "url",
> +                                    "sha256sum"
> +                                ],
> +                                "additionalProperties": false
>                              }
>                          },
>                          "additionalProperties": false
> --
> 2.34.1
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#19808): https://lists.openembedded.org/g/bitbake-devel/message/19808
> Mute This Topic: https://lists.openembedded.org/mt/120037327/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

