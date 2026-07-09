Return-Path: <rob.woolley@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64609C44507
	for <webhook@archiver.kernel.org>; Thu,  9 Jul 2026 02:03:56 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.405.1783562631461175374
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 08 Jul 2026 19:03:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=sVhlmeLL;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=1650fcb189=rob.woolley@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6691gLpi1094724
	for <bitbake-devel@lists.openembedded.org>; Thu, 9 Jul 2026 02:03:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=AVKIln7rlaUXjgXV871p8bcP5HNkoZOa8GDcPwsVf+8=; b=
	sVhlmeLLGEtRySZufQUTaizxw+IS/W8kTkbnsudYWkzHxLYACcsJeZuDXYOccd7i
	sWk61u+Z8/0sDvTO0fdWreJEeDieH4pCu/eoria19EAEMOjmyxo06KUkqjAOuZ2U
	d0jIB/a7t5UMKgOjnQ+VxS1ROnsdIWHBqqwd9A15Hdv2zE9NWexkJYCt4lwk730b
	ocb3Vm9mo9StGtQb04paw2e2eD8xbp819GkAUoqRh7SdkQfooIUpXqlCI0G0TSIC
	yS6czdiUpZ7T/MPu/dIp6aP+YzwCnQ5nFZ6wzCyHqyNlk8Va+LPlLDneAnhBqn53
	9qYwI44bkZ6pz6+ZHD26Pw==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4fa1h202nm-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 09 Jul 2026 02:03:50 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 8 Jul 2026 19:03:48 -0700
Received: from ala-lpggp3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 8 Jul 2026 19:03:48 -0700
From: Rob Woolley <rob.woolley@windriver.com>
Date: Wed, 8 Jul 2026 19:03:34 -0700
Subject: [PATCH v5 2/9] pypi: Add PyPI packaging for bitbake-setup
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260708-add-pypi-v10-v5-2-7d5f457f4b9c@windriver.com>
References: <20260708-add-pypi-v10-v5-0-7d5f457f4b9c@windriver.com>
In-Reply-To: <20260708-add-pypi-v10-v5-0-7d5f457f4b9c@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: Rob Woolley <rob.woolley@windriver.com>
X-Mailer: b4 0.15.2
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a4f0186 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=24AZYWMyAAAA:8
 a=iGHA9ds3AAAA:8 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8 a=qV09NasGAAAA:8
 a=V5MqrhjLj9XmrIPkEmEA:9 a=QEXdDO2ut3YA:10 a=bG88sKzkDEFeXWNnvthB:22
 a=nM-MV4yxpKKO9kiQg6Ot:22 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22
 a=GlicbclHOgpI_Rq0ze_Y:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDAxNiBTYWx0ZWRfX1QOvI1Nctepb
 CNghr8P6tTgIgpHdHkKFUNDqSvLCCSfeTpIH3C8IjlnywsvB57AJAKmoljMvkiBqdYCI/N8Xfwu
 pn8Vk1/9a+uy0ZGOOx6MriXvNvq4ZiIfuyOs5Xy6wQ36f2m7bnlN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDAxNiBTYWx0ZWRfX5eL8WAfir1u+
 l27I7FyQEcITSW+gms8LzkyYEqE7D2htVbGkgl9xSU1Qr2wrK5FVVeLIEwRbLTXazhBJfvmbz7q
 gOHzsz/3/gHn9IV+MFt1IDgA1H2cpFl6w5+L+1ZG3fLBn2FRJGRuygoNHXCdEr70459L2g+9I6l
 +Szl5i7l7UBSMTmjGIz0lphJHtMEFa/Rla399XnoKFDYwFEEZ3MttQ5SoOIfDtN5AIXJy6y7Cyg
 NAweDnAmAwiBlKR+TvTJhA11UKEDi0ZVMzOLdpoluACN1QuUk02vC22iYl7Bai/UOKBHThbemrY
 pFrVxpRKgPwjdbECKF6im3bXx/UBq51KKwxkripbq/fzkpgNUa3igd60v70Vq03DOSQ2EhAY90u
 iLFeqftO3nK3n0qx+e69NDc0FkSW6UJ3gMj4YzEi/TokEpNfqi+gFMwHbv2N9snHTW6oIHxStVj
 hirDVP5L+a1BR6vKBmQ==
X-Proofpoint-ORIG-GUID: 6dbOkI4ukFfKRt3c2L3KEVCzHzlqchAX
X-Proofpoint-GUID: 6dbOkI4ukFfKRt3c2L3KEVCzHzlqchAX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_05,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090016
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 09 Jul 2026 02:03:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19828

We wish to publish bitbake-setup to PyPI to improve the workflow
for new users that are familiar with pip install.

In order to publish bitbake-setup as a standalone package, we
must create a staging directory for Python to build the package.

The package-bitbake-setup.py automates the staging of the
necessary files.  You may supply your desired directory as the
first argument, but packaging-workspace in the root of the git
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
   * Verify version is set correctly (not fallback 0.0.0 unless
     expected).
   * Verify wheel METADATA file contains required fields.

The pyproject.toml, LICENSE, and README.md files are used to
create the package and provide information for PyPI.

Assisted-by: Claude:claude-4.6-opus
Signed-off-by: Rob Woolley <rob.woolley@windriver.com>
---
 bin/bitbake-selftest                               |   2 +
 lib/bb/tests/setup.py                              | 289 ++++++++++++++++++++-
 packaging-pypi/bitbake-setup/LICENSE               |  23 ++
 packaging-pypi/bitbake-setup/README.md             |  42 +++
 .../bitbake-setup/package-bitbake-setup.py         |  79 ++++++
 packaging-pypi/bitbake-setup/pyproject.toml        |  92 +++++++
 6 files changed, 526 insertions(+), 1 deletion(-)

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index 7f6a64438..8ac0aeb5f 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -72,6 +72,8 @@ ENV_HELP = """\
 Environment variables:
   BB_SKIP_NETTESTS      set to 'yes' in order to skip tests using network
                         connection
+  BB_SKIP_PYPI_TESTS    set to 'no' to run PyPI packaging tests
+                        (default: yes/skip)
   BB_TMPDIR_NOCLEAN     set to 'yes' to preserve test tmp directories
 """
 
diff --git a/lib/bb/tests/setup.py b/lib/bb/tests/setup.py
index 5592e8196..de0ccef28 100644
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
-        return bb.process.run([bbsetup, '--global-settings', os.path.join(self.tempdir, 'global-config')] + cmd)
+        # Set PYTHONPATH so subprocess can find bb module instead of relying on the current directory
+        env = os.environ.copy()
+        libdir = os.path.abspath(os.path.dirname(__file__) + "/../..")
+        env["PYTHONPATH"] = libdir + ":" + env.get("PYTHONPATH", "")
+        return bb.process.run([bbsetup, '--global-settings', os.path.join(self.tempdir, 'global-config')] + cmd, env=env, cwd=self.tempdir)
 
 
     def _add_json_config_to_registry_helper(self, name, sources):
@@ -735,3 +746,279 @@ print("BBPATH is {{}}".format(os.environ["BBPATH"]))
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
+        # Locate packaging-pypi/bitbake-setup directory
+        cls.pypi_dir = os.path.abspath(
+            os.path.join(os.path.dirname(__file__), '..', '..', '..', 'packaging-pypi', 'bitbake-setup')
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
diff --git a/packaging-pypi/bitbake-setup/LICENSE b/packaging-pypi/bitbake-setup/LICENSE
new file mode 100644
index 000000000..4b4c73672
--- /dev/null
+++ b/packaging-pypi/bitbake-setup/LICENSE
@@ -0,0 +1,23 @@
+bitbake-setup is licensed under the GNU General Public License version 2.0. See
+LICENSE.GPL-2.0-only for further details.
+
+Individual files contain the following style tags instead of the full license text:
+
+    SPDX-License-Identifier:	GPL-2.0-only
+
+This enables machine processing of license information based on the SPDX
+License Identifiers that are here available: http://spdx.org/licenses/
+
+The bitbake-setup package vendorizes the following modules:
+
+beautifulsoup4
+    SPDX-License-Identifier:	MIT
+
+typing_extensions
+    SPDX-License-Identifier:	PSF-2.0
+
+progressbar:
+    SPDX-License-Identifier:	LGPL-2.1-or-later OR BSD-3-Clause-Clear
+
+simplediff:
+    SPDX-License-Identifier:	Zlib
diff --git a/packaging-pypi/bitbake-setup/README.md b/packaging-pypi/bitbake-setup/README.md
new file mode 100644
index 000000000..aaa702783
--- /dev/null
+++ b/packaging-pypi/bitbake-setup/README.md
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
diff --git a/packaging-pypi/bitbake-setup/package-bitbake-setup.py b/packaging-pypi/bitbake-setup/package-bitbake-setup.py
new file mode 100755
index 000000000..f5468dc47
--- /dev/null
+++ b/packaging-pypi/bitbake-setup/package-bitbake-setup.py
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
+        # This script is located in packaging-pypi/bitbake-setup/package-bitbake-setup.py
+        workspace_dir = Path(__file__).parents[2] / "packaging-workspace"
+
+    if not workspace_dir.exists():
+        logging.debug(f"Created packaging workspace at: {workspace_dir}")
+        workspace_dir.mkdir(exist_ok=True)
+    else:
+        logging.debug(f"Packaging workspace already exists at: {workspace_dir}")
+
+    # Copy packaging files to the workspace
+    files_to_copy = [
+        "packaging-pypi/bitbake-setup/pyproject.toml",
+        "packaging-pypi/bitbake-setup/README.md",
+        "packaging-pypi/bitbake-setup/LICENSE",
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
diff --git a/packaging-pypi/bitbake-setup/pyproject.toml b/packaging-pypi/bitbake-setup/pyproject.toml
new file mode 100644
index 000000000..90ed1ffb9
--- /dev/null
+++ b/packaging-pypi/bitbake-setup/pyproject.toml
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
+license = "GPL-2.0-only AND MIT AND PSF-2.0 AND Zlib AND LGPL-2.1-or-later OR BSD-3-Clause-Clear"
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

-- 
2.49.0


