Return-Path: <Qi.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 1A6AE7F07B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Aug 2019 07:39:09 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x7M7dBDS023735
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Aug 2019 00:39:11 -0700 (PDT)
Received: from pek-qchen1-d1.corp.ad.wrs.com (128.224.162.148) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.468.0; Thu, 22 Aug 2019 00:39:10 -0700
From: Chen Qi <Qi.Chen@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 22 Aug 2019 15:52:50 +0800
Message-ID: <cover.1566460314.git.Qi.Chen@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: [PATCH V2 0/1] cooker.py: remove generation of recipe-depends.dot
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
X-List-Received-Date: Thu, 22 Aug 2019 07:39:10 -0000
Content-Type: text/plain

Changes in V2:
* Remove the file to avoid misleading information

The following changes since commit 58ab85d3e005476ab5bcc288ad421c0c5d1e0582:

  systemd: add PACKAGECONFIG for gnu-efi (2019-08-21 21:52:59 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib ChenQi/recipe-depends
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=ChenQi/recipe-depends

Chen Qi (1):
  cooker.py: remove generation of recipe-depends.dot

 bitbake/lib/bb/cooker.py | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

-- 
1.9.1


