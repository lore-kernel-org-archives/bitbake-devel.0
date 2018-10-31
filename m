Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 076AE79D50
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Oct 2018 19:21:44 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w9VJLk7v000282
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 Oct 2018 12:21:46 -0700 (PDT)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.408.0;
	Wed, 31 Oct 2018 12:21:45 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 31 Oct 2018 15:21:42 -0400
Message-ID: <20181031192144.35366-1-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
MIME-Version: 1.0
Subject: [PATCH 0/2] Fix gitsm issues
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
X-List-Received-Date: Wed, 31 Oct 2018 19:21:45 -0000
Content-Type: text/plain

Two issues here:

1) Fix an issue where the submodule commit may not be on a branch of the
same name as the SRC_URI entry.

2) Recursive submodules may not properly unpacked 


Mark Hatle (2):
  fetch2/gitsm.py: Disable branch checking on submodules
  fetch2/gitsm.py: Fix the references when the module and path are
    different

 lib/bb/fetch2/gitsm.py | 71 +++++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 36 deletions(-)

-- 
1.8.3.1


