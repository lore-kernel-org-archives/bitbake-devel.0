Return-Path: <Chong.Lu@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 0F8F772C99
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Jan 2015 02:58:37 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id t0M2wbI3020883
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
	Wed, 21 Jan 2015 18:58:37 -0800 (PST)
Received: from pek-hostel-deb02.wrs.com (128.224.153.152) by
	ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
	14.3.174.1; Wed, 21 Jan 2015 18:58:37 -0800
From: Chong Lu <Chong.Lu@windriver.com>
To: <bitbake-devel@lists.openembedded.org>, <paul.eggleton@linux.intel.com>
Date: Thu, 22 Jan 2015 10:53:53 +0800
Message-ID: <cover.1421895046.git.Chong.Lu@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: [PATCH V2 0/2] bitbake-layers: add a ability to query layer dependencies from layer index
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
X-List-Received-Date: Thu, 22 Jan 2015 02:58:43 -0000
Content-Type: text/plain

Change since V2:
Add option '-a' to controll fetch and add to conf/bblayers.conf.

The following changes since commit 35c9fa0588ed8e88b541a6c80cc1517324616cea:

  maintainers: Update for non-maintained recipes (2015-01-20 21:39:41 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib chonglu/layerindex
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=chonglu/layerindex

Chong Lu (2):
  bitbake.conf: Add two variables for layer index
  bitbake-layers: add a ability to query layer dependencies from layer index

 bitbake/bin/bitbake-layers | 188 +++++++++++++++++++++++++++++++++++++++++++++
 meta/conf/bitbake.conf     |   6 ++
 2 files changed, 194 insertions(+)

-- 
1.9.1


