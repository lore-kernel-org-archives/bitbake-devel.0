Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1TCdL5-0004k9-KP
	for bitbake-devel@lists.openembedded.org;
	Fri, 14 Sep 2012 23:22:15 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q8EL9dij013361
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Sep 2012 14:09:39 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.64) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Fri, 14 Sep 2012 14:09:38 -0700
From: Peter Seebach <peter.seebach@windriver.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 14 Sep 2012 16:09:37 -0500
Message-ID: <cover.1347656669.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.0.4
MIME-Version: 1.0
Subject: v3 or so [PATCH 0/1] File inclusion tracking (cleaned up)
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
X-List-Received-Date: Fri, 14 Sep 2012 21:22:16 -0000
Content-Type: text/plain

This is *just* the file inclusion tracking. Spent a while looking
at it, improved it, got some great advice from a friend who is
better at Python, improved it more, and ended up with something I think
is much more maintainable and much clearer. The include tracking
cost is minimal (the expensive stuff went away), so it's currently
done unconditionally.

As before, the main implication is that bitbake -e output starts out:

        #
        # INCLUDE HISTORY:
        #
        # /home/seebs/poky/build/conf/bblayers.conf
        # /home/seebs/poky/meta/conf/layer.conf
        # /home/seebs/poky/meta-yocto/conf/layer.conf
        # /home/seebs/poky/meta-yocto-bsp/conf/layer.conf
        # conf/bitbake.conf includes:
        #   /home/seebs/poky/meta/conf/abi_version.conf
        [...]

The idea is that if you are getting syntax errors in a file, and you
don't even know *why*, this makes it possible to see. For a smallish
build, the include history is only maybe 50-60 lines, so it's not a
big impact on the size of the bitbake -e output.

The following changes since commit ac75b06744e73399ca1fbda322ef851ae5754b0a:
  Valentin Popa (1):
        Implement 'settings' dialog as designed

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib seebs/include
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=seebs/include

Peter Seebach (1):
  data_smart.py and friends: Track file inclusions for bitbake -e

 lib/bb/cooker.py         |    5 +++++
 lib/bb/data_smart.py     |   44 ++++++++++++++++++++++++++++++++++++++++++++
 lib/bb/parse/__init__.py |    3 ++-
 3 files changed, 51 insertions(+), 1 deletions(-)



