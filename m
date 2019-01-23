Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 9297B6BE46
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Jan 2019 15:28:20 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x0NFSK70019951
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 23 Jan 2019 07:28:20 -0800 (PST)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.408.0;
	Wed, 23 Jan 2019 07:28:19 -0800
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 23 Jan 2019 10:28:16 -0500
Message-ID: <20190123152818.63800-1-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
MIME-Version: 1.0
Subject: [PATCH 0/2] gitsm fetcher, fix submodule unpack issues
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
X-List-Received-Date: Wed, 23 Jan 2019 15:28:20 -0000
Content-Type: text/plain

Khem Raj discovered that a number of recipes using gitsm were failing.  This
was tied back to two items.  A mistake in the way the relative URLs was
being handled after the prior patch set, and the way the modules directory
of the various submodule components was being constructed.

This set fixes both issues, and additional tests for the specific cases
that Khem mentioned were also added to the test suite.


Mark Hatle (2):
  gitsm.py: Fix relative URLs
  gitsmy.py: Fix unpack of submodules of submodules

 lib/bb/fetch2/gitsm.py | 20 ++++++++++++--------
 lib/bb/tests/fetch.py  | 30 ++++++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 10 deletions(-)

-- 
1.8.3.1


