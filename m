Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDACC5DF86
	for <webhook@archiver.kernel.org>; Wed, 19 Aug 2026 12:11:17 +0000 (UTC)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5526.1787141468135652554
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Aug 2026 05:11:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=n5TWs0XV;
 spf=pass (domain: gmail.com, ip: 209.85.219.50, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-90a6b298887so5728466d6.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 05:11:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787141467; cv=none;
        d=google.com; s=arc-20260327;
        b=QepWiNzuOtyc+uhQQ/dfCdna45iQwb4sVWVh4bSXq+fpkG7qIp8opylaDX0d1aBMvx
         hRFmGLFphjuxpmG85+4KpN1zJP8A+ffrhOtC0YKJ5tpI9HI40bIi5Y/wJctvQ7vTIgLR
         yKNpjr4MAC/FAoNMqJ+ZJmIdQqqGLlUQkZUf2kKK798g5l5ifMhA2WaPLskhk+HFkHub
         qF3Bv+kxxfLMmjHWMM/8o5HB8qnEEpsVLwwsjrSukAQMGQMMsY613pxOzCshcbMFeunH
         g9sc0zcLRxHc5znvlWe9xcwrZfNtppPv9GaWPJejAVOl0tLkPek+zVVN2GkpcD8L+DzD
         dnyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=b2S9x80J04J/zqSwMDaAJVaw9EizoZQrd3Ov9Jxl2Qw=;
        fh=sZ+LizO92di32clJ5O4FZQSlrzEWq9dYqe6rVfGtX9Q=;
        b=FLcXp+Mf1v4zLMixOALldmTuOJ5mvIEPAEunF0GPYFu3ME+nDOYMprF1R8YBLeG+tD
         Fswi6geINIfJRP3rwtZfwtLGbRrrkmy1E79ml2wAKuDa9KnFlzvogRoYzEQkM3Px5hJL
         PWroUbk6vpybBCT86+HmrrNGCfK3h5eHQWgRsC0snHFAJX7GCUwiSs7cagqA35ao8OV/
         ecpdlUlwaOijsTUVyuPiz7av6PECyktLjye9WI1Syt3QmCjlkvUyPcawCmohwdXGX8o0
         3/A/APUlBBvb9MZ8YKfWKoeikGYT/O9pr4F90W4G+mmFqGcvt/D2SOZUaVFDAAhZ+RIR
         0Arg==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787141467; x=1787746267; darn=lists.openembedded.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b2S9x80J04J/zqSwMDaAJVaw9EizoZQrd3Ov9Jxl2Qw=;
        b=n5TWs0XVGcxG5UALeyWr51td4d+Fb6YTosBbPt0Gg77CttWktroENmOnQgNmw8Bm2z
         r6ms4d9HQtzxFUqpK8lZH6WgcxJ6phQfG34zScNn3gI/pzpZDigyU5zuh7UDDUcywpb6
         Cl7UnrX1YXGggsoKsG/kL2XHaT+EeY89pS+g29q4gEj42eynYkEqlGRaCE/8xaK8q3/6
         bpOo0njlyKyQ7wHs1A0BIse9aIkgItdwdYNWcT617oWZgdKGJ7/JVHUCFriwU5lN2HBD
         ai9mcCmPyFzBXihODWFi0tqE937Axzx/6F8ru6NSE255SHpgfoHfJEWZ7IyfSrJOGkfd
         u0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787141467; x=1787746267;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b2S9x80J04J/zqSwMDaAJVaw9EizoZQrd3Ov9Jxl2Qw=;
        b=amt+1KyE8mqq5ls1t4eyJ7zqQMSsNksRTZjF4yPrACwcWRk/xyKEbCFYkZupWMfZgr
         kEtABH5TPSydpXlEZROURrLgMChL8omD6PKKFF3lRQw9Yf6l5z72M8IE86aSMzJLTEWR
         8ntRkTJsZ6utlTrR0J4k2ELG2actphuB70YQuTsLuzkiRr/qWsmk5/Vv3DuY9Oe478pS
         08BZlKEwS0ox5U9ffdQTrUW3iQlprwpHoLznUn/Sw5uj4rUcXu7Z+yl3fuhRSbzOBJWM
         c2DThnmHhZd7LXlUa14u3m2S252ZPSiAYNDvA6CGcc+SGPntNxyzNAknNGcYVAsF/hRc
         SktQ==
X-Gm-Message-State: AFuF++mXPtvhbhoNrMDWPQBPRnIDRU82qMFWQ26kI/OJ/ulyzrpPGUhk
	b1qybewNFiZ4vRtwQqtqJ0TY2sSSDnI2+USKAd9JsmQO79SCwrRuChfOQ9lrH+UoXPsnXwUAHGx
	gZ+DpPJZQsnbwokUaYF+B4FhWW4l6oNU=
X-Gm-Gg: AR+sD121ibWe+AWrQoq8X2pBBzRQ1RIg8m77M+1tHz4YBHRymXP6GowurTzkmj9Zi9R
	JeP2Hp2GhAQqBKMy9d8f9BEu522h2efxgLPL8EoeHYGYYT4YJ5aDOdsUNYOGGbRLPQkUMiqDSsd
	rwLrpV73u9QcIB+uctOliCFnzJZfKEraSI9Beu0BFtjilN/LwQ33VeZLfxHRwG6ILi7XSOBrse1
	AZF+YBdFKBQkSnBD3aRJESScq+V0J7Ts4SYYSxGYv765BBxh7wD79jcFoUvefNOYOxrg1CEWXw6
	FgZxzRmHaq5t3WXfUSqj3kRuxxObWQJsaKtEKe+oaSIkThgTJW9KtIcOirqbVrNwdo2JOo8pX0V
	eI40=
X-Received: by 2002:a05:6214:5710:b0:8be:7779:d1b1 with SMTP id
 6a1803df08f44-90c5eaa2dcdmr39532106d6.30.1787141467002; Wed, 19 Aug 2026
 05:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260819120644.23750-1-giancarlo.cicellyn@gmail.com>
In-Reply-To: <20260819120644.23750-1-giancarlo.cicellyn@gmail.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 19 Aug 2026 14:10:56 +0200
X-Gm-Features: AcwNN1XQ-_qZ1OgsjFy7QSfg6mV73gz_7qRa6TV2kJAHqR3s-hz7D_KGKV7k92o
Message-ID: <CANNYZj-Qc3kWk3Z=F_-GyGNgU=n3E=6nj_2X1zgK7pC8gNsdvA@mail.gmail.com>
Subject: Re: [PATCH v2] bitbake-setup: preserve build config when init script
 is missing
To: Giancarlo Cicellyn Comneno <giancarlo.cicellyn@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Aug 2026 12:11:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19997

No. Please talk to me first (or wait for my reply) before sending any
revised patches.

Alex

On Wed, 19 Aug 2026 at 14:07, Giancarlo Cicellyn Comneno
<giancarlo.cicellyn@gmail.com> wrote:
>
> Source revisions can change during bitbake-setup updates. If an updated
> source still provides scripts/oe-setup-build but no longer provides
> oe-init-build-env, checkout_layers() continues to select that source as
> the build environment provider.
>
> setup_bitbake_build() currently discovers the missing init script only
> after moving the active build/conf aside and creating replacement
> configuration files. It then logs an error and returns, allowing
> update_build() to continue writing fixed revisions and committing
> configuration state despite the failed environment initialization.
>
> Check for oe-init-build-env before modifying build/conf and raise an
> exception when it is unavailable.
>
> The regression test changes the configured source from master to another
> branch that retains scripts/oe-setup-build but removes oe-init-build-env,
> matching the supported source revision update mechanism. It verifies that
> the failed update is reported and leaves the active local.conf unchanged.
>
> Tests:
>   LC_ALL=C LANG=C ./bin/bitbake-selftest bb.tests.setup
>
> AI-Generated: Uses OpenAI ChatGPT
> Signed-off-by: Giancarlo Cicellyn Comneno <giancarlo.cicellyn@gmail.com>
> ---
> Changes in v2:
> - model the failure through a supported source revision update instead of
>   removing oe-init-build-env from the already configured revision
> - make the regression test retain scripts/oe-setup-build while the updated
>   revision removes oe-init-build-env
> - clarify that the failed initialization replaces the active build/conf
>   before returning success to update_build()
> - verify the regression on unmodified origin/master and validate the revised
>   patch with the full bb.tests.setup suite
> ---
>  bin/bitbake-setup     |  8 +++---
>  lib/bb/tests/setup.py | 67 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 71 insertions(+), 4 deletions(-)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 34260139c..d214ad568 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -354,6 +354,10 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
>      if template and not os.path.exists(oesetupbuild):
>          raise Exception("Cannot complete setting up a bitbake build directory from OpenEmbedded template '{}' as oe-setup-build was not found in any layers; please use oe-init-build-env manually.".format(template))
>
> +    oeinitbuildenvdir = os.path.join(layerdir, 'oe-init-build-env-dir')
> +    if not template and not os.path.exists(os.path.join(oeinitbuildenvdir, "oe-init-build-env")):
> +        raise Exception("Could not find oe-init-build-env in any of the layers; please use another mechanism to initialize the bitbake environment")
> +
>      bitbake_confdir = os.path.join(bitbake_builddir, 'conf')
>      backup_bitbake_confdir = add_unique_timestamp_to_path(os.path.join(bitbake_builddir, 'conf-backup'))
>      upstream_bitbake_confdir = add_unique_timestamp_to_path(os.path.join(bitbake_builddir, 'conf-upstream'))
> @@ -368,10 +372,6 @@ def setup_bitbake_build(bitbake_config, layerdir, setupdir, thisdir, update_bb_c
>      if template:
>          bb.process.run([oesetupbuild, "setup", "-c", template, "-b", bitbake_builddir, "--no-shell"])
>      else:
> -        oeinitbuildenvdir = os.path.join(layerdir, 'oe-init-build-env-dir')
> -        if not os.path.exists(os.path.join(oeinitbuildenvdir, "oe-init-build-env")):
> -            logger.error("Could not find oe-init-build-env in any of the layers; please use another mechanism to initialize the bitbake environment")
> -            return
>          _make_init_build_env(bitbake_builddir, os.path.realpath(oeinitbuildenvdir))
>
>      _prepend_passthrough_to_init_build_env(bitbake_builddir)
> diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
> index 53a07ee3a..33ceaf3ce 100644
> --- a/lib/bb/tests/setup.py
> +++ b/lib/bb/tests/setup.py
> @@ -578,6 +578,73 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
>          out = self.runbbsetup(["init", "--non-interactive", "-L", "test-repo", self.testrepopath, "--setup-dir-name", custom_setup_dir, "test-config-1", "gadget"])
>          _check_local_sources(custom_setup_dir)
>
> +    def test_update_preserves_build_conf_when_init_build_env_missing(self):
> +        if 'BBPATH' in os.environ:
> +            del os.environ['BBPATH']
> +        os.chdir(self.tempdir)
> +
> +        self.runbbsetup([
> +            "settings", "set", "default", "registry",
> +            "'git://{};protocol=file;branch=master;rev=master'".format(
> +                self.registrypath
> +            ),
> +        ])
> +        self.add_file_to_testrepo('test-file', 'initial\n')
> +        self.add_json_config_to_registry(
> +            'test-config-1.conf.json', 'master', 'master'
> +        )
> +
> +        self.runbbsetup([
> +            "init",
> +            "--non-interactive",
> +            "test-config-1",
> +            "gadget-notemplate",
> +        ])
> +
> +        setuppath = self.get_setup_path(
> +            'test-config-1', 'gadget-notemplate'
> +        )
> +        local_conf = os.path.join(
> +            setuppath, 'build', 'conf', 'local.conf'
> +        )
> +
> +        user_content = 'USER_SETTING = "preserve-me"\n'
> +        with open(local_conf, 'w') as f:
> +            f.write(user_content)
> +
> +        branch = 'missing-init-build-env'
> +        self.git(['checkout', '-b', branch], cwd=self.testrepopath)
> +
> +        self.assertTrue(os.path.exists(os.path.join(
> +            self.testrepopath, 'scripts', 'oe-setup-build'
> +        )))
> +        os.remove(os.path.join(self.testrepopath, 'oe-init-build-env'))
> +        self.git(['add', '-u'], cwd=self.testrepopath)
> +        self.git(
> +            ['commit', '-m', 'Remove oe-init-build-env'],
> +            cwd=self.testrepopath,
> +        )
> +
> +        self.add_json_config_to_registry(
> +            'test-config-1.conf.json', branch, branch
> +        )
> +
> +        os.environ['BBPATH'] = os.path.join(setuppath, 'build')
> +        try:
> +            with self.assertRaisesRegex(
> +                bb.process.ExecutionError,
> +                "Could not find oe-init-build-env",
> +            ):
> +                self.runbbsetup([
> +                    "update",
> +                    "--update-bb-conf=yes",
> +                ])
> +        finally:
> +            del os.environ['BBPATH']
> +
> +        with open(local_conf) as f:
> +            self.assertEqual(f.read(), user_content)
> +
>      def test_vscode(self):
>          if 'BBPATH' in os.environ:
>              del os.environ['BBPATH']
> --
> 2.43.0
>

