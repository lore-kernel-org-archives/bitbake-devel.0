Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (unknown [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 611026B49F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 May 2014 15:22:35 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 23 May 2014 08:22:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.98,894,1392192000"; d="scan'208";a="545581341"
Received: from bidesilv-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.123.159])
	by orsmga002.jf.intel.com with ESMTP; 23 May 2014 08:22:31 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 May 2014 16:22:15 +0100
Message-Id: <29701c5132760101bb6ccaf68d33a9354296db08.1400858501.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <cover.1400858501.git.paul.eggleton@linux.intel.com>
References: <cover.1400858501.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1400858501.git.paul.eggleton@linux.intel.com>
References: <cover.1400858501.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 2/4] bitbake-layers: show-cross-depends: ignore global inherits
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
X-List-Received-Date: Fri, 23 May 2014 15:22:36 -0000

It's not particularly useful to show globally inherited classes here
since they do not normally represent a dependency.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 826a3e7..326239a 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -596,6 +596,8 @@ The .bbappend file can impact the dependency.
         self.include_re = re.compile(r"include\s+(.+)")
         self.inherit_re = re.compile(r"inherit\s+(.+)")
 
+        global_inherit = (self.bbhandler.config_data.getVar('INHERIT', True) or "").split()
+
         # The bb's DEPENDS and RDEPENDS
         for f in pkg_fn:
             f = bb.cache.Cache.virtualfn2realfn(f)[0]
@@ -637,6 +639,9 @@ The .bbappend file can impact the dependency.
                     # The inherits' format is [classes/cls, /path/to/classes/cls]
                     # ignore the classes/cls.
                     if not cls_re.match(cls):
+                        classname = os.path.splitext(os.path.basename(cls))[0]
+                        if classname in global_inherit:
+                            continue
                         inherit_layername = self.get_file_layer(cls)
                         if inherit_layername != layername and not inherit_layername in ignore_layers:
                             if not options.show_filenames:
-- 
1.9.0


