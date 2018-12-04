Return-Path: <jpewhacker@gmail.com>
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
	[209.85.166.65])
	by mail.openembedded.org (Postfix) with ESMTP id 68FC66D179;
	Tue,  4 Dec 2018 03:46:36 +0000 (UTC)
Received: by mail-io1-f65.google.com with SMTP id n9so4364744ioo.2;
	Mon, 03 Dec 2018 19:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=4qhwlvFsYgWglZ7t97sZeY3NqzeB3GqXrm/bjLo/B28=;
	b=iZp5hZmEnO1uDUvlLbnDYRmJUXbIrwGEq8PmURvMPDqmwM9gPTDkfGJkICbDmzW5iq
	4K81o1cnPICKYcqC+QSVqlT6SUGLBmECxdeuuzaNdRmKSqH13UoRn3ykaZMzvY2qUGPU
	9pK2/AE5/UmKkP6WjA3UUsA0jRBTfHRczl6jirXUhcMK4I1xizlOqPpFUmt14HhlO2yb
	fBRBjdJnOnbt6hfZCj80ZUqi3/Oij/2RQQ4t/Qd2XYMfx9eVCXYhWYjKUECiAwcATEUb
	Nsf+8KJag81+9dhJdqmKSkv9QmXfEnd5i2WrcuHMuij8ANJiqLyQ8zjvSNtRDzm47XeY
	2nSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=4qhwlvFsYgWglZ7t97sZeY3NqzeB3GqXrm/bjLo/B28=;
	b=a2dgXCVYV/q5NgFZnl7Wg30XP8KQI+f5/2VTtsbF83WN5L4QkqmLObHf7itMc72NMT
	KOyYAotnZS4/bkTmPK8QqMuvIiknGOTruLdjA0CSwza3/SmfKgprUHrqU1eoh8/IFVuz
	6NR0RnMBgbtaz2OSzJbYWdb000uqLhtNbGmJZdNk1r4LmnEXs3mcPdjjz26S7jqzISYR
	BWW9CuSRQrARDg0TMAXDRS5S+R9SnNNb0jkpjNdCzHya0nRK48ER/6TqBCqrPGHh5ppk
	+YFNLZxPBIdqxpVCLCC+c+1Rgrcb12lg5xlte7uevnYwGgSO0cBlNqrzpL/Zi6eMq9UA
	cLNA==
X-Gm-Message-State: AA+aEWbNJN1aGtPrm6u0BORuLdtcp9TA+7ky5WItsA4UVA4wbVJ6mnF4
	86xWA+Y5rPljTnm8MwnnmhE54yxzHGM=
X-Google-Smtp-Source: AFSGD/Vj4S/vFtcHSlgI9ROEQe6sjzEIUhu8RAVwi1rHmIpEljU3Qy4LXQVTmEUYBQ/ME+R0GXDdMQ==
X-Received: by 2002:a5e:c914:: with SMTP id z20mr15636442iol.72.1543895197288; 
	Mon, 03 Dec 2018 19:46:37 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q23sm6216824ioi.66.2018.12.03.19.46.36
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 03 Dec 2018 19:46:36 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Mon,  3 Dec 2018 21:42:45 -0600
Message-Id: <20181204034245.25461-18-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204034245.25461-1-JPEWhacker@gmail.com>
References: <20180809220840.26697-1-JPEWhacker@gmail.com>
	<20181204034245.25461-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v3 17/17] classes/image-buildinfo: Remove unused argument
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
X-List-Received-Date: Tue, 04 Dec 2018 03:46:36 -0000
Content-Transfer-Encoding: 8bit

Removes the listvars argument to image_buildinfo_outputvars(). It
doesn't appear that this argument ever did anything.

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 meta/classes/image-buildinfo.bbclass | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/meta/classes/image-buildinfo.bbclass b/meta/classes/image-buildinfo.bbclass
index 87a6a1a4893..94c585d4cd9 100644
--- a/meta/classes/image-buildinfo.bbclass
+++ b/meta/classes/image-buildinfo.bbclass
@@ -16,9 +16,8 @@ IMAGE_BUILDINFO_VARS ?= "DISTRO DISTRO_VERSION"
 IMAGE_BUILDINFO_FILE ??= "${sysconfdir}/build"
 
 # From buildhistory.bbclass
-def image_buildinfo_outputvars(vars, listvars, d): 
+def image_buildinfo_outputvars(vars, d):
     vars = vars.split()
-    listvars = listvars.split()
     ret = ""
     for var in vars:
         value = d.getVar(var) or ""
@@ -59,8 +58,7 @@ def buildinfo_target(d):
                 return ""
         # Single and list variables to be read
         vars = (d.getVar("IMAGE_BUILDINFO_VARS") or "")
-        listvars = (d.getVar("IMAGE_BUILDINFO_LVARS") or "")
-        return image_buildinfo_outputvars(vars, listvars, d)
+        return image_buildinfo_outputvars(vars, d)
 
 # Write build information to target filesystem
 python buildinfo () {
-- 
2.19.1


