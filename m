Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 808E66AC9A
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Jul 2014 06:41:33 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s646fVEM009435
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 3 Jul 2014 23:41:31 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.169.1;
	Thu, 3 Jul 2014 23:41:30 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 3 Jul 2014 23:41:29 -0700
Message-ID: <cover.1404455961.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Subject: [PATCH 0/1] bitbake-user-manual-metadata.xml: remove populate_staging
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
X-List-Received-Date: Fri, 04 Jul 2014 06:41:38 -0000
Content-Type: text/plain

There is still a populate_staging in bitbake/lib/bb/shell.py, not sure whether
the shell.py works or not, so doesn't remove it.

// Robert

The following changes since commit b21f799dfe4297a910a661859a28affadf310a69:

  build-appliance-image: Update to master head revision (2014-07-03 17:49:18 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/staging
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/staging

Robert Yang (1):
  bitbake-user-manual-metadata.xml: remove populate_staging

 .../bitbake-user-manual-metadata.xml               |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
1.7.9.5


