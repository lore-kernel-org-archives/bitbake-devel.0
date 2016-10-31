Return-Path: <michael.g.wood@intel.com>
Received: from mail-pf0-f174.google.com (mail-pf0-f174.google.com
	[209.85.192.174])
	by mail.openembedded.org (Postfix) with ESMTP id A769B71ABD
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Oct 2016 16:40:51 +0000 (UTC)
Received: by mail-pf0-f174.google.com with SMTP id n85so79022705pfi.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Oct 2016 09:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=TMq83oMOBJ5ZMA3TFy+1engjwn/DMpAOG0v4B1tNppo=;
	b=n659eGcc+9kwRqhqQKu+phMHZR8XvA5Ov0TsGRlvfpeGI7S8px2jBjH3fQvCwtu4bJ
	2SmWW/mrdTVCjbzAapxujNJcGphgF7cEZvL/1vclYo6vr5A/HEOmsHj9orLCB1CG4s9u
	m9jlm4Guh12kMZqyE21FAwZV2irlIie3tOUdExZHBMgUwQB1gQV19Frdv8Syf160e3UR
	UqoxbIm0bNhgp4xH95qp13Vk4kFzn95Ndm77bBNciEYf4x9vYsbSA1vNVRcpxtshOiLY
	QfhXC2vziL8f7CDNd1mFnhbC/Oa0L+P0+5tX0uu0ODdxS2/NvEwczH5g9jceV5d8hi0o
	My7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=TMq83oMOBJ5ZMA3TFy+1engjwn/DMpAOG0v4B1tNppo=;
	b=Npsm0l85pdt5rdjOBPMGA0BMfpnYrJC+Z7xFvHcNklJhSZixrAUSs+Xjpq3VkbDXj8
	6kEgXYONLOq9pA80MdVXUSO74JEVd9Rq0w5j5yW4qjRXCP1LFgTUqDmceosh6ioQ01hw
	eXVuC54Y4W7H396nMcMJvEDCwnMlILcxSze38ovyc94vHBePtbVu0YloUDWNfaNMZKrY
	5qJzBgN7sakUpbMKzROdWTi7N8ud1m7uL15uqS78yf5CLCkXpVANwM4x8kOX4WsACYQn
	iXzDVuqt8L26I+80379tfrR9mjHOTOcEU+Z/V+dMUlLEVTdkIsOsmfL68EgYRICEwTTf
	8AJw==
X-Gm-Message-State: ABUngvey5ku6gUy16mMQtrJdi5HEnXA8VHnFKq54mSrPBAbuDVifbsUANh717XvXzwBVVrID
X-Received: by 10.98.79.193 with SMTP id f62mr5400686pfj.149.1477932052909;
	Mon, 31 Oct 2016 09:40:52 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr04-ext.fm.intel.com.
	[192.55.55.39]) by smtp.gmail.com with ESMTPSA id
	j192sm36718494pfc.60.2016.10.31.09.40.51
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 31 Oct 2016 09:40:52 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Oct 2016 16:40:40 +0000
Message-Id: <1477932040-10112-5-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1477932040-10112-1-git-send-email-michael.g.wood@intel.com>
References: <1477932040-10112-1-git-send-email-michael.g.wood@intel.com>
Subject: [PATCH 4/4] toaster: add tests/eventreplay/README
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
X-List-Received-Date: Mon, 31 Oct 2016 16:40:52 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

Put instructions on how to prepare event log files
and run eventreplay tests.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
Signed-off-by: Michael Wood <michael.g.wood@intel.com>
---
 lib/toaster/tests/eventreplay/README | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 lib/toaster/tests/eventreplay/README

diff --git a/lib/toaster/tests/eventreplay/README b/lib/toaster/tests/eventreplay/README
new file mode 100644
index 0000000..8c5bb64
--- /dev/null
+++ b/lib/toaster/tests/eventreplay/README
@@ -0,0 +1,22 @@
+# Running eventreplay tests
+
+These tests use event log files produced by bitbake <target> -w <event log file>
+You need to have event log files produced before running this tests.
+
+At the moment of writing this document tests use 2 event log files: zlib.events
+and core-image-minimal.events. They're not provided with the tests due to their
+significant size.
+
+Here is how to produce them:
+
+$ . oe-init-build-env
+$ rm -r tmp sstate-cache
+$ bitbake core-image-minimal -w core-image-minimal.events
+$ rm -rf tmp sstate-cache
+$ bitbake zlib -w zlib.events
+
+After that it should be possible to run eventreplay tests this way:
+
+$ EVENTREPLAY_DIR=./ DJANGO_SETTINGS_MODULE=toastermain.settings_test ../bitbake/lib/toaster/manage.py test -v2 tests.eventreplay
+
+Note that environment variable EVENTREPLAY_DIR should point to the directory with event log files.
-- 
2.7.4


