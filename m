Return-Path: <harshjain32@gmail.com>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id 6DF2560809
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Sep 2014 18:31:31 +0000 (UTC)
Received: by mail-wg0-f42.google.com with SMTP id a1so119434wgh.13
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Sep 2014 11:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:date:message-id:subject:from:to:content-type;
	bh=+IWX2l4U44Ad3Yn1EKHUAiP0kSV8sZCP4Rgm1GP55uA=;
	b=RxDT9O2bkkYZPGY06W64rnMSBMlLRvqD9dRkMIodgxwjJm8OkRYltPLnJUByzecpZe
	wCBoc+kzKFhzq5KwDfS/gGcbkUYL/w4vPGWfcykoGQbYUXpQZEaxM+sYNIU6iFgg08RL
	SxPAcr6mow30R4+MTTu4urKd2b+4qyblCdlCtZwxpUMHv9tVGQGldRRMtZc7OZ2n+PNA
	iQ6BNcD6wwjAKJDwa1DV3h7QHLexUmsfh8MjJvbzwCulUxMGX+8C5N2+Zqvx6DQFruX0
	LRcJS0PqMhA8hS1uc05i/r0NuTU1iCBJJBnL5VyiZErFD19R63UqAC+C7Hq5R9+Vf+Ic
	z2Yg==
MIME-Version: 1.0
X-Received: by 10.180.212.78 with SMTP id ni14mr121685wic.44.1411151491946;
	Fri, 19 Sep 2014 11:31:31 -0700 (PDT)
Received: by 10.216.96.11 with HTTP; Fri, 19 Sep 2014 11:31:31 -0700 (PDT)
Date: Sat, 20 Sep 2014 00:01:31 +0530
Message-ID: <CAKuL1XTTbrXNyoVyexg=BDN=jEO_nvnSJdg5kFsYzX8Bvf_1Jg@mail.gmail.com>
From: harsh jain <harshjain32@gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Update recipe file to avoid conflict with other dependant packages
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
X-List-Received-Date: Fri, 19 Sep 2014 18:31:39 -0000
Content-Type: text/plain; charset=UTF-8

I am trying to install python version 2.7.4 after updating recipe file
of version 2.7.3.There are several other packages in my build system
which depends upon Python version 2.7.3.When I try to make build these
dependant packages give warning.
What I needs to update in build environment so that these packages can
also included.I am assuming that these dependants packages are also
compatible with python verson 2.7.4.

