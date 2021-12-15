Return-Path: <pontus.jaensson@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52526C433F5
	for <webhook@archiver.kernel.org>; Wed, 15 Dec 2021 14:25:07 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web08.40922.1639578305881487217
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Dec 2021 06:25:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=In8zFhYt;
 spf=pass (domain: axis.com, ip: 195.60.68.17,
 mailfrom: pontus.jaensson@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1639578306;
  x=1671114306;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2kEcLq6vDTkn05mgH9t8EidIn4mUYdvaC4fYLZ+larA=;
  b=In8zFhYtRzmvyw7mWcApqpWv9mEb0Q1G1G+fR9DjTCV0wD+CnDDIMimM
   39FsJiaa6N+tkgRRFcmaqEMxU4lDMYCTAmgxAojNXn7UV1rqhzQfa4JpD
   8OfAza6wxEaFIIborAPewkSuXG0lgfTbRPXAtwUl3DV3a0QG3iHGDKy5W
   W1sCk4/7FEArToNc5IFDBwDXY7ZACBhit6LzU6OhmbVL7fc70Ej61Kaac
   oPVxKQSFESZkG7gWtzjXUQrGXYE9Ewb9pq2VWbfXQWXq+xiRlbxGpm8ph
   EyQrIK9PIwIjXHi/WixHAHl6TGryNJLXqy3jskT25yBkpELpmvAJ+Tn+8
   w==;
From: Pontus Jaensson <pontusja@axis.com>
To: <bitbake-devel@lists.openembedded.org>
CC: <fredrik.gustafsson@axis.com>, Pontus Jaensson <pontusja@axis.com>
Subject: [RFC] Implementation of a submodule fetcher
Date: Wed, 15 Dec 2021 15:24:50 +0100
Message-ID: <20211215142449.13469-1-pontusja@lap5cg1077w4w.se.axis.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Dec 2021 14:25:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13168

From: Pontus Jaensson <pontusja@axis.com>

This patch consists of a Submodule class which inherits from and extends the FetchMethod-class
for retrieving, initializing and updating a submodule directory. The main reason for implementing
it is to make it possible to track the version of a packet with git instead of just a recipe.

The submodule fetcher is used by using the following syntax in the SRC_URI field in the recipe:
SRC_URI = submodule://<PATH TO TOP LEVEL DIRECTORY>;localpath=<NAME OF THE WANTED SUBMODULE>.
Where the submodule-keyword is necessary to use in order to call this specific fetcher.

In the download-method the URI is then parsed and the relevant parts from it are extracted and
used to find information about the module in the .gitmodules-file in the top level git directory.
The final thing that happens in the download-method is that git submodule init & git submodule
update are called and executed at the right location for the specified submodule.

In the unpack-method the empty directory, that is being created during the process but contains no
information, is removed and replaced with a symlink to the directory that contains the actual
source code.

The code has been tested and so far it seems to work fine.
---
 bitbake/lib/bb/fetch2/__init__.py  |   2 +
 bitbake/lib/bb/fetch2/submodule.py | 123 +++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+)
 create mode 100644 bitbake/lib/bb/fetch2/submodule.py

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 6a38cb0955..a87e0b5338 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1923,6 +1923,7 @@ class FetchConnectionCache(object):
 from . import cvs
 from . import git
 from . import gitsm
+from . import submodule
 from . import gitannex
 from . import local
 from . import svn
@@ -1945,6 +1946,7 @@ methods.append(wget.Wget())
 methods.append(svn.Svn())
 methods.append(git.Git())
 methods.append(gitsm.GitSM())
+methods.append(submodule.Submodule())
 methods.append(gitannex.GitANNEX())
 methods.append(cvs.Cvs())
 methods.append(ssh.SSH())
diff --git a/bitbake/lib/bb/fetch2/submodule.py b/bitbake/lib/bb/fetch2/submodule.py
new file mode 100644
index 0000000000..ef46404c2e
--- /dev/null
+++ b/bitbake/lib/bb/fetch2/submodule.py
@@ -0,0 +1,123 @@
+"""
+BitBake 'Fetch' implementation for local git submodules.
+
+Inherits from and extends the FetchMethod for retrieving, initializing and
+updating a submodule directory.
+
+SRC_URI = "submodule://<PATH TO TOP LEVEL GIT DIRECTORY>;localpath=<SUBMODULE NAME>"
+
+NOTE: If the name of the submodule contains space(s), please indicate this by placing
+the <SUBMODULE NAME> within a single quotation mark and replace the space(s) with a
+backslash (\). Ex) If the submodule name is: name with spaces, then write the
+following: localpath='name\with\spaces'.
+
+"""
+
+# Pontus Jaensson 2021
+#
+# SPDX-License-Identifier: GPL-2.0-only
+#
+
+import os
+import subprocess
+from re import compile
+from bb.fetch2 import FetchMethod
+
+class Submodule(FetchMethod):
+
+    def supports(self, ud, d):
+        """
+        Checks if the given url can be fetched with submodule.
+        """
+        return ud.type in ['submodule']
+
+    def download(self, ud, d):
+        """
+        Finds the path and the location to the submodule in the local .gitmodules
+        file and then passes it to the execution method.
+        """
+        module_path, module_location = self._prepare_module_data(ud.url)
+
+        self._run_command(f'git submodule init {module_path}', module_location)
+        self._run_command(f'git submodule update {module_path}', module_location)
+
+    def unpack(self, ud, root, d):
+        """
+        Is called once the 'download' of the submodule has been completed in order
+        to ensure that the source code is in the right location thanks to symlinks.
+        """
+        path, location = self._prepare_module_data(ud.url)
+        abs_path = location + path
+
+        try:
+            subprocess.check_output(['rm', '-r', 'gitmodule'])
+            subprocess.check_output(['ln', '-s', abs_path, 'gitmodule'])
+        except subprocess.CalledProcessError as e:
+            raise Exception(f'Failed setting up the symlinks correctly') from e
+
+    def _run_command(self, cmd, location):
+        """
+        Runs the provided cmd command at the path specified by the location argument.
+        Raises an error if the location is unvalid or if the cmd command fails.
+        """
+        try:
+            modules_git_command = cmd.split(' ')[:3]
+            module_path = cmd.split(' ')[3:]
+            os.chdir(location)
+            if len(module_path) > 1:
+                module_path = [' '.join(module_path)]
+            cmd_array = modules_git_command + module_path
+            subprocess.check_output(cmd_array)
+        except OSError as e:
+            raise Exception(f'Not able to change current working directory to: {location}') from e
+        except subprocess.CalledProcessError as e:
+            raise Exception(f'Not able to run command: {cmd} at {location}') from e
+
+    def _parse_url(self, url):
+        """
+        Helper method for deconstructing the url from the user data.
+        """
+        res = compile('([^:]*)://(([^/;]+)@)?(?P<location>[^;]+)(;(?P<submodule>.*))?').match(url)
+        module_location = res.group('location') + '/'
+        submodule = res.group('submodule').split('=')[1]
+        return module_location, submodule
+
+    def _prepare_module_data(self, url):
+        """
+        Helper method for preparing and processing the submodule data based on the
+        url provided.
+        """
+        module_location, name = self._parse_url(url)
+        modules_path = os.path.abspath(module_location + '.gitmodules')
+        try:
+            with open(modules_path) as file:
+                gitmodule_data = file.readlines()
+        except:
+            raise Exception(f'Could not open .gitmodules file located at: {modules_path}')
+
+        return self._process_submodules_info(gitmodule_data, name), module_location
+
+    def _process_submodules_info(self, gitmodule_data, wanted_module):
+        """
+        Helper method for iterating through the provided gitmodule_data in order to find
+        the path to the wanted_module. Returns it if it is found otherwise raises an Exception.
+        """
+        module_path = ''
+
+        if wanted_module[0] == wanted_module[-1] == "'":
+            wanted_module = wanted_module[1:-1].replace('\\', ' ')
+
+        for line in gitmodule_data:
+            if line.startswith('[submodule'):
+                name = line.split('"')[1]
+                if name == wanted_module:
+                    current_module = True
+                else:
+                    current_module = False
+            elif line.strip().startswith('path') and current_module:
+                module_path = line.split('=')[1].strip()
+                break
+        if module_path:
+            return module_path
+        else:
+            raise ValueError(f'{wanted_module} is not a valid submodule name.')
-- 
2.20.1


