Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by mail.openembedded.org (Postfix) with ESMTP id 3BE8579BA6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Feb 2019 17:47:05 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id m1so121441wml.2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Feb 2019 09:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=xbrdVT8qnaj8aDaLeSnsqd+MTa5HxiMRyxmepAencGU=;
	b=X+YM6F8eNdk7Qw2YOAnbL4Z9lNQFQR5A4AvwdP/qT8MqaZp3Un40hcPz4q2PL1s+jW
	DMsJo4TyGEAI5ZuVeX+Qxw/KATom9BBl3iG6Vs4EnP7NRuRLIV4WIuLfpBYaGcxHbtqL
	5J73Wop6IXkDrqY65ACx23ESXEg+Yn3bDvAks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=xbrdVT8qnaj8aDaLeSnsqd+MTa5HxiMRyxmepAencGU=;
	b=DJztjiSRoXUZpl16u9Yw/LSItrIviCtKKeLQXMyglibr3HjeBdGS5kYde5cv/8v8k3
	Gu1cqAfMNIWpU+16P8ZWcowRMnQosjAbx7WGUyTHrdv9xlOilEKnKIZUNsec/OR8K7vu
	7ND7a8FwNce5okjUo0UEcDXt8VFS6cMpQokhywawvCPrypYgdlQXQF/9UmVQZjEsukYt
	38QRM0HCUbM0H7Lsi/oVOupxEY58SSM1eZI6z9fkzfl0fjZj742LMjVhJhYTHfYleOjc
	RCri93DhtGCJ1cFzNSN1WNloUUxtalsNJlmenvkfC90NrCWz5AMZpyfLmBVGcb3EvQ/Y
	KA5Q==
X-Gm-Message-State: AHQUAubtuQ5StA+7J9+fHDqySIRrMRpWu91EmguAMsSFKwc/pZEAnCkL
	sP9cI2JIk6F9Ry5F4nP+O8p++H67sxo=
X-Google-Smtp-Source: AHgI3IZdBMC6DKwbztVVqtb3DKmw/kB4Snm+g+QgxJQU+eKNGD5kcmzjsFSNWv8GMLIETdCw95GVTw==
X-Received: by 2002:a1c:e10a:: with SMTP id y10mr482358wmg.73.1549907225572;
	Mon, 11 Feb 2019 09:47:05 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	l129sm7232345wml.42.2019.02.11.09.47.04
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 11 Feb 2019 09:47:04 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 11 Feb 2019 17:47:03 +0000
Message-Id: <20190211174703.5874-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH] oe-build-perf-report: Fix missing buildstats comparisions
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
X-List-Received-Date: Mon, 11 Feb 2019 17:47:05 -0000
Content-Transfer-Encoding: 8bit

Integers were being compared to strings leading to missing buildstats comparision
data. Fix this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/oe-build-perf-report | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/oe-build-perf-report b/scripts/oe-build-perf-report
index b3c769895e6..af4f0469f6b 100755
--- a/scripts/oe-build-perf-report
+++ b/scripts/oe-build-perf-report
@@ -427,8 +427,8 @@ def print_html_report(data, id_comp, buildstats):
 
             # Compare buildstats
             bs_key = test + '.' + meas
-            rev = metadata['commit_num']['value']
-            comp_rev = metadata['commit_num']['value_old']
+            rev = str(metadata['commit_num']['value'])
+            comp_rev = str(metadata['commit_num']['value_old'])
             if (rev in buildstats and bs_key in buildstats[rev] and
                     comp_rev in buildstats and bs_key in buildstats[comp_rev]):
                 new_meas['buildstats'] = BSSummary(buildstats[comp_rev][bs_key],
-- 
2.20.1


