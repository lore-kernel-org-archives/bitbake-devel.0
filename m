Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id A3C2B601A0
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Dec 2014 10:50:31 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 08 Dec 2014 02:50:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,537,1413270000"; d="scan'208";a="644158892"
Received: from apwitke-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.30.33])
	by fmsmga002.fm.intel.com with ESMTP; 08 Dec 2014 02:50:30 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  8 Dec 2014 10:50:22 +0000
Message-Id: <f4daea84bd8279728a56153a605db9aef532691d.1418034514.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1418034514.git.paul.eggleton@linux.intel.com>
References: <cover.1418034514.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1418034514.git.paul.eggleton@linux.intel.com>
References: <cover.1418034514.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/4] utils: add exec_flat_python_func()
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
X-List-Received-Date: Mon, 08 Dec 2014 10:50:33 -0000

Add a function that allows executing a flat python function (defined
with def funcname(args): ...).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/bb/utils.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/lib/bb/utils.py b/lib/bb/utils.py
index c6f4071..d7c5067 100644
--- a/lib/bb/utils.py
+++ b/lib/bb/utils.py
@@ -893,3 +893,25 @@ def multiprocessingpool(*args, **kwargs):
 
     return multiprocessing.Pool(*args, **kwargs)
 
+def exec_flat_python_func(func, *args, **kwargs):
+    """Execute a flat python function (defined with def funcname(args):...)"""
+    # Prepare a small piece of python code which calls the requested function
+    # To do this we need to prepare two things - a set of variables we can use to pass
+    # the values of arguments into the calling function, and the list of arguments for
+    # the function being called
+    context = {}
+    funcargs = []
+    # Handle unnamed arguments
+    aidx = 1
+    for arg in args:
+        argname = 'arg_%s' % aidx
+        context[argname] = arg
+        funcargs.append(argname)
+        aidx += 1
+    # Handle keyword arguments
+    context.update(kwargs)
+    funcargs.extend(['%s=%s' % (arg, arg) for arg in kwargs.iterkeys()])
+    code = 'retval = %s(%s)' % (func, ', '.join(funcargs))
+    comp = bb.utils.better_compile(code, '<string>', '<string>')
+    bb.utils.better_exec(comp, context, code, '<string>')
+    return context['retval']
-- 
1.9.3


