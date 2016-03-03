Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f68.google.com (mail-pa0-f68.google.com
	[209.85.220.68])
	by mail.openembedded.org (Postfix) with ESMTP id BB94D602D9
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Mar 2016 05:20:38 +0000 (UTC)
Received: by mail-pa0-f68.google.com with SMTP id a7so672953pax.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Mar 2016 21:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=qM8WW8luoWy5h1WJFCmBbE5zu3v0SriB+DfgO1vftUk=;
	b=VUYb4A+w7p+xoujXzue4ZhVXvENW824EigbEzKOXJQTYM/jhKyaHb3jU6V0oSONitY
	TFioTZMDtNzSH6eqNdO8JgrSutY5n+FLghm++MnmdiGs5GB2oaMe/cUY80fZ6l9OpQbF
	PB+EgCXUmeRdfoJ8KUlSXGzvvYnusbhG6UD8IHGpEJTNGcpsWn5dRwNwdlBhP8gMkRam
	5OsCKOeW+fJwj5L08W/eSAbxkRJ2Kkd2f0uDwo7htcAXbk+a2l6bPNin5lArpjbFkks9
	BqIKJYdyxX2Vu5Vz0gSROOwBLrzg3mVnea8F5wgkHBTCIZiFa9fICPZtpr0HHFCD9OZt
	jxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=qM8WW8luoWy5h1WJFCmBbE5zu3v0SriB+DfgO1vftUk=;
	b=DlR8ROwtx3TfSISZ91n/WRuktYbEFJ74MwDMLRXip5AxK6JuDR9zkLeqaCoJ9rcWA9
	Rji/xhog28iIfgYU48v6aAZihOFRvIrgbpBaY4TBANRd/e05Y4CjxNTLdUTEMau/s2iq
	BeiFHRM3y7aBzauqOpFQoNVEMMdbx5hmEMTECFQNsHdrN+Zdur0oWO0ykMc994yvMiGg
	RMvK94OCvtVlQy3CPCQLHneNzr3PQ0XoNmVjlmTkI84bfIfQJO79U2OW326ZAlHx0+0D
	dYEMRAQouqixksEuDFIr7YR4loukFKQwhUQDQ8J8RxVaCglV7eWmM4yqydcXszzG9yI4
	XqDw==
X-Gm-Message-State: AD7BkJIm6vNRPA9BAXJLI0K+lr+4qQB5xZwEV+CQ2Gfj+vqdpZVi0CrocuBIRpdA+qEOPA==
X-Received: by 10.66.65.228 with SMTP id a4mr1082403pat.4.1456982439156;
	Wed, 02 Mar 2016 21:20:39 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	s197sm56825198pfs.62.2016.03.02.21.20.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Mar 2016 21:20:38 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Mar 2016 21:26:52 -0800
Message-Id: <cover.1456982682.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/3] toaster: remove ssh build controller
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
X-List-Received-Date: Thu, 03 Mar 2016 05:20:40 -0000

sshbecontroller code and tests have been broken for months. Its functionality(running
builds on remote machine) can be achieved by simply running manage.py runbuilds
on the remote machine. There is no need to keep it in the codebase.

This change would also make refactoring of buildcontroller code
[YOCTO #8806] easier.

-bavery

The following changes since commit ed3decf958ff7fd09da3ca931808bb68e7915971:

  toaster: update the meta-yocto toaster configuration file (2016-03-02 20:30:17 -0800)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/ed/2016-03-03_remove-ssh-controller
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/ed/2016-03-03_remove-ssh-controller

Ed Bartosh (3):
  toaster: raise NotImplementedError
  toaster: don't use sshbecontroller
  toaster: remove sshbecontroller module

 lib/toaster/bldcontrol/bbcontroller.py             |  16 +-
 .../migrations/0002_auto_20160120_1250.py          |  19 +++
 lib/toaster/bldcontrol/models.py                   |  10 +-
 lib/toaster/bldcontrol/sshbecontroller.py          | 169 ---------------------
 lib/toaster/bldcontrol/tests.py                    |  30 +---
 5 files changed, 32 insertions(+), 212 deletions(-)
 create mode 100644 bitbake/lib/toaster/bldcontrol/migrations/0002_auto_20160120_1250.py
 delete mode 100644 bitbake/lib/toaster/bldcontrol/sshbecontroller.py

--
1.9.1

