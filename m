Return-Path: <juro.bystricky@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id CC9917638A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 29 Jul 2015 18:15:02 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 29 Jul 2015 11:13:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,572,1432623600"; d="scan'208";a="773737945"
Received: from juro-precision-t5610.jf.intel.com ([10.7.198.145])
	by orsmga002.jf.intel.com with ESMTP; 29 Jul 2015 11:13:47 -0700
From: Juro Bystricky <juro.bystricky@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Jul 2015 11:09:41 -0700
Message-Id: <1438193381-29031-1-git-send-email-juro.bystricky@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: richard.purdie@intel.com
Subject: [PATCH] bitbake-user-manual-fetching.xml: note about URLs with semi-colons
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
X-List-Received-Date: Wed, 29 Jul 2015 18:15:02 -0000

Some URLs contain semi-colons. Unfortunatelly, bitbake uses semi-colons in SRC_URI
as delimiters for various parameters.
It may still be possible to use such URLs, providing the user replaces semi-colons ';'
with '&' characters.

For example:

   http://abc123.com/git/?p=gcc/gcc.git;a=snapshot;h=a5dd47

 and

   http://abc123.com/git/?p=gcc/gcc.git&a=snapshot&h=a5dd47

should be equivalent, as W3C recommends treating ';' in queries identically to '&'.

See http://www.w3.org/TR/1999/REC-html401-19991224/appendix/notes.html#h-B.2.2

Kudos to Olof Johansson

Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
---
 .../bitbake-user-manual-fetching.xml                  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
index b37b2ae..f168cfa 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
@@ -325,6 +325,25 @@
      SRC_URI = "ftp://you@oe.handhelds.org/home/you/secret.plan"
                 </literallayout>
             </para>
+            <note>
+               Because URL parameters are delimited by semi-colons, this can
+               introduce ambiguity when parsing URLs that also contain semi-colons,
+               for example:
+                <literallayout class='monospaced'>
+     SRC_URI = "http://abc123.org/git/?p=gcc/gcc.git;a=snapshot;h=a5dd47"
+                </literallayout>
+               Such URLs should should be modified by replacing semi-colons with '&amp;' characters:
+               <literallayout class='monospaced'>
+     SRC_URI = "http://abc123.org/git/?p=gcc/gcc.git&amp;a=snapshot&amp;h=a5dd47"
+                </literallayout>
+                In most cases this should work. Treating semi-colons and '&amp;' in queries
+                identically is recommended by the World Wide Web Consortium (W3C).
+                Note that due to the nature of the URL, you may have to specify the name
+                of the downloaded file as well:
+              <literallayout class='monospaced'>
+     SRC_URI = "http://abc123.org/git/?p=gcc/gcc.git&amp;a=snapshot&amp;h=a5dd47;downloadfilename=myfile.bz2"
+                </literallayout>
+            </note>
         </section>
 
         <section id='cvs-fetcher'>
-- 
1.9.1


