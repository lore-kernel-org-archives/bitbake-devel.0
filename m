Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1RJnrP-0003P3-5f
	for bitbake-devel@lists.openembedded.org;
	Fri, 28 Oct 2011 16:56:44 +0200
Received: by gyc15 with SMTP id 15so3656448gyc.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Oct 2011 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=from:to:subject:date:message-id:x-mailer;
	bh=r527l7PiVjokyu9HYDxxSS+FIqAZiKcjM3TIXo2CYp0=;
	b=M0MVCghw+rZUXbX6Vxnp+LIRWjnhrjDE+B/lBhCIZ+ky+CIrabPz7Wrx8U/hsV9UNx
	bbmqqr8IBgNSEl68i8vj86n0QamrBiWdyX+Hdg5c2z66bhLUTomxkw4ViPtqcNuJ3zQs
	ITqZ+546BCkGe9TlM1DkpJ/OOeu0+hSSzflNM=
Received: by 10.151.25.12 with SMTP id c12mr2944927ybj.85.1319813441160;
	Fri, 28 Oct 2011 07:50:41 -0700 (PDT)
Received: from localhost.localdomain (ip24-251-167-38.ph.ph.cox.net.
	[24.251.167.38])
	by mx.google.com with ESMTPS id 4sm25218924ano.9.2011.10.28.07.50.33
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 28 Oct 2011 07:50:33 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Oct 2011 07:50:22 -0700
Message-Id: <cover.1319813177.git.kergoth@gmail.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/2] Simplify PythonParser
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
X-List-Received-Date: Fri, 28 Oct 2011 14:56:44 -0000

As you can see below, this simplifies the python parser by merging its nested
class into the main class, and by simplifying the name comparison logic. This
also seems to increase up front parse performance slightly, as can be seen
here, the result of wiping the cache and running bitbake -p repeatedly:

Old:
  77.72user 11.98system 1:12.54elapsed 123%CPU (0avgtext+0avgdata 509456maxresident)k
  0inputs+32136outputs (0major+132904minor)pagefaults 0swaps
  77.48user 12.73system 1:12.28elapsed 124%CPU (0avgtext+0avgdata 508704maxresident)k
  0inputs+32096outputs (0major+134062minor)pagefaults 0swaps
  80.30user 9.69system 1:04.96elapsed 138%CPU (0avgtext+0avgdata 511520maxresident)k
  0inputs+32112outputs (0major+132475minor)pagefaults 0swaps
  79.53user 11.29system 1:05.46elapsed 138%CPU (0avgtext+0avgdata 510704maxresident)k
  0inputs+32088outputs (0major+132093minor)pagefaults 0swaps
  78.89user 10.94system 1:09.31elapsed 129%CPU (0avgtext+0avgdata 505616maxresident)k
  0inputs+32136outputs (0major+132909minor)pagefaults 0swaps
  79.70user 10.41system 1:08.17elapsed 132%CPU (0avgtext+0avgdata 511632maxresident)k
  0inputs+32088outputs (0major+133901minor)pagefaults 0swaps

New:
  69.95user 17.44system 1:01.31elapsed 142%CPU (0avgtext+0avgdata 502032maxresident)k
  0inputs+32104outputs (0major+130402minor)pagefaults 0swaps
  75.36user 10.14system 1:04.88elapsed 131%CPU (0avgtext+0avgdata 504784maxresident)k
  0inputs+32096outputs (0major+133487minor)pagefaults 0swaps
  73.12user 12.70system 1:03.68elapsed 134%CPU (0avgtext+0avgdata 505440maxresident)k
  0inputs+32096outputs (0major+132893minor)pagefaults 0swaps
  74.68user 10.08system 1:04.64elapsed 131%CPU (0avgtext+0avgdata 522384maxresident)k
  0inputs+32056outputs (0major+132502minor)pagefaults 0swaps
  75.59user 9.59system 1:03.46elapsed 134%CPU (0avgtext+0avgdata 509760maxresident)k
  0inputs+32072outputs (0major+133315minor)pagefaults 0swaps
  75.33user 10.12system 1:02.48elapsed 136%CPU (0avgtext+0avgdata 509568maxresident)k
  0inputs+32104outputs (0major+133788minor)pagefaults 0swaps

The following changes since commit 8e4e75383e43d6da2c16ec5286186a0d0569b0f8:

  codeparser: make var_expands actually hold useful information (2011-10-27 22:45:52 -0700)

are available in the git repository at:
  https://github.com/kergoth/bitbake codeparser-cleanup

Christopher Larson (2):
      codeparser: merge the nested python parsing classes
      codeparser: simplify how we compare the called node names

 lib/bb/codeparser.py |  157 +++++++++++++++++--------------------------------
 1 files changed, 55 insertions(+), 102 deletions(-)

Christopher Larson (2):
  codeparser: merge the nested python parsing classes
  codeparser: simplify how we compare the called node names

 lib/bb/codeparser.py |  157 +++++++++++++++++--------------------------------
 1 files changed, 55 insertions(+), 102 deletions(-)

-- 
1.7.7



