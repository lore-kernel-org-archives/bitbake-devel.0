Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 5E96B72908
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Dec 2014 10:20:52 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 19 Dec 2014 02:20:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,606,1413270000"; d="scan'208";a="640218085"
Received: from khamid-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.31.61])
	by fmsmga001.fm.intel.com with ESMTP; 19 Dec 2014 02:20:50 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 19 Dec 2014 10:20:30 +0000
Message-Id: <d757b12a7919de4df3b525e99631790f1ea02546.1418984377.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1418984377.git.paul.eggleton@linux.intel.com>
References: <cover.1418984377.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1418984377.git.paul.eggleton@linux.intel.com>
References: <cover.1418984377.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/4] utils: add basic metadata manipulation functions
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 19 Dec 2014 10:20:53 -0000

* Add a generic edit_metadata_file() function to modify variable
  assignments in any metadata file (conf, bb, bbappend) using a callback
  for flexibility
* Add a specific edit_bblayers_conf() function to modify
  conf/bblayers.conf and add and/or remove layers from the BBLAYERS
  value within it.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/utils.py | 127 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index d7c5067..f26349f 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -915,3 +915,130 @@ def exec_flat_python_func(func, *args, **kwargs):
     comp = bb.utils.better_compile(code, '<string>', '<string>')
     bb.utils.better_exec(comp, context, code, '<string>')
     return context['retval']
+
+def edit_metadata_file(meta_file, variables, func):
+    """Edit a recipe or config file and modify one or more specified
+    variable values set in the file using a specified callback function.
+    The file is only written to if the value(s) actually change.
+    """
+    var_res = {}
+    for var in variables:
+        var_res[var] = re.compile(r'^%s[ \t]*[?=]+' % var)
+
+    updated = False
+    varset_start = ''
+    newlines = []
+    in_var = None
+    full_value = ''
+
+    def handle_var_end():
+        (newvalue, indent, minbreak) = func(in_var, full_value)
+        if newvalue != full_value:
+            if isinstance(newvalue, list):
+                intentspc = ' ' * indent
+                if minbreak:
+                    # First item on first line
+                    if len(newvalue) == 1:
+                        newlines.append('%s "%s"\n' % (varset_start, newvalue[0]))
+                    else:
+                        newlines.append('%s "%s\\\n' % (varset_start, newvalue[0]))
+                        for item in newvalue[1:]:
+                            newlines.append('%s%s \\\n' % (intentspc, item))
+                        newlines.append('%s"\n' % indentspc)
+                else:
+                    # No item on first line
+                    newlines.append('%s " \\\n' % varset_start)
+                    for item in newvalue:
+                        newlines.append('%s%s \\\n' % (intentspc, item))
+                    newlines.append('%s"\n' % intentspc)
+            else:
+                newlines.append('%s "%s"\n' % (varset_start, newvalue))
+            return True
+        return False
+
+    with open(meta_file, 'r') as f:
+        for line in f:
+            if in_var:
+                value = line.rstrip()
+                full_value += value[:-1]
+                if value.endswith('"') or value.endswith("'"):
+                    if handle_var_end():
+                        updated = True
+                    in_var = None
+            else:
+                matched = False
+                for (varname, var_re) in var_res.iteritems():
+                    if var_re.match(line):
+                        splitvalue = line.split('"', 1)
+                        varset_start = splitvalue[0].rstrip()
+                        value = splitvalue[1].rstrip()
+                        if value.endswith('\\'):
+                            value = value[:-1]
+                        full_value = value
+                        if value.endswith('"') or value.endswith("'"):
+                            if handle_var_end():
+                                updated = True
+                        else:
+                            in_var = varname
+                        matched = True
+                        break
+                if not matched:
+                    newlines.append(line)
+    if updated:
+        with open(meta_file, 'w') as f:
+            f.writelines(newlines)
+
+def edit_bblayers_conf(bblayers_conf, add, remove):
+    """Edit bblayers.conf, adding and/or removing layers"""
+
+    import fnmatch
+
+    def remove_trailing_sep(pth):
+        if pth and pth[-1] == os.sep:
+            pth = pth[:-1]
+        return pth
+
+    def layerlist_param(value):
+        if not value:
+            return []
+        elif isinstance(value, list):
+            return [remove_trailing_sep(x) for x in value]
+        else:
+            return [remove_trailing_sep(value)]
+
+    notadded = []
+    notremoved = []
+
+    addlayers = layerlist_param(add)
+    removelayers = layerlist_param(remove)
+
+    def handle_bblayers(varname, origvalue):
+        updated = False
+        bblayers = [remove_trailing_sep(x) for x in origvalue.split()]
+        if removelayers:
+            for removelayer in removelayers:
+                matched = False
+                for layer in bblayers:
+                    if fnmatch.fnmatch(layer, removelayer):
+                        updated = True
+                        matched = True
+                        bblayers.remove(layer)
+                        break
+                if not matched:
+                    notremoved.append(removelayer)
+        if addlayers:
+            for addlayer in addlayers:
+                if addlayer not in bblayers:
+                    updated = True
+                    bblayers.append(addlayer)
+                else:
+                    notadded.append(addlayer)
+
+        if updated:
+            return (bblayers, 2, False)
+        else:
+            return (origvalue, 2, False)
+
+    edit_metadata_file(bblayers_conf, ['BBLAYERS'], handle_bblayers)
+    return (notadded, notremoved)
+
-- 
1.9.3


