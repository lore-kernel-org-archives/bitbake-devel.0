Return-Path: <mcfrisk@kapsi.fi>
X-Greylist: delayed 2397 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 01 Jun 2017 16:31:44 UTC
Received: from mail.kapsi.fi (mail.kapsi.fi [217.30.184.167])
	by mail.openembedded.org (Postfix) with ESMTP id 0FAC677D3C
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Jun 2017 16:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; 
	h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
	bh=G30OZuPID3dmsHyiK6QcnxgoLWwlmcRv1x8ug/xufiI=; 
	b=LL7Ick5x34jomu+WwrX4re/KNMgaQEkejl74uP4Z6XFeyWPFcqR1wU1KtxR8O37l30oeZ66HKREHiGF+kxJP9rTilVCtDNiEgiy4+NemJE0NrtgzGhwecq1w+EuQWAMxGiYtOF/VKXkCGiN8yNzM2FPV/91hI6obh2KXtWpW74aum5k/KSxuvDDpnQ8EYxezugP85/xblz4aLoTxNIbDQ8OqyaYEgOJCa3dPClghRm6Ixd/H42ufWXIenyeCD5F7S02MihVd8gXTsXsiuToN+yF9GsyZ9WGUFd8ePBrqkc3NgEUHN3YeKo4rWCMDxjIkIT/W2Xwriy+TJ7yPS+qEWg==;
Received: from lakka.kapsi.fi ([2001:1bc8:1004::1] ident=Debian-exim)
	by mail.kapsi.fi with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.84_2) (envelope-from <mcfrisk@kapsi.fi>)
	id 1dGSO0-0005IM-Ug; Thu, 01 Jun 2017 18:51:44 +0300
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.84_2)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1dGSO0-0006WI-TE; Thu, 01 Jun 2017 18:51:44 +0300
From: Mikko Rapeli <mikko.rapeli@bmw.de>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  1 Jun 2017 18:51:33 +0300
Message-Id: <1496332293-23469-1-git-send-email-mikko.rapeli@bmw.de>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <20170601125029.wli6reydiovo7xjk@hiutale>
References: <20170601125029.wli6reydiovo7xjk@hiutale>
X-SA-Exim-Connect-IP: 2001:1bc8:1004::1
X-SA-Exim-Mail-From: mcfrisk@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Cc: openembedded-core@lists.openembedded.org
Subject: [PATCH 1/3 v2] bitbake: Fix return value checks from subprocess.call()'s
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
X-List-Received-Date: Thu, 01 Jun 2017 16:31:45 -0000

Python function subprocess.call() returns the return value of the
executed process. If return values are not checked, errors may
go unnoticed and bad things can happen.

Change all callers of subprocess.call() which do not check for
the return value to use subprocess.check_call() which raises
CalledProcessError if the subprocess returns with non-zero value.

https://docs.python.org/2/library/subprocess.html#using-the-subprocess-module

All users of the function were found with:

$ git grep "subprocess\.call" | \
  egrep -v 'if.*subprocess\.call|=\ +subprocess\.call|return.*subprocess\.call'

Tested similar patch on top of yocto jethro. Only compile tested
core-image-minimal on poky master branch.

Signed-off-by: Mikko Rapeli <mikko.rapeli@bmw.de>
---
 bitbake/lib/bb/ui/ncurses.py | 2 +-
 bitbake/lib/bb/utils.py      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

v2:
split patches to bitbake, meta and scripts

v1:
http://lists.openembedded.org/pipermail/openembedded-core/2017-May/136901.html

diff --git a/bitbake/lib/bb/ui/ncurses.py b/bitbake/lib/bb/ui/ncurses.py
index d81e413..ca845a3 100644
--- a/bitbake/lib/bb/ui/ncurses.py
+++ b/bitbake/lib/bb/ui/ncurses.py
@@ -297,7 +297,7 @@ class NCursesUI:
 #                            bb.error("log data follows (%s)" % logfile)
 #                            number_of_lines = data.getVar("BBINCLUDELOGS_LINES", d)
 #                            if number_of_lines:
-#                                subprocess.call('tail -n%s %s' % (number_of_lines, logfile), shell=True)
+#                                subprocess.check_call('tail -n%s %s' % (number_of_lines, logfile), shell=True)
 #                            else:
 #                                f = open(logfile, "r")
 #                                while True:
diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 077fddc..6a44db5 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -680,7 +680,7 @@ def remove(path, recurse=False):
             if _check_unsafe_delete_path(path):
                 raise Exception('bb.utils.remove: called with dangerous path "%s" and recurse=True, refusing to delete!' % path)
         # shutil.rmtree(name) would be ideal but its too slow
-        subprocess.call(['rm', '-rf'] + glob.glob(path))
+        subprocess.check_call(['rm', '-rf'] + glob.glob(path))
         return
     for name in glob.glob(path):
         try:
-- 
1.9.1


