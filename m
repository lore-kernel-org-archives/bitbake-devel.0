Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RJK67-0007oE-Nj
	for bitbake-devel@lists.openembedded.org;
	Thu, 27 Oct 2011 09:09:57 +0200
Received: by opal (Postfix, from userid 111)
	id 356F91032E; Thu, 27 Oct 2011 07:09:22 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111027070922.356F91032E@opal>
Date: Thu, 27 Oct 2011 07:09:22 +0000 (UTC)
From: git@git.openembedded.org
X-Mailman-Approved-At: Tue, 01 Nov 2011 08:48:59 +0100
Subject: Joshua Lock : doc: update manual for checksum changes
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
X-List-Received-Date: Thu, 27 Oct 2011 07:09:58 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 0a6443f9e1d07865c9fd1dfc0b4622eb1c4c3f3a
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=0a6443f9e1d07865c9fd1dfc0b4622eb1c4c3f3a

Author: Joshua Lock <josh@linux.intel.com>
Date:   Tue Oct 11 13:15:15 2011 -0700

doc: update manual for checksum changes

Document the ability to use SRC_URI parameters for checksums

Signed-off-by: Joshua Lock <josh@linux.intel.com>

---

 doc/manual/usermanual.xml |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/doc/manual/usermanual.xml b/doc/manual/usermanual.xml
index 3a3af6d..687503b 100644
--- a/doc/manual/usermanual.xml
+++ b/doc/manual/usermanual.xml
@@ -388,7 +388,7 @@ ftp://.*/.*      http://somemirror.org/sources/ \n \
 http://.*/.*     http://somemirror.org/sources/ \n \
 https://.*/.*    http://somemirror.org/sources/ \n"</screen></para>
 
-            <para>Non-local downloaded output is placed into the directory specified by the <varname>DL_DIR</varname>. For non local downloads the code can check checksums for the download to ensure the file has been downloaded correctly. These are specified in the form <varname>SRC_URI[md5sum]</varname> for the md5 checksum and <varname>SRC_URI[sha256sum]</varname> for the sha256 checksum. If <varname>BB_STRICT_CHECKSUM</varname> is set, any download without a checksum will trigger an error message. In cases where multiple files are listed in SRC_URI, the name parameter is used assign names to the urls and these are then specified in the checksums in the form SRC_URI[name.sha256sum].</para>
+            <para>Non-local downloaded output is placed into the directory specified by the <varname>DL_DIR</varname>. For non local archive downloads the code can verify sha256 and md5 checksums for the download to ensure the file has been downloaded correctly. These may be specified either in the form <varname>SRC_URI[md5sum]</varname> for the md5 checksum and <varname>SRC_URI[sha256sum]</varname> for the sha256 checksum or as parameters on the SRC_URI such as SRC_URI="http://example.com/foobar.tar.bz2;md5sum=4a8e0f237e961fd7785d19d07fdb994d". If <varname>BB_STRICT_CHECKSUM</varname> is set, any download without a checksum will trigger an error message. In cases where multiple files are listed in SRC_URI, the name parameter is used assign names to the urls and these are then specified in the checksums in the form SRC_URI[name.sha256sum].</para>
 
         </section>
 



