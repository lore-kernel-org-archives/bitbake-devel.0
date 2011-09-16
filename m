Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1R4T7G-0002SI-Sl
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Sep 2011 09:45:42 +0200
Received: by bke11 with SMTP id 11so4596980bke.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2011 00:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=7NPjpIncLc7zaPCS3pewIkHipycb5M2MVp2qR7n0OvE=;
	b=C3nKKdrsFO/obSkmsyhZaQW2xW4ViBgqDBoqSfjSnTNwIErfqHEjyNoQTRGpNVxJci
	kYPm0qgLxLSkU3k78Qi0dfkcVvLkYFZvXdM6m3Xzxl04SwGXy2wY92GfEPBU938LFSCI
	1bgawXIY4FhBxfIonkteZOMS++aPd/8QPNnjg=
Received: by 10.204.140.88 with SMTP id h24mr32928bku.170.1316158653363;
	Fri, 16 Sep 2011 00:37:33 -0700 (PDT)
Received: from localhost ([94.230.152.246])
	by mx.google.com with ESMTPS id v16sm5486223bkd.6.2011.09.16.00.37.31
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 16 Sep 2011 00:37:32 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Sep 2011 09:37:24 +0200
Message-Id: <cover.1316158579.git.Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.7.6.1
Subject: [PATCH 0/3] Small fixes for fetch2
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
X-List-Received-Date: Fri, 16 Sep 2011 07:45:43 -0000

The following changes since commit 2d5c71ae78b13e935548fe6ff5174b1c09b3077d:

  fetch2: export LD_LIBRARY_PATH (2011-09-16 09:27:12 +0200)

are available in the git repository at:
  git://gitorious.org/shr/bitbake jansa/pull

Martin Jansa (3):
  fetch2/git: fix typo logggin/logger
  fetch2/git: be more carefull in _contains_ref when checking git log
    output
  fetch2: export LD_LIBRARY_PATH

 lib/bb/fetch2/__init__.py |    2 +-
 lib/bb/fetch2/git.py      |    7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
1.7.6.1



