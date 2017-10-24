Return-Path: <andr2000@gmail.com>
Received: from mail-lf0-f68.google.com (mail-lf0-f68.google.com
	[209.85.215.68])
	by mail.openembedded.org (Postfix) with ESMTP id C79376093B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Oct 2017 11:35:54 +0000 (UTC)
Received: by mail-lf0-f68.google.com with SMTP id p184so23560926lfe.12
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Oct 2017 04:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=QOLYmrqFaPsfdeVGAXB+PAAwb4CwjHWoUBRJQpO452o=;
	b=DNd/Im5CquJuuCg3LBQuG753DAFGvKWIpdITF7IMIzi7fbNVnVNnaiYdgptSVe7cbB
	dZpMyGfKPdmAc3afqrs7wSS/l4WpZ0thp7jETYf3FffoXOhHB//Hm89TS4XHTKuZIZeD
	PxtWne8j9AHLyQmvH9iHfnuTMp6QqyHhMCHO3Qk3V4S0qT0X539BB5eClisIh0w1fjm7
	lTrr1lv98N08zBz+4HS2YefNTCnbSXqbuaN9XVQtLGpKPdlXtetPk3KzFJEL5YY6NYkY
	3KH9juB/UnXdjb/CQGtQk0riErUQsJJG5NKOl0GzembLF5Yd/nM3zRBF1rHted51OCNj
	wHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=QOLYmrqFaPsfdeVGAXB+PAAwb4CwjHWoUBRJQpO452o=;
	b=C5+PyZtrrMpXbzPMcdEcJCl4mLhH+wHmhGGJBtzRbgdImmzSFE0O+Md0vRgR8c31Wn
	ZgpD/Z9Gb+nv4zh6F19GBC6dRzSO1ca7hcjMPTCq8hPRDEtaH9HQAZq6SiwPVlt1KZMq
	wTdRB/q0FOQW1QBX8GUuP+PTdOKy6+xhfZv2A5JIzpz91/mhuYN8MAPw7wMSHM3LUyJ0
	ZXCa3ibsWFbq1zYVEZyiagghjn380/yQQDGGqLlhkynii0Eb0SRdqWllZE/kHch/DO3K
	kM2Cn1Pu0EJEVvCPRgRD9Js//NouwlttmL7lBP1E/0qvULxjMsfoCc9MwzwC24LRpI4n
	Qs8g==
X-Gm-Message-State: AMCzsaUUW/OY3+6VDgbaro6QgaJDjcJRNzwNOK2RI/KcJUrhEceilLSe
	XTzL73vM99j4Qi0dckgB/kbbWw==
X-Google-Smtp-Source: ABhQp+QWzbllTOLTaV9Hk1JoVVQ4tI7kA0PJj4XppO2VHSdelCdUj/bPyyeGxyhhbE7yg2SdTNR7JQ==
X-Received: by 10.46.16.218 with SMTP id 87mr7493607ljq.115.1508844955601;
	Tue, 24 Oct 2017 04:35:55 -0700 (PDT)
Received: from a2k-HP-ProDesk-600-G2-SFF.kyiv.epam.com
	(ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
	by smtp.gmail.com with ESMTPSA id h82sm18166lfb.21.2017.10.24.04.35.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 24 Oct 2017 04:35:54 -0700 (PDT)
From: Oleksandr Andrushchenko <andr2000@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Oct 2017 14:35:44 +0300
Message-Id: <1508844944-5761-5-git-send-email-andr2000@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1508844944-5761-1-git-send-email-andr2000@gmail.com>
References: <1508844944-5761-1-git-send-email-andr2000@gmail.com>
X-Mailman-Approved-At: Fri, 27 Oct 2017 14:42:08 +0000
Cc: andr2000@gmail.com,
	Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Subject: [PATCH 4/4] fetch2/repo: Use multiple jobs to fetch and sync
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
X-List-Received-Date: Tue, 24 Oct 2017 11:35:55 -0000

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Google repo supports "--jobs" parameter, so one can
speed up the process of fetching and syncing. According to
https://groups.google.com/a/chromium.org/forum/#!topic/chromium-os-dev/ny3nkgE9AE8
it is even more gets to speed if used separately for
network jobs and "local" ones.
Use BB_NUMBER_THREADS to run parallel repo sync.

Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
---
 lib/bb/fetch2/repo.py | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/lib/bb/fetch2/repo.py b/lib/bb/fetch2/repo.py
index 3c28fe04ab1e..08331acd6706 100644
--- a/lib/bb/fetch2/repo.py
+++ b/lib/bb/fetch2/repo.py
@@ -57,6 +57,13 @@ class Repo(FetchMethod):
         ud.codir = os.path.join(repodir, gitsrcname, ud.manifest)
         ud.repodir = os.path.join(ud.codir, "repo")
 
+    def sync(self, ud, d):
+        # repo can separate the "network" sync (the git fetch part, network bound)
+        # from the local sync (the git rebase part, compute & i/o bound).
+        num_jobs = d.getVar("BB_NUMBER_THREADS", True) or "1"
+        runfetchcmd("repo sync -c -n -j%s" % num_jobs, d, workdir=ud.repodir)
+        runfetchcmd("repo sync -c -l -j%s" % num_jobs, d, workdir=ud.repodir)
+
     def download(self, ud, d):
         """Fetch url"""
 
@@ -74,7 +81,7 @@ class Repo(FetchMethod):
         runfetchcmd("repo init -m %s -b %s -u %s://%s%s%s" % (ud.manifest, ud.branch, ud.proto, username, ud.host, ud.path), d, workdir=ud.repodir)
 
         bb.fetch2.check_network_access(d, "repo sync %s" % ud.url, ud.url)
-        runfetchcmd("repo sync", d, workdir=ud.repodir)
+        self.sync(ud, d)
 
         scmdata = ud.parm.get("scmdata", "")
         if scmdata == "keep":
@@ -88,7 +95,7 @@ class Repo(FetchMethod):
     def unpack(self, ud, destdir, d):
         FetchMethod.unpack(self, ud, destdir, d)
         bb.fetch2.check_network_access(d, "repo sync %s" % ud.url, ud.url)
-        runfetchcmd("repo sync", d, workdir=ud.repodir)
+        self.sync(ud, d)
 
     def supports_srcrev(self):
         return False
-- 
2.7.4


