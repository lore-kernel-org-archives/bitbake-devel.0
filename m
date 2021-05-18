Received: from so254-9.mailgun.net (so254-9.mailgun.net [])
 by mx.groups.io with SMTP id smtpd.web11.10388.1621352141517833550
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 18 May 2021 08:36:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@mg.codeaurora.org header.s=smtp header.b=KIjXL4nA;
 spf=softfail (domain: mg.codeaurora.org, ip: <nil>, mailfrom: bounce+f78134.be9e4a-bitbake-devel=lists.openembedded.org@mg.codeaurora.org)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621352166; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=G/CPCnGEjvttp+VCHeLvBwZJu7G3Cj2AAa3xkQdreIA=; b=KIjXL4nASjWCpa3qsAbEXLjcQz5OE9ZUpTuElffD4Umi+RRM7qq6zpeq3iu0VYWVMpQHB62X
 kxQomHOguafJb3WbbOcVw8tLfw/CvfKpRCdOh2IubGHQZzhahY66Lul6ULwsLd/os7YGLc88
 Cba48kMukErqb8Ay05yKoFSH5Y8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyIyMjIzMCIsICJiaXRiYWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60a3dedfb15734c8f927135c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 18 May 2021 15:35:59
 GMT
Sender: sbanerje=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
	id 1ACA7C433D3; Tue, 18 May 2021 15:35:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
	autolearn=no autolearn_force=no version=3.4.0
Received: from lnxeng01-le.qualcomm.com (unknown [202.46.22.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sbanerje)
	by smtp.codeaurora.org (Postfix) with ESMTPSA id 92EADC433F1;
	Tue, 18 May 2021 15:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92EADC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sbanerje@codeaurora.org
From: "Sourabh Banerjee" <sbanerje@codeaurora.org>
To: bitbake-devel@lists.openembedded.org
Cc: Sourabh Banerjee <sbanerje@codeaurora.org>
Subject: [PATCH 2/3] bitbake: fetch2/repo: add support for sync specific projects
Date: Tue, 18 May 2021 21:05:23 +0530
Message-Id: <1621352124-27088-2-git-send-email-sbanerje@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621352124-27088-1-git-send-email-sbanerje@codeaurora.org>
References: <1621352124-27088-1-git-send-email-sbanerje@codeaurora.org>

repo tool can fetch projects by name. I.e., if there are
multiple projects listed in the manifest file.

 <manifest>
  <project name="project1"  path="sync path1"  revision="sha256" />
  <project name="project2"  path="sync path2"  revision="sha256" />
 </manifest>

Documented Usage: repo sync [<project>...]

By supplying project=<project_name> recipe can choose to sync a specific
project.
Example:
  SRC_URI = "repo://REPOROOT;protocol=git;branch=main;manifest=default.xml;project=project1"

This is helpful when recipe needs to sync only a specific project
from a manifest that lists multiple projects.

Signed-off-by: Sourabh Banerjee <sbanerje@codeaurora.org>
---
 bitbake/lib/bb/fetch2/repo.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/repo.py b/bitbake/lib/bb/fetch2/repo.py
index 8547b9e..e7c5255 100644
--- a/bitbake/lib/bb/fetch2/repo.py
+++ b/bitbake/lib/bb/fetch2/repo.py
@@ -41,7 +41,10 @@ class Repo(FetchMethod):
         if not ud.manifest.endswith('.xml'):
             ud.manifest += '.xml'
 
-        ud.localfile = d.expand("repo_%s%s_%s_%s.tar.gz" % (ud.host, ud.path.replace("/", "."), ud.manifest, ud.branch))
+        project = ud.parm.get('project', '')
+        if len(project):
+            project = '_' + project
+        ud.localfile = d.expand("repo_%s%s_%s_%s%s.tar.gz" % (ud.host, ud.path.replace("/", "."), ud.manifest, ud.branch, project.replace("/", ".")))
 
     def download(self, ud, d):
         """Fetch url"""
@@ -52,7 +55,8 @@ class Repo(FetchMethod):
 
         repodir = d.getVar("REPODIR") or (d.getVar("DL_DIR") + "/repo")
         gitsrcname = "%s%s" % (ud.host, ud.path.replace("/", "."))
-        codir = os.path.join(repodir, gitsrcname, ud.manifest)
+        project = ud.parm.get('project', '')
+        codir = os.path.join(repodir, gitsrcname, ud.manifest, project.replace("/", "."))
 
         if ud.user:
             username = ud.user + "@"
@@ -76,7 +80,7 @@ class Repo(FetchMethod):
         if jobs:
             jobs = '-j' + jobs
         bb.fetch2.check_network_access(d, "%s sync %s" % (ud.basecmd, ud.url), ud.url)
-        runfetchcmd("%s sync %s" % (ud.basecmd, jobs), d, workdir=repodir)
+        runfetchcmd("%s sync %s %s" % (ud.basecmd, jobs, project), d, workdir=repodir)
 
         scmdata = ud.parm.get("scmdata", "")
         if scmdata == "keep":
-- 
2.7.4

