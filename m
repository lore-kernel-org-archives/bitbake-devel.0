Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com [74.125.82.44])
	by mail.openembedded.org (Postfix) with ESMTP id 731E3606A8
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 May 2016 23:01:59 +0000 (UTC)
Received: by mail-wm0-f44.google.com with SMTP id g17so211542354wme.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 May 2016 16:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=DJs//4qJXcPbK3ipWBK/ZC3248xz5XheCaatBoaXz9c=;
	b=tqFJ52Hq/+UdK5GVmx2s4hYhv7IaELDNyujgj8lQTla+N7o/8tOs3OznF1v6hHOJBe
	+3dXssZsPKAFVhyrEp3HmuBzP969WnyFEwV6YxzYeONEzOxlPu0+avpIWd22aXQAr35l
	K7BGX7j88je2Bc2PeJukmM1qTrZ6uUvAZAkjoCkahLeNSlS7FJy2XGJAV62WH7C3QHTN
	DvtojhLhoq8sJNCoqAKPukxA1mT0+L6083Yac7QDizGjLX0P8QV+YMjWmtJnjvbRdlk6
	w6Qcndia/9/k59qO3ND76P2IHtAj/rY+35R1DZemOkrXngO6WOPE5+r1VMcEFp9GtxLv
	6AWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=DJs//4qJXcPbK3ipWBK/ZC3248xz5XheCaatBoaXz9c=;
	b=Jmaof5lOV99B9JqESuH1ZrlxBOoRumCUrpTfheqkIuzt7tR9cGm8SRvhXhKyThCPR5
	jn/SvGg39aKtTshmD+JcYR7k6dbsXyS0cdu3Hc29nIOd14r1vnWi8+pDBQrifgNJnaeE
	ZVPyYgRGwACDqJeTVwwaWGvm5JcgAPF1AFectdcobVQWDJdQTgmErPgw8pNZn7vQOrep
	0OgvozjyjjWHV6/jtj2ALaPwq1nlDMLoxsBWvlr9cFZYGfxlBw924zoqIw5jTnckjrph
	1YvMm1BuBZvdY5u6414AcK+WISv18clh7euRtW8kKOUQOtsgbc5fi2FYESfNbQJCU4TH
	8f4g==
X-Gm-Message-State: AOPr4FW77TckBFuH6NjMB7evtO9UNS+uZkRAVwALzF71mFuneUP+7mZe1lMQUBfemKtznov5
X-Received: by 10.28.175.143 with SMTP id y137mr12996823wme.21.1462834919414; 
	Mon, 09 May 2016 16:01:59 -0700 (PDT)
Received: from orion.home (host109-151-244-175.range109-151.btcentralplus.com.
	[109.151.244.175]) by smtp.gmail.com with ESMTPSA id
	b22sm27111436wmb.9.2016.05.09.16.01.58
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 09 May 2016 16:01:58 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 May 2016 00:01:47 +0100
Message-Id: <1462834912-23449-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 0/5] Validate unique project names
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
X-List-Received-Date: Mon, 09 May 2016 23:02:00 -0000

Patch series to add the unique project name validation at project creation and editing.
Add selenium unit tests to cover the validation on new project creation page.

Michael Wood (2):
  toaster: models Add missing import sys
  toaster: tests browser Add test for creating a project

Sujith H (3):
  toaster: projectNameValidation API added
  toaster: ui handles duplicate project name in new project page
  toaster: ui handles duplicate project name in project page

 lib/toaster/orm/models.py                          |   1 +
 lib/toaster/tests/browser/test_new_project_page.py | 109 +++++++++++++++++++++
 lib/toaster/toastergui/static/js/libtoaster.js     |  62 ++++++++++++
 lib/toaster/toastergui/static/js/projecttopbar.js  |   7 ++
 lib/toaster/toastergui/templates/newproject.html   |  12 ++-
 .../toastergui/templates/projecttopbar.html        |   3 +-
 6 files changed, 191 insertions(+), 3 deletions(-)
 create mode 100644 lib/toaster/tests/browser/test_new_project_page.py

-- 
2.7.4


