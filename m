Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
	[209.85.220.49])
	by mail.openembedded.org (Postfix) with ESMTP id 1D2926078E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2016 15:17:01 +0000 (UTC)
Received: by mail-pa0-f49.google.com with SMTP id cd13so3303454pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 27 Sep 2016 08:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=eVqM9VzRkGX+70gTw/L/uqZ/DiPmGXhTOOxMKeqr2j8=;
	b=bGg7GKv0XtTZ+OUP0XIQ6jujOysMAcYaG4mgStEXepn8Rd5jtmvxEKKFC3aeizCwXZ
	bi/G+k2t7JLaLcvWHKfkwh/9Ghgl6zFnT2I9kMT5/IZQ1wmCn9lkxUeu/X6Xm3hHtqT7
	gl5b4aAos2WLZY3B/WV1bRh/HKXUbpleuqXLXNgox4OLK3E8GXjXcnqmJF7qdqAUeIbC
	XBqM/B4FdBuLDykm3TL2I0YAGkqUiB64MzY/bs719VH9pNcN+YumdrFsmGz3STke58Jp
	d07UkUgobLh3xBaBjN7/0ovaTbOi708UwyuZkAXEpUpzUpT6nZggTc8HEbOaeI9TZ6hv
	X2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=eVqM9VzRkGX+70gTw/L/uqZ/DiPmGXhTOOxMKeqr2j8=;
	b=jzs8QWo0s3gfgjW/VOtVgCO1jNLA2dve7Ixi2jNurOc5l5bn5ZeMMYOX8tVXJRNFCH
	FNOe/NTjbLs0F65LagkzLQQ+xrqNTnY2GaukdHh9Kp8xdOJP7smGiFG7u/que3T+JmsP
	IMnrWSBfs/oGvwOXA2xGNm9fa9OFDYEYZBIoa5QxGviSrj7WyMBWxt+MnCwew9MKiTgI
	rsLlMFBDxnn9znYVM5ABnqcpuYCYyYOHJEC1vwUkiXrwVtHhwMan0DWo7JY27MVoKPYG
	85ZOjRUSFrDRS3bI+nzs5U6KvwLcos2y/xeLbV/qFhHyrQdPN9KPlLSuuKzPQ6ha0rt9
	BnLg==
X-Gm-Message-State: AE9vXwMollVWYbARgaqb+XaTO+fonfcQmTpLf5dTNBu8wfhKbZu5c5wfaU6Yi/6le9kedjlr
X-Received: by 10.66.121.131 with SMTP id lk3mr48116779pab.139.1474989423233; 
	Tue, 27 Sep 2016 08:17:03 -0700 (PDT)
Received: from orion.ld.intel.com (fmdmzpr01-ext.fm.intel.com. [192.55.54.36])
	by smtp.gmail.com with ESMTPSA id
	p1sm5784876pae.12.2016.09.27.08.17.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 27 Sep 2016 08:17:02 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 27 Sep 2016 16:16:51 +0100
Message-Id: <1474989416-10454-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 0/5] misc Toaster fixes from Ed
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
X-List-Received-Date: Tue, 27 Sep 2016 15:17:03 -0000

This patchset contains bug fix for bug 10185 - Image builds not showing as complete in the UI after finishing and bunch of small related and unrelated fixes for toaster script and toasterui.

Review done on the toaster mailing list.

Ed Bartosh (5):
  toaster: stop modifying OEROOT in toaster script
  toaster: check if file exist
  toaster: fix handling of EnvironmentError
  toaster: fix 'Unhandled MetadataEvent' error
  toaster: make error message more informative

 bin/toaster                  | 10 ++++++----
 lib/bb/ui/buildinfohelper.py |  3 +++
 lib/bb/ui/toasterui.py       | 15 +++++++++++----
 3 files changed, 20 insertions(+), 8 deletions(-)

-- 
2.7.4


