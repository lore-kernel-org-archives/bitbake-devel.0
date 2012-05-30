Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SZlkO-00054z-Hl
	for bitbake-devel@lists.openembedded.org;
	Wed, 30 May 2012 18:27:44 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 30 May 2012 09:17:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="105914746"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.12.128])
	by AZSMGA002.ch.intel.com with ESMTP; 30 May 2012 09:17:25 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 30 May 2012 17:17:18 +0100
Message-Id: <a1795bad9360bbe9a325ee41b3e56022209b17c7.1338394341.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1338394341.git.paul.eggleton@linux.intel.com>
References: <cover.1338394341.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1338394341.git.paul.eggleton@linux.intel.com>
References: <cover.1338394341.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 5/5] bitbake: include varflags in checksums
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
X-List-Received-Date: Wed, 30 May 2012 16:27:44 -0000

Add a dependency to each variable on a filtered list of its varflags.
This is intended to catch things such as SRC_URI checksums, varflags
controlling extra functionality from classes (e.g. the recently updated
update-alternatives class in OE-Core), etc. and ensure their values
influence the sstate checksums.

There is an exclusion list which needs to be set via bitbake.conf
(BB_SIGNATURE_EXCLUDE_FLAGS), if this is not set then the functionality
is disabled. The existing vardepsexclude mechanism can also be used to
exclude undesired varflags, but they must be fully specified, e.g.:

do_patch[vardepsexclude] += "do_patch[someflag]"

Implements [YOCTO #2517].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/data.py   |   20 +++++++++++++++++++-
 bitbake/lib/bb/siggen.py |    4 ++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/data.py b/bitbake/lib/bb/data.py
index c0636e1..e3ffefe 100644
--- a/bitbake/lib/bb/data.py
+++ b/bitbake/lib/bb/data.py
@@ -279,7 +279,12 @@ def build_dependencies(key, keys, shelldeps, vardepvals, d):
     deps = set()
     vardeps = d.getVarFlag(key, "vardeps", True)
     try:
-        value = d.getVar(key, False)
+        if key[-1] == ']':
+            vf = key[:-1].split('[')
+            value = d.getVarFlag(vf[0], vf[1], False)
+        else:
+            value = d.getVar(key, False)
+
         if key in vardepvals:
            value =  d.getVarFlag(key, "vardepvalue", True)
         elif d.getVarFlag(key, "func"):
@@ -301,6 +306,19 @@ def build_dependencies(key, keys, shelldeps, vardepvals, d):
             parser = d.expandWithRefs(value, key)
             deps |= parser.references
             deps = deps | (keys & parser.execs)
+
+        # Add varflags, assuming an exclusion list is set
+        varflagsexcl = d.getVar('BB_SIGNATURE_EXCLUDE_FLAGS', True)
+        if varflagsexcl:
+            varfdeps = []
+            varflags = d.getVarFlags(key)
+            if varflags:
+                for f in varflags:
+                    if f not in varflagsexcl:
+                        varfdeps.append('%s[%s]' % (key, f))
+            if varfdeps:
+                deps |= set(varfdeps)
+
         deps |= set((vardeps or "").split())
         deps -= set((d.getVarFlag(key, "vardepsexclude", True) or "").split())
     except:
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index daf5677..c4b7c39 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -108,6 +108,10 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 data = data + dep
                 if dep in lookupcache:
                     var = lookupcache[dep]
+                elif dep[-1] == ']':
+                    vf = dep[:-1].split('[')
+                    var = d.getVarFlag(vf[0], vf[1], False)
+                    lookupcache[dep] = var
                 else:
                     var = d.getVar(dep, False)
                     lookupcache[dep] = var
-- 
1.7.9.5



