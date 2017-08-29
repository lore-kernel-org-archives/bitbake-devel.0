Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 803E7782F0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Aug 2017 20:38:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 748E81842D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Aug 2017 22:33:06 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id n68c8g19SryX for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Aug 2017 22:33:04 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id 813EE18410
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Aug 2017 22:33:04 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C3171E095
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Aug 2017 22:33:04 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6102C1E094
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Aug 2017 22:33:04 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder03.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Aug 2017 22:33:04 +0200 (CEST)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by seth.se.axis.com (Postfix) with ESMTP id 553512186
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Aug 2017 22:33:04 +0200 (CEST)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id v7TKX3OC021348
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Aug 2017 22:33:03 +0200
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id v7TKX3iA021344
	for bitbake-devel@lists.openembedded.org;
	Tue, 29 Aug 2017 22:33:03 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 29 Aug 2017 22:33:00 +0200
Message-Id: <cover.1504038736.git.pkj@axis.com>
X-Mailer: git-send-email 2.12.0
X-TM-AS-GCONF: 00
Subject: [PATCH 0/1] Avoid build failures due to setscene errors
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
X-List-Received-Date: Tue, 29 Aug 2017 20:38:58 -0000

Occasionally, we see errors on our autobuilders where a setscene task
fails to retrieve a file from our global sstate cache. It typically
looks something like this:

WARNING: zip-3.0-r2 do_populate_sysroot_setscene: Failed to fetch URL
file://66/sstate:zip:core2-64-poky-linux:3.0:r2:core2-64:3:\
66832b8c4e7babe0eac9d9579d1e2b6a_populate_sysroot.tgz;\
downloadfilename=66/sstate:zip:core2-64-poky-linux:3.0:r2:core2-64:3:\
66832b8c4e7babe0eac9d9579d1e2b6a_populate_sysroot.tgz, attempting
MIRRORS if available
ERROR: zip-3.0-r2 do_populate_sysroot_setscene: Fetcher failure:
Unable to find file
file://66/sstate:zip:core2-64-poky-linux:3.0:r2:core2-64:3:\
66832b8c4e7babe0eac9d9579d1e2b6a_populate_sysroot.tgz;\
downloadfilename=66/sstate:zip:core2-64-poky-linux:3.0:r2:core2-64:3:\
66832b8c4e7babe0eac9d9579d1e2b6a_populate_sysroot.tgz anywhere. The
paths that were searched were:
    /home/pkj/.openembedded/sstate-cache
ERROR: zip-3.0-r2 do_populate_sysroot_setscene: No suitable staging
package found
WARNING: Setscene task
(meta/recipes-extended/zip/zip_3.0.bb:do_populate_sysroot_setscene)
failed with exit code '1' - real task will be run instead

As the last warning indicates, the build will proceed and the real
task will run and the build will eventually complete. However, due to
the two errors above, bitbake will return with an error code which
causes the autobuilder to treat the build as failed and it proceeds to
throw everything it built away.

Since this is quite pointless and causes unnecessary build resources
to be spent and grief from the developers, the two patches in this
change set turn the errors from setscene tasks into warnings.

Well, there is actually only one patch in this change set, as the
other patch is for OE-Core...

//Peter

The following changes since commit bc2e0b2e9b95707d96c840dade12b00e1450ecc3:

  libsdl: Move PACKAGECONFIG options from meta-mingw (2017-08-29 12:23:10 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib pkj/setscene-errors-bitbake
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=pkj/setscene-errors-bitbake

Peter Kjellerstedt (1):
  fetch2: Allow Fetch.download() to warn instead of error

 bitbake/lib/bb/fetch2/__init__.py | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

-- 
2.12.0


