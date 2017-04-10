Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 4696A77C28
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Apr 2017 22:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1491863747; x=1523399747;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=Qx2ET9f0VQs0RhpZhJgDYqZQcQmCHW/RPX4F0I4cNUM=;
	b=PbZuBMInzXkBJ+CWMF575X0uog/QpoFZab3BljNp1KkDQEd8gZQS4N35
	hacUzko+rf9X2HoOVpeA0jhROmlqSA==;
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	10 Apr 2017 15:35:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,183,1488873600"; d="scan'208";a="87467167"
Received: from lheah-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.133.64])
	by fmsmga006.fm.intel.com with ESMTP; 10 Apr 2017 15:35:45 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Apr 2017 10:35:39 +1200
Message-Id: <ca32559f007df35d7c5bbc818c709a305acce406.1491863723.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <cover.1491863723.git.paul.eggleton@linux.intel.com>
References: <cover.1491863723.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] bitbake-diffsigs: fix traceback with no arguments
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
X-List-Received-Date: Mon, 10 Apr 2017 22:35:45 -0000

In the move over to argparse we've made the two signature file arguments
optional and thus if -t is not in use we need to explicitly check if at
least one signature file has been specified - and if not, show an error
and the command-line help.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-diffsigs | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/bin/bitbake-diffsigs b/bin/bitbake-diffsigs
index 884be1e..eb2f859 100755
--- a/bin/bitbake-diffsigs
+++ b/bin/bitbake-diffsigs
@@ -147,6 +147,10 @@ else:
             output = bb.siggen.compare_sigfiles(options.sigdatafile1, options.sigdatafile2, color=color)
         elif options.sigdatafile1:
             output = bb.siggen.dump_sigfile(options.sigdatafile1)
+        else:
+            logger.error('Must specify signature file(s) or -t/--task')
+            parser.print_help()
+            sys.exit(1)
     except IOError as e:
         logger.error(str(e))
         sys.exit(1)
-- 
2.9.3


