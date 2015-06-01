Return-Path: <dev@codyps.com>
Received: from mail-vn0-f48.google.com (mail-vn0-f48.google.com
	[209.85.216.48])
	by mail.openembedded.org (Postfix) with ESMTP id 3543A757AC
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  1 Jun 2015 17:41:04 +0000 (UTC)
Received: by vnbg129 with SMTP id g129so17073052vnb.9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 01 Jun 2015 10:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codyps.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=V6YE8KcXIAUnD2chds88E+i2aarpnyFLcRVKzFf4IOs=;
	b=R/m4I+xE61VaOrAIB03L9sYp1FUTvEFOiP7szevZ2Q9/GMHVYNdHjmP7ZMhi6ZlkJy
	JaLs0hZb603EF2vaNovBRuSQt2VFkrlpkfCH/jWhCRYtRBA59eCDpF+bfLlGsZ5EKp7z
	FVcI4B4UiIdqNT6SQReYcpomK6Fe40BKPA+Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=V6YE8KcXIAUnD2chds88E+i2aarpnyFLcRVKzFf4IOs=;
	b=Sm3d3tLLPLQ8wwkbPUfAIIQEwoBm98tG6dbfgeP2tfmdri8FVc1ntJHt1rK4Fk1PFj
	gD8h5Q3FS+K/k4i2X57xRHN+7hdENVr+dCdw86M7obAU002K7DCoFMrzoKCoLlAcHE24
	dYyLrlXHu4sNQ6t2Sly2Ho0xZO96ODwTiF1rUWFRXoStmlsJWUMWyjBfSlRZ1CET/DBj
	aGGdcWeBit9wu+rRPYFU5bSna4xaJ7+1U3cEnwh1qBjvYr/W+MzparN2LPmYKXNfXPNg
	QbLmIPYhipxi3YfTKpZo5ElPrOxxFSrDJdRouLSiYdRt6qNu35mUKU4LTr2W5VmCM0jE
	dhSA==
X-Gm-Message-State: ALoCoQkVrkepbljhzTauit3ZXves5SjXyn4YTw2PGEydcoGiIPoTtZQmhdhiCS/bCyddZBrd3P86
X-Received: by 10.52.233.166 with SMTP id tx6mr29930996vdc.91.1433180465664;
	Mon, 01 Jun 2015 10:41:05 -0700 (PDT)
Received: from localhost (static-96-237-165-28.bstnma.fios.verizon.net.
	[96.237.165.28])
	by mx.google.com with ESMTPSA id h14sm22414617vdj.0.2015.06.01.10.41.04
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 01 Jun 2015 10:41:04 -0700 (PDT)
From: Cody P Schafer <dev@codyps.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  1 Jun 2015 13:41:17 -0400
Message-Id: <1433180477-14367-1-git-send-email-dev@codyps.com>
X-Mailer: git-send-email 2.4.1
X-Mailman-Approved-At: Mon, 08 Jun 2015 11:10:02 +0000
Cc: Cody P Schafer <dev@codyps.com>
Subject: [PATCH v2] git: allow use of HEAD
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
X-List-Received-Date: Mon, 01 Jun 2015 17:41:05 -0000

Especially useful in the case where one has local git repositories that
they point bitbake at via bbappends for development purposes.

Signed-off-by: Cody P Schafer <dev@codyps.com>
---
 lib/bb/fetch2/git.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 0fd9bee..161a2db 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -342,7 +342,7 @@ class Git(FetchMethod):
         """
         output = self._lsremote(ud, d, "")
         # Tags of the form ^{} may not work, need to fallback to other form
-        if ud.unresolvedrev[name][:5] == "refs/":
+        if ud.unresolvedrev[name][:5] == "refs/" or ud.unresolvedrev[name] == "HEAD":
             head = ud.unresolvedrev[name]
             tag = ud.unresolvedrev[name]
         else:
-- 
2.4.1


