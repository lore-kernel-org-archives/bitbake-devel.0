Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1U31Ul-000823-MY
	for bitbake-devel@lists.openembedded.org;
	Wed, 06 Feb 2013 10:40:49 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r169OulJ026310
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 6 Feb 2013 01:24:56 -0800 (PST)
Received: from pek-usp-3.wrs.com (128.224.163.124) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.318.4;
	Wed, 6 Feb 2013 01:24:54 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 6 Feb 2013 17:28:15 +0800
Message-ID: <cover.1360138241.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.11.2
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 0/1] bitbake-layers: make show-cross-depends avoid long path
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
X-List-Received-Date: Wed, 06 Feb 2013 09:40:49 -0000
Content-Type: text/plain

Hi Paul,

I added a "-f" option for the show-cross-depends, please feel free to give
your comments. BTW., I will be on vacation from Feb. 7th to 17th because of
the Chinese Spring Festival, and I will go back to my hometown where has no
network, so I can't reply the email until Feb. 18th.

// Robert

The following changes since commit ee1f126ad5cb2c6af66815e55720257a1efc5a49:

  bitbake: bitbake: fetch2: Print the complete SRCREV variable name when INVALID (2013-02-05 15:22:45 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib robert/bbl_long_path
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/bbl_long_path

Robert Yang (1):
  bitbake-layers: make show-cross-depends avoid long path

 bitbake/bin/bitbake-layers | 56 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 8 deletions(-)

-- 
1.7.11.2



