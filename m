Return-Path: <freesilicon@gmail.com>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
	by mail.openembedded.org (Postfix) with ESMTP id 2B73B719AF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Oct 2017 15:43:50 +0000 (UTC)
Received: by mail-wm0-f68.google.com with SMTP id u138so4754106wmu.5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Oct 2017 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=p6j2j3Es2JfYWc28BB/JZbd+/7L3NHZcmqmNdzTHClQ=;
	b=doR4lg8naUO9euFD13EWwkJIdClH1Ll0o7dDV01fC/yfbNyP6X9Tm5pqN4HiRx2hPW
	e6ofKdgHe65hS0YBlVdv5Dl4bGmm5QMboe+L0jhjOY1tjO+68quXrxA7myUNIjeFbw8o
	r4gD8pWI6Y5NHKsJkeac3B6KWgVJrKG2cZKXIdk8xWLSHXxmkYL/WhXduOiBc6GhbM8j
	EoKRnV+VUcWWOp41kb5Rj/bdG0bB/u0REohb6ZuIW25S18qV35hOx/D03AH/x+R9J+W2
	Q/eYm6x4Xl02qW+BQKyGwbTFSoZmZWOxtZxYo62BcHsclUL2t6LJzG52kJ0t9OZbRZbc
	L/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=p6j2j3Es2JfYWc28BB/JZbd+/7L3NHZcmqmNdzTHClQ=;
	b=QvVFJeEcSy5cUkXkh5AG8GzxwrdeWfz0c6chxts/z/m7SsLkxnZ2HVFbFNdv83n9bv
	GYmgDMrD5gQmNF8Ol6yrwrIu7xALygCkHw/KnUvVZML+HRm6T9rDGZdjt4CRPDb+zCat
	qyx8noxTrfZN0wTIpDHVDoowT36vv+opD8WNi8RjA4cVOwuRG5+Ttk7YCSDdO0zV5GU8
	yTUlEiKcnbrSVtxXF5Fro+a3cTXtPanlKRqHUhTcTFRbfwEFhgtN7CgPDWkekHCZuRUY
	A8OphJd1VRwlJTbFsoC5OylbHYzdlkTl+1HmTFShKRpFwRltNCO6jnLQt8GbysOLVQ7K
	08Zg==
X-Gm-Message-State: AMCzsaUyz08k4NQmd17Gb84zYcXyucNdFi90TD6BpKxZPP1j/VT81x8b
	9UFZECl7FAySRjeyD5iRXDupUlCo
X-Google-Smtp-Source: ABhQp+R79+WlT9Z6AGe4yeaFMAVUUpeM9KZ5bYxivDJBVK67dyGYrfYbVb576FTVxhcTbR8/63w7eQ==
X-Received: by 10.28.1.70 with SMTP id 67mr3683808wmb.34.1508255031599;
	Tue, 17 Oct 2017 08:43:51 -0700 (PDT)
Received: from crde-port-20.cahors.local ([185.47.80.46])
	by smtp.gmail.com with ESMTPSA id
	y129sm9932991wmg.42.2017.10.17.08.43.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 17 Oct 2017 08:43:50 -0700 (PDT)
From: David Vincent <freesilicon@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 17 Oct 2017 17:43:14 +0200
Message-Id: <20171017154316.18464-1-freesilicon@gmail.com>
X-Mailer: git-send-email 2.14.2
In-Reply-To: <20171017112748.10968-1-freesilicon@gmail.com>
References: <20171017112748.10968-1-freesilicon@gmail.com>
Subject: [PATCH v2 0/2] fetch/git: fix per-branch unpacking
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
X-List-Received-Date: Tue, 17 Oct 2017 15:43:51 -0000

Create branches for each user-supplied name when running checkout and
set start point of branch to the resolved revision.
Also, update documentation to better describe this functionality.

Changes in v2:
  - clarify commit message
  - update documentation

David Vincent (2):
  fetch/git: fix per-branch unpacking
  bitbake-user-manual: update git fetcher

 .../bitbake-user-manual-fetching.xml               | 34 ++++++++++++++++++++--
 lib/bb/fetch2/git.py                               | 12 ++++----
 lib/bb/tests/fetch.py                              | 27 +++++++++++++++++
 3 files changed, 66 insertions(+), 7 deletions(-)

-- 
2.14.2


