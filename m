Return-Path: <antonin.godard@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0A4C369D5
	for <webhook@archiver.kernel.org>; Fri, 18 Apr 2025 15:16:01 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
 by mx.groups.io with SMTP id smtpd.web10.14029.1744989353773508640
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 18 Apr 2025 08:15:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=paoV0Ld9;
 spf=pass (domain: bootlin.com, ip: 217.70.183.196, mailfrom: antonin.godard@bootlin.com)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 00FE343ACE;
	Fri, 18 Apr 2025 15:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744989352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yg3sigk3D64hZ6QgZjMUqXb6K3DrdvkCRigijWjNhCo=;
	b=paoV0Ld97aZRzzDGDhVvA3vpQvHDfdX1ICCt3tKMOvq6tlN8jG0ZnBonS7LHSpJqVz1cJx
	p8sgBJfxBEHIrs1b+s0++cbKp0HiDJS5lBNA1zRwYNRkazzuBqrMJyJyRLqVR9TQQr26x4
	f1qMhjVKpiUipYDVVJeYHJ0io4iA++NKjicAh9njvXQBddUvU7ivZcVJiJvpVQm5mG4ggR
	91u65i3zSM1r6yAFj02PvTwGCtzAevJMGpG5dl9kSOLkeq55JhPEosa9OUHdUUfYZRa4nx
	/AmfPxjAyJzn1hpA9hYy1EJAc1kz/5ZRTk9mNGGNapZJUklf1CJwou7yclgTKg==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Fri, 18 Apr 2025 17:15:25 +0200
Subject: [PATCH 1/4] utils: format and improve docstrings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-library-functions-v1-1-3bbb836149d7@bootlin.com>
References: <20250418-library-functions-v1-0-3bbb836149d7@bootlin.com>
In-Reply-To: <20250418-library-functions-v1-0-3bbb836149d7@bootlin.com>
To: bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 docs@lists.yoctoproject.org, Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=37552;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=lNJ5KqhSJN8+XzCcdaCSzoIHkhiMyO/eBeVSABJw8vQ=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBoAmymgRg5Z/tWNBGuhmx/jd1P/kBQHwa/m9/4C
 6Pv+E6eXCCJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCaAJspgAKCRDRgEFAKaOo
 NpYkEACOKkNaFq5kUgMb4aD+BPyo9oX02sO0a1XPXcnznElLzFHpuABUUZIMSf/oTfoX7m26Al+
 2UZDGGA+rf3TihpQu0ldEbtkT88XrViJCrTFsfClfn4MK04gF+shmxu6IbR446Lxpss7yNFHhx0
 YiC0NXI1KEuABcDNaRjmQCQOI5e8xUBsX5jzikM+713V16iSv3Dlbwlfxy7x2rf1R5RV53hM10p
 kIYaRGJa1WCWHRb/aMJIxWHj+20GuLoYz8Z4Q5whSE0sdaGD5lDq/6H+BqDDnx6jrfC5SrGGwfh
 0PeJrYdnvnw2z1jjQmUgz9LobelJcDxCMJfNrLeOUPitFUbvjBI1poTBpUYvU1fkx7KMOKeyef5
 lheVXN3hzcCr+J/nhXR2WV6VZatSODIbR/QQQ1u01RVguy5Mfssz3zqqs7Rq4NKp1c/yhI/Z1aw
 ZA8hVgAMhvdNmRroZAxP6/1zKs+vmjBJ1gyc0791F8KSW9d2dBSBOqj0RbMK7CPbKTcVqRIVx2y
 KFrCDfwCcqrNytCtpQuXfuMnOO1KpE/cMPbzHc/a4A/Ooh2cqKMB1HAv7DL9WJLB5ezIOogR2WW
 vr4DTRVOk4hhx8VbByHOXEXflZcNQjai0gwEppCq1nwXzusIYgkwxR7QHvUdhMIjvplMMMz7SsG
 kXNt7uod/a8B/BA==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvfedvgeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedtgeekfeeitdelkedvkeetjedvffejudelheeluddufffgveejuedujeejiefhffenucffohhmrghinhepughivgdrnhgvthdpshgvmhhvvghrrdhorhhgnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemudejtgdvmeefkeejrgemfheiheemhedvfeehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmedujegtvdemfeekjegrmehfieehmeehvdefhedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeegpdhrtghpthhtoheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmp
 dhrtghpthhtohepughotghssehlihhsthhsrdihohgtthhophhrohhjvggtthdrohhrghdprhgtphhtthhopegsihhtsggrkhgvqdguvghvvghlsehlihhsthhsrdhophgvnhgvmhgsvgguuggvugdrohhrgh
X-GND-Sasl: antonin.godard@bootlin.com
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 18 Apr 2025 15:16:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17536

Format the docstrings of the utils modules to be automatically
documented with the autodoc Sphinx extensions. Sphinx syntax can be used
in those for proper formatting. Cross-referencing with :term: is not
possible in these.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 lib/bb/utils.py | 601 ++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 453 insertions(+), 148 deletions(-)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index 5486f9599..32de30979 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -82,7 +82,16 @@ def explode_version(s):
     return r
 
 def split_version(s):
-    """Split a version string into its constituent parts (PE, PV, PR)"""
+    """Split a version string into its constituent parts (PE, PV, PR).
+
+    Arguments:
+
+    -  ``s``: version string. The format of the input string should be::
+
+          ${PE}:${PV}-${PR}
+
+    Returns a tuple ``(pe, pv, pr)``.
+    """
     s = s.strip(" <>=")
     e = 0
     if s.count(':'):
@@ -134,16 +143,30 @@ def vercmp(ta, tb):
     return r
 
 def vercmp_string(a, b):
-    """ Split version strings and compare them """
+    """ Split version strings using ``bb.utils.split_version()`` and compare
+    them with ``bb.utils.vercmp().``
+
+    Arguments:
+
+    -  ``a``: left version string operand.
+    -  ``b``: right version string operand.
+
+    Returns what ``bb.utils.vercmp()`` returns."""
     ta = split_version(a)
     tb = split_version(b)
     return vercmp(ta, tb)
 
 def vercmp_string_op(a, b, op):
     """
-    Compare two versions and check if the specified comparison operator matches the result of the comparison.
-    This function is fairly liberal about what operators it will accept since there are a variety of styles
-    depending on the context.
+    Takes the return value ``bb.utils.vercmp()`` and returns the operation
+    defined by ``op`` between the return value and 0.
+
+    Arguments:
+
+    -  ``a``: left version string operand.
+    -  ``b``: right version string operand.
+    -  ``op``: operator string. Can be one of ``=``, ``==``, ``<=``, ``>=``,
+       ``>``, ``>>``, ``<``, ``<<`` or ``!=``.
     """
     res = vercmp_string(a, b)
     if op in ('=', '=='):
@@ -163,9 +186,16 @@ def vercmp_string_op(a, b, op):
 
 def explode_deps(s):
     """
-    Take an RDEPENDS style string of format:
-    "DEPEND1 (optional version) DEPEND2 (optional version) ..."
-    and return a list of dependencies.
+    Takes an RDEPENDS style string of format::
+
+      DEPEND1 (optional version) DEPEND2 (optional version) ...
+
+    Arguments:
+
+    -  ``s``: input RDEPENDS style string
+
+    Returns a list of dependencies.
+
     Version information is ignored.
     """
     r = []
@@ -187,9 +217,17 @@ def explode_deps(s):
 
 def explode_dep_versions2(s, *, sort=True):
     """
-    Take an RDEPENDS style string of format:
-    "DEPEND1 (optional version) DEPEND2 (optional version) ..."
-    and return a dictionary of dependencies and versions.
+    Takes an RDEPENDS style string of format::
+
+       DEPEND1 (optional version) DEPEND2 (optional version) ...
+
+    Arguments:
+
+    -  ``s``: input RDEPENDS style string
+    -  ``*``: *Unused*.
+    -  ``sort``: whether to sort the output or not.
+
+    Returns a dictionary of dependencies and versions.
     """
     r = collections.OrderedDict()
     l = s.replace(",", "").split()
@@ -254,10 +292,17 @@ def explode_dep_versions2(s, *, sort=True):
 
 def explode_dep_versions(s):
     """
-    Take an RDEPENDS style string of format:
-    "DEPEND1 (optional version) DEPEND2 (optional version) ..."
-    skip null value and items appeared in dependency string multiple times
-    and return a dictionary of dependencies and versions.
+    Take an RDEPENDS style string of format::
+
+      DEPEND1 (optional version) DEPEND2 (optional version) ...
+
+    Skips null values and items appeared in dependency string multiple times.
+
+    Arguments:
+
+    -  ``s``: input RDEPENDS style string
+
+    Returns a dictionary of dependencies and versions.
     """
     r = explode_dep_versions2(s)
     for d in r:
@@ -271,7 +316,17 @@ def explode_dep_versions(s):
 
 def join_deps(deps, commasep=True):
     """
-    Take the result from explode_dep_versions and generate a dependency string
+    Take a result from ``bb.utils.explode_dep_versions()`` and generate a
+    dependency string.
+
+    Arguments:
+
+    -  ``deps``: dictionary of dependencies and versions.
+    -  ``commasep``: makes the return value separated by commas if ``True``,
+       separated by spaces otherwise.
+
+    Returns a comma-separated (space-separated if ``comma-sep`` is ``False``)
+    string of dependencies and versions.
     """
     result = []
     for dep in deps:
@@ -433,7 +488,11 @@ def better_eval(source, locals, extraglobals = None):
 
 @contextmanager
 def fileslocked(files, *args, **kwargs):
-    """Context manager for locking and unlocking file locks."""
+    """Context manager for locking and unlocking file locks. Uses
+    ``bb.utils.lockfile()`` and ``bb.utils.unlockfile()`` to lock and unlock
+    files.
+
+    No return value."""
     locks = []
     if files:
         for lockfile in files:
@@ -450,14 +509,23 @@ def fileslocked(files, *args, **kwargs):
 
 def lockfile(name, shared=False, retry=True, block=False):
     """
-    Use the specified file as a lock file, return when the lock has
-    been acquired. Returns a variable to pass to unlockfile().
-    Parameters:
-        retry: True to re-try locking if it fails, False otherwise
-        block: True to block until the lock succeeds, False otherwise
+    Use the specified file (with filename ``name``) as a lock file, return when
+    the lock has been acquired. Returns a variable to pass to unlockfile().
+
+    Arguments:
+
+    -  ``shared``: sets the lock as a shared lock instead of an
+       exclusive lock.
+    -  ``retry``: ``True`` to re-try locking if it fails, ``False``
+       otherwise.
+    -  ``block``: ``True`` to block until the lock succeeds,
+       ``False`` otherwise.
+
     The retry and block parameters are kind of equivalent unless you
     consider the possibility of sending a signal to the process to break
     out - at which point you want block=True rather than retry=True.
+
+    Returns the locked file descriptor in case of success, ``None`` otherwise.
     """
     basename = os.path.basename(name)
     if len(basename) > 255:
@@ -516,7 +584,13 @@ def lockfile(name, shared=False, retry=True, block=False):
 
 def unlockfile(lf):
     """
-    Unlock a file locked using lockfile()
+    Unlock a file locked using ``bb.utils.lockfile()``.
+
+    Arguments:
+
+    -  ``lf``: the locked file descriptor.
+
+    No return value.
     """
     try:
         # If we had a shared lock, we need to promote to exclusive before
@@ -544,7 +618,11 @@ def _hasher(method, filename):
 
 def md5_file(filename):
     """
-    Return the hex string representation of the MD5 checksum of filename.
+    Arguments:
+
+    -  ``filename``: path to the input file.
+
+    Returns the hexadecimal string representation of the MD5 checksum of filename.
     """
     import hashlib
     try:
@@ -556,39 +634,59 @@ def md5_file(filename):
 
 def sha256_file(filename):
     """
-    Return the hex string representation of the 256-bit SHA checksum of
+    Returns the hexadecimal representation of the 256-bit SHA checksum of
     filename.
+
+    Arguments:
+
+    -  ``filename``: path to the file.
     """
     import hashlib
     return _hasher(hashlib.sha256(), filename)
 
 def sha1_file(filename):
     """
-    Return the hex string representation of the SHA1 checksum of the filename
+    Returns the hexadecimal representation of the SHA1 checksum of the filename
+
+    Arguments:
+
+    -  ``filename``: path to the file.
     """
     import hashlib
     return _hasher(hashlib.sha1(), filename)
 
 def sha384_file(filename):
     """
-    Return the hex string representation of the SHA384 checksum of the filename
+    Returns the hexadecimal representation of the SHA384 checksum of the filename
+
+    Arguments:
+
+    -  ``filename``: path to the file.
     """
     import hashlib
     return _hasher(hashlib.sha384(), filename)
 
 def sha512_file(filename):
     """
-    Return the hex string representation of the SHA512 checksum of the filename
+    Returns the hexadecimal representation of the SHA512 checksum of the filename
+
+    Arguments:
+
+    -  ``filename``: path to the file.
     """
     import hashlib
     return _hasher(hashlib.sha512(), filename)
 
 def goh1_file(filename):
     """
-    Return the hex string representation of the Go mod h1 checksum of the
+    Returns the hexadecimal string representation of the Go mod h1 checksum of the
     filename. The Go mod h1 checksum uses the Go dirhash package. The package
     defines hashes over directory trees and is used by go mod for mod files and
     zip archives.
+
+    Arguments:
+
+    -  ``filename``: path to the file.
     """
     import hashlib
     import zipfile
@@ -609,8 +707,8 @@ def goh1_file(filename):
     return method.hexdigest()
 
 def preserved_envvars_exported():
-    """Variables which are taken from the environment and placed in and exported
-    from the metadata"""
+    """Returns the list of variables which are taken from the environment and
+    placed in and exported from the metadata."""
     return [
         'BB_TASKHASH',
         'HOME',
@@ -624,7 +722,8 @@ def preserved_envvars_exported():
     ]
 
 def preserved_envvars():
-    """Variables which are taken from the environment and placed in the metadata"""
+    """Returns the list of variables which are taken from the environment and
+    placed in the metadata."""
     v = [
         'BBPATH',
         'BB_PRESERVE_ENV',
@@ -633,7 +732,9 @@ def preserved_envvars():
     return v + preserved_envvars_exported()
 
 def check_system_locale():
-    """Make sure the required system locale are available and configured"""
+    """Make sure the required system locale are available and configured.
+
+    No return value."""
     default_locale = locale.getlocale(locale.LC_CTYPE)
 
     try:
@@ -651,6 +752,12 @@ def filter_environment(good_vars):
     """
     Create a pristine environment for bitbake. This will remove variables that
     are not known and may influence the build in a negative way.
+
+    Arguments:
+
+    -  ``good_vars``: list of variable to exclude from the filtering.
+
+    No return value.
     """
 
     removed_vars = {}
@@ -695,6 +802,8 @@ def clean_environment():
     """
     Clean up any spurious environment variables. This will remove any
     variables the user hasn't chosen to preserve.
+
+    No return value.
     """
     if 'BB_PRESERVE_ENV' not in os.environ:
         good_vars = approved_variables()
@@ -705,6 +814,8 @@ def clean_environment():
 def empty_environment():
     """
     Remove all variables from the environment.
+
+    No return value.
     """
     for s in list(os.environ.keys()):
         os.unsetenv(s)
@@ -713,6 +824,12 @@ def empty_environment():
 def build_environment(d):
     """
     Build an environment from all exported variables.
+
+    Arguments:
+
+    -  ``d``: the data store.
+
+    No return value.
     """
     import bb.data
     for var in bb.data.keys(d):
@@ -737,7 +854,17 @@ def _check_unsafe_delete_path(path):
     return False
 
 def remove(path, recurse=False, ionice=False):
-    """Equivalent to rm -f or rm -rf"""
+    """Equivalent to rm -f or rm -rf.
+
+    Arguments:
+
+    -  ``path``: path to file/directory to remove.
+    -  ``recurse``: deletes recursively if ``True``.
+    -  ``ionice``: prepends ``ionice -c 3`` to the ``rm`` command. See ``man
+       ionice``.
+
+    No return value.
+    """
     if not path:
         return
     if recurse:
@@ -758,7 +885,17 @@ def remove(path, recurse=False, ionice=False):
                 raise
 
 def prunedir(topdir, ionice=False):
-    """ Delete everything reachable from the directory named in 'topdir'. """
+    """
+    Delete everything reachable from the directory named in ``topdir``.
+
+    Arguments:
+
+    -  ``topdir``: directory path.
+    -  ``ionice``: prepends ``ionice -c 3`` to the ``rm`` command. See ``man
+       ionice``.
+
+    No return value.
+    """
     # CAUTION:  This is dangerous!
     if _check_unsafe_delete_path(topdir):
         raise Exception('bb.utils.prunedir: called with dangerous path "%s", refusing to delete!' % topdir)
@@ -770,8 +907,15 @@ def prunedir(topdir, ionice=False):
 #
 def prune_suffix(var, suffixes, d):
     """
-    See if var ends with any of the suffixes listed and
-    remove it if found
+    Check if ``var`` ends with any of the suffixes listed in ``suffixes`` and
+    remove it if found.
+
+    Arguments:
+
+    -  ``var``: string to check for suffixes.
+    -  ``suffixes``: list of strings representing suffixes to check for.
+
+    Returns the string ``var`` without the suffix.
     """
     for suffix in suffixes:
         if suffix and var.endswith(suffix):
@@ -780,7 +924,13 @@ def prune_suffix(var, suffixes, d):
 
 def mkdirhier(directory):
     """Create a directory like 'mkdir -p', but does not complain if
-    directory already exists like os.makedirs
+    directory already exists like ``os.makedirs()``.
+
+    Arguments:
+
+    -  ``directory``: path to the directory.
+
+    No return value.
     """
     if '${' in str(directory):
         bb.fatal("Directory name {} contains unexpanded bitbake variable. This may cause build failures and WORKDIR polution.".format(directory))
@@ -791,10 +941,24 @@ def mkdirhier(directory):
             raise e
 
 def movefile(src, dest, newmtime = None, sstat = None):
-    """Moves a file from src to dest, preserving all permissions and
+    """Moves a file from ``src`` to ``dest``, preserving all permissions and
     attributes; mtime will be preserved even when moving across
-    filesystems.  Returns true on success and false on failure. Move is
+    filesystems.  Returns ``True`` on success and ``False`` on failure. Move is
     atomic.
+
+    Arguments:
+
+    -  ``src`` -- Source file.
+    -  ``dest`` -- Destination file.
+    -  ``newmtime`` -- new mtime to be passed as float seconds since the epoch.
+    -  ``sstat`` -- os.stat_result to use for the destination file.
+
+    Returns an ``os.stat_result`` of the destination file if the
+    source file is a symbolic link or the ``sstat`` argument represents a
+    symbolic link - in which case the destination file will also be created as
+    a symbolic link.
+
+    Otherwise, returns ``newmtime`` on success and ``False`` on failure.
     """
 
     #print "movefile(" + src + "," + dest + "," + str(newmtime) + "," + str(sstat) + ")"
@@ -885,9 +1049,24 @@ def movefile(src, dest, newmtime = None, sstat = None):
 
 def copyfile(src, dest, newmtime = None, sstat = None):
     """
-    Copies a file from src to dest, preserving all permissions and
+    Copies a file from ``src`` to ``dest``, preserving all permissions and
     attributes; mtime will be preserved even when moving across
-    filesystems.  Returns true on success and false on failure.
+    filesystems.
+
+    Arguments:
+
+    -  ``src``: Source file.
+    -  ``dest``: Destination file.
+    -  ``newmtime``: new mtime to be passed as float seconds since the epoch.
+    -  ``sstat``: os.stat_result to use for the destination file.
+
+    Returns an ``os.stat_result`` of the destination file if the
+    source file is a symbolic link or the ``sstat`` argument represents a
+    symbolic link - in which case the destination file will also be created as
+    a symbolic link.
+
+    Otherwise, returns ``newmtime`` on success and ``False`` on failure.
+
     """
     #print "copyfile(" + src + "," + dest + "," + str(newmtime) + "," + str(sstat) + ")"
     try:
@@ -965,10 +1144,16 @@ def copyfile(src, dest, newmtime = None, sstat = None):
 
 def break_hardlinks(src, sstat = None):
     """
-    Ensures src is the only hardlink to this file.  Other hardlinks,
+    Ensures ``src`` is the only hardlink to this file.  Other hardlinks,
     if any, are not affected (other than in their st_nlink value, of
-    course).  Returns true on success and false on failure.
+    course).
 
+    Arguments:
+
+    -  ``src``: source file path.
+    -  ``sstat``: os.stat_result to use when checking if the file is a link.
+
+    Returns ``True`` on success and ``False`` on failure.
     """
     try:
         if not sstat:
@@ -982,11 +1167,24 @@ def break_hardlinks(src, sstat = None):
 
 def which(path, item, direction = 0, history = False, executable=False):
     """
-    Locate `item` in the list of paths `path` (colon separated string like $PATH).
-    If `direction` is non-zero then the list is reversed.
-    If `history` is True then the list of candidates also returned as result,history.
-    If `executable` is True then the candidate has to be an executable file,
-    otherwise the candidate simply has to exist.
+    Locate ``item`` in the list of paths ``path`` (colon separated string like
+    ``$PATH``).
+
+    Arguments:
+
+    -  ``path``: list of colon-separated paths.
+    -  ``item``: string to search for.
+    -  ``direction``: if non-zero then the list is reversed.
+    -  ``history``: if ``True`` then the list of candidates also returned as
+       ``result,history`` where ``history`` is the list of previous path
+       checked.
+    -  ``executable``: if ``True`` then the candidate defined by ``path`` has
+       to be an executable file, otherwise if ``False`` the candidate simply
+       has to exist.
+
+    Returns the item if found in the list of path, otherwise an empty string.
+    If ``history`` is ``True``, return the list of previous path checked in a
+    tuple with the found (or not found) item as ``(item, history)``.
     """
 
     if executable:
@@ -1017,6 +1215,8 @@ def which(path, item, direction = 0, history = False, executable=False):
 def umask(new_mask):
     """
     Context manager to set the umask to a specific mask, and restore it afterwards.
+
+    No return value.
     """
     current_mask = os.umask(new_mask)
     try:
@@ -1027,7 +1227,17 @@ def umask(new_mask):
 def to_boolean(string, default=None):
     """
     Check input string and return boolean value True/False/None
-    depending upon the checks
+    depending upon the checks.
+
+    Arguments:
+
+    -  ``string``: input string.
+    -  ``default``: default return value if the input ``string`` is ``None``,
+       ``0``, ``False`` or an empty string.
+
+    Returns ``True`` if the string is one of "y", "yes", "1", "true", ``False``
+    if the string is one of "n", "no", "0", or "false". Return ``default`` if
+    the input ``string`` is ``None``, ``0``, ``False`` or an empty string.
     """
     if not string:
         return default
@@ -1048,18 +1258,17 @@ def contains(variable, checkvalues, truevalue, falsevalue, d):
 
     Arguments:
 
-    variable -- the variable name. This will be fetched and expanded (using
-    d.getVar(variable)) and then split into a set().
+    -  ``variable``: the variable name. This will be fetched and expanded (using
+       d.getVar(variable)) and then split into a set().
+    -  ``checkvalues``: if this is a string it is split on whitespace into a set(),
+       otherwise coerced directly into a set().
+    -  ``truevalue``: the value to return if checkvalues is a subset of variable.
+    -  ``falsevalue``: the value to return if variable is empty or if checkvalues is
+       not a subset of variable.
+    -  ``d``: the data store.
 
-    checkvalues -- if this is a string it is split on whitespace into a set(),
-    otherwise coerced directly into a set().
-
-    truevalue -- the value to return if checkvalues is a subset of variable.
-
-    falsevalue -- the value to return if variable is empty or if checkvalues is
-    not a subset of variable.
-
-    d -- the data store.
+    Returns ``True`` if the variable contains the values specified, ``False``
+    otherwise.
     """
 
     val = d.getVar(variable)
@@ -1079,18 +1288,17 @@ def contains_any(variable, checkvalues, truevalue, falsevalue, d):
 
     Arguments:
 
-    variable -- the variable name. This will be fetched and expanded (using
-    d.getVar(variable)) and then split into a set().
-
-    checkvalues -- if this is a string it is split on whitespace into a set(),
-    otherwise coerced directly into a set().
-
-    truevalue -- the value to return if checkvalues is a subset of variable.
+    -  ``variable``: the variable name. This will be fetched and expanded (using
+       d.getVar(variable)) and then split into a set().
+    -  ``checkvalues``: if this is a string it is split on whitespace into a set(),
+       otherwise coerced directly into a set().
+    -  ``truevalue``: the value to return if checkvalues is a subset of variable.
+    -  ``falsevalue``: the value to return if variable is empty or if checkvalues is
+       not a subset of variable.
+    -  ``d``: the data store.
 
-    falsevalue -- the value to return if variable is empty or if checkvalues is
-    not a subset of variable.
-
-    d -- the data store.
+    Returns ``True`` if the variable contains any of the values specified,
+    ``False`` otherwise.
     """
     val = d.getVar(variable)
     if not val:
@@ -1105,17 +1313,17 @@ def contains_any(variable, checkvalues, truevalue, falsevalue, d):
     return falsevalue
 
 def filter(variable, checkvalues, d):
-    """Return all words in the variable that are present in the checkvalues.
+    """Return all words in the variable that are present in the ``checkvalues``.
 
     Arguments:
 
-    variable -- the variable name. This will be fetched and expanded (using
-    d.getVar(variable)) and then split into a set().
-
-    checkvalues -- if this is a string it is split on whitespace into a set(),
-    otherwise coerced directly into a set().
+    -  ``variable``: the variable name. This will be fetched and expanded (using
+       d.getVar(variable)) and then split into a set().
+    -  ``checkvalues``: if this is a string it is split on whitespace into a set(),
+       otherwise coerced directly into a set().
+    -  ``d``: the data store.
 
-    d -- the data store.
+    Returns a list of string.
     """
 
     val = d.getVar(variable)
@@ -1131,8 +1339,27 @@ def filter(variable, checkvalues, d):
 
 def get_referenced_vars(start_expr, d):
     """
-    :return: names of vars referenced in start_expr (recursively), in quasi-BFS order (variables within the same level
-    are ordered arbitrarily)
+    Get the names of the variables referenced in a given expression.
+
+    Arguments:
+
+      -  ``start_expr``: the expression where to look for variables references.
+
+         For example::
+
+            ${VAR_A} string ${VAR_B}
+
+         Or::
+
+            ${@d.getVar('VAR')}
+
+         If a variables makes references to other variables, the latter are also
+         returned recursively.
+
+      -  ``d``: the data store.
+
+    Returns the names of vars referenced in ``start_expr`` (recursively), in
+    quasi-BFS order (variables within the same level are ordered arbitrarily).
     """
 
     seen = set()
@@ -1212,7 +1439,9 @@ def multiprocessingpool(*args, **kwargs):
     return multiprocessing.Pool(*args, **kwargs)
 
 def exec_flat_python_func(func, *args, **kwargs):
-    """Execute a flat python function (defined with def funcname(args):...)"""
+    """Execute a flat python function (defined with ``def funcname(args): ...``)
+
+    Returns the return value of the function."""
     # Prepare a small piece of python code which calls the requested function
     # To do this we need to prepare two things - a set of variables we can use to pass
     # the values of arguments into the calling function, and the list of arguments for
@@ -1238,48 +1467,57 @@ def edit_metadata(meta_lines, variables, varfunc, match_overrides=False):
     """Edit lines from a recipe or config file and modify one or more
     specified variable values set in the file using a specified callback
     function. Lines are expected to have trailing newlines.
-    Parameters:
-        meta_lines: lines from the file; can be a list or an iterable
-            (e.g. file pointer)
-        variables: a list of variable names to look for. Functions
-            may also be specified, but must be specified with '()' at
-            the end of the name. Note that the function doesn't have
-            any intrinsic understanding of :append, :prepend, :remove,
-            or overrides, so these are considered as part of the name.
-            These values go into a regular expression, so regular
-            expression syntax is allowed.
-        varfunc: callback function called for every variable matching
-            one of the entries in the variables parameter. The function
-            should take four arguments:
-                varname: name of variable matched
-                origvalue: current value in file
-                op: the operator (e.g. '+=')
-                newlines: list of lines up to this point. You can use
-                    this to prepend lines before this variable setting
-                    if you wish.
-            and should return a four-element tuple:
-                newvalue: new value to substitute in, or None to drop
-                    the variable setting entirely. (If the removal
-                    results in two consecutive blank lines, one of the
-                    blank lines will also be dropped).
-                newop: the operator to use - if you specify None here,
-                    the original operation will be used.
-                indent: number of spaces to indent multi-line entries,
-                    or -1 to indent up to the level of the assignment
-                    and opening quote, or a string to use as the indent.
-                minbreak: True to allow the first element of a
-                    multi-line value to continue on the same line as
-                    the assignment, False to indent before the first
-                    element.
-            To clarify, if you wish not to change the value, then you
-            would return like this: return origvalue, None, 0, True
-        match_overrides: True to match items with _overrides on the end,
-            False otherwise
+
+    Arguments:
+
+    -  ``meta_lines``: lines from the file; can be a list or an iterable
+       (e.g. file pointer)
+    -  ``variables``: a list of variable names to look for. Functions
+       may also be specified, but must be specified with ``()`` at
+       the end of the name. Note that the function doesn't have
+       any intrinsic understanding of ``:append``, ``:prepend``, ``:remove``,
+       or overrides, so these are considered as part of the name.
+       These values go into a regular expression, so regular
+       expression syntax is allowed.
+    -  ``varfunc``: callback function called for every variable matching
+       one of the entries in the variables parameter.
+
+       The function should take four arguments:
+
+       -  ``varname``: name of variable matched
+       -  ``origvalue``: current value in file
+       -  ``op``: the operator (e.g. ``+=``)
+       -  ``newlines``: list of lines up to this point. You can use
+          this to prepend lines before this variable setting
+          if you wish.
+
+       And should return a four-element tuple:
+
+       -  ``newvalue``: new value to substitute in, or ``None`` to drop
+          the variable setting entirely. (If the removal
+          results in two consecutive blank lines, one of the
+          blank lines will also be dropped).
+       -  ``newop``: the operator to use - if you specify ``None`` here,
+          the original operation will be used.
+       -  ``indent``: number of spaces to indent multi-line entries,
+          or ``-1`` to indent up to the level of the assignment
+          and opening quote, or a string to use as the indent.
+       -  ``minbreak``: ``True`` to allow the first element of a
+          multi-line value to continue on the same line as
+          the assignment, ``False`` to indent before the first
+          element.
+
+       To clarify, if you wish not to change the value, then you
+       would return like this::
+
+          return origvalue, None, 0, True
+    -  ``match_overrides``: True to match items with _overrides on the end,
+       False otherwise
+
     Returns a tuple:
-        updated:
-            True if changes were made, False otherwise.
-        newlines:
-            Lines after processing
+
+    -  ``updated``: ``True`` if changes were made, ``False`` otherwise.
+    -  ``newlines``: Lines after processing.
     """
 
     var_res = {}
@@ -1423,12 +1661,13 @@ def edit_metadata(meta_lines, variables, varfunc, match_overrides=False):
 
 
 def edit_metadata_file(meta_file, variables, varfunc):
-    """Edit a recipe or config file and modify one or more specified
+    """Edit a recipe or configuration file and modify one or more specified
     variable values set in the file using a specified callback function.
     The file is only written to if the value(s) actually change.
-    This is basically the file version of edit_metadata(), see that
+    This is basically the file version of ``bb.utils.edit_metadata()``, see that
     function's description for parameter/usage information.
-    Returns True if the file was written to, False otherwise.
+
+    Returns ``True`` if the file was written to, ``False`` otherwise.
     """
     with open(meta_file, 'r') as f:
         (updated, newlines) = edit_metadata(f, variables, varfunc)
@@ -1439,20 +1678,24 @@ def edit_metadata_file(meta_file, variables, varfunc):
 
 
 def edit_bblayers_conf(bblayers_conf, add, remove, edit_cb=None):
-    """Edit bblayers.conf, adding and/or removing layers
-    Parameters:
-        bblayers_conf: path to bblayers.conf file to edit
-        add: layer path (or list of layer paths) to add; None or empty
-            list to add nothing
-        remove: layer path (or list of layer paths) to remove; None or
-            empty list to remove nothing
-        edit_cb: optional callback function that will be called after
-            processing adds/removes once per existing entry.
+    """Edit ``bblayers.conf``, adding and/or removing layers.
+
+    Arguments:
+
+    -  ``bblayers_conf``: path to ``bblayers.conf`` file to edit
+    -  ``add``: layer path (or list of layer paths) to add; ``None`` or empty
+       list to add nothing
+    -  ``remove``: layer path (or list of layer paths) to remove; ``None`` or
+       empty list to remove nothing
+    -  ``edit_cb``: optional callback function that will be called
+       after processing adds/removes once per existing entry.
+
     Returns a tuple:
-        notadded: list of layers specified to be added but weren't
-            (because they were already in the list)
-        notremoved: list of layers that were specified to be removed
-            but weren't (because they weren't in the list)
+
+    -  ``notadded``: list of layers specified to be added but weren't
+       (because they were already in the list)
+    -  ``notremoved``: list of layers that were specified to be removed
+       but weren't (because they weren't in the list)
     """
 
     def remove_trailing_sep(pth):
@@ -1572,7 +1815,22 @@ def get_collection_res(d):
 
 
 def get_file_layer(filename, d, collection_res={}):
-    """Determine the collection (as defined by a layer's layer.conf file) containing the specified file"""
+    """Determine the collection (or layer name, as defined by a layer's
+    ``layer.conf`` file) containing the specified file.
+
+    Arguments:
+
+    -  ``filename``: the filename to look for.
+    -  ``d``: the data store.
+    -  ``collection_res``: dictionary with the layer names as keys and file
+       patterns to match as defined with the BBFILE_COLLECTIONS and
+       BBFILE_PATTERN variables respectively. The return value of
+       ``bb.utils.get_collection_res()`` is the default if this variable is
+       not specified.
+
+    Returns the layer name containing the file. If multiple layers contain the
+    file, the last matching layer name from collection_res is returned.
+    """
     if not collection_res:
         collection_res = get_collection_res(d)
 
@@ -1610,7 +1868,13 @@ class PrCtlError(Exception):
 
 def signal_on_parent_exit(signame):
     """
-    Trigger signame to be sent when the parent process dies
+    Trigger ``signame`` to be sent when the parent process dies.
+
+    Arguments:
+
+    -  ``signame``: name of the signal. See ``man signal``.
+
+    No return value.
     """
     signum = getattr(signal, signame)
     # http://linux.die.net/man/2/prctl
@@ -1697,6 +1961,13 @@ def disable_network(uid=None, gid=None):
     Disable networking in the current process if the kernel supports it, else
     just return after logging to debug. To do this we need to create a new user
     namespace, then map back to the original uid/gid.
+
+    Arguments:
+
+    -  ``uid``: original user id.
+    -  ``gid``: original user group id.
+
+    No return value.
     """
     libc = ctypes.CDLL('libc.so.6')
 
@@ -1766,9 +2037,14 @@ class LogCatcher(logging.Handler):
 
 def is_semver(version):
     """
-        Is the version string following the semver semantic?
+    Arguments:
+
+    -  ``version``: the version string.
 
-        https://semver.org/spec/v2.0.0.html
+    Returns ``True`` if the version string follow semantic versioning, ``False``
+    otherwise.
+
+    See https://semver.org/spec/v2.0.0.html.
     """
     regex = re.compile(
     r"""
@@ -1806,6 +2082,8 @@ def rename(src, dst):
 def environment(**envvars):
     """
     Context manager to selectively update the environment with the specified mapping.
+
+    No return value.
     """
     backup = dict(os.environ)
     try:
@@ -1822,6 +2100,13 @@ def is_local_uid(uid=''):
     """
     Check whether uid is a local one or not.
     Can't use pwd module since it gets all UIDs, not local ones only.
+
+    Arguments:
+
+    -  ``uid``: user id. If not specified the user id is determined from
+       ``os.getuid()``.
+
+    Returns ``True`` is the user id is local, ``False`` otherwise.
     """
     if not uid:
         uid = os.getuid()
@@ -1836,7 +2121,7 @@ def is_local_uid(uid=''):
 
 def mkstemp(suffix=None, prefix=None, dir=None, text=False):
     """
-    Generates a unique filename, independent of time.
+    Generates a unique temporary file, independent of time.
 
     mkstemp() in glibc (at least) generates unique file names based on the
     current system time. When combined with highly parallel builds, and
@@ -1845,6 +2130,18 @@ def mkstemp(suffix=None, prefix=None, dir=None, text=False):
 
     This function adds additional entropy to the file name so that a collision
     is independent of time and thus extremely unlikely.
+
+    Arguments:
+
+    -  ``suffix``: filename suffix.
+    -  ``prefix``: filename prefix.
+    -  ``dir``: directory where the file will be created.
+    -  ``text``: if ``True``, the file is opened in text mode.
+
+    Returns a tuple containing:
+
+    -  the file descriptor for the created file
+    -  the name of the file.
     """
     entropy = "".join(random.choices("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890", k=20))
     if prefix:
@@ -1855,12 +2152,20 @@ def mkstemp(suffix=None, prefix=None, dir=None, text=False):
 
 def path_is_descendant(descendant, ancestor):
     """
-    Returns True if the path `descendant` is a descendant of `ancestor`
-    (including being equivalent to `ancestor` itself). Otherwise returns False.
+    Returns ``True`` if the path ``descendant`` is a descendant of ``ancestor``
+    (including being equivalent to ``ancestor`` itself). Otherwise returns
+    ``False``.
+
     Correctly accounts for symlinks, bind mounts, etc. by using
-    os.path.samestat() to compare paths
+    ``os.path.samestat()`` to compare paths.
+
+    May raise any exception that ``os.stat()`` raises.
+
+    Arguments:
 
-    May raise any exception that os.stat() raises
+    -  ``descendant``: path to check for being an ancestor.
+    -  ``ancestor``: path to the ancestor ``descendant`` will be checked
+       against.
     """
 
     ancestor_stat = os.stat(ancestor)

-- 
2.47.0


