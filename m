Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f43.google.com (mail-wg0-f43.google.com [74.125.82.43])
	by mail.openembedded.org (Postfix) with ESMTP id 83AA871637
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Feb 2015 10:54:40 +0000 (UTC)
Received: by wghl2 with SMTP id l2so9445857wgh.9
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 26 Feb 2015 02:54:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=HbOeLuE8+YLQJVqWLp9U8LTuxVlUvIull7+Pv8poX8c=;
	b=VPrOvG2hZzEj0098UrOT+bmYz25lI0rY/w+aoYiG4uNCL2BSCAqEPojKY2ihwcVmfI
	Ya8FGAQOzG51PfyYAxgxo5ogxK8R3KBLymSCbifHkeV0QhQ70lkZgySVTsjoP7brnd2G
	NGOaZEIHLFc2EAHY9T8oFTSyPPBbXN0iV/6c/Ory1DTaS+Briek2ahgHFHGrkUigSs//
	3in7yk6E7TRYFOcQ1jZSA+gPMS85xarsErcp3F7G8Afs4LGlQdTWCLCpPhXxDgVbD/AP
	qWdnrYlgIPlGN3SQYpATOOHo/ybrlyu+zs5UT3L2GE697fIfIuwNWLqLa9tu3yivKQ9c
	9Vxw==
X-Gm-Message-State: ALoCoQkdy+6tGnUI0eqZJyYj7YDy4XmXh40xnQHcg+ocBlndWkrB23kQ7JoM6qr7w37l6/nl3r5+
X-Received: by 10.194.71.98 with SMTP id t2mr15737340wju.72.1424948081813;
	Thu, 26 Feb 2015 02:54:41 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id hv5sm829270wjb.16.2015.02.26.02.54.38
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 26 Feb 2015 02:54:40 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id CC901561608; Tue, 24 Feb 2015 17:20:53 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Feb 2015 17:20:52 +0000
Message-Id: <cover.1424798369.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 00/12] Toaster fixes patchset
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
X-List-Received-Date: Thu, 26 Feb 2015 10:54:43 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

This is a patchset with fixes for the Toaster graphical user interface.

The patches have been reviewed and tested on the toaster mailinglist.

Can you please pull at your convenience ?

Cheers,
Alex


The following changes since commit 4b8fcf9a5bc802793bf332334217faace55f14f6:

  bitbake-layers: add ability to fetch layers and their dependencies from layer index (2015-02-20 18:00:34 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150224-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150224-submission-bb

Alexandru DAMIAN (2):
  toasterui: disable autocommit for build logging
  toasterui: fix ETA calculation

Alexandru Damian (2):
  toaster: update requirement for Django 1.6
  toastergui: performance improvements in task details page

Belen Barros Pena (4):
  toastergui: fix spacing and input field sizes
  toasterui: style the Toaster version information
  toasterui: improving the latest builds consistency
  toaster: fix typo in models.py

Michael Wood (4):
  toaster: layerdetails summary/descriptions to be searchable
  toaster: layerdetails Add link to machines file
  toaster: layerdetails Fix pagination controls
  toaster: Add machine selection notification

 bin/toaster                                        |  4 +-
 lib/bb/ui/buildinfohelper.py                       | 11 +++
 lib/toaster/orm/models.py                          | 24 +++++-
 lib/toaster/toastergui/static/css/default.css      | 10 ++-
 lib/toaster/toastergui/static/js/layerdetails.js   |  2 +-
 lib/toaster/toastergui/static/js/libtoaster.js     |  3 +
 lib/toaster/toastergui/static/js/machines.js       |  3 +-
 lib/toaster/toastergui/static/js/projectapp.js     |  9 +++
 lib/toaster/toastergui/templates/base.html         |  2 +-
 lib/toaster/toastergui/templates/importlayer.html  |  4 +-
 lib/toaster/toastergui/templates/layerdetails.html | 13 +++-
 .../toastergui/templates/managed_mrb_section.html  | 27 ++++---
 lib/toaster/toastergui/templates/project.html      | 10 +--
 lib/toaster/toastergui/views.py                    | 85 ++++++++++------------
 lib/toaster/toastermain/settings.py                |  4 +-
 15 files changed, 132 insertions(+), 79 deletions(-)

-- 
1.9.1


