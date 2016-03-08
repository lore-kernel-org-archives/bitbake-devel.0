Return-Path: <peter.kjellerstedt@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 6F8E56FEF6
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Mar 2016 23:54:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id D26912E1C5
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 00:54:05 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 2XbBmbM0iE83 for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 00:54:03 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id 77B9B2E1C3
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 00:54:03 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 589E31426
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 00:54:03 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 4D4841413
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 00:54:03 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by seth.se.axis.com (Postfix) with ESMTP id 4B58F61E
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 00:54:03 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id u28Ns3Zp023119
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 9 Mar 2016 00:54:03 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id u28Ns3hn023118
	for bitbake-devel@lists.openembedded.org; Wed, 9 Mar 2016 00:54:03 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Mar 2016 00:53:57 +0100
Message-Id: <cover.1457481171.git.pkj@axis.com>
X-Mailer: git-send-email 2.1.0
Subject: [PATCH 0/1] Make the fetcher expand checksums
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
X-List-Received-Date: Tue, 08 Mar 2016 23:54:06 -0000

We needed a way to override the checksums for a recipe from a
configuration file, e.g., local.conf. I first tried the naive:

    SRC_URI_pn-myrecipe[md5sum] = "123abc..."
    SRC_URI_pn-myrecipe[sha256sum] = "abcd1234..."

which of course did not work. Then I modified the recipe as:

    SRC_URI = "http://.../${PN}-${PV}.tar.gz"

    MD5SUM = "123abc..."
    SHA256SUM = "abcd1234..."

    SRC_URI[md5sum] = "${MD5SUM}"
    SRC_URI[sha256sum] = "${SHA256SUM}"

which I had assumed would work, but it did not. Finally I tried:

    MD5SUM = "123abc..."
    SHA256SUM = "abcd1234..."

    SRC_URI = "http://.../${PN}-${PV}.tar.gz;md5sum=${MD5SUM};sha256sum=${SHA256SUM}"

which actually did work.

Looking into why the second solution above did not work it turned out
that the fetcher code called d.getVarFlag("SRC_URI", ..., False),
i.e., without expanding the checksum values. I cannot see any reason
not to expand the values, so the following patch does that.

//Peter

The following changes since commit 5ac3dc76a5afc2ed35b1abfc8e330e0c580eadf0:

  image.bbclass: fix incomplete .rootfs customization (2016-03-07 22:10:54 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib pkj/expand_checksums
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=pkj/expand_checksums

Peter Kjellerstedt (1):
  fetch2: Make SRC_URI[md5sum] and SRC_URI[sha256sum] expand their
    values

 bitbake/lib/bb/fetch2/__init__.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.1.0


