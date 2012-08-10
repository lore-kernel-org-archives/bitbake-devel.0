Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1SzgII-00048X-4x
	for bitbake-devel@lists.openembedded.org;
	Fri, 10 Aug 2012 05:53:50 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q7A3fx93024424
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 9 Aug 2012 20:41:59 -0700 (PDT)
Received: from localhost.localdomain (128.224.163.124) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.2.309.2; Thu, 9 Aug 2012 20:42:00 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 10 Aug 2012 11:47:39 +0800
Message-ID: <6a3f6d68c2bb44faac061761f2565a5f03d8e8d8.1344569166.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <cover.1344569166.git.liezhi.yang@windriver.com>
References: <cover.1344569166.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/1 V2] bitbake-whatchanged: print what is about to happen
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 10 Aug 2012 03:53:50 -0000
Content-Type: text/plain

* Contents:
  - Summary
  - Usage
  - Implementation summary
  - Output
  - TODO

* Summary:
  This is used for printing out what is about to happen between the
  current and last builds, for example:

  $ bitbake core-image-sato
  # Edit some recipes
  $ bitbake-whatchanged core-image-sato

  The changes will be printed.

* Usage:
  bitbake-whatchanged [[opts] recipe]

* Implementation summary:
  - Use the "BB_STAMPS_DIR=<path> bitbake -S recipe" to generate the new
    stamps

  - When "the -v" (verbose) is not specified:
    > Figure out the newly added tasks
    > Figure out the PV (including PE) and PR changeds "PN", I think
      that we the tasks details here, since all the task will change
      when PV or PR changes.
    > The left tasks are the ones that the "DEPENDS"(Or dependency might
      be better?) changed ones.

  - When "-v" is specified:
    > Figure out the newly added tasks
    > Use bb.siggen.compare_sigfiles to figure out the details

* Output, for example (between core-image-sato and meta-toolchain-sdk,
  and with recipes upgraded):
  - without "-v":
    Figuring out the TMPDIR ...
    Generating the new stamps ... (need several minutes)
    === Newly added tasks: (807 tasks)
      libpthread-stubs-nativesdk: do_install do_build do_fetch do_package_write_rpm [snip]
      telepathy-mission-control: do_unpack do_build do_package_write_rpm do_package [snip]
      [snip]

    === PV changed: (48 tasks)
      bison-native: 2.5 -> 2.5.1
      atk: 2.2.0 -> 2.4.0
      [snip]

    === PR changed: (276 tasks)
      gdk-pixbuf-native: r3 -> r4
      db-native: r7 -> r8
      [snip]

    === DEPENDS changed: (2522 tasks)
      speex: do_package_write_rpm do_configure do_package do_populate_sysroot [snip]
      libgpg-error-native: do_build do_package_write do_package do_package_write_rpm [snip]
      [snip]

    === Summary: (3653 changed, 1927 unchanged)
    Newly added: 807
    PV changed: 48
    PR changed: 276
    Depends changed: 2522

    Removing the newly generated stamps ...

  - with "-v": (No PV or PR changes summary)
    === Newly added tasks: (807 tasks)
      libpthread-stubs-nativesdk: do_install do_build do_fetch do_package_write_rpm [snip]
      telepathy-mission-control: do_unpack do_build do_package_write_rpm do_package [snip]
      [snip]

    === The verbose changes of libice:
    Dependency on task bash_4.2.bb.do_package_write was added with hash d03d35205f8c897b2d37c1ebf6249fbf
    Dependency on task bash_3.2.48.bb.do_package_write was removed with hash 4bdef77351789cb078742430fd034212
    [snip]

    === The verbose changes of bash:
    basehash changed from 2a3301fad820eaad859ae738b2cdb613 to 8086533b1abb4ab5b8507ff5e4a3046f
    List of dependencies for variable sbindir changed from set(['exec_prefix']) to set([])
    List of dependencies for variable bindir changed from set(['exec_prefix']) to set([])
    [snip]

    === Summary: (3653 changed, 1927 unchanged)
    Newly added: 807
    Depends changed: 2846

    Removing the newly generated stamps ...

* TODO
  - It seems that the "bitabke -S core-image-sato" has bugs, it would always
    report errors, but doesn't fatal errors

  - "bitbake -S" always generate the nativesdk stamps regardless of what
     we build.

  - The gcc-cross' stamps are in tmp/stamps/work-shared, but the
    "bitbake -S" doesn't put the stamps in work-shared. This doesn't
     matter to the "bitbake-whatchanged" since it uses the os.walk.

  - Print the ones which can be installed from the sstate.

[YOCTO #1659]

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/bin/bitbake-whatchanged | 328 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 328 insertions(+)
 create mode 100755 bitbake/bin/bitbake-whatchanged

diff --git a/bitbake/bin/bitbake-whatchanged b/bitbake/bin/bitbake-whatchanged
new file mode 100755
index 0000000..241c093
--- /dev/null
+++ b/bitbake/bin/bitbake-whatchanged
@@ -0,0 +1,328 @@
+#!/usr/bin/env python
+# ex:ts=4:sw=4:sts=4:et
+# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
+
+# Copyright (c) 2012 Wind River Systems, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License version 2 as
+# published by the Free Software Foundation.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+# See the GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+
+from __future__ import print_function
+import os
+import sys
+import getopt
+import shutil
+import re
+import warnings
+from optparse import OptionParser
+
+# Need the bb.process.run and bb.siggen
+sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(sys.argv[0])), 'lib'))
+import bb.process
+import bb.siggen
+
+# Match the stamp's filename
+# group(1): PN
+# group(2): PE_PV (may no PE)
+# group(3): PR
+# group(4): TASK
+# group(5): HASH (not used here)
+fre = re.compile("(?P<pn>.*)-(?P<pv>.*)-(?P<pr>r\d+)\.(?P<task>do_\w+)\.sigdata\.(?P<hash>.*)")
+fre_sdk = re.compile("(.*)-nativesdk-(.*)|(.*)-crosssdk-(.*)")
+
+def gen_dict(stamps, sdk):
+    """
+    Generate the dict from the stamps dir.
+    The output dict format is:
+    {FN: {pn: PN, pv: PV, pr: PR, task: TASK, path: PATH}}
+    """
+    # The member of the sub dict (a "path" will be added later)
+    sub_mem = ("pn", "pv", "pr", "task")
+    d = {}
+    for dirpath, _, files in os.walk(stamps):
+        for fn in files:
+            subdict = {}
+            if fre.match(fn):
+                tmp = fre.match(fn)
+                # Nothing especially should be done if sdk, just add it to the dict.
+                if sdk:
+                    for i in sub_mem:
+                        subdict[i] = tmp.group(i)
+                elif not fre_sdk.match(fn):
+                    for i in sub_mem:
+                        subdict[i] = tmp.group(i)
+                if len(subdict) != 0:
+                    # The path will be used by os.stat() and bb.siggen
+                    subdict['path'] = dirpath
+                    d[fn] = subdict
+    return d
+
+# Re-construct the dict
+def recon_dict(dict_in):
+    """
+    The output dict format is:
+    {PN_TASK: {fn: FN, pv: PV, pr: PR, path: PATH}}
+    """
+    dict_out = {}
+    for k in dict_in.keys():
+        subdict = {}
+        # The key
+        pn_task = "%s_%s" % (dict_in.get(k).get('pn'), dict_in.get(k).get('task'))
+        # If more than one stamps are found, use the latest one.
+        if pn_task in dict_out:
+            full_path_pre = "%s/%s" % (dict_in.get(dict_out.get(pn_task).get('fn')).get('path'), k)
+            full_path_cur = "%s/%s" % (dict_in.get(k).get('path'), k)
+            if os.stat(full_path_pre).st_mtime > os.stat(full_path_cur).st_mtime:
+                continue
+        subdict['fn'] = k
+        subdict['pv'] = dict_in.get(k).get('pv')
+        subdict['pr'] = dict_in.get(k).get('pr')
+        subdict['path'] = dict_in.get(k).get('path')
+        dict_out[pn_task] = subdict
+
+    return dict_out
+
+def split_pntask(s):
+    """
+    Split the pn_task in to (pn, task) and return it
+    """
+    tmp = re.match("(.*)_(do_.*)", s)
+    return (tmp.group(1), tmp.group(2))
+
+
+def print_added(d_new = None, d_old = None):
+    """
+    Print the newly added tasks
+    """
+    added = {}
+    for k in d_new.keys():
+        if k not in d_old:
+            # Add the new one to added dict, and remove it from
+            # d_new, so the remaining ones are the changed ones
+            added[k] = d_new.get(k)
+            del(d_new[k])
+
+    if not added:
+        return 0
+
+    # Format the output, the dict format is:
+    # {pn: task1, task2 ...}
+    added_format = {}
+    counter = 0
+    for k in added.keys():
+        pn, task = split_pntask(k)
+        if pn in added_format:
+            # Append the value
+            added_format[pn] = "%s %s" % (added_format.get(pn), task)
+        else:
+            added_format[pn] = task
+        counter += 1
+    print("=== Newly added tasks: (%s tasks)" % counter)
+    for k in added_format.keys():
+        print("  %s: %s" % (k, added_format.get(k)))
+
+    return counter
+
+def print_vrchanged(d_new = None, d_old = None, vr = None):
+    """
+    Print the pv or pr changed tasks.
+    The arg "vr" is "pv" or "pr"
+    """
+    pvchanged = {}
+    counter = 0
+    for k in d_new.keys():
+        if d_new.get(k).get(vr) != d_old.get(k).get(vr):
+            counter += 1
+            pn, task = split_pntask(k)
+            if pn not in pvchanged:
+                # Format the output, we only print pn (no task) since
+                # all the tasks would be changed when pn or pr changed,
+                # the dict format is:
+                # {pn: pv/pr_old -> pv/pr_new}
+                pvchanged[pn] = "%s -> %s" % (d_old.get(k).get(vr), d_new.get(k).get(vr))
+            del(d_new[k])
+
+    if not pvchanged:
+        return 0
+
+    print("\n=== %s changed: (%s tasks)" % (vr.upper(), counter))
+    for k in pvchanged.keys():
+        print("  %s: %s" % (k, pvchanged.get(k)))
+
+    return counter
+
+def print_depchanged(d_new = None, d_old = None, verbose = False):
+    """
+    Print the dependency changes
+    """
+    depchanged = {}
+    counter = 0
+    for k in d_new.keys():
+        counter += 1
+        pn, task = split_pntask(k)
+        if (verbose):
+            full_path_old = "%s/%s" % (d_old.get(k).get("path"), d_old.get(k).get('fn'))
+            full_path_new = "%s/%s" % (d_new.get(k).get("path"), d_new.get(k).get('fn'))
+            # No counter since it is not ready here
+            print("\n=== The verbose changes of %s:" % pn)
+            bb.siggen.compare_sigfiles(full_path_old, full_path_new)
+        else:
+            # Format the output, the format is:
+            # {pn: task1, task2, ...}
+            if pn in depchanged:
+                depchanged[pn] = "%s %s" % (depchanged.get(pn), task)
+            else:
+                depchanged[pn] = task
+
+    if len(depchanged) > 0:
+        print("\n=== DEPENDS changed: (%s tasks)" % counter)
+        for k in depchanged.keys():
+            print("  %s: %s" % (k, depchanged[k]))
+
+    return counter
+
+
+def main():
+    """
+    Print what will be done between the current and last builds:
+    1) Run "BB_STAMPS_DIR=<path> bitbake -S recipe" to re-generate the stamps
+    2) Figure out what are newly added and changed, can't figure out
+       what are removed since we can't know the previous stamps
+       clearly, for example, if there are several builds, we can't know
+       which stamps the last build has used exactly.
+    3) Use bb.siggen.compare_sigfiles to diff the old and new stamps
+    """
+
+    parser = OptionParser(
+        version = "1.0",
+        usage = """%prog [options] [package ...]
+print what will be done between the current and last builds, for example:
+
+    $ bitbake core-image-sato
+    # Edit the recipes
+    $ bitbake-whatchanged core-image-sato
+
+The changes will be printed"
+
+Note:
+    The amount of tasks is not accurate when the task is "do_build" since
+    it usually depends on other tasks.
+    The "nostamp" task is not included.
+"""
+)
+    parser.add_option("-v", "--verbose", help = "print the verbose changes",
+               action = "store_true", dest = "verbose")
+
+    options, args = parser.parse_args(sys.argv)
+
+    verbose = options.verbose
+
+    if len(args) != 2:
+        parser.error("Incorrect number of arguments")
+    else:
+        recipe = args[1]
+
+    # FIXME
+    # The bitbake -S will always generate the stamp for the nativesdk,
+    # so we should check whether it really builds sdk or not:
+    if recipe.endswith('sdk'):
+        sdk = True
+    else:
+        sdk = False
+
+    # Get the BB_STAMPS_DIR
+    print("Figuring out the BB_STAMPS_DIR ...")
+    cmdline = "bitbake -e | sed -ne 's/^BB_STAMPS_DIR=\"\(.*\)\"/\\1/p'"
+    stampsdir, err = bb.process.run(cmdline)
+    if not stampsdir:
+        print("ERROR: No BB_STAMPS_DIR found for '%s'" % recipe, file=sys.stderr)
+        return 2
+    stampsdir = stampsdir.rstrip("\n")
+    if not os.path.isdir(stampsdir):
+        print("ERROR: stamps directory \"%s\" not found!" % stampsdir, file=sys.stderr)
+        return 2
+
+    # The new stamps dir
+    new_stampsdir = stampsdir + ".bbs"
+    if os.path.exists(new_stampsdir):
+        print("ERROR: %s is not empty!" % new_stampsdir, file=sys.stderr)
+        return 2
+
+    try:
+        # Generate the new stamps dir
+        print("Generating the new stamps ... (need several minutes)")
+        cmdline = "BB_STAMPS_DIR=%s bitbake -S %s" % (new_stampsdir, recipe)
+        # FIXME
+        # The "bitbake -S" may fail, not fatal error, the stamps will still
+        # be generated, This might be a bug of "bitbake -S".
+        try:
+            bb.process.run(cmdline)
+        except:
+            pass
+
+        # The dict for the new and old stamps.
+        old_dict = gen_dict(stampsdir, sdk)
+        new_dict = gen_dict(new_stampsdir, sdk)
+
+        # Remove the same one from both stamps.
+        cnt_unchanged = 0
+        for k in new_dict.keys():
+            if k in old_dict:
+                cnt_unchanged += 1
+                del(new_dict[k])
+                del(old_dict[k])
+
+        # Re-construct the dict to easily find out what is added or changed.
+        # The dict format is:
+        # {PN_TASK: {fn: FN, pv: PV, pr: PR, path:PATH}}
+        new_recon = recon_dict(new_dict)
+        old_recon = recon_dict(old_dict)
+
+        del new_dict
+        del old_dict
+
+        # Figure out what are changed, the new_recon would be changed
+        # by the print_xxx function.
+        # Newly added
+        cnt_added = print_added(new_recon, old_recon)
+
+        # PV (including PE) and PR changed
+        # Let the bb.siggen handle them if verbose
+        cnt_rv = {}
+        if not verbose:
+            for i in ('pv', 'pr'):
+               cnt_rv[i] = print_vrchanged(new_recon, old_recon, i)
+
+        # Depends changed (use bitbake-diffsigs)
+        cnt_dep = print_depchanged(new_recon, old_recon, verbose)
+
+        total_changed = cnt_added + (cnt_rv.get('pv') or 0) + (cnt_rv.get('pr') or 0) + cnt_dep
+
+        print("\n=== Summary: (%s changed, %s unchanged)" % (total_changed, cnt_unchanged))
+        if verbose:
+            print("Newly added: %s\nDepends changed: %s\n" % \
+                (cnt_added, cnt_dep))
+        else:
+            print("Newly added: %s\nPV changed: %s\nPR changed: %s\nDepends changed: %s\n" % \
+                (cnt_added, cnt_rv.get('pv') or 0, cnt_rv.get('pr') or 0, cnt_dep))
+    except:
+        print("ERROR occurred!")
+        raise
+    finally:
+        # Remove the newly generated stamps dir
+        if os.path.exists(new_stampsdir):
+            print("Removing the newly generated stamps dir ...")
+            shutil.rmtree(new_stampsdir)
+
+if __name__ == "__main__":
+    sys.exit(main())
-- 
1.7.11.2



