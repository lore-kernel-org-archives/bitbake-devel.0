Return-Path: <mark.hatle@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 2916B7C3A1
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 27 Jan 2019 16:57:18 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x0RGvDAO021236
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Sun, 27 Jan 2019 08:57:14 -0800 (PST)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.40) with Microsoft SMTP Server id 14.3.435.0;
	Sun, 27 Jan 2019 08:57:13 -0800
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 27 Jan 2019 11:57:11 -0500
Message-ID: <20190127165712.118078-1-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
MIME-Version: 1.0
Cc: liu.ming50@gmail.com
Subject: [PATCH]gitsm fetcher: Fix recurse submodule error
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
X-List-Received-Date: Sun, 27 Jan 2019 16:57:19 -0000
Content-Type: text/plain

Due to an error in some optimization work, recursive submodules may not
always unpack.  Resolve this issue and add a specific test case to catch
any new regressions.

(already in master-next, but I wanted to make sure others saw the patch
as well..)

Mark Hatle (1):
  gitsm: The fetcher did not process some recursive submodules properly.

 lib/bb/fetch2/gitsm.py |  4 +++-
 lib/bb/tests/fetch.py  | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

-- 
1.8.3.1


