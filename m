Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
 by mx.groups.io with SMTP id smtpd.web10.20473.1625661768824105468
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 07 Jul 2021 05:42:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=dwrobel@ertelnet.rybnik.pl header.s=ertelnet header.b=Vr9kM0f+;
 spf=pass (domain: ertelnet.rybnik.pl, ip: 136.143.188.14, mailfrom: dwrobel@ertelnet.rybnik.pl)
ARC-Seal: i=1; a=rsa-sha256; t=1625661767; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eCj2jyXtLIe5RFugoHSGH2lAty1tlGi7hhIUfeb26N7BJPXJm+1pz0L7m2C4yi9DoWqwTy9GxW8egzhFR5ytcrCemZFl/RMQ6Zlpz9ChfdDlWuizeT0hT6vbX+l/cWb8H5AMpIbctbb4SYW/3BCfMqApejkALz9ZKzcotIAs8d8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1625661767; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=t5POo/wnQMbUkNE4cKCgPU8QLWLqUplg67uS/T+OeeQ=; 
	b=H1cfcZ2UJKydAJB0IT9eyvyeB5Z90nu3z2I7S0MFRfMao2kIFpMTDRtPGZ63MhLu6+U/DbqcP8p/OXDLRKMTeOjfT8gEyNWX+KF9+o4EDFYXcvLSF0/fdz6wOrQ9gcuDxFPxgH3329omToaDPiKtzEF+DzawxAI/PteRGms3vxc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=ertelnet.rybnik.pl;
	spf=pass  smtp.mailfrom=dwrobel@ertelnet.rybnik.pl;
	dmarc=pass header.from=<dwrobel@ertelnet.rybnik.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1625661767;
	s=ertelnet; d=ertelnet.rybnik.pl; i=dwrobel@ertelnet.rybnik.pl;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
	bh=t5POo/wnQMbUkNE4cKCgPU8QLWLqUplg67uS/T+OeeQ=;
	b=Vr9kM0f+5uHPPCzKJ/PF+vDZhx1TJCqBMu/mF9zONDrXT3oeRkg5uNTApIFxwsnf
	RTV+neA9D9Zf3IVQ28A60uJKW+kLwUuyBXmmAxxBl/9eRwfAB5jpYDyEC6utLknqyF8
	mD2UjJwQd2foNP0WrJnjy1DVBJk1CKzakQdi4rM0=
Received: from dell.adbgroup.pl (178.217.216.129 [178.217.216.129]) by mx.zohomail.com
	with SMTPS id 162566176425362.19493646989304; Wed, 7 Jul 2021 05:42:44 -0700 (PDT)
From: "Damian Wrobel" <dwrobel@ertelnet.rybnik.pl>
To: bitbake-devel@lists.openembedded.org
Cc: Adam Romanek <romanek.adam@gmail.com>
Subject: [PATCH] bitbake: fetch2/git: run gc in foreground to avoid race with tar
Date: Wed,  7 Jul 2021 14:42:30 +0200
Message-Id: <20210707124230.2499371-1-dwrobel@ertelnet.rybnik.pl>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-ZohoMailClient: External
Content-Transfer-Encoding: 8bit

From: Adam Romanek <romanek.adam@gmail.com>

It looks like git gc can interrupts the package creation when
BB_GENERATE_MIRRORS_TARBALL is in use.

Log excerpts:

tar -czf TOPDIR/../downloads/git2_bitbucket.name-hidden.git.tar.gz . failed with exit code 1, output:
tar: ./objects/pack/pack-89a1d76f6c08f53172ef1d02ff851d90564362c4.pack: file changed as we read it
tar: ./objects/pack/pack-b4a48ada355d333630fdf6b4f67205b7c264dc2c.idx: File removed before we read it

Auto packing the repository in background for optimum performance.
See "git help gc" for manual housekeeping.

Signed-off-by: Adam Romanek <romanek.adam@gmail.com>
Signed-off-by: Damian Wrobel <dwrobel@ertelnet.rybnik.pl>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 5e65c83c..488f4c74 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -231,7 +231,7 @@ class Git(FetchMethod):
             for name in ud.names:
                 ud.unresolvedrev[name] = 'HEAD'
 
-        ud.basecmd = d.getVar("FETCHCMD_git") or "git -c core.fsyncobjectfiles=0"
+        ud.basecmd = d.getVar("FETCHCMD_git") or "git -c core.fsyncobjectfiles=0 -c gc.autoDetach=false"
 
         write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0"
         ud.write_tarballs = write_tarballs != "0" or ud.rebaseable
-- 
2.31.1

