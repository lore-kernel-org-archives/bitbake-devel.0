Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id 05AAE608B7
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Oct 2015 16:26:02 +0000 (UTC)
Received: by wicll6 with SMTP id ll6so168309404wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Oct 2015 09:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel_com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=OXi7z/wYCZjnnwLJYdI3ykz6bDCPSzvm2QdjmQuDAFI=;
	b=OI2xQlL+8x2SHKS/Hguud3KqQlslbUFtWmTgL0cJQOqeanZyH9Eskv+hWmknsRS2MV
	2GwgLK/NnKYQjVivHqt7M4CcpeTm+ZlWLoo2WzqTM55weuWsdzcHINfdl2nqRkx04dx+
	YffodxHlXIq8hY9ImHRua6yltewseyUGXj6+GgXECBWp4CfbZ1VmjoYdWVTN/lAhhznU
	GvqdcqrmMNbQpiQMd8SM5BW7z3i9XHOcrzYzMZsoQOm9cLCJhBPSjeB4J3D1D5IJYMQf
	kIM3ZAJmgXLncsSDZbFRoYGyeQpkk3sn7uKEGmO5RT6FDRELKRs8CgAXykfefK1dB1qo
	Kedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=OXi7z/wYCZjnnwLJYdI3ykz6bDCPSzvm2QdjmQuDAFI=;
	b=LUeSkltIUVQ3yziRm1R5VmOJSTj4ITvs5LfS9+8EhrJkkoDbkMiEXo3d1XGXd9kMbS
	tHIpHu3FksvfeRMcGJPrfIcJ314VdlF7H+i4+dkZK6yLh3DCwC9AiTwE7wdgChtymTEU
	dpNlchuMv9L8/yparj/rl6XUmwjNZCnLBX6cCQdnpbFFMXplHDE4///wLVRnKamyMqdD
	EYu0cHK3VwMksnMYUyKR4LV8YmMTP9KeyC9lLKqaknAn7YYU0lgaXd8Fz/2+kg1uHSL9
	FFpt6Qb5L3VSNCU+kbcNw24p23wv5jufi3LQMt46BNX0NHGCAulvLqq2P2aybmJO6W6/
	+dRQ==
X-Gm-Message-State: ALoCoQlG7oL5x9haF35PyzhDFHnipPLS0abSg47dtzPXenEqZiGlj5zfNkcV2xyM31xs8H/67nWW
X-Received: by 10.180.205.145 with SMTP id lg17mr29082752wic.67.1445963161816; 
	Tue, 27 Oct 2015 09:26:01 -0700 (PDT)
Received: from dorado.Home ([2.120.70.166])
	by smtp.gmail.com with ESMTPSA id fp6sm6779267wib.9.2015.10.27.09.26.00
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 27 Oct 2015 09:26:01 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Oct 2015 16:25:55 +0000
Message-Id: <1445963156-18084-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] Toaster logging issue
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
X-List-Received-Date: Tue, 27 Oct 2015 16:26:03 -0000

See discussion in thread Re: [bitbake-devel] [PATCH] cooker: Ensure BB_CONSOLE remains correct over server resets

Elliot Smith (1):
  toasterui: Create per-build logs

 lib/bb/ui/buildinfohelper.py |   8 ++--
 lib/bb/ui/toasterui.py       | 105 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 84 insertions(+), 29 deletions(-)

-- 
2.1.4


