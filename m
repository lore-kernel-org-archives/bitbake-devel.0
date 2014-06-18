Return-Path: <rpjday@crashcourse.ca>
Received: from astoria.ccjclearline.com (astoria.ccjclearline.com
	[64.235.106.9])
	by mail.openembedded.org (Postfix) with ESMTP id 3825B6FE20
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jun 2014 16:06:59 +0000 (UTC)
Received: from [69.196.158.250] (port=40024 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.80) (envelope-from <rpjday@crashcourse.ca>)
	id 1WxIO4-0003C9-BP for bitbake-devel@lists.openembedded.org;
	Wed, 18 Jun 2014 12:07:00 -0400
Date: Wed, 18 Jun 2014 12:03:18 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.LFD.2.11.1406181202040.30320@localhost>
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
Subject: [PATCH] bitbake-user-manual-execution.xml: Typo, grammar fixes.
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
X-List-Received-Date: Wed, 18 Jun 2014 16:07:01 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
index 8514f23..2b58276 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
+++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
@@ -72,7 +72,7 @@
             <link linkend='var-BBFILES'><filename>BBFILES</filename></link>.
             <filename>BBPATH</filename> is used to search for
             configuration and class files under
-            <filename>conf/</filename> and <filename>class/</filename>
+            <filename>conf/</filename> and <filename>classes/</filename>
             directories, respectively.
             <filename>BBFILES</filename> is used to find recipe files
             (<filename>.bb</filename> and <filename>.bbappend</filename>).
@@ -120,7 +120,7 @@
             variable that is a space delimited list of 'layer' directories.
             Recall that if BitBake cannot find a <filename>bblayers.conf</filename>
             file then it is assumed the user has set the <filename>BBPATH</filename>
-            and <filename>BBFILES</filename> directly in the environment.
+            and <filename>BBFILES</filename> variables directly in the environment.
         </para>

         <para>
@@ -128,7 +128,7 @@
             file is searched for and parsed with the
             <link linkend='var-LAYERDIR'><filename>LAYERDIR</filename></link>
             variable being set to the directory where the layer was found.
-            The idea is these files automatically setup
+            The idea is these files automatically set up
             <link linkend='var-BBPATH'><filename>BBPATH</filename></link>
             and other variables correctly for a given build directory.
         </para>
@@ -495,7 +495,7 @@
             As each task completes, a timestamp is written to the directory specified by the
             <link linkend='var-STAMP'><filename>STAMP</filename></link> variable.
             On subsequent runs, BitBake looks in the build directory within
-            <filename>tmp/stamps</filename>and does not rerun
+            <filename>tmp/stamps</filename> and does not rerun
             tasks that are already completed unless a timestamp is found to be invalid.
             Currently, invalid timestamps are only considered on a per
             recipe file basis.
@@ -535,7 +535,7 @@
         <title>Executing Tasks</title>

         <para>
-            Tasks can either be a shell task or a Python task.
+            Tasks can be either a shell task or a Python task.
             For shell tasks, BitBake writes a shell script to
             <filename>${</filename><link linkend='var-T'><filename>T</filename></link><filename>}/run.do_taskname.pid</filename>
             and then executes the script.
@@ -755,9 +755,9 @@
             to determine the stamps and delta where these two
             stamp trees diverge.
             <note>
-                It is likely that future versions of BitBake with
+                It is likely that future versions of BitBake will
                 provide other signature handlers triggered through
-                additional "-S" paramters.
+                additional "-S" parameters.
             </note>
         </para>


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

