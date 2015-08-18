Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f51.google.com (mail-pa0-f51.google.com
	[209.85.220.51])
	by mail.openembedded.org (Postfix) with ESMTP id 485CB7689C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 22:32:17 +0000 (UTC)
Received: by pawq9 with SMTP id q9so44850042paw.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 15:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=I445yJBMM0q9C1ndWijr6WglnJAdVEHRty7H0ofR7bk=;
	b=xfDc0aLQbWvOTH84sEgqQHzR2yIddvmWKzf5EXYAfThD8n9rVBhD7eGncqEVcdCLm9
	1qqK5hMMQE0fijTwcBxgPP0PW5ApbGFBkmNyZ7u349WTetzSoR3Cjrgo/iPRWLO/qDC6
	yZjZP19bMtXtkI+x3aEqsXxk8OYUQHje501TlnHcWi7tfEFCp9YdjIJgElqxYHXoSkfe
	mh/Clvp6vl10pBkGD1SqlNlB+r7lUcYG4Z9znbdW1tfy5gfEDt5Q/WNuxFRRwJH9755X
	b4ivv9GMqV/PLyEa5fSAxgmKOOmH1mKs2uegN9TD6q7eeW14wkLdRrS3rfgfZ9UMc2Yk
	kOxA==
X-Received: by 10.68.198.37 with SMTP id iz5mr17736743pbc.129.1439937137675;
	Tue, 18 Aug 2015 15:32:17 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	mc1sm8765659pdb.14.2015.08.18.15.32.16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 18 Aug 2015 15:32:16 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Aug 2015 15:32:42 -0700
Message-Id: <cover.1439937065.git.avery.brian@gmail.com>
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
X-List-Received-Date: Tue, 18 Aug 2015 22:32:18 -0000

Simple addition of cross site request forgery protection to base page so it is inherited everywhere.

The following changes since commit c348fa50186fb0796bc7b793c4b8d710419f2a0d:

  bitbake: toaster: move code from setup_lv_tests to setUp (2015-08-17 14:41:45 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/michaelw/20150817_csrf_added_base
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/michaelw/20150817_csrf_added_base

Michael Wood (1):
  toastergui: Call csrf function in all pages to ensure cookie is sent

 lib/toaster/toastergui/templates/base.html | 1 +
 1 file changed, 1 insertion(+)

-- 
1.9.1


