Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f51.google.com (mail-it0-f51.google.com
	[209.85.214.51])
	by mail.openembedded.org (Postfix) with ESMTP id 3708E60107
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  6 Jan 2017 09:50:59 +0000 (UTC)
Received: by mail-it0-f51.google.com with SMTP id c20so10249353itb.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 06 Jan 2017 01:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=T7eWoKZhJ4fZajT9TPi8TzTz9nakU9KES7ZD9lDqamw=;
	b=Wj6JheAM3k+XuJgdh4XPAY1f9YpJpOpNeONUlYWaX3Q6aoWnJaDp+qw842RDCLdaNT
	TSj17hEWkxTjKs0Kq8+QaOCH2oF1ydoa5G7C+KgYXUv/itlsuswhkQfw1XfNzeUwwAxK
	B7JITHYO6sCzs6CYZkTXgY/vmHahE8WnHGzBKPWkWhCHWVz4NUScrajTa4APIX04Ln39
	/4QQb2FYB4qW3dTPCH7zdoKrfIlV1/m2LfeOsDBJasVPCbYUANmqcKdUof1mC17GCkEc
	jYYaQ0yG8THTeTZWnP451TJCbGOT/uKyW6r802LhGtXKN+u93DYvaTjenxrLkgdWD+Do
	A4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=T7eWoKZhJ4fZajT9TPi8TzTz9nakU9KES7ZD9lDqamw=;
	b=LDsAFt8Ca3H/gv9lExTqzy7oMyuUFRuaB/2qoRNiCAYtnrwVr34oEUodUIEyjxqXIp
	ewM6CKz+BcXt7HDECeWwdoROxif4xsUU/tZrfOX+Ge1JGW0zd6Zs2WfByzfb99T8lchB
	Lqtqlj1634tUkv/a5tC4CqTyDG9GaD3124godxy4X0Ru+8S30/AWCy+pjAXUYRK5e6UY
	MGr4gM2GGhw21yQ5dl0fR7jiO1RrMmLN+WXr890qB44rFi5vLUpwJdAC9vfvlu1vbbWg
	dRJgTu1sOcJvoMB+8hTzWZ5rfuahvZ0f0txVdEokBCrxAySifjUySkVZyLIreB8QpF0j
	nHpQ==
X-Gm-Message-State: AIkVDXIahOnNr0XJMLahJI2lK9orM+1nk8pGjOaAO5UttbDaON9cZRvjjjZLPQcv1xiwr47L
X-Received: by 10.36.207.5 with SMTP id y5mr1664857itf.15.1483696259584;
	Fri, 06 Jan 2017 01:50:59 -0800 (PST)
Received: from pohly-desktop.fritz.box (p5DE8F5BD.dip0.t-ipconnect.de.
	[93.232.245.189]) by smtp.gmail.com with ESMTPSA id
	w192sm1171819itw.3.2017.01.06.01.50.57
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 06 Jan 2017 01:50:58 -0800 (PST)
From: Patrick Ohly <patrick.ohly@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Jan 2017 10:50:46 +0100
Message-Id: <cover.1483696010.git.patrick.ohly@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 0/3] rm_work enhancements
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
X-List-Received-Date: Fri, 06 Jan 2017 09:51:00 -0000

This is the bitbake side of the rm_work.bbclass enhancements. See the
OE-core "rm_work + pybootchart enhancements" mail thread for further
information.

Related-to: YOCTO #10584

The following changes since commit ae6045b84978940c365c95c33d6996359c3e299d:

  bb/cooker: BBCooker stops notifier at shutdown (2017-01-06 00:01:03 +0000)

are available in the git repository at:

  git://github.com/pohly/bitbake rmwork
  https://github.com/pohly/bitbake/tree/rmwork

Patrick Ohly (3):
  recipes: anonymous functions with priorities
  build.py: add preceedtask() API
  runqueue.py: alternative rm_work scheduler

 lib/bb/build.py      |  16 ++++++++
 lib/bb/data_smart.py |   3 ++
 lib/bb/parse/ast.py  |  19 +++++++--
 lib/bb/runqueue.py   | 107 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 142 insertions(+), 3 deletions(-)

-- 
2.1.4


