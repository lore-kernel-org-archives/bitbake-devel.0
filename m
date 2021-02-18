Received: from MTA-07-4.privateemail.com (MTA-07-4.privateemail.com [68.65.122.27])
 by mx.groups.io with SMTP id smtpd.web10.838.1613681627899500457
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Feb 2021 12:53:48 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: whitetree.xyz, ip: 68.65.122.27, mailfrom: charles.davies@whitetree.xyz)
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
	by MTA-07.privateemail.com (Postfix) with ESMTP id AFC7460053;
	Thu, 18 Feb 2021 15:53:46 -0500 (EST)
Received: from localhost.localdomain (unknown [10.20.151.232])
	by MTA-07.privateemail.com (Postfix) with ESMTPA id 8B0C160052;
	Thu, 18 Feb 2021 20:53:45 +0000 (UTC)
From: "Charlie Davies" <charles.davies@whitetree.xyz>
To: bitbake-devel@lists.openembedded.org
Cc: Charlie Davies <charles.davies@whitetree.xyz>
Subject: [RFC][PATCH 0/9] addition of REQUIRED_VERSION variable
Date: Thu, 18 Feb 2021 20:52:12 +0000
Message-Id: <20210218205221.55005-1-charles.davies@whitetree.xyz>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Content-Transfer-Encoding: quoted-printable

Fixes [YOCTO #10096]

This series of patches introduces REQUIRED_VERSION which allows the user
to specify a version of a package and if that version is not found then
an informative error is raised and Bitbake stops. REQUIRED_VERSION is set
in the same manner as the existing PREFERRED_VERSION.

** TODO **

1) Add a patch for changes to the documentation to describe
REQUIRED_VERSION
2) Change logic in scripts/contrib/devtool-stress.py and=20
scripts/contrib/list-packageconfig-flags.py since the behaviour of the
underlying bb.providers.findProviders function has changed. Should I
raise an exception if the REQUIRED_VERSION is requested by not found in
these scripts?
3) The multilib_global patch should be submitted to a different mailing
list but for now kept with this series of patches to provide context.

** Q's **

1) Have I caught all of the knock on effects these patches have on
tinfoil?

Cheers,

Charles

Charlie Davies (9):
  bitbake: providers: fix incorrect return type bug
  bitbake: providers: use pythonic empty list check
  bitbake: providers: remove unneeded logging call
  bitbake: providers: consistent single line formatting between
    functions
  bitbake: providers: introduce logic for REQUIRED_VERSION variable
  bitbake: providers: check for REQUIRED_VERSION in _filterProviders
  bitbake: lib: add Required Version to Bitbake --show-versions command
  bitbake: cooker: Add REQUIRED_VERSION checks
  multilib_global: handle REQUIRED_VERSION

 bitbake/lib/bb/cooker.py             | 34 ++++++++----
 bitbake/lib/bb/providers.py          | 81 ++++++++++++++++++----------
 meta/classes/multilib_global.bbclass | 67 +++++++++++++----------
 3 files changed, 114 insertions(+), 68 deletions(-)

--=20
2.30.0

