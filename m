Return-Path: <ulfalizer@gmail.com>
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com [74.125.82.54])
	by mail.openembedded.org (Postfix) with ESMTP id 38C627720B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Sep 2016 22:33:39 +0000 (UTC)
Received: by mail-wm0-f54.google.com with SMTP id 1so170117329wmz.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Sep 2016 15:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=sVPWqUNSGdOcJGrRymof4KkwDgwTTkL0f2kk5Xfp+l8=;
	b=c/OG9f+GfOB4pfAdnaKeEGA3QwALbyI/dBOiwN4X1GxOuEDbmJL96o13oj6R3dPDl9
	/VUEGvFboWZuWqgzIcq4KoXBeC6f1b7f3ndnEJUes9pEz5cwsj0HTqJx5Y1vf46X7rvL
	kpizQtJoFUTdiLJDPFHFI2BNpDMttoNn0FOMPSGX0eZDkDimikGhjk7Z7OVmQK97Jn8m
	5bi3zNbbR4bhqSRUWncMco8ttKDp5TrD9BYVVBLOcuhvtASy1o5PsLY9cRqe1OMvw1fE
	IGWLMggNyPsf8DH2WEYZ7hzuXEZe5yZc1/BXWg0fBEiKmCvTgAOM37kOStFNgW3Mfy2q
	3YLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=sVPWqUNSGdOcJGrRymof4KkwDgwTTkL0f2kk5Xfp+l8=;
	b=UW4XRnpMp8VpKPU7cwRyA58JN+KWMuCpzdue8JfrBm2uggGsB7UBaTkx/CekJiW5Sm
	gXex7MMD+D15PEcx25h3P68xqE3+vsHm/C2YbUQneOi5sO5PNTZSHTKsFohlRLT6eYZk
	2OD+xTwPFCXjg7ztOCwwISIKXaWrNxnPNJPTDSqt7bUeBnXuyJVkyD4WWfNNHX+7eNnN
	l9qw/CyxMAwb1dqySsPq53VtOiKRDWN3WooJGGDPxtBtIy54PToo36KQmVxTBCv7Ghaf
	0w/ZAhYwFc31j7TxeO0znefA+Ike5cNCQeB4+Af01HMbIK/KfOaL0vJfOZmtPidLPJ1N
	MpKw==
X-Gm-Message-State: AE9vXwOWRehGb/Df9tnUzgmlefMe1KeQnWXswfbK4qr1XKUhY5wGSJDxst4FtxnN8dB8lg==
X-Received: by 10.194.235.166 with SMTP id un6mr16477821wjc.169.1473719619761; 
	Mon, 12 Sep 2016 15:33:39 -0700 (PDT)
Received: from huvuddator.home (ip5f5bfeac.dynamic.kabel-deutschland.de.
	[95.91.254.172]) by smtp.gmail.com with ESMTPSA id
	j10sm4428858wjy.13.2016.09.12.15.33.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 12 Sep 2016 15:33:39 -0700 (PDT)
From: Ulf Magnusson <ulfalizer@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Sep 2016 00:33:31 +0200
Message-Id: <1473719612-1200-1-git-send-email-ulfalizer@gmail.com>
X-Mailer: git-send-email 2.5.0
Subject: [PATCH v3 0/1] Make SRCREV_FORMAT name substitution safer
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
X-List-Received-Date: Mon, 12 Sep 2016 22:33:41 -0000

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


