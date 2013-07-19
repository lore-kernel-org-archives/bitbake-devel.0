Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 6DE0D6B262
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Jul 2013 08:11:10 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r6J8BA3N028482
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Jul 2013 01:11:10 -0700 (PDT)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.2.342.3; Fri, 19 Jul 2013 01:11:10 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 19 Jul 2013 04:11:06 -0400
Message-ID: <cover.1374204011.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Subject: [PATCH 0/1] providers.py: print a debug message for dynamic pacakge
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
X-List-Received-Date: Fri, 19 Jul 2013 08:11:10 -0000
Content-Type: text/plain

The following changes since commit 31e6eee860b5f9f4ac9ef0889bcff5648de6e3f9:

  poky-tiny.conf: blacklist core-image-weston option (2013-07-18 21:26:58 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib robert/dynamic
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/dynamic

Robert Yang (1):
  providers.py: print a debug message for dynamic pacakge

 bitbake/lib/bb/providers.py |    1 +
 1 file changed, 1 insertion(+)

-- 
1.7.10.4


