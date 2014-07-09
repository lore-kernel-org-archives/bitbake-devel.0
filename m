Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id AD5AD609B2
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Jul 2014 12:20:58 +0000 (UTC)
Received: from [69.196.158.250] (port=44779 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1X4qrq-000587-0F for bitbake-devel@lists.openembedded.org;
	Wed, 09 Jul 2014 08:20:58 -0400
Date: Wed, 9 Jul 2014 08:20:45 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1407090819380.6147@localhost>
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
Subject: [PATCH] Documentation: Add a couple examples to conditional data.
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
X-List-Received-Date: Wed, 09 Jul 2014 12:21:03 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  i think having a couple real-life examples here would make a huge
difference.

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
index a9f5072..e433d85 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml
@@ -372,6 +372,23 @@
                         You select the os-specific version of the <filename>TEST</filename>
                         variable by appending the "os" override to the variable
                         (i.e.<filename>TEST_os</filename>).
+                        </para>
+
+                        <para>
+                            As a practical example, the following lines from
+                            one of the Linux kernel recipe files will first set
+                            the kernel branch variable <filename>KBRANCH</filename>
+                            to a default value, then conditionally override that
+                            value based on the architecture of the build:
+                        <literallayout class='monospaced'>
+    KBRANCH = "standard/base"
+    KBRANCH_qemuarm  = "standard/arm-versatile-926ejs"
+    KBRANCH_qemumips = "standard/mti-malta32"
+    KBRANCH_qemuppc  = "standard/qemuppc"
+    KBRANCH_qemux86  = "standard/common-pc/base"
+    KBRANCH_qemux86-64  = "standard/common-pc-64/base"
+    KBRANCH_qemumips64 = "standard/mti-malta64"
+                        </literallayout>
                         </para></listitem>
                     <listitem><para><emphasis>Appending and Prepending:</emphasis>
                         BitBake also supports append and prepend operations to
@@ -385,6 +402,18 @@
                         </literallayout>
                         In this example, <filename>DEPENDS</filename> becomes
                         "glibc ncurses libmad".
+                        </para>
+
+                        <para>
+                            Again using a kernel recipe file as an example, the
+                            following lines will conditionally append to the
+                            <filename>KERNEL_FEATURES</filename> variable based
+                            on the architecture:
+                        <literallayout class='monospaced'>
+    KERNEL_FEATURES_append = " ${KERNEL_EXTRA_FEATURES}"
+    KERNEL_FEATURES_append_qemux86=" cfg/sound.scc cfg/paravirt_kvm.scc"
+    KERNEL_FEATURES_append_qemux86-64=" cfg/sound.scc cfg/paravirt_kvm.scc"
+                        </literallayout>
                         </para></listitem>
                 </itemizedlist>
             </para>

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

