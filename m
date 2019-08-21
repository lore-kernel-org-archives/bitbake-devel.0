Return-Path: <Qi.Chen@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 490D56D147
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Aug 2019 08:48:01 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x7L8laOM030931
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Aug 2019 01:47:52 -0700
Received: from pek-qchen1-d1.corp.ad.wrs.com (128.224.162.148) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.468.0; Wed, 21 Aug 2019 01:47:26 -0700
From: Chen Qi <Qi.Chen@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 21 Aug 2019 17:01:05 +0800
Message-ID: <cover.1566378022.git.Qi.Chen@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: [PATCH 0/1] cooker.py: use depends instead of tdepends to generate recipe-depends.dot
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
X-List-Received-Date: Wed, 21 Aug 2019 08:48:01 -0000
Content-Type: text/plain

*** BLURB HERE ***
The following changes since commit 20946c63c272b2128e6dc76490313b174ee97d8e:

  bitbake: runqueue: Ensure target_tids is filtered (2019-08-16 10:05:33 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib ChenQi/recipe-depends
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=ChenQi/recipe-depends

Chen Qi (1):
  cooker.py: use depends instead of tdepends to generate
    recipe-depends.dot

 bitbake/lib/bb/cooker.py | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

-- 
1.9.1


