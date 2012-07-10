Received: from mail-we0-f175.google.com ([74.125.82.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei@gherzan.ro>) id 1SoiFI-0002nD-AH
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jul 2012 23:45:24 +0200
Received: by weyr6 with SMTP id r6so311310wey.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jul 2012 14:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
	bh=u8OXxMoekVZ40/OjeEVES9VjSMvVA5oIpDv7VekAX9Q=;
	b=RTsNiy2Vpt/LmTtgVrPFmYjVCnoAKayON+8btNXwjei8PU0HhQXrHD6vp7+CCnRXk6
	31yzFzh7uGvkCIVJqD8noaKGlw8B2rm8ufNvDWRwFZmsR+Qg0o8w3UQ3wJYboQ2j7aO8
	0gm/M+HiBNLg2bbrjE/bIjFpXFtp6zBd5HM4ZitnGPCy5TJpYPP0ddNXa1nX6oUulpKL
	+usnTH9Ywb4t3IsYxBAPOqcKQz5NYB5IGbvy/vWDisqnLXNb6jg1zbs4HaJloV+AGzjL
	ODWcSZPJT3jJdRdbqY48Z8tjYwioJOxKh1PQCn+pOn9R/b6lZ5dpH3OeKDJdkdLDgVOD
	YJDw==
Received: by 10.180.83.106 with SMTP id p10mr5480362wiy.21.1341956053305;
	Tue, 10 Jul 2012 14:34:13 -0700 (PDT)
Received: from localhost.localdomain ([79.117.115.156])
	by mx.google.com with ESMTPS id ef5sm1571189wib.3.2012.07.10.14.34.10
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 10 Jul 2012 14:34:11 -0700 (PDT)
From: Andrei Gherzan <andrei@gherzan.ro>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 11 Jul 2012 00:34:00 +0300
Message-Id: <cover.1341955881.git.andrei@gherzan.ro>
X-Mailer: git-send-email 1.7.9.5
X-Gm-Message-State: ALoCoQmaNGLJSYn/r+GkPudupj8s0vTEMIO9A4D7wA1UA0rnDc/BY1q+8xOI/tnG1+1TQXj/xf7F
Subject: [PATCH-V2 0/5] Warn user if "param" is used in SRC_URI
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
X-List-Received-Date: Tue, 10 Jul 2012 21:45:24 -0000

The following changes since commit 90ad663909c0c8a405b22a510c9f957007d02669:

  upstream_tracking: update boost (2012-07-09 17:21:38 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib ag/protocol
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=ag/protocol

Andrei Gherzan (5):
  fetch2/svn.py: Use "protocol" parameter to get the protocol
  fetch2/osc.py: Use "protocol" parameter to get the protocol
  fetch2/hg.py: Use "protocol" parameter to get the protocol
  fetch2/bzr.py: Use "protocol" parameter to get the protocol
  fetch2/__init__.py: Warn user if SRC_URI is using "proto" and not
    "protocol"

 bitbake/lib/bb/fetch2/__init__.py |    4 ++++
 bitbake/lib/bb/fetch2/bzr.py      |    2 +-
 bitbake/lib/bb/fetch2/hg.py       |    2 +-
 bitbake/lib/bb/fetch2/osc.py      |    2 +-
 bitbake/lib/bb/fetch2/svn.py      |    2 +-
 5 files changed, 8 insertions(+), 4 deletions(-)

-- 
1.7.9.5



