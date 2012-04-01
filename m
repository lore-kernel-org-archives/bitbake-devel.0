Received: from astoria.ccjclearline.com ([64.235.106.9])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <rpjday@crashcourse.ca>) id 1SEOwB-0002jP-82
	for bitbake-devel@lists.openembedded.org;
	Sun, 01 Apr 2012 19:51:35 +0200
Received: from cpec03f0ed08c7f-cm001ac318e826.cpe.net.cable.rogers.com
	([99.241.91.63] helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <rpjday@crashcourse.ca>)
	id 1SEOnM-0005Gm-VG for bitbake-devel@lists.openembedded.org;
	Sun, 01 Apr 2012 13:42:29 -0400
Date: Sun, 1 Apr 2012 13:42:14 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@oneiric
To: BitBake developer list <bitbake-devel@lists.openembedded.org>
Message-ID: <alpine.DEB.2.02.1204011341180.28083@oneiric>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
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
Subject: [PATCH] Fix typo in user manual: "incarantion" -> "incarnation"
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
X-List-Received-Date: Sun, 01 Apr 2012 17:51:35 -0000
Content-Type: TEXT/PLAIN; charset=US-ASCII


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/doc/manual/usermanual.xml b/doc/manual/usermanual.xml
index a677789..f894dfc 100644
--- a/doc/manual/usermanual.xml
+++ b/doc/manual/usermanual.xml
@@ -251,7 +251,7 @@ of the event and the content of the <varname>FILE</varname> variable.</para>
             <section>
                 <title>Variants</title>
                 <para>Two BitBake features exist to facilitate the creation of multiple buildable incarnations from a single recipe file.</para>
-                <para>The first is <varname>BBCLASSEXTEND</varname>.  This variable is a space separated list of classes used to "extend" the recipe for each variant.  As an example, setting <screen>BBCLASSEXTEND = "native"</screen> results in a second incarnation of the current recipe being available.  This second incarantion will have the "native" class inherited.</para>
+                <para>The first is <varname>BBCLASSEXTEND</varname>.  This variable is a space separated list of classes used to "extend" the recipe for each variant.  As an example, setting <screen>BBCLASSEXTEND = "native"</screen> results in a second incarnation of the current recipe being available.  This second incarnation will have the "native" class inherited.</para>
                 <para>The second feature is <varname>BBVERSIONS</varname>.  This variable allows a single recipe to build multiple versions of a project from a single recipe file, and allows you to specify conditional metadata (using the <varname>OVERRIDES</varname> mechanism) for a single version, or an optionally named range of versions:</para>
                 <para><screen>BBVERSIONS = "1.0 2.0 git"
 SRC_URI_git = "git://someurl/somepath.git"</screen></para>

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================


