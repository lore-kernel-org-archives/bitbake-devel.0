Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1TtsV4-0005xb-Ek
	for bitbake-devel@lists.openembedded.org;
	Sat, 12 Jan 2013 05:15:21 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r0C1f1cN004835
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Jan 2013 17:41:01 -0800 (PST)
Received: from localhost.localdomain (172.25.34.64) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Fri, 11 Jan 2013 17:41:01 -0800
From: Peter Seebach <peter.seebach@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 11 Jan 2013 19:40:57 -0600
Message-ID: <cover.1357954043.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.0.4
MIME-Version: 1.0
Subject: [PATCH 0/2] Variable tracking: Cleaned up and rebased.
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
X-List-Received-Date: Sat, 12 Jan 2013 04:15:21 -0000
Content-Type: text/plain

This is the much-famed "variable tracking" patch. Rebased against current
bitbake, fixed a couple of things.

WHAT IT DOES:

        $ bitbake -e > variable_history

        $ cat variable_history
        #
        # INCLUDE HISTORY:
        #
        # /home/seebs/oe-core/build/conf/bblayers.conf
        # /home/seebs/oe-core/meta/conf/layer.conf
        # conf/bitbake.conf includes:
        #   /home/seebs/oe-core/meta/conf/abi_version.conf
        #   conf/site.conf
        #   conf/auto.conf
        #   /home/seebs/oe-core/build/conf/local.conf
        [...]
        # $prefix [2 operations]
        #   exported conf/bitbake.conf:17
        #     [export] "1"
        #   set conf/bitbake.conf:17
        #     "/usr"
        # computed:
        #   "/usr"
        export prefix="/usr"
        [...]

This can get pretty useful if you're trying to find out, say, where
the -m32 came from in TUNE_CCARGS:

        # $TUNE_CCARGS [6 operations]
        #   set conf/bitbake.conf:105
        #     [defaultval] ""
        #   set conf/bitbake.conf:106
        #     [vardepvalue] "${TUNE_CCARGS}"
        #   append /home/seebs/oe-core/meta/conf/machine/include/ia32/arch-ia32.inc:16
        #     "${@bb.utils.contains("TUNE_FEATURES", "m32", "-m32", "", d)}"
        #   append /home/seebs/oe-core/meta/conf/machine/include/ia32/arch-ia32.inc:24
        #     "${@bb.utils.contains("TUNE_FEATURES", "mx32", "-mx32", "", d)}"
        #   append /home/seebs/oe-core/meta/conf/machine/include/ia32/arch-ia32.inc:32
        #     "${@bb.utils.contains("TUNE_FEATURES", "m64", "-m64", "", d)}"
        #   append /home/seebs/oe-core/meta/conf/machine/include/tune-i586.inc:7
        #     "${@bb.utils.contains("TUNE_FEATURES", "i586", "-march=i586", "", d)}"
        # computed:
        #   " ${@bb.utils.contains("TUNE_FEATURES", "m32", "-m32", "", d)} ${@bb.utils.contains("TUNE_FEATURES", "mx32", "-mx32", "", d)} ${@bb.utils.contains("TUNE_FEATURES", "m64", "-m64", "", d)} ${@bb.utils.contains("TUNE_FEATURES", "i586", "-march=i586", "", d)}"
        TUNE_CCARGS="-m32   -march=i586"
        #

The cleanup since the last version is pretty minor, but there was one real
bug: If any part of a variable's history showed a modification from Python
code (with a function name) rather than from the parser, the variable's
value would be displayed as though it were a function. Whoops.

The output for renames is now much more useful than it was before, though:

# $SECTION_${PN}-dbg [2 operations]
#   set conf/bitbake.conf:316
#     "devel"
#   rename (to) data.py:161 [expandKeys]
#     "SECTION_core-image-minimal-dbg"
# computed:
#   "None"

and

# $SECTION_core-image-minimal-dbg
#   rename from SECTION_${PN}-dbg data.py:161 [expandKeys]
#     "devel"
SECTION_core-image-minimal-dbg="devel"

I remain a little unhappy with the loginfo stuff, in particular the
possible clash between keys in loginfo and non-keyword arguments, but
I can't really think of a way to make it definitely better, and the
much-less-intrusive usage strikes me as a big enough improvement to
justify it. (Picking different names for the keyword arguments would
reduce clashes, and also legibility in cases where they're being
specified.)

The following changes since commit dee7decf87dfa8cb966fe40846d27f3e6ab1846b:
  Richard Purdie (1):
        build.py: Fix traceback when there are no dependencies

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib seebs/incvar
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=seebs/incvar

Peter Seebach (2):
  data_smart.py and friends: Track file inclusions for bitbake -e
  data_smart.py and friends: Track variable history

 lib/bb/cooker.py                   |   15 ++-
 lib/bb/data.py                     |   38 +++++-
 lib/bb/data_smart.py               |  250 ++++++++++++++++++++++++++++++++----
 lib/bb/parse/__init__.py           |    3 +-
 lib/bb/parse/ast.py                |   25 +++-
 lib/bb/parse/parse_py/BBHandler.py |    6 +-
 6 files changed, 299 insertions(+), 38 deletions(-)



