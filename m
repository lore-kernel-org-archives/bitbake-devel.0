Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1SzgIH-00048U-1l
	for bitbake-devel@lists.openembedded.org;
	Fri, 10 Aug 2012 05:54:03 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q7A3fx3k013004
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 9 Aug 2012 20:41:59 -0700 (PDT)
Received: from localhost.localdomain (128.224.163.124) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.2.309.2; Thu, 9 Aug 2012 20:41:58 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 10 Aug 2012 11:47:38 +0800
Message-ID: <cover.1344569166.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.11.2
MIME-Version: 1.0
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 0/1 V2] bitbake-whatchanged: print what is about to happen
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
X-List-Received-Date: Fri, 10 Aug 2012 03:54:03 -0000
Content-Type: text/plain

Changes of V2:

* Fix a typo fn -> 'fn'

* Use "bitbake -e" rather than "bitbake -e recipe" to get the BB_STAMPS_DIR

* Use "BB_STAMPS_DIR=<path> bitbake -S recipe" to regenerate the stamps

* Change the summary format a little, now it looks like:
  - (without -v):
    === Summary: (3653 changed, 1927 unchanged)
    Newly added: 807
    PV changed: 48
    PR changed: 276
    Depends changed: 2522

  - (with -v):
    === Summary: (3653 changed, 1927 unchanged)
    Newly added: 807
    Depends changed: 2846

// Robert

The following changes since commit 2dec760b79bb7e2e79c33c5127fa64685bd86a18:

  foomatic: fix perl path for target (2012-08-08 10:06:00 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib robert/whatchanged
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/whatchanged

Robert Yang (1):
  bitbake-whatchanged: print what is about to happen

 bitbake/bin/bitbake-whatchanged | 328 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 328 insertions(+)
 create mode 100755 bitbake/bin/bitbake-whatchanged

-- 
1.7.11.2



