Return-Path: <Leif.Middelschulte@klsmartin.com>
X-Greylist: delayed 427 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 04 Jun 2019 16:09:21 UTC
Received: from ironport.klsmartin.com (ironport.klsmartin.com [212.211.191.11])
	by mail.openembedded.org (Postfix) with ESMTP id 1070E7DE7D
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  4 Jun 2019 16:09:21 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.60,550,1549926000"; 
   d="scan'208";a="1788397"
Received: from unknown (HELO hera.klsmartin.com) ([172.30.5.66])
	by ironport.klsmartin.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
	04 Jun 2019 18:02:16 +0200
Received: from SUMMAIL01.UMK.KLS.zentral ([172.25.1.63])
	by hera.klsmartin.com (8.14.3/8.13.1/SuSE Linux 0.7) with ESMTP id
	x54G25IX016090 for <bitbake-devel@lists.openembedded.org>;
	Tue, 4 Jun 2019 18:02:08 +0200
Received: from UML026.UMK.KLS.zentral (172.25.2.60) by
	SUMMAIL01.UMK.KLS.zentral (172.25.1.63) with Microsoft SMTP Server
	(TLS) id 14.3.408.0; Tue, 4 Jun 2019 18:02:11 +0200
From: Leif Middelschulte <leif.middelschulte@klsmartin.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 4 Jun 2019 18:01:36 +0200
Message-ID: <20190604160137.5636-1-leif.middelschulte@klsmartin.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Originating-IP: [172.25.2.60]
X-KSE-ServerInfo: SUMMAIL01.UMK.KLS.zentral, 9
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 04.06.2019 11:03:00
Cc: Leif Middelschulte <leif.middelschulte@klsmartin.com>
Subject: [PATCH 0/1] bitbake: fetch2/git: fix initial http authed clone
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
X-List-Received-Date: Tue, 04 Jun 2019 16:09:22 -0000
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch fixes initial clones of git repositories authenticated
via basic http authentication. This became apparent when code was
reused to clone submodules too.

The method is the recommended way of cloning source code by CI
runners. This patch fixes the currently broken behvior.

Beware, that already cloned repositories are not affected.

Based on master (d94ccd506d04aff182ab48f501f6f366d5dd14f5).

Leif Middelschulte (1):
  bitbake: fetch2/git: set password in https clones too

 lib/bb/fetch2/git.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.21.0


