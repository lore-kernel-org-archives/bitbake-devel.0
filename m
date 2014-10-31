Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
	[209.85.212.177])
	by mail.openembedded.org (Postfix) with ESMTP id 7E99C706B3
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Nov 2014 10:27:28 +0000 (UTC)
Received: by mail-wi0-f177.google.com with SMTP id ex7so5922927wid.16
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 03 Nov 2014 02:27:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=kcUpYptvI8X9BxVDxttmNzy0zsikEXUVb6FGNMHWIKw=;
	b=TSha6Slkgc2CPLInoRTncrhhAErJRuT4uUd50Fs9dTS8TfieT4kpRp7RftJbNC4PTn
	3mv3P5L7R2br7FcqGJ+AbSEvUzuhn64T10pE/U/RZkeEP43LCEesMTHCU+JifHtjkkr/
	BpxVDmySOgM9x0f3o9Z5/WzswnZ7JecxHEqxOAKkrIoJXcgfY5fv5muImkx8OvFAdUqK
	zEHPJvcMRi9DYFmi+aiKHnbbhtgmWhkljzuifEl3mgvZmJp6FJLTjX99J+cwj9mouJY7
	C1yCJmNRtBN/70EuipAgkjTb5a19Ufpozt+4ae0GZ4dIeGP8BSJYU4lctrHtAtmGelJk
	1QgA==
X-Gm-Message-State: ALoCoQnqxwkEKvfNWQW9ccK14Tap8XqpzO5ORWwB4XDoM/s0p45vgmkPYYb8Y/w/bVEi8dRies6v
X-Received: by 10.180.219.106 with SMTP id pn10mr15396360wic.63.1415010448921; 
	Mon, 03 Nov 2014 02:27:28 -0800 (PST)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id f1sm5771043wiy.17.2014.11.03.02.27.26
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Nov 2014 02:27:26 -0800 (PST)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 25A54560E98; Fri, 31 Oct 2014 19:16:55 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Oct 2014 19:16:54 +0000
Message-Id: <cover.1414779051.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 0/2] Patches fixing bugs in 1.6 mode
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
X-List-Received-Date: Mon, 03 Nov 2014 10:27:30 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

These patches fix issues related to 1.6 toaster running mode, in regards
to data collection, and displaying pages that have 1.7-mode content in them
(currently causing the UI to be innacessible).

Can you please pull in sync with the toaster.bbclass patch

	toaster.bbclass: read elapsed time from the stats file

Thank you,
Alex

The following changes since commit 26d601ab2a677a422bab425696a2cf6357ff3576:

  bitbake: clarify startup message (2014-10-30 13:39:37 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20141031-bb-submission
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20141031-bb-submission

Alexandru DAMIAN (2):
  toasterui: improvements in data reading
  toastergui: fix invalid build url usage

 lib/bb/ui/buildinfohelper.py                      | 22 +++++++++++++---------
 lib/bb/ui/toasterui.py                            |  6 ++++--
 lib/toaster/toastergui/templates/mrb_section.html | 10 +++++-----
 3 files changed, 22 insertions(+), 16 deletions(-)

-- 
1.9.1


