Return-Path: <Qi.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 2A59A73A65
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 11 Mar 2015 03:20:52 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id t2B3KrBp020419
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Mar 2015 20:20:53 -0700 (PDT)
Received: from pek-qchen1-d1.corp.ad.wrs.com (128.224.162.236) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.224.2; Tue, 10 Mar 2015 20:20:53 -0700
From: Chen Qi <Qi.Chen@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 11 Mar 2015 11:21:05 +0800
Message-ID: <cover.1425969366.git.Qi.Chen@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: [PATCH 0/1] bitbake-diffsigs: consider the situation where sigdata and siginfo files having the same hash values
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
X-List-Received-Date: Wed, 11 Mar 2015 03:20:54 -0000
Content-Type: text/plain

The following changes since commit 8ce2f2c3549248b2aa1259ceb28ed03be166ac6f:

  maintainers.inc: Became maintainer of python2 and python3 (2015-03-09 16:01:08 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib ChenQi/bitbake-diffsigs-duplicates
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=ChenQi/bitbake-diffsigs-duplicates

Chen Qi (1):
  bitbake-diffsigs: consider the situation where sigdata and siginfo
    files having the same hash values

 bitbake/bin/bitbake-diffsigs | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

-- 
1.9.1


