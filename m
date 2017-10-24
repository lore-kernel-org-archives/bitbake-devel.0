Return-Path: <andr2000@gmail.com>
Received: from mail-lf0-f68.google.com (mail-lf0-f68.google.com
	[209.85.215.68])
	by mail.openembedded.org (Postfix) with ESMTP id A9562719AF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Oct 2017 11:35:53 +0000 (UTC)
Received: by mail-lf0-f68.google.com with SMTP id a2so1522248lfh.11
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Oct 2017 04:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=wdfETzZDwKts0Pa46RRcNmA25xw4SCIaOFQeGHUomV8=;
	b=iUxvuKbT/vcyvM7P5dRaL2Pf1I+C7jcwBHFP5WLMYwJn1x2I2Upyk37lXQbqlhs9rq
	AjeDVe5jDZqzIxSkxwbve5tgtPxLgJq9PIEQ8UqDnbsZ/1wkuUZqpiD1ce6VWmehv7F/
	Y/F/TWDJ2Xx9yG9Epqb8hbDzyFrurY4WSu9yQGlHmvxAuVeI6NmeUwWuPCEdjrW2+Erk
	HwkkeMXX3b0k1BI8ctQZWBlhv9pbwes78vEl/JJWeIVRqDaPBTs0MoI9Ic2uqRut3pmD
	uAPj/qxgMwVTWTRWcQbLD9Y+qv0lMIG2s0vQNYif8LCm1En29SnhB2fQmMypI8WQrByA
	K4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=wdfETzZDwKts0Pa46RRcNmA25xw4SCIaOFQeGHUomV8=;
	b=VH+Fneec4dtk9V6LTIB+0NC7L93gfRFgttlssMtIg8czKTLpnp+EAqMk1+Lr4qZfJT
	6z2KcmQ0gqwndVWuB6lBlbQuH9btkvOjjBG7kBrCdn8JSl7s/Rn76HdKtvsiY6M/pMzs
	rhZB6IbgIuIkb71Jk+7qeTAfVQeJxyCLd2b+iseTayQnRIMJc5X1+hrw+29p/EcnxcLJ
	hkgqxgI2FNnuhKpI34Epdl7TwAuE0JnYj7rds8aYTZu+7y7QEswAFZ2Oxhee6YBVLB6A
	6NflzFXZZH7R9GTtLIb59DFw3rM9ELfEhTXRhyjM9GQR+pYAaHxCi1Uz/cIuaurFx/AR
	tKXg==
X-Gm-Message-State: AMCzsaUuam6EdbPXtOb4LLlj7XmB1XBwmGb9qb/uFois7NRI2G3Lwd/s
	Rb84i6zwi5bUY6pn2KbkzpNcQA==
X-Google-Smtp-Source: ABhQp+TSEJsXx7QcZoknOhwYz50HGwHq3PCIunr9FYhumoqt4190isXsMawQ2njDm50ufOUzQW6nqw==
X-Received: by 10.25.59.26 with SMTP id i26mr4867674lfa.191.1508844954235;
	Tue, 24 Oct 2017 04:35:54 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com
	(ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
	by smtp.gmail.com with ESMTPSA id h82sm18166lfb.21.2017.10.24.04.35.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 24 Oct 2017 04:35:53 -0700 (PDT)
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Oct 2017 14:35:43 +0300
Message-Id: <1508844944-5761-4-git-send-email-andr2000@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1508844944-5761-1-git-send-email-andr2000@gmail.com>
References: <1508844944-5761-1-git-send-email-andr2000@gmail.com>
X-Mailman-Approved-At: Fri, 27 Oct 2017 14:42:08 +0000
Cc: andr2000@gmail.com,
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH 3/4] fetch2/repo: Make fetcher always sync on unpack
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
X-List-Received-Date: Tue, 24 Oct 2017 11:35:53 -0000

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Currently if repo has fetched the repository and
cached it to a tar file it never runs repo sync again,
thus making the build use potentially outdated repo.
Fix this by implementing unpack functionality which runs
repo sync.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 lib/bb/fetch2/repo.py | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
index 861437dd22b2..3c28fe04ab1e 100644
--- a/lib/bb/fetch2/repo.py
+++ b/lib/bb/fetch2/repo.py
@@ -52,6 +52,10 @@ class Repo(FetchMethod):
             ud.manifest += '.xml'
 
         ud.localfile = d.expand("repo_%s%s_%s_%s.tar.gz" % (ud.host, ud.path.replace("/", "."), ud.manifest, ud.branch))
+        repodir = d.getVar("REPODIR", True) or os.path.join(d.getVar("DL_DIR", True), "repo")
+        gitsrcname = "%s%s" % (ud.host, ud.path.replace("/", "."))
+        ud.codir = os.path.join(repodir, gitsrcname, ud.manifest)
+        ud.repodir = os.path.join(ud.codir, "repo")
 
     def download(self, ud, d):
         """Fetch url"""
@@ -60,22 +64,17 @@ class Repo(FetchMethod):
             logger.debug(1, "%s already exists (or was stashed). Skipping repo init / sync.", ud.localpath)
             return
 
-        gitsrcname = "%s%s" % (ud.host, ud.path.replace("/", "."))
-        repodir = d.getVar("REPODIR") or os.path.join(d.getVar("DL_DIR"), "repo")
-        codir = os.path.join(repodir, gitsrcname, ud.manifest)
-
         if ud.user:
             username = ud.user + "@"
         else:
             username = ""
 
-        repodir = os.path.join(codir, "repo")
-        bb.utils.mkdirhier(repodir)
+        bb.utils.mkdirhier(ud.repodir)
         bb.fetch2.check_network_access(d, "repo init -m %s -b %s -u %s://%s%s%s" % (ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), ud.url)
-        runfetchcmd("repo init -m %s -b %s -u %s://%s%s%s" % (ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), d, workdir=repodir)
+        runfetchcmd("repo init -m %s -b %s -u %s://%s%s%s" % (ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), d, workdir=ud.repodir)
 
         bb.fetch2.check_network_access(d, "repo sync %s" % ud.url, ud.url)
-        runfetchcmd("repo sync", d, workdir=repodir)
+        runfetchcmd("repo sync", d, workdir=ud.repodir)
 
         scmdata = ud.parm.get("scmdata", "")
         if scmdata == "keep":
@@ -84,7 +83,12 @@ class Repo(FetchMethod):
             tar_flags = "--exclude='.repo' --exclude='.git'"
 
         # Create a cache
-        runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, os.path.join(".", "*") ), d, workdir=codir)
+        runfetchcmd("tar %s -czf %s %s" % (tar_flags, ud.localpath, os.path.join(".", "*") ), d, workdir=ud.codir)
+
+    def unpack(self, ud, destdir, d):
+        FetchMethod.unpack(self, ud, destdir, d)
+        bb.fetch2.check_network_access(d, "repo sync %s" % ud.url, ud.url)
+        runfetchcmd("repo sync", d, workdir=ud.repodir)
 
     def supports_srcrev(self):
         return False
-- 
2.7.4


