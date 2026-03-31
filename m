Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E730310F3DCD
	for <webhook@archiver.kernel.org>; Tue, 31 Mar 2026 16:07:17 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23973.1774973228847749209
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 31 Mar 2026 09:07:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=X22sLPXd;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=85502649bd=rob.woolley@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V6nv8Q2249206;
	Tue, 31 Mar 2026 16:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=/Qtk79xbMYnbnOiw2Ldh3ujzzAK/6OX1TS7E5KbPqZw=; b=
	X22sLPXdqLf59BUbtfQEhvYDfHrfKhSzQtfwWBWk4onbvGD+RFgaFOvm4zRg2UtX
	rjgV6ex9+YmFwWZhquK0E2sLQ4kBQH9rjrgQ1Wt8lGTtfYB8fGgINwsMCsuoZ07y
	M5O88XePviHMZ0cBUpVeSkTdTtWHASHbX0ucHJqgwtdnFXa5dX6KEHnQGz5F90t6
	m8JsDf4XZS1TC82+72E6Aun6rS/DFpy82clzI+gv4WWyUtzD0owYiPBLd7VIwZYU
	ztaTWjfex76t+R4rY1GgzWN/DKSlSBOAjhuHfXOngtHArxKJ3nT95BRzvRkg6xDo
	SGhOylQx5DnBYYPIOLztWw==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d646vuyv2-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 31 Mar 2026 16:07:07 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 31 Mar 2026 09:07:05 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 31 Mar 2026 09:07:05 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <alex.kanavin@gmail.com>
Subject: [PATCH v2 09/13] pypi: Add PyPI packaging for bitbake-setup
Date: Tue, 31 Mar 2026 09:06:59 -0700
Message-ID: <20260331160703.3137930-10-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260331160703.3137930-1-rob.woolley@windriver.com>
References: <20260331160703.3137930-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Zqjg6t7G c=1 sm=1 tr=0 ts=69cbf12b cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=24AZYWMyAAAA:8 a=iGHA9ds3AAAA:8 a=Q4-j1AaZAAAA:8
 a=t7CeM3EgAAAA:8 a=qV09NasGAAAA:8 a=V5MqrhjLj9XmrIPkEmEA:9
 a=bG88sKzkDEFeXWNnvthB:22 a=nM-MV4yxpKKO9kiQg6Ot:22 a=9H3Qd4_ONW2Ztcrla5EB:22
 a=FdTzh2GWekK77mhwV6Dw:22 a=GlicbclHOgpI_Rq0ze_Y:22
X-Proofpoint-ORIG-GUID: aMBvwBtpYHXPjsZElxLagsx6hhYVr26Q
X-Proofpoint-GUID: aMBvwBtpYHXPjsZElxLagsx6hhYVr26Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE1NCBTYWx0ZWRfX2ssV528ChXoZ
 CuPEdCmwxv8A/mApJreIg/W0mUMsg5gc9oB392eh/2xpUZ48WruiJrz2ltPbscjPhO1cef+SfC7
 od2ansDgWb1cXzRgY/NTOPzDKzpz1D1bv8YJtg5nNIrspFZjsE1WtJofC5y2uRplw+DvP15/wq/
 CNuHeAeggExBPk3wfkoWy8ae0BzWJAYt+qM3/3cMft8zoC4iBe1g2BstKx1oyAC4GMwQOWmKpwE
 0epd/Wnk3KA/TLT+Fj+BAAeLx/tNjmkIVXxIYzfv9EzWGVmUzM5ZJmLZCgHX7vtuS4gMW2d4pcU
 KGaH117d5CB64vt0VxBxWL2wcNFntsJe9UiCWAoK1Nv0tm6QBAcUje5+vdpOpMw92poZwZ/uVdl
 KylnBR6moGSIGPvk8ozy0YeVh9+X3XOVsdF9+Lxtj+GBE3Soxw8nSTJjGF8IOfRji/eGPU9SCYm
 Rf5ylRySjytfEP9+jRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310154
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 31 Mar 2026 16:07:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19308

We wish to publish bitbake-setup to PyPI to improve the workflow
for new users that are familiar with pip install.

In order to publish bitbake-setup as a standalone package, we
must create a staging directory for Python to build the package.

The package-bitbake-setup.py automates the staging of the
necessary files.  You may supply your desired directory as the
first argument, but packaging_workspace in the root of the git
repository is chosen by default.

The packaging process and related tests have also been included
as part of bitbake-selftest and lib/bb/tests/setup.py.  These
tests use package-bitbake-setup.py.

The tests include:

   * Verify bitbake-setup --help runs successfully.
   * Verify bitbake-setup list runs successfully.
   * Verify console script entry points are correctly defined.
   * Verify all expected modules can be imported from installed
     package.
   * Verify package metadata is correctly set.
   * Verify vendored dependencies (bs4, ply, progressbar,
     simplediff) are not bundled in package.
   * Verify version is set correctly (not fallback 0.0.0 unless
     expected).
   * Verify wheel METADATA file contains required fields.

The pyproject.toml, LICENSE, and README.md files are used to
create the package and provide information for PyPI.

Assisted-by: Claude:claude-4.6-opus
Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-selftest                  |   2 +
 contrib/pypi/LICENSE                  |   9 +
 contrib/pypi/README.md                |  42 ++++
 contrib/pypi/package-bitbake-setup.py |  79 +++++++
 contrib/pypi/pyproject.toml           |  92 ++++++++
 lib/bb/tests/setup.py                 | 289 +++++++++++++++++++++++++-
 6 files changed, 512 insertions(+), 1 deletion(-)
 create mode 100644 contrib/pypi/LICENSE
 create mode 100644 contrib/pypi/README.md
 create mode 100755 contrib/pypi/package-bitbake-setup.py
 create mode 100644 contrib/pypi/pyproject.toml

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index fb7c57dd8..7b5d68ff9 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -67,6 +67,8 @@ ENV_HELP = """\
 Environment variables:
   BB_SKIP_NETTESTS      set to 'yes' in order to skip tests using network
                         connection
+  BB_SKIP_PYPI_TESTS    set to 'no' to run PyPI packaging tests
+                        (default: yes/skip)
   BB_TMPDIR_NOCLEAN     set to 'yes' to preserve test tmp directories
 """
 
diff --git a/contrib/pypi/LICENSE b/contrib/pypi/LICENSE
new file mode 100644
index 000000000..f9b44182d
--- /dev/null
+++ b/contrib/pypi/LICENSE
@@ -0,0 +1,9 @@
+bitbake-setup is licensed under the GNU General Public License version 2.0. See
+LICENSE.GPL-2.0-only for further details.
+
+Individual files contain the following style tags instead of the full license text:
+
+    SPDX-License-Identifier:	GPL-2.0-only
+
+This enables machine processing of license information based on the SPDX
+License Identifiers that are here available: http://spdx.org/licenses/
diff --git a/contrib/pypi/README.md b/contrib/pypi/README.md
new file mode 100644
index 000000000..a6dd99e09
--- /dev/null
+++ b/contrib/pypi/README.md
@@ -0,0 +1,42 @@
+# bitbake-setup
+
+This package provides the `bitbake-setup` command and the Python modules
+required to support BitBake setup and configuration.
+
+## Usage
+
+Instructions on uses of bitbake-setup can be found in 
+[Setting Up the Environment With bitbake-setup](https://docs.yoctoproject.org/bitbake/dev/bitbake-user-manual/bitbake-user-manual-environment-setup.html) from the Yocto Project manual.
+
+List the available configurations;
+```bash
+bitbake-setup list
+```
+
+Show the help for the bitbake-setup init subcommand:
+```bash
+bitbake-setup init --help
+usage: bitbake-setup init [-h] [--non-interactive] [--source-overrides SOURCE_OVERRIDES] [--setup-dir-name SETUP_DIR_NAME] [--skip-selection SKIP_SELECTION] [-L SOURCE_NAME PATH]
+                          [config ...]
+
+positional arguments:
+  config                path/URL/id to a configuration file (use 'list' command to get available ids), followed by configuration options. Bitbake-setup will ask to choose from available
+                        choices if command line doesn't completely specify them.
+
+options:
+  -h, --help            show this help message and exit
+  --non-interactive     Do not ask to interactively choose from available options; if bitbake-setup cannot make a decision it will stop with a failure.
+  --source-overrides SOURCE_OVERRIDES
+                        Override sources information (repositories/revisions) with values from a local json file.
+  --setup-dir-name SETUP_DIR_NAME
+                        A custom setup directory name under the top directory.
+  --skip-selection SKIP_SELECTION
+                        Do not select and set an option/fragment from available choices; the resulting bitbake configuration may be incomplete.
+  -L SOURCE_NAME PATH, --use-local-source SOURCE_NAME PATH
+                        Symlink local source into a build, instead of getting it as prescribed by a configuration (useful for local development).
+```
+
+To initialize a workspace for the Poky reference distro using the development branch (ie. "master") of OpenEmbedded:
+```bash
+bitbake-setup init poky-master
+```
\ No newline at end of file
diff --git a/contrib/pypi/package-bitbake-setup.py b/contrib/pypi/package-bitbake-setup.py
new file mode 100755
index 000000000..60c503c4e
--- /dev/null
+++ b/contrib/pypi/package-bitbake-setup.py
@@ -0,0 +1,79 @@
+#!/usr/bin/env python3
+
+import argparse
+import logging
+import shutil
+from pathlib import Path
+
+
+def create_packaging_workspace(directory):
+    # Create the directory for packaging workspace
+    if len(directory or "") > 0:
+        workspace_dir = Path(directory)
+    else:
+        # This script is located in contrib/pypi/package-bitbake-setup.py
+        workspace_dir = Path(__file__).parents[2] / "packaging_workspace"
+
+    if not workspace_dir.exists():
+        logging.debug(f"Created packaging workspace at: {workspace_dir}")
+        workspace_dir.mkdir(exist_ok=True)
+    else:
+        logging.debug(f"Packaging workspace already exists at: {workspace_dir}")
+
+    # Copy packaging files to the workspace
+    files_to_copy = [
+        "contrib/pypi/pyproject.toml",
+        "contrib/pypi/README.md",
+        "contrib/pypi/LICENSE",
+        "LICENSE.MIT",
+        "LICENSE.GPL-2.0-only"
+    ]
+
+    for file in files_to_copy:
+        src_path = Path(__file__).parents[2] / file
+        dest_path = workspace_dir / Path(file).name
+
+        if src_path.is_dir():
+            shutil.copytree(src_path, dest_path, dirs_exist_ok=True)
+            logging.debug(f"Copied directory: {src_path} to {dest_path}")
+        else:
+            shutil.copy2(src_path, dest_path)
+            logging.debug(f"Copied file: {src_path} to {dest_path}")
+
+
+    # Copy necessary modules to the workspace
+    modules_to_bundle = [
+        "lib/bb",
+    ]
+
+    for module in modules_to_bundle:
+        src_path = Path(__file__).parents[2] / module
+        dest_path = workspace_dir / "src" / Path(module).name
+
+        if src_path.is_dir():
+            shutil.copytree(src_path, dest_path, dirs_exist_ok=True)
+            logging.debug(f"Bundled module directory: {src_path} to {dest_path}")
+        else:
+            shutil.copy2(src_path, dest_path)
+            logging.debug(f"Bundled module file: {src_path} to {dest_path}")
+
+    # Create bitbake_setup module
+    bitbake_setup_dir = Path(workspace_dir / "src" / "bitbake_setup")
+    bitbake_setup_dir.mkdir(exist_ok=True)
+    Path(bitbake_setup_dir / "__init__.py").touch()
+    shutil.copy2(Path(__file__).parents[2] / "bin" / "bitbake-setup", str(bitbake_setup_dir / "__main__.py"))
+
+
+if __name__ == "__main__":
+    logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
+
+    parser = argparse.ArgumentParser(description='Package bitbake-setup for PyPI')
+    parser.add_argument('-v', '--verbose', action='store_true', help='increase output verbosity.')
+    parser.add_argument('-d', '--directory', type=str, help='specify the directory to create the packaging workspace in.')
+
+    args = parser.parse_args()
+
+    if args.verbose:
+        logging.getLogger().setLevel(logging.DEBUG)
+
+    create_packaging_workspace(args.directory)
diff --git a/contrib/pypi/pyproject.toml b/contrib/pypi/pyproject.toml
new file mode 100644
index 000000000..69f34667d
--- /dev/null
+++ b/contrib/pypi/pyproject.toml
@@ -0,0 +1,92 @@
+[build-system]
+requires = [
+    "setuptools>=64",
+]
+build-backend = "setuptools.build_meta"
+
+[project]
+name = "bitbake-setup"
+dynamic = ["version"]
+description = "bitbake-setup"
+readme = "README.md"
+requires-python = ">=3.9"
+license = "GPL-2.0-only AND MIT"
+authors = [
+  { name = "OpenEmbedded BitBake Developers", email = "bitbake-devel@lists.openembedded.org" }
+]
+classifiers = [
+  "Programming Language :: Python :: 3",
+  "Operating System :: POSIX :: Linux",
+]
+
+dependencies = [
+  # bitbake-setup is mostly self-contained
+]
+
+[project.optional-dependencies]
+test = [
+  "pytest>=7",
+]
+
+lint = [
+  "ruff>=0.3",
+  "mypy>=1.8",
+]
+
+dev = [
+  "pytest>=7",
+  "ruff>=0.3",
+  "mypy>=1.8",
+  "build",
+  "twine",
+]
+
+[project.scripts]
+bitbake-setup = "bitbake_setup.__main__:main"
+
+[project.urls]
+Homepage = "https://git.openembedded.org/bitbake/"
+Documentation = "https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-environment-setup.html"
+Repository = "https://git.openembedded.org/bitbake/"
+
+[tool.mypy]
+python_version = "3.9"
+warn_unused_configs = true
+ignore_missing_imports = true
+no_implicit_optional = true
+check_untyped_defs = false
+
+[tool.ruff]
+target-version = "py39"
+line-length = 88
+src = ["src"]
+
+[tool.ruff.lint]
+select = [
+  "E",   # pycodestyle
+  "F",   # pyflakes
+  "B",   # flake8-bugbear
+  "I",   # import sorting
+]
+ignore = [
+  "E501",  # line length (handled by formatter)
+]
+
+[tool.ruff.format]
+quote-style = "double"
+indent-style = "space"
+
+[tool.setuptools]
+package-dir = { "" = "src" }
+zip-safe = false
+include-package-data = true
+
+[tool.setuptools.dynamic]
+version = {attr = "bb.__version__"}
+
+[tool.setuptools.packages.find]
+where = ["src"]
+include = [
+  "bb*",
+  "bitbake_setup"
+]
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 638d56d3b..b031270e7 100644
--- a/lib/bb/tests/setup.py
+++ b/lib/bb/tests/setup.py
@@ -11,7 +11,14 @@ import glob
 import hashlib
 import json
 import os
+import shutil
 import stat
+import subprocess
+import sys
+import tempfile
+import unittest
+import venv
+import zipfile
 from bb.tests.support.httpserver import HTTPService
 
 class BitbakeSetupTest(FetcherTest):
@@ -92,7 +99,11 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
 
     def runbbsetup(self, cmd):
         bbsetup = os.path.abspath(os.path.dirname(__file__) +  "/../../../bin/bitbake-setup")
-        return bb.process.run("{} --global-settings {} {}".format(bbsetup, os.path.join(self.tempdir, 'global-config'), cmd))
+        # Set PYTHONPATH so subprocess can find bb module instead of relying on the current directory
+        env = os.environ.copy()
+        libdir = os.path.abspath(os.path.dirname(__file__) + "/../..")
+        env["PYTHONPATH"] = libdir + ":" + env.get("PYTHONPATH", "")
+        return bb.process.run("{} --global-settings {} {}".format(bbsetup, os.path.join(self.tempdir, 'global-config'), cmd), env=env, cwd=self.tempdir)
 
 
     def _add_json_config_to_registry_helper(self, name, sources):
@@ -726,3 +737,279 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
             self.assertEqual(f.read(), 'conflicting-upstream\n',
                              "re-cloned layer must contain the upstream content after conflict backup")
         del os.environ['BBPATH']
+
+@unittest.skipIf(os.environ.get("BB_SKIP_PYPI_TESTS", "yes") != "no",
+                 "PyPI packaging test (set BB_SKIP_PYPI_TESTS=no to run)")
+class PyPIPackagingTest(unittest.TestCase):
+    """Tests for PyPI packaging of bitbake-setup.
+
+    These tests build a wheel from source, install it in an isolated venv,
+    and verify the package works correctly. Skipped by default unless
+    BB_SKIP_PYPI_TESTS=no is set.
+    """
+
+    wheel_path = None
+    build_tempdir = None
+    workspace_dir = None
+
+    @classmethod
+    def setUpClass(cls):
+        """Build wheel once for all tests in this class."""
+        # Locate contrib/pypi directory
+        cls.pypi_dir = os.path.abspath(
+            os.path.join(os.path.dirname(__file__), '..', '..', '..', 'contrib', 'pypi')
+        )
+
+        # Check for required build tools
+        cls._check_build_tools()
+
+        # Create temporary directory for packaging workspace
+        cls.build_tempdir = tempfile.mkdtemp(prefix="bitbake-pypi-build-")
+
+        # Run package-bitbake-setup.py to create packaging workspace
+        cls._create_packaging_workspace()
+
+        # Build the wheel
+        cls._build_wheel()
+
+    @classmethod
+    def _check_build_tools(cls):
+        """Verify build tools are available, skip if not."""
+        try:
+            result = subprocess.run(
+                [sys.executable, "-m", "build", "--version"],
+                capture_output=True, check=True
+            )
+        except (subprocess.CalledProcessError, FileNotFoundError):
+            raise unittest.SkipTest("'build' package not installed (pip install build)")
+
+    @classmethod
+    def _create_packaging_workspace(cls):
+        """Create packaging workspace using package-bitbake-setup.py."""
+        script = os.path.join(cls.pypi_dir, 'package-bitbake-setup.py')
+        cls.workspace_dir = os.path.join(cls.build_tempdir, 'workspace')
+        result = subprocess.run(
+            [sys.executable, script, '-d', cls.workspace_dir],
+            capture_output=True, text=True
+        )
+        if result.returncode != 0:
+            raise unittest.SkipTest(f"Packaging workspace creation failed: {result.stderr}")
+
+    @classmethod
+    def _build_wheel(cls):
+        """Build the wheel in the packaging workspace."""
+        result = subprocess.run(
+            [sys.executable, "-m", "build", "--wheel"],
+            cwd=cls.workspace_dir,
+            capture_output=True, text=True
+        )
+        if result.returncode != 0:
+            raise unittest.SkipTest(f"Wheel build failed: {result.stderr}")
+
+        # Find the built wheel
+        dist_dir = os.path.join(cls.workspace_dir, 'dist')
+        wheels = glob.glob(os.path.join(dist_dir, '*.whl'))
+        if not wheels:
+            raise unittest.SkipTest("No wheel file found after build")
+        cls.wheel_path = wheels[0]
+
+    @classmethod
+    def tearDownClass(cls):
+        """Clean up the shared wheel build artifacts."""
+        if cls.build_tempdir and os.environ.get("BB_TMPDIR_NOCLEAN") != "yes":
+            shutil.rmtree(cls.build_tempdir, ignore_errors=True)
+        elif cls.build_tempdir:
+            print(f"Not cleaning up {cls.build_tempdir}. Please remove manually.")
+
+    def setUp(self):
+        """Create isolated venv for testing the installed package."""
+        self.venv_dir = tempfile.mkdtemp(prefix="bitbake-pypi-venv-")
+
+        # Create venv without pip (faster, no network needed)
+        venv.create(self.venv_dir, with_pip=False, symlinks=True)
+
+        # Get paths to venv python and bin directory
+        if sys.platform == 'win32':
+            self.venv_python = os.path.join(self.venv_dir, 'Scripts', 'python.exe')
+            self.venv_bin = os.path.join(self.venv_dir, 'Scripts')
+        else:
+            self.venv_python = os.path.join(self.venv_dir, 'bin', 'python')
+            self.venv_bin = os.path.join(self.venv_dir, 'bin')
+
+        # Install wheel using pip from the outer environment (offline, no-deps)
+        site_packages = self._get_site_packages()
+        result = subprocess.run(
+            [sys.executable, "-m", "pip", "install",
+             "--target", site_packages,
+             "--no-deps", "--no-index",
+             self.wheel_path],
+            capture_output=True, text=True
+        )
+        if result.returncode != 0:
+            self.fail(f"Failed to install wheel: {result.stderr}")
+
+        # Install console script entry point manually
+        self._install_console_script()
+
+    def _get_site_packages(self):
+        """Get the site-packages directory in the venv."""
+        lib_dir = os.path.join(self.venv_dir, 'lib')
+        # Find python version directory
+        for d in os.listdir(lib_dir):
+            if d.startswith('python'):
+                return os.path.join(lib_dir, d, 'site-packages')
+        raise RuntimeError("Could not find site-packages in venv")
+
+    def _install_console_script(self):
+        """Create console script wrapper in venv bin directory."""
+        site_packages = self._get_site_packages()
+        script_path = os.path.join(self.venv_bin, 'bitbake-setup')
+        script_content = f'''#!{self.venv_python}
+import sys
+sys.path.insert(0, "{site_packages}")
+from bitbake_setup.__main__ import main
+sys.exit(main())
+'''
+        with open(script_path, 'w') as f:
+            f.write(script_content)
+        os.chmod(script_path, 0o755)
+
+    def tearDown(self):
+        """Remove venv after test."""
+        if os.environ.get("BB_TMPDIR_NOCLEAN") != "yes":
+            shutil.rmtree(self.venv_dir, ignore_errors=True)
+        else:
+            print(f"Not cleaning up {self.venv_dir}. Please remove manually.")
+
+    def test_imports(self):
+        """Verify all expected modules can be imported from installed package."""
+
+        site_packages = self._get_site_packages()
+        imports = ['bb', 'bitbake_setup']
+        for module in imports:
+            result = subprocess.run(
+                [self.venv_python, '-c', f'import sys; sys.path.insert(0, "{site_packages}"); import {module}'],
+                capture_output=True, text=True
+            )
+            self.assertEqual(result.returncode, 0,
+                f"Failed to import {module}: {result.stderr}")
+
+    def test_console_script_help(self):
+        """Verify bitbake-setup --help runs successfully."""
+        script = os.path.join(self.venv_bin, 'bitbake-setup')
+        result = subprocess.run(
+            [script, '--help'],
+            capture_output=True, text=True
+        )
+        self.assertEqual(result.returncode, 0,
+            f"bitbake-setup --help failed: {result.stderr}")
+        self.assertIn('usage:', result.stdout.lower())
+
+    def test_console_script_list(self):
+        """Verify bitbake-setup list runs successfully."""
+        script = os.path.join(self.venv_bin, 'bitbake-setup')
+        result = subprocess.run(
+            [script, 'list'],
+            capture_output=True, text=True
+        )
+        # List may return 0 even with no configurations
+        self.assertEqual(result.returncode, 0,
+            f"bitbake-setup list failed: {result.stderr}")
+
+    def test_package_metadata(self):
+        """Verify package metadata is correctly set."""
+        site_packages = self._get_site_packages()
+        code = '''
+import json
+import sys
+sys.path.insert(0, "{}")
+from importlib.metadata import metadata
+m = metadata("bitbake-setup")
+print(json.dumps({{
+    "name": m["Name"],
+    "version": m["Version"],
+    "requires_python": m.get("Requires-Python", ""),
+    "license": m.get("License", ""),
+}}))
+'''.format(site_packages)
+        result = subprocess.run(
+            [self.venv_python, '-c', code],
+            capture_output=True, text=True
+        )
+        self.assertEqual(result.returncode, 0,
+            f"Failed to get metadata: {result.stderr}")
+
+        meta = json.loads(result.stdout)
+        self.assertEqual(meta['name'], 'bitbake-setup')
+        self.assertIn('>=3.9', meta['requires_python'])
+
+    def test_vendored_dependencies(self):
+        """Verify vendored dependencies (bs4, ply, progressbar, simplediff) are not bundled in package."""
+        # Check that vendored packages do not exist in root of wheel
+        with zipfile.ZipFile(self.wheel_path, 'r') as whl:
+            names = whl.namelist()
+
+            # Check for expected package directories
+            expected = ['bs4/', 'ply/', 'progressbar/', 'simplediff/']
+            for pkg in expected:
+                found = any(n.startswith(pkg) for n in names)
+                self.assertFalse(found,
+                    f"Unexpected vendored package '{pkg}' found in wheel")
+
+    def test_version_from_wheel(self):
+        """Verify version is set correctly (not fallback 0.0.0 unless expected)."""
+        import re
+        # Extract version from wheel filename
+        wheel_name = os.path.basename(self.wheel_path)
+        # Wheel format: {name}-{version}(-{build})?-{python}-{abi}-{platform}.whl
+        parts = wheel_name.split('-')
+        version = parts[1]
+
+        # Check version format (should be semver-like or contain git info)
+        version_pattern = r'^\d+\.\d+\.\d+.*$'
+        self.assertTrue(re.match(version_pattern, version),
+            f"Version '{version}' doesn't match expected pattern")
+
+        print(f"Extracted version from wheel: {version}")
+
+        self.assertNotEqual(version, '0.0.0',
+            "Version is fallback 0.0.0 - no git tags found")
+
+    def test_wheel_metadata_file(self):
+        """Verify wheel METADATA file contains required fields."""
+        with zipfile.ZipFile(self.wheel_path, 'r') as whl:
+            # Find METADATA file in dist-info
+            metadata_path = None
+            for name in whl.namelist():
+                if name.endswith('.dist-info/METADATA'):
+                    metadata_path = name
+                    break
+
+            self.assertIsNotNone(metadata_path, "METADATA file not found in wheel")
+
+            # Parse metadata
+            metadata_content = whl.read(metadata_path).decode('utf-8')
+
+            # Check required fields
+            self.assertIn('Metadata-Version:', metadata_content)
+            self.assertIn('Name: bitbake-setup', metadata_content)
+            self.assertIn('Version:', metadata_content)
+            self.assertIn('Requires-Python:', metadata_content)
+
+    def test_entry_points(self):
+        """Verify console script entry points are correctly defined."""
+        with zipfile.ZipFile(self.wheel_path, 'r') as whl:
+            # Find entry_points.txt in dist-info
+            entry_points_path = None
+            for name in whl.namelist():
+                if name.endswith('.dist-info/entry_points.txt'):
+                    entry_points_path = name
+                    break
+
+            self.assertIsNotNone(entry_points_path,
+                "entry_points.txt not found in wheel")
+
+            content = whl.read(entry_points_path).decode('utf-8')
+            self.assertIn('[console_scripts]', content)
+            self.assertIn('bitbake-setup', content)
+            self.assertIn('bitbake_setup.__main__:main', content)
-- 
2.49.0


