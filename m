Received: from mail-pb0-f42.google.com ([209.85.160.42])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1UX8Ru-0004Rv-Nd
	for bitbake-devel@lists.openembedded.org;
	Tue, 30 Apr 2013 13:10:42 +0200
Received: by mail-pb0-f42.google.com with SMTP id up15so203597pbc.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Apr 2013 03:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:cc:subject:date:message-id:x-mailer;
	bh=HnMP+dfKVNtq/BBs4lCPuTCuXA3ORtvH32sFuefLYcc=;
	b=sePRWwZBqxYnryxMgNQH7Cq1+5q8hyuJfbmzzstkjk2VCITD8OVSHbddSbbfD1KKZH
	wuLyxd4vmlkid4JgpDvGVuBmabY63xZ5TNTaOpXq8ZwsE1NlID3FIzN8mylBksuKCrGi
	odduPe3XwoQa4UyNDVGfU6V6ZHDIH1OrTCjMUgH7AsIp8HHEah7JqjWm7K8yAjq6G0Zy
	tS4UhMKyzfnq/GpcmtMJXOwZ6TIo2MQ1mtYTVuzLcRoFFggJ1Cl8igQKiwvChRP2A6A6
	kGyv4pCuCOWkzX0AQqJftOmy4G4EdyMxaqym80FbEG3J2pZj7eyeaMV3F9gspBooU9yU
	YhXw==
X-Received: by 10.68.103.36 with SMTP id ft4mr74508217pbb.2.1367319147611;
	Tue, 30 Apr 2013 03:52:27 -0700 (PDT)
Received: from localhost (ip-62-24-80-145.net.upcbroadband.cz. [62.24.80.145])
	by mx.google.com with ESMTPSA id
	pa2sm30156991pac.9.2013.04.30.03.52.24 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 30 Apr 2013 03:52:26 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Apr 2013 12:52:40 +0200
Message-Id: <1367319160-19785-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.8.2.1
Subject: [RFC] git: add BB_FETCH_PREMIRROR_READONLY option
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
X-List-Received-Date: Tue, 30 Apr 2013 11:10:51 -0000

* just RFC, because I haven't even tested this change,
  use it only to describe the issue and discuss it

* remove symlink to ud.fullmirror when BB_FETCH_PREMIRROR_READONLY is set

* with read-only PREMIRROR (e.g. mounted over NFS or CIFS
  and referenced as file:///mnt/premirror) we cannot use
  BB_GENERATE_MIRROR_TARBALLS because all git2_abc.git.tar.gz
  files later became just symlinks to read-only location in PREMIRROR
  (it works fine on first build and for new components, because
  at that time there isn't tarball on PREMIRROR yet).

  ERROR: Fetcher failure: Fetch command failed with exit code 141, output:
  tar (child): /build/downloads/git2_abc.git.tar.gz: Cannot open: Read-only file system
  tar (child): Error is not recoverable: exiting now

* maybe we can change the default behavior and always remove symlink
  without introducing new option

Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
---
 lib/bb/fetch2/git.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 052802e..14a8bc2 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -217,6 +217,10 @@ class Git(FetchMethod):
     def build_mirror_data(self, url, ud, d):
         # Generate a mirror tarball if needed
         if ud.write_tarballs and (ud.repochanged or not os.path.exists(ud.fullmirror)):
+            premirror_readonly = (d.getVar("BB_FETCH_PREMIRROR_READONLY", True) == "1")
+            if premirror_readonly and os.path.islink(ud.fullmirror):
+                os.unlink(origud.localpath)
+
             os.chdir(ud.clonedir)
             logger.info("Creating tarball of git repository")
             runfetchcmd("tar -czf %s %s" % (ud.fullmirror, os.path.join(".") ), d)
-- 
1.8.2.1



