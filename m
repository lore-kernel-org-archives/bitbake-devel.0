Return-Path: <Yi.Zhao@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 166997FC13
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  8 Nov 2019 03:46:01 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id xA83k2FF028935
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 7 Nov 2019 19:46:03 -0800
Received: from localhost (128.224.158.241) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.468.0;
	Thu, 7 Nov 2019 19:46:02 -0800
From: Yi Zhao <yi.zhao@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 8 Nov 2019 11:46:00 +0800
Message-ID: <20191108034600.13103-1-yi.zhao@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-Originating-IP: [128.224.158.241]
Subject: [PATCH] contrib/vim/indent/bitbake.vim: move it to correct directory
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
X-List-Received-Date: Fri, 08 Nov 2019 03:46:02 -0000
Content-Type: text/plain

Move bitbake.vim from bitbake/contrib/vim/indent to contrib/vim/indent.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 {bitbake/contrib => contrib}/vim/indent/bitbake.vim | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename {bitbake/contrib => contrib}/vim/indent/bitbake.vim (100%)

diff --git a/bitbake/contrib/vim/indent/bitbake.vim b/contrib/vim/indent/bitbake.vim
similarity index 100%
rename from bitbake/contrib/vim/indent/bitbake.vim
rename to contrib/vim/indent/bitbake.vim
-- 
2.17.1


