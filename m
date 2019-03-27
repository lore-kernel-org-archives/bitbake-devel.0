Return-Path: <mark.hatle@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 08B037D180
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Mar 2019 17:41:31 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x2RHernH022996
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 27 Mar 2019 10:41:03 -0700
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.439.0;
	Wed, 27 Mar 2019 10:40:43 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>, <wak@google.com>
Date: Wed, 27 Mar 2019 13:40:41 -0400
Message-ID: <20190327174042.97926-1-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
MIME-Version: 1.0
Subject: [PATCH 0/1] gitsm: When switching SRCREVs verify submodules
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
X-List-Received-Date: Wed, 27 Mar 2019 17:41:32 -0000
Content-Type: text/plain

I'm not going to claim that this is a 'v2' version.  But the work is in
response to the patch submittted by William A. Kennington III to the list.

I've used his test case to determine what the issue is, and developed a
different solution to the problem.

The primary difference in overall behavior is that I wanted to avoid any
sort of iteration into the submodules during processing.  Otherwise we
run the risk of race conditions and locking issues.  (The original
work from William did address locking concerns, but prior versions of
the gitsm fetcher proved this was still problematic.)

The test case from William's patch is included in this, unmodified.

Mark Hatle (1):
  gitsm: Add need_update method to determine when we are going to a new
    SRCREV

 lib/bb/fetch2/gitsm.py | 20 ++++++++++++++++++++
 lib/bb/tests/fetch.py  | 19 +++++++++++++++++++
 2 files changed, 39 insertions(+)

-- 
2.16.0.rc2


