Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by mx.groups.io with SMTP id smtpd.web11.2989.1620264864497033411
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 05 May 2021 18:34:26 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: intel.com, ip: 192.55.52.88, mailfrom: anuj.mittal@intel.com)
IronPort-SDR: QHCKIjMieVe/g7EK2ck7EVqL2I0AvrHvHC+ZGT+aQCR5FS0rtMFPZOMsAS1m87oqMRi3dBsFCJ
 2N91A1/r7qOg==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="219222916"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="219222916"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 18:34:20 -0700
IronPort-SDR: pPBG/J9Aj4ROKRqB0LdsUt73YWpRYlk0URCEENeALEaWABLorCb2hKyvnJjhD2KZZRvLRAKQjX
 23pbK2vYQqPw==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="459046386"
Received: from hanpinon-mobl.gar.corp.intel.com (HELO anmitta2-mobl1.gar.corp.intel.com) ([10.213.47.180])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 18:34:19 -0700
From: "Anuj Mittal" <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.50][PATCH 0/2] review request
Date: Thu,  6 May 2021 09:34:12 +0800
Message-Id: <cover.1620264737.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Please review these changes for 1.50/hardknott.

Thanks,

Anuj

The following changes since commit 14c5f0735947307b9d69c57f7334fefaea7311b3:

  bitbake: tests/fetch: remove write protected files too (2021-04-27 15:22:30 +0100)

are available in the Git repository at:

  git://push.openembedded.org/bitbake-contrib stable/1.50-next

Richard Purdie (2):
  runqueue: Fix multiconfig deferred task sstate validity caching issue
  runqueue: Handle deferred task rehashing in multiconfig builds

 lib/bb/runqueue.py | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

-- 
2.30.2

