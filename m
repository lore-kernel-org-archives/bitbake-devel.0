Return-Path: <michael.g.wood@intel.com>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id 973EB6FFC7
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  8 Mar 2016 11:32:20 +0000 (UTC)
Received: by mail-wm0-f51.google.com with SMTP id p65so23377812wmp.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 08 Mar 2016 03:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=AwzVeSBykHfLpXUvsuuq3MHyKYfB5ApuHQkErFCq50E=;
	b=rBAehDdlHVH1K7cAj5IBzhQbNHeWImfcwnlpWsXe31o61a+aumGrn7pDZr5sbijUfQ
	K5HURAIgjqeRzT76Fe6urKa6cotoKW1obFgJpiChZ4gYcAwuoRyMRhPBWFVrfjCELc1t
	/jOV3pjwePVPL5GyjQYQJEjAQBvKGTdDe42AWqVkESzjVKjWXXgjxophpGkky4Rj9Nca
	BaxZxb8d33Up6eXPulQIpiktsXr5gFtrIpbhdosUdwzekuUtCnT3NuQ0AM0wOBx5ArEE
	6Q5PrrU39bU21qgua0WCktJlxAWxi4rHRgvjKiEFC9iUL7tVnQrJXal/9nepb0vjUB5Y
	iqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=AwzVeSBykHfLpXUvsuuq3MHyKYfB5ApuHQkErFCq50E=;
	b=XmxJ+/sI1QC/bKwJWm9HvYT1/vUOcYWzmCwDxoe9Ve0kbUma8Ark/izpEMS09502ne
	adrRjbgKEoMIYUEBATrJ6AYZm06U6MPSngtAl6p8uD1uPV1GT2bsqTesMwNvex2Eo2e0
	DY1pxtPVoZdym628XHOj6PbFpZpOyOTBEK0mFQ1450ebocLuqkI6U7oi3ZPmEJPOUItv
	ONGXlLCMblmMWz+yPhIUCnQ30aMVvF946iPxuUeXwM3DGoBTX2PwF4jeZxhYS6Qf/Uuh
	JTotmYAY068mG+K9fBqTHHJDnX2gg/iIbU5jkKOTODTAOfMookwfpZGYzISUHroD7WfR
	XmMw==
X-Gm-Message-State: AD7BkJIkNxNGJicYzQue0FCaplworrbPQn7GrNbQCW2iiZCTyVyNtuuJJdoFj0ViOnhKpyOg
X-Received: by 10.28.48.136 with SMTP id w130mr16109579wmw.54.1457436740678;
	Tue, 08 Mar 2016 03:32:20 -0800 (PST)
Received: from dorado.home (host86-147-84-80.range86-147.btcentralplus.com.
	[86.147.84.80]) by smtp.gmail.com with ESMTPSA id
	y62sm2955138wmg.12.2016.03.08.03.32.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 08 Mar 2016 03:32:20 -0800 (PST)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 Mar 2016 11:32:11 +0000
Message-Id: <1457436732-7609-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.5.0
Subject: [PATCH] buildstats rework
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
X-List-Received-Date: Tue, 08 Mar 2016 11:32:21 -0000

Note to committer This had new files and depends on http://lists.openembedded.org/pipermail/openembedded-core/2016-March/118642.html 

Elliot Smith (1):
  toaster: rework task buildstats storage and display

 lib/bb/ui/buildinfohelper.py                       | 72 ++++++++++------------
 .../orm/migrations/0005_task_field_separation.py   | 48 +++++++++++++++
 lib/toaster/orm/models.py                          | 18 +++++-
 .../toastergui/templates/basebuildpage.html        |  4 +-
 lib/toaster/toastergui/templates/task.html         | 23 ++++---
 lib/toaster/toastergui/templates/tasks.html        | 20 +++---
 lib/toaster/toastergui/urls.py                     |  2 +-
 lib/toaster/toastergui/views.py                    | 55 +++++++++++------
 8 files changed, 163 insertions(+), 79 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0005_task_field_separation.py

-- 
2.5.0


