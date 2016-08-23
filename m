Return-Path: <jeremy.rosen@smile.fr>
Received: from idris.smile.fr (idris.smile.fr [91.216.209.19])
	by mail.openembedded.org (Postfix) with ESMTP id CEDB9731DB
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Aug 2016 09:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by idris.smile.fr (Postfix) with ESMTP id 415CF1EE081E;
	Tue, 23 Aug 2016 11:45:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at smile.fr
Received: from idris.smile.fr ([127.0.0.1])
	by localhost (bluemind-mta.prod.vitry.intranet [127.0.0.1])
	(amavisd-new, port 10024)
	with ESMTP id I+Iv3T5UpCrt; Tue, 23 Aug 2016 11:45:03 +0200 (CEST)
Received: from pcrosen.daviel.openwide.fr (unknown [193.56.60.161])
	by idris.smile.fr (Postfix) with ESMTPA id 7D9141EE0476;
	Tue, 23 Aug 2016 11:45:02 +0200 (CEST)
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Rosen?= <jeremy.rosen@smile.fr>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 23 Aug 2016 11:44:50 +0200
Message-Id: <cover.d26c020bb7163ba8281b0826f12094be699d8182.1471945418.git-series.jeremy.rosen@smile.fr>
X-Mailer: git-send-email 2.9.3
MIME-Version: 1.0
Subject: [PATCH v2 0/1][resend] Add a syntax to unset variable from bitbake configuration file
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
X-List-Received-Date: Tue, 23 Aug 2016 09:45:05 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

While working on a Yocto project I had a need to reactivate a task that was
disabled (do_fetch[noexec]="1") Currently, bitbake does not check the value
of the noexec flag but only if the flag is set. The only way to unset a flag
is to use an inline python syntax like the one below

python () {
   d.delVarFlag("do_fetch","noexec")
}

Using inline python to do something as simple as clearing a flag sounded too
complicated to me so I added a new keyword "unset" to bitbake with the
following syntax :

unset VAR

will call d.delVar("VAR")

unset VAR[flag]

will call d.delVarFlag("VAR","flag")

Documentation has been updated accordingly

---
v2 : fix some wording in documentation
     add unit test

Jérémy Rosen (1):
  add a syntax to clear variable

 bitbake/doc/bitbake-user-manual/bitbake-user-manual-metadata.xml | 17 ++++-
 bitbake/lib/bb/parse/ast.py                                      | 33 +++++++-
 bitbake/lib/bb/parse/parse_py/ConfHandler.py                     | 12 +++-
 bitbake/lib/bb/tests/parse.py                                    | 17 ++++-
 4 files changed, 79 insertions(+), 0 deletions(-)

-- 
git-series 0.8.9

