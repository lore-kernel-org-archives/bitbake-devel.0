Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RUc8M-0003bL-KF
	for bitbake-devel@lists.openembedded.org;
	Sun, 27 Nov 2011 11:38:54 +0100
Received: by opal (Postfix, from userid 111)
	id 50B461032F; Sun, 27 Nov 2011 10:35:06 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111127103506.50B461032F@opal>
Date: Sun, 27 Nov 2011 10:35:06 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : Update users of getVar/ setVar to use the data store functions directly
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
X-List-Received-Date: Sun, 27 Nov 2011 10:38:54 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: 9f7978ca4d59b92721de508113dbac30721014d9
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=9f7978ca4d59b92721de508113dbac30721014d9

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Fri Nov 25 14:57:53 2011 +0000

Update users of getVar/setVar to use the data store functions directly

(From Poky rev: affd0907253387cee0ba0c7e9f92bcc109895446)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 bin/bitdoc                           |    2 +-
 doc/manual/usermanual.xml            |    2 +-
 lib/bb/build.py                      |    4 +-
 lib/bb/cache.py                      |    5 +-
 lib/bb/codeparser.py                 |    4 +-
 lib/bb/command.py                    |    5 +-
 lib/bb/cooker.py                     |   56 ++++++++++----------
 lib/bb/data.py                       |    4 +-
 lib/bb/data_smart.py                 |    2 +-
 lib/bb/fetch/__init__.py             |   32 ++++++------
 lib/bb/fetch/git.py                  |    6 +-
 lib/bb/fetch2/__init__.py            |   78 +++++++++++++-------------
 lib/bb/fetch2/git.py                 |    4 +-
 lib/bb/parse/__init__.py             |    6 +-
 lib/bb/parse/ast.py                  |  100 +++++++++++++++++-----------------
 lib/bb/parse/parse_py/BBHandler.py   |    2 +-
 lib/bb/parse/parse_py/ConfHandler.py |   18 +++---
 lib/bb/persist_data.py               |    6 +-
 lib/bb/providers.py                  |    8 ++--
 lib/bb/runqueue.py                   |   26 +++++-----
 lib/bb/siggen.py                     |    2 +-
 lib/bb/ui/crumbs/configurator.py     |    4 +-
 lib/bb/utils.py                      |    6 +-
 23 files changed, 190 insertions(+), 192 deletions(-)

Diff:   http://git.openembedded.org/?p=bitbake.git/?a=commitdiff;h=9f7978ca4d59b92721de508113dbac30721014d9


