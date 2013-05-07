Received: from mail-ea0-f179.google.com ([209.85.215.179])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1UZlCd-00086E-BJ
	for bitbake-devel@lists.openembedded.org;
	Tue, 07 May 2013 18:57:25 +0200
Received: by mail-ea0-f179.google.com with SMTP id h14so424595eaj.10
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 07 May 2013 09:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
	:references; bh=MfLn7aJ4d5rIMjlve32Dj1BMBPFpMVDoasviGeNFsEI=;
	b=g0H3BHZveyw+kGlvl+yMceAy0qIcwV0YS5avCRVVZyMjk1NiQ8F64/MlCm7mmywRhw
	Jehii5yIvDSx69QdUD2A38F6iDd6qE9yxiCRvcYQ4s88KwGZDqLnsGAxug5oYNT7RXTb
	EYFrCLeHJx0aO6GM7dYp4Y3+tKG5+F8ll/IMbrH31nmxb4M+gnFqq7pnzpF/hjRYVSE5
	fTOtNQK9w7aT1StJBfPdhqnyVUIhqWhqfCtF8mEC4oiHVGDl5RcKS83/0dgCBxN2lp/b
	a8mjPv0w2ZsV0ev41OvGNmY4t1pp6s6AcdXvt2Nxg6m9Ke5HNB341qMeEMUk3rrpT8GB
	k70g==
X-Received: by 10.14.106.200 with SMTP id m48mr7084432eeg.17.1367944762457;
	Tue, 07 May 2013 09:39:22 -0700 (PDT)
Received: from localhost (ip-62-24-80-145.net.upcbroadband.cz. [62.24.80.145])
	by mx.google.com with ESMTPSA id
	n7sm40475352eeo.0.2013.05.07.09.39.21 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 07 May 2013 09:39:21 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 May 2013 18:39:20 +0200
Message-Id: <1367944760-16756-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <20732985.qIsTObyanK@helios>
References: <20732985.qIsTObyanK@helios>
Subject: [PATCHv3] git: remove symling before updating mirror tarball
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 07 May 2013 16:57:30 -0000

* with read-only PREMIRROR (e.g. mounted over NFS or CIFS
  and referenced as file:///mnt/premirror) we cannot use
  BB_GENERATE_MIRROR_TARBALLS because all git2_abc.git.tar.gz
  files later became just symlinks to read-only location in PREMIRROR
  (it works fine on first build and for new components, because
  at that time there isn't tarball on PREMIRROR yet).

  ERROR: Fetcher failure: Fetch command failed with exit code 141, output:
  tar (child): /build/downloads/git2_abc.git.tar.gz: Cannot open: Read-only file system
  tar (child): Error is not recoverable: exiting now

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/fetch2/git.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 052802e..6175e4c 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -217,6 +217,10 @@ class Git(FetchMethod):
     def build_mirror_data(self, url, ud, d):
         # Generate a mirror tarball if needed
         if ud.write_tarballs and (ud.repochanged or not os.path.exists(ud.fullmirror)):
+            # it's possible that this symlink points to read-only filesystem with PREMIRROR
+            if os.path.islink(ud.fullmirror):
+                os.unlink(ud.fullmirror)
+
             os.chdir(ud.clonedir)
             logger.info("Creating tarball of git repository")
             runfetchcmd("tar -czf %s %s" % (ud.fullmirror, os.path.join(".") ), d)
-- 
1.8.2.1



