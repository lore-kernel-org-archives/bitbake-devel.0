Return-Path: <dev@codyps.com>
Received: from mail-qc0-f174.google.com (mail-qc0-f174.google.com
	[209.85.216.174])
	by mail.openembedded.org (Postfix) with ESMTP id E935965C7B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Nov 2014 01:26:31 +0000 (UTC)
Received: by mail-qc0-f174.google.com with SMTP id r5so8494965qcx.5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 11 Nov 2014 17:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codyps.com; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=50E77dYKGE3QBvX+FsjJKmWIgq5hjITL97LJL7MEUdc=;
	b=Pr0+EdEIvFXVxIk2X9nm2/VpKJnRfXX+EoZ2F64WUMfY/ARdLuO12ofmUD7a4tbMEV
	KfJd1LMrBQHN2piQhgeqsBcFaLMT2eCM3ZDIh8kWqRf1JsqYU6S3JrFz+MyZ42OuuK7k
	NrdJQhstP2IoBiahDQi5tRvqLRQD0JaG3ZW6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=50E77dYKGE3QBvX+FsjJKmWIgq5hjITL97LJL7MEUdc=;
	b=IkivyF758+637fkSaTZI+ENRAMI/aUPAt1kqcAbijnmyLOVmtowc1vhIzkToDU3fVv
	NRYJimWoFUd8r7GPl0G8YEqE0xtFcWJ2atMsZllmIfmZ+jNrwJS52SrwHagpcJIVenei
	MAijb5/Oux9UJ/fh0yMkCxSvP2aCYeX2Bf+T55rP1aKjJzR/HKTjjf4PJgmuikbJk3v2
	fqkgQaiwbswvwMHeRo6MFjLRgg+/GsOZrsk32GXNm7JA8D01MsBACrcK60DnncgiTznS
	Nrdo6tSgdzGdh6jUQDrmRVRDd/JfwGDyIfqNlbnJ/ge4sIlMsSrITqpXIqvKH2/bt+Tz
	vlnA==
X-Gm-Message-State: ALoCoQmJ336O2tZE+oBDSLNFpwGaOSp54ETt/1VlshHkRVutbN7C4NBvQwvsNmyi8RBtCBTvlux4
X-Received: by 10.224.92.81 with SMTP id q17mr55945787qam.66.1415755590231;
	Tue, 11 Nov 2014 17:26:30 -0800 (PST)
Received: from localhost (c-73-38-182-46.hsd1.ma.comcast.net. [73.38.182.46])
	by mx.google.com with ESMTPSA id
	r1sm19810113qag.14.2014.11.11.17.26.28 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 11 Nov 2014 17:26:29 -0800 (PST)
From: Cody P Schafer <dev@codyps.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Nov 2014 20:26:16 -0500
Message-Id: <1415755576-4571-1-git-send-email-dev@codyps.com>
X-Mailer: git-send-email 2.1.3
X-Mailman-Approved-At: Sun, 23 Nov 2014 21:58:57 +0000
Cc: Cody P Schafer <dev@codyps.com>
Subject: [PATCH] git: allow use of HEAD
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
X-List-Received-Date: Wed, 12 Nov 2014 01:26:32 -0000

---
 lib/bb/fetch2/git.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 66a77a8..84c7268 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -339,7 +339,9 @@ class Git(FetchMethod):
         """
         Compute the HEAD revision for the url
         """
-        if ud.unresolvedrev[name][:5] == "refs/":
+        if ud.unresolvedrev[name] == "HEAD":
+            search = "%s %s^{}" % (ud.unresolvedrev[name], ud.unresolvedrev[name])
+        elif ud.unresolvedrev[name][:5] == "refs/":
             search = "%s %s^{}" % (ud.unresolvedrev[name], ud.unresolvedrev[name])
         else:
             search = "refs/heads/%s refs/tags/%s^{}" % (ud.unresolvedrev[name], ud.unresolvedrev[name])
-- 
2.1.3


