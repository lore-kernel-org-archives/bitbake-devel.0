Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f175.google.com (mail-pf0-f175.google.com
	[209.85.192.175])
	by mail.openembedded.org (Postfix) with ESMTP id AD62573204
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Sep 2016 14:29:39 +0000 (UTC)
Received: by mail-pf0-f175.google.com with SMTP id w87so7235554pfk.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 05 Sep 2016 07:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=1V13JIsPA1dW3RC/yHwU0lupPQU5dWTG+zlA7HVX0Fc=;
	b=Beog58AU9WpEiAjRS0vT5X03qnGiifdde/kVjl0uXFtJaj7KowOCzZM0+HKGQ5PZ42
	osQqoe8BjzeqomFE5i5ftE6EgyDwPYFOS1L12X91UFT+R1kkqRzokhXmekOK16FYTJaQ
	2rUaEbU+jUe3Z38mOvpFmRVEPW9HWyCUzIsm9Z3SGHh71e/y39EViZTEeNsy4jQ/NjXQ
	Kc3Pp91hmlNRwOSb78vTsi5cBCcvbbMBWepwQiHq3RdA7T+gLtmQy1VHdt1W3fJCtAG6
	dhujIsLg/tVGHYwAYryQyL3M3wSc6QS//eMRV4fa8NFq5pd5+ibN8NFHnUXRYQC5lpL3
	NxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=1V13JIsPA1dW3RC/yHwU0lupPQU5dWTG+zlA7HVX0Fc=;
	b=M0s2B2p744YLpiW4JcgdVlzUKBnuq9E9uJw+1+pqVVYXliWHs9pJRJOsNVS3OVMe6k
	sq3jWcqV7MUyclijM/FVTSi0NQW8cmjXmBUIpSt1Zx/wLYNXOh6oz1zBhwsdGm0Lk+KT
	qnPvgQu13cd5F5f4PVomHJ50L1WqG67cck/whUkOghHc7SpLNpEaRtwP1g3T/F1C8uy7
	q58id4ThCMOaLZPwRT1ZcjtpIdRKOpaEEeRqHXA+EJdI+sGlBcxxf+vXUlWOVl7iRJdi
	bpMI8v4iKcO/MTDEJfelkk2rOtPNnODGrnbQ+l1W0TkYm6qcDFAoOyJ1SKVIZgmy9RnM
	sZ2Q==
X-Gm-Message-State: AE9vXwP9t7ViFU7cwgImyI2RU4juFjMtoYO2b6iMHWG/YGXOgNpw+rSgFQFsod57aOpElmBr
X-Received: by 10.98.153.1 with SMTP id d1mr6937577pfe.13.1473085780123;
	Mon, 05 Sep 2016 07:29:40 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr03-ext.fm.intel.com.
	[192.55.54.38]) by smtp.gmail.com with ESMTPSA id
	j21sm34058285pfj.75.2016.09.05.07.29.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 05 Sep 2016 07:29:39 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Sep 2016 15:29:21 +0100
Message-Id: <1473085772-17878-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 00/11] Toaster patches
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
X-List-Received-Date: Mon, 05 Sep 2016 14:29:44 -0000

Latest patches for bitbake reviewed on toaster mailing list:

Belen Barros Pena (7):
  toaster: tasks Remove recipe version from defaults
  toaster: configuration Provide machine help text
  toaster: layer details Layout fixes
  toaster: import layer Layout fixes
  toaster: layer details Fix "edit" form interaction
  toaster: Allow forward slash in variable names
  toaster: orm Update IMAGE_FSTYPES values

David Reyna (1):
  toaster: keep layer name in variable history path

Ed Bartosh (3):
  toaster: don't kill toaster on start
  toaster: remove handling of .toasterui.pid
  toaster: don't kill all runserver processes

 bin/toaster                                        | 15 ---------------
 lib/bb/ui/buildinfohelper.py                       |  3 ++-
 lib/toaster/orm/models.py                          |  7 ++++---
 lib/toaster/toastergui/buildtables.py              |  3 ++-
 lib/toaster/toastergui/static/css/default.css      | 10 +++++++++-
 lib/toaster/toastergui/static/js/layerdetails.js   |  8 ++++----
 lib/toaster/toastergui/templates/importlayer.html  | 12 +++++++-----
 lib/toaster/toastergui/templates/layerdetails.html |  7 +++----
 lib/toaster/toastergui/templates/project.html      |  5 +----
 lib/toaster/toastergui/templates/projectconf.html  |  6 +++---
 10 files changed, 35 insertions(+), 41 deletions(-)

-- 
2.7.4


