Return-Path: <paul.barker.commagility@gmail.com>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
	[209.85.212.169])
	by mail.openembedded.org (Postfix) with ESMTP id 0600677108
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Oct 2015 14:25:18 +0000 (UTC)
Received: by wikq8 with SMTP id q8so34596767wik.1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Oct 2015 07:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=from:to:cc:subject:date:message-id;
	bh=lyJ2EMXb459yLT8dWM7PFKdlIyndv43FZ2UAk5DNuLI=;
	b=LeR0Sj20dMF6oihlyPr9ZD77otuO1nkCjfROcmKYvRvGON0uyvJkwDXSrfz4uFNNVd
	f8OpfV/gyPfPqiR5xrgTwi6MmdUqYKN2LcEUxkdH0hLZ54wXn7UiXN46VMTRVgv3g6hL
	Nuq5i6FwB1Kx3I5Lgwot6KLaz3u6uInFp3dhapB42bJJs2lov1HTYVS5JbCHcWX8RgRm
	F4mAmOXJYQrRYsNbSlsNQtttyl1wUwYkf0ewfYQpSdmONt9mvY0iiiWZ6DWCxtrxJ+pB
	ojtyiMB1GytzsV+ITizLFo+Fdg/PYukE6PKzsnJL51XbqAllkLGbQZ3X7JegIfY2kFEu
	xcwg==
X-Received: by 10.180.211.47 with SMTP id mz15mr17152578wic.93.1445523918409; 
	Thu, 22 Oct 2015 07:25:18 -0700 (PDT)
Received: from oebuild.commagility.com (inno-commagility-ownrouter.lut.ac.uk.
	[131.231.60.35]) by smtp.gmail.com with ESMTPSA id
	lg1sm28276828wic.17.2015.10.22.07.25.16
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 22 Oct 2015 07:25:17 -0700 (PDT)
From: Paul Barker <paul.barker@commagility.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 22 Oct 2015 15:21:48 +0100
Message-Id: <1445523709-17314-1-git-send-email-paul.barker@commagility.com>
X-Mailer: git-send-email 1.8.3.1
Subject: [PATCH][1.26] Backport toaster fix from master
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
X-List-Received-Date: Thu, 22 Oct 2015 14:25:19 -0000

This is a backport of commit b4ce793685f70cab3f28cb4329aaaf3878cd62e8 from
master, re-written as `git cherry-pick` couldn't figure it out. I'm unsure if
this is the right way to send it as I'm not the auther of the original patch. I
can edit the authorship to credit Michael Wood and resubmit if desired - as I've
altered the patch I didn't want to put his name on it initially.

This fixes issues I've been seeing in toaster with packages missing from the
"Packages included" list and an empty "Directory structure" page for my images
when using fido and bitbake 1.26.

Paul Barker (1):
  toaster: buildinfohelper Skip packages we have no build info about

 lib/bb/ui/buildinfohelper.py | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

-- 
1.8.3.1


