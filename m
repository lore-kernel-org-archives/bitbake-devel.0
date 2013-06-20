Return-Path: <peter.kjellerstedt@axis.com>
Received: from anubis.se.axis.com (anubis.se.axis.com [195.60.68.12])
	by mail.openembedded.org (Postfix) with ESMTP id 8F322619DE
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 09:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id D527619D8E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 11:36:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id LK5QAK9BmafP for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 11:36:02 +0200 (CEST)
Received: from boulder.localdomain (boulder.se.axis.com [10.0.2.104])
	by anubis.se.axis.com (Postfix) with ESMTP id 4296619DE1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 11:36:00 +0200 (CEST)
Received: from boulder.localdomain (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 25800477
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 11:36:00 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.localdomain (Postfix) with ESMTP id 1A78335E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 11:36:00 +0200 (CEST)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by seth.se.axis.com (Postfix) with ESMTP id 18BB43E06D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 11:36:00 +0200 (CEST)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id r5K9a0aF025413
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Jun 2013 11:36:00 +0200
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id r5K9ZxDG025412
	for bitbake-devel@lists.openembedded.org;
	Thu, 20 Jun 2013 11:35:59 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Jun 2013 11:35:47 +0200
Message-Id: <cover.1371720878.git.pkj@axis.com>
X-Mailer: git-send-email 1.8.2.1
Subject: [PATCH 0/2] Fixes for the fetcher
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 20 Jun 2013 09:36:05 -0000

We need the SFTP fetcher for one of our recipes. As it turned out when I
wrote the recipe, the fetcher failed to retrieve the sources because it
wanted me to specify checksums for them. However, the checksums _were_
specified in the recipe.

After examining the code for the fetcher, it turned out that the list of
fetchers that expect a checksum is hardcoded in the constructor of
FetchData in lib/bb/fetch2/__init__.py, whereas verify_checksum() uses
ud.method.supports_checksum() and ud.method.recommends_checksum() to
determine if a checksum is needed. Needless to say, this of course
failed as the hardcoded values did not match reality.

This patch updates the list of hardcoded fetchers to include SFTP, but I
consider it more of a bandage, and someone with better Python skills
than mine should rewrite the constructor to not use a hardcoded list.

//Peter

The following changes since commit efb8a460d2a977dbd481a0650fba8eb637c65bec:

  package.bbclass: Fix sources contents (2013-05-14 08:52:47 +0300)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib pkj/fetch_sftp
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=pkj/fetch_sftp

Peter Kjellerstedt (2):
  Allow checksums to be used for files retrieved using SFTP
  Correct a typo

 bitbake/lib/bb/fetch2/__init__.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
1.8.2.1


