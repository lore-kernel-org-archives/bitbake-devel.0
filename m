Return-Path: <petter@technux.se>
Received: from vsp-authed-02-02.binero.net (vsp-authed02.binero.net
	[195.74.38.226])
	by mail.openembedded.org (Postfix) with SMTP id 95DA960958
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jul 2013 09:19:33 +0000 (UTC)
Received: from smtp01.binero.se (unknown [195.74.38.28])
	by vsp-authed-02-02.binero.net (Halon Mail Gateway) with ESMTP;
	Mon, 29 Jul 2013 11:19:26 +0200 (CEST)
Received: from eldbvzzwp1-7x.lan (90-224-44-236-no67.tbcn.telia.com
	[90.224.44.236]) (Authenticated sender: petter@technux.se)
	by smtp-06-01.atm.binero.net (Postfix) with ESMTPSA id 6B6633A10F;
	Mon, 29 Jul 2013 11:19:26 +0200 (CEST)
From: =?UTF-8?q?Petter=20Mab=C3=A4cker?= <petter@technux.se>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Jul 2013 11:18:49 +0200
Message-Id: <cover.1375088734.git.petter@technux.se>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Subject: [PATCH 0/1] bitbake: runqueue: add warning in invalidate task
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
X-List-Received-Date: Mon, 29 Jul 2013 09:19:34 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 67864ca79da08df752487a3a4e1a975546da123d:

  systemd: Remove systemd_unitdir if systemd is not in distro features (2013-07-24 11:35:39 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib petmab/bug/4877
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=petmab/bug/4877

Petter Mabäcker (1):
  bitbake: runqueue: add warning in invalidate task

 bitbake/lib/bb/runqueue.py |    3 +++
 1 file changed, 3 insertions(+)

-- 
1.7.9.5


