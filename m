Received: from mail-ee0-f52.google.com ([74.125.83.52])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1UYIe7-00065Q-Ec
	for bitbake-devel@lists.openembedded.org;
	Fri, 03 May 2013 18:15:50 +0200
Received: by mail-ee0-f52.google.com with SMTP id d41so788077eek.25
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 May 2013 08:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
	:references; bh=fxbxcIF46JR25X4mfVYOwqR9Mbj/jasqkglcJjSVydQ=;
	b=WRNrqnG1n14XeiMNA5u+55JTqDWyl5JheP0j7HxgulUGqGQrasNm3MqhHgxd0H8klJ
	/Vvv0gJa52UBe1swPnAwgghnydofbniLZWLyg5LnVaGjlmBWcQgZV34DmaJv01ZE3svA
	r94hxIiDTNvJeFAzNFuPhedxHCld0xjdKDWHc4V3Rhs6TERl0NOV/tzxQPYtl0ArDSjv
	4S+987TXQFvcB8bH2QyaN7/8YX/Paq4JRub8ZdiX1bJqFBDt9n/nmUh1EjmAEKUHR6Ou
	He8QFOPpdA+yNVXhVMqSA4MENxmualAepexkJw/8hC1vqe2h5AEH5RZsK9+KF70bHFZ+
	ygiQ==
X-Received: by 10.14.111.129 with SMTP id w1mr29583695eeg.13.1367596668329;
	Fri, 03 May 2013 08:57:48 -0700 (PDT)
Received: from localhost (ip-62-24-80-145.net.upcbroadband.cz. [62.24.80.145])
	by mx.google.com with ESMTPSA id
	bn53sm16702634eeb.7.2013.05.03.08.57.47 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 03 May 2013 08:57:47 -0700 (PDT)
From: Martin Jansa <martin.jansa@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 May 2013 17:58:12 +0200
Message-Id: <1367596692-12433-1-git-send-email-Martin.Jansa@gmail.com>
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <20732985.qIsTObyanK@helios>
References: <20732985.qIsTObyanK@helios>
Subject: [PATCHv2] git: remove symling before updating mirror tarball
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
X-List-Received-Date: Fri, 03 May 2013 16:16:01 -0000

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
index 052802e..1ec8908 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -217,6 +217,10 @@ class Git(FetchMethod):
     def build_mirror_data(self, url, ud, d):
         # Generate a mirror tarball if needed
         if ud.write_tarballs and (ud.repochanged or not os.path.exists(ud.fullmirror)):
+            # it's possible that this symlink points to read-only filesystem with PREMIRROR
+            if os.path.islink(ud.fullmirror):
+                os.unlink(origud.localpath)
+
             os.chdir(ud.clonedir)
             logger.info("Creating tarball of git repository")
             runfetchcmd("tar -czf %s %s" % (ud.fullmirror, os.path.join(".") ), d)
-- 
1.8.2.1



