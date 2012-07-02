Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SliqG-0002Lq-Ea for bitbake-devel@lists.openembedded.org;
	Mon, 02 Jul 2012 17:47:12 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q62FaC9f002432
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 2 Jul 2012 16:36:12 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 00610-07 for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Jul 2012 16:36:05 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q62Fa2hu002418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 2 Jul 2012 16:36:03 +0100
Message-ID: <1341243368.23146.256.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 02 Jul 2012 16:36:08 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] usermanual: Improve task dependency documentation to match reality
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
X-List-Received-Date: Mon, 02 Jul 2012 15:47:12 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/doc/manual/usermanual.xml b/bitbake/doc/manual/usermanual.xml
index f894dfc..81b301a 100644
--- a/bitbake/doc/manual/usermanual.xml
+++ b/bitbake/doc/manual/usermanual.xml
@@ -228,7 +228,7 @@ addtask printdate before do_build</screen></para>
                 <para>'nostamp' - don't generate a stamp file for a task. This means the task is always rexecuted.</para>
                 <para>'fakeroot' - this task needs to be run in a fakeroot environment, obtained by adding the variables in FAKEROOTENV to the environment.</para>
                 <para>'umask' - the umask to run the task under.</para>
-                <para> For the 'deptask', 'rdeptask', 'recdeptask' and 'recrdeptask' flags please see the dependencies section.</para>
+                <para> For the 'deptask', 'rdeptask', 'depends', 'rdepends' and 'recrdeptask' flags please see the dependencies section.</para>
             </section>
 
             <section>
@@ -308,37 +308,35 @@ SRC_URI_append_1.0.7+ = "file://some_patch_which_the_new_versions_need.patch;pat
         </section>
         <section>
             <title>Dependency handling</title>
-            <para>BitBake 1.7.x onwards works with the metadata at the task level since this is optimal when dealing with multiple threads of execution. A robust method of specifing task dependencies is therefore needed. </para>
+            <para>BitBake handles dependencies at the task level since to allow for efficient operation with multiple processed executing in parallel. A robust method of specifying task dependencies is therefore needed. </para>
             <section>
                 <title>Dependencies internal to the .bb file</title>
                 <para>Where the dependencies are internal to a given .bb file, the dependencies are handled by the previously detailed addtask directive.</para>
             </section>
 
             <section>
-                <title>DEPENDS</title>
+                <title>Build Dependencies</title>
                 <para>DEPENDS lists build time dependencies. The 'deptask' flag for tasks is used to signify the task of each item listed in DEPENDS which must have completed before that task can be executed.</para>
                 <para><screen>do_configure[deptask] = "do_populate_staging"</screen></para>
                 <para>means the do_populate_staging task of each item in DEPENDS must have completed before do_configure can execute.</para>
             </section>
             <section>
-                <title>RDEPENDS</title>
-                <para>RDEPENDS lists runtime dependencies. The 'rdeptask' flag for tasks is used to signify the task of each item listed in RDEPENDS which must have completed before that task can be executed.</para>
+                <title>Runtime Dependencies</title>
+                <para>The PACKAGES variable lists runtime packages and each of these can have RDEPENDS and RRECOMMENDS runtime dependencies. The 'rdeptask' flag for tasks is used to signify the task of each item runtime dependency which must have completed before that task can be executed.</para>
                 <para><screen>do_package_write[rdeptask] = "do_package"</screen></para>
                 <para>means the do_package task of each item in RDEPENDS must have completed before do_package_write can execute.</para>
             </section>
             <section>
-                <title>Recursive DEPENDS</title>
-                <para>These are specified with the 'recdeptask' flag and is used signify the task(s) of each DEPENDS which must have completed before that task can be executed. It applies recursively so the DEPENDS of each item in the original DEPENDS must be met and so on.</para>
-            </section>
-            <section>
-                <title>Recursive RDEPENDS</title>
-                <para>These are specified with the 'recrdeptask' flag and is used signify the task(s) of each RDEPENDS which must have completed before that task can be executed. It applies recursively so the RDEPENDS of each item in the original RDEPENDS must be met and so on. It also runs all DEPENDS first.</para>
+                <title>Recursive Dependencies</title>
+                <para>These are specified with the 'recrdeptask' flag which is used signify the task(s) of dependencies which must have completed before that task can be executed. It works by looking though the build and runtime dependencies of the current recipe as well as any inter-task dependencies the task has, then adding a dependency on the listed task. It will then recurse through the dependencies of those tasks and so on.</para>
+                <para>It may be desireable to recurse not just through the dependencies of those tasks but through the build and runtime dependencies of dependent tasks too. If that is the case, the taskname itself should be referenced in the task list, e.g. do_a[recrdeptask] = "do_a do_b".</para>
             </section>
             <section>
                 <title>Inter task</title>
-                <para>The 'depends' flag for tasks is a more generic form of which allows an interdependency on specific tasks rather than specifying the data in DEPENDS or RDEPENDS.</para>
+                <para>The 'depends' flag for tasks is a more generic form of which allows an interdependency on specific tasks rather than specifying the data in DEPENDS.</para>
                 <para><screen>do_patch[depends] = "quilt-native:do_populate_staging"</screen></para>
                 <para>means the do_populate_staging task of the target quilt-native must have completed before the do_patch can execute.</para>
+                <para>The 'rdepends' flag works in a similar way but takes targets in the runtime namespace instead of the build time dependency namespace.
             </section>
         </section>
 




