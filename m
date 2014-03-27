Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id D0CF46F8DF
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 16:50:05 +0000 (UTC)
Received: by mail-wg0-f41.google.com with SMTP id n12so2691789wgh.12
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 09:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:in-reply-to:references;
	bh=z4qSxbMuwXRvF+UNEQLnGnZTcwwLWstOi6vkRQPZqdY=;
	b=TpHSY1J/xf5J06MNzxXrDLmjGDtZojH3mQFB62dILqyey5xBG1IjaLWjFvFrBbKBme
	7h1PkFIAGuJZ5YPuiXytmohbklex/e0FLAIy5cBLwFuryVANOwNfKX2ZTWISahhp7Tcc
	NF18FrQLHIJzPLWu11wgB5nM4IqjGmXZzowSdyE4AvENlEGroxonusEVHQQl7P4hDWPp
	sllFZmVLrtNI7LPxFm6lHM4VG+O2kKDqKa8wqY39MR5TEHmhV/7d/hj2bhWvvHH9phD+
	O+xSCYlcpqq0MMS9MOjAsr1Zyl0b79qSAt7wbUiVTeRTWZTJMlc3Tuwx4bOzLLAFuFjW
	1jRQ==
X-Gm-Message-State: ALoCoQmf1gbiqVqsvczIR1FoPp1tOXG4H5B6zMSnCM85ikP7TVC9CghM3AgegV/Oh01pWMfdUw39
X-Received: by 10.180.99.225 with SMTP id et1mr6361955wib.13.1395939006517;
	Thu, 27 Mar 2014 09:50:06 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	fs16sm8778690wic.18.2014.03.27.09.50.04 for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 27 Mar 2014 09:50:05 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 88E1C560E3C; Thu, 27 Mar 2014 16:50:02 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Mar 2014 16:50:00 +0000
Message-Id: <528163262263bf5315b8c1f3822dff7eb15d9e81.1395938903.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <30647848c4c202df4537eb2c1810ec0999dab4bd.1395938903.git.alexandru.damian@intel.com>
References: <30647848c4c202df4537eb2c1810ec0999dab4bd.1395938903.git.alexandru.damian@intel.com>
In-Reply-To: <cover.1395938903.git.alexandru.damian@intel.com>
References: <cover.1395938903.git.alexandru.damian@intel.com>
Cc: Dave Lerner <dave.lerner@windriver.com>
Subject: [PATCH 8/9] toaster: fix dirinfo empty dir expansion
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
X-List-Received-Date: Thu, 27 Mar 2014 16:50:06 -0000

From: Dave Lerner <dave.lerner@windriver.com>

[YOCTO 6036]

In the page that shows the directory layout for an image, if the
directory is empty, then the directory folder icon should be black and
the table row should not be 'expandable' on a mouse click.  That
behavior depends on the directory's child entry count calculated in the
view function controlling that page.

Two images in the database with the same directory path in the target
image, but one with path having entries and the other not having
any entries caused the path without entries to be clickable; the
query for a directory's count of entries, didn't filter on the image id,
only on the path.

Signed-off-by: Dave Lerner <dave.lerner@windriver.com>
---
 lib/toaster/toastergui/views.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/views.py b/lib/toaster/toastergui/views.py
index d323b37..4f7170b 100644
--- a/lib/toaster/toastergui/views.py
+++ b/lib/toaster/toastergui/views.py
@@ -646,7 +646,7 @@ def _get_dir_entries(build_id, target_id, start):
             if o.inodetype == Target_File.ITYPE_DIRECTORY:
                 entry['isdir'] = 1
                 # is there content in directory
-                entry['childcount'] = Target_File.objects.filter(directory__path=o.path).all().count()
+                entry['childcount'] = Target_File.objects.filter(target__exact=target_id, directory__path=o.path).all().count()
             else:
                 entry['isdir'] = 0
 
-- 
1.8.3.2


