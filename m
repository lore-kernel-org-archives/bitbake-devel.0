Return-Path: <freesilicon@gmail.com>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
	by mail.openembedded.org (Postfix) with ESMTP id 1A77E784A2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Nov 2017 15:25:09 +0000 (UTC)
Received: by mail-wm0-f66.google.com with SMTP id z3so5782833wme.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Nov 2017 07:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=/Gsz0z1c5epyh6/coVp/XVxioR/lD5Wl141+2EBRWyQ=;
	b=NmxIg3Rcgv4XX8Y5piUUqQc2whH/YonyObJistt/FntSCCcLxEnpGigz/i//I8G4ji
	AsjUmqJ16J0QH8gN+5KiUzPGrAQM0ivOCXtLJldqgjSdttBZtcu4WXPwQGy+7ZAuVv00
	14n2GfvgeZsrze0TjlV6fdEq+bkxiiPlKEME+PhG/LVPfWzZJEQQQKut1HyOnNzvxRY0
	uH6lOr8phg/C2dhWG7vFgYNeaQfjKxVtq7EmKxIAzN12odekKXwDDS/N3JDvB8aNLTzW
	c44LvmxDNLCLH1ov7nvNNwPLNnZ6Kilk+uDGPNp1XtEtXEXoIqzFpmFyiIc7f8I2O3ll
	5qYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=/Gsz0z1c5epyh6/coVp/XVxioR/lD5Wl141+2EBRWyQ=;
	b=VSCBJ37I0LzE4hA8naECbYf7tyDe0vexX/nG0EzsHTvIHhkJiH1G4w1Vmv1oTSmBNN
	sRWYv+OcBHMiwY0sLIW0F0a6wS+8fIocPKmVv5K1bbFMAO0U3qPminMpmBCOv6g+q5H4
	a+sGwRAcrWu+VOuDS9d/YY6OMbAodoiXOh/90Mm+axDiSyAO0DCsrzCw0w8LcV/rzRfU
	k2DJ3TilehkYHjiVJ5pR4uyVmeU5WBp16Oz+NTLDxYRuJkhSXmJi0eQ2ssGAJkYlN/iP
	lGnNGm+04e+oAqUz0wD8KTrN+m7SyzD/Z9FZYxktfHdpzrka6ykl8XhTm09fsBikczKQ
	h2PA==
X-Gm-Message-State: AJaThX6cRjGuvggRtqByO4b4IcPCkfoHBi3jYb9YcxowLusCyN4zi74z
	JzsaGcGB9Qu8BB/vuQ3oxd1byA+e
X-Google-Smtp-Source: AGs4zMYSSSVL31C27tbd0tScyQ7aA8+Y7acXVwpiH+9h4TMUMavQBUc6ETYDz+ir0Uvv7+jYLghnPQ==
X-Received: by 10.28.11.138 with SMTP id 132mr6839640wml.89.1510586710165;
	Mon, 13 Nov 2017 07:25:10 -0800 (PST)
Received: from crde-port-20.cahors.local ([185.47.80.46])
	by smtp.gmail.com with ESMTPSA id
	l16sm20192454wma.19.2017.11.13.07.25.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 13 Nov 2017 07:25:09 -0800 (PST)
From: David Vincent <freesilicon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 13 Nov 2017 16:24:02 +0100
Message-Id: <20171113152404.21785-1-freesilicon@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171113151617.20905-1-freesilicon@gmail.com>
References: <20171113151617.20905-1-freesilicon@gmail.com>
Subject: [PATCH v3 0/2] fetch/git: fix per-branch unpacking
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
X-List-Received-Date: Mon, 13 Nov 2017 15:25:10 -0000

Create branches for each user-supplied name when running checkout and
set start point of branch to the resolved revision.
Also, update documentation to better describe this functionality.

Changes in v2:
  - clarify commit message
  - update documentation

Changes in v3:
  - rebase on current master

David Vincent (2):
  fetch/git: fix per-branch unpacking
  bitbake-user-manual: update git fetcher

 .../bitbake-user-manual-fetching.xml               | 34 ++++++++++++++++++++--
 lib/bb/fetch2/git.py                               | 12 ++++----
 lib/bb/tests/fetch.py                              | 28 ++++++++++++++++++
 3 files changed, 67 insertions(+), 7 deletions(-)

-- 
2.13.6


