Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RoHX6-0003hk-7Z
	for bitbake-devel@lists.openembedded.org;
	Fri, 20 Jan 2012 17:41:44 +0100
Received: by opal (Postfix, from userid 111)
	id 3588E10334; Fri, 20 Jan 2012 16:43:39 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20120120164339.3588E10334@opal>
Date: Fri, 20 Jan 2012 16:43:39 +0000 (UTC)
From: git@git.openembedded.org
Subject: Darren Hart : usermanual: Correct "inherit" search to bbclass from oeclass
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
X-List-Received-Date: Fri, 20 Jan 2012 16:41:44 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 8b713708541f85a4252c0f7b683aff4407c7d3e0
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=8b713708541f85a4252c0f7b683aff4407c7d3e0

Author: Darren Hart <dvhart@linux.intel.com>
Date:   Thu Jan 19 13:46:38 2012 -0800

usermanual: Correct "inherit" search to bbclass from oeclass

Bitbake looks for bbclass now, not oeclass. Update the docs accordingly.

Signed-off-by: Darren Hart <dvhart@linux.intel.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 doc/manual/usermanual.xml |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/doc/manual/usermanual.xml b/doc/manual/usermanual.xml
index fa53ace..a677789 100644
--- a/doc/manual/usermanual.xml
+++ b/doc/manual/usermanual.xml
@@ -204,7 +204,7 @@ include</literal> directive.</para>
             <section>
                 <title>Inheritance</title>
                 <para><emphasis>NOTE:</emphasis> This is only supported in .bb and .bbclass files.</para>
-                <para>The <literal>inherit</literal> directive is a means of specifying what classes of functionality your .bb requires.  It is a rudimentary form of inheritance.  For example, you can easily abstract out the tasks involved in building a package that uses autoconf and automake, and put that into a bbclass for your packages to make use of.  A given bbclass is located by searching for classes/filename.oeclass in <envar>BBPATH</envar>, where filename is what you inherited.</para>
+                <para>The <literal>inherit</literal> directive is a means of specifying what classes of functionality your .bb requires.  It is a rudimentary form of inheritance.  For example, you can easily abstract out the tasks involved in building a package that uses autoconf and automake, and put that into a bbclass for your packages to make use of.  A given bbclass is located by searching for classes/filename.bbclass in <envar>BBPATH</envar>, where filename is what you inherited.</para>
             </section>
             <section>
                 <title>Tasks</title>



