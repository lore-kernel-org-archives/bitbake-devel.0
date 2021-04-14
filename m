Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mx.groups.io with SMTP id smtpd.web11.7175.1618365613440125813
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 13 Apr 2021 19:00:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linux.microsoft.com header.s=default header.b=Tb6V/xAn;
 spf=pass (domain: linux.microsoft.com, ip: 13.77.154.182, mailfrom: pauleg@linux.microsoft.com)
Received: by linux.microsoft.com (Postfix, from userid 1054)
	id C467820B8001; Tue, 13 Apr 2021 19:00:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C467820B8001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1618365612;
	bh=4PUe+QV7NtuevJfLqC3X2mh6CirxOGoTGGaxBcx0iTg=;
	h=From:To:Subject:Date:From;
	b=Tb6V/xAneZltvi68dK/XUzTOCfkfvfFi06kAjdsw0pp71UC6+VycimQ/kHml18Ctz
	 TolTOWVg0HdAXqOqftTPa6mVbMdqDqWc3Mk88g5b8q1TdEN9SU0YX6TKG1m+YAX0FA
	 Re4V60f8wISZ+Yf80i3xtNY4kUJ/Ry3+EtVVhRxU=
From: "Paul Eggleton" <paul.eggleton@linux.microsoft.com>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 0/2] Doc tweaks for 1.50
Date: Tue, 13 Apr 2021 19:00:07 -0700
Message-Id: <cover.1618364983.git.paul.eggleton@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1

A couple of documentation fixes relating to the BitBake 1.50 release.


The following changes since commit e70b925ba98fd4fedf3940d141a4210c953087ca:

  bitbake: Update version to 1.50.0 stable release series (2021-04-09 14:19:54 +0100)

are available in the git repository at:

  git://git.openembedded.org/bitbake-contrib paule/doc-git-pw
  http://cgit.openembedded.org/bitbake-contrib/log/?h=paule/doc-git-pw

Paul Eggleton (2):
  bitbake-user-manual: document no support for using passwords in git
    URLs
  bitbake-user-manual: add REQUIRED_VERSION and adjust PREFERRED_VERSION
    entry

 .../bitbake-user-manual-fetching.rst                   |  9 +++++++++
 .../bitbake-user-manual-ref-variables.rst              | 18 ++++++++++++++++--
 2 files changed, 25 insertions(+), 2 deletions(-)

-- 
1.8.3.1

