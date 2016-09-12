Return-Path: <ulfalizer@gmail.com>
Received: from mail-wm0-f52.google.com (mail-wm0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id 92B1A7720B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Sep 2016 22:40:43 +0000 (UTC)
Received: by mail-wm0-f52.google.com with SMTP id c131so82300320wmh.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Sep 2016 15:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=SS4nfTfOMXGr8y/gTUcf7vbFbX3lpBr1NkDeyXpZcDU=;
	b=ImoAei//Mzvls8lVm/SIbMgPVVpLpwHqAnHzMGIXJfNx2ixZ+emvnbjhA8jJfqfAoF
	6fRlxj0cbN7ybGmEJwOOABjNMDQJsEpFX4VeTI+uyce8TSPUBchgkPzL0Wt5U6eXhXzX
	awDVKDKpdyCYEUTNdnzkHRXZlIA5IgxZo+GE4RF9yTzgpxAHCXqpc5v5K+wwG+42O0p9
	+GHcDrvP3sspf28YDiq8UU8YvdO6AtKBv2hCOWOtrQH6erRNfEPkTecLmiN/EAQT6ori
	gjlnR45bMFcroQuZAPji+BvQONTtTbWXAg7qVNnWWt1SgHdbm8tjEcAtvBom/yHt3Yt4
	NA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=SS4nfTfOMXGr8y/gTUcf7vbFbX3lpBr1NkDeyXpZcDU=;
	b=LG8ya2+uAcX1SCRKhu6w8qFXPpek/rtP/7ul149OkF72zw7xL0cZVPMLs1MhdHQSz0
	bjpSyZLVlWiwPG4Dx9gPT7I3koAcmiLaSJfPxOK49ooqBUTUUhp6aLKdaKlF2slgUfAo
	uH8AUw1w22Al14bgfs5asGzlH98xxbX5kAflnh3YjhWOeKfbN71r+sO8mIkiAVHElkA2
	MQdmu9lZAlh6wbUPFqx8Ix/nzEF/AMzaozlbkxK0QzfJ5RvXcEIeYUx59O2Iy/vkrEdZ
	i25kV9ESgzEIwlRz+NivQ0qQPNNNxKXIByENNbJtBVXhtPc1QAKjgPK1xnQNIjfpMosG
	yizQ==
X-Gm-Message-State: AE9vXwOHSHxdVFdljXZRJSCLIkIU6HuqxddG62lX5NcpD1dBl8s2LIkvP4/SBFi+jE9UkQ==
X-Received: by 10.28.48.19 with SMTP id w19mr1900061wmw.54.1473720043543;
	Mon, 12 Sep 2016 15:40:43 -0700 (PDT)
Received: from huvuddator.home (ip5f5bfeac.dynamic.kabel-deutschland.de.
	[95.91.254.172])
	by smtp.gmail.com with ESMTPSA id o2sm19899989wjo.3.2016.09.12.15.40.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 12 Sep 2016 15:40:43 -0700 (PDT)
From: Ulf Magnusson <ulfalizer@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Sep 2016 00:40:36 +0200
Message-Id: <1473720037-1789-1-git-send-email-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.5.0
Subject: [PATCH v4 0/1] Make SRCREV_FORMAT name substitution safer
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
X-List-Received-Date: Mon, 12 Sep 2016 22:40:45 -0000

Changes since v3:

Replace "ascending" with "descending". Word fail.

Changes since v2:

Using re.compile() is a bit silly for a one-off regex. Use re.sub() directly
instead.

Changes since v1:

Fix the original patch to make it actually work, and broaden it to make the
substitution more robust in general by substituting all names at once.

Ulf Magnusson (1):
  bitbake: fetch2: Make SRCREV_FORMAT name substitution safer

 bitbake/lib/bb/fetch2/__init__.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

-- 
2.5.0


