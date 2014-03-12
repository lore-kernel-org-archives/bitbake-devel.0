Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f46.google.com (mail-wg0-f46.google.com [74.125.82.46])
	by mail.openembedded.org (Postfix) with ESMTP id 15EDA6F6E7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Mar 2014 18:47:36 +0000 (UTC)
Received: by mail-wg0-f46.google.com with SMTP id b13so5674408wgh.5
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Mar 2014 11:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=9nYwy0LmwfVkyDJx7VkrwX9ezpbTB4fracPlu82KCeo=;
	b=iZ0YioiwbNvY/wQ0P01KWRUbPqOdImiCP4zmDxuf7KSnliCsM2BxtU+2o94vH76o5W
	7RaFqxcL5i6C6JXvsEYSidad/ZztsMJd6caNtohGuHmZhl5hKqntLx27mYSPDhfWE4M7
	i8AaR+dAGfTb5YOsc93EwCr5NxFTVm+3cgSm3QjZg5NcWHEY7dy9x3j9xgLJYB5wUzXC
	uuKSNGXiWdqm43oEdSdkQqicw2UgZ0KNcPYVCUADUprj9OmKQqQVaJ8SytCYdchI7450
	ASoKoQUPidqZNIFhFOIaVdJTdPLHyGdR0jCd8uvplHcauoq0T5ehWJKL5QSlU7dCKVaI
	koZQ==
X-Gm-Message-State: ALoCoQnnBqHH/nlztH1O14CVqVECEelgMrQA136XgpnIGmQm2zPFwJeGolyFVkndbvQDB6E0/c9d
X-Received: by 10.180.97.72 with SMTP id dy8mr8614760wib.5.1394650057203;
	Wed, 12 Mar 2014 11:47:37 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	ga20sm14952853wic.0.2014.03.12.11.47.35 for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Wed, 12 Mar 2014 11:47:36 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 6A13B5605BD; Wed, 12 Mar 2014 18:47:37 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 12 Mar 2014 18:47:36 +0000
Message-Id: <cover.1394649860.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
Cc: Amit Kumar Chaudhary <amit@floatingpondtech.com>,
	Alexandru DAMIAN <alexandru.damian@intel.com>,
	Ravi Chintakunta <ravi.chintakunta@timesys.com>
Subject: [PATCH 0/4] toaster patchset
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 12 Mar 2014 18:47:37 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patchset consists on data collection improvement patches, and 
UI interface improvements.

Can you please pull in these changes ?

The following changes since commit fe8baaa2f533db7a1b7203476c675588923d8d45:

  runqueue: Improve sigchld handler (2014-03-12 05:55:59 -0700)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/submission-12032014
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=submission-12032014

Amit Kumar Chaudhary (1):
  toaster: add errors and warnings listing

Cristiana Voicu (2):
  toaster: populate target image file table
  toaster: add license manifest path to database

Ravi Chintakunta (1):
  toaster: Add counters to filters

 lib/bb/ui/buildinfohelper.py                       | 27 +++++++
 lib/bb/ui/toasterui.py                             | 10 ++-
 lib/toaster/bldviewer/api.py                       |  1 +
 lib/toaster/bldviewer/views.py                     |  3 +-
 lib/toaster/toastergui/static/js/main.js           | 20 ++++++
 .../toastergui/templates/builddashboard.html       | 56 ++++++++++++++-
 .../toastergui/templates/filtersnippet.html        | 17 +++--
 lib/toaster/toastergui/views.py                    | 84 ++++++++++++----------
 8 files changed, 171 insertions(+), 47 deletions(-)

-- 
1.8.3.2


