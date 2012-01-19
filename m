Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dvhart@linux.intel.com>) id 1Rnzy1-0004U4-V5
	for bitbake-devel@lists.openembedded.org;
	Thu, 19 Jan 2012 22:56:22 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 19 Jan 2012 13:47:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="100564187"
Received: from unknown (HELO localhost) ([10.7.199.147])
	by orsmga002.jf.intel.com with ESMTP; 19 Jan 2012 13:47:35 -0800
From: Darren Hart <dvhart@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel@lists.openembedded.org
Date: Thu, 19 Jan 2012 13:46:38 -0800
Message-Id: <4a879ac75cf9be17efc7168b5ee87119e724d23c.1327009447.git.dvhart@linux.intel.com>
X-Mailer: git-send-email 1.7.6.5
In-Reply-To: <cover.1327009447.git.dvhart@linux.intel.com>
References: <cover.1327009447.git.dvhart@linux.intel.com>
In-Reply-To: <cover.1327009447.git.dvhart@linux.intel.com>
References: <cover.1327009447.git.dvhart@linux.intel.com>
Subject: [PATCH 1/1] metadata: Correct "inherit" search to bbclass from oeclass
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
X-List-Received-Date: Thu, 19 Jan 2012 21:56:22 -0000

Bitbake looks for bbclass now, not oeclass. Update the docs accordingly.

Signed-off-by: Darren Hart <dvhart@linux.intel.com>
---
 bitbake/doc/manual/usermanual.xml |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bitbake/doc/manual/usermanual.xml b/bitbake/doc/manual/usermanual.xml
index fa53ace..a677789 100644
--- a/bitbake/doc/manual/usermanual.xml
+++ b/bitbake/doc/manual/usermanual.xml
@@ -204,7 +204,7 @@ include</literal> directive.</para>
             <section>
                 <title>Inheritance</title>
                 <para><emphasis>NOTE:</emphasis> This is only supported in .bb and .bbclass files.</para>
-                <para>The <literal>inherit</literal> directive is a means of specifying what classes of functionality your .bb requires.  It is a rudimentary form of inheritance.  For example, you can easily abstract out the tasks involved in building a package that uses autoconf and automake, and put that into a bbclass for your packages to make use of.  A given bbclass is located by searching for classes/filename.oeclass in <envar>BBPATH</envar>, where filename is what you inherited.</para>
+                <para>The <literal>inherit</literal> directive is a means of specifying what classes of functionality your .bb requires.  It is a rudimentary form of inheritance.  For example, you can easily abstract out the tasks involved in building a package that uses autoconf and automake, and put that into a bbclass for your packages to make use of.  A given bbclass is located by searching for classes/filename.bbclass in <envar>BBPATH</envar>, where filename is what you inherited.</para>
             </section>
             <section>
                 <title>Tasks</title>
-- 
1.7.6.5



