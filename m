Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id D241460424
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Jul 2014 12:04:05 +0000 (UTC)
Received: from [69.196.158.250] (port=44733 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1X4qbW-0004PL-89 for bitbake-devel@lists.openembedded.org;
	Wed, 09 Jul 2014 08:04:06 -0400
Date: Wed, 9 Jul 2014 08:03:58 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1407090802320.5937@localhost>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - astoria.ccjclearline.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Subject: [PATCH] Documentation: Add examples to User Manual, Metadata chapter
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
X-List-Received-Date: Wed, 09 Jul 2014 12:04:12 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  as long as i've understood everything correctly, this is just
throwing in some physical examples of a couple concepts.

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index a9f5072..423d9a4 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -285,6 +285,16 @@
                 The flags are immediately set to "abc" and "123", respectively.
                 The <filename>a</filename> flag becomes "abc456".
             </para>
+
+            <para>
+                Note that there is no need to pre-define variable flags; you
+                can simply start using them.  One extremely common application
+                is to attach some brief documentation to a BitBake variable as
+                follows:
+                <literallayout class='monospaced'>
+    CACHE[doc] = "The directory holding the cache of the metadata."
+                </literallayout>
+            </para>
         </section>

         <section id='inline-python-variable-expansion'>
@@ -298,7 +308,19 @@
      DATE = "${@time.strftime('%Y%m%d',time.gmtime())}"
                 </literallayout>
                 This example results in the <filename>DATE</filename>
-                variable becoming the current date.
+                variable being set to the current date.
+            </para>
+
+            <para>
+                Probably the most common use of this feature is to extract
+                the value of variables from BitBake's internal data dictionary,
+                <filename>d</filename>. The following lines
+                select the values of, respectively, a package name and its
+                version number:
+                <literallayout class='monospaced'>
+    PN = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE'),d)[0] or 'defaultpkgname'}"
+    PV = "${@bb.parse.BBHandler.vars_from_file(d.getVar('FILE'),d)[1] or '1.0'}"
+                </literallayout>
             </para>
         </section>


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

