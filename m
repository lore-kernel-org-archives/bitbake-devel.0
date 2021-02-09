Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by mx.groups.io with SMTP id smtpd.web09.12314.1612886220938659827
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Feb 2021 07:57:01 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 192.55.52.136, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: 6f3BeDvH6u0CNNrDk4Y/74WJT05D9EA+WwMuWBooIwbbKrd+tYFW9TUKm8ZjDtJvsySFkD1fC7
 r0qApaOakeMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="161054050"
X-IronPort-AV: E=Sophos;i="5.81,165,1610438400"; 
   d="scan'208";a="161054050"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 07:57:00 -0800
IronPort-SDR: StYyRbCbW8JvpMTDv4BTCltbZuyeSIcIXl5rpY8yxG8SrxGs0Yd9c6N4gVq4CfPexgg5PwADWT
 URTkrdHaUlOw==
X-IronPort-AV: E=Sophos;i="5.81,165,1610438400"; 
   d="scan'208";a="419866440"
Received: from ytee-mobl1.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.255.146.52])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 07:56:58 -0800
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.48][PATCH 0/1] gatesgarth review request
Date: Tue,  9 Feb 2021 23:56:53 +0800
Message-Id: <cover.1612886078.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please review these changes for 1.48/gatesgarth. This pull request has a
single patch that should go together with the _PYTHON_SYSCONFIGDATA_NAME
changes in oe-core gatesgarth.

Thanks,

Anuj

The following changes since commit c73f8f2f4a6491c6bea54839630af6994c27ad24:

  fetch/git: download LFS content too during do_fetch (2021-02-02 15:51:38 +0000)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.48-next

Alexander Kanavin (1):
  lib/bb/fetch2/__init__.py: drop _PYTHON_SYSCONFIGDATA_NAME unsetting

 lib/bb/fetch2/__init__.py | 5 -----
 1 file changed, 5 deletions(-)

-- 
2.29.2

