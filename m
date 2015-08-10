Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id 358B7768B5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 17:26:49 +0000 (UTC)
Received: by wicne3 with SMTP id ne3so144890862wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Aug 2015 10:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=Adn2Pf8KU0VoY7iwa/dX8yt+Uf9cAMxwikHenTN9X9Y=;
	b=SNgyb9hsZkumtvevLpt71VohZ83qTW7JIEUYmELws86ptwO6q/s711WCAcA7HZda+c
	wL0LuF+xM2XhWOxUvaynNBFZrT6xLEoH6KLqy7BGvBvRjMOsPesE9lRClF68QQG9a+LL
	CW5DeBLwxkDAKeDQkXHrNFXelVUrLMJ4sLJvB1FfKzHeOeXi6F0xsEACCCv6UlbKt4Yo
	UmnPdyNLg1OPBz/PvKaktLMMbZlB+/x77A6AiYYiOqbeNZenY8E+C+GBBvcdKB6hbW0S
	ffW9MJ5o0+BIYGqACjwx1Jf8qB5gOWj+pTjhYEJRKqtPNYU35c6tciHC3TUpLlobSJZ+
	2T3Q==
X-Gm-Message-State: ALoCoQleiIWEsPAoHUjXUCDbPiRHYB/0zwr1LJvLtJNYXOu6Yudo2oRNEwIqylP+C3U8+m9e43l2
X-Received: by 10.180.107.34 with SMTP id gz2mr27187098wib.77.1439227609264;
	Mon, 10 Aug 2015 10:26:49 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	di7sm14760408wib.23.2015.08.10.10.26.48
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 10 Aug 2015 10:26:48 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 10 Aug 2015 18:26:41 +0100
Message-Id: <cover.1439226591.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 00/11] Fixes and clean ups for toastergui unit tests
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
X-List-Received-Date: Mon, 10 Aug 2015 17:26:53 -0000

This patchset contains fixes and code cleanups for Toaster GUI tests.
Reviewed by Michael Wood.

The following changes since commit c75cefe8a382a63f625123c156137782db118f64:

  libpam: Fix patch broken during upgrade (2015-08-09 15:15:33 -0700)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib michaelw/toaster/submit/ed/toaster/fix-toastergui-tests
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=michaelw/toaster/submit/ed/toaster/fix-toastergui-tests

Ed Bartosh (11):
  toaster: fix test_get_json_call_returns_json test
  toaster: wrap long lines
  toaster: get rid of AllProjectsViewTestCase
  toaster: put all test cases into one class
  toaster: get rid of class attributes
  toaster: remove unused import
  toaster: add header and docstings
  toaster: don't catch json.load exceptions
  toaster: fix test_get_json_call_returns_json again
  toaster: fix pylint warning 'no space allowed'
  toaster: reduced amount of instance attributes

 lib/toaster/toastergui/tests.py | 133 +++++++++++++++++++++++-----------------
 1 file changed, 78 insertions(+), 55 deletions(-)

-- 
2.1.4


