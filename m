Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by mx.groups.io with SMTP id smtpd.web10.48180.1612244307043948624
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 01 Feb 2021 21:38:27 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 134.134.136.31, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: oxrAugwG0IEEmwrnDmK6LZFDfJufnDij8ktJ1779FE5guJ2cFkGTV/oMeTcnpWSqe9yC6Op+T3
 a3tjzYB+c3dw==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242317831"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="242317831"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:38:26 -0800
IronPort-SDR: mc9ZcCAjBkTsUJLDKIHdixFHaVX4dlu12b37Z+18FSa3sOl9GptYeWKyLrpqmSoofC8YYEkd/C
 yh8dpCX3Q2wQ==
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="391296087"
Received: from ajayap1x-mobl1.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.255.184.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 21:38:25 -0800
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [gatesgarth][PATCH 0/1] patch review request
Date: Tue,  2 Feb 2021 13:38:18 +0800
Message-Id: <cover.1612244174.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please review these changes for gatesgarth.

Thanks,

Anuj

The following changes since commit cb7277e7bb3a440968fdb918d56fe8fa17bca2e6:

  data_smart: Ensure hash reflects vardepvalue flags correctly (2021-01-26 15:44:56 +0000)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.48-next

Matt Hoosier (1):
  fetch/git: download LFS content too during do_fetch

 lib/bb/fetch2/git.py  | 44 ++++++++++++++++++++++++++++++++++++++++---
 lib/bb/tests/fetch.py | 28 +++++++++++++++++++--------
 2 files changed, 61 insertions(+), 11 deletions(-)

-- 
2.29.2

