Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
	[209.85.220.50])
	by mail.openembedded.org (Postfix) with ESMTP id 3319573E20
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Aug 2015 19:01:27 +0000 (UTC)
Received: by pawq9 with SMTP id q9so34115442paw.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Aug 2015 12:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=vQwxU6IUCjU1MBG7uX074f/+2DdFSwfbIQVgbl6lmYw=;
	b=tC1O0w9bWia5xgN7tKN9KkGcOWwNHi8fywILaaEoQxuzq+8gorfTj8oxUR87Unnuod
	HrLAuAg4viuDS2rn/yuAS/M2S4POYCl3qQL1D2gXto1LTVTcMkOdnSRuYcJADY2PlXB+
	LMqqyCpSG33WxNksP9IZXcQHJ+fyqOulDHwdh60qWQTmU+XHz1g1dzbUQPoj1XwiI4jV
	iEglozMTW/OeM51RlmhbYAAWM58DGIpJhfyVFTh4YVaAnL546wpC8Gf+eMmefMmVlZTV
	BxbNhjdKcPSIj3aAWuq7G8+fcl5KTHpCA9r8ezjwz7iJlFwGy6P+i7igkBCcub3dJmTN
	qXHQ==
X-Received: by 10.68.98.131 with SMTP id ei3mr8996462pbb.113.1440097287716;
	Thu, 20 Aug 2015 12:01:27 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	nt6sm5167067pdb.73.2015.08.20.12.01.26
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 20 Aug 2015 12:01:27 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Aug 2015 12:01:53 -0700
Message-Id: <cover.1440096890.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/1] Use Jquery's Qunit tests to create some unit tests for javascript
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
X-List-Received-Date: Thu, 20 Aug 2015 19:01:30 -0000

Use Jquery's Qunit tests to create some unit tests for javascript.

The following changes since commit c348fa50186fb0796bc7b793c4b8d710419f2a0d:

  bitbake: toaster: move code from setup_lv_tests to setUp (2015-08-17 14:41:45 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/michaelw/20150817_qunit-tests
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/michaelw/20150817_qunit-tests

Michael Wood (1):
  toastergui: Add frontend javascript unit tests

 lib/toaster/toastergui/static/js/tests/test.js     | 175 +++++++++++++++++++++
 .../toastergui/templates/js-unit-tests.html        |  39 +++++
 lib/toaster/toastergui/urls.py                     |   3 +
 lib/toaster/toastergui/views.py                    |  16 ++
 4 files changed, 233 insertions(+)
 create mode 100644 bitbake/lib/toaster/toastergui/static/js/tests/test.js
 create mode 100644 bitbake/lib/toaster/toastergui/templates/js-unit-tests.html

-- 
1.9.1


