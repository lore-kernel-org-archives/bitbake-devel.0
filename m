Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 74AD762133
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Mar 2016 09:32:55 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id u2U9Wtgm003310
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Mar 2016 02:32:56 -0700 (PDT)
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Wed, 30 Mar 2016 02:32:55 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 30 Mar 2016 02:32:54 -0700
Message-ID: <cover.1459330331.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/1] cookerdata.py: remove slash in the end
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
X-List-Received-Date: Wed, 30 Mar 2016 09:32:56 -0000
Content-Type: text/plain

The following changes since commit ddbeb56f4fb69831453f4b91f5410ba4fde9fa56:

  bitbake: cookerdata: Improve handling of ParseError (2016-03-29 23:21:52 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib 96108bac83f88289ad4851f781742f515e882f5d
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=96108bac83f88289ad4851f781742f515e882f5d

Robert Yang (1):
  cookerdata.py: remove slash in the end

 bitbake/lib/bb/cookerdata.py | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.7.4


