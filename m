Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
	[209.85.220.45])
	by mail.openembedded.org (Postfix) with ESMTP id CC9E265D19
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jan 2015 16:13:44 +0000 (UTC)
Received: by mail-pa0-f45.google.com with SMTP id lf10so11356637pab.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jan 2015 08:13:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=6L4jbcpI/C6N70vAm0DgdxHLpEN+nU8jT5lc3vPusE4=;
	b=iTRTOsylNFCKP8xUtS8FoJbJYHXpcVG8yQFQx4n/r8a7+bLhze/n7FWQ1iFjsebhhC
	Q8VtY39n7YUAp0Vbt0okV5xAiZPImg7ZUfpYMMZXtX1QWLch+HARdz5+wEwc1fr+Km4d
	mzZVXshSZljwgqe1dPOcf/3XPYy089i1kZLzdfeCo39HbfO0sMLboKPV6MNRX4LJCZQS
	J38AZRAULgDY6s1GgNFpe5hTOkSTSkgmKk0Fhs8DKi5ddMYBzrhnLZ7tOohQPVxcwGhZ
	ivA+SgtVnp0jC6038K2O2vSmiGIBvwo8KWHdh9LeJo59H1jZEKO7IQ9ldzGVOgR2uJvv
	eUjg==
X-Gm-Message-State: ALoCoQlqVZAAqKtcIns0K2hDBJNzSyCvduGBzb3w1+pOo4BoaH7eKaU64IgLdD8kMmyYhYj4PndY
X-Received: by 10.68.242.8 with SMTP id wm8mr6988361pbc.32.1421252024126;
	Wed, 14 Jan 2015 08:13:44 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	ge2sm20071986pbc.15.2015.01.14.08.13.42
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 14 Jan 2015 08:13:43 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id AD85A56220A; Wed, 14 Jan 2015 12:46:50 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Jan 2015 12:46:49 +0000
Message-Id: <cover.1421239131.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 0/4] Toaster feature / bugfix patchset
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
X-List-Received-Date: Wed, 14 Jan 2015 16:13:55 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This patchset brings in the layer details page, and the managed version
of the "all builds" page.

The patches have been reviewed on the Toaster mailing list.

Can you please pull at your convenience ?


Cheers,
Alex


The following changes since commit 0557d03c170fba8d7efe82be1b9641d0eb229213:

  cooker/cache/parse: Implement pyinofity based reconfigure (2015-01-13 22:23:21 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150114-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150114-submission-bb

Alexandru DAMIAN (2):
  toastergui: all builds page lists failed build requests
  toasterui: fix variable data error

Michael Wood (2):
  toaster: Add layer details page feature
  toaster: layerdetails Remove compatibility setting

 lib/bb/ui/buildinfohelper.py                       |   2 +-
 lib/toaster/toastergui/static/css/default.css      |   1 +
 lib/toaster/toastergui/static/js/layerdetails.js   | 398 ++++++++++++
 lib/toaster/toastergui/static/js/libtoaster.js     |  35 +
 lib/toaster/toastergui/templates/layerdetails.html | 625 +++++++++++++-----
 .../toastergui/templates/layers_dep_modal.html     |   9 +
 .../toastergui/templates/managed_builds.html       | 135 ++++
 .../toastergui/templates/managed_mrb_section.html  | 172 +++++
 lib/toaster/toastergui/templatetags/projecttags.py |  19 +
 lib/toaster/toastergui/urls.py                     |   1 +
 lib/toaster/toastergui/views.py                    | 708 +++++++++++++++------
 11 files changed, 1755 insertions(+), 350 deletions(-)
 create mode 100644 lib/toaster/toastergui/static/js/layerdetails.js
 create mode 100644 lib/toaster/toastergui/templates/managed_builds.html
 create mode 100644 lib/toaster/toastergui/templates/managed_mrb_section.html

-- 
1.9.1


