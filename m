Received: from so254-9.mailgun.net (so254-9.mailgun.net [198.61.254.9])
 by mx.groups.io with SMTP id smtpd.web11.10388.1621352141517833550
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 May 2021 08:35:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mg.codeaurora.org header.s=smtp header.b=TQN7MgOu;
 spf=pass (domain: mg.codeaurora.org, ip: 198.61.254.9, mailfrom: bounce+f78134.be9e4a-bitbake-devel=lists.openembedded.org@mg.codeaurora.org)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621352142; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=kkcyxjzcNcvTYHJJhWI/34nDdVz0e1H2O2hrT52sZ1o=; b=TQN7MgOuywPhObX9x4DBFpToUD3jJXgikJyIoCyYafsFJ3Iu1Yyh+SRhOfa8xLCHc3y7BWL5
 W/SHpnbkr8IljzpahByGL/YBXiG2vW8Xxhlb8a2NMEqTVnmxSZc68a5meCYO2pJBM+R/R+vW
 Nz5XwTvE4DG1cfFTH5pEVvDZYvo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyIyMjIzMCIsICJiaXRiYWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60a3decb2bff04e53b51ecbf (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 May 2021 15:35:39
 GMT
Sender: sbanerje=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
	id B6826C433D3; Tue, 18 May 2021 15:35:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
	autolearn=no autolearn_force=no version=3.4.0
Received: from lnxeng01-le.qualcomm.com (unknown [202.46.22.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sbanerje)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 4248BC4338A;
	Tue, 18 May 2021 15:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4248BC4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sbanerje@codeaurora.org
From: "Sourabh Banerjee" <sbanerje@codeaurora.org>
To: bitbake-devel@lists.openembedded.org
Cc: Sourabh Banerjee <sbanerje@codeaurora.org>
Subject: [PATCH 1/3] bitbake: fetch2/repo: add support for projects to be fetched simultaneously
Date: Tue, 18 May 2021 21:05:22 +0530
Message-Id: <1621352124-27088-1-git-send-email-sbanerje@codeaurora.org>
X-Mailer: git-send-email 2.7.4

repo tool can fetch projects simultaneously.
As per repo sync documentation:
  Usage: repo sync [<project>...]
  Options:
    -j JOBS, --jobs=JOBS  projects to fetch simultaneously (default 1)

By supplying jobs=<some_number> recipe can choose to use the
simultaneous fetch feature of repo tool.
Example:
  SRC_URI = "repo://REPOROOT;protocol=git;branch=main;manifest=default.xml;jobs=8"

Signed-off-by: Sourabh Banerjee <sbanerje@codeaurora.org>
---
 bitbake/lib/bb/fetch2/repo.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/repo.py b/bitbake/lib/bb/fetch2/repo.py
index fa4cb81..8547b9e 100644
--- a/bitbake/lib/bb/fetch2/repo.py
+++ b/bitbake/lib/bb/fetch2/repo.py
@@ -62,11 +62,21 @@ class Repo(FetchMethod):
         repodir = os.path.join(codir, "repo")
         bb.utils.mkdirhier(repodir)
         if not os.path.exists(os.path.join(repodir, ".repo")):
+
             bb.fetch2.check_network_access(d, "%s init -m %s -b %s -u %s://%s%s%s" % (ud.basecmd, ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), ud.url)
             runfetchcmd("%s init -m %s -b %s -u %s://%s%s%s" % (ud.basecmd, ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), d, workdir=repodir)
 
+        # Projects to fetch simultaneously at time of 'repo sync'.
+        # If SRC_URI provides parallel jobs parameter as follows:
+        #   SRC_URI = "repo://REPOROOT;branch=some_branch;jobs=8"
+        # Sync is run as 'repo sync -j8'
+        # When jobs parameter is not passed with SRC_URI then
+        # repo tool's default behavior is to fetch 1 project at a time.
+        jobs = ud.parm.get('jobs', '')
+        if jobs:
+            jobs = '-j' + jobs
         bb.fetch2.check_network_access(d, "%s sync %s" % (ud.basecmd, ud.url), ud.url)
-        runfetchcmd("%s sync" % ud.basecmd, d, workdir=repodir)
+        runfetchcmd("%s sync %s" % (ud.basecmd, jobs), d, workdir=repodir)
 
         scmdata = ud.parm.get("scmdata", "")
         if scmdata == "keep":
-- 
2.7.4

