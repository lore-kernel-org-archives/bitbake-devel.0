Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F28D340A6
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 16:05:21 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15116.1769529915542139021
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Jan 2026 08:05:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=GMp5DY4N;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=5487f82e02=rob.woolley@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBpuZ9880612
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 08:05:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=hTYhKnLxVNuUm/l03MebA2owk9jYisP3RLBtLE5TNng=; b=GMp5DY4Nz+TU
	0d/5SVe3euhjgUWwgc/5SLZiiDTubIc0t/813wZfb75mbgc3exoOsu1820c2nOci
	Oy/sI0jFCdvTTlBfFpE5cJDcbdiqjtEKo791ktEfYgpmhQl1dFVd5sdFLiq4hDkJ
	G0T+9g7dw1DAvk6MSjLCsH6KmAvRZTPGHv14qsbUWjU5DpwUEnBzx+Dk7bK9iBp4
	uTBCG71bX37PomoXcTAiH+tT9HVDifKJgOKNZmLABKtecMgIH6sTBeRL0oOD2UDH
	otaaS0C6y0i/2c+uGJVs6+7JhJszZTXQXmHh9JNwdEmHvTWDXQvmvYaoTrldoStR
	qCWOJd/vJw==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bvxfm33xy-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 08:05:14 -0800 (PST)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Tue, 27 Jan 2026 08:05:13 -0800
Received: from ala-lpggp2.wrs.com (10.11.232.110) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Tue, 27 Jan 2026 08:05:13 -0800
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH v2 02/10] bitbake-setup: Add pypi packaging
Date: Tue, 27 Jan 2026 08:04:59 -0800
Message-ID: <20260127160508.3392732-3-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127160508.3392732-1-rob.woolley@windriver.com>
References: <20260127160508.3392732-1-rob.woolley@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FhNNxPC2NPaDGleMYWiLpqxfR-E1kLLX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEzMSBTYWx0ZWRfX/VPAdnJXGO1B
 PNbENhb5dXtzty9ot3JMbzPBuWd0gxMW6jX5iXk+2bT6j6mMg/p8ALlSxfmCcgIs/IFOLu9Vujb
 Cpzj/o6mhTKsG5ft8tyT5hE9CBvf0480JFWqYwMyBHrHUs1nRD5FyjeCOd2ahYnKcWdyxQKQL1g
 UR/Ex5HjuvRnERsVNDpcxpyyrAobjfetOsbro9E6xqnDm4aAjrMmkaGKNLEnsseIgZ3doMubemj
 csOYKxVFt+W4frQ+aVMdXUOyudxLS0fiPWloSJwrShepD5SoJWLbTkLGsEohn14KkzmOUMkkogi
 eKPOj0pQxRO35XyzkVdaU6qB7g34aNZdAnzdCZ8wdfbWpdqAsrqz0PMxU2dk6SvBmZ5uGret8BO
 qQE7Xdq97zpEDxtKL3fylDrdw4U3NmDd8caIkcaWd2a3ssXgwweUEU77d4uJiKF2/slW+oo34Us
 13pjiJD7parcx7FfQpQ==
X-Authority-Analysis: v=2.4 cv=Lo+fC3dc c=1 sm=1 tr=0 ts=6978e23b cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=24AZYWMyAAAA:8 a=iGHA9ds3AAAA:8
 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8 a=qV09NasGAAAA:8 a=ue5rBGj6qoDf4QOmq34A:9
 a=abPTvJue_RwA:10 a=bG88sKzkDEFeXWNnvthB:22 a=nM-MV4yxpKKO9kiQg6Ot:22
 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22 a=GlicbclHOgpI_Rq0ze_Y:22
X-Proofpoint-GUID: FhNNxPC2NPaDGleMYWiLpqxfR-E1kLLX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270131
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Jan 2026 16:05:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18891

Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 .gitignore                            |  1 +
 contrib/pypi/BUILD.md                 | 57 ++++++++++++++++
 contrib/pypi/LICENSE                  |  9 +++
 contrib/pypi/README.md                | 42 ++++++++++++
 contrib/pypi/noxfile.py               | 30 +++++++++
 contrib/pypi/package-bitbake-setup.py | 93 +++++++++++++++++++++++++
 contrib/pypi/pyproject.toml           | 97 +++++++++++++++++++++++++++
 contrib/pypi/tests/test_install.py    | 17 +++++
 8 files changed, 346 insertions(+)
 create mode 100644 contrib/pypi/BUILD.md
 create mode 100644 contrib/pypi/LICENSE
 create mode 100644 contrib/pypi/README.md
 create mode 100644 contrib/pypi/noxfile.py
 create mode 100755 contrib/pypi/package-bitbake-setup.py
 create mode 100644 contrib/pypi/pyproject.toml
 create mode 100644 contrib/pypi/tests/test_install.py

diff --git a/.gitignore b/.gitignore
index a6a256b2..9a5c4ec4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -17,3 +17,4 @@ lib/toaster/contrib/tts/backlog.txt
 lib/toaster/contrib/tts/log/*
 lib/toaster/contrib/tts/.cache/*
 lib/bb/tests/runqueue-tests/bitbake-cookerdaemon.log
+packaging_workspace/
diff --git a/contrib/pypi/BUILD.md b/contrib/pypi/BUILD.md
new file mode 100644
index 00000000..3c50b6e1
--- /dev/null
+++ b/contrib/pypi/BUILD.md
@@ -0,0 +1,57 @@
+# Development Instructions
+
+## Requirements
+
+- Python >= 3.9
+- pip >= 19 (for installation)
+- git (for SCM-based versioning)
+
+## Automated testing
+
+The steps to lint, build, and test the bitbake-setup pypi packaging have been automated with the nox tool.  This tool automatically creates a Python virtual environment for you.
+
+To run the linters do:
+```bash
+nox -s lint
+```
+
+To run the build do:
+```bash
+nox -s build
+```
+
+To run the tests do:
+```bash
+nox -s tests
+```
+
+## Manual Steps
+
+### Building
+
+To install the development tools manually run:
+```bash
+python3 -m pip install -e '.[dev]'
+```
+
+To build a wheel (.whl) then use:
+```bash
+python3 -m build
+```
+
+This produces a wheel (.whl) file in the dist directory.  This may be installed using pip.
+
+### Testing
+
+```bash
+python3 -m pip install -e '.[test]'
+pytest
+```
+
+### Linting
+
+```bash
+python3 -m pip install -e '.[lint]'
+
+ruff check src/bitbake_setup
+```
\ No newline at end of file
diff --git a/contrib/pypi/LICENSE b/contrib/pypi/LICENSE
new file mode 100644
index 00000000..f9b44182
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
index 00000000..a6dd99e0
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
diff --git a/contrib/pypi/noxfile.py b/contrib/pypi/noxfile.py
new file mode 100644
index 00000000..ab226547
--- /dev/null
+++ b/contrib/pypi/noxfile.py
@@ -0,0 +1,30 @@
+#!/usr/bin/env python3
+
+import glob
+import nox
+from pathlib import Path
+
+nox.options.sessions = ["lint", "tests", "build"]
+
+@nox.session
+def lint(session):
+    session.install("ruff", "mypy")
+    session.run("ruff", "check", "src/bitbake_setup")
+    # Ignore mypy for now as there are too many errors in imported modules
+    # session.run("mypy", "src/bitbake_setup")
+
+@nox.session
+def tests(session):
+    session.install(".[test]")
+    session.run("pytest")
+
+@nox.session
+def build(session):
+    session.install("build", "twine")
+    session.run("python", "-m", "build")
+
+    # Verify the wheel installs cleanly
+    wheels = list(Path("dist").glob("*.whl"))
+    session.install(str(wheels[0]))
+    session.run("bitbake-setup", "--help")
+    session.run("bitbake-setup", "list")
\ No newline at end of file
diff --git a/contrib/pypi/package-bitbake-setup.py b/contrib/pypi/package-bitbake-setup.py
new file mode 100755
index 00000000..3a07e911
--- /dev/null
+++ b/contrib/pypi/package-bitbake-setup.py
@@ -0,0 +1,93 @@
+#!/usr/bin/env python3
+
+import argparse
+import logging
+import os
+import shutil
+from pathlib import Path
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
+        "contrib/pypi/noxfile.py",
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
+    modules_to_copy = [
+        "lib/bb",
+        "lib/bs4",
+        "lib/ply"
+    ]
+
+    for module in modules_to_copy:
+        src_path = Path(__file__).parents[2] / module
+        dest_path = workspace_dir / "src" / Path(module).name
+
+        if src_path.is_dir():
+            shutil.copytree(src_path, dest_path, dirs_exist_ok=True)
+            logging.debug(f"Copied module directory: {src_path} to {dest_path}")
+        else:
+            shutil.copy2(src_path, dest_path)
+            logging.debug(f"Copied module file: {src_path} to {dest_path}")
+
+    # Create bitbake_setup module
+    bitbake_setup_dir = Path(workspace_dir / "src" / "bitbake_setup")
+    bitbake_setup_dir.mkdir(exist_ok=True)
+    Path(bitbake_setup_dir / "__init__.py").touch()
+    shutil.copy2(Path(__file__).parents[2] / "bin" / "bitbake-setup", str(bitbake_setup_dir / "__main__.py"))
+
+    # Create codegen module
+    codegen_dir = Path(workspace_dir / "src" / "codegen")
+    codegen_dir.mkdir(exist_ok=True)
+    Path(codegen_dir / "__init__.py").touch()
+    shutil.copy2(Path(__file__).parents[2] / "lib" / "codegen.py", str(codegen_dir / "__main__.py"))
+
+    # Copy tests
+    tests_dir = Path(workspace_dir / "tests")
+    tests_dir.mkdir(exist_ok=True)
+    shutil.copytree(Path(__file__).parents[2] / "contrib" / "pypi" / "tests", str(tests_dir), dirs_exist_ok=True)
+
+
+if __name__ == "__main__":
+    logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
+
+    parser = argparse.ArgumentParser(description='Package bitbake-setup for PyPI')
+    parser.add_argument('-v', '--verbose', action='store_true', help='increase output verbosity.')
+    parser.add_argument('-d', '--directory', type=str, help='specify the directory to create the packaging workspace in.')
+
+    args = parser.parse_args();
+
+    if args.verbose:
+        logging.getLogger().setLevel(logging.DEBUG)
+
+    create_packaging_workspace(args.directory);
diff --git a/contrib/pypi/pyproject.toml b/contrib/pypi/pyproject.toml
new file mode 100644
index 00000000..53d5ffc1
--- /dev/null
+++ b/contrib/pypi/pyproject.toml
@@ -0,0 +1,97 @@
+[build-system]
+requires = [
+    "setuptools>=64",
+    "setuptools_scm[toml]>=8",
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
+  # BitBake is mostly self-contained
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
+  "nox>=2022.11.21",
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
+Documentation = "https://docs.yoctoproject.org/bitbake/dev/bitbake-user-manual/"
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
+[tool.setuptools.packages.find]
+where = ["src"]
+include = [
+  "bb*",
+  "bitbake_setup",
+  "bs4*",
+  "codegen",
+  "ply"
+]
+
+[tool.setuptools_scm]
+fallback_version = "0.0.0"
\ No newline at end of file
diff --git a/contrib/pypi/tests/test_install.py b/contrib/pypi/tests/test_install.py
new file mode 100644
index 00000000..26c28261
--- /dev/null
+++ b/contrib/pypi/tests/test_install.py
@@ -0,0 +1,17 @@
+import subprocess
+import sys
+
+def test_imports():
+    import bb
+    import bs4
+    import ply
+    import bitbake_setup
+
+def test_console_script():
+    result = subprocess.run(
+        ["bitbake-setup", "--help"],
+        stdout=subprocess.PIPE,
+        stderr=subprocess.PIPE,
+        text=True,
+    )
+    assert result.returncode == 0
-- 
2.49.0


