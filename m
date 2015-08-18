Return-Path: <avery.brian@gmail.com>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
	[209.85.192.172])
	by mail.openembedded.org (Postfix) with ESMTP id 636C47689C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 22:10:10 +0000 (UTC)
Received: by pdbmi9 with SMTP id mi9so32026185pdb.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 15:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=WOD7t6a08lkgt7BS90HK/HcogSvn2DucnY8D6S+joX0=;
	b=ZxNpwODMRyW6gN58CiRuQMqsCUx/3Lhh2o+2SK5rZAvt55pUu34fV1AHYh0A2me/c9
	k/R7RLmw2FY57GEhje44A9np/jns7Tl9uEZq8luIzdjR7/0hXkFbPYOUWI0MFmD27nkH
	PlRPAbDylRg4i0Xb635/5Qa8gMrgW7NZy9VtlacOaCzw7pD5Srv53O+jfqpKZwtQNv5P
	U1NxqYxVRvtWd1MqSQG93rdplORdbhf4c1lpyrlc85F0SsJ2qK+FxM6m57mz71xiKd9u
	mXbg/2HkHridURrnnRPKPYlrzodPxKmvIXmrrlZemDl3n4KuBHqJSVvllkhf+zNxskM1
	0VzQ==
X-Received: by 10.70.90.193 with SMTP id by1mr17696281pdb.80.1439935811291;
	Tue, 18 Aug 2015 15:10:11 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id 2sm19225825pdp.68.2015.08.18.15.10.10
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 18 Aug 2015 15:10:10 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Aug 2015 15:10:18 -0700
Message-Id: <cover.1439935538.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/1] Call csrf function in all pages to ensure cookie is sent
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
X-List-Received-Date: Tue, 18 Aug 2015 22:10:11 -0000

Simple addition of cross site request forgery protection to base page so it is inherited everywhere.

The following changes since commit c348fa50186fb0796bc7b793c4b8d710419f2a0d:

  bitbake: toaster: move code from setup_lv_tests to setUp (2015-08-17 14:41:45 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/michaelw/20150817_csrf_added_base
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/michaelw/20150817_csrf_added_base

Michael Wood (1):
  bitbake: toastergui: Call csrf function in all pages to ensure cookie
    is sent

 lib/toaster/toastergui/templates/base.html | 1 +
 1 file changed, 1 insertion(+)

-- 
1.9.1


