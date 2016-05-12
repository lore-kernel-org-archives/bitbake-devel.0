Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
	by mail.openembedded.org (Postfix) with ESMTP id 822306FF84
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 14:10:44 +0000 (UTC)
Received: by mail-wm0-f53.google.com with SMTP id n129so261216980wmn.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 07:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=R3Zmp45NDVMkPhUiBXOrDyNAoZV+N1t2V38eqwvmbt8=;
	b=kzg+XxTvEG7pgyvJkLQSB6561RpFcTYSSrc1dB5A8EGRztMcRNHN0SJp70eMmYMKXp
	cWCCvobmTYv7Z6g9bOAqqqQvtnfZB/wry/1DAIO5BXERc3zr3XxSd3nhCNVl8qJjP4Pz
	ArVSYQv9rt1neHj/NDPVKdeamSEDRWWIXpEgHxa4RpAV7MIsxB2XLa7YX3lJwKatx6oI
	SHBnQaRhQ3+pc0CI+VE3G4O8Py8e424TJsqUeREhg9CfRL/nEWGKF0N9bk3Ri6VNEUt4
	QUPrOrygJNRrRCKHI3wTlKhkh3RzCyFQOp7b0kNgZ3DSKfI8L5fPeA4S5CsoBbuIibir
	/xCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=R3Zmp45NDVMkPhUiBXOrDyNAoZV+N1t2V38eqwvmbt8=;
	b=CSa/iijcCHwji20g4GIVv+kHx+Or62Lc1p7xL9J2tp3TAwqjsOOsNfdXc6CV8h+pIY
	g9nSUnPRGqO75v/Bkz2u22NPezOPqrnSouVLG4SUDDJiRMte+u4d1VTYKW4Ws/HOP033
	xpJXSADttPqDAQpI9Xf1hiZ+lcEMmI2Ft8jq4lx3NCJXgXOOqOZQklDoreoWVHDvEq2k
	pjpf0kVcvLbuZX1PPkMd2GdXjvSM/qyMgprIB1Rqng70iSSDTDZrl1xeoTknbS71TKXi
	Ug5A0x1K+0imuXEpxfiyTPzYHJT1yy38EgPPHHC4v0NZv4WnjFUDU2kwuzbzbpz61IOt
	/+AA==
X-Gm-Message-State: AOPr4FVeuiDM9wpS1A7qhT97JDnR05x9fQQgxt3qayvLpF/D41p4k6aEBYHzcuLthjlwdcv0
X-Received: by 10.28.178.129 with SMTP id b123mr6836264wmf.2.1463062245099;
	Thu, 12 May 2016 07:10:45 -0700 (PDT)
Received: from orion.icx.intel.com ([83.217.123.106])
	by smtp.gmail.com with ESMTPSA id u4sm13653360wjz.4.2016.05.12.07.10.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 12 May 2016 07:10:44 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 May 2016 15:10:35 +0100
Message-Id: <1463062238-12007-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 0/3] Cancel toaster builds when cli is interrupted
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
X-List-Received-Date: Thu, 12 May 2016 14:10:46 -0000

If a bitbake build is running on the command line and is interrupted (e.g. by
Ctrl-c), capture the interrupt and shut down the bitbake server. Also set
the outcome to CANCELLED so the build displays correctly in the Toaster UI.

Elliot Smith (3):
  buildinfohelper: add method to set current build as CANCELLED
  toasterui: capture keyboard interrupts the same way as knotty
  toaster: don't show "Rebuild" button for cancelled cli builds

 lib/bb/ui/buildinfohelper.py                      | 10 +++++++++
 lib/bb/ui/toasterui.py                            | 17 ++++++++++++++-
 lib/toaster/toastergui/templates/mrb_section.html | 25 +++++++++++++----------
 3 files changed, 40 insertions(+), 12 deletions(-)

-- 
2.7.4


