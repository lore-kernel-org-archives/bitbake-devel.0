Return-Path: <ross.burton@intel.com>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
	[209.85.212.179])
	by mail.openembedded.org (Postfix) with ESMTP id BC6B173B10
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 Jul 2015 14:49:58 +0000 (UTC)
Received: by wiclp1 with SMTP id lp1so53351785wic.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 07 Jul 2015 07:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=3Owx3u88Qf1znzoYVKBp6ImF3BPWiLSTBnaNs+sxHxM=;
	b=mJey+r78u7nJtK0vTZOevjD+BbPzmvNdeAAqoXCOT7hijLtoBcQ1JkcoC97T1mDwKU
	cfN5H4D/H1LRFuhEy8kif79U8bU8YMDlnwUlnVXku2G4uD65yVZ2mE1KKKoZsjvsJTld
	VYpYozmBTaq+8bnYXEq1YzW6rPAiUZDd3iiS/ue+tKr0TllZNA/HjYPYhGhpXBp4BlzR
	Ed4HMFCe6zHWmhNSE0eqiyEH2EUTKkpCxhasWWCNek5r4W5EEB8ycc1qObRrw6JCY87P
	fTQBxi13Kg145H7GiuHMtnvFbuOv/HcxUHzkrUzLRCCPceolb2WzoX40FgnOYQnfuH7/
	zOng==
X-Gm-Message-State: ALoCoQlMzVFeqRPPJGemDvVWyKaLhBNPl+pfVA/CGbplhsnwJQBsCksq5JxLn/+BABDGjK+nA486
X-Received: by 10.180.187.41 with SMTP id fp9mr66907598wic.67.1436280597908;
	Tue, 07 Jul 2015 07:49:57 -0700 (PDT)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35]) by mx.google.com with ESMTPSA id
	fb3sm52866992wib.21.2015.07.07.07.49.56
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 07 Jul 2015 07:49:57 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 Jul 2015 15:44:33 +0100
Message-Id: <1436280273-5756-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] main: add skeleton documentation for the recipe:do_task syntax
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
X-List-Received-Date: Tue, 07 Jul 2015 14:49:59 -0000

The incredibly useful recipe:do_task syntax on the command line isn't documented
at all.  This isn't much but it's better than nothing.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/main.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/main.py b/bitbake/lib/bb/main.py
index 49dc8d5..ee72328 100755
--- a/bitbake/lib/bb/main.py
+++ b/bitbake/lib/bb/main.py
@@ -83,7 +83,7 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
     def parseCommandLine(self, argv=sys.argv):
         parser = optparse.OptionParser(
             version = "BitBake Build Tool Core version %s" % bb.__version__,
-            usage = """%prog [options] [recipename/target ...]
+            usage = """%prog [options] [recipename/target recipe:do_task ...]
 
     Executes the specified task (default is 'build') for a given set of target recipes (.bb files).
     It is assumed there is a conf/bblayers.conf available in cwd or in BBPATH which
-- 
2.1.4


