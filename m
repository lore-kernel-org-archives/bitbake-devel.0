Received: from so254-9.mailgun.net (so254-9.mailgun.net [])
 by mx.groups.io with SMTP id smtpd.web11.10388.1621352141517833550
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 May 2021 08:36:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mg.codeaurora.org header.s=smtp header.b=reh9YyQb;
 spf=softfail (domain: mg.codeaurora.org, ip: <nil>, mailfrom: bounce+f78134.be9e4a-bitbake-devel=lists.openembedded.org@mg.codeaurora.org)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621352170; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=4/mnkDVr8p7hQ9NT1hB08jHHH72tS2nlmgHOchaCPhw=; b=reh9YyQbmeiVsHvWZZmKO7zmYkZhTkDzN/hrBnDiDlAWD8stbRD8HJeik1MK9OXIDOrppPE3
 bsdAb8QXpbWTarqHShIOsmwBmRehjjZsV1MUBci/R+dVSL3JLcKknmXQhKmAYB5W5lDdZZN1
 Dac86vvIx+xCO+NeaSH1dGvZKEQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyIyMjIzMCIsICJiaXRiYWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60a3dee32bff04e53b527345 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 May 2021 15:36:03
 GMT
Sender: sbanerje=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
	id C631AC4338A; Tue, 18 May 2021 15:36:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
	autolearn=no autolearn_force=no version=3.4.0
Received: from lnxeng01-le.qualcomm.com (unknown [202.46.22.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sbanerje)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 5CBAAC433F1;
	Tue, 18 May 2021 15:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5CBAAC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sbanerje@codeaurora.org
From: "Sourabh Banerjee" <sbanerje@codeaurora.org>
To: bitbake-devel@lists.openembedded.org
Cc: Sourabh Banerjee <sbanerje@codeaurora.org>
Subject: [PATCH 3/3] bitbake: fetch2/repo: add support for --repo-url and --repo-branch
Date: Tue, 18 May 2021 21:05:24 +0530
Message-Id: <1621352124-27088-3-git-send-email-sbanerje@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621352124-27088-1-git-send-email-sbanerje@codeaurora.org>
References: <1621352124-27088-1-git-send-email-sbanerje@codeaurora.org>

repo tool provides following options to use a stable or preferred
version of the tool
  repo Version options:
    --repo-url=URL      repo repository location
    --repo-branch=REVISION
                        repo branch or revision

By supplying repo_url=<uri> and repo_branch=<branch> recipe may choose
to sync a specific version of repo tool.

Signed-off-by: Sourabh Banerjee <sbanerje@codeaurora.org>
---
 bitbake/lib/bb/fetch2/repo.py | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/repo.py b/bitbake/lib/bb/fetch2/repo.py
index e7c5255..902337f 100644
--- a/bitbake/lib/bb/fetch2/repo.py
+++ b/bitbake/lib/bb/fetch2/repo.py
@@ -66,9 +66,15 @@ class Repo(FetchMethod):
         repodir = os.path.join(codir, "repo")
         bb.utils.mkdirhier(repodir)
         if not os.path.exists(os.path.join(repodir, ".repo")):
+            repo_url = ud.parm.get('repo_url', '')
+            if repo_url:
+                repo_url = '--repo-url=' + repo_url
+            repo_branch = ud.parm.get('repo_branch', '')
+            if repo_branch:
+                repo_branch = '--repo-branch=' + repo_branch
 
             bb.fetch2.check_network_access(d, "%s init -m %s -b %s -u %s://%s%s%s" % (ud.basecmd, ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), ud.url)
-            runfetchcmd("%s init -m %s -b %s -u %s://%s%s%s" % (ud.basecmd, ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), d, workdir=repodir)
+            runfetchcmd("%s init -m %s -b %s -u %s://%s%s%s %s %s" % (ud.basecmd, ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path, repo_url, repo_branch), d, workdir=repodir)
 
         # Projects to fetch simultaneously at time of 'repo sync'.
         # If SRC_URI provides parallel jobs parameter as follows:
-- 
2.7.4

