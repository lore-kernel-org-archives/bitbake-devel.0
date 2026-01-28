Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B376D25B4E
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 12:27:02 +0000 (UTC)
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11796.1769603219226271427
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 28 Jan 2026 04:26:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GA50BYe7;
 spf=pass (domain: gmail.com, ip: 209.85.222.180, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c6a822068eso928269085a.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 04:26:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769603218; cv=none;
        d=google.com; s=arc-20240605;
        b=kjo3SdMsVBHWQVeti956DwWDsi0pp0roUAS1KYatc0/36HHEdmMVFxxVanTrxq6+ou
         K4rbZmogMaFoLuR1Qi34G/oHaYnGnnPhzLgWcTyff+UfjmX+XKJOK79+qV+MWeFwvtco
         OnQb9KF2BwgGW8dHylycuzvY/gJcoF4fXnpBY/VQNq4wnrYX0cqncAXBG5p0AY7Z1cdS
         xDIxbmV5Y1GcMzQgvHvBvg7tQ4i82qOlQQl7NmNhwEb3rj0YYQCGXzAgbjlCxtcA9K4g
         Akt+umPhXPk6Gfk6GdCVPs6S/zUmD9VgNq/npMllQpVLMpk3RlrwfEkNfvsZ+cqBBfBy
         Zkxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4mBUjoaIx+lSWv35IaqbZrk+Oxj0DHRoeSV62kNuBGw=;
        fh=OW3Dv9aSaONdxqFEg+gHG7ItOEhRMtXzTVqh/JdGy3c=;
        b=HPK0AMkZdjsVLS/k6/+p3DTZfO0Xim9Tvh0i188iCYncR631qu3YSaQfwGLB6JqFD+
         0OCt18Tfac7WqHiwssBmhNbfPauCWbuPcU2KWKTO/Uh4r1RPmTmGzo+be3HCfeSNPCC5
         9I2QtnAs4owe/et1vQskwgTEubyodvxdckf52KgRcvth67CdKIbinhy6TLDQeNhED+im
         iXZgOJYXuQ+1n0so25dMGNHlYSO3z0QxTYAwfq0v2ytFzFfdj35Wy0wj9WH72HiQXc8i
         8zMw9+6Fun2wJq5duzhFHC/jo95hARKh+JE0WTABJMzRx8TSdlZJGBv+URxbw19ss0Co
         sMmQ==;
        darn=lists.openembedded.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769603218; x=1770208018; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4mBUjoaIx+lSWv35IaqbZrk+Oxj0DHRoeSV62kNuBGw=;
        b=GA50BYe7lfq/fACsNeXfWdgxKnvT35ec5/xF62SiZSpLTCTyNWEd0f6tW2KCcRZf3R
         cr5uycox3N0yfWry0EYP30MridnzJSwnTd0leRXQmywOkPyLzwG497s0hwbWTtea/hKl
         7L1KN3Ser2CXyez+chmvyCRPTMSpE64cObT3PGSFOOb4ogKQxslHWo/Z6H5HNa/0DN7s
         bRHxm9krjubSbROvCLe1mO9GaFGl1J9lb63cYBu3COBiXfGU57VtrCYH70FQ7UEd3FH1
         snH0Su/YSKGs5cnDfgibImhkAL48zFX0zLPxgDAxwMSoN4dMPqe8kMmnP56IMNYQaLwS
         34Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769603218; x=1770208018;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mBUjoaIx+lSWv35IaqbZrk+Oxj0DHRoeSV62kNuBGw=;
        b=cbi4nz+KkwoeneixZJuZtGB3FTQdTPoSkG25wZJ38RInoaj6htnBaPLqU1qRko9ink
         yqSaiQfgMdn4RCDURv1SmAw9CKzg5VukjkOZ8EAUImabRg18lEheTU9gPWyl/yINqnDT
         m5ZiaIxI5TUl4fRCmMsP9cI4f2Wg9ubBQdWQj9QJdZB33vl5BPatixslaXAQ2iudrvMR
         aDnFt7Woc/WP8rcSHaKXUthGnSffaqbTmm5hFuX63E/BLuuHMDaRPeRlki+Hm72X94b3
         pOxezGbLbZ5lLagycEmWwTua+xdu4anKhfC32eG0ItdzZh6Q6pGq7p1cDT2nTFSNaXZ3
         9Vng==
X-Gm-Message-State: AOJu0YyPLwdbSnxWYaoecIvkuIENRNbnOgz2IsQeMKccD4HgqEYjrpF9
	xp17y5Mw6kRfycNO8jGqnmpuCUlKFCEyIrqbYQp7tO/3ma/aqL/bOCzhBu3xK2Xy+d8htHxA5am
	U1nk4MJB7r9yoPY9rQn/hwnDZzMpoZJg=
X-Gm-Gg: AZuq6aLlynw9u8ncT/U3EtKc/ldp/6Oa8d5mENztJ+TxwgxP6KXocD8qv4TnMCs1sJQ
	HETMrKapgUG/djNaJBqiD5f1abeRzB49txE+HWjgtO7lsRIK6h3aylKbzUSU3ig3UpbnSCgATzZ
	cq2coYZOI1+bxYc06bethxN9iM1Q3vBGaEl4BOnhTFdsceSy2uVVjVCUrdRSMNUeDfe6qj8X/pI
	KO9dNmk/r6iJ0YqV+XkG/QrPjNEWUk3WxoOteayoCqrlnBLckpmudwXH5czmE8LJM+DH9PGfJJD
	M8qLVgV8bGyIOvxO9kPSzdoZZcuSXw==
X-Received: by 2002:a05:620a:404d:b0:8b6:164e:e0c with SMTP id
 af79cd13be357-8c70b862078mr607361085a.25.1769603217583; Wed, 28 Jan 2026
 04:26:57 -0800 (PST)
MIME-Version: 1.0
References: <20260127160508.3392732-1-rob.woolley@windriver.com> <20260127160508.3392732-3-rob.woolley@windriver.com>
In-Reply-To: <20260127160508.3392732-3-rob.woolley@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 28 Jan 2026 13:26:46 +0100
X-Gm-Features: AZwV_QjbamtKhPHUSultW8RWFS7HZeIVFmlkq4vwEkeZ24UNFQEwW1E7XSw1mPg
Message-ID: <CANNYZj9YWviJ=JDR7On+LfK2RHBs1X77J6UzxPQDzVUV2rxnag@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH v2 02/10] bitbake-setup: Add pypi packaging
To: rob.woolley@windriver.com
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 28 Jan 2026 12:27:02 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18911

Thanks! This does look much cleaner, my only concern is that there are
no tests. Is it possible to produce the .whl such that the steps and
the output are contained entirely in some temporary location, or (less
good) bitbake repo itself, e.g. nothing gets written in $HOME? I see
that contrib/pypi/package-bitbake-setup.py takes a -d parameter, so
perhaps that could be used?

I'd really like to extend lib/bb/tests/setup.py with a new class (e.g.
PypiTest) that does it.

Alex

On Tue, 27 Jan 2026 at 17:05, Rob Woolley via lists.openembedded.org
<rob.woolley=windriver.com@lists.openembedded.org> wrote:
>
> Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
> ---
>  .gitignore                            |  1 +
>  contrib/pypi/BUILD.md                 | 57 ++++++++++++++++
>  contrib/pypi/LICENSE                  |  9 +++
>  contrib/pypi/README.md                | 42 ++++++++++++
>  contrib/pypi/noxfile.py               | 30 +++++++++
>  contrib/pypi/package-bitbake-setup.py | 93 +++++++++++++++++++++++++
>  contrib/pypi/pyproject.toml           | 97 +++++++++++++++++++++++++++
>  contrib/pypi/tests/test_install.py    | 17 +++++
>  8 files changed, 346 insertions(+)
>  create mode 100644 contrib/pypi/BUILD.md
>  create mode 100644 contrib/pypi/LICENSE
>  create mode 100644 contrib/pypi/README.md
>  create mode 100644 contrib/pypi/noxfile.py
>  create mode 100755 contrib/pypi/package-bitbake-setup.py
>  create mode 100644 contrib/pypi/pyproject.toml
>  create mode 100644 contrib/pypi/tests/test_install.py
>
> diff --git a/.gitignore b/.gitignore
> index a6a256b2..9a5c4ec4 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -17,3 +17,4 @@ lib/toaster/contrib/tts/backlog.txt
>  lib/toaster/contrib/tts/log/*
>  lib/toaster/contrib/tts/.cache/*
>  lib/bb/tests/runqueue-tests/bitbake-cookerdaemon.log
> +packaging_workspace/
> diff --git a/contrib/pypi/BUILD.md b/contrib/pypi/BUILD.md
> new file mode 100644
> index 00000000..3c50b6e1
> --- /dev/null
> +++ b/contrib/pypi/BUILD.md
> @@ -0,0 +1,57 @@
> +# Development Instructions
> +
> +## Requirements
> +
> +- Python >= 3.9
> +- pip >= 19 (for installation)
> +- git (for SCM-based versioning)
> +
> +## Automated testing
> +
> +The steps to lint, build, and test the bitbake-setup pypi packaging have been automated with the nox tool.  This tool automatically creates a Python virtual environment for you.
> +
> +To run the linters do:
> +```bash
> +nox -s lint
> +```
> +
> +To run the build do:
> +```bash
> +nox -s build
> +```
> +
> +To run the tests do:
> +```bash
> +nox -s tests
> +```
> +
> +## Manual Steps
> +
> +### Building
> +
> +To install the development tools manually run:
> +```bash
> +python3 -m pip install -e '.[dev]'
> +```
> +
> +To build a wheel (.whl) then use:
> +```bash
> +python3 -m build
> +```
> +
> +This produces a wheel (.whl) file in the dist directory.  This may be installed using pip.
> +
> +### Testing
> +
> +```bash
> +python3 -m pip install -e '.[test]'
> +pytest
> +```
> +
> +### Linting
> +
> +```bash
> +python3 -m pip install -e '.[lint]'
> +
> +ruff check src/bitbake_setup
> +```
> \ No newline at end of file
> diff --git a/contrib/pypi/LICENSE b/contrib/pypi/LICENSE
> new file mode 100644
> index 00000000..f9b44182
> --- /dev/null
> +++ b/contrib/pypi/LICENSE
> @@ -0,0 +1,9 @@
> +bitbake-setup is licensed under the GNU General Public License version 2.0. See
> +LICENSE.GPL-2.0-only for further details.
> +
> +Individual files contain the following style tags instead of the full license text:
> +
> +    SPDX-License-Identifier:   GPL-2.0-only
> +
> +This enables machine processing of license information based on the SPDX
> +License Identifiers that are here available: http://spdx.org/licenses/
> diff --git a/contrib/pypi/README.md b/contrib/pypi/README.md
> new file mode 100644
> index 00000000..a6dd99e0
> --- /dev/null
> +++ b/contrib/pypi/README.md
> @@ -0,0 +1,42 @@
> +# bitbake-setup
> +
> +This package provides the `bitbake-setup` command and the Python modules
> +required to support BitBake setup and configuration.
> +
> +## Usage
> +
> +Instructions on uses of bitbake-setup can be found in
> +[Setting Up the Environment With bitbake-setup](https://docs.yoctoproject.org/bitbake/dev/bitbake-user-manual/bitbake-user-manual-environment-setup.html) from the Yocto Project manual.
> +
> +List the available configurations;
> +```bash
> +bitbake-setup list
> +```
> +
> +Show the help for the bitbake-setup init subcommand:
> +```bash
> +bitbake-setup init --help
> +usage: bitbake-setup init [-h] [--non-interactive] [--source-overrides SOURCE_OVERRIDES] [--setup-dir-name SETUP_DIR_NAME] [--skip-selection SKIP_SELECTION] [-L SOURCE_NAME PATH]
> +                          [config ...]
> +
> +positional arguments:
> +  config                path/URL/id to a configuration file (use 'list' command to get available ids), followed by configuration options. Bitbake-setup will ask to choose from available
> +                        choices if command line doesn't completely specify them.
> +
> +options:
> +  -h, --help            show this help message and exit
> +  --non-interactive     Do not ask to interactively choose from available options; if bitbake-setup cannot make a decision it will stop with a failure.
> +  --source-overrides SOURCE_OVERRIDES
> +                        Override sources information (repositories/revisions) with values from a local json file.
> +  --setup-dir-name SETUP_DIR_NAME
> +                        A custom setup directory name under the top directory.
> +  --skip-selection SKIP_SELECTION
> +                        Do not select and set an option/fragment from available choices; the resulting bitbake configuration may be incomplete.
> +  -L SOURCE_NAME PATH, --use-local-source SOURCE_NAME PATH
> +                        Symlink local source into a build, instead of getting it as prescribed by a configuration (useful for local development).
> +```
> +
> +To initialize a workspace for the Poky reference distro using the development branch (ie. "master") of OpenEmbedded:
> +```bash
> +bitbake-setup init poky-master
> +```
> \ No newline at end of file
> diff --git a/contrib/pypi/noxfile.py b/contrib/pypi/noxfile.py
> new file mode 100644
> index 00000000..ab226547
> --- /dev/null
> +++ b/contrib/pypi/noxfile.py
> @@ -0,0 +1,30 @@
> +#!/usr/bin/env python3
> +
> +import glob
> +import nox
> +from pathlib import Path
> +
> +nox.options.sessions = ["lint", "tests", "build"]
> +
> +@nox.session
> +def lint(session):
> +    session.install("ruff", "mypy")
> +    session.run("ruff", "check", "src/bitbake_setup")
> +    # Ignore mypy for now as there are too many errors in imported modules
> +    # session.run("mypy", "src/bitbake_setup")
> +
> +@nox.session
> +def tests(session):
> +    session.install(".[test]")
> +    session.run("pytest")
> +
> +@nox.session
> +def build(session):
> +    session.install("build", "twine")
> +    session.run("python", "-m", "build")
> +
> +    # Verify the wheel installs cleanly
> +    wheels = list(Path("dist").glob("*.whl"))
> +    session.install(str(wheels[0]))
> +    session.run("bitbake-setup", "--help")
> +    session.run("bitbake-setup", "list")
> \ No newline at end of file
> diff --git a/contrib/pypi/package-bitbake-setup.py b/contrib/pypi/package-bitbake-setup.py
> new file mode 100755
> index 00000000..3a07e911
> --- /dev/null
> +++ b/contrib/pypi/package-bitbake-setup.py
> @@ -0,0 +1,93 @@
> +#!/usr/bin/env python3
> +
> +import argparse
> +import logging
> +import os
> +import shutil
> +from pathlib import Path
> +
> +def create_packaging_workspace(directory):
> +    # Create the directory for packaging workspace
> +    if len(directory or "") > 0:
> +        workspace_dir = Path(directory)
> +    else:
> +        # This script is located in contrib/pypi/package-bitbake-setup.py
> +        workspace_dir = Path(__file__).parents[2] / "packaging_workspace"
> +
> +    if not workspace_dir.exists():
> +        logging.debug(f"Created packaging workspace at: {workspace_dir}")
> +        workspace_dir.mkdir(exist_ok=True)
> +    else:
> +        logging.debug(f"Packaging workspace already exists at: {workspace_dir}")
> +
> +    # Copy packaging files to the workspace
> +    files_to_copy = [
> +        "contrib/pypi/pyproject.toml",
> +        "contrib/pypi/README.md",
> +        "contrib/pypi/LICENSE",
> +        "contrib/pypi/noxfile.py",
> +        "LICENSE.MIT",
> +        "LICENSE.GPL-2.0-only"
> +    ]
> +
> +    for file in files_to_copy:
> +        src_path = Path(__file__).parents[2] / file
> +        dest_path = workspace_dir / Path(file).name
> +
> +        if src_path.is_dir():
> +            shutil.copytree(src_path, dest_path, dirs_exist_ok=True)
> +            logging.debug(f"Copied directory: {src_path} to {dest_path}")
> +        else:
> +            shutil.copy2(src_path, dest_path)
> +            logging.debug(f"Copied file: {src_path} to {dest_path}")
> +
> +
> +    # Copy necessary modules to the workspace
> +    modules_to_copy = [
> +        "lib/bb",
> +        "lib/bs4",
> +        "lib/ply"
> +    ]
> +
> +    for module in modules_to_copy:
> +        src_path = Path(__file__).parents[2] / module
> +        dest_path = workspace_dir / "src" / Path(module).name
> +
> +        if src_path.is_dir():
> +            shutil.copytree(src_path, dest_path, dirs_exist_ok=True)
> +            logging.debug(f"Copied module directory: {src_path} to {dest_path}")
> +        else:
> +            shutil.copy2(src_path, dest_path)
> +            logging.debug(f"Copied module file: {src_path} to {dest_path}")
> +
> +    # Create bitbake_setup module
> +    bitbake_setup_dir = Path(workspace_dir / "src" / "bitbake_setup")
> +    bitbake_setup_dir.mkdir(exist_ok=True)
> +    Path(bitbake_setup_dir / "__init__.py").touch()
> +    shutil.copy2(Path(__file__).parents[2] / "bin" / "bitbake-setup", str(bitbake_setup_dir / "__main__.py"))
> +
> +    # Create codegen module
> +    codegen_dir = Path(workspace_dir / "src" / "codegen")
> +    codegen_dir.mkdir(exist_ok=True)
> +    Path(codegen_dir / "__init__.py").touch()
> +    shutil.copy2(Path(__file__).parents[2] / "lib" / "codegen.py", str(codegen_dir / "__main__.py"))
> +
> +    # Copy tests
> +    tests_dir = Path(workspace_dir / "tests")
> +    tests_dir.mkdir(exist_ok=True)
> +    shutil.copytree(Path(__file__).parents[2] / "contrib" / "pypi" / "tests", str(tests_dir), dirs_exist_ok=True)
> +
> +
> +if __name__ == "__main__":
> +    logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
> +
> +    parser = argparse.ArgumentParser(description='Package bitbake-setup for PyPI')
> +    parser.add_argument('-v', '--verbose', action='store_true', help='increase output verbosity.')
> +    parser.add_argument('-d', '--directory', type=str, help='specify the directory to create the packaging workspace in.')
> +
> +    args = parser.parse_args();
> +
> +    if args.verbose:
> +        logging.getLogger().setLevel(logging.DEBUG)
> +
> +    create_packaging_workspace(args.directory);
> diff --git a/contrib/pypi/pyproject.toml b/contrib/pypi/pyproject.toml
> new file mode 100644
> index 00000000..53d5ffc1
> --- /dev/null
> +++ b/contrib/pypi/pyproject.toml
> @@ -0,0 +1,97 @@
> +[build-system]
> +requires = [
> +    "setuptools>=64",
> +    "setuptools_scm[toml]>=8",
> +]
> +build-backend = "setuptools.build_meta"
> +
> +[project]
> +name = "bitbake-setup"
> +dynamic = ["version"]
> +description = "bitbake-setup"
> +readme = "README.md"
> +requires-python = ">=3.9"
> +license = "GPL-2.0-only AND MIT"
> +authors = [
> +  { name = "OpenEmbedded BitBake Developers", email = "bitbake-devel@lists.openembedded.org" }
> +]
> +classifiers = [
> +  "Programming Language :: Python :: 3",
> +  "Operating System :: POSIX :: Linux",
> +]
> +
> +dependencies = [
> +  # BitBake is mostly self-contained
> +]
> +
> +[project.optional-dependencies]
> +test = [
> +  "pytest>=7",
> +]
> +
> +lint = [
> +  "ruff>=0.3",
> +  "mypy>=1.8",
> +]
> +
> +dev = [
> +  "nox>=2022.11.21",
> +  "pytest>=7",
> +  "ruff>=0.3",
> +  "mypy>=1.8",
> +  "build",
> +  "twine",
> +]
> +
> +[project.scripts]
> +bitbake-setup = "bitbake_setup.__main__:main"
> +
> +[project.urls]
> +Homepage = "https://git.openembedded.org/bitbake/"
> +Documentation = "https://docs.yoctoproject.org/bitbake/dev/bitbake-user-manual/"
> +Repository = "https://git.openembedded.org/bitbake/"
> +
> +[tool.mypy]
> +python_version = "3.9"
> +warn_unused_configs = true
> +ignore_missing_imports = true
> +no_implicit_optional = true
> +check_untyped_defs = false
> +
> +[tool.ruff]
> +target-version = "py39"
> +line-length = 88
> +src = ["src"]
> +
> +[tool.ruff.lint]
> +select = [
> +  "E",   # pycodestyle
> +  "F",   # pyflakes
> +  "B",   # flake8-bugbear
> +  "I",   # import sorting
> +]
> +ignore = [
> +  "E501",  # line length (handled by formatter)
> +]
> +
> +[tool.ruff.format]
> +quote-style = "double"
> +indent-style = "space"
> +
> +[tool.setuptools]
> +package-dir = { "" = "src" }
> +zip-safe = false
> +include-package-data = true
> +
> +[tool.setuptools.packages.find]
> +where = ["src"]
> +include = [
> +  "bb*",
> +  "bitbake_setup",
> +  "bs4*",
> +  "codegen",
> +  "ply"
> +]
> +
> +[tool.setuptools_scm]
> +fallback_version = "0.0.0"
> \ No newline at end of file
> diff --git a/contrib/pypi/tests/test_install.py b/contrib/pypi/tests/test_install.py
> new file mode 100644
> index 00000000..26c28261
> --- /dev/null
> +++ b/contrib/pypi/tests/test_install.py
> @@ -0,0 +1,17 @@
> +import subprocess
> +import sys
> +
> +def test_imports():
> +    import bb
> +    import bs4
> +    import ply
> +    import bitbake_setup
> +
> +def test_console_script():
> +    result = subprocess.run(
> +        ["bitbake-setup", "--help"],
> +        stdout=subprocess.PIPE,
> +        stderr=subprocess.PIPE,
> +        text=True,
> +    )
> +    assert result.returncode == 0
> --
> 2.49.0
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18891): https://lists.openembedded.org/g/bitbake-devel/message/18891
> Mute This Topic: https://lists.openembedded.org/mt/117490846/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

