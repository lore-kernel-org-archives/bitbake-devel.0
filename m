Return-Path: <niko.mauno@iki.fi>
X-Greylist: delayed 602 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 23 Mar 2018 09:39:43 UTC
Received: from sinikuusama2.dnainternet.net (sinikuusama2.dnainternet.net
	[83.102.40.152])
	by mail.openembedded.org (Postfix) with ESMTP id 864E378830
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Mar 2018 09:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by sinikuusama2.dnainternet.net (Postfix) with ESMTP id 20F371034B;
	Fri, 23 Mar 2018 11:29:41 +0200 (EET)
X-Virus-Scanned: DNA Internet at dnainternet.net
X-Spam-Flag: NO
X-Spam-Score: 0.652
X-Spam-Level: 
X-Spam-Status: No, score=0.652 tagged_above=-9999 required=6
	tests=[SPF_NEUTRAL=0.652] autolearn=disabled
Received: from sinikuusama2.dnainternet.net ([83.102.40.152])
	by localhost (sinikuusama2.dnainternet.net [127.0.0.1]) (DNA Internet,
	port 10041)
	with ESMTP id zZwWuABcccW3; Fri, 23 Mar 2018 11:29:40 +0200 (EET)
Received: from kirsikkapuu2.dnainternet.net (kirsikkapuu2.dnainternet.net
	[83.102.40.52])
	by sinikuusama2.dnainternet.net (Postfix) with ESMTP id 7B0EFF9CE;
	Fri, 23 Mar 2018 11:28:38 +0200 (EET)
Received: from localhost.localdomain (82-181-15-94.bb.dnainternet.fi
	[82.181.15.94])
	by kirsikkapuu2.dnainternet.net (Postfix) with ESMTP id 5A4F73FE5;
	Fri, 23 Mar 2018 11:28:36 +0200 (EET)
From: Niko Mauno <niko.mauno@iki.fi>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Mar 2018 11:28:21 +0200
Message-Id: <20180323092821.106187-1-niko.mauno@iki.fi>
X-Mailer: git-send-email 2.16.2
Subject: [PATCH] bitbake: fetch2/svn: Add tarsnapshots parameter
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
X-List-Received-Date: Fri, 23 Mar 2018 09:39:44 -0000

By adding 'tarsnapshots=currentonly' option to svn-specific component in
SRC_URI, associated subversion repository module's existing tarball
snapshots are removed from DL_DIR, before creating a new one.

This provides a means to avoid downloads directory becoming congested
with a subversion repository module's tarball snapshots, which may occur
for example during circumstances where source code residing in a
subversion repository is subject to long-term development work, and
recipe used in continuous integration builds has SRCREV set to AUTOREV.

Signed-off-by: Niko Mauno <niko.mauno@iki.fi>
---
 bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml | 6 ++++++
 bitbake/lib/bb/fetch2/svn.py                                     | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
index 29ae486a7c..b4f1f673ec 100644
--- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
+++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-fetching.xml
@@ -484,6 +484,12 @@
                         You can use this parameter to specify the ssh
                         program used by svn.
                         </para></listitem>
+                    <listitem><para><emphasis>"tarsnapshots":</emphasis>
+                        If this optional parameter is set to "currentonly" then
+                        any previously created tarball snapshots of associated
+                        repository module are removed from DL_DIR, before
+                        creating a new one.
+                        </para></listitem>
                     <listitem><para><emphasis>"transportuser":</emphasis>
                         When required, sets the username for the transport.
                         By default, this parameter is empty.
diff --git a/bitbake/lib/bb/fetch2/svn.py b/bitbake/lib/bb/fetch2/svn.py
index 3f172eec9b..3b58492f8f 100644
--- a/bitbake/lib/bb/fetch2/svn.py
+++ b/bitbake/lib/bb/fetch2/svn.py
@@ -148,6 +148,12 @@ class Svn(FetchMethod):
         else:
             tar_flags = "--exclude='.svn'"
 
+        tarsnapshots = ud.parm.get("tarsnapshots", "")
+        if tarsnapshots == "currentonly":
+            rm_path = ud.localpath.replace('_%s_.tar.' % ud.revision, '_[0-9]*_.tar.')
+            bb.utils.remove(rm_path)
+            bb.utils.remove(rm_path + '.done')
+
         # tar them up to a defined filename
         runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, ud.path_spec), d,
                     cleanup=[ud.localpath], workdir=ud.pkgdir)
-- 
2.16.2


