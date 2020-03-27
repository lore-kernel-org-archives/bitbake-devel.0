Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 by mx.groups.io with SMTP id smtpd.web10.158.1585349519052851978
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 27 Mar 2020 15:51:59 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: windriver.com, ip: 147.11.146.13, mailfrom: david.reyna@windriver.com)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 02RMpnS7006840
	(version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
	Fri, 27 Mar 2020 15:51:50 -0700 (PDT)
Received: from honig-Precision-T5600.corp.ad.wrs.com (147.11.209.184) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
 14.3.487.0; Fri, 27 Mar 2020 15:51:49 -0700
From: "Reyna, David" <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
CC: David Reyna <David.Reyna@windriver.com>,
        "Ahmed . Hossam"
	<Ahmed.Hossam@opensynergy.com>,
        Paul Eggleton <paul.eggleton@linux.intel.com>
Subject: [PATCH 0/4] toaster:cummulative_03272020
Date: Fri, 27 Mar 2020 15:50:54 -0700
Message-ID: <cover.1585348962.git.david.reyna@windriver.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This cummulative patch set for Toaster is based after the previously submitted "Dango-2.2 update"
patch (though there are no direct overlaps):
  * Bugzilla #13847 Toaster needs update to Dunfell
  * Bugzilla #13170 Support environment-safe manage commands
  * Bugzilla #13717 FieldError when trying to load Reverse runtime dependencies
  * Bugzilla #13707 toaster: import build directory fails if BBLAYERS contains variable reference

The following changes since commit 127ebac4a40ff63f493afbb3629f914a0b92d22b:

  toaster: migrate to Django-2.2 (2020-03-27 15:39:24 -0700)

are available in the Git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/toaster_cummulative_03272020
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/toaster_cummulative_03272020

David Reyna (3):
  toaster: update to Dunfell
  toaster: support environment-safe manage commands
  toaster: FieldError loading Reverse runtime dependencies

Paul Eggleton (1):
  toaster: fix for import build directory with var refs in BBLAYERS

 bin/toaster                                   | 19 ++++++++++++++++---
 lib/toaster/orm/fixtures/oe-core.xml          | 12 ++++++------
 lib/toaster/orm/fixtures/poky.xml             | 18 +++++++++---------
 lib/toaster/toastergui/views.py               |  2 +-
 .../management/commands/buildimport.py        | 12 +++++++++++-
 5 files changed, 43 insertions(+), 20 deletions(-)

-- 
2.20.1

