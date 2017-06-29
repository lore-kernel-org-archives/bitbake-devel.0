Return-Path: <Rob.Woolley@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id D154777FEC
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 29 Jun 2017 02:24:20 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v5T2OC3f025983
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 28 Jun 2017 19:24:12 -0700 (PDT)
Received: from ala-lpggp2.wrs.com (147.11.105.123) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Wed, 28 Jun 2017 19:24:11 -0700
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 28 Jun 2017 19:24:10 -0700
Message-ID: <20170629022411.57685-1-rob.woolley@windriver.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Cc: paul.eggleton@linux.intel.com
Subject: [PATCH v2 0/1] Automatically paginate bitbake -e output
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
X-List-Received-Date: Thu, 29 Jun 2017 02:24:21 -0000
Content-Type: text/plain

The bitbake show_versions (-s) and show_environment (-e) commands provide
a lot of non-interactive output.  Even experienced users will sometimes
forget to page the output.

This enhancement adds a feature to automatically page these commands when
using the knotty user interface.  It doesn't affect any other commands
and is designed to work in a similar fashion to the auto-paging in git.

This was tested with bitbake -s and bitbake -s | less (and -e) to ensure that
there were no regressions.  This includes testing broken pipe conditions
caused by quitting the pager before the full output has been sent through
the pipe.

This is an update of my previous patch from February 2015 and adds support
for Python 3 and utf-8.

PATCH v1: https://patchwork.openembedded.org/patch/89543/
YOCTO #9203: https://bugzilla.yoctoproject.org/show_bug.cgi?id=9203

