Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1SVR7a-0008UW-Rl
	for bitbake-devel@lists.openembedded.org;
	Fri, 18 May 2012 19:37:47 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q4IHRf0a023821
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 May 2012 10:27:41 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.64) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Fri, 18 May 2012 10:27:40 -0700
From: Peter Seebach <peter.seebach@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 18 May 2012 12:27:38 -0500
Message-ID: <cover.1337361285.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.0.4
MIME-Version: 1.0
Subject: [RFC PATCH 0/2] data_smart.py (mostly): Variable and include tracking!
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
X-List-Received-Date: Fri, 18 May 2012 17:37:47 -0000
Content-Type: text/plain

This is a first pass at allowing us to answer that vexing question:

Where the heck did that value come from?

The complexity of bitbake's variable assignment means that even if you
had a complete list of the lines being processed in order, you might need
a few tries to figure out why a variable is set to what it is.  When
debugging, you might want to know what it would have been otherwise,
too; knowing that a given ?= is processed after a +=, for instance,
could save you a great deal of trouble.  To solve this, we add two pieces
of functionality to "bitbake -e".

The first is a list of the .conf/.inc files that were parsed, in order;
the list shows included files indented under the thing that included
them, making it easier to see not just what got processed, but why it got
processed.

The second is a list of all the operations performed on each value, in
order, citing to the file and line number where they happened (whenever
possible).  So, for instance, say I want to know how SSTATETASKS got its
value.  The output of "bitbake -e" now says:

# SSTATETASKS [4]
#   append /home/seebs/poky/meta/classes/staging.bbclass:105:
#     < do_populate_sysroot>
#   append /home/seebs/poky/meta/classes/package.bbclass:1750:
#     < do_populate_sysroot do_package>
#   append /home/seebs/poky/meta/classes/package_rpm.bbclass:1112:
#     < do_populate_sysroot do_package do_package_write_rpm>
#   append /home/seebs/poky/meta/classes/license.bbclass:380:
#     < do_populate_sysroot do_package do_package_write_rpm do_populate_lic>
#
# SSTATETASKS= do_populate_sysroot do_package do_package_write_rpm do_populate_lic

Wait, staging.bbclass?  I don't remember asking for that.  Let's go look
at the include history:

# /home/seebs/poky/meta/classes/base.bbclass includes:
#   /home/seebs/poky/meta/classes/patch.bbclass includes:
#     /home/seebs/poky/meta/classes/terminal.bbclass
#   /home/seebs/poky/meta/classes/staging.bbclass

So this tells me that staging.bbclass was included from base.bbclass.  Yay!
Mystery is solved.  Everything is working because it's doing what it is
supposed to do.  :)

The following changes since commit f8bf4499549f978ce7c93bc088a66f74cd751e2c:
  Martin Jansa (1):
        setup.py: fix path for bitbake-selftest

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib seebs/tracking
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=seebs/tracking

Peter Seebach (2):
  data_smart.py: Provide (optional) logging of variable modifications
  data_smart.py: Track configuration file inclusions

 lib/bb/cooker.py                   |    4 +-
 lib/bb/data.py                     |   46 +++++++++++--
 lib/bb/data_smart.py               |  128 +++++++++++++++++++++++++++--------
 lib/bb/parse/__init__.py           |    8 ++-
 lib/bb/parse/ast.py                |   89 +++++++++++++------------
 lib/bb/parse/parse_py/BBHandler.py |    8 +-
 lib/bb/siggen.py                   |    2 +-
 7 files changed, 198 insertions(+), 87 deletions(-)



